################################################################################
#
# bustle
#
################################################################################

BUSTLE_VERSION = 0.4.3
BUSTLE_SITE = http://www.willthompson.co.uk/bustle/releases/$(BUSTLE_VERSION)/
BUSTLE_LICENSE = LGPLv2.1+
BUSTLE_LICENSE_FILES = LICENSE
BUSTLE_DEPENDENCIES = libglib2 libpcap host-pkgconf

BUSTLE_PCAP_FLAGS = "-lpcap"
ifeq ($(BR2_PREFER_STATIC_LIB),y)
BUSTLE_PCAP_FLAGS += $(shell $(STAGING_DIR)/usr/bin/pcap-config --static --additional-libs)
endif

define BUSTLE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		PCAP_FLAGS="$(BUSTLE_PCAP_FLAGS)" -C $(@D) dist/build/bustle-pcap
endef

define BUSTLE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/dist/build/bustle-pcap \
		$(TARGET_DIR)/usr/bin/bustle-pcap
endef

$(eval $(generic-package))

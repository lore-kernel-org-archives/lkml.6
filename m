Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZqu07GUjmTlXHpk+YvG1hTqxScfbvlLomtPVGNFsXd95CTLXf1qws1EarMgDwjovarnuFGG
ARC-Seal: i=1; a=rsa-sha256; t=1525455849; cv=none;
        d=google.com; s=arc-20160816;
        b=DkjfVSq7SdS/eaKzb6SvLrgBv14Ko+iVJw7mpzkfQ3R1b7ly2lo/sxthjWS7G7VpuU
         SyZCtMFsBQoOnLoiGCnP8xRaIA9lGK3QUiEJkDRk2A028NqnSc/+j3kyKXmkBPR1AD7k
         ImJOQsAqz6uDLlQLuNoXuBKjeYcOkp2WiMd1G+nA5BbraMdJAN72zQX9U6M8ohnyYQ+D
         GoNM7wq41NHtgDj3rM2J9bMMUVfggevVoc4k9N2AuI+8JT1FbpOHEP3wJq/AWx6zkRAX
         bSwX/s0Y02U643yDIQLxcpf0MpEp6iyahHrSJqx9GgaOPAf5ox/7S1/WvISmq9bP2cgI
         nwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=mAGqv6aDP+hQubJfCQLyhRdHuKsnHqc7FEVaPdakhcM=;
        b=gF5+rRLp4P2v2eHiZzqgK+S51XmC/g0zj8JfSkh68DXo0z0q+oOauOMEKr607+HWqO
         6eCcvHU+CPurdW53TsMP/Ff7U4QSZP06Y79GIeT0zp7slP4/WERZf64GOy/Rfh3tv/Pu
         F2+rCtzs1zoV8er0sbUW0igW5kjhXF9Ie6OdXBnOa90horts5wCwf+fjvKG7GBAFcyIe
         6QTjohA+M6+Hl5SW8ntVX5xXn/uRf8RWerx7uz/sjwC+T49gOtYluypfU2mBqMj8m6lj
         +/PPDbOWqGUcMR3iU73PivQ+BSpLV0j+c+2XQv/s8I9WZJlxuXjDTlcuehv2FNZ0lhiF
         eK4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BNphJZo7;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BNphJZo7;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	ast@fb.com,
	hare@suse.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	khc@pm.waw.pl,
	davem@davemloft.net,
	maco@android.com,
	arve@android.com,
	tkjos@android.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 6/6] firmware_loader: move kconfig FW_LOADER entries to its own file
Date: Fri,  4 May 2018 10:43:55 -0700
Message-Id: <20180504174356.13227-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504174356.13227-1-mcgrof@kernel.org>
References: <20180504174356.13227-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599556392363321923?=
X-GMAIL-MSGID: =?utf-8?q?1599556392363321923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This will make it easier to track and easier to understand
what components and features are part of the FW_LOADER. There
are some components related to firmware which have *nothing* to
do with the FW_LOADER, souch as PREVENT_FIRMWARE_BUILD.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/Kconfig                 | 150 +--------------------------
 drivers/base/firmware_loader/Kconfig | 149 ++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 149 deletions(-)
 create mode 100644 drivers/base/firmware_loader/Kconfig

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index bf2d464b0e2c..06d6e27784fa 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -88,155 +88,7 @@ config PREVENT_FIRMWARE_BUILD
 	    o CONFIG_WANXL through CONFIG_WANXL_BUILD_FIRMWARE
 	    o CONFIG_SCSI_AIC79XX through CONFIG_AIC79XX_BUILD_FIRMWARE
 
-menu "Firmware loader"
-
-config FW_LOADER
-	tristate "Firmware loading facility" if EXPERT
-	default y
-	---help---
-	  This enables the firmware loading facility in the kernel. The kernel
-	  will first look for built-in firmware, if it has any. Next, it will
-	  look for the requested firmware in a series of filesystem paths:
-
-		o firmware_class path module parameter or kernel boot param
-		o /lib/firmware/updates/UTS_RELEASE
-		o /lib/firmware/updates
-		o /lib/firmware/UTS_RELEASE
-		o /lib/firmware
-
-	  Enabling this feature only increases your kernel image by about
-	  828 bytes, enable this option unless you are certain you don't
-	  need firmware.
-
-	  You typically want this built-in (=y) but you can also enable this
-	  as a module, in which case the firmware_class module will be built.
-	  You also want to be sure to enable this built-in if you are going to
-	  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
-
-if FW_LOADER
-
-config EXTRA_FIRMWARE
-	string "Build these firmware blobs into the kernel binary"
-	help
-	  Device drivers which require firmware can typically deal with
-	  having the kernel load firmware from the various supported
-	  /lib/firmware/ paths. This option enables you to build into the
-	  kernel firmware files. Built-in firmware searches are preceeded
-	  over firmware lookups using your filesystem over the supported
-	  /lib/firmware paths documented on CONFIG_FW_LOADER.
-
-	  This may be useful for testing or if the firmware is required early on
-	  in boot and cannot rely on the firmware being placed in an initrd or
-	  initramfs.
-
-	  This option is a string and takes the (space-separated) names of the
-	  firmware files -- the same names that appear in MODULE_FIRMWARE()
-	  and request_firmware() in the source. These files should exist under
-	  the directory specified by the EXTRA_FIRMWARE_DIR option, which is
-	  /lib/firmware by default.
-
-	  For example, you might set CONFIG_EXTRA_FIRMWARE="usb8388.bin", copy
-	  the usb8388.bin file into /lib/firmware, and build the kernel. Then
-	  any request_firmware("usb8388.bin") will be satisfied internally
-	  inside the kernel without ever looking at your filesystem at runtime.
-
-	  WARNING: If you include additional firmware files into your binary
-	  kernel image that are not available under the terms of the GPL,
-	  then it may be a violation of the GPL to distribute the resulting
-	  image since it combines both GPL and non-GPL work. You should
-	  consult a lawyer of your own before distributing such an image.
-
-config EXTRA_FIRMWARE_DIR
-	string "Firmware blobs root directory"
-	depends on EXTRA_FIRMWARE != ""
-	default "/lib/firmware"
-	help
-	  This option controls the directory in which the kernel build system
-	  looks for the firmware files listed in the EXTRA_FIRMWARE option.
-
-config FW_LOADER_USER_HELPER
-	bool "Enable the firmware sysfs fallback mechanism"
-	help
-	  This option enables a sysfs loading facility to enable firmware
-	  loading to the kernel through userspace as a fallback mechanism
-	  if and only if the kernel's direct filesystem lookup for the
-	  firmware failed using the different /lib/firmware/ paths, or the
-	  path specified in the firmware_class path module parameter, or the
-	  firmware_class path kernel boot parameter if the firmware_class is
-	  built-in. For details on how to work with the sysfs fallback mechanism
-	  refer to Documentation/driver-api/firmware/fallback-mechanisms.rst.
-
-	  The direct filesystem lookup for firwmare is always used first now.
-
-	  If the kernel's direct filesystem lookup for firware fails to find
-	  the requested firmware a sysfs fallback loading facility is made
-	  available and userspace is informed about this through uevents.
-	  The uevent can be supressed if the driver explicitly requested it,
-	  this is known as the driver using the custom fallback mechanism.
-	  If the custom fallback mechanism is used userspace must always
-	  acknowledge failure to find firmware as the timeout for the fallback
-	  mechanism is disabled, and failed requests will linger forever.
-
-	  This used to be the default firmware loading facility, and udev used
-	  listen for uvents to load firmware for the kernel. The firmware
-	  loading facility functionality in udev has been removed, as such it
-	  can no longer be relied upon as a fallback mechanism. Linux no longer
-	  relies on or uses a fallback mechanism in userspace.
-
-	  Since this was the default firmware loading facility at one point,
-	  old userspace may exist which relies upon it, and as such this
-	  mechanism can never be removed from the kernel.
-
-	  You should only enable this functionality if you are certain you
-	  require a fallback mechanism and have a userspace mechanism ready to
-	  load firmware in case it is not found. Another reason kernels may
-	  have this feature enabled is to support a driver which explicitly
-	  relies on this fallback mechanism. Only two drivers need this today:
-
-	    o CONFIG_LEDS_LP55XX_COMMON
-	    o CONFIG_DELL_RBU
-
-	  Outside of supporting the above drivers, another reason for needing
-	  this may be that your firmware resides outside of the paths the kernel
-	  looks for and cannot possibily be specified using the firmware_class
-	  path module parameter or kernel firmware_class path boot parameter
-	  if firmware_class is built-in.
-
-	  A modern use case may be to temporarily mount a custom partition
-	  during provisioning which is only accessible to userspace, and then
-	  to use it to look for and fetch the required firmware. Such type of
-	  driver functionality may not even ever be desirable upstream by
-	  vendors, and as such is only required to be supported as an interface
-	  for provisioning. Since udev's firmware loading facility has been
-	  removed you can use firmwared or a fork of it to customize how you
-	  want to load firmware based on uevents issued:
-	  https://github.com/teg/firmwared
-
-	  Enabling this option will increase your kernel image size by about
-	  13436 bytes.
-
-	  If you are unsure about this, say N here, unless you are Linux
-	  distribution and need to support the above two drivers, or you are
-	  certain you need to support some really custom firmware loading
-	  facility in userspace.
-
-config FW_LOADER_USER_HELPER_FALLBACK
-	bool "Force the firmware sysfs fallback mechanism when possible"
-	depends on FW_LOADER_USER_HELPER
-	help
-	  Enabling this option forces a sysfs userspace fallback mechanism
-	  to be used for all firmware requests which explicitly do not disable a
-	  a fallback mechanism. Firmware calls which do prohibit a fallback
-	  mechanism is request_firmware_direct(). This option is kept for
-          backward compatibility purposes given this precise mechanism can also
-	  be enabled by setting the proc sysctl value to true:
-
-	       /proc/sys/kernel/firmware_config/force_sysfs_fallback
-
-	  If you are unsure about this, say N here.
-
-endif # FW_LOADER
-endmenu
+source "drivers/base/firmware_loader/Kconfig"
 
 config WANT_DEV_COREDUMP
 	bool
diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
new file mode 100644
index 000000000000..b4cf42d6fe51
--- /dev/null
+++ b/drivers/base/firmware_loader/Kconfig
@@ -0,0 +1,149 @@
+menu "Firmware loader"
+
+config FW_LOADER
+	tristate "Firmware loading facility" if EXPERT
+	default y
+	---help---
+	  This enables the firmware loading facility in the kernel. The kernel
+	  will first look for built-in firmware, if it has any. Next, it will
+	  look for the requested firmware in a series of filesystem paths:
+
+		o firmware_class path module parameter or kernel boot param
+		o /lib/firmware/updates/UTS_RELEASE
+		o /lib/firmware/updates
+		o /lib/firmware/UTS_RELEASE
+		o /lib/firmware
+
+	  Enabling this feature only increases your kernel image by about
+	  828 bytes, enable this option unless you are certain you don't
+	  need firmware.
+
+	  You typically want this built-in (=y) but you can also enable this
+	  as a module, in which case the firmware_class module will be built.
+	  You also want to be sure to enable this built-in if you are going to
+	  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
+
+if FW_LOADER
+
+config EXTRA_FIRMWARE
+	string "Build these firmware blobs into the kernel binary"
+	help
+	  Device drivers which require firmware can typically deal with
+	  having the kernel load firmware from the various supported
+	  /lib/firmware/ paths. This option enables you to build into the
+	  kernel firmware files. Built-in firmware searches are preceeded
+	  over firmware lookups using your filesystem over the supported
+	  /lib/firmware paths documented on CONFIG_FW_LOADER.
+
+	  This may be useful for testing or if the firmware is required early on
+	  in boot and cannot rely on the firmware being placed in an initrd or
+	  initramfs.
+
+	  This option is a string and takes the (space-separated) names of the
+	  firmware files -- the same names that appear in MODULE_FIRMWARE()
+	  and request_firmware() in the source. These files should exist under
+	  the directory specified by the EXTRA_FIRMWARE_DIR option, which is
+	  /lib/firmware by default.
+
+	  For example, you might set CONFIG_EXTRA_FIRMWARE="usb8388.bin", copy
+	  the usb8388.bin file into /lib/firmware, and build the kernel. Then
+	  any request_firmware("usb8388.bin") will be satisfied internally
+	  inside the kernel without ever looking at your filesystem at runtime.
+
+	  WARNING: If you include additional firmware files into your binary
+	  kernel image that are not available under the terms of the GPL,
+	  then it may be a violation of the GPL to distribute the resulting
+	  image since it combines both GPL and non-GPL work. You should
+	  consult a lawyer of your own before distributing such an image.
+
+config EXTRA_FIRMWARE_DIR
+	string "Firmware blobs root directory"
+	depends on EXTRA_FIRMWARE != ""
+	default "/lib/firmware"
+	help
+	  This option controls the directory in which the kernel build system
+	  looks for the firmware files listed in the EXTRA_FIRMWARE option.
+
+config FW_LOADER_USER_HELPER
+	bool "Enable the firmware sysfs fallback mechanism"
+	help
+	  This option enables a sysfs loading facility to enable firmware
+	  loading to the kernel through userspace as a fallback mechanism
+	  if and only if the kernel's direct filesystem lookup for the
+	  firmware failed using the different /lib/firmware/ paths, or the
+	  path specified in the firmware_class path module parameter, or the
+	  firmware_class path kernel boot parameter if the firmware_class is
+	  built-in. For details on how to work with the sysfs fallback mechanism
+	  refer to Documentation/driver-api/firmware/fallback-mechanisms.rst.
+
+	  The direct filesystem lookup for firwmare is always used first now.
+
+	  If the kernel's direct filesystem lookup for firware fails to find
+	  the requested firmware a sysfs fallback loading facility is made
+	  available and userspace is informed about this through uevents.
+	  The uevent can be supressed if the driver explicitly requested it,
+	  this is known as the driver using the custom fallback mechanism.
+	  If the custom fallback mechanism is used userspace must always
+	  acknowledge failure to find firmware as the timeout for the fallback
+	  mechanism is disabled, and failed requests will linger forever.
+
+	  This used to be the default firmware loading facility, and udev used
+	  listen for uvents to load firmware for the kernel. The firmware
+	  loading facility functionality in udev has been removed, as such it
+	  can no longer be relied upon as a fallback mechanism. Linux no longer
+	  relies on or uses a fallback mechanism in userspace.
+
+	  Since this was the default firmware loading facility at one point,
+	  old userspace may exist which relies upon it, and as such this
+	  mechanism can never be removed from the kernel.
+
+	  You should only enable this functionality if you are certain you
+	  require a fallback mechanism and have a userspace mechanism ready to
+	  load firmware in case it is not found. Another reason kernels may
+	  have this feature enabled is to support a driver which explicitly
+	  relies on this fallback mechanism. Only two drivers need this today:
+
+	    o CONFIG_LEDS_LP55XX_COMMON
+	    o CONFIG_DELL_RBU
+
+	  Outside of supporting the above drivers, another reason for needing
+	  this may be that your firmware resides outside of the paths the kernel
+	  looks for and cannot possibily be specified using the firmware_class
+	  path module parameter or kernel firmware_class path boot parameter
+	  if firmware_class is built-in.
+
+	  A modern use case may be to temporarily mount a custom partition
+	  during provisioning which is only accessible to userspace, and then
+	  to use it to look for and fetch the required firmware. Such type of
+	  driver functionality may not even ever be desirable upstream by
+	  vendors, and as such is only required to be supported as an interface
+	  for provisioning. Since udev's firmware loading facility has been
+	  removed you can use firmwared or a fork of it to customize how you
+	  want to load firmware based on uevents issued:
+	  https://github.com/teg/firmwared
+
+	  Enabling this option will increase your kernel image size by about
+	  13436 bytes.
+
+	  If you are unsure about this, say N here, unless you are Linux
+	  distribution and need to support the above two drivers, or you are
+	  certain you need to support some really custom firmware loading
+	  facility in userspace.
+
+config FW_LOADER_USER_HELPER_FALLBACK
+	bool "Force the firmware sysfs fallback mechanism when possible"
+	depends on FW_LOADER_USER_HELPER
+	help
+	  Enabling this option forces a sysfs userspace fallback mechanism
+	  to be used for all firmware requests which explicitly do not disable a
+	  a fallback mechanism. Firmware calls which do prohibit a fallback
+	  mechanism is request_firmware_direct(). This option is kept for
+          backward compatibility purposes given this precise mechanism can also
+	  be enabled by setting the proc sysctl value to true:
+
+	       /proc/sys/kernel/firmware_config/force_sysfs_fallback
+
+	  If you are unsure about this, say N here.
+
+endif # FW_LOADER
+endmenu
-- 
2.17.0

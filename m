Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA7C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E662073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JanZ5Err"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfBDUdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:33:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41661 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfBDUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:33:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so1314942wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=br7iQT4xLDwtZffOOBCsb3YDZsoKvb+zg+pvfvq0sJg=;
        b=JanZ5Err8EdgHwgy2g43RXLUIVj9qzLegZIW2P5H9gUyRRG51YpuALTaCKP56HMX8+
         C4i7ceu8Vgr7bb89KURCgWmqP4HuW0BdeuJbnFXAUjq3qlRXnPbvmVWUwn5QCKqw3em6
         RvymaB3xB76I7D6vQyO0RHA+JUpDDEx32Ofktbt9tzO7bgOzA7XCd4czhEdotPKYTNJB
         s6KexEVLw+dgKPPjgY3YYYgjfUyxeeCwY41kaQrpuezJpR64KfqjDrIzIm4yxKLkeCzV
         7xeeYwRbd/aRyx8fXBFc6bO0HQOS3FFidJgLnI/etKTAjWKNViJ2H/DZe8xliSWVC2ku
         1z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=br7iQT4xLDwtZffOOBCsb3YDZsoKvb+zg+pvfvq0sJg=;
        b=F6dLE7rI+uOzjrV8zzF4YfzonQwIsWGNT4FGMuE7CGbSMH7Qnm+Majpc8eLbHto8Cx
         Uub3BtMY/pZ4aW4ytgKe0XZbPPpjs1K/CyALRATjIGnH7Hy5MjIH4gAxkWHSC7VakZRI
         LjcqVangQGfF/WVAyTGvahxIQul84bc4JKxDJgEkVRKOBIw3CC3AB9ZEAnAAswo3pR8R
         SmwEzC6BPxl9XzB7YNCcnQzYVytn3ulqEP8tVs3sdyxEH4/7AK7C3r4Y10OydzOfdcac
         63TMtSrBgi2WJWV87Q//m/pMMeBg2x72w0xvAIw3Mopg2qy1dKdXuBd7zmhHY76hO2X8
         N2Xw==
X-Gm-Message-State: AHQUAuY7a1DUgk1iIC1dldzDgeHqgTJUWpQYfS2SsVX/n6aKFlW/EH/v
        aP6kYwXIGvjhOmLYgexIlRWlqJ5I
X-Google-Smtp-Source: AHgI3Ibl2RSBDO/OCgL923OPd0oMw3IVLFKLrAoyZIsnZ3jMK7+eRvVhxjagFAHeotA1+rMlSTBUTQ==
X-Received: by 2002:a5d:480a:: with SMTP id l10mr829430wrq.101.1549312397629;
        Mon, 04 Feb 2019 12:33:17 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j24sm19990792wrd.86.2019.02.04.12.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:33:16 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v3 09/15] habanalabs: add sysfs and hwmon support
Date:   Mon,  4 Feb 2019 22:32:48 +0200
Message-Id: <20190204203254.4026-10-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204203254.4026-1-oded.gabbay@gmail.com>
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the sysfs and hwmon entries that are exposed by the driver.

Goya has several sensors, from various categories such as temperature,
voltage, current, etc. The driver exposes those sensors in the standard
hwmon mechanism.

In addition, the driver exposes a couple of interfaces in sysfs, both for
configuration and for providing status of the device or driver.

The configuration attributes is for Power Management:
- Automatic or manual
- Frequency value when moving to high frequency mode
- Maximum power the device is allowed to consume

The rest of the attributes are read-only and provide the following
information:
- Versions of the various firmwares running on the device
- Contents of the device's EEPROM
- The device type (currently only Goya is supported)
- PCI address of the device (to allow user-space to connect between
  /dev/hlX to PCI address)
- Status of the device (operational, malfunction, in_reset)
- How many processes are open on the device's file

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../ABI/testing/sysfs-driver-habanalabs       | 190 ++++++
 drivers/misc/habanalabs/Makefile              |   2 +-
 drivers/misc/habanalabs/device.c              | 146 +++++
 drivers/misc/habanalabs/goya/Makefile         |   2 +-
 drivers/misc/habanalabs/goya/goya.c           | 230 +++++++
 drivers/misc/habanalabs/goya/goyaP.h          |  21 +
 drivers/misc/habanalabs/goya/goya_hwmgr.c     | 306 +++++++++
 drivers/misc/habanalabs/habanalabs.h          | 101 +++
 drivers/misc/habanalabs/habanalabs_drv.c      |   7 +
 drivers/misc/habanalabs/hwmon.c               | 449 +++++++++++++
 drivers/misc/habanalabs/sysfs.c               | 589 ++++++++++++++++++
 11 files changed, 2041 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-habanalabs
 create mode 100644 drivers/misc/habanalabs/goya/goya_hwmgr.c
 create mode 100644 drivers/misc/habanalabs/hwmon.c
 create mode 100644 drivers/misc/habanalabs/sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
new file mode 100644
index 000000000000..19edd4da87c1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -0,0 +1,190 @@
+What:           /sys/class/habanalabs/hl<n>/armcp_kernel_ver
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Version of the Linux kernel running on the device's CPU
+
+What:           /sys/class/habanalabs/hl<n>/armcp_ver
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Version of the application running on the device's CPU
+
+What:           /sys/class/habanalabs/hl<n>/cpld_ver
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Version of the Device's CPLD F/W
+
+What:           /sys/class/habanalabs/hl<n>/device_type
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays the code name of the device according to its type.
+                The supported values are: "GOYA"
+
+What:           /sys/class/habanalabs/hl<n>/eeprom
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    A binary file attribute that contains the contents of the
+                on-board EEPROM
+
+What:           /sys/class/habanalabs/hl<n>/fuse_ver
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays the device's version from the eFuse
+
+What:           /sys/class/habanalabs/hl<n>/hard_reset
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Interface to trigger a hard-reset operation for the device.
+                Hard-reset will reset ALL internal components of the device
+                except for the PCI interface and the internal PLLs
+
+What:           /sys/class/habanalabs/hl<n>/hard_reset_cnt
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays how many times the device have undergone a hard-reset
+                operation
+
+What:           /sys/class/habanalabs/hl<n>/high_pll
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Allows the user to set the maximum clock frequency for MME, TPC
+                and IC when the power management profile is set to "automatic".
+
+What:           /sys/class/habanalabs/hl<n>/ic_clk
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Allows the user to set the maximum clock frequency of the
+                Interconnect fabric. Writes to this parameter affect the device
+                only when the power management profile is set to "manual" mode.
+                The device IC clock might be set to lower value then the
+                maximum. The user should read the ic_clk_curr to see the actual
+                frequency value of the IC
+
+What:           /sys/class/habanalabs/hl<n>/ic_clk_curr
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays the current clock frequency of the Interconnect fabric
+
+What:           /sys/class/habanalabs/hl<n>/infineon_ver
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Version of the Device's power supply F/W code
+
+What:           /sys/class/habanalabs/hl<n>/max_power
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Allows the user to set the maximum power consumption of the
+                device in milliwatts.
+
+What:           /sys/class/habanalabs/hl<n>/mme_clk
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Allows the user to set the maximum clock frequency of the
+                MME compute engine. Writes to this parameter affect the device
+                only when the power management profile is set to "manual" mode.
+                The device MME clock might be set to lower value then the
+                maximum. The user should read the mme_clk_curr to see the actual
+                frequency value of the MME
+
+What:           /sys/class/habanalabs/hl<n>/mme_clk_curr
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays the current clock frequency of the MME compute engine
+
+What:           /sys/class/habanalabs/hl<n>/pci_addr
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays the PCI address of the device. This is needed so the
+                user would be able to open a device based on its PCI address
+
+What:           /sys/class/habanalabs/hl<n>/pm_mng_profile
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Power management profile. Values are "auto", "manual". In "auto"
+                mode, the driver will set the maximum clock frequency to a high
+                value when a user-space process opens the device's file (unless
+                it was already opened by another process). The driver will set
+                the max clock frequency to a low value when there are no user
+                processes that are opened on the device's file. In "manual"
+                mode, the user sets the maximum clock frequency by writing to
+                ic_clk, mme_clk and tpc_clk
+
+
+What:           /sys/class/habanalabs/hl<n>/preboot_btl_ver
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Version of the device's preboot F/W code
+
+What:           /sys/class/habanalabs/hl<n>/soft_reset
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Interface to trigger a soft-reset operation for the device.
+                Soft-reset will reset only the compute and DMA engines of the
+                device
+
+What:           /sys/class/habanalabs/hl<n>/soft_reset_cnt
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays how many times the device have undergone a soft-reset
+                operation
+
+What:           /sys/class/habanalabs/hl<n>/status
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Status of the card: "Operational", "Malfunction", "In reset".
+
+What:           /sys/class/habanalabs/hl<n>/thermal_ver
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Version of the Device's thermal daemon
+
+What:           /sys/class/habanalabs/hl<n>/tpc_clk
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Allows the user to set the maximum clock frequency of the
+                TPC compute engines. Writes to this parameter affect the device
+                only when the power management profile is set to "manual" mode.
+                The device TPC clock might be set to lower value then the
+                maximum. The user should read the tpc_clk_curr to see the actual
+                frequency value of the TPC
+
+What:           /sys/class/habanalabs/hl<n>/tpc_clk_curr
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays the current clock frequency of the TPC compute engines
+
+What:           /sys/class/habanalabs/hl<n>/uboot_ver
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Version of the u-boot running on the device's CPU
+
+What:           /sys/class/habanalabs/hl<n>/write_open_cnt
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays the total number of user processes that are currently
+                opened on the device's file
diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index 1e2a0c1b3890..2aeadc4cef30 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -5,7 +5,7 @@
 obj-m	:= habanalabs.o
 
 habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
-		command_buffer.o hw_queue.o irq.o
+		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o
 
 include $(src)/goya/Makefile
 habanalabs-y += $(HL_GOYA_FILES)
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index e4c939899042..5cb54cbd8502 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -231,6 +231,118 @@ static void device_early_fini(struct hl_device *hdev)
 	mutex_destroy(&hdev->fd_open_cnt_lock);
 }
 
+static void set_freq_to_low_job(struct work_struct *work)
+{
+	struct hl_device *hdev = container_of(work, struct hl_device,
+						work_freq.work);
+
+	if (atomic_read(&hdev->fd_open_cnt) == 0)
+		hl_device_set_frequency(hdev, PLL_LOW);
+
+	schedule_delayed_work(&hdev->work_freq,
+			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
+}
+
+/*
+ * device_late_init - do late stuff initialization for the habanalabs device
+ *
+ * @hdev: pointer to habanalabs device structure
+ *
+ * Do stuff that either needs the device H/W queues to be active or needs
+ * to happen after all the rest of the initialization is finished
+ */
+static int device_late_init(struct hl_device *hdev)
+{
+	int rc;
+
+	INIT_DELAYED_WORK(&hdev->work_freq, set_freq_to_low_job);
+	hdev->high_pll = hdev->asic_prop.high_pll;
+
+	/* force setting to low frequency */
+	atomic_set(&hdev->curr_pll_profile, PLL_LOW);
+
+	if (hdev->pm_mng_profile == PM_AUTO)
+		hdev->asic_funcs->set_pll_profile(hdev, PLL_LOW);
+	else
+		hdev->asic_funcs->set_pll_profile(hdev, PLL_LAST);
+
+	if (hdev->asic_funcs->late_init) {
+		rc = hdev->asic_funcs->late_init(hdev);
+		if (rc) {
+			dev_err(hdev->dev,
+				"failed late initialization for the H/W\n");
+			return rc;
+		}
+	}
+
+	schedule_delayed_work(&hdev->work_freq,
+			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
+
+	hdev->late_init_done = true;
+
+	return 0;
+}
+
+/*
+ * device_late_fini - finalize all that was done in device_late_init
+ *
+ * @hdev: pointer to habanalabs device structure
+ *
+ */
+static void device_late_fini(struct hl_device *hdev)
+{
+	if (!hdev->late_init_done)
+		return;
+
+	cancel_delayed_work_sync(&hdev->work_freq);
+
+	if (hdev->asic_funcs->late_fini)
+		hdev->asic_funcs->late_fini(hdev);
+
+	hdev->late_init_done = false;
+}
+
+/*
+ * hl_device_set_frequency - set the frequency of the device
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @freq: the new frequency value
+ *
+ * Change the frequency if needed.
+ * We allose to set PLL to low only if there is no user process
+ * Returns 0 if no change was done, otherwise returns 1;
+ */
+int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq)
+{
+	enum hl_pll_frequency old_freq =
+			(freq == PLL_HIGH) ? PLL_LOW : PLL_HIGH;
+	int ret;
+
+	if (hdev->pm_mng_profile == PM_MANUAL)
+		return 0;
+
+	ret = atomic_cmpxchg(&hdev->curr_pll_profile, old_freq, freq);
+	if (ret == freq)
+		return 0;
+
+	/*
+	 * in case we want to lower frequency, check if device is not
+	 * opened. We must have a check here to workaround race condition with
+	 * hl_device_open
+	 */
+	if ((freq == PLL_LOW) && (atomic_read(&hdev->fd_open_cnt) > 0)) {
+		atomic_set(&hdev->curr_pll_profile, PLL_HIGH);
+		return 0;
+	}
+
+	dev_dbg(hdev->dev, "Changing device frequency to %s\n",
+		freq == PLL_HIGH ? "high" : "low");
+
+	hdev->asic_funcs->set_pll_profile(hdev, freq);
+
+	return 1;
+}
+
 /*
  * hl_device_suspend - initiate device suspend
  *
@@ -391,6 +503,12 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto release_ctx;
 	}
 
+	rc = hl_sysfs_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize sysfs\n");
+		goto free_cb_pool;
+	}
+
 	rc = hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize the H/W\n");
@@ -408,11 +526,33 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto out_disabled;
 	}
 
+	/* After test_queues, KMD can start sending messages to device CPU */
+
+	rc = device_late_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed late initialization\n");
+		rc = 0;
+		goto out_disabled;
+	}
+
+	dev_info(hdev->dev, "Found %s device with %lluGB DRAM\n",
+		hdev->asic_name,
+		hdev->asic_prop.dram_size / 1024 / 1024 / 1024);
+
+	rc = hl_hwmon_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to initialize hwmon\n");
+		rc = 0;
+		goto out_disabled;
+	}
+
 	dev_notice(hdev->dev,
 		"Successfully added device to habanalabs driver\n");
 
 	return 0;
 
+free_cb_pool:
+	hl_cb_pool_fini(hdev);
 release_ctx:
 	if (hl_ctx_put(hdev->kernel_ctx) != 1)
 		dev_err(hdev->dev,
@@ -462,6 +602,12 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
+	hl_hwmon_fini(hdev);
+
+	device_late_fini(hdev);
+
+	hl_sysfs_fini(hdev);
+
 	/*
 	 * Halt the engines and disable interrupts so we won't get any more
 	 * completions from H/W and we won't have any accesses from the
diff --git a/drivers/misc/habanalabs/goya/Makefile b/drivers/misc/habanalabs/goya/Makefile
index b546e9f5ef76..46125e4c2799 100644
--- a/drivers/misc/habanalabs/goya/Makefile
+++ b/drivers/misc/habanalabs/goya/Makefile
@@ -1,4 +1,4 @@
 subdir-ccflags-y += -I$(src)
 
-HL_GOYA_FILES :=  goya/goya.o goya/goya_security.o
+HL_GOYA_FILES :=  goya/goya.o goya/goya_security.o goya/goya_hwmgr.o
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 9cf2eecb9414..dd6366c6d309 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -127,6 +127,8 @@ static const char *goya_axi_name[GOYA_MAX_INITIATORS] = {
 
 #define GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE 121
 
+static int goya_armcp_info_get(struct hl_device *hdev);
+
 static void goya_get_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -174,6 +176,7 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->num_of_events = GOYA_ASYNC_EVENT_ID_SIZE;
 	prop->cb_pool_cb_cnt = GOYA_CB_POOL_CB_CNT;
 	prop->cb_pool_cb_size = GOYA_CB_POOL_CB_SIZE;
+	prop->max_power_default = MAX_POWER_DEFAULT;
 	prop->tpc_enabled_mask = TPC_ENABLED_MASK;
 
 	prop->high_pll = PLL_HIGH_DEFAULT;
@@ -564,6 +567,89 @@ int goya_early_fini(struct hl_device *hdev)
 	return 0;
 }
 
+/*
+ * goya_fetch_psoc_frequency - Fetch PSOC frequency values
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ */
+static void goya_fetch_psoc_frequency(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	prop->psoc_pci_pll_nr = RREG32(mmPSOC_PCI_PLL_NR);
+	prop->psoc_pci_pll_nf = RREG32(mmPSOC_PCI_PLL_NF);
+	prop->psoc_pci_pll_od = RREG32(mmPSOC_PCI_PLL_OD);
+	prop->psoc_pci_pll_div_factor = RREG32(mmPSOC_PCI_PLL_DIV_FACTOR_1);
+}
+
+/*
+ * goya_late_init - GOYA late initialization code
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Get ArmCP info and send message to CPU to enable PCI access
+ */
+static int goya_late_init(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct goya_device *goya = hdev->asic_specific;
+	int rc;
+
+	rc = goya->armcp_info_get(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to get armcp info\n");
+		return rc;
+	}
+
+	/* Now that we have the DRAM size in ASIC prop, we need to check
+	 * its size and configure the DMA_IF DDR wrap protection (which is in
+	 * the MMU block) accordingly. The value is the log2 of the DRAM size
+	 */
+	WREG32(mmMMU_LOG2_DDR_SIZE, ilog2(prop->dram_size));
+
+	rc = goya_send_pci_access_msg(hdev, ARMCP_PACKET_ENABLE_PCI_ACCESS);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
+		return rc;
+	}
+
+	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
+			GOYA_ASYNC_EVENT_ID_INTS_REGISTER);
+
+	goya_fetch_psoc_frequency(hdev);
+
+	return 0;
+}
+
+/*
+ * goya_late_fini - GOYA late tear-down code
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Free sensors allocated structures
+ */
+void goya_late_fini(struct hl_device *hdev)
+{
+	const struct hwmon_channel_info **channel_info_arr;
+	int i = 0;
+
+	if (!hdev->hl_chip_info.info)
+		return;
+
+	channel_info_arr = hdev->hl_chip_info.info;
+
+	while (channel_info_arr[i]) {
+		kfree(channel_info_arr[i]->config);
+		kfree(channel_info_arr[i]);
+		i++;
+	}
+
+	kfree(channel_info_arr);
+
+	hdev->hl_chip_info.info = NULL;
+}
+
 /*
  * goya_sw_init - Goya software initialization code
  *
@@ -581,9 +667,15 @@ static int goya_sw_init(struct hl_device *hdev)
 		return -ENOMEM;
 
 	goya->test_cpu_queue = goya_test_cpu_queue;
+	goya->armcp_info_get = goya_armcp_info_get;
 
 	/* according to goya_init_iatu */
 	goya->ddr_bar_cur_addr = DRAM_PHYS_BASE;
+
+	goya->mme_clk = GOYA_PLL_FREQ_LOW;
+	goya->tpc_clk = GOYA_PLL_FREQ_LOW;
+	goya->ic_clk = GOYA_PLL_FREQ_LOW;
+
 	hdev->asic_specific = goya;
 
 	/* Create DMA pool for small allocations */
@@ -3218,6 +3310,87 @@ void *goya_get_events_stat(struct hl_device *hdev, u32 *size)
 	return goya->events_stat;
 }
 
+static int goya_armcp_info_get(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct armcp_packet pkt;
+	void *armcp_info_cpu_addr;
+	dma_addr_t armcp_info_dma_addr;
+	u64 dram_size;
+	long result;
+	int rc;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
+
+	armcp_info_cpu_addr =
+			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
+			sizeof(struct armcp_info), &armcp_info_dma_addr);
+	if (!armcp_info_cpu_addr) {
+		dev_err(hdev->dev,
+			"Failed to allocate DMA memory for ArmCP info packet\n");
+		return -ENOMEM;
+	}
+
+	memset(armcp_info_cpu_addr, 0, sizeof(struct armcp_info));
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_INFO_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.addr = armcp_info_dma_addr + prop->host_phys_base_address;
+	pkt.data_max_size = sizeof(struct armcp_info);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+			GOYA_ARMCP_INFO_TIMEOUT, &result);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to send armcp info pkt, error %d\n", rc);
+		goto out;
+	}
+
+	memcpy(&prop->armcp_info, armcp_info_cpu_addr,
+			sizeof(prop->armcp_info));
+
+	dram_size = prop->armcp_info.dram_size;
+	if (dram_size) {
+		if ((!is_power_of_2(dram_size)) ||
+				(dram_size < DRAM_PHYS_DEFAULT_SIZE)) {
+			dev_err(hdev->dev,
+				"F/W reported invalid DRAM size %llu. Trying to use default size\n",
+				dram_size);
+			dram_size = DRAM_PHYS_DEFAULT_SIZE;
+		}
+
+		prop->dram_size = dram_size;
+		prop->dram_end_address = prop->dram_base_address + dram_size;
+	}
+
+	rc = hl_build_hwmon_channel_info(hdev, prop->armcp_info.sensors);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to build hwmon channel info, error %d\n", rc);
+		rc = -EFAULT;
+		goto out;
+	}
+
+out:
+	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
+			sizeof(struct armcp_info), armcp_info_cpu_addr);
+
+	return rc;
+}
+
+static void goya_init_clock_gating(struct hl_device *hdev)
+{
+
+}
+
+static void goya_disable_clock_gating(struct hl_device *hdev)
+{
+
+}
 
 static void goya_hw_queues_lock(struct hl_device *hdev)
 {
@@ -3233,9 +3406,60 @@ static void goya_hw_queues_unlock(struct hl_device *hdev)
 	spin_unlock(&goya->hw_queues_lock);
 }
 
+int goya_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct armcp_packet pkt;
+	void *eeprom_info_cpu_addr;
+	dma_addr_t eeprom_info_dma_addr;
+	long result;
+	int rc;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
+
+	eeprom_info_cpu_addr =
+			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
+					max_size, &eeprom_info_dma_addr);
+	if (!eeprom_info_cpu_addr) {
+		dev_err(hdev->dev,
+			"Failed to allocate DMA memory for EEPROM info packet\n");
+		return -ENOMEM;
+	}
+
+	memset(eeprom_info_cpu_addr, 0, max_size);
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_EEPROM_DATA_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.addr = eeprom_info_dma_addr + prop->host_phys_base_address;
+	pkt.data_max_size = max_size;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+			GOYA_ARMCP_EEPROM_TIMEOUT, &result);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to send armcp EEPROM pkt, error %d\n", rc);
+		goto out;
+	}
+
+	/* result contains the actual size */
+	memcpy(data, eeprom_info_cpu_addr, min((size_t)result, max_size));
+
+out:
+	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, max_size,
+			eeprom_info_cpu_addr);
+
+	return rc;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
+	.late_init = goya_late_init,
+	.late_fini = goya_late_fini,
 	.sw_init = goya_sw_init,
 	.sw_fini = goya_sw_fini,
 	.hw_init = goya_hw_init,
@@ -3256,10 +3480,16 @@ static const struct hl_asic_funcs goya_funcs = {
 	.cpu_accessible_dma_pool_alloc = goya_cpu_accessible_dma_pool_alloc,
 	.cpu_accessible_dma_pool_free = goya_cpu_accessible_dma_pool_free,
 	.update_eq_ci = goya_update_eq_ci,
+	.add_device_attr = goya_add_device_attr,
+	.remove_device_attr = goya_remove_device_attr,
 	.handle_eqe = goya_handle_eqe,
+	.set_pll_profile = goya_set_pll_profile,
 	.get_events_stat = goya_get_events_stat,
+	.enable_clock_gating = goya_init_clock_gating,
+	.disable_clock_gating = goya_disable_clock_gating,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
+	.get_eeprom_data = goya_get_eeprom_data,
 	.send_cpu_message = goya_send_cpu_message
 };
 
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 58f1e316f8d9..6d2da801c155 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -50,7 +50,10 @@
 
 #define PLL_HIGH_DEFAULT		1575000000	/* 1.575 GHz */
 
+#define MAX_POWER_DEFAULT		200000		/* 200W */
+
 #define GOYA_ARMCP_INFO_TIMEOUT		10000000	/* 10s */
+#define GOYA_ARMCP_EEPROM_TIMEOUT	10000000	/* 10s */
 
 #define DRAM_PHYS_DEFAULT_SIZE		0x100000000ull	/* 4GB */
 
@@ -151,9 +154,15 @@ enum goya_fw_component {
 
 struct goya_device {
 	int (*test_cpu_queue)(struct hl_device *hdev);
+	int (*armcp_info_get)(struct hl_device *hdev);
 
 	/* TODO: remove hw_queues_lock after moving to scheduler code */
 	spinlock_t	hw_queues_lock;
+
+	u64		mme_clk;
+	u64		tpc_clk;
+	u64		ic_clk;
+
 	u64		ddr_bar_cur_addr;
 	u32		events_stat[GOYA_ASYNC_EVENT_ID_SIZE];
 	u32		hw_cap_initialized;
@@ -162,6 +171,18 @@ struct goya_device {
 int goya_test_cpu_queue(struct hl_device *hdev);
 int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
 				u32 timeout, long *result);
+long goya_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr);
+long goya_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr);
+long goya_get_current(struct hl_device *hdev, int sensor_index, u32 attr);
+long goya_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr);
+long goya_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr);
+void goya_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
+			long value);
+void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
+int goya_add_device_attr(struct hl_device *hdev);
+void goya_remove_device_attr(struct hl_device *hdev);
 void goya_init_security(struct hl_device *hdev);
+u64 goya_get_max_power(struct hl_device *hdev);
+void goya_set_max_power(struct hl_device *hdev, u64 value);
 
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
new file mode 100644
index 000000000000..866d1774b2e4
--- /dev/null
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "goyaP.h"
+
+void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
+{
+	struct goya_device *goya = hdev->asic_specific;
+
+	switch (freq) {
+	case PLL_HIGH:
+		hl_set_frequency(hdev, MME_PLL, hdev->high_pll);
+		hl_set_frequency(hdev, TPC_PLL, hdev->high_pll);
+		hl_set_frequency(hdev, IC_PLL, hdev->high_pll);
+		break;
+	case PLL_LOW:
+		hl_set_frequency(hdev, MME_PLL, GOYA_PLL_FREQ_LOW);
+		hl_set_frequency(hdev, TPC_PLL, GOYA_PLL_FREQ_LOW);
+		hl_set_frequency(hdev, IC_PLL, GOYA_PLL_FREQ_LOW);
+		break;
+	case PLL_LAST:
+		hl_set_frequency(hdev, MME_PLL, goya->mme_clk);
+		hl_set_frequency(hdev, TPC_PLL, goya->tpc_clk);
+		hl_set_frequency(hdev, IC_PLL, goya->ic_clk);
+		break;
+	default:
+		dev_err(hdev->dev, "unknown frequency setting\n");
+	}
+}
+
+static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, MME_PLL, false);
+
+	if (value < 0)
+		return value;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", value);
+}
+
+static ssize_t mme_clk_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	struct goya_device *goya = hdev->asic_specific;
+	int rc;
+	long value;
+
+	if (hdev->disabled) {
+		count = -ENODEV;
+		goto fail;
+	}
+
+	if (hdev->pm_mng_profile == PM_AUTO) {
+		count = -EPERM;
+		goto fail;
+	}
+
+	rc = kstrtoul(buf, 0, &value);
+
+	if (rc) {
+		count = -EINVAL;
+		goto fail;
+	}
+
+	hl_set_frequency(hdev, MME_PLL, value);
+	goya->mme_clk = value;
+
+fail:
+	return count;
+}
+
+static ssize_t tpc_clk_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, TPC_PLL, false);
+
+	if (value < 0)
+		return value;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", value);
+}
+
+static ssize_t tpc_clk_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	struct goya_device *goya = hdev->asic_specific;
+	int rc;
+	long value;
+
+	if (hdev->disabled) {
+		count = -ENODEV;
+		goto fail;
+	}
+
+	if (hdev->pm_mng_profile == PM_AUTO) {
+		count = -EPERM;
+		goto fail;
+	}
+
+	rc = kstrtoul(buf, 0, &value);
+
+	if (rc) {
+		count = -EINVAL;
+		goto fail;
+	}
+
+	hl_set_frequency(hdev, TPC_PLL, value);
+	goya->tpc_clk = value;
+
+fail:
+	return count;
+}
+
+static ssize_t ic_clk_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, IC_PLL, false);
+
+	if (value < 0)
+		return value;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", value);
+}
+
+static ssize_t ic_clk_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	struct goya_device *goya = hdev->asic_specific;
+	int rc;
+	long value;
+
+	if (hdev->disabled) {
+		count = -ENODEV;
+		goto fail;
+	}
+
+	if (hdev->pm_mng_profile == PM_AUTO) {
+		count = -EPERM;
+		goto fail;
+	}
+
+	rc = kstrtoul(buf, 0, &value);
+
+	if (rc) {
+		count = -EINVAL;
+		goto fail;
+	}
+
+	hl_set_frequency(hdev, IC_PLL, value);
+	goya->ic_clk = value;
+
+fail:
+	return count;
+}
+
+static ssize_t mme_clk_curr_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, MME_PLL, true);
+
+	if (value < 0)
+		return value;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", value);
+}
+
+static ssize_t tpc_clk_curr_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, TPC_PLL, true);
+
+	if (value < 0)
+		return value;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", value);
+}
+
+static ssize_t ic_clk_curr_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, IC_PLL, true);
+
+	if (value < 0)
+		return value;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", value);
+}
+
+static DEVICE_ATTR_RW(mme_clk);
+static DEVICE_ATTR_RW(tpc_clk);
+static DEVICE_ATTR_RW(ic_clk);
+static DEVICE_ATTR_RO(mme_clk_curr);
+static DEVICE_ATTR_RO(tpc_clk_curr);
+static DEVICE_ATTR_RO(ic_clk_curr);
+
+int goya_add_device_attr(struct hl_device *hdev)
+{
+	int rc;
+
+	rc = device_create_file(hdev->dev, &dev_attr_mme_clk);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file mme_clk\n");
+		return rc;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_tpc_clk);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file tpc_clk\n");
+		goto remove_mme_clk;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_ic_clk);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file ic_clk\n");
+		goto remove_tpc_clk;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_mme_clk_curr);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file mme_clk_curr\n");
+		goto remove_ic_clk;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_tpc_clk_curr);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file tpc_clk_curr\n");
+		goto remove_mme_clk_curr;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_ic_clk_curr);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file ic_clk_curr\n");
+		goto remove_tpc_clk_curr;
+	}
+
+	return 0;
+
+remove_tpc_clk_curr:
+	device_remove_file(hdev->dev, &dev_attr_tpc_clk_curr);
+remove_mme_clk_curr:
+	device_remove_file(hdev->dev, &dev_attr_mme_clk_curr);
+remove_ic_clk:
+	device_remove_file(hdev->dev, &dev_attr_ic_clk);
+remove_tpc_clk:
+	device_remove_file(hdev->dev, &dev_attr_tpc_clk);
+remove_mme_clk:
+	device_remove_file(hdev->dev, &dev_attr_mme_clk);
+	return rc;
+}
+
+void goya_remove_device_attr(struct hl_device *hdev)
+{
+	device_remove_file(hdev->dev, &dev_attr_ic_clk_curr);
+	device_remove_file(hdev->dev, &dev_attr_tpc_clk_curr);
+	device_remove_file(hdev->dev, &dev_attr_mme_clk_curr);
+	device_remove_file(hdev->dev, &dev_attr_ic_clk);
+	device_remove_file(hdev->dev, &dev_attr_tpc_clk);
+	device_remove_file(hdev->dev, &dev_attr_mme_clk);
+}
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 11f0c0492c79..5e0f20b92bde 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -28,6 +28,8 @@
 
 #define HL_DEVICE_TIMEOUT_USEC		1000000 /* 1 s */
 
+#define HL_PLL_LOW_JOB_FREQ_USEC	5000000 /* 5 s */
+
 #define HL_MAX_QUEUES			128
 
 struct hl_device;
@@ -63,6 +65,8 @@ struct hw_queue_properties {
 /**
  * struct asic_fixed_properties - ASIC specific immutable properties.
  * @hw_queues_props: H/W queues properties.
+ * @armcp_info: received various information from ArmCP regarding the H/W. e.g.
+ *		available sensors.
  * @uboot_ver: F/W U-boot version.
  * @preboot_ver: F/W Preboot version.
  * @sram_base_address: SRAM physical start address.
@@ -75,6 +79,7 @@ struct hw_queue_properties {
  * @dram_pci_bar_size: size of PCI bar towards DRAM.
  * @host_phys_base_address: base physical address of host memory for
  *				transactions that the device generates.
+ * @max_power_default: max power of the device after reset
  * @va_space_host_start_address: base address of virtual memory range for
  *                               mapping host memory.
  * @va_space_host_end_address: end address of virtual memory range for
@@ -87,6 +92,10 @@ struct hw_queue_properties {
  * @sram_size: total size of SRAM.
  * @max_asid: maximum number of open contexts (ASIDs).
  * @num_of_events: number of possible internal H/W IRQs.
+ * @psoc_pci_pll_nr: PCI PLL NR value.
+ * @psoc_pci_pll_nf: PCI PLL NF value.
+ * @psoc_pci_pll_od: PCI PLL OD value.
+ * @psoc_pci_pll_div_factor: PCI PLL DIV FACTOR 1 value.
  * @completion_queues_count: number of completion queues.
  * @high_pll: high PLL frequency used by the device.
  * @cb_pool_cb_cnt: number of CBs in the CB pool.
@@ -95,6 +104,7 @@ struct hw_queue_properties {
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	hw_queues_props[HL_MAX_QUEUES];
+	struct armcp_info	armcp_info;
 	char			uboot_ver[VERSION_MAX_LEN];
 	char			preboot_ver[VERSION_MAX_LEN];
 	u64			sram_base_address;
@@ -106,6 +116,7 @@ struct asic_fixed_properties {
 	u64			dram_size;
 	u64			dram_pci_bar_size;
 	u64			host_phys_base_address;
+	u64			max_power_default;
 	u64			va_space_host_start_address;
 	u64			va_space_host_end_address;
 	u64			va_space_dram_start_address;
@@ -114,6 +125,10 @@ struct asic_fixed_properties {
 	u32			sram_size;
 	u32			max_asid;
 	u32			num_of_events;
+	u32			psoc_pci_pll_nr;
+	u32			psoc_pci_pll_nf;
+	u32			psoc_pci_pll_od;
+	u32			psoc_pci_pll_div_factor;
 	u32			high_pll;
 	u32			cb_pool_cb_cnt;
 	u32			cb_pool_cb_size;
@@ -287,11 +302,37 @@ enum hl_asic_type {
 	ASIC_INVALID
 };
 
+/**
+ * enum hl_pm_mng_profile - power management profile.
+ * @PM_AUTO: internal clock is set by KMD.
+ * @PM_MANUAL: internal clock is set by the user.
+ * @PM_LAST: last power management type.
+ */
+enum hl_pm_mng_profile {
+	PM_AUTO = 1,
+	PM_MANUAL,
+	PM_LAST
+};
+
+/**
+ * enum hl_pll_frequency - PLL frequency.
+ * @PLL_HIGH: high frequency.
+ * @PLL_LOW: low frequency.
+ * @PLL_LAST: last frequency values that were configured by the user.
+ */
+enum hl_pll_frequency {
+	PLL_HIGH = 1,
+	PLL_LOW,
+	PLL_LAST
+};
+
 /**
  * struct hl_asic_funcs - ASIC specific functions that are can be called from
  *                        common code.
  * @early_init: sets up early driver state (pre sw_init), doesn't configure H/W.
  * @early_fini: tears down what was done in early_init.
+ * @late_init: sets up late driver/hw state (post hw_init) - Optional.
+ * @late_fini: tears down what was done in late_init (pre hw_fini) - Optional.
  * @sw_init: sets up driver state, does not configure H/W.
  * @sw_fini: tears down driver state, does not configure H/W.
  * @hw_init: sets up the H/W state.
@@ -321,15 +362,23 @@ enum hl_asic_type {
  * @cpu_accessible_dma_pool_alloc: allocate CPU PQ packet from DMA pool.
  * @cpu_accessible_dma_pool_free: free CPU PQ packet from DMA pool.
  * @update_eq_ci: update event queue CI.
+ * @add_device_attr: add ASIC specific device attributes.
+ * @remove_device_attr: remove ASIC specific device attributes.
  * @handle_eqe: handle event queue entry (IRQ) from ArmCP.
+ * @set_pll_profile: change PLL profile (manual/automatic).
  * @get_events_stat: retrieve event queue entries histogram.
+ * @enable_clock_gating: enable clock gating for reducing power consumption.
+ * @disable_clock_gating: disable clock for accessing registers on HBW.
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
+ * @get_eeprom_data: retrieve EEPROM data from F/W.
  * @send_cpu_message: send buffer to ArmCP.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
 	int (*early_fini)(struct hl_device *hdev);
+	int (*late_init)(struct hl_device *hdev);
+	void (*late_fini)(struct hl_device *hdev);
 	int (*sw_init)(struct hl_device *hdev);
 	int (*sw_fini)(struct hl_device *hdev);
 	int (*hw_init)(struct hl_device *hdev);
@@ -358,11 +407,19 @@ struct hl_asic_funcs {
 	void (*cpu_accessible_dma_pool_free)(struct hl_device *hdev,
 				size_t size, void *vaddr);
 	void (*update_eq_ci)(struct hl_device *hdev, u32 val);
+	int (*add_device_attr)(struct hl_device *hdev);
+	void (*remove_device_attr)(struct hl_device *hdev);
 	void (*handle_eqe)(struct hl_device *hdev,
 				struct hl_eq_entry *eq_entry);
+	void (*set_pll_profile)(struct hl_device *hdev,
+			enum hl_pll_frequency freq);
 	void* (*get_events_stat)(struct hl_device *hdev, u32 *size);
+	void (*enable_clock_gating)(struct hl_device *hdev);
+	void (*disable_clock_gating)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
+	int (*get_eeprom_data)(struct hl_device *hdev, void *data,
+				size_t max_size);
 	int (*send_cpu_message)(struct hl_device *hdev, u32 *msg,
 				u16 len, u32 timeout, long *result);
 };
@@ -409,6 +466,8 @@ struct hl_cs_job {
 	struct work_struct	finish_work;
 	u32			id;
 };
+
+
 /*
  * FILE PRIVATE STRUCTURE
  */
@@ -481,6 +540,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * @rmmio: configuration area address on SRAM.
  * @cdev: related char device.
  * @dev: realted kernel basic device structure.
+ * @work_freq: delayed work to lower device frequency if possible.
  * @asic_name: ASIC specific nmae.
  * @asic_type: ASIC specific type.
  * @completion_queue: array of hl_cq.
@@ -506,13 +566,23 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * @asic_prop: ASIC specific immutable properties.
  * @asic_funcs: ASIC specific functions.
  * @asic_specific: ASIC specific information to use only from ASIC files.
+ * @hwmon_dev: H/W monitor device.
+ * @pm_mng_profile: current power management profile.
+ * @hl_chip_info: ASIC's sensors information.
  * @cb_pool: list of preallocated CBs.
  * @cb_pool_lock: protects the CB pool.
  * @user_ctx: current user context executing.
+ * @curr_pll_profile: current PLL profile.
  * @fd_open_cnt: number of open user processes.
+ * @max_power: the max power of the device, as configured by the sysadmin. This
+ *             value is saved so in case of hard-reset, KMD will restore this
+ *             value and update the F/W after the re-initialization
  * @major: habanalabs KMD major.
+ * @high_pll: high PLL profile frequency.
  * @id: device minor.
  * @disabled: is device disabled.
+ * @late_init_done: is late init stage was done during initialization.
+ * @hwmon_initialized: is H/W monitor sensors was initialized.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -520,6 +590,7 @@ struct hl_device {
 	void __iomem			*rmmio;
 	struct cdev			cdev;
 	struct device			*dev;
+	struct delayed_work		work_freq;
 	char				asic_name[16];
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
@@ -541,16 +612,25 @@ struct hl_device {
 	struct asic_fixed_properties	asic_prop;
 	const struct hl_asic_funcs	*asic_funcs;
 	void				*asic_specific;
+	struct device			*hwmon_dev;
+	enum hl_pm_mng_profile		pm_mng_profile;
+	struct hwmon_chip_info		hl_chip_info;
 
 	struct list_head		cb_pool;
 	spinlock_t			cb_pool_lock;
 
 	/* TODO: remove user_ctx for multiple process support */
 	struct hl_ctx			*user_ctx;
+
+	atomic_t			curr_pll_profile;
 	atomic_t			fd_open_cnt;
+	u64				max_power;
 	u32				major;
+	u32				high_pll;
 	u16				id;
 	u8				disabled;
+	u8				late_init_done;
+	u8				hwmon_initialized;
 
 	/* Parameters for bring-up */
 	u8				cpu_enable;
@@ -631,6 +711,15 @@ int hl_device_suspend(struct hl_device *hdev);
 int hl_device_resume(struct hl_device *hdev);
 void hl_hpriv_get(struct hl_fpriv *hpriv);
 void hl_hpriv_put(struct hl_fpriv *hpriv);
+int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
+int hl_build_hwmon_channel_info(struct hl_device *hdev,
+		struct armcp_sensor *sensors_arr);
+
+int hl_sysfs_init(struct hl_device *hdev);
+void hl_sysfs_fini(struct hl_device *hdev);
+
+int hl_hwmon_init(struct hl_device *hdev);
+void hl_hwmon_fini(struct hl_device *hdev);
 
 int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr, u32 cb_size,
 		u64 *handle, int ctx_id);
@@ -647,6 +736,18 @@ int hl_cb_pool_fini(struct hl_device *hdev);
 
 void goya_set_asic_funcs(struct hl_device *hdev);
 
+long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
+void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
+long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr);
+long hl_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr);
+long hl_get_current(struct hl_device *hdev, int sensor_index, u32 attr);
+long hl_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr);
+long hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr);
+void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
+			long value);
+u64 hl_get_max_power(struct hl_device *hdev);
+void hl_set_max_power(struct hl_device *hdev, u64 value);
+
 /* IOCTLs */
 long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 14775a7022f0..6260d99ef1ca 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -131,6 +131,13 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hpriv->taskpid = find_get_pid(current->pid);
 
+	/*
+	 * Device is IDLE at this point so it is legal to change PLLs. There
+	 * is no need to check anything because if the PLL is already HIGH, the
+	 * set function will return without doing anything
+	 */
+	hl_device_set_frequency(hdev, PLL_HIGH);
+
 	return 0;
 
 out_err:
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
new file mode 100644
index 000000000000..4d60b36dfa21
--- /dev/null
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+#define SENSORS_PKT_TIMEOUT		100000	/* 100ms */
+#define HWMON_NR_SENSOR_TYPES		(hwmon_pwm + 1)
+
+int hl_build_hwmon_channel_info(struct hl_device *hdev,
+				struct armcp_sensor *sensors_arr)
+{
+	u32 counts[HWMON_NR_SENSOR_TYPES] = {0};
+	u32 *sensors_by_type[HWMON_NR_SENSOR_TYPES] = {0};
+	u32 sensors_by_type_next_index[HWMON_NR_SENSOR_TYPES] = {0};
+	struct hwmon_channel_info **channels_info;
+	u32 num_sensors_for_type, num_active_sensor_types = 0,
+			arr_size = 0, *curr_arr;
+	enum hwmon_sensor_types type;
+	int rc, i, j;
+
+	for (i = 0 ; i < ARMCP_MAX_SENSORS ; i++) {
+		type = sensors_arr[i].type;
+
+		if ((type == 0) && (sensors_arr[i].flags == 0))
+			break;
+
+		if (type >= HWMON_NR_SENSOR_TYPES) {
+			dev_err(hdev->dev,
+				"Got wrong sensor type %d from device\n", type);
+			return -EINVAL;
+		}
+
+		counts[type]++;
+		arr_size++;
+	}
+
+	for (i = 0 ; i < HWMON_NR_SENSOR_TYPES ; i++) {
+		if (counts[i] == 0)
+			continue;
+
+		num_sensors_for_type = counts[i] + 1;
+		curr_arr = kcalloc(num_sensors_for_type, sizeof(*curr_arr),
+				GFP_KERNEL);
+		if (!curr_arr) {
+			rc = -ENOMEM;
+			goto sensors_type_err;
+		}
+
+		num_active_sensor_types++;
+		sensors_by_type[i] = curr_arr;
+	}
+
+	for (i = 0 ; i < arr_size ; i++) {
+		type = sensors_arr[i].type;
+		curr_arr = sensors_by_type[type];
+		curr_arr[sensors_by_type_next_index[type]++] =
+				sensors_arr[i].flags;
+	}
+
+	channels_info = kcalloc(num_active_sensor_types + 1,
+			sizeof(*channels_info), GFP_KERNEL);
+	if (!channels_info) {
+		rc = -ENOMEM;
+		goto channels_info_array_err;
+	}
+
+	for (i = 0 ; i < num_active_sensor_types ; i++) {
+		channels_info[i] = kzalloc(sizeof(*channels_info[i]),
+				GFP_KERNEL);
+		if (!channels_info[i]) {
+			rc = -ENOMEM;
+			goto channel_info_err;
+		}
+	}
+
+	for (i = 0, j = 0 ; i < HWMON_NR_SENSOR_TYPES ; i++) {
+		if (!sensors_by_type[i])
+			continue;
+
+		channels_info[j]->type = i;
+		channels_info[j]->config = sensors_by_type[i];
+		j++;
+	}
+
+	hdev->hl_chip_info.info =
+			(const struct hwmon_channel_info **)channels_info;
+
+	return 0;
+
+channel_info_err:
+	for (i = 0 ; i < num_active_sensor_types ; i++)
+		if (channels_info[i]) {
+			kfree(channels_info[i]->config);
+			kfree(channels_info[i]);
+		}
+	kfree(channels_info);
+channels_info_array_err:
+sensors_type_err:
+	for (i = 0 ; i < HWMON_NR_SENSOR_TYPES ; i++)
+		kfree(sensors_by_type[i]);
+
+	return rc;
+}
+
+static int hl_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_max:
+		case hwmon_temp_crit:
+		case hwmon_temp_max_hyst:
+		case hwmon_temp_crit_hyst:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		*val = hl_get_temperature(hdev, channel, attr);
+		break;
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+		case hwmon_in_min:
+		case hwmon_in_max:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		*val = hl_get_voltage(hdev, channel, attr);
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+		case hwmon_curr_min:
+		case hwmon_curr_max:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		*val = hl_get_current(hdev, channel, attr);
+		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+		case hwmon_fan_min:
+		case hwmon_fan_max:
+			break;
+		default:
+			return -EINVAL;
+		}
+		*val = hl_get_fan_speed(hdev, channel, attr);
+		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+		case hwmon_pwm_enable:
+			break;
+		default:
+			return -EINVAL;
+		}
+		*val = hl_get_pwm_info(hdev, channel, attr);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int hl_write(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long val)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+		case hwmon_pwm_enable:
+			break;
+		default:
+			return -EINVAL;
+		}
+		hl_set_pwm_info(hdev, channel, attr, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static umode_t hl_is_visible(const void *data, enum hwmon_sensor_types type,
+				u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_max:
+		case hwmon_temp_max_hyst:
+		case hwmon_temp_crit:
+		case hwmon_temp_crit_hyst:
+			return 0444;
+		}
+		break;
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+		case hwmon_in_min:
+		case hwmon_in_max:
+			return 0444;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+		case hwmon_curr_min:
+		case hwmon_curr_max:
+			return 0444;
+		}
+		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+		case hwmon_fan_min:
+		case hwmon_fan_max:
+			return 0444;
+		}
+		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+		case hwmon_pwm_enable:
+			return 0644;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_ops hl_hwmon_ops = {
+	.is_visible = hl_is_visible,
+	.read = hl_read,
+	.write = hl_write
+};
+
+long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr)
+{
+	struct armcp_packet pkt;
+	long result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_TEMPERATURE_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.sensor_index = sensor_index;
+	pkt.type = attr;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+			SENSORS_PKT_TIMEOUT, &result);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to get temperature from sensor %d, error %d\n",
+			sensor_index, rc);
+		result = 0;
+	}
+
+	return result;
+}
+
+long hl_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr)
+{
+	struct armcp_packet pkt;
+	long result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_VOLTAGE_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.sensor_index = sensor_index;
+	pkt.type = attr;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					SENSORS_PKT_TIMEOUT, &result);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to get voltage from sensor %d, error %d\n",
+			sensor_index, rc);
+		result = 0;
+	}
+
+	return result;
+}
+
+long hl_get_current(struct hl_device *hdev, int sensor_index, u32 attr)
+{
+	struct armcp_packet pkt;
+	long result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_CURRENT_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.sensor_index = sensor_index;
+	pkt.type = attr;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					SENSORS_PKT_TIMEOUT, &result);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to get current from sensor %d, error %d\n",
+			sensor_index, rc);
+		result = 0;
+	}
+
+	return result;
+}
+
+long hl_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr)
+{
+	struct armcp_packet pkt;
+	long result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_FAN_SPEED_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.sensor_index = sensor_index;
+	pkt.type = attr;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					SENSORS_PKT_TIMEOUT, &result);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to get fan speed from sensor %d, error %d\n",
+			sensor_index, rc);
+		result = 0;
+	}
+
+	return result;
+}
+
+long hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr)
+{
+	struct armcp_packet pkt;
+	long result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_PWM_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.sensor_index = sensor_index;
+	pkt.type = attr;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					SENSORS_PKT_TIMEOUT, &result);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to get pwm info from sensor %d, error %d\n",
+			sensor_index, rc);
+		result = 0;
+	}
+
+	return result;
+}
+
+void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
+			long value)
+{
+	struct armcp_packet pkt;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_PWM_SET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.sensor_index = sensor_index;
+	pkt.type = attr;
+	pkt.value = value;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					SENSORS_PKT_TIMEOUT, NULL);
+
+	if (rc)
+		dev_err(hdev->dev,
+			"Failed to set pwm info to sensor %d, error %d\n",
+			sensor_index, rc);
+}
+
+int hl_hwmon_init(struct hl_device *hdev)
+{
+	struct device *dev = hdev->pdev ? &hdev->pdev->dev : hdev->dev;
+	int rc;
+
+	if ((hdev->hwmon_initialized) || !(hdev->fw_loading))
+		return 0;
+
+	if (hdev->hl_chip_info.info) {
+		hdev->hl_chip_info.ops = &hl_hwmon_ops;
+
+		hdev->hwmon_dev = hwmon_device_register_with_info(dev,
+				"habanalabs", hdev, &hdev->hl_chip_info, NULL);
+		if (IS_ERR(hdev->hwmon_dev)) {
+			rc = PTR_ERR(hdev->hwmon_dev);
+			dev_err(hdev->dev,
+				"Unable to register hwmon device: %d\n", rc);
+			return rc;
+		}
+
+		dev_info(hdev->dev, "%s: add sensors information\n",
+			dev_name(hdev->hwmon_dev));
+
+		hdev->hwmon_initialized = true;
+	} else {
+		dev_info(hdev->dev, "no available sensors\n");
+	}
+
+	return 0;
+}
+
+void hl_hwmon_fini(struct hl_device *hdev)
+{
+	if (!hdev->hwmon_initialized)
+		return;
+
+	hwmon_device_unregister(hdev->hwmon_dev);
+}
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
new file mode 100644
index 000000000000..c5b90f338b4d
--- /dev/null
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -0,0 +1,589 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+
+#define SET_CLK_PKT_TIMEOUT	200000	/* 200ms */
+#define SET_PWR_PKT_TIMEOUT	400000	/* 400ms */
+
+long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
+{
+	struct armcp_packet pkt;
+	long result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	if (curr)
+		pkt.ctl = ARMCP_PACKET_FREQUENCY_CURR_GET <<
+						ARMCP_PKT_CTL_OPCODE_SHIFT;
+	else
+		pkt.ctl = ARMCP_PACKET_FREQUENCY_GET <<
+						ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.pll_index = pll_index;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+						SET_CLK_PKT_TIMEOUT, &result);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to get frequency of PLL %d, error %d\n",
+			pll_index, rc);
+		result = rc;
+	}
+
+	return result;
+}
+
+void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
+{
+	struct armcp_packet pkt;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_FREQUENCY_SET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.pll_index = pll_index;
+	pkt.value = freq;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					SET_CLK_PKT_TIMEOUT, NULL);
+
+	if (rc)
+		dev_err(hdev->dev,
+			"Failed to set frequency to PLL %d, error %d\n",
+			pll_index, rc);
+}
+
+u64 hl_get_max_power(struct hl_device *hdev)
+{
+	struct armcp_packet pkt;
+	long result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_MAX_POWER_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+						SET_PWR_PKT_TIMEOUT, &result);
+
+	if (rc) {
+		dev_err(hdev->dev, "Failed to get max power, error %d\n", rc);
+		result = rc;
+	}
+
+	return result;
+}
+
+void hl_set_max_power(struct hl_device *hdev, u64 value)
+{
+	struct armcp_packet pkt;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_MAX_POWER_SET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.value = value;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					SET_PWR_PKT_TIMEOUT, NULL);
+
+	if (rc)
+		dev_err(hdev->dev, "Failed to set max power, error %d\n", rc);
+}
+
+static ssize_t pm_mng_profile_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			(hdev->pm_mng_profile == PM_AUTO) ? "auto" :
+			(hdev->pm_mng_profile == PM_MANUAL) ? "manual" :
+			"unknown");
+}
+
+static ssize_t pm_mng_profile_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	if (hdev->disabled) {
+		count = -ENODEV;
+		goto out;
+	}
+
+	mutex_lock(&hdev->fd_open_cnt_lock);
+
+	if (atomic_read(&hdev->fd_open_cnt) > 0) {
+		dev_err(hdev->dev,
+			"Can't change PM profile while user process is opened on the device\n");
+		count = -EPERM;
+		goto unlock_mutex;
+	}
+
+	if (strncmp("auto", buf, strlen("auto")) == 0) {
+		/* Make sure we are in LOW PLL when changing modes */
+		if (hdev->pm_mng_profile == PM_MANUAL) {
+			atomic_set(&hdev->curr_pll_profile, PLL_HIGH);
+			hl_device_set_frequency(hdev, PLL_LOW);
+			hdev->pm_mng_profile = PM_AUTO;
+		}
+	} else if (strncmp("manual", buf, strlen("manual")) == 0) {
+		/* Make sure we are in LOW PLL when changing modes */
+		if (hdev->pm_mng_profile == PM_AUTO) {
+			flush_delayed_work(&hdev->work_freq);
+			hdev->pm_mng_profile = PM_MANUAL;
+		}
+	} else {
+		dev_err(hdev->dev, "value should be auto or manual\n");
+		count = -EINVAL;
+		goto unlock_mutex;
+	}
+
+unlock_mutex:
+	mutex_unlock(&hdev->fd_open_cnt_lock);
+out:
+	return count;
+}
+
+static ssize_t high_pll_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", hdev->high_pll);
+}
+
+static ssize_t high_pll_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+	int rc;
+
+	if (hdev->disabled) {
+		count = -ENODEV;
+		goto out;
+	}
+
+	rc = kstrtoul(buf, 0, &value);
+
+	if (rc) {
+		count = -EINVAL;
+		goto out;
+	}
+
+	hdev->high_pll = value;
+
+out:
+	return count;
+}
+
+static ssize_t uboot_ver_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", hdev->asic_prop.uboot_ver);
+}
+
+static ssize_t armcp_kernel_ver_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s",
+			hdev->asic_prop.armcp_info.kernel_version);
+}
+
+static ssize_t armcp_ver_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			hdev->asic_prop.armcp_info.armcp_version);
+}
+
+static ssize_t cpld_ver_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n",
+			hdev->asic_prop.armcp_info.cpld_version);
+}
+
+static ssize_t infineon_ver_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n",
+			hdev->asic_prop.armcp_info.infineon_version);
+}
+
+static ssize_t fuse_ver_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			hdev->asic_prop.armcp_info.fuse_version);
+}
+
+static ssize_t thermal_ver_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s",
+			hdev->asic_prop.armcp_info.thermal_version);
+}
+
+static ssize_t preboot_btl_ver_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", hdev->asic_prop.preboot_ver);
+}
+
+static ssize_t device_type_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	char *str;
+
+	switch (hdev->asic_type) {
+	case ASIC_GOYA:
+		str = "GOYA";
+		break;
+	default:
+		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
+				hdev->asic_type);
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", str);
+}
+
+static ssize_t pci_addr_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	/* Use dummy, fixed address for simulator */
+	if (!hdev->pdev)
+		return snprintf(buf, PAGE_SIZE, "0000:%02d:00.0\n", hdev->id);
+
+	return snprintf(buf, PAGE_SIZE, "%04x:%02x:%02x.%x\n",
+			pci_domain_nr(hdev->pdev->bus),
+			hdev->pdev->bus->number,
+			PCI_SLOT(hdev->pdev->devfn),
+			PCI_FUNC(hdev->pdev->devfn));
+}
+
+static ssize_t status_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	char *str;
+
+	if (hdev->disabled)
+		str = "Malfunction";
+	else
+		str = "Operational";
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", str);
+}
+
+static ssize_t write_open_cnt_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", hdev->user_ctx ? 1 : 0);
+}
+
+static ssize_t max_power_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long val;
+
+	if (hdev->disabled)
+		return -ENODEV;
+
+	val = hl_get_max_power(hdev);
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", val);
+}
+
+static ssize_t max_power_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	unsigned long value;
+	int rc;
+
+	if (hdev->disabled) {
+		count = -ENODEV;
+		goto out;
+	}
+
+	rc = kstrtoul(buf, 0, &value);
+
+	if (rc) {
+		count = -EINVAL;
+		goto out;
+	}
+
+	hdev->max_power = value;
+	hl_set_max_power(hdev, value);
+
+out:
+	return count;
+}
+
+static ssize_t eeprom_read_handler(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *attr, char *buf, loff_t offset,
+			size_t max_size)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	char *data;
+	int rc;
+
+	if (!max_size)
+		return -EINVAL;
+
+	data = kzalloc(max_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	rc = hdev->asic_funcs->get_eeprom_data(hdev, data, max_size);
+	if (rc)
+		goto out;
+
+	memcpy(buf, data, max_size);
+
+out:
+	kfree(data);
+
+	return max_size;
+}
+
+static DEVICE_ATTR_RW(pm_mng_profile);
+static DEVICE_ATTR_RW(high_pll);
+static DEVICE_ATTR_RO(uboot_ver);
+static DEVICE_ATTR_RO(armcp_kernel_ver);
+static DEVICE_ATTR_RO(armcp_ver);
+static DEVICE_ATTR_RO(cpld_ver);
+static DEVICE_ATTR_RO(infineon_ver);
+static DEVICE_ATTR_RO(fuse_ver);
+static DEVICE_ATTR_RO(thermal_ver);
+static DEVICE_ATTR_RO(preboot_btl_ver);
+static DEVICE_ATTR_RO(device_type);
+static DEVICE_ATTR_RO(pci_addr);
+static DEVICE_ATTR_RO(status);
+static DEVICE_ATTR_RO(write_open_cnt);
+static DEVICE_ATTR_RW(max_power);
+
+static const struct bin_attribute bin_attr_eeprom = {
+	.attr = {.name = "eeprom", .mode = (0444)},
+	.size = PAGE_SIZE,
+	.read = eeprom_read_handler
+};
+
+int hl_sysfs_init(struct hl_device *hdev)
+{
+	int rc;
+
+	rc = hdev->asic_funcs->add_device_attr(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "failed to add device attributes\n");
+		return rc;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_pm_mng_profile);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file pm_mng_profile\n");
+		goto remove_device_attr;
+	}
+
+	hdev->pm_mng_profile = PM_AUTO;
+
+	rc = device_create_file(hdev->dev, &dev_attr_high_pll);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file pll_profile\n");
+		goto remove_pm_mng_profile;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_uboot_ver);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file uboot_ver\n");
+		goto remove_pll_profile;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_armcp_kernel_ver);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file armcp_kernel_ver\n");
+		goto remove_uboot_ver;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_armcp_ver);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file armcp_ver\n");
+		goto remove_armcp_kernel_ver;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_cpld_ver);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file cpld_ver\n");
+		goto remove_armcp_ver;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_infineon_ver);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file infineon_ver\n");
+		goto remove_cpld_ver;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_fuse_ver);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file fuse_ver\n");
+		goto remove_infineon_ver;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_thermal_ver);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file thermal_ver\n");
+		goto remove_fuse_ver;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_preboot_btl_ver);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file preboot_btl_ver\n");
+		goto remove_thermal_ver;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_device_type);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file device_type\n");
+		goto remove_preboot_ver;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_pci_addr);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file pci_addr\n");
+		goto remove_device_type;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_status);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file status\n");
+		goto remove_pci_addr;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_write_open_cnt);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file write_open_count\n");
+		goto remove_status;
+	}
+
+	hdev->max_power = hdev->asic_prop.max_power_default;
+
+	rc = device_create_file(hdev->dev, &dev_attr_max_power);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file max_power\n");
+		goto remove_write_open_cnt;
+	}
+
+	rc = sysfs_create_bin_file(&hdev->dev->kobj, &bin_attr_eeprom);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create EEPROM sysfs entry\n");
+		goto remove_attr_max_power;
+	}
+
+	return 0;
+
+remove_attr_max_power:
+	device_remove_file(hdev->dev, &dev_attr_max_power);
+remove_write_open_cnt:
+	device_remove_file(hdev->dev, &dev_attr_write_open_cnt);
+remove_status:
+	device_remove_file(hdev->dev, &dev_attr_status);
+remove_pci_addr:
+	device_remove_file(hdev->dev, &dev_attr_pci_addr);
+remove_device_type:
+	device_remove_file(hdev->dev, &dev_attr_device_type);
+remove_preboot_ver:
+	device_remove_file(hdev->dev, &dev_attr_preboot_btl_ver);
+remove_thermal_ver:
+	device_remove_file(hdev->dev, &dev_attr_thermal_ver);
+remove_fuse_ver:
+	device_remove_file(hdev->dev, &dev_attr_fuse_ver);
+remove_infineon_ver:
+	device_remove_file(hdev->dev, &dev_attr_infineon_ver);
+remove_cpld_ver:
+	device_remove_file(hdev->dev, &dev_attr_cpld_ver);
+remove_armcp_ver:
+	device_remove_file(hdev->dev, &dev_attr_armcp_ver);
+remove_armcp_kernel_ver:
+	device_remove_file(hdev->dev, &dev_attr_armcp_kernel_ver);
+remove_uboot_ver:
+	device_remove_file(hdev->dev, &dev_attr_uboot_ver);
+remove_pll_profile:
+	device_remove_file(hdev->dev, &dev_attr_high_pll);
+remove_pm_mng_profile:
+	device_remove_file(hdev->dev, &dev_attr_pm_mng_profile);
+remove_device_attr:
+	hdev->asic_funcs->remove_device_attr(hdev);
+
+	return rc;
+}
+
+void hl_sysfs_fini(struct hl_device *hdev)
+{
+	sysfs_remove_bin_file(&hdev->dev->kobj, &bin_attr_eeprom);
+	device_remove_file(hdev->dev, &dev_attr_max_power);
+	device_remove_file(hdev->dev, &dev_attr_write_open_cnt);
+	device_remove_file(hdev->dev, &dev_attr_status);
+	device_remove_file(hdev->dev, &dev_attr_pci_addr);
+	device_remove_file(hdev->dev, &dev_attr_device_type);
+	device_remove_file(hdev->dev, &dev_attr_preboot_btl_ver);
+	device_remove_file(hdev->dev, &dev_attr_thermal_ver);
+	device_remove_file(hdev->dev, &dev_attr_fuse_ver);
+	device_remove_file(hdev->dev, &dev_attr_infineon_ver);
+	device_remove_file(hdev->dev, &dev_attr_cpld_ver);
+	device_remove_file(hdev->dev, &dev_attr_armcp_ver);
+	device_remove_file(hdev->dev, &dev_attr_armcp_kernel_ver);
+	device_remove_file(hdev->dev, &dev_attr_uboot_ver);
+	device_remove_file(hdev->dev, &dev_attr_high_pll);
+	device_remove_file(hdev->dev, &dev_attr_pm_mng_profile);
+	hdev->asic_funcs->remove_device_attr(hdev);
+}
-- 
2.17.1


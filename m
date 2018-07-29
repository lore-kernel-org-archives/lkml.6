Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70447C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AC420857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqzTq+Y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AC420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeG2VIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33454 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbeG2VIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so6037711pgv.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VapyDsrpZffL8kM/wYM1X6PZYnq90RUNGjk4cQ88fPU=;
        b=BqzTq+Y2QZ+KvGYAdPfa6byWpLHh4Gpw8kPVDx1/C/6PXhzl256qnB8e/f3NoptRqb
         sxK2yh0Iv5D3ugfAz6gygZdR+/QDNy+kHdIHGiU0CTkO2gRcAlgRdn7pZ0yzXRmixqI1
         WdgNQyjTzCwHpBmRdAGcdL4wfUbQH7qvBG8Zp7lLpHmyWLZHuHEUl+ezMSLofy+QTkbX
         zKcQU8Z+h4jxeLCI3Vgw705ykYfp9t24cq56fzszglkFsjbduJokobEIXHAZ4P+W0amW
         SqaVuQIYNySyJJ/rX4h61G5Bch73Y5/Wg2ZLiMl/RHNIlbcc9aIwtvbR0cy1pl363dNz
         x52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VapyDsrpZffL8kM/wYM1X6PZYnq90RUNGjk4cQ88fPU=;
        b=c/SsXEn8mA7ei/FV6867NZDklPTzUmcyPc7CBIp8QNuVpCrX3nU/380czsXX3ywcGm
         hWqgRSs12FratKrIpYaEuZzeGhAnMVuaQSZh+r+QlDcja6bS7XXc2CDXCuI6Rkoz7pzT
         BzsCy1RyF7GCdGwFryL0HhPHvgxkOJt9sGlpsksgtP9cuvsszOtKzWqMJhKgj5UEegBl
         mEVGQ7hyTc8axEhzY0XaTg8bUuS5AiknVJqJ9FTAn+Id0VM47XmQYQEDr/RwlmFrlxgV
         G9wkxoMF674mpHuU8+O7AZlceDs8iA8UYk+lbCoSipIib3QPRf0aOeIReu/bQXBjG8aQ
         qyzw==
X-Gm-Message-State: AOUpUlGoJag/xlH2u7Q+sArDHDNmnBuxvSQFMvzhYlBXYiPDP30wLhC3
        2qF1CJaqVCdzEMBN6TtljnY=
X-Google-Smtp-Source: AAOMgpcRzL513+rCSO91sUx139QqXEHCHgOV44ojrs256vW1O3PwgcUyGsnqZUd+SJoOjwGpcvclmA==
X-Received: by 2002:a65:48cd:: with SMTP id o13-v6mr13264059pgs.99.1532893029155;
        Sun, 29 Jul 2018 12:37:09 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:37:08 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 12/13] staging: gasket: apex: remove static function forward declarations
Date:   Sun, 29 Jul 2018 12:36:45 -0700
Message-Id: <20180729193646.201721-13-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove forward declarations of static functions, move code to avoid
forward references, for kernel style.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 416 ++++++++++++---------------
 1 file changed, 190 insertions(+), 226 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index a756764751777..f70fea0d80ecf 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -123,55 +123,6 @@ static struct gasket_page_table_config apex_page_table_configs[NUM_NODES] = {
 	},
 };
 
-/* Function declarations */
-static int __init apex_init(void);
-static void apex_exit(void);
-
-static int apex_add_dev_cb(struct gasket_dev *gasket_dev);
-
-static int apex_sysfs_setup_cb(struct gasket_dev *gasket_dev);
-
-static int apex_device_cleanup(struct gasket_dev *gasket_dev);
-
-static int apex_device_open_cb(struct gasket_dev *gasket_dev);
-
-static ssize_t sysfs_show(
-	struct device *device, struct device_attribute *attr, char *buf);
-
-static int apex_reset(struct gasket_dev *gasket_dev, uint type);
-
-static int apex_get_status(struct gasket_dev *gasket_dev);
-
-static bool apex_ioctl_check_permissions(struct file *file, uint cmd);
-
-static long apex_ioctl(struct file *file, uint cmd, void __user *argp);
-
-static long apex_clock_gating(struct gasket_dev *gasket_dev,
-			      struct apex_gate_clock_ioctl __user *argp);
-
-static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type);
-
-static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type);
-
-static bool is_gcb_in_reset(struct gasket_dev *gasket_dev);
-
-/* Data definitions */
-
-/* The data necessary to display this file's sysfs entries. */
-static struct gasket_sysfs_attribute apex_sysfs_attrs[] = {
-	GASKET_SYSFS_RO(node_0_page_table_entries, sysfs_show,
-			ATTR_KERNEL_HIB_PAGE_TABLE_SIZE),
-	GASKET_SYSFS_RO(node_0_simple_page_table_entries, sysfs_show,
-			ATTR_KERNEL_HIB_SIMPLE_PAGE_TABLE_SIZE),
-	GASKET_SYSFS_RO(node_0_num_mapped_pages, sysfs_show,
-			ATTR_KERNEL_HIB_NUM_ACTIVE_PAGES),
-	GASKET_END_OF_ATTR_ARRAY
-};
-
-static const struct pci_device_id apex_pci_ids[] = {
-	{ PCI_DEVICE(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID) }, { 0 }
-};
-
 /* The regions in the BAR2 space that can be mapped into user space. */
 static const struct gasket_mappable_region mappable_regions[NUM_REGIONS] = {
 	{ 0x40000, 0x1000 },
@@ -251,65 +202,6 @@ static struct gasket_interrupt_desc apex_interrupts[] = {
 	},
 };
 
-static struct gasket_driver_desc apex_desc = {
-	.name = "apex",
-	.driver_version = APEX_DRIVER_VERSION,
-	.major = 120,
-	.minor = 0,
-	.module = THIS_MODULE,
-	.pci_id_table = apex_pci_ids,
-
-	.num_page_tables = NUM_NODES,
-	.page_table_bar_index = APEX_BAR_INDEX,
-	.page_table_configs = apex_page_table_configs,
-	.page_table_extended_bit = APEX_EXTENDED_SHIFT,
-
-	.bar_descriptions = {
-		GASKET_UNUSED_BAR,
-		GASKET_UNUSED_BAR,
-		{ APEX_BAR_BYTES, (VM_WRITE | VM_READ), APEX_BAR_OFFSET,
-			NUM_REGIONS, mappable_regions, PCI_BAR },
-		GASKET_UNUSED_BAR,
-		GASKET_UNUSED_BAR,
-		GASKET_UNUSED_BAR,
-	},
-	.coherent_buffer_description = {
-		APEX_CH_MEM_BYTES,
-		(VM_WRITE | VM_READ),
-		APEX_CM_OFFSET,
-	},
-	.interrupt_type = PCI_MSIX,
-	.interrupt_bar_index = APEX_BAR_INDEX,
-	.num_interrupts = APEX_INTERRUPT_COUNT,
-	.interrupts = apex_interrupts,
-	.interrupt_pack_width = 7,
-
-	.add_dev_cb = apex_add_dev_cb,
-	.remove_dev_cb = NULL,
-
-	.enable_dev_cb = NULL,
-	.disable_dev_cb = NULL,
-
-	.sysfs_setup_cb = apex_sysfs_setup_cb,
-	.sysfs_cleanup_cb = NULL,
-
-	.device_open_cb = apex_device_open_cb,
-	.device_close_cb = apex_device_cleanup,
-
-	.ioctl_handler_cb = apex_ioctl,
-	.device_status_cb = apex_get_status,
-	.hardware_revision_cb = NULL,
-	.device_reset_cb = apex_reset,
-};
-
-/* Module registration boilerplate */
-MODULE_DESCRIPTION("Google Apex driver");
-MODULE_VERSION(APEX_DRIVER_VERSION);
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("John Joseph <jnjoseph@google.com>");
-MODULE_DEVICE_TABLE(pci, apex_pci_ids);
-module_init(apex_init);
-module_exit(apex_exit);
 
 /* Allows device to enter power save upon driver close(). */
 static int allow_power_save;
@@ -329,61 +221,6 @@ module_param(allow_sw_clock_gating, int, 0644);
 module_param(allow_hw_clock_gating, int, 0644);
 module_param(bypass_top_level, int, 0644);
 
-static int __init apex_init(void)
-{
-	return gasket_register_device(&apex_desc);
-}
-
-static void apex_exit(void)
-{
-	gasket_unregister_device(&apex_desc);
-}
-
-static int apex_add_dev_cb(struct gasket_dev *gasket_dev)
-{
-	ulong page_table_ready, msix_table_ready;
-	int retries = 0;
-
-	apex_reset(gasket_dev, 0);
-
-	while (retries < APEX_RESET_RETRY) {
-		page_table_ready =
-			gasket_dev_read_64(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT);
-		msix_table_ready =
-			gasket_dev_read_64(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT);
-		if (page_table_ready && msix_table_ready)
-			break;
-		schedule_timeout(msecs_to_jiffies(APEX_RESET_DELAY));
-		retries++;
-	}
-
-	if (retries == APEX_RESET_RETRY) {
-		if (!page_table_ready)
-			dev_err(gasket_dev->dev, "Page table init timed out\n");
-		if (!msix_table_ready)
-			dev_err(gasket_dev->dev, "MSI-X table init timed out\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
-static int apex_sysfs_setup_cb(struct gasket_dev *gasket_dev)
-{
-	return gasket_sysfs_create_entries(
-		gasket_dev->dev_info.device, apex_sysfs_attrs);
-}
-
-/* On device open, perform a core reinit reset. */
-static int apex_device_open_cb(struct gasket_dev *gasket_dev)
-{
-	return gasket_reset_nolock(gasket_dev, APEX_CHIP_REINIT_RESET);
-}
-
 /* Check the device status registers and return device status ALIVE or DEAD. */
 static int apex_get_status(struct gasket_dev *gasket_dev)
 {
@@ -391,53 +228,6 @@ static int apex_get_status(struct gasket_dev *gasket_dev)
 	return GASKET_STATUS_ALIVE;
 }
 
-/* Reset the Apex hardware. Called on final close via device_close_cb. */
-static int apex_device_cleanup(struct gasket_dev *gasket_dev)
-{
-	u64 scalar_error;
-	u64 hib_error;
-	int ret = 0;
-
-	hib_error = gasket_dev_read_64(
-		gasket_dev, APEX_BAR_INDEX,
-		APEX_BAR2_REG_USER_HIB_ERROR_STATUS);
-	scalar_error = gasket_dev_read_64(
-		gasket_dev, APEX_BAR_INDEX,
-		APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
-
-	dev_dbg(gasket_dev->dev,
-		"%s 0x%p hib_error 0x%llx scalar_error 0x%llx\n",
-		__func__, gasket_dev, hib_error, scalar_error);
-
-	if (allow_power_save)
-		ret = apex_enter_reset(gasket_dev, APEX_CHIP_REINIT_RESET);
-
-	return ret;
-}
-
-/* Reset the hardware, then quit reset.  Called on device open. */
-static int apex_reset(struct gasket_dev *gasket_dev, uint type)
-{
-	int ret;
-
-	if (bypass_top_level)
-		return 0;
-
-	if (!is_gcb_in_reset(gasket_dev)) {
-		/* We are not in reset - toggle the reset bit so as to force
-		 * re-init of custom block
-		 */
-		dev_dbg(gasket_dev->dev, "%s: toggle reset\n", __func__);
-
-		ret = apex_enter_reset(gasket_dev, type);
-		if (ret)
-			return ret;
-	}
-	ret = apex_quit_reset(gasket_dev, type);
-
-	return ret;
-}
-
 /* Enter GCB reset state. */
 static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 {
@@ -576,6 +366,30 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 	return 0;
 }
 
+/* Reset the Apex hardware. Called on final close via device_close_cb. */
+static int apex_device_cleanup(struct gasket_dev *gasket_dev)
+{
+	u64 scalar_error;
+	u64 hib_error;
+	int ret = 0;
+
+	hib_error = gasket_dev_read_64(
+		gasket_dev, APEX_BAR_INDEX,
+		APEX_BAR2_REG_USER_HIB_ERROR_STATUS);
+	scalar_error = gasket_dev_read_64(
+		gasket_dev, APEX_BAR_INDEX,
+		APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
+
+	dev_dbg(gasket_dev->dev,
+		"%s 0x%p hib_error 0x%llx scalar_error 0x%llx\n",
+		__func__, gasket_dev, hib_error, scalar_error);
+
+	if (allow_power_save)
+		ret = apex_enter_reset(gasket_dev, APEX_CHIP_REINIT_RESET);
+
+	return ret;
+}
+
 /* Determine if GCB is in reset state. */
 static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
 {
@@ -586,29 +400,69 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
 	return (val & SCU3_CUR_RST_GCB_BIT_MASK);
 }
 
-/*
- * Check permissions for Apex ioctls.
- * Returns true if the current user may execute this ioctl, and false otherwise.
- */
-static bool apex_ioctl_check_permissions(struct file *filp, uint cmd)
+/* Reset the hardware, then quit reset.  Called on device open. */
+static int apex_reset(struct gasket_dev *gasket_dev, uint type)
 {
-	return !!(filp->f_mode & FMODE_WRITE);
+	int ret;
+
+	if (bypass_top_level)
+		return 0;
+
+	if (!is_gcb_in_reset(gasket_dev)) {
+		/* We are not in reset - toggle the reset bit so as to force
+		 * re-init of custom block
+		 */
+		dev_dbg(gasket_dev->dev, "%s: toggle reset\n", __func__);
+
+		ret = apex_enter_reset(gasket_dev, type);
+		if (ret)
+			return ret;
+	}
+	ret = apex_quit_reset(gasket_dev, type);
+
+	return ret;
 }
 
-/* Apex-specific ioctl handler. */
-static long apex_ioctl(struct file *filp, uint cmd, void __user *argp)
+static int apex_add_dev_cb(struct gasket_dev *gasket_dev)
 {
-	struct gasket_dev *gasket_dev = filp->private_data;
+	ulong page_table_ready, msix_table_ready;
+	int retries = 0;
 
-	if (!apex_ioctl_check_permissions(filp, cmd))
-		return -EPERM;
+	apex_reset(gasket_dev, 0);
 
-	switch (cmd) {
-	case APEX_IOCTL_GATE_CLOCK:
-		return apex_clock_gating(gasket_dev, argp);
-	default:
-		return -ENOTTY; /* unknown command */
+	while (retries < APEX_RESET_RETRY) {
+		page_table_ready =
+			gasket_dev_read_64(
+				gasket_dev, APEX_BAR_INDEX,
+				APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT);
+		msix_table_ready =
+			gasket_dev_read_64(
+				gasket_dev, APEX_BAR_INDEX,
+				APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT);
+		if (page_table_ready && msix_table_ready)
+			break;
+		schedule_timeout(msecs_to_jiffies(APEX_RESET_DELAY));
+		retries++;
 	}
+
+	if (retries == APEX_RESET_RETRY) {
+		if (!page_table_ready)
+			dev_err(gasket_dev->dev, "Page table init timed out\n");
+		if (!msix_table_ready)
+			dev_err(gasket_dev->dev, "MSI-X table init timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/*
+ * Check permissions for Apex ioctls.
+ * Returns true if the current user may execute this ioctl, and false otherwise.
+ */
+static bool apex_ioctl_check_permissions(struct file *filp, uint cmd)
+{
+	return !!(filp->f_mode & FMODE_WRITE);
 }
 
 /* Gates or un-gates Apex clock. */
@@ -645,6 +499,22 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev,
 	return 0;
 }
 
+/* Apex-specific ioctl handler. */
+static long apex_ioctl(struct file *filp, uint cmd, void __user *argp)
+{
+	struct gasket_dev *gasket_dev = filp->private_data;
+
+	if (!apex_ioctl_check_permissions(filp, cmd))
+		return -EPERM;
+
+	switch (cmd) {
+	case APEX_IOCTL_GATE_CLOCK:
+		return apex_clock_gating(gasket_dev, argp);
+	default:
+		return -ENOTTY; /* unknown command */
+	}
+}
+
 /* Display driver sysfs entries. */
 static ssize_t sysfs_show(
 	struct device *device, struct device_attribute *attr, char *buf)
@@ -696,9 +566,103 @@ static ssize_t sysfs_show(
 	return ret;
 }
 
+static struct gasket_sysfs_attribute apex_sysfs_attrs[] = {
+	GASKET_SYSFS_RO(node_0_page_table_entries, sysfs_show,
+			ATTR_KERNEL_HIB_PAGE_TABLE_SIZE),
+	GASKET_SYSFS_RO(node_0_simple_page_table_entries, sysfs_show,
+			ATTR_KERNEL_HIB_SIMPLE_PAGE_TABLE_SIZE),
+	GASKET_SYSFS_RO(node_0_num_mapped_pages, sysfs_show,
+			ATTR_KERNEL_HIB_NUM_ACTIVE_PAGES),
+	GASKET_END_OF_ATTR_ARRAY
+};
+
+static int apex_sysfs_setup_cb(struct gasket_dev *gasket_dev)
+{
+	return gasket_sysfs_create_entries(
+		gasket_dev->dev_info.device, apex_sysfs_attrs);
+}
+
+/* On device open, perform a core reinit reset. */
+static int apex_device_open_cb(struct gasket_dev *gasket_dev)
+{
+	return gasket_reset_nolock(gasket_dev, APEX_CHIP_REINIT_RESET);
+}
+
+static const struct pci_device_id apex_pci_ids[] = {
+	{ PCI_DEVICE(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID) }, { 0 }
+};
+
 static void apex_pci_fixup_class(struct pci_dev *pdev)
 {
 	pdev->class = (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+static struct gasket_driver_desc apex_desc = {
+	.name = "apex",
+	.driver_version = APEX_DRIVER_VERSION,
+	.major = 120,
+	.minor = 0,
+	.module = THIS_MODULE,
+	.pci_id_table = apex_pci_ids,
+
+	.num_page_tables = NUM_NODES,
+	.page_table_bar_index = APEX_BAR_INDEX,
+	.page_table_configs = apex_page_table_configs,
+	.page_table_extended_bit = APEX_EXTENDED_SHIFT,
+
+	.bar_descriptions = {
+		GASKET_UNUSED_BAR,
+		GASKET_UNUSED_BAR,
+		{ APEX_BAR_BYTES, (VM_WRITE | VM_READ), APEX_BAR_OFFSET,
+			NUM_REGIONS, mappable_regions, PCI_BAR },
+		GASKET_UNUSED_BAR,
+		GASKET_UNUSED_BAR,
+		GASKET_UNUSED_BAR,
+	},
+	.coherent_buffer_description = {
+		APEX_CH_MEM_BYTES,
+		(VM_WRITE | VM_READ),
+		APEX_CM_OFFSET,
+	},
+	.interrupt_type = PCI_MSIX,
+	.interrupt_bar_index = APEX_BAR_INDEX,
+	.num_interrupts = APEX_INTERRUPT_COUNT,
+	.interrupts = apex_interrupts,
+	.interrupt_pack_width = 7,
+
+	.add_dev_cb = apex_add_dev_cb,
+	.remove_dev_cb = NULL,
+
+	.enable_dev_cb = NULL,
+	.disable_dev_cb = NULL,
+
+	.sysfs_setup_cb = apex_sysfs_setup_cb,
+	.sysfs_cleanup_cb = NULL,
+
+	.device_open_cb = apex_device_open_cb,
+	.device_close_cb = apex_device_cleanup,
+
+	.ioctl_handler_cb = apex_ioctl,
+	.device_status_cb = apex_get_status,
+	.hardware_revision_cb = NULL,
+	.device_reset_cb = apex_reset,
+};
+
+static int __init apex_init(void)
+{
+	return gasket_register_device(&apex_desc);
+}
+
+static void apex_exit(void)
+{
+	gasket_unregister_device(&apex_desc);
+}
+MODULE_DESCRIPTION("Google Apex driver");
+MODULE_VERSION(APEX_DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("John Joseph <jnjoseph@google.com>");
+MODULE_DEVICE_TABLE(pci, apex_pci_ids);
+module_init(apex_init);
+module_exit(apex_exit);
-- 
2.18.0.345.g5c9ce644c3-goog


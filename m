Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF16222DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwyAZjQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394018AbfBOWkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:40:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36192 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393985AbfBOWj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:39:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so11929217wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 14:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tpANLnLS6S5lbqQJRoJsQkRpsIoFETbAbJEDtXCnRko=;
        b=VwyAZjQhTPeAl8bomB2rv/kW54wA9EsaVg8AJA4XgA6nuGOugONu0syh0O0FymUvwq
         fyFfDjuwNxYF/nZNEqTgJUJEr+YrchPNo463J+lnjZw9gmwU0TEFMg+RPEDJhrInVNnM
         MoVZrD1bow9QlmKRmlbiBe+t58KGRYgaA5Qovqot76i/p7XspsEYidLLFMbG6KWwOzUs
         eKyZRC0n4kLjqlxbvFuHsNbuZwQIPAPiYdmTyPwc9+/6zpSFqeGqtq7P0Zv8Ovp8Seeg
         8hWWjsWelneiQ5DGHEE4PguTwqRGljgCxVKmbclyI8v75KK+/n3pF1CmsxdlPEkKkKRA
         wC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tpANLnLS6S5lbqQJRoJsQkRpsIoFETbAbJEDtXCnRko=;
        b=fagyn4+YJkXuo9unvnJyqpzddIPOLiD+7QB2jT+7CUs1pkUgSof4Sw0pvUvI8muzMA
         pigZS9VL/DNHyIdRY2yK//ydIlcxHxpOs0Cz+3ctDmawOO1T+hbsAnlFrXiHFyhqR8CU
         YCdS6hGSmXkrn+s//6ZHOyhkKpnC4s3D5YePF6MiQrupvfqAXqSj3cN51LjroO2qUysk
         Rqtmd06vHJuAeDrkTCR/l/4OiX6z9oZae9FvutvLJoU0GHs7Q6WNk+1gwnbHnmAjkPIL
         wC9E4dyvQbZYPKRRhIqjrrdaZbqHEg9iQFmB5R0e9znogMkwBz3oJIEAAGdQmcgsRqB3
         0SsA==
X-Gm-Message-State: AHQUAub/3if8EJoSTQS7NeBLaLCCqJC20PROAbx2HwRhY2l0UCUj4fMl
        6pomzl1oK8iEUXC4XvRWrPY=
X-Google-Smtp-Source: AHgI3IbGx1tsBqcsvE1Us0SfX0U5tIcO4Q397+OAiv69y+V/LFVU1mOTJuyNP10AGPGROcBGEn41jA==
X-Received: by 2002:adf:e342:: with SMTP id n2mr8124222wrj.60.1550270394388;
        Fri, 15 Feb 2019 14:39:54 -0800 (PST)
Received: from goyamonster.habana-labs.com ([31.154.181.186])
        by smtp.gmail.com with ESMTPSA id b197sm14652609wmd.23.2019.02.15.14.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:39:53 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v6 13/15] habanalabs: implement INFO IOCTL
Date:   Sat, 16 Feb 2019 00:39:23 +0200
Message-Id: <20190215223925.16351-14-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190215223925.16351-1-oded.gabbay@gmail.com>
References: <20190215223925.16351-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the INFO IOCTL. That IOCTL is used by the user to
query information that is relevant/needed by the user in order to submit
deep learning jobs to Goya.

The information is divided into several categories, such as H/W IP, Events
that happened, DDR usage and more.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c        |   6 +
 drivers/misc/habanalabs/habanalabs.h       |   2 +
 drivers/misc/habanalabs/habanalabs_ioctl.c | 126 +++++++++++++++++++++
 include/uapi/misc/habanalabs.h             |  75 +++++++++++-
 4 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 89b82b989966..bf3f76f1aeae 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5131,6 +5131,11 @@ static void goya_hw_queues_unlock(struct hl_device *hdev)
 	spin_unlock(&goya->hw_queues_lock);
 }
 
+static u32 goya_get_pci_id(struct hl_device *hdev)
+{
+	return hdev->pdev->device;
+}
+
 int goya_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -5232,6 +5237,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.soft_reset_late_init = goya_soft_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
+	.get_pci_id = goya_get_pci_id,
 	.get_eeprom_data = goya_get_eeprom_data,
 	.send_cpu_message = goya_send_cpu_message,
 	.get_hw_state = goya_get_hw_state
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 03085e7a12dd..02de4a2cab27 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -470,6 +470,7 @@ enum hl_pll_frequency {
  * @soft_reset_late_init: perform certain actions needed after soft reset.
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
+ * @get_pci_id: retrieve PCI ID.
  * @get_eeprom_data: retrieve EEPROM data from F/W.
  * @send_cpu_message: send buffer to ArmCP.
  * @get_hw_state: retrieve the H/W state
@@ -539,6 +540,7 @@ struct hl_asic_funcs {
 	int (*soft_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
+	u32 (*get_pci_id)(struct hl_device *hdev);
 	int (*get_eeprom_data)(struct hl_device *hdev, void *data,
 				size_t max_size);
 	int (*send_cpu_message)(struct hl_device *hdev, u32 *msg,
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 6e4dc5b5e696..12408d3302e9 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -12,10 +12,136 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
+static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_hw_ip_info hw_ip = {0};
+	u32 size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 sram_kmd_size, dram_kmd_size;
+
+	if ((!size) || (!out))
+		return -EINVAL;
+
+	sram_kmd_size = (prop->sram_user_base_address -
+				prop->sram_base_address);
+	dram_kmd_size = (prop->dram_user_base_address -
+				prop->dram_base_address);
+
+	hw_ip.device_id = hdev->asic_funcs->get_pci_id(hdev);
+	hw_ip.sram_base_address = prop->sram_user_base_address;
+	hw_ip.dram_base_address = prop->dram_user_base_address;
+	hw_ip.tpc_enabled_mask = prop->tpc_enabled_mask;
+	hw_ip.sram_size = prop->sram_size - sram_kmd_size;
+	hw_ip.dram_size = prop->dram_size - dram_kmd_size;
+	if (hw_ip.dram_size > 0)
+		hw_ip.dram_enabled = 1;
+	hw_ip.num_of_events = prop->num_of_events;
+	memcpy(hw_ip.armcp_version,
+		prop->armcp_info.armcp_version, VERSION_MAX_LEN);
+	hw_ip.armcp_cpld_version = prop->armcp_info.cpld_version;
+	hw_ip.psoc_pci_pll_nr = prop->psoc_pci_pll_nr;
+	hw_ip.psoc_pci_pll_nf = prop->psoc_pci_pll_nf;
+	hw_ip.psoc_pci_pll_od = prop->psoc_pci_pll_od;
+	hw_ip.psoc_pci_pll_div_factor = prop->psoc_pci_pll_div_factor;
+
+	return copy_to_user(out, &hw_ip,
+		min((size_t)size, sizeof(hw_ip))) ? -EFAULT : 0;
+}
+
+static int hw_events_info(struct hl_device *hdev, struct hl_info_args *args)
+{
+	u32 size, max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	void *arr;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	arr = hdev->asic_funcs->get_events_stat(hdev, &size);
+
+	return copy_to_user(out, arr, min(max_size, size)) ? -EFAULT : 0;
+}
+
+static int dram_usage_info(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_dram_usage dram_usage = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 dram_kmd_size;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	dram_kmd_size = (prop->dram_user_base_address -
+				prop->dram_base_address);
+	dram_usage.dram_free_mem = (prop->dram_size - dram_kmd_size) -
+					atomic64_read(&hdev->dram_used_mem);
+	dram_usage.ctx_dram_mem = atomic64_read(&hdev->user_ctx->dram_phys_mem);
+
+	return copy_to_user(out, &dram_usage,
+		min((size_t) max_size, sizeof(dram_usage))) ? -EFAULT : 0;
+}
+
+static int hw_idle(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_hw_idle hw_idle = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	hw_idle.is_idle = hdev->asic_funcs->is_device_idle(hdev);
+
+	return copy_to_user(out, &hw_idle,
+		min((size_t) max_size, sizeof(hw_idle))) ? -EFAULT : 0;
+}
+
+static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
+{
+	struct hl_info_args *args = data;
+	struct hl_device *hdev = hpriv->hdev;
+	int rc;
+
+	if (hl_device_disabled_or_in_reset(hdev)) {
+		dev_err(hdev->dev,
+			"Device is disabled or in reset. Can't execute INFO IOCTL\n");
+		return -EBUSY;
+	}
+
+	switch (args->op) {
+	case HL_INFO_HW_IP_INFO:
+		rc = hw_ip_info(hdev, args);
+		break;
+
+	case HL_INFO_HW_EVENTS:
+		rc = hw_events_info(hdev, args);
+		break;
+
+	case HL_INFO_DRAM_USAGE:
+		rc = dram_usage_info(hdev, args);
+		break;
+
+	case HL_INFO_HW_IDLE:
+		rc = hw_idle(hdev, args);
+		break;
+
+	default:
+		dev_err(hdev->dev, "Invalid request %d\n", args->op);
+		rc = -ENOTTY;
+		break;
+	}
+
+	return rc;
+}
+
 #define HL_IOCTL_DEF(ioctl, _func) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func}
 
 static const struct hl_ioctl_desc hl_ioctls[] = {
+	HL_IOCTL_DEF(HL_IOCTL_INFO, hl_info_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_CB, hl_cb_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_CS, hl_cs_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_WAIT_CS, hl_cs_wait_ioctl),
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 9015043887d1..4afc1891ece8 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -45,6 +45,62 @@ enum goya_queue_id {
 	GOYA_QUEUE_ID_SIZE
 };
 
+/* Opcode for management ioctl */
+#define HL_INFO_HW_IP_INFO	0
+#define HL_INFO_HW_EVENTS	1
+#define HL_INFO_DRAM_USAGE	2
+#define HL_INFO_HW_IDLE		3
+
+#define HL_INFO_VERSION_MAX_LEN	128
+
+struct hl_info_hw_ip_info {
+	__u64 sram_base_address;
+	__u64 dram_base_address;
+	__u64 dram_size;
+	__u32 sram_size;
+	__u32 num_of_events;
+	__u32 device_id; /* PCI Device ID */
+	__u32 reserved[3];
+	__u32 armcp_cpld_version;
+	__u32 psoc_pci_pll_nr;
+	__u32 psoc_pci_pll_nf;
+	__u32 psoc_pci_pll_od;
+	__u32 psoc_pci_pll_div_factor;
+	__u8 tpc_enabled_mask;
+	__u8 dram_enabled;
+	__u8 pad[2];
+	__u8 armcp_version[HL_INFO_VERSION_MAX_LEN];
+};
+
+struct hl_info_dram_usage {
+	__u64 dram_free_mem;
+	__u64 ctx_dram_mem;
+};
+
+struct hl_info_hw_idle {
+	__u32 is_idle;
+	__u32 pad;
+};
+
+struct hl_info_args {
+	/* Location of relevant struct in userspace */
+	__u64 return_pointer;
+	/*
+	 * The size of the return value. Just like "size" in "snprintf",
+	 * it limits how many bytes the kernel can write
+	 *
+	 * For hw_events array, the size should be
+	 * hl_info_hw_ip_info.num_of_events * sizeof(__u32)
+	 */
+	__u32 return_size;
+
+	/* HL_INFO_* */
+	__u32 op;
+
+	/* Context ID - Currently not in use */
+	__u32 ctx_id;
+	__u32 pad;
+};
 
 /* Opcode to create a new command buffer */
 #define HL_CB_OP_CREATE		0
@@ -264,6 +320,23 @@ union hl_mem_args {
 	struct hl_mem_out out;
 };
 
+/*
+ * Various information operations such as:
+ * - H/W IP information
+ * - Current dram usage
+ *
+ * The user calls this IOCTL with an opcode that describes the required
+ * information. The user should supply a pointer to a user-allocated memory
+ * chunk, which will be filled by the driver with the requested information.
+ *
+ * The user supplies the maximum amount of size to copy into the user's memory,
+ * in order to prevent data corruption in case of differences between the
+ * definitions of structures in kernel and userspace, e.g. in case of old
+ * userspace and new kernel driver
+ */
+#define HL_IOCTL_INFO	\
+		_IOWR('H', 0x01, struct hl_info_args)
+
 /*
  * Command Buffer
  * - Request a Command Buffer
@@ -365,7 +438,7 @@ union hl_mem_args {
 #define HL_IOCTL_MEMORY		\
 		_IOWR('H', 0x05, union hl_mem_args)
 
-#define HL_COMMAND_START	0x02
+#define HL_COMMAND_START	0x01
 #define HL_COMMAND_END		0x06
 
 #endif /* HABANALABS_H_ */
-- 
2.18.0


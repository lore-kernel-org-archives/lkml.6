Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347D9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B9D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1tnlzBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B9D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeIZBnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:43:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44225 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeIZBnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:43:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id 36-v6so25647412oth.11;
        Tue, 25 Sep 2018 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgu+id+jU+mvRQcnvnTw2gS7YngpV6PFEbVGxiJTDfo=;
        b=g1tnlzBwOdhhoFJQlRS4bnYp6EicaNhbNLuTyBlWmUDwJ1fEbvlKP08nNZUE84a9aL
         tYRhnVlQSWYtiBzwFi6weSiyFU2nPYTRuJMKQMbnsU5TecgeIdXDUeBehLbZT5cZ6rv4
         3a+eCLeyM5yPXWJqgS42Yv3v5mwJ+sKvVDzEFogVQr6lpI/7SGG54hLucmQgBv/XhmVW
         8yPut0CPFjADYG4vqSCziF+GFwSOFDrrMgN0RydLMlwLH3NhR/qgTExeMfAqAHyTXjHi
         32pU40by7bvP+kmCdMtfRAJPMuQQ/k8tb3g0C4t3Ok9yOgxlRZTuj8tnE0uCphblhXTJ
         s2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgu+id+jU+mvRQcnvnTw2gS7YngpV6PFEbVGxiJTDfo=;
        b=TdFwd3ZZlEFpq83s6Cz5jYkUMk9MRTF5Xo+eXOwhU7d0L7BlQ1vt2w8zPdzey3D5+q
         +gd2Mw5BJpBAQrV2/VB0PID8g56M8UDkvvWjyxS0f9CmAx1ImrDopisjgW6ZYRKgbIHa
         lxp9WrRUtU3Ai1sdTgF7AReeFtNNWgN5reLcnOcZnAVtV8Or9tfF38uB2BBbexVm7TB2
         XOZtFQ4Xy38Hznc2lvar+cFr4hCfC55hOy0b6kk2FMYgpKLX1ucYcZK5p9jO+aEZBllN
         zKCnSKwff9RSmF8nTKl7Xqf4hVIhbV0nCDZbasGYfaBwz/pt28owLNjF/vYO/8+EF/Lv
         2kXQ==
X-Gm-Message-State: ABuFfogH+pMsGaEcWVh+G/gtZrfb0ReKWYURKHbCaaGWYfpCxid8Msxo
        3T4YikDGvKXsPNuCMiP3kno=
X-Google-Smtp-Source: ACcGV606Us3RVviTTGNQJ+W0/qbOZsvbPOfeSHfh5UAH9cmvCL+2Ut2pg4K8EEJpb6HXEd+hW8pBZA==
X-Received: by 2002:a9d:4905:: with SMTP id e5-v6mr1920283otf.368.1537904073037;
        Tue, 25 Sep 2018 12:34:33 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1049193otl.43.2018.09.25.12.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:34:31 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
X-Google-Original-From: Stuart Hayes <stuart.hayes@dell.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH 2/5] firmware: dcdbas: Add support for WSMT ACPI table
Date:   Tue, 25 Sep 2018 14:34:15 -0500
Message-Id: <20180925193418.28493-3-stuart.hayes@dell.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925193418.28493-1-stuart.hayes@dell.com>
References: <20180925193418.28493-1-stuart.hayes@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Hayes <stuart.w.hayes@gmail.com>

If the WSMT ACPI table is present and indicates that a fixed communication
buffer should be used, use the firmware-specified buffer instead of
allocating a buffer in memory for communications between the dcdbas driver
and firmare.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
This patch has been discussed previously, see history at
https://lore.kernel.org/patchwork/patch/958893/


 drivers/firmware/dcdbas.c | 123 ++++++++++++++++++++++++++++++++++++--
 drivers/firmware/dcdbas.h |  10 ++++
 2 files changed, 127 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/dcdbas.c b/drivers/firmware/dcdbas.c
index 0bdea60c65dd..ae28e48ff7dc 100644
--- a/drivers/firmware/dcdbas.c
+++ b/drivers/firmware/dcdbas.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/acpi.h>
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/cpu.h>
@@ -41,7 +42,7 @@
 #include "dcdbas.h"
 
 #define DRIVER_NAME		"dcdbas"
-#define DRIVER_VERSION		"5.6.0-3.2"
+#define DRIVER_VERSION		"5.6.0-3.3"
 #define DRIVER_DESCRIPTION	"Dell Systems Management Base Driver"
 
 static struct platform_device *dcdbas_pdev;
@@ -49,19 +50,23 @@ static struct platform_device *dcdbas_pdev;
 static u8 *smi_data_buf;
 static dma_addr_t smi_data_buf_handle;
 static unsigned long smi_data_buf_size;
+static unsigned long max_smi_data_buf_size = MAX_SMI_DATA_BUF_SIZE;
 static u32 smi_data_buf_phys_addr;
 static DEFINE_MUTEX(smi_data_lock);
+static u8 *eps_buffer;
 
 static unsigned int host_control_action;
 static unsigned int host_control_smi_type;
 static unsigned int host_control_on_shutdown;
 
+static bool wsmt_enabled;
+
 /**
  * smi_data_buf_free: free SMI data buffer
  */
 static void smi_data_buf_free(void)
 {
-	if (!smi_data_buf)
+	if (!smi_data_buf || wsmt_enabled)
 		return;
 
 	dev_dbg(&dcdbas_pdev->dev, "%s: phys: %x size: %lu\n",
@@ -86,7 +91,7 @@ static int smi_data_buf_realloc(unsigned long size)
 	if (smi_data_buf_size >= size)
 		return 0;
 
-	if (size > MAX_SMI_DATA_BUF_SIZE)
+	if (size > max_smi_data_buf_size)
 		return -EINVAL;
 
 	/* new buffer is needed */
@@ -169,7 +174,7 @@ static ssize_t smi_data_write(struct file *filp, struct kobject *kobj,
 {
 	ssize_t ret;
 
-	if ((pos + count) > MAX_SMI_DATA_BUF_SIZE)
+	if ((pos + count) > max_smi_data_buf_size)
 		return -EINVAL;
 
 	mutex_lock(&smi_data_lock);
@@ -322,8 +327,20 @@ static ssize_t smi_request_store(struct device *dev,
 			ret = count;
 		break;
 	case 1:
-		/* Calling Interface SMI */
-		smi_cmd->ebx = (u32) virt_to_phys(smi_cmd->command_buffer);
+		/*
+		 * Calling Interface SMI
+		 *
+		 * Provide physical address of command buffer field within
+		 * the struct smi_cmd to BIOS.
+		 *
+		 * Because the address that smi_cmd (smi_data_buf) points to
+		 * will be from memremap() of a non-memory address if WSMT
+		 * is present, we can't use virt_to_phys() on smi_cmd, so
+		 * we have to use the physical address that was saved when
+		 * the virtual address for smi_cmd was received.
+		 */
+		smi_cmd->ebx = smi_data_buf_phys_addr +
+				offsetof(struct smi_cmd, command_buffer);
 		ret = dcdbas_smi_request(smi_cmd);
 		if (!ret)
 			ret = count;
@@ -482,6 +499,93 @@ static void dcdbas_host_control(void)
 	}
 }
 
+/* WSMT */
+
+static u8 checksum(u8 *buffer, u8 length)
+{
+	u8 sum = 0;
+	u8 *end = buffer + length;
+
+	while (buffer < end)
+		sum += *buffer++;
+	return sum;
+}
+
+static inline struct smm_eps_table *check_eps_table(u8 *addr)
+{
+	struct smm_eps_table *eps = (struct smm_eps_table *)addr;
+
+	if (strncmp(eps->smm_comm_buff_anchor, SMM_EPS_SIG, 4) != 0)
+		return NULL;
+
+	if (checksum(addr, eps->length) != 0)
+		return NULL;
+
+	return eps;
+}
+
+static int dcdbas_check_wsmt(void)
+{
+	struct acpi_table_wsmt *wsmt = NULL;
+	struct smm_eps_table *eps = NULL;
+	u64 remap_size;
+	u8 *addr;
+
+	acpi_get_table(ACPI_SIG_WSMT, 0, (struct acpi_table_header **)&wsmt);
+	if (!wsmt)
+		return 0;
+
+	/* Check if WSMT ACPI table shows that protection is enabled */
+	if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS) ||
+	    !(wsmt->protection_flags & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
+		return 0;
+
+	/* Scan for EPS (entry point structure) */
+	for (addr = (u8 *)__va(0xf0000);
+	     addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table));
+	     addr += 16) {
+		eps = check_eps_table(addr);
+		if (eps)
+			break;
+	}
+
+	if (!eps) {
+		dev_dbg(&dcdbas_pdev->dev, "found WSMT, but no EPS found\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Get physical address of buffer and map to virtual address.
+	 * Table gives size in 4K pages, regardless of actual system page size.
+	 */
+	if (upper_32_bits(eps->smm_comm_buff_addr + 8)) {
+		dev_warn(&dcdbas_pdev->dev, "found WSMT, but EPS buffer address is above 4GB\n");
+		return -EINVAL;
+	}
+	/*
+	 * Limit remap size to MAX_SMI_DATA_BUF_SIZE + 8 (since the first 8
+	 * bytes are used for a semaphore, not the data buffer itself).
+	 */
+	remap_size = eps->num_of_4k_pages * PAGE_SIZE;
+	if (remap_size > MAX_SMI_DATA_BUF_SIZE + 8)
+		remap_size = MAX_SMI_DATA_BUF_SIZE + 8;
+	eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
+	if (!eps_buffer) {
+		dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed to map EPS buffer\n");
+		return -ENOMEM;
+	}
+
+	/* First 8 bytes is for a semaphore, not part of the smi_data_buf */
+	smi_data_buf_phys_addr = eps->smm_comm_buff_addr + 8;
+	smi_data_buf = eps_buffer + 8;
+	smi_data_buf_size = remap_size - 8;
+	max_smi_data_buf_size = smi_data_buf_size;
+	wsmt_enabled = true;
+	dev_info(&dcdbas_pdev->dev,
+		 "WSMT found, using firmware-provided SMI buffer.\n");
+	return 1;
+}
+
 /**
  * dcdbas_reboot_notify: handle reboot notification for host control
  */
@@ -548,6 +652,11 @@ static int dcdbas_probe(struct platform_device *dev)
 
 	dcdbas_pdev = dev;
 
+	/* Check if ACPI WSMT table specifies protected SMI buffer address */
+	error = dcdbas_check_wsmt();
+	if (error < 0)
+		return error;
+
 	/*
 	 * BIOS SMI calls require buffer addresses be in 32-bit address space.
 	 * This is done by setting the DMA mask below.
@@ -635,6 +744,8 @@ static void __exit dcdbas_exit(void)
 	 */
 	if (dcdbas_pdev)
 		smi_data_buf_free();
+	if (eps_buffer)
+		memunmap(eps_buffer);
 	platform_device_unregister(dcdbas_pdev_reg);
 	platform_driver_unregister(&dcdbas_driver);
 }
diff --git a/drivers/firmware/dcdbas.h b/drivers/firmware/dcdbas.h
index ca3cb0a54ab6..52729a494b00 100644
--- a/drivers/firmware/dcdbas.h
+++ b/drivers/firmware/dcdbas.h
@@ -53,6 +53,7 @@
 #define EXPIRED_TIMER				(0)
 
 #define SMI_CMD_MAGIC				(0x534D4931)
+#define SMM_EPS_SIG				"$SCB"
 
 #define DCDBAS_DEV_ATTR_RW(_name) \
 	DEVICE_ATTR(_name,0600,_name##_show,_name##_store);
@@ -103,5 +104,14 @@ struct apm_cmd {
 
 int dcdbas_smi_request(struct smi_cmd *smi_cmd);
 
+struct smm_eps_table {
+	char smm_comm_buff_anchor[4];
+	u8 length;
+	u8 checksum;
+	u8 version;
+	u64 smm_comm_buff_addr;
+	u64 num_of_4k_pages;
+} __packed;
+
 #endif /* _DCDBAS_H_ */
 
-- 
2.19.0.221.g150f307af


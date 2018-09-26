Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D11C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B3E21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2cAuQDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B3E21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeI0EFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:05:39 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36502 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeI0EFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:05:39 -0400
Received: by mail-ot1-f67.google.com with SMTP id c18-v6so540827otm.3;
        Wed, 26 Sep 2018 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s01L8+2N42mmy3/Sl6zdwx55us58oM8Y2Fl8Ftqtldc=;
        b=G2cAuQDLp1vF5bQ79kXgDtXPmk9dzw5IG9o74ueyH6zjDCGlw4Zjvi479i5G0cJC9C
         swNwFGx+hFBH/fzlayKJg8t2piZPjr2DyAQYAgpk8nsosH3UJQZiFw2SyGJGLH1jDYTC
         eAUcVpRp87WqDYRAAoTO+3OpvOCufSUtD8BmVZUHvx3g/XNqIpGEeRYvO/dRYNsFEunl
         fmYxnzGp76vqbcWhx4lZ6jtd3wGw2bnkm4MTAGyPdltE8HSD2P50ICSoz7DVt07lelrN
         fRtqUYAxkp0UyPRHy7AWK7SnncpKDkOznYnDzYEF6MAys1rsag9SfDZbQSo/h7OVdgAD
         h1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s01L8+2N42mmy3/Sl6zdwx55us58oM8Y2Fl8Ftqtldc=;
        b=byuYjawOxQxN0aCsEnSz4/xx/fQbDVsPRk/9LDzY6SuZBLWP3XmcVraL5TRlYoxRvw
         Sdh83sVEJ1FP2lKT27fex1agCiNmJRJcJENSPaXRMHzp00e4RgilTu9NtrzkFg1Ko5MF
         XqF9aTFGu1qtUEX5uHiYNH7979RHqCWZGEn5p9SBXlrq9lQwtUOsvm7crlnyIPhtfe1X
         waMUCzHUccX6x8j30t+rXpwo+xwHD60DsuWU2XO7va/2syuZ76FK62Bvadc1xGGFUVth
         1gO5QFC7HtauoZ5NHx5VrWnV6IWZWCj1u0zZhGzTpu/Jx+rMzhjExNOxgGxmCBsVeG2y
         sAPw==
X-Gm-Message-State: ABuFfohG8y1HZef36naVtrGJwHVfqwMM7cUsL7juhqErViA4vR0GYd4F
        tKZDLETNZJfTyPSpQQBYHM4=
X-Google-Smtp-Source: ACcGV625g6VvYypF+aXMRqWxX0hYIwzsu0iyb+I8Cq2QCquTsHLj1483FGHUIZkmsHbWZOirtbd0Xg==
X-Received: by 2002:a9d:4384:: with SMTP id t4-v6mr3047028ote.336.1537998638614;
        Wed, 26 Sep 2018 14:50:38 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id b124-v6sm95121oii.14.2018.09.26.14.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:50:37 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Doug Warzecha <Douglas_Warzecha@dell.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2 2/5] firmware: dcdbas: Add support for WSMT ACPI table
Date:   Wed, 26 Sep 2018 16:50:18 -0500
Message-Id: <20180926215021.30471-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
References: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.19.0


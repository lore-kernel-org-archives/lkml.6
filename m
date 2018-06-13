Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1CEA0C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEC420891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVUYEH+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEC420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935038AbeFMBZA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:25:00 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42973 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754407AbeFMBY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:24:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id k190-v6so825072oib.9;
        Tue, 12 Jun 2018 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oy1YOxxkqA3GItWNbJaU64wFvE4GajJWugIU1ZXlCXc=;
        b=BVUYEH+yQ1lrOor7Ufd49kjlff3jss9aWsRneSopp48TCYuRiBmAby7Uwk5roTgCcg
         ysHY5VMQfJHSV9lQkam/VwM8+MHH0TnqVKDPHjM5nE9N6ccgYmuOCtyVp0t9URCmlows
         uKr3U/YBbAuhXEI59kQRachDRZ4mjYEOKEBSnVhKrJwlE/JynNS13q8x4/9M/PnaIBM0
         omVw7JLDNdqaKZiapM0cINMEqs7sQH2zqxMdKdioVbUZCG3+as3U7D+7tWPThv4s5VLC
         UWo93qLPOUaekKhL9etYAjRg5fo2LfSWF1TuqUahZREdgZLV0XAOuh+JtDNOPAs1DTkn
         ZHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oy1YOxxkqA3GItWNbJaU64wFvE4GajJWugIU1ZXlCXc=;
        b=h1f9T71be2jb9MHtx5wGhQLPASirplH5fVoYKwkt8ByT8aRioRLfZkbzQfye33nRX9
         /cf2oRph2SZeD9nesJ5SQFsZwe7srXaSvwbE8XIhg3142W2X9lc9wKAg+XkHZDG3h/xg
         abdxJ+c0fBYeRUOOZTlChWmaV6D8LfteT6vovaW5rgw5Mn7ldP2ztom7RQXQ6HTytwXK
         UW88y3E4kBZh7GY8wcb611LgRIZGkXP8YGqFEK9tEZYhdxyXWfMoytRsLGFttdmz/9ho
         yyFF9BEt8wn1KoUULJvUwwHDU4bkIgeOJHd75ttanpNXyXqcQVYRgPr9nzwN/tdrAdoO
         KvBw==
X-Gm-Message-State: APt69E2zikN5Y84E9JjmAXBUVtr3X+7uuqoNU1zLmtXG5DJ8hLLDsPVl
        Tie6gDks+jbe+u6X3kcTxpwqUuoK
X-Google-Smtp-Source: ADUXVKK+AuZHksxtTC3nCxd/AEpJFV81echNEhPJuQLF6UTaIfzSDE5NCQ9kCBkt5HC/3bxc8jowCQ==
X-Received: by 2002:aca:3b09:: with SMTP id i9-v6mr3507546oia.156.1528853097835;
        Tue, 12 Jun 2018 18:24:57 -0700 (PDT)
Received: from [192.168.0.2] (cpe-24-27-59-32.austin.res.rr.com. [24.27.59.32])
        by smtp.gmail.com with ESMTPSA id p8-v6sm683729oti.66.2018.06.12.18.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 18:24:56 -0700 (PDT)
Subject: [PATCH v3] dcdbas: Add support for WSMT ACPI table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>
Cc:     Douglas_Warzecha@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jared.Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
 <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
Date:   Tue, 12 Jun 2018 20:24:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 180612-4, 06/12/2018), Outbound message
X-Antivirus-Status: Clean
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
v2 Bumped driver version to 5.6.0-3.3
v3 Removed dependency on ACPI in Kconfig
   Moved the added #include to be in alphabetical order
   Added comments in smi_request_store()
   Simplified checksum code
   Changed loop searching 0xf0000 to be more readable
   Reworked calculation of remap_size & smi_data_buf_size


 drivers/firmware/dcdbas.c | 118 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/firmware/dcdbas.h |  10 ++++
 2 files changed, 122 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/dcdbas.c b/drivers/firmware/dcdbas.c
index 0bdea60c65dd..e95dc9aee2fa 100644
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
@@ -322,8 +327,14 @@ static ssize_t smi_request_store(struct device *dev,
 			ret = count;
 		break;
 	case 1:
-		/* Calling Interface SMI */
-		smi_cmd->ebx = (u32) virt_to_phys(smi_cmd->command_buffer);
+		/* Calling Interface SMI
+		 *
+		 * Provide physical address of command buffer field within
+		 * the struct smi_cmd... can't use virt_to_phys on smi_cmd
+		 * because address may be from memremap.
+		 */
+		smi_cmd->ebx = smi_data_buf_phys_addr +
+				offsetof(struct smi_cmd, command_buffer);
 		ret = dcdbas_smi_request(smi_cmd);
 		if (!ret)
 			ret = count;
@@ -482,6 +493,94 @@ static void dcdbas_host_control(void)
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
+	if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS)
+	    || !(wsmt->protection_flags
+		 & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
+		return 0;
+
+	/* Scan for EPS (entry point structure) */
+	for (addr = (u8 *)__va(0xf0000);
+	     addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table));
+	     addr += 1) {
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
@@ -548,6 +647,11 @@ static int dcdbas_probe(struct platform_device *dev)
 
 	dcdbas_pdev = dev;
 
+	/* Check if ACPI WSMT table specifies protected SMI buffer address */
+	error = dcdbas_check_wsmt();
+	if (error < 0)
+		return error;
+
 	/*
 	 * BIOS SMI calls require buffer addresses be in 32-bit address space.
 	 * This is done by setting the DMA mask below.
@@ -635,6 +739,8 @@ static void __exit dcdbas_exit(void)
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
2.14.2


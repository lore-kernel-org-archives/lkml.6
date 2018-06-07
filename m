Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wePmAqFWGVvZZAAAmS7hNA
	; Thu, 07 Jun 2018 16:00:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E3B6B607E7; Thu,  7 Jun 2018 16:00:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi3zhuhO"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1E5DC60590;
	Thu,  7 Jun 2018 16:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E5DC60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934982AbeFGQA2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:00:28 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41250 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933178AbeFGP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:59:59 -0400
Received: by mail-ot0-f193.google.com with SMTP id d19-v6so6581039oti.8;
        Thu, 07 Jun 2018 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7MeyJcmP+RmVXGlb3ok3oWmMX7V2GkaOBpRbaAuIoMk=;
        b=gi3zhuhOggaB0ubx+mB7RRF9TvoXkqZ//+iOCqgszr5vNO9OJFvHSe1AJEmWFtG55W
         t8/M9cfPKhoy3YA4z/RH0o1gzCuic5hqKCf/iHFeva0bD5nEj/JzugrGmS7gYKt7NMPa
         PdlqVY6+rT68F+7Cc5wrjP6qGivr2DfqysU0z+N7zKkAb2y1fYwQiSpXyB3VcoXJ9RBO
         t3kcYCFxbpJq7S1jq/G0FMVK4V2e8ikiNVkcOpSJTw4pV2zI3/HJNwT6lTB/GGy28QOL
         FyYToj/PuD8Lq0WR+Hv+llpiYWUdSRuKqiRS01+Q2xlIkNfBJqlcvgQuBNVlOIrHoBV/
         m8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7MeyJcmP+RmVXGlb3ok3oWmMX7V2GkaOBpRbaAuIoMk=;
        b=W11z7QtRGYvnCPnB7EIA/80HCWomPgVLm39G+TT39nbPwDeBKLsTEbp8jmLXWpcItr
         Zwy90hw6Z1e4GfH4TQHJqjJieqAmLFjtKUo0E4gkwsBtcpC/oCk5Vntb7q/Shyb7uNdK
         rS5n8tIPF6Q19KAkj849vzzn8sWypkLF8rDq2O1n2Di6vc96INVukQJ3U22iGU2LS0kJ
         c0WsMndFIDwQAYcbYosd4yOT5KSNmCaH7lmOLEzeAEnCjikvpgCF9Kwml6Hv1T2ZXcye
         bsrUc8YkR7b9etKXs0c27KsC38FWJK7kFEmUp9ab+YRVPINKwePp9/6sKMSJy+GgkmeF
         Aq7g==
X-Gm-Message-State: APt69E1QY1FMq6468I1KkJPetQqojOLtpdMhSyJ0n8MsxmTZonIV2EFf
        EUtZduiHWUXBUu2kazGniNGDVWbe
X-Google-Smtp-Source: ADUXVKJd4i89CCTTyTvqKdnir/oMxjJmu4G2QilC6ulbFXjOQ2sTrMB02l1NdVsBr0ddO/MhQRz76A==
X-Received: by 2002:a9d:338d:: with SMTP id u13-v6mr1428148otc.232.1528387198228;
        Thu, 07 Jun 2018 08:59:58 -0700 (PDT)
Received: from [192.168.0.2] (cpe-24-27-59-32.austin.res.rr.com. [24.27.59.32])
        by smtp.gmail.com with ESMTPSA id s144-v6sm8699006oie.17.2018.06.07.08.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 08:59:57 -0700 (PDT)
Subject: [PATCH resend v2] dcdbas: Add support for WSMT ACPI table
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: Douglas_Warzecha@Dell.com
Cc: mario.limonciello@dell.com, Jared_Dominguez@dell.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
Message-ID: <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
Date: Thu, 7 Jun 2018 10:59:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 180607-0, 06/07/2018), Outbound message
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
Tested-by: Mario Limonciello <mario.limonciello@dell.com>
Acked-by: Doug Warzecha <douglas_warzecha@dell.com>
---
v2 Bumped driver version to 5.6.0-3.3


 drivers/firmware/Kconfig  |   2 +-
 drivers/firmware/dcdbas.c | 102 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/firmware/dcdbas.h |  11 +++++
 3 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b7c748248e53..a2bd6092bfa1 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -125,7 +125,7 @@ config DELL_RBU
 
 config DCDBAS
 	tristate "Dell Systems Management Base Driver"
-	depends on X86
+	depends on X86 && ACPI
 	help
 	  The Dell Systems Management Base Driver provides a sysfs interface
 	  for systems management software to perform System Management
diff --git a/drivers/firmware/dcdbas.c b/drivers/firmware/dcdbas.c
index 0bdea60c65dd..1699cfdcefe4 100644
--- a/drivers/firmware/dcdbas.c
+++ b/drivers/firmware/dcdbas.c
@@ -36,12 +36,13 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
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
@@ -323,7 +328,8 @@ static ssize_t smi_request_store(struct device *dev,
 		break;
 	case 1:
 		/* Calling Interface SMI */
-		smi_cmd->ebx = (u32) virt_to_phys(smi_cmd->command_buffer);
+		smi_cmd->ebx = smi_data_buf_phys_addr
+				+ offsetof(struct smi_cmd, command_buffer);
 		ret = dcdbas_smi_request(smi_cmd);
 		if (!ret)
 			ret = count;
@@ -482,6 +488,85 @@ static void dcdbas_host_control(void)
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
+		sum = (u8)(sum + *(buffer++));
+	return sum;
+}
+
+static inline struct smm_eps_table *check_eps_table(u8 *addr)
+{
+	struct smm_eps_table *eps = (struct smm_eps_table *)addr;
+
+	if (strncmp(SMM_EPS_SIG, eps->smm_comm_buff_anchor, 4) != 0)
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
+	     addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table)) && !eps;
+	     addr += 1)
+		eps = check_eps_table(addr);
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
+	if (eps->smm_comm_buff_addr + 8 > U32_MAX) {
+		dev_warn(&dcdbas_pdev->dev, "found WSMT, but EPS buffer address is above 4GB\n");
+		return -EINVAL;
+	}
+	eps_buffer = (u8 *)memremap(eps->smm_comm_buff_addr,
+				     eps->num_of_4k_pages * 4096, MEMREMAP_WB);
+	if (!eps_buffer) {
+		dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed to map EPS buffer\n");
+		return -ENOMEM;
+	}
+
+	/* First 8 bytes of buffer is for semaphore */
+	smi_data_buf_phys_addr = (u32) eps->smm_comm_buff_addr + 8;
+	smi_data_buf = eps_buffer + 8;
+	smi_data_buf_size = (unsigned long) min(eps->num_of_4k_pages * 4096 - 8,
+			    (u64) ULONG_MAX);
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
@@ -548,6 +633,11 @@ static int dcdbas_probe(struct platform_device *dev)
 
 	dcdbas_pdev = dev;
 
+	/* Check if ACPI WSMT table specifies protected SMI buffer address */
+	error = dcdbas_check_wsmt();
+	if (error < 0)
+		return error;
+
 	/*
 	 * BIOS SMI calls require buffer addresses be in 32-bit address space.
 	 * This is done by setting the DMA mask below.
@@ -635,6 +725,8 @@ static void __exit dcdbas_exit(void)
 	 */
 	if (dcdbas_pdev)
 		smi_data_buf_free();
+	if (eps_buffer)
+		memunmap(eps_buffer);
 	platform_device_unregister(dcdbas_pdev_reg);
 	platform_driver_unregister(&dcdbas_driver);
 }
diff --git a/drivers/firmware/dcdbas.h b/drivers/firmware/dcdbas.h
index ca3cb0a54ab6..7ea5b3e070b9 100644
--- a/drivers/firmware/dcdbas.h
+++ b/drivers/firmware/dcdbas.h
@@ -54,6 +54,8 @@
 
 #define SMI_CMD_MAGIC				(0x534D4931)
 
+#define SMM_EPS_SIG				"$SCB"
+
 #define DCDBAS_DEV_ATTR_RW(_name) \
 	DEVICE_ATTR(_name,0600,_name##_show,_name##_store);
 
@@ -103,5 +105,14 @@ struct apm_cmd {
 
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

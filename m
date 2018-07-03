Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2F9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4481123ECE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYJU76VG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4481123ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933878AbeGCQU3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:20:29 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35826 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933569AbeGCQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:20:25 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so4972174oik.2;
        Tue, 03 Jul 2018 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zsgypG04OW6kcYuDEeplrtJIK66q56vyi8ZE06TomNM=;
        b=oYJU76VGOUofJ9/KvNrZeU9A8xHAwAkjneQ1rGDCRTfIIeKGZEnVkzkAGHDW89717O
         YsM/BJGXeTJ7dpOFPZpZCap2Gt2vYx5nhIrZqmG1ZRN3BMZJmqrdfg51W3XZxal3cLkQ
         Swn2EM5lhB/fQd/HIi0cYXtD9A2FHbMqJL4R3MDudublaZoXh3z45PGFcc1lL4aGlAWH
         CQbwJY539INz45DDJdrwiGRErJla1MYl/1IQa89OOxXZ+uBuC9M9MIbkcQeS6Eh3lgdD
         XFOeCVTTbZ7IJGNVueVXVjrtnO3T3QMWpwVOqH8qGoXSP5tUXOWwQoisDNORi003WxIO
         KgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zsgypG04OW6kcYuDEeplrtJIK66q56vyi8ZE06TomNM=;
        b=ghjPQEzwx02KOqhRyUGr1jD1POPySjQxb8e2EAhZRYYPl67SYu1MCFdR2GVvP20azS
         ZkLJdwqn1C+dW4KIaS9Nvat6GdUhQ+bwZjJ6ftDpf9CGz+D5PcS5BjZUQyUNna6uqyIV
         i414hQHpdI66HkSL2U1DU4cdsNCFFYmEVEA7kOiWrcnx+8rvJdpJhGNP9n8lCsdviMOC
         r/bJ+vL0iNLQmSV75zRWMwrcAXW/kfkGvzr8pH1cbxoYV9yraaaSmxcv7RRviURuNReg
         bbFo5wNCW9bCxQkhyUrEG8EfN46PCIKC9SKy650uTDdX2GF5ebwwytHkmLxLf7QWAcjH
         xzWg==
X-Gm-Message-State: APt69E3hFXQDWtIldwwstaZsMARSdU5ijlHmpILVhWszScXElRTJtCcv
        IsGm/GyNo/5xzQ+KruijcpFAubtH
X-Google-Smtp-Source: AAOMgpetCILNp77lzoFBTkRsPf04Okd0i1DaNKiDJTJm9xIB4xk/HC7q9ZKvV2iH0By5AmpZzSZwug==
X-Received: by 2002:aca:3507:: with SMTP id c7-v6mr5996959oia.46.1530634824813;
        Tue, 03 Jul 2018 09:20:24 -0700 (PDT)
Received: from [192.168.0.2] (cpe-70-124-142-160.austin.res.rr.com. [70.124.142.160])
        by smtp.gmail.com with ESMTPSA id w62-v6sm641936otb.0.2018.07.03.09.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 09:20:23 -0700 (PDT)
Subject: [PATCH v5] dcdbas: Add support for WSMT ACPI table
To:     Mario.Limonciello@dell.com, andy.shevchenko@gmail.com
Cc:     dvhart@infradead.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
 <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
 <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
 <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com>
 <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
 <b5652ed8-5fff-4f8b-ec0f-467bce853bf8@gmail.com>
 <CAHp75VfL3v8U6o36-e3+XPL53sb9wMUOXsL6gn3XE4=-kJjuKQ@mail.gmail.com>
 <367a12e9-7d10-98e4-4791-69cdc7d01129@gmail.com>
 <CAHp75VdSVLzNHnrOzzrBMf4X2Cg4QACRrnxKNkQzcYJ0h5W+tw@mail.gmail.com>
 <e17fbb51b98d45318001adb7eb6a51b2@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VfNo9NVfgGn4Fqa5fA9zp47TkqHwn1MJ044qMQoMNMB-Q@mail.gmail.com>
 <73c53c23c0824e4595292bfafc6054ee@ausx13mpc120.AMER.DELL.COM>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <4e26f407-58c0-09b6-6735-f004d5e86969@gmail.com>
Date:   Tue, 3 Jul 2018 11:20:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <73c53c23c0824e4595292bfafc6054ee@ausx13mpc120.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 180703-2, 07/03/2018), Outbound message
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
v4 Fixed comment that starts with "Calling Interface SMI"
   Fixed formatting of first "if" statement in dcdbas_check_wsmt()
v5 Reworked comment that starts with "Calling Interface SMI"
   Changed EPS scanning loop to check every 16 bytes


 drivers/firmware/dcdbas.c | 123 +++++++++++++++++++++++++++++++++++++++++++---
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
2.14.2


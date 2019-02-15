Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFCDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AF620821
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9vCIc7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390558AbfBOHs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:48:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45308 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfBOHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:48:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id r14so4530104pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 23:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a/3ug9o1gmqa0JxxYVq6VlcYLD2RDBFkq8e370+la9s=;
        b=r9vCIc7pWJxNjxtfvl9G1e8WBgQVZu32tA8QcMJS0A9Bmtw0Co6Duin9zxSDNo9O0U
         z5f6rdeJVZ3cl/FozColSWrasCxHGP9xQ1Nggg/FM1yVW2HvDZG10lMQmrDiwk7uAwYx
         HsbDhXA9aD7JfbYgP8lye5QaTXSvTbQkWVCB9VFzqqWblLBjjalB7YRG/8zV7g7w8oP6
         Gy5wd3HfLM/205eTFsdqUNqV2LtDyC6I2igpNfs6sVISN5iIRbp4PSRAAO3Yfnet6KhB
         +HF9rSPlv9HLi97kTKdnNO8U62YH5r8dipO3wavOImB5V5KFEUYo210PeRmI1We2Cahq
         /kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a/3ug9o1gmqa0JxxYVq6VlcYLD2RDBFkq8e370+la9s=;
        b=PBNPIbyuwMSJdZH2igzW9o50ZwLpD9W5WeTQJh9bxkxtKpKli/cbUjbdW4puYPkHDy
         fpo31JzDllGCxtFN+0ksqegmOwEHYpst9Hr30icOWyHw8pj+6t2bMT7fb005tJIDnN8v
         qzbQ2FLR8wU+tO+ikh3w816KBSZrjNOK/gRO4WOxUVSxudnQnh3SVIKtY2NeYv02Fb4D
         Wjpuklz7RWuvhUC7AlE39cg9LSEA3mE+dujJ17JFhXAc8BSRkQrC6VAJaOCgrhjeQoZw
         TmXoqdJuvo44faY/ILEDEGDLox2coRJ/y6UKuf01MWa5mhnkJzqat92O6AKV0072Pxo1
         1gQQ==
X-Gm-Message-State: AHQUAubXJVyKLcEQJqj86A1SNir2wFSm6ts3IbvssvMeMDrX01T6P5N/
        J0+kFWw6az55LC4T6cDb80g=
X-Google-Smtp-Source: AHgI3IZpwiNQbPIearNWrtXiIL7shO/WbysUjMA/cxqXWl04gRuY1l7oX3GmE9m8xKgl/lOKPzb1+w==
X-Received: by 2002:a17:902:48c8:: with SMTP id u8mr8815282plh.79.1550216936433;
        Thu, 14 Feb 2019 23:48:56 -0800 (PST)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id v75sm7060167pfa.164.2019.02.14.23.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 23:48:55 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH v2] pstore: Add boot loader log messages support
Date:   Fri, 15 Feb 2019 15:48:02 +0800
Message-Id: <20190215074802.8260-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Sometimes we hope to check boot loader log messages (e.g. Android
Verified Boot status) when kernel is coming up. Generally it does
depend on serial device, but it will be removed for the hardware
shipping to market by most of manufacturers. In that case better
solder and proper serial cable for different interface (e.g. Type-C
or microUSB) are needed. That is inconvenient and even wasting much
time on it.

Therefore, let's add a logging support: PSTORE_TYPE_XBL.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: mention info of interacting with boot loader

 fs/pstore/Kconfig      | 10 +++++++
 fs/pstore/platform.c   | 16 ++++++++++
 fs/pstore/ram.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pstore.h | 21 +++++++++----
 4 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 0d19d19..ef4a2dc 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -137,6 +137,16 @@ config PSTORE_FTRACE
 
 	  If unsure, say N.
 
+config PSTORE_XBL
+	bool "Log bootloader messages"
+	depends on PSTORE
+	help
+	  When the option is enabled, pstore will log boot loader
+	  messages to /sys/fs/pstore/xbl-ramoops-[ID] after reboot.
+	  Boot loader needs to support log buffer reserved.
+
+	  If unsure, say N.
+
 config PSTORE_RAM
 	tristate "Log panic/oops to a RAM buffer"
 	depends on PSTORE
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 2d1066e..2e6c3f8f 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -65,6 +65,7 @@
 	"mce",
 	"console",
 	"ftrace",
+	"xbl",
 	"rtas",
 	"powerpc-ofw",
 	"powerpc-common",
@@ -530,6 +531,19 @@ static void pstore_register_console(void) {}
 static void pstore_unregister_console(void) {}
 #endif
 
+#ifdef CONFIG_PSTORE_XBL
+static void pstore_register_xbl(void)
+{
+	struct pstore_record record;
+
+	pstore_record_init(&record, psinfo);
+	record.type = PSTORE_TYPE_XBL;
+	psinfo->write(&record);
+}
+#else
+static void pstore_register_xbl(void) {}
+#endif
+
 static int pstore_write_user_compat(struct pstore_record *record,
 				    const char __user *buf)
 {
@@ -616,6 +630,8 @@ int pstore_register(struct pstore_info *psi)
 		pstore_register_ftrace();
 	if (psi->flags & PSTORE_FLAGS_PMSG)
 		pstore_register_pmsg();
+	if (psi->flags & PSTORE_FLAGS_XBL)
+		pstore_register_xbl();
 
 	/* Start watching for new records, if desired. */
 	if (pstore_update_ms >= 0) {
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 1adb5e3..b114b1d 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -56,6 +56,27 @@
 module_param_named(pmsg_size, ramoops_pmsg_size, ulong, 0400);
 MODULE_PARM_DESC(pmsg_size, "size of user space message log");
 
+/*
+ * interact with boot loader
+ * =========================
+ *
+ * xbl memory layout:
+ * +----+
+ * |dst |
+ * |----|     +------------+
+ * |src ----> |   header   |
+ * +----+     |log messages|
+ *            +------------+
+ *
+ * As above, src memory is used to store header and log messages generated
+ * by boot loader, pstore will copy the log messages to dst memory which
+ * has same size as src. The header in src is to record log messages size
+ * written and make xbl cookie.
+ */
+static ulong ramoops_xbl_size = MIN_MEM_SIZE;
+module_param_named(xbl_size, ramoops_xbl_size, ulong, 0400);
+MODULE_PARM_DESC(xbl_size, "size of boot loader log");
+
 static unsigned long long mem_address;
 module_param_hw(mem_address, ullong, other, 0400);
 MODULE_PARM_DESC(mem_address,
@@ -88,6 +109,7 @@ struct ramoops_context {
 	struct persistent_ram_zone *cprz;	/* Console zone */
 	struct persistent_ram_zone **fprzs;	/* Ftrace zones */
 	struct persistent_ram_zone *mprz;	/* PMSG zone */
+	struct persistent_ram_zone *bprz;	/* XBL zone */
 	phys_addr_t phys_addr;
 	unsigned long size;
 	unsigned int memtype;
@@ -95,6 +117,7 @@ struct ramoops_context {
 	size_t console_size;
 	size_t ftrace_size;
 	size_t pmsg_size;
+	size_t xbl_size;
 	int dump_oops;
 	u32 flags;
 	struct persistent_ram_ecc_info ecc_info;
@@ -106,6 +129,7 @@ struct ramoops_context {
 	unsigned int max_ftrace_cnt;
 	unsigned int ftrace_read_cnt;
 	unsigned int pmsg_read_cnt;
+	unsigned int xbl_read_cnt;
 	struct pstore_info pstore;
 };
 
@@ -119,6 +143,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
 	cxt->console_read_cnt = 0;
 	cxt->ftrace_read_cnt = 0;
 	cxt->pmsg_read_cnt = 0;
+	cxt->xbl_read_cnt = 0;
 	return 0;
 }
 
@@ -272,6 +297,10 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 	if (!prz_ok(prz) && !cxt->pmsg_read_cnt++)
 		prz = ramoops_get_next_prz(&cxt->mprz, 0 /* single */, record);
 
+	if (!prz_ok(prz) && !cxt->xbl_read_cnt++) {
+		prz = ramoops_get_next_prz(&cxt->bprz, 0 /* single */, record);
+	}
+
 	/* ftrace is last since it may want to dynamically allocate memory. */
 	if (!prz_ok(prz)) {
 		if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU) &&
@@ -360,6 +389,26 @@ static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz,
 	return len;
 }
 
+static void ramoops_get_xbl_record(struct persistent_ram_zone *prz,
+				  struct pstore_record *record,
+				  size_t xbl_size)
+{
+	struct pstore_xbl_header *hdr = NULL;
+	size_t half = xbl_size / 2;
+	size_t max = half - PSTORE_XBL_HDR_SIZE;
+
+	hdr = (struct pstore_xbl_header *)((size_t)prz->buffer + half);
+
+	if (hdr->cookie == PSTORE_XBL_COOKIE) {
+		record->buf = (char *)((size_t)hdr + PSTORE_XBL_HDR_SIZE);
+		record->size = hdr->size_written;
+		if (unlikely(record->size > max))
+			record->size = max;
+		return;
+	}
+	pr_debug("no valid xbl record (cookie = 0x%08x)\n", hdr->cookie);
+}
+
 static int notrace ramoops_pstore_write(struct pstore_record *record)
 {
 	struct ramoops_context *cxt = record->psi->data;
@@ -390,6 +439,16 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
 	} else if (record->type == PSTORE_TYPE_PMSG) {
 		pr_warn_ratelimited("PMSG shouldn't call %s\n", __func__);
 		return -EINVAL;
+	} else if (record->type == PSTORE_TYPE_XBL) {
+		if (!cxt->bprz)
+			return -ENOMEM;
+
+		ramoops_get_xbl_record(cxt->bprz, record, cxt->xbl_size);
+		if (record->size == 0)
+			return -EINVAL;
+
+		persistent_ram_write(cxt->bprz, record->buf, record->size);
+		return 0;
 	}
 
 	if (record->type != PSTORE_TYPE_DMESG)
@@ -469,6 +528,9 @@ static int ramoops_pstore_erase(struct pstore_record *record)
 	case PSTORE_TYPE_PMSG:
 		prz = cxt->mprz;
 		break;
+	case PSTORE_TYPE_XBL:
+		prz = cxt->bprz;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -697,6 +759,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	parse_size("console-size", pdata->console_size);
 	parse_size("ftrace-size", pdata->ftrace_size);
 	parse_size("pmsg-size", pdata->pmsg_size);
+	parse_size("xbl-size", pdata->xbl_size);
 	parse_size("ecc-size", pdata->ecc_info.ecc_size);
 	parse_size("flags", pdata->flags);
 
@@ -740,7 +803,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	}
 
 	if (!pdata->mem_size || (!pdata->record_size && !pdata->console_size &&
-			!pdata->ftrace_size && !pdata->pmsg_size)) {
+		!pdata->ftrace_size && !pdata->pmsg_size && !pdata->xbl_size)) {
 		pr_err("The memory size and the record/console size must be "
 			"non-zero\n");
 		goto fail_out;
@@ -754,6 +817,8 @@ static int ramoops_probe(struct platform_device *pdev)
 		pdata->ftrace_size = rounddown_pow_of_two(pdata->ftrace_size);
 	if (pdata->pmsg_size && !is_power_of_2(pdata->pmsg_size))
 		pdata->pmsg_size = rounddown_pow_of_two(pdata->pmsg_size);
+	if (pdata->xbl_size && !is_power_of_2(pdata->xbl_size))
+		pdata->xbl_size = rounddown_pow_of_two(pdata->xbl_size);
 
 	cxt->size = pdata->mem_size;
 	cxt->phys_addr = pdata->mem_address;
@@ -762,6 +827,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	cxt->console_size = pdata->console_size;
 	cxt->ftrace_size = pdata->ftrace_size;
 	cxt->pmsg_size = pdata->pmsg_size;
+	cxt->xbl_size = pdata->xbl_size;
 	cxt->dump_oops = pdata->dump_oops;
 	cxt->flags = pdata->flags;
 	cxt->ecc_info = pdata->ecc_info;
@@ -769,7 +835,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	paddr = cxt->phys_addr;
 
 	dump_mem_sz = cxt->size - cxt->console_size - cxt->ftrace_size
-			- cxt->pmsg_size;
+			- cxt->pmsg_size - cxt->xbl_size;
 	err = ramoops_init_przs("dmesg", dev, cxt, &cxt->dprzs, &paddr,
 				dump_mem_sz, cxt->record_size,
 				&cxt->max_dump_cnt, 0, 0);
@@ -797,6 +863,11 @@ static int ramoops_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_init_mprz;
 
+	err = ramoops_init_prz("xbl", dev, cxt, &cxt->bprz, &paddr,
+				cxt->xbl_size, 0);
+	if (err)
+		goto fail_init_bprz;
+
 	cxt->pstore.data = cxt;
 	/*
 	 * Since bufsize is only used for dmesg crash dumps, it
@@ -818,6 +889,8 @@ static int ramoops_probe(struct platform_device *pdev)
 		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
 	if (cxt->pmsg_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
+	if (cxt->xbl_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_XBL;
 
 	err = pstore_register(&cxt->pstore);
 	if (err) {
@@ -835,6 +908,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	dump_oops = pdata->dump_oops;
 	ramoops_console_size = pdata->console_size;
 	ramoops_pmsg_size = pdata->pmsg_size;
+	ramoops_xbl_size = pdata->xbl_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
 
 	pr_info("using 0x%lx@0x%llx, ecc: %d\n",
@@ -847,6 +921,8 @@ static int ramoops_probe(struct platform_device *pdev)
 	kfree(cxt->pstore.buf);
 fail_clear:
 	cxt->pstore.bufsize = 0;
+	persistent_ram_free(cxt->bprz);
+fail_init_bprz:
 	persistent_ram_free(cxt->mprz);
 fail_init_mprz:
 fail_init_fprz:
@@ -915,6 +991,7 @@ static void __init ramoops_register_dummy(void)
 	pdata.console_size = ramoops_console_size;
 	pdata.ftrace_size = ramoops_ftrace_size;
 	pdata.pmsg_size = ramoops_pmsg_size;
+	pdata.xbl_size = ramoops_xbl_size;
 	pdata.dump_oops = dump_oops;
 	pdata.flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
 
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index b146181..e016bbf 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -43,13 +43,14 @@ enum pstore_type_id {
 	PSTORE_TYPE_MCE		= 1,
 	PSTORE_TYPE_CONSOLE	= 2,
 	PSTORE_TYPE_FTRACE	= 3,
+	PSTORE_TYPE_XBL		= 4,
 
 	/* PPC64-specific partition types */
-	PSTORE_TYPE_PPC_RTAS	= 4,
-	PSTORE_TYPE_PPC_OF	= 5,
-	PSTORE_TYPE_PPC_COMMON	= 6,
-	PSTORE_TYPE_PMSG	= 7,
-	PSTORE_TYPE_PPC_OPAL	= 8,
+	PSTORE_TYPE_PPC_RTAS	= 5,
+	PSTORE_TYPE_PPC_OF	= 6,
+	PSTORE_TYPE_PPC_COMMON	= 7,
+	PSTORE_TYPE_PMSG	= 8,
+	PSTORE_TYPE_PPC_OPAL	= 9,
 
 	/* End of the list */
 	PSTORE_TYPE_MAX
@@ -207,10 +208,20 @@ struct pstore_info {
 #define PSTORE_FLAGS_CONSOLE	BIT(1)
 #define PSTORE_FLAGS_FTRACE	BIT(2)
 #define PSTORE_FLAGS_PMSG	BIT(3)
+#define PSTORE_FLAGS_XBL	BIT(4)
 
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
 
+#define PSTORE_XBL_COOKIE	0x4c425850 /* "PXBL" in ASCII */
+
+struct pstore_xbl_header {
+	uint32_t cookie;
+	uint32_t size_written;
+};
+
+#define PSTORE_XBL_HDR_SIZE	sizeof(struct pstore_xbl_header)
+
 struct pstore_ftrace_record {
 	unsigned long ip;
 	unsigned long parent_ip;
-- 
1.9.1


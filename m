Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6F3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C6020861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZ9A3QxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C6020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeIGMki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:40:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38602 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeIGMki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:40:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so6231252plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kuvWS+UEUvQZ2xoTaqUxXfZ4y4Bfqw3nkDkVU5NcSio=;
        b=MZ9A3QxJ7yRFgCIEoDFMglvR9MFB25h+UXHZBcN7/UOYpmmUXgi1mSCgTP+t/wweU0
         zwdH74SMalwuKNMY0AKwCfQ5f1pJS+9JZj7BJZoARJLLUyk5aTxJjMD6xisomeA4BNng
         aKJBLMbfPRiLXNAnDCTTDLTUryjVXLq/w4MEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kuvWS+UEUvQZ2xoTaqUxXfZ4y4Bfqw3nkDkVU5NcSio=;
        b=aanWjAZ4+n5ik5EJ3RduIz5j7kAES6xHDElXHexhqIA6Is+R+03C9ju4nuSbfe+FcN
         Gwjdhaejg+nHZZAr9R0mXt3v9CrMlH+OdChaTmN36nQhhD23eKABi2XfYqR2u5PLJs0M
         DGWv31jaIfqO8780UHvDQ7VXZmJCNo5YPLDnFNqPvAe1DN4wo985PddXczVemW4ak/LC
         QcZ3qWkLcyqrcWZr14IcICf+DB2Am6suBdf4KALhrRG7hIgW9+ZuBag0/CP3R3PBgNwe
         EA5nCI2Hb8ZDmP4/5EkAfNg88vJN+129Jc504SpghqcW6chRsfv3G9vfVHcip4ZXg6wV
         LlGQ==
X-Gm-Message-State: APzg51DMZsIimBLmawZrz0Yi0mdLXRKyVQORx8NhR5IOySZDXE1CeD0s
        4axOS3yjDuT76A3bKuSOU8imyw==
X-Google-Smtp-Source: ANB0VdZ4Ph6XxIz7yk79prCPqeUXuq1u+ajtrHhpG1RtU4zn6SjbTbmNVm0JlVhrRYwwT0o2Jm2rtg==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr6654075pld.145.1536307253444;
        Fri, 07 Sep 2018 01:00:53 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id d12-v6sm10819689pfk.69.2018.09.07.01.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 01:00:52 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v14 10/16] arm64: kexec_file: load initrd and device-tree
Date:   Fri,  7 Sep 2018 17:00:34 +0900
Message-Id: <20180907080040.4967-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907080040.4967-1-takahiro.akashi@linaro.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_other_segments() is expected to allocate and place all the necessary
memory segments other than kernel, including initrd and device-tree
blob (and elf core header for crash).
While most of the code was borrowed from kexec-tools' counterpart,
users may not be allowed to specify dtb explicitly, instead, the dtb
presented by the original boot loader is reused.

arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
specific data allocated in load_other_segments().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kexec.h         |  17 +++
 arch/arm64/kernel/machine_kexec_file.c | 188 +++++++++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index e17f0529a882..157b2897d911 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -93,6 +93,23 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_FILE
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	void *dtb;
+	unsigned long dtb_mem;
+};
+
+struct kimage;
+
+extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
+extern int load_other_segments(struct kimage *image,
+		unsigned long kernel_load_addr, unsigned long kernel_size,
+		char *initrd, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index c38a8048ed00..f53f14bd1700 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -5,12 +5,200 @@
  * Copyright (C) 2018 Linaro Limited
  * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  *
+ * Most code is derived from arm64 port of kexec-tools
  */
 
 #define pr_fmt(fmt) "kexec_file: " fmt
 
+#include <linux/ioport.h>
+#include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/libfdt.h>
+#include <linux/memblock.h>
+#include <linux/of_fdt.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+/* relevant device tree properties */
+#define FDT_PSTR_INITRD_STA	"linux,initrd-start"
+#define FDT_PSTR_INITRD_END	"linux,initrd-end"
+#define FDT_PSTR_BOOTARGS	"bootargs"
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	NULL
 };
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->arch.dtb);
+	image->arch.dtb = NULL;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
+
+static int setup_dtb(struct kimage *image,
+		unsigned long initrd_load_addr, unsigned long initrd_len,
+		char *cmdline, unsigned long cmdline_len,
+		void **dtb_buf, unsigned long *dtb_buf_len)
+{
+	void *buf = NULL;
+	size_t buf_size;
+	int nodeoffset;
+	int ret;
+
+	/* duplicate dt blob */
+	buf_size = fdt_totalsize(initial_boot_params);
+
+	if (initrd_load_addr) {
+		/* can be redundant, but trimmed at the end */
+		buf_size += fdt_prop_len(FDT_PSTR_INITRD_STA, sizeof(u64));
+		buf_size += fdt_prop_len(FDT_PSTR_INITRD_END, sizeof(u64));
+	}
+
+	if (cmdline)
+		/* can be redundant, but trimmed at the end */
+		buf_size += fdt_prop_len(FDT_PSTR_BOOTARGS, cmdline_len);
+
+	buf = vmalloc(buf_size);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	ret = fdt_open_into(initial_boot_params, buf, buf_size);
+	if (ret) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	nodeoffset = fdt_path_offset(buf, "/chosen");
+	if (nodeoffset < 0) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	/* add bootargs */
+	if (cmdline) {
+		ret = fdt_setprop_string(buf, nodeoffset, FDT_PSTR_BOOTARGS,
+							cmdline);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	} else {
+		ret = fdt_delprop(buf, nodeoffset, FDT_PSTR_BOOTARGS);
+		if (ret && (ret != -FDT_ERR_NOTFOUND)) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	}
+
+	/* add initrd-* */
+	if (initrd_load_addr) {
+		ret = fdt_setprop_u64(buf, nodeoffset, FDT_PSTR_INITRD_STA,
+							initrd_load_addr);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+
+		ret = fdt_setprop_u64(buf, nodeoffset, FDT_PSTR_INITRD_END,
+						initrd_load_addr + initrd_len);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	} else {
+		ret = fdt_delprop(buf, nodeoffset, FDT_PSTR_INITRD_STA);
+		if (ret && (ret != -FDT_ERR_NOTFOUND)) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+
+		ret = fdt_delprop(buf, nodeoffset, FDT_PSTR_INITRD_END);
+		if (ret && (ret != -FDT_ERR_NOTFOUND)) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	}
+
+	/* trim a buffer */
+	fdt_pack(buf);
+	*dtb_buf = buf;
+	*dtb_buf_len = fdt_totalsize(buf);
+
+	return 0;
+
+out_err:
+	vfree(buf);
+	return ret;
+}
+
+int load_other_segments(struct kimage *image,
+			unsigned long kernel_load_addr,
+			unsigned long kernel_size,
+			char *initrd, unsigned long initrd_len,
+			char *cmdline, unsigned long cmdline_len)
+{
+	struct kexec_buf kbuf;
+	void *dtb = NULL;
+	unsigned long initrd_load_addr = 0, dtb_len;
+	int ret = 0;
+
+	kbuf.image = image;
+	/* not allocate anything below the kernel */
+	kbuf.buf_min = kernel_load_addr + kernel_size;
+
+	/* load initrd */
+	if (initrd) {
+		kbuf.buffer = initrd;
+		kbuf.bufsz = initrd_len;
+		kbuf.mem = 0;
+		kbuf.memsz = initrd_len;
+		kbuf.buf_align = 0;
+		/* within 1GB-aligned window of up to 32GB in size */
+		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
+						+ (unsigned long)SZ_1G * 32;
+		kbuf.top_down = false;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret)
+			goto out_err;
+		initrd_load_addr = kbuf.mem;
+
+		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				initrd_load_addr, initrd_len, initrd_len);
+	}
+
+	/* load dtb blob */
+	ret = setup_dtb(image, initrd_load_addr, initrd_len,
+				cmdline, cmdline_len, &dtb, &dtb_len);
+	if (ret) {
+		pr_err("Preparing for new dtb failed\n");
+		goto out_err;
+	}
+
+	kbuf.buffer = dtb;
+	kbuf.bufsz = dtb_len;
+	kbuf.mem = 0;
+	kbuf.memsz = dtb_len;
+	/* not across 2MB boundary */
+	kbuf.buf_align = SZ_2M;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = true;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out_err;
+	image->arch.dtb = dtb;
+	image->arch.dtb_mem = kbuf.mem;
+
+	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			kbuf.mem, dtb_len, dtb_len);
+
+	return 0;
+
+out_err:
+	vfree(dtb);
+	return ret;
+}
-- 
2.18.0


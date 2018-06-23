Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BF3C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B385A24AC2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrL3/FYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B385A24AC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934853AbeFWCVk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:21:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40273 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934528AbeFWCVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:21:36 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so4273301plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Buhnia0QVhj7ctfiyaB/peBEFNlYmg9JmdMmp9kLmE=;
        b=DrL3/FYhSkz25qJ83t0nut98E0UvFGn62wvP7jAFc7DQIs+QtQZtQnz+/ZIKLJt+Jn
         Oq2mzAmf1OSAINcNO8soTnJl+bRvGylqrPAGHq3SJboAwnOFA+imgdy7TKIRXdW/2oYS
         BPdvZnC3Zxw2/00NVS4lqI/zAniAvAgKv88KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Buhnia0QVhj7ctfiyaB/peBEFNlYmg9JmdMmp9kLmE=;
        b=j8ppOUE0SAhWHIEQ3bkhm+rhg+uQGiLt6KSI/GXzjEv3o8xUnJUklvxAfHvPkogvC1
         q5kBiBKj9Bq4vBzCHFeXGu4r9IAXh5bL/obZDXhB6EK1msLDN7nHR6dodeui8rP7dY38
         0CjyF8NDAndT8cN5WF8K7GFJTGSXeUfZ8W5Y7Qa+tMkqHH5kDYCZHb9fuI+3lU/lnLHD
         pCWK8fFuR5dCldC2j8DDvPYN/QYjfByfjvKWCMUqAmJN9CRSkW8XWApX5Jn3yDynAYeR
         G7UVsm3j8Nsea686USzt1J3GFRGUvsh8gS37qlvukuoPwK30Z9hrkdN7hTBkU5dUjuGu
         PNGg==
X-Gm-Message-State: APt69E0YD42M9GApUfWj1yvyOQ7acWA2oJuBEC06LYvoPoGASh4WHXF8
        HGuYyg2qqKSzanHboxMrXvmpTg==
X-Google-Smtp-Source: ADUXVKJHViPHl35q8q/I3YfBb086ita9qaXH5hl039jgN28AIJmB9LYttFSFgfYRZ1NkUS1qLZkQew==
X-Received: by 2002:a17:902:1a2:: with SMTP id b31-v6mr3784832plb.279.1529720496230;
        Fri, 22 Jun 2018 19:21:36 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id d18-v6sm13045111pfn.118.2018.06.22.19.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:21:35 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 10/14] arm64: kexec_file: add crash dump support
Date:   Sat, 23 Jun 2018 11:20:54 +0900
Message-Id: <20180623022058.10935-11-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling crash dump (kdump) includes
* prepare contents of ELF header of a core dump file, /proc/vmcore,
  using crash_prepare_elf64_headers(), and
* add two device tree properties, "linux,usable-memory-range" and
  "linux,elfcorehdr", which represent repsectively a memory range
  to be used by crash dump kernel and the header's location

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/kexec_image.c        |   9 +-
 arch/arm64/kernel/machine_kexec_file.c | 114 ++++++++++++++++++++++++-
 3 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 69333694e3e2..eeb5766928b0 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -99,6 +99,10 @@ static inline void crash_post_resume(void) {}
 struct kimage_arch {
 	phys_addr_t dtb_mem;
 	void *dtb_buf;
+	/* Core ELF header buffer */
+	void *elf_headers;
+	unsigned long elf_headers_sz;
+	unsigned long elf_load_addr;
 };
 
 /**
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index a47cf9bc699e..df1e341d3a28 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -67,8 +67,13 @@ static void *image_load(struct kimage *image,
 
 	/* Load the kernel */
 	kbuf.image = image;
-	kbuf.buf_min = 0;
-	kbuf.buf_max = ULONG_MAX;
+	if (image->type == KEXEC_TYPE_CRASH) {
+		kbuf.buf_min = crashk_res.start;
+		kbuf.buf_max = crashk_res.end + 1;
+	} else {
+		kbuf.buf_min = 0;
+		kbuf.buf_max = ULONG_MAX;
+	}
 	kbuf.top_down = false;
 
 	kbuf.buffer = kernel;
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 199e86e791c9..6aec996d015a 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,7 +16,9 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 #include <asm/byteorder.h>
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
@@ -29,6 +31,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->arch.dtb_buf);
 	image->arch.dtb_buf = NULL;
 
+	vfree(image->arch.elf_headers);
+	image->arch.elf_headers = NULL;
+	image->arch.elf_headers_sz = 0;
+
 	return kexec_image_post_load_cleanup_default(image);
 }
 
@@ -38,13 +44,31 @@ static int setup_dtb(struct kimage *image,
 		char **dtb_buf, size_t *dtb_buf_len)
 {
 	char *buf = NULL;
-	size_t buf_size;
+	size_t buf_size, range_size;
 	int nodeoffset;
 	u64 value;
 	int ret;
 
+	/* check ranges against root's #address-cells and #size-cells */
+	if (image->type == KEXEC_TYPE_CRASH &&
+		(!of_fdt_cells_size_fitted(image->arch.elf_load_addr,
+				image->arch.elf_headers_sz) ||
+		 !of_fdt_cells_size_fitted(crashk_res.start,
+				crashk_res.end - crashk_res.start + 1))) {
+		pr_err("Crash memory region doesn't fit into DT's root cell sizes.\n");
+		ret = -EINVAL;
+		goto out_err;
+	}
+
 	/* duplicate dt blob */
 	buf_size = fdt_totalsize(initial_boot_params);
+	range_size = of_fdt_reg_cells_size();
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		buf_size += fdt_prop_len("linux,elfcorehdr", range_size);
+		buf_size += fdt_prop_len("linux,usable-memory-range",
+								range_size);
+	}
 
 	if (initrd_load_addr) {
 		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64));
@@ -68,6 +92,23 @@ static int setup_dtb(struct kimage *image,
 	if (nodeoffset < 0)
 		goto out_err;
 
+	if (image->type == KEXEC_TYPE_CRASH) {
+		/* add linux,elfcorehdr */
+		ret = fdt_setprop_reg(buf, nodeoffset, "linux,elfcorehdr",
+				image->arch.elf_load_addr,
+				image->arch.elf_headers_sz);
+		if (ret)
+			goto out_err;
+
+		/* add linux,usable-memory-range */
+		ret = fdt_setprop_reg(buf, nodeoffset,
+				"linux,usable-memory-range",
+				crashk_res.start,
+				crashk_res.end - crashk_res.start + 1);
+		if (ret)
+			goto out_err;
+	}
+
 	/* add bootargs */
 	if (cmdline) {
 		ret = fdt_setprop(buf, nodeoffset, "bootargs",
@@ -103,6 +144,45 @@ static int setup_dtb(struct kimage *image,
 	return ret;
 }
 
+static int prepare_elf_headers(void **addr, unsigned long *sz)
+{
+	struct crash_mem *cmem;
+	unsigned int nr_ranges;
+	int ret;
+	u64 i;
+	phys_addr_t start, end;
+
+	nr_ranges = 1; /* for exclusion of crashkernel region */
+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
+							&start, &end, NULL)
+		nr_ranges++;
+
+	cmem = kmalloc(sizeof(struct crash_mem) +
+			sizeof(struct crash_mem_range) * nr_ranges, GFP_KERNEL);
+	if (!cmem)
+		return -ENOMEM;
+
+	cmem->max_nr_ranges = nr_ranges;
+	cmem->nr_ranges = 0;
+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
+							&start, &end, NULL) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
+
+	/* Exclude crashkernel region */
+	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (ret)
+		goto out;
+
+	ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+
+out:
+	kfree(cmem);
+	return ret;
+}
+
 int load_other_segments(struct kimage *image,
 			unsigned long kernel_load_addr,
 			unsigned long kernel_size,
@@ -110,11 +190,43 @@ int load_other_segments(struct kimage *image,
 			char *cmdline, unsigned long cmdline_len)
 {
 	struct kexec_buf kbuf;
+	void *hdrs_addr;
+	unsigned long hdrs_sz;
 	unsigned long initrd_load_addr = 0;
 	char *dtb = NULL;
 	unsigned long dtb_len = 0;
 	int ret = 0;
 
+	/* load elf core header */
+	if (image->type == KEXEC_TYPE_CRASH) {
+		ret = prepare_elf_headers(&hdrs_addr, &hdrs_sz);
+		if (ret) {
+			pr_err("Preparing elf core header failed\n");
+			goto out_err;
+		}
+
+		kbuf.image = image;
+		kbuf.buffer = hdrs_addr;
+		kbuf.bufsz = hdrs_sz;
+		kbuf.memsz = hdrs_sz;
+		kbuf.buf_align = PAGE_SIZE;
+		kbuf.buf_min = crashk_res.start;
+		kbuf.buf_max = crashk_res.end + 1;
+		kbuf.top_down = true;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret) {
+			vfree(hdrs_addr);
+			goto out_err;
+		}
+		image->arch.elf_headers = hdrs_addr;
+		image->arch.elf_headers_sz = hdrs_sz;
+		image->arch.elf_load_addr = kbuf.mem;
+
+		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				 image->arch.elf_load_addr, hdrs_sz, hdrs_sz);
+	}
+
 	kbuf.image = image;
 	/* not allocate anything below the kernel */
 	kbuf.buf_min = kernel_load_addr + kernel_size;
-- 
2.17.0


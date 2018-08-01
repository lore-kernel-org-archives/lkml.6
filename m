Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79542C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B7020841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BSn0QXX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B7020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbeHAJo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:44:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43977 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbeHAJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:44:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so7426398pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xe+ptcwA2jG1hIMUvqrzyq16x2eFJronfOhv7p2qODs=;
        b=BSn0QXX2DBmorvj8lIohJ2EXbUkxGkvf9BWUMTCPj0C+zsVYWHajL6qt2nEpp36NHU
         ivtJD62+dbbvT+3ey7XwnY86eKaD3mRNJG77m20YixjoQRDAp/A9VNVo5eYkommzuP+N
         dhKyRRvY41Udtd0ByQ+Jkr7UmtoDu4iGxn9qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xe+ptcwA2jG1hIMUvqrzyq16x2eFJronfOhv7p2qODs=;
        b=eJqjVZvZ9xFAZ5dsUMKi4dES32gVZhfCwreMJEyhanAtwfDOKmY0JYFmgurSqG52zy
         Rpkgc19iVbtuwVplZYYvLvX5dOO9bbBZ0ejQf7qxHdMgb+LuvtEBXj/3uux76YbbGEQX
         wSL/i43XuGDTzfItepujz8ivMyKe04i418DJo1O01zZ7kCvWqwxJXA0W68NyQLAivp2g
         HHfqUBXWrq36TTbTsgJMXCgQpqN/RBeOA2/3aEGH1ggPowq/gGJfR2s5d7MECNxjYNMM
         VCWJmUcPW8LPG6Lza4DpPqI/XHoNUFmskYXNsaZjst7uZ/FAoSyAmw2btCM/c1ME3/oX
         0Q+w==
X-Gm-Message-State: AOUpUlH9cZgUvN4UK/HnDk2/kur0drGg/ivuiATNPcZNdvQj2afIxAsh
        bGA1VxxgUSe0ax0GeZ4wU/n8kQ==
X-Google-Smtp-Source: AAOMgpfVXC7sXZf8XalxAV+Bt4OypVAPPERv9jx0sP5G5qzR9oVyBId3lcK0rrX19+7gHXDKuuKvrw==
X-Received: by 2002:a62:25c5:: with SMTP id l188-v6mr25450400pfl.179.1533110400872;
        Wed, 01 Aug 2018 01:00:00 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id p3-v6sm21954094pfo.130.2018.08.01.00.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:00:00 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v13 04/16] powerpc, kexec_file: factor out memblock-based arch_kexec_walk_mem()
Date:   Wed,  1 Aug 2018 16:58:08 +0900
Message-Id: <20180801075820.3753-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memblock list is another source for usable system memory layout.
So move powerpc's arch_kexec_walk_mem() to common code so that other
memblock-based architectures, particularly arm64, can also utilise it.
A moved function is now renamed to kexec_walk_memblock() and integrated
into kexec_locate_mem_hole(), which will now be usable for all
architectures with no need for overriding arch_kexec_walk_mem().

With this change, arch_kexec_walk_mem() need no longer be a weak function,
and was now renamed to kexec_walk_resources().

Since powerpc doesn't support kdump in its kexec_file_load(), the current
kexec_walk_memblock() won't work for kdump either in this form, this will
be fixed in the next patch.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/powerpc/kernel/machine_kexec_file_64.c | 54 -------------------
 include/linux/kexec.h                       |  2 -
 kernel/kexec_file.c                         | 60 +++++++++++++++++++--
 3 files changed, 57 insertions(+), 59 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index 0bd23dc789a4..5357b09902c5 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -24,7 +24,6 @@
 
 #include <linux/slab.h>
 #include <linux/kexec.h>
-#include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <asm/ima.h>
@@ -46,59 +45,6 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 	return kexec_image_probe_default(image, buf, buf_len);
 }
 
-/**
- * arch_kexec_walk_mem - call func(data) for each unreserved memory block
- * @kbuf:	Context info for the search. Also passed to @func.
- * @func:	Function to call for each memory block.
- *
- * This function is used by kexec_add_buffer and kexec_locate_mem_hole
- * to find unreserved memory to load kexec segments into.
- *
- * Return: The memory walk will stop when func returns a non-zero value
- * and that value will be returned. If all free regions are visited without
- * func returning non-zero, then zero will be returned.
- */
-int arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			int (*func)(struct resource *, void *))
-{
-	int ret = 0;
-	u64 i;
-	phys_addr_t mstart, mend;
-	struct resource res = { };
-
-	if (kbuf->top_down) {
-		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
-						&mstart, &mend, NULL) {
-			/*
-			 * In memblock, end points to the first byte after the
-			 * range while in kexec, end points to the last byte
-			 * in the range.
-			 */
-			res.start = mstart;
-			res.end = mend - 1;
-			ret = func(&res, kbuf);
-			if (ret)
-				break;
-		}
-	} else {
-		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
-					NULL) {
-			/*
-			 * In memblock, end points to the first byte after the
-			 * range while in kexec, end points to the last byte
-			 * in the range.
-			 */
-			res.start = mstart;
-			res.end = mend - 1;
-			ret = func(&res, kbuf);
-			if (ret)
-				break;
-		}
-	}
-
-	return ret;
-}
-
 /**
  * setup_purgatory - initialize the purgatory's global variables
  * @image:		kexec image.
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 49ab758f4d91..c196bfd11bee 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -184,8 +184,6 @@ int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
 					const Elf_Shdr *relsec,
 					const Elf_Shdr *symtab);
 
-int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			       int (*func)(struct resource *, void *));
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bf39df5e5bb9..1073ef56a95d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -16,6 +16,7 @@
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/kexec.h>
+#include <linux/memblock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/fs.h>
@@ -501,6 +502,55 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
+static int kexec_walk_memblock(struct kexec_buf *kbuf,
+			       int (*func)(struct resource *, void *))
+{
+	int ret = 0;
+	u64 i;
+	phys_addr_t mstart, mend;
+	struct resource res = { };
+
+	if (kbuf->top_down) {
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+						&mstart, &mend, NULL) {
+			/*
+			 * In memblock, end points to the first byte after the
+			 * range while in kexec, end points to the last byte
+			 * in the range.
+			 */
+			res.start = mstart;
+			res.end = mend - 1;
+			ret = func(&res, kbuf);
+			if (ret)
+				break;
+		}
+	} else {
+		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
+					NULL) {
+			/*
+			 * In memblock, end points to the first byte after the
+			 * range while in kexec, end points to the last byte
+			 * in the range.
+			 */
+			res.start = mstart;
+			res.end = mend - 1;
+			ret = func(&res, kbuf);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+#else
+static int kexec_walk_memblock(struct kexec_buf *kbuf,
+			       int (*func)(struct resource *, void *))
+{
+	return 0;
+}
+#endif
+
 /**
  * arch_kexec_walk_mem - call func(data) on free memory regions
  * @kbuf:	Context info for the search. Also passed to @func.
@@ -510,8 +560,8 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
  * and that value will be returned. If all free regions are visited without
  * func returning non-zero, then zero will be returned.
  */
-int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			       int (*func)(struct resource *, void *))
+static int kexec_walk_resources(struct kexec_buf *kbuf,
+				int (*func)(struct resource *, void *))
 {
 	if (kbuf->image->type == KEXEC_TYPE_CRASH)
 		return walk_iomem_res_desc(crashk_res.desc,
@@ -538,7 +588,11 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	if (kbuf->mem)
 		return 0;
 
-	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
+	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
+			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
+		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
+	else
+		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
-- 
2.18.0


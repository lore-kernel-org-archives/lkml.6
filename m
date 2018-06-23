Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD22FC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4B724AB5
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpvK8BfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4B724AB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934736AbeFWCU6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:20:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38203 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934528AbeFWCUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:20:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id a1-v6so140504pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ud5nvphvoW/NQdtNnrXCOa4yIIIYmgsYS/42liQ8pyI=;
        b=GpvK8BfYV/Y6hC58cz/x4l54QUgma8GnXGmM9l+ltwtLH8XQZBULAhfutql2zlZ8ob
         nam+DgHqkDzs9/ydCS6rdF5oouTRSV0YciQCjPZny3+UmnDwQljDnzEUSTjqQS4mAqCz
         a01qFgP1JINQyQJrWtNaYeJ/96n8m8XEZODjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ud5nvphvoW/NQdtNnrXCOa4yIIIYmgsYS/42liQ8pyI=;
        b=EKbpknst/bK9AdT5TcH6nhru8KVa1vreNhWVhyJtBiuhMqVBhXUQybRaZKKyHYxiTf
         gWApHxaNEqY3b/HKNvPRZaLIPa/rg4vc0NRXHpViX14Q4fKW2RJHS5NO5PqppT6U2/m2
         EejNhM3LXmvax1QTmtR+XtBXkFgwX8ovwgZDtr66VDGmV4jkPlhzklgm/hKut7d/c9SL
         VN7Hnn/amBAJsrcjFYvgruijfQkwbzSJPzt5/0KvKaAGnVWaOaD8W9w94UENCKVhKT4t
         74vy1GrSZ3dZe+VR7lH2kzrM5nyFwxmSgTv6nna081BwCgLtUBAjxmI6VvlODlDmBHx7
         l5rQ==
X-Gm-Message-State: APt69E0vzXZI2bgxp0uXDPP9mO8Qo0dtAayrqGzEHpHkbHm0CbB+qL8k
        IMKJjC9D+Hf89tmzTRMmzBmuDBcaf0E=
X-Google-Smtp-Source: ADUXVKICHciX9Tt/2OOU2PwVTfRv+aeJSYPhV81QWp04EzyzrqAu/ONHNPMHwlJ+srEWCBMEQBmyCg==
X-Received: by 2002:aa7:8058:: with SMTP id y24-v6mr4086982pfm.148.1529720454630;
        Fri, 22 Jun 2018 19:20:54 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id m5-v6sm32427449pfa.93.2018.06.22.19.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:20:54 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v10 03/14] powerpc, kexec_file: factor out memblock-based arch_kexec_walk_mem()
Date:   Sat, 23 Jun 2018 11:20:47 +0900
Message-Id: <20180623022058.10935-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memblock list is another source for usable system memory layout.
A merged new arch_kexec_walk_mem() will walk through either io resource
list or memblock list depending on CONFIG_ARCH_DISCARD_MEMBLOCK so that
arm64, in addition to powerpc, will be able to utilize this generic
function for kexec_file.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/kernel/machine_kexec_file_64.c | 53 ---------------------
 kernel/kexec_file.c                         | 52 ++++++++++++++++++++
 2 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index 0bd23dc789a4..3d4be91786ce 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -46,59 +46,6 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
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
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 63c7ce1c0c3e..563acd1c9a61 100644
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
@@ -501,6 +502,53 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
+static int kexec_walk_memblock(struct kexec_buf *kbuf,
+			       int (*func)(struct resource *, void *))
+{
+	u64 i;
+	phys_addr_t mstart, mend;
+	struct resource res = { };
+	int ret = 0;
+
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
+	/*
+	 * In memblock, end points to the first byte after the
+	 * range while in kexec, end points to the last byte
+	 * in the range.
+	 */
+	if (kbuf->top_down) {
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+					&mstart, &mend, NULL) {
+			res.start = mstart;
+			res.end = mend - 1;
+			ret = func(&res, kbuf);
+			if (ret)
+				break;
+		}
+	} else {
+		for_each_free_mem_range(i, NUMA_NO_NODE, 0,
+					&mstart, &mend, NULL) {
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
@@ -513,6 +561,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(struct resource *, void *))
 {
+	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
+			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
+		return kexec_walk_memblock(kbuf, func);
+
 	if (kbuf->image->type == KEXEC_TYPE_CRASH)
 		return walk_iomem_res_desc(crashk_res.desc,
 					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-- 
2.17.0


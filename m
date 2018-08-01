Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B44C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF7220841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WU9YMzQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF7220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbeHAJqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:46:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41264 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbeHAJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:46:07 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so8412783ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hvAWBPxjHLCiuG/UDQDc1Nu8BX1v01gDGjuspChhtac=;
        b=WU9YMzQPUTnoNa5HnOw5eBPp1T5wlr/z+viQAp2LZ9cSIxO8ipv2mPcyWDp4ZgzUnT
         WyDkooAOOzxEqlB8kLCDABQO2QVOlRMhZB3KkEfJ6khFhMadGcYSqYRkkKUVjBl0VlbF
         VK+VT5wZGhXDfPxb5LJtU9vUnaUx9zApOz56g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hvAWBPxjHLCiuG/UDQDc1Nu8BX1v01gDGjuspChhtac=;
        b=saAK6TY3DBTkCmVUqdzuwQ9SNCC1150rj9tHYqhSEqDZPkc2vpCIqFJ82eNjOLiyTf
         lOR8sVKQCYZWgGddpvOHDXRvHVZjKuI8tbsm/6ufKk/9TOEBGHiamIkfKLju+vNo9+Ot
         nOWVCvExs4cYCCf/4CflHlBal2Q3tCpWkMxQi2eGWw8/l2QjSdgujhpRpLVcDVwnmHyw
         i+VG4R3P+v8V++ilnldcg6i/aLhiTTedwQ/y5iSkWJ+q30JDRZ2P6FX6160SsA7NfcY5
         6f/4i/T12u73FECziBdkch475pqDCS/Jq3AarnwmsEqyfEpowL7Qwhps/YlviHfzW/vh
         ZXCA==
X-Gm-Message-State: AOUpUlFT3+jXRyRPEotMf90jPl1T7/pbZd4nShDVe60Ptcde0oQaFOEm
        BQGgKIpJDuCqAq7de7Jz8cppMA==
X-Google-Smtp-Source: AAOMgpc9REI6aVelkbglbYXZ6kN1MPtdeNrBpOYh1cbBmeNoNQloeUWdSAIYwEuY2aZMgvoRMNx5cg==
X-Received: by 2002:a17:902:e005:: with SMTP id ca5-v6mr23681465plb.224.1533110500350;
        Wed, 01 Aug 2018 01:01:40 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id y3-v6sm46126520pfi.24.2018.08.01.01.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:01:39 -0700 (PDT)
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
Subject: [PATCH v13 16/16] arm64: kexec_file: add kaslr support
Date:   Wed,  1 Aug 2018 16:58:20 +0900
Message-Id: <20180801075820.3753-17-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
address randomization, at secondary kernel boot. We always do this as
it will have no harm on kaslr-incapable kernel.

We don't have any "switch" to turn off this feature directly, but still
can suppress it by passing "nokaslr" as a kernel boot argument.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index ecaecb122cad..967db9824e3f 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,6 +16,7 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
@@ -27,6 +28,7 @@
 #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
 #define FDT_PSTR_INITRD_END	"linux,initrd-end"
 #define FDT_PSTR_BOOTARGS	"bootargs"
+#define FDT_PSTR_KASLR_SEED	"kaslr-seed"
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
@@ -45,6 +47,32 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
+/* crng needs to have been initialized for providing kaslr-seed */
+static int random_ready;
+
+static void random_ready_notified(struct random_ready_callback *unused)
+{
+	random_ready = 1;
+}
+
+static struct random_ready_callback random_ready_cb = {
+	.func = random_ready_notified,
+};
+
+static __init int init_random_ready_cb(void)
+{
+	int ret;
+
+	ret = add_random_ready_callback(&random_ready_cb);
+	if (ret == -EALREADY)
+		random_ready = 1;
+	else if (ret)
+		pr_warn("failed to add a callback for random_ready\n");
+
+	return 0;
+}
+late_initcall(init_random_ready_cb)
+
 static int setup_dtb(struct kimage *image,
 		unsigned long initrd_load_addr, unsigned long initrd_len,
 		char *cmdline, unsigned long cmdline_len,
@@ -53,6 +81,7 @@ static int setup_dtb(struct kimage *image,
 	void *buf = NULL;
 	size_t buf_size, range_size;
 	int nodeoffset;
+	u64 value;
 	int ret;
 
 	/* check ranges against root's #address-cells and #size-cells */
@@ -85,6 +114,8 @@ static int setup_dtb(struct kimage *image,
 		/* can be redundant, but trimmed at the end */
 		buf_size += fdt_prop_len(FDT_PSTR_BOOTARGS, cmdline_len);
 
+	buf_size += fdt_prop_len(FDT_PSTR_KASLR_SEED, sizeof(u64));
+
 	buf = vmalloc(buf_size);
 	if (!buf) {
 		ret = -ENOMEM;
@@ -164,6 +195,20 @@ static int setup_dtb(struct kimage *image,
 		}
 	}
 
+	/* add kaslr-seed */
+	fdt_delprop(buf, nodeoffset, FDT_PSTR_KASLR_SEED);
+	if (random_ready) {
+		get_random_bytes(&value, sizeof(value));
+		ret = fdt_setprop_u64(buf, nodeoffset, FDT_PSTR_KASLR_SEED,
+							value);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	} else {
+		pr_notice("kaslr-seed won't be fed\n");
+	}
+
 	/* trim a buffer */
 	fdt_pack(buf);
 	*dtb_buf = buf;
-- 
2.18.0


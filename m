Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3AAC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5183720854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eekxUjV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5183720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbeGKHqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:46:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42220 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeGKHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:46:17 -0400
Received: by mail-pf0-f194.google.com with SMTP id l9-v6so6238943pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IhXU1taVFqTvONKqzouhydG5S7Jk/KaBxJ/e0+WeXgw=;
        b=eekxUjV21HslWOHRESAr06L0Kztm+FKq2OFDkoPcAr+yWsaGuXIQFf2ChsDETAo8V1
         kdb+Qd7+i9Kq0EobklijY/i+iCpJ3ba5J8KWnrVcEA2ey8ZR6QZFOpqTtcjrq96yRDja
         8sGI6sSDNFbVpnDPOYLscJ+dPMmD/gsZr2RUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IhXU1taVFqTvONKqzouhydG5S7Jk/KaBxJ/e0+WeXgw=;
        b=D9MB0U9Xw3lGkIDtUGUCwxvahk0nxHjniZ6cuWk9TvDVYzFgP6kDVyAef1pS3t+Axu
         a1Oo0XVf57Q8a8MYO/Q4s4AcWDMiMisj0azGBn5P8230gr7iUnG2EIhzchNFos1n9Owk
         ZYE1T+luElsS2/yplc5asYO/9dQIgh9FJJntXLNzoQGIBROSEzESsgdtESpqyBsWhHy+
         dcvvR3wul9p6cTrxuuGl94xMznqT873sYEW+lYDDFAuNG/NtVGCKO0Vi+y4+JszGoBli
         f+g5bqkkgER3JD5vjQIm6w9DiBMAKov6XgIs9IoBh8e0UbBMz2+UXYo8Rgp3MKIOQ+SX
         nS8w==
X-Gm-Message-State: APt69E2LksjPPIkUUFAPEGBFhf1tuaoNdxNWGSfNHHeQhKR1ZaxgOz4h
        Ei7VVF+YTT5bmmcHKfrhTq7lVw==
X-Google-Smtp-Source: AAOMgpe7KUObUERCYs4GhLO3asB1/y7ZLD/sUIH9aL2QZ6bVBGpZUeCl2EL12PGWZQWYqEKb3QnHrA==
X-Received: by 2002:a62:ec41:: with SMTP id k62-v6mr28760983pfh.206.1531295000777;
        Wed, 11 Jul 2018 00:43:20 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id w123-v6sm33118200pfb.38.2018.07.11.00.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:43:20 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v11 14/15] arm64: kexec_file: add kernel signature verification support
Date:   Wed, 11 Jul 2018 16:42:02 +0900
Message-Id: <20180711074203.3019-15-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch, kernel verification can be done without IMA security
subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.

On x86, a signature is embedded into a PE file (Microsoft's format) header
of binary. Since arm64's "Image" can also be seen as a PE file as far as
CONFIG_EFI is enabled, we adopt this format for kernel signing.

You can create a signed kernel image with:
    $ sbsign --key ${KEY} --cert ${CERT} Image

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig              | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c | 15 +++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a9a3a5583c8b..1445eb2fc833 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -844,6 +844,30 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
+config KEXEC_VERIFY_SIG
+	bool "Verify kernel signature during kexec_file_load() syscall"
+	depends on KEXEC_FILE
+	help
+	  Select this option to verify a signature with loaded kernel
+	  image. If configured, any attempt of loading a image without
+	  valid signature will fail.
+
+	  In addition to that option, you need to enable signature
+	  verification for the corresponding kernel image type being
+	  loaded in order for this to work.
+
+config KEXEC_IMAGE_VERIFY_SIG
+	bool "Enable Image signature verification support"
+	default y
+	depends on KEXEC_VERIFY_SIG
+	depends on EFI && SIGNED_PE_FILE_VERIFICATION
+	help
+	  Enable Image signature verification support.
+
+comment "Support for PE file signature verification disabled"
+	depends on KEXEC_VERIFY_SIG
+	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index df1e341d3a28..bb0a95add197 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/string.h>
+#include <linux/verification.h>
 #include <asm/boot.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
@@ -28,6 +29,9 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
 			!memcmp(&h->magic, ARM64_MAGIC, sizeof(ARM64_MAGIC)))
 		return -EINVAL;
 
+	pr_debug("PE format: %s\n",
+			memcmp(&h->mz_magic, "MZ", 2) ?  "no" : "yes");
+
 	return 0;
 }
 
@@ -107,7 +111,18 @@ static void *image_load(struct kimage *image,
 	return ERR_PTR(ret);
 }
 
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+static int image_verify_sig(const char *kernel, unsigned long kernel_len)
+{
+	return verify_pefile_signature(kernel, kernel_len, NULL,
+				       VERIFYING_KEXEC_PE_SIGNATURE);
+}
+#endif
+
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+	.verify_sig = image_verify_sig,
+#endif
 };
-- 
2.17.0


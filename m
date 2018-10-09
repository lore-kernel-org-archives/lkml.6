Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD3BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A48214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3y9/iks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A48214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJJAcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:32:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38913 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJAcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:32:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so2672020wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixmq0eTdX6XQdK50jLnhNrpgIWjhAAnM3DDCvlSc1f0=;
        b=L3y9/iksAIKE2JGWKiRt9NRvPE7HaQmoxOvhJlD05571FUQq3Z8nz1iNeZt7LdH1fR
         hrACy4j/8cA51P2eQMa11slap3S/VxYg3EieuSSx4TCDlW53zwirKRy9q5p7h0SQwS5l
         /2qpaFv5ENThILHgO2jdRkDwHNXlHUjO/74ZI5KKTt5QsT2r0R+F99YaSem353IkjqoZ
         LYYSwrb4/dx0L4cZ8u4bLy9wyUjJrVw1WhRYaAr6TILLtNcpUxJOJBdDTXOtiz8YDOvP
         76L3iDIdj/PFyeo2VI7sjBa8kQqR3IFy35qz0n6o2F5lUV3yVrxNa+G/WQcqN52MS0FB
         kkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixmq0eTdX6XQdK50jLnhNrpgIWjhAAnM3DDCvlSc1f0=;
        b=VCITDtvqgkN7HqCQ1QNgr2DKA6iIBxw3eSAd+ShNbVoMt3/NsJ6h8YnF1JOF2gqOZl
         nfWL57c9eZrM6JwGCWKkzwy9FP/4QaRQgUxqw0cL8cMm8CoFzz4UdY/CEIvOlEpWarOx
         xy58htn7XYkfLSlHkyCrtQLwTfsyrNldhiy6EMctTQACP6bmYTkYdsZDISqQ1gItlMvM
         wZ1z95ajBQi29hslNP8epzzdWKP3Gp+Js1FiYVw8oHu2mDSEqxC0PTezcDrrO+/hiEVG
         wEsI1aDENnz6/BZbdXrj0xcL2dsD/2XCSjLzAl7s+M56RhGqXXmChvN/cra+G8mU6Uyq
         5F7w==
X-Gm-Message-State: ABuFfoiQ2kCKJSnXX461EaG/STw9yjwha+s7xjiwK2aFwmkw4tH0aC5w
        oRs8oiHualmujA04/PdQjjs=
X-Google-Smtp-Source: ACcGV62t6G5rgbTtWcsN9KvMI9e1kauB2U2o+0sIhHRW//wXRAiGSF9vrYzOAQ73unsh5H4alVbArw==
X-Received: by 2002:a5d:680b:: with SMTP id w11-v6mr19087047wru.186.1539105265109;
        Tue, 09 Oct 2018 10:14:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f1-v6sm13467468wme.23.2018.10.09.10.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 10:14:24 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/i915: Convert _print_param to a macro
Date:   Tue,  9 Oct 2018 10:14:01 -0700
Message-Id: <20181009171401.14980-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with Clang with defconfig and CONFIG_64BIT
disabled, vmlinux fails to link because of the BUILD_BUG in
_print_param.

ld: drivers/gpu/drm/i915/i915_params.o: in function `i915_params_dump':
i915_params.c:(.text+0x56): undefined reference to
`__compiletime_assert_191'

This function is semantically invalid unless the code is first inlined
then constant folded, which doesn't work for Clang because semantic
analysis happens before optimization/inlining. Converting this function
to a macro avoids this problem and allows Clang to properly remove the
BUILD_BUG during optimization.

The output of 'objdump -D' is identically before and after this change
for GCC regardless of if CONFIG_64BIT is set and allows Clang to link
the kernel successfully with or without CONFIG_64BIT set.

Link: https://github.com/ClangBuiltLinux/linux/issues/191
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/i915/i915_params.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 295e981e4a39..a0f20b9b6f2d 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -174,22 +174,19 @@ i915_param_named(enable_dpcd_backlight, bool, 0600,
 i915_param_named(enable_gvt, bool, 0400,
 	"Enable support for Intel GVT-g graphics virtualization host support(default:false)");
 
-static __always_inline void _print_param(struct drm_printer *p,
-					 const char *name,
-					 const char *type,
-					 const void *x)
-{
-	if (!__builtin_strcmp(type, "bool"))
-		drm_printf(p, "i915.%s=%s\n", name, yesno(*(const bool *)x));
-	else if (!__builtin_strcmp(type, "int"))
-		drm_printf(p, "i915.%s=%d\n", name, *(const int *)x);
-	else if (!__builtin_strcmp(type, "unsigned int"))
-		drm_printf(p, "i915.%s=%u\n", name, *(const unsigned int *)x);
-	else if (!__builtin_strcmp(type, "char *"))
-		drm_printf(p, "i915.%s=%s\n", name, *(const char **)x);
-	else
-		BUILD_BUG();
-}
+#define _print_param(p, name, type, x)					       \
+do {									       \
+	if (!__builtin_strcmp(type, "bool"))				       \
+		drm_printf(p, "i915.%s=%s\n", name, yesno(*(const bool *)x));  \
+	else if (!__builtin_strcmp(type, "int"))			       \
+		drm_printf(p, "i915.%s=%d\n", name, *(const int *)x);	       \
+	else if (!__builtin_strcmp(type, "unsigned int"))		       \
+		drm_printf(p, "i915.%s=%u\n", name, *(const unsigned int *)x); \
+	else if (!__builtin_strcmp(type, "char *"))			       \
+		drm_printf(p, "i915.%s=%s\n", name, *(const char **)x);	       \
+	else								       \
+		BUILD_BUG();						       \
+} while (0)
 
 /**
  * i915_params_dump - dump i915 modparams
-- 
2.19.0


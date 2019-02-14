Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BBDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11C72229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ioo7iJvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404198AbfBNOvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:51:12 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46107 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407293AbfBNOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so7026703qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3EUxbJ4Gs2ebNHsOGp92F1GifsPVltaoVmIWi4xEEBo=;
        b=Ioo7iJvX7d6MQbbygi6AqmTR717u8Nn9q4l6Lz9RRC1h2d3f5BI8HB987KC8ic+sht
         SQoxNNsUvDcnct0MF5I7HmqlYkNS2SnlTLS6JYqlJzKgIMXBTIjxD/ZV1tuqzpb8uBNH
         PT+t9K7fRpu0muIzuxJZ8aQn96cPNTdDS6TQkBjJDluavck2nBuD8bXJAUe6O24/tHBv
         IqnIxPiZ3ZUbgvPrcsMySFm4fRYjuYQ18ImpPHE0oknCl1zf75nzAP2rV/RLyoq3jQsY
         t32Aj633ROdtEItbocW7xgTqUgYH/Skv+qTXrlsGaJwxZDOZWqyXOnVmgqKtIjJhzjRX
         PAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3EUxbJ4Gs2ebNHsOGp92F1GifsPVltaoVmIWi4xEEBo=;
        b=U/WKitwHINfDH8V7Z0u3C8THHkauuY+QfbwP6wpFK91qkP5J+7tS5ZHn73wNYbb/3b
         U5LXfhSZg3Ct9Q/1xV4pgPeq3OJIyHBp/soUm2ePI6AQJNz5OBz3AWR+q5UxKjWENsAO
         X3zUxk6Oc7axkdHpBEL6s0aR+ziKaaRRgayF5sBMr1UcrMs9Fh91XwgKNIkxE1qbTqhB
         cJAyMxXtPENLPDubAliRR1HfkRQtd1xzgtubYG7T7d+IlR90Jm7ucEnLig5R5C/hF5AJ
         Fi5MyO0vd6spnejfbFdsJO9cBCK/vDEXTJ3R5g25POLKycEuomG767ocmfgh4+nl2FfB
         tgAA==
X-Gm-Message-State: AHQUAub2aN+MH3xjElp3rKaztZxdy5fUYuYa/dpCNRRIrFJmxxjmevwT
        r/GjxEVxMBekpkOLeqXnuAuj/A==
X-Google-Smtp-Source: AHgI3IZsomSLVmJUtA5Ud1tLgJJgLsgoW/v5KOp+5LVD6Kt1FqCgcuILjIUVEQBX6zyvIgGiuH5Uqg==
X-Received: by 2002:a0c:8816:: with SMTP id 22mr3233956qvl.247.1550155781094;
        Thu, 14 Feb 2019 06:49:41 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:40 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.9 06/16] ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
Date:   Thu, 14 Feb 2019 09:49:20 -0500
Message-Id: <20190214144930.27539-7-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit e3aa6243434fd9a82e84bb79ab1abd14f2d9a5a7 upstream.

When Spectre mitigation is required, __put_user() needs to include
check_uaccess. This is already the case for put_user(), so just make
__put_user() an alias of put_user().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/uaccess.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 9ae888775743..b61acd62cffb 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -400,6 +400,14 @@ do {									\
 	__pu_err;							\
 })
 
+#ifdef CONFIG_CPU_SPECTRE
+/*
+ * When mitigating Spectre variant 1.1, all accessors need to include
+ * verification of the address space.
+ */
+#define __put_user(x, ptr) put_user(x, ptr)
+
+#else
 #define __put_user(x, ptr)						\
 ({									\
 	long __pu_err = 0;						\
@@ -407,12 +415,6 @@ do {									\
 	__pu_err;							\
 })
 
-#define __put_user_error(x, ptr, err)					\
-({									\
-	__put_user_switch((x), (ptr), (err), __put_user_nocheck);	\
-	(void) 0;							\
-})
-
 #define __put_user_nocheck(x, __pu_ptr, __err, __size)			\
 	do {								\
 		unsigned long __pu_addr = (unsigned long)__pu_ptr;	\
@@ -492,6 +494,7 @@ do {									\
 	: "r" (x), "i" (-EFAULT)				\
 	: "cc")
 
+#endif /* !CONFIG_CPU_SPECTRE */
 
 #ifdef CONFIG_MMU
 extern unsigned long __must_check
-- 
2.17.1


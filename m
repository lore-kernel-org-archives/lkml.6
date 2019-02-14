Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BFC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1B321902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B79bS5Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404084AbfBNCKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:40 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:44440 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393956AbfBNCKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:37 -0500
Received: by mail-qt1-f174.google.com with SMTP id n32so5140920qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=39y7AjK7peQfKaqAWC/HsqOhv07u/eu+YO/gawsGjOo=;
        b=B79bS5LozvnKZmS+ofA7EZyc742ycPZZafnn9JfHNU+XuK5Rv0DlIjq2zftNuZnnX2
         CTr4hRn3N9Sg18fiGg6J0Pm87PGMSISqWE6MkZrqx1v/Rv9Sz8r9jvSmYy/p8L0As2s3
         evqUAWxGT6TxyToF2g00dcT6tXOUItrIIKdw4SNr3k7YKJLlCXkoid+Kg7f88d5I13xp
         rHKDfpcpzRc2iOOcuCALNKo6YRdz9StBV2UMYfZY2U09UrvcSLujDm63E6TKQMFu6xwY
         REUpMavQweMFk3OpX6EAivxfyZd5iBbkfO5Dfrmn8hiftilW3X6ILHXWitHB8Vrmu9jX
         aDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=39y7AjK7peQfKaqAWC/HsqOhv07u/eu+YO/gawsGjOo=;
        b=SBx7yuSWxiVRe5A5MGz7Kf81mIsH9gmEKf/AbuA0Jk85kyLZyIZkgQA6kW5FQkja6Z
         mnTP2d9KFSCLpYaef6sk2eIvDGqWbIHBGvcAz1t5SfPlaAaX50SFA7AjTgMdIU5AWWAZ
         fyCVRPoQ3uh0o8+EsEqtGJakfRQph+hBvipWkr7exjKkWODYdg5g031hUPzQUX4MneyT
         shf6XfzqVD1krpqn/mpEfi9m9I7xcBVWXDHQvAkphfUVGVS2bMtPmFs+yhMq28SZZyvH
         77W99FGGEnZoehlwXZk9eAeP2O6UrgeYNolbYc8SCjStrlLyL6TfIHAfo1ParkLLVI0J
         Ri9A==
X-Gm-Message-State: AHQUAuYjTT0oAtud/BBbUnUR1pHAaN5TwyRNSwO/7ElwyLqspP67lPYQ
        FlviJ9Zq+lAngtHg407HFMWnCg==
X-Google-Smtp-Source: AHgI3IbdXsLcPMDuF6L/GoHAtZoUOyjB+XvX4Zz2DXjnAzYOS2cKN9R5pxInjik1pfVy+8+3xeXsCQ==
X-Received: by 2002:ac8:2a39:: with SMTP id k54mr1098700qtk.26.1550110235825;
        Wed, 13 Feb 2019 18:10:35 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:35 -0800 (PST)
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
Subject: [PATCH 4.14 V2 08/17] ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization
Date:   Wed, 13 Feb 2019 21:10:13 -0500
Message-Id: <20190214021022.5313-9-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit afaf6838f4bc896a711180b702b388b8cfa638fc upstream.

Introduce C and asm helpers to sanitize user address, taking the
address range they target into account.

Use asm helper for existing sanitization in __copy_from_user().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/assembler.h | 11 +++++++++++
 arch/arm/include/asm/uaccess.h   | 26 ++++++++++++++++++++++++++
 arch/arm/lib/copy_from_user.S    |  6 +-----
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index b17ee03d280b..88286dd483ff 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -467,6 +467,17 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+	.macro uaccess_mask_range_ptr, addr:req, size:req, limit:req, tmp:req
+#ifdef CONFIG_CPU_SPECTRE
+	sub	\tmp, \limit, #1
+	subs	\tmp, \tmp, \addr	@ tmp = limit - 1 - addr
+	addhs	\tmp, \tmp, #1		@ if (tmp >= 0) {
+	subhss	\tmp, \tmp, \size	@ tmp = limit - (addr + size) }
+	movlo	\addr, #0		@ if (tmp < 0) addr = NULL
+	csdb
+#endif
+	.endm
+
 	.macro	uaccess_disable, tmp, isb=1
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/*
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index cf50b030c62c..a5807b67ca8a 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -99,6 +99,32 @@ static inline void set_fs(mm_segment_t fs)
 #define __inttype(x) \
 	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 
+/*
+ * Sanitise a uaccess pointer such that it becomes NULL if addr+size
+ * is above the current addr_limit.
+ */
+#define uaccess_mask_range_ptr(ptr, size)			\
+	((__typeof__(ptr))__uaccess_mask_range_ptr(ptr, size))
+static inline void __user *__uaccess_mask_range_ptr(const void __user *ptr,
+						    size_t size)
+{
+	void __user *safe_ptr = (void __user *)ptr;
+	unsigned long tmp;
+
+	asm volatile(
+	"	sub	%1, %3, #1\n"
+	"	subs	%1, %1, %0\n"
+	"	addhs	%1, %1, #1\n"
+	"	subhss	%1, %1, %2\n"
+	"	movlo	%0, #0\n"
+	: "+r" (safe_ptr), "=&r" (tmp)
+	: "r" (size), "r" (current_thread_info()->addr_limit)
+	: "cc");
+
+	csdb();
+	return safe_ptr;
+}
+
 /*
  * Single-value transfer routines.  They automatically use the right
  * size if we just have the right pointer type.  Note that the functions
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index a826df3d3814..6709a8d33963 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -93,11 +93,7 @@ ENTRY(arm_copy_from_user)
 #ifdef CONFIG_CPU_SPECTRE
 	get_thread_info r3
 	ldr	r3, [r3, #TI_ADDR_LIMIT]
-	adds	ip, r1, r2	@ ip=addr+size
-	sub	r3, r3, #1	@ addr_limit - 1
-	cmpcc	ip, r3		@ if (addr+size > addr_limit - 1)
-	movcs	r1, #0		@ addr = NULL
-	csdb
+	uaccess_mask_range_ptr r1, r2, r3, ip
 #endif
 
 #include "copy_template.S"
-- 
2.17.1


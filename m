Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EABDC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E552146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="g1PCSE8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfBHRhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:37:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54225 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfBHRf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so4361255wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krZKYWoU8pidQJSuC93zX28N7u3H16YP6+0fJKp65YA=;
        b=g1PCSE8H4NRPRwdR5gSw9St8gLtnFSfzX+xkJidkPUsJsGIOzc3pw3FuScFZqrjNxx
         chfJBd+lXeZw0WTIonBnYn/Isugire9ZiVtiboJ3wdBMywQ/EyXV1GEeHdQtTkGwWlrA
         NrtBJ9xVcMMc+6tblnK3PmlIsY8ZuqG2k+6O5LMA6QyZxXG/kqqxW1f0nLyvGQlnILIu
         6rnv/Pk2ZaqZ+Lp0LAqwh1wfFs2A1WIHKUAE4Jxr4xDb+cfzZn0aqAM5rC9AhTTP5a5m
         OaEGsMSrTIGBMtyUOUJZniXF+JXIs9GcDEhMFBjefyQkPdYDJbtiqHwptAVlzmXmPAvU
         eQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krZKYWoU8pidQJSuC93zX28N7u3H16YP6+0fJKp65YA=;
        b=NMl3+rTMc+DE7ecTLLWCDl595MDin1sGJaPl6BMXHEDF2e+vjIAU1tdNT/A2W+v9Tx
         5PnvChgdz7fAJSoh/mW/3+ETR+jN/9xwDuWf+ZFotMFIvaNiekK3M4ZsIp5qE9kvloSD
         UemNKd345cZXdtimQJmpE5UiDobVMRip5TBUwxZJh6JCZSw62GlmjBEQrx+W6H0YRT47
         0fe8vWcrMTPU7IQ1xPU/Pryagp05uAe6+PwdHw8ahY9NGq+kCQpmLvuwsnwKC5LCKSfB
         cb725bPxzUC+o8Cf7E6OqGJGjiLZqAr8S6tdHLxojG9MQ5hZW0ZMFWsurSWdVotymmyG
         OL0g==
X-Gm-Message-State: AHQUAuaY7eEFTWzyoVHRs2gg3ANRU3AWCtHH+yvyYsdnLE2QAb1aCSga
        HMp+eIOfw34z1jtGPG8Ce42KiA==
X-Google-Smtp-Source: AHgI3IbgQ/VM6XgrgnNUQ5bh34WjL5FESmPkUww+I9D6IlcykpHcCr/TefDLN7RCHYBkPQKD4t1/Qg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2801634wmb.148.1549647327937;
        Fri, 08 Feb 2019 09:35:27 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 18/33] ARM: davinci: aintc: remove unnecessary includes
Date:   Fri,  8 Feb 2019 18:34:43 +0100
Message-Id: <20190208173458.4801-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

These includes are no longer required. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 0f469c59acfb..0768edfc3b66 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -12,10 +12,6 @@
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 
-#include <mach/hardware.h>
-#include <mach/cputype.h>
-#include <mach/common.h>
-#include <asm/mach/irq.h>
 #include <asm/exception.h>
 
 #define DAVINCI_AINTC_FIQ_REG0		0x00
-- 
2.20.1


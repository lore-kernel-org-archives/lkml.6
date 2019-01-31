Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A950C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC47218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w09mFQU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfAaNkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51762 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387720AbfAaNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2554803wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cdS11IbVgx3eQtG5n+0kNrZKOYHM3MdE1VC/tnZNKak=;
        b=w09mFQU/c14b8cwe3r2NIU4j9ZpMcKNn0VdnMKiacsTVAYwUix5OAi4CUmpzns4z7Z
         KyV1XGsbEm/vyPAkjH0Qj4zDyd46lk89NGVHgR8ui8/2qQc9cQ0BcUdhRKJSsaI2bxCv
         pxApZlTQcXYh4frKtLnFBUxk0iPbBC6jl3ftnn9kdVMMO0GRkOvpDhA46WOuT7PkUW0i
         Nf5cM3jb92ZpsbdmSELHsYFVRwUnz0Y+zMYy/dWR2RaHcLz2SBhMCyNn3zK6U4F56HzY
         WSzsrO2FGaHNl7t6log1dzt8r0d0TWM5O+jwwL2NhN9wfMigR6xXe0dGI/lSWC0tYl90
         fodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdS11IbVgx3eQtG5n+0kNrZKOYHM3MdE1VC/tnZNKak=;
        b=qI65rLUik64CtiOH+OJjm4GBrfzEIJ19FyL74+4Q7Zp+yslqi/PDQrKmjBiHirbarY
         OVJsvex8H90NfS+qNqdb/3Bx2DtwxMBKjmLg92W2lG2/hhsBFTVr6Oqv1tqv0nu7DFn+
         lDnIMQP+TcHfibS4s/RsvGxRfNmaMpRTyp0quPFznHg3sIJ0Kw4wjGD2dOr65uaMKMXX
         CXZRkAFg8rFlV8qUiLhMpS61hL3sjlxykbMcaGWBV718HWdOnmyGxlq0clPEPtptDlnN
         +bQzCrfIH44hkPjk+7RannqbFMZNxf/HvdBjF7FneqwnYu70Kjt9NdYe+KALERNm+7rS
         sPnA==
X-Gm-Message-State: AJcUukdPD0+ihASujvJ17GdeOe4synz+t5+fMAkdxxRAWzMEj7qNKN/q
        w2mNlUbqigznWmrR2tbRNT1img==
X-Google-Smtp-Source: ALg8bN5L9iqGEJX/cb0kOiO+8fhnfMfovehjp1UwzR9NL2cH7gITxMpcgM5vcOjp9rwiYUDWNz70Lw==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr29595614wmf.8.1548942001998;
        Thu, 31 Jan 2019 05:40:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 17/35] ARM: davinci: aintc: remove unnecessary includes
Date:   Thu, 31 Jan 2019 14:39:10 +0100
Message-Id: <20190131133928.17985-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

These includes are no longer required. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2e114ad83adc..ce4625d9cad7 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -12,11 +12,6 @@
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 
-#include <mach/hardware.h>
-#include <mach/cputype.h>
-#include <mach/common.h>
-#include <mach/irqs.h>
-#include <asm/mach/irq.h>
 #include <asm/exception.h>
 
 #define DAVINCI_AINTC_FIQ_REG0		0x00
-- 
2.20.1


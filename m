Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0071C10F05
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1932229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="je69WcmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439613AbfBNOxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44781 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439590AbfBNOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id v16so6761507wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MwgpcBpoQMZ/y0HzyDL1fssen+k0kz1TThumbF16U64=;
        b=je69WcmHdRPYvtJuCnNskBDAdR9NWb8Ajo0M+bnWnsUbsVT8cB/bbHQHKe1sGYwr9c
         6jia32K6dFPmCc36L5vFxEcP+5hFXZ324BHTikWWJxLeoiNmbJT8Buz0WHKB/scXCf8q
         KYV03J5u4SSPqiEGPXUQJosD2D5L/mLpDSO0Y9qiUqgmhWs55GLlK9tccJ4UuIyZaRTZ
         Y8nyu2RwpRHXafIgl1cS9UTD2KQBK5UFtEMU9OvfcGDOkjZCL6uGFKKHIc3lSTSKzHRU
         wbcEmX0oKfr9RwVAxxUCL0T1NJ6wmWBl6ny7JtuVTYw3SGO/o9dMs7mNb2AXZFZybLo1
         tLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MwgpcBpoQMZ/y0HzyDL1fssen+k0kz1TThumbF16U64=;
        b=GWp2TiisgT8On6vQryEd7NdU6T6t1s/hnIE7LPhJVk++enDLSkUIu+KOHqXVQ8ZAF3
         V1F/CxFDYUOwTljtZLNwcrFlywon3Re92zB1TZ0nUVGel1O68F8dN/sdyXyZ2hL0WJK9
         YlNWgZc6thgS4MahsGi8k7uNucd/wmpgSkq2EfyHldlN8AWeT/XAnmmZWdBt/F85272d
         JAE2eALH4+TZdFZjpMcKy88Tij6EVRhuGDIrOHgiRn9x/X4E6bb2JPA2JSpw33FyXaqD
         rsy4cKDl244t7Hu94kMaXb6fp1BarhOzd7XqvFOgkRXlgcHtJf9T/XRBPlVyTjqm4wXG
         GPTA==
X-Gm-Message-State: AHQUAuaHiAzxeRQ+rvTQCLIXhn8qXK+rL7CvhK5ohnzQ7ayBgsG7EUmB
        RmKBpbX7O9yrcVHZ2MQQPcPh5jJ79WA=
X-Google-Smtp-Source: AHgI3Ib+dC7DUyOfGRb7ZE2q6bWo9oFo2ysKITQ3FRlJj9Rz0LIJ/QfdDHdL4Utne5iGTtnh2r4CIg==
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr3258990wrj.107.1550155987042;
        Thu, 14 Feb 2019 06:53:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 20/37] ARM: davinci: aintc: remove the timer-specific irq_set_handler()
Date:   Thu, 14 Feb 2019 15:52:14 +0100
Message-Id: <20190214145231.8750-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I've been unable to figure out exactly why, but the IRQ_TINT1_TINT34
interrupt is being handled as level irq and it's configured in the
irq chip driver instead of set by the irq_set_type() callback.

Since this is probably some legacy hack for out-of-tree code - remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2b6943731af9..92b6e653d8cb 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -18,8 +18,6 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
-#include "irqs.h"
-
 #define DAVINCI_AINTC_FIQ_REG0		0x00
 #define DAVINCI_AINTC_FIQ_REG1		0x04
 #define DAVINCI_AINTC_IRQ_REG0		0x08
@@ -165,6 +163,5 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 		davinci_aintc_setup_gc(davinci_aintc_base + reg_off,
 				       irq_base + irq_off, 32);
 
-	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
 	set_handle_irq(davinci_aintc_handle_irq);
 }
-- 
2.20.1


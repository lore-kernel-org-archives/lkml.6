Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B076C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3173520989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iB2Itlhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3173520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeKUUK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:10:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44614 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeKUUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so598195wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HC+mchDEZwGYwrWGM+6feJYkdRI25AY3Wcks9Ijr2dE=;
        b=iB2ItlhqxqQKQpsTkdSyBdwNwda2ZSnnkC720HijPxDPzkj4l6vYEQYds64HCq6TbQ
         dAovMHP1uO2ehmbdM8UWoUVILulAq0Hz+FF/PjZIC6cVoV80jwOFFvxliB4VwctbSL5X
         bxqDfCisz+9Ftxpk6C2L6NL4DeaWrBX20059z8uQiVIdDKw6AaK9ZcQ7VxgGM6+4xqcu
         fWuFDxJGdIdxN/FxUjIbqq0c6PqhDonMmV9fruf7MU6YzU6Zwv8LuQMZCi5JIT2kvNsQ
         N0qyvfWOm2xUFPMQb7GQ+mpdOCTJyJWjMv/czmg+OyX7wHTukID247QC50JJfKLIXQiv
         is2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HC+mchDEZwGYwrWGM+6feJYkdRI25AY3Wcks9Ijr2dE=;
        b=T88XwIentD9PdDuo/HymUb++9+nqJtoVSL0i6CcZbT6wrtZkBgFCkH2KzlGuuuAziN
         X3xEZ7JuHZCXV+YfQIo0p+1JSRVdfBF/gJUdMWsu81ku+t6/lnaE7HmPFMr5VgNhXXFg
         Gy4b6mYwfdUWo2Ke85dT4njLrxVo71sP4TcCCxmsJNx0KUN6yh61+Htc5aOpUBqlENFg
         AeUwydr8WpoOy2cEimkKpUe6mhbdlrvkytSaFGFF/TtihSLJy3FFAxs61gHEB/6eF9YS
         MhQ7ZLfCaxeHtFMR/1410yHf/l4jaOtwj3MWjE/ud7jWi0ml88ewkTpq7Mggc54Feygm
         lFwQ==
X-Gm-Message-State: AA+aEWb0stNnWt66YqHwTa4gXACwwtH1saCTzgP50bVzbCUCcHbOH94T
        ct8HyztU0KTeoCGucdeXnC3SXw==
X-Google-Smtp-Source: AFSGD/UvPXBF79Bclhv0n50IlUiKs7axgXrGGaqXj2eSBdaVnL4CEq2hpOA4u4dEptsr8klK7sCI9w==
X-Received: by 2002:adf:b190:: with SMTP id q16mr5019328wra.95.1542792932567;
        Wed, 21 Nov 2018 01:35:32 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 02/12] ARM: davinci: dm365: define gpio interrupts as separate resources
Date:   Wed, 21 Nov 2018 10:35:13 +0100
Message-Id: <20181121093523.12503-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121093523.12503-1-brgl@bgdev.pl>
References: <20181121093523.12503-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
IRQ numbering") the davinci GPIO driver fails to probe if we boot
in legacy mode from any of the board files. Since the driver now
expects every interrupt to be defined as a separate resource, split
the definition of IRQ resources instead of having a single continuous
interrupt range.

Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ numbering")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm365.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index abcf2a5ed89b..42665914166a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -267,6 +267,41 @@ static struct resource dm365_gpio_resources[] = {
 	},
 	{	/* interrupt */
 		.start	= IRQ_DM365_GPIO0,
+		.end	= IRQ_DM365_GPIO0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO1,
+		.end	= IRQ_DM365_GPIO1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO2,
+		.end	= IRQ_DM365_GPIO2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO3,
+		.end	= IRQ_DM365_GPIO3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO4,
+		.end	= IRQ_DM365_GPIO4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO5,
+		.end	= IRQ_DM365_GPIO5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO6,
+		.end	= IRQ_DM365_GPIO6,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO7,
 		.end	= IRQ_DM365_GPIO7,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.19.1


Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FF92147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Vyp5QaeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FF92147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbeKUUJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37324 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKUUJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so4992101wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aoqDI6spOH1d2bckgKTeVXZgHSpuq0n8nfFajTzWeKI=;
        b=Vyp5QaePqotmVenu2wb9UGhLVjGde3lM5owpCD+pZULIYvxd69bD54HmOSOYVo0ka7
         eKAs9x2lrr0AfFCIKIuLV3Sts+ycpr717jbrHGHXYOz/UwbVuEF0O5vA7Rf5TSPkVv0W
         zoJBlUBidgACYw/XVkLt25RAy6XBxtODFTA2+i7AgUZ+fOgtJIRL4TOCpXK1Ervl7GUw
         kBESazuxJGknfTuFmKNefA5ZBtYUc7axzzajJRtqZgN7KFRt8bhxhFsEaQ8Wm2Kg8+3K
         0NhDw0vnvRHRqQ5sxV5Mf7eQiMFIElp0l8zoAgEVDlRuKm9C3z0x6O9EYiNrIs6o6iJd
         7hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aoqDI6spOH1d2bckgKTeVXZgHSpuq0n8nfFajTzWeKI=;
        b=uXR1X8czlxZNTfkqlKHDlbMu0Ps8t+p1Uur84INFlGFQ+bae1zMEumJkKseOPQqcVd
         25hTjluOdViMVvdpHXg8ylj4t1fJIMZ+pE4/ylztBAxlmtd8QjYLk6mS4eoCcf9w4mrH
         p+GvfzfMDmuMOj1WN8K5gi8PmOnp9cQm95IXZB0RRExjIKy/6r9tk+ORRWEBdxj1faK9
         tQOtBa0xOiwat4pkC9YMj/yqCURVD4x3NRQf5esspQ2JssHCsZQA9dlH8OMVHO3qPjny
         dEZ+Z9SX2wgh3MoU0Q3yxw5KAGl4xCPmx1a0LvdEEUPcHPz06axBk9vIv67I//kDM7Hp
         K12g==
X-Gm-Message-State: AGRZ1gLn8DCPfo9CqvCZmrw6z9vuJJAYWTYzgy5ufxJAf3+z8nA870+K
        4w7+ayMQ4FvmNaafu+37b7M8JQ==
X-Google-Smtp-Source: AJdET5dquGsp95DFiftyVHh1pi1AjbwALjBrKI0Y7H0Wuc+kncQz6ClJi1DgRoUTsqG/SohN0R/8Eg==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr4878201wma.91.1542792931392;
        Wed, 21 Nov 2018 01:35:31 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:30 -0800 (PST)
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
Subject: [PATCH 01/12] ARM: davinci: da8xx: define gpio interrupts as separate resources
Date:   Wed, 21 Nov 2018 10:35:12 +0100
Message-Id: <20181121093523.12503-2-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/devices-da8xx.c | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 1fd3619f6a09..cf78da5ab054 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -701,6 +701,46 @@ static struct resource da8xx_gpio_resources[] = {
 	},
 	{ /* interrupt */
 		.start	= IRQ_DA8XX_GPIO0,
+		.end	= IRQ_DA8XX_GPIO0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO1,
+		.end	= IRQ_DA8XX_GPIO1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO2,
+		.end	= IRQ_DA8XX_GPIO2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO3,
+		.end	= IRQ_DA8XX_GPIO3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO4,
+		.end	= IRQ_DA8XX_GPIO4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO5,
+		.end	= IRQ_DA8XX_GPIO5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO6,
+		.end	= IRQ_DA8XX_GPIO6,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO7,
+		.end	= IRQ_DA8XX_GPIO7,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO8,
 		.end	= IRQ_DA8XX_GPIO8,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.19.1


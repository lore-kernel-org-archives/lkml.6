Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A318C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3089020989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yCKqkjS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3089020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbeKUUKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:10:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42047 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKUUJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so4880077wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjdzFhQREPTnJUNVsg8kuyC1vvOrCeXjQBrgQGo9DMI=;
        b=yCKqkjS/a9fhkywBvKntg0bv1vn9Us/g5a+VAfC6Dl0GTlbx4Bh5Z1OwlE+61X+kX3
         jwJN8qYRPztOSx5jKl4EYa6wbazuuG7gBsGAHkT6CsaZ1JhOqA4mG7FQ5yOdHx2O8Cxl
         OeKgXhlD+RA5llamk3V7UPe3Gcu0HFuNKa3Ncy8DWEubmYA+b1JmLUAzm3M0bJzDpMPh
         yPyIq7rINWBvkW17XpJUDuPaSQa4t6JMzciBUBVEL52T4iOVtIUFnDPTTIPT1Cs5GCSz
         Dk8Y1OCaJJxa3dvA/Vdi8slYhSdDEBwdkFG9Ujcv+GQX4d5ni4lthpybyf6tFhRRWCbC
         jFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjdzFhQREPTnJUNVsg8kuyC1vvOrCeXjQBrgQGo9DMI=;
        b=fIJH3SWGaTetHL5H/Id+vjoJbQIZygV7LGIgnNQZmr5K1GlMFnf+FUWiHzK5lzne67
         bXjGFpI0Ko53WCAUIhzucyMlMkNoDpsaYuV+yuURAccdNWo/wE7cRE2L1uzUHswRrqLD
         G9M5qX8z4AO2jOCd83Q28x7CJ47IrxFeD7klpZpsSX0Au/8WRp54DLYUN2r89HHHj3YZ
         YMzNdnuJVx4E7O4mHFeTXyv11fSuHRUPQaCRyJ+tcHzWoKDvH2Ekut0Y5MxRAJHHGk4Q
         e9sRXw2YO8MjB2AbAfIbA5qVUpSMSi1+Yiym4jXM5Y+ev6Jz49lj5+9L/fBSw23XTvuM
         /30w==
X-Gm-Message-State: AA+aEWZ86vfkK3YCwXMtm27iCMMKOXko0wtfMlb0AQ/Va56O+gNcSg+Y
        l+WjVwMh2CgasgBl1KshWfaMPw==
X-Google-Smtp-Source: AFSGD/U8MZAngrsDB11zme7tjW7DvR3eS6LadxlZSP1EWiwN5PnumTYZjEwESegbqG4CsRzsnubvhQ==
X-Received: by 2002:adf:f649:: with SMTP id x9mr4927531wrp.247.1542792934877;
        Wed, 21 Nov 2018 01:35:34 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:34 -0800 (PST)
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
Subject: [PATCH 04/12] ARM: davinci: dm355: define gpio interrupts as separate resources
Date:   Wed, 21 Nov 2018 10:35:15 +0100
Message-Id: <20181121093523.12503-5-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm355.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9f7d38d12c88..2b0f5d97ab7c 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -548,6 +548,36 @@ static struct resource dm355_gpio_resources[] = {
 	},
 	{	/* interrupt */
 		.start	= IRQ_DM355_GPIOBNK0,
+		.end	= IRQ_DM355_GPIOBNK0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK1,
+		.end	= IRQ_DM355_GPIOBNK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK2,
+		.end	= IRQ_DM355_GPIOBNK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK3,
+		.end	= IRQ_DM355_GPIOBNK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK4,
+		.end	= IRQ_DM355_GPIOBNK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK5,
+		.end	= IRQ_DM355_GPIOBNK5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK6,
 		.end	= IRQ_DM355_GPIOBNK6,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.19.1


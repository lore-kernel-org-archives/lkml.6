Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35643C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CE520989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vBaYd4fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CE520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeKUUJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39300 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbeKUUJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so5016242wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1NndAx1d3yMsHryrz9uJjCfJ9mVNSmD5ueQ1RobI0Co=;
        b=vBaYd4fNJU79whOVi+98h7JMHSXcmzp0FiF7KraD4T8zmRTfeB29COcTEg7lmDsVPw
         n6242vHb+Or8HFYMSyGurnqShBRRHP6tL6K7ClaISPQa8yP4vXBNk6bY62Frjos09c9i
         zAg6BBCdJIZWeNKLRwMqC4nyBFMIG1n/PWyOM29wvbSO4USfGu8orbgjk1swDgnat+gE
         wOrvGEZth0ekRTr1CHHi5ebT2ayl47HR7zorN7bMnbg7shPXknmr/dPM/z29arSBwBE8
         /q+cXuyz9E0Om1jUkanoq3LZhkAVaLjS+oe3sBIK4QaRCLcscMXumhvvQCY/PsUxvkl9
         diXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1NndAx1d3yMsHryrz9uJjCfJ9mVNSmD5ueQ1RobI0Co=;
        b=dyowFzZ/46VTQOx353gKVAVGoHlRu8uwu/467XbvkkPjD8u1JFDKjX9eB17OzRKRI3
         qHzLQVoZcayiuhJe5JcJmqviXQ4iXXj3AfBBWhxGtmt8utDACJSerRKOeR7zk2nk8hmz
         pbgg0fr3VVqarchFODOGPHwo98bHUQtM+sq0X6MIcFjFvauO+3VhiAntNAULgDMLyVtF
         vIbIh78ULH4IEOtOwQrKbIVHuEUnuvyGAVNvg38BENkSYcAaR5+Vi5vn0kqJr8g3P2e2
         Hy4Xg7PwkBnHTeW+q5Q6WqgyZGI6OcJH0NY9lVhNqRpRcWbn/z8PL47KendCWtJx4hng
         fS6g==
X-Gm-Message-State: AGRZ1gJ7j+Z80h7JVmyI8ojR9pGP1zOiBsfHqpXpKPCyg7USHOFBJ5gx
        05tOU2quOKY+jgUCrTVfiQJPuw==
X-Google-Smtp-Source: AFSGD/XOo8WapgaMwpEEUO9Ky7hHEoS5xG6JGbXrhkQOUHJN5o9vkTt+H1DZZPta+s3GVsZqj7QMtA==
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr5222968wml.15.1542792939534;
        Wed, 21 Nov 2018 01:35:39 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:38 -0800 (PST)
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
Subject: [PATCH 08/12] ARM: davinci: dm365: set the GPIO base to 0
Date:   Wed, 21 Nov 2018 10:35:19 +0100
Message-Id: <20181121093523.12503-9-brgl@bgdev.pl>
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

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the GPIO support on DaVinci boards
in legacy mode by allowing gpiolib to set the GPIO base automatically.

DaVinci board files use the legacy GPIO API with hard-coded GPIO line
numbers. Use the new fields in struct davinci_gpio_platform_data to
manually set the GPIO base to 0.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm365.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 42665914166a..01fb2b0c82de 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -308,6 +308,8 @@ static struct resource dm365_gpio_resources[] = {
 };
 
 static struct davinci_gpio_platform_data dm365_gpio_platform_data = {
+	.no_auto_base	= true,
+	.base		= 0,
 	.ngpio		= 104,
 	.gpio_unbanked	= 8,
 };
-- 
2.19.1


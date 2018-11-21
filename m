Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC29C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365BF20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tD+zxbFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365BF20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbeKUUJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44616 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbeKUUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so598257wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3wZBxxhoW0hv41EZ6owq2gUmTW5TqD7gIWFHMpOd28=;
        b=tD+zxbFToGlOLdHoW27X3+KKg8pw3Dj70R3J6fsC8gcyLnsQ2rPrbbIVA03OyVIemj
         RsvmAQ+CkKsqkIm7kgSPdUlBpW/nuD04Y77Ac0zxiHPT/jt9BJ7gWkfS0lIuep8KXh2k
         aydrh0KdhOpANN3IJGqD0cnex5YAABte+cWxQliXGMye5BwtQHdTFRD/OoYaE1tygo58
         ojXlOAIifWCT9nXmVDeyFpxbqJnoCSE4op2wKhJdqWa+ClTQ7rfjX5j6knFgwuQ6biQS
         YRDgTccpQhSRo5nLnqMshfFVPmntPfxQpQOylmQ+8QlWUTQFG1mwXSYC/3j9EORbfD/e
         Ad2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3wZBxxhoW0hv41EZ6owq2gUmTW5TqD7gIWFHMpOd28=;
        b=DqZpLyY49LDUBwJryqwxjvJtuqILstgRvgO6zHZJRnBcIA6x3L7DHdsQEDMDDstDuE
         DGOp8Gdb/eRnPnbwvsDiDvIsb9zshM7lCYvRtxKjW3POY4cNCftov732jPznaL0kS7Cy
         J/Bdm2P2LEpC4PYxPuk9otZaMjB6CA7SbelT/WnGs/ROaynd2JnAh6V0bBMUW6WVpuzK
         gG9JuztU9VMlum8Sbvcdz+bZ1tDHabXptTDOq0rVbAOTIEubLICA7u4E6fTZO09pMAHe
         bJCI85X2seE5zIWhrchpJZbuVbAHLGo02vPuRgKsA+IAFDPYMu01rQpe2EvmCIn+SqCb
         2aKA==
X-Gm-Message-State: AA+aEWaSHpMZV0CU2x78tPhrm/u8WBvHwoBLRKlwWocLov0WEzYeTh7b
        hTbtvLNVngKghcqfYeYCxfDupg==
X-Google-Smtp-Source: AFSGD/Usi2zU03IHHtEHxq7GgxxUQVl204cqWxbGPoygORrnCfXkwluTnCprAjuAUSsppxEkP3iTPA==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr4752487wrx.259.1542792933703;
        Wed, 21 Nov 2018 01:35:33 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:33 -0800 (PST)
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
Subject: [PATCH 03/12] ARM: davinci: dm646x: define gpio interrupts as separate resources
Date:   Wed, 21 Nov 2018 10:35:14 +0100
Message-Id: <20181121093523.12503-4-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm646x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 6bd2ed069d0d..d9b93e2806d2 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -442,6 +442,16 @@ static struct resource dm646x_gpio_resources[] = {
 	},
 	{	/* interrupt */
 		.start	= IRQ_DM646X_GPIOBNK0,
+		.end	= IRQ_DM646X_GPIOBNK0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM646X_GPIOBNK1,
+		.end	= IRQ_DM646X_GPIOBNK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM646X_GPIOBNK2,
 		.end	= IRQ_DM646X_GPIOBNK2,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.19.1


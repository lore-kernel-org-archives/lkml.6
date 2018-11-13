Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574BCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC50223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yvwZTO6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC50223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbeKMXtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:49:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34503 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387434AbeKMXtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:49:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so13397600wre.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7d3gKs/3PvV8H7d9+aIBGmoqH8Qt+ozbWCJM2/z5B8=;
        b=yvwZTO6S9n/L4hlrekct66mJgeWtENzNAHTnLT5z+jsZS5B0iApKkSsajPzFmw2UNN
         swLrEdj0/AuiGBuX2XfmroQzs4MlcXsJ3JqGirlowfrG3N2+E1UrV/mcrx904opJpGxP
         Y+KKSlIG8BcDIil0C07eWtQSmLX9JiUn+LIaC73/Ned68GLbRsioIBtqsZg1eaGMisQW
         Lera1xkkTv5rDhZGYkpDztnHBU82l96yKmaq5uYKoefmN5Dj/uK5zZkyFydhCY0yowTA
         nRj4doympGg1Of8+NlJ0GfWLc6X3MqKm2rDSVO9EYy8BWKkPaNYEUOeoVfsS0PnLAnnR
         RGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7d3gKs/3PvV8H7d9+aIBGmoqH8Qt+ozbWCJM2/z5B8=;
        b=R1Yeo1Mnb+CGswZ/H+KLdwSqI+hKT0sxMcgf2uzGBJQSeWQGf9D+dQPOUsNfjwzXYG
         0aJi5aI7V/LJVGh6eQb0L9KUFRobc+tSPx3Rc0fQZiFqAoOQPzf4hwzWfpAPHlo8tnu8
         QESh3ck5ApDs/cMVc740Od8GSwLkcLZViZeeBBBFim9ASwOqJa95XieIMovNYwiGB5IQ
         490vpAc5kJwAO4L3Rmpc9zHDA53cYJ8fxm/kW/LcKRPhTmGFWPf/N/3xeTS4zEFw6wjs
         SLiMGrmR9ouj4PZojnoTOQCs2ZQSs4nEy8DZUMiuFz5L1S/5MQk56JBuAZgNhuPQFq+x
         UVQA==
X-Gm-Message-State: AGRZ1gLsQoAz/CD7oXSjHv48YbDCBJJBvjRAun371PbKp8NgAcaOKWmC
        DZ/zVto+8lJEbAZwO+fc6kUHIg==
X-Google-Smtp-Source: AJdET5ejY3D0K1c906Io4dU4bzfBUogq19SOc+p/RgF432JNqhWTsPjtvmxr9ZIXsD+CgetOfJPV3A==
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr4903739wrh.65.1542117066160;
        Tue, 13 Nov 2018 05:51:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id j40-v6sm15170050wre.48.2018.11.13.05.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 05:51:05 -0800 (PST)
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
Subject: [PATCH 3/3] ARM: davinci: fix da850-evm boot in legacy mode
Date:   Tue, 13 Nov 2018 14:50:51 +0100
Message-Id: <20181113135051.15308-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113135051.15308-1-brgl@bgdev.pl>
References: <20181113135051.15308-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the network support in legacy boot
mode for da850-evm since we can no longer request the MDIO clock GPIO.

We now have the option to specify the GPIO base manually for davinci,
so add the relevant fields to platform data.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 4528bbf0c861..e7b78df2bfef 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -719,7 +719,9 @@ int __init da850_register_vpif_capture(struct vpif_capture_config
 }
 
 static struct davinci_gpio_platform_data da850_gpio_platform_data = {
-	.ngpio = 144,
+	.no_auto_base	= true,
+	.base		= 0,
+	.ngpio		= 144,
 };
 
 int __init da850_register_gpio(void)
-- 
2.19.1


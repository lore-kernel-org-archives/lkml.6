Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3CCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B83020989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DTPPfdcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B83020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeKUUJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55408 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbeKUUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so4744003wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyQV5m1eERF6ftGqlcdzXXJMTCz4GXPVvKn91uWAFD4=;
        b=DTPPfdcx8ic8YGeVJnqWQXxNlBsiD0u+pWwQcnOXLXItMp+iDGjwkgFSdfh36s78qK
         MpKTk6JwwdPP767hccchWpDSqqdQ7wIGdzwAHZ5SaUkagngZ6RKihVzJ9OcUfGrCHrq1
         JCqYeifsYOOmYM28o0OGDDtNd1GtXzcWTM+8exMzewMhwYoQ6DHLMFNjtM46pgKepIPj
         Cou7ByGntfxwdA5yaUO9ysA4OFCFnNVEC3zV7coObPku82WDWZO2l9JtW+5ADPtkBlk7
         g9t9UzH553nQo5mU6fxEEpvvRis7ePTX+7Bt+qbnSGyMbkR0HbiDJNbJ9XI/NsJQeU7U
         WRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyQV5m1eERF6ftGqlcdzXXJMTCz4GXPVvKn91uWAFD4=;
        b=TRw9iezDmuprTEK3Wj2O2b3cefUf/NF/uHIUUqGJLUAzPjnoT+z2QFKdTNLD+NWmjd
         m9Im/nW1q5ruhNfpN1UlXYZJ3mXBQhkOuHrZyU2PMZqX2Ng6srYwng2cga7VrDVaGSq1
         neBC0psWLGNwiID707lm++tHK9woTQ0Ch0hyTNSxfB4KpOYmeIez+m4QYzcL3viisbxT
         BZkbC2gMH3Wn5/YVeKA6udk8YRGBTJ+BjVoYE2XPTzEa/yaMiqMXLU+El3W1jS+Owe5Y
         qf5/vXXdWz4SKSiB0CAfDDh99UN3rGgwnrNzWDyhjowgpgn/49cmd4AuS2Y5tZ8N2BSj
         qgDg==
X-Gm-Message-State: AA+aEWYLyFCazLVfmqv8oq5bblyLKmq+3qE1jM+PtvsyO9/jrUvlqypj
        Y2UN3lNiR7gY9gHgwueNrYV/tA==
X-Google-Smtp-Source: AFSGD/VplsSOVCX52OWMIQ5M+Vv959mVT7eNoIMmclDZsQKtsghWz4Jb3z+voCr1MXQTnxPL8EZHxg==
X-Received: by 2002:a1c:adc9:: with SMTP id w192-v6mr5228708wme.103.1542792942947;
        Wed, 21 Nov 2018 01:35:42 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:42 -0800 (PST)
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
Subject: [PATCH 11/12] ARM: davinci: da830: set the GPIO base to 0
Date:   Wed, 21 Nov 2018 10:35:22 +0100
Message-Id: <20181121093523.12503-12-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/da830.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 0bc5bd2665df..2cc9fe4c3a91 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -759,7 +759,9 @@ static struct davinci_id da830_ids[] = {
 };
 
 static struct davinci_gpio_platform_data da830_gpio_platform_data = {
-	.ngpio = 128,
+	.no_auto_base	= true,
+	.base		= 0,
+	.ngpio		= 128,
 };
 
 int __init da830_register_gpio(void)
-- 
2.19.1


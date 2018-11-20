Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C219FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB982075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Q38YL7ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB982075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeKTXD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:03:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54376 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeKTXDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:03:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so1966820wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EX5SH7zUB9IIqhYxyhcNg2fvn6Z8aWqh5bSPTUdIxiY=;
        b=Q38YL7ZWBUzfBQxEpo+ChPK2HZJ+SNOhCoqC+gtEVGFtpZw0xMeu06+n/J4PAdSOqq
         OSp4ExCI304g8Y/sViEoQLWI0Nw/pFZD8p97m49IFtMKso+a44bGcQfh7DODp55CjXqH
         X+YksKg3lYDFODgDUqHf7cYe7Kcp0fVcKQt4SQffWh8sHw5eR7hVWKzLC0lsWhb4QLfg
         AcgO6k0Ip2qSzODf/+wDk4zLffsd7lrrXbMTbGkjW00crAYOHDtP2L0+yyY1Jv/SItpt
         E852SUbbhXuPvniHin0iAlPJsqlK0jZH3lZDv/onmw6dfk+7Wv0l3VzdzT4Q03YCeLRH
         brrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EX5SH7zUB9IIqhYxyhcNg2fvn6Z8aWqh5bSPTUdIxiY=;
        b=F8xLQXwl1md0TckwmOzLMJZ4rRhru620Mu+6NAlr1b0s2GlG3BnGN+RQ/zZ/Q9816q
         eoDCKg2WpMlNQfrQ+TS52wJBsUxdwuED2zZSyRG5LcSnixdMwtBvQ7kHqSx8KMTcFifX
         hUNLNI7PUTvgh3UtZVDzr7RbhObTvQiXuuULSL515YTnd2meQboACo8FS6WyXa3XVrOS
         4c7M+DwtBS7eaFrx3G8K2+UK4yE8TVutkvQc4g6nYmEZQgJXDWhCoTbeIwKDBIA9JD1/
         zymgzQ3TNm1hPk7pobWtWWanNAQgC44XLNUhKayHLhtexWhyYy/ks5KcGGiA5XdA73uw
         sPJg==
X-Gm-Message-State: AGRZ1gLIJj6a1YhpDBBeml/PPbCTKKiF9ZN7xCLpy5PzATwp7pH79ZZY
        C3s/kRtBFsf9nEGxEJq1Qs9dzQ==
X-Google-Smtp-Source: AJdET5ehQkYqujL/5k6wrOVJy/+0FnaK45j+GgVIzqUNOZNkAU7wDU1MbGadmW8KyUpNv5v1jIz95w==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr1909355wme.21.1542717268517;
        Tue, 20 Nov 2018 04:34:28 -0800 (PST)
Received: from debian-brgl.home (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id v189-v6sm33482685wmd.40.2018.11.20.04.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 04:34:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/5] ARM: davinci: dm365: set the GPIO base to 0
Date:   Tue, 20 Nov 2018 13:31:21 +0100
Message-Id: <20181120123125.24938-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120123125.24938-1-brgl@bgdev.pl>
References: <20181120123125.24938-1-brgl@bgdev.pl>
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
index abcf2a5ed89b..c8e66d8745b7 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -273,6 +273,8 @@ static struct resource dm365_gpio_resources[] = {
 };
 
 static struct davinci_gpio_platform_data dm365_gpio_platform_data = {
+	.no_auto_base	= true,
+	.base		= 0,
 	.ngpio		= 104,
 	.gpio_unbanked	= 8,
 };
-- 
2.19.1


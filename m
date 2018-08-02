Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CC3C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6716214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQjUx0dF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6716214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbeHBNDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:03:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34429 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732047AbeHBNDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:03:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id h1-v6so809440eds.1;
        Thu, 02 Aug 2018 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZnKNfg2FkoBzleSCEQnev6xVyvhZvYN0+QMbtw7RHh4=;
        b=uQjUx0dFTVIynbm7yZF9XgtqBhTEy6/tig4GsdwaB1uWIwiPSRGWDGxXhut1aphKvD
         axj3nLSHEPXpR+Rq6QY7LfEeFa0ecVrHV6wXFKZRnHOzbBG27JNPjAYUB/NOgUY9yhIt
         1jq0H3/kmcnaBDxG3e4kDggCIifGTJR19UulABB+Vt+oh9draFIyDI0tzubuPzjwGYWn
         L8d9Oy725LYNgx3MbsD6oaK4q0BxEd316v/B9K4xs+SbCPXBFkIqWFXVe6kqOwJm/2PK
         mnwfTrAhpnLwKiIEJWKPATR2yHH9TqUP8aqBUweFfASTsYcVQnJUEN19pjis674vbXEh
         ebxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZnKNfg2FkoBzleSCEQnev6xVyvhZvYN0+QMbtw7RHh4=;
        b=F1jP7J3sPIQOlRmu4FP/4zPvDULf0x7LvG+5jx6+PalCQUOLM4V1K5q3YdfKLg++GJ
         9YEhKx3BNPXiBVpyi683raeVzQIFIcyRHA8QOrlU+wle2dLSIYEVBjKczjdFKH5yFO8C
         AMWqTGbDSNDttjTSI954WaZc1jNkufvDprMP/RmngBulECwyLY6GdZtfZtuCBAw8t0kI
         a17xHudeekNXwWpyicuu6OAE9mtTQyJWKgheXtTzuymELCuVfsd2Z+qi/u5802psfEi1
         Q80YcRyhVHfJRCVwEfdQLv8o/SeKQ3ytpWjbwoPU8jjWPwzqhUC1TsbwiqPzAwuM00ta
         7z6w==
X-Gm-Message-State: AOUpUlHjxcA7cJ9yCydg/G5k6yHrSoLxB3U1GdLyeZf4ugc0JFS7qE+U
        DRoQRzqCIMck0VZFjemX3xYO5zF3
X-Google-Smtp-Source: AAOMgpfy7rKA4iWxF6WOef5GrAVUHjsXQM5e1fk/C2f05ToIbkzSTB++5gA6KrlaEwirJwylXaknzg==
X-Received: by 2002:aa7:d60d:: with SMTP id c13-v6mr2839263edr.301.1533208341762;
        Thu, 02 Aug 2018 04:12:21 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id c21-v6sm886933eda.21.2018.08.02.04.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 04:12:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] gpio: tegra: Move driver registration to subsys_init level
Date:   Thu,  2 Aug 2018 14:11:44 +0300
Message-Id: <20180802111144.12512-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802111144.12512-1-digetx@gmail.com>
References: <20180802111144.12512-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in regards to deferred probing within the drivers core
that causes GPIO-driver to suspend after its users. The bug appears if
GPIO-driver probe is getting deferred, which happens after introducing
dependency on PINCTRL-driver for the GPIO-driver by defining "gpio-ranges"
property in device-tree. The bug in the drivers core is old (more than 4
years now) and is well known, unfortunately there is no easy fix for it.
The good news is that we can workaround the deferred probe issue by
changing GPIO / PINCTRL drivers registration order and hence by moving
PINCTRL driver registration to the arch_init level and GPIO to the
subsys_init.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpio/gpio-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 2d940785bad0..a53c77db9744 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -712,4 +712,4 @@ static int __init tegra_gpio_init(void)
 {
 	return platform_driver_register(&tegra_gpio_driver);
 }
-postcore_initcall(tegra_gpio_init);
+subsys_initcall(tegra_gpio_init);
-- 
2.18.0


Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC127C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCB4222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438843AbfBNNQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:16:07 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46666 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfBNNQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:16:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so4475409lfc.13;
        Thu, 14 Feb 2019 05:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=onJ7kVDUvKCrM+R9JuQDpxkKNjnnLN832FI3hjpWRso=;
        b=Rn4Cl1/GzUa82LlCZrtjZBRZ/+caPyn/fDHcGp2tzK5rluamX8hDMfoMsxJg9So7Ke
         3UMeFl3qJYOQfo6UVjYEZRzYLt9akAaYf/dKOwQi2oL0Ftd2z302iZ4cPgH8LyPgKxcq
         /ew+Umxjfqnex+K3WqNOW/D+jT5eMcYdHazG8eE3/Yvy5xvDqKUN3eani7LHhhjTbcRW
         GDdImir0UGYQCKYS/7gdRmNPB5rvvdyUCiuCtr1HdByb9aqc+iLM/HKO/uTqVbE0QHUI
         Y4fvMdzTJnMYXmEtG/sU/wxG2nVPIdTdcC3y41lGOJMtch44ikQIoUXZMQlUnFSOaiQV
         Lhyw==
X-Gm-Message-State: AHQUAuZfv9S5PqyDyjTYe7cXL25+NCX0W9MIdzK9bYdu1FYFyVIL6ba9
        b8l8Aq5eI9UrgW8FsUBF3FY=
X-Google-Smtp-Source: AHgI3IaonFR06zAohDG5Wl9S5rmkCN8+Uj5fWppUU1Za433kkN8YQgf2FS7HvHPpVGS0nIY2uu4qow==
X-Received: by 2002:ac2:5288:: with SMTP id q8mr2424062lfm.157.1550150163673;
        Thu, 14 Feb 2019 05:16:03 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k21sm460492lfg.51.2019.02.14.05.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:16:03 -0800 (PST)
Date:   Thu, 14 Feb 2019 15:15:50 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v10 9/9] regulator: bd70528: drop struct bd70528
Message-ID: <540fde29249cb6417fb484d0f0f6ebf8a4ac4dd2.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a result of exporting the bd70528 specific locking functions
we no longer need struct bd70528. Remove references to
struct bd70528 from bd70528 regulator.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Mark, I proposed to hide the struct bd70528 from sub drivers
as the RTC lock no longer needs to be visible for sub drivers. So
please consider applying this to your tree in order to avoid breaking
it when (if) this series goes via MFD.

 drivers/regulator/bd70528-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 72c7f9aa84f3..30e3ed430a8a 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -246,7 +246,7 @@ static const struct regulator_desc bd70528_desc[] = {
 
 static int bd70528_probe(struct platform_device *pdev)
 {
-	struct bd70528 *bd70528;
+	struct rohm_regmap_dev *bd70528;
 	int i;
 	struct regulator_config config = {
 		.dev = pdev->dev.parent,
@@ -258,7 +258,7 @@ static int bd70528_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	config.regmap = bd70528->chip.regmap;
+	config.regmap = bd70528->regmap;
 
 	for (i = 0; i < ARRAY_SIZE(bd70528_desc); i++) {
 		struct regulator_dev *rdev;
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

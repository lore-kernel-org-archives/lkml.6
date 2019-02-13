Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774EEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415C621934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="U5aEVNCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404263AbfBMWZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:25:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45906 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392504AbfBMWZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:25:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so4301801wrn.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PvAO/6uQ3rM1kwF8ijOzVJfqznQ9Ss07X4DJx6RF6go=;
        b=U5aEVNCxMWrVl4ZYOfmDjIrXW/OFtpJ05w5Xt+3Qg8wgeGI8JrG7V8wVrTJdhYscjV
         z5lRAx3+XwtbznwZoz07Fad2M/BDhUjaH/GW/9dssKIuDFk9NXLPZx2GvOKPahy/p0/k
         HH5UeX+Yl2bGzSETa2WfauNDuINKxB+yuwb9RFLR9MwssIsQW85o5O9Bd1dSyKDnub2d
         UPDxhcMzuJ55TZtdvILn8J8t0a5+Bc9hgTxTfoO2L1oH8GmTa8u8HZhoL5RIp+qyqcMq
         jfr9JYMt8uY2Xxd0pk+6TgOEo7vspVPXCjao+Kr9p1EicR7Wt6WTP2/tH360lmKrFwdH
         S1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PvAO/6uQ3rM1kwF8ijOzVJfqznQ9Ss07X4DJx6RF6go=;
        b=M8AZZvM5QHckwbVobiM11D4AvU3xAkQWsM6PGOC1l+cfoWBo0QuZEHT0sPMN7OMI3V
         pTUyWb8khx25Lm9NE0+wagOGlwaC80SgKPRWSRSl5OgUpprj6D5rzTBNcqAqi+Tk/NiO
         WYsvLPnFJPLBhn4rfQ3/VpsBPCZXWZ764X/Jnw9DXkcgcUgDe7PWzzBBiKtMV6VNzAwU
         gFmMZAccONk5cHsvRsos9qTUq0DUr4ciYJ+i66cV07d1m1N9AvrsRz0boc+nRdlJHeY0
         QG6nKENWKUo+KO9OgM5BObIAReFpvmoHI5pRBr1v26OUglVViKiS5HqREKF3LAUDWDNx
         Gx3w==
X-Gm-Message-State: AHQUAuaLzf889nlxlXt2pDAYGtVGzZl7EIJffnGb0UI1u1tkid2EmUw5
        lA8TcCG0swx37+kioC+uc3V4Vw==
X-Google-Smtp-Source: AHgI3IYaJ7fpkqBRpBqGEHWV8SWT+9hqrBagMw1HWoABd0x++ifz0VvUdgdX+S76zhG1FEAlBQ1S9g==
X-Received: by 2002:adf:a147:: with SMTP id r7mr244239wrr.5.1550096698561;
        Wed, 13 Feb 2019 14:24:58 -0800 (PST)
Received: from diamond.mathembedded.com (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
        by smtp.gmail.com with ESMTPSA id h71sm788330wme.20.2019.02.13.14.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:24:57 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Stuart Menefy <stuart.menefy@mathembedded.com>
Subject: [PATCH v3 1/2] mfd: sec: Put one element structure initialisation on one line
Date:   Wed, 13 Feb 2019 22:24:01 +0000
Message-Id: <20190213222402.20541-2-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190213222402.20541-1-stuart.menefy@mathembedded.com>
References: <20190213222402.20541-1-stuart.menefy@mathembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the layout of the initialisation of structures with one
element to a single line of code. This keeps the coding style
consistent.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 drivers/mfd/sec-core.c | 58 +++++++++++++++++---------------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index e0835c9df7a1..5ff3fd726f9e 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -28,45 +28,33 @@
 #include <linux/regmap.h>
 
 static const struct mfd_cell s5m8751_devs[] = {
-	{
-		.name = "s5m8751-pmic",
-	}, {
-		.name = "s5m-charger",
-	}, {
-		.name = "s5m8751-codec",
-	},
+	{ .name = "s5m8751-pmic", },
+	{ .name = "s5m-charger", },
+	{ .name = "s5m8751-codec", },
 };
 
 static const struct mfd_cell s5m8763_devs[] = {
-	{
-		.name = "s5m8763-pmic",
-	}, {
-		.name = "s5m-rtc",
-	}, {
-		.name = "s5m-charger",
-	},
+	{ .name = "s5m8763-pmic", },
+	{ .name = "s5m-rtc", },
+	{ .name = "s5m-charger", },
 };
 
 static const struct mfd_cell s5m8767_devs[] = {
+	{ .name = "s5m8767-pmic", },
+	{ .name = "s5m-rtc", },
 	{
-		.name = "s5m8767-pmic",
-	}, {
-		.name = "s5m-rtc",
-	}, {
 		.name = "s5m8767-clk",
 		.of_compatible = "samsung,s5m8767-clk",
-	}
+	},
 };
 
 static const struct mfd_cell s2mps11_devs[] = {
+	{ .name = "s2mps11-regulator", },
+	{ .name = "s2mps14-rtc", },
 	{
-		.name = "s2mps11-regulator",
-	}, {
-		.name = "s2mps14-rtc",
-	}, {
 		.name = "s2mps11-clk",
 		.of_compatible = "samsung,s2mps11-clk",
-	}
+	},
 };
 
 static const struct mfd_cell s2mps13_devs[] = {
@@ -79,37 +67,29 @@ static const struct mfd_cell s2mps13_devs[] = {
 };
 
 static const struct mfd_cell s2mps14_devs[] = {
+	{ .name = "s2mps14-regulator", },
+	{ .name = "s2mps14-rtc", },
 	{
-		.name = "s2mps14-regulator",
-	}, {
-		.name = "s2mps14-rtc",
-	}, {
 		.name = "s2mps14-clk",
 		.of_compatible = "samsung,s2mps14-clk",
-	}
+	},
 };
 
 static const struct mfd_cell s2mps15_devs[] = {
+	{ .name = "s2mps15-regulator", },
+	{ .name = "s2mps15-rtc", },
 	{
-		.name = "s2mps15-regulator",
-	}, {
-		.name = "s2mps15-rtc",
-	}, {
 		.name = "s2mps13-clk",
 		.of_compatible = "samsung,s2mps13-clk",
 	},
 };
 
 static const struct mfd_cell s2mpa01_devs[] = {
-	{
-		.name = "s2mpa01-pmic",
-	},
+	{ .name = "s2mpa01-pmic", },
 };
 
 static const struct mfd_cell s2mpu02_devs[] = {
-	{
-		.name = "s2mpu02-regulator",
-	},
+	{ .name = "s2mpu02-regulator", },
 };
 
 #ifdef CONFIG_OF
-- 
2.13.6


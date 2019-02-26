Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAC2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4049217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="X0FEJ4q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfBZMlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:41:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39191 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfBZMlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:41:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id h8so5661619pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=utZTqqZEVdTOpuC+qnFKED1DJ0xjQS8dUtV0nmtg3sk=;
        b=X0FEJ4q9EOsWk8d3kPDDzxD1dAPrNX2RdmUcmGuWUp/52Pt/8jnqic3r4vpEQehPfw
         +Ir6ui+cmj6KAKiuqFlyyprc/ybiv7hi+qlLOW9VlyJzTdPWT2sH8zUBpvRMV6xhtsjO
         Ba7g6iZb3NsBEwJ9SeHwvvpsg02ivcEerxHIuJbWfUW4dlPCMtKyG4aAHAYAWQLAhn+O
         BZ/qFqVnIZBWmCiB3LilDYHgP0eCqJbtYqke9Q3uibyd2eIP0m038193Bpr5J52I/4+F
         2YFwKMA3qg0xFwCLTu2F0r78DsVWZCiYndB/59DxCCrR0tsqiowkj8yNkOwefmasn+Vy
         IczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=utZTqqZEVdTOpuC+qnFKED1DJ0xjQS8dUtV0nmtg3sk=;
        b=jdvEXLe7eq9pPXLvgpUAK4NRBdfoaHHWQRyKjpTKR6AKCR8RPlnf8Hp9MRFQQZdNwi
         mc/+cTkY7dbBofHdughk6BehO/Oj9pF+M9J87hvmDLZONN4bXvlVV/Js3AWYh/kVQ5lx
         HLWLPlgKpvsp0F2yXbl6SQdz9cSLeBLf48Z5lBh3uHhD2LVTyIzGLCUQieh4ib+L6K58
         xjYScqLRphKF6rV0Tw75p7r60YRcqPkMrQTnWkYw8BhwXtlJa7fOpmdkuDNMxQnNGIs/
         mlX+4SbU0AEOX1y881olvtMsFTxrfIbjxSaNzwYhGD2cyTVPZrwQaGtlr6zQOYt2WS7o
         IB6Q==
X-Gm-Message-State: AHQUAuYL/zw85WjAhLnFQDA1wFL2Aoz4UVAct1sBa0JF0TudK85+Bj7o
        vqqw1vhz2vt1NN0hJoyl370kiA==
X-Google-Smtp-Source: AHgI3IYrREOwYrn1h3hlpWeLfny1Wxz9Ybscvnq/i/qzfm1rbZRcB2AP94qS+TZoNyTM7mOPlBqLug==
X-Received: by 2002:a63:f310:: with SMTP id l16mr24057167pgh.72.1551184879371;
        Tue, 26 Feb 2019 04:41:19 -0800 (PST)
Received: from localhost.localdomain (36-239-237-193.dynamic-ip.hinet.net. [36.239.237.193])
        by smtp.gmail.com with ESMTPSA id c13sm7669030pfd.121.2019.02.26.04.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:41:18 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jett Zhou <jtzhou@marvell.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: 88pm8607: Remove unused fields from struct pm8607_regulator_info
Date:   Tue, 26 Feb 2019 20:40:59 +0800
Message-Id: <20190226124059.26668-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226124059.26668-1-axel.lin@ingics.com>
References: <20190226124059.26668-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *i2c and *i2c_8606 are no longer used since this driver was converted
to use regmap helpers. The *chip and *regulator are not really required.
So remove these unused fields.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/88pm8607.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 597385d25201..753a6a1b30c3 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/i2c.h>
 #include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/platform_device.h>
@@ -22,10 +21,6 @@
 
 struct pm8607_regulator_info {
 	struct regulator_desc	desc;
-	struct pm860x_chip	*chip;
-	struct regulator_dev	*regulator;
-	struct i2c_client	*i2c;
-	struct i2c_client	*i2c_8606;
 
 	unsigned int	*vol_suspend;
 
@@ -350,6 +345,7 @@ static int pm8607_regulator_probe(struct platform_device *pdev)
 	struct pm8607_regulator_info *info = NULL;
 	struct regulator_init_data *pdata = dev_get_platdata(&pdev->dev);
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	struct resource *res;
 	int i;
 
@@ -372,13 +368,9 @@ static int pm8607_regulator_probe(struct platform_device *pdev)
 		/* i is used to check regulator ID */
 		i = -1;
 	}
-	info->i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
-	info->i2c_8606 = (chip->id == CHIP_PM8607) ? chip->companion :
-			chip->client;
-	info->chip = chip;
 
 	/* check DVC ramp slope double */
-	if ((i == PM8607_ID_BUCK3) && info->chip->buck3_double)
+	if ((i == PM8607_ID_BUCK3) && chip->buck3_double)
 		info->slope_double = 1;
 
 	config.dev = &pdev->dev;
@@ -393,12 +385,11 @@ static int pm8607_regulator_probe(struct platform_device *pdev)
 	else
 		config.regmap = chip->regmap_companion;
 
-	info->regulator = devm_regulator_register(&pdev->dev, &info->desc,
-						  &config);
-	if (IS_ERR(info->regulator)) {
+	rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
+	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "failed to register regulator %s\n",
 			info->desc.name);
-		return PTR_ERR(info->regulator);
+		return PTR_ERR(rdev);
 	}
 
 	platform_set_drvdata(pdev, info);
-- 
2.17.1


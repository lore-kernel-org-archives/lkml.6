Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23293C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D563220842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="IoOsvu6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfBYJOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:14:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36677 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfBYJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:14:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so4223121pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 01:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UpxBY7cksRBN49z6GdQZcO+xAJ0NwGNp0fRtgo2CD1E=;
        b=IoOsvu6d0lQiNN24fFoJB/9D/Aih6OuEOtbC3c7gtuEQVIZJmsnhQzw5YrhBt8tGmK
         +eDB2plNj8Uz/YweeSjGENTiesArgoymFKWH4kT+dS37MPt6jcvZOYkL/VGVcFPLqFuP
         SCXAZQQAOfzi71ii/FSAJYGj6LhO1zv+OkesPypu3oh2oKf64m9QxANiMjMizXPbesZn
         yZ5AJqvRI/ycgELEBJOiazxB79fidInDfd+Zu13xxoWPR49pLrjv5/XyOAFfvDq5ycnj
         Za6DVHGSp/R9hQMauFJte2UQ3XFE5MZtLRrNVv9YB9QbybkZD24YRb3kBkocDB0iNmTo
         Lvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UpxBY7cksRBN49z6GdQZcO+xAJ0NwGNp0fRtgo2CD1E=;
        b=LhP6RD94Gu12PXB3yAVHrxHcPPqA7KIkMm2b1lqSMCSKVinxZ27DuqRvZRnTp8fMi3
         dbb+ol1Lpw6YpxaWovJUBH2d+Kp/hjHp9KyoWcsuDs9U3fk/Sa2KEsAZVNMYpXid5YbM
         ux/IBemwEEmjNSMwGDoRZE/Z2ILwd9fjX6YCqeAqRb9ewdl7jXnPqkbSwRjkJAMhxt3G
         M9mIBekLpfJnQCnppFJ4cXUJGjYPEki/O/JnmewWdfHfjUYNoIwDwUYMh9kJP8ER7ooe
         rT2NQDvkMdolLAyRdhhwtHzqxJ/RN/TNpJGMtcsHNokaZL8l+0nrZS8kBlM/tP69Xv+D
         bcOQ==
X-Gm-Message-State: AHQUAuanAgZaxFQ2jZKIvAW/D7m5Zsy5XNk2wdVBqnSfWYHzjisDKytt
        or8E7+PA8aWJNqaLl+1NB8zyzQ==
X-Google-Smtp-Source: AHgI3IbFr8Nkion7SqRlb2H+/yQnszW5cm5u6X3R/brMG9z5530AyFtBKGvBsaGLJx3te76tFIUwOg==
X-Received: by 2002:aa7:8150:: with SMTP id d16mr19553971pfn.172.1551086044007;
        Mon, 25 Feb 2019 01:14:04 -0800 (PST)
Received: from localhost.localdomain (36-239-237-193.dynamic-ip.hinet.net. [36.239.237.193])
        by smtp.gmail.com with ESMTPSA id o76sm18474402pfa.156.2019.02.25.01.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 01:14:02 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: arizona_ldo1: Simplify arizona_ldo1_hc_set/get_voltage_sel
Date:   Mon, 25 Feb 2019 17:13:49 +0800
Message-Id: <20190225091349.6159-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup .vsel_reg and .vsel_mask then we can use the standard
set/get_voltage_sel_regmap helpers to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/arizona-ldo1.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index dfed6d3f03ad..bf3ab405eed1 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -43,8 +43,7 @@ struct arizona_ldo1 {
 static int arizona_ldo1_hc_set_voltage_sel(struct regulator_dev *rdev,
 					   unsigned sel)
 {
-	struct arizona_ldo1 *ldo = rdev_get_drvdata(rdev);
-	struct regmap *regmap = ldo->regmap;
+	struct regmap *regmap = rdev_get_regmap(rdev);
 	unsigned int val;
 	int ret;
 
@@ -61,16 +60,12 @@ static int arizona_ldo1_hc_set_voltage_sel(struct regulator_dev *rdev,
 	if (val)
 		return 0;
 
-	val = sel << ARIZONA_LDO1_VSEL_SHIFT;
-
-	return regmap_update_bits(regmap, ARIZONA_LDO1_CONTROL_1,
-				  ARIZONA_LDO1_VSEL_MASK, val);
+	return regulator_set_voltage_sel_regmap(rdev, sel);
 }
 
 static int arizona_ldo1_hc_get_voltage_sel(struct regulator_dev *rdev)
 {
-	struct arizona_ldo1 *ldo = rdev_get_drvdata(rdev);
-	struct regmap *regmap = ldo->regmap;
+	struct regmap *regmap = rdev_get_regmap(rdev);
 	unsigned int val;
 	int ret;
 
@@ -81,11 +76,7 @@ static int arizona_ldo1_hc_get_voltage_sel(struct regulator_dev *rdev)
 	if (val & ARIZONA_LDO1_HI_PWR)
 		return rdev->desc->n_voltages - 1;
 
-	ret = regmap_read(regmap, ARIZONA_LDO1_CONTROL_1, &val);
-	if (ret != 0)
-		return ret;
-
-	return (val & ARIZONA_LDO1_VSEL_MASK) >> ARIZONA_LDO1_VSEL_SHIFT;
+	return regulator_get_voltage_sel_regmap(rdev);
 }
 
 static const struct regulator_ops arizona_ldo1_hc_ops = {
@@ -108,6 +99,8 @@ static const struct regulator_desc arizona_ldo1_hc = {
 	.type = REGULATOR_VOLTAGE,
 	.ops = &arizona_ldo1_hc_ops,
 
+	.vsel_reg = ARIZONA_LDO1_CONTROL_1,
+	.vsel_mask = ARIZONA_LDO1_VSEL_MASK,
 	.bypass_reg = ARIZONA_LDO1_CONTROL_1,
 	.bypass_mask = ARIZONA_LDO1_BYPASS,
 	.linear_ranges = arizona_ldo1_hc_ranges,
-- 
2.17.1


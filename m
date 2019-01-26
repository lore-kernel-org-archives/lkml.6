Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2364C282C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6117218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="sgAT9sYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfAZDkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:40:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36424 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbfAZDkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:40:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so5431473plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 19:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dzsOiGH/R3nCY1ZAjsq4uxfEl0pQ2SbbvsP+tc/yPtg=;
        b=sgAT9sYNWIx/qhe9C9rVfqgCHVTe8a4yeYZi6bysYUSuJt2QfD2PXtfQLoqHl5usnt
         ZBjr/4CnCKBxPJrlmkhd/i3FEpzQLACq+GuDcyZ7ZYrl3jD5qp3iCH0AB5kNPWnTyxfQ
         r+rEBwkVfCmSqarPWh67ablEnzqqo6ouAaGK2krTSW3tDLlFb7jYHMlsZSZ1k5AWdmpX
         4yexOxVgo9/+ESZn8rXrEuSrsMa8G+ij27WbsKBEQcMKggYpEWBj53QuEAxHKTzcfIni
         hGISIrP96ltVOjLcTo+5p6mmRV6tBdkgcq9Y872A1IRwNJw8RchVNOtvjCYAt9AXSB64
         605w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dzsOiGH/R3nCY1ZAjsq4uxfEl0pQ2SbbvsP+tc/yPtg=;
        b=bsZK1rBEbc+wL62Oxp9u7O2PfBIefOH06tbOg+C5d3aew7xajS9nImxBHzLz8mrqp8
         gxsxUE+w3ZAee89Kbe4gZytoWJLsOOpDIqOuh/QfmDB10lADhOLvg92hFBYDAWX3SWfm
         MyMg0c7FETKhbGmdl1vcrv/YLtRmC835Lj/Jb1lGIJQ2Wx3pHaUwoIpWNW+ZHMKKOuce
         tXzMYtQnFXxc/0iA4skZOdJ6RH4ZbVjn2uOW96/45kFQdjr3C/ndWItImkUdcvAsrPj/
         2tI+EmPEPzXd0T3PnzXR9UKRsEmYr8xwEfcJwe5Y1jweXdgAeMedgzKnYJSJhe0BmJmY
         AtBw==
X-Gm-Message-State: AJcUukdIIQj2ZV3SgJA5UFgKnJ6tdnwSMu4m8uBqwZzAbWc19j4eQZCg
        bRjjFkGvdxsjd7YEZpYO7ut1nA==
X-Google-Smtp-Source: ALg8bN6CnXn1VAWxJFwB9jhfM2iBj1cF/Gz8TshOWZKZtC1lpOakOfS7PsGV9dj7Ld01oTkh3ZO5mA==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr13028087plb.6.1548474009610;
        Fri, 25 Jan 2019 19:40:09 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 24sm37460086pfr.75.2019.01.25.19.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 19:40:09 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 4/8] regulator: lp873x: Constify lp873x_buck01_ops and lp873x_ldo01_ops
Date:   Sat, 26 Jan 2019 11:39:03 +0800
Message-Id: <20190126033907.18427-4-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126033907.18427-1-axel.lin@ingics.com>
References: <20190126033907.18427-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp873x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index 70e3df653381..2ec5e833c379 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -146,7 +146,7 @@ static int lp873x_buck_get_current_limit(struct regulator_dev *rdev)
 }
 
 /* Operations permitted on BUCK0, BUCK1 */
-static struct regulator_ops lp873x_buck01_ops = {
+static const struct regulator_ops lp873x_buck01_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -161,7 +161,7 @@ static struct regulator_ops lp873x_buck01_ops = {
 };
 
 /* Operations permitted on LDO0 and LDO1 */
-static struct regulator_ops lp873x_ldo01_ops = {
+static const struct regulator_ops lp873x_ldo01_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
-- 
2.17.1


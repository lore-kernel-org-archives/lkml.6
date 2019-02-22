Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EEDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ECE2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="ef0KxZaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfBVJJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:09:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42595 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVJJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:09:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so838236pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mXQLSAdHEi/4DUOK0YaskYQsxvjQ7kwSNApMlAyJhK4=;
        b=ef0KxZaHQaQB48EteeM1RZpPI9WpzCkFmiOccZ88bV6g+uHSDZnFzWseRuYVkskbFw
         vn0eNQdsjqiqFOMLsEfvmTBKAm+SAqGq7uYGDfTphrs2ttNnDljxHUn2O8iVnaweZQdc
         fs8miWVsw191EvJ5eo7NN0pdhJBj/yhYGRp5cTKXZlDTutVS6qH2g2rGcdLQphvylsHo
         ViV8k80hgqQnXCeKtsf74bOXqk6AMlEGYuKJ/mAMel/h8SfQUc34Mk8wCj0ZPBNivba7
         ++oiL1iEigyRht7WBOoDHumU8bt2xqL9E1Py0uTB+IG8s0smvC+7Dm3SW5EXpSscDSFE
         m6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mXQLSAdHEi/4DUOK0YaskYQsxvjQ7kwSNApMlAyJhK4=;
        b=twGO7IWhGmHgFQ/pKS8nMdmimaeipRx4VK00EhK/E2gFjaX0o7IkU6bFpwrlaMErU3
         y5LRueAWSjRgvupIhn0llLvAqt6fjhY8IUuiDKhvoqHGllRvxyx9sPG2slDJSZkfJi4q
         88OhpL6WKYG2qPOi2KTBJfXMqQbS4cHJPhDgi/j6gqT+CI+4od84b3FRRyRXhvZnJlXB
         rqgxt3wXYxfSGtq73wTuQY7vDhVZ5KC3Zolj8ZPTug3aPzwlzQFPn1+a8rypDzThocL5
         49K7zxaXWt4dnAVquGhg1zVo9WMRIUkXwpoHYXHYkxNvW1/zy4YxZHmDJyex80QgwKbe
         gixA==
X-Gm-Message-State: AHQUAuZbcDRfRNidhOnP2mAHu/3JCNCpdOhiQUBVSHvar8uTg2GUjar5
        zaLicwHP2Qn0vDENmGUU6bguWg==
X-Google-Smtp-Source: AHgI3IbOYuBBXDneUz+pEFCjWKL+JODtMuDcM9dAZR2u4x7JYxKHs6L7Md7WYLYOigU5Hus4KNSJhw==
X-Received: by 2002:a65:6091:: with SMTP id t17mr3040112pgu.416.1550826579118;
        Fri, 22 Feb 2019 01:09:39 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id a15sm2769719pgd.4.2019.02.22.01.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 01:09:38 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max77650: Fix set_current_limit implementation
Date:   Fri, 22 Feb 2019 17:09:21 +0800
Message-Id: <20190222090921.2068-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code always return error, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max77650-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 411912d5278b..a1af414db751 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -243,7 +243,7 @@ static int max77650_regulator_set_current_limit(struct regulator_dev *rdev,
 {
 	struct max77650_regulator_desc *rdesc;
 	struct regmap *map;
-	int rv, i, limit;
+	int i, limit;
 
 	rdesc = rdev_get_drvdata(rdev);
 	map = rdev_get_regmap(rdev);
@@ -252,11 +252,9 @@ static int max77650_regulator_set_current_limit(struct regulator_dev *rdev,
 		limit = max77650_current_limit_table[i];
 
 		if (limit >= min_uA && limit <= max_uA) {
-			rv = regmap_update_bits(map, rdesc->regA,
+			return regmap_update_bits(map, rdesc->regA,
 					MAX77650_REGULATOR_CURR_LIM_MASK,
 					MAX77650_REGULATOR_CURR_LIM_SHIFT(i));
-			if (rv)
-				return rv;
 		}
 	}
 
-- 
2.17.1


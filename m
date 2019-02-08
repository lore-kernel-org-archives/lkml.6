Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B917C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7B12177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="I7hGWnOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfBHOMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:12:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38413 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfBHOMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:12:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so1634096pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=upLxb8FYOOB0a3AN+WEMWBMy2FJ8QnNHx4fmloyVXyI=;
        b=I7hGWnOvMTUQHjiu9rXcxKOaYjnCRH/04iAWprsW6Dw3/0e5WjdYsJ1eaNk+iijCzS
         UmksFWWtHeVe1S+rvpv2XAdEzO/Bt5/PPghCIK4JYVbpGruUkLcnv/Ud1kHSLcuR/kEf
         O1rcRLvf+4lVI1QQ4tySLw6O5ijBuDeA2eVGO9KUG3kIOp7npvk3jFxfA++bqQg7xxvV
         RM0uGX3RMYfI6JYiuErSzBYgD2oMJburIFt7MsptTai9JvaxQ+P+bYepwQJIgCZBtc9R
         0zKdy5/gVS5f55SxWfM2IAHc/9N62dYGFRsGPfQn96XjJK5/230zbBi1UBTdDiX6uSHz
         THUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=upLxb8FYOOB0a3AN+WEMWBMy2FJ8QnNHx4fmloyVXyI=;
        b=K766ED6COCdoExuxigIjhZrOEhyNen/u3ZbcwrZr5OvXRRsvGJB+5suAZb2WpI9FeK
         TL48O8RDgjsanRRdfSO4nfH1lPayNpKStz3edv6JT3v/mmzwvIkgbXgeoWRcFmfoLV8c
         pPVGzp+TI95HfBSVZHFU0S/6W+gj+NeqA1Rc92et7BHuU6JCKQq3OWsUuaozL2T7EFEq
         0xsKNXlKNdmsWo+0tk1yCDdBDZjrg9I3fz+1bquhcPELXHDou5ycgX2Llf/D6a/iIdOf
         gI2aVbIeT6celsPBGAiQRylPB6Goy6mlKvCxffUMcYbWysQpyJ5raaeB7GmkEbgd05ho
         DYRQ==
X-Gm-Message-State: AHQUAuZ+WUwngexHQA9LaBsIk/jqgYj4hli8053oI/B4PckebinJa+6V
        JyAujubNHcDdPPhTHSvQL49YmQ==
X-Google-Smtp-Source: AHgI3IaSCtUGGr5R+R+CApFtB4Iuz376FYv9XwMgkA/sz9XsfwT/g6OV4khEBt88Ikinp5FTnw6y8Q==
X-Received: by 2002:a65:44ca:: with SMTP id g10mr17421622pgs.180.1549635128057;
        Fri, 08 Feb 2019 06:12:08 -0800 (PST)
Received: from localhost.localdomain (36-239-237-75.dynamic-ip.hinet.net. [36.239.237.75])
        by smtp.gmail.com with ESMTPSA id 184sm3411700pfe.106.2019.02.08.06.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:12:06 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: lm363x: Check return value of gpiod_get_index_optional
Date:   Fri,  8 Feb 2019 22:11:52 +0800
Message-Id: <20190208141152.13887-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiod_get_index_optional can return ERR_PTR, add IS_ERR checking for it.
While at it, also remove a redundant NULL test for gpiod in error path.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lm363x-regulator.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index 8c0e8419c43f..c876e161052a 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -258,6 +258,9 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
 	 * Register update is required if the pin is used.
 	 */
 	gpiod = lm363x_regulator_of_get_enable_gpio(dev, id);
+	if (IS_ERR(gpiod))
+		return PTR_ERR(gpiod);
+
 	if (gpiod) {
 		cfg.ena_gpiod = gpiod;
 
@@ -265,8 +268,7 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
 					 LM3632_EXT_EN_MASK,
 					 LM3632_EXT_EN_MASK);
 		if (ret) {
-			if (gpiod)
-				gpiod_put(gpiod);
+			gpiod_put(gpiod);
 			dev_err(dev, "External pin err: %d\n", ret);
 			return ret;
 		}
-- 
2.17.1


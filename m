Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB1AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B7C2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="NGnMFEka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbfA3NEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:04:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46233 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfA3NEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:04:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so10289938pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=IOJh5cFz0hYqAE0BPjw73b9BbMxTZ+YqYtizXRisyaI=;
        b=NGnMFEkaYq04HnY0Elo6WcH9a9g8m3P6gTrd+vrC/iqLHB2XWwwxHKpSdwaNFJHZIk
         ooeX3UU1lOzI7PpUFVuW+u3hhiUqbk4b1iNMPqc2My1cF+Mmy1uddVw2Sg+o9ospZjDb
         SnNzDDxwHasV1BIEiAUXX49LfYvL3aghA2OpXT0ylJ1gw4xXf4nWgMrETnS++EaWTIxb
         SFQCFI1yMt9xT+U/0L0DckymRON/mFtqKLIWzDzk/Y6QviVXvPTppcjIJa674sxlzGVd
         isGR/Kjhn+ADHnvGUZiWKhO4hSYyUXXzZ0s2Wo2nGUb5Dbglv8RObh+sMNCPGIbub0N4
         dV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IOJh5cFz0hYqAE0BPjw73b9BbMxTZ+YqYtizXRisyaI=;
        b=GxJbciiZv05P4QM+wIn9LJDmE39ub+BfdCgkX1XTHVtDkWr0iWxiImS+5tHzA4FFS+
         UbVA/oSrGzgdIFQwHJDCzlbw6oMDiUEh5hJFYg230oNni0IzdatXDRv9/OiTiwaUlQoc
         Ky4v4XrGPgrsuyFSNemGY/6E3ck7auixGpdj/UQGbQfiClH/WOkBOOuZ/StbSHiKbIUm
         DClDdOs1sPP80yNXoorrgpyyF4HrsxkZYlzcIOb8A+WAaIb/3asNdsmG7x8/ihENVFT6
         dOy3atc52rf7X1SrL5nvLH0XzBBnZIhRkdBUIZF0KjuhduUt2AM3Ef1u/9BvdlgwPOFQ
         kVeQ==
X-Gm-Message-State: AJcUukcaIhAhDbiHnjUmPAVpbGJUnfw+84zrcYN9+d0zckFtLhmWaxR7
        2BtICHc0gnWfu5EIypGQ8diBPg==
X-Google-Smtp-Source: ALg8bN4JrB8WOAmY86audoPue+Jm635UY0/811HUq5oJJ6SKGOdHkQT7dltP+Cx49kNKhtAjO5ro2w==
X-Received: by 2002:a63:a401:: with SMTP id c1mr27698035pgf.403.1548853477419;
        Wed, 30 Jan 2019 05:04:37 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id m3sm5128033pff.173.2019.01.30.05.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 05:04:36 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: lp8788-ldo: Remove *desc and *regulator from struct lp8788_ldo
Date:   Wed, 30 Jan 2019 21:04:18 +0800
Message-Id: <20190130130419.23548-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are not used at all, remove them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp8788-ldo.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index a2ef146e6b3a..172b5f9355dd 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -113,8 +113,6 @@ enum lp8788_ldo_id {
 
 struct lp8788_ldo {
 	struct lp8788 *lp;
-	struct regulator_desc *desc;
-	struct regulator_dev *regulator;
 	struct gpio_desc *ena_gpiod;
 };
 
@@ -558,7 +556,6 @@ static int lp8788_dldo_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ldo->regulator = rdev;
 	platform_set_drvdata(pdev, ldo);
 
 	return 0;
@@ -605,7 +602,6 @@ static int lp8788_aldo_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ldo->regulator = rdev;
 	platform_set_drvdata(pdev, ldo);
 
 	return 0;
-- 
2.17.1


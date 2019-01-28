Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C445C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="hCyk6xrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfA1OCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:02:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34455 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfA1OCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:02:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so8053172pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=KtmU5dD1rLyhwI51CxowmcrDTgRChmsNZA99ELtLZRE=;
        b=hCyk6xrw8rytyfE25jatFI70y2+2ooh22e/UTMH/UxCczy5mKQ34evFNnnODp3w75k
         tXHzjWD/jLK3bsxdYEb9xvNynPacTBMe04vbIdHQcnLnsOPeMCROcJQW6d3OW9udrmW6
         OOV1zHQKKFIPhQYWblMOoZ/8n7DYFtVbMz33UWClDEhpZgDeDgzdI4pD2k8wBsmTzs8D
         G1CUexUV7ZnAlmlb98/YQZZcvJsbRhu24MZmwKIN0ky5uy3nNU3OUuHy+14isvjQ7GKC
         U+55yodLrCYsa7GvowQ/6z79ABWj7oBpXcb0+B00ryPEosn6RMEfT3EjkNnDIiRC8GiR
         m03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KtmU5dD1rLyhwI51CxowmcrDTgRChmsNZA99ELtLZRE=;
        b=FqVxZhJocjrgXsQebsl7ZecyP+sR3stLExiO/YcXDjD1U4k24M517eArjaFvDzElOR
         C9THe0Jr0Mbqc1BGJ3V7aArtkrZmLX8Cp66wnNRP+CdAMbG9afLcki19W57RrUcuPgOj
         KBZjGgL0XJYSkjC8pLdOzHlocBIWlXq/gXtwn5ly3IKjK+yv/qdbIHyBS9kdF7IXwz5H
         cCK24kNJ22HrZi5zZv9sBR2BCxi281DYHBUjWq8Oq8vCd2C8Rn4pdYSTqR/LPiKek46l
         qp00yB8llmlHRzkIYNz95L69ztrNwc1KVL4AA35Wjfka9dtLW6jIgOy5HFM39qh1ZbJA
         18dg==
X-Gm-Message-State: AJcUukcnSIamVVZV4O0hUuyj6kqseHu4kJYfrpHMng6qtvmhUhBglZdg
        hARvtigIfMFAfl6dpRnafkHz3g==
X-Google-Smtp-Source: ALg8bN6OjdB6DVk9bAgYOrLJunoWsARixG25UUDfA677K+sXKrnydC2UXcPwQOeHCP0WqA1xp9qybA==
X-Received: by 2002:a62:53c5:: with SMTP id h188mr21639827pfb.190.1548684157612;
        Mon, 28 Jan 2019 06:02:37 -0800 (PST)
Received: from localhost.localdomain (36-239-222-123.dynamic-ip.hinet.net. [36.239.222.123])
        by smtp.gmail.com with ESMTPSA id h82sm68276064pfa.105.2019.01.28.06.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:02:36 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: axp20x: Fix incorrect vsel_mask settings
Date:   Mon, 28 Jan 2019 22:02:19 +0800
Message-Id: <20190128140219.4414-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix copy-paste mistake while converting to use defines for masks.

Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/axp20x-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 087cadb96fab..6d081c8321a1 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -577,7 +577,7 @@ static const struct regulator_desc axp22x_regulators[] = {
 		 AXP22X_DCDC3_V_OUT, AXP22X_DCDC3_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL1, AXP22X_PWR_OUT_DCDC3_MASK),
 	AXP_DESC(AXP22X, DCDC4, "dcdc4", "vin4", 600, 1540, 20,
-		 AXP22X_DCDC4_V_OUT, AXP22X_DCDC4_V_OUT,
+		 AXP22X_DCDC4_V_OUT, AXP22X_DCDC4_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL1, AXP22X_PWR_OUT_DCDC4_MASK),
 	AXP_DESC(AXP22X, DCDC5, "dcdc5", "vin5", 1000, 2550, 50,
 		 AXP22X_DCDC5_V_OUT, AXP22X_DCDC5_V_OUT_MASK,
@@ -956,7 +956,7 @@ static const struct regulator_desc axp813_regulators[] = {
 		 AXP22X_ALDO1_V_OUT, AXP22X_ALDO1_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO1_MASK),
 	AXP_DESC(AXP813, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
-		 AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT,
+		 AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO2_MASK),
 	AXP_DESC(AXP813, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
 		 AXP22X_ALDO3_V_OUT, AXP22X_ALDO3_V_OUT_MASK,
@@ -966,7 +966,7 @@ static const struct regulator_desc axp813_regulators[] = {
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO1_MASK),
 	AXP_DESC_RANGES(AXP813, DLDO2, "dldo2", "dldoin",
 			axp803_dldo2_ranges, AXP803_DLDO2_NUM_VOLTAGES,
-			AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT,
+			AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT_MASK,
 			AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO2_MASK),
 	AXP_DESC(AXP813, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
 		 AXP22X_DLDO3_V_OUT, AXP22X_DLDO3_V_OUT_MASK,
@@ -981,7 +981,7 @@ static const struct regulator_desc axp813_regulators[] = {
 		 AXP22X_ELDO2_V_OUT, AXP22X_ELDO2_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO2_MASK),
 	AXP_DESC(AXP813, ELDO3, "eldo3", "eldoin", 700, 1900, 50,
-		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT,
+		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO3_MASK),
 	/* to do / check ... */
 	AXP_DESC(AXP813, FLDO1, "fldo1", "fldoin", 700, 1450, 50,
-- 
2.17.1


Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3EDC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E50C218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548431834;
	bh=SkX1ewLFPA5g/FP0Y3G7x6hwqN/9cDUe1Ec2vu58fNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2J8wfapamL/wB2MHIGMnuKTtrU4uD10sDHaSYDha8LTBNeVi3ptHD/9JhUr3isSiK
	 4K/M8qHTiSVFkRGaq3aPnbiOXd0qlitIWGXrPETprFSti/UqybZfVWmr7r2AaGdyDa
	 tg5BICK296PHAQLtXUgxYTNqv16s0wJSVVUXwpRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfAYP5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:57:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35156 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYP5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:57:12 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so8022818oif.2;
        Fri, 25 Jan 2019 07:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yznjzNNy1+1fIbKuH6Qgt44pp5Q8zl8F/RgJ2eO6RFw=;
        b=lpUqZjZD+tzq0d6qU+KcAHALjjXeTU8Y+PQ0hq0e1cKq9zcZjnkTEM7VWg0nSkIm/w
         ZGbMZ5wZh2nEF2biacDmgiMd6Lj/p/xXbgKVa2AtV8praq2yO/IJqkmU995Tn9ZtSfHN
         jDOEmuKyl01IUtXnuLoYPY7Hn8fySnGWYeuPwzbwG9pv+RkGuYyP9KfAYXjyxK0D6kNV
         rnV9VUPpocrxUWeSs62Vcm5C/f4nqDlWd4gEELjK11zKQmFdFjCLEk78O7tFB16Ue4rm
         5cjRM7xyZGe8NTqoekjUs5ysCI67ovb6jg3MvjiZOn9vBlGZ2muhEceMLnGCqc8hem47
         kYMg==
X-Gm-Message-State: AJcUukcx7FZvm/NPlj2nUDQoY1JsiEPbk0dUQgnPwIdSc0A20ogI9e4D
        lr2SCbEhWLNzujc2LRAHEzEsoFU=
X-Google-Smtp-Source: AHgI3IYYS1ChxnEwZrRF7ZEJVZdBas0htnypEUViOtmceAE94fVj5JdTu3mmeaPslM7sjOomWIYtmQ==
X-Received: by 2002:aca:e715:: with SMTP id e21mr1684734oih.76.1548430629308;
        Fri, 25 Jan 2019 07:37:09 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id w5sm1259009oif.48.2019.01.25.07.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 07:37:08 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 2/2] regulator: da9052: Use lowercase regulator names to match the DT
Date:   Fri, 25 Jan 2019 09:37:05 -0600
Message-Id: <20190125153705.29921-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125153705.29921-1-robh@kernel.org>
References: <20190125153705.29921-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since c32569e358ad ("regulator: Use of_node_name_eq for node name
comparisons"), regulator node name comparisons are case sensitive.
The DA9052 driver uses uppercase, but the DT has lowercase.

Fix this by using a lowercase regulator name to match the DT node name.

Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/regulator/da9052-regulator.c | 64 ++++++++++++++--------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index 207cb3859dcc..cefa3558236d 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -290,10 +290,10 @@ static const struct regulator_ops da9052_ldo_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-#define DA9052_LDO(_id, step, min, max, sbits, ebits, abits) \
+#define DA9052_LDO(_id, _name, step, min, max, sbits, ebits, abits) \
 {\
 	.reg_desc = {\
-		.name = #_id,\
+		.name = #_name,\
 		.ops = &da9052_ldo_ops,\
 		.type = REGULATOR_VOLTAGE,\
 		.id = DA9052_ID_##_id,\
@@ -310,10 +310,10 @@ static const struct regulator_ops da9052_ldo_ops = {
 	.activate_bit = (abits),\
 }
 
-#define DA9052_DCDC(_id, step, min, max, sbits, ebits, abits) \
+#define DA9052_DCDC(_id, _name, step, min, max, sbits, ebits, abits) \
 {\
 	.reg_desc = {\
-		.name = #_id,\
+		.name = #_name,\
 		.ops = &da9052_dcdc_ops,\
 		.type = REGULATOR_VOLTAGE,\
 		.id = DA9052_ID_##_id,\
@@ -331,37 +331,37 @@ static const struct regulator_ops da9052_ldo_ops = {
 }
 
 static struct da9052_regulator_info da9052_regulator_info[] = {
-	DA9052_DCDC(BUCK1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
-	DA9052_DCDC(BUCK2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
-	DA9052_DCDC(BUCK3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
-	DA9052_DCDC(BUCK4, 50, 1800, 3600, 5, 6, 0),
-	DA9052_LDO(LDO1, 50, 600, 1800, 5, 6, 0),
-	DA9052_LDO(LDO2, 25, 600, 1800, 6, 6, DA9052_SUPPLY_VLDO2GO),
-	DA9052_LDO(LDO3, 25, 1725, 3300, 6, 6, DA9052_SUPPLY_VLDO3GO),
-	DA9052_LDO(LDO4, 25, 1725, 3300, 6, 6, 0),
-	DA9052_LDO(LDO5, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO6, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO7, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO8, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO9, 50, 1250, 3650, 6, 6, 0),
-	DA9052_LDO(LDO10, 50, 1200, 3600, 6, 6, 0),
+	DA9052_DCDC(BUCK1, buck1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
+	DA9052_DCDC(BUCK2, buck2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
+	DA9052_DCDC(BUCK3, buck3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
+	DA9052_DCDC(BUCK4, buck4, 50, 1800, 3600, 5, 6, 0),
+	DA9052_LDO(LDO1, ldo1, 50, 600, 1800, 5, 6, 0),
+	DA9052_LDO(LDO2, ldo2, 25, 600, 1800, 6, 6, DA9052_SUPPLY_VLDO2GO),
+	DA9052_LDO(LDO3, ldo3, 25, 1725, 3300, 6, 6, DA9052_SUPPLY_VLDO3GO),
+	DA9052_LDO(LDO4, ldo4, 25, 1725, 3300, 6, 6, 0),
+	DA9052_LDO(LDO5, ldo5, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO6, ldo6, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO7, ldo7, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO8, ldo8, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO9, ldo9, 50, 1250, 3650, 6, 6, 0),
+	DA9052_LDO(LDO10, ldo10, 50, 1200, 3600, 6, 6, 0),
 };
 
 static struct da9052_regulator_info da9053_regulator_info[] = {
-	DA9052_DCDC(BUCK1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
-	DA9052_DCDC(BUCK2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
-	DA9052_DCDC(BUCK3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
-	DA9052_DCDC(BUCK4, 25, 950, 2525, 6, 6, 0),
-	DA9052_LDO(LDO1, 50, 600, 1800, 5, 6, 0),
-	DA9052_LDO(LDO2, 25, 600, 1800, 6, 6, DA9052_SUPPLY_VLDO2GO),
-	DA9052_LDO(LDO3, 25, 1725, 3300, 6, 6, DA9052_SUPPLY_VLDO3GO),
-	DA9052_LDO(LDO4, 25, 1725, 3300, 6, 6, 0),
-	DA9052_LDO(LDO5, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO6, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO7, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO8, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO9, 50, 1250, 3650, 6, 6, 0),
-	DA9052_LDO(LDO10, 50, 1200, 3600, 6, 6, 0),
+	DA9052_DCDC(BUCK1, buck1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
+	DA9052_DCDC(BUCK2, buck2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
+	DA9052_DCDC(BUCK3, buck3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
+	DA9052_DCDC(BUCK4, buck4, 25, 950, 2525, 6, 6, 0),
+	DA9052_LDO(LDO1, ldo1, 50, 600, 1800, 5, 6, 0),
+	DA9052_LDO(LDO2, ldo2, 25, 600, 1800, 6, 6, DA9052_SUPPLY_VLDO2GO),
+	DA9052_LDO(LDO3, ldo3, 25, 1725, 3300, 6, 6, DA9052_SUPPLY_VLDO3GO),
+	DA9052_LDO(LDO4, ldo4, 25, 1725, 3300, 6, 6, 0),
+	DA9052_LDO(LDO5, ldo5, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO6, ldo6, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO7, ldo7, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO8, ldo8, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO9, ldo9, 50, 1250, 3650, 6, 6, 0),
+	DA9052_LDO(LDO10, ldo10, 50, 1200, 3600, 6, 6, 0),
 };
 
 static inline struct da9052_regulator_info *find_regulator_info(u8 chip_id,
-- 
2.19.1


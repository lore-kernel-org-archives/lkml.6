Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC24C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E8820850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039483;
	bh=1mPaYs9d3oCiEl4rXy5LuwNSdNrj0v1uKqA6EisZOHs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oNBNf4PkhCsERF7L+IyeY4wqrloueanoXe+YpICknd34BapBD3JazShCqy5WYV6Oa
	 3jgThAboxW/QG/hVZGopxKH4T6hFjtP28sBbLVcnmw8k+UNPeV7TYzoFEdtKDyIS2g
	 VnKoqBnwC/AjJ5mvLXKOggDDtNeJ7fsFVVKr7WwM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E8820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeLETvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:22 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37611 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbeLETvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so19802365oth.4;
        Wed, 05 Dec 2018 11:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZT2CIk3VKIW0+KTeOjaZQKGiIbm+8YjA18EhBPqm0fo=;
        b=p+cHTyO2SjkfWTiTuM1GMF+2pHscE3M+AqxT7CixphE35I/hQV7XrruG8PK83wGN80
         RrDaMaZeZxKWZO+4eU1ZYJ1yvT/uRaElMd+Ps3mHY3xvEgE3p2nIWfZwacSqrfi9RvR5
         oDsX0csdER2XQ0OjwAXYiEopsv+zjLgCpLfapViPFQv9EeG/eEg54AnuQAqGNyAs9XtI
         1MfbuVsJ+z2e6myVnF3Oq7fjC0Dz0MeCiNuQAqf6Pn82IzpoaciRmRGA+8Rg5sk6CbB0
         GgHwYMw/vU+lO/CRXIWnRx2Q2gqqFB+xIUrPvUMPvYWpcGmTME319vtx0CMAnXV5xKEi
         GiyQ==
X-Gm-Message-State: AA+aEWYdC4KDhnwSdeXQMNpJ26fM7kxeRZcekdurrELEWYQN8r2aXWMJ
        pTfI/bhjVqz4DBBlZ5gBFLKJGEM=
X-Google-Smtp-Source: AFSGD/UG88ewl8KLIDzjAHD80UP4wjpOxJ5t3LyHsIlAsCPgqhGzt1yfG34CviCQ9IH3thQ8a6Tw4g==
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr15296146oth.279.1544039475230;
        Wed, 05 Dec 2018 11:51:15 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:14 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] regulator: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:37 -0600
Message-Id: <20181205195050.4759-21-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/regulator/88pm8607.c               | 2 +-
 drivers/regulator/da9052-regulator.c       | 2 +-
 drivers/regulator/max8997-regulator.c      | 2 +-
 drivers/regulator/mc13xxx-regulator-core.c | 2 +-
 drivers/regulator/qcom-rpmh-regulator.c    | 2 +-
 drivers/regulator/s5m8767.c                | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index fd86446e499b..28f55248eb90 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -328,7 +328,7 @@ static int pm8607_regulator_dt_init(struct platform_device *pdev,
 		return -ENODEV;
 	}
 	for_each_child_of_node(nproot, np) {
-		if (!of_node_cmp(np->name, info->desc.name)) {
+		if (of_node_name_eq(np, info->desc.name)) {
 			config->init_data =
 				of_get_regulator_init_data(&pdev->dev, np,
 							   &info->desc);
diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index 37e4025203e3..207cb3859dcc 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -435,7 +435,7 @@ static int da9052_regulator_probe(struct platform_device *pdev)
 			return -ENODEV;
 
 		for_each_child_of_node(nproot, np) {
-			if (!of_node_cmp(np->name,
+			if (of_node_name_eq(np,
 					 regulator->info->reg_desc.name)) {
 				config.init_data = of_get_regulator_init_data(
 					&pdev->dev, np,
diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index 3bf5ddfaaea8..4d2487279a0a 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -925,7 +925,7 @@ static int max8997_pmic_dt_parse_pdata(struct platform_device *pdev,
 	pdata->regulators = rdata;
 	for_each_child_of_node(regulators_np, reg_np) {
 		for (i = 0; i < ARRAY_SIZE(regulators); i++)
-			if (!of_node_cmp(reg_np->name, regulators[i].name))
+			if (of_node_name_eq(reg_np, regulators[i].name))
 				break;
 
 		if (i == ARRAY_SIZE(regulators)) {
diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index 65eb1e0350cf..2243138d8a58 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -186,7 +186,7 @@ struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 		for (i = 0; i < num_regulators; i++) {
 			if (!regulators[i].desc.name)
 				continue;
-			if (!of_node_cmp(child->name,
+			if (of_node_name_eq(child,
 					 regulators[i].desc.name)) {
 				p->id = i;
 				p->init_data = of_get_regulator_init_data(
diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 39ccf53fdeb3..b2c2d01d1637 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -410,7 +410,7 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
 	vreg->dev = dev;
 
 	for (rpmh_data = pmic_rpmh_data; rpmh_data->name; rpmh_data++)
-		if (!strcmp(rpmh_data->name, node->name))
+		if (of_node_name_eq(node, rpmh_data->name))
 			break;
 
 	if (!rpmh_data->name) {
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 219b9afda0cb..654f65abcb5a 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -561,7 +561,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 	pdata->opmode = rmode;
 	for_each_child_of_node(regulators_np, reg_np) {
 		for (i = 0; i < ARRAY_SIZE(regulators); i++)
-			if (!of_node_cmp(reg_np->name, regulators[i].name))
+			if (of_node_name_eq(reg_np, regulators[i].name))
 				break;
 
 		if (i == ARRAY_SIZE(regulators)) {
-- 
2.19.1


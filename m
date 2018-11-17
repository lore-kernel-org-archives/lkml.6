Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ED7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4C820815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWVZh3/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4C820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeKRE3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:29:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40456 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKRE3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:29:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so7206061pls.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 10:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBG44qE+mHZDSdO1ECWplE3Hb6CD5oUqffewEpSqfwI=;
        b=jWVZh3/ng480jJY7G+Kizs8gz/X94qnr9nSlNQ3WF90/wJFT+C2wJvIIb3xBK05GQH
         uFmKZfm0ogZfGkiNAjJVyDfNOEwPA0Fu4bGLCkQprTk02jkK8fmPikcbZbXyEIlV0RHY
         Y8f2on6nw9pbbmp6pqgTant/MfkqWaaqRqwzrlxqmY3sIbQ7MEDxKBWD3MrdCehw/Eyr
         nVnr9aV08hmguQ2JPHLqJ6F3lQ+MibnzgoJetfP0LraKswMchYAawSpzF7cKKSp0aXnv
         Q0MQ894Pnmj0QVHwssr7Ja/TYrd1+iFLdFhoHSiiCnYqAMbWGIsFUQ1Iu+1veFSBR5R1
         9dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBG44qE+mHZDSdO1ECWplE3Hb6CD5oUqffewEpSqfwI=;
        b=KYBBHXNRRKEv+SN35e8rlaWi/BRyadH9nSOGdkiZTce1+J7fE7Jrspo0FM3zfqdoph
         UiMfhC7e+OfzkFgdpdU2zudXkf9OsuvypB+4QG8Oj0U4gvbjchsyfUgntVP06Jhv/l8g
         twg6jasPm8XiSRY/wABJoszVSOvPkm2zigJ2rqBdxm7OoMCM494y68KB1U8DehgQzdpH
         3C5PyGBg6pt0QvipLTs0QfvM3C7bVXRMwE4X6oH2c35f8nhSyJXJoAgdtuesnXrvwNuv
         /rWv7WwCveqNtaJ0JpsD5Dtz3yzXCcrnTclq9cOfYkQTt1nFaeKO4wywKcqAznj0n/mj
         RI5g==
X-Gm-Message-State: AGRZ1gKpljSLuqBnx7Lb+xBybCPVs3ApDadTgshzhZbVL0m2jOAW1vgW
        lTpFWwQ5tpDWgD4C6o8FT0s0K7dxmL0=
X-Google-Smtp-Source: AJdET5caoviF2e3koOaZT9l2e0zXUOomxeaujWqccIAPhN3V/FQsAEt+hiQ5DKuwkAAmy94Cgr3ilA==
X-Received: by 2002:a17:902:1c9:: with SMTP id b67-v6mr16256907plb.152.1542478336334;
        Sat, 17 Nov 2018 10:12:16 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g190sm34634026pgc.28.2018.11.17.10.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 10:12:15 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] soc: imx: gpcv2: Make regmap access table variant specific.
Date:   Sat, 17 Nov 2018 10:12:05 -0800
Message-Id: <20181117181206.10267-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117181206.10267-1-andrew.smirnov@gmail.com>
References: <20181117181206.10267-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move regmap access table to be a part of struct imx_pgc_domain_data in
order to allow supporting multiple GPCv2 variants.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 43 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 0835999f1ed0..184ffd4cc9aa 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -67,6 +67,7 @@ struct imx_pgc_domain {
 struct imx_pgc_domain_data {
 	const struct imx_pgc_domain *domains;
 	size_t domains_num;
+	struct regmap_access_table access_table;
 };
 
 static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
@@ -198,9 +199,24 @@ static const struct imx_pgc_domain imx7_pgc_domains[] = {
 	},
 };
 
+static const struct regmap_range imx7_yes_ranges[] = {
+	regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+			 GPC_M4_PU_PDN_FLG),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
+			 GPC_PGC_SR(PGC_MIPI)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_PCIE),
+			 GPC_PGC_SR(PGC_PCIE)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_USB_HSIC),
+			 GPC_PGC_SR(PGC_USB_HSIC)),
+};
+
 static const struct imx_pgc_domain_data imx7_pgc_domain_data = {
 	.domains = imx7_pgc_domains,
 	.domains_num = ARRAY_SIZE(imx7_pgc_domains),
+	.access_table = {
+		.yes_ranges	= yes_ranges,
+		.n_yes_ranges	= ARRAY_SIZE(yes_ranges),
+	},
 };
 
 static int imx_pgc_domain_probe(struct platform_device *pdev)
@@ -265,30 +281,17 @@ builtin_platform_driver(imx_pgc_domain_driver)
 
 static int imx_gpcv2_probe(struct platform_device *pdev)
 {
-	const struct imx_pgc_domain_data *domain_data;
-	static const struct regmap_range yes_ranges[] = {
-		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
-				 GPC_M4_PU_PDN_FLG),
-		regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
-				 GPC_PGC_SR(PGC_MIPI)),
-		regmap_reg_range(GPC_PGC_CTRL(PGC_PCIE),
-				 GPC_PGC_SR(PGC_PCIE)),
-		regmap_reg_range(GPC_PGC_CTRL(PGC_USB_HSIC),
-				 GPC_PGC_SR(PGC_USB_HSIC)),
-	};
-	static const struct regmap_access_table access_table = {
-		.yes_ranges	= yes_ranges,
-		.n_yes_ranges	= ARRAY_SIZE(yes_ranges),
-	};
-	static const struct regmap_config regmap_config = {
+	struct device *dev = &pdev->dev;
+	const struct imx_pgc_domain_data *
+		domain_data = of_device_get_match_data(dev);
+	const struct regmap_config regmap_config = {
 		.reg_bits	= 32,
 		.val_bits	= 32,
 		.reg_stride	= 4,
-		.rd_table	= &access_table,
-		.wr_table	= &access_table,
+		.rd_table	= &domain_data->access_table,
+		.wr_table	= &domain_data->access_table,
 		.max_register   = SZ_4K,
 	};
-	struct device *dev = &pdev->dev;
 	struct device_node *pgc_np, *np;
 	struct regmap *regmap;
 	struct resource *res;
@@ -313,8 +316,6 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	domain_data = of_device_get_match_data(&pdev->dev);
-
 	for_each_child_of_node(pgc_np, np) {
 		struct platform_device *pd_pdev;
 		struct imx_pgc_domain *domain;
-- 
2.19.1


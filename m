Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E90CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE28120815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1VGcqSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE28120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeKRE3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:29:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42636 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKRE3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:29:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id x21-v6so9925921pln.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIkA2xbehBvP9cER5i9snepoBOZM92ap6NFaUP64/go=;
        b=R1VGcqSVW/IU6P1QgfLSHhNlZAZPEY67SUL5FQvr1y5iDc4s4zPfl1RsJ3EwtkFypg
         LpeK+gFDDW94VD7Q0nGuEwOZvZ3hKKKJ5g4cyVJHi2tiCRn4orfUB5Tm/dHcS73dgn0c
         V+bXN/WnSOur/IaOEbvj+3x8p6B5q9umAmDS8cPnSWb5xuvUEbJAf/sZXrcXGfmN7acH
         WhlyKUXp8miCHoGl42AujD2DDYi3lB+skuDtfRdTJ/rN79pEKn13bNWZOV5uzc6E/Khc
         6Ps7/kZTi3jYaZv8AMLCWzo3tYQHBvflkrDjDySMYx7h4VgMTAAzz3xBBZSWUIWnWwK6
         JU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIkA2xbehBvP9cER5i9snepoBOZM92ap6NFaUP64/go=;
        b=G2FDdpnTxBlHhEspVd7p2VE+u5QN+Dou4yso5LYyeiMDhzyJyYABZM/3yVL56WbCZa
         BMKXjrJj/ooUV7Z4DEgWdunk4XYWwH84P0jEHCQxWG+COnYZTpSRvtu3oa6Vm4VO1Aoa
         7Q281DOLu32n/aeZF/6owh1oaJcmSWdeDj+vp2zqARvuSl/gLZXvMq4o5ItjknXGm2KC
         42H2RI0qJxum+82Dnvfh4Ztun5Lp9RXo6GGVSwVnqbmIoo3qiPdl8eVG+sCJ7jKSvjFz
         /ly+Iixja+yP8YY9Sz+3nPB43HGKciGaqSJJf2CkFJW6MkWZt6HukXl6iAXRRlxmmfd3
         YNOw==
X-Gm-Message-State: AGRZ1gLrekigAsgNUCcaqlBR17zYu7iJwpHSnRKf3Uk/AXl2ahr8kqlg
        nktdoZG4vtNzpyTCxKXTIBh7MlUguF4=
X-Google-Smtp-Source: AJdET5cr2OV4qlkQ8bQJU0VwgjpkAqu8dgmGTZ5oO4GE5AnTTvKj1uYVoHeXhzsILNQ4cEAaplen1A==
X-Received: by 2002:a17:902:2867:: with SMTP id e94-v6mr15982374plb.317.1542478334326;
        Sat, 17 Nov 2018 10:12:14 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g190sm34634026pgc.28.2018.11.17.10.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 10:12:13 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] soc: imx: gpcv2: Remove static qualifier from domain_data
Date:   Sat, 17 Nov 2018 10:12:04 -0800
Message-Id: <20181117181206.10267-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117181206.10267-1-andrew.smirnov@gmail.com>
References: <20181117181206.10267-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/soc/imx/gpcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index e7b5994fee9d..0835999f1ed0 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -265,7 +265,7 @@ builtin_platform_driver(imx_pgc_domain_driver)
 
 static int imx_gpcv2_probe(struct platform_device *pdev)
 {
-	static const struct imx_pgc_domain_data *domain_data;
+	const struct imx_pgc_domain_data *domain_data;
 	static const struct regmap_range yes_ranges[] = {
 		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
 				 GPC_M4_PU_PDN_FLG),
-- 
2.19.1


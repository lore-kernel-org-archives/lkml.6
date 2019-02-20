Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E6FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C901D2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNlZ3iJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfBTB7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:59:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37763 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfBTB7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:59:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id q3so3979191pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpWYHuHVnkwq1EMuW8Pn3claUxN8n48XRaznunYdNpA=;
        b=oNlZ3iJp4MsqiqJGNwAGIoJDMCsk1Wy4uql8QgYajEEu7v8hdH1GLqYtl7bCoCnu2o
         TFY19M2umiPqbGYesNAJ8gKq/XSx9fA249e7Oa3r97/NBEL0iXIDDLEhr/XuVf1xHXf1
         RBvkgljp0EHgVk5TmoKzT29QDwYV1gR90Z4Xc139zbCq8SpleZ/r9GWSDhLRU66v1WxK
         KZqALqB5GQneibPVd/P0jymXKP0y5BxGjgTvkrTKGY43PYqQwxXWz78kN6QopBzcCo7R
         FqoH+U4PjeT9mFDyjjP5+2yA55coE1CnrYHCRUAnH1rJ/W3iCEkjV45SiKCphhbkIpD4
         IEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpWYHuHVnkwq1EMuW8Pn3claUxN8n48XRaznunYdNpA=;
        b=AIUEZKTl/soP7vBhhy89qtVIZkk2m65FcFDoi01aZsG7ic3u/tUbOpdUg8YzpBONFt
         A8Tl/iqPnkChHaZBODhZowiU5C8ZwSHNz5mUnjCL/tG/rUqQyExFIO+7/0+Mf7oK7k2+
         +0MIvrHc57TXt1jCzyc366qGU6bbUBab0W4lG9W9ydoB5ooqWD/BP+W20tifuBV/Sp/b
         zKL/qfJXRyIt95Bk23lhXu9c6nkRnkNueKr3hciU8e5ZZRuaEntfGT79mT+iN4BpsMOb
         X1oBbOlwEOHXJKMqX8b2g+cu6ImBajXhFshmHRNDKZ8ONm13uxzcKVgCGPPsYP4A/SDI
         pLxQ==
X-Gm-Message-State: AHQUAubNzN2eMBbWmW5MfBblEjr09ds48OYrmJpH4ZeOcPu4NAHZa9X0
        dnDB4wqKwPS9kA0zICTlpEdogktG
X-Google-Smtp-Source: AHgI3IapSHX7UhEs9Q11gejspLG9vGBTyjlU44n3Xy6UfOyr9iBBo6gaqRBvYTT9OJqOujD+A8d31g==
X-Received: by 2002:a17:902:8f98:: with SMTP id z24mr33431989plo.40.1550627951200;
        Tue, 19 Feb 2019 17:59:11 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:59:10 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] arm64: dts: imx8mq: Add a node for SRC IP block
Date:   Tue, 19 Feb 2019 17:58:54 -0800
Message-Id: <20190220015857.7136-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220015857.7136-1-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for reset controller IP block found on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index f6c37bf9cbce..50436bd393ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -254,6 +254,12 @@
 				              "clk_ext3", "clk_ext4";
 			};
 
+			src: src@30390000 {
+				compatible = "fsl,imx8mq-src", "syscon";
+				reg = <0x30390000 0x10000>;
+				#reset-cells = <1>;
+			};
+
 			gpc: gpc@303a0000 {
 				compatible = "fsl,imx8mq-gpc";
 				reg = <0x303a0000 0x10000>;
-- 
2.20.1


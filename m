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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A22C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F404A2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8fHUax9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfBTB7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:59:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43961 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbfBTB7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:59:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id m10so1690835plt.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YOuL4YXz7ChPC3PYLWY4+mNLE7+8TCzSgAykkg2Dg0w=;
        b=h8fHUax9u++ZM38dFa2WI6ce9IsvFZvhAbSqHkv/qXlo9Yd4Y0H5gkJdvaK4kJvUf5
         5UbOWkxqrEr3V9QqTTTY+jbTItSlKcg2OV8PNTWjXiOriJIai1FcqX4rF5ykXJhjG0yA
         QGmt4MYV/QT8yOmAqVP9BIkdCaTHJraaBcEkA8lSFMYKHkSlyJYHz0EdqMRiHZXplNr+
         GHI8N32pmVLCtQiVA1r1/2pM01rlGSYgx6O5BBKJ4aeqJlLzYZ4Ed+tjq4AeNbWrSM59
         Be4gQYRwTbcVJeX/4Kiqyt+pSIv0aLZJr8PfriQPaOznsPALjNwmxLEb5fg6lzewl2jr
         t+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOuL4YXz7ChPC3PYLWY4+mNLE7+8TCzSgAykkg2Dg0w=;
        b=i//VOV4eDMHmI+VPACgHaf2J/GvXgORxSldLcyBjS918Ao0DSrezG7uZK7uf6wVvM5
         Ux7CNwPS6wQwAEn65Qz6CLJkWgPEAR+GDoNlL6hmcMoCKqRoHaqGnI4DlSeAM15kRG5k
         snsynmV0KoW97EmUIbJj2pfRZKqV2PbMe4WhsZ5w4NomR/8fyKdHPFW17gryyxNzYMl/
         CRpmhHqiAh+PP9gToILPNOsbOAJ87O7yu27BlBkY34BL55GnM9sjVkeZXXCS+E0TUoTa
         X6TwF3KrAUzP69VHhZ5P38MloJuvJBFJQ5kBDWbJl5Uzi8WfFX3ESZVtHJsuv79e5xyK
         2SNQ==
X-Gm-Message-State: AHQUAuaxdH+cP/iF0NE1T9c07nnXwzXuPQbCDmdLur4EvKyk7JVGjNNU
        lFCDCymFAPsiZEh195K6seL5XPPu
X-Google-Smtp-Source: AHgI3IaLDAe/iYVJgN7bjnYsa3JH0/RzZbsvfv6KYXlsVxMQlRj3J+jSAZgHt9bmjb04/5sBmiQoKg==
X-Received: by 2002:a17:902:5a8d:: with SMTP id r13mr34083249pli.190.1550627952429;
        Tue, 19 Feb 2019 17:59:12 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:59:11 -0800 (PST)
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
Subject: [PATCH v3 3/5] arm64: dts: imx8mq: Combine PCIE power domains
Date:   Tue, 19 Feb 2019 17:58:55 -0800
Message-Id: <20190220015857.7136-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220015857.7136-1-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to NXP's FAE feedback and a comment in ATF firmware, PCIE1
and PCIE2 power domains can't really be used independently. Due to
shared reset line both power domains have to be turned on at the same
time. Account for that quirk by combining PCIE power domains into a
single 'pgc_pcie' power domain.

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
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 50436bd393ed..fca9b71de94f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -273,9 +273,25 @@
 						reg = <IMX8M_POWER_DOMAIN_MIPI>;
 					};
 
-					pgc_pcie1: power-domain@1 {
+					/*
+					 * As per comment in ATF source code:
+					 *
+					 * PCIE1 and PCIE2 share the
+					 * same reset signal, if we
+					 * power down PCIE2, PCIE1
+					 * will be held in reset too.
+					 *
+					 * So instead of creating two
+					 * separate power domains for
+					 * PCIE1 and PCIE2 we create a
+					 * link between both and use
+					 * it as a shared PCIE power
+					 * domain.
+					 */
+					pgc_pcie: power-domain@1 {
 						#power-domain-cells = <0>;
 						reg = <IMX8M_POWER_DOMAIN_PCIE1>;
+						power-domains = <&pgc_pcie2>;
 					};
 
 					pgc_otg1: power-domain@2 {
-- 
2.20.1


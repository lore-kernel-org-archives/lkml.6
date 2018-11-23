Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F6A20865
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH5zI3W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F6A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409173AbeKWU2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:28:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42334 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbeKWU2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:28:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so3117808pfr.9;
        Fri, 23 Nov 2018 01:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kr93T5nijBQ3GQq5BgtND5H6Q0KuJDUwRY2zFzNeJZo=;
        b=gH5zI3W2RVqR1eFdTwQbRiw1P5GEipXZI+WM3CXc5z9tpEZFKNxtJct0QUCURiP+g8
         X0uvYvYA3E61at48BPuMOaO+iLTaD822y17zzuTRLsa0b2om03fk1NIidtb8NYuUx29c
         XB2/28vXMNI1bSUHe6pr72KVbQ6UYhaMT4h2xERGgC3tiAyuYxKFsJQ21VyYV/YCBuWW
         cT22VQpSDU7biVTwFY+eXavzzch9GdGxGG0sBeE6/1tT38Z52n5+C9C6xmw3Tz0GfwzJ
         Y1XIqxYLbm0TGmjw/sUfZPFzrG53sTZ82yAxO/LwDEJD8uGBLrI/zeO/jnCOl4Fbgjwe
         0bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kr93T5nijBQ3GQq5BgtND5H6Q0KuJDUwRY2zFzNeJZo=;
        b=ii8wKfwtYZUC0wdGYXpxV4m5g+Xk9GXNPYLV1eJ1L47UkrPZNiaarkEoeo+xN4EkW7
         3I4A9M0NQf9syT03vFW9AoEaWNyiHx6hJbBBHJ8eJy56KUGulNBlQVcw3j6mfAYqvmDW
         6+UbMLjY8BYtozdvtsqVW7/yALVxR34JurWNYIf5I+QUQ6JlijbmRKg8UwPCWD+w4X+J
         xT71KBDUy0/LssRHkfYbqY/2cI6Ps0E7k351y4kqC1Yg0uqqJwpBMvf0exnKvWBUnZIq
         ZDKWJvOyIdO0FuXcTO9vhwDpKaunKoMYGAhbPrQdeczXs6sPKdK2eeHVrEaLN+Xot3Mt
         +RFQ==
X-Gm-Message-State: AGRZ1gLdOx9HgELoct4PLDA8Bu/yGfgwYQz216KQmnLK1909FphT9+7i
        1TTFdm35bTirHS+1BTfK49k=
X-Google-Smtp-Source: AJdET5eYspqJqqS/A2X+B0VFYYv0OT9wVJN7/CFWTfHeTrYGqNuFAzFZK85HWCcb15VSpnLVOmIY8A==
X-Received: by 2002:a62:b9a:: with SMTP id 26mr15372771pfl.196.1542966276926;
        Fri, 23 Nov 2018 01:44:36 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.164])
        by smtp.gmail.com with ESMTPSA id o189sm34059848pfg.117.2018.11.23.01.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 01:44:36 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>
Subject: [PATCH 1/3] clk: samsung: exynos5420: add VPLL rate table for g3d clock
Date:   Fri, 23 Nov 2018 09:44:11 +0000
Message-Id: <20181123094413.1108-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marian Mihailescu <mihailescu2m@gmail.com>

A specific clock rate table is added for VPLL so it is possible
to set frequency of the VPLL output clock that used by the g3d clock.

Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34cce3c5898f..34156bdfd0d2 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1303,6 +1303,18 @@ static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
 	PLL_36XX_RATE(24 * MHZ,  32768001U, 131, 3, 5, 4719),
 };
 
+static const struct samsung_pll_rate_table exynos5420_vpll_24mhz_tbl[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 600000000U, 200, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 543000000U, 181, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 533000000U, 533, 6, 2),
+	PLL_35XX_RATE(24 * MHZ, 480000000U, 320, 4, 2),
+	PLL_35XX_RATE(24 * MHZ, 420000000U, 140, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 350000000U, 175, 3, 2),
+	PLL_35XX_RATE(24 * MHZ, 266000000U, 266, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 177000000U, 118, 2, 3),
+	PLL_35XX_RATE(24 * MHZ, 100000000U, 200, 3, 4),
+};
+
 static struct samsung_pll_clock exynos5x_plls[nr_plls] __initdata = {
 	[apll] = PLL(pll_2550, CLK_FOUT_APLL, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, NULL),
@@ -1428,6 +1440,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+		exynos5x_plls[vpll].rate_table = exynos5420_vpll_24mhz_tbl;
 	}
 
 	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
-- 
2.17.1


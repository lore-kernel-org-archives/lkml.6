Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9F9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB4720827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H6Dt222Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB4720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeKGUMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:12:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38704 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeKGUMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:12:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so1640718wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kEsi/nsjK7WvSuXES8o3Beh0DNXNzn5LcL3qjPywCB4=;
        b=H6Dt222ZopB9pow+UCP/ljRKRvR8sgp0O1pOAYkScdY2xtxMwgL+ZdUzfgxbPDqQWd
         peiZyKBx2IeDyaRPaT+JMPC5+g5tEZdn7Fq9TgK2Heqkvmf+nBUgKlRvMMhSOWttlwdJ
         9flZyj8+g9r9sYRqNHiVXH0Cd5zopc0sK1kNdBToryxCKlRe8ZvIKWok/jC7/3ihvldx
         eJOOIqRUSmGoB3+kooVK6ae7AiFsKjhvyXy3Bl7C/KrRChbxh1Z9eds+0QXbF4NHENfj
         xmlow3Kc367BS+MkAbsrNvYWN8YhtrXcccdBOPF8YO0mj5fdMGlyG7muU/6keN3lRGss
         wQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kEsi/nsjK7WvSuXES8o3Beh0DNXNzn5LcL3qjPywCB4=;
        b=i+XA932Bj2ta1kZeh0+S34yRdvDYB2Iry/HMfexMVIL46Eck4fu+PUL4o2OLwRyJMk
         r2dUa2a735ciY+PsH1BPG5TIrJRbqeTqhY8ytqW6/IFwSLrhwPBezcEiOxxFNMpaCKSd
         2flADXgg/BOJKOJqqw+YCJwnXPMtqer43bUOp1yHQK82B119SNfnJIOKu9U7n5Z7TMEw
         fm0i3WYTkx/xmyLeBqg7qoV2zMua+wJRelNSv67oL97bldcF6//pIGKOTYCFBFWDD3Rl
         iOMYqmMkhDVHV0JGA334xNdzpxR9rDLd8QsU4siSVsjFk3uwLDsUxWFdzcZhxXNG26lq
         Bhbw==
X-Gm-Message-State: AGRZ1gJob3y7Q5c/Lpjskm1lsT3SMuuF8YB014iElwriuLVSTxZslQw3
        TVBwKvB5IuPwPN9Wo7QQX0PrzHCM6eg=
X-Google-Smtp-Source: AJdET5dddbN6/cb0Fi2CFqzRNQ1N1CpavMxjWTdavaoMCq8QBTbeEP09Tu6NYoQF96sm3ePCVz0JcA==
X-Received: by 2002:a1c:d10f:: with SMTP id i15-v6mr1647062wmg.110.1541587361225;
        Wed, 07 Nov 2018 02:42:41 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y76-v6sm594516wmd.37.2018.11.07.02.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 02:42:40 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linus.walleij@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: meson-gxl: remove invalid GPIOX tsin_a pins
Date:   Wed,  7 Nov 2018 11:42:38 +0100
Message-Id: <1541587358-17654-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIOX tsin_a pins wrongly uses the SDCard pinctrl bits, this
patch completely removes these pins entries until we find out what
are the correct bits and registers to be used instead.

Fixes: 5a6ae9b80139 ("pinctrl: meson-gxl: add tsin_a pins")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 7dae1d7..3277d17 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -239,13 +239,9 @@ static const unsigned int eth_link_led_pins[]	= { GPIOZ_14 };
 static const unsigned int eth_act_led_pins[]	= { GPIOZ_15 };
 
 static const unsigned int tsin_a_d0_pins[]	= { GPIODV_0 };
-static const unsigned int tsin_a_d0_x_pins[]	= { GPIOX_10 };
 static const unsigned int tsin_a_clk_pins[]	= { GPIODV_8 };
-static const unsigned int tsin_a_clk_x_pins[]	= { GPIOX_11 };
 static const unsigned int tsin_a_sop_pins[]	= { GPIODV_9 };
-static const unsigned int tsin_a_sop_x_pins[]	= { GPIOX_8 };
 static const unsigned int tsin_a_d_valid_pins[] = { GPIODV_10 };
-static const unsigned int tsin_a_d_valid_x_pins[] = { GPIOX_9 };
 static const unsigned int tsin_a_fail_pins[]	= { GPIODV_11 };
 static const unsigned int tsin_a_dp_pins[] = {
 	GPIODV_1, GPIODV_2, GPIODV_3, GPIODV_4, GPIODV_5, GPIODV_6, GPIODV_7,
@@ -432,10 +428,6 @@ static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GROUP(spi_miso,		5,	2),
 	GROUP(spi_ss0,		5,	1),
 	GROUP(spi_sclk,		5,	0),
-	GROUP(tsin_a_sop_x,	6,	3),
-	GROUP(tsin_a_d_valid_x,	6,	2),
-	GROUP(tsin_a_d0_x,	6,	1),
-	GROUP(tsin_a_clk_x,	6,	0),
 
 	/* Bank Z */
 	GROUP(eth_mdio,		4,	23),
@@ -698,8 +690,8 @@ static const char * const eth_led_groups[] = {
 };
 
 static const char * const tsin_a_groups[] = {
-	"tsin_a_clk", "tsin_a_clk_x", "tsin_a_sop", "tsin_a_sop_x",
-	"tsin_a_d_valid", "tsin_a_d_valid_x", "tsin_a_d0", "tsin_a_d0_x",
+	"tsin_a_clk", "tsin_a_sop",
+	"tsin_a_d_valid", "tsin_a_d0",
 	"tsin_a_dp", "tsin_a_fail",
 };
 
-- 
2.7.4


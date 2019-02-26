Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7756D2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlagRZnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfBZTgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:36:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36888 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbfBZTgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:36:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id s22so6730648pfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4Hu2QCxn5OJqL1KMoylJ0W+atiXbfqxwE6Hc3/RGaw=;
        b=dlagRZnF4HIVuvNrb144ZDWe+YXbLIhJYz96nvGlaG9IoBQscKI6pgbqce5LBceYs9
         xulSNH84l4EDPSxuj+pXOxM1KzT9J/Q4pYFLTXFKHLAka5dXfUCb1p8VimWjYznNcfz2
         5joW6bCLNY/t62V2xsAvipbS1bgcmgouytshHOMBNmERqKpHEDywkcpgR1GLNE8ew3EB
         R++u6GAZp68AVE6jBpQXELoUZCQokaN05uO10bzWKI6td2/gzoaoR3OWxvYeMngtXVsB
         KoDSkodnKYIKmHKRzQAnjj7F1XmyaNmOwEgq0OytOeDdGxzCOkna0zaME1FplyCHwcWg
         37fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4Hu2QCxn5OJqL1KMoylJ0W+atiXbfqxwE6Hc3/RGaw=;
        b=L9gpSo0lfcSJUR7gKHqKzlgRz2/zZZ7Pkc2FIYz07KLMu7mIaqHWJk5t9RNRp6Imz6
         jiZK+T9s0V0Aw6etldwBoBNRrl+d1OBPaehOHQrU2FILUGXTCmIyv4Q2KtA1T1AG/9Kb
         0/cWYqVcDUddyoGBHbDLpi9cALFRAMA3/WI9+j7OjW4FqMRXKBqN6I5umVKyVb065HdF
         IPpRku4H0pdyDxsOmoLDDHA7zSg6RnXfsyYqixO0KMOZm8NkMH6SS866DRayxM1DV6vT
         xyqGtt7Kk/YnH1Xzvl6HXXqBRm+ERjKFSa502vVShQC585F8nErebpNW+GlPYfMv8VyA
         5E/w==
X-Gm-Message-State: AHQUAuZdhv4MvWsceS6IPz6RmFqHRRv1lAvV53eAn1zGVZk8Dr95TpYc
        9cxoxyScj7ArKNNUBgX/7qBoGKKMnLo=
X-Google-Smtp-Source: AHgI3IYtiTLTnf+zj4rKJMXXVIDYPI9YK5bYIkGS+meZTL0TxS0EELNwCTVyKmQ+G1gqB5bovQ4UiA==
X-Received: by 2002:a63:31c8:: with SMTP id x191mr421627pgx.99.1551209796570;
        Tue, 26 Feb 2019 11:36:36 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l79sm28951220pfb.102.2019.02.26.11.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:36:35 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] drm/bridge: tc358767: Introduce tc_set_syspllparam()
Date:   Tue, 26 Feb 2019 11:36:07 -0800
Message-Id: <20190226193609.9862-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226193609.9862-1-andrew.smirnov@gmail.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common code converting clock rate to an appropriate constant and
configuring SYS_PLLPARAM register into a separate routine and convert
the rest of the code to use it. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 50 +++++++++++++------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 54ff95f66e30..227f14cd2d3d 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -522,35 +522,42 @@ static int tc_stream_clock_calc(struct tc_data *tc)
 	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
 }
 
-static int tc_aux_link_setup(struct tc_data *tc)
+static int tc_set_syspllparam(struct tc_data *tc)
 {
 	unsigned long rate;
-	u32 value;
-	int ret;
-	u32 dp_phy_ctrl;
+	u32 pllparam = SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
 
 	rate = clk_get_rate(tc->refclk);
 	switch (rate) {
 	case 38400000:
-		value = REF_FREQ_38M4;
+		pllparam |= REF_FREQ_38M4;
 		break;
 	case 26000000:
-		value = REF_FREQ_26M;
+		pllparam |= REF_FREQ_26M;
 		break;
 	case 19200000:
-		value = REF_FREQ_19M2;
+		pllparam |= REF_FREQ_19M2;
 		break;
 	case 13000000:
-		value = REF_FREQ_13M;
+		pllparam |= REF_FREQ_13M;
 		break;
 	default:
 		dev_err(tc->dev, "Invalid refclk rate: %lu Hz\n", rate);
 		return -EINVAL;
 	}
 
+	return regmap_write(tc->regmap, SYS_PLLPARAM, pllparam);
+}
+
+static int tc_aux_link_setup(struct tc_data *tc)
+{
+	int ret;
+	u32 dp_phy_ctrl;
+
 	/* Setup DP-PHY / PLL */
-	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	tc_write(SYS_PLLPARAM, value);
+	ret = tc_set_syspllparam(tc);
+	if (ret)
+		return ret;
 
 	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_A0_EN;
 	if (tc->link.base.num_lanes == 2)
@@ -811,7 +818,6 @@ static int tc_main_link_setup(struct tc_data *tc)
 {
 	struct drm_dp_aux *aux = &tc->aux;
 	struct device *dev = tc->dev;
-	unsigned int rate;
 	u32 dp_phy_ctrl;
 	int timeout;
 	u32 value;
@@ -828,25 +834,9 @@ static int tc_main_link_setup(struct tc_data *tc)
 		 (tc->link.spread ? DP0_SRCCTRL_SSCG : 0) |
 		 ((tc->link.base.rate != 162000) ? DP0_SRCCTRL_BW27 : 0));
 
-	rate = clk_get_rate(tc->refclk);
-	switch (rate) {
-	case 38400000:
-		value = REF_FREQ_38M4;
-		break;
-	case 26000000:
-		value = REF_FREQ_26M;
-		break;
-	case 19200000:
-		value = REF_FREQ_19M2;
-		break;
-	case 13000000:
-		value = REF_FREQ_13M;
-		break;
-	default:
-		return -EINVAL;
-	}
-	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	tc_write(SYS_PLLPARAM, value);
+	ret = tc_set_syspllparam(tc);
+	if (ret)
+		return ret;
 
 	/* Setup Main Link */
 	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_A0_EN | PHY_M0_EN;
-- 
2.20.1


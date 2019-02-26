Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B020EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791222063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVsb9oQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfBZTgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:36:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43828 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfBZTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:36:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so6711864pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGzhHRXCSSTUV8y9+sZJ9O8fW6lSd15+7S2lT8PZLKA=;
        b=oVsb9oQLiw7fuySZNvlTxYC1ZehjkTc/1qbDebFX0OVzzj1lDRVZYVj/hVcKlX2UgJ
         6RiYPPmIM4CxFqs23wm6SwGZXpVFGvgffu6sCZCP3yTHs3pUefaHP1YSTD4BMop17Y37
         S185yh8XgT4Ucv6nhw6jK7Q5uygOunVf16nDnp60gGvwVFK9Z1y8Ct9HvB8DNzHruGwJ
         zjx+8ecwX0piZrihN/7y4y/C9IWiy7qoo0VNO/7jr5mMz/Ewiyg4hcXjUFG2vkuy1qPf
         SfF9aFi8PphRz4iz+6IbaR7Qh/TZQkLf6B1LJY1bgfurGFXhC4nd/9nc5lE0T+eFy/vC
         lx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGzhHRXCSSTUV8y9+sZJ9O8fW6lSd15+7S2lT8PZLKA=;
        b=HDlviJvWiQ2pRe/NBprn5QoYlc4Y5Eu80vaR8Q6tgSYZG5RlJmxdQev8YQhQcAWq1U
         h3V5+3EGLySOtr2hXLUF5/EOJHO4ClMr5lHcMfc7ovVN+t4I8lkyJUQ1mhxz5a8lmFfL
         YY6xAC8J6+b3Y1xlgET4/iaajylSlML7B7/TGl6IRq1xY3iTo7D7AG00L+YlpW+GyK9l
         xqSn3MCWyIcCdNrzT64It8o1aEc96lZrxnbqm4ph+ItNwsV+7irZVUMR4+ImX6maK3nj
         pz6dSJSFxLgpBA1ZvPBPbxnHcdmDo2/LqXNuNioQP6N7/bjbwR9B4IaHj1i0AU4VK5b0
         yt/Q==
X-Gm-Message-State: AHQUAubVa+zA1ei447zq7T/5DNWX0beSLbQG6m8IdQEK5nHfCNKZlVVN
        0cSIqU4uzx3E+aEcMjQwK3s=
X-Google-Smtp-Source: AHgI3IYBKXd+WcIOttjJ2/AqPrDDfdXeAWYSdT7lTdKZeN63pE1l21nX8QLdWskyqKN7gIry08xFUA==
X-Received: by 2002:a63:8942:: with SMTP id v63mr25177689pgd.406.1551209798004;
        Tue, 26 Feb 2019 11:36:38 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l79sm28951220pfb.102.2019.02.26.11.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:36:37 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] drm/bridge: tc358767: Introduce tc_pllupdate_pllen()
Date:   Tue, 26 Feb 2019 11:36:08 -0800
Message-Id: <20190226193609.9862-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226193609.9862-1-andrew.smirnov@gmail.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tc_wait_pll_lock() is always called as a follow-up for updating
PLLUPDATE and PLLEN bit of a given PLL control register. To simplify
things, merge the two operation into a single helper function
tc_pllupdate_pllen() and convert the rest of the code to use it. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 36 +++++++++++++++++++------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 227f14cd2d3d..239b3aaa255d 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -390,10 +390,18 @@ static u32 tc_srcctrl(struct tc_data *tc)
 	return reg;
 }
 
-static void tc_wait_pll_lock(struct tc_data *tc)
+static int tc_pllupdate_pllen(struct tc_data *tc, unsigned int pllctrl)
 {
+	int ret;
+
+	ret = regmap_write(tc->regmap, pllctrl, PLLUPDATE | PLLEN);
+	if (ret)
+		return ret;
+
 	/* Wait for PLL to lock: up to 2.09 ms, depending on refclk */
 	usleep_range(3000, 6000);
+
+	return 0;
 }
 
 static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
@@ -487,11 +495,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
 		 (best_mul << 0));		/* Multiplier for PLL */
 
 	/* Force PLL parameter update and disable bypass */
-	tc_write(PXL_PLLCTRL, PLLUPDATE | PLLEN);
-
-	tc_wait_pll_lock(tc);
-
-	return 0;
+	return tc_pllupdate_pllen(tc, PXL_PLLCTRL);
 err:
 	return ret;
 }
@@ -568,11 +572,13 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	 * Initially PLLs are in bypass. Force PLL parameter update,
 	 * disable PLL bypass, enable PLL
 	 */
-	tc_write(DP0_PLLCTRL, PLLUPDATE | PLLEN);
-	tc_wait_pll_lock(tc);
+	ret = tc_pllupdate_pllen(tc, DP0_PLLCTRL);
+	if (ret)
+		return ret;
 
-	tc_write(DP1_PLLCTRL, PLLUPDATE | PLLEN);
-	tc_wait_pll_lock(tc);
+	ret = tc_pllupdate_pllen(tc, DP1_PLLCTRL);
+	if (ret)
+		return ret;
 
 	ret = tc_poll_timeout(tc->regmap, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1,
 			      1000);
@@ -846,11 +852,13 @@ static int tc_main_link_setup(struct tc_data *tc)
 	msleep(100);
 
 	/* PLL setup */
-	tc_write(DP0_PLLCTRL, PLLUPDATE | PLLEN);
-	tc_wait_pll_lock(tc);
+	ret = tc_pllupdate_pllen(tc, DP0_PLLCTRL);
+	if (ret)
+		return ret;
 
-	tc_write(DP1_PLLCTRL, PLLUPDATE | PLLEN);
-	tc_wait_pll_lock(tc);
+	ret = tc_pllupdate_pllen(tc, DP1_PLLCTRL);
+	if (ret)
+		return ret;
 
 	/* PXL PLL setup */
 	if (tc_test_pattern) {
-- 
2.20.1


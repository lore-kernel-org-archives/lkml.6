Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E9BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D395520449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298494;
	bh=WNtB7uTkgwopA8hlJfC7PjG24QeSF57/Y0Q1UIhBhJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SEZ/zUj0KO/NHPZsDNRCiWMoFaYuhrfe797wbpnqr2/Z4qokEOE7xeUN8ZuoDTFiH
	 PKLjJGzcpviPEHY2IsTdnz1OEC+Rs32Qwg4+wE8zQB0yivfPhHOrVCALnxQNgBmYtx
	 vkQJ1SidjvKt3V8C234z48TYTUHxih9lIZ9m/oo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbeLTJ3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbeLTJ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90F72177E;
        Thu, 20 Dec 2018 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298147;
        bh=WNtB7uTkgwopA8hlJfC7PjG24QeSF57/Y0Q1UIhBhJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRfOKt1ipH1egSHBAiHchzK7RCMgSB0wcvH8yA7dL8EdO11Xk7i500UyIOZnjTVvz
         n8om+er1h3d1xGnBDqdiO1uGwpQrFI67r0xStyxNJqpL1F5GZqXciFRc3Agi/rKOp9
         a/2O2UrJp2b+OJ7WXs+pPBSXg+hRVC2NaZlhuzsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 17/67] drm/msm/dsi: configure VCO rate for 10nm PLL driver
Date:   Thu, 20 Dec 2018 10:18:29 +0100
Message-Id: <20181220085904.239046856@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8531f0587f5c9e1a74cd9543a97617349f5e0706 ]

Currenty the VCO rate in the 10nm PLL driver relies
on the parent rate which is not configured.

Configure the VCO rate to 19.2 Mhz as required by
the 10nm PLL driver.

Signed-off-by: Abhinav Kumar <abhinavk@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
index 4c03f0b7343e..41bec570c518 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
@@ -39,6 +39,8 @@
 #define DSI_PIXEL_PLL_CLK		1
 #define NUM_PROVIDED_CLKS		2
 
+#define VCO_REF_CLK_RATE		19200000
+
 struct dsi_pll_regs {
 	u32 pll_prop_gain_rate;
 	u32 pll_lockdet_rate;
@@ -316,7 +318,7 @@ static int dsi_pll_10nm_vco_set_rate(struct clk_hw *hw, unsigned long rate,
 	    parent_rate);
 
 	pll_10nm->vco_current_rate = rate;
-	pll_10nm->vco_ref_clk_rate = parent_rate;
+	pll_10nm->vco_ref_clk_rate = VCO_REF_CLK_RATE;
 
 	dsi_pll_setup_config(pll_10nm);
 
-- 
2.19.1




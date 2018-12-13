Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B470C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104DF2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676719;
	bh=aplAg/CvU+QG9D0qZhU55pIk83LVYUjSBq/slMDHuZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bihe+A+rKd0oUp9vkS9sWNA2FkUPlDlEb4a3SiAFpTnueGYjtDBk58or/DgwxKrap
	 20Wg/gxTVuwCOLP8ERxaJBLnIRrAfhTiUca/iylmnLbF4dxl/X0XEZQCf5peBwUPPa
	 07z+JSvvpHRhI+z/iGMeDdQXGneGno389/kDyVOk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104DF2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeLMEv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbeLME3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB95620849;
        Thu, 13 Dec 2018 04:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675343;
        bh=aplAg/CvU+QG9D0qZhU55pIk83LVYUjSBq/slMDHuZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZIPgtQWqWneZyHeb1IUxd7NxNIKdbQ5o2Hccgc+yOazvwVsODVR82TiZqOi1AXl9
         6uJkuFyYZ7yogfqoQLfdgA7vUM6rjpD2EWaxfQPiNuj0tbqGFg2XvFYHXQcuZzRGpS
         IENVifrayvfK5CJj8AjyRejiggXtWB/epYFH9qGw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 15/73] drm/msm/dsi: configure VCO rate for 10nm PLL driver
Date:   Wed, 12 Dec 2018 23:27:40 -0500
Message-Id: <20181213042838.75160-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhinav Kumar <abhinavk@codeaurora.org>

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


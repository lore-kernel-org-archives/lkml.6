Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B89C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34053222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899576;
	bh=dTJu1T2rabD1jdkKv6pLU86dxyx9oiQtSSIxrpOgTqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X/+J5RjAfVb2aXnT1OkIpkOiQNNpAtZtGR27I1XSI+alKv7zqAtH9TerEa5zfU3d1
	 L/6ZfMK6pcELhe6esd8BmqBzYoRtzwkiBqcHgBAZV2BtC1PfkbqVae1gIPoGfKABDv
	 NBhh7FqIT82L4gk+zR6zhwqOw2if/Og78MOqLKZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfBKOtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387846AbfBKOtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:49:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81BAA206BA;
        Mon, 11 Feb 2019 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896559;
        bh=dTJu1T2rabD1jdkKv6pLU86dxyx9oiQtSSIxrpOgTqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaAzPIDIz2fcvf7pNAnFePCOY8nL7sSHRtEJWW0ACYwkjalhTfAAXfkRcRuamib7D
         r5H+vTuPmn3FEgWS4xdVq850cSt+bsoAeWFIfwOK66hFaWw5PMur0tqSYERXeDVmBr
         EoegeDpKRgFovPY8FFC7O+E1XsLrfmGRdzHqIw6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenjing Liu <Wenjing.Liu@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 194/313] drm/amd/display: validate extended dongle caps
Date:   Mon, 11 Feb 2019 15:17:54 +0100
Message-Id: <20190211141906.208732148@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit 99b922f9ed6a6313c0d2247cde8aa1e4a0bd67e4 ]

[why]
Some dongle doesn't have a valid extended dongle caps,
but we still set the extended dongle caps to be valid.
This causes validation fails for all timing.

[how]
If no dp_hdmi_max_pixel_clk is provided,
don't use extended dongle caps.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index a7553b6d59c2..05840f5bddd5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2240,7 +2240,8 @@ static void get_active_converter_info(
 					translate_dpcd_max_bpc(
 						hdmi_color_caps.bits.MAX_BITS_PER_COLOR_COMPONENT);
 
-				link->dpcd_caps.dongle_caps.extendedCapValid = true;
+				if (link->dpcd_caps.dongle_caps.dp_hdmi_max_pixel_clk != 0)
+					link->dpcd_caps.dongle_caps.extendedCapValid = true;
 			}
 
 			break;
-- 
2.19.1




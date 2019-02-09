Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A104AC282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECCF21934
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738157;
	bh=mJnX0lt0X0Atl953s6iPzGdUi1sxGo0IRtpnIaDHryk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fQMFNM/8Oazsnl4KxVhlKeAQAKqsdpv4bVTVmDCvhINcCC2KJvsbHrpo5tT/ewyVJ
	 UgMLEf4AZ6KUnyQFTURYUaElobMwqb/OjIBBDMUCmslUYnx/j8+auCP7hDtTfE9ocO
	 xsLCGzNf7umayOIrKvIHY6cvpe1xK6VjiJY98Jbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfBIStP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbfBIStM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5009120821;
        Sat,  9 Feb 2019 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738152;
        bh=mJnX0lt0X0Atl953s6iPzGdUi1sxGo0IRtpnIaDHryk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQlulxFsXsJHKlo2LxaXCqF8pNDSMN+XRwo5MAdCigr/7dz583PcXIg2uxQrrXrwZ
         dhKFcO7f2arqJnAgXoY+s8YTBN3RCKSabH2TASDJRkd42nq9dEaTRcH4rSjrycWS+F
         9riCOuJDFMCylHo+zsfeLIVjlnJ0GHqivfx8KQVA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Qu <Jim.Qu@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 18/28] drm/amdgpu: set WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang
Date:   Sat,  9 Feb 2019 13:48:26 -0500
Message-Id: <20190209184840.126418-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Qu <Jim.Qu@amd.com>

[ Upstream commit 0c6c8125582714e1fd3544983eba3d750db0f5b8 ]

effect asics: VEGA10 and VEGA12

Signed-off-by: Jim Qu <Jim.Qu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 7c3b634d8d5f..de5a689e1925 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -71,7 +71,6 @@ static const struct soc15_reg_golden golden_settings_sdma_4[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000),
-	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CLK_CTRL, 0xffffffff, 0x3f000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GFX_IB_CNTL, 0x800f0100, 0x00000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GFX_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
@@ -89,6 +88,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4[] = {
 static const struct soc15_reg_golden golden_settings_sdma_vg10[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002)
 };
@@ -96,6 +96,7 @@ static const struct soc15_reg_golden golden_settings_sdma_vg10[] = {
 static const struct soc15_reg_golden golden_settings_sdma_vg12[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104001),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104001),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001)
 };
-- 
2.19.1


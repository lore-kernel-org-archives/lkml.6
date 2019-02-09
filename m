Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D753C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B55320643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738570;
	bh=piS+ve4NsLFiqF14w5vK98/GfacsCblY/WaVt8eL1YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z2v9edMNM+q/nt3nRgfaxOzKWW0NyzVxOZdDAn0nF/38tHGowukG7xr6DuxwJoC0m
	 9BD64PjEuVc7wu6xymZ8Oruf67Sjw3n7tYaBcyJwmvUsZSf5YpozNgvBrJFkt2K49g
	 S++DU2qEllXxidmaPuc6d+lf/6leHi3Bt2Dcglts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfBIS4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:32886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbfBISsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BDB2192B;
        Sat,  9 Feb 2019 18:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738090;
        bh=piS+ve4NsLFiqF14w5vK98/GfacsCblY/WaVt8eL1YY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JguHeDrnkCp3+Ke4Wxf3qFMEf8YNdfdindUM+ItfYIZcxhuC5DjuZ3VRFB5faJQ4z
         P49Zb3qUxV5Idzyc2gEgJqtQ/6s4juMIBQSZKAZGP17S8Z6c6idAihn03bkhse5CRO
         3H+/6cN71P9Yp8TKR2EllgJI2XUWNCv0QGxE954w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Qu <Jim.Qu@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 27/42] drm/amdgpu: set WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang
Date:   Sat,  9 Feb 2019 13:47:19 -0500
Message-Id: <20190209184734.125935-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
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
index 7a8c9172d30a..86d5dc5f8887 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -73,7 +73,6 @@ static const struct soc15_reg_golden golden_settings_sdma_4[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000),
-	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CLK_CTRL, 0xffffffff, 0x3f000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GFX_IB_CNTL, 0x800f0100, 0x00000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GFX_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
@@ -91,6 +90,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4[] = {
 static const struct soc15_reg_golden golden_settings_sdma_vg10[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002)
 };
@@ -98,6 +98,7 @@ static const struct soc15_reg_golden golden_settings_sdma_vg10[] = {
 static const struct soc15_reg_golden golden_settings_sdma_vg12[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104001),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104001),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001)
 };
-- 
2.19.1


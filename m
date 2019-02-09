Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF601C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE6520643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738576;
	bh=Ldo4ZIX2byNtz5roCMGL3G4+9TpmOw0RHg7YNpfk6Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HZ6wvmWIDjzSwwP0CRuwX3dsD0QIPEEGQyg8soGsr5FiE/KBwieSlXYsyEP97BpmN
	 jrX7NaLqgYzVH988plVVhMq3v6ClHBxSRqz9DqxCANvl/fJuNFAM6WXgEt8+BDrSl4
	 jZt3WE/tXlaJ0llk/7WYr9A6/G/rtWpz4/BMAv+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfBIS4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:32820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbfBISsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639BF21919;
        Sat,  9 Feb 2019 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738087;
        bh=Ldo4ZIX2byNtz5roCMGL3G4+9TpmOw0RHg7YNpfk6Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H5/5bLBYwrI/0n9W5Y0KsJsDuxyCnhzsUm8v322gF5KrUtZ59tQaRXgn0XBjsawOa
         ykAIaNKgXuoZuTXkeXYyygh45PBGqF3SjjiqR6swat4vBwSoP3Ma5rWjUP3LHXEC8U
         Ma5CljbwPTUVIQ56qs7ObZ4HSToxl+3wGUrlD+Rg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 26/42] drm/amdgpu: fix CPDMA hang in PRT mode for VEGA20
Date:   Sat,  9 Feb 2019 13:47:18 -0500
Message-Id: <20190209184734.125935-26-sashal@kernel.org>
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

From: Tao Zhou <tao.zhou1@amd.com>

[ Upstream commit 3e958fe67720b37d04ab8ef81b9d507a56a09bbc ]

Fix CPDMA hang in PRT mode for both VEGA10 and VEGA20

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Tested-by: Yukun.Li <yukun1.li@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 21363b2b2ee5..88ed064b3585 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -112,7 +112,10 @@ static const struct soc15_reg_golden golden_settings_gc_9_0[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CHAN_STEER_HI, 0xffffffff, 0x4a2c0e68),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CHAN_STEER_LO, 0xffffffff, 0xb5d3f197),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_CACHE_INVALIDATION, 0x3fff3af3, 0x19200000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000003ff)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000003ff),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_MEC1_F32_INT_DIS, 0x00000000, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_MEC2_F32_INT_DIS, 0x00000000, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_DEBUG, 0x00000000, 0x00008000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_9_0_vg10[] =
@@ -134,10 +137,7 @@ static const struct soc15_reg_golden golden_settings_gc_9_0_vg10[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_UTCL1_CNTL2, 0x00030000, 0x00020000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1, 0x0000000f, 0x01000107),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTD_CNTL, 0x00001800, 0x00000800),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmWD_UTCL1_CNTL, 0x08000000, 0x08000080),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_MEC1_F32_INT_DIS, 0x00000000, 0x00000800),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_MEC2_F32_INT_DIS, 0x00000000, 0x00000800),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_DEBUG, 0x00000000, 0x00008000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmWD_UTCL1_CNTL, 0x08000000, 0x08000080)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_9_0_vg20[] =
-- 
2.19.1


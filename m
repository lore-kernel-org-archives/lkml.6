Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AB42070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501230;
	bh=mHtx7CpOIKwAit7f7gATQMrdrfY3jz7Gqj3yMoYOgPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fX0ys8+2ZcJuHMS/BC7hPGukBerU/e37ctXkuyJ6sPHnH738ArGA5eT9KCi+/GxQz
	 AKVDEERP8YeZPxcGXlK07TuZFdGGch8thn7mYf1QWCB1ZHdgR0QEEK6CT755KrGr/8
	 dsp+7itQhNHcWWhBGnXEuJg5En1XBmAI5hODcQlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390323AbfBROrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731515AbfBRNqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C043B217F5;
        Mon, 18 Feb 2019 13:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497561;
        bh=mHtx7CpOIKwAit7f7gATQMrdrfY3jz7Gqj3yMoYOgPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPzgj+7pFem4kIx9+t+xW9u6KZzaCPcMrbshXtMB7ssuq4kTj2QCFrltA1eOTUpk0
         Av+7LydFAeNX+qxj76+UsHG31csmGMJ5MPBgkIg9XbcyDjzmudaPCM3zVebswhtW7a
         UmD930DN3TJMT9WeMSAEgXx3Pcbdigft499G83k4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Qu <Jim.Qu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 30/92] drm/amdgpu: set WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang
Date:   Mon, 18 Feb 2019 14:42:33 +0100
Message-Id: <20190218133457.568911849@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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




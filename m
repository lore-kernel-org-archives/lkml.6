Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06669C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BD420672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675436;
	bh=etABM3TpQz/jU13PH2ujZsfyUbj2elhKNS8p0o3uQ0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=axJ0TwqQjC4NbWalCe2xnShDl/l9oEl1xE0lSXyG0V1VnelyiZz7Im3axaQWJY2Bx
	 PPu1QbU/D01jKhD0gxBzXf8rNu9diXhn0IoV3KHT9aUhk7aS3OrV4D9OJZuDUkonQh
	 bjuMPA96WooYrafBeODCfIL0QJA5la/A3kPPKjVk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BD420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeLMEaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbeLMEac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1D520672;
        Thu, 13 Dec 2018 04:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675432;
        bh=etABM3TpQz/jU13PH2ujZsfyUbj2elhKNS8p0o3uQ0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVe1+GwIu3igcs5l66CmOYaRKJBCLJU1F9dncEORsJyFO72YmfivYhv0GnogxJ3eT
         MULdCNcQEsQzs0NKq2A0AdMqmJuSnBuju3BXDPZv+aR+NgGmU7ReU8tb182uodMVtv
         /nnChR7OkhmaSlkwib2AvDP8a9B314MWgwXuV2Ms=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Zhu <James.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 59/73] drm/amdgpu/vcn: Update vcn.cur_state during suspend
Date:   Wed, 12 Dec 2018 23:28:24 -0500
Message-Id: <20181213042838.75160-59-sashal@kernel.org>
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

From: James Zhu <James.Zhu@amd.com>

[ Upstream commit 0a9b89b2e2e7b6d90f81ddc47e489be1043e01b1 ]

Replace vcn_v1_0_stop with vcn_v1_0_set_powergating_state during suspend,
to keep adev->vcn.cur_state update. It will fix VCN S3 hung issue.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 072371ef5975..4f8f3bb21832 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -43,6 +43,7 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_jpeg_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_jpeg_ring_set_patch_ring(struct amdgpu_ring *ring, uint32_t ptr);
+static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_state state);
 
 /**
  * vcn_v1_0_early_init - set function pointers
@@ -216,7 +217,7 @@ static int vcn_v1_0_hw_fini(void *handle)
 	struct amdgpu_ring *ring = &adev->vcn.ring_dec;
 
 	if (RREG32_SOC15(VCN, 0, mmUVD_STATUS))
-		vcn_v1_0_stop(adev);
+		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 
 	ring->ready = false;
 
-- 
2.19.1


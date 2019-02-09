Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532DDC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186CE20643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738563;
	bh=rInsUxZ/JgzRMsfhwfaXW9BE1ybDcXNaiUUhVbulyoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sVkTfvTWFFIBC9TwgQf2DLElA3bpA+3tNoVo9uKzcCK53oVc+mn2VZ2YJ5Vb+2dmX
	 7HgSHuFGjacTfGDVe4vzW2Vk6RMyJr0MWSZE0cszFq52hQp09etRoiyDE2zDwk3eON
	 AC79M0VvjuZvOPrVHBJGMNS01s1lFVOoPWyKVuz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfBISsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:32970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfBISsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8238F21919;
        Sat,  9 Feb 2019 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738093;
        bh=rInsUxZ/JgzRMsfhwfaXW9BE1ybDcXNaiUUhVbulyoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDgXJNBm33aPb5yy6M+fgKb6VgeNc7GAHUibCtu2oK8CdbPRRZhn/slBp/okHlEy+
         vcS6JQHwM2CEsHebQUr3DZU4cy/lUDXO2HR/tFt6qKU5YFv7tvTDw9Hea7q/IRKllv
         K5qQLp+iW1y3xbs5YylBIdtQ3xyO/ZkYiOoJAIWk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 28/42] drm/amdgpu: disable system memory page tables for now
Date:   Sat,  9 Feb 2019 13:47:20 -0500
Message-Id: <20190209184734.125935-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 1c1eba86339c8517814863bc7dd21e2661a84e77 ]

We hit a problem with IOMMU with that. Disable until we have time to
debug further.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0877ff9a9594..8c9abaa7601a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -850,9 +850,6 @@ static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp->size = amdgpu_vm_bo_size(adev, level);
 	bp->byte_align = AMDGPU_GPU_PAGE_SIZE;
 	bp->domain = AMDGPU_GEM_DOMAIN_VRAM;
-	if (bp->size <= PAGE_SIZE && adev->asic_type >= CHIP_VEGA10 &&
-	    adev->flags & AMD_IS_APU)
-		bp->domain |= AMDGPU_GEM_DOMAIN_GTT;
 	bp->domain = amdgpu_bo_get_preferred_pin_domain(adev, bp->domain);
 	bp->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-- 
2.19.1


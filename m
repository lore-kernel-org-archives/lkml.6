Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51FA21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497568;
	bh=dU0LSo/eqWBPC+p5IxFyv87ZeLPWkY5d7p4rR7Pq+To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KWWjsZ7hthvlVr3sdcz2I+OGSRZ+eiITEGm1r4AqVfFwjfMLtzGBes2H2GgKuexTG
	 hyGZmdqbRCooUcWnMulefQwbPUmP4n5FPUIpKWJIhJAy+Nf+5CzYFJPdq3NiayRov1
	 XUWZiG0xRog7N2RF0hpXEFElWr/63XjfL9PHHgcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfBRNqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbfBRNqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BA17218FC;
        Mon, 18 Feb 2019 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497565;
        bh=dU0LSo/eqWBPC+p5IxFyv87ZeLPWkY5d7p4rR7Pq+To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+Ilt4v3n+ZmsMSbEe3wCeeqgZ3z+7Noqn2+5iubd+T2eKpPRzsW8XQipVJhcp+QP
         E5BfHRtHd+7/KNILNiyvzx9K2/Yy4sTYn9Ce2h6lIrexpm2mr3yarEAqTbSLiGqVn0
         r/6fKl/zQM0KzO9CNxfDDyr0pwn13M3Ac0JcjLUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 31/92] drm/amdgpu: disable system memory page tables for now
Date:   Mon, 18 Feb 2019 14:42:34 +0100
Message-Id: <20190218133457.663427474@linuxfoundation.org>
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




Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847D2C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5191D222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025330;
	bh=OrKTZTXmGNedz9RGTvaG6XUg8U4uUvIyYgneOlrKGXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rV85qiNTgkH8RbhD786Op929djAPuodPtPwZi4Rv6eI0UUJEzkMuLtuYkvYanJIch
	 RyxrTTsu+GzJr/53zNNvdfiV8iFbw51ftknj1JOcbyER0mHqwsQDsuoNj8VMWl/DdH
	 xofwOWrlobaKj+R8zuMpxmMcS/F33iKv6ofKAZBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbfBMCfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:35:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387983AbfBMCfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31ACE222CA;
        Wed, 13 Feb 2019 02:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025322;
        bh=OrKTZTXmGNedz9RGTvaG6XUg8U4uUvIyYgneOlrKGXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJA7/noDcQmgyd3e1hLHAzsVo+DzczK2tpAJgytaGkkmXmZkJn6nfeDKWJ67/dl0B
         lKLd8jcTdO4uJNiqCTVjkA2YMsm9acHkuQzp31KxoEgNI3b/IcxKbyHxJivd4YmgvN
         XRRuOdYRktHKdpo6hLWWtMC2urCnO6JqywZSQV6I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 068/105] drm/amdkfd: Don't assign dGPUs to APU topology devices
Date:   Tue, 12 Feb 2019 21:32:59 -0500
Message-Id: <20190213023336.19019-68-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit bbdf514fe5648566b0754476cbcb92ac3422dde2 ]

dGPUs need their own topology devices. Don't assign them to APU topology
devices with CPU cores.

Bug: https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/issues/66
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: Elias Konstantinidis <ekondis@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index e3843c5929ed..fffece5e42c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1074,8 +1074,6 @@ static uint32_t kfd_generate_gpu_id(struct kfd_dev *gpu)
  *		the GPU device is not already present in the topology device
  *		list then return NULL. This means a new topology device has to
  *		be created for this GPU.
- * TODO: Rather than assiging @gpu to first topology device withtout
- *		gpu attached, it will better to have more stringent check.
  */
 static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
 {
@@ -1083,12 +1081,20 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
 	struct kfd_topology_device *out_dev = NULL;
 
 	down_write(&topology_lock);
-	list_for_each_entry(dev, &topology_device_list, list)
+	list_for_each_entry(dev, &topology_device_list, list) {
+		/* Discrete GPUs need their own topology device list
+		 * entries. Don't assign them to CPU/APU nodes.
+		 */
+		if (!gpu->device_info->needs_iommu_device &&
+		    dev->node_props.cpu_cores_count)
+			continue;
+
 		if (!dev->gpu && (dev->node_props.simd_count > 0)) {
 			dev->gpu = gpu;
 			out_dev = dev;
 			break;
 		}
+	}
 	up_write(&topology_lock);
 	return out_dev;
 }
-- 
2.19.1


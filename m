Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C7FC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A86A204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A86A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeKAUF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:05:58 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:35502 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKAUF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:05:58 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C34E072CC67;
        Thu,  1 Nov 2018 14:03:28 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B671B7CCDFB; Thu,  1 Nov 2018 14:03:28 +0300 (MSK)
Date:   Thu, 1 Nov 2018 14:03:28 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] uapi: fix more linux/kfd_ioctl.h userspace compilation
 errors
Message-ID: <20181101110328.GB20538@altlinux.org>
Mail-Followup-To: Oded Gabbay <oded.gabbay@gmail.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistently use types provided by <linux/types.h> via <drm/drm.h>
to fix struct kfd_ioctl_get_queue_wave_state_args userspace compilation errors.

Fixes: 5df099e8bc83f ("drm/amdkfd: Add wavefront context save state retrieval ioctl")
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/kfd_ioctl.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index dae897f38e59..b01eb502d49c 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -83,11 +83,11 @@ struct kfd_ioctl_set_cu_mask_args {
 };
 
 struct kfd_ioctl_get_queue_wave_state_args {
-	uint64_t ctl_stack_address;	/* to KFD */
-	uint32_t ctl_stack_used_size;	/* from KFD */
-	uint32_t save_area_used_size;	/* from KFD */
-	uint32_t queue_id;		/* to KFD */
-	uint32_t pad;
+	__u64 ctl_stack_address;	/* to KFD */
+	__u32 ctl_stack_used_size;	/* from KFD */
+	__u32 save_area_used_size;	/* from KFD */
+	__u32 queue_id;			/* to KFD */
+	__u32 pad;
 };
 
 /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */
-- 
ldv

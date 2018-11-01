Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E54C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E7A204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E7A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeKAUFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:05:38 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34960 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKAUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:05:38 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A01DE72CBF9;
        Thu,  1 Nov 2018 14:03:08 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8FEA17CCDFB; Thu,  1 Nov 2018 14:03:08 +0300 (MSK)
Date:   Thu, 1 Nov 2018 14:03:08 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Shaoyun Liu <Shaoyun.Liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] uapi: fix linux/kfd_ioctl.h userspace compilation errors
Message-ID: <20181101110308.GA20538@altlinux.org>
Mail-Followup-To: Oded Gabbay <oded.gabbay@gmail.com>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistently use types provided by <linux/types.h> via <drm/drm.h>
to fix the following linux/kfd_ioctl.h userspace compilation errors:

/usr/include/linux/kfd_ioctl.h:250:2: error: unknown type name 'uint32_t'
  uint32_t reset_type;
/usr/include/linux/kfd_ioctl.h:251:2: error: unknown type name 'uint32_t'
  uint32_t reset_cause;
/usr/include/linux/kfd_ioctl.h:252:2: error: unknown type name 'uint32_t'
  uint32_t memory_lost;
/usr/include/linux/kfd_ioctl.h:253:2: error: unknown type name 'uint32_t'
  uint32_t gpu_id;

Fixes: 0c119abad7f0d ("drm/amd: Add kfd ioctl defines for hw_exception event")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/kfd_ioctl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f5ff8a76e208..dae897f38e59 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -255,10 +255,10 @@ struct kfd_hsa_memory_exception_data {
 
 /* hw exception data */
 struct kfd_hsa_hw_exception_data {
-	uint32_t reset_type;
-	uint32_t reset_cause;
-	uint32_t memory_lost;
-	uint32_t gpu_id;
+	__u32 reset_type;
+	__u32 reset_cause;
+	__u32 memory_lost;
+	__u32 gpu_id;
 };
 
 /* Event data */
-- 
ldv

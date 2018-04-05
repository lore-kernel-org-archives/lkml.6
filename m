Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeDEEfO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 00:35:14 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45996 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeDEEfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 00:35:13 -0400
Date: Thu, 5 Apr 2018 07:26:55 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
        "Shaoyun.liu" <shaoyun.liu@amd.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: fix linux/kfd_ioctl.h userspace compilation errors
Message-ID: <20180405042655.GA13233@altlinux.org>
Mail-Followup-To: Felix Kuehling <Felix.Kuehling@amd.com>,
        "Shaoyun.liu" <shaoyun.liu@amd.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistently use types provided by <linux/types.h> via <drm/drm.h>
to fix the following linux/kfd_ioctl.h userspace compilation errors:

/usr/include/linux/kfd_ioctl.h:266:2: error: unknown type name 'uint64_t'
  uint64_t tba_addr;  /* to KFD */
/usr/include/linux/kfd_ioctl.h:267:2: error: unknown type name 'uint64_t'
  uint64_t tma_addr;  /* to KFD */
/usr/include/linux/kfd_ioctl.h:268:2: error: unknown type name 'uint32_t'
  uint32_t gpu_id;  /* to KFD */
/usr/include/linux/kfd_ioctl.h:269:2: error: unknown type name 'uint32_t'
  uint32_t pad;

Fixes: d7b9bd2248d79 ("drm/amdkfd: Add support for user-mode trap handlers")
Cc: <stable@vger.kernel.org> # v4.16
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/kfd_ioctl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f4cab5b3ba9a..111d73ba2d96 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -263,10 +263,10 @@ struct kfd_ioctl_get_tile_config_args {
 };
 
 struct kfd_ioctl_set_trap_handler_args {
-	uint64_t tba_addr;		/* to KFD */
-	uint64_t tma_addr;		/* to KFD */
-	uint32_t gpu_id;		/* to KFD */
-	uint32_t pad;
+	__u64 tba_addr;		/* to KFD */
+	__u64 tma_addr;		/* to KFD */
+	__u32 gpu_id;		/* to KFD */
+	__u32 pad;
 };
 
 #define AMDKFD_IOCTL_BASE 'K'
-- 
ldv

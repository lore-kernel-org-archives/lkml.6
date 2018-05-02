Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbeEBOTI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:19:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750936AbeEBOTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:19:06 -0400
Date: Wed, 2 May 2018 17:19:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH] Revert "vhost: make msg padding explicit"
Message-ID: <1525270740-460646-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 93c0d549c4c5a7382ad70de6b86610b7aae57406.

Unfortunately the padding will break 32 bit userspace.
Ouch. Need to add some compat code, revert for now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/vhost.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 5a8ad06..c51f8e5 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -68,7 +68,6 @@ struct vhost_iotlb_msg {
 
 struct vhost_msg {
 	int type;
-	int padding0;
 	union {
 		struct vhost_iotlb_msg iotlb;
 		__u8 padding[64];
-- 
MST

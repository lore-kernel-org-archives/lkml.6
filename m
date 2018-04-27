Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758676AbeD0QCH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:02:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758604AbeD0QCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:02:06 -0400
Date: Fri, 27 Apr 2018 19:02:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Kevin Easton <kevin@guarana.org>, Jason Wang <jasowang@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: [PATCH] vhost: make msg padding explicit
Message-ID: <1524844881-178524-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a 32 bit hole just after type. It's best to
give it a name, this way compiler is forced to initialize
it with rest of the structure.

Reported-by: Kevin Easton <kevin@guarana.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/vhost.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index c51f8e5..5a8ad06 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -68,6 +68,7 @@ struct vhost_iotlb_msg {
 
 struct vhost_msg {
 	int type;
+	int padding0;
 	union {
 		struct vhost_iotlb_msg iotlb;
 		__u8 padding[64];
-- 
MST

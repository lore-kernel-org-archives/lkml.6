Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeDSFaz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:30:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753249AbeDSFaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:30:52 -0400
Date: Thu, 19 Apr 2018 08:30:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v2 net 3/3] virtio_net: sparse annotation fix
Message-ID: <1524115776-334953-4-git-send-email-mst@redhat.com>
References: <1524115776-334953-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524115776-334953-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

offloads is a buffer in virtio format, should use
the __virtio64 tag.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f84fe04..c5b11f2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -155,7 +155,7 @@ struct control_buf {
 	u8 promisc;
 	u8 allmulti;
 	__virtio16 vid;
-	u64 offloads;
+	__virtio64 offloads;
 };
 
 struct virtnet_info {
-- 
MST

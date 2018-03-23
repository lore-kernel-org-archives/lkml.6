Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4005782-1521764232-2-14033404493115952425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521764231; b=nc+iaZe/dk+Lm/WWeAlF/AMiWA7RUy6FdoMcGWjGPuDw+PD
    UZL5oZWK9AHGOb+pMQinHserNoO+gLfpxYJbCMp1l1+V3Sn8Y3NXy2sZD39LHWk4
    7LXHjFqhwBVPtYuFDR2LOUkU+Q1M0PTNUPXvjjQwPigsoC6d8hNjm415LUU+TqX5
    tR3ZY3w0CbcDLFae6o9G/3Y3p0xf0i+ecgvTv2wxTZMev2nqGaK0ATfKMjraCd2z
    uJwwpu+MV8JGWaJM2brkp9GxcrK9ylcxe+tvrJfod2/AlopG/P9zQ8z17SCFQPkO
    TiILBnfsY2gjAyj/NXQU0PiaCEMt3UxxtTHyVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521764231; bh=t
    K7++7Thi3xnzv26rcCQiqSKU9yTw1TWQouTHlglkmg=; b=DNtZklkBeqzZJ8BTe
    L3JUVmEeHtrIJDREostf8hEOvGqnWhm6pFU9aOoiejEuloV6ajwuoho5SLF+55dP
    svIPaSA2B2TWh2wqSrO233+8y5iMqH0X4K6GVpqczT3Rr6f7hwo02QwJqMpFzv6B
    dCPlfUZJ8aWGcSIO8CO752Iy+vvQmOO9nh1jd8bPwPj0kJ4CicXRGbYWis1HVqgo
    LQtP75Eayz7s3taM+QiKetAS/JKMbgueCaIIEX5ZiRtuGLkoUoB2r+uU472bI1OQ
    95wqA+BwmG18bQikNYxDagoFgMDMttYDI3RihPWC+cLEabqXI+9DHyR5KVLYgswd
    uXlyw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring buffer
 percentage
Date: Thu, 22 Mar 2018 17:15:37 -0700
Message-Id: <20180323001538.31876-2-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180323001538.31876-1-longli@linuxonhyperv.com>
References: <20180323001538.31876-1-longli@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfG305MfkxXzo5w34EqwXBhc5ABXK0d4Qw+b8b7GuQvNYHgndcF8MGVfuG4+Pths+RNYl5FZkSAPgMzKRieAnQ+RZ9SbhEENBxV0l545MZgTKXmd29HF0
 HXwVshJHAeYetLyQ2kpXxpLhQTxLQ1Qc5/4pxac1uN+yNVOQiwkveUn9K+kadSLSz/j9zM/qOD1NA/muxTca/somJFyeR2fMxENphtcYDxIlz0RkOomuYLvY
 b1hDeCBzdeZo22XUd6dDZp/PG3xdL49FGfz4OINdFuEKsVE2/sQXfNelcTBcd8e8FQB/1bDhSBlTiuO+qBXsBT9Y1j/tJYf+2r4n19ypXzYLdbg8gGS789yz
 AV/H4yEbbdHjMZTo8JtEUni1PJN6lpjDnIm807z7zsDnJFI6uX8sdgVtuo+fpRNDweU+U4WZGdVxi/JAq96eDRrFokh0uAC6L4gHyG4SMBrnnUjzmDKOWNmV
 keXxkAI6iYcCHWUtdV1WPGwaOpu7oejl9abhVZqm/OMd4YASgovGuX2eN2g=
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

In Vmbus, we have defined a function to calculate available ring buffer
percentage to write.

Use that function and remove duplicate netvsc code.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/hyperv/netvsc.c     | 17 +++--------------
 drivers/net/hyperv/netvsc_drv.c |  3 ---
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 0265d703eb03..8af0069e4d8c 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -31,7 +31,6 @@
 #include <linux/vmalloc.h>
 #include <linux/rtnetlink.h>
 #include <linux/prefetch.h>
-#include <linux/reciprocal_div.h>
 
 #include <asm/sync_bitops.h>
 
@@ -590,17 +589,6 @@ void netvsc_device_remove(struct hv_device *device)
 #define RING_AVAIL_PERCENT_HIWATER 20
 #define RING_AVAIL_PERCENT_LOWATER 10
 
-/*
- * Get the percentage of available bytes to write in the ring.
- * The return value is in range from 0 to 100.
- */
-static u32 hv_ringbuf_avail_percent(const struct hv_ring_buffer_info *ring_info)
-{
-	u32 avail_write = hv_get_bytes_to_write(ring_info);
-
-	return reciprocal_divide(avail_write  * 100, netvsc_ring_reciprocal);
-}
-
 static inline void netvsc_free_send_slot(struct netvsc_device *net_device,
 					 u32 index)
 {
@@ -649,7 +637,8 @@ static void netvsc_send_tx_complete(struct netvsc_device *net_device,
 		wake_up(&net_device->wait_drain);
 
 	if (netif_tx_queue_stopped(netdev_get_tx_queue(ndev, q_idx)) &&
-	    (hv_ringbuf_avail_percent(&channel->outbound) > RING_AVAIL_PERCENT_HIWATER ||
+	    (hv_get_avail_to_write_percent(&channel->outbound) >
+	     RING_AVAIL_PERCENT_HIWATER ||
 	     queue_sends < 1)) {
 		netif_tx_wake_queue(netdev_get_tx_queue(ndev, q_idx));
 		ndev_ctx->eth_stats.wake_queue++;
@@ -757,7 +746,7 @@ static inline int netvsc_send_pkt(
 	struct netdev_queue *txq = netdev_get_tx_queue(ndev, packet->q_idx);
 	u64 req_id;
 	int ret;
-	u32 ring_avail = hv_ringbuf_avail_percent(&out_channel->outbound);
+	u32 ring_avail = hv_get_avail_to_write_percent(&out_channel->outbound);
 
 	nvmsg.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
 	if (skb)
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index faea0be18924..b0b1c2fd2b7b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -35,7 +35,6 @@
 #include <linux/slab.h>
 #include <linux/rtnetlink.h>
 #include <linux/netpoll.h>
-#include <linux/reciprocal_div.h>
 
 #include <net/arp.h>
 #include <net/route.h>
@@ -55,7 +54,6 @@ static unsigned int ring_size __ro_after_init = 128;
 module_param(ring_size, uint, S_IRUGO);
 MODULE_PARM_DESC(ring_size, "Ring buffer size (# of pages)");
 unsigned int netvsc_ring_bytes __ro_after_init;
-struct reciprocal_value netvsc_ring_reciprocal __ro_after_init;
 
 static const u32 default_msg = NETIF_MSG_DRV | NETIF_MSG_PROBE |
 				NETIF_MSG_LINK | NETIF_MSG_IFUP |
@@ -2186,7 +2184,6 @@ static int __init netvsc_drv_init(void)
 			ring_size);
 	}
 	netvsc_ring_bytes = ring_size * PAGE_SIZE;
-	netvsc_ring_reciprocal = reciprocal_value(netvsc_ring_bytes);
 
 	ret = vmbus_driver_register(&netvsc_drv);
 	if (ret)
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

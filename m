Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB2C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660492084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660492084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754440AbeGIIgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:36:13 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeGIIgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:36:11 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MAAfN-1fnCDf0ddR-00BKzz; Mon, 09 Jul 2018 10:35:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Henry Orosco <henry.orosco@intel.com>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] [v3] infiniband: i40iw, nes: don't use wall time for TCP sequence numbers
Date:   Mon,  9 Jul 2018 10:34:43 +0200
Message-Id: <20180709083523.448587-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:rSrAKW9dicx5MxyWzZY/+sqFwvArtFG7G/WGNiZng8bufP3QMHB
 dq7WsQJsjcgCb7jjoLUAnWtxqfFfIRQOQw69PWT36j7lY3T0yxlxcdkI71H/pKsFTPDX/mB
 5M2uHg2HxJJkIubqxiX5Oz7I3kndNw3eyHLBn3m3pMuDFky2H22Z0PWWVFOG1XFRA43F2hA
 TC9ZbOMywJAZCrLOriGEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8POcDsgy4BQ=:FbOCrPRYvA5mJgJbh020lQ
 NdxKySJ3F6lc9TuG30LCdlMZ3s9iNRTY1XbtrfUh9cBEdxvw4iKetam/dTlaovl6nXyuS0rXK
 5VGu8BGRFf4EmwnC3p8blplHHFpbuvggYWJsWcYNdOTr0AEdb6No7BeBfMq8Dm5kZr+90heN3
 2qs2CbGi/zPO55FWOUuXcSY6YNY0OBbdy/QbKxLgxR7A5fQobUz6kAvtHln1uaALQy9AIpM6/
 XZj9zyYOlFx+rmy/dqD943bQHR8o9lJThWFOTY3+0zfebYVN60KdG2vO2g0hCZi6sL45BqXiA
 f0EUm88NCkOHPtCZbwswXDw0xej1VXyi9lj7F6WX/IpovS7WGXHTprJLKDJzN7NznoCXLwIB5
 9nXnqj9ldXn+DRdBf9NMq0e012BYjZYhQaJJ+M/3jyR8AHUepD7k3WJVqbwga6xBYTLClCxOA
 ejX2pdrDoke4OG+b7hHktC5WNdRqeaPG5oa4ZfurmNFhdF8xqKREYwn9yhD4p3I/OqfYObHFj
 lRKnSg/lMmOy7ac5gH07ENtpkZ2r+MdlYimulsJlToP/JjAmeNVf9FKvUOeDAJU9edrncrZRT
 U5ug2IDWYGR5m2zdrZ+K3roc2tFPLz9R1QwQoe8UgWqU7fiVEViLQMBEXuNSfv91oX+ec6uLg
 lpKsyQEQvxajmttbH1TiA9Onnxq14J/K9Jjky7xdPRaA8+oIghdRvQY5xqDLbCL0FuPM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nes infiniband driver uses current_kernel_time() to get a nanosecond
granunarity timestamp to initialize its tcp sequence counters. This is
one of only a few remaining users of that deprecated function, so we
should try to get rid of it.

Aside from using a deprecated API, there are several problems I see here:

- Using a CLOCK_REALTIME based time source makes it predictable in
  case the time base is synchronized.
- Using a coarse timestamp means it only gets updated once per jiffie,
  making it even more predictable in order to avoid having to access
  the hardware clock source
- The upper 2 bits are always zero because the nanoseconds are at most
  999999999.

For the Linux TCP implementation, we use secure_tcp_seq(), which appears
to be appropriate here as well, and solves all the above problems.

i40iw uses a variant of the same code, so I do that same thing there
for ipv4. Unlike nes, i40e also supports ipv6, which needs to call
secure_tcpv6_seq instead.

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use secure_tcpv6_seq for IPv6 support as suggested by Shiraz Saleem.
v3: add a soft IPv6 dependency to prevent a link error with CONFIG_IPV6=m,
    this now forces i40iw to be a module as well, add an IS_ENABLED()
    check to avoid calling it when IPV6 is completely disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/i40iw/Kconfig    |  1 +
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 26 +++++++++++++++++++++-----
 drivers/infiniband/hw/nes/nes_cm.c     |  8 +++++---
 net/core/secure_seq.c                  |  1 +
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/Kconfig b/drivers/infiniband/hw/i40iw/Kconfig
index 2962979c06e9..d867ef1ac72a 100644
--- a/drivers/infiniband/hw/i40iw/Kconfig
+++ b/drivers/infiniband/hw/i40iw/Kconfig
@@ -1,6 +1,7 @@
 config INFINIBAND_I40IW
 	tristate "Intel(R) Ethernet X722 iWARP Driver"
 	depends on INET && I40E
+	depends on IPV6 || !IPV6
 	depends on PCI
 	select GENERIC_ALLOCATOR
 	---help---
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 7b2655128b9f..423818a7d333 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -57,6 +57,7 @@
 #include <net/addrconf.h>
 #include <net/ip6_route.h>
 #include <net/ip_fib.h>
+#include <net/secure_seq.h>
 #include <net/tcp.h>
 #include <asm/checksum.h>
 
@@ -2164,7 +2165,6 @@ static struct i40iw_cm_node *i40iw_make_cm_node(
 				   struct i40iw_cm_listener *listener)
 {
 	struct i40iw_cm_node *cm_node;
-	struct timespec ts;
 	int oldarpindex;
 	int arpindex;
 	struct net_device *netdev = iwdev->netdev;
@@ -2214,10 +2214,26 @@ static struct i40iw_cm_node *i40iw_make_cm_node(
 	cm_node->tcp_cntxt.rcv_wscale = I40IW_CM_DEFAULT_RCV_WND_SCALE;
 	cm_node->tcp_cntxt.rcv_wnd =
 			I40IW_CM_DEFAULT_RCV_WND_SCALED >> I40IW_CM_DEFAULT_RCV_WND_SCALE;
-	ts = current_kernel_time();
-	cm_node->tcp_cntxt.loc_seq_num = ts.tv_nsec;
-	cm_node->tcp_cntxt.mss = (cm_node->ipv4) ? (iwdev->vsi.mtu - I40IW_MTU_TO_MSS_IPV4) :
-				 (iwdev->vsi.mtu - I40IW_MTU_TO_MSS_IPV6);
+	if (cm_node->ipv4) {
+		cm_node->tcp_cntxt.loc_seq_num = secure_tcp_seq(htonl(cm_node->loc_addr[0]),
+							htonl(cm_node->rem_addr[0]),
+							htons(cm_node->loc_port),
+							htons(cm_node->rem_port));
+		cm_node->tcp_cntxt.mss = iwdev->vsi.mtu - I40IW_MTU_TO_MSS_IPV4;
+	} else if (IS_ENABLED(CONFIG_IPV6)) {
+		__be32 loc[4] = {
+			htonl(cm_node->loc_addr[0]), htonl(cm_node->loc_addr[1]),
+			htonl(cm_node->loc_addr[2]), htonl(cm_node->loc_addr[3])
+		};
+		__be32 rem[4] = {
+			htonl(cm_node->rem_addr[0]), htonl(cm_node->rem_addr[1]),
+			htonl(cm_node->rem_addr[2]), htonl(cm_node->rem_addr[3])
+		};
+		cm_node->tcp_cntxt.loc_seq_num = secure_tcpv6_seq(loc, rem,
+							htons(cm_node->loc_port),
+							htons(cm_node->rem_port));
+		cm_node->tcp_cntxt.mss = iwdev->vsi.mtu - I40IW_MTU_TO_MSS_IPV6;
+	}
 
 	cm_node->iwdev = iwdev;
 	cm_node->dev = &iwdev->sc_dev;
diff --git a/drivers/infiniband/hw/nes/nes_cm.c b/drivers/infiniband/hw/nes/nes_cm.c
index 6cdfbf8c5674..2b67ace5b614 100644
--- a/drivers/infiniband/hw/nes/nes_cm.c
+++ b/drivers/infiniband/hw/nes/nes_cm.c
@@ -58,6 +58,7 @@
 #include <net/neighbour.h>
 #include <net/route.h>
 #include <net/ip_fib.h>
+#include <net/secure_seq.h>
 #include <net/tcp.h>
 #include <linux/fcntl.h>
 
@@ -1445,7 +1446,6 @@ static struct nes_cm_node *make_cm_node(struct nes_cm_core *cm_core,
 					struct nes_cm_listener *listener)
 {
 	struct nes_cm_node *cm_node;
-	struct timespec ts;
 	int oldarpindex = 0;
 	int arpindex = 0;
 	struct nes_device *nesdev;
@@ -1496,8 +1496,10 @@ static struct nes_cm_node *make_cm_node(struct nes_cm_core *cm_core,
 	cm_node->tcp_cntxt.rcv_wscale = NES_CM_DEFAULT_RCV_WND_SCALE;
 	cm_node->tcp_cntxt.rcv_wnd = NES_CM_DEFAULT_RCV_WND_SCALED >>
 				     NES_CM_DEFAULT_RCV_WND_SCALE;
-	ts = current_kernel_time();
-	cm_node->tcp_cntxt.loc_seq_num = htonl(ts.tv_nsec);
+	cm_node->tcp_cntxt.loc_seq_num = secure_tcp_seq(htonl(cm_node->loc_addr),
+							htonl(cm_node->rem_addr),
+							htons(cm_node->loc_port),
+							htons(cm_node->rem_port));
 	cm_node->tcp_cntxt.mss = nesvnic->max_frame_size - sizeof(struct iphdr) -
 				 sizeof(struct tcphdr) - ETH_HLEN - VLAN_HLEN;
 	cm_node->tcp_cntxt.rcv_nxt = 0;
diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
index 7232274de334..af6ad467ed61 100644
--- a/net/core/secure_seq.c
+++ b/net/core/secure_seq.c
@@ -140,6 +140,7 @@ u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
 			    &net_secret);
 	return seq_scale(hash);
 }
+EXPORT_SYMBOL_GPL(secure_tcp_seq);
 
 u32 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport)
 {
-- 
2.9.0


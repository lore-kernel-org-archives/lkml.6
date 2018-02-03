Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1639138-1517683916-2-627359355880336868
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683915; b=FdRV1TZRJ9DCHFWdE41EU+yITi+qChNPtWR+2qLkMRMdX+g
    6veSfEmJEHwv/mZL/aaFvXqqStpaLwM6fNEAkTrn3rKiNKj0hPHN7+0lkC0lS9YG
    3a7WBG+bXxXfFfLtg+isUarMuYQwEw+r7Fd99hIEm+NnMArPx6niRVUYrkyS4/z5
    qtCPt+5EjwumtuxUVyNYLT9v2O1JOAnKnTPEnGBo/FSzScIUe+5NBUF5zcvAfZ/U
    hqza5m1bFpbgASKj7Xhbklfdcj4hxIJXe0uHZpaRkSYN/jM2890ueHsC4m3joDYL
    /Ky5T5H13nvlg+n3bQC/PTJMeoOwl/fzDA/zoPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683915; bh=E3cmSg
    AFFqEdboET3l1ThuBMpUIFJeJZzTRZWiXjR2U=; b=StrymLBwt+L5tKY1RydphD
    TsVVDyplBHeSnCaT5QehFMN1vKEn9RsEeecyRFg1y87S/C+KFztZVLVvYIRt7MBk
    Q5KwTGNYkChKjHZo0wD25XvPefgkO+R3fhMExpU7uk2b1ajbhbldVrG0HkaUeEaM
    4pBX++4Wxf6wHfnh/cc4rNxrCyjA+VqsCqrhnOUSLKdA3tuygy6YGHFfGNIE1Diy
    dHZJzI305PYteJvZ7yDDdGNylcHaddQfh0OZ9Sn8C4y2kMP2AQAFCGc7y5uoTP9K
    wCWGBNLfcebmIZXp8LUosGYdpgb9xY62Bia3/xmwAnBks+CsewYGVoQ9ticDRn/Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dah1f5OT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dah1f5OT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeBCSvt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:51:49 -0500
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:2624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752858AbeBCSBN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 025/110] xfrm: Reinject transport-mode
 packets through tasklet
Thread-Topic: [PATCH AUTOSEL for 4.14 025/110] xfrm: Reinject transport-mode
 packets through tasklet
Thread-Index: AQHTnRjmi43borHdIEavwZ+XUdC7uA==
Date: Sat, 3 Feb 2018 18:00:40 +0000
Message-ID: <20180203180015.29073-25-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;7:LBY8JRLaSy/e5UUERdvIGqSu6xuEI1dCY4tvmeNTwcx35aLnB+gkntzYRtK3zbWTor07hi4MOjrZYeQ4cCr4FZEwbDTOdClYIVcg8ivGsuuX8o4NR0TeMSQ+0W+RxZaHAdfBTN6cQhzG0lg5cOE8GSuCMenWdCHCAbDCIOViI6rKqPwUna1OwKUDIbxjOsTJF4ZM5eLaSG+RgqEEh5yOc+ku7donN7h0l2bzC2j8c6qdV0rYjxIW3LAQj0kupSTw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6cb6bf8-98a5-4b84-3921-08d56b300abc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB1090FB1270564FC9BD37513BFBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(278021516957215);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(966005)(107886003)(72206003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(6306002)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: QjVNfxDsunJjbNetmqpg1DP2LjkAw46kKsrdEoJWNuoWMG1tWr8XuBEpB2dXpndQZCEdckrP6D6OkKWm+Cjp1w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cb6bf8-98a5-4b84-3921-08d56b300abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:40.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit acf568ee859f098279eadf551612f103afdacb4e ]

This is an old bugbear of mine:

https://www.mail-archive.com/netdev@vger.kernel.org/msg03894.html

By crafting special packets, it is possible to cause recursion
in our kernel when processing transport-mode packets at levels
that are only limited by packet size.

The easiest one is with DNAT, but an even worse one is where
UDP encapsulation is used in which case you just have to insert
an UDP encapsulation header in between each level of recursion.

This patch avoids this problem by reinjecting tranport-mode packets
through a tasklet.

Fixes: b05e106698d9 ("[IPV4/6]: Netfilter IPsec input hooks")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/net/xfrm.h     |  3 +++
 net/ipv4/xfrm4_input.c | 12 ++++++++++-
 net/ipv6/xfrm6_input.c | 10 ++++++++-
 net/xfrm/xfrm_input.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index e015e164bac0..db99efb2d1d0 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1570,6 +1570,9 @@ int xfrm_init_state(struct xfrm_state *x);
 int xfrm_prepare_input(struct xfrm_state *x, struct sk_buff *skb);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_typ=
e);
 int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
+int xfrm_trans_queue(struct sk_buff *skb,
+		     int (*finish)(struct net *, struct sock *,
+				   struct sk_buff *));
 int xfrm_output_resume(struct sk_buff *skb, int err);
 int xfrm_output(struct sock *sk, struct sk_buff *skb);
 int xfrm_inner_extract_output(struct xfrm_state *x, struct sk_buff *skb);
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index e50b7fea57ee..bcfc00e88756 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -23,6 +23,12 @@ int xfrm4_extract_input(struct xfrm_state *x, struct sk_=
buff *skb)
 	return xfrm4_extract_header(skb);
 }
=20
+static int xfrm4_rcv_encap_finish2(struct net *net, struct sock *sk,
+				   struct sk_buff *skb)
+{
+	return dst_input(skb);
+}
+
 static inline int xfrm4_rcv_encap_finish(struct net *net, struct sock *sk,
 					 struct sk_buff *skb)
 {
@@ -33,7 +39,11 @@ static inline int xfrm4_rcv_encap_finish(struct net *net=
, struct sock *sk,
 					 iph->tos, skb->dev))
 			goto drop;
 	}
-	return dst_input(skb);
+
+	if (xfrm_trans_queue(skb, xfrm4_rcv_encap_finish2))
+		goto drop;
+
+	return 0;
 drop:
 	kfree_skb(skb);
 	return NET_RX_DROP;
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index fe04e23af986..841f4a07438e 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -32,6 +32,14 @@ int xfrm6_rcv_spi(struct sk_buff *skb, int nexthdr, __be=
32 spi,
 }
 EXPORT_SYMBOL(xfrm6_rcv_spi);
=20
+static int xfrm6_transport_finish2(struct net *net, struct sock *sk,
+				   struct sk_buff *skb)
+{
+	if (xfrm_trans_queue(skb, ip6_rcv_finish))
+		__kfree_skb(skb);
+	return -1;
+}
+
 int xfrm6_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo =3D xfrm_offload(skb);
@@ -56,7 +64,7 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async=
)
=20
 	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
 		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
-		ip6_rcv_finish);
+		xfrm6_transport_finish2);
 	return -1;
 }
=20
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 347ab31574d5..444fa3765f1d 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -8,15 +8,29 @@
  *
  */
=20
+#include <linux/bottom_half.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/percpu.h>
 #include <net/dst.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
 #include <net/ip_tunnels.h>
 #include <net/ip6_tunnel.h>
=20
+struct xfrm_trans_tasklet {
+	struct tasklet_struct tasklet;
+	struct sk_buff_head queue;
+};
+
+struct xfrm_trans_cb {
+	int (*finish)(struct net *net, struct sock *sk, struct sk_buff *skb);
+};
+
+#define XFRM_TRANS_SKB_CB(__skb) ((struct xfrm_trans_cb *)&((__skb)->cb[0]=
))
+
 static struct kmem_cache *secpath_cachep __read_mostly;
=20
 static DEFINE_SPINLOCK(xfrm_input_afinfo_lock);
@@ -25,6 +39,8 @@ static struct xfrm_input_afinfo const __rcu *xfrm_input_a=
finfo[AF_INET6 + 1];
 static struct gro_cells gro_cells;
 static struct net_device xfrm_napi_dev;
=20
+static DEFINE_PER_CPU(struct xfrm_trans_tasklet, xfrm_trans_tasklet);
+
 int xfrm_input_register_afinfo(const struct xfrm_input_afinfo *afinfo)
 {
 	int err =3D 0;
@@ -467,9 +483,41 @@ int xfrm_input_resume(struct sk_buff *skb, int nexthdr=
)
 }
 EXPORT_SYMBOL(xfrm_input_resume);
=20
+static void xfrm_trans_reinject(unsigned long data)
+{
+	struct xfrm_trans_tasklet *trans =3D (void *)data;
+	struct sk_buff_head queue;
+	struct sk_buff *skb;
+
+	__skb_queue_head_init(&queue);
+	skb_queue_splice_init(&trans->queue, &queue);
+
+	while ((skb =3D __skb_dequeue(&queue)))
+		XFRM_TRANS_SKB_CB(skb)->finish(dev_net(skb->dev), NULL, skb);
+}
+
+int xfrm_trans_queue(struct sk_buff *skb,
+		     int (*finish)(struct net *, struct sock *,
+				   struct sk_buff *))
+{
+	struct xfrm_trans_tasklet *trans;
+
+	trans =3D this_cpu_ptr(&xfrm_trans_tasklet);
+
+	if (skb_queue_len(&trans->queue) >=3D netdev_max_backlog)
+		return -ENOBUFS;
+
+	XFRM_TRANS_SKB_CB(skb)->finish =3D finish;
+	skb_queue_tail(&trans->queue, skb);
+	tasklet_schedule(&trans->tasklet);
+	return 0;
+}
+EXPORT_SYMBOL(xfrm_trans_queue);
+
 void __init xfrm_input_init(void)
 {
 	int err;
+	int i;
=20
 	init_dummy_netdev(&xfrm_napi_dev);
 	err =3D gro_cells_init(&gro_cells, &xfrm_napi_dev);
@@ -480,4 +528,13 @@ void __init xfrm_input_init(void)
 					   sizeof(struct sec_path),
 					   0, SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 					   NULL);
+
+	for_each_possible_cpu(i) {
+		struct xfrm_trans_tasklet *trans;
+
+		trans =3D &per_cpu(xfrm_trans_tasklet, i);
+		__skb_queue_head_init(&trans->queue);
+		tasklet_init(&trans->tasklet, xfrm_trans_reinject,
+			     (unsigned long)trans);
+	}
 }
--=20
2.11.0

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682558-2-9884191908757963307
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682557; b=ZijjcOlC5y4rdhTz2MgI5s2QvIi/kVjh0muqFAliqZbw0Jm
    5zx6d09ZhTIxdpfX6KP+wDW3O111/49FnNWPn3Xc8S3CgPdxl7w/I/f4FjCygnSg
    Aks8r0OkmP4RqGhxVYrC3+5c7+BAAzU7MUpgKe3hB5gJ1LVWFdvJ7mWC+9qB/e+r
    Q7nyPqkVMlDDfR2B6xLYTLpPkolEOIsh4KiAqZthNltSJZGzyVLATQARyBj4sdNf
    I0TM2myh8HRfsOi5kufk1N9IpSzMSzvtfumoiBDWP5e46682Mh6bdraghzHNE4YN
    TGRmccm2odvzFCjJfEngakCNKMKQdT2DfqTH8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682557; bh=6MNxDc
    kMRIJ9OBH3456lro0nG/bAWVPv7AJjnsKfjWg=; b=vX0zEhBz0wh9ChZZwzCtt2
    4oAOYPQk7vy//dH8Ud0H/KCTud1CMDp6uO5ptdq04K4SMPOOacZDDVQwOFhE5iXj
    whm6XCvChvk0X2RX7LDXAPHrREGYtnKOLLTxOdY48FtpqONe/y2gICl5YUPMUUQy
    PnLw1Jfa8uOq1FfySIM48TkDw+J5MLRuMHUlptbnDqjKxpxg2HUXkOlHucpoghZz
    Lq1TOHzKnWr6QGOjbDvJGrc5G0Ed1JAWj+IpfBotNV6HSw8ERynEKjB3g1tk3b3e
    EhSvUrMDcNqBOAsHxkoKptBOPdnYV3PUHMuhJVNb8GlEeXOLd9lzVuVKsiZdNrPQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iIy+Wepl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iIy+Wepl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeBCS2i (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:38 -0500
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:44500
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753313AbeBCSEv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 074/110] IB/ipoib: Fix race condition in
 neigh creation
Thread-Topic: [PATCH AUTOSEL for 4.14 074/110] IB/ipoib: Fix race condition in
 neigh creation
Thread-Index: AQHTnRj80YjHlLfYFk+cO/w9ycU3sQ==
Date: Sat, 3 Feb 2018 18:01:17 +0000
Message-ID: <20180203180015.29073-74-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;6:FVFM3xfsxpohUiDiFdYg/tCEOYImDBVYlqj98zHBeA8e3o/D39HD4xVINqzsArNu6C2dbL4FUAju4wngj42PLfJRv70H9q5bXMWUbcMJYDTft/+1L5BgC+UXyHu5it5zaXEme6FpwPlb+zwmd1RpkIyuqh7k2Qo7yYDDw/ll+bvRhnv4sYi3jVv98B7JLzN9cA/cq5iPiHkJpHB2bQyX6y0BgpgmZSJkViZDUjKMQiAPkKBRPH6kN5ZFA8LYRUCBED2RYHlVIly7F3yXPrSDEaTNXTyKF6TMQOAzh2436ziBmPN/4eCL7G0246W9J2ED7QaSPT8dHqRB0ezojYGf43+rcE+bL62rrQNVl50pp2nVf4VfuPmgJuI7HgOTEe2w;5:Dg90w8MKTyfiPFqP/jH9lK78aoakXv/qjZiyVFe4EUvEpMyNFBYM1nrKHFE/5UofUY2Vz1aViOkvYzEe0P4aybOx3396Udqd0y5Y7CBO/xpYuar6VcN/IXXWWu+S8gtP9VGkG0hPA0spdzis6TIA7QPL/MS7e4n2Vsbxeh7IaFY=;24:h5hK62D8+Qw1Zx9XweM08BMwd3YjV4StYijl5k7lOa9oxDfLO+QiAMEe2GCJOBCbUHq5uxW6g8xBKMjSFq0swVDjx76zQizbLpAu5LNdf6Y=;7:sR/1izBEx/P8QzntKlpQXPkkycEoHOZBTNr7Fomlk9B5iI+jv3m0GVZC52oQchu28gSf0oROUJqNy2H6K6Rk+EZnEsUD0URtA9ErlUzgCqV7XwHWpXZpR2Aavw5PP1U2+XuBXe66vFnScJKfMAwXhX/zXylk3Ic4MtIrlnU5Ab6TwqF9Q3fEmewH2/qya+xvlZknrResT/fYp2AGofrgcJ9KEcmnYw+xMxoX97Y19OCJvvATfJ1LGx/PKtsfprEC
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4b9b245-3d07-4848-9653-08d56b303e16
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB11051A30B4B4A03B84953161FBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: WTJdPNdXbgDsgGg0mu3xINuNNaysiOj+gKi6n2xrbpdsISdL+ISB4OzJ2ojEP1gmNHTsh3Q5F7vMRJvIuvanJw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b9b245-3d07-4848-9653-08d56b303e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:17.2534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Erez Shitrit <erezsh@mellanox.com>

[ Upstream commit 16ba3defb8bd01a9464ba4820a487f5b196b455b ]

When using enhanced mode for IPoIB, two threads may execute xmit in
parallel to two different TX queues while the target is the same.
In this case, both of them will add the same neighbor to the path's
neigh link list and we might see the following message:

  list_add double add: new=3Dffff88024767a348, prev=3Dffff88024767a348...
  WARNING: lib/list_debug.c:31__list_add_valid+0x4e/0x70
  ipoib_start_xmit+0x477/0x680 [ib_ipoib]
  dev_hard_start_xmit+0xb9/0x3e0
  sch_direct_xmit+0xf9/0x250
  __qdisc_run+0x176/0x5d0
  __dev_queue_xmit+0x1f5/0xb10
  __dev_queue_xmit+0x55/0xb10

Analysis:
Two SKB are scheduled to be transmitted from two cores.
In ipoib_start_xmit, both gets NULL when calling ipoib_neigh_get.
Two calls to neigh_add_path are made. One thread takes the spin-lock
and calls ipoib_neigh_alloc which creates the neigh structure,
then (after the __path_find) the neigh is added to the path's neigh
link list. When the second thread enters the critical section it also
calls ipoib_neigh_alloc but in this case it gets the already allocated
ipoib_neigh structure, which is already linked to the path's neigh
link list and adds it again to the list. Which beside of triggering
the list, it creates a loop in the linked list. This loop leads to
endless loop inside path_rec_completion.

Solution:
Check list_empty(&neigh->list) before adding to the list.
Add a similar fix in "ipoib_multicast.c::ipoib_mcast_send"

Fixes: b63b70d87741 ('IPoIB: Use a private hash table for path lookup in xm=
it path')
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Reviewed-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c      | 25 ++++++++++++++++++----=
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |  5 ++++-
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband=
/ulp/ipoib/ipoib_main.c
index dcc77014018d..f6935811ef3f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -903,8 +903,8 @@ static int path_rec_start(struct net_device *dev,
 	return 0;
 }
=20
-static void neigh_add_path(struct sk_buff *skb, u8 *daddr,
-			   struct net_device *dev)
+static struct ipoib_neigh *neigh_add_path(struct sk_buff *skb, u8 *daddr,
+					  struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv =3D ipoib_priv(dev);
 	struct rdma_netdev *rn =3D netdev_priv(dev);
@@ -918,7 +918,15 @@ static void neigh_add_path(struct sk_buff *skb, u8 *da=
ddr,
 		spin_unlock_irqrestore(&priv->lock, flags);
 		++dev->stats.tx_dropped;
 		dev_kfree_skb_any(skb);
-		return;
+		return NULL;
+	}
+
+	/* To avoid race condition, make sure that the
+	 * neigh will be added only once.
+	 */
+	if (unlikely(!list_empty(&neigh->list))) {
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return neigh;
 	}
=20
 	path =3D __path_find(dev, daddr + 4);
@@ -957,7 +965,7 @@ static void neigh_add_path(struct sk_buff *skb, u8 *dad=
dr,
 			path->ah->last_send =3D rn->send(dev, skb, path->ah->ah,
 						       IPOIB_QPN(daddr));
 			ipoib_neigh_put(neigh);
-			return;
+			return NULL;
 		}
 	} else {
 		neigh->ah  =3D NULL;
@@ -974,7 +982,7 @@ static void neigh_add_path(struct sk_buff *skb, u8 *dad=
dr,
=20
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
-	return;
+	return NULL;
=20
 err_path:
 	ipoib_neigh_free(neigh);
@@ -984,6 +992,8 @@ err_drop:
=20
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
+
+	return NULL;
 }
=20
 static void unicast_arp_send(struct sk_buff *skb, struct net_device *dev,
@@ -1092,8 +1102,9 @@ static int ipoib_start_xmit(struct sk_buff *skb, stru=
ct net_device *dev)
 	case htons(ETH_P_TIPC):
 		neigh =3D ipoib_neigh_get(dev, phdr->hwaddr);
 		if (unlikely(!neigh)) {
-			neigh_add_path(skb, phdr->hwaddr, dev);
-			return NETDEV_TX_OK;
+			neigh =3D neigh_add_path(skb, phdr->hwaddr, dev);
+			if (likely(!neigh))
+				return NETDEV_TX_OK;
 		}
 		break;
 	case htons(ETH_P_ARP):
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infin=
iband/ulp/ipoib/ipoib_multicast.c
index 93e149efc1f5..9b3f47ae2016 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -816,7 +816,10 @@ void ipoib_mcast_send(struct net_device *dev, u8 *dadd=
r, struct sk_buff *skb)
 		spin_lock_irqsave(&priv->lock, flags);
 		if (!neigh) {
 			neigh =3D ipoib_neigh_alloc(daddr, dev);
-			if (neigh) {
+			/* Make sure that the neigh will be added only
+			 * once to mcast list.
+			 */
+			if (neigh && list_empty(&neigh->list)) {
 				kref_get(&mcast->ah->ref);
 				neigh->ah	=3D mcast->ah;
 				list_add_tail(&neigh->list, &mcast->neigh_list);
--=20
2.11.0

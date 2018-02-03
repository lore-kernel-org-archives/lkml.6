Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682223-2-583073571305572447
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
    t=1517682223; b=QS/mdEQ3CEPDob7zRjCNPLAdPlCH5vPyRT2HEehW638rRNW
    xUW1w2vtfDWKGtiMqOwUFP4KKsR5RwW6WwQs0xyww3sSr67NDIaGzVaWBqM6FOw5
    Y3MVxK0eFBL3i+FwVjZxABu8k3vENuscT/zx65quV+5ZRHfbLjnJt/DNm5d/q1pw
    TNr0gYuZ6OACjC22ze7t6syxmeElZPsOCiEVupHL+H/wfxkkUdE1kIDXQ8pNEJ3K
    xbs0fSAaxcUy+IFRREIoFANnpO2vrxBCn1PdTHxqxlZYPEWD/Fzdh4C+KUwt2ekB
    auACc1TTgMypU25XHF3J+JMWoS8NJzvZZqgsmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682223; bh=NFLmVG
    KzWXggXhmsoNbugnRtZvHbyyhAvW1lKM/8Hg0=; b=cpm+tgDOncNZg5hEMjccIn
    G0Vx2ffaCkAkszz/tdvg6UGzuUvqVd/97L4nOFEvZsVIFMFIhV8PPC4IAzzbFIXT
    VyzC01wABQFfYrARBMOl4XtNClY8DG40IzEiDuW1CD49WSDkgbJmVg1aH0rh0qy5
    2U4gk42NXhMbq78cv9s8iTLb3IwNBeRiWdzNI20cuv07Onyvr/5VS60MlKn86MJO
    e0QWYYq6rvHmIIlkp++r6/gE8CIJVzFXAoXW10JHZ49zQ60RVtPKN9vshTY2x0GV
    Q7fkG0l+yhVoIjjH1X4WEScs+e6cWNUguhrD4yenjC0E9F0gfWy1SjdvglASOplw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YpMQjlDT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YpMQjlDT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754274AbeBCSXj (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:23:39 -0500
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:59967
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752236AbeBCSGX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 18/32] IB/ipoib: Fix race condition in neigh
 creation
Thread-Topic: [PATCH AUTOSEL for 4.4 18/32] IB/ipoib: Fix race condition in
 neigh creation
Thread-Index: AQHTnRly567Eh/+0s0SvZ5gQ+vrMJw==
Date: Sat, 3 Feb 2018 18:04:33 +0000
Message-ID: <20180203180413.7438-18-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;6:4VDUynFR/DB4Cy8YcgBi7Hl2qHGajGtg1JlV3DR57FhPJ5eL1yeQAtYTRcsYaJjIovF9i9zdOHyaUCJu9nS9OPnShQbEecKXz/1eFzK2I7jcZNd4XYPzA8RZVZvwe2H+IQTfiZNaM6qcI+Id5K5z0thG5C63g0tr+MciTeon+xf+edajhMJnJwzwLS10aYEhQbrJbHDsPZTkqF9WT3F+HdjwGAmH1P80o6mIq2/E356lgktcfllnnupkrfzQz2aKZqdCkZXe9zTeQTlYtsLJh+MIEJjIZJF+k/ummbkcOJCRJZPXwMTLUxMygEB4yasWeCXnoqrQjjf1RsNy+yOqFJIQ07IDytokE+ErWGMRuwgGRhwHu1kkrrI5TOTf5wQt;5:2YQMthuzRfD1gOpZ5UshXyE8F5XNt5buYN0Y98+QEYY1KG0gw5FFHpuI0OWEX1yjHRny9l+wdUAOQL3yNC18lku5/ChGMKw5SziJ1kRoaRfO1iwXOsDGuOhTqTst/2mB/REaUjeBr5MIRpwDvLDN3+P0IQd4qJrSOouLeziUh40=;24:w89bBqL8EgTf3yei3OO0wOK4tntm9ceb07sfm3ggzqg/J0Ju7y1UaU4xSevEjPheXX7vvbZgYtKeigKCjbI5hLZQGlnomBEO6Ijbr5lohLo=;7:OucAt2FrN9HJfdIZHa70FE79POBbxZSTj7wnAEyib6TmIpj82CmdUp8QAWgCkwqEwzrNgb8K3Z6GN7LbX6k7xO1941aYZw1nT4LyW2a39QTEg/38oFRraaCPOl0K74uyRD7pmU2I3RnGYGVcN3ZGAV45kF6SgX0aSRTj+dU8yoe2yQzo5N1UBewBNWUi2B1AtUKwf+RkROs80Vim9508/zrK+bi2iYh7PyT8hlxNSYMlixNGJ1A+L5oUDo8c1cZn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5003b6bd-9818-4e88-686f-08d56b30c2c8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009B320536604CC5BC61D6DFBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(575784001)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: nTPdwuebc+OCj6/FDv6mYTrRTTmNXS8a07WtpWcVsY2AL8ReApZAEAUWfmV4vuDSLnt7eRveMKm5JXS4BMqgwA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5003b6bd-9818-4e88-686f-08d56b30c2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:33.8933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
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
index bad76eed06b3..5c653669e736 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -844,8 +844,8 @@ static int path_rec_start(struct net_device *dev,
 	return 0;
 }
=20
-static void neigh_add_path(struct sk_buff *skb, u8 *daddr,
-			   struct net_device *dev)
+static struct ipoib_neigh *neigh_add_path(struct sk_buff *skb, u8 *daddr,
+					  struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv =3D netdev_priv(dev);
 	struct ipoib_path *path;
@@ -858,7 +858,15 @@ static void neigh_add_path(struct sk_buff *skb, u8 *da=
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
@@ -896,7 +904,7 @@ static void neigh_add_path(struct sk_buff *skb, u8 *dad=
dr,
 			spin_unlock_irqrestore(&priv->lock, flags);
 			ipoib_send(dev, skb, path->ah, IPOIB_QPN(daddr));
 			ipoib_neigh_put(neigh);
-			return;
+			return NULL;
 		}
 	} else {
 		neigh->ah  =3D NULL;
@@ -913,7 +921,7 @@ static void neigh_add_path(struct sk_buff *skb, u8 *dad=
dr,
=20
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
-	return;
+	return NULL;
=20
 err_path:
 	ipoib_neigh_free(neigh);
@@ -923,6 +931,8 @@ err_drop:
=20
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
+
+	return NULL;
 }
=20
 static void unicast_arp_send(struct sk_buff *skb, struct net_device *dev,
@@ -1028,8 +1038,9 @@ static int ipoib_start_xmit(struct sk_buff *skb, stru=
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
index 5580ab0b5781..8bf48165f32c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -775,7 +775,10 @@ void ipoib_mcast_send(struct net_device *dev, u8 *dadd=
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

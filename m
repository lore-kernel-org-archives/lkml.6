Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681251-2-10118921055442033976
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
    t=1517681250; b=p3c8AKEIjSveL/mInVa1lHBwUVpX+ucDa7Yzu+DHBLgW9cS
    kfTu93wPKK0Enm2YYkkUJ51VPd9NFPEGS0BixVed7/0Qcnq4kNafQuuc6E+yuADT
    iW040z0+anLmrn752/W7ntoVoWR0CR0+coEz6Zf48wrWq3EzdB0kpMRDf8HTSGRO
    Y5jdT8GadA60sGmsiJdXAfh163xQZ9TaWgeiDtcB9NWeRCY3iC4JX20zvnXQueih
    Sz59OgpyufomATROTEhb8+J4G+0HIMdn9tE+Smms3AnDULVjINF97q8GAzmZpmQ9
    gg/j/4V2MzhzFLzRo6wkLi6P8MLuETh8v7hTtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681250; bh=vBJo09
    bWPccDUqvDPAU/dgrJ0+DrvIrriVUgSbnFExM=; b=aMFVsuFVvviGlwyIh7bC4O
    z+bigyZHlC/zYtEKuZn/WW9rqvoZcXn7qdZiexz+H2CDqwvBg1WtG6aljNVraodi
    e48pnYiSghGO8NtWiYeauhAq8R5qSsA/935OEdx1Im8INyt9IpeKxbjkdliU+xCt
    KJKivEZiQ2kDhg1tFlPY2SIVgLMA349Uk6nG2cydZjPGLqPWndZbkE0HaM7pbCR/
    ZQu/+Yk6HgWnVUnVcThRJ+TUYZItD3qSOODX2O/pcv80E95YbnOx2f6uAZ0roekT
    9DyYyTn+/RakaWzRdli9H0PpBYDdM04+bFJ+AUwZpREu/AY9OyLRFs87a+cSnOfQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PSQ+YlTH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PSQ+YlTH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeBCSHU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:20 -0500
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:50832
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753374AbeBCSF1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:27 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 33/52] IB/ipoib: Fix race condition in neigh
 creation
Thread-Topic: [PATCH AUTOSEL for 4.9 33/52] IB/ipoib: Fix race condition in
 neigh creation
Thread-Index: AQHTnRlZhMiO0d5kr02AAT2UJsG3Wg==
Date: Sat, 3 Feb 2018 18:03:52 +0000
Message-ID: <20180203180303.8490-33-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;6:rCB+kAqIF/hS776sula3FiPuSbTYmjIEcBfra+GD/OAZJsg1+x4DkFIy53S7BWnMDlR44WAqjxTtEcmUxIdOFxfIN34qsTbOLQJfa/Ppq34wfKzOfKpGCk9p3IWOYhEm5XhiTTwvpG53DtNrjfTJUFLVJEGLg8tCM79MToEJLQRvARF+xjVTlz4CfboRWn4QNUZKDfP3g/k7BQPpyWasUcch3DICSDbWX20Of/OL4UP66sXqFv8TqC/8rZqQFk6DqoK15hdrF94rD8A8qnOJnmMDhGyE2OtY65Wq+Z81K++YPdYQG7tOobV7lEcumnVIcF4pb6Ldj8K/a2Gnv4UvdCBw+QUOwrY+VLyJl1f4aTpyKLVns2HRP84aqLHYF+Zk;5:5JoTy/k3O88ICKV5ldVPihoIBcJOo9HxmuFlVaKln27a9iyYv/0XwvmSCvpCiG6QacralI34TuO+2kb+Wo1uJo8WxFM6Eez6euTUP+JFzCB7YyF0x/CVldOWr8lsy2Vo7Tet0ae6dEbM0sRTPDC5B24RMdUdZQ42yLt6gf8u88E=;24:T9H5L/ZfaDYnr7LKdpCplEckGS7tCreYL6bkGwRY9XOdVNR74wzgLC918t7oDM27r+ZIOjIPukywCau6YaixyUyUrJ2MOG4qTGNrbxzT+BQ=;7:flOzddKlo1ttbgfdIVxhUc9I1rfPwsWq/00lqBZaFf9Hc86uxKq4ss6HUYqIy/urgR8fMmolduv13NA8Jn3YYxTc7+7rEmioOPKr4nU2kL9eQOsCFuX2pSl4wwtpimtSdGBhEF7ILDU80z6wCC/vapv0XCPG05MavOpDScuQ5YBCkBbcepaskBySTrcHe9XR0uHRU5hBNa1mRVyeWoGj4ERYEV62/HeI+KzAjReoBS2kmtt1M0LN5Wa/TWtjYmIA
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9980921-d3c8-43e9-f130-08d56b309aa6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012EC5F94DBDC797B1FE487FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(6666003)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(575784001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: KYc0/r7AnB4uukF98qTREisyj28YZ1xvfbdGyu5FNXqVI6ZA/Kb//kq8IQoPdOodxbiQ2bCqBjTbZDnw7gIv5g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9980921-d3c8-43e9-f130-08d56b309aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:52.2214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
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
index 183db0cd849e..e37e918cb935 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -919,8 +919,8 @@ static int path_rec_start(struct net_device *dev,
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
@@ -933,7 +933,15 @@ static void neigh_add_path(struct sk_buff *skb, u8 *da=
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
@@ -971,7 +979,7 @@ static void neigh_add_path(struct sk_buff *skb, u8 *dad=
dr,
 			spin_unlock_irqrestore(&priv->lock, flags);
 			ipoib_send(dev, skb, path->ah, IPOIB_QPN(daddr));
 			ipoib_neigh_put(neigh);
-			return;
+			return NULL;
 		}
 	} else {
 		neigh->ah  =3D NULL;
@@ -988,7 +996,7 @@ static void neigh_add_path(struct sk_buff *skb, u8 *dad=
dr,
=20
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
-	return;
+	return NULL;
=20
 err_path:
 	ipoib_neigh_free(neigh);
@@ -998,6 +1006,8 @@ err_drop:
=20
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
+
+	return NULL;
 }
=20
 static void unicast_arp_send(struct sk_buff *skb, struct net_device *dev,
@@ -1103,8 +1113,9 @@ static int ipoib_start_xmit(struct sk_buff *skb, stru=
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
index fddff403d5d2..6b6826f3e446 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -818,7 +818,10 @@ void ipoib_mcast_send(struct net_device *dev, u8 *dadd=
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

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495094-2-14613146730869145047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521495093; b=pZys3PoO2OjB32gWdf7agZGQrp+HHFSnga7oNXsFLIuJDGe
    n8GyjZD8P+c1/cn3pABqGBFo+IaK+IDtBiL/F9sTph46xYM0OGMYVtsDcW/AoXx5
    riSdYMyCF6rMX5YIC+Wj7uzifWkvGpGJX8alOssxi/ETM5WwTf3/FbNZH6GgPfmx
    JjFKg66bqysxb8Z3dCMTrkG1np2eTc08OQ/uUmi6f+CyM7f9ffLcMgfk+PZnVPa/
    V9DY6czRfaTTFHVr0zqmHdn20qUr4eAMtBpPYM71DZwDHkLNPZ2EiV98yoBuJuBI
    bPSDDaF6ssgYZQlyWuJw5TxSX/ih0Daj3tnmQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495093; bh=HSf9Yg
    HepUFvPh3xnFsGHTcUaW1PePALp0vV75PUwUo=; b=eOehQ349Phxpr6/SiVFOSb
    o+IgwlpvWVbZ9hNOxhJqXyLwCw6nBDLPd4UEKkyCMgLfTNcw+FkopMOC0AwnS5yl
    9fZTOXG8DfMtD9S1nd0hcXNEuEzkOHV0QRVRM56/iT2CHxudu4iOLm7l70pBh/4C
    h5gqBennJQtEQjCDbUwYwqUtT9uf+12O/KXlIzHqZk1/WQKQRjt6nzUCeDoww6dn
    lBhJCPoU8MgocvdIK3qqO92JRF9baAE8XtONDKh+mM3BwhezyPONqNtNwyKFS27I
    VgaySf1Bv1f6vxBRsIasjZiUYlWzseoC14W9GqJMl2VEdAC11lpGp+BWciXL2uvw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ahgwX+R6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekheejtdenucevlhhushhtvghrufhiiigvpedvie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ahgwX+R6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekheejtdenucevlhhushhtvghrufhiiigvpedvie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965206AbeCSQAC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:00:02 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:43648
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965079AbeCSP74 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>,
        David Ahern <dsa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        roopa <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 061/281] ipmr: vrf: Find VIFs using the actual
 device
Thread-Topic: [PATCH AUTOSEL for 4.9 061/281] ipmr: vrf: Find VIFs using the
 actual device
Thread-Index: AQHTv5symQHLRs6YlEatAwr+z9Lcvw==
Date: Mon, 19 Mar 2018 15:59:01 +0000
Message-ID: <20180319155742.13731-61-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:3aX10VfBdZyVjj1CiT0vhTHDGd3aNzkR7QZfAutE+y/h8cdcPEx5/PMTXZavmW9KDPb6YMEBXNDEG5WxopSEEyKytjE9bW61qfjOZQh6C4FG+MOnCF73xcYyyYD4EcAF4+GLt4S1uxCyt7NBb+FHfBAUMp0TuVsa0vI9wyRmdfJWiIV9VnTsQI7DpaeKh9cvdoKwXQvytrqJMBvy3H6Kly2xw3YGS4mxuSinzSR47iSorXBeSPYTTMx1H8d/Jjqc;20:QAJWYT0jCgAvYUprSNIcTUPFPSMFJi0pNES3c2TC7tQLcL23NLGFpFK4C674Yscry+37dY5qwrdpp2KAMhGk1tIqkiYh+oMrESMbFVEfrTkERzn0abIKovTiQuF78KUSMargTdszgNXkqcrgHaFm4rX1K4pjpgqNpIAkyyBb2EI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8855f867-ebf5-4baa-e333-08d58db274a1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09650423FF122D98DDF43E8EFBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Zx9eHsjSn1eSQDWEK1KoXRUhvgi0zgMODSHOsBhFnrfp/WWcQ8YCmCjMJpkM4A40Dc5zlcZ0+sL2Y5T2TSetYx/TKTXtPb9Xf1myrbGvrSivpr0FAfYni5kwrEJM2xqCSBznG0TBOpgjtCFInZhxlljkdeFkYjx9yExPYjoMyl5u7ozZufq7DgDw/dQlr1SOjSdZD0WLcaV8Ed4XdWQomRZqlLMhDz/I9tnxzAZx3bCyRICp/+XCNmYELI95yx1uTbZuprBbpAK9erNWeJOyNylCYgd1WNQVd6vKHQq/2BichuhSjIZ8uc7GfC8VNkNHrGW/r/uy0lFNtYDjvDPHlg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8855f867-ebf5-4baa-e333-08d58db274a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:01.4932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>

[ Upstream commit bcfc7d33110b0f33069d74138eeb7ca9acbb3c85 ]

The skb->dev that is passed into ip_mr_input is
the loX device for VRFs. When we lookup a vif
for this dev, none is found as we do not create
vifs for loopbacks. Instead lookup a vif for the
actual device that the packet was received on,
eg the vlan.

Signed-off-by: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
cc: David Ahern <dsa@cumulusnetworks.com>
cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
cc: roopa <roopa@cumulusnetworks.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/ipmr.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 27089f5ebbb1..742a3432c3ea 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1929,6 +1929,20 @@ int ip_mr_input(struct sk_buff *skb)
 	struct net *net =3D dev_net(skb->dev);
 	int local =3D skb_rtable(skb)->rt_flags & RTCF_LOCAL;
 	struct mr_table *mrt;
+	struct net_device *dev;
+
+	/* skb->dev passed in is the loX master dev for vrfs.
+	 * As there are no vifs associated with loopback devices,
+	 * get the proper interface that does have a vif associated with it.
+	 */
+	dev =3D skb->dev;
+	if (netif_is_l3_master(skb->dev)) {
+		dev =3D dev_get_by_index_rcu(net, IPCB(skb)->iif);
+		if (!dev) {
+			kfree_skb(skb);
+			return -ENODEV;
+		}
+	}
=20
 	/* Packet is looped back after forward, it should not be
 	 * forwarded second time, but still can be delivered locally.
@@ -1966,7 +1980,7 @@ int ip_mr_input(struct sk_buff *skb)
 	/* already under rcu_read_lock() */
 	cache =3D ipmr_cache_find(mrt, ip_hdr(skb)->saddr, ip_hdr(skb)->daddr);
 	if (!cache) {
-		int vif =3D ipmr_find_vif(mrt, skb->dev);
+		int vif =3D ipmr_find_vif(mrt, dev);
=20
 		if (vif >=3D 0)
 			cache =3D ipmr_cache_find_any(mrt, ip_hdr(skb)->daddr,
@@ -1986,7 +2000,7 @@ int ip_mr_input(struct sk_buff *skb)
 		}
=20
 		read_lock(&mrt_lock);
-		vif =3D ipmr_find_vif(mrt, skb->dev);
+		vif =3D ipmr_find_vif(mrt, dev);
 		if (vif >=3D 0) {
 			int err2 =3D ipmr_cache_unresolved(mrt, vif, skb);
 			read_unlock(&mrt_lock);
--=20
2.14.1

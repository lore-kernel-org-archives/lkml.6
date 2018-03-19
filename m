Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521499066-2-11258818540862793066
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
    t=1521499065; b=YORU4GUI3IR+x22BvryPVBJf2rkgcoxkrXwvgqUT6sgz3+Q
    3gFLV1Mrjf2056N1y1pSahIqBl0l8Ssqx9nJnivfUlDkwVISP5xpMOmFjYBw41mt
    R6h/MiRg67dpo1fyvfFmhvNOsvl5LARJMgz/D3xw79X3U78qjhUXiDa3TEh9QH4b
    +RMAMVmKqp0hR/n+W5Bsz+wY/moLvgev2JA3Oxsc9TrcC48VtpvKKc5y9JE5UO2F
    ZaM6Pp2FzsQnhDD7fMjI/4QkcXO3OjO9d/nC7prKWqFZqNWCyWW07G05C/KEOBlC
    1MFz1zvLSfPLfWq3Mz9dN77LMww0nF+WgrL1c9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499065; bh=Wmildu
    hO5Lr/xhZJUKYzNXPdz+do/8gEWwqKZjtvDGc=; b=g+OJiBH5UMKMfU7h3zDJOh
    OmN+dVxCIUrBoaUZutjapv6n6aquSop07ke9dM55rDZAAaiEJj/tJmERLZn0wmm3
    7wmyKn081sex3J5X4o9irh6I2tpM2D+r1Ce3TLiNbEt40WXFne+41w/zeuYbGp2U
    ZEd5O9mszyPjLtmj4kE4IqSn4T0E7/NIwkOo8L/QS49boXj93P8P9+l/uz5XV8yP
    3BYvefC4Kg/9EHXPY0458y2efHI/wBPGtFXfxJGH/FIvDQQnWlRdvlGrsq/bvHfi
    0vZjc+nXrAS8Nd/elJcSHy4aAJUmzWPHJGTtlQi5lFNqJhnceb1Y01Qjven359Bw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DGA9KNRA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtieenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DGA9KNRA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtieenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933713AbeCSWgy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:36:54 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:61852
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933475AbeCSPrj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nogah Frankel <nogahf@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 028/124] net_sch: red: Fix the new offload
 indication
Thread-Topic: [PATCH AUTOSEL for 4.15 028/124] net_sch: red: Fix the new
 offload indication
Thread-Index: AQHTv5mVOCWwk/zA3k2VvMqw+YHN+Q==
Date: Mon, 19 Mar 2018 15:47:27 +0000
Message-ID: <20180319154645.11350-28-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:szgAN3X2h5wzyFW6P2EoFh0hiGWNaok9SwKLq02o679GzrN1sPWy0aHchIL5cytiToMxRjWIhlTmYJJyDDuKlSSJOJ7efhYQ+A431gE/sCBKOlUS0a9E8SBEM/17+C8/aw/9MxAsc3kxnSYd6quH+YUr6zTYC5tvRxoEPVOWOigvZGw28cFo/79h/s0Xo7d7Av2myn2oU+4YWTetwtKbv5D+hH+F8z6IgQ+dhzGByIzDmRp89Hi5LqxbpZxj7j+D;20:SrHSTfQPIsfDMisF5yLfmkXOtgllk4Bn5PdetHbTw5EwFCfob1rkjtETcikFHmloib1cijU8nsUtQhK6zxzqht/1j0FN2pzs8u4grCFpPGY5uZqbZ0fkkIgRO78LunPFs7bQLKu59NsH2Uu1O+nwgAZsS3KGKwNl4NdOCFirk5U=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b40aab72-b366-4bbd-5cf4-08d58db0b90c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998A5DBC0CC45315A94C094FBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: aNAiyHbaK6WP7tk+G3xbMj+klZdkNToK3lIbby/hGHDFkiwYPHFhauO2433uq3AMXlF+m222nPqwDhIy4ky+iAeDTBPi4T7s9bGOP0Zx97hrEux1XhTBv2u+DC/H1RPJ975jVMxinm2xgsYxeyhdi1eoUSMwqYxhitErCE8Amtlr+XQiSuRgOk2MYvY1LIUXF6nixylOOrSwTFQvyDwRgiN3tZ9IN4bgGSvWIyvGufn7ihaD5Eoep0bZsIEWBj5zJmMp7HlWsbKafUScNkzbB7hJltRJz0wcXf3OFTLFxZog/ffZgzwMN2BlLREmB859uF7t8/08A3I28tE23sMjPg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40aab72-b366-4bbd-5cf4-08d58db0b90c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:27.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nogah Frankel <nogahf@mellanox.com>

[ Upstream commit 8234af2db3614d78b49e77ef46ea8cfab6586568 ]

Update the offload flag, TCQ_F_OFFLOADED, in each dump call (and ignore
the offloading function return value in relation to this flag).
This is done because a qdisc is being initialized, and therefore offloaded
before being grafted. Since the ability of the driver to offload the qdisc
depends on its location, a qdisc can be offloaded and un-offloaded by graft
calls, that doesn't effect the qdisc itself.

Fixes: 428a68af3a7c ("net: sched: Move to new offload indication in RED"
Signed-off-by: Nogah Frankel <nogahf@mellanox.com>
Reviewed-by: Yuval Mintz <yuvalm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sched/sch_red.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index f0747eb87dc4..cca57e93a810 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -157,7 +157,6 @@ static int red_offload(struct Qdisc *sch, bool enable)
 		.handle =3D sch->handle,
 		.parent =3D sch->parent,
 	};
-	int err;
=20
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return -EOPNOTSUPP;
@@ -172,14 +171,7 @@ static int red_offload(struct Qdisc *sch, bool enable)
 		opt.command =3D TC_RED_DESTROY;
 	}
=20
-	err =3D dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
-
-	if (!err && enable)
-		sch->flags |=3D TCQ_F_OFFLOADED;
-	else
-		sch->flags &=3D ~TCQ_F_OFFLOADED;
-
-	return err;
+	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
 }
=20
 static void red_destroy(struct Qdisc *sch)
@@ -294,12 +286,22 @@ static int red_dump_offload_stats(struct Qdisc *sch, =
struct tc_red_qopt *opt)
 			.stats.qstats =3D &sch->qstats,
 		},
 	};
+	int err;
+
+	sch->flags &=3D ~TCQ_F_OFFLOADED;
=20
-	if (!(sch->flags & TCQ_F_OFFLOADED))
+	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
+		return 0;
+
+	err =3D dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED,
+					    &hw_stats);
+	if (err =3D=3D -EOPNOTSUPP)
 		return 0;
=20
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED,
-					     &hw_stats);
+	if (!err)
+		sch->flags |=3D TCQ_F_OFFLOADED;
+
+	return err;
 }
=20
 static int red_dump(struct Qdisc *sch, struct sk_buff *skb)
--=20
2.14.1

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498528-2-4001668467979329994
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
    t=1521498525; b=dVkrSFmBBJlXN4Xy8UqtjP6NnD9skJ4MdoYeCAkKIeGTLy0
    LSrWa9p33Zn9mhkjjnwAbkQjmQ3rB0/INGgkDP0rcQOmbAK8DnFs3kY+LfY7W5Uo
    mvnaqrndSS1uRtYaHQpJMd/DohR53GTHg3ahCERPfgMhJA+JeVyGW6dNtExR4Ehv
    sQcwgDjnCcIBTrXJheXIxP2iuOzV2IVkb3ny4vRrS2zHkKRaMVnmTgIAgEVQjgOC
    AbovjylOdb+PrEtv5nwlQJXYEE9A0t7DiSWT32sam275JjD0z02kuV2Drwbm1OEp
    RBigSTkipg4SR/1/7H0j2vd8nk/Hfq4VaqoBVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498525; bh=v4Iohq
    qvswwGGChZ0ypfxilgvrBcG4JuenKfKq9fi7Q=; b=dreAOmsVRhHIgTCS2cgWWO
    sBvn0dtPTfdXf1GOxSDGAc+vSavn97cNWGTol5gYLUl33pjyCRUnB0+lpOy37iZ5
    UXlpElRI2vRBM/MjMarm8nz9bz4PCaTXFXM/q1hQAkEyHF1jFm0M7duvkiOGZj/J
    VV9AxbmOWG3V1OF5dUGzEokeFxGRVU+wxh71GOYnphcCl42a77tPxksulFeGC8Gx
    CHffw+KhbMwaSS9ums7lF3ozhHCOaNs6WYqHSDsQyrCMJNoudvGxp3WuggEGZzkD
    Y8eMoeJHqC5InijCy1h6f5S6L449U8/vvp3w/jaaAZzIpsZR4UsKozvLg1Py5zrw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cy0RKD5Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdefkeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cy0RKD5Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdefkeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbeCSW2m (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:28:42 -0400
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:16179
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933810AbeCSPsr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 058/124] ipv6: Set nexthop flags during route
 creation
Thread-Topic: [PATCH AUTOSEL for 4.15 058/124] ipv6: Set nexthop flags during
 route creation
Thread-Index: AQHTv5mo//FsBdCFtkuOTa0rN5EV2A==
Date: Mon, 19 Mar 2018 15:48:00 +0000
Message-ID: <20180319154645.11350-58-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:QnCsqq4oBvcFcuXiQCKGWzoim0cOvptN2Sgh6RFCDcGnIVsc43u4KPCT5fz2U23QU8KAZR4xOIDE/bycF/t2TBfZlsATI34DQLVUi8znVaGqGYWhN0UjMxNde+SyZ3T4/0OyMLPDgFGUTEXnH9Sbwpi5P4Mayk0tf8UlFoXpwVkxVBrUxGi4B5skdL1wobBUPdaBOX4Z3I+XHrA0ybm5XwEiD3ZyMRCg3+VTPv99okE0MEsFwAMlgbyjgnw1t6sz;20:FUOdPDVRsCMYH+FqLjQLUaTMX2s7L96pHfoyA+iAPmRNOLLeesVXGRv2I99c1rfEtiv6A5rNSRoJtSudhjj7sdl6dFypvmc6Q9V+Se1Davn5Xx4/d4b8aVP76f+ClzmjJelOlNwdm7bYr98bPg2nlS/BK7jYy6/yWXZMG2i0lp8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8c7a211-5fd0-4af8-fb62-08d58db0d52c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031ABC17CBE5EA147C39724FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(86362001)(53936002)(107886003)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: PVFUZDB1qTi+bVWzQMXRBb9TixnaZTKPg8hKS5xZwAWeJFqIxzoKy2LM91ZgpF5ZObiFmT5agYTbY0fUJ2vVRhf7SK1u1iGCMTm6BlajqTBciBZ+OQnuGKJ9h/87gddnP3wT+Kj1ZQwYDfid1cVrSP/iph7AN41B8RAEvU/IkcYW4pYiANs5PW1db8JIHyHo+kPYB4AMrevPSBBpLHnCwtFvMwzd8CIc08Fu5kWSN0O1d1JE0KMyIOcOySdTYFKP6kHt5yAnoEBtO2f2StRXGgQafKdEMqNl5svZxm6id4iIbl0TeEdF5iOY1ZukvLCQ9QZTkTWbwOTLEIPH9mtUuQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c7a211-5fd0-4af8-fb62-08d58db0d52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:00.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 5609b80a37f69f796548339e675256188b29c17d ]

It is valid to install routes with a nexthop device that does not have a
carrier, so we need to make sure they're marked accordingly.

As explained in the previous patch, host and anycast routes are never
marked with the 'linkdown' flag.

Note that reject routes are unaffected, as these use the loopback device
which always has a carrier.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/route.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a560fb1d0230..b2d6377f1ef5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2750,6 +2750,9 @@ static struct rt6_info *ip6_route_info_create(struct =
fib6_config *cfg,
 	rt->rt6i_flags =3D cfg->fc_flags;
=20
 install_route:
+	if (!(rt->rt6i_flags & (RTF_LOCAL | RTF_ANYCAST)) &&
+	    !netif_carrier_ok(dev))
+		rt->rt6i_nh_flags |=3D RTNH_F_LINKDOWN;
 	rt->dst.dev =3D dev;
 	rt->rt6i_idev =3D idev;
 	rt->rt6i_table =3D table;
--=20
2.14.1

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497031-2-16219294486478546989
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
    t=1521497031; b=J9zHG5p0u53TS+rPPu0DLX1v5INEVZc36E8ZjBUSiVbpaXv
    ESfHd7AxJX6/6YSmfJ/s6Lr9UaKpAiEDrpESfocS0SsfXE2qXbXHFEqcv9UzKMUe
    Xpfa2V31jv5cSU50cGBxCYGMeaod2By251rDc6ic1cPh9VwHKFKorCtmqpEAA6En
    jG1AvqNqIhZ4tsP81KVzZ6eZkAFgDYqsRpuxKjgO7Kpj4u5pgfZ8+lc6Hqv69I6X
    7yMjkbk/DV9BRFg/nps/nqZGYj6DL7XyJ+sisVRyGRnfQ7FZaSFZ8OShYZotJrc4
    LP6iYtw3ok67PvSnt+6cHZ7A7hLhscJADMT80pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497031; bh=y9xVw+
    WDyc+IoDrNqSsstQN4O4+UwPjmokASM5l0n/I=; b=VlrZ8X9cJ1nD8Qz8wvrG6U
    vPv+ZgT4ZObzM40Cel4UEZhKAEVi1UE53cxMelIvFnhxAwN4JmV63uQHVdECeHjJ
    t4ywAnOLJLQRlPThkcIVJEa+O/eZzEIGerBO5RTodR9Afe6drpNcDNe6dNyB/gx1
    fahfOh4nq2H47RXvS4sEyrC1LGpVczWjrqybAul9n5nyj3XUIuiZZoULM+5htkfu
    vJvvvfNSyE7yCdcpP07hFtB02LRzFRD2sy7z24WoI3bz8aq66XCitPdZjoYm8yPF
    c4NfPikfRyvn4RcF0FfK/ZeTeS9l8U9F7rzIVakCPERLTySme4R2YgC5YuQLl6bA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zv6VbscS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdefgeenucevlhhushhtvghrufhiiigvpeeiie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zv6VbscS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdefgeenucevlhhushhtvghrufhiiigvpeeiie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936284AbeCSWDF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:03:05 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:43956
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934186AbeCSPzz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 44/97] ipv6: Set nexthop flags during route
 creation
Thread-Topic: [PATCH AUTOSEL for 4.14 44/97] ipv6: Set nexthop flags during
 route creation
Thread-Index: AQHTv5qvQA685S0X6kiC6Xs1KCADvw==
Date: Mon, 19 Mar 2018 15:55:22 +0000
Message-ID: <20180319155411.12348-44-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:Q4kDiXXr1apfAHAz2iwHhGSg2/qgmKygjNTy6TBVKooM9Vlc+lSe0qEvbt05yXJ8ScYb7vq3j4w4kkSPpcjWveu6S6cWYBDVwGNqShp4pRF+EcPamL5NZHe1BVYuTTwkGX0TvRxtxT207APPmJyeHo6YMB8e/GvctzN3uP8FxAglc1K35hTnTOwXSzgQxzd3GkdxbQ7Njrv5OE0RM1dpUjTVuomqVc+wySYtHAuaQGhEzu/CTW+S861g45Dn5cBL;20:SMEJM2K5+wp/eIj1U1VSQdr/ShEgRmiOql3bziZqQ7zplpTCT+L3padwkwoHRPBPpws53I/EAvcNyo/V1t3UE4SjqJV47KpYTIXy3AJANr450t4YuuMIb7K1MWyGKgZoZ8w9AEEbhq1i8uDFse0ZJcVthKdfafzn8WqfRd92KtY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c51c7e56-3435-442f-f933-08d58db1e0d7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09675637E8E2ADEAB33BD7DDFBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 28X6+ZQhhw/qyuqXtMyuz4vUSTm6JxnouGNLcDLLF8uOLp8DNu/KqgEAa8NN5WnkSfmtObqAiHQFxURazabqf9y88mu47MQHgC9O756fISqwpfkyN+m4c+5b4+y93IhK/skdqcoXBUg8JOYI/8q5Fe2mMthUTTGWwQbzIP2oMmB7Uao4UCY1UWyPKLpD2l9XroiXHrcYXkynY+DQUQHbBYjC4hw2M+klBSppsoP/KLuzbbQo4fzFfIeI19WMXntBB86fMrPrBY6A1GmPmIuPt4KKPItKskNT1uRZ+sM6X8q0i8yClBr1WCjOHEoSiPrH7CQBwvg0PeSDc83nOMg0Lg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51c7e56-3435-442f-f933-08d58db1e0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:22.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
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
index a4a865c8a23c..fa283eec92a3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2157,6 +2157,9 @@ static struct rt6_info *ip6_route_info_create(struct =
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

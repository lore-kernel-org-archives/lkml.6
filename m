Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480398-2-9871478110949051491
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
    t=1521480398; b=lJTLOOrtpfjiIoMSHkjiT5poYI2mhpxdy4fg8ZIBRwK6g7l
    8+pdUyYiQpurBSlggfi+gmDGDqFmUwgBI2o8xmAZBo2bjmIwDZu4+u55rT/Y/IIx
    f1U9iR9s6tTFNNQGelPBE0mYzwIumB3vr27jooOV3NC14z1RqLF7DfU0BqufpD//
    OaPRcCN/oX9qVcw2Rv80xRqZ7jRdPYBmAZHiG1shsBxsG5Cs+yZe/kR0tQUyqODW
    fZ73uEIsqtNbW9777kic9Rb4oNpZfaNCIjSwCMUIocXCaorfQHhHqAxQKT7wA8E/
    0iJAB1Gt8ul591gnz10WKxL2Y+NsyUzmUoblbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480398; bh=yhNeg8
    IerUxWh2xZJ/o/LYNY3c8LIUO3eceMvkN/Oo4=; b=GltCGxABkAdqa+ShJv8+l8
    99oXpy6KO0wYEHWjBtyyWXtl2i83jjhY1MnPG0KiYlH/mZJcOBGqMBFxQGOEt6ZY
    NwfFWlrtoViR2DaaZKL1qIx5XfjzIjnSfZ4AIFIFeuMmHlVPP2SziNADYnew5FSR
    KwiAzFje2pwSIi9byQav3aYOnE2IqmS5Z1QbogufMElQYtK6f4Z28rIf587Il+tp
    8Vi9gebY19jHkdEP+B1jwZQRiYaI2yGuLlDpI6HSi0At7GUAn+Lv7QZlN/HlYz6P
    kt4mNPSkxEo1V6ofPouxYDYAzdSTid97jiS45Dg6XfeGSuzqeIPH5X0eJgQncB2A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VCWsp7nq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeeftdenucevlhhushhtvghrufhiiigvpeehke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VCWsp7nq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeeftdenucevlhhushhtvghrufhiiigvpeehke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966313AbeCSR0d (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:26:33 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:15680
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966090AbeCSQIW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Antony Antony <antony@phenome.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 055/167] xfrm: fix state migration copy replay
 sequence numbers
Thread-Topic: [PATCH AUTOSEL for 4.4 055/167] xfrm: fix state migration copy
 replay sequence numbers
Thread-Index: AQHTv5w91+hkDBG2+E+QYWZgSASSfA==
Date: Mon, 19 Mar 2018 16:06:29 +0000
Message-ID: <20180319160513.16384-55-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:CGuXCX+xPFRYwh9I3nzJ2TpndKVQdyudJ0jYU85FFlRgFJac/HNkuK1bnw0Rli7Cae7msMdzPUjhYongSo47nRAPVabj2jxXO9O5YaG6CHW5pkz93xgLax6nB7e0i8rm3Fe6i/GZF1ufneUqueqlmTnrZ8lXhD+so2F6jCEdiLkitqToHVLEp3Lzez562IF/AaI8oyh274TxfwK8/RbX/rxkQ/Mlbkb2xBlKUH2cyNEUUIDqcR5hKTZy8w0X7DBC;20:SZTKuAKjRuTM6Mj1EUuncdIyly3qdfXGS9LpFpa+XkBzh2ULfnklrLiy5vPTw2WcXKlhw2xeuGuIbPuiMgtJVWlnxq+rHBOmB7XIeauwahh0LZZ1AOgoIiT0KooRe+3r89NUjfA75Q11vv0WIaYt7Z1hYmLmnJuRG+0JS3m7qw4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 989a8220-2740-42bc-2484-08d58db3a2ca
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805EE6CBE9007B21545F9A4FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 98NvqeP3EmgjIJYRhFvcGqLiisb1wGgShiJnMm41oHwwZp7yYx52LmWwbi78RXuYFUJp3Dz5SqNfieb/OKRE0i9Z1uZXlF3oOTXG2mH18mzP8eyCVnW/TKUC9nz+CMbst01oBEsEy9mAblfQuOm9i2wImaNk0M+0/nzm1EFCFQzTufXAWwI5OGRF7OWTo+UgP1cgLLSKweIIZIT/IqWh+GWgPcg8e3JSp5XApn3Q/1EA/P/Swyn3FjQZITlUalQ1EpkSpUExzt76ZbgDaWdoiX5onc0lGCABEqd2dCBWMvru6aSPUQumVi+aa0VNMmVQVR4ioQeKRvG8jJReM44ULQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989a8220-2740-42bc-2484-08d58db3a2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:29.3819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Antony Antony <antony@phenome.org>

[ Upstream commit a486cd23661c9387fb076c3f6ae8b2aa9d20d54a ]

During xfrm migration copy replay and preplay sequence numbers
from the previous state.

Here is a tcpdump output showing the problem.
10.0.10.46 is running vanilla kernel, is the IKE/IPsec responder.
After the migration it sent wrong sequence number, reset to 1.
The migration is from 10.0.0.52 to 10.0.0.53.

IP 10.0.0.52.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=3D0x43ef462d,seq=3D=
0x7cf), length 136
IP 10.0.10.46.4500 > 10.0.0.52.4500: UDP-encap: ESP(spi=3D0xca1c282d,seq=3D=
0x7cf), length 136
IP 10.0.0.52.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=3D0x43ef462d,seq=3D=
0x7d0), length 136
IP 10.0.10.46.4500 > 10.0.0.52.4500: UDP-encap: ESP(spi=3D0xca1c282d,seq=3D=
0x7d0), length 136

IP 10.0.0.53.4500 > 10.0.10.46.4500: NONESP-encap: isakmp: child_sa  inf2[I=
]
IP 10.0.10.46.4500 > 10.0.0.53.4500: NONESP-encap: isakmp: child_sa  inf2[R=
]
IP 10.0.0.53.4500 > 10.0.10.46.4500: NONESP-encap: isakmp: child_sa  inf2[I=
]
IP 10.0.10.46.4500 > 10.0.0.53.4500: NONESP-encap: isakmp: child_sa  inf2[R=
]

IP 10.0.0.53.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=3D0x43ef462d,seq=3D=
0x7d1), length 136

NOTE: next sequence is wrong 0x1

IP 10.0.10.46.4500 > 10.0.0.53.4500: UDP-encap: ESP(spi=3D0xca1c282d,seq=3D=
0x1), length 136
IP 10.0.0.53.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=3D0x43ef462d,seq=3D=
0x7d2), length 136
IP 10.0.10.46.4500 > 10.0.0.53.4500: UDP-encap: ESP(spi=3D0xca1c282d,seq=3D=
0x2), length 136

Signed-off-by: Antony Antony <antony@phenome.org>
Reviewed-by: Richard Guy Briggs <rgb@tricolour.ca>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/xfrm/xfrm_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9895a8c56d8c..2cfa8105c437 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1208,6 +1208,8 @@ static struct xfrm_state *xfrm_state_clone(struct xfr=
m_state *orig)
 	x->curlft.add_time =3D orig->curlft.add_time;
 	x->km.state =3D orig->km.state;
 	x->km.seq =3D orig->km.seq;
+	x->replay =3D orig->replay;
+	x->preplay =3D orig->preplay;
=20
 	return x;
=20
--=20
2.14.1

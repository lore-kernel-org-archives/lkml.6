Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521494878-2-3169118959353438187
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
    t=1521494878; b=Z6CYsO1O2MqQArW7jGKZBPdp/wBvwsWLQGgTaSSWFnfWjS4
    S8Djxge6dIIUi75Rb8PgrkOoctyONet9mxN+rd+Z9aBFMx1IZI4Zef9RQoXfd+mX
    ht05E8l0cd2SJ4rewLD/D/2CM84eCvs9QSeUCpAh/GTajj4np5/har81UFE5SETF
    RljKpqopFVuR+MO9NkTIbl4+siRGrNyduD2dT5ru8PWwnUeUT8rJuiABGW0ultuG
    00zQf0htqtzVd5vhryOIBfn6imQyj6yD7+p6EDsZBHCL/AR5tJX3pfRIkRI+yR6k
    qs84jh9w/E1PrpOmh3mvXtyjN0rjDs+xmEi9dPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494878; bh=dn79HS
    H1rxs5ZWo5dqi01h+nlaHHub1/p2/9m6Y6PtQ=; b=tNPea9cxILbVIHdbEBQZ6K
    /AA8X33NfZkKtA9e3Ls2eeTz6IbQAWVFfvHicbCFOxrsQDwFQfZLDu+eQ54NSazj
    0p9mMlJ1Iv3jf+/0p7EOn528ZuWGkCqCVlTDuqXrt0YuwXUkZehgHS2CTAoEPuYH
    GOCquKqMR2zggk21d+u0zXcel+yzjB8hwy6xov1vL1sqiNdW2KjGvmAKiUP4uppa
    vFj1AQAt+QpZSBcLUolU3Rt0dqC4dzgkN8Eea68hsLpF9JnJS3cqO8zYK2t3VbQG
    KKNS+L5US/hZSuIXPlbadL7OFmTmI3xh/g+btiM0fR/xIkW1Lrav5t4T9KhJhQHw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CuN8F7LB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeefleenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CuN8F7LB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeefleenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032339AbeCSV14 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:27:56 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:56553
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934798AbeCSQAM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Antony Antony <antony@phenome.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 082/281] xfrm: fix state migration copy replay
 sequence numbers
Thread-Topic: [PATCH AUTOSEL for 4.9 082/281] xfrm: fix state migration copy
 replay sequence numbers
Thread-Index: AQHTv5tDa/i20VjxmUGcHQ5JQWmtmg==
Date: Mon, 19 Mar 2018 15:59:29 +0000
Message-ID: <20180319155742.13731-82-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:42gASwFRYyAesAw/JYaf0iPTU0Gm0gpC4dw5nUMJO7RaFdxXP+bZye3aYAMNvPvCxJahyY7nxdMCAz0T7XCeNJYJRDAIL3SuTs/RiJJQZD6GhImGlkagbuqxjxjV5UeF5c3DRBD7do2cT3QeWbV4bPeGAItd30V+pixV3ssgPmznK86bul3+uuWHrULYcsNL71l2/D28YC6ng29E0Nd0zKjgJpBJo6wAe+p242oQkpSabvYXC9Uif0sqAHf54z8I;20:dxRm/A3LtsPgFIlYkNh+eC9xfkIYOnZsQVlfmzpFIX0jKe3SVkMTFdmoCiWy7PESg0hNFEQHw8rJBhOs/x6eECZanDdDUHGt20bbv/aBgJxlo6gYs4dIF/bGL1u0UVs2rTrGlRHYRyzeZv32kOiCzrol79d4d5XWlzIZTdPWF9c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a8fb5c4-dc40-47a2-d306-08d58db27b0f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09841901B660789B760426D6FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(6116002)(25786009)(6486002)(97736004)(1076002)(4326008)(2950100002)(6666003)(66066001)(3846002)(36756003)(81166006)(8676002)(6436002)(106356001)(8936002)(81156014)(2900100001)(105586002)(5250100002)(2501003)(305945005)(7736002)(10090500001)(5660300001)(14454004)(54906003)(68736007)(99286004)(26005)(186003)(6506007)(3280700002)(478600001)(3660700001)(86362001)(107886003)(10290500003)(6512007)(86612001)(72206003)(53936002)(76176011)(316002)(22452003)(102836004)(110136005)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lvxPcg8c/p+s0PfYF533Cg87/rWsKY/CD8epSou481klmw6LfUypHx04QWRa3q2UStOF1MYFrXMLyQ2uWcVb5MgGZITYVBAUYUyUvBpOQorYALdiiZTNlRfiL09BKSMSLAvMGWvHAA0WIjwrzvXONqTuE9nApnrE6nkDqondd/gKF3UBji9HZTHqXgbqcDEhq3LWIgdypVdl5iJeYtrc2I79tMZIBlOFndFiv0jHlSNSlw9g9FPlow+IxzlLyr5kybdHmopPQRhoQHb/qM13g0nXk8ZBue+BvfjZQltGYcGEFFq7JyB5yfph521PyabMzLaWog6KE104vWZd3EBZeg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8fb5c4-dc40-47a2-d306-08d58db27b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:29.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index 419bf5d463bd..125282916f55 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1246,6 +1246,8 @@ static struct xfrm_state *xfrm_state_clone(struct xfr=
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

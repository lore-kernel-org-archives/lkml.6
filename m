Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497392-2-9495027506449037869
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
    t=1521497391; b=tTWNcQvbTOMXcA5tACFgFE5xr7tjhYssnFVVckySa5CyBCd
    UaR7Ic6JvIpxzIYiPdiwqvhLywfYfwwZ0MnsOAAtKYlektDz5sS+ZD+do9xG6qFS
    71o5i76IXyfBrmh3/gDTFCMvCszHOtYkPaQUQoa0J1K9CuKx1iQ98fHp6ybW7Ztg
    PHzvbXf2ZsAIItYwSGixYtYnh/suT60RsS7/oFu5gWFU5YzqLEIcSaYURXHk1keI
    s7+GMWLpGYjhV3Tb1egdZtqhYk02ukwb1B7clZQq5XFKjxPT3yNALrR5H6rUD5zq
    OkVMCmztLV9ldUD7oecqHQdgGLsasorez/fOCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497391; bh=zBC8z+
    /B/sFF04WY9iI9bllUv3+hbaKS8yz3NJq+tUs=; b=CiZI5uZ7npB0rEBSugir+g
    ZNX+eINfBGYtqYgFOMkQ4+ra4EVcDAROaEYzm2TPOaE0f59FMm+Tins/9SWBWXZB
    ccqtUPK50VbgEJRnmpbniRMDayoONrKwrXBJQfpQOt/7oQKboUEMji7rhr9ZTe9X
    BeVo9IYO0Y1TT+REbN5zR0LGdcDCjJ+35aL4wWYV5W+uEZ7leNIxN+0YWqNcDo4H
    6dJ9UIr3WH+eM6IUQpWgfJp4iy3ZcJwcw6gJzA0f8VOlrYILpp5ggSAXGX+GPsEu
    WB1iwEWZ4ScaUzYck2pFOktpciF/VbTkeI3TorG4kdmKk6qhKVzqrYP9mzb3j4HA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OwnRDdlE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedtieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OwnRDdlE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedtieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972257AbeCSWJF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:09:05 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:51100
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934324AbeCSPyy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 21/97] clk: sunxi-ng: fix the A64/H5 clock
 description of DE2 CCU
Thread-Topic: [PATCH AUTOSEL for 4.14 21/97] clk: sunxi-ng: fix the A64/H5
 clock description of DE2 CCU
Thread-Index: AQHTv5qdl6P6FzNJvEe9sMa6QzdPMA==
Date: Mon, 19 Mar 2018 15:54:52 +0000
Message-ID: <20180319155411.12348-21-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:QgjOooPXepQYSUOGUG69yxOpcMkAcqG9JArqCrB0snVOvcG5S9X6+DOOi7BzmHgcr//htpbC6Eyl1Nbp42tK0GrUbXhABXXTNoagN6mpPAIZL4OM/7zzAzLpmwXQMU2WuFeF6QoV9eG6rSkTPApAYnGFXdW4y/NLziaAqZdstcXWvcudMcJVDjMo7CJJs+3b6YWBWshyyYvBmcLqf5O5DZ9hfy5OV0uBYPCUR+9DcuHQWf3HI2lzBz9jg+3+GcMt;20:mkLJCehpG8o1Ge2kzUAmjdr/pdSY9K8wFfbQzCn5m8wqN4Dh5su+oXM7q5/swLGkXdSE+vT7O6AxnM49O/GKu6U20W53Cpcj3Bs/4upCxwROwDyMl3qvZ9dbyiIkK18KIJjQI68DGIBzDxAUx9gZGMwTZwQJ36SLqsXwjsfKvws=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f553a908-b2be-40c3-e04f-08d58db1c0b9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09035BC47F0EE3F6874F8D09FBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(3660700001)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(8936002)(68736007)(6506007)(76176011)(14454004)(4326008)(2900100001)(3280700002)(25786009)(575784001)(86362001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: GWX9bZtC2OJNAcRcxOrdMcwtKh9KBAN/rkM+CzjHKt2A2MKES77GKt3GTgsR6oietv0BpqOQQplJEjaIiy17/M/CVnnE2FrBhAUsBKhla4bnG4xHs3TyCENMBAqkpp8INXbgwQTrHrzSNHJhsXC5tt96OvwCIEMYi2s0KCPGI2Y+9FJRbZHBsLbK3LLmT4EkBfEV8YYnc5SqW3hZBpCsFAUdlnOx0M8WUlGXiQQDWcSrbb2bLm4ene1vRE9tbZhOHY/sYqT55zMYb0cvvhoKhhoFeMpQK6rpbFdiRKpwUxT9yrzphf/sy5FTQI9qtOK/w3TM4Tz7Kk2KtzHbwjDiZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f553a908-b2be-40c3-e04f-08d58db1c0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:52.3577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Icenowy Zheng <icenowy@aosc.io>

[ Upstream commit cf4881c1293516c1975606e8f2af7948789168b8 ]

The clocks of A64/H5 SoCs in the DE2 CCU is the same as the clocks in H3
DE2 CCU rather than the A83T DE2 CCU (the parent of them is the DE
module clock).

Fix this by change the clock descriptions to use the clocks of H3.

Fixes: 763c5bd045b1 ("clk: sunxi-ng: add support for DE2 CCU")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/cc=
u-sun8i-de2.c
index 5cdaf52669e4..f0d9e5961496 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -129,10 +129,10 @@ static const struct sunxi_ccu_desc sun8i_a83t_de2_clk=
_desc =3D {
 };
=20
 static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc =3D {
-	.ccu_clks	=3D sun8i_a83t_de2_clks,
-	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_a83t_de2_clks),
+	.ccu_clks	=3D sun8i_h3_de2_clks,
+	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_h3_de2_clks),
=20
-	.hw_clks	=3D &sun8i_a83t_de2_hw_clks,
+	.hw_clks	=3D &sun8i_h3_de2_hw_clks,
=20
 	.resets		=3D sun50i_a64_de2_resets,
 	.num_resets	=3D ARRAY_SIZE(sun50i_a64_de2_resets),
--=20
2.14.1

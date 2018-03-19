Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521499138-2-10401534257805581375
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
    t=1521499137; b=QdgrglI7nUtizQ1xb5lqy4eli14x8kq1Wz8rOd3+AVl2fQv
    kwLfYZZmD7kk8QgZbjw9E90RuqYfYCTRL6+WOZUTRwWLtd0N9wglw3L2wDg308xt
    at0lNP61aGeGfj3T5xlff1S38+1KZ0sciD93qdWq8250Nek3a2swQkKlsHe/ANP5
    t2XJiaLkXN7bPTH4JSWR9ofJprPcltNrvXseaKb7mITfgqGlPvVrHb/lk59DzmwB
    INYzcTzaQtW37YLNbyGGiNfwDd7ZFcOgg3x6oipoN51DD5qPN/Mbt4VwAwq401z1
    IGtHmrITdsRZ0M2ZBrelqjKbsBgvNhpim5HDOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499137; bh=AgUsiX
    TvdVFwrrllBqwxyXzn1cDbVIJtuxAZ+QS7NBs=; b=d536mQw3wR8/1um1rt7221
    tDVXxC6tyogBwe1spIhanGvGnjNvKhsfcGr4eMyTm5Aof7aT6cwAF7XavFIcdC15
    y7zgdyGnA3Rj8gAY4apRGN/yh+l0fQzc83yhI6HwCsgbVdTQj8+DDHsB6zY3vk9l
    GoYhFXkDvZh3jU2qAC8r1R4zBVuJ29tnByU0BD2VRcANmAJOR0MI2wQ4v8evmru8
    C3EO4R8Tk/S1mSOpp8FWr+TM9Tw3ZPpenduTxUUk448hk1Ou0xBuYMR+S9fWsBxP
    tbq0rQ/vYBaTaZ/Xjh4t2g5jx6l5zIWMRigvJ2pxLhkQrh1/DJJz05VpUWOU7hHA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F67olH6l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeduvdenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F67olH6l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeduvdenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936597AbeCSWhs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:37:48 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:59200
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933450AbeCSPre (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 025/124] clk: sunxi-ng: fix the A64/H5 clock
 description of DE2 CCU
Thread-Topic: [PATCH AUTOSEL for 4.15 025/124] clk: sunxi-ng: fix the A64/H5
 clock description of DE2 CCU
Thread-Index: AQHTv5mTrcl5URsNMEuq9WipzPPlgw==
Date: Mon, 19 Mar 2018 15:47:24 +0000
Message-ID: <20180319154645.11350-25-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:uMFyfODJBNznwPwgkQVVEMucObIuSgIOnuJVA91Z3sXJhr4FvJ482mhCNWLl+BvNOsfqi2KKW33pU9RIEgB4yE67Q1Zs1sq3+ikTfmjP8jhSjjz4n+/8+WfdRIqMJ44u9Wgpi3dGlP4mTM1jnScy8HgijR++BhVYkwGI/CGbTdQCPsrS4DN5n3fDvG9oiPCJKAKOJE/Rc0coFCKtQ+yNUHAqPX9Q5bvT+hWGiEnNFeQEOOW79fOOX4Gw6BrZeSQf;20:pm+HJSt2v4STmJvk42JjjqyVv+rgzkdZUlO3PpHwCLr12Cd88pztXBMz31ReE+sP7P4ppWMG7MXFaHssy01I1M2Hm6b6PkBEDLo6a9IpkywBJOcnz5xpZ/yE0HkPZ1QgIzySBFpEa16b8N7B2lAsz/fBCNd9BWsY0Xm/+TsxVFo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98909d8d-f14f-4aa2-c3ab-08d58db0b829
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998F6179A45D0B0F0C6922FFBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ztfY+ZzwGbpD5q2Z4HU8lTEkx3RohFGW56Uo/SPQ/K65UiWO8Yww4kSgLGFGcmcBulbsEgoBLKSIsB/AsfkkpqN+E0l9J5LelSpogClRkFtCNvgxD6tO+nr8OZcFFbfY+LxxdvR+PzoCSmivYnDgXCQj3JeDJhOmDqfG8V6KQlsiJeOK3yCtkmxsfSOhielyWW0MJGn8O/AsHVP3VVPBuzb/+2pU8wTGP7wsLeVhu4XduTIiKCIabcvdpE/F88yIZ0BMUC3iHKxFlLrApcI4m4fiDwy754+FOIHj78ogzbnK7+jwZYygICD1V/8tqtPom/uJLc4jh3IDW8Uu2bJv2w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98909d8d-f14f-4aa2-c3ab-08d58db0b829
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:24.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
index 5cc9d9952121..775cda4f2fd3 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -134,10 +134,10 @@ static const struct sunxi_ccu_desc sun8i_a83t_de2_clk=
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

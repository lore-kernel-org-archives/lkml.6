Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497549-2-5022450276142163443
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
    t=1521497548; b=pi7gVOw0QjJL58nnHOAlgW+u5a2CI3c72K1h78IhG4XnNG9
    rDZnQwzxYL3xp2zU9gclVLzPbUAIWVvgQcl2zuBvE4oSTSrphzKPIKyBCK2W+sOS
    pYOiIGoUOC/Dy5VAOkUobRX6P4yM0RZjqmvgxaZxrtQMTmwNfuG1/w8FKGgvy53M
    yvh7kcoNF5/jcBgLv2BccC82mAf7ZJdRBUu8Phbh9pTPswwYqNJPmDw7S+VLMaSf
    6aKoXhxGgzyM2TtdLMlye5bhN6znMR2/OqTxEHcz6WdXff8C5yUXBWQnJ07AtU/k
    hYcDMAiKdbmML7x+qRd6RAPm2QgRboIZk1uryXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497548; bh=wz9vAf
    /XxlHXtcAsaBKyOM9kzp2vm/uTUsoq/uGlAXY=; b=eeev89XwuLAItpzPhMIlgj
    NxMkGUkJCfN0/k7QLKMnXsytXoxNwE7m4oqSnPMb+FheTSaPlQ8Vc5n82byl3YTB
    g1Pz+cLYs3dPZ11Mfsh7BjvmdBRBSWSgH802VUW4jLCLz5RgxeHwCRTcAytqXftq
    DtX3ge3vRQGG/oAgt74B2SOw/gw7783NHkILD/QngWcDv0LyAN5niZUr7a8RSONP
    AOHxSmu5FECSol7Hml2TsxIToTJauZ1ZyzWsPBAsDJ7D+yDJ4117erbvpCJxt+FI
    f6892N/9EqiJyiHbt13QeQjr6BJv8KMOefm19TXkRT+f2dXLoTKe10/QRhpr9dBQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ei7zPZ6y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeeifeenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ei7zPZ6y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeeifeenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934270AbeCSPyc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:54:32 -0400
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:45512
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934260AbeCSPy1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 04/97] clk: meson: mpll: use 64-bit maths in
 params_from_rate
Thread-Topic: [PATCH AUTOSEL for 4.14 04/97] clk: meson: mpll: use 64-bit
 maths in params_from_rate
Thread-Index: AQHTv5qOe7u07TGExEKVux/LKiLzIA==
Date: Mon, 19 Mar 2018 15:54:25 +0000
Message-ID: <20180319155411.12348-4-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:D6ACVJTGMgvPMYyOKGUOZfz8ZJ+dvW6ZHHF7QG848wEe1cziPy+Bsm/8kZvZCV40MmBbOBoK07Y8x0S9kF/3DESD7AA7iAvV8FcPkQf+6KqGJoVoSwkSztvNszIevTBc4cSb85OqA6K6TijK9LjAV3Z4UKKh9bt0My2nniK54HBH89VEZecbLu0hi71OTfeAhY/oBUbSvMbQcybFsf3fkSu6cUHCheydIQVYFMQRZ3QtRkAYUKJUFQBiyO1Ihod6;20:R6iNomSYGh0pTaiO24sRJH16NBNa5zsoAEPnKQbiCJnlWCBQVnQS1idYpGwx0cTlIVdBKXkOiKZoTS+9/L43iAaA89WvSd4DLJX8TZ2K/rt2S4L1eYLy02/oapLvHOgsfRTUhduWSDrlVri+j2F9jZgcCICZwk/V1CfG5aZqvpE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a0f8f18-a90f-40f7-095a-08d58db1b0b9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806F40C4C10F517E4EBBD09FBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(59450400001)(102836004)(6506007)(53936002)(86362001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: GUGFbPeZDOvYz69amto6NrnhxfhjK6niwIhoaVbdru95yuc6EuMrC0KkS865trHJdrs0hrVPF6Kgwkq1/cKZ0aEs3d83CyYumz48h+IeXTeDNqKPihKMZGOw1KAaiGRl0Uu9Zs76Raroq8vd2VqOQoQwBJdN6iV3D3ydZfFBVdxOdKGOl0gIzHhczc7+VD1w1IXlhhVzBor7uIskneJ2p8eBsTIltUgwdJ9+CEAkCcBztyfQGuIU1Xl59kGrWhidNf2m4matny8m+Mn0HgtKSJfgGAjtjcbGRUVpSlR2qux3FNrdREZqYnumGRo2Vo2f0Dgeowy3js9sd0IETtCVpg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0f8f18-a90f-40f7-095a-08d58db1b0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:25.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 86aacdca66774051cbc0958110a48074b57a060b ]

"rem * SDM_DEN" can easily overflow on the 32-bit Meson8 and Meson8b
SoCs if the "remainder" (after the division operation) is greater than
262143Hz. This is likely to happen since the input clock for the MPLLs
on Meson8 and Meson8b is "fixed_pll", which is running at a rate of
2550MHz.

One example where this was observed to be problematic was the Ethernet
clock calculation (which takes MPLL2 as input). When requesting a rate
of 125MHz there is a remainder of 2500000Hz.
The resulting MPLL2 rate before this patch was 127488329Hz.
The resulting MPLL2 rate after this patch is 124999103Hz.

Commit b609338b26f5 ("clk: meson: mpll: use 64bit math in
rate_from_params") already fixed a similar issue in rate_from_params.

Fixes: 007e6e5c5f01d3 ("clk: meson: mpll: add rw operation")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/meson/clk-mpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index 44a5a535ca63..5144360e2c80 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -98,7 +98,7 @@ static void params_from_rate(unsigned long requested_rate=
,
 		*sdm =3D SDM_DEN - 1;
 	} else {
 		*n2 =3D div;
-		*sdm =3D DIV_ROUND_UP(rem * SDM_DEN, requested_rate);
+		*sdm =3D DIV_ROUND_UP_ULL((u64)rem * SDM_DEN, requested_rate);
 	}
 }
=20
--=20
2.14.1

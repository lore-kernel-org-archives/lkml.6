Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497617-2-11099540121934726285
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
    t=1521497617; b=s94dleDUwe1VBtt2f3FCPdiN8zHslPrfofDzpKRHB4DAc0v
    1951hlslBYiGhQc8M5DCXqInNWuVWpQz+m1rzBimXlX7knBVu+fp++S0e0i6TPsD
    NDR0fBTz5H+meG2p1FiYebEs5hf+KcTYpkssdjeAwGcd9cfcr6yhUm+raLsx7oep
    pXM+n5jVUJqn5uiI4Dwt145S98oYmuq9YIgKNv2YFLgZjj/p+aOA3PfBl59ibf3J
    WHaczdbjzTR59gfNam7ZWjEb79sJyZke0yP5QQ3CTm3ER3bLNh8PYdeBbnyFuZtd
    Z55vedOPZdd8eezfITYWwI3eyQUDUqZ81Sb62yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497617; bh=oBHTya
    tAGoPmAhJTv7o2HwUEhBTRmDma4227zm5P2W4=; b=uXhvaGFWWqfQVgJQ9RevKK
    sUrIVZGQHGWmvL7j5KHY5wzeTndk2VeTpBACU+qyLoj9xLMYJHVOrmVo5itLYoIt
    wpmiMqOzpDat9mJ18aqaHWuFCon44DxLWa2VtZGGlOFphHZJbmURmt4Cz/6bxqXL
    Dl6UYxQvVix1/MhwRrAEFYKQTroLd3fMBFDUFOqsq2K+H8LDrnMcqnB+l4aQTNLb
    Z0QV4eH4XfGXMOU0+aj/Qo7NgNxbpmDI9eULbXorf/jlDmw3+X+4JdwHyIlGlV/m
    dV3yt3AXIHmjXmgTyHmv19xXYQ+BbCJV2sa5VEKzszb+NMGhe2BbfjIcElNNLd9A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DY//ixjr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdejudenucevlhhushhtvghrufhiiigvpeeiie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DY//ixjr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdejudenucevlhhushhtvghrufhiiigvpeeiie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934221AbeCSWNC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:13:02 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:27808
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933767AbeCSPy2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 05/97] ARM: dts: ls1021a: add
 "fsl,ls1021a-esdhc" compatible string to esdhc node
Thread-Topic: [PATCH AUTOSEL for 4.14 05/97] ARM: dts: ls1021a: add
 "fsl,ls1021a-esdhc" compatible string to esdhc node
Thread-Index: AQHTv5qOeZZBmr2qXUiAqE8K7AW2OA==
Date: Mon, 19 Mar 2018 15:54:26 +0000
Message-ID: <20180319155411.12348-5-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:Wf1nd753ETiyjxhpqtx3ANsiNAbWslq15PtOY9UiGdnSrI5Rq8WNG3BkLkNxYp2bWk3OZBEyP5X9TTOZq4Q7oDB5CvTylUfytgN2Ot/J+W4s/TVe8BsnZZ33E9/iB7fHBqHnep2LQJIUIkAguo+dHwbg0TlBCqamkemEzc5NdhYPQIJ1TSNAasv7vGpBtTJePxfpJdVt8V7kygzwNmXTxPAPb1I0OJJsG8BgMfM2PR5RJJHywlsnx6ZiWG8ZaPS9;20:PU7WfQ/vhLrtot5zVFN73ldEzf6mtR0W8S/8BTrZ+CRmxCxzV53hBCJsEgsuWVsxy5TGsUtXklQ19dUyjKxdEXTShz1Qa3qJ30slOo+BswsphAWIbcrTJI6rrLplC+anZMIQ1KURsiTGnppkuMmqC2MOELuCL3BbrEzLzd30QQc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 421625bf-6f5a-4784-5c62-08d58db1b164
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090368568762764C0C4667FEFBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(3660700001)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(8936002)(68736007)(6506007)(76176011)(14454004)(59450400001)(4326008)(2900100001)(3280700002)(25786009)(575784001)(86362001)(6436002)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: TjCZy6aFaTBTQISlHhmrPXK5Q8bPcewF01AwpXh+FOpRTSiqXbEvbyuB2Rsj5gkxd/6DJMUzRxa9+PZps91y64xr/NdMsaAKLxHFD8w9OAdaDpPYdgpwQkSBQRK3iy70a8w8dgfCAFWIcDy5OTUzVreW+tghxdMhj24XEJO3HCorD9Ou3Vdrqpk34vDoq212hI6vZrwKAMGJu6jmxAEEmIidnvounMEphPqAoaPTZx2qd9Up857Iv0B68dxDNtAb51nOh0RZbasIb9epBFQDWi4R56xRQYiIor5DBCRlTtjDwfbRv++GYp6kgc5tdGX66NA1hkn/Y290zDWasY9CPQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421625bf-6f5a-4784-5c62-08d58db1b164
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:26.6464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

[ Upstream commit d5c7b4d5ac2237a6da7ced3adfe6b8bf769f8cc6 ]

Commit a22950c888e3 (mmc: sdhci-of-esdhc: add quirk
SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for ls1021a) added logic to the driver to
enable the broken timeout val quirk for ls1021a, but did not add the
corresponding compatible string to the device tree, so it didn't really
have any effect. Fix that.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dts=
i
index 9319e1f0f1d8..379b4a03cfe2 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -155,7 +155,7 @@
 		};
=20
 		esdhc: esdhc@1560000 {
-			compatible =3D "fsl,esdhc";
+			compatible =3D "fsl,ls1021a-esdhc", "fsl,esdhc";
 			reg =3D <0x0 0x1560000 0x0 0x10000>;
 			interrupts =3D <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency =3D <0>;
--=20
2.14.1

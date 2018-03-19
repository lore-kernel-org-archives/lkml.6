Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495326-2-6109848197193628797
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
    t=1521495325; b=MJjY1PUkemRLG4TKR0LJeNV9+Il6/fFBS9OqVuf+ZjjCPiz
    hHCmn70vuLb9IatJZweOBVowY4cpyghdOLenqLemHkBp5zFdq/bq/62z7xZxacaS
    5rSYDXlwmEgbVTKAksChaqKZlW8ymyiLKcBE9Uuuo1DC2WHa1q0fVxACzM/2WWCi
    e4rAfUBV4Oa9rVJGtQteBRknX+8AQU0kah3YZJsh+0FBPp3SBUDBjxPt6sHMQwxj
    IH184UikseTKafDGT7jpzFlhE2Q5aBH1YS2ibvFc02NP/K0WmRJV3ll9ENl4XDLd
    TV7KdRpJoSEDxE2cQ8/Vn6hsRFB9Kuf3QKQF4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495325; bh=3HcRms
    wF8u8fOMt1L7wlsJMg4cQUAW8p9Cy1udbwg3U=; b=LkiBL5v8uLKxBDHTWHxvA7
    kjUVPlK11lVIn5+03LWGfbA7Iae6BKWt6XgAyqb1xJkZM/SKJ031RNeBqu/DIsbk
    CXKbMB9icAxasGTm9sQ58hBhQdbXmwHDHKX8djs50GnsB15FppsGcNBy8QtL7FEn
    vTkpUPJE6IDWHoQdzV5Uxmh3rZGN4Dp5+kn0Dq8L5Gdpj7wYfMAttAgAklu+fjEA
    O99+WJ4xT4+LkL6Eyr9ArDL3CgvHRsOHIcYQX35MI+B0oI17saEeTUjxN5B6EfZE
    f18mDT2El4/EpjoCla6KByirgSqrO2nsilTnMMMv4QFaOlsAR0I9dQaGsDJtD39g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CSi4WJqk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdefleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CSi4WJqk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdefleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934781AbeCSP7d (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:33 -0400
Received: from mail-sn1nam02on0139.outbound.protection.outlook.com ([104.47.36.139]:23168
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965088AbeCSP7T (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 045/281] ARM: dts: imx53-qsrb: Pulldown PMIC
 IRQ pin
Thread-Topic: [PATCH AUTOSEL for 4.9 045/281] ARM: dts: imx53-qsrb: Pulldown
 PMIC IRQ pin
Thread-Index: AQHTv5snfaLg+N78N0CiL40ABE4chQ==
Date: Mon, 19 Mar 2018 15:58:43 +0000
Message-ID: <20180319155742.13731-45-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:BqQdwXY3+G1nwHUFEsFOif46AlRiGos0f9xe5j6Hf8WjI6ni9RN/AdqXNsaizW40P1nS0SdSlR/fku7asRYzXEK9najS6CEoU9kVse1u7GTEVEITH6sXJi1HMw2M1F2MepmwJL2G97CbbZnAS3Dj7+3vJ929QUmAZa1G65RRnfcdj4wJaxgJpmMosFs5XCdzxM6p86ppi7yCYXClxf9eRlyyr2/+FQ7SngzC/taiKEXnHfa2h562j74qV3eoAarG;20:F1OLWUV3F1F3gZxjiTsbekUqV3WPb0CWkQxyKqJYqsyvwnvak77tffcetUXBsoWVIhNkfXEuNtRRSuxXhrGe6zLyZFywun5UmZ65IAhk6OzGG+KzPoI4YEGJ7ID4UPpZv/jlsXZeXSLYoMncVuU+N1XabRZY5/wrspwydD7vvdU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33ec48db-636d-482a-2849-08d58db25caa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015D36C8A9C5417A85C7252FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(8656006)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: aD6Ni3snnaOfPZQqFaEIAb+ziHD+dYasU2pvv2fcEBiJmBZa1uxftIWL7+EpJXB46nUqz+cHw/92nemC2zqii9F+tU8DYhMw5Z8iwBMM4E3/PgujSoTfEpZvIsZ9t4h4l64V+FHho0B6aDG5/zZQ6n+Iln4mYmsMKt5gjqCLpglcovI8LMjY637QdY5NO36LuRHEHV1pE443b+AxIVD0I6eeGARylTVRttjCnRUzhl3bctZ0vLL6In5xutTfYvrofa1WxBOOiMCLeo3tbTTjRTqzMR9kBhvS3PiP+z4E4tAZU4pqnriQR50p2JpFb5c980O3tw+QguTPDW5VmkGB1Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ec48db-636d-482a-2849-08d58db25caa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:43.5142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit 2fe4bff3516924a37e083e3211364abe59db1161 ]

Currently the following errors are seen:

[   14.015056] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.321093] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.411681] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.456281] mc13xxx 0-0008: Failed to read IRQ status: -6
[   30.527106] mc13xxx 0-0008: Failed to read IRQ status: -6
[   36.596900] mc13xxx 0-0008: Failed to read IRQ status: -6

Also when reading the interrupts via 'cat /proc/interrupts' the
PMIC GPIO interrupt counter does not stop increasing.

The reason for the storm of interrupts is that the PUS field of
register IOMUXC_SW_PAD_CTL_PAD_CSI0_DAT5 is currently configured as:
10 : 100k pullup

and the PMIC interrupt is being registered as IRQ_TYPE_LEVEL_HIGH type,
which is the correct type as per the MC34708 datasheet.

Use the default power on value for the IOMUX, which sets PUS field as:
00: 360k pull down

This prevents the spurious PMIC interrupts from happening.

Commit e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
correctly described the irq type as IRQ_TYPE_LEVEL_HIGH, but
missed to update the IOMUX of the PMIC GPIO as pull down.

Fixes: e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/imx53-qsrb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsrb.dts b/arch/arm/boot/dts/imx53-qsr=
b.dts
index 96d7eede412e..036c9bd9bf75 100644
--- a/arch/arm/boot/dts/imx53-qsrb.dts
+++ b/arch/arm/boot/dts/imx53-qsrb.dts
@@ -23,7 +23,7 @@
 	imx53-qsrb {
 		pinctrl_pmic: pmicgrp {
 			fsl,pins =3D <
-				MX53_PAD_CSI0_DAT5__GPIO5_23	0x1e4 /* IRQ */
+				MX53_PAD_CSI0_DAT5__GPIO5_23	0x1c4 /* IRQ */
 			>;
 		};
 	};
--=20
2.14.1

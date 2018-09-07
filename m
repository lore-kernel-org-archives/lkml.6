Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927DD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ibfPYf3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927DD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbeIGF3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:29:31 -0400
Received: from mail-eopbgr680106.outbound.protection.outlook.com ([40.107.68.106]:39946
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728952AbeIGFRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghoh32rku5DFQ99FT3FgasNN111B4Tw7IA2KwACxKuA=;
 b=ibfPYf3N/MOFUv029Zld/oCIyHNB40hV+B6gcpwkEJwBJpdaUdgRm22ZXyNkqP35eeR/I93BPVD1WCuftsw+Rfj/IiJ4QszpK8lkTDzqR3oGrs+4dnzWNfQuJNtjepq3Eq4T0viOQ5F2vKNsUr0fLcTI6t4tzZ/vLWCLbMVdNZ8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0695.namprd21.prod.outlook.com (10.175.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bhushan Shah <bshah@kde.org>, Brian Masney <masneyb@onstation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 56/67] ARM: dts: qcom: msm8974-hammerhead:
 increase load on l20 for sdhci
Thread-Topic: [PATCH AUTOSEL 4.14 56/67] ARM: dts: qcom: msm8974-hammerhead:
 increase load on l20 for sdhci
Thread-Index: AQHURkMIW1WRi+oWh0OKsNYRkXgJGQ==
Date:   Fri, 7 Sep 2018 00:38:02 +0000
Message-ID: <20180907003716.57737-56-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0695;6:zK6yfCXn/wvpbbfse33jWtOQsEqpCXa8Ror4Dy9rrhnkJ8+7OpwIxCyklhjenMssHQlVnrRHDKBtCMOxByDnUrsJ38NYTttSTHcchbTb4spthuD3ZH7fFDkcv8CzquuUxOzNoYoR7KMteE5TzT22ZbnqFQmQgiplyF+17OuEYncfHD9Tb1Vzf3SvAw2/yh+uGemlR27BmNgd3d/qKSZSD21bCdEq25FlP7enTsvV4nBYBijfH2aDADtj8wFNEgKcIgJ03urB7Kvzrx99imfZotNcjZTSdD1HzGWONnFxZNFvB5CIimu0cboyV7aeshXO5JGLITuu8sc/BbAIr7Ccxnbkb1NsGheJExkhIA+LVYT2DCoJ0A9N8X4pipThbf23V13Om5QhjZiwKjso9VYePnQvhxUM4O0sfXFa5jZYJETiIpsI3lPRrwgL754snKl++7oUooHpv4gdh1LjYnFsow==;5:TMs2P6dO63nad84u1H8qe5g8MOKWfalvSnqUTLwNwuBC3MG6Y/Yj0V4Eo7B5rfJqCPQZmfQqDxT9JhT2Rt4uaidWna09S9RXYnpKDhSkU5ii/MEw/Zbo7kHVoSihwtD9I0J0bNY2is78/i6FWW1PA92kIYeerbZu83RkIK7xHIM=;7:5sSmn4VmbIshCf0ewsg0VmyzCB5B89fMzVOblggA2rBX/0yPgwb91VKJuFxeYgeaVXCfKfE2u7unjAR2zIcy9RQtqZ0xm9n2tictb1hSHmn2hHVhnYPUeJBlgtb0lgTo90KM4z/wvHln7b1uJDgHoayNVtxidupGntIuyBOcAVYHoNhmey8DvSz4J8B0252t3xv1dvHAsioSHUo8L89MklafWV+twDvPzIGMhMJIqzRircVBQWsZ1yEHyllQ7XDp
x-ms-office365-filtering-correlation-id: 76b571a3-930e-4cc0-804e-08d6145a5194
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0695;
x-ms-traffictypediagnostic: CY4PR21MB0695:
x-microsoft-antispam-prvs: <CY4PR21MB06952768F4EADD6125D75A5EFB000@CY4PR21MB0695.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0695;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0695;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(14444005)(99286004)(6486002)(5250100002)(256004)(6436002)(8676002)(81156014)(81166006)(2906002)(10090500001)(97736004)(2900100001)(76176011)(305945005)(7736002)(25786009)(36756003)(86612001)(105586002)(22452003)(106356001)(575784001)(4326008)(66066001)(476003)(2616005)(5660300001)(486006)(6666003)(446003)(11346002)(86362001)(316002)(8936002)(6506007)(6116002)(72206003)(3846002)(14454004)(217873002)(2501003)(6512007)(478600001)(1076002)(10290500003)(53936002)(68736007)(102836004)(110136005)(6346003)(54906003)(26005)(186003)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0695;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JU9OXHzitBTZYokuO8NH9C/fVxz1XFT8wgJqfX/5PXyUu5Yf2qDZyk7mB8qskO9wq4MSHFwhxDqOr61yiN9/od6gIauyGPCt4WGqCxD6OOx3F33n++jPUq/gdZETPGrapK8G6zOqgA8OfMf0NMuISosZghmEf7aUG8Y5DauCvFJ5oJgGjgdLx/6eeIP+7P81Uyes0Kziq72wqKBeAudYi2N4y0MDWLyFKuZ9cP5wHa43FT0m+wD5WXAG6MmY2Sog0dd59vS7u3PAamhndfxJUoZKNuRiXLTUAfhZ0dWSPvop1qZUu6dorQ3haUCW7JSMOlnuXZCR3NUDoMFzqg+HjTR1+VryUtwaAldKLZe4YZI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b571a3-930e-4cc0-804e-08d6145a5194
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:02.0490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhushan Shah <bshah@kde.org>

[ Upstream commit 03864e57770a9541e7ff3990bacf2d9a2fffcd5d ]

The kernel would not boot on the hammerhead hardware due to the
following error:

mmc0: Timeout waiting for hardware interrupt.
mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mmc0: sdhci: Sys addr:  0x00000200 | Version:  0x00003802
mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000200
mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
mmc0: sdhci: Present:   0x03e80000 | Host ctl: 0x00000034
mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
mmc0: sdhci: Int enab:  0x02ff900b | Sig enab: 0x02ff100b
mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
mmc0: sdhci: Caps:      0x642dc8b2 | Caps_1:   0x00008007
mmc0: sdhci: Cmd:       0x00000c1b | Max curr: 0x00000000
mmc0: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0x00000000
mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc0: sdhci: Host ctl2: 0x00000008
mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x70040220
mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mmc0: Card stuck in wrong state! mmcblk0 card_busy_detect status: 0xe00
mmc0: cache flush error -110
mmc0: Reset 0x1 never completed.

This patch increases the load on l20 to 0.2 amps for the sdhci
and allows the device to boot normally.

Signed-off-by: Bhushan Shah <bshah@kde.org>
Signed-off-by: Brian Masney <masneyb@onstation.org>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arc=
h/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 4dc0b347b1ee..c2dc9d09484a 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -189,6 +189,8 @@
 						regulator-max-microvolt =3D <2950000>;
=20
 						regulator-boot-on;
+						regulator-system-load =3D <200000>;
+						regulator-allow-set-load;
 					};
=20
 					l21 {
--=20
2.17.1

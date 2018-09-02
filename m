Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F7AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A552D20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Qs87Or+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A552D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeIBRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:43:52 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728794AbeIBRWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzigIJBDf0JqFhKDCXTX8pRH8GlJM3jMN0ODcl5CI60=;
 b=Qs87Or+jxyt/Ue7ouqix74lJi3oACcNZEu5Bj4gj1rCfmnGweJJKCh9LxCOaerH/Cnn6uskmqVmFDMUnXBo/w/n95xt6aSTUZfH1VBnDnAc9ZcFKcwt6+e7Ia/g2eixfyiD+39SzqN0wlS6tqoZctYyT/YQC0q13Zj+lmY/tQkY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Quentin Schulz <quentin.schulz@bootlin.com>,
        Paul Burton <paul.burton@mips.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 129/131] MIPS: mscc: ocelot: fix length of memory
 address space for MIIM
Thread-Topic: [PATCH AUTOSEL 4.18 129/131] MIPS: mscc: ocelot: fix length of
 memory address space for MIIM
Thread-Index: AQHUQr2pHPqi3/mQZ0OZmaKIhhWiug==
Date:   Sun, 2 Sep 2018 13:05:45 +0000
Message-ID: <20180902064601.183036-129-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:1D3pdDo5jazpQFU9oB38mIFYgPxtJmibyysTg6KqdejmkVv0npPWaAz443BFooC8NWjV5gc8n4MD6SzJk2w4vzSXTn3aPB4t6IvoLD5IheCW50si1goZCWUeHv+XE6QCsDgbm0vg+Po3pkmyNVKfF1IowbExD8l1SQQj8f046nx8ZFbOKlGHIlpeej8drzd2Yk4vf3abtyGCTfoOkInJVLJTw7ahOYb9j9MpuUFgoAGshuWWxIv2H7RVmJVVBM3PzrJrlqghLeHI/blZjxZWsh5cxu8aEjz9NSuL8EjjkdMuyYp1/Gr/b0isY7ADiqCfi6WCo/bw8wRNfcagscEShtkdgy9kAk/seYSS+NuMuBA/2fc0k/S8FZf6livg7y3mNyGaCxoKm6yO69VcIOmxfvB8VnMED2D2D+MuTgxMl9ZkX4JfvRxQvbh+aWNtw3303YNJm1J1ABawcHwP/+Shvg==;5:neKVvPwE7lZqcMV8obwI/6UuWS/KUKlZ0gfn/OYncYQ+gXvv32n4OQj7TICo/L+Iaa89lsjueDDxlJnrBM/0LjNSo2V8McFCa4Me7D9+t+h71mh7auzHzT7VrVESViasRaAOpd2RQJz1jzX+YQb3virkuYDh4EIJF8PIH9p/uzk=;7:fQSjFF1swUriuj3s5j7vgMF2BU+MLFtUqs+vwVSi5byOmghpSOBH/64paEzFaNJ9/NqxDhF9vmAPSc5/Byn8fQOlJn4hkWy48LmMb/AW2P5kVeutg2StoOTQg/HjTTo8Q8kAKIThDU79vgYa3BPF72S5o4AQETfXIQqhgwPvc1wbWsjUhUUObWizR/AcDONCqAx7U3EMH0O8Tzo+hGqOt0XPGyYn370M+MClCl1uBqh2SaoA9F0v0Rjw/LxvN0CH
x-ms-office365-filtering-correlation-id: 14ca20fa-4cdf-40e8-ed38-08d610d4dfab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822AB6CCDADC384858156C0FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(6306002)(76176011)(966005)(6486002)(53936002)(2616005)(476003)(72206003)(7416002)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: oBkuYIAqpv7SrDf1DpIwlZgT8wfMC9f+FzhVTXOUi1hydT7A6X+CcXxDBhOnELyMCVV3MRBbU9ECzAOpE3PbzQIYqvyH2/O6cjMgK9b9+BsbdLRdFpzr2O+662C5RIseDEdYtJ+FqsLHuJJ7VPLvwZr5vl2x/VGPeY+TVqGfNqCXsgNShFpVKym46biyaXnwH9ErS9viFxMQxdQvIpHo4g6VnkejqlaZmFRLiT+Za7cPx4Y+XsxIawbopwojmdBQM2FD9OXsssx5Kt+GZTRJwGea/kvT+raua8hKKI5t62zlZrCcUr4HqX8T77ucQO0HdI7iMsB8nSr2JeVv5dJ5lo5d2VSZdCZ2P8lQnfafhHY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ca20fa-4cdf-40e8-ed38-08d610d4dfab
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:45.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

[ Upstream commit 49e5bb13adc11fe6e2e40f65c04f3a461aea1fec ]

The length of memory address space for MIIM0 is from 0x7107009c to
0x710700bf included which is 36 bytes long in decimal, or 0x24 bytes in
hexadecimal and not 0x36.

Fixes: 49b031690abe ("MIPS: mscc: Add switch to ocelot")

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20013/
Cc: robh+dt@kernel.org
Cc: mark.rutland@arm.com
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/=
ocelot.dtsi
index 4f33dbc67348..7096915f26e0 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -184,7 +184,7 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			compatible =3D "mscc,ocelot-miim";
-			reg =3D <0x107009c 0x36>, <0x10700f0 0x8>;
+			reg =3D <0x107009c 0x24>, <0x10700f0 0x8>;
 			interrupts =3D <14>;
 			status =3D "disabled";
=20
--=20
2.17.1

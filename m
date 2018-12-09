Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0703C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B57B20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m8FrItid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B57B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbeLIO0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:26:44 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:42112
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbeLIO0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3OJ9aDDU//RpMYbfYhsuvu0QiMl574l+IQHNsr6WaA=;
 b=m8FrItidd6Z5SOiuvj3sDhHebDuR+eNVSKMLbKwqxCUqL9EDF2wY9tFDKQoanX7rj/4RqQxtIUd6cqNkN/guAABYdXEpiJn0SbwOvHO/TC5PRAlm4kmfUn6tX0bYTawN6AHPtoj7le4zh0oHEXuXLLRjQ+QmTUQA2q/6RVTx7kc=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3910.eurprd04.prod.outlook.com (52.133.29.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sun, 9 Dec 2018 14:26:10 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.025; Sun, 9 Dec 2018
 14:26:10 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v5 5/6] arm64: dts: imx8mq: add watchdog devices
Thread-Topic: [PATCH v5 5/6] arm64: dts: imx8mq: add watchdog devices
Thread-Index: AQHUj8shDl9/dHaIwEebpIZj6ZXO1Q==
Date:   Sun, 9 Dec 2018 14:26:10 +0000
Message-ID: <1544365552-30270-6-git-send-email-abel.vesa@nxp.com>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:203:51::14) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3910;6:/eE2iO6+MyytmwlfyTcMAr37eikT8GzJEKmyOvCVf6NAYr8TKToivxEZT3g9B0W8/lpA6SOupli99bhgS8vpHWWF3FMRfK2g32MIpfg6HzwS5j2FVJ5c/XvxpeoGy4FD0niI39KDtwIio/aTWgoLfpvurI8mojFFz77FjM8p8nHnPyCDAIk51Lyp4EVSRgQ9+XAp+qBrkidOVEC/fpHxZuPAyyQAqPtf1D2sjsj5ikbR9oJUWoLbr594auTn2bg2cWGRpJKDuKE2puakO4XwTI58wCH9wkuYk4ZRKVy7hhSvckC3ufjhrRoxCH2vHAnxD+zodvbFhcz6ljbU5cyzFOb8MMAGnLMgbFlF4vi2/W63MKnYra7LdiQbCRK6CatgqmN0VJrm4sVFMrOQC2ATvWayziFHuAEXMSUzV/5+Oik2gWdlbNAQpCZv2GsNqbULO/iX3tgpMQk6pZMsKSjTFQ==;5:MyqFYk8HhYhq4dytWA7sl4vMjeGxEsmeLLQhJJj0bpz9LZ3asNGBzWaWuC90iPruAG6+4Ww/gFA0fGaV1aTVNhn8XBQVeVjQ9Q9jCt4bdbZM4LghIgM1UseXEi3chAnVjI1HM+vlB2SsbuB81hLvma4kA3kVCdXvpVXYKfekGaQ=;7:8i4wvtj3JhUg7lhKi8Y4EoWURVcDhU1YBJwCGD6dZqDxvGWntCMl1zNaN9QhImFRKO1FRZKI+hatsGbs5ogUWkFYvAIFy2GUQHxr6L+Ep9bgC/hlddZpezpcHrgLlVDdMs/qhDj0Qv5Cbu7NfMlBfQ==
x-ms-office365-filtering-correlation-id: c1be5b68-d80e-49b5-926b-08d65de243ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3910;
x-ms-traffictypediagnostic: AM6PR0402MB3910:
x-microsoft-antispam-prvs: <AM6PR0402MB391032501FFABD21356E2150F6A40@AM6PR0402MB3910.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3910;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3910;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(26005)(446003)(5660300001)(25786009)(11346002)(71190400001)(2906002)(106356001)(105586002)(54906003)(3846002)(7736002)(44832011)(305945005)(2501003)(6116002)(476003)(486006)(2616005)(66066001)(97736004)(8676002)(4326008)(53936002)(99286004)(7416002)(6436002)(81166006)(110136005)(14444005)(6486002)(186003)(81156014)(68736007)(6512007)(386003)(6506007)(478600001)(86362001)(256004)(14454004)(36756003)(76176011)(71200400001)(102836004)(8936002)(52116002)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3910;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9N7f3h76DtgaFoAWTZb/8GtEmrPPWm82NwOK+FBPnmW5s1otVheKdunZtBmD4rxxz8ee1C/46KwOuki8JfPtmK1A6tWan5XSwV/OTXPx441g4u7FhO2B12OczAjbWNUjaZXlmWykgUfzpHQjFuf3Lg94+Dh8e+qJzTXOqurgMbhqQT43f5g3CL4D7ADx9cawPd/rpDQBRrn3lk5fElqzbUKYgzNxHmnLZh9mJlhy/minKfOlvS+VU+QRl00kw9gVEcWF6ZD9XBVgF0bHdzcW40vdRhdIODVbYHwkSIeNdAkeuYsW1rPf+cyQWU7TkVpN0gDRCCOsFH2rmVrA1TOyu8RQFN4YN4+LRHMe9vUfjQk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1be5b68-d80e-49b5-926b-08d65de243ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 14:26:10.1935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 3703bca..8e9d6d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -228,6 +228,30 @@
 				              "clk_ext1", "clk_ext2",
 				              "clk_ext3", "clk_ext4";
 			};
+
+			wdog1: watchdog@30280000 {
+				compatible =3D "fsl,imx8mq-wdt", "fsl,imx21-wdt";
+				reg =3D <0x30280000 0x10000>;
+				interrupts =3D <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_WDOG1_ROOT>;
+				status =3D "disabled";
+			};
+
+			wdog2: watchdog@30290000 {
+				compatible =3D "fsl,imx8mq-wdt", "fsl,imx21-wdt";
+				reg =3D <0x30290000 0x10000>;
+				interrupts =3D <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_WDOG2_ROOT>;
+				status =3D "disabled";
+			};
+
+			wdog3: watchdog@302a0000 {
+				compatible =3D "fsl,imx8mq-wdt", "fsl,imx21-wdt";
+				reg =3D <0x302a0000 0x10000>;
+				interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_WDOG3_ROOT>;
+				status =3D "disabled";
+			};
 		};
=20
 		bus@30400000 { /* AIPS2 */
--=20
2.7.4


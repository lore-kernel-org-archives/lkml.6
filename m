Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D32C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F9920870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v6ASDE36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F9920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391773AbeKVNdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:33:06 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:55138
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730701AbeKVNdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY3XXWpv6kHx2CHoEXrwNinI5Mzn+XmixIRmJeMwgQ0=;
 b=v6ASDE36syzox2zSX4AR4eWKNRs58K8HTWXrfOgkI9LNzlFCw0m+KrueZ03zw7JIYNd5FsIPeWbQQT3iaW+TSZzf0WENA7uCet4GuCvKkVdBXV30Rjvt8o/69NwMQ54GzHlQKt4OhFilFOY8Qjp+hvg164xIznanTKN5O6nxV7Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Thu, 22 Nov 2018 02:55:45 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Thu, 22 Nov 2018
 02:55:45 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM: dts: imx6sll-evk: use WDOG_B pin reset
Thread-Topic: [PATCH] ARM: dts: imx6sll-evk: use WDOG_B pin reset
Thread-Index: AQHUgg7d1FC14R6xdkulOHFUc5P9Kg==
Date:   Thu, 22 Nov 2018 02:55:45 +0000
Message-ID: <1542855018-30217-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0170.apcprd02.prod.outlook.com
 (2603:1096:201:1f::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3675;6:KaIXytR+zoibpXYokbHri+3dwSBiEa00k2BRaFH+JBE+9nZ69RdU0ATTCJyY1gOI15GpBhTiXyCK7PynmOljREwFKI9KxJAcHm9RlktCtmMFfAQnqQetLVHBbhWICz0JHZzIr9wpGNCNHZB/IuXve0fzbT9TP5GVz1RvvdVhLqyUxZP1O4VOK8tBwZ0ABnNrRk+7IWVNoTNi7q3YMCTOOi6917CfEoOvdzieDAxefz5zHAZ2LmbH3Jmi9ZaF3b/0DScV4J1xzNV9dY+cHR9JBL/8rQHNaIb5wUHxdHF97wQb2NNMCfVo7CEN5DG6VBmJpMfPFu4OAiEj4FrzK5gdP7QW/9qOmHBTJlx+NGhBylKaN0qHyv7ATyATEFuZPJAQh2040qZF3pcMdw9UdW5KgOMYacU1sCDdgyiAYiOwGOlPm+qUb48Xr3Qg8Gf8rVfNl3C2eRzMDvH+B66bhcCnHg==;5:O0gLGybOuGv4lpZrZ9AO8iC4Td4xl1bzKRdcwAC/zMRvLc20REw0nMtpqp97z2pt6T6RhcRd7m8+rygKtIrzoXyWPuzJnowEbwKYjPhsy1l4ILITqFGkp0MXrelPMqSHBtsa+mE8Tx1BGoYFEEOssgqVq44ZbCmNDjkh118mNAo=;7:g45NXaNxYwEvGoHQPR+nqNd6/ZVjsfCrkqHm9JsyvycSfVpD5BZtJNeGKQza1CUhDczotZQLfNEFmS795HaS3egDTaXIa3FXbSeBvd7sDiKtPdhZ6Qt68oQSVX+eY3cOX2byMqSfFR5vVhiqP+KBKw==
x-ms-office365-filtering-correlation-id: c3ea7b66-5db9-491d-5808-08d65025ff94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB36753AC94CE6BA8BD07A457AF5DB0@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3675;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3675;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(99286004)(36756003)(2501003)(50226002)(6512007)(256004)(2201001)(14454004)(86362001)(316002)(110136005)(81166006)(81156014)(2906002)(8936002)(106356001)(305945005)(8676002)(97736004)(6116002)(105586002)(2900100001)(5660300001)(71190400001)(6436002)(66066001)(6486002)(7736002)(68736007)(478600001)(71200400001)(386003)(6506007)(102836004)(53936002)(1857600001)(486006)(2616005)(26005)(476003)(52116002)(186003)(3846002)(4326008)(25786009)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eYiHolD3nAJdry4weudmIiUwuhWYcjlfS2x0nxSz5t8j+b793cRuJJUBIkrLmb7M6mzEoQ1ld7jN+KAAihysMUsbMrPRJBL1F2rZCGHgcegrocvmGCg3UDN/OWqmaykjiYiRDRx/8m+rz0hMQgKYTgRXZEmYpcoDOduM9TnSlzqog/QCGAXiOy0JlUrHvbI13bRR8uSGtnCepS1xiD3JWeWImM83PIVZyWRnpJiUmgtWspFfsKv4PRupZDoHu7Luno8BzyOdccgF2RnqZ8L/Y5LljXURB0hv9D2Tww7HqVK4cvfw2LoReYyn3vB2+4k7JlatjEBj+dy1VeqI16QBoPW4Cydr/Q9m1y+RwzUS7kY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ea7b66-5db9-491d-5808-08d65025ff94
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 02:55:45.6151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL EVK board has WDOG_B pin connected to the PMIC;

Add the WDOG_B pinctrl entry and 'fsl,ext-reset-output'
property to wdog node to let watchdog trigger a system
POR reset via the PMIC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-=
evk.dts
index 9c90cbd..d8ad2a2 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -313,6 +313,12 @@
 	status =3D "okay";
 };
=20
+&wdog1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_wdog1>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	pinctrl_reg_sd3_vmmc: sd3vmmcgrp {
 		fsl,pins =3D <
@@ -478,4 +484,10 @@
 			MX6SLL_PAD_PWM1__PWM1_OUT   0x110b0
 		>;
 	};
+
+	pinctrl_wdog1: wdog1grp	{
+		fsl,pins =3D <
+			MX6SLL_PAD_WDOG_B__WDOG1_B   0x170b0
+		>;
+	};
 };
--=20
2.7.4


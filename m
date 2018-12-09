Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1320EC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A7F20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aXWErhso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A7F20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeLIO0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:26:48 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:42112
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbeLIO0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8+cnSBmPgw+FhovAppAO7uxN1lXIoy9FMIxcnXWge0=;
 b=aXWErhsoIRYWhianlMnlI5PYVrhSP11Z6W3zpDdgrnKKZX4w4odweEgTgooYGwfjuGy/Rxlzh3/hLjY/trHhI/DOO8hpcJbC+yGP/x5ztL9iNlOBcBrglJw8RPgmwxRyOeWSM1UI7O9J+4h81rlCNU8mHCbFXW4Eu+IVa52q7Gg=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3910.eurprd04.prod.outlook.com (52.133.29.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sun, 9 Dec 2018 14:26:11 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.025; Sun, 9 Dec 2018
 14:26:11 +0000
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
Subject: [PATCH v5 6/6] arm64: dts: imx8mq-evk: enable watchdog
Thread-Topic: [PATCH v5 6/6] arm64: dts: imx8mq-evk: enable watchdog
Thread-Index: AQHUj8si/ZSCJEp2tUig8gYxGJppSg==
Date:   Sun, 9 Dec 2018 14:26:11 +0000
Message-ID: <1544365552-30270-7-git-send-email-abel.vesa@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3910;6:2p2gYziG8qg2Wsocb2maHpURLWcCKq+BWpYIni04wQ3Rxzfeuc70f0fnL16Pr/Tj6TJjZCjT/yORQ+LfvYTWqVHpJRYYguQoQeN/oGBeC2kIRdltqSffxLKzkizu9zBblbcGtZomRfqj9xiij6dHEML3K//Gbt0gr7tcc3t+4NRqJon/dXtMkKn4tyPhiG/F1F0IiLxOLFAJca+RFaPzUJaUK6HAl8qMyPfaBgfkphOLECsgUQzSmG4UW1v5G/kIV09ZKcCGpZF+g9VlQb+1I6yslK6otBqzPuLS0PT/KJCRAhEgeBTO5eITksh1jECoWdhJGKAuKVA/+Q2XSUTURIKtaqstn+i1vPcAEEf0B9Mex2jjhPqt4fDjpR4vKlNdmoMbBpyP7iVNO5zwvxOiXPJMagu/ymhD3ZU28nQfTnMDtVl3Z19cGD0/YrgKeZn04Nvh547f8XLAHhdkKUytig==;5:FQftOTl0Es0PlBG/OCciPX7JTrSdSZy1LBbBZ5wIfGR30DAZudmX7i98E0WMdDWfuPBXXoVSMpzYCBjEkKYu6qkx15MTaVZzUSJ2fKUXB5dlMm4+ay3ms9RYDOvvdz+GEqOD5l8EWzv2U+LJRXUsDDZPuF6mAcSwN5awmdpWwlI=;7:UWEvtrQJpyrBHNuLwP+LaYzZuTMv9Ut9ONLm7iFYC685EbkayqohYoIm2WFfxU7RKLbBN2Ti36PO1A6VNlVIXIdGxZHdydqxWE+smOpjxyv6XmGQ62paANRjZlvp+cVDYWtMfYaT2JuvJXVEFJTd2A==
x-ms-office365-filtering-correlation-id: 79a89346-a61b-440b-7921-08d65de24447
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3910;
x-ms-traffictypediagnostic: AM6PR0402MB3910:
x-microsoft-antispam-prvs: <AM6PR0402MB39100AA692D1FAC0E3CF9E59F6A40@AM6PR0402MB3910.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3910;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3910;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(26005)(446003)(5660300001)(25786009)(11346002)(71190400001)(2906002)(106356001)(105586002)(54906003)(3846002)(7736002)(44832011)(305945005)(2501003)(6116002)(476003)(486006)(2616005)(66066001)(97736004)(8676002)(4326008)(53936002)(99286004)(7416002)(6436002)(81166006)(110136005)(6486002)(186003)(81156014)(68736007)(6512007)(386003)(6506007)(478600001)(86362001)(256004)(14454004)(36756003)(76176011)(71200400001)(102836004)(575784001)(8936002)(52116002)(316002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3910;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2ZhTxpKYADCjsNyur6+/Z2AhnpyUQqJ/63GnkUAX9Xu77EoWSphdy719yNml79dOB3gk8jNY1GjbgHnf+v8VQCaRlh2mF4RcYC8mpy+UAjP9ac1sd5O1kfc18r92pBSMu/jb8gkSjUKFDXJTBOhQImvC8kxZ+zFM9gjzwEk48W1ys6/Fi/fq6ZCysPH1EJL62yj4b+i41JkCiP/P4B5At2ASnwhK6hWQ2QUPmY/EtNXtbPLAat4N/QBBOpfU9dJrZnDWbnk9tjBa3CX1bDFC7rrI1KR4L/zjT3NXn1zdovpYLY6Lyt5FkR20Itb4PfF3oxJTbLCqsVtAj1SrVp6EdFXTc6zvqABN12jjOje+YX4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a89346-a61b-440b-7921-08d65de24447
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 14:26:11.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

The external nWDOG signal connects to the EVK board reset circuit.

Tested on the i.MX8MQ EVK rev B3.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 04ce13f..64acccc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -160,6 +160,13 @@
 	status =3D "okay";
 };
=20
+&wdog1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status =3D "okay";
+};
+
 &iomuxc {
 	pinctrl_fec1: fec1grp {
 		fsl,pins =3D <
@@ -287,4 +294,10 @@
 			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
 		>;
 	};
+
+	pinctrl_wdog: wdog1grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
+		>;
+	};
 };
--=20
2.7.4


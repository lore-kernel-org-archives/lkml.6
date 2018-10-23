Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D696C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D2B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EMsiPjh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D2B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJWNwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:52:34 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:17654
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726764AbeJWNwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3xET8mbLwCaS95IXGWFK6xFdNuYFI88MKkGVscJEE4=;
 b=EMsiPjh+ro57c+wrYp3kinMWmKPScvdRqtPiIlXDeGb4+7OWpp6n35kFM+Ks/UvkYJuxBsoyx7oKsH1cSRqwoMxEDjaPf7eq0XvaAnejjL/4pbTiXNRoJACQkvk1B6RI7SWZ3t9i/yoGZSbZShLeG0REUxfIWmRpDNfZ7R8aZPc=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4794.eurprd04.prod.outlook.com (20.176.233.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 05:30:44 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 05:30:44 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V1 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup support
Thread-Topic: [PATCH V1 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup
 support
Thread-Index: AQHUapGLcG+0l0YmQEuEyHO6X3Kdtg==
Date:   Tue, 23 Oct 2018 05:30:44 +0000
Message-ID: <20181023052831.2553-2-qiangqing.zhang@nxp.com>
References: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To DB7PR04MB4618.eurprd04.prod.outlook.com (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4794;6:d6PamLuZaBGxYsPK8RZqy1KECE3X6QzVoRodqc8SdRZ+3ATxML+L7gyWdpWQ63k8a2VkUp+A38HeVfvWeO+mpd2NiUIJoGaYAeEvdkMB8tUST7YQC36Z6cGlBOYaa2Q3xbJ7Xseopb+ZudgN+jVwnB36MSn5WTkeD3Y2QrJDV1DgiqA0ChtNYOnIsBpLa7tqkIlZXPm9yZSSQ+y/+i6aZiI73ZygV7nvcfPNbp6Kg0wL4+eVFtbiMWHZC8JEQmPrFEvHzV9fnTjWeqvOGrYJ6e4v29/HzhrfK2VN4COVbfTgJ55SIF/Th3jCYHx0HhAgFlJ0GARTq5Pbg/gGQJj2nv9nhc8bxt8cmbz5DBhmwnizfubov6YKtWcNLX2EQu9Z3ql4GkJ2Q5VoC96czW9JxmPXwS1QlcMD9mw0s+g5Fwu2CYqs/0PLZe/KD/NiJwAxC5HU4uwFxcgRB8Sq53LUmw==;5:q0Rk5mucXHaFstcFpQQQ7TxMQAKzWXtON+HRu8Q1RTzzcCxU4PBbZmf9WUYlIa0UwFaDvTNtPUnsUkwS9vRtuB7x4pKZY02DTtKaZT+2udIxdVn3rz8AA/L5/K7jxoCFnoRB8SrVAR7Y218l2PXG7yvOSPsErlFgKbt/Crony9E=;7:kgQjMS4AF5E4V46faxMksMs8VVXFUKvefxb242ZyKHvxcQ3+NWLakgY/cEmiKGWv4bx+YHZ0bGm5JkFXZmqe1wtV3H8C9Hobb2awvDjmz/vVpR8x+jHYXj2eLe0dyvxt2wgBhBtpqOVUxMxwN1kifq4SDXrdyggnaWW4DSBz1YsZ7MEabGiEgbEIQ5Xsa146PKfAN/e0a+M80ck+Ec1qzOYskfffHvEhcxmH5mMC3Li9lSo/x/pd8anzGtkiO72B
x-ms-office365-filtering-correlation-id: fce1a574-9398-4e06-8386-08d638a8adb0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4794;
x-ms-traffictypediagnostic: DB7PR04MB4794:
x-microsoft-antispam-prvs: <DB7PR04MB47946BE1F9E0D4ECA56E90A4E6F50@DB7PR04MB4794.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4794;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4794;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(81166006)(26005)(8936002)(6436002)(446003)(11346002)(25786009)(2906002)(8676002)(305945005)(7736002)(81156014)(476003)(6116002)(2616005)(3846002)(53936002)(256004)(5660300001)(102836004)(6512007)(6486002)(14444005)(50226002)(71190400001)(186003)(4326008)(52116002)(1076002)(86362001)(71200400001)(486006)(478600001)(14454004)(68736007)(6506007)(2900100001)(76176011)(97736004)(386003)(99286004)(36756003)(316002)(5250100002)(54906003)(2501003)(66066001)(110136005)(106356001)(105586002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4794;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IJofuqVhOlCVkLeouPFF7gV37hGcl6AJq7U0H6rCG1yXGGZ/lWiM2osDxs720rR4IHqoyyD/xj8mo5Oe6yeJ2NNJAn5cIBpc61Gn6f6WOnSHMOmyop30qtx+YeZ2ILJID/9U95KxOJ5zog1nqpMIMsmhQ1pUZCy0TV/2t0iLIAdmq8HitwNgGSrYUQxTx6z5mwk9gO+2AYjxaccf14ok5QNNsj0cAjTQ3kvz1OUA0yBKfsA0AsPQkcGo5trSCgyrKQGXgDxo96HPPGSSowCI7FM7RXEvaUYkuwVq7uEpQl5fikchKNgI9wgUJl8eJ4T1PrhbSnXxJzzUYc7LS+iwmQxxcu8fUhWWh3ubgjiQoTU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce1a574-9398-4e06-8386-08d638a8adb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 05:30:44.3253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4794
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Add stop-mode property which is required by stop mode wakeup
feature.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 844caa39364f..3f459d6da7fc 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -448,6 +448,7 @@
 				clocks =3D <&clks IMX6SX_CLK_CAN1_IPG>,
 					 <&clks IMX6SX_CLK_CAN1_SERIAL>;
 				clock-names =3D "ipg", "per";
+				stop-mode =3D <&gpr 0x10 1 0x10 17>;
 				status =3D "disabled";
 			};
=20
@@ -458,6 +459,7 @@
 				clocks =3D <&clks IMX6SX_CLK_CAN2_IPG>,
 					 <&clks IMX6SX_CLK_CAN2_SERIAL>;
 				clock-names =3D "ipg", "per";
+				stop-mode =3D <&gpr 0x10 2 0x10 18>;
 				status =3D "disabled";
 			};
=20
--=20
2.17.1


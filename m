Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A502C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5162089F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ccs+iViM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395423AbfBNDoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:44:44 -0500
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:10521
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391237AbfBNDon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXG4twRAkYaLsjmzwbjU3xDHne01mU65iLRlM2QjRzc=;
 b=Ccs+iViMP/2VevPmht7IOXV3Bikz5g6F1tuDKokTSIPPclsgz7Xeo5be2BcvVUuIA06JayjuKlc3MwxzH8k2alInZzW2Ur7V2e7ZzaBXmDrMQTiNlO9yS73LUYJiiUU18NSfrM7BmUmeXrndoNN8uaqOSlSQWwXTt6zOo6QKQUg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 14 Feb 2019 03:44:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 03:44:37 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 3/4] arm64: dts: freescale: imx8qxp: enable scu general irq
 channel
Thread-Topic: [PATCH V2 3/4] arm64: dts: freescale: imx8qxp: enable scu
 general irq channel
Thread-Index: AQHUxBebZGnL84gchEe72CRarVHnlw==
Date:   Thu, 14 Feb 2019 03:44:37 +0000
Message-ID: <1550115535-14488-4-git-send-email-Anson.Huang@nxp.com>
References: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::32) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b353fbf-88a3-4896-9da6-08d6922ebddf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3675;23:fyoPuhWoUkYe/+r5AEL2b0lUc9ZCb9JWNd4c2?=
 =?iso-8859-1?Q?OlB7h3cl6A9dgZD8iPSDejRTq6aEBRFggpBFKo90QbW7m9HIIYC1aWqk+j?=
 =?iso-8859-1?Q?kJrUM9XmFefOZJTGYF/43WvMBo/Nw8nV7VkEHyXerpI3DnFI2+jWUlcQb2?=
 =?iso-8859-1?Q?MenY99+yHqVLqKI7KFyI0tXhtKGlKJUKI0taTEtD2fZQLINnUDsPBqFitO?=
 =?iso-8859-1?Q?jq1S4SyPB7PJJNbNQYVmTXiCX0NBtch/mUgK8GsBI8nYxu713a5sjjX+Ur?=
 =?iso-8859-1?Q?QPbPGN2nk5utZOW9OPsCBxx6O2V8eauJjb0PePAhn9QXsvQUyZOErQm9WS?=
 =?iso-8859-1?Q?obk5UYRw2RmkQN//ZETiapRMW7zCJ93yKNkjCljOVYzZn9zkyIMh/j0T4L?=
 =?iso-8859-1?Q?rNPqkAJZ1VbACvMtWnI6YEfPi1TaqHoIVQQehXndbSUryK1xm+rZC4Q8te?=
 =?iso-8859-1?Q?bbqusRuMB7fpC62lRGX/aU3EJjT6uBL3lKRURmxx9g6/qVMWFIK7DUnAN+?=
 =?iso-8859-1?Q?S0jBgDnGzcJitn4xGAUhsVucOzVF74/8OCEYapLRUh2UUKPDlv0kdr4AO5?=
 =?iso-8859-1?Q?DsA0kJO1CSOVDfwOUWnkev7wiAGQ/pnIk6HuFHQ6yXdj8T8ZUHPrtfCuoc?=
 =?iso-8859-1?Q?DHrVvcAP6pAVQRmHGgaLUE62O+9GQ0s/8fZqaTdn/mDpgdPnSH9FgEyaIG?=
 =?iso-8859-1?Q?Ptbzzi0klreVchebjQudpSO6Y5a2RmUzEAW23uGyM7b5qB/iAcKUTR0OTV?=
 =?iso-8859-1?Q?IsEg5XfvzMCj8cBxmKGoF9in3IRVKe41RrzzHTFfto3am9qv5Tzk+N6urU?=
 =?iso-8859-1?Q?QJcTQib3KzvoQc6HT5yTJOhTWlMuxN/zsZhcDpWBIRcTr2uq9xLp9miHen?=
 =?iso-8859-1?Q?ajuWBdDJp8Y237PmN8qqXAF3a0MmzvL17TtMFrklPK5hEdD5C/3NBYw3JW?=
 =?iso-8859-1?Q?v0cYd00J+VJBz0LkugIJz0HYnPozeDWgvaaXzNNV7KgmwOyscII+XcwTDR?=
 =?iso-8859-1?Q?ekTCcfaa04+c+O8R1Vn5drWuxeF6wwnq4JMCpacYusXvT1jD2SMxYhzZQV?=
 =?iso-8859-1?Q?aJujt7LtsE8QgHi1uRtyZBvVaGuivPTiK292NIY7ERmiO6aUnZTXGvug/q?=
 =?iso-8859-1?Q?fLQcHI4gtGS13vCcDcVuxpyHcMR1VNFe5LodNiWoQPM9hLEmnU4YzLybir?=
 =?iso-8859-1?Q?5URtJdKnDyutMY7fkfGv5ZjQzHzRRG2nPjHMhmctDnKxEeb631i0cFY1j+?=
 =?iso-8859-1?Q?o21DYLPN2dUM5tbDOKZnrwg2AIrL8eHmMp1cUiuTCcKLht7sPfu0dq6vDv?=
 =?iso-8859-1?Q?Y6fB550+NTl+o39UQlTWlqmjU?=
x-microsoft-antispam-prvs: <DB3PR0402MB3675E9D18365C2465396D135F5670@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(76176011)(486006)(97736004)(4326008)(53936002)(256004)(305945005)(3846002)(6512007)(36756003)(50226002)(2906002)(476003)(106356001)(446003)(4744005)(2201001)(8936002)(6116002)(14454004)(11346002)(68736007)(52116002)(71190400001)(71200400001)(478600001)(2616005)(81166006)(7736002)(86362001)(81156014)(8676002)(386003)(7416002)(105586002)(186003)(26005)(6506007)(25786009)(6436002)(102836004)(110136005)(316002)(99286004)(2501003)(66066001)(6486002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GPtfJLXfLRjClICA1+vkmXbOAQ1OmK+ZsjoYm3BLsUvZKwFhaAWr0NRTw/98KUWwFprCBaMiZzi+FV/4ApBMG+KqYa7c5neTzcBNHkpk/QT68X8nuRD+e/veR8w1dhH52evFSIcT5WKqC4+2FiHRB3c3ijPlfySSY/x4j+38XF0XN0RAz/+KdUqWMYXkL+kCqLB7MdUmDQujA7WEGspn1d0FoICOPmYZqnxEt2lUgkXEilg8tVFboOKBV1pKaQdaM/thBW6VM6BZE/j7XFFUEGCbA5z0UIH1ZqUR7q9HEcyiQB8WCbU/cdFOQ4kAHncfQ4meQkcTwL1UuFd9oNzw/mR3PWeYK/piDVsZab4UUxJcMV09D11bpmCK5JTFgxQqvuL22viBlbM+nCicQLEjYDQR0FWY8Yyy1/IlZzWacrY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b353fbf-88a3-4896-9da6-08d6922ebddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 03:44:31.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8QXP, SCU uses MU1 general interrupt channel #3 to notify
user for IRQs of RTC alarm, thermal alarm and WDOG etc., mailbox
RX doorbell mode is used for this function, this patch adds
support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V1.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 1e08387..593e2db 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -112,7 +112,8 @@
 	scu {
 		compatible =3D "fsl,imx-scu";
 		mbox-names =3D "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gi3";
 		mboxes =3D <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -120,7 +121,8 @@
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
=20
 		clk: clock-controller {
 			compatible =3D "fsl,imx8qxp-clk";
--=20
2.7.4


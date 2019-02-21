Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6072BC4151A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322B521734
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R3ZWRQYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfBUJUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:20:11 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:35760
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbfBUJUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofn/P8qkrfmb33ItlcOAZ/8Bh5BDu2BN69r63qmUi1o=;
 b=R3ZWRQYr8qcHx3/ASCBubel4GOpEFZFWwtmPqV8v6gS4QStRhAl2MaZQgU5+zpso3YyzyOSihJTPOGLCxrZthtO3EaY3Uwf6dqEWo/yfZ4k34xS1OdU0MLbZbzsVQr8DejtYAZ11xZ0eMWzerNjb6R58xzc5cAMHIjR5E2WNjJk=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3784.eurprd04.prod.outlook.com (52.133.9.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 09:19:34 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 09:19:34 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 3/4] arm64: dts: freescale: imx8qxp: enable scu general irq
 channel
Thread-Topic: [PATCH V4 3/4] arm64: dts: freescale: imx8qxp: enable scu
 general irq channel
Thread-Index: AQHUycaPVtFbouRFnkmRRlSeOfCv5A==
Date:   Thu, 21 Feb 2019 09:19:34 +0000
Message-ID: <1550740354-2701-3-git-send-email-Anson.Huang@nxp.com>
References: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:2f::13) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ece9e8f7-b82d-4f2e-63be-08d697ddb187
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3784;
x-ms-traffictypediagnostic: AM6PR0402MB3784:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR0402MB3784;23:YxWCSTZAid0Ezh1A281Kafqpxyr6Kn+AmffS+?=
 =?iso-8859-1?Q?M+1bJuo2ROuIZZwzZk0+kGXtQOo0jTQ9YTwUHzORCwITVpqHsaYow5U7Ti?=
 =?iso-8859-1?Q?Z88783+Kod3J2t3uUvOOJhsEWvN4ooa8x0BhE3cqGghUKqYzMdqhTsB+eq?=
 =?iso-8859-1?Q?FvJD6yQZ9dQGAo57m2k/zMoR7TzOLFiagRVzHFfFR+bWry7KlNhkzpKL3V?=
 =?iso-8859-1?Q?+/pLENgYNtubo5ODawsbpw0DzsqDS08yZZluxDjmQu96BtZM9XQv1odvHx?=
 =?iso-8859-1?Q?giBFY2imIqkUSePXEOcZRRb63nlRymtZJ+3t9eNLmIzGhGEvPdBGzOkbZx?=
 =?iso-8859-1?Q?vi8q7m4D+YHN9YIQlnG7m3NQ7aNYTxwRFUZ3jfm6+uRdt7WUVqRnkrpeYs?=
 =?iso-8859-1?Q?qMjeMThw1lyrPe2EXnYPckwbrPBzMk2euA6J5p/pPm4f9PeNZjDOPvXQiP?=
 =?iso-8859-1?Q?tby7X8TTNqEuvKasWxh5YB+hNZoUYo4Yf9Ng/QQ+xfY1guG0mDYixi814E?=
 =?iso-8859-1?Q?63pPY7vHqBhO2RNZaoAY9PV0QXrRfM8gH3239wCKp+/iXGRc8ecpZ+8O7h?=
 =?iso-8859-1?Q?v881GZyeCvvoe/K1RCiVLLOs7xt9IQ4njey4WbY4cx2/R8Yb3OQZ2SJnU/?=
 =?iso-8859-1?Q?5uAOmoJol+j6As88Q3T4BI3sSnD4EtFnL+QEhErEcw/Cqefq6AUfkQIboq?=
 =?iso-8859-1?Q?ohGnVA3gb4VMoZQ9sk5S9u6/eWsUUqamRo2bLi/D1jI8TvEQDjfQ23qzCD?=
 =?iso-8859-1?Q?a+DK1YtKV2XlunXpyRh6I6W6EoxL61T52715u3Oz73NxG3t/506zm8vzRd?=
 =?iso-8859-1?Q?s9pDAT5qyT5rLVwCMMAz4kx6MGxWsabpsmfWY6KN2rKLYYzh7HE/wAKH+e?=
 =?iso-8859-1?Q?zf+VDAhBoKSA0HZwmGzUFvghePNqfjNrkOB154zDyyXJAACnq7GZySKLbt?=
 =?iso-8859-1?Q?8oIEilocCyGB+WXKBumZ8VfJYj9nbpTp49UfX0jPJU3Ti1srOTGN91U/1c?=
 =?iso-8859-1?Q?rMZShqOVVeMDUvDMZVN6UPvqXQZ8emmLfTy/OM+heCzqec4GA+Y4ft3tvO?=
 =?iso-8859-1?Q?mxhqkiFw44Ytk0JKpxfrRB4HsoJlzltaS8rvMq2lYyId0zLPZyOZNEKRz6?=
 =?iso-8859-1?Q?8OYzjrE5p2H6N7oIYmAijuk9S7q/JUW+nUeojfT0GvZkWmpIxd338BzXeP?=
 =?iso-8859-1?Q?TrpAXfKN2o4oh0Oc4A1KGsl0mGMFUPdVmVrnqdySnjp440JTijRMctLyCb?=
 =?iso-8859-1?Q?GOWAU3iANn4JAZ9XBLZNfsp2tBAx9FhOT3FL25E8Tv559WSuVbZoprXJ4f?=
 =?iso-8859-1?Q?pznqbtJnKpUqIebYoVsjVkFge?=
x-microsoft-antispam-prvs: <AM6PR0402MB3784E1AE07B66F15BC51F287F57E0@AM6PR0402MB3784.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(366004)(189003)(199004)(71190400001)(68736007)(71200400001)(14454004)(66066001)(26005)(386003)(102836004)(6506007)(186003)(86362001)(2201001)(316002)(6512007)(36756003)(256004)(76176011)(99286004)(305945005)(2501003)(478600001)(52116002)(97736004)(7416002)(106356001)(50226002)(8936002)(3846002)(53936002)(6116002)(7736002)(105586002)(11346002)(5660300002)(2906002)(4326008)(8676002)(81166006)(6486002)(6436002)(476003)(486006)(81156014)(2616005)(110136005)(446003)(25786009)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3784;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GIp4wJ2MtdWv8gIspwb58D42FUaE6U5vuPQbNLqQ9URQ5ko7dZHCU2Icc8iyeAZGPjcPsnkGqwYbRqHQeTE8xsFVXADKK6HDdszSTOX/lpgHHdQZ9NZkAbQwry6onrIUKAvY6bQGPd4sCtpEFxx4WmFlWsvXFAOF6+gmW7oPDf2TNh1s4SpD+5tDnrluv4fEdvF5a7ikV4gZlzzJ3qLgSmBka3jYrTxLaS3a+tvUWz3g/rVV/qsf79a3Myn5l9V6zObf23hiXkEZ0DAqrBqkobLKT3Uj0/JRIY+59bp7ekWTF7lZl7xdDw/zfWTwjnPKymn8b4RW6KBoUkss0IgHMtx87/iY10+3zFcJ6pgl8kPtyXMjxyaEn/qNeFVa6SJbGznb/yP61JCBPfka4gQW5KzXQvEHBve0I581ADGDT+s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece9e8f7-b82d-4f2e-63be-08d697ddb187
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:19:29.0545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3784
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
Changes since V3:
	- rename "gi3" to "gip3";
	- add alias for getting mu id by driver.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 4c3dd95..f0a9224 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -21,6 +21,7 @@
 		mmc1 =3D &usdhc2;
 		mmc2 =3D &usdhc3;
 		serial0 =3D &adma_lpuart0;
+		mu1 =3D &lsio_mu1;
 	};
=20
 	cpus {
@@ -87,7 +88,8 @@
 	scu {
 		compatible =3D "fsl,imx-scu";
 		mbox-names =3D "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gip3";
 		mboxes =3D <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -95,7 +97,8 @@
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


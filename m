Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34F521B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wxQ/Nhlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfBOSHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:07:31 -0500
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:62496
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387497AbfBOSH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w189ljzm0VaqugtVo9tpZPHp05AlfHj0Dcxzoa0eJr0=;
 b=wxQ/NhltAvEyUyIfp4j5bkXFjQUvfp+iyYGoBgdhfulOZrGi3WKAOfJgd9IXEoJ8rvWZLLNMW3BW+HTl08ttb/IwNC9Hl7dn1aBtd6KMVDbU0F1kPmOlpgmZpPl9DPsYXHIpAM/9xCwBTl9fUpRGCyKRbidqfKVOjF9BhiKzzZc=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4385.eurprd04.prod.outlook.com (52.135.149.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 18:07:22 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 18:07:22 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 1/3] arm64: dts: imx8mq: Add the clocks and the latencies
 for the A53 cores
Thread-Topic: [PATCH v2 1/3] arm64: dts: imx8mq: Add the clocks and the
 latencies for the A53 cores
Thread-Index: AQHUxVlMOnMGYj2UEkGIzXXdUVdTXw==
Date:   Fri, 15 Feb 2019 18:07:22 +0000
Message-ID: <1550254032-16451-2-git-send-email-abel.vesa@nxp.com>
References: <1550254032-16451-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1550254032-16451-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0043.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::20) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27cef4af-9b29-4796-d058-08d693706e84
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4385;
x-ms-traffictypediagnostic: AM0PR04MB4385:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4385;23:TWTBsXv7PCuAbBe4dEPBIh1K4TsgL8yRSplCzyB?=
 =?iso-8859-1?Q?wXzShQt/DRNU+0018hVb+a3L3wvs5no9kyJAPZS5QVS7wU18JTl7eMYJBV?=
 =?iso-8859-1?Q?chUguT+rOT7Pw9Ip70N5uD3Gj8qw//MrEwA+3J75rU7NK87joevJiaCtlt?=
 =?iso-8859-1?Q?Qpk+Ezx9oZ3TS616gViHGDcN9RihzaEdzVVc3IGFJIKjlcfUQG76eQDEb2?=
 =?iso-8859-1?Q?d0XE7A7rw1janDsiXmYRIg9FNo4QAYLEkiEEA4cifqKf4Caj9rVhuVNF1W?=
 =?iso-8859-1?Q?q9ywoqQSxxT8l+M6svHFhgqeHi6hbltxnf+1OVFjqw6L+ruiQCk5q2qA/0?=
 =?iso-8859-1?Q?dTUaJIKnyrAhDdUqhGjGp2oucEqlHDdNOUe2Cfbr3J9fARhxWjkCSSzD1D?=
 =?iso-8859-1?Q?CwosxOGs1ikJAXDbc5z7CiC3ffyZnN6i6vVBDZoUAhH9wrqyHQz5EtvloW?=
 =?iso-8859-1?Q?UnExiv6pGTuD38Lc0ZJFP82rG8IP9gTF3WZk/sWC3CEe6iGmOc6RPE0d9H?=
 =?iso-8859-1?Q?5HREyVysx24dBelsXBhHSMun4XiH/XKjSVGYras/Dgyo7S2bAzMNkySaTr?=
 =?iso-8859-1?Q?pHxn68Mt/ZdCvK6EvdS6T77JPiDvnhzZJ5FBlUPPoWmtPZn1uryGYFO6cs?=
 =?iso-8859-1?Q?XIoIZxCUCBaaI8dugMnJI28IJeJPs2nqWRnJHJq/N+0MfBz5Y+T7XUQGdu?=
 =?iso-8859-1?Q?iHD5umTVKyRokmq78CiDEC/BnqthASMZTZhdNNIdmLCI7iGzbJnwB/AiHx?=
 =?iso-8859-1?Q?KCPgFfti8KSdekYFsgHcBQyKi61Zu4vpmxPiKdbXsvJ6UEH6T3zVyjREjh?=
 =?iso-8859-1?Q?rsoGZcbOiAWnU8nGfOtY1+tabDXxar7lbiIGqisDTkCqOVYPmscfX+XTS7?=
 =?iso-8859-1?Q?aL7PmuH+DKElEwuLaLLPDZd9entElzR/aUoRQ5PkWIKS3rXWSzpAZxERxu?=
 =?iso-8859-1?Q?jWVbzSJTo7Qk9+Wmcd4Kdg8Yn834lHu7vPmel6hz8Z/yHE2ExuLMSC2vc9?=
 =?iso-8859-1?Q?iWjA3oCKLVtaNiCfl8MAbocbwtj1jsGXioGH8m0rkswQIeKXse7pS+b7tn?=
 =?iso-8859-1?Q?XWzqsvQqAR6fXevCJIcuoJyDabot4Xk2lmv3MKOvG/1u7Lmjw2OZTzN/kX?=
 =?iso-8859-1?Q?3jPUXmKgTnZMCeRDOG6WGU03sZdqKTFf+LF6YWeo1KY/C3sYL8kSaq/7dA?=
 =?iso-8859-1?Q?yuNXV/XvRhG3XAvIKpWM7rqCbeoJ6ImJ+rjMNTqUn9f8r808bkFhb6Y3wv?=
 =?iso-8859-1?Q?U3Q1S4p/6AUUbar7+?=
x-microsoft-antispam-prvs: <AM0PR04MB4385ACAF2A71C2E25C75232CF6600@AM0PR04MB4385.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(189003)(199004)(305945005)(86362001)(97736004)(71200400001)(71190400001)(446003)(102836004)(14454004)(66066001)(478600001)(6506007)(6436002)(386003)(2906002)(7736002)(106356001)(105586002)(44832011)(8676002)(6116002)(81166006)(36756003)(81156014)(3846002)(476003)(486006)(99286004)(52116002)(2616005)(8936002)(110136005)(76176011)(256004)(54906003)(316002)(26005)(53936002)(11346002)(25786009)(6486002)(4326008)(6512007)(68736007)(186003)(50226002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4385;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u/Wy8wcMUdXjO+slWLjyRDH+DEpR4w//7nXD9AcMjqIHP2uVYo/G9Dyhn1HGPztRTdtr//fjSoDrqQgGGNYQx8Io9lArRA8dt8L4iUE0RjW9MkpGns5P+i71S1K6q0JzrlPoCWZHZJAVLfx5kLxbLvcy3fN5qSIeBI3qw4126qw2z4qHTdnNwqpPVrBbwZ5tD5RQv4QkpUCvosIz60if9fFMoD+x+sFDWuQD4XwDTKLEzbe6te48LutJ04+h7+R7yIi4brZVXP4m2BEWxQur+SyTuHDW+iWqnH2N8kXnLD3DJMXnx5lso9f8rIJfOoRiHa7l4voyWhuaaObiJ9dWs5iKAzt7QU/eh9ryp97nJ7nDuTaCHTd955SzwDBRXf2YEAarggjG4zGicAJ8OSlH1f5UZMntnZoP+4SiyaG6AKQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cef4af-9b29-4796-d058-08d693706e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:07:21.3127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks and their latencies will be used by cpufreq-dt.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9155bd4..1a89062 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -87,6 +87,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x0>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
@@ -95,6 +97,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x1>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
@@ -103,6 +107,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x2>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
@@ -111,6 +117,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x3>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
--=20
2.7.4


Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F76213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c28tySfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfBYN1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:27:13 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:5026
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbfBYN0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX6q6lc+tbP1OZ3w/LXO0CGKRYLxDEuL2tCmm+8URqk=;
 b=c28tySfHqhNrh4S2HhpdLUYgaWLsG45xsS0fDXVunxqqtG2w774SbJktj2fTrif/7/dXZ/jQ74R7f95LwVs5ZppYSJCTf45u6p93r38mWp0SyDGCeeFJyiUtmcDW2wu5Zuab6FzkOejNwlolRjOz8eZyKNRXceQpCbat9J0c8sE=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2848.eurprd04.prod.outlook.com (10.175.23.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 13:26:39 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:26:39 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 4/5 v2] arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
Thread-Topic: [PATCH 4/5 v2] arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
Thread-Index: AQHUzQ297yImCNxuE0SjFgDwYcA5Nw==
Date:   Mon, 25 Feb 2019 13:26:39 +0000
Message-ID: <20190225132617.10987-5-daniel.baluta@nxp.com>
References: <20190225132617.10987-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225132617.10987-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0192.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::22) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc0825b7-51db-4f30-c349-08d69b24df98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2848;
x-ms-traffictypediagnostic: VI1PR0402MB2848:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB2848;23:2bqlfVPLcIm+oe9OxLQWdmRdaMyZ5ezxbIdk2?=
 =?iso-8859-1?Q?By9L4X+PHYmn/0KzwYSxEiH92DSz5/erGZ7yfSX1Uzm8EEe/jEZKcsuRxQ?=
 =?iso-8859-1?Q?l1/yy5DnEi5xhcihh3wmNvf1MUcHgj//FvAaqai/41nWoFxEVl9eYnIm06?=
 =?iso-8859-1?Q?Ug33iuW2Ktwn9tua4q8KZyxQvUzVCYBdhp9ynmcB99pyhStgrXQwMkzcFd?=
 =?iso-8859-1?Q?/yxvbocRv3sdTgui7M+g8HBk9xlUxR12jwoaGa7Eu6kfH8yauZ11pQa8ik?=
 =?iso-8859-1?Q?5whKKOUnj7mijn+obEj/IuV/bKTn/lJ9nUejpFSeFE/UvvqowOAD1UZPZq?=
 =?iso-8859-1?Q?BIONZv1YOZ4bNYS1SZZp6dkZuhnOQodqxIMA0zlWv0BDHEENAXU/ufc69n?=
 =?iso-8859-1?Q?kYffzM1fOlK4l7kCZwA8hvQW8xcXsWMRxn3T3z4iUMJsppbMFFpcEXcpoy?=
 =?iso-8859-1?Q?5rDMWI4+bPt97nWm52yd1u8a5YyN6Uq7CSBom5PLjbv1++HVccCPFWR2gF?=
 =?iso-8859-1?Q?Ru2eyf2Ie5upaFF3+NfhyuUl2Gq0e9H3pEIloFTa69TfWJzh/9qCEFfKwN?=
 =?iso-8859-1?Q?LfXB0bBTh4Dml6O0k47bFMC+WYATW5DaAdkxgLUHB/R6YkkdCw8oehBrkD?=
 =?iso-8859-1?Q?KwBARxOAY/5B403uulAAxI1Go1N0FVggTn75Q+9UOfaiIKss/t5dcjIq7B?=
 =?iso-8859-1?Q?lvkmOVslJMPUJYbStQwcCMGMTmq5vAWrhEUHaQFreuVyT9Vu8LRVDJhuij?=
 =?iso-8859-1?Q?+K1Fp8C0GUvRyPBnzpu8bsaylvqG+gT4aA/ny6hGTr8vs5UZT+GsJ5W/T2?=
 =?iso-8859-1?Q?z9cHO99QY/NHf7abLG8dRMgsF0EM+Zqxl4dDYDCzt91TKNNWg9tbebMGfB?=
 =?iso-8859-1?Q?y8QzOrxL2YaHzBd76VHEF9N3ZhikrxF6+A/XqxAaoOocFsgj92KHOQ4rx0?=
 =?iso-8859-1?Q?tL/+MeK+KrmWAH0fXbLE9E/Ijgo2V/EOt0hdtKLciFMjMmiqiWOWlZZ8XW?=
 =?iso-8859-1?Q?0t4/pqtLR4OVqBEeLZ8NhesFrdm7gid5wvrvYPIuCd6ipW7osct681PGwO?=
 =?iso-8859-1?Q?VUMuDxrSjn918k8NW+GRJP7ITivdrjQTO27MnzlSQSefak60t3X8xUrfa4?=
 =?iso-8859-1?Q?PL461EsafxJbPOFeBktCl+Hw9HWpYMttrMw6JRFwZ1GynTPRCmW4Gc6zcf?=
 =?iso-8859-1?Q?2ieisgcWzYU8T4ZpfAUnyMj0QGVXHi5HfN9ZteJkjTfd4+ZNSLjy8IJoSl?=
 =?iso-8859-1?Q?W6HPnGoAgREA5fPCKW/qUTgrof7iDMAqepdcQBOSYYpTIyYbck4UI3eQKP?=
 =?iso-8859-1?Q?eEZTak2gkSaF5xo7DpbB+9TnZyNV19O7S+JjJR6V8JdJFbKVhFshME7oBU?=
 =?iso-8859-1?Q?0f2Z+RSdxaCeZg7RyiME1yQQ7ngzOYcF0M0CqMdyw+cjIGgu8OxxduJJh4?=
 =?iso-8859-1?Q?kjTSzkxzduYIDZLP+CLkHInPRn9VXvzVkgR4AbUKQgGlnXdTEr4KYAImvr?=
 =?iso-8859-1?B?dz09?=
x-microsoft-antispam-prvs: <VI1PR0402MB28487F85963D6179F2E87FD0F97A0@VI1PR0402MB2848.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(6346003)(66066001)(4326008)(68736007)(76176011)(99286004)(6916009)(256004)(478600001)(7416002)(386003)(97736004)(25786009)(6486002)(2501003)(26005)(8936002)(6506007)(14454004)(52116002)(36756003)(186003)(4744005)(50226002)(102836004)(8676002)(81156014)(1730700003)(53936002)(2351001)(11346002)(106356001)(5660300002)(81166006)(316002)(86362001)(6512007)(7736002)(305945005)(71190400001)(2906002)(6116002)(14444005)(5640700003)(3846002)(6436002)(54906003)(1076003)(44832011)(486006)(446003)(105586002)(2616005)(476003)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2848;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2C3qVw3ly5rhYyQLlNaP70G2IEqIhhK/cO1jvmYJQQrCHSBnUQS9GZrgk0xA4VALj/rME34IuUIIJTyBqM92+lTjGh56H8P4/g5rxa7f3t1sT+sy3RTkyFjEcJXJxf9Q/ZzWCLk5RJTTNESRz1Mheqc8G6vEX3xY7Ve4c+UQI54l4WALia+n3XvxnCdODUAwYABwLllPAxcS2LzwVAHI1v/E2zzblNTXTRkEAd0GGbdjWfcHNYFL//9M720LxCp7vjvN8weCG3Ebpce/Vy2CifzbjcmKX/N6OwnaiSnbhSgGBts3RC8FbpMzmeRHoQQGIoc2f5hWfRCQJOkRVnGfDS0swBriNlxm2NWEeHDnJi/gYiL4NpMWDtHAqAN0Er2b55NR/RvI2JjfrUeJth8MyDtYwi5B0LFTj36r/rJSpP8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0825b7-51db-4f30-c349-08d69b24df98
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:26:38.4247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2848
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables SAI2 digital audio interface to be used with
wm8524 codec.

wm8524 works only in slave mode, so we make sure that IMX8MQ_CLK_SAI2
has an appropriate frequency in order to easily derive rates divisible
with 8000.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index d21ee2a5312c..58de4a3d6029 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -52,6 +52,15 @@
 	};
 };
=20
+&sai2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sai2>;
+	assigned-clocks =3D <&clk IMX8MQ_CLK_SAI2>;
+	assigned-clock-parents =3D <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates =3D <24576000>;
+	status =3D "okay";
+};
+
 &i2c1 {
 	clock-frequency =3D <100000>;
 	pinctrl-names =3D "default";
--=20
2.17.1


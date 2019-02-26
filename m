Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3674BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE522217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aKuylAjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfBZHI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:08:28 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:60768
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbfBZHIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX6q6lc+tbP1OZ3w/LXO0CGKRYLxDEuL2tCmm+8URqk=;
 b=aKuylAjQlYEpv0I5FLo3SE/VpO8h2ENeB3QM01nv70hwa5UbAMFO3T7QSv3/KE7BVyBALhc4RrHMcQD/B+24wcnEkZkx1W8wRpvB2YmLFDYAVBN039lzDPB1CyN47FrHH7qTUTNWzmJZzA/W/l0ztZXTNUftoTv7beZhrjGuNhw=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2848.eurprd04.prod.outlook.com (10.175.23.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 07:08:15 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 07:08:15 +0000
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
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 4/5] arm64: dts: imx8mq: Enable SAI2 for wm8524 codec
Thread-Topic: [PATCH v3 4/5] arm64: dts: imx8mq: Enable SAI2 for wm8524 codec
Thread-Index: AQHUzaILlyGCAEJNX0GZm0XebkNjIQ==
Date:   Tue, 26 Feb 2019 07:08:15 +0000
Message-ID: <20190226070742.30551-5-daniel.baluta@nxp.com>
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
In-Reply-To: <20190226070742.30551-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:803:64::37) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f99b7e5-1555-4652-21ab-08d69bb92d79
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2848;
x-ms-traffictypediagnostic: VI1PR0402MB2848:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB2848;23:dEZrDLGYQM/8x5Ze4mYoblb//P3HnS2D/gvrH?=
 =?iso-8859-1?Q?5QXOnsQhhwQ/h/0q72je3/nX5eD++le931FmffaZice+Lo0vFi1eCehdzB?=
 =?iso-8859-1?Q?7WCnKs9a8XNc86wO25F5wulWWgSEL/2WeZ8Jj/2jy/Hg5KGs7TRWCxKSgA?=
 =?iso-8859-1?Q?4rS2mcQH5mjXIYrdk9rpULlCtmeU+ojhd0T2xvmPh1j1+gRLFmL8wHhH5p?=
 =?iso-8859-1?Q?l9e8bT6zmi9vjr94X5eN0nPDW6iW5Y1uIBqR2xDBlltVPQ0r+S/RTxOJ3e?=
 =?iso-8859-1?Q?z6f8KA3du/1hhgNh0eVvyrFNpPqYe2h7mIjfLl6ihizJqjwReQHAFnBd66?=
 =?iso-8859-1?Q?3WSgWrJ2850Dy4gDfJRfqG7Olz1aJ0jAC3QdG1Qqyg5T8lc6RAsxDE7+Zh?=
 =?iso-8859-1?Q?iU6pa//0qR7VewawAgFqE5BL8y1dIfujnbUZWgMaPUor+5wp10aetcmHTA?=
 =?iso-8859-1?Q?IiB0oeDjNzNKB5ngBBC22hl+Ym7Zk492H5W3aTI+Him/NjRqz4u7pblGYh?=
 =?iso-8859-1?Q?L+2K4WJ+rfCmNsW22qWpW5ZJ1NBHkvkXBu+fWkPzggcbMan0ZrnAtI0dUT?=
 =?iso-8859-1?Q?UOeZXjWlyXcmPaS1DS5nkp9y+3jeXwqQ0oQxgkahGVYAWap+J7NPqgJY/B?=
 =?iso-8859-1?Q?iBnQFY8yKvqsFYTL7aPB4ClIHRY2hSWfz44yzOa1ooxFDJ/grVZ8evfL8L?=
 =?iso-8859-1?Q?7Y5k1Qqy+p46DWmeZrixLngeej1GDW4es2hacg75qVjXRacCQJ7rbEZluN?=
 =?iso-8859-1?Q?msFhDoiDm5tx7J+2sCnGijupIAeRNzriKCzzMyglYiKrOmjQmcTTUsODtX?=
 =?iso-8859-1?Q?uW9qb+2oatILGUb0ZzZ0yiXoqxPIaPK5eoKqtMzklNSKgiMfbSY2NYJnWT?=
 =?iso-8859-1?Q?mKDKeeKg13cDidcj/vkDc2MCt5gbIuGX5avWjnBFy7h70pKrzTSH/AQfYs?=
 =?iso-8859-1?Q?T2c7xRkOB9b+TZiBvPzW5nREP2SVx2Oqg2x1puCYubSehRwBbnCG3zZQJ+?=
 =?iso-8859-1?Q?llnyGSbX7IHfI4sqTeqr55t3LYBZTW2HDxJ6BAlp83fGzIrkNJaornY9kj?=
 =?iso-8859-1?Q?pmS7j78y8YcOi3W06Lyg6MP0xpoupauk1Jqpl1+NTL0KFU6galLrCVjX/R?=
 =?iso-8859-1?Q?tTPGcZpb3jeQcgrFwyWExvjeyxiVKf/Zcj9GLeL14B1bi+RX08wOLb8U3L?=
 =?iso-8859-1?Q?o5E/DGbnVtO60DrGjdZ5wvmqL3aMBOb5aS5gXmKMTgr3IexImA/dG24+y5?=
 =?iso-8859-1?Q?WjmJVGaWBHI5MKar7Bglaw1A7V0ZNcdHzTDPeIYTT0ZMudP5jtvjEjPsB8?=
 =?iso-8859-1?Q?B4wKX9KeGx6yuHiIZy5jQrhcsTVHbcwgGF+yKH15at2KUgXvp8okKzkqqV?=
 =?iso-8859-1?Q?xxwA9le7RTcRcad8sMn7hpXt2zOb2b5wrRQIPnkZ+0cE3Ghi5xlySP0kkk?=
 =?iso-8859-1?Q?+mWeMuHn+3AvsrQ9jIBOr9eYwPGQFsnw01lJqAXmvQ2pMpGySw1ROcez3P?=
 =?iso-8859-1?B?Zz09?=
x-microsoft-antispam-prvs: <VI1PR0402MB2848DA0565D4E34E2915330BF97B0@VI1PR0402MB2848.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(86362001)(2906002)(316002)(305945005)(6512007)(7736002)(81156014)(1730700003)(102836004)(50226002)(2351001)(5660300002)(8676002)(11346002)(53936002)(106356001)(105586002)(81166006)(486006)(446003)(71200400001)(71190400001)(476003)(2616005)(5640700003)(14444005)(6116002)(44832011)(54906003)(6436002)(1076003)(3846002)(2501003)(256004)(478600001)(6486002)(386003)(6916009)(4326008)(6346003)(66066001)(99286004)(68736007)(6506007)(36756003)(186003)(4744005)(8936002)(97736004)(25786009)(7416002)(26005)(52116002)(14454004)(76176011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2848;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 62StNLE8vjpp9f8GIvOpXAgWUXs8QkDq0ByIYg4c2QJ41aSffhSvNzGjO71gvqWjzok0RbLAhrSRVl1MPA+5RLJicZdpYRAHp/Kc99V9rjF08s8C6ZxKWN5aqKUzUeB+ZDHCm74A0uJMPGWT/xgTbLMVvFw9tW2cwRTqSM+kWQnZwM3UC65pI9sMOF/B1e9LMShpE332uYwEa0S4lSGYER3VXMbXqYfs4iDY7RGX0t7jALnWgrzjzHca+sbJKqPyE0MrPaoENt28Hynaf5eTwFaRgjuvrcEtcxmbvl747C36asN+r4VzYs72157XuQJpksUfJGh8khZFS2HnS9BjM7yoJGSCj1SJgEsHjjOUIpihYyK4R6IUq7mV/NM64xUWzAilEKJTHN32OhKS5zaxWnt4ZMhZ6MMdH16mAFNX4ak=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f99b7e5-1555-4652-21ab-08d69bb92d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 07:08:14.5776
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


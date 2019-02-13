Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB03C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7712A222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lISvBKZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391294AbfBMTFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:05:24 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:5779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392159AbfBMTFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep2w2cZAfcfxXLCNjmOf3YUxLKRZ44/siUE9rL1xvpc=;
 b=lISvBKZDJNXyuOcawYYRMVYjCko46qEsy5kbHl8r6FbAAeTVtOyb0TDWaIdPiMA/DohduyFsuJWVqr4tSoKV4b2WH+Kirik/fsj0E/ZW71WkFE7wwUf4G17aiqZSTWonFq/BVgEp0AqK0psmYqji45mI/votMB0SmB/DJLbclOo=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4515.eurprd04.prod.outlook.com (52.135.148.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 19:05:15 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 19:05:15 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 3/5] clk: imx8mq: Add the missing ARM clock
Thread-Topic: [RFC 3/5] clk: imx8mq: Add the missing ARM clock
Thread-Index: AQHUw88NcMpiZioGe0qpdfUO8mvjtg==
Date:   Wed, 13 Feb 2019 19:05:15 +0000
Message-ID: <1550084693-9797-4-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0058.eurprd07.prod.outlook.com
 (2603:10a6:203:2::20) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6638f32-0c52-4fb9-a8b5-08d691e62fe9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4515;
x-ms-traffictypediagnostic: AM0PR04MB4515:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4515;23:PXtsI8l0GOwS3P2DEVazcrc2dmYJsvQJRrgfW4P?=
 =?iso-8859-1?Q?XGG/Hq3yoHSbgbhSwzyRC4z0/YKFgWBg5DAk84WtRNvnVaWcJOyVIissWB?=
 =?iso-8859-1?Q?NrFy+kWEIt/39kY+KxEX3Y21BBQnXzLvaEuJH9My+bVjsafgHQs0ashzJ+?=
 =?iso-8859-1?Q?b6iv2oW071VFF/N01D0QhNwj5Xp549HFnuJr77lYL8VX+iEiwvgucW57Fw?=
 =?iso-8859-1?Q?Qe5lnHmIYASVZ0RjTa2OUXthVeNao7ZWc9yIcHBs2PKWyBzHQpraHtNMSU?=
 =?iso-8859-1?Q?tZ0bDz623RZJ69xORSkYvHVzeb8avngXene+rzDP1BTMOG8F5t9Rqhmm36?=
 =?iso-8859-1?Q?yd+rJ9SyTvPY3EARrGu/WIEYKTa7OMfCrdyef075MrQDkmiBIys++aaVme?=
 =?iso-8859-1?Q?PSYfc698B1dKp+0enACIqap1drjjj9/xO5pGP+zMor8AsaBok2O76l8bLf?=
 =?iso-8859-1?Q?T+qudw7iJi6PcEnF/tETuUTsO+5H1zpANfq5kkfLzw8yESdLBCq77HHXBR?=
 =?iso-8859-1?Q?DJfkzHpj0cERJWVN7lyhxSJJxSK953iiPioirgBEdd7phkfeg9J7dtzaDJ?=
 =?iso-8859-1?Q?2N5SbMBQBg4aLpnxjIOJd6g3OdAtPUi22m6/CNKjZQiH47crjIcP6Fs/30?=
 =?iso-8859-1?Q?TGtB4+in+18cDNroc758rqHtnssX+CyfnhlX7FDBDbMPU1i10tdv4WQSgJ?=
 =?iso-8859-1?Q?fbRbKjIwI77hOZ42pS0uFd5r6JkKRRjTc+YGwXhzS9XfNFWn1/ctprg0pD?=
 =?iso-8859-1?Q?MRlG92vXNWGt7ikinCaR5cJibb5z+/CI+ZUxwf43wUyKEReD5LUWpE4ib7?=
 =?iso-8859-1?Q?Wscw7Qji6DHrgkpx+nJEbCJiNRPak8fc0de0Mrk2TTImwiQqYkIvUW2Qfk?=
 =?iso-8859-1?Q?hEoHQwqiIFLwqoyWkrciSlbkT+E0IJKMfCY8EX4lWQmDDJicQHDr+aWMGe?=
 =?iso-8859-1?Q?pcKuzt9r1S3GZoFogFpcHfvr/k8wiU/rWe1YSVcGhOgzNaS+KUb07rdeb2?=
 =?iso-8859-1?Q?oMxJTkODVSrNeJ3e9Uuo/Wm5QVTIU+++8dvcv+GdYjZM78hRp58NTmniJj?=
 =?iso-8859-1?Q?Y7YEntQSW18PPL0XG2L6aEE7vijvxcBXr/DEw7f6mnzq4N/suU548LaDL7?=
 =?iso-8859-1?Q?8DyOwcVsYYbEExLy0HrP0vV2dD6yDb5NFbf4yVPE7npdZSdTaAspaW//Y+?=
 =?iso-8859-1?Q?pevY3XetW/an7P6lYO4C1VATtPLfKKkPIsYFeqjHeF/jUBAhh+vO7JKlip?=
 =?iso-8859-1?Q?Qg61e7sUiZZU9gV7uYf5lksBePp+RBtWp8YA8QtW8CEw+Dhx1743BxaMLA?=
 =?iso-8859-1?Q?Y6RQ2eAledLnvXKtI9O6hxY?=
x-microsoft-antispam-prvs: <AM0PR04MB4515A2E41CF3479D5C9C3EB5F6660@AM0PR04MB4515.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(4326008)(52116002)(2906002)(6636002)(3846002)(6116002)(99286004)(106356001)(105586002)(7736002)(305945005)(25786009)(97736004)(14454004)(66066001)(53936002)(8676002)(81156014)(81166006)(68736007)(36756003)(8936002)(478600001)(6486002)(6436002)(6512007)(50226002)(110136005)(54906003)(316002)(486006)(186003)(2616005)(476003)(256004)(26005)(102836004)(4744005)(11346002)(446003)(71200400001)(71190400001)(7416002)(6506007)(76176011)(86362001)(386003)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4515;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mYnueK+3dXUPxokeVd+BL4upnkq8vq60rF8xUd2XUxKwTjYVItJWa19jB9Vy0hE74lY6H3NqFIyjXmdRiSkhVFXqLISDJoWrDJSwH8NGbLln71nEZEC6d/8ZeCn749hRXiCEpZkizMrkAO5ITyG50MmB5Y8AUPkR3UG2iiU/iWoe2DW5Q2dv3Tp8cNnrjp9fy+lPajdVFZXXLHMfG9cjDqeHLkI0cjHTGsLS+23JEZMBztpHDLPBJ9k9Eb2/RhH5u5UnttvvO+bUyNwD26e0+0p/DhrxBwsLQh3gas+KZyEGdyPAP0TocwKkng7T5dF6beRstfymGeKZ4ZGnBH7sP/PMWbELe1QFpn1+Ur5ozwe8nPruEK5DirR2OLv3UF7kJRhsZxre6DH2EKHx7IIz74JDout6HEj4QTOrasLyahw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6638f32-0c52-4fb9-a8b5-08d691e62fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 19:05:14.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ARM clock as imx_clk_cpu type.
Will be used by cpufreq.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 57499ed..8a283cb 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -558,6 +558,12 @@ static int imx8mq_clocks_probe(struct platform_device =
*pdev)
 	clks[IMX8MQ_GPT_3M_CLK] =3D imx_clk_fixed_factor("gpt_3m", "osc_25m", 1, =
8);
 	clks[IMX8MQ_CLK_DRAM_ALT_ROOT] =3D imx_clk_fixed_factor("dram_alt_root", =
"dram_alt", 1, 4);
=20
+	clks[IMX8MQ_CLK_ARM] =3D imx_clk_cpu("arm", "arm_a53_div",
+					   clks[IMX8MQ_CLK_A53_DIV],
+					   clks[IMX8MQ_CLK_A53_SRC],
+					   clks[IMX8MQ_ARM_PLL_OUT],
+					   clks[IMX8MQ_SYS1_PLL_800M]);
+
 	for (i =3D 0; i < IMX8MQ_CLK_END; i++)
 		if (IS_ERR(clks[i]))
 			pr_err("i.MX8mq clk %u register failed with %ld\n",
--=20
2.7.4


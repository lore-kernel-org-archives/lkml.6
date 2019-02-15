Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A420C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E422064C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y82AD0Fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfBORtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:49:00 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:41470
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730575AbfBORsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIp1/4qU7H5VkwyXcWHI140IWKCAnVvYk8dEvmy+bTI=;
 b=Y82AD0FwMYpQZ/QYXjW5QQu68jfXY693UiD/QcdxW+quL8DT91EhvhWsVoWyOz6f/vxG6KNGTHxlDtfmsVKF2F1mAnj1ArNAzNbhmN/18yA702AR/1SUpTnPXIUJoyFcFJmQwuGzcscvIWONtcGRJ5oMx6Qf52VzFgh9Ine2QOY=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5330.eurprd04.prod.outlook.com (52.134.93.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 17:48:46 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 17:48:46 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Rob Herring <robh@kernel.org>
CC:     Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 3/3] clk: imx8mq: Add the missing ARM clock
Thread-Topic: [PATCH v2 3/3] clk: imx8mq: Add the missing ARM clock
Thread-Index: AQHUxVaygt4K7Vtjfk6EnO4JuLEpZw==
Date:   Fri, 15 Feb 2019 17:48:46 +0000
Message-ID: <1550252913-24532-4-git-send-email-abel.vesa@nxp.com>
References: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:209:1::22) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d96a003-087a-4786-60c3-08d6936dd533
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5330;
x-ms-traffictypediagnostic: AM0PR04MB5330:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5330;23:DN/dbthU+h7HIO9Daf5np6YLy7Wazu0I81SUj30?=
 =?iso-8859-1?Q?zebH7n+VxTeke9DXIfD9E0HO8a4p9rXOynpsq1yubnUGt6eMasYLOflDXG?=
 =?iso-8859-1?Q?45D8G9zzJhgfjzGb9vtWn+0TMPUGSpXi+fLtAg/UmvvsaUWFdpXkGD960Z?=
 =?iso-8859-1?Q?r0N2X09Let0wKaQZVDl9IXdH/mY2k2R6zR4YjGTm8rJErWaQBveTB5f4R9?=
 =?iso-8859-1?Q?3zqctu+52TqmcML1E9+c0keMUUmWy+btaBofrr64+AG/VS7DNDF2k1Uscl?=
 =?iso-8859-1?Q?et+H/owQoIIN46aH91jNP+OgfDJy3O84ApYEGvLsceUTmQuExuZB8ckHJR?=
 =?iso-8859-1?Q?8CbiPBpJxxhOM8SYSPn6MDfgcYSNKmNxzbYiFMknQes/lFV8IFu1X1wZUz?=
 =?iso-8859-1?Q?x+m9KFUYy3cWj5U4rTo+ZFsYFUT2ZKfXUCSF5kOK+fKtoao7H7KT3vSs7O?=
 =?iso-8859-1?Q?fbjqjiIwldbSvdY+RhN450F9U4g9qE5zi1/K2DjEyk1IejrNgY2lplb1s2?=
 =?iso-8859-1?Q?vNld1YOftMDEvfFBhd6j8W4nOPqx0/Er6Hi/H/VLkndJNG3zkpu7RObzfx?=
 =?iso-8859-1?Q?5L1wWYtu6/hYvWsSALsvzYnPIWmd46J5wLbpQQBjLhvJ1U/Potf6lRFpJ+?=
 =?iso-8859-1?Q?iA0vOgWELZx0zmSayJWM2+kOhy7cP4YHPAmLmz9ITZ+2VULwW4bo45hUCL?=
 =?iso-8859-1?Q?SlcDKPU1mX7+4ZCkN7qe/w43+zOk5bT6NO3iXNwGupVxcSew8ipL810sSh?=
 =?iso-8859-1?Q?ladF4DADgahxlAWL5Xl98H7yJxl8Sh/eBOVNiL8DV1yZNARON6VTxL8roJ?=
 =?iso-8859-1?Q?xv7IAgOSAL0JmJQdTkZFzY1NSAAPaYw6txLDQ2ng7qjnKUc8CAttLfD/Sv?=
 =?iso-8859-1?Q?Wztdfp/yFHwiopU8adJ1HPTckWANcssv4/kwlBxdInzQ/IG6a8IgJDTSjg?=
 =?iso-8859-1?Q?1svF7+lWtjhpToMmBZZGOjmdwLjnxQ5o2AZ30nxmiU+X6lIP4o0sCylY2F?=
 =?iso-8859-1?Q?C1TVglg1wbYRdCWJtGdb+4upyIbG0c/jehkPJY6Ekos0JsgPfeLCj+Im1U?=
 =?iso-8859-1?Q?OVMvbINmVUjVupDae0xEB7YXfPaQhTDrmYMRjCmuShvhs5HvAZcM3yIExP?=
 =?iso-8859-1?Q?i3OFxv42kLePdTOz3VWrhuTzsU7mGIJznn+4YEsVDBVhzO1Ww/B/iC68zu?=
 =?iso-8859-1?Q?6JDqAhHdXRK2rOwJNx0+G0FB4aIdrHuVe0pngnk7mYb4kGBtdgHwn8/jRQ?=
 =?iso-8859-1?Q?sG1ncneIl1pQ5BLiYH1yNzRG6PRphGoBveGMISQgMzWHjpmAteU00hd31V?=
 =?iso-8859-1?Q?lg=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB5330C896242B3C5A5F6771B0F6600@AM0PR04MB5330.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(6436002)(14454004)(6116002)(3846002)(97736004)(186003)(478600001)(476003)(110136005)(71200400001)(105586002)(106356001)(26005)(71190400001)(11346002)(68736007)(2616005)(86362001)(446003)(6486002)(50226002)(54906003)(316002)(44832011)(486006)(7416002)(99286004)(81166006)(81156014)(8676002)(53936002)(76176011)(8936002)(66066001)(386003)(6506007)(4326008)(36756003)(25786009)(52116002)(2906002)(305945005)(6512007)(256004)(102836004)(4744005)(7736002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5330;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oOwAhWkzNwd/nRxqcUwruzeSLTLf9Xa81YnC+bROtY8QJinfJglIwOZmD1zQkaNbXQ0sgVzhjUwh2R8eTsww6IsFpaHw/t1aPkdkNK8H58dJLD6h/rHVX7ossLTfoih4FvOM5++L6XR9ETcc4nFkQzl0kUX8/r5fDjN/LLChqcu5bxM6Sp5gPLFvgklMApJn7aF2rzZ/NlXgAiuJTQmHY2VoV54QxsVurp4EUwbYLrO+8eW2qdbynQW2a3lPCQkIU/hcy43n0OXNzsNJLyRL/vkDfpNlmgFceQZhop68hvs142AEjee4XDd6ZvTzb76GWnDG1uRYR5oV/TScXHxxZPOmwDELWO44AXv8d4imsy2CoAlyek1CAwNjH3By00qcDldIoKdQhufbTjIHDejX+9JFoUpf7+8Jb/uu6LelbtM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d96a003-087a-4786-60c3-08d6936dd533
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:48:45.0921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ARM clock as imx_clk_cpu type.
Will be used by cpufreq.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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


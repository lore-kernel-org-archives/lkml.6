Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A0822B53
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hbnFem7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A0822B53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeGFOZW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:25:22 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:26624
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753705AbeGFOZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBrKBEYysaQ/cSyNTAkpK0U76C4lvDUjBFL0pgHPR2Y=;
 b=hbnFem7DMo3i9G/oM65Iny6qmcsUnpnbLX1ojg6845+NCtTT1bh7nTDjIchuDYjeZhhJR4+Dk+kbvcKAqBi7qGQpxgJG8WdlbOSfY4IUazD9o8tPVKDYSq8+FRe+pys1CZMMbmrsndUCzKW8fHob9UFMxUCmVO3hUh+O49NzfG8=
Received: from HE1PR04MB3289.eurprd04.prod.outlook.com (10.170.255.157) by
 HE1PR04MB3113.eurprd04.prod.outlook.com (10.171.196.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Fri, 6 Jul 2018 14:25:16 +0000
Received: from HE1PR04MB3289.eurprd04.prod.outlook.com
 ([fe80::882f:418e:1cfa:786e]) by HE1PR04MB3289.eurprd04.prod.outlook.com
 ([fe80::882f:418e:1cfa:786e%4]) with mapi id 15.20.0930.016; Fri, 6 Jul 2018
 14:25:16 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface clock
Thread-Topic: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface
 clock
Thread-Index: AQHT/14eon3OMNqy9UmcYn13+b0vSKRyvsXggA+styA=
Date:   Fri, 6 Jul 2018 14:25:16 +0000
Message-ID: <HE1PR04MB3289D7DB7BCDAA199B16CE0A89470@HE1PR04MB3289.eurprd04.prod.outlook.com>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
 <HE1PR04MB3289046CBDA6B77A733994E889490@HE1PR04MB3289.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR04MB3289046CBDA6B77A733994E889490@HE1PR04MB3289.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB3113;7:8XP/GQkBNyv8borCHnQFSUzt8T0hS5rh4zUAx/fDfSpR/VXKKFK79O29y92tFaBBzwWEaHBNpIx6k/yDoCnE6mThZuSGmXvDGWkJDJ3H6zCcMp+FitjD9Xq00G44uzNZ0gS4eQujHuer6i7nxkSJBSvfUsfpd9O1y9H+25tVhXq/dCbUXU9Mpu89cTwxLa3Wo+q2Xnxt9xoV4Ww/CEvRmC9qZgk1PAowyc6tWOdUDooeJ4KWhJ32UG+jhEnQiJte
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 06701d5f-8ffc-4ed9-aed5-08d5e34c4b95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3113;
x-ms-traffictypediagnostic: HE1PR04MB3113:
x-microsoft-antispam-prvs: <HE1PR04MB31134D315570420AD68EFB8489470@HE1PR04MB3113.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB3113;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3113;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(39860400002)(376002)(13464003)(199004)(189003)(39060400002)(14454004)(74316002)(9686003)(33656002)(478600001)(6436002)(54906003)(5660300001)(97736004)(6116002)(76176011)(229853002)(8936002)(66066001)(99286004)(25786009)(7696005)(5640700003)(55016002)(5250100002)(68736007)(44832011)(446003)(6246003)(26005)(4326008)(81166006)(81156014)(8676002)(486006)(2351001)(106356001)(7736002)(1361003)(53936002)(86362001)(575784001)(53546011)(2501003)(2900100001)(3846002)(14444005)(105586002)(305945005)(6506007)(6916009)(476003)(316002)(186003)(2906002)(11346002)(102836004)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3113;H:HE1PR04MB3289.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3b0qlr+MjwJK6YOM9NpEGmrVW0dBsiiR62WR8DJZbQnA0VQAVQjExiZpotnZtGBMlTT/ClMMu7+6qEg76ImzYfdnOyCokmD+OmKewvMX2N/7Dk7XSCQP4c/LwgnZGBEfKxXlZ6mdRGBd8hZxQTdajqXZ841a7MoXeCXZPWf5Sa9R+w4GYLHsdmXvI9akOovEox3WvQ2HPRmDyhM6l7rRV36HetLsd6Oj076kzXrXs1UVLoeQHy1PuDEUUR/9L875KDgMn7XBm9lTNzzKokUbjKHBiOW/3dbVXKt+ztMizz+kOTMHKylNrZDZ3slOSxYcp1at9o+GFOGYpFVyLEdHzhdDJJ0kaMD9BkJw+Vg1TTM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06701d5f-8ffc-4ed9-aed5-08d5e34c4b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 14:25:16.5822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2nd ping.

Regards,
Shenwei

-----Original Message-----
From: Shenwei Wang=20
Sent: Tuesday, June 26, 2018 10:03 AM
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; linux-kern=
el@vger.kernel.org
Subject: RE: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface cl=
ock

Ping.

Shenwei

-----Original Message-----
From: Shenwei Wang=20
Sent: Friday, June 8, 2018 2:23 PM
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; linux-kern=
el@vger.kernel.org; Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface clock

The current driver assumes that the ftm_sys clock works as one of the clock=
 sources for the IP block as well as the IP interface clock. This assumptio=
n does not apply any more on the latest i.MX8x SoC family. On i.MX8x SoCs, =
a dedicated IP interface clock is introduced and it must be enabled before =
accessing any FTM registers. Moreover, the clock can not be used as the sou=
rce clock for the FTM IP block. This patch introduces the ipg_clk as the de=
dicated IP interface clock and by default it is the same as the ftm_sys clo=
ck if not specified.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c index 55=
7b4ea..df0a1c0 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -87,6 +87,7 @@ struct fsl_pwm_chip {
=20
 	int period_ns;
=20
+	struct clk *ipg_clk;
 	struct clk *clk[FSL_PWM_CLK_MAX];
 };
=20
@@ -99,14 +100,14 @@ static int fsl_pwm_request(struct pwm_chip *chip, stru=
ct pwm_device *pwm)  {
 	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
=20
-	return clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	return clk_prepare_enable(fpc->ipg_clk);
 }
=20
 static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)  {
 	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
=20
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	clk_disable_unprepare(fpc->ipg_clk);
 }
=20
 static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc, @@ -363,=
7 +364,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)  {
 	int ret;
=20
-	ret =3D clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret =3D clk_prepare_enable(fpc->ipg_clk);
 	if (ret)
 		return ret;
=20
@@ -371,7 +372,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
 	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
=20
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	clk_disable_unprepare(fpc->ipg_clk);
=20
 	return 0;
 }
@@ -441,6 +442,15 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]);
=20
+	/* ipg_clk is the interface clock for the IP.
+	 * If not provided, use the ftm_sys clock as
+	 * the default
+	 */
+	fpc->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fpc->ipg_clk))
+		fpc->ipg_clk =3D fpc->clk[FSL_PWM_CLK_SYS];
+
+
 	fpc->chip.ops =3D &fsl_pwm_ops;
 	fpc->chip.of_xlate =3D of_pwm_xlate_with_flags;
 	fpc->chip.of_pwm_n_cells =3D 3;
@@ -480,7 +490,7 @@ static int fsl_pwm_suspend(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
=20
-		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_disable_unprepare(fpc->ipg_clk);
=20
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -503,7 +513,7 @@ static int fsl_pwm_resume(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
=20
-		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_prepare_enable(fpc->ipg_clk);
=20
 		if (!pwm_is_enabled(pwm))
 			continue;
--
2.9.2


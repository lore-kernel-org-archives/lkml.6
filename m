Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94260C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411DB26CC2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dLzxHEMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411DB26CC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeFZPDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:03:15 -0400
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:46622
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751071AbeFZPDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPXVpa9yXAmaUpJMjEl3VSGHM6UTYIcGU2Q3hLmJnrA=;
 b=dLzxHEMjS6N3yXAMdVATYawDFATMEt/b5pNsDkcOPdeg8BmvZiRM1Ux+n2ViTGMaY7mJBOEjSW0XMQrxqqV9vTNQlBN/+Ef59p43a2qGDts6SDwAdTuk2FvF1T9Pv39CWnKqklGdVNeLTvuerXKYrLwJfEHyjB5WasF4OSxO4qE=
Received: from HE1PR04MB3289.eurprd04.prod.outlook.com (10.170.255.157) by
 HE1PR04MB0873.eurprd04.prod.outlook.com (10.162.23.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Tue, 26 Jun 2018 15:03:09 +0000
Received: from HE1PR04MB3289.eurprd04.prod.outlook.com
 ([fe80::6181:5130:a151:da21]) by HE1PR04MB3289.eurprd04.prod.outlook.com
 ([fe80::6181:5130:a151:da21%4]) with mapi id 15.20.0884.023; Tue, 26 Jun 2018
 15:03:09 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface clock
Thread-Topic: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface
 clock
Thread-Index: AQHT/14eon3OMNqy9UmcYn13+b0vSKRyvsXg
Date:   Tue, 26 Jun 2018 15:03:08 +0000
Message-ID: <HE1PR04MB3289046CBDA6B77A733994E889490@HE1PR04MB3289.eurprd04.prod.outlook.com>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
In-Reply-To: <20180608192237.11063-1-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB0873;7:sHF1kYH03vJAwMkuiIiDm5CX6xT9YBUHr8oI7yFUdtDu1KV5PBiB3Bvh5HQafdLNCG38I+D2ftrWrUNdIXh5XPDfbCW5zwHGay/kvzVpPPFExMLoJSbl1QjTbLtdS8vWZysfHVLvoewKqpd4fQvtPqzkiTjcN74Tm1SUpdoqmJx6kDvsAzFfdTUhL0jCf5WmaPyPRCpH6xT3vIzAKQVmo83wtC73PenYSXtAf+LYHCKqVz/bEX3PG7Jeh8OHQczY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1a7c19e7-2202-445e-07ed-08d5db75ee49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB0873;
x-ms-traffictypediagnostic: HE1PR04MB0873:
x-microsoft-antispam-prvs: <HE1PR04MB0873643624E7F78729A11F4489490@HE1PR04MB0873.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB0873;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB0873;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(13464003)(199004)(189003)(8936002)(39060400002)(14454004)(9686003)(102836004)(76176011)(53546011)(6506007)(7696005)(2351001)(3846002)(8676002)(97736004)(33656002)(7736002)(256004)(6916009)(53936002)(66066001)(4326008)(26005)(186003)(86362001)(14444005)(6116002)(575784001)(305945005)(74316002)(316002)(81156014)(106356001)(6246003)(105586002)(2906002)(54906003)(478600001)(81166006)(1361003)(229853002)(446003)(25786009)(5640700003)(6436002)(2501003)(55016002)(5250100002)(2900100001)(486006)(44832011)(68736007)(5660300001)(11346002)(476003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB0873;H:HE1PR04MB3289.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nQPENKZiIP5BW0PkMBVNhmcuTT9PSv3LAnVBs38jvNjVwf2451xJryNx44TeMjx1+aqObmyHGS7CiB90uJXtQ6XmfxrThCISB6Yz8kvXw3qA/rpBqDauAnvcRfqM6zDD5dQ4cslu40ykyc3b2q57xmUiftAHzh5V6JYv9tHZCtZGut9vb0nx4wky8GwwbqxHMrW5cVnECO4+MBz6SxzX00CD4v7OJ/TluZdOnI3hj9KO28YHrClmCcTX/T2lhWZkpoXiMj2QZ6YDJDYTTnrHeapACfjrREyE14KKz8qe2wM3kR8RlGFzgivIb3XzIDSAltZNGa/EoPDOSmw29iBzu104BPKg2A5dYet6ihnll6Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7c19e7-2202-445e-07ed-08d5db75ee49
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 15:03:09.6632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB0873
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


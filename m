Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41952C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF43420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ffNQh6IL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF43420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeLMHIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:08:09 -0500
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:48784
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbeLMHIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxmOMQS+6OxuoG4jWaKE8DXrE6H1rd2NII/mrbKTPLE=;
 b=ffNQh6ILewb03OVTi3a63cCjjpJTfWs4ytvHeWMEDk4U/5gY0jBJwGf5VBxwIZT4IxyWgSqIVFqnNedNPPk9CPdjazE9LjDI8jrTBIEGKzSMOzyuo4kkyWYn4d7bdPL1R3sH+7JQE1EPcXMKTzOmnpQHahf08xo9smAean22hOY=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4985.eurprd04.prod.outlook.com (20.176.234.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 07:08:00 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9%3]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 07:08:00 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 2/2] can: flexcan: add support for PE clock source select
Thread-Topic: [PATCH 2/2] can: flexcan: add support for PE clock source select
Thread-Index: AQHUkrKV8NzxgIccIkWFoq1vo8L2Yg==
Date:   Thu, 13 Dec 2018 07:08:00 +0000
Message-ID: <20181213070537.25095-3-qiangqing.zhang@nxp.com>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0128.apcprd04.prod.outlook.com
 (2603:1096:3:16::12) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4985;6:iGbUr+XE9MjkIueWjMG2lNfOZ4piUhd5drdGFilMrOd77chT6u/2oC+VHWvtIzjmQG7v2EPa2JcXvdvg699016UwpSIhhB03K1Chmaw1SZmIIZ2aCUuEQM1g2k39aIoJgTzJSCrjvf1nmB094K5LKxG/JYpAdnmsrDdRrpkeHHSOdX0I0qk9dfdIqUBXjG7Y9cM2cly+gvM5hySHbWGlfwihQBY5vXfdgT0jSXLLeuhdhMB1aCMGpS7uTUAGIdDr31R+X5eJoSxckFqgDKy5zA9zrjgrqgvGTFzY8CK/BWCnjqSGBgKaXr7seEzfVSKctUa858NbBJn8vQgVM5hSzZNE+7NWM9xUbouZkZ0ZDSUfFlDga44s1uiCUhFB7WEfEcFentcRI72sh/ehe1W2QesJZ+rdzFXqGk9QMlb9yhS//x+4klOD8WFxSexvwp/A0TJUCc00TayAo1T6HpbkDw==;5:NVcFLuT+MU0kZ4APMniBZ42a5l790fYOCoUAgxOJS0usrys1mHDi80AD0lsAuACSKUqPtw6PXKMQomTvrP4nNSJnw0FH28AugBX8TUIDtKcOATSE2uT0BslQTKUXrpgZN15xnmo57X++siVBg18EUL4mMbuCw1HEJ9/MAjO7YJ0=;7:E7DHWJ7PgqQ76qhN01fI4MTsI95F4yVy0YWW04V16RuSnx2EYCrxXVRu4HaFP/00ZIuC14R1F/wBypxuQ5eCkxSPLWKcMYLub/jv8lhskMuiVFZst8DIc+4UaaToCg7rkBuVq1fRi94Xfg015A/YzQ==
x-ms-office365-filtering-correlation-id: 756ca5a4-449f-4b9f-ea13-08d660c9b757
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4985;
x-ms-traffictypediagnostic: DB7PR04MB4985:
x-microsoft-antispam-prvs: <DB7PR04MB498538CD87149454BAF83CE7E6A00@DB7PR04MB4985.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4985;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4985;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(97736004)(36756003)(71200400001)(106356001)(71190400001)(81166006)(8676002)(81156014)(52116002)(66066001)(486006)(256004)(2616005)(476003)(316002)(446003)(11346002)(86362001)(76176011)(50226002)(105586002)(54906003)(110136005)(8936002)(2501003)(3846002)(6486002)(4326008)(6116002)(53936002)(6512007)(25786009)(68736007)(26005)(186003)(6506007)(102836004)(99286004)(386003)(1076002)(478600001)(14454004)(5660300001)(2906002)(7736002)(305945005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4985;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ju+qVR1+KCgsaTuhBNZE1GQdjXLnviqb8MSEUNWhH/Pm/F58r0jdgMoRyvkXDaI5EDRrWuv4mNVusoXLjOvfy8fBYM8BQX0D0GTZAnlX+p0+bX5zGk12Go1tTNidCCDMihbq/tUAlrRuW+LYJYRvVFcDCW2SISIxl+iTSErEvwhHkNArQXv6AoaaGKxIDWTgRjwCObW5DIpyTSRwyNxjvwoOX+HDu9yyPWI8OKudDpQ3nA1TVxF+8/OwblCUrSMEhSHkkuZpfjn38ne5wi1YbNGnD5SL2tHqiWZiVFmFSYF9mTXFxdCU39o3GHrWbi05
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756ca5a4-449f-4b9f-ea13-08d660c9b757
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 07:08:00.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Add support to select the clock source for CAN Protocol Engine (PE).
It's Soc Implementation dependent. Refer to RM for detailed definition
of each Soc. We select clock source 1 (peripheral clock) by default in
driver now, this patch add support to prase clock source in DTS file.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eafe3ac1..2bca867bcfaa 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -273,6 +273,8 @@ struct flexcan_priv {
 	u8 tx_mb_idx;
 	u8 mb_count;
 	u8 mb_size;
+	/* Select clock source to CAN Protocol Engine */
+	u8 clk_src;
 	u32 reg_ctrl_default;
 	u32 reg_imask1_default;
 	u32 reg_imask2_default;
@@ -1361,9 +1363,12 @@ static int register_flexcandev(struct net_device *de=
v)
 	err =3D flexcan_chip_disable(priv);
 	if (err)
 		goto out_disable_per;
-	reg =3D priv->read(&regs->ctrl);
-	reg |=3D FLEXCAN_CTRL_CLK_SRC;
-	priv->write(reg, &regs->ctrl);
+
+	if (priv->clk_src) {
+		reg =3D priv->read(&regs->ctrl);
+		reg |=3D FLEXCAN_CTRL_CLK_SRC;
+		priv->write(reg, &regs->ctrl);
+	}
=20
 	err =3D flexcan_chip_enable(priv);
 	if (err)
@@ -1488,6 +1493,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
 	struct flexcan_regs __iomem *regs;
 	int err, irq;
+	u8 clk_src =3D 1;
 	u32 clock_freq =3D 0;
=20
 	reg_xceiver =3D devm_regulator_get(&pdev->dev, "xceiver");
@@ -1496,9 +1502,12 @@ static int flexcan_probe(struct platform_device *pde=
v)
 	else if (IS_ERR(reg_xceiver))
 		reg_xceiver =3D NULL;
=20
-	if (pdev->dev.of_node)
+	if (pdev->dev.of_node) {
 		of_property_read_u32(pdev->dev.of_node,
 				     "clock-frequency", &clock_freq);
+		of_property_read_u8(pdev->dev.of_node,
+				    "fsl,clk-source", &clk_src);
+	}
=20
 	if (!clock_freq) {
 		clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
@@ -1556,6 +1565,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 		priv->write =3D flexcan_write_le;
 	}
=20
+	priv->clk_src =3D clk_src;
 	priv->can.clock.freq =3D clock_freq;
 	priv->can.bittiming_const =3D &flexcan_bittiming_const;
 	priv->can.do_set_mode =3D flexcan_set_mode;
--=20
2.17.1


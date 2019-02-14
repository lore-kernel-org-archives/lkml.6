Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B73CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A27821900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iPMNZu2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393932AbfBNMOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:14:36 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7596 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfBNMOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:14:35 -0500
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; 
   d="scan'208";a="26730454"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 05:14:34 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 05:14:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW1sdiK2uEG9D0rvDjAQBjNdw4/YAq16MPfcKWt5eiw=;
 b=iPMNZu2niSBfT8Zy03kF6nXu1zsneQuGoW6FOJCoXdtvIrTaIjTYdLJAw81o9RLoE1g6WGCOhZ4sKczHQDTufAiMUH6y3duHkxDl5qI/NFSCuh1Y0NesdgxtdFMRUrLkJAn2DQejxDvDTpeuTgHsTgSe4/B5UztAxp2+/l1IIvA=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1518.namprd11.prod.outlook.com (10.172.54.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 12:14:32 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 12:14:32 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 2/3] clk: at91: sckc: add support for SAM9X60
Thread-Topic: [PATCH v2 2/3] clk: at91: sckc: add support for SAM9X60
Thread-Index: AQHUxF7XgscBW81rJUmiAtq1msPxSw==
Date:   Thu, 14 Feb 2019 12:14:32 +0000
Message-ID: <1550146447-1441-3-git-send-email-claudiu.beznea@microchip.com>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:803:1::37) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8f6ce95-5ac7-4f9d-7194-08d69275fa04
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1518;
x-ms-traffictypediagnostic: MWHPR11MB1518:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1518;23:1QzjmEeK/KE3PI5JbMQAxaMxWHCHYcvs790THDF?=
 =?iso-8859-1?Q?Z5yrrkWzXFC8SQLp7rIh+X+pYu8ZYF8G1Zw+hnJOZQ1zPXwF6lvaOKU8+p?=
 =?iso-8859-1?Q?aQo2uR2IHaKxT10JERT5b7gEZvcOYnJzXWcp4qmMkEBCVNRIH6Spe+V7xn?=
 =?iso-8859-1?Q?f9VmjXLvvVXdu63nZW4xPiLG0crB2Pfmg1PVxCLgQTlSNphHcmXrDycFF0?=
 =?iso-8859-1?Q?ApFNrf1Oxxci6Sbdh5UOGvjfBjN4OnSnb1Y/ehLXJmKSgneTmxxwIoskCM?=
 =?iso-8859-1?Q?6tOE+X8BVndc/4JKzZHYTNFSdoQS+al9xOL2VFfXqoxULpoQFkuPAgER8x?=
 =?iso-8859-1?Q?vZ0XfoajAp+hl4/0h/XaSrSgxxbiMNOyurPrm7b6emiF24gDQucmzYehDw?=
 =?iso-8859-1?Q?QE0d8gCQUo5KTL0Gtag2PjwZLPSIkCgHDYSsoQFTZWYabsreifKGTJ4tWc?=
 =?iso-8859-1?Q?f2x2MQo+ehqR7eSvZ92JiVq/CIhUt6fapDQZyyV1eWdMuydz0riWWorGAy?=
 =?iso-8859-1?Q?XTLjMbMT1ijdzGXQaxHihvBFAk5Lb2L/bp617SVunKs4PhwSGlnLwSv8B4?=
 =?iso-8859-1?Q?30oDHJO7eo7wIkA/5nIll8I6O5cVAPlTx4XyAzozTMX4+Ub0mK8Uo3Shk/?=
 =?iso-8859-1?Q?2EGBr4Lko5x1j/IqfLZ0Gjuyh2UKZtiGpUPTETcOaDfxEubRuMnZDR6JrS?=
 =?iso-8859-1?Q?XVOXOwK8lO37Fyiz2VwhSi/azG5sZq15kyLlBCiiSwmy1eqqeZR2qhvM0K?=
 =?iso-8859-1?Q?IYAMrJHICCIIhcpULavg6gfM1Flax8mujmyVtvyCpz6OoP3YNIVl1jO5zh?=
 =?iso-8859-1?Q?2glFH4QMxXl8uwu2n247/G1CoPRSm+HysOMyE225s/zQ073Gtc9YDgZEYJ?=
 =?iso-8859-1?Q?HragTf1Cl7j6VUTc579er/41iM2lr+oMX2hdAWwtUWBfLoV7Y1F9na80zo?=
 =?iso-8859-1?Q?Mq1nZR5I6ffaQ3rU1h2MeE0n6VHwSjLeAVw96TP8tJuJs4Xf2aHSrEMCMF?=
 =?iso-8859-1?Q?kUwPQi5WDWSC+NSSjPIBHUiREtgkl4vnJhjfFpguw/1G7Hee8+8tRqwbOK?=
 =?iso-8859-1?Q?z8CODwEzXx9Ijde6UN7S8524UESCdmcHnDWdwSfokYVI4fwXeORk9RRz48?=
 =?iso-8859-1?Q?EbZ7/SpAnXbhZrgPAz9EdKsIFyyBGpeIV2dlkQ2p89PJY35tz7FgPw3VfD?=
 =?iso-8859-1?Q?lLLPG5yrL1RTYCv8wVLlzZvOaCCN5QlDQz1PS9e+K7H0AoM4TDQyZH0tUp?=
 =?iso-8859-1?Q?FfzKAg9Z6ejzhkCp9bfC3/vi8i7D4bVw5pD9HYq7oAzMYfcKxmVevxbgmD?=
 =?iso-8859-1?Q?bo=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB15180478A7A84CECB1F0895087670@MWHPR11MB1518.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(72206003)(11346002)(107886003)(476003)(25786009)(4326008)(52116002)(486006)(6512007)(14454004)(6636002)(478600001)(446003)(36756003)(3846002)(2616005)(6116002)(97736004)(8936002)(76176011)(50226002)(54906003)(110136005)(99286004)(7736002)(256004)(186003)(71200400001)(2501003)(316002)(71190400001)(106356001)(68736007)(26005)(81166006)(105586002)(81156014)(2906002)(305945005)(66066001)(6486002)(53936002)(86362001)(6436002)(386003)(102836004)(6506007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1518;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ySdzWU0VhvihF2KXhuOs4j58A8Yh65sRLORtr3wCT/Zt4YDpg63Jm2iPiad5Y92gI2vrJVKeNmeB59hgRjYFfjEa0c4R7OpGYt2CTzFRZpDwm1TvGtl4MmkMM7yOXUunQ/pztKF2IY7TynprtWmOuVBMjpq2aBFor3mRZ2/JhuV8cwMDt9w7KqO7ENCKAki6qy48OfyJoR/ECpAl8PDbFEFQE/jpVWpK2y2x548DnVFKSTCIRHGhu72keaQHVGela+WG5TlCM0fBPMTvA11zHfNPatjDBPMRjzyCeUlB+0Fa0GKo9fnEz12idNjDG7hyTaCQp6Go8eMrnjaDJtmVm95Hxv+CNwL175hZrHW9E9uAvrnVdIQ8k0/sDF2k6A4gnJ4/eYJmQnlNE+ZPcv/A20sqrgX1JPmP+jOpuZY4oZQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f6ce95-5ac7-4f9d-7194-08d69275fa04
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 12:14:28.7509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1518
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for SAM9X60.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sckc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index b7163d3a2269..b3075c51d260 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -459,6 +459,36 @@ static void __init of_at91sam9x5_sckc_setup(struct dev=
ice_node *np)
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
 	       of_at91sam9x5_sckc_setup);
=20
+static const struct clk_slow_offsets at91sam9x60_offsets =3D {
+	.cr_rcen =3D AT91_SCKC_OFFSET_INVALID,
+	.cr_osc32en =3D 1,
+	.cr_osc32byp =3D 2,
+	.cr_oscsel =3D 24,
+};
+
+static void __init of_at91sam9x60_sckc_setup(struct device_node *np)
+{
+	struct device_node *childnp;
+	void (*clk_setup)(struct device_node *np, void __iomem *io,
+			  const struct clk_slow_offsets *offsets);
+	const struct of_device_id *clk_id;
+	void __iomem *regbase =3D of_iomap(np, 0);
+
+	if (!regbase)
+		return;
+
+	for_each_child_of_node(np, childnp) {
+		clk_id =3D of_match_node(sckc_clk_ids, childnp);
+		if (!clk_id)
+			continue;
+		clk_setup =3D clk_id->data;
+		clk_setup(childnp, regbase, &at91sam9x60_offsets);
+	}
+}
+
+CLK_OF_DECLARE(at91sam9x60_clk_sckc, "microchip,sam9x60-sckc",
+	       of_at91sam9x60_sckc_setup);
+
 static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_sama5d4_slow_osc *osc =3D to_clk_sama5d4_slow_osc(hw);
--=20
2.7.4


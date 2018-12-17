Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC4B20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wZ67lp8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbeLQOOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:14:50 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:52519 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733307AbeLQONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:13:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="22366015"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 07:13:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:13:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgevUhPYg5Bh3SNVnyZSPjukuIyPbHAlU740fVrcAwU=;
 b=wZ67lp8jOxQCwok+7vHftu2aL1am6csJCyojxZxQvYc7dFrVIyU1gsKhkG1rsM8+GJmb8EYeVnaPw7wpYtuKoMjOg0XGaCc3Txd/mkJoLSRa2P1dTsit0xwWP3EYLGYlD5j1LrWrSavBXAz5RLFfjSKTgo0F7xIGqsWjBlYmP3w=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0584.namprd11.prod.outlook.com (10.163.159.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:13:47 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:13:47 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh@kernel.org>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v7 3/6] pwm: atmel: add pwm capabilities
Thread-Topic: [PATCH v7 3/6] pwm: atmel: add pwm capabilities
Thread-Index: AQHUlhK5wQUDgP4280m8i+nAkdfkdA==
Date:   Mon, 17 Dec 2018 14:13:47 +0000
Message-ID: <1545055999-23950-4-git-send-email-claudiu.beznea@microchip.com>
References: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::25) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0584;6:u6aFTf3sCBXRMESchsNDmu7+d4aLqRaCv+4OPeQO4vvdEjC2itErcTuB6Dxhy+ty78amjltd+P2vPXqM7EMTBMqZSthLVYflFnhYlwXnuAgSSK6k1h4b4UNvx0nUQcRC/7uBXJfy5UpIz7NKay4XRZ66bG3pIhaJf0ZpDK6E2FPY98dM9ZnKgyZxkl3qY16s8+4qIUUqPp8EBrphJ3hiYX32oLPaWgmi8VZGifYOTklO0nk9pQuC14P13sUCkT9UVsDs6zHmnvgggSRAQaQ7gVRyNEXYmonJv9XyFMmfTrhSg795EnoCITrC+cPyGFG7owTRUx8AceHkDiWLY45RnLLRp+3If3KAhzH8Fz5YGwvSqpCLnrDQ+rCvThHVpzpzyLbnsV6ax3Tl1TjPMq7uaaFTvmq89qfzS/3bQaQK7kx3O4m4rPnpMQGSbwuzBhKeWSxxX64jRvVX6PvTgxXjAw==;5:g4exStloA8uHdcSs+JtIZt4QO/4LrQSE6tQydQMPl4k2fehNO623iJM6fjtVzjDbzWVbiXCWPRdXleSGTE8WVsS5QiChc9YfEarJRNzNItmeXjpLYrhnLcCENl2YjyVooszKtxlTVncCZnXwH9LkQ1ZtTPVc/x68qCPPK1VL5Vo=;7:zbKXIPXR5TGQDlyfczVG2hsV3fl+vl7A7g8lryN0KJol1qVmR4AXBhU8tNRoUEU1ZpvemoCTNQmuWUMAdf3vFFZA/ACkBey8KXoo8Mm/4D2zZXerEFh2WymrDOg+0hHHqJbZiszrL4sJ94FiPnzMyQ==
x-ms-office365-filtering-correlation-id: 0d37d477-e010-40a4-ae83-08d66429dc0e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0584;
x-ms-traffictypediagnostic: BY2PR11MB0584:
x-microsoft-antispam-prvs: <BY2PR11MB0584AA23CB4B82556579C69487BC0@BY2PR11MB0584.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0584;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0584;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(8676002)(25786009)(68736007)(6506007)(386003)(6116002)(102836004)(5660300001)(6436002)(66066001)(3846002)(39060400002)(478600001)(107886003)(71190400001)(2501003)(72206003)(256004)(305945005)(71200400001)(6486002)(7736002)(186003)(97736004)(26005)(52116002)(316002)(54906003)(476003)(4326008)(2201001)(99286004)(14444005)(14454004)(11346002)(2616005)(446003)(2906002)(76176011)(6512007)(36756003)(53936002)(110136005)(86362001)(6636002)(8936002)(81156014)(486006)(81166006)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0584;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n7uKdTJnNULEpOeyoju2oNrBfTnTHD5GOfXajeQkzZPFlIu8XtDUbJt6SpJKoz9hergfcSpSWeDuJtNNs3cZznSYEW/WLcxcT6zct2BQ6i+90p1cg+HqHRzF9F9SDXsXRmJKRulibzxdr7JBzgDZci3GW2cuI6M8ufq7W+MVAuoV0EpPhTgQUtU4Pj3mAg/1uy1IqjqFx1t/wFoaAcobtZM/exQbTY7v0peOsQdCbRlHgAaRYM2JMzao0EB7OiSJDxy5aW4s1XH92daRsiodCbSw1JHVUvfWwm23a658Eg/ZMz7TgLVnI4ZQwkYdD4eV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d37d477-e010-40a4-ae83-08d66429dc0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:13:47.0853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0584
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add pwm capabilities for Atmel/Microchip PWM controllers.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 86 ++++++++++++++++++++++++++++++++-------------=
----
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 530d7dc5f1b5..b72cacd5dca3 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -65,18 +65,23 @@ struct atmel_pwm_registers {
 	u8 duty_upd;
 };
=20
+struct atmel_pwm_data {
+	struct atmel_pwm_registers regs;
+	struct pwm_caps caps;
+};
+
 struct atmel_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
-	const struct atmel_pwm_registers *regs;
+	const struct atmel_pwm_data *data;
=20
 	unsigned int updated_pwms;
 	/* ISR is cleared when read, ensure only one thread does that */
 	struct mutex isr_lock;
 };
=20
-static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *ch=
ip)
+static inline struct atmel_pwm_chip *to_atmel_pwm_chip(const struct pwm_ch=
ip *chip)
 {
 	return container_of(chip, struct atmel_pwm_chip, chip);
 }
@@ -150,15 +155,15 @@ static void atmel_pwm_update_cdty(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
 	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
 	u32 val;
=20
-	if (atmel_pwm->regs->duty_upd =3D=3D
-	    atmel_pwm->regs->period_upd) {
+	if (atmel_pwm->data->regs.duty_upd =3D=3D
+	    atmel_pwm->data->regs.period_upd) {
 		val =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
 		val &=3D ~PWM_CMR_UPD_CDTY;
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 	}
=20
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->duty_upd, cdty);
+			    atmel_pwm->data->regs.duty_upd, cdty);
 }
=20
 static void atmel_pwm_set_cprd_cdty(struct pwm_chip *chip,
@@ -168,9 +173,9 @@ static void atmel_pwm_set_cprd_cdty(struct pwm_chip *ch=
ip,
 	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
=20
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->duty, cdty);
+			    atmel_pwm->data->regs.duty, cdty);
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->period, cprd);
+			    atmel_pwm->data->regs.period, cprd);
 }
=20
 static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pw=
m,
@@ -225,7 +230,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
 		    cstate.polarity =3D=3D state->polarity &&
 		    cstate.period =3D=3D state->period) {
 			cprd =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
-						  atmel_pwm->regs->period);
+						  atmel_pwm->data->regs.period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
 			atmel_pwm_update_cdty(chip, pwm, cdty);
 			return 0;
@@ -272,32 +277,55 @@ static int atmel_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 	return 0;
 }
=20
+static int atmel_pwm_get_caps(const struct pwm_chip *chip,
+			      const struct pwm_device *pwm,
+			      struct pwm_caps *caps)
+{
+	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
+
+	*caps =3D atmel_pwm->data->caps;
+
+	return 0;
+}
+
 static const struct pwm_ops atmel_pwm_ops =3D {
 	.apply =3D atmel_pwm_apply,
+	.get_caps =3D atmel_pwm_get_caps,
 	.owner =3D THIS_MODULE,
 };
=20
-static const struct atmel_pwm_registers atmel_pwm_regs_v1 =3D {
-	.period		=3D PWMV1_CPRD,
-	.period_upd	=3D PWMV1_CUPD,
-	.duty		=3D PWMV1_CDTY,
-	.duty_upd	=3D PWMV1_CUPD,
+static const struct atmel_pwm_data atmel_pwm_data_v1 =3D {
+	.regs =3D {
+		.period		=3D PWMV1_CPRD,
+		.period_upd	=3D PWMV1_CUPD,
+		.duty		=3D PWMV1_CDTY,
+		.duty_upd	=3D PWMV1_CUPD,
+	},
+	.caps =3D {
+		.modes_msk =3D PWM_MODE_BIT(NORMAL),
+	},
 };
=20
-static const struct atmel_pwm_registers atmel_pwm_regs_v2 =3D {
-	.period		=3D PWMV2_CPRD,
-	.period_upd	=3D PWMV2_CPRDUPD,
-	.duty		=3D PWMV2_CDTY,
-	.duty_upd	=3D PWMV2_CDTYUPD,
+static const struct atmel_pwm_data atmel_pwm_data_v2 =3D {
+	.regs =3D {
+		.period		=3D PWMV2_CPRD,
+		.period_upd	=3D PWMV2_CPRDUPD,
+		.duty		=3D PWMV2_CDTY,
+		.duty_upd	=3D PWMV2_CDTYUPD,
+	},
+	.caps =3D {
+		.modes_msk =3D PWM_MODE_BIT(NORMAL) |
+			     PWM_MODE_BIT(COMPLEMENTARY),
+	},
 };
=20
 static const struct platform_device_id atmel_pwm_devtypes[] =3D {
 	{
 		.name =3D "at91sam9rl-pwm",
-		.driver_data =3D (kernel_ulong_t)&atmel_pwm_regs_v1,
+		.driver_data =3D (kernel_ulong_t)&atmel_pwm_data_v1,
 	}, {
 		.name =3D "sama5d3-pwm",
-		.driver_data =3D (kernel_ulong_t)&atmel_pwm_regs_v2,
+		.driver_data =3D (kernel_ulong_t)&atmel_pwm_data_v2,
 	}, {
 		/* sentinel */
 	},
@@ -307,20 +335,20 @@ MODULE_DEVICE_TABLE(platform, atmel_pwm_devtypes);
 static const struct of_device_id atmel_pwm_dt_ids[] =3D {
 	{
 		.compatible =3D "atmel,at91sam9rl-pwm",
-		.data =3D &atmel_pwm_regs_v1,
+		.data =3D &atmel_pwm_data_v1,
 	}, {
 		.compatible =3D "atmel,sama5d3-pwm",
-		.data =3D &atmel_pwm_regs_v2,
+		.data =3D &atmel_pwm_data_v2,
 	}, {
 		.compatible =3D "atmel,sama5d2-pwm",
-		.data =3D &atmel_pwm_regs_v2,
+		.data =3D &atmel_pwm_data_v2,
 	}, {
 		/* sentinel */
 	},
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
=20
-static inline const struct atmel_pwm_registers *
+static inline const struct atmel_pwm_data *
 atmel_pwm_get_driver_data(struct platform_device *pdev)
 {
 	const struct platform_device_id *id;
@@ -330,18 +358,18 @@ atmel_pwm_get_driver_data(struct platform_device *pde=
v)
=20
 	id =3D platform_get_device_id(pdev);
=20
-	return (struct atmel_pwm_registers *)id->driver_data;
+	return (struct atmel_pwm_data *)id->driver_data;
 }
=20
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
-	const struct atmel_pwm_registers *regs;
+	const struct atmel_pwm_data *data;
 	struct atmel_pwm_chip *atmel_pwm;
 	struct resource *res;
 	int ret;
=20
-	regs =3D atmel_pwm_get_driver_data(pdev);
-	if (!regs)
+	data =3D atmel_pwm_get_driver_data(pdev);
+	if (!data)
 		return -ENODEV;
=20
 	atmel_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
@@ -373,7 +401,7 @@ static int atmel_pwm_probe(struct platform_device *pdev=
)
=20
 	atmel_pwm->chip.base =3D -1;
 	atmel_pwm->chip.npwm =3D 4;
-	atmel_pwm->regs =3D regs;
+	atmel_pwm->data =3D data;
 	atmel_pwm->updated_pwms =3D 0;
 	mutex_init(&atmel_pwm->isr_lock);
=20
--=20
2.7.4


Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1140BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC79D217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="IhlAK6HX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfACNaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:30:16 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:20956 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731748AbfACN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:29:54 -0500
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="25939504"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2019 06:29:53 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 3 Jan 2019 06:30:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgevUhPYg5Bh3SNVnyZSPjukuIyPbHAlU740fVrcAwU=;
 b=IhlAK6HXOzlISZZu6W8Mz4DzK6Pdj5gg2gVoQncAOaaCtvMvEyo7a7lNYpIKPLdYDoodn0EmGCEeVO/avFxs/xLyUzccFtXTFChPjFIKsNCvWEGt9qdvNuQ0y5fHUmGihZ8r3MaDnPVleFv5KMKsIGpDFsk2rnFHD9UePEpmUjg=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:29:51 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:29:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v8 3/6] pwm: atmel: add pwm capabilities
Thread-Topic: [PATCH v8 3/6] pwm: atmel: add pwm capabilities
Thread-Index: AQHUo2hnvyIqHD2cNkWnKHVETasQ7A==
Date:   Thu, 3 Jan 2019 13:29:50 +0000
Message-ID: <1546522081-23659-4-git-send-email-claudiu.beznea@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0209.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::33) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1984;6:z4Gb7PVTLaxtGaDvZQA3NP2ECmX3dxlHJVJUfZMpzCsub+YrR/3b3JSF60Wo4ZqV5OaTlExEBMwsT6lOc2Y9429ibmLyl5wgBYQGRdfeqm3Hvkx86Gyv3SfKzsyjXn0mSWY1V2wLotT684KZSedA85+m9j0c1aHjZdUVUv0bTGDCPwVTUzjgRBT5/ety1Vtv39IvsENJZiZemUpaem5vLzAm2adcMMl82YcAMfjkRyIbgizC2UIJtFs9im7G6YV8EsdpyfLozmwItmxYYJYwTYcdHsHH9IsoKC0uR+JjB+1xZARN3obtfdblpaXyZJOFCJIOMVqjvarDgLTQPc24CRoYuDIiby3hIewxuLreL8suKEyffzWjLTPoHmdESJi0rTSNdBNKL5ADBdGYmAvtvaHGjQQ/1eCMED4IN8Ae5fIhZJdbvAbgGQhbY53n82x2Htg7k2yexRIiZ2Myyszb1Q==;5:E0k1PNfo8xpgfALDMKJVU95k0NwzL6n91oafDNQV5KKH/p7c+RvyvHxKlcdz3hPgMUjx7Ug+a97iyISRnsvNDx0sRhEdXpxOD3DV999b2AMHTpqZybJmF/X9HNoCitGaBo96E5SFM7nKFAGK4Fem0yMh9jxU6Y7vAtd8KVkPphhUQfEociu+rHuikuetNgYKur4RTPLkkClb5hfkXi3vBg==;7:HpMe1i+beL6C1eMLcpCj1wUfTo8g5LxN1fEZ3m6iI4nzI8UpdH4gokOAckd7LYdcQsjun2XFGdggrvniJmK59+9HZrYfH/zHhf6W6Wl7+uGrOlQWdcUi1q4zouA2aDe3aTRgHLF0n9E07vjec2OPCQ==
x-ms-office365-filtering-correlation-id: 2138b6f4-d8cb-40eb-6841-08d6717f89b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB198437E2BD61605FB94D4409878D0@MWHPR11MB1984.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1984;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1984;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(11346002)(71190400001)(6486002)(2501003)(72206003)(14454004)(2616005)(476003)(97736004)(446003)(5660300001)(478600001)(316002)(6636002)(86362001)(99286004)(54906003)(52116002)(110136005)(71200400001)(6436002)(6512007)(186003)(53936002)(305945005)(7736002)(3846002)(39060400002)(6506007)(386003)(6116002)(105586002)(106356001)(107886003)(68736007)(76176011)(36756003)(4326008)(26005)(81156014)(81166006)(102836004)(8936002)(66066001)(2906002)(486006)(8676002)(256004)(25786009)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +qQ+vj+OcG0+UgnyrcR+Lm9uZOS2qjqArr2a5s8cwjLjzBwT/ZPwl2fU2RoKifwI5XFzkLgtwO+80vxm5ocZ7gYtNmqTopJjDRq3i6NDNbOoZBxfleQ74lzIZYg3Abt3/Bmku3GOmvl2jFp57CSXzMCJhx04RoOkup0ZjwF9TOdFlWvlr43468jHnORtc7TZLQrYIYS+s6eR9u1jEex0uphLhX46bTdXF2dFDv4CipiCXwEda457SGi3zoa4BbWWGBZI/VoEw0iv2OUmLVY3aDLji5VR6aOjWa2TUpf+49b2kovzzvLvRovD4ck7oK77
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2138b6f4-d8cb-40eb-6841-08d6717f89b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:29:50.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
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


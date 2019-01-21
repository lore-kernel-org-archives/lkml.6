Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDAEC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF42F2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HQENiGfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfAUMay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:30:54 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:30430 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfAUMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:30:53 -0500
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="25300552"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Jan 2019 05:30:52 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 21 Jan 2019 05:30:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9lIBio+d1I8a0cqfMF/qq8HbRXrUVc1eb2t+KSG708=;
 b=HQENiGfzyHklH6gSTB/jrHtmLwDCn+Dh8ds5y9zMWhd85QgUC6yNcFwL9wV8eZdRNqzZkgbaLFThrmzQ27J0Ua46Fsjh1OOkHRSHinuOjb/Z4CQyuyC7f+PDx7hEf/2v9XVesewiuT+2+xC34v+uWDmHbuQkyiAt5xSOAgCl5rg=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2064.namprd11.prod.outlook.com (10.169.236.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Mon, 21 Jan 2019 12:30:50 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%8]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 12:30:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/4] pwm: atmel: add struct atmel_pwm_data
Thread-Topic: [PATCH 1/4] pwm: atmel: add struct atmel_pwm_data
Thread-Index: AQHUsYUkAaxUeswMuUqKCCXBbYEuxA==
Date:   Mon, 21 Jan 2019 12:30:49 +0000
Message-ID: <1548073783-22640-2-git-send-email-claudiu.beznea@microchip.com>
References: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB2064;6:Os+Ch9pCgSZv2uAB53bzB9Jdaz2egUcARIqySltuzYgAy3gauA4N9w2FATnGwZsEQE4GTjTEMVP2HN7tjKuTHBsS4saDUW7K/QK6wDO8CIDlXwjhTjwnrLvv3ivVHrZrFP5GLYz5ECR+zBec4etFZje4i0FAfs9VsqL6y71g86vPyKVzudNAuNU21TU9TlXf6Qlffh3B4jJgwQJaupXH3E1uDOKINVZVwzp2C8qbhTZU+Uigv05P7kMI7cyzadHvC/R0ieBPbyOtxoHZ+3H4o6OP9MwV0NT60jtJjYd2n8l2ijVKsrJAeMWkzczUp65VPfxxA2mzBSbi/iQ0b3evw4F28cbyUxoYkSVpdi0BXPzogfiO9koWj18uQUC6I2Gr+CR7qvUDcuUA4X2kqzSXSzRSqVoQgFlDexSRNklNZvssOfczas3smsoyNTjatRWpaWEQuqfCLI82b+tpRa/TdQ==;5:HloM3UizrpAy6tfq+N8xMN/lS5m7qJ5ovg6lxIufPxKY987eJZ9MmVj52KL9sGGp2KgtaWgmv+uE59okVoJI+VAq6SMCMJpL5jr4VQXxNF4+8/6J7CF/DeliqfUFmIC4XmqQ5lrBA11UYDrASkZFXM5r+YLxgkUXFNiaxSgDThKsdpozn6lcSRUsTHEGHL8ao0a76W4FfJ5iWFmgyGI7KQ==;7:Z0ZUIqy7UQozyzZJ7VKlJXOMAHhVALISMxPt9IBDDo111aPtY0bFv1NeiNl3FA1kcX8IsNfck9Gmzrs3C8ygbxwmPEcUg2/HgZI5lkJMFOEBF8+NFwP9S/TqeFVU4eklQa1yRCEBh2d45SLtGLW04w==
x-ms-office365-filtering-correlation-id: c8b55bfe-800a-487e-310d-08d67f9c4670
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2064;
x-ms-traffictypediagnostic: MWHPR11MB2064:
x-microsoft-antispam-prvs: <MWHPR11MB2064C5C64F87B43A5C786350879F0@MWHPR11MB2064.namprd11.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(186003)(6436002)(6636002)(53936002)(4326008)(50226002)(6116002)(105586002)(52116002)(446003)(106356001)(97736004)(3846002)(36756003)(7736002)(305945005)(6486002)(39060400002)(316002)(26005)(6512007)(99286004)(71200400001)(107886003)(71190400001)(86362001)(25786009)(68736007)(256004)(14444005)(14454004)(8936002)(8676002)(2906002)(81156014)(386003)(6506007)(81166006)(476003)(2616005)(2501003)(76176011)(54906003)(11346002)(102836004)(66066001)(72206003)(478600001)(110136005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2064;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dps3yhER2PHcWmT/XG6+1u/VUpdeBW0qsCNv3Y9pwlXscyrYFlLfeMxBXkC9NtlxBJ8jqM8NqeGfN7o8b7AN3JRQoA21RaalvGZjFbbOfncyIQp9JVnD/Nu4fXXx9UpagcnIXcvB3jg4mp5Z0h9KEgvGeysId4dfiML/PluD7hPiztMEYPbwLK2Xb8uyLfinDz7WtFoHZlq89INrmuOso0jJQF4usC1mE+qm3yhy/y1yrObFMQvRvXdBsPnCg6SJgQCxVCjU7bX5qsxr+58uNIAIQA7ChR2jbqm7KGF1a46LaJogvOPhyVmh6MjXg7JubwURs0CUCNGb1VWyIuHvtX2AGVpJwxfED9ZoH7yfU6j/3LAbZQtFFNCYUZELIhb5k7tNOQ7ZznRtPSBPz1x4TFodx8RhxABA2M6R2nc7LoE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b55bfe-800a-487e-310d-08d67f9c4670
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 12:30:46.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add struct atmel_pwm_data to embed different per controller information. At
this stage, embed a member of type struct atmel_pwm_registers in it.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 64 +++++++++++++++++++++++++++------------------=
----
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 530d7dc5f1b5..7e86a5266eb6 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -65,11 +65,15 @@ struct atmel_pwm_registers {
 	u8 duty_upd;
 };
=20
+struct atmel_pwm_data {
+	struct atmel_pwm_registers regs;
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
@@ -150,15 +154,15 @@ static void atmel_pwm_update_cdty(struct pwm_chip *ch=
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
@@ -168,9 +172,9 @@ static void atmel_pwm_set_cprd_cdty(struct pwm_chip *ch=
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
@@ -225,7 +229,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
 		    cstate.polarity =3D=3D state->polarity &&
 		    cstate.period =3D=3D state->period) {
 			cprd =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
-						  atmel_pwm->regs->period);
+						  atmel_pwm->data->regs.period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
 			atmel_pwm_update_cdty(chip, pwm, cdty);
 			return 0;
@@ -277,27 +281,31 @@ static const struct pwm_ops atmel_pwm_ops =3D {
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
@@ -307,20 +315,20 @@ MODULE_DEVICE_TABLE(platform, atmel_pwm_devtypes);
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
@@ -330,18 +338,18 @@ atmel_pwm_get_driver_data(struct platform_device *pde=
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
@@ -373,7 +381,7 @@ static int atmel_pwm_probe(struct platform_device *pdev=
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


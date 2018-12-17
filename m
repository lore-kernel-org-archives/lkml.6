Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30940C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BCB2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rtSYOITj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbeLQODr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:03:47 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:44533 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732305AbeLQODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:03:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="24310660"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 07:03:44 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:03:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvVjPyoaV+bK8s4DYjcBuwUc1zpXS76CKb2RhaH4FuE=;
 b=rtSYOITj0LGAT6Z2DjbAwbFT5/tepdSKLyhYc0cQj+vK7lQAMyDx9S2IcUacF2ZaKK3LL1B/OzXZT8A9Xl9YOlwcUIzNE8Pb5q9JJcJ7NK3r516xg26ACBhexKCskL+fKBJMDZBKw2d5RGz7T8WpAGS/raHOoVHr5t9lso11niQ=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0646.namprd11.prod.outlook.com (10.163.159.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 14:03:41 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:03:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh@kernel.org>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v6 6/6] pwm: atmel: add push-pull mode support
Thread-Topic: [PATCH v6 6/6] pwm: atmel: add push-pull mode support
Thread-Index: AQHUlhFQlu0Xw9HO/kiWgX12GBAvAw==
Date:   Mon, 17 Dec 2018 14:03:41 +0000
Message-ID: <1545055368-23338-7-git-send-email-claudiu.beznea@microchip.com>
References: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::34) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0646;6:DBM/QIhWq121EFrupFmO0J7ukDGjWXQpi5EJYKn56VYBJ94m/7LKOIFD2TJ5EDJljzzq3FgRyuq+UAtU4/tL+o74FStdYakwueLn7KKMrkc+CuuCInTPd2iylhj0yP6JG1kithSdeNRM0jlaWQHxVwsAeHQsuSpi/CSFtQFvkWt1uQM9gqnG48Yv74cLmGMVqGGyMQH/XkqIonk091yGK5y0g/ubPUC2zD5btkFyrXeALl0rcuO60ridNxnZg9oyqfyy1rOZJlTcxbdrQqf99o64C+d/+CmE5Y7QTPsQU3Qgsk4/C4zGfBMSBHTerKEnqA8hk5nGfVkyStNAl50w9Js9RRLo9v1reJFoOVUGjPlW0P8r1tGLsURZjzWcbrGzcpLf7lRjvjzB7oGsVesWPA9opPlUmBTRFtNZ3YCLH1VRHbIoPOcVD1ZIMaDDu0Q85NTpauPmNmVPx91sP80AXQ==;5:+noUaH3eCjxxpzRDk+QwWwJBw8pax0ldXRlwSFQvNn6dNGwcz4/XFRqxjURWgk53EeE7hHIG1eel3FdQjODtEnIoLLuPE1oLEt7OGX3omRX5Ro9eiVJd5U/0EtbPY3cR6ZJhrjtoyw/xkw1ElWfQJ1pHD1sYLK2yFN1JqaCzFeU=;7:JhUZBb3bv5yW0oJrVg8HqbEqlxHYiMhCvKlW6ttZKy9L/dCJZJD2ElRppD7SpAK49Gces/spmylKB33yZWYa7vNWsigSQlgHSMoVR80fCUvc3fxWGXT6YEdlKAwkisBhYMMTsRz4lv1vEpdBQ8v1Vw==
x-ms-office365-filtering-correlation-id: 12ef0c84-5501-4b81-6cdc-08d664287327
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0646;
x-ms-traffictypediagnostic: BY2PR11MB0646:
x-microsoft-antispam-prvs: <BY2PR11MB0646D7B7AD020BE249CA253287BC0@BY2PR11MB0646.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0646;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0646;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(72206003)(478600001)(53936002)(2906002)(446003)(256004)(14444005)(8936002)(36756003)(3846002)(6116002)(2616005)(11346002)(107886003)(316002)(110136005)(54906003)(2501003)(14454004)(68736007)(81166006)(4326008)(97736004)(8676002)(39060400002)(305945005)(71190400001)(71200400001)(476003)(186003)(7736002)(25786009)(106356001)(6512007)(66066001)(102836004)(26005)(81156014)(6436002)(386003)(6506007)(76176011)(52116002)(6486002)(5660300001)(575784001)(99286004)(105586002)(486006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0646;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: agPynI1t6s2cUd+BVCye79OVqYMiozce8AH+58FfiUEO231lyh/nigAveUiNJDBvE5BQXZBuy3X/EXJkOmvsIN2vMTPjRGeT9dW3aU9Y44SsTq0F9GgBqXeiOuwig1nmGTZsBb6wDeynkpnEKs9LTcR4oLGWWtjc/l/4EHklqnI+/bxMK+EzJr0iCeSsZXPWf8YjCVzCZK/YDDP5jZoVdAJjsimgY3exye2er+81+L5J4xlLZ8JsP98hvS09APe/lio19WCTJaAYzpOMzTmA95PmykQ3ZLD2cIZJBCufEm19VVlrPVMbFQ6fDNMnc0Pi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ef0c84-5501-4b81-6cdc-08d664287327
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:03:41.6910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0646
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for PWM push-pull mode. This is only supported by SAMA5D2 SoCs.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index b72cacd5dca3..650d475a4c34 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -33,8 +33,11 @@
=20
 #define PWM_CMR			0x0
 /* Bit field in CMR */
-#define PWM_CMR_CPOL		(1 << 9)
-#define PWM_CMR_UPD_CDTY	(1 << 10)
+#define PWM_CMR_CPOL		BIT(9)
+#define PWM_CMR_UPD_CDTY	BIT(10)
+#define PWM_CMR_DTHI		BIT(17)
+#define PWM_CMR_DTLI		BIT(18)
+#define PWM_CMR_PPM		BIT(19)
 #define PWM_CMR_CPRE_MSK	0xF
=20
 /* The following registers for PWM v1 */
@@ -219,16 +222,19 @@ static int atmel_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 {
 	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
 	struct pwm_state cstate;
+	struct pwm_caps caps;
 	unsigned long cprd, cdty;
 	u32 pres, val;
 	int ret;
=20
 	pwm_get_state(pwm, &cstate);
+	pwm_get_caps(pwm, &caps);
=20
 	if (state->enabled) {
 		if (cstate.enabled &&
 		    cstate.polarity =3D=3D state->polarity &&
-		    cstate.period =3D=3D state->period) {
+		    cstate.period =3D=3D state->period &&
+		    cstate.modebit =3D=3D state->modebit) {
 			cprd =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 						  atmel_pwm->data->regs.period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
@@ -263,6 +269,18 @@ static int atmel_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 			val &=3D ~PWM_CMR_CPOL;
 		else
 			val |=3D PWM_CMR_CPOL;
+
+		/* PWM mode. */
+		if (caps.modes_msk & PWM_MODE_BIT(PUSH_PULL)) {
+			if (state->modebit =3D=3D PWM_MODE_BIT(PUSH_PULL)) {
+				val |=3D PWM_CMR_PPM | PWM_CMR_DTLI;
+				val &=3D ~PWM_CMR_DTHI;
+			} else {
+				val &=3D ~(PWM_CMR_PPM | PWM_CMR_DTLI |
+					 PWM_CMR_DTHI);
+			}
+		}
+
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 		atmel_pwm_set_cprd_cdty(chip, pwm, cprd, cdty);
 		mutex_lock(&atmel_pwm->isr_lock);
@@ -319,6 +337,20 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 =
=3D {
 	},
 };
=20
+static const struct atmel_pwm_data atmel_pwm_data_v3 =3D {
+	.regs =3D {
+		.period		=3D PWMV2_CPRD,
+		.period_upd	=3D PWMV2_CPRDUPD,
+		.duty		=3D PWMV2_CDTY,
+		.duty_upd	=3D PWMV2_CDTYUPD,
+	},
+	.caps =3D {
+		.modes_msk =3D PWM_MODE_BIT(NORMAL) |
+			     PWM_MODE_BIT(COMPLEMENTARY) |
+			     PWM_MODE_BIT(PUSH_PULL),
+	},
+};
+
 static const struct platform_device_id atmel_pwm_devtypes[] =3D {
 	{
 		.name =3D "at91sam9rl-pwm",
@@ -341,7 +373,7 @@ static const struct of_device_id atmel_pwm_dt_ids[] =3D=
 {
 		.data =3D &atmel_pwm_data_v2,
 	}, {
 		.compatible =3D "atmel,sama5d2-pwm",
-		.data =3D &atmel_pwm_data_v2,
+		.data =3D &atmel_pwm_data_v3,
 	}, {
 		/* sentinel */
 	},
--=20
2.7.4


Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D6ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9436208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H5tCAhnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9436208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbeIOGzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:55:37 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728669AbeIOGwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y+Q/bsOf7NdCvVUd5X4fLrNnEv9bqPvfqY9KOiAJMI=;
 b=H5tCAhnQKgR3lzz43VANMrZJm5dmgBoL1eZpXxAgTzwLDt1gT/d8e6SZ7h1FE6MknYpP1W3R3c7Q1EmIGhtYa/Vw/NZO4cDaFGkyk0j9mZlhyU+K7h2OE9CdzQNzfczGcjtTWsI1jK8tNzUkTPUBwvbr/Z7Vp8k00NKNyIn00QQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 34/34] pinctrl: qcom: spmi-gpio: Fix
 pmic_gpio_config_get() to be compliant
Thread-Topic: [PATCH AUTOSEL 4.9 34/34] pinctrl: qcom: spmi-gpio: Fix
 pmic_gpio_config_get() to be compliant
Thread-Index: AQHUTJRJmpSmwVKN1kCwweqYU+DHHw==
Date:   Sat, 15 Sep 2018 01:34:47 +0000
Message-ID: <20180915013422.180023-34-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:9wJe9RahJ37pcjYMvGmlaJl1O0603acKA3MK0VQMmGvVO/O3SBz6wvq1YSPqlQ4uSABe5Y0rNmkzhExSa+HSyALOOgWyX8d0KsjvUe6zqaI57mUEq0ZrX7imRmYGpm7AM8KihWjXFCeW2T4oMNiqOJZkWWb7sD1GmaYPXl6POa9PHBOMf1g/RmfVvzIGxukVPgo2cOv5aHZmF6DX0rp6FkTvZKHYWxgefT1qg/baxmX41l7JzwAm/1KFn9fChveUIkR+hPmTnI3qjX9u90ap5VHPdStnGgkFVQrAmPrBHbIVBE/0pUqNEibt9Tap9CHi81LT4Q6Tcyu1gqRcL86ooJ7SwHeDXOb5AzE1zsWu+vM61MdITGo1dOlo+DNVpmCrY4KIVLXpJcsGfXF0zjRNzOH9yZ3NN35dJcGhA1LLPD9XurYwrg4pKKjprT8G8YbqJt90dMbfzG3lKV3fkZGp/Q==;5:a9LTS0EVfODuOg4J9T8VQaMGIotdEkAXEkhIGilffUPVFlLm+Tv1n7+3Msap3R2mEZTJxh7bcymWly0I7PT855DvDzG968V4FxBeKLCxw53sdbXoaWTz6ETPod7BTTAsaUPxp2aNlFTO6jj3X9diBjhUaav4rG5zC6Sbn6iZkfI=;7:eZcwl+ZUyApvJMA9fWtW/6boEd98N4ZLv2zLOVQkYKXHTuW7YYH/miwT+ve2GZc8+9FNqAbsIC7GxEfR7gv3JSmWB78J+Xd6MyJ4P/ZA27b2Hp4DMl+aQEwIqwfkbwNIJJRQ4feqe+Rjpz6fA/CSzxGqBDxXBND7lE2ojOH8OEVJ44g8TC0w0X3s/laiaUdJDxZCY9DvCtfmIAUyrLf8joagziqVr44XcbYq+bshJ9vcC6PavwUdu8b/7y8QqqYs
x-ms-office365-filtering-correlation-id: b4e54151-b1f7-4c8a-3638-08d61aab7d95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB01812DF62E18101BAD3C649CFB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(14444005)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /ghSMTKT9jJjGi/fHfrNVhCsoXyVP1BNnGT+tP4Z2kqGmeAWkkumvWsK8vAezPMxTMOwkxJ2NXkYBrm0BV1ZD6m2DTEe30v+Xu2iTQLorS+8dPNBk7cw+v04CCYzDaB5n3TmMwgny+CUjCAqXVM97FiQr08sBphy6nY0wpY55TN64lOGFmn2OUdyTmXxriii6jevU11R9hktoDFP06iPutyKsdWn6EQUHpCS1i2GRYkBe3FCY5WYUXwqenAqAWqzWrrdpyDMuI1UdabH6AMEzI+YK+exQ+VpEzNjk/VD4hSj+XEHfVcbzrtJLgkkb6UTyy+VLdeXcdryB2Rnobr+jbulS06fD4gr3UreZcYYJI8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e54151-b1f7-4c8a-3638-08d61aab7d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:47.5515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 1cf86bc21257a330e3af51f2a4e885f1a705f6a5 ]

If you do this on an sdm845 board:
  grep "" /sys/kernel/debug/pinctrl/*spmi:pmic*/pinconf-groups

...it looks like nonsense.  For every pin you see listed:
  input bias disabled, input bias high impedance, input bias pull down, inp=
ut bias pull up, ...

That's because pmic_gpio_config_get() isn't complying with the rules
that pinconf_generic_dump_one() expects.  Specifically for boolean
parameters (anything with a "struct pin_config_item" where has_arg is
false) the function expects that the function should return its value
not through the "config" parameter but should return "0" if the value
is set and "-EINVAL" if the value isn't set.

Let's fix this.

From a quick sample of other pinctrl drivers, it appears to be
tradition to also return 1 through the config parameter for these
boolean parameters when they exist.  I'm not one to knock tradition,
so I'll follow tradition and return 1 in these cases.  While I'm at
it, I'll also continue searching for four leaf clovers, kocking on
wood three times, and trying not to break mirrors.

NOTE: This also fixes an apparent typo for reading
PIN_CONFIG_BIAS_DISABLE where the old driver was accidentally
using "=3D" instead of "=3D=3D" and thus was setting some internal
state when you tried to query PIN_CONFIG_BIAS_DISABLE.  Oops.

Fixes: eadff3024472 ("pinctrl: Qualcomm SPMI PMIC GPIO pin controller drive=
r")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 32 ++++++++++++++++++------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qco=
m/pinctrl-spmi-gpio.c
index 664b641fd776..8093afd17aa4 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -287,31 +287,47 @@ static int pmic_gpio_config_get(struct pinctrl_dev *p=
ctldev,
=20
 	switch (param) {
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		arg =3D pad->buffer_type =3D=3D PMIC_GPIO_OUT_BUF_CMOS;
+		if (pad->buffer_type !=3D PMIC_GPIO_OUT_BUF_CMOS)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		arg =3D pad->buffer_type =3D=3D PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS;
+		if (pad->buffer_type !=3D PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
-		arg =3D pad->buffer_type =3D=3D PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS;
+		if (pad->buffer_type !=3D PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		arg =3D pad->pullup =3D=3D PMIC_GPIO_PULL_DOWN;
+		if (pad->pullup !=3D PMIC_GPIO_PULL_DOWN)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_DISABLE:
-		arg =3D pad->pullup =3D PMIC_GPIO_PULL_DISABLE;
+		if (pad->pullup !=3D PMIC_GPIO_PULL_DISABLE)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		arg =3D pad->pullup =3D=3D PMIC_GPIO_PULL_UP_30;
+		if (pad->pullup !=3D PMIC_GPIO_PULL_UP_30)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		arg =3D !pad->is_enabled;
+		if (pad->is_enabled)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		arg =3D pad->power_source;
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		arg =3D pad->input_enabled;
+		if (!pad->input_enabled)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_OUTPUT:
 		arg =3D pad->out_value;
--=20
2.17.1

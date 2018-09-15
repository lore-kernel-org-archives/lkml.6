Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADAEECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BDF208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WPv4UBue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BDF208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeIOGvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:04 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:58848
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbeIOGvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoIKYlgKeSWFLrTITGgc20djY6oRsdPDIbQA52Sxrjg=;
 b=WPv4UBuedFF6Mowc7rOUKCq9xSl1vByBNj3Ym2dWbRuzGcYTfdbmoRYCTkHc2ACrLQ37n4f/oB1uidFVjH6p0RIi2Pnl9AMsOOAPz1LQYXIqEALMkRW5gbooBJiyM3DvLNy10T7y80zhgPMNyjbb1tKnIw78mQBwfCqwiSSj/P8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:33:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 56/57] pinctrl: qcom: spmi-gpio: Fix
 pmic_gpio_config_get() to be compliant
Thread-Topic: [PATCH AUTOSEL 4.14 56/57] pinctrl: qcom: spmi-gpio: Fix
 pmic_gpio_config_get() to be compliant
Thread-Index: AQHUTJQLF+HhAZCO+Eafrvk7bC174g==
Date:   Sat, 15 Sep 2018 01:33:04 +0000
Message-ID: <20180915013223.179909-56-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:JJo7LAviqL397Si/3pmYb2yDJHUJaYKfHa4EUx6/V/7dVQbpHRB2MAFHUzVRjhgEw1QJ7byuuUeEgifSPzoOxFSRhtCyhVZE8JYBaFHbofgK7uGIUguK1vEG9K1TY9evV+8F5Vx4uRFzkQ+SW1WX7ZEZ+EJo7tQ+caEZwaE8BTeLC32Xnbth9F3rhl6PkGO+Pin+XP0PXPCQaXByUZcarJHiO6fC9latTig8z8PY0799f9aQRR/vDwycLatEn7bjzHL9lX2xj+zWIxO/vgbHWtWveFy/CI6cmUbGjXmGevYDNI8AszQci0KycHECEplbp0Hbx8cqEh+8lcS1tUguCUsRcep9m51qp4dc+5YU0Bqt9U5YZ9mGmDaQ3WhQyB+ChYPoTE9t/3yx0ZF7bA5hLVry/vv5ltELSrHNz+h+2HXayhsmz/6cquXJBjb8CPBFGL219xJtvaR+7+OeMbzNXQ==;5:WEKJXmxvnokm53UJOW44vAZKad/1lEPnLyjcQv3rTnVIf5677DrshbDAj8z6PCAtjDpAYsDgtC4MChDQ7yzNpawlqRi0q0kVY8zp65F61A1HLUCS1GLl8JV+npwKn0O1fMiCB3MbeNqSjxEM8v/wwWHn/KSEYElFdeaNvjouQKE=;7:lcX1vbJ1ZJmgQQq+T8DcGd4kJkjrM7uhoeV220zQ48KRcJdZTubQGEmg7GJFJgQkRf+3m4qsHCDHiT85tJdBVDNv1fQq7WUZozte2pu2t6PJvZaEDvOTCoDU+iAzB7EnSJMwCA0rcCka5a/rw1XJ927V8dF3j/UfrjM+sy/2RhObjtexi2Y0zvbGjpox/6tjvh1jYuoHRcceYMXRCsD3U28xqkNglqNxnT31gK3W+KJRFFeTOtZ/s4x4kOJ5cexs
x-ms-office365-filtering-correlation-id: e2258bea-8015-4715-8f71-08d61aab3ca9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855F61F13F47538C64A5ED9FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(6666003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: tI51SvMiTVYyTcj3+aCssmrzP3wXstZ0j+drAtPkkKBTNO/wyCCeAj91qpslKAqXA7sIjhLeAo2/9Wpfm4iRyLrjcCEYu46LoiRq1sYbhon5tlc65iFZ8rdjVptXjQtX1u81yu93bHgEqVBREgPNt8t1Cs9jlHm2GemmhWYx9pQNK2sSLkHjfI5FUxFJxkPe+kqQPS8lUa322dWkTS0cVZxOBa0UxdWGAczLvg0BhX2a3jFHI+zYS9qfWtMhHh1wCEep70Dz3dcweSYDcHVqmqaWgNrhZosbiY8iYDqOCqorwptmGimk0CPo9KR7mMFah31wQWdNNhNm6p2ILWWYv3CqGjriZTiesJPGouaya0s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2258bea-8015-4715-8f71-08d61aab3ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:33:04.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index c2c0bab04257..22aaf4375fac 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -390,31 +390,47 @@ static int pmic_gpio_config_get(struct pinctrl_dev *p=
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

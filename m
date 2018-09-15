Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81386ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A6C206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iiVG3/aM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A6C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbeIOGws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:48 -0400
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:8380
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730028AbeIOGwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKtnGXwE7vPnCxCGVcAkJi5FaedS7bCTSgIqkv0mRnA=;
 b=iiVG3/aMWp/Fw2l6Gj1J7au5qpNdn3C5vV6oGX7YyxQo9jt0Aw9C523WoXSCbparDvZ2phROjDyQ6iqkLVkyKu3b9cpjhoFgja2DnGAUPeoLG0+Lr7kNqod0RDLI2KYjjGR96fjeFaz+FZlNJ4iWcXhrfcPiHr9iAzx3vCD9+w4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 20/20] pinctrl: qcom: spmi-gpio: Fix
 pmic_gpio_config_get() to be compliant
Thread-Topic: [PATCH AUTOSEL 4.4 20/20] pinctrl: qcom: spmi-gpio: Fix
 pmic_gpio_config_get() to be compliant
Thread-Index: AQHUTJRbrPpVERYP4UeY3DM/aSsCZA==
Date:   Sat, 15 Sep 2018 01:35:17 +0000
Message-ID: <20180915013502.180110-20-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:wnwIqWgOQFlOiJy2fWKhIwR3Rm21NUbA25kywvkz+AZo30Oa8+60UViS1GoUDc0gpHJjMePIYqXqKjh5d7ZYd2XCgs6nMThc8xipwVm0m1hgRXElO+pH8FNv/yWa3yxzrNyqUoLbs6rG1KEkn3F+TNjdtpmen9DKYlsAnB2k1F3wOK2z7zLY5QLSdx1yo0+4u8bRGUf/Vgg7b/aYBn69SZt3bSE8N3GcoMer8DEXlTTeFSvqzYcVbg0N9fIoYJUFVqUYgoEtmimm2gJu+v59Mz+WIC2v2ErwVv90Q5fGZCmrgh+arohgCuP8/QJm2sZeitJbzSlPCAhLnv+L/hQDkQgcCFl50XFRdrs6vWZdIJP+LvFs8tVQD3DFUMwUu4e/kgxzfr42NMObEqwrYiLuDSWj7bqQZFnJnDSlnrlBGkMJeW3rvRFFTju8BByl0ZLAhDMHFXsren7l9a69JxFP5g==;5:GyYOnRPZDWhBfgW5AEj3dbS3q6LsnOMUlXzbE4hn+MChALdZMn0WKyvOLLnC+3BIUos18NZBbmDPm1wA1VETGPVFuBBd6a6Sj82E3pDW1VgbamB6HgzSjRfpOum9knZox8YOtAGFG0DuLzEgV/RbVbS0MDoXpF018mCL7E0j9ao=;7:JJzBeXMtpx/uOrRe/wIKVMc1gol31SvNtt5N+3TKjddm5u/spD1lr+uNIDALQ40JsKp9efxitD32RkCaO00ZgJE+GNHQQi8lrFmOyzGrNxGuvfnlYT8giGcjRGqJ/qiantAB86F62oBcW4WIOpYNLBfKachrGptmEzautfJOCAemT3IJqYHu3CSIhRc0rA2lZdIW9ktzd62pauzzHwM8dNoe+thQTxO1xPDc3zQgeX41i3IF8HVFiSn+Tzpf/ixo
x-ms-office365-filtering-correlation-id: 034eb933-a9b1-4085-d107-08d61aab8227
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB0280607C7AE2CE58AB19BC8BFB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(14444005)(256004)(217873002)(478600001)(5660300001)(6666003)(6512007)(5250100002)(2501003)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(86362001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: D4mng0FGtOKD514aykBhQTGJ+sKm4lgraeJ/UYyQgskn+RcacvKO4h/MbiX278qqS48O3k8zTbmkS3ruIfcXybhjWDEY8A+N9aDqy966pLPMc+rgEDEGhfQdqwdPrOiPQmrxTAif5807yG0dIOIgGfFp2ZX4P5w2optARDiiBQyPYQNqnvHLSZRUY9LOOXk/hNhwoRnVf4FvZ6inzb2NbRVtVta27iapxvIxQ1qTz6o/HRkyvhe1H+96MicqKDGAD8D1eideuAmDAETdruiIGqc8iLsNvFTapWi9g3VTrdWHbrLBNCxyYVag05FcUzziyGBuhNQm9BY9LzroX4iM9bsHb3aZ9Wwp/DGyquqasTI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034eb933-a9b1-4085-d107-08d61aab8227
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:17.4570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
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
index 6c42ca14d2fd..4ea810cafaac 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -291,31 +291,47 @@ static int pmic_gpio_config_get(struct pinctrl_dev *p=
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

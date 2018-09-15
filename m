Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C9CECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB776208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lUdERaiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB776208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbeIOGtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:43 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729115AbeIOGtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qnj8mcDxUhGRHnbbwb7v1krnScBCLkbxszIjyzDFQAI=;
 b=lUdERaiEJkULXCwMU+kNCbKk/fmJpqte+cNSCqf5LthnpI938kP7qZw0kO3DI1jmpO0+BwIZWTufXoiiQdMJDMJhm51e6Q0lCT/hJ8J8+GZfw5+ch24enoJH0uEHWTbozofDbR0LBZmA5AWyOFBYsFNKsVrTIsF9ENMkp3RkB9c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 16/57] pinctrl: pinmux: Return selector to the
 pinctrl driver
Thread-Topic: [PATCH AUTOSEL 4.14 16/57] pinctrl: pinmux: Return selector to
 the pinctrl driver
Thread-Index: AQHUTJP94eQ6NLInnE6YAHmVywKh5Q==
Date:   Sat, 15 Sep 2018 01:32:39 +0000
Message-ID: <20180915013223.179909-16-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:3Uu0PTavuMUqsMPe6pfL6UjxQisIyb5hpoHG9VUjZpzetOj6dmPs71iMO1X28owvN81HXew4hN39f0oi8bI99IRRj4H8VFDPucXfyKeQCS4yVEfE2t1GmgjY9+EH4hFs3Pt9E3yeE+Q4cNIogKNTPldz3hnci5RJP8ksilcpTRTIeagEp/xk2OrIhhUGxKk8Il4NAF4D1BvFzzWPsZDvabXyeokXgtMJmjd5t4ItiQCizYVprm+6EsO0D8ia+pSZ8KkjUuHBFf6vXsGfWLP7PBmHggVQaMeh3JFJQvQfxmOK96Do6yXAJya1eEi7zHnQPW/pxvRACGbzrZeCAYPH+YTwAtzNc/hZSMhtM/GayOLOKAi7FnH0mbsFxWtfGnVfgoMrL/MSy+ExuVFTGP9u54PIDWnDkOkNGLydr9JrBxQkfg90QRaSq3Linv53OhliLm8ddZQ2KqUbull/Onmtpg==;5:XDrSPOf5oi9z4xvkYixQCj66VKQUl7xBes5mUJqhaIVEb0zaci50Hy+ThMcdN+qslTrxZzq26NJk4nOHnnPitxiWHUJ0EZ86IyC4nH8zIa7T8A1sCyp0a+z30vqEwJ+2ajRRpwwNpramHkMgVQMj5+klOlaPNYdJYyvSlu2Z9UY=;7:wDdJRfYWNM72ARRNhfWvtfBtASrdlDkzp6ep54dRmL+Wl1jNZEbgdW/6aw37egym8grZnzctcNCpf5scqfgRNw0sEa1VH2ZGiYcNbfqRWxbjI8PeCHLW04ZMXO/Mone3QGACM40V1hu59IDS3qrAwcxRKw27UFpxhaU+VgZ0CqA5V2hBulUzRIkLf3LRtWXTooKXl5en/7G/DUiLLSjXzdXeT40lehy0TtRUDSRvDXvULpCeIxQ4sDoTgxEKbC3l
x-ms-office365-filtering-correlation-id: 8a72cb66-5ede-4ce4-55d9-08d61aab1fc1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822B07AC7898A60C883F2F5FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(39060400002)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5CWxhPIOPjcaPbmomFbtwCI6GBnQBD9Dk3dZtTKqWgMSGIagFMPkrt4BesDYi3x2MYpRi9D4fOsqAMt+JiBg79udrCyCZHrEAzXuvY2jYLXV5uxCzz1EgE92wh+V9XNTuHPJl3wOL/oaYN0uDaMGN0mYtoSW0Eqo2TnZHl3HrigMTvk5fj/tDTZQPH5la36kTi9Uq/nn5TCDKClEtmghEOUaoC/AoFuu2lrMC3JAb99q4plGo/ciVUA+MHbNaakROhOItIf0PmPW/zC4hPlCF2dakZm7cytRIB1id8+VUYSly8L5/XwQRUaixRhnSsjOvRq2V0oEcvrBr9D17Ek3+xNr6XF7V7AxIqPUEh9QRsY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a72cb66-5ede-4ce4-55d9-08d61aab1fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:39.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit f913cfce4ee49a3382a9ff95696f49a46e56e974 ]

We must return the selector from pinmux_generic_add_function() so
pin controller device drivers can remove the right group if needed
for deferred probe for example. And we now must make sure that a
proper name is passed so we can use it to check if the entry already
exists.

Note that fixes are also needed for the pin controller drivers to
use the selector value.

Fixes: a76edc89b100 ("pinctrl: core: Add generic pinctrl functions for
managing groups")
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Christ van Willegen <cvwillegen@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-By: H. Nikolaus Schaller <hns@goldelico.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/pinmux.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 55502fc4479c..ec41ed209380 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -308,7 +308,6 @@ static int pinmux_func_name_to_selector(struct pinctrl_=
dev *pctldev,
 		selector++;
 	}
=20
-	dev_err(pctldev->dev, "function '%s' not supported\n", function);
 	return -EINVAL;
 }
=20
@@ -777,6 +776,16 @@ int pinmux_generic_add_function(struct pinctrl_dev *pc=
tldev,
 				void *data)
 {
 	struct function_desc *function;
+	int selector;
+
+	if (!name)
+		return -EINVAL;
+
+	selector =3D pinmux_func_name_to_selector(pctldev, name);
+	if (selector >=3D 0)
+		return selector;
+
+	selector =3D pctldev->num_functions;
=20
 	function =3D devm_kzalloc(pctldev->dev, sizeof(*function), GFP_KERNEL);
 	if (!function)
@@ -787,12 +796,11 @@ int pinmux_generic_add_function(struct pinctrl_dev *p=
ctldev,
 	function->num_group_names =3D num_groups;
 	function->data =3D data;
=20
-	radix_tree_insert(&pctldev->pin_function_tree, pctldev->num_functions,
-			  function);
+	radix_tree_insert(&pctldev->pin_function_tree, selector, function);
=20
 	pctldev->num_functions++;
=20
-	return 0;
+	return selector;
 }
 EXPORT_SYMBOL_GPL(pinmux_generic_add_function);
=20
--=20
2.17.1

Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B5EECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3B6208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UIf5Qtdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3B6208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeIOGrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:10 -0400
Received: from mail-sn1nam01on0101.outbound.protection.outlook.com ([104.47.32.101]:52800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727994AbeIOGrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4zgfptFEeGqg/ICEV+H3PRakObDkw7MXn2cUb8iJrU=;
 b=UIf5Qtdqn7Y2VTmdUFUgS348echoChWOVHRpNmAq6kRNqi+BBPfpuYTqJhqeYM8Xjd5EwjOKtHbgXcg7ka1/9/54fLGYD/95JC0NVdz2DTNBivKqtii5Km089PuLufpb0YtqWWJfFDenEFH4K4Xc6p91CttnaQJV9q/TqwrDi1Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:03 +0000
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
Subject: [PATCH AUTOSEL 4.18 21/92] pinctrl: pinmux: Return selector to the
 pinctrl driver
Thread-Topic: [PATCH AUTOSEL 4.18 21/92] pinctrl: pinmux: Return selector to
 the pinctrl driver
Thread-Index: AQHUTJOg9vVUfoMxVE+RRbhVAAmRQQ==
Date:   Sat, 15 Sep 2018 01:30:03 +0000
Message-ID: <20180915012944.179481-21-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:UOWs2VTkd/EpIE3q2W9rjTlltSNHeJx2ESNyVr4ZTVbm9ItlJo1ucFQWFzqlEgyq/jXnPvLGWO0LFuvk60saB5pIXLtaTgw6v/8qJvGmDczs8FQU6f7chc5husBU4ATkfK0FqrCiyAw6EpWsJGtOAIPQQZI+57UB7i9yrIFgucWEE5agY783Uj5m5I+Y8usrKT7LpOwrWugkISfD2pfCXdwsNF7dtyuxTUdFA2UkkViDuIBzTSQEBUNM6cR7Z98S7ofU6MG4si+wT1Kwcsns4cCF19gHVnsgT5FMzZ4qE4RnB7/pulmOWaDhHaFgcIdNTndg5Jg4a18FkePfWZucf/kh48kXEqaSi9AKgn4DHHyCVU/pMfezBLsCQBQiOe3z9aAn2pUFOwU8IeyENcOnRH6HCMHB4a1CQDjoUI0ZPu8shQSTLNSt6V0dI6r9cWH44PqDol/qcbMDu3qtwb+2ZQ==;5:kpT8cBUIQqozmLMxfgom6K8lH6pDqZ0ThjaGocEOihxoDb63Im1nOuYTlMKl5FBLV1ES2qdRcr1RidKQbORMFWc7byx+mw18g+IXacpev8b+r6JyKc6Vh0S5hKmq68966KOkOFNxHxOQppHVneRMQGaOQpFS8/JnEIusKn2e8wE=;7:hRPNQi6pE5s+4ZZ1afkWaSf49mgs3UgFLhHvofWWGWPvGPIZr/VroZlwut2Nfznk4OkL5BLN6t8S3PkWkSL43DIfdzl6xRsJuMiM8ZoRCC+2UWXVyZCYZJh2nddIx2kA57XRiqU+fXzAeuYB8dS9WGNnYSkuY6H6B984mEnGr/FhbqD9mT02p9cUn6I5oddJNTq+PJV1zHN1Myt+IU0neCuVfHkNk717G/P1LOuCDlmDj0AcA5EU3bhx7MJxYZKz
x-ms-office365-filtering-correlation-id: 2353f457-7c10-4ac5-9f01-08d61aaac308
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB0824FC124229077EF75B7E8FFB180@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(6506007)(1076002)(66066001)(22452003)(99286004)(102836004)(76176011)(2501003)(5250100002)(97736004)(54906003)(6116002)(186003)(39060400002)(3846002)(107886003)(25786009)(11346002)(6346003)(446003)(486006)(476003)(26005)(2616005)(5660300001)(10090500001)(86612001)(86362001)(36756003)(4326008)(217873002)(316002)(68736007)(110136005)(8936002)(81156014)(8676002)(2906002)(6436002)(14444005)(256004)(72206003)(7736002)(53936002)(2900100001)(478600001)(6512007)(81166006)(10290500003)(105586002)(305945005)(106356001)(6486002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vbDPSey8vHC1PgPJTmLHAtPBWeWmAGmQnqds5CiEHcYRboevInC4iIYLSRfCsH45JmITjaPjNZ5z98qPxTCGXvcZeM6VPSc/tmBF9HnwLZs+L+t6whUy/SrTjIMP2OceqBkcndD6iBmMqxrWHGCjwMP/3qegmCryxprOhi6AW8FF0rfIl9JWhwCJe+8jfik58ERFXoMT7mf9MgYBm3hGNy6PnRcZS+th7lzh3G+vp+8tE4jWZQPXQ2XGKKEGxEJ7QjvgvPW+fVC5zEGeLQpzn7zw+4tvfCGtBruDVJ3QKS/JTPspBf7QGb09JHMx7tXuzybQjiOZ5r13kpwMlsrxnJ+us0RgmDOGnWtrveshIko=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2353f457-7c10-4ac5-9f01-08d61aaac308
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:03.7138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
index b8e9bda8ec98..451e7fdfc8ba 100644
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
@@ -775,6 +774,16 @@ int pinmux_generic_add_function(struct pinctrl_dev *pc=
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
@@ -785,12 +794,11 @@ int pinmux_generic_add_function(struct pinctrl_dev *p=
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

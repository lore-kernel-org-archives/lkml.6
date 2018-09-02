Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F70C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8BA20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KLqyNRZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8BA20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeIBRUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:47 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:62112
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeIBRUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLAd8EB19nXOPotskAiXJ/W8/lwke6bbHt3GfAzeoY0=;
 b=KLqyNRZrD5rXidq4lHzOpJNDMXp4chZm62RjUnsDqh+uLvXCUGFAJiq0jkhxFf/UUavnbmoP3qnLBgtML54JvxzAuOc8qAAhB2ICfKcRcuMOlx2Jn8wEkj/eR/M+W663DhqN7ly8SJnu7yNKPaHGzryYTxjSTqMWKK8o0Zq3LT8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 076/131] pinctrl: imx: off by one in
 imx_pinconf_group_dbg_show()
Thread-Topic: [PATCH AUTOSEL 4.18 076/131] pinctrl: imx: off by one in
 imx_pinconf_group_dbg_show()
Thread-Index: AQHUQr2C1c2OqM0S9UWnsor39aRMGQ==
Date:   Sun, 2 Sep 2018 13:04:40 +0000
Message-ID: <20180902064601.183036-76-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:2COjTnIPwTkanNpcWtU6uUlAywgyeXu+UJAQiZC7taFn/DiyC8pjlrlyeQJ/WsZDVitQTyIhtxIhLsLcMo/JTj2nfZIDkIPqdmJJulRE7kKnDz1tJNtjQvrpFlDt4MSRimVgGHWDRaH1vNRXlyngHF5B2Xof+07QBJkpCSvZoTZfcDpOYV2IZ5QQaE2dBX2MNqfG5Srpj1lMi5s+lmfCUiQP3P4U/FCcCr+HxEMILQv7xL7cnVuMCvlQHrjLgfNWY/ZarLSWmNoMayBbWKNRfacOZM+Xiu5+4M3fOOirkGUpc84tg8RbjroZOmtHKolJyV39RaU30XaBuHe5fPJSGRjVAljHlNPvQTwPHM/BouA7hN3EuPBMoNRxcGOTDpRswsbjmZ2a7XobOFHn/n6xb+dbQbZkwc3EoTTPzQD9Qkh42ZPbQkf6mLSjOLRaODvi4o3j74Mz6+JHysN03yblLg==;5:cHP0U+ExnUh+GuNawAyaR8GaZMSKm2c5sJIp6fAj91OlsHQ3JIZgaTj7gAQTaSecl2dmgoVgNPXal3FfRkkao+tQwgE+5/L3lKW5q7IdSF5KVy5L/GRspePyCuSYWH3LVe/R1mIDed2FTybqgXeTq2M+K0Nohvqxkc5Ff4JsUck=;7:enX1WPnbMe3ctoIWUdJ6o/mz6Dm/g4o3gk6tNDKxuyUGX49DKjcTzD4lzw7UExVfKgIOx60RlC/Z3UZ1XSfJBks1rtVZTFiS1Ln4yArMW9CcqHyavK6QUDNNxEZ/boKTVS+XBoEPr9wjrhNrAy5cVmx3y+zwfQAFfLm+4sRW7EbGg1DOzCK1Dn1av56bGFkdwco+fv+zE5rXZP5dDiCSD+aqIvny7YiRhtMayZkxqRDxBJv46LfT6sxBnDmEuUN4
x-ms-office365-filtering-correlation-id: 182e7bb0-03de-4ae6-5ea0-08d610d4ad8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074184B04A7F3600B7A1C85EFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KG+3Gfz5CLr3cjfKsutoP+EK9HR+OvuXWummrzyP01lOJjhEvAMBGhT+NJPHW12SbbVcMkqHnecdYsSgWHE9ur0M/OpTULFYiJNKkCjY35NE/GZQusXJm4tckByphBUCEO4lOK1qcl+gmlzCXfVubp8ID/8G2A7S1H9KfGaH7ooBFuqKBAZp5e7CQQCa6zDfIO7qoWXtVfdhzIlpq0gvyiLlI7ZYa5tGIcn9Qf0pxVTsoHc3vOIBQfLrv2/VdYgchODZ3bg6w1L91GnTQ4gYvxjVcs1dq1M1SfV5770r7JcbEoTo4iZunPwf9/YxJgTbUElKBYS21WuChsz/jSwb16v0eJDs/+kpN5G/81+R5eg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182e7bb0-03de-4ae6-5ea0-08d610d4ad8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:40.3931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b4859f3edb47825f62d1b2efdd75fe7945996f49 ]

The > should really be >=3D here.  It's harmless because
pinctrl_generic_get_group() will return a NULL if group is invalid.

Fixes: ae75ff814538 ("pinctrl: pinctrl-imx: add imx pinctrl core driver")
Reported-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/free=
scale/pinctrl-imx.c
index 1c6bb15579e1..b04edc22dad7 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -383,7 +383,7 @@ static void imx_pinconf_group_dbg_show(struct pinctrl_d=
ev *pctldev,
 	const char *name;
 	int i, ret;
=20
-	if (group > pctldev->num_groups)
+	if (group >=3D pctldev->num_groups)
 		return;
=20
 	seq_puts(s, "\n");
--=20
2.17.1

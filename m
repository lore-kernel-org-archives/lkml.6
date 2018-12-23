Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEA2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC6421903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WJ4fLN/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLWG7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 01:59:55 -0500
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:45616
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeLWG7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 01:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfjTJjSvQeJo2wMkBgmDnNtwqve8vNVJHDC5jPpLFcM=;
 b=WJ4fLN/AfBaed6CsWu4j8OlnUZI7yGpsjzyrq9tEiaAZjFjKRfK6S1LXVI9pgnazI6yHI6TO/xn+pyE2dRyH0F+0crnDO8R+edCewEpY9Vm+/RjnQLhOhehTXT77m8s0RPqypGSgf7KA6ZnnK1zN1IMl3zAAxtqff5eEslo2nV0=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3383.eurprd04.prod.outlook.com (52.133.19.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.24; Sun, 23 Dec 2018 06:59:50 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 06:59:50 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Topic: [PATCH] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Index: AQHUmo0ZxZkW3cAPxEypasRMKtmrGA==
Date:   Sun, 23 Dec 2018 06:59:50 +0000
Message-ID: <1545548380-17399-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0034.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::47) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3383;6:0VEvolA07tz2xyeJC3oFqC/5csqoRH5CKXSFj7awPKq85/7nL8rwQ7z771OXWcCaVsJjJzMWp6Nc/6sF8pcSkG7rQ4XrB4HOXfV4TDNGGIV0nEpNlJJDxp98tI7FQxxjxlQpoSLX3AMILJlps1pE+9XhbbnU8StqqbUeklw2brX1yZz2E41AkO3Y5fobcTNnXZc3iR+IAE8VcQgT2DAa5NHcEctmfCSFPmJEdxZsGx2JQ/5A9y701E2DaON5iWGsrhyKowVZAZaCfKzPajAbU76j+dh5kq4L4Il1dpNJ0Uafvr9U81DpjKuiCaQqYaRgh4po0lY8bV9TpGIXTvsydzqG2Sak2Yrdei8R3aUW9cbaHhb7/BFMvs2Z3Q/C6LKvHF/T8rvuRfytYJ8P5Eq4EwzI1f0t/jnmh6s6QPikil9dw84ZmsWs2sLUds8bwS+YUjdnfS6pCxpIH9mgptFVow==;5:fV6J03h4VNxbAhYRtsVR/Dt7k53VLO14MSpjMiIEZch1yun1uisje49DZwVIxZSwjjBcx0YmtUdZQrYvPW3zdHCWV/HdH8KAOGsYwHuZDtLNmqw9S2Bpb/XhJzoIF96K+fJNqCdC5dsk5Wyy4cZHHpuxAMg/I4+eWGSudKFKtIM=;7:Y7lf0iry+kjz2X6SYlkUeeik4WyDhAFvi4/0PWxi4E6Uez5dXXstdsUSirWcmRopN11CYZveM7OO6pdbq0Pp+oPBtHCc7dVY3pizMH54+mMEFwUJGXnXz+pOpF3+UH4QoM1VX9c217YFryLob19m+w==
x-ms-office365-filtering-correlation-id: 09afb5f7-9a3f-400e-d467-08d668a43b5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3383;
x-ms-traffictypediagnostic: AM6PR0402MB3383:
x-microsoft-antispam-prvs: <AM6PR0402MB3383535026CB4A4CAFE1E395F6BA0@AM6PR0402MB3383.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3383;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3383;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(366004)(376002)(189003)(199004)(44832011)(68736007)(8676002)(86362001)(7736002)(486006)(14444005)(6116002)(3846002)(316002)(66066001)(97736004)(54906003)(110136005)(81166006)(256004)(106356001)(105586002)(6636002)(8936002)(81156014)(6486002)(6436002)(6512007)(26005)(99286004)(305945005)(36756003)(52116002)(102836004)(386003)(6506007)(476003)(4326008)(2616005)(478600001)(25786009)(2906002)(14454004)(71190400001)(71200400001)(53936002)(5660300001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3383;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yaIV6p6sZwSE/BhbKFWhwpM3RzdjnFR8i16TsZlhmLMUnU0gTP4vDCHfY9pTSBbq6loP2JmbFfEsHHZqzS9wEP7TV+4OLW3o7OX7Tstt+y1sJZMieIOp1tegbAPFEuv+YfjzUdhB805fVBjNfVwUn9ngIul1mrsMkE864s0z/We5uc6lMhwz7cEKJVYAziZDlhEswximNYw25Tt00K5fUHr4f26Vz8Dzd2yYJWpbaO7E6USVNX94QclezyD1+Qv3149aUnghtTzQvu/KC1VLQaWjk3yZyaJzT/Mf8JwCd7gEZL/RSkLbcQFgDtFdjtCL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09afb5f7-9a3f-400e-d467-08d668a43b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 06:59:50.5149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is going to be used on more SoCs than just i.MX8MQ,
make the dependency here more generic.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 2112d18..7ffbb6b 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
=20
 config IMX_GPCV2_PM_DOMAINS
 	bool "i.MX GPCv2 PM domains"
-	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
+	depends on SOC_IMX7D || ARCH_MXC || (COMPILE_TEST && OF)
 	depends on PM
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
--=20
2.7.4


Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D335EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DAF21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JdT7Dk+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbeLQKhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:37:54 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24868 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeLQKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:37:53 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="22360662"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 03:37:53 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 03:37:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dkpiSmOuy9dfxWqlXTk09b4B7dJU4P9Wh6comcpmy8=;
 b=JdT7Dk+Kdq7EmJAou7Oo7tnTcjKZLqY+WxUgPMU5nX04wvak2ntJD9sMFAxWf5EAKa/mCXTOX2WRjRUbojCEMbKMD1ljRaA3UKddA1Wk1B+1lHSvA1CB54QDOW4UvatnX2DDoxCONo2dJuCmN9dwHQwPDPUrFQOHvRgs3sp3m7k=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0517.namprd11.prod.outlook.com (10.163.158.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 10:37:51 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 10:37:51 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH] regulator: act8945a-regulator: fix 'defined but not used'
 compiler warning
Thread-Topic: [PATCH] regulator: act8945a-regulator: fix 'defined but not
 used' compiler warning
Thread-Index: AQHUlfSPupUtRhE8V0OpXroyWEqAHw==
Date:   Mon, 17 Dec 2018 10:37:51 +0000
Message-ID: <1545043055-22413-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0142.eurprd07.prod.outlook.com
 (2603:10a6:802:16::29) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0517;6:svTGxTajPSTHJK93H3195VdvnqtKyooZaoAjGlMNm2EhyKPciyPMrR11evs8l1m500L5OOe/MED7r8udQQ/Dul3MqvAQj/Bs2+GZdmXkBvZKgJVfhjTIbJ3bTvXRnvgs9sWG5CLmF6lSSu4TpdzQmmIw8LzkzpQ3Man5h9YkSbiX2zQ4LBliWdYfUVBFWjf9M2kmdGP9mDXiNOP0hPoksZAIDgynRbsEiG5OvppawVojxILeadymes2TmZzQvtME2lwMYcuB/3mYw2GSRRYq8uDzuZTsR1vtcYRw01/1zfH/HC3bSLlvwQLB2R7fxBFv39hLmXmYk7qdNTCH2rNuuawQQJH2EffDkE1INcrrda6g94PhLdzHD3pRsWdadJps0dOF5T2AhGBcw94HSf6FukNxI8RH0ePToTP8UG4hAAk4UGY6AnpPHWBJ8ogRJuByJXEUAzJzG0xHPwrFHogDzoV0ISpU2ZZ7Z65jnir3M44=;5:wK6UFaqx3xUdsxOWKBy4j9WHFfYDakOG35++ZYJGasSp5sMjdj3GueYbK/NaduuTybimgYC6zJpKyBA+h//V4mWrSkPe6f67yytTRAp2s/AVfNoT/dGiSEhVIG5UoRNA6/A8qdwpKq9e/0ccylZb8OFZVsOdSjc64RBuJvDNhb8=;7:cvSTREtHZUj6F7JpfgmaP5lz8O4Uow/Y+77YW12H96tz7U66kaiOflblmsgBu8/sYlmoYH4goLc5CX5e+9rvzE7I4ewmh/U0KiUdfwugAG8bCEZIUAuBiPRMYeBfMUMkMMsCWA+yGa7wseTc/xLhsQ==
x-ms-office365-filtering-correlation-id: 6beb58fc-a52c-46a3-30bd-08d6640bb1c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0517;
x-ms-traffictypediagnostic: BY2PR11MB0517:
x-microsoft-antispam-prvs: <BY2PR11MB05179121C63998AF43AFDC0B87BC0@BY2PR11MB0517.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0517;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0517;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(39060400002)(14454004)(110136005)(72206003)(7736002)(54906003)(4326008)(478600001)(316002)(106356001)(105586002)(8936002)(81166006)(81156014)(8676002)(14444005)(36756003)(2501003)(68736007)(25786009)(5660300001)(52116002)(305945005)(2616005)(476003)(256004)(99286004)(486006)(3846002)(2906002)(97736004)(6486002)(6436002)(6116002)(6506007)(386003)(186003)(86362001)(26005)(107886003)(6512007)(53936002)(66066001)(102836004)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0517;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: puIsvkE0B2SCBfb8TUADYXvbfWehaRfafoyOGp9ieG7HsUnH9bT2egSDDZQK4le6f6OxZZGkEYlAG9FpvcRa60TyDP78IoNBXIsTedv9CBx30VdQ7rQmzEY1WiozZ2FXUttPVqQalWiua3hP8m8w4jSyHm0uhepdPzvhhhX3XKDdhyY7gc/LzkTk3EDMBX44cT4iJ+ngMSNT2rwpNcEIDt5gQO5pQ+uYVJ++M5B/LE4stmfB4CUPzg+6v8IHvY/Aq5HbkkvmB8IwbuwUJbLUn/hHAZsOy3RbqSn6JmomeDBxn3nM49BJ+rBBr6mXeIQ0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6beb58fc-a52c-46a3-30bd-08d6640bb1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 10:37:51.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0517
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Fix 'defined but not used' compiler warning for act8945a_suspend()
function in case CONFIG_PM_SLEEP is not defined.

Fixes: b5ebba46e694 ("regulator: act8945a-regulator: add shutdown function"=
)
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reported-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/regulator/act8945a-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act=
8945a-regulator.c
index 90572b6370c6..157272536122 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -326,7 +326,7 @@ static int act8945a_pmic_probe(struct platform_device *=
pdev)
 	return regmap_write(act8945a->regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
 }
=20
-static int act8945a_suspend(struct device *pdev)
+static int __maybe_unused act8945a_suspend(struct device *pdev)
 {
 	struct act8945a_pmic *act8945a =3D dev_get_drvdata(pdev);
=20
--=20
2.7.4


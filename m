Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4692C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC2820855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="a9flKYY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC2820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbeLKP4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:56:52 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:8846 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730661AbeLKP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="24082987"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 08:56:48 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 08:56:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN1Dg3nIpUQbfLfV7zTXkz/v8csDo2gqNaWQinGdKVo=;
 b=a9flKYY4zd0YNPO2U7SyqjMK5gcif10cmiwXUwHWj+ae9GAz/0TRfh6nVsCUex2gqe2W2jYRmuIOPny1t5+jK53LYUXcdaFtIJwSRxMa+JQN0dPig0bAbD5kUtoukKDMFLPUxVw+r/vafHbY8yRp1LDkOmqheoo9OsvncpaRt4A=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0792.namprd11.prod.outlook.com (10.163.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 15:56:46 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:56:46 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 3/6] regulator: act8945a-regulator: fix line over 80 chars
 warning
Thread-Topic: [PATCH v3 3/6] regulator: act8945a-regulator: fix line over 80
 chars warning
Thread-Index: AQHUkWoeUjpnY0WHW0WHOf/toQJMVQ==
Date:   Tue, 11 Dec 2018 15:56:45 +0000
Message-ID: <1544543768-2066-4-git-send-email-claudiu.beznea@microchip.com>
References: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0050.eurprd09.prod.outlook.com
 (2603:10a6:802:1::39) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0792;6:EIQucF8CrY4TN5rDRX0QQat4di6ak7IyDWX56XjGKkPlKkGtb56qw8uE7EWVQ2Pjg4RyVrmyKJqWrnkpH8s+LnhjX19i1fMlEDdBdHowXzEVDES5GVJxXTkTp3rGdNT8+wx2+k5Mu3F7hGBJiNR4VVJfAo9S+qYHLld0hQJMKsvGaD/sOTdv0Qi3cPfSAUDzbSPnDBO22/SrkUwns9ccaVnOViNmJRi5MJIZbSG0A6A6wv3bsGHf7GVZimySVsLTSenR4cvWoWfK5CB/x0f8S2RNjSsdBvTlBaq0fr7/KeUpBAXHbjyqIa+ifi4yBnaz8ptHQuqN3T34nSlN5868Q/h0vQIhny9/k6xmlp99Fwe9pIy6D087BoPCNkP9iQuTBFtIePYihMgHZEXy+be0YlXXd6q8Zpxx7GgjMUZBdH44elRTggCpqECyuSNyObkPqsbDA+I0gFMULelbEE58Xw==;5:AAKRXIcYi0gFn9hgiFafNrF9ZLKI5jNaqiGRSyk3I1VuegBdr7YhJ6JgwX4jJvPmyuiFwmLichdeVEptVPmEJ8mRU6TorNr1+76B2dtSaOHEH7G5n+8F4rZbCsvY4dre4rFBMAUfrZ+Z5pAbeg05fnfpyuLSNTDqghd+T3NaULg=;7:9z5c5ym+Z3B8fMRgUTritgvJllStxfW+yBR3PhkjZq7xZjOYdBcttSnKpZklxYD/41G94NDyldOn/5uOOlKck1KpcqOYaTvFW0krkcMHrgbE5WFq6NZE7kXRyMHnobnd7pLf+5v1MLJXZse3Dj7p+w==
x-ms-office365-filtering-correlation-id: 50dc9fa8-08bb-4913-dc6d-08d65f81405c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0792;
x-ms-traffictypediagnostic: BY2PR11MB0792:
x-microsoft-antispam-prvs: <BY2PR11MB07927CEB6E55897D9267F0CD87A60@BY2PR11MB0792.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0792;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0792;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(54906003)(36756003)(476003)(14454004)(39060400002)(68736007)(53936002)(72206003)(478600001)(316002)(106356001)(110136005)(305945005)(86362001)(107886003)(7736002)(2906002)(4326008)(102836004)(486006)(81166006)(99286004)(8936002)(25786009)(186003)(3846002)(66066001)(26005)(8676002)(76176011)(71190400001)(71200400001)(6506007)(52116002)(386003)(6116002)(2501003)(81156014)(6512007)(5660300001)(97736004)(2616005)(6486002)(446003)(11346002)(6436002)(14444005)(105586002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0792;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /O4IiDXJgSp9+Hmn7/550WFaxE1rHABUAseGLjP5x/7sq/bS5uXlGmf5xSsZuyKd7r+RkGezXIquUCAPVGBAWRorhaV73hXeYQkKDLt12x8jER0DAJyTU7lNWSDelo7429tl6xyQJISh1YvJggnxvtlgZeg91UR4GFym8NEySBwAWIn6TSt0zhDB1+jQZKqb/92K0IE23q7hPHcobefm2NOyXQNEyt1gTMc0SKP9+YcE/8Hl3W/l80sRjXsLzqkowMBq8QFnF9T/K7OHZV8MCEnvX5IH7C/QHDgYmlLG/HpDZRcPpmH9vi4Q/cnuPslP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dc9fa8-08bb-4913-dc6d-08d65f81405c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:56:46.0026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0792
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Fix line over 80 chars checkpatch.pl warning.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/act8945a-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act=
8945a-regulator.c
index f37d1a860407..f4d60743efb3 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -310,7 +310,8 @@ static int act8945a_pmic_probe(struct platform_device *=
pdev)
 	config.dev->of_node =3D pdev->dev.parent->of_node;
 	config.driver_data =3D act8945a;
 	for (i =3D 0; i < num_regulators; i++) {
-		rdev =3D devm_regulator_register(&pdev->dev, &regulators[i], &config);
+		rdev =3D devm_regulator_register(&pdev->dev, &regulators[i],
+					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev,
 				"failed to register %s regulator\n",
--=20
2.7.4


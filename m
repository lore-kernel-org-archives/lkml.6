Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041C2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB36E20645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FpJ/sHnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB36E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbeLMMuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:50:37 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:35905 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbeLMMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:50:02 -0500
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="24317964"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Dec 2018 05:50:01 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 13 Dec 2018 05:50:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN1Dg3nIpUQbfLfV7zTXkz/v8csDo2gqNaWQinGdKVo=;
 b=FpJ/sHnSbvI8J/FhuTTqCsjLRyqr0+IslFLMq5Y9DQ7eqxdoirtKPxUUPyUlkq8OuTGKVGamnL0stHi5YMgGcQeWlLHgypU7NjgY2gtKmh9h0yGJT9jWXko/+TNwPcVxdLaC9SFPT+WogjP6nqDShTmwUYatn9WwSI186HIbCR4=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0519.namprd11.prod.outlook.com (10.163.158.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 12:49:58 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:49:58 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v4 4/6] regulator: act8945a-regulator: fix line over 80 chars
 warning
Thread-Topic: [PATCH v4 4/6] regulator: act8945a-regulator: fix line over 80
 chars warning
Thread-Index: AQHUkuJbEDUKpOh7VkeEzAI5wePo4A==
Date:   Thu, 13 Dec 2018 12:49:58 +0000
Message-ID: <1544703110-27161-5-git-send-email-claudiu.beznea@microchip.com>
References: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0519;6:qaUoisCj88S52o7nbI/Nezxl+dRO8fXRa6kxxpmACqiMkAWECCNQBJ8peDxLbUGKpC1DDA1sKq0MZaWPaiUvHaU/1gydAgWFzksz/2OAIMhBLNu6UDzt2CVA7zpLVRBfGoAlw0tVD60KrLhJajOtRc+raMafoifnkXZqSluso94f9kRK8YCduPL8uk/zXv55TYrORpJ9fuhLyid8hQRsCa+2Nb4GsV3KZdMbyIE8RTCwYFSc7D9F/pYYl0SqLke1J3cFZhfD85uwcChTasb7IuqYDddOzrntcLYH1Y14WWx22oNNy/6LWYg/fpdr+2f8MdH92o/1iRIE7A8srGziW+JsRkWrZYpALv14bCTJbxPCo69BtZbo701xBP5Whk/l0R3MdGmQM+ary5BnLIzaT7J46T+qI68EhjAogWo3BxVdnqUcN2lTqN+Bgxs+MliRb4Vgbwmk1MM9qPx/sQ7DeyYWP+wzZ/aQs4XLaiJU2ZU=;5:A5QVzNKhWRAL6aJvfKxz23olzFGdxio2irCPOIqODRHN6ECS/Mn+9suajN1ldevK5GzLTlPOcQWbv6cHlMiDRd/LsMlteJou5aftaeyVIi7CTBEkaeTQF1Utt1Y5luxYjrURPIbKWMclAljugm5TkD0IQ3241OhTPXnuW0DMIwM=;7:nzZG9NU/Z7zy/PfXjJ0fRaS5N4gxkWh89dJUbALQ8eJ4VDrtPeMD8bZ1jhJlGiRSFYlxbvl8v1bGfTiQ8DchzO1IqgDXSVxk/w2BN+qxjMs9CsPfZQPKk12Q8px8BmoT4ugzOZTsaymzgkH2SdkJNA==
x-ms-office365-filtering-correlation-id: f971ce38-670d-4670-e1f7-08d660f97d34
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0519;
x-ms-traffictypediagnostic: BY2PR11MB0519:
x-microsoft-antispam-prvs: <BY2PR11MB05198F36009851342F09475487A00@BY2PR11MB0519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0519;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0519;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(316002)(5660300001)(305945005)(8936002)(97736004)(2501003)(102836004)(26005)(6436002)(36756003)(99286004)(476003)(68736007)(3846002)(386003)(6506007)(7736002)(14444005)(76176011)(52116002)(6486002)(106356001)(6116002)(186003)(4326008)(105586002)(6512007)(256004)(53936002)(81166006)(81156014)(8676002)(2906002)(66066001)(39060400002)(25786009)(2616005)(86362001)(486006)(446003)(6636002)(478600001)(54906003)(107886003)(110136005)(71200400001)(71190400001)(72206003)(11346002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0519;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g3zyItpywM1op4OuYiK16CQNqkTAiH9cHybcVC5uAvMBo3K89Y0j20bCqi4POhNMM49HU6r3kw5Gk3Ts5jp0uz6JVyABeQ101HepWnh6OwyjHZIH3SvCtxIZGEpBDkpOtdirdrDiXEU0FCJAYZyToYyUEqxI7/BqLUOyC4CghLrI1dW5foJwXpv9zOOrtJehqK2gSDCK/+vUvAhq4Uu4cAZgS7tG1Awas7P2oD6FIftOiiB4uKcGU8dqG+4SgW1sRKPTxNPo/5arCVmwa6WcNhRXKtXwny3iDBoJTaiZd364FO02ryQ5H0tO69J6z7s3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f971ce38-670d-4670-e1f7-08d660f97d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:49:58.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0519
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


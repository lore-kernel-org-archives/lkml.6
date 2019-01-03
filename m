Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8872073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SbQ9qzc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbfACNaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:30:02 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27261 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbfACNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:30:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="22933262"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2019 06:29:59 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 3 Jan 2019 06:30:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbW1EiKkgAj/gBxHMet2Sam7zBrYJeYeJuf2xaMqGnY=;
 b=SbQ9qzc6cCwi2IRrtliRYg5xU5+KRctbLcGMKHqZrDx5x0dI+5izwFV6135N5prbErvaSMiQwwUx28VpfOJnXA9AAj783aOqBd+pBnDH1SOY6zW+Z2e852WsKlIHiGAHdz+sa/TKfrM5TmrQvstaJ00+vbYKMXKI5RdPCsqqR5w=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:29:57 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:29:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v8 5/6] pwm: add documentation for pwm push-pull mode
Thread-Topic: [PATCH v8 5/6] pwm: add documentation for pwm push-pull mode
Thread-Index: AQHUo2hrpXORaGbfU06xWvz69aRPVA==
Date:   Thu, 3 Jan 2019 13:29:57 +0000
Message-ID: <1546522081-23659-6-git-send-email-claudiu.beznea@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0209.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::33) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1984;6:tflFfglim7X03m8+5nCzxDIp8WFnQwuAbPGJJ3DlphuXJX6z0Fg6T4uqAdJotGSTWql49ykhdmr7QPT9yd5QYzVDsHMyUUyjReTq792hD0fpOTf2u0IPVrU26AL88izuX/x06NNFi4x7vokkd4NsV8NrAwbnkdn+kEhrzPi9uL30HAzzXh8l/tLv3vRpFuefqgv9DTps8agil0wxMTxOond/SDBaGeP+BmdTeuA7Wzjvw7a7KmNM3p39ETk9jO2xFioukdmsxhQjQSe4Poj3CnnZcQXDW90DrYYM+sVL6CR+MN6757gW9/aaFbIIATZnCCcL23LTdG06rmK9aDuG53zt++i3NcV9EVVyLi47J8JrI+sZGcokxToAa+HUnlgfwsWoIhg0wTBWdlqzrnQeAzteDQRlKEN1dbtGJ1KMBasulXMlU0v4ftC1AA7UghiyzgJK2VLcfKpJbbkDREFPjw==;5:OxVYLVpDrgysI0hnhrWxYHnQoN8a+FqAMzRb2gxWqXKiVnC05gsKNV2XjUMTpZn+A2KWLjiEMdfNB7NbQ2HPlWCjQ9jDrx0POtM2Z3AIOOclfikBFLgMYgtmEIh1SxMX9adBGJWo0mbDQPnHHZHHQGLAcPL20jEb9TyeXouWeGZnd/yB+KyXrSLvRY6JzmGQmuK7qMyAmMDxqttWY9pG0g==;7:v+Y1/DPiEYvjRol+5eP+5ueNE6eKaqxkDPrTA8eZmlT1PyC3daxXbAsxKvCvw+tpmBvaxJykK9fjx6LTBH/0zyXe3FeCzl6LT9ykkVZobz7OovbxEs+uZcyFfvbiy2n03Mbyyl/FpnSI84hrZoRZ5A==
x-ms-office365-filtering-correlation-id: 5255ddc9-f2cd-4eb5-58ff-08d6717f8d7d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB198474BF7D7D7D1ACDADB519878D0@MWHPR11MB1984.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1984;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1984;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(11346002)(71190400001)(6486002)(2501003)(72206003)(14454004)(2616005)(476003)(97736004)(446003)(5660300001)(478600001)(316002)(6636002)(86362001)(99286004)(54906003)(52116002)(110136005)(71200400001)(6436002)(6512007)(186003)(53936002)(305945005)(7736002)(3846002)(39060400002)(6506007)(386003)(6116002)(105586002)(106356001)(107886003)(68736007)(76176011)(36756003)(4326008)(26005)(81156014)(81166006)(102836004)(8936002)(66066001)(2906002)(486006)(8676002)(256004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gms4XmnVFhH4KgLZZKtvJvT/CWGMgDQcGhu+iFz1sBUimJYDTMe+qz/g+2vfzwtBtKSiegVynLqBABm6xVE35CoubxeZTPrlHJqLpsc8MjSWFrdMIhcbNyLXh9Rq7piH5AJs+/KmAFBQZpMksI0zgj9PQftSKQaqSIRyoXtECCzU7M+JpaO3oebAReKxpOWF8/LA/CcA3sC4sFuiesMSkVyozoV0YUSCJmeneb0XtrYeLTBGclK9TZPJ4ETuM91sigDrmVIhsIWUiGXxLhabrBEsXB7DRdS2FzPXh2CnCOmx4Abv799/BKyiJIKtbqdH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5255ddc9-f2cd-4eb5-58ff-08d6717f8d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:29:57.1824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for PWM push-pull mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/pwm.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 669fd4c9cc8e..80552627627d 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -130,6 +130,22 @@ channel that was exported. The following properties wi=
ll then be available:
     PWMx_1   |__|    |__|    |__|    |__|
              ^       ^       ^       ^
=20
+    Push-pull mode - for PWM channels with two outputs; output waveforms
+        for a PWM channel in push-pull mode, with normal polarity looks li=
ke
+        this:
+              __              __
+    PWMx_0 __|  |____________|  |__________
+                      __              __
+    PWMx_1 __________|  |____________|  |__
+             ^       ^       ^       ^
+
+    If polarity is inversed:
+           __    ____________    __________
+    PWMx_0   |__|            |__|
+           __________    ____________    __
+    PWMx_1           |__|            |__|
+             ^       ^       ^       ^
+
     Where '^' specifies the beginning of a period.
=20
 Implementing a PWM driver
--=20
2.7.4


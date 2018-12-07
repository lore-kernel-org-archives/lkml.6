Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B432AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C3220892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UR7dGkIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C3220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeLGLdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:33:16 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:41219 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLGLdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:33:16 -0500
X-IronPort-AV: E=Sophos;i="5.56,326,1539673200"; 
   d="scan'208";a="24974523"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 07 Dec 2018 04:33:06 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 7 Dec 2018 04:33:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIlLhVv6TK/hfk0z3NXM4T/pBFPOXGFHqCaex+rVz2Q=;
 b=UR7dGkIO4Jzx3+XdNECoJ3Fehw6Sn2E9Tmtxnt6fEn8so3A7LX3egoHzOjiDx3ws6YPepdnXb0zeZZOwYIX2Cm+5vzW9x0b/wZGOqWaioxtpULLDhWBY1+3+XcMV/z6hW+GPoeZ6++0mFt4OWNrSNeBhNYm4F+eEw9Lq9CxYdfI=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2307.namprd11.prod.outlook.com (10.174.113.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Fri, 7 Dec 2018 11:33:04 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 11:33:04 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <wsa@the-dreams.de>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Cristian.Birsan@microchip.com>
CC:     <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [RESEND PATCH] i2c: at91: switched to resume/suspend callbacks.
Thread-Topic: [RESEND PATCH] i2c: at91: switched to resume/suspend callbacks.
Thread-Index: AQHUjiCdUvmDe/qGj02NgBYI/XQKAQ==
Date:   Fri, 7 Dec 2018 11:33:04 +0000
Message-ID: <1544182362-7001-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::26) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2307;6:K0tcQrzidYYuCVKUEc8ZvKUl62h3Id8rhwT4+gJL3KZzngMCOvQv4sHwAZjGIwCC+E6H1O9Z3HvbDtutIe5vv8tis1U+Jr3iTAJlf81EKNzVDRuRlPBgaN/Y8l9rceiQZk0BZhlVQiJT/fifov8PaMlT3hVkOOIXQZiobaHbNdBL7r2pxD9WaI6KfSGnCgh/mgHazyA4zMp4fXEJfPB0Z+7qAyqnZpxKcb892kG8tVGP1jz+tPfOMl7S4GKfkskFPc3EsWy/B21djfu7DtO4uQZh6s5UKMlFIr4PQQJrGM51cPr76htaPEWBftQvKSwxhwjRa2um892pfalj8N+y7wA8mQ77SDhotDix5mM1LaQITdrn2S4Wtn5M+kSZPaLjG/DLpw/4R/Q3GJOK3299BNv08/xa1EVu0vzoq5eywzgufUmFwB0wMFW87/MSnxeAafDsrmBUrYyZZvmvH5Hubw==;5:8VNUUbNMSZ9XEgCOUC/vR1uj+9c+f9AegYDbqPhu2Hl3DQ6KkTV+TaGh9qkk1KW4tQ7n8FGki8rM/2pS52e3+7gio+6cc9BqR1uHzaUbj3C9ROkMJLuWShufZlv+xMk5Gr+dAoY6h1LqCRESBiLwauryMXPvefosTY41HthHce8=;7:RjWq5RyZyQIQcXWLz+t3EdcaAyOozw8FcbPhmzOElYwWl5mzWjEFxOy0sAgKvqsntl3NAQzBvaD/CiC3uGgS3BUxNrs+nBMVV7N1XORvwhnt0tNPH1brAf7A1IfM3dqWvRCTjXuPgC7Q8TjTTp5SrQ==
x-ms-office365-filtering-correlation-id: a9e8c800-a6bc-43b9-73ac-08d65c37bff0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2307;
x-ms-traffictypediagnostic: BN6PR1101MB2307:
x-microsoft-antispam-prvs: <BN6PR1101MB23075AD970581C8A2B54D292EDAA0@BN6PR1101MB2307.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2307;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2307;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(53936002)(107886003)(106356001)(68736007)(72206003)(316002)(105586002)(386003)(15650500001)(6506007)(5660300001)(26005)(186003)(4326008)(86362001)(102836004)(99286004)(256004)(54906003)(14444005)(110136005)(478600001)(14454004)(52116002)(8936002)(6436002)(6512007)(7736002)(71190400001)(81156014)(71200400001)(8676002)(2906002)(25786009)(97736004)(6486002)(81166006)(2501003)(3846002)(6636002)(36756003)(305945005)(66066001)(2616005)(6116002)(476003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2307;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QHQOnebGa6QeeHf29hoL65nB3TzzxrsbWg0cpfvaUkHrUdFTm7C/tkveWp+NAGmjANaBZ57LZkYMUfLwrGo61jZkFIAxnCmVEQAJTXbnxjuUlauvE2mtFrH5Z4fBBGuVUGywa9Hs4WohPL0eCymvhateeYn+8ZsSneynsKjCpNr4yO1rvp+79w70w0neVdvp/lejdu9XNlbQvk0wnIPUijukdVV9G4oqUTK3LLGBjiW3tIFvkYYdzu7iShnC1FGwKUuIYLZGbfKlABag2spQ2ZivBz/SxlQkuekYDt93VWVpKLJQANCslwu9MK12cu5Fwn5GknZQgIS4FaQ+61D6lDnH8WZORUtwc/9vfCSfjZo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e8c800-a6bc-43b9-73ac-08d65c37bff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 11:33:04.1444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2307
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous version of the driver resume/suspend_noirq callbacks
were used. Because of this, when resuming from suspend-to-ram,
an I2C (belonging to a FLEXCOM) would resume before FLEXCOM.
The first read on the I2C bus would then result in a timeout.

This patch switches to resume/suspend callbacks which are=20
called after FLEXCOM resumes. FLEXCOM, SPI and USART drivers use
resume/suspend callbacks.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/i2c/busses/i2c-at91.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index bfd1fdf..81f7b94 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -1174,7 +1174,7 @@ static int at91_twi_runtime_resume(struct device *dev=
)
 	return clk_prepare_enable(twi_dev->clk);
 }
=20
-static int at91_twi_suspend_noirq(struct device *dev)
+static int at91_twi_suspend(struct device *dev)
 {
 	if (!pm_runtime_status_suspended(dev))
 		at91_twi_runtime_suspend(dev);
@@ -1182,7 +1182,7 @@ static int at91_twi_suspend_noirq(struct device *dev)
 	return 0;
 }
=20
-static int at91_twi_resume_noirq(struct device *dev)
+static int at91_twi_resume(struct device *dev)
 {
 	struct at91_twi_dev *twi_dev =3D dev_get_drvdata(dev);
 	int ret;
@@ -1202,8 +1202,8 @@ static int at91_twi_resume_noirq(struct device *dev)
 }
=20
 static const struct dev_pm_ops at91_twi_pm =3D {
-	.suspend_noirq	=3D at91_twi_suspend_noirq,
-	.resume_noirq	=3D at91_twi_resume_noirq,
+	.suspend	=3D at91_twi_suspend,
+	.resume		=3D at91_twi_resume,
 	.runtime_suspend	=3D at91_twi_runtime_suspend,
 	.runtime_resume		=3D at91_twi_runtime_resume,
 };
--=20
2.7.4


Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0092C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DA8207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Vs5YQ6Rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DA8207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeJWRnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:43:16 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:36906 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJWRnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:43:15 -0400
X-IronPort-AV: E=Sophos;i="5.54,415,1534834800"; 
   d="scan'208";a="22121364"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Oct 2018 02:20:42 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 23 Oct 2018 02:20:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcVmFypS/IM1YO4giYqYt+WG6T11QxF6t5LRH2vEWrg=;
 b=Vs5YQ6Rk3aECOmWuWjEKNyjCTZ5mAZnSTlNXs1FaYEzpTytI56lTFeeXaT/a1xQYeeoRpJUd27OxSUylp8Yp9IwsRCiE17xFCdBVLgn4Do8vBlGeoQtVRzs9/5QtZdxyOACQBqAtXisQXHC6j/rCg4eJ2M1NVNQ1ToIW2mdARYk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1524.namprd11.prod.outlook.com (10.172.22.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:20:40 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%4]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 09:20:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wsa@the-dreams.de>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH 2/2] i2c: at91: Save the bus clock frequency in adapter
Thread-Topic: [RESEND PATCH 2/2] i2c: at91: Save the bus clock frequency in
 adapter
Thread-Index: AQHUarGqVj1seYt2NUmS2+BhiG2LoQ==
Date:   Tue, 23 Oct 2018 09:20:40 +0000
Message-ID: <20181023092025.32463-3-tudor.ambarus@microchip.com>
References: <20181023092025.32463-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181023092025.32463-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::25) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.7.230.215]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1524;6:yRAZeVu0ScOnBWiX96jgAA75E7KhjOy9CUaHSpMTwihBVQTyOElWnq6620R7p8W0bIBLezNZRIsLQpMB1ZzBKBR5legEOaFjKJ4nP4J/Md1r6dz88mZ+HupEBS+bCVqsgLPD/1sVvTXxQ7T05JVivE6FywRyIkYwp5MBDqT4jXdcRiSn8M70nf2sDs3hiLkSnLAC/+JJ4ChlaOxxjZyFtWt2047/XPudydz6Ga4tBoyHFPzsejkLQViO14IztzdvhaJwdUyycXn1cUNe0LZkchc8A92c3mDj8ljDL85GP+hE+KNyC2YlX0aYuED48xAPBBGU4LPATWn4jIK81+5Q6csl1q/TZcjGwvbjORdKo69i/zEKBIWPGHL7GhoHOM89BWRUD3AlTAwLGAFTIqFCcokIt69AgpUbcjyOlUr1wBxOgyHo/RCc10J3m6cFc3n68VxMfyhUlQpUGPt/SYp92g==;5:qMufFiBv/E1EUvf+iWOl1Mgd96Ny+jkcAz/uQS17/ZfnULUGMjqpY9Xe/JxWtVWdDih9B1QQNz8MMjLVQ9cpfdtjfjaVMkhoDXT2szqlKUKsQkmMQohfHEIVwS2U8I8+u2xUGzg9sG347c7LiL73Yu4zrxtrD9855TxYI1EMg1w=;7:EQXHnwDGfx+jHiZqucKDeqWcpIbKgMDiWHpqml97PUDOAVS/BJ+JQBxikKJSD91w67eOUPa99OSeYnXxQVnW6INhC9r4fqcIkD/zQa0gpfrOK73VhfOoe2FhI4oUW9JCPsB7Tj+tIIXXP+7MjPv2mCQwZT1s+UlVj80NTT6lzEQs6PqE9JdaHpwmgWdpnM1vKukXBDGCL2gGNVLwjd2KncpV46BVg8GufWZ9nkaMAGXwa5nf2LCxTFc15jc+uCX0
x-ms-office365-filtering-correlation-id: fdfeb8bc-f91c-4a06-9bdc-08d638c8cd09
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1524;
x-ms-traffictypediagnostic: BN6PR11MB1524:
x-microsoft-antispam-prvs: <BN6PR11MB152433426ECAA1EA2291F8DDF0F50@BN6PR11MB1524.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1524;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1524;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(52116002)(478600001)(26005)(4326008)(316002)(14444005)(86362001)(305945005)(6486002)(6436002)(6512007)(256004)(110136005)(7736002)(72206003)(53936002)(14454004)(25786009)(107886003)(2501003)(97736004)(36756003)(105586002)(66066001)(486006)(106356001)(386003)(11346002)(2906002)(1076002)(476003)(6116002)(6506007)(76176011)(3846002)(5660300001)(446003)(2201001)(5250100002)(102836004)(2616005)(8676002)(99286004)(81166006)(2900100001)(71190400001)(71200400001)(8936002)(217873002)(81156014)(68736007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1524;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jpo/bUVDpgoFb0hohf8xEXxvJ9bPT+1HcooeE1ldgpfqwC6PkjbR7l4v8I90sjRdEPd6bUuHESBmCvVydKKBzxBgEKDQJ2eaoSCUKq5xzvKrGN6bPmdBwnVNjeemWISMOdxwfIvXUbbBY6OpoEofxJ19BafQqYNQ6B6gjgEEDzrhZfXN8wEIRdFDHdqEerki6hvd8OvlUx/r0zrWoy9Ced55IKRLzJPOnOlPfWWaVM4IBavds4oB1xlvtFpPV7MiYKpsJzU8YKh1tSlYkLxs/ZFLovnEMBxOOB0Obj010dbcWVxUJyPpRuu8GKgTw8cYnPZb7jLcSIugDpGHrccpsy/59UqkELNGo5x+eGekgLg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfeb8bc-f91c-4a06-9bdc-08d638c8cd09
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:20:40.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1524
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-frequency property is not mandatory for the i2c buses. If it's
not present in the device tree, the buses __usually__ assume it's 100kHZ
(see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
clock-frequency, so the default clock frequency varies from bus to bus.

There are i2c clients that need to know the bus clock frequency in order to
compute their wake token (see atecc508a i2c client).

The clock-frequency value has to be propagated to the i2c clients, otherwis=
e,
if they will not find the i2c bus clock frequency in the device tree, they
will have to make their own assumption of the clock frequency.

Spare the i2c clients of making wrong assumptions of the i2c bus clock
frequency and provide the bus clock frequency in adapter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/i2c/busses/i2c-at91.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 3f3e8b3bf5ff..9aa0937817ac 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -1124,6 +1124,7 @@ static int at91_twi_probe(struct platform_device *pde=
v)
 	dev->adapter.quirks =3D &at91_twi_quirks;
 	dev->adapter.dev.parent =3D dev->dev;
 	dev->adapter.nr =3D pdev->id;
+	dev->adapter.bus_freq_hz =3D bus_clk_rate;
 	dev->adapter.timeout =3D AT91_I2C_TIMEOUT;
 	dev->adapter.dev.of_node =3D pdev->dev.of_node;
=20
--=20
2.9.4


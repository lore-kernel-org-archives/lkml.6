Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B364C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F1B222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ifDZRPto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbfBMJBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:01:49 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62113 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfBMJBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:01:49 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="23778134"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 13 Feb 2019 01:59:47 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 01:59:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY3mtMmnD9cseNMymdV/VsZoqf3XBJ/9J7higqgrd7I=;
 b=ifDZRPto/btI/cv1RaHs5GbnteEH5fsHqHRRJ8zW73Ff4BXv8nFQg1M1lp6qP9k1VBhdQpWyojpppwflXJVptSJtNHmzJ8B29m1w/BbAgyXnwTJfKzt9WLBNHtxVUUS2w8ykrsUHStXSlEz03nwK9xZqYbvlAlTpK3BOCTMqnrA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:59:45 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:59:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 01/11] ARM: at91: add sam9x60 SFR definitions
Thread-Topic: [PATCH 01/11] ARM: at91: add sam9x60 SFR definitions
Thread-Index: AQHUw3p2o3oeiLqtBEORedY4SOk1lg==
Date:   Wed, 13 Feb 2019 08:59:44 +0000
Message-ID: <20190213085930.31578-2-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c45e8f4-873d-4782-4292-08d691919920
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN6PR11MB0019;23:bsnb4tT4Z52Nz5HCeef55QLWwYqM6axbicSNtDx?=
 =?iso-8859-1?Q?BFCaq3ZngDdzhewFJbt9vgihiyVCYh+eTWjwwrLCc3byTzs11kWjEMfe4y?=
 =?iso-8859-1?Q?9j80qFjKuxN3B6/A44ecC1zBJZXz+JR2NqlvM00i1P03xtDRCEaY5pQR0P?=
 =?iso-8859-1?Q?Vuz2Z5ncVubobyI34F1KKBb3Ibk96WVBHrAyMYZKyjIiWyDiiGJQH/mwHm?=
 =?iso-8859-1?Q?6ondfgeFTj5Pxq6lckVCD/NRcYaI7oBt3MfIEcNMII9a6M7Acw6F0lcDxn?=
 =?iso-8859-1?Q?txHRl4fdByVJf+0TSJR2lTeFYUuLcn8BFukNE4/PPMJDTgUdpSj6M60gMu?=
 =?iso-8859-1?Q?D70l1UF7Jt+uxMdMgzhOg8q3FZ9IRweTHQZbXNFFlb8XR3UyX0GB3uz3o9?=
 =?iso-8859-1?Q?VZp7/Iw1fI5xSC3rfqGlKSS6S4JQQDvpe+SS4+bvE7ZlsJAn8YeW3w0bcn?=
 =?iso-8859-1?Q?VPvlP4ChX3RN5GzulIELF0TdKXQavx/LYAsgUA8Z2CxMpEQVfkiu6TIxOG?=
 =?iso-8859-1?Q?GF334l9YZMrdqI7j4T/vPU/EDFojK600IyFR+AzdIP05LAQ4ragErvtsvb?=
 =?iso-8859-1?Q?ODX29h47tT6roV3B2oIFdMefirhKOLgXhvyamWRPWNHfrolm0V4Rwr3V2J?=
 =?iso-8859-1?Q?qRgD1HNIMpm4xNmq+7yI7sbZKQqLcSsaothGuvzWAuzeuuHFJuRmTPVoQN?=
 =?iso-8859-1?Q?s+FizUv9eUkRXP1N2V3dYsPwyhWVkSnpAIy+KNv2tsx7RkPCPE8tIT56Md?=
 =?iso-8859-1?Q?M/GJ97xQcnWjbVYu36goa2tm/kKrYo37O/YL8rdBDWNiFr8v2RWwSLwYdj?=
 =?iso-8859-1?Q?f5oByt51SaRXA7tEePkdgcNfAug8vtvkLdV3BXzSVyU0+Kssv70xW+J/jP?=
 =?iso-8859-1?Q?0dyLUITxassx3vqTmo3pDm+nnTw63sJ24zAz76octRQKEM4rn6jWlKSQog?=
 =?iso-8859-1?Q?cfrbc3vpf45+sSd9l+6PyNOHt33bJ0colzPCpGCOXdrWd1ZLPkQhyvnq8d?=
 =?iso-8859-1?Q?9zx7YNhm1CHMaUHGnlGg7RNzkVStjBYUhyYl8N8bTo71SHwZFNAvTa2P/j?=
 =?iso-8859-1?Q?kM546+t803mCigOFWhicIDe/VE6rhKOReNox9wVxYfMv5jF3VZV+3+no+O?=
 =?iso-8859-1?Q?ALoOrmZ/lwuOdMaAJ3TodVJTHYO5LJPOMcbdiGnkGbnRQpW7hv0nwVWZit?=
 =?iso-8859-1?Q?hbF0A8opZrdpq71El8dXtT0SA2HmVwOjcv3Az+6yFhDBbKRwP8Ff+5G6Um?=
 =?iso-8859-1?Q?rj+aRyT/usTr9YUtLo5MC5Hain8aAQGKhAN3hfRog6Xmls8UbnfuCbIOWZ?=
 =?iso-8859-1?Q?7c3YWOFfa4fY89cP3vwNA+A7K6P9WZTDJley6z7cH9n9dLkI7AWHbs+alt?=
 =?iso-8859-1?Q?BZqKXACeqrXVvMNdH/VZrmwEO6oAc?=
x-microsoft-antispam-prvs: <BN6PR11MB00193E96369D292E0882C537F0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(446003)(2616005)(316002)(8676002)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(11346002)(86362001)(2906002)(72206003)(71190400001)(14454004)(76176011)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(14444005)(7736002)(305945005)(256004)(25786009)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1tJHhf5WCnkFrdvsOF3MrqwM5CoO8oP4vA8eSmYucAosizNOd/d0Zucgc28Mnnl2OCmaBldGHWVOnV0I5lQbeS0Cc31w49JYAKGY8X6lGRzWwMB6DIdVtKmQ1SkpEh8XjeAMykqcA0cw3N1tmpwWNbPC1hAvuv4tvOxDUNRF5n/vkkLLT3TluQtqPeUrbZYcrS7OZWeO3682XigilIUfjuTCEOtL/ONx8Zn8osyCYwDUxMz00gPBhmka9tIza/A89Ms57Vq3WaGGalu6Kzbyq2tv4fRp0k60hGmLSL1xWVFZwLu2qHucs7zrFbYVeK1WK6On3ID0zU4FvUWsD+q7/aTcaSNw+UcBLv7HiRRqUxOR+FQb17eQjRN84z/BBAD1xe3lk+X08yR/sYNcr93TmnskQLvfcRtm2yap8ans5jA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c45e8f4-873d-4782-4292-08d691919920
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:59:41.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Keep generic names, as there are no conflicts with previous
SFR definitions.

While touching bits, update AT91_OHCIICR_USB_SUSPEND to use
GENMASK, replace unused AT91_OHCIICR_SUSPEND_A/B/C with a more
generic macro, align values on tab-width.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 include/soc/at91/atmel-sfr.h | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/soc/at91/atmel-sfr.h b/include/soc/at91/atmel-sfr.h
index 482337af06b8..532fd784e86c 100644
--- a/include/soc/at91/atmel-sfr.h
+++ b/include/soc/at91/atmel-sfr.h
@@ -14,21 +14,41 @@
 #define _LINUX_MFD_SYSCON_ATMEL_SFR_H
=20
 #define AT91_SFR_DDRCFG		0x04	/* DDR Configuration Register */
+#define AT91_SFR_CCFG_EBICSA	0x04	/* EBI Chip Select Register */
 /* 0x08 ~ 0x0c: Reserved */
 #define AT91_SFR_OHCIICR	0x10	/* OHCI INT Configuration Register */
 #define AT91_SFR_OHCIISR	0x14	/* OHCI INT Status Register */
 #define AT91_SFR_UTMICKTRIM	0x30	/* UTMI Clock Trimming Register */
+#define AT91_SFR_UTMISWAP	0x3c	/* UTMI DP/DM Pin Swapping Register */
+#define AT91_SFR_LS		0x7c	/* Light Sleep Register */
 #define AT91_SFR_I2SCLKSEL	0x90	/* I2SC Register */
+#define AT91_SFR_WPMR		0xe4	/* Write Protection Mode Register */
=20
 /* Field definitions */
-#define AT91_OHCIICR_SUSPEND_A	BIT(8)
-#define AT91_OHCIICR_SUSPEND_B	BIT(9)
-#define AT91_OHCIICR_SUSPEND_C	BIT(10)
+#define AT91_SFR_CCFG_EBI_CSA(cs, val)		((val) << (cs))
+#define AT91_SFR_CCFG_EBI_DBPUC			BIT(8)
+#define AT91_SFR_CCFG_EBI_DBPDC			BIT(9)
+#define AT91_SFR_CCFG_EBI_DRIVE			BIT(17)
+#define AT91_SFR_CCFG_NFD0_ON_D16		BIT(24)
+#define AT91_SFR_CCFG_DDR_MP_EN			BIT(25)
=20
-#define AT91_OHCIICR_USB_SUSPEND	(AT91_OHCIICR_SUSPEND_A | \
-					 AT91_OHCIICR_SUSPEND_B | \
-					 AT91_OHCIICR_SUSPEND_C)
+#define AT91_SFR_OHCIICR_RES(x)			BIT(x)
+#define AT91_SFR_OHCIICR_ARIE			BIT(4)
+#define AT91_SFR_OHCIICR_APPSTART		BIT(5)
+#define AT91_SFR_OHCIICR_USB_SUSP(x)		BIT(8 + (x))
+#define AT91_SFR_OHCIICR_UDPPUDIS		BIT(23)
+#define AT91_OHCIICR_USB_SUSPEND		GENMASK(10, 8)
=20
-#define AT91_UTMICKTRIM_FREQ	GENMASK(1, 0)
+#define AT91_SFR_OHCIISR_RIS(x)			BIT(x)
+
+#define AT91_UTMICKTRIM_FREQ			GENMASK(1, 0)
+
+#define AT91_SFR_UTMISWAP_PORT(x)		BIT(x)
+
+#define AT91_SFR_LS_VALUE(x)			BIT(x)
+#define AT91_SFR_LS_MEM_POWER_GATING_ULP1_EN	BIT(16)
+
+#define AT91_SFR_WPMR_WPEN			BIT(0)
+#define AT91_SFR_WPMR_WPKEY_MASK		GENMASK(31, 8)
=20
 #endif /* _LINUX_MFD_SYSCON_ATMEL_SFR_H */
--=20
2.9.5


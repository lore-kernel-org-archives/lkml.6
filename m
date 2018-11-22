Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84137C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB1F206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ictfBvwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB1F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395114AbeKVXQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:16:15 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:46442 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbeKVXQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:16:14 -0500
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="20688181"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 05:37:03 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 22 Nov 2018 05:37:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykDnPhJhzRxCCsCFFY6MHzKyQp34bjZASLkoolp2iuI=;
 b=ictfBvwmJagqLA3R9K62LPF6d6GyKTINQcs1lv1zXAwJPBVlu4f03wxhhE+6uvMuN/uFZkBvgfcJ1gV1BRLCur77vcf2EF2bq9OX3o9xbu1oCnkt6tJOJbMi3EjdT/3OxV8KFAGS/IbBTyN2n7cp+ohrUaPO8qUDrF6Y27qRPxA=
Received: from DM5PR11MB1850.namprd11.prod.outlook.com (10.175.92.17) by
 DM5PR11MB1561.namprd11.prod.outlook.com (10.172.37.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Thu, 22 Nov 2018 12:36:59 +0000
Received: from DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::9198:565d:bbda:6801]) by DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::9198:565d:bbda:6801%8]) with mapi id 15.20.1339.027; Thu, 22 Nov 2018
 12:36:59 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <alexander.sverdlin@nokia.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH] mtd: spi-nor: fix erase_type array to indicate current map
 conf
Thread-Topic: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Index: AQHUgmAPRuGauPbUmUaN5hsWx0CViA==
Date:   Thu, 22 Nov 2018 12:36:59 +0000
Message-ID: <20181122123552.15756-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0601CA0002.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::12) To DM5PR11MB1850.namprd11.prod.outlook.com
 (2603:10b6:3:114::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1561;6:9U1Z0Nf93QUtgmLO+/a7/4oD8dcPd2AB8QbS3tZ+yFlFvsOh3MTMr4sRTBlwnVrmEYNsfc76E8rtPowOotNlqsrvUIvWXl5Gm4Uobuy2OQeZAJz2uC+tm0hOySmqtbtl/WA5cYs/E3eg/oJpieZpKFxBE8FqfGm4luqTKK1gSEVYT4d4C8aCLh732CGtYyhzHsn4BAPRQqjLh5hZVCj95lzmNRgPXmteXr9RLLMW0KDxdLbpvRar2Bs566ezalZt5QLE6SOSTs3tGWcnlWw1e/jR1LiqDYFXTUSvHg88V6WX+ffIUKRNz6ecpQ3lzuS5Yz+QcrFjjYnOD5oZH/b8MFQ4+fZQJwXNIC0rBjjQ9XSuoDfGWHicYFehP5EttukIADYjbzPRAojlHeadlPSPgDlpgWt4MFG/r7UrROF+eI8FBkDaT8OUOtzQFj/I48xAH3mh1fVd+t7Ujg0JKYWikw==;5:vqls2Z+4CHS9TYAlh+HRY/Dq9ffNQqJw/qyWfHx3A6abkrkQoVv5WdfSyGTw9nxkqhhdPJFe/acjkbh1Kz3yO3AUNGNv/k+I7IGBhSsHUQWOG+RRc2Ik8hS0VlhX01nddX0THtpb7aQlUw/Z3qBGCbjxZQznhEg+PzJVDquiZZQ=;7:3mPriq14tNN85yoNf27+mHmx8kdQSYC0dhdVamGphBkX4bi6aiprQiddLWj1qwfZw0RN7WHj1bnZFPUzM8tPiCUr731S7fRGr6ay/06BmN3LmlN7x802TMk3afFwPKTsT08SFzyXxeC32KnDoGWURw==
x-ms-office365-filtering-correlation-id: 2f74158c-401d-40b6-c0ec-08d650773246
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1561;
x-ms-traffictypediagnostic: DM5PR11MB1561:
x-microsoft-antispam-prvs: <DM5PR11MB156191F72609EA29D8BCD25BF0DB0@DM5PR11MB1561.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR11MB1561;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1561;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(81156014)(81166006)(305945005)(6512007)(7736002)(8676002)(66066001)(478600001)(486006)(25786009)(54906003)(110136005)(105586002)(106356001)(2501003)(8936002)(72206003)(5660300001)(6436002)(6486002)(68736007)(14444005)(1857600001)(86362001)(2201001)(14454004)(476003)(1076002)(39060400002)(26005)(4326008)(2906002)(3846002)(6116002)(2616005)(256004)(97736004)(2900100001)(316002)(186003)(71190400001)(71200400001)(102836004)(6506007)(99286004)(386003)(53936002)(52116002)(107886003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1561;H:DM5PR11MB1850.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DuqCNcM71UxUTGtYzY7cKttZcCszq2uZn+1te/my9nil64DLn+p2I+ASrqRfY67iAWcz2C5LF25M1e5Qr6Nux04m4dWj/VUdp4y6iR39AcZI4mj227AG8MsHQAvxjdpTtm/Krt7yjOm84hgNwj8NHlA80wG8TCdBdlLyViF4dEFpCR8nM3kiXLwEMDcqtJjU4zQ5EjPIY0asOAotkMXzeC2iq4gE2JOr7G881D8Ed6KdbiizjHiXGSKXphDsE+vCNSj6mRFVO1isyTGohmkmP+67vCgu3coOZlitrdLVbvLTCpZzsH0H2sVTnDZzg80A7+u5kNxlssq+gFrZphpL0l3ZspZryAVqewFMDcJzzWw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f74158c-401d-40b6-c0ec-08d650773246
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 12:36:59.6233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1561
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Bug reported for the out-of-tree S25FS128S flash memory.

BFPT table advertises all the erase types supported by all the
possible map configurations. Update the erase_type array to indicate
which erase types are applicable to the current map configuration.

Backward compatibility test done on sst26vf064b.

Fixes: b038e8e3be72 ("mtd: spi-nor: parse SFDP Sector Map Parameter Table")
Reported-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 93c9bc8931fc..a71adcd6ddfa 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -3000,7 +3000,8 @@ static int spi_nor_init_non_uniform_erase_map(struct =
spi_nor *nor,
 	u64 offset;
 	u32 region_count;
 	int i, j;
-	u8 erase_type, uniform_erase_type;
+	u8 uniform_erase_type, save_uniform_erase_type;
+	u8 erase_type, regions_erase_type;
=20
 	region_count =3D SMPT_MAP_REGION_COUNT(*smpt);
 	/*
@@ -3014,6 +3015,7 @@ static int spi_nor_init_non_uniform_erase_map(struct =
spi_nor *nor,
 	map->regions =3D region;
=20
 	uniform_erase_type =3D 0xff;
+	regions_erase_type =3D 0;
 	offset =3D 0;
 	/* Populate regions. */
 	for (i =3D 0; i < region_count; i++) {
@@ -3030,13 +3032,38 @@ static int spi_nor_init_non_uniform_erase_map(struc=
t spi_nor *nor,
 		 */
 		uniform_erase_type &=3D erase_type;
=20
+		/*
+		 * regions_erase_type mask will indicate all the erase types
+		 * supported in this configuration map.
+		 */
+		regions_erase_type |=3D erase_type;
+
 		offset =3D (region[i].offset & ~SNOR_ERASE_FLAGS_MASK) +
 			 region[i].size;
 	}
=20
+	save_uniform_erase_type =3D map->uniform_erase_type;
 	map->uniform_erase_type =3D spi_nor_sort_erase_mask(map,
 							  uniform_erase_type);
=20
+	if (!regions_erase_type) {
+		/*
+		 * Roll back to the previous uniform_erase_type mask, SMPT is
+		 * broken.
+		 */
+		map->uniform_erase_type =3D save_uniform_erase_type;
+		return -EINVAL;
+	}
+
+	/*
+	 * BFPT table advertises all the erase types supported by all the
+	 * possible map configurations. Update the erase_type array to indicate
+	 * which erase types are applicable to the current map configuration.
+	 */
+	for (i =3D 0; i < SNOR_ERASE_TYPE_MAX; i++)
+		if (!(regions_erase_type & BIT(erase[i].idx)))
+			spi_nor_set_erase_type(&erase[i], 0, 0xFF);
+
 	spi_nor_region_mark_end(&region[i - 1]);
=20
 	return 0;
--=20
2.9.4


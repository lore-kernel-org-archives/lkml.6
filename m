Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BDDC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F782086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="1ZDAQfUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F782086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeKHUmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:42:23 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:48191 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeKHUmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:42:22 -0500
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="23002237"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 04:07:25 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 8 Nov 2018 04:07:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYBPaGm1zSjR5qcoeyK0JE1G9HlWd7fsaoE6QhLLHUw=;
 b=1ZDAQfUuMJfK0dil1rBrbMJC5lf2n1VXjOxCD2fvOcRYudhheHnQQ9aG8+zLQJkN4aJClr6d7oAjE2Pq38gzNRL2fRTxPyOB3TCfwAZePkUQNUdSgqtE8nRsQ8x5RaczVrREExnXOIAYEbRKRTduG7eOQo+fa7GTLZGmJ+lkil8=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1396.namprd11.prod.outlook.com (10.173.33.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Thu, 8 Nov 2018 11:07:21 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:07:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 7/7] mtd: spi-nor: remove unneeded smpt zeroization
Thread-Topic: [PATCH 7/7] mtd: spi-nor: remove unneeded smpt zeroization
Thread-Index: AQHUd1M4HxVLczuL70mwaCh/G/cBzQ==
Date:   Thu, 8 Nov 2018 11:07:21 +0000
Message-ID: <20181108110653.21063-8-tudor.ambarus@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181108110653.21063-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0401CA0009.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1396;6:D70pk1ua/gPxWkpVjoFf6BfzTEZEJBjp+ybHAGu0C8TiFlE/kUrUjxx1sautXFM5y80+oA4Aqq0OJYd5Vkw7xDrTiHQQgsof9URnzRtJBLy/w2yZTQp3tJiAH0n2WWE76lvVz2Vcuf7RVMKYMUb7ess83d7iq+quuyQqhiuX1nhVxMUKhub2YxKFhn6zR5onVhRmSGwKd3fD1Qhj7M7gQN0Zh47nrVAvOdxXl4Yhn6HzoF8QJc5xQZWL7yG9ECz6B35uRc5PbJKYtuneljdVePFzPs0RrHrXrMiKr3HnltBKcjpxf1KIoxmuxTTP4vI9S7rSwuxMFPiF7M59MVFPCPB9uDyt7mG0Ndz6jyLwR5CnSScnEdjNaSDOg6xSIDkvz85JOSO0DM74avxcbNJuLR279q8Ul7yKhxKsmskBnvI+wgJcYZHx1H622Ct2a6b9DPAKw7WMmSP4zCkoIZxZpw==;5:6koubjgHuCN7A45EAFO5LhKjpTSSjqhnl8RM2CJ7vr8iMDXcQa3EB6+WwBG8VQAoJlb7S+mM+fHLBurlAcB/sTrKIZ5tAB2LULiBFSyyRuxhhr61XIQhLwO7yRfb4MbJGjdRVOY0w8D0vVhEZWFlwP44O9PviT/ASmzVuB6OH8E=;7:0oQFC59UGmP9vop78VdscVVWCacCQM3N3yk0Lz9I/2xIXGxlGzfgjkcn/ymttok4v8HL36+EXDkEoYsbMEIKd/1RBYs5GdD3V+cnLhZBnQr73mdWIwclB29S48O7ILvxUmIIgEPMaWErkRteQ1+Mhw==
x-ms-office365-filtering-correlation-id: 6a4721e7-7a37-43d1-352a-08d6456a5abb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1396;
x-ms-traffictypediagnostic: BN6PR11MB1396:
x-microsoft-antispam-prvs: <BN6PR11MB1396AB307C9F8B506924D610F0C50@BN6PR11MB1396.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1396;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1396;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(25786009)(99286004)(2900100001)(6436002)(4326008)(2501003)(76176011)(5660300001)(8936002)(1076002)(6116002)(3846002)(478600001)(81156014)(8676002)(81166006)(97736004)(2201001)(52116002)(86362001)(39060400002)(66066001)(53936002)(71190400001)(72206003)(71200400001)(107886003)(6486002)(305945005)(14454004)(7736002)(6506007)(186003)(256004)(476003)(14444005)(386003)(102836004)(105586002)(106356001)(26005)(486006)(110136005)(6512007)(68736007)(54906003)(2906002)(2616005)(316002)(36756003)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1396;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XLSn7ZWSe4ZNkR5P0Xg8K4vX3cegWgQr3nvd+BFSblpcNRpVh4odT9ZJcmuisG0O5K3paHZNmHgrkMl6BxRfW6rqeSZeW0XIucUcfhjQmUDAHvf4N70F1yeUFBhfxPLvtP+ziZmpjmOeQ7KZYPSVryAPStBtfNJMhkiSWGRFAxuEcMebFZGvo66q4h9dAk787tme/HNXaarj4KbkBXAyQ8b3+F6mqx0v9lh88b1E7m6MIL6OO9LutmdpX2D90pM+COYWqG4v2XxizCqsPYaZJ+BEsUijx+5WjRMSpEv+7Gf+HlTFn3zKvdj7lO9fox7u0Ex3SQM7+d+y8h2CxDEw/RszEOY6HtknItizEXDcA1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4721e7-7a37-43d1-352a-08d6456a5abb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:07:21.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1396
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entire smpt array is initialized with data read from sfdp,
there is no need to init it with zeroes before.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index a13fc82bade5..c71e1da1f562 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -3053,7 +3053,7 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
=20
 	/* Read the Sector Map Parameter Table. */
 	len =3D smpt_header->length * sizeof(*smpt);
-	smpt =3D kzalloc(len, GFP_KERNEL | GFP_DMA);
+	smpt =3D kmalloc(len, GFP_KERNEL | GFP_DMA);
 	if (!smpt)
 		return -ENOMEM;
=20
--=20
2.9.4


Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A73C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8D820818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2OfgM9Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8D820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeKJCi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:38:28 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:22948 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbeKJCiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:38:25 -0500
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; 
   d="scan'208";a="20177811"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Nov 2018 09:57:00 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 9 Nov 2018 09:57:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWoIzdf/V0PCx7GmXHQNqZHzIeZ24+ifLTuyiRgkZ1E=;
 b=2OfgM9Mx0IpdUbanqYgWfZL3vN3h9eckyMSmFfUGOyNZq6gafKqrsk3JUpJqdITSQlVTZmgSL7mfa6YXQizdLNuqmStwJL2329o7GOhMVOyhK+KUXrecdDyfTdaZyvyqTzjiRf+ASv3rRn+KGwncUyojbt7X+C7DG7BWtHyHbek=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1251.namprd11.prod.outlook.com (10.173.32.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 16:56:56 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 16:56:56 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 5/5] mtd: spi-nor: remove unneeded smpt zeroization
Thread-Topic: [PATCH v2 5/5] mtd: spi-nor: remove unneeded smpt zeroization
Thread-Index: AQHUeE05/IawJabFxUqWI1XY3JgXlg==
Date:   Fri, 9 Nov 2018 16:56:56 +0000
Message-ID: <20181109165644.30534-6-tudor.ambarus@microchip.com>
References: <20181109165644.30534-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181109165644.30534-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0231.eurprd07.prod.outlook.com
 (2603:10a6:802:58::34) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1251;6:BruUd5OG57tRe/u8saIhfgDnD4dbG4V5jbq3DopU7uiqNUN3+n4h6mzGh+RF9RBiaBGfEVBC3rqU6X1GVtjXc4ml11fsw91ocWyFGBLJ7xQcmS/au/BoinH/DEV3YkdPGisiov3kDvXpfkbC+qRnGVvxCUZdZU7fIf1CEnbljMOomg0/13hkQOHuVs4GW23y0LlFuRCJI9/qeh9s3aJtWFklbqXJsuSQ00IZO5pF53mMAZAz4NNRXOZFjcyDzUmStkcOsPd0vVgWQ06dBE3QSTbxkkGHO/A/seyuD30+qbmSR116/tDi/uFauH61KQoKmAz+kMmU7cG45A2Q/i6De26gykS/zY41JbzI2I3LRTGJxu7+HC5JFMmVuW+CJ80qXD4f+EP4w+SmHeL+UEZBuhSpNxpwzCruMK5VaubW4capAHhxZ5cRn47D1nsin5OLYjYP+GuKwFH+Bi86qXeMbw==;5:0DA/hRp/Lp64MlLUt6VqpKgSN9nre8fK+rWeIXmyY4nJxVdglGgn2o5jzHFlW+Qcu8d14Ic/Vej5kxlMWIRBuwjv3wUQz4fDdlJ4i3Y4LyqnEOKWNCtUgrSmeHB9qSN8fJahaJWV1BVXMfUHj276FhecDuy5FDwr5go1E2tThcs=;7:50w72s2Ak3Zv2bDIgt362ljCMLlMHsq28qwUWB5bKiPCkSZld64a/jFZfj/N+1mAJ9FPK1cPisUEr1+JuQLuZe+MPuJLl4rDyn90Ev+PZuOA2LdjTPEypYYiyUxiwkNacBLh+VSWt+8ayzb3ZfLosw==
x-ms-office365-filtering-correlation-id: dab54c45-66f1-43dc-8de0-08d646645b60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1251;
x-ms-traffictypediagnostic: BN6PR11MB1251:
x-microsoft-antispam-prvs: <BN6PR11MB125188B5971D1B37ABB0A3C3F0C60@BN6PR11MB1251.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1251;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1251;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(2906002)(14454004)(2616005)(106356001)(6512007)(105586002)(6436002)(72206003)(476003)(3846002)(68736007)(36756003)(6116002)(446003)(110136005)(486006)(1076002)(2900100001)(2201001)(11346002)(6486002)(86362001)(54906003)(316002)(2501003)(102836004)(39060400002)(97736004)(386003)(4326008)(186003)(76176011)(52116002)(66066001)(99286004)(6506007)(107886003)(305945005)(81156014)(53936002)(25786009)(26005)(81166006)(8936002)(8676002)(7736002)(256004)(14444005)(71190400001)(5660300001)(478600001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1251;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2H67/utkln6/f+J/c6ucyeuL0hEAgeub1+8TiOgpWuGsEPSjvXc2CcDesPzSJXCkoNXWtiOxTqRWdZxx0pqNvAD3vzEU3WmJgHlLbDB4sWsrojDm1KyFZ3Ic1KBPLuBZisj5Gx2+M108LRJ/IskohVAz9IL8lxwEDrRC49HpQ+hm5luizIiuLaePUKBFJHGNnlcOSzgzhO/4eOlosFakq9d9PRhK9jeDDUhI2Lw+s3wciX0zwN4uIqiOxYZXV+gJ6oD8vE59aurXEvF3THChWn2p7sduijRPKU+336z2NNZ72BshCD5Oqh95QXz+Y5WfvPkUFkxLylcPac0DEGDRyBi5vjFVBK6ilIekUIuLYys=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dab54c45-66f1-43dc-8de0-08d646645b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 16:56:56.6859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1251
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
index 458ca8321999..f9c657867e5a 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -3044,7 +3044,7 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
=20
 	/* Read the Sector Map Parameter Table. */
 	len =3D smpt_header->length * sizeof(*smpt);
-	smpt =3D kzalloc(len, GFP_KERNEL);
+	smpt =3D kmalloc(len, GFP_KERNEL);
 	if (!smpt)
 		return -ENOMEM;
=20
--=20
2.9.4


Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0953FC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1872086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="I25sV/Mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1872086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeKHUmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:42:05 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50301 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeKHUmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:42:05 -0500
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="22845566"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 04:07:07 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 8 Nov 2018 04:07:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNwAwHLy63D1zp/k7k9/1MnxCeh7NQVBNnnvMaJKXFE=;
 b=I25sV/MmBObhTpLM4pP3HgSZ0mOZdvIxj09x7dmp3J3kypkIE5EtFu3e8uPwn8HOB50htkq3aLJA6HA9ciqjR2EBJ22ywECplmf8dw/lqJc7Y28S0v45T5QxHmI6kA3Xpeq/vRfVlF1LB/b2Ck3ffyqwKhMV4gmOhNLAEL/QHmI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1987.namprd11.prod.outlook.com (10.173.32.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Thu, 8 Nov 2018 11:07:05 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:07:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 0/7] mtd: spi-nor: fixes found when debugging smpt
Thread-Topic: [PATCH 0/7] mtd: spi-nor: fixes found when debugging smpt
Thread-Index: AQHUd1MusgRIXwFIpEeHiJ5bB2lg8Q==
Date:   Thu, 8 Nov 2018 11:07:05 +0000
Message-ID: <20181108110653.21063-1-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1987;6:snGu11w0a2hboy0L5Rh2ClrE6sZXi8c8uoszndrD0+jBSqnK/cfmJJPPXjGwG9dppuj3IihiR8fvxxllq8swWwRTHQMmHuzSFh2Fw1WCdgL0sCptSVDRqs4Dy1n+/Z2M4XPRIQv2r26Zn7Mo1pbC842VrWhgniJSkomsjD49pynJaibmmXnIwvthstLMtWTSynMEMMbrhZCBnfsXMGP9xWfbTWT2zANkvxzqZs0JJly1rP8YBpGWcFtq6jweO9GUA0DPYd6ZGy1Fxu1AuzDI3NWKtv7PTARzbvZzb+6pQgTKVg5WTBSt73NeVlBtUakpmcUpj5sgcDqPd8j32REKeQnZPOxJhBNYwdDQKkTmATBeTwBMrqfvCyMKUkG0rEcNb1dt28Xcyj0GED0t7wsW1SEX7NpCR4+u9tEfDNHVnQJSP/hW88yCdTNgveeusoLTqYOgYCNCHvq7fKmd9Y/MfQ==;5:OP4JzaUa41W7DC5a1WbX6b1S+gKNHP1ViTnGqnydCXGoRdmypHtv/uLK9M4GIyzdhB2lBPETlq0HM3GP1uP3Em8O25xNwj5w1aqZddTx0QSye1d4N60dg8ZTcQnRDAOdxcPzcNRFBJervu4Q0igmGp68Ch56hPEoYxACKNzyVKY=;7:BnrYlvPYS6v3dzVBdup3stURBuxUoKESv3zBWT5x5CYdLZnGN+mXIq3XiaY/EkQJQDJG4Asok0J/FEaXZxq/OZU/BJmYVDvooexZHHo7aQvUbiU6Mp3K05zjxFbMypjqWzcWd5M9iJO+jxF9eeK2iQ==
x-ms-office365-filtering-correlation-id: 05959812-413a-4bb5-1ad7-08d6456a50e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1987;
x-ms-traffictypediagnostic: BN6PR11MB1987:
x-microsoft-antispam-prvs: <BN6PR11MB1987DED984C7C44135E96E8EF0C50@BN6PR11MB1987.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1987;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1987;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(72206003)(8676002)(81166006)(5660300001)(81156014)(102836004)(14454004)(68736007)(305945005)(26005)(86362001)(1076002)(2201001)(39060400002)(7736002)(8936002)(2906002)(2900100001)(36756003)(3846002)(6116002)(71200400001)(71190400001)(107886003)(97736004)(6436002)(6486002)(110136005)(54906003)(2501003)(2616005)(99286004)(53936002)(6512007)(256004)(4326008)(478600001)(66066001)(52116002)(386003)(6506007)(186003)(25786009)(316002)(105586002)(476003)(486006)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1987;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aDHpLePs8ULUqEZvVX9REfRdLsaU0vlCDf8rp0TNqZPy46wUAiFEnVvud+yssl/exEs+NShNxOgzB8voI4cSNyXjbFDDhQw9q7behfJQW/dd1whGopwxVX8rRhnjQoHa63oWRityFjtwjbNddKSjz+64+I2yvxkdJtU2MvZYgPd3YzVe+L+5bof7+/Y7Nq/ZB/2di2LFD1KvwJA8MxhUomwEZqLmZULaT/2dvSwAe4bpN9NjswzBLFm6NIBTOTiSCtGfXTmS8mRq8QQmq8Bjbklvnw1XmAGiLMhthxXawVh22kB/BRYxPnivJyxy8D3AuQr+mblLXZK/evNux5aScPnTEST1m/oCpBSxa/zCSAI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 05959812-413a-4bb5-1ad7-08d6456a50e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:07:05.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1987
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bunch of fixes that we found while debugging the roll back to
SPINOR_OP_READ_1_1_4_4B in case smpt parser fails.

Boris, Yogesh,

Now I'm looking for a fix in case the smpt detection commands
define variable address length and dummy bytes. Will follow.

Tudor Ambarus (7):
  mtd: spi-nor: don't drop sfdp data if optional parsers fail
  mtd: spi-nor: fix iteration over smpt array
  mtd: spi-nor: add restriction for nmaps in smpt parser
  mtd: spi-nor: don't overwrite errno in spi_nor_get_map_in_use()
  mtd: spi_nor: pass DMA-able buffer to spi_nor_read_raw()
  mtd: spi-nor: ensure memory used for nor->read() is DMA safe
  mtd: spi-nor: remove unneeded smpt zeroization

 drivers/mtd/spi-nor/spi-nor.c | 98 ++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 74 insertions(+), 24 deletions(-)

--=20
2.9.4


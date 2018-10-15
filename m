Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4B3C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6608220881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RZ+9BQSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6608220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJOTdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:33:13 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:41824
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726588AbeJOTdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbpsSOKRqk9CcRIeTqfas15AOZ/alGFiAmz2QAL3i3E=;
 b=RZ+9BQSJrCkdYA2T42c3F0paM1fhDBuT/mDJpJaOjQjc3RpdPeYOckq+XN4sH8c5wGBK/tjjj2MeqKdhIkGmowhe/NT9Yp1QBGOtpxzTn8zRcO94TY0fEkYbFpNIW4gCSKSJXl50Qn4z6Ul6f4lH2Zd2PP0wLJNhMFjU8RDDe20=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (10.164.84.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 11:48:13 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 11:48:13 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 3/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v2 3/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Index: AQHUZHzzKNGdPxeY8EyFFoPgzHf0KA==
Date:   Mon, 15 Oct 2018 11:48:13 +0000
Message-ID: <1539603969-21076-4-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1616;6:VmzhNWZiahAWMXRfBr+1zl2Wt+D5+tR0hlEjQwnZe74ZaEl8HW+gHqUfpyGu+pHotKDc+NGe9mXvlwbsonF9wdjIdtMP/AAQkYany8RI/3yJHuIu8D5z2V82d8gxfsTlIpe2hxb5q7UMJBdXkhFZVGwoEaN8FZhoJiw+Tp4oEbItnfxg8h4SwH/74dXyEZVEYlf0YZrMfwFxnzrQSb6K3cPN6Y+FT4nr2yctpR2b0tN62UUaSszjyz7mIzOGcCZvR+Koqskbn5cfSw7LaWZgAVMYsSQQSnfVEiHIV9JRPo+UHAWaDwW82238FOrkiep0PfD6oKBMVwfpbhTWnIUyQfeK2MvmPFGVJMTuVo5R6YPEr5uTBfnk6vQ0ltLfvblCqcsP6rxN5qb2+4Su8mHr50Viqsv9Sv4k03IOCMWjGFAxC1sOiDxe/wbF56H9qeGO2GdeaQBiTjNwv8MImtq2eR2Oabj7QyNvmqQ6hX0J7MQ=;5:tUB7tBiQnDHXMApLhtAdNb/PjPS05Z5HE7F9qw6o/QENshNGWVW6Z+h4MFqrD6u0+nZhLRv1Wp0I+QmHmfnzEw7DVG7fjK6CbqxgoS1fjFbzJkt2WDwTp5Ad81QoFefPPzrpO6zsxqcdxAzQhecikS0mmcESNZLUydCKhn3fwFs=;7:3ml5Ke5faS5ZIYZ4mANHzGpDzwUbd5yXun/5Un+BVPhzx1bQK6E6LkFeUXkmz18gcXdvFHgfFM0ac8hzQH3SaUahuEPVEkp5eytbf3dSrqJRaCNy1m4JM2jrHOP+vE0INApj5BbJi8kdCOcV2EcadPYX16t7Bxo/iHV14bPDFNUUxVu+ir6LiD6EkAzlGXcG9XuR462wo5zo/3aBU08jqUG4mxNcNc9ib/VAYGUumO/MCAym/w6LiDxEf9yo7b16
x-ms-office365-filtering-correlation-id: 58c4bc60-5334-43ae-d730-08d63294160c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
x-ms-traffictypediagnostic: VI1PR04MB1616:
x-microsoft-antispam-prvs: <VI1PR04MB1616588C18E11FB2E7AFB99F99FD0@VI1PR04MB1616.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(81166006)(81156014)(8676002)(7416002)(8936002)(4326008)(2501003)(316002)(66066001)(5250100002)(2201001)(53936002)(7736002)(256004)(14444005)(6512007)(25786009)(6486002)(6436002)(86362001)(68736007)(5660300001)(305945005)(52116002)(2906002)(6116002)(3846002)(54906003)(110136005)(76176011)(99286004)(39060400002)(2900100001)(478600001)(476003)(11346002)(2616005)(486006)(446003)(14454004)(106356001)(36756003)(186003)(26005)(55236004)(71200400001)(102836004)(386003)(71190400001)(6506007)(105586002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jFRLdu9ByoCdgZvcKJ+YYXtXWGSjQMQC0fuokRVHHUUICKnVrGsgTtqmJBBH/9HWkUVXIpLE2OOvjfI/k5F5dQrPKLtCJAoA32OJNiouXItFLxpVBCBulyhpBqpZQzL5OhhE2rfKPdC90mMf4fkRpEaUq+dWPWhbWA4Awd/AdsQI2OhrP0hHAXZR86SI2YSzJs6NduYGw3vXgeWchcgcy21FfPVYhVD5sYk2bsWCgM5+9MMCbx5cJQeOwS5NG4TKi7vZrwQ188LIGFzJdPMLjyoW1DUUbyJVxNNS5Hwk/0j4TAmT6z8nUWflszGT1Nu7aGnHUOtCvk8V32EsgP9/tXTi727zHg6S1pAhv1n2980=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c4bc60-5334-43ae-d730-08d63294160c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 11:48:13.2497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add octal read flag for flash mt35xu512aba.
This flash, mt35xu512aba, is only complaint to SFDP JESD216B and does
not seem to support newer JESD216C standard that provides auto
detection of Octal mode capabilities and opcodes. Therefore, this
capability is manually added using new SPI_NOR_OCTAL_READ flag.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
 Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 7c64ff0..574f3e6 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1413,7 +1413,8 @@ static const struct flash_info spi_nor_ids[] =3D {
 	/* Micron */
 	{
 		"mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
-			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES)
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
+			SPI_NOR_4B_OPCODES)
 	},
=20
 	/* PMC */
--=20
2.7.4


Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41250C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A21214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="LiYZSFCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfBDKJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:09:54 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24519 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfBDKJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:09:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="23387571"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Feb 2019 03:09:49 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:09:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsIqQp4S2TjLKPSdu/z3ptMP5oR6DmykRM4FmGRHgsM=;
 b=LiYZSFCxcswY4H7oSxSz4lS7l/gqOqEpPoPXu/mQ1G6v0el4pf8IW4nZZvzeNUhNHPkPeiVd+LsxZW5Ke1XIcJVfDfeM7LHlqvHGMkHnFV4gIuWw/PTn0A0RPao5q2AVshA72niVL+v2x5QzPA03psTSd6TamITuwEARszxtSho=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1508.namprd11.prod.outlook.com (10.172.21.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:09:47 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:09:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 06/13] spi: atmel-quadspi: return appropriate error code
Thread-Topic: [PATCH v4 06/13] spi: atmel-quadspi: return appropriate error
 code
Thread-Index: AQHUvHHC6KE9JPQGH0KQIcX+/+O1dw==
Date:   Mon, 4 Feb 2019 10:09:47 +0000
Message-ID: <20190204100910.26701-7-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190204100910.26701-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0270.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::43) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1508;6:BtBjuSXi89LeAAfABNzLzLEF/3BifgTh8H5fIWVm+Nh54/eAM2iZNE2uTohrXFiS+GqXz5mibLsL8UXHsjjcMIlLg0pfdh9bh3vUZHENqFWqyJLnKgGbwGlQ1ZDuxhhSkDm/2HxItmNjdyjIx8ANaUsHNgOE0RZJZmJVKoqW++2Ey8b7lbhaYy3mAuuB9y32o104H8/NBBAI9H25sg9fOlsL6oXWvWRIh301H4arW5uRGv0mW56TOwW6ZZhAYj6HlLw7x+RWXR+DM8uCkM/+p0dHLL0yDXxgOU43azCfR9ifCfHFzPWZGNGZE6cnvlsNVAhNxbD8F2IPtIFHo8D9wSJwhqZZV38j+eVD0EsszhnVFItX/VFW/qt03QTVJ1hWk59GIFpm+iRdk5xcOnR2WgsG36ptvBDTwR2csyNKzpsTcs5ZNxOZVEbkBKKz1D/9ClL/fdhWVYtJojTv8sxQcA==;5:aBoFUDhVo69GvrygS7lZrE7xXdP5KMz54YrrdaZRgXhQCVRI8bwkILvllAaZ6Le3ffhsl/gnw6Cm0QK8CBEUdai+oTYwIBgYM3kOBie8V++BobdaQFD7KRHgzBmVlern9giNdIDKqznElrG1Xktg0/klX5UTcQd8IMHht2ZjdUbIz1+uycLrxfx7Vbe527nZA64+u0JoA7CU3LVjuAC8Rg==;7:UA/AH5A7wcdlxVIN8V4ziI/n/mtqXaJloZ5bGtRggBgqR/z7CLN/TXCoxX9UNoLMn3vMbJh/P46ZIzRFcPIDb2rpk/Im4TazhMe7KMgBPQei6AaO5yPSpDMyKBvIrndYojdNqvbHObn4nlFQioerAA==
x-ms-office365-filtering-correlation-id: 81164169-e28b-4887-3794-08d68a88e476
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1508;
x-ms-traffictypediagnostic: BN6PR11MB1508:
x-microsoft-antispam-prvs: <BN6PR11MB150801FD1CAE143CDFE61ECDF06D0@BN6PR11MB1508.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(6486002)(11346002)(446003)(2616005)(486006)(106356001)(99286004)(6436002)(4326008)(105586002)(478600001)(476003)(76176011)(186003)(53936002)(305945005)(3846002)(6116002)(7736002)(81156014)(102836004)(26005)(81166006)(6512007)(107886003)(8676002)(25786009)(68736007)(39060400002)(52116002)(50226002)(110136005)(8936002)(2906002)(386003)(54906003)(6506007)(86362001)(1076003)(36756003)(4744005)(71190400001)(71200400001)(316002)(97736004)(7416002)(14454004)(256004)(2501003)(72206003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1508;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sBHsqucvF5CldpgZfj9tsygPEOleHxwKrhon2BA8BJ1RIQ+BTwe0cZ++q9oZamsfB8dhD59icgqz5iD0YnK4LO5EkFrlvRjvzJRIyeMSP+FRF3d3NydtDi88sOZtc/TFNUt47eSxomAWS/J9Z4LZJAD9+LVi0TESznv2CtzelccHGY4pCS4MrEqPnSMDbYc1a1JOTWMsWUNp3jFpPQHT3ggWMvp+o7jXfS4cdgztv60Az5IEEtyOmQ39FYCp919gOB8VEFMCCW8Ii85fqtJoCAptMqf/JlXTTNDM7XVHtBvMNSdbAGHb1oUelLsfpzzZiTyUSJf0pJ13iBMvN8Xdcn6gMKX61Jckkc1/p09tWyqp8gn/fs5bpEzVK4ZzewEED+WiT92nif4HyPBS9ZYN8xFe54rp0oVwnyCnz9EDNSY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81164169-e28b-4887-3794-08d68a88e476
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:45.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1508
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Return -ENOTSUPP when atmel_qspi_find_mode() fails. Propagate
the error in atmel_qspi_exec_op().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v4: no change
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index be7f87fd5ac7..06c31830d07b 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -198,7 +198,7 @@ static int atmel_qspi_find_mode(const struct spi_mem_op=
 *op)
 		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
 			return i;
=20
-	return -1;
+	return -ENOTSUPP;
 }
=20
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
@@ -238,7 +238,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
=20
 	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
-		return -ENOTSUPP;
+		return mode;
=20
 	ifr |=3D sama5d2_qspi_modes[mode].config;
=20
--=20
2.9.5


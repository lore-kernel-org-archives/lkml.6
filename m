Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09409C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D0C2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dwrRTRqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfBDKJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:09:42 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:33446 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfBDKJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:09:40 -0500
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="26269131"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Feb 2019 03:09:39 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:09:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONzljGUKpxSEzjquSeX0Xc1OQzIQlDcNjKqAIPOusBI=;
 b=dwrRTRqfDTXpvOMuaRs1hcGIMWeTKMtsIRJjTVtLwFw0deEaKESRXBxoh9InkRUosqCvfMHwJwr1oWVx8fiVT/rw1WW7Zdrd0G9EQX1fdKQFUlm0Decp+Fo0jag6WfmiHo+V/CH8UhOTQnV9MyGsQ/DwyjdtQUOflGzPUGP7UNI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1553.namprd11.prod.outlook.com (10.172.23.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:09:35 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:09:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 05/13] spi: atmel-quadspi: remove unnecessary cast
Thread-Topic: [PATCH v4 05/13] spi: atmel-quadspi: remove unnecessary cast
Thread-Index: AQHUvHG7FrZsuRI6JkGSi50b6kZeGw==
Date:   Mon, 4 Feb 2019 10:09:35 +0000
Message-ID: <20190204100910.26701-6-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1553;6:6DU13k39C2gdorANswtXWwDb2JlePpPw34FI1Udnwly0HL5xlrJAZeeWGuyoFO9oni+X1l5ac+UZmxhlEGqsv+MU9mOzXbtQCVmk07woGJmg+HuJPIdHu7oxHF1M8ZyGmKcwEauryI1faiGY/liugOHKe/ML8/4E9rnYDxcBTKUtI+QFw3uFYqhrlTmSpcs+E3jVN/lEwOVc3RS7fvjWx+9OriwD/hotb4AO3G5J5fipcXrGXWg+XeRpZKfaPoIOcNXwrdP0KUuzu9D0c7d884D8d0VpqitNr8llm7pD6MtAaOU6434rzuTm7s1Oj9ba5/beqBEZzkIq6Qi0Ws/szURCXuwDZqb//tC1KWTZso6zls+t9gUOeofpQsXWXd6PZIVElgWxrB7F/VWlZd9DLUajTjVuND07F8Uv1q9dkGd1UKndZCXpuHW3rc3JlRVV9JDfrBlQbD1DC4vFNdzIqw==;5:Nt4NuklSRIvUpNrjFBasA3m4gglTVt+pVcl04xqpLzSXq5O72UJHIV/lTT0snkjcm89NahcweUtehjisex4bR4Cy9pLSw/99wGremA5MRKSMZo/BFl1/esKJtfi4IeZrT3/WhpIZnFfVbktfFWNggUPKNeca6+/K63g1j/dcmmuSw/bcpOq5JdQ3/4bmORSt6+xeheXBtYGkbN0FDZE5Mg==;7:qagK4kiJuvn/QYa8R+deNBqgNFwRrYdbUvZ7YpXwHyWDIwBgU9RoJhM80mZrTOQgofmNcm+prleuYoq4At0eGRzcnatJwmzbfGWRGVkeVrKa0AgL3DbS8VJ5i3G+h58uovGuIsEzwaKrF66LG4OvUw==
x-ms-office365-filtering-correlation-id: ac730272-e9e0-4f61-4895-08d68a88dd3f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1553;
x-ms-traffictypediagnostic: BN6PR11MB1553:
x-microsoft-antispam-prvs: <BN6PR11MB15533BE642F46FB6FD792D7EF06D0@BN6PR11MB1553.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(8676002)(81166006)(81156014)(316002)(76176011)(8936002)(4744005)(110136005)(305945005)(186003)(54906003)(66066001)(7736002)(446003)(3846002)(6116002)(6436002)(68736007)(86362001)(478600001)(102836004)(1076003)(36756003)(105586002)(26005)(106356001)(99286004)(72206003)(50226002)(6512007)(2501003)(14454004)(11346002)(476003)(486006)(256004)(14444005)(7416002)(25786009)(4326008)(53936002)(39060400002)(107886003)(2906002)(6486002)(2616005)(52116002)(97736004)(71200400001)(386003)(71190400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1553;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LfguKdxVrQJkzHbDVJjKQkyIn0w/zHuL22XcD0+zlbwP+fZDKsArnHUNC7dE4G9FEjpsq4gVgBCLqD5qbPOptgnnHiuoJa6W8aqetFYTrFInt+mpcaUFIUzwzf3wj59suJE62hIjKo26oeWZV5D+0jr8Y8mCKUfyOKcg+3W/GAjDFFX7atvZeo22yHeUMOw4zB6az2Mg3UIFMoHSNXMAuOGeigUDA6P8boJJvu8p/UGlEkjQH0UzOOax2EwVbYEHws5KWHSS5fQZ/4UnDJ6DRc3x60Uwmjac+svPKygCDOQZLB83pneB8mJbD91B8FU5wXnmXU/oC5HI8BP34UrmWIfXHyhV1auZbwiiK9B9gTQPyjf7MkgHvDqCaXfvmQpaRG/A+S4VwE18mifqak5KCSSvbzHQJp2I5fDsNTxdT7o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac730272-e9e0-4f61-4895-08d68a88dd3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:32.7821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1553
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The cast is done implicitly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v4: no change
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index be1d1ba7898c..be7f87fd5ac7 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -389,7 +389,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
=20
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 {
-	struct atmel_qspi *aq =3D (struct atmel_qspi *)dev_id;
+	struct atmel_qspi *aq =3D dev_id;
 	u32 status, mask, pending;
=20
 	status =3D readl_relaxed(aq->regs + QSPI_SR);
--=20
2.9.5


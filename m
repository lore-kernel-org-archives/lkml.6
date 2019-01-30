Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E4AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAFE218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="c99bKrwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfA3PIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:08:40 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7120 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbfA3PIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:08:39 -0500
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="26094017"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2019 08:08:38 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 08:08:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Os2tdyNKEPCMm909MpCewpd6kQGkzIfTJFtLpLZTIg=;
 b=c99bKrwX2t3OT3sQXWZCTIz2QmhFtt0T0ZzV6r8rYMckldJC2Wp9HnI19jQgYSfL/KPj1Ve3Jtf8H1+naW+TDEdzd/2PvMgLjLq0luCMBsNshY/MhNNUmYcxvxlDPq+jCCvdEsCfx0ENijwFEJIww4oTDWHJPya0i60qUx15qyI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1796.namprd11.prod.outlook.com (10.175.99.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 15:08:36 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:36 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 4/9] spi: atmel-quadspi: remove unnecessary cast
Thread-Topic: [PATCH 4/9] spi: atmel-quadspi: remove unnecessary cast
Thread-Index: AQHUuK2spztuTCidrUSdAFF1gcbY/A==
Date:   Wed, 30 Jan 2019 15:08:35 +0000
Message-ID: <20190130150818.24902-5-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1796;6:DWDxTCNNSbvD9hb6OiinnTm2+ZqmPpDVzYwoiBNnkJ5DsOoi1j1SwzLzOTyaPBCgjYCeFJkaRmcbuiRtncdMzrZu8zv92sxrfRCZiPXtkSNoAdZ0NiLpKvqaIQXJuglsK/zdFn1EC9p9qqpsCZxt22KbanLwOx6D/OAyeyrElVKBf4nTlMTh3OIXF+xF4JinFEEW7gbxSxKM9wTKR+FJ9FhV9eqhpwQ8t1AWIveb1UkUHbJtrI1IXEUwXmNocsjx8jIPzaOwJQv48Wy+HXC3u41sUdVBCAuKQ+pv71UPeyiFWzE3f8dOFcSTqt5VNwlPVE96kdE/6EqDtVVvWi/RjKZEHZgvLsav5HLyVXg4yoyUvqoKyBs9AnRfp5zyLM84Rx2tXPjHNqYv86o/mybhDyM8OhMGlSqH3yuWmpa9+bLHSAl30BhFBzuld3KMHYVcapIhT3ggdIGJSLNqLvSjkA==;5:Xu7BNE8kbf1KnfTQaDmCZ1V4WaMnx/nbrInZjKrzx6H/T8jwqL70Uj7b/jd87kUhfXra2ViVnit8m0Hy+tAbCu8r+yRcjXK4Kd/OTNsW7m5rPq0xaVCQVpshanLNJo8zLQ65cKZcm14FBEpRAICdgIeicYKSrml1Wnb3VwAuJ1JHtCuISRg9y7NBXoR4QQgpnsRzyJCc+HoDr0VXNUPqRQ==;7:JUnXVEC2kKZ4zt0F65kjNNR+ec/3xxW6ELlwsCOd2eadt8+/pwgesXA34S9xjn1Wm4dqvpdGLuSaLbMbqeKgtIMT967fX1wN3QvhAylt66ET4NvaJ6kOGJYXEOboHpR4MZNE+f3y3OZETN76iwlx0Q==
x-ms-office365-filtering-correlation-id: 10591938-85c4-4e38-759a-08d686c4ce78
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1796;
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-microsoft-antispam-prvs: <BN6PR11MB179693A52F7631284E83A75FF0900@BN6PR11MB1796.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(386003)(316002)(81156014)(2501003)(72206003)(81166006)(4744005)(486006)(14454004)(476003)(110136005)(1076003)(8936002)(6116002)(4326008)(11346002)(50226002)(52116002)(6506007)(2616005)(36756003)(3846002)(68736007)(6486002)(6436002)(53936002)(8676002)(54906003)(66066001)(6512007)(478600001)(99286004)(186003)(71200400001)(97736004)(86362001)(2906002)(256004)(71190400001)(14444005)(305945005)(446003)(6636002)(102836004)(105586002)(25786009)(7736002)(26005)(106356001)(107886003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1796;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ybFcjN+xHv7DMSoStm530K1Gewm9yKcYEA9s+K1W4uWLic88/EejA3J73V6NrPgf7xwfR2tm8D2vRvYtDmgKEFjEBZQHv+A2ODYs73QwCL+sQFb0ImGizRD3ER0TaxGn4IQLWQd/PGacFoU7EGY2BtXjXqiNl2UKpSV8C+vkE5MeA071qFq3h4HzPVugFhBwI6/KyqMk13k5Ml9izbmutt3fh6DEAlRZVfKEXeSddxBRj/p27XN+00as+rjigUwsJX4UVQ7Tof+28lgq2D7inj1n++xmdzWn5nzDNYAckeo1CWFRgX4JSB0mz8ULZ6XUoiDolkE12vkiqxtc2f9F9zvmrhhR7xdMQonjisjm1izRO+npQmI54913h4aFKAcUw1LGrfohpeWx586XvQGOV5F1eGMNQdOaBmeQhSdPTrA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10591938-85c4-4e38-759a-08d686c4ce78
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:34.1095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The cast is done implicitly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index e156c345705b..3643f0c851b0 100644
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
 	status =3D atmel_qspi_readl(aq, QSPI_SR);
--=20
2.9.5


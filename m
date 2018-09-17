Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B687ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496FF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MSG4yVD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496FF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbeIQIbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:47 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:32192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728849AbeIQIbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD2+ChWeiklC+HzBl2ixdTid3lWbHuZwiDCnQkNkiL8=;
 b=MSG4yVD/68yf6j1dLfpPG7qitczaK3BPd8rGU2tjQtBsV8TZCwqHF9c5zw6Igl27bYxb1zSmA2t4QN80/RhH88SpXFsD9jYivauw8XRgFoV6igbDDuQ5c3IamjBYftgVqXKxLQklcfQXLA5RtWjv+It7sNM86rCmliC8ikn4LkI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nadav Amit <namit@vmware.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 54/57] gpio: Fix wrong rounding in gpio-menz127
Thread-Topic: [PATCH AUTOSEL 4.9 54/57] gpio: Fix wrong rounding in
 gpio-menz127
Thread-Index: AQHUTjMf2x4bEfRqRkmDDgcIBS6xcA==
Date:   Mon, 17 Sep 2018 03:04:17 +0000
Message-ID: <20180917030340.378-54-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:wsQrf+gHFmjrRFsHnPu/i37fpu1nG12NZrrOBqMeyXPhsGdtyAJi/XjHak3owBzuIjRk1Naop9tBWIwbnn5QoG2cHQmkW62Eff17pbzaY0jJU0QxGzqJ717yWn4sDjs3T2IlzoVibGQoUt8Bx9fbX8jyDLYBp610w/bkrpogQee2SZMFvUgENnYmbjHMu8wZ7i0JTXSMHjZvaje0OemZtKdbHtuZqwjG6juzGZIpnEXz0x8AzLT0I1d0DDRtnTdXhDAO/PYegaUldPFolyo40yYvo4QIGQzrseD02sDx8JfKLvtZ8hM9pmIQadY7zsFaeiPmsDiMIOqi6Ng+4yK0yYswE2A5y2OcaJu/oMSFdk0JMeeysSJly7o/EYBfoISswkp8PwVqRDps0alD6q5uUzcnIWn4BQ6WMc741QD0PkhbWC4J0tKeLRV7CBg8tYd/CMu9uyZVnw52ohQ0ZitZ4g==;5:ibx4O6TH/tKSheajdJmiocpA7PJLVIEl+eYzc/XwYn+OaY6NYp21irB01jm4UvP/DtCBy5g0z6OrW5iLXtsyv9ClxqBObLy96Z3efnTEq7lIcXAg2TSlwU/LtImOvV6kgWsfFPmAtiDUiHajm0PIX7uuD3o6ANO7zlUkAyEiw6o=;7:pS+OZKb5ZXgpuQcXlNr/Rh9tAAyCuxQJX9B/YbVCpfCj4nZH91P2xrcB0d40YvsjUrTY2Rv/U7NTHM2wlpJ4UdYOvkARQPl9znzYHa9wG0GC7Ghu9xPSXcaVNUfdng7DaBC+Zyd2mNlz/hHU9ThzabF5zcJUH2Ra6gf70QnFooscC6SwRY+5gVNcGGf9HFpAe8cUahwLx6zh3jVdERYOedddnIo2mpnF3ccwIJFasPOH0AYAtavvjWZXNUxnXcNU
x-ms-office365-filtering-correlation-id: 42961890-21fa-4d37-60e1-08d61c4a8f1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB0166603200C8A31B1EE372FAFB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(575784001)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: LHFMyMsP87KE9EltBBHWaJIxzp8H6rWaw7NzNMqnuQykFTN/DXGvGqF6kWIl4c33kjZbq2OE5cXzNZbEbGR95U3u7ujYayovwhbI8ZowN+YoVfTF2MHTfFovsFzg2L5ZFLsqeovSSZLc0eGswbiRWSLNmpTWodqWjhNDZ+QeGbH9NSskx5cchAUYUoa8G8WtmmzL3aDBvCUePSn2QGQhpFJ+4nBSUpUW9x8Wp38JN+ciqE6sppFgz/QGw9HThkv7bie2gq+dkgP4oTYAGmn5Rd3FGUcANe9F1ikiXCtfBIcXGKzIlPkLUOjiy6VR++5EixhuKZH9ugVbCA4BQSVovcodI7aaxgZh3REM2V9m6dQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42961890-21fa-4d37-60e1-08d61c4a8f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:17.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

[ Upstream commit 7279d9917560bbd0d82813d6bf00490a82c06783 ]

men_z127_debounce() tries to round up and down, but uses functions which
are only suitable when the divider is a power of two, which is not the
case. Use the appropriate ones.

Found by static check. Compile tested.

Fixes: f436bc2726c64 ("gpio: add driver for MEN 16Z127 GPIO controller")
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-menz127.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-menz127.c b/drivers/gpio/gpio-menz127.c
index a1210e330571..95061d25895b 100644
--- a/drivers/gpio/gpio-menz127.c
+++ b/drivers/gpio/gpio-menz127.c
@@ -56,9 +56,9 @@ static int men_z127_debounce(struct gpio_chip *gc, unsign=
ed gpio,
 		rnd =3D fls(debounce) - 1;
=20
 		if (rnd && (debounce & BIT(rnd - 1)))
-			debounce =3D round_up(debounce, MEN_Z127_DB_MIN_US);
+			debounce =3D roundup(debounce, MEN_Z127_DB_MIN_US);
 		else
-			debounce =3D round_down(debounce, MEN_Z127_DB_MIN_US);
+			debounce =3D rounddown(debounce, MEN_Z127_DB_MIN_US);
=20
 		if (debounce > MEN_Z127_DB_MAX_US)
 			debounce =3D MEN_Z127_DB_MAX_US;
--=20
2.17.1

Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEBF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HcD2iDuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEBF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbeIQIae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:34 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730540AbeIQIac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5/8WlY+isC8nXUiwvyobWMTy7akgiRTJlrL/kwvtIY=;
 b=HcD2iDuHAX4Sq5w/mEQqinlms4g+IHbPlk5g2ERocMKLSrgD6/605d+4J/v7ROEazwpJi2p0YVZF87eyR4icsrISgJ6UctOGBdQlGenHs2eySuDOeT8vHiXbTLfZRpoaiG24NHvNV3yJ9asfb1nWJ0EgmQFvCKDiEfmxquoZsyo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     khilman <khilman@baylibre.com>, Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 86/87] ARM: dts: dra7: fix DCAN node addresses
Thread-Topic: [PATCH AUTOSEL 4.14 86/87] ARM: dts: dra7: fix DCAN node
 addresses
Thread-Index: AQHUTjL8piU5GL5b1U2vhi+OtkBYYw==
Date:   Mon, 17 Sep 2018 03:03:19 +0000
Message-ID: <20180917030220.245686-86-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:QL8fMUhpk7USXMf8Qk5OvSWZkaRWA3UzSs+P3nBrMDTft+Wh2gnTnc75SwUo1j2RE1Hiz1IV1JYErd6bv5dwSfIveSFko6Nh5qs/Yo31BzuftN/9oL/6EG9XR6v7ChqJqt6ZmNpUqDJiXT9mkrhfJI6ypVdF9CH+ITya95MfVuyGRbkU5mn1Hy7AKroWNlF/n8KFhEZYS7aqDE3lVInoCi1j1VoBhA5ay2s/O6aKV50TLAn8k6sU/mRQbOHn2bBTs9IvIv7JZoPYmnzFPZRLv0bBBqDhg+jvHML4lX9bPiRmRGdEaPznxA3rVKn+t5LGcrvL8L4Q4eGoZBx6yPlokQzZih1z/35OslW1kzYkfTkp+o48WP/zhOwa+ie8d5s9D/Uh3kD+RJfYW6xHjcKV6qkGcUwrb2oB6ycsITsH5qAv/FPg7G599HHYRdhWYnpzgEJshcD+uNRMj9L+oP/x7g==;5:ArHV0SzlinAPaG4fDoRus5br5wvItvCrrM+wF9/BPIlMNDexGcAqB6/qBse1PR1zGWfr8en7+71A5IiwTotwyVoejWV+6IKMy/5FTHtbKZsuvm1y+zDYfTiWaPY88eM0xTauv4lrVbioKzBNwh49TwwcAhTenr1UkIPNZfeLOHY=;7:D5RApcHyhuQ57aN13D0PaYQT5CnM2rM3CMgi8x3e05p1d7/uZRYEk7kfEfjzdPbl9lq/2fOrW4jqNne3FCsfgfYOILqAK88+xggCzb6lfFGP+tfV1YyqbgmyP9CbqoFx6wvAMGPoTf8qJCJy+EcnhgazcZy7YJe2btBUdXwCc3rbuL1bD6fXmDk3ul9Fcyeax1Q33rNeV3DYWwFBoI+Py1mwsaAnYxAcJdoX1eTwqG5XHVamBzfui91SPewQEMlU
x-ms-office365-filtering-correlation-id: b52bba40-70e5-426c-2fec-08d61c4a5dd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0133249FF277767FA1543D6AFB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(106291317490208)(31051911155226)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(14444005)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(1720100001)(14454004)(966005)(72206003)(105586002)(99286004)(6486002)(6306002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zhMgIN9ji7TEBsYD/A79Ok4d543pgmiSnhlfG+wTzygSW77VEs/mLHQmyanGIUoTDQUC2FvIIavbZYAxbCRyLQwZZAvPCOqiraaLN+WbkZmALJ1N2iyXYB+ZZu8HW65TydKR0k3n+aw6RcymK+OIL1/jWCAk+YpZePsLwDIMwpzbj2p3RlUQDz7KB8Zbl46YGedtAsexp0g81UmmW9eoRX5OEhPZ+R4wd0Mx2cDKRcW8+m+0kK0ZkC6SRKrDJaDHzRdrcan9zx7JXV/3eFOb+rnzMmQVmIN3hCx3WxLnfLqDvbCuQZrJ0w53K8knh1CMQtDX1XSjCpUV9onvHn0vWv+/upjsulV4N4gy3rmbUP4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52bba40-70e5-426c-2fec-08d61c4a5dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:19.3683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Hilman <khilman@baylibre.com>

[ Upstream commit 949bdcc8a97c6078f21c8d4966436b117f2e4cd3 ]

Fix the DT node addresses to match the reg property addresses,
which were verified to match the TRM:
http://www.ti.com/lit/pdf/sprui30

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/dra7.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 02a136a4661a..a5bd8f0205e8 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1818,7 +1818,7 @@
 			};
 		};
=20
-		dcan1: can@481cc000 {
+		dcan1: can@4ae3c000 {
 			compatible =3D "ti,dra7-d_can";
 			ti,hwmods =3D "dcan1";
 			reg =3D <0x4ae3c000 0x2000>;
@@ -1828,7 +1828,7 @@
 			status =3D "disabled";
 		};
=20
-		dcan2: can@481d0000 {
+		dcan2: can@48480000 {
 			compatible =3D "ti,dra7-d_can";
 			ti,hwmods =3D "dcan2";
 			reg =3D <0x48480000 0x2000>;
--=20
2.17.1

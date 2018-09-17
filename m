Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E020ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7CA214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DIiGBR1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7CA214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbeIQI3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:01 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:31712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729165AbeIQI27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEJ4eRxrf99qM895bSXnKYx0NiTpTyYZE2tnjUWtiPA=;
 b=DIiGBR1Kju5M+rSIoqV9IWTXSGllo/ZP8LAnUiUWwEFkbSM99y8CWtMkCmApK0OhaMWd+cQBEP5awot9wZ6K1pEMYI0T1lB/dvensIUwm9brR/8fpPy/YFPpoDFACNTWAhEiyrwA5jb3meXkf+KxJVNZ8ko5Pe0xc0dCAGzSIOY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     khilman <khilman@baylibre.com>, Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 132/136] ARM: dts: dra7: fix DCAN node addresses
Thread-Topic: [PATCH AUTOSEL 4.18 132/136] ARM: dts: dra7: fix DCAN node
 addresses
Thread-Index: AQHUTjK+1yijfK4dykqkIHyJjb9xQQ==
Date:   Mon, 17 Sep 2018 03:01:34 +0000
Message-ID: <20180917030006.245495-132-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:n5j070/1QPDrXDKMBGDunmOe80rfcAmP1aZVs0swKOtjUmSTGicVT8dZVIqjXeoS+/w47wyGhorWN4I7KAnWni7i2eaZT8BBiNoONZvuFV2L96JZQvj+FWHS86e6BxnqQiNdO0coGHtJ83oDjfpb8RkFZPFMO9H6CecfDbaKko01dXWAHfKHuSOU7qvi7nrfut2VBV56yUmPrTGFPcBZaPOhX8qlFA5f/NPQlanVDfu+6K46xBbIZ5s4kvXDKMWjT0b9sPp+JHxprKi1/a5L2xHspHTDVXSMqa3LM7NISeIStdb19UCQIuASsLkITbeTjFKLytGjIiHUAJL7tuL+6aai0/GfdByoYg8RfM7D6ohBvVIiXYrPcEScgDlsOLwJp46PCAKkdpo8+7EReHSk0NPNPbveQE4zPOB80g8nMDWqmJuI2WhsdLxQsVTzRepR43vAJsqhpKsSritimx5J9w==;5:iW/YUen4Ol1F5KCwwIcQicV5xl9eToxKH+OuWjs16gv6USRrzPXNwHaX+8VMEc1nNvDIeUh1dHrXOW0xQ8CWx4e6oTs0m+QMnbKTvFn9AIjNuXtQbM3jopL/S1mF+yWV5jwfN/TdW//iR6+7rmI2gl5Y5KPwphcanMxJ6KAEE7A=;7:hsd+FukBKcUodNTzk2a6XwLTyui/xl5HIndcyjVZFz/K83jyZAIMy4AOLoLFxl090TtBYY3AT/lMHszgT93wJOub6Kqds77JliGCZb+Nr2HZF+SwoPbr/qIY5ktLngrNxZ5l6t2DlKpW0cRjEHab/Obl/LO2vDblxVopRUF0zC4fxee3iorjQH5f8Td3oR82JofbMCOHuKV2wmRkfyiRyfC4gT0aOwpZ9ebAXa470yyTjnvFoUiu+3+3RpMBJPRg
x-ms-office365-filtering-correlation-id: 5982f0ee-9978-446b-e97c-08d61c4a229c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0118E4749E2DD74AFEAC2BA2FB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(106291317490208)(31051911155226)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(1720100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(966005)(8676002)(575784001)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6666003)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(6306002)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: S4bctQzY0SgPcJp37sn3lBffRPhYhMUqwiACcGPDKN1A5gFo0bzGwguTmHHpwwrx/b0PPhvaeE9HMtt6KZSuHXq9pwej1AZkimK43kuqiku4aHclRhcSg1LLf0rRuBXx19zjTP4pbV5VEpdKe0KqY254dtdCGmJWEUO8T1qZsmuXnUQ/IplDW8KlSRdprei5R40T/UAdUCg24vJLhlyp3v8himf4F2T15ZitR8f9YMw2nnOfdX3ZYNWvWhX6J5f45DubpPFjB+R4VTYm66+rwWxV3THbXXV5yhRm/onKXlwNSbW9Gz/Cb0o04gOFX6XIEIyN788nnuSvjBNrBebQNTQpfjYtD6JnWSRmQiZ5K9w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5982f0ee-9978-446b-e97c-08d61c4a229c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:34.7133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
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
index e03495a799ce..a0ddf497e8cd 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1893,7 +1893,7 @@
 			};
 		};
=20
-		dcan1: can@481cc000 {
+		dcan1: can@4ae3c000 {
 			compatible =3D "ti,dra7-d_can";
 			ti,hwmods =3D "dcan1";
 			reg =3D <0x4ae3c000 0x2000>;
@@ -1903,7 +1903,7 @@
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

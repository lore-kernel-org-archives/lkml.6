Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608E9ECE565
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7D12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OxG9TwzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7D12147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbeIQIdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:10 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:52292
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731446AbeIQIdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me1BDAZoqjka3nwIFkOUTManlWr7AikTrN7eVLkxV1A=;
 b=OxG9TwzB4nmu3EpQLhQ4bxg6Szc7mWEsjSXn2DizHUEml9gzoh303YGQ1oVfLpLLY6L7/TPFTdUyII8Z5yiGsG+4tT0oaFVNG8e/FIdwBP2eWiU30R589UWM5ixc1R3hNdRRcMMnh83vFjxwLql8JfX0D8rDcGBykGgCDT5mcSo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     khilman <khilman@baylibre.com>, Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 43/43] ARM: dts: dra7: fix DCAN node addresses
Thread-Topic: [PATCH AUTOSEL 4.4 43/43] ARM: dts: dra7: fix DCAN node
 addresses
Thread-Index: AQHUTjNBZRyRh78gzkm+GitoU45L3A==
Date:   Mon, 17 Sep 2018 03:05:15 +0000
Message-ID: <20180917030445.484-43-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:BfJ5EyTw6H8+X/l47zjnMQs38buxLEsME2eFEAiFkQt0GR9BEzszrNRL04MRRl+U7+IqxIvDhbkDkOkzUWKOa37TOvVn11gU8CidIBKuySvsvrdaoYxOidhqR6vJS7Oc+UsvGaMiwtSDI6Af45ZFfr0bgxjqVo44xVvD6XefzdqF4yQjHnFY0X07PhWNKVxRauCBnlTgQINEGAG6l/QlKczRa/j/iQ55ZCGCm1nRKUltFPbEJzWyBfVS9ez0dWj9Y5Oa0pPQk8J3h27jfh9twgVN5XS/26VZTnFNQlH/Y2adSLOT1B0mP4o1rB3A5KyK8See6nkqbrsYzoEjYGiC6qqrfYQs4luyivsr8+KXtz/JA7bUVsIpcsYFr05qS2ibodRUZwD4aK2w8eM/6RwYirGn48Oy7fcQ0BVPd7JuJqc5VEAH+GpMhz7dfTQngIcl0gzpGd0sLdjqi6Y9mrJSeQ==;5:Hk9+D1ynFNFzLxte/PnXs27IQDVhC32DWN6staVBHDxBhaeVH5oqqPNJzz3tK5JylBpP4RV0AGMFKeAJqAMwZgFUvtpjpQolm6l3QAsnohZlrJ89lcXktnUiBIFvqr+ITODBEeF9kVZvzIUqpCvuUz0q8UI9DN5Gi+ni44GjnvE=;7:WHtYd0Bitgh1AXmFMpW+mWzr+3HPSqy45pLnm/n8CPtFTyg2NQUE6UOjCxMulkaWRd5mgzKGOjXjbjnSYcVeyoVeIND0WKZpGskPtVmzKtnDBjuhZDVHn3gsNunXZuvEWZwW66A0Zq0zboPWxbHG5P8yxwzp0YuQKQYJnBLI/6Iekma/TiDj5ISJHSiIUdzFKqGl7K9A3fZ7/A9L42ndhArzADonCka2xI4A23CbzbfMknIe52KR3k8hAOLCWm+q
x-ms-office365-filtering-correlation-id: f35e066e-fd53-4bbc-18f7-08d61c4abef0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0839DDD811864981A58AF432FB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(106291317490208)(31051911155226)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(1720100001)(3846002)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(966005)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(6306002)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: y6VcEjEtLksLHFAMpst3z7xihgnO8tA6I0TPUWUEImAjmc9RRs1FrJxXN60NyYcH1Q6BOKGtqqLWw1mO2kfAjW/fFX/Xqif0bX7SgF6cBbuoQBD/Pe8xniGMm9M/Yueogip3H+kbmyWzHPHenBMDa1xHzFkQEHqvdzqUTR+ZjyoiIoKH8fYa4f/B2MDIMfED9VCiyDZqP0E64LWp6n8/20HEZ2TzzQUH4I+Cm58vj3EIxYPCuxeGLtyTCC5f6TXnaNt4OFGBDwp6OKGnBho6DYBm1k2YT0jBXHi/RY3sECXrheheMvx6WwziS9nd2eJAuIhbgH7X6KMPv+xPJZC+3S6f21lJE4091thyLvpI8kc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35e066e-fd53-4bbc-18f7-08d61c4abef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:15.6171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 02bd6312d1d9..e6a3a94bac69 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1549,7 +1549,7 @@
 			};
 		};
=20
-		dcan1: can@481cc000 {
+		dcan1: can@4ae3c000 {
 			compatible =3D "ti,dra7-d_can";
 			ti,hwmods =3D "dcan1";
 			reg =3D <0x4ae3c000 0x2000>;
@@ -1559,7 +1559,7 @@
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

Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA1EECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEF0208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WOu/HGNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEF0208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbeIQIkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:40:21 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:15223
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730956AbeIQIbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AyEVuydv0Ozyj9BiRvDsowr0MuyTAI9KSRzHXRITak=;
 b=WOu/HGNeJRLZEFIPjacevfHhg12Ce4eTGCHZ/H0xhWluXTWvEdEnuYQoryRBDglna+qXFfDyAkUAOe+xQlP0VXXUDAZubSVJTc5d9knjI4/FuEg/sICmqYIB4XWIrC7lk0KtPhDwfySX7kA+lpX8ucnaJEJQiPFGYxbzp4NGFyk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     khilman <khilman@baylibre.com>, Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 57/57] ARM: dts: dra7: fix DCAN node addresses
Thread-Topic: [PATCH AUTOSEL 4.9 57/57] ARM: dts: dra7: fix DCAN node
 addresses
Thread-Index: AQHUTjMgPGlYL2YpdEykTnnAdig9dQ==
Date:   Mon, 17 Sep 2018 03:04:19 +0000
Message-ID: <20180917030340.378-57-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:d/TEosnMxsz15xnbGUQjWRvGPozXfeIcV534szv2GkXGvayRl2c9GQuc85Ru1hMDLtqb2zZLR4dRr9j1lO0PRMsrmuMSCCet15RYE5Ao83Zyquyaozl19m/PyklweL+ljlmzaRT19PqTNknTZHlu/Hi5C9rK4malM9FfDB3gCIAHXKfyfC9a4R7bADoloJpUtnVouOx+2dm5lIPwo2flA4k+Nslg6JXVzHUyo+2HzoBCGRFU3yjgg8phkjIt5z7WxHdq4/AGQuwR4QjzKRCmD/W/iv89zXFLmbJcAlKRyb+il2jhhy5SDhRqMS+7Re9/dpcEA0JRZCRJBDgXAXqF722L+Bjqmd2kVKZsBoiidOpKzLhB7jg+OrTYcd6WXNE+SD9rkmxAL0n0W2cfyY6TH+Hc/h9y/TnCAWDzfPXLhojjImf+DxpN+linol6WxJn9wdgJhTiWvWQlN4A/8FVK/Q==;5:jmNhwX0SCKp1TFA7E/gILEpbYJS6Y2xts4wgk+SA0ykJP2lcl9zd9nDmz9yIdd0WwiTp9vWiB8teFCREBAEZLT3CtXOOsTE/YY1uBL6yP926sAnKzN32NAQsaoxXmPmlYK5paB1uHQRPvQPpqzX77YmPg7EzRSoQf2y4s9W8kCM=;7:0cyjRfBtN8VpRdCCRo1zjfka0qff3lwCRTpfI4MtTnopYOrZoOuSOUnKvinGvedxjb0LwmhniPOfMba4Y+47nRaxbPXarC0nT8EeWddsYdN5nq4QH2Bob5KjgvYDcCyRcO7DNodm6uhlAOd8Kt5XKvB55KF/Fcy7I4WMkpuc4EpyAw8JxwcML67nVktlKhISz0YBRUHe4rJ1akJ4dFjWPRU2dJAwNRscBagirAQa9yICVHMlPOCh8jZI0Z0yt2CX
x-ms-office365-filtering-correlation-id: 289e72db-1530-4a74-b702-08d61c4a9017
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB016648B3FD137CA7AC3A3906FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(106291317490208)(31051911155226)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(966005)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1720100001)(1076002)(97736004)(86362001)(6436002)(6306002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: bC80liC1xyMnmlauEXSlVGwQKuPzhXtpZhiL+QkVpB2hjYMIKvtKkqtBkyr1WpdpMuJMcPzk/HEOp3+CseQj4CP7E1mJ8fEUwA426lzSAFGNHnZC61qFDxf5uhiimkdcnObN70QSuewYcm10Now3pNFp61dnSVPfMah/RmQpfMvHeCeZ/kJbw3Gmxuyj57BD7bYb8zapW/YljD3ZjFOMHfnsNi1+kRwVaQuAOnZZKcLlVgvBR6NGbSnJVuVSF88K7yyKwRym/0Mxz84MmjUhxU4cCVIPtZ1ursv91zZ9yFELQ7TybsMJKA5va+h7EiAC42vpcYG0D9M+0g0NTfpWX3HeMvvSgdBQrWMDrXhCEAA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289e72db-1530-4a74-b702-08d61c4a9017
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:19.3207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
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
index ce54a70b7695..a1a928064b53 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1770,7 +1770,7 @@
 			};
 		};
=20
-		dcan1: can@481cc000 {
+		dcan1: can@4ae3c000 {
 			compatible =3D "ti,dra7-d_can";
 			ti,hwmods =3D "dcan1";
 			reg =3D <0x4ae3c000 0x2000>;
@@ -1780,7 +1780,7 @@
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

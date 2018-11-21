Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D90FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8C720989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="N4kSDmbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8C720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeKUTVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:21:43 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:29095 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeKUTVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:21:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="23076084"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Nov 2018 01:48:04 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 21 Nov 2018 01:48:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pS4qmhByiUwDkUVgLjGLnwXLsRfsxBRrJ1Q0hYkjEk=;
 b=N4kSDmbV1xcNJHCJ0vs7XtOHv71rrJYmU7iLrzhVW0Jj7Zz2yIadcqyuXBcgI8DXaVxvIjOtzEiXzSg/Q/ml/awG1perDkfrctgKsozes0662sTGasuIF3PjblpzShdeEzztr2NzRr4YlpLCl8niFn7PQV044CLVtXkdCa/W900=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0073.namprd11.prod.outlook.com (10.164.155.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Wed, 21 Nov 2018 08:48:02 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::f46d:c17e:bb65:5e0f]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::f46d:c17e:bb65:5e0f%3]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 08:48:02 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <Cristian.Birsan@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 3/3] drm/panel: simple: add support for PDA 91-00156-A0 panel
Thread-Topic: [PATCH 3/3] drm/panel: simple: add support for PDA 91-00156-A0
 panel
Thread-Index: AQHUgXbpALTSyb2E+k2kjADrWyV93Q==
Date:   Wed, 21 Nov 2018 08:48:02 +0000
Message-ID: <1542789804-4584-4-git-send-email-eugen.hristev@microchip.com>
References: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::31) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB0073;6:H7/mzWE8IlT8uBVwXM0y+nr7I6PhpvfXOkxGfEDNjHqyB1eychp+rwncIsFAX3n6RXfreVk97ie6PdrU2+i0JmdXF/GW+iPxEPEwdgRpCByxG0MUfQJMi8n4BHH1FLeHzD8AaXzfbNaIwzB9T9Zc2AKXCgrlQ6yqYAjli7obHKp9rGegQMKopW5qm8xS/Jy1YVtE5fxdXPx5x08XY2Fn1//qv6H5dVqroa7mC0mJQNd+nMqKSoCYIE5Ada7Fzu6I42Cu8X+DAqXnjl7vcm1Jr23VijXtSxfA8sK9xoLape8+4b1ourzeciZs4Stt2LdVoN0kRd2sOvYdDXhLr/XZj5cZYvY6ep4c1/o2hPXMvVP3BTdnT/xhaxabqpeLT16qplhN0L87up4h9iaWwChcFDZPm7g5DdhBXbvong1Bg6nXIHBTHKqtXj4MuIqVfvpjeoMvA3Sl1DceFGsxTFS9ZA==;5:tdXrpXSVBEVFLObhd+KMnDj74enZ1r2vbqeRUxf4LB8gKuDh43qL6pt4Hgbn06L80XuQR7nofnLpkWLGHZTme4CEwF5Cke3h9CViEli2Tz1opVx/8pGa3CfMikXMgRClr7ekd70A9VXejq4vBs9i8nXXCjCZLO+DnuTdQA9FMAk=;7:95svYdYq7Vkxshficj7y3L5xqkcpDXG2aOkG1Zita5Up0eoi06jXUiOHMbxAkKgzoh06dFdW/DPJIc9tcBCaGtkWAxcekNFfsBvxhbsIwsqauh/SVeB2A8Ba/lpKrEugVy+RSUXJZyJ/QZSr/VYh9w==
x-ms-office365-filtering-correlation-id: 85b21517-bdf1-4339-b5ec-08d64f8e0bde
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB0073;
x-ms-traffictypediagnostic: DM5PR11MB0073:
x-microsoft-antispam-prvs: <DM5PR11MB0073AD961F9F5E438DDA2013E8DA0@DM5PR11MB0073.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231442)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR11MB0073;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB0073;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(52116002)(106356001)(186003)(99286004)(5660300001)(2906002)(26005)(14454004)(7736002)(2501003)(105586002)(102836004)(386003)(6506007)(81156014)(305945005)(76176011)(8936002)(8676002)(71190400001)(71200400001)(68736007)(3846002)(256004)(66066001)(36756003)(72206003)(6116002)(2616005)(81166006)(478600001)(476003)(6512007)(2201001)(6486002)(446003)(11346002)(486006)(6436002)(107886003)(97736004)(39060400002)(4326008)(53936002)(6636002)(2900100001)(316002)(25786009)(110136005)(54906003)(86362001)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0073;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G/Trl1BP3ePM9A8ZG46rEhvAGV4co07nrq2Kxfq2DYacQJGybiE9YU4qNBNR5GiLgelhkljzEIbqMgN6PYdAxxXYA4cWs7dLplv99dU8FLmlMjGo5FColKDFDjFVj04vm8kwYdHDdLT2zg2EA//aviCAxSjGnkB4n3JJMCP3H9jouOiOfn6lRLXGIKoSmzGTHw3bfEalrS2zH6ygNXUO9tsCF8D5OYZpCgWAZHj6/hEYA+ttu1VbTF6Rah3jz09fyEJiRYA7Z3d0AdXnQ+90fMA8WKNi0jmvPoOEjaQqF0vfCkqOT4qGGWtr9FRHiEZD0TmS2Mc1IrVHl1/bFiMgZUkfavNl2HA4kEGoHZW4OYc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b21517-bdf1-4339-b5ec-08d64f8e0bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 08:48:02.4900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0073
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
AC320005-5).

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/p=
anel-simple.c
index 5fbee83..3fc9d0b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1984,6 +1984,30 @@ static const struct panel_desc ortustech_com43h4m85u=
lc =3D {
 	.bus_flags =3D DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
 };
=20
+static const struct drm_display_mode pda_91_00156_a0_mode =3D {
+	.clock =3D 33300,
+	.hdisplay =3D 800,
+	.hsync_start =3D 800 + 1,
+	.hsync_end =3D 800 + 1 + 64,
+	.htotal =3D 800 + 1 + 64 + 64,
+	.vdisplay =3D 480,
+	.vsync_start =3D 480 + 1,
+	.vsync_end =3D 480 + 1 + 23,
+	.vtotal =3D 480 + 1 + 23 + 22,
+	.vrefresh =3D 60,
+};
+
+static const struct panel_desc pda_91_00156_a0  =3D {
+	.modes =3D &pda_91_00156_a0_mode,
+	.num_modes =3D 1,
+	.size =3D {
+		.width =3D 152,
+		.height =3D 91,
+	},
+	.bus_format =3D MEDIA_BUS_FMT_RGB888_1X24,
+};
+
+
 static const struct drm_display_mode qd43003c0_40_mode =3D {
 	.clock =3D 9000,
 	.hdisplay =3D 480,
@@ -2659,6 +2683,9 @@ static const struct of_device_id platform_of_match[] =
=3D {
 		.compatible =3D "ortustech,com43h4m85ulc",
 		.data =3D &ortustech_com43h4m85ulc,
 	}, {
+		.compatible =3D "pda,91-00156-a0",
+		.data =3D &pda_91_00156_a0,
+	}, {
 		.compatible =3D "qiaodian,qd43003c0-40",
 		.data =3D &qd43003c0_40,
 	}, {
--=20
2.7.4


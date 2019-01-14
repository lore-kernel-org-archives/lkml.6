Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD278C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724A22086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BCznmam7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfANJnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:43:35 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:23258 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfANJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:43:34 -0500
X-IronPort-AV: E=Sophos;i="5.56,477,1539673200"; 
   d="scan'208";a="23351907"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jan 2019 02:43:34 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 14 Jan 2019 02:43:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjUC0Fh1aTOCEeAS0jT8fqnNFXHs4D1KCmlpqeO7WFM=;
 b=BCznmam7bzc1HLLJDc8iz2z07/6oSUQsCmEIT78qd7kFV70cajNAsTPd1XBvSWO0XCP0jbyOm0WEBi8kEjvluY7uDqBBttyIoQVfCuPDiQA6SrfNCFI9mzVCv+Pg1h36BM+9GlJFCUA2V/TWT64AiM16GdxRbF5oENryUR4bpP0=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1675.namprd11.prod.outlook.com (10.172.38.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 09:43:31 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::4c19:f788:c2be:5e8f]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::4c19:f788:c2be:5e8f%4]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 09:43:31 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <Eugen.Hristev@microchip.com>, <Cristian.Birsan@microchip.com>
Subject: [PATCH v2 3/3] drm/panel: simple: add support for PDA 91-00156-A0
 panel
Thread-Topic: [PATCH v2 3/3] drm/panel: simple: add support for PDA
 91-00156-A0 panel
Thread-Index: AQHUq+2crybztxbQ+0Gujmye0E0iaQ==
Date:   Mon, 14 Jan 2019 09:43:31 +0000
Message-ID: <1547458584-29548-4-git-send-email-eugen.hristev@microchip.com>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::30) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1675;6:hSZzOwRW2ejxCCUjw/vtcTjeHtd+CNOFy++iBg5yWlEkzYKXAixPSclREKU83aN+fNLldU/dJw4gAOdtWr7B2juNksD/bLaGQu1XyzF+uCe3APSGUbRRgw8oUx3ViYNuo5M9zwVhrljh9Q/ko6PW7qyajwEBCd9dsNLM2FE3rJ6WbIIfWiTc3zpXoOlCoVLBTPBx4o4N9vTANPcYOvF/BcyixngmSgvKVxH1oLoPRk3cBKXK9fU4JAMr7mQ+todPk9tlLLc+kK8cIsIa84OIlf4PwrmFWm2iJp5JzGh+HE4oYECID9F5uy0VWuKXwOPSbUCySFtRUoP4NwK8wXQQa2+SXz1amWg2jg+TQcTCwNHlhXMztyTAAs+w+vqnGdmiaENckeJeeDxrg4dmX9+Djwzuo2g7p7+ebH/J3DmlwH5Zk6BOh9MKCsMkOOMBiZfuU17YOmw/zIggUswc5BSoTg==;5:DNpxx6KdG/yziqNQp7R08XQjX5L7hNNL8tio6I6eOyf4SKrDhBX69sLLZRpmhQwSZacKA70uEcauHxpCDyRNRjCKsyI9NkCS/CthjEhJrpNrPpNat9zIQ+bmamuFfby6qPf1OmOQVHbX7CLI8gEcu8bfaAcRE63caRqUZLAYVzxWO8v/JxgyZuWqFP9Kg79PmmB7Z3NPtjH29wtOieaK1g==;7:WFZFd0PYZMQVvQpC+TA0uhEQD/sMj7dKWLJ/dveWs35JPkav4q2hw/lVjdJI+hqZ7Lj4Tkzb/QYvtQSFMsUXYO7jRScRR5FW+N7vryDzEo78OpxiU+gXIT+xS75idWzc1iAjcRT3NS6OAHUgxAwwpA==
x-ms-office365-filtering-correlation-id: 57f5b18f-34c0-4565-c068-08d67a04be9c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1675;
x-ms-traffictypediagnostic: DM5PR11MB1675:
x-microsoft-antispam-prvs: <DM5PR11MB16751306F622A7BBDD0BA3B3E8800@DM5PR11MB1675.namprd11.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(6436002)(316002)(2616005)(186003)(54906003)(6512007)(476003)(6486002)(110136005)(76176011)(2501003)(99286004)(71200400001)(71190400001)(6636002)(6506007)(386003)(102836004)(107886003)(26005)(68736007)(478600001)(446003)(72206003)(86362001)(66066001)(8676002)(39060400002)(106356001)(36756003)(25786009)(486006)(105586002)(3846002)(2906002)(14454004)(4326008)(53936002)(52116002)(81166006)(2201001)(8936002)(5660300001)(6116002)(7736002)(11346002)(97736004)(81156014)(256004)(305945005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1675;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vfEVuE53KWnjkNxjcluhtWeRgXAhgqQZvilCL6upmCHuLg+ySJFTJVu6VY8ZRtyuF8W55Vjua05ihaq4ediYifPVWQMhbEvjxhWxhxAY8cAAM5gOHrj8ehj6cJY2wNyHZeN1cTRnapRzNoPa8bur9unzwMUFUjAB7CPpAAwQaRaaJwvlOlIW0t4dFSs7swCK8uBd0TkJgFtb23b4nISK735dMwqALWTJbklaCrwv0Ft0DwQbW0D1Z/hayMnLq4j0Z6rzy4nS/d3cVE/zAu5qJCEZrWb/EUp14SyheY/HmtMWUo3qs3o8iTV4kouji+lKPtq4eXZrxeUdvdG98YPulwgHrsvwwXCo/3Ew59nl1bFqks5QBqUSOh6Q1K2chRM0ADwdrXqi5B+ofl5mknSGgBpM1eA3jkb3KrSHHWH/QqQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f5b18f-34c0-4565-c068-08d67a04be9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 09:43:31.8093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1675
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
AC320005-5).

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/p=
anel-simple.c
index 9c69e73..61361ba 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2008,6 +2008,30 @@ static const struct panel_desc ortustech_com43h4m85u=
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
@@ -2686,6 +2710,9 @@ static const struct of_device_id platform_of_match[] =
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


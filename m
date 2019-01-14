Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8FAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0266A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="DFW68Ijq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfANJne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:43:34 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61568 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfANJnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:43:32 -0500
X-IronPort-AV: E=Sophos;i="5.56,477,1539673200"; 
   d="scan'208";a="22561371"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jan 2019 02:43:31 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 14 Jan 2019 02:43:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcMLGvj0rR/QJUHh4lbyHGY6+nlKkwsUgdh8tXoLhWY=;
 b=DFW68IjqPx/vhqU0tL2mdoLPDf/Wmxnz8g7nwusIchNRVQWoDb59VLCazwJOM7M1vZh/HQAVTimNAcMbmChLq9YTXJhTywqrFWbZZ4eb2dycwKJx0m3e2szvgkPc1QGkjB5wNuNxnqUjyEq8AoNprz8IVhDiiWNC/Rr+jQnaipc=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1675.namprd11.prod.outlook.com (10.172.38.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 09:43:29 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::4c19:f788:c2be:5e8f]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::4c19:f788:c2be:5e8f%4]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 09:43:29 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <Eugen.Hristev@microchip.com>, <Cristian.Birsan@microchip.com>
Subject: [PATCH v2 2/3] dt-bindings: drm/panel: simple: add support for PDA
 91-00156-A0
Thread-Topic: [PATCH v2 2/3] dt-bindings: drm/panel: simple: add support for
 PDA 91-00156-A0
Thread-Index: AQHUq+2a2UkmhGmZaEW5NwjqBZObcQ==
Date:   Mon, 14 Jan 2019 09:43:28 +0000
Message-ID: <1547458584-29548-3-git-send-email-eugen.hristev@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1675;6:psh9WGrhO/Rp74E55HZTnUbIx0F4m8InsuzhnXTaa4JtiwGW4Ni1d5RY9edHyH0YMLGgv5AZbGRTfE/X/zaY9ynk4dep/ty4i6/u1kWbVdhHVOUJrYHD3nPvcjhd1FiSsSJRDdD7c/5SG44M6n6bqNFErZuIJc9OSSkMAkElSYoOwzkLLBW48HO7sJV6pCGdN3F0rnVosHuJFlZYoKOfjtN/5yDS+JLS7yLGbvK3ZnbuNLvLDDWxP0Nb8A0xHSvgMTe33dSikSmTLWGuMz3oHyI72XIfyxOl0w3Od22zKt6WqjhElD6NmESA5iqnN6V+Y2zIu0bc2eoAtpa2amfBds4EK/fDq2X96odAHmse/QzaDAQYjdzQkvJrmuhk37XNiXPc0IrdZSTxUX2tD9WPdMrt1GJq+JwNI3ojTu4hha5Zpdk9A+jDTWzq+tjpfOPOQugcMVyLh5gLJzaQCqL6wg==;5:e8X7dMipW+klcoU/t505kVNsVYy5gY23x1BgCrAyP7P2byRWkIyamIF2iudGnJt+WfKPfZA4IUUw9/9vdpoJcrD1bQLHklafe3OGfuC92UQuF3YyEJ2SQQ6ns0h8q3xaZPHCM7wEJ7Cnez0YMghKtsrznuTjaMj+R40ogQRg98vyz6+7nehRlBUyielIS1AKlSOj8ljsXwScgsz+hp7MzQ==;7:OsSPK5M/mGai9lpisv6Hx6ZWytpw9WVZjbnPEJrMOdvJ1CA9qI1EWwYBvbHI79hXh1GVHE2bFGW/VD8X5yk4NRowXf0d/BksDMTj0BuC5n1QHiQqpVXUgs0Dc7nsYK/FyaYtCMb/b0SiCk1MhCMLvg==
x-ms-office365-filtering-correlation-id: dc968365-8f48-41d0-99a4-08d67a04bcef
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1675;
x-ms-traffictypediagnostic: DM5PR11MB1675:
x-microsoft-antispam-prvs: <DM5PR11MB1675CBF3B986506E28A51907E8800@DM5PR11MB1675.namprd11.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(6436002)(316002)(2616005)(186003)(54906003)(6512007)(476003)(6486002)(110136005)(76176011)(2501003)(99286004)(71200400001)(71190400001)(6636002)(6506007)(386003)(102836004)(107886003)(26005)(68736007)(478600001)(446003)(72206003)(86362001)(66066001)(8676002)(39060400002)(106356001)(36756003)(25786009)(486006)(105586002)(3846002)(2906002)(14454004)(4326008)(53936002)(52116002)(81166006)(2201001)(8936002)(5660300001)(6116002)(7736002)(11346002)(97736004)(81156014)(256004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1675;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Pafc/Rrp+kgY6jay2GrgOggSUHmDUnnPOU1mvvAgsnTPI+7g9ztC8W/QGa4WiIyCWKkObgPTg4yzKKbLqoq4bhFFLKhWKbeDCSPkxoJ+hH9VGSitvu5J1gMova+t5hGXk0swmptT33A8rkdggMJQ2Qe1Ci9f9T2I6Q5ddMD+60wjg/xMYZrbqA8kknO0kszry61N3HmV0G4cJ/G6ew+qSLzHE1Eb5j9uyTiwDzmKWXkySqOHoOB40+NVXEUAyE6jGSOnGlSg+GtVYJfwxayPrqVd2Ryy7jybUsGpVAzRJfcS52ZAfsHfc/LKZyZfXWl4z75mY4944/Gc7n2hlQE7iYK/cmrsLXTvEA021c35gYIBN/PlVSemtuRGXAtZIL9zQlY913V9P8Uj18QVYdCazgYoE8jovx/cax/inkrmEA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dc968365-8f48-41d0-99a4-08d67a04bcef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 09:43:28.9812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1675
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
AC320005-5).
Adding Device Tree bindings for this panel.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
[eugen.hristev@microchip.com]: specified backlight and supply bindings
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
- added binding explanations for required properties from simple-panel:
backlight and power supply which are mandatory

 .../devicetree/bindings/display/panel/pda,91-00156-a0.txt  | 14 ++++++++++=
++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-=
00156-a0.txt

diff --git a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a=
0.txt b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
new file mode 100644
index 0000000..1639fb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
@@ -0,0 +1,14 @@
+PDA 91-00156-A0 5.0" WVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "pda,91-00156-a0"
+- power-supply: this panel requires a single power supply. A phandle to a
+regulator needs to be specified here. Compatible with panel-common binding=
 which
+is specified in the panel-common.txt in this directory.
+- backlight: this panel's backlight is controlled by an external backlight
+controller. A phandle to this controller needs to be specified here.
+Compatible with panel-common binding which is specified in the panel-commo=
n.txt
+in this directory.
+
+This binding is compatible with the simple-panel binding, which is specifi=
ed
+in simple-panel.txt in this directory.
--=20
2.7.4


Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9396CC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EAF222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wL6MnWYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbfBMJAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:00:05 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:5401 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390985AbfBMI77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:59:59 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="26652873"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 13 Feb 2019 01:59:58 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 01:59:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IZWL4twTy2xYkCdFqjyhzDlNJ6FSCI+6LfgKdArK4w=;
 b=wL6MnWYRPqK9ezSCpFGgoZrz0rJ3SnSjQCMpio7UQDIQ9T2ChKaywMDT1Bjv7htitfrEdtXyrKpkjitu40lwGjYoTS1bWpDxh7F3j2dyg0U7Eg6N44f0x6eC71tpnDBoicRLsR+kfYLsg8pspqsO+VFBjP5t8/bzE21s1lWWgVQ=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:59:55 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:59:55 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 04/11] memory: atmel-ebi: add sam9x60 EBI support
Thread-Topic: [PATCH 04/11] memory: atmel-ebi: add sam9x60 EBI support
Thread-Index: AQHUw3p9sN/CdCNCukG8e/clx2Pbpg==
Date:   Wed, 13 Feb 2019 08:59:55 +0000
Message-ID: <20190213085930.31578-5-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82e1e00d-b7a4-4fba-d9c6-08d691919f74
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN6PR11MB0019;23:Rp5bUThHXzXSIrVmUVgFt9w9riOtQlTPe+1cABj?=
 =?iso-8859-1?Q?LadCoEs+h/BUvwWhMCPiiTthqL7Ydp4fh7pu/ARcnWhYHBqvSIo8OX9Z+/?=
 =?iso-8859-1?Q?UkD17JqwHS10HTcsoqMkz1/7ANu7YMlBKrbVsSLEBdF5AK6IAky7eYRm1x?=
 =?iso-8859-1?Q?EOzfojs1NC+0Oa1nr7eZanHSE2h+3BoRQjqKY99XAf4HZdBeAzJQRg/2NK?=
 =?iso-8859-1?Q?LQB6dmsLqo+d91Ond98pjvJTDC+vKOPiFV12e8Jv3TVRbWGgkzrEhaeEVg?=
 =?iso-8859-1?Q?N0gGkjeQTfgRkrpC/1AFl9YNr1YUb22kDAOEkjSYDBD818KShO2zRGtz0r?=
 =?iso-8859-1?Q?dKj3TVgHgbhPUg62fqw1Hn6e1wZqpxOOHs05seqMUqLBhpUG5fPDyYjEIq?=
 =?iso-8859-1?Q?FHcFUmBg74XOiPInQZcOLv2cIGqZUZiX2BT1+hk5NviX2jcZsofTzVsksI?=
 =?iso-8859-1?Q?VlM0GiRPkPsFhhsKdfFmpprqrrk4j0e3UL3zBPCSl8XToylF8Ze0I4rPF2?=
 =?iso-8859-1?Q?dRnWod3HprgKy8X+d+ZFY3KBauenod6k9TaN0Ua901zdcAmhHA/SoJnXDr?=
 =?iso-8859-1?Q?WMskDy/jb0Pjm7Egn3TD6HKVs6ZxeYEVk27zckd91watJI5fvdAIxpksH3?=
 =?iso-8859-1?Q?1KCd7LMBQ0ApRZxnNibD7q2nO39xiSHCPrDqgzdY15a1cUmvyckUPeNL62?=
 =?iso-8859-1?Q?WLJILBxFJdnW0TIFSMFRA3THL50jG1aeNexVOpPZbTTl6KOPpKcluF2wf+?=
 =?iso-8859-1?Q?GbN1mf/PjZGMOUtjwxIoC9jfuh0FpNcb/TGIug4CLe5ZtDM1WvcPHbAbZO?=
 =?iso-8859-1?Q?+IdmlYLSa9EqGLmYgVuFowVELVvWOEWSdEs8Mi7FuMXQvt3jtV7GHwSS44?=
 =?iso-8859-1?Q?nrTFB2pzq9MuUoKDb/xj1Q33QUt3/m4fkHhwgiQbN8oZUvLIZoZ3RKBfWg?=
 =?iso-8859-1?Q?vfZKTDjksZWHHAN5+okFLhK7ORjjCpG3OLKxeoPwrvAr9AWcP5R4cQlVTc?=
 =?iso-8859-1?Q?q04o/WHuGieS6jeCYfB03hs3g/A9VTQTSYgvsk2C2T3M1Cbh6moXOVnCz3?=
 =?iso-8859-1?Q?d4kppzv0XLxFroEzP1PRZz15lDflzbwZDEvPvL+M2mKhIkKTyAGBZhABzH?=
 =?iso-8859-1?Q?tDC3wYG3bOuDA7xrpAcEr2fWz/4Q7uaCPOqiQRDs+1UEzS0uxUiYgUgYo+?=
 =?iso-8859-1?Q?zk/rACzhwRUgYHsL34pzVt3kfnGOuzIOSkCt5ZE0zH8raLlUxflL85yuCE?=
 =?iso-8859-1?Q?JDbVvg2bkGMm3YbVDOhJ3JLWhShOh0AmzMcZ4O63+dBuqXy1EF0HV+0yU7?=
 =?iso-8859-1?Q?YzQfaPhJyuDUyvtssVRZ2ESPfXA7E1nlNFucCuUmIKxnp8tsGMLm1UPl3W?=
 =?iso-8859-1?Q?a6g8k4X4=3D?=
x-microsoft-antispam-prvs: <BN6PR11MB00194E87B3261799CECADE96F0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(446003)(2616005)(316002)(8676002)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(11346002)(86362001)(2906002)(72206003)(71190400001)(14454004)(76176011)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(7736002)(305945005)(256004)(25786009)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Trk2sF0bZ66Sgm/DE4ITvUcPYoxWZ16Jt+zqOXMs2icmUQW73yThGnQgnLUS5la3u2bacTCX9/XgUSu1KbJobYC5pHXjsAgysl7w971WcnU3TuXJvePzwpZZ3NMRpFmyvlEHyuRSF8kqLADMDzU7xNwiXoSV+DjJJLOOUKSLj7+LI6ydhAvp2cAH7dsjM2fhJfzRgvlDsxe8AQzXvcm8R/2b5gpfuLnJ67//xF+O4CE2RtiOfhC1FWOgtIKapxkIwGWw+64SmO016NlLH1dm7/cQDlCIxXgHi/bKajo6cxkBU4UuRQElOLmldQpxm78mRpzyBgkQ1y+MgVzc87zuwGH407K0aEk1F6Hdh2viwX7Co7cAYE5LTwTON9SrLuroyiHBHxbu0Tc4IQwhsvTAor43ewUUhtM3oQ/QogqCKs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e1e00d-b7a4-4fba-d9c6-08d691919f74
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:59:52.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 board defines the CCFG_EBICSA register under SFR,
and not as a MATRIX register, as previous boards do.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/memory/atmel-ebi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index b45914cfa212..0322df9dc249 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <soc/at91/atmel-sfr.h>
=20
 struct atmel_ebi_dev_config {
 	int cs;
@@ -440,6 +441,15 @@ static const struct atmel_ebi_caps sama5d3_ebi_caps =
=3D {
 	.apply_config =3D sama5_ebi_apply_config,
 };
=20
+static const struct atmel_ebi_caps sam9x60_ebi_caps =3D {
+	.available_cs =3D 0x3f,
+	.ebi_csa_offs =3D AT91_SFR_CCFG_EBICSA,
+	.regmap_name =3D "microchip,sfr",
+	.get_config =3D at91sam9_ebi_get_config,
+	.xlate_config =3D atmel_ebi_xslate_smc_config,
+	.apply_config =3D at91sam9_ebi_apply_config,
+};
+
 static const struct of_device_id atmel_ebi_id_table[] =3D {
 	{
 		.compatible =3D "atmel,at91sam9260-ebi",
@@ -473,6 +483,10 @@ static const struct of_device_id atmel_ebi_id_table[] =
=3D {
 		.compatible =3D "atmel,sama5d3-ebi",
 		.data =3D &sama5d3_ebi_caps,
 	},
+	{
+		.compatible =3D "microchip,sam9x60-ebi",
+		.data =3D &sam9x60_ebi_caps,
+	},
 	{ /* sentinel */ }
 };
=20
--=20
2.9.5


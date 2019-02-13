Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2D9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68B7222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tzpS4sph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391053AbfBMJAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:00:13 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:53899 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391037AbfBMJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:00:12 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="27631565"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2019 02:00:11 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 02:00:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po1+Rmo5LsZDDrBE5/UwLhyrYNZ5bKrwc0UeryHkhKc=;
 b=tzpS4sphTe/yuaYrJzwtXx26up8AR5+/neND2R8n+Z3f7ClffCzlVxH5Ur9N68kPqyEQ+/ONTtnmgEB6QGHrAKra/vNtWdX9NB5mHW4vBqRBXQYPuo0hhhd3r2oXd/fXERoBcp5qIyOw6j4MnRBCl4t5hRlcJGkpWHd2Y9gQtSc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 09:00:08 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 09:00:08 +0000
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
Subject: [PATCH 08/11] memory: atmel-ebi: move NUM_CS definition inside
 atmel-ebi
Thread-Topic: [PATCH 08/11] memory: atmel-ebi: move NUM_CS definition inside
 atmel-ebi
Thread-Index: AQHUw3qEx2ObER7HjEmtDvVIpHB7CA==
Date:   Wed, 13 Feb 2019 09:00:08 +0000
Message-ID: <20190213085930.31578-9-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 5654c66d-a890-4576-81b6-08d69191a70d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN6PR11MB0019;23:sGyCwV0KwoWFOe1noLaeSKHx3VJJZuVelVdAWCI?=
 =?iso-8859-1?Q?DsHT9JJ49WZUWCxL58VVbZP5c/3OquYpiRZ8dDpZJiLTLO0jMG7hZMAyvE?=
 =?iso-8859-1?Q?lPokPyqa3DbsKCM2fv3DJrbjIwPGiOXn4vNOdM+0LWtxsQYbL1dIehFWJ0?=
 =?iso-8859-1?Q?0zmbEMiuhAF4tLR0aeyMoIpki1G4XlOr7dQ47E8quvW8V6uCcUadPj5QFO?=
 =?iso-8859-1?Q?U5PwNlKaFE8nu9kaMGHW6IeWLextbnbwNvvQxKjUFknMk95Jt5zxWh4YMo?=
 =?iso-8859-1?Q?k21lsugDYWEcG1YSEWaHoMjeHYVljtsQDsexjvENwdG/VOSVmPYX3ZdQs8?=
 =?iso-8859-1?Q?bf0dHbTNkZ/ONxLtS6hGOZfCzAW9wOcMyvNcl82zZzJ7qbPs8UntH+KY39?=
 =?iso-8859-1?Q?tjaupI3MrK6dcwdciD7t2aSryDg5PXFwtzDY0rl7tVcAVw5Y4atGN3sgwf?=
 =?iso-8859-1?Q?N7DFSTk8rmc6PpbS+Th08QUK74QB/3Os6OJ8F/VdoBQlf5cWNVCKM5pV89?=
 =?iso-8859-1?Q?VU9ErO3EravesA1wJUrnpuMBfgpSAjiHjSInldBDRR3DCPr7b0uIY3tQb7?=
 =?iso-8859-1?Q?BiS2fyvA6Np0JQpi3pPCnQ9iVqMltp1Pkyiy6spuKx35ObkCZtGeadHn/s?=
 =?iso-8859-1?Q?yssLfz3qujl3Q10GbJEV3odpNbxhrsQVN9+rp1IAZUXXUbSyfkTcYL17mF?=
 =?iso-8859-1?Q?2q9cOVhtC0GLNpMPHJWfP4hyKqofsjNBnfqv22HaMdaSVVSU1jSfRZKlHn?=
 =?iso-8859-1?Q?xTIRwly/RKNgqC6ygE23xV7zi2V7QFJjsA/2jRJM5tURsxwcQqhLxVj73V?=
 =?iso-8859-1?Q?bJmKYHtb6IKWrsaWLD3oTK8EnTzppEEEnOAoZMkcrGljLRGbIhNOY23aHx?=
 =?iso-8859-1?Q?JhlHaHEaWuP2mH2orI0t6eIG2eEugAKXBr3A/gcdCAt/X1RqLTGIt5UNuP?=
 =?iso-8859-1?Q?xDK30DISxRAHNcQAKrppSJK8UghHHm/524HLYk/r7/oGICoQjetrTUibVu?=
 =?iso-8859-1?Q?J+wxeQlHhNCsHzt2mrt2vwPDiJ1zR0u5AytXtbbK4XAM/t0CX2m7F/X//i?=
 =?iso-8859-1?Q?Wjk3Ft5fEAVesoTS7LGJXW0FEiwEgqnjgU4vyXSt3fNGWJsUIYPfUwUAEV?=
 =?iso-8859-1?Q?g3JbCte8qVNCuXsLoq7FZu2C4eu1OVeKjHcqvDFJOHn9at5jEafcJHQZt/?=
 =?iso-8859-1?Q?lm9eyAPv5LFgC0Vw8wTuH62O7iX1G8FATXsRHBdSCGNcGrAbz/NP5ilzDB?=
 =?iso-8859-1?Q?8XKyOZrDChAungPZCsvXWCijb6AGwISgG1n3OMNHf1GQNojn3XQW44RBah?=
 =?iso-8859-1?Q?dSBOyOMMjXIwFHKzu8Hbzux4WV3mZ4X4VQvxTi6tEsnZphAsCGkHbmz5wM?=
 =?iso-8859-1?Q?IAb7Y4SA=3D?=
x-microsoft-antispam-prvs: <BN6PR11MB0019C9DAEB4832FAB739E39EF0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(446003)(2616005)(316002)(8676002)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(11346002)(86362001)(2906002)(72206003)(71190400001)(14454004)(76176011)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(7736002)(305945005)(256004)(25786009)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Piq9LueXa1PTnTLYJnrjhst3fRxPYJRunDW7lneP6XDCR4pvwt94iHa++vwpjBJuUGOZBgDPTa64Vjza13APR6KIMtKiBUOPJsby+UfzKp+WRjLE2U5PcZiC55ZPCnwA3C7fh/TCS0LU+O3l5A6gyaoV3LYWYUtkSb3a+dPkPkCd/bGoI9aCS7g+Hj47PRp2M5xVvRBl1KhDJANopJDUIMcaErkSimuGhyV7/td9TxR0FMEAsG5+b527SXyvAOiE+VPmIM76hC7XihOwxs7yECJ8GDddQHqk+IhPlx7XsLyEJZXHjXixZe5oK3kMf7IkVhz2CXHv0deXCyfDZvw8AeZxEYL+OUuP9fOYxC9H3o7aY8YiZIQZljJJS8nemILnFN61FnlfBc7UEWTEiAJGwCwzksc5s89E0j2AUANhxy4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5654c66d-a890-4576-81b6-08d69191a70d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 09:00:05.3779
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

The total number of cs lines is described by the EBI controller
and not by the matrix. Move the definition for the number of cs
inside ebi driver. Drop "matrix" from its name.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/memory/atmel-ebi.c              | 6 ++++--
 include/linux/mfd/syscon/atmel-matrix.h | 1 -
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 0322df9dc249..8515196c2b03 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -19,6 +19,8 @@
 #include <linux/regmap.h>
 #include <soc/at91/atmel-sfr.h>
=20
+#define AT91_EBI_NUM_CS		8
+
 struct atmel_ebi_dev_config {
 	int cs;
 	struct atmel_smc_cs_conf smcconf;
@@ -314,7 +316,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, s=
truct device_node *np,
 		if (ret)
 			return ret;
=20
-		if (cs >=3D AT91_MATRIX_EBI_NUM_CS ||
+		if (cs >=3D AT91_EBI_NUM_CS ||
 		    !(ebi->caps->available_cs & BIT(cs))) {
 			dev_err(dev, "invalid reg property in %pOF\n", np);
 			return -EINVAL;
@@ -344,7 +346,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, s=
truct device_node *np,
 		apply =3D true;
=20
 	i =3D 0;
-	for_each_set_bit(cs, &cslines, AT91_MATRIX_EBI_NUM_CS) {
+	for_each_set_bit(cs, &cslines, AT91_EBI_NUM_CS) {
 		ebid->configs[i].cs =3D cs;
=20
 		if (apply) {
diff --git a/include/linux/mfd/syscon/atmel-matrix.h b/include/linux/mfd/sy=
scon/atmel-matrix.h
index 8293c3e2a82a..1e2cd118e4e3 100644
--- a/include/linux/mfd/syscon/atmel-matrix.h
+++ b/include/linux/mfd/syscon/atmel-matrix.h
@@ -110,7 +110,6 @@
 #define AT91_MATRIX_DDR_IOSR			BIT(18)
 #define AT91_MATRIX_NFD0_SELECT			BIT(24)
 #define AT91_MATRIX_DDR_MP_EN			BIT(25)
-#define AT91_MATRIX_EBI_NUM_CS			8
=20
 #define AT91_MATRIX_USBPUCR_PUON		BIT(30)
=20
--=20
2.9.5


Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F37EECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DDE21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XS2Q7usA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DDE21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbeITI3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:37 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:3328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387959AbeITI3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTfPJ+9DjgZrRPm/px84tuQs6SJO1aLQKmkj5ZmafxI=;
 b=XS2Q7usAPyx9s66VVYM0ghQBYUnnCgf8G4Qj4kWuek1/EQiV64/zUrrcda3icgXLLPA3SiFapDDuLx6t3Asf+9YofsQ2NYzq7/Kh9/S8FIxmdOQnZPzN4iZmrzsIfRV2UYSNPr0qrsFWJJEZ8cv79FwCmo4jOgA0VRuxe9YfVTM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 48/56] ata: ftide010: Add a quirk for SQ201
Thread-Topic: [PATCH AUTOSEL 4.18 48/56] ata: ftide010: Add a quirk for SQ201
Thread-Index: AQHUUIxYXlZob3ldCEy5ELn5/3KDKQ==
Date:   Thu, 20 Sep 2018 02:48:01 +0000
Message-ID: <20180920024716.58490-48-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:1oz8Up6hdoqNRijcEq4sr7GA4+gjaiZKMY+DEshq3WniH+f6UmJ9rYsZg2jmX69uffnKSuddNhsq4hbBNtq3eU7zRPfhIZ3TZ7sc8jl9yXW8zDHwjB4Lg90/Ce1LpHPYB8RJzGIad/jjGpn0DTxW7C3YGC41Ahk0CDBZYYA+tgpXlY1YRVgqiY75dT100mavpEQHnEPDjikSZ25Eh4q/U7cX1Tz5w/+nJZD/QmLHeN6L02DoCPcbwEknf6zkvF7kCC3L9IPL+pJusQj7OGRtyhxMjK8izhXpvaO/STPR0PcY8wUA3HoC2ccJeTFEPp/lv3eDqCnb/PywR6Lo3MuSCEOPl0LXmgWYyxGAOGvlKUAHc3tgAj5kNrfHyuWTGlmIk6MeRhcI3ElHOww7BgUvUhSW4V0N41RpDWnbZOz9jmafMafGL+SmqhH5s2nkR+vh2cHqSImhhYQBqX+nV6nQvw==;5:SQs6kJdVW4N9LTTKnDhwD9AbPjYjZOnXsO5B+ewVzdLeZamDEmDTGXLQ8AFFM4kglpKqrL2FIIKjSoWdv0VRnrNNFIifxZfBktOCPMsaVaAIuKS+zLBju0lAcufqJYPh4SbP6qjBUmmVRljX1nduApYgaPp51wZE2tmLnCGn8dk=;7:UkdcbIT4HbU2foU0xNq9pyfC0cJf73/Fl7hSloggtJm6Nv+Kkq4eae0SO0lOpFQmnc4tynqA8fCIAndG922H8/PO60ZUwPiH3S2xfapbiEEt7kce5p1DesZZaUGmlVrI5eYok9ZGxsnLYFEgPX2A7CTHit+JyOp6+K/9UjjFiXbYQyd5UK6kWjz5/pz8AaWmeIH56AIpNX4byb+L1NdlOglQ8iH2kCUehXRNPSrSSZ8bMbMI/fCeUz0GAPiKYuum
x-ms-office365-filtering-correlation-id: 1670defe-44fd-45ca-9ca3-08d61ea38b64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011997F4C8123582EA6021BAFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(12401385986421)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(2280148)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(575784001)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006)(60540400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WFZT74e0XSqU+3pdvmk0g5n++IDZMpclAJF2jXA/e5gUtaj991Ati11gKVYj+hfq22Xy4XjPWcdVTQdGs4G9GVUHGBr87nBLbs3I1hpSscy5CNfLL8La+MB4zIEw+YZ7fcNcwIvfLc5G7DyRPjjNc3fWmeIKEgIFkIzqMSy9z+WWEC113Oht5FvN4mA0Mj5RBawj8WOte25p1a2zxApR1x4DK512ui+hDBU9wZbPP35g7K0+ZJPx7O0wSoQ206ok3ZInlIWZzuD79NC4Qm+bJxhFEbgplKybwsQPVDlCk8pSd/uVhREFsvDbirxL6lxhFPrAIdblkVNDAYZG/YIytbA1KJIyw1/ncHFGO918IgwPZNZWK8rae+Ffp9KRAXrsH2c4vrRxEZNgTLWSc+tGk1Tmfk19FDf6SqubbGpUEO5k59WRflkdoCFB9Fq4Ip3AUF/H97KZE44Qi102qHr/9fbcFBhiCvFj+6vn2+JKaMDs7cI2HZyrEMOu7WdI1zD9sQ80/JqdHE+acWaNpGhRrFmVgQvRbyF029e7xDsQqEanLJ3mp134rHaTdlL9fCSY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1670defe-44fd-45ca-9ca3-08d61ea38b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:01.6636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 46cb52ad414ac829680d0bb8cc7090ac2b577ca7 ]

The DMA is broken on this specific device for some unknown
reason (probably badly designed or plain broken interface
electronics) and will only work with PIO. Other users of
the same hardware does not have this problem.

Add a specific quirk so that this Gemini device gets
DMA turned off. Also fix up some code around passing the
port information around in probe while we're at it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ata/pata_ftide010.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 5d4b72e21161..569a4a662dcd 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -256,14 +256,12 @@ static struct ata_port_operations pata_ftide010_port_=
ops =3D {
 	.qc_issue	=3D ftide010_qc_issue,
 };
=20
-static struct ata_port_info ftide010_port_info[] =3D {
-	{
-		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.mwdma_mask	=3D ATA_MWDMA2,
-		.udma_mask	=3D ATA_UDMA6,
-		.pio_mask	=3D ATA_PIO4,
-		.port_ops	=3D &pata_ftide010_port_ops,
-	},
+static struct ata_port_info ftide010_port_info =3D {
+	.flags		=3D ATA_FLAG_SLAVE_POSS,
+	.mwdma_mask	=3D ATA_MWDMA2,
+	.udma_mask	=3D ATA_UDMA6,
+	.pio_mask	=3D ATA_PIO4,
+	.port_ops	=3D &pata_ftide010_port_ops,
 };
=20
 #if IS_ENABLED(CONFIG_SATA_GEMINI)
@@ -349,6 +347,7 @@ static int pata_ftide010_gemini_cable_detect(struct ata=
_port *ap)
 }
=20
 static int pata_ftide010_gemini_init(struct ftide010 *ftide,
+				     struct ata_port_info *pi,
 				     bool is_ata1)
 {
 	struct device *dev =3D ftide->dev;
@@ -373,7 +372,13 @@ static int pata_ftide010_gemini_init(struct ftide010 *=
ftide,
=20
 	/* Flag port as SATA-capable */
 	if (gemini_sata_bridge_enabled(sg, is_ata1))
-		ftide010_port_info[0].flags |=3D ATA_FLAG_SATA;
+		pi->flags |=3D ATA_FLAG_SATA;
+
+	/* This device has broken DMA, only PIO works */
+	if (of_machine_is_compatible("itian,sq201")) {
+		pi->mwdma_mask =3D 0;
+		pi->udma_mask =3D 0;
+	}
=20
 	/*
 	 * We assume that a simple 40-wire cable is used in the PATA mode.
@@ -435,6 +440,7 @@ static int pata_ftide010_gemini_init(struct ftide010 *f=
tide,
 }
 #else
 static int pata_ftide010_gemini_init(struct ftide010 *ftide,
+				     struct ata_port_info *pi,
 				     bool is_ata1)
 {
 	return -ENOTSUPP;
@@ -446,7 +452,7 @@ static int pata_ftide010_probe(struct platform_device *=
pdev)
 {
 	struct device *dev =3D &pdev->dev;
 	struct device_node *np =3D dev->of_node;
-	const struct ata_port_info pi =3D ftide010_port_info[0];
+	struct ata_port_info pi =3D ftide010_port_info;
 	const struct ata_port_info *ppi[] =3D { &pi, NULL };
 	struct ftide010 *ftide;
 	struct resource *res;
@@ -490,6 +496,7 @@ static int pata_ftide010_probe(struct platform_device *=
pdev)
 		 * are ATA0. This will also set up the cable types.
 		 */
 		ret =3D pata_ftide010_gemini_init(ftide,
+				&pi,
 				(res->start =3D=3D 0x63400000));
 		if (ret)
 			goto err_dis_clk;
--=20
2.17.1

Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A8DECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D5421521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DzEpQTWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D5421521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbeITIa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:28 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388232AbeITIa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTfPJ+9DjgZrRPm/px84tuQs6SJO1aLQKmkj5ZmafxI=;
 b=DzEpQTWJ0LhfPFVtzpEVZY4pxgMrOEhVu1D2uS2pLgsCkBicRYWT6/Blgt+9aWbPbCQ0K7bVVvy4hiUmC/BiGAiISA3vC3NhvxPrBpoXO5oVVAR4ERG5/NDZ3q3C6r6u07MHjcUW5M4VAr3mDCYj8QN9CKUehscM655fTFfJ2Ws=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 19/25] ata: ftide010: Add a quirk for SQ201
Thread-Topic: [PATCH AUTOSEL 4.14 19/25] ata: ftide010: Add a quirk for SQ201
Thread-Index: AQHUUIxpzYqChRRp7U+UsRcHwCjKaA==
Date:   Thu, 20 Sep 2018 02:48:28 +0000
Message-ID: <20180920024810.58594-19-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:me2C0m+CtAbNfOsMZJPgmkk1QcC+pGt2oaLm2lM8OARrh+SaVp+nMM/b2d8tScME9khE4YDY8mix78jPGEhN2aKhWtyI5mn0Etlai/MoudFUbdXxj0NW0k4ez3PGdqxnfAvi23x+kszcXN2s1kBL4K+QSWRnlDZ1r1u5LoKBPRjFsH88ketZl1nd+CP/lPeX3sOaqa4wKPDIfu/tzECFE6Qm1BpP17NJG6cW0YsC4O71Pp03WR8kwg+OubLqMPzfUc7oFxFZnc5HDKh8USdQeEO3bRHyyFvakz1JFWEnv14XcniZmNHrOv8ISVeo2dQMQLDopM4BG3ySg3wNbnARO/cMxwJM1o2OPOamMcnzM4+GYfOzFklBejGycnNHwX+2Dgprg++eEGrKIz8jI9EMoiVeINrGtFQm2luOVyFZrwxlT399eGKigsaFpC5GYLUIs5ZmAsaOr1FAQL16UK6I8w==;5:iu29/5LvGSmPT5BdkRb5MhWkF05FnpLjTNALpyUPQajtkdcU3DSLxh06Hp2p3GQ7TnliClF45a1og9CI+yv/mlkxuCnYY6h4HEfAG+9pp9f+IolGwl8OAZRXvnzKi0POMYCWHsTo3umAK2YhJC7Vgd3WNsVhnbrORuN6++Hozek=;7:nlifkGKuf7/kryyQkkqGTQfv+QhnSbgcyCtR8iHrmmm38YRVbCxLNbYle+QGNqbEle8QJ80YWqeGh9SNXmkKfFdSxGdzy8Kjc9cqS8pHN2fJdCiYktACR0oRhPKt50fMB2R7v2r0A54EzUyrQKtTkEQLKIPqaKjF/gZwzRF9vmpQRu0P3MZvdIIPNqQFnpC45ePZqyFJbpqoSchIJDw/cuNyjiAZIDNDWhL9IA7SBCx1b+a1ulyKpGH/VD6TRmV8
x-ms-office365-filtering-correlation-id: 6b6e0649-d8bd-41ab-a3d6-08d61ea3a888
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744E23C69BC54B4B5FD842CFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(12401385986421)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(2280148)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(575784001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: og1/PQYyf24I4VIghWqT5DdhiOebvKCU6glX7sbnkzFQmeKcH6yQWjpNSvqCAiBWSUGL7+7GaGKtiS4HAdeC5YSqjbKncCymtLBG5bNpsKV/FR5P5gHzvhAJrriReCoCJDM4zEOSGizCYiEGZOnad6Fivf7YkU9zPtLd4JgUsXr8UHH/Wq1d00RegMbmoqgi+tIqwLMgene/p/mzsq6tjgJPXOfFOni60lJcAOtlNlN+F96lthbLyvfl5NdbcFMD806XY0j6PiHZZxDGT7bFh1R8YxkZtNyp4Ub2+Lt0it4RVN7Clp6fjtNthY/osFvPeZPeB1RrW5d1orOkDofIpx9PfFWQRW9voYJCx3WLk6xXQ0cXY4KpkQgzHCXRLIEwEetnihfcrQWchkCdc1PtbB7Y7xdDB2YsMmGiXWjcygjbQ6zJjm06RchIoNdE6OmnNkbUiLlvkqGk3/nxqaEhoPMORW+IVUVPVYqzGFMec9l77dM6QWLar4n5ecRA7RVXgDHB5cO0hW0hk8jZlJ7WYq7K8DfKJty6NDKzvzrS6eqBp+TJWB7qQq8svrKNzEyr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6e0649-d8bd-41ab-a3d6-08d61ea3a888
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:28.9758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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

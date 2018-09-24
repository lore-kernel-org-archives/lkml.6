Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20909ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48B12098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eov/z67j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48B12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbeIXUvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:24 -0400
Received: from mail-eopbgr730114.outbound.protection.outlook.com ([40.107.73.114]:62688
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732197AbeIXUvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFTSmVbsweyTKH8/fEqCFLSF58ecGJ0ofu1wi0DdqRo=;
 b=eov/z67jdQMWCuADY/IF71K4QeltB1p/iwID+pIiqbHyfi9Igw+PpXEPUbhZniQ/wjXORLPuxIp2t+PJWNJRIjFBkat8gilz4oMkbjvlasur2m02qmJPg//3GvPePgwFoxl18XE77cLXXDL0o785+okBZl+tHFTJgdPM2eiJ07k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chris Brandt <chris.brandt@renesas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 33/76] sh_eth: Add R7S9210 support
Thread-Topic: [PATCH AUTOSEL 4.18 33/76] sh_eth: Add R7S9210 support
Thread-Index: AQHUVBWjkEmt2Z2AJUmzwrJ08Iozgg==
Date:   Mon, 24 Sep 2018 14:48:21 +0000
Message-ID: <20180924144751.164410-32-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:DekDR9iped5TXcb/3KFp90VTcSDjJijeh/HQXuLID5dgp9pfnQqUjlQ48HwtXuv/HBhi+9rEnkSRBgNE+iGq3K/424TcvtzbP6x6PFRb2JL2uWKH//ZfRUsQNtuJojxN1onukCvgnc3JV1CgJgKyQLSfCPra3YnvNPUPVct/Ok/VVsNZCx7xjb/FsNJBTVpCC3082TkE16dI8WOvfPMKscPl0RD8LN7h3aeriicOmgX7JzAsisCB3kDw0Oyy4EE0lK7uI8kw2tJRZC7eJIg1OKe4qNTqootWZOZl9psrSpyiQpSMQw+mx+nWcY7agYk/QhAmTv+mnXhPw8FH2AvuCWT0sseyDeAZvzGDkNQnQC7nZnhqiQflMP+Liqw5KM/0ON8Jh7vhxHH6DaalpPnAj9Mme3tRPinOM7UlyIqU46YjcJ6zjrKBKY3rBFLdxKTtj79KwPmKTZ7V2T//RDc6LA==;5:KB5LMHB0uPB5yldR4tqcuv2z9Pz+TKiBYcbNXaQL0M8WO12vWFlvNBD1uO1OKzj5YtxlVw8QvOWP1FgckyrUc3TMdLW2CeMgxBqvZ9C6v4+Nmzpqh9ofi8tqyNyoJWsCNc30Erq27szBYnJUWA8THRTcwCTJvRSvtcStfe0i11Q=;7:Br82j9z95T3EE5v+e1R7Ads5nlJvpczSf9Rxkc00trj4kzrwNAOQkPe+5MV8lViWIA0RgbS5yB8V3b1nwB14GHeZu7r8XKJf+U6gdbs1m7DxmdqJVTjiE4urlH/NfVF+WZHKzl3+DRSVom9eyhuEGV0g54n+hKBf/YyOzuryRRryid3RXtLUqSJA7k6lWaKkPN/aGYqXm3A3wavOzxpgyeVAmOgRNZQyqU7qwzs3OsxZECDuKxHNR2figdymgDjM
x-ms-office365-filtering-correlation-id: 7768435c-79bf-41a2-d9d7-08d6222cd7cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855C716B89E4735F92EE568FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(575784001)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VP/u97UdSGhbOr7vZHkUzXyZ8Nl0X7s1Lkxen5bB8qlFhIVsqD63h9yMCcTT302yyanMXvQlAHHz0y5i761b7xQJozfZhZDOzBd46AEY1fX7avPGicptPBBOPt6cTOrwYnfI7QI8MTV/FZ4l43tAdeLRccanWkHtxQCchtS/ZGmEYhAB3p2vANU3uqNjglx+JFo0SPd+34iR88PZQ1ACl8NugCqOAIb9XW3yHiJXE07yfe0T7F8Wgl4DJb4rMQW65S5/wAOSveDmwN+oW5pNb+HJJ1mbnzM4+dQDBw2KqYbtdLAvCIRF2MuYAfPy7dS/QNotZerBkwC954mbosj903gQy/c4PZluelSEQfxZH9g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7768435c-79bf-41a2-d9d7-08d6222cd7cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:21.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Brandt <chris.brandt@renesas.com>

[ Upstream commit 6e0bb04d0e4f597d8d8f4f21401a9636f2809fd1 ]

Add support for the R7S9210 which is part of the RZ/A2 series.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../devicetree/bindings/net/sh_eth.txt        |  1 +
 drivers/net/ethernet/renesas/sh_eth.c         | 36 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/sh_eth.txt b/Documentati=
on/devicetree/bindings/net/sh_eth.txt
index 82a4cf2c145d..a62fe3b613fc 100644
--- a/Documentation/devicetree/bindings/net/sh_eth.txt
+++ b/Documentation/devicetree/bindings/net/sh_eth.txt
@@ -16,6 +16,7 @@ Required properties:
 	      "renesas,ether-r8a7794"  if the device is a part of R8A7794 SoC.
 	      "renesas,gether-r8a77980" if the device is a part of R8A77980 SoC.
 	      "renesas,ether-r7s72100" if the device is a part of R7S72100 SoC.
+	      "renesas,ether-r7s9210" if the device is a part of R7S9210 SoC.
 	      "renesas,rcar-gen1-ether" for a generic R-Car Gen1 device.
 	      "renesas,rcar-gen2-ether" for a generic R-Car Gen2 or RZ/G1
 	                                device.
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/r=
enesas/sh_eth.c
index 5614fd231bbe..6520379b390e 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -807,6 +807,41 @@ static struct sh_eth_cpu_data r8a77980_data =3D {
 	.magic		=3D 1,
 	.cexcr		=3D 1,
 };
+
+/* R7S9210 */
+static struct sh_eth_cpu_data r7s9210_data =3D {
+	.soft_reset	=3D sh_eth_soft_reset,
+
+	.set_duplex	=3D sh_eth_set_duplex,
+	.set_rate	=3D sh_eth_set_rate_rcar,
+
+	.register_type	=3D SH_ETH_REG_FAST_SH4,
+
+	.edtrr_trns	=3D EDTRR_TRNS_ETHER,
+	.ecsr_value	=3D ECSR_ICD,
+	.ecsipr_value	=3D ECSIPR_ICDIP,
+	.eesipr_value	=3D EESIPR_TWBIP | EESIPR_TABTIP | EESIPR_RABTIP |
+			  EESIPR_RFCOFIP | EESIPR_ECIIP | EESIPR_FTCIP |
+			  EESIPR_TDEIP | EESIPR_TFUFIP | EESIPR_FRIP |
+			  EESIPR_RDEIP | EESIPR_RFOFIP | EESIPR_CNDIP |
+			  EESIPR_DLCIP | EESIPR_CDIP | EESIPR_TROIP |
+			  EESIPR_RMAFIP | EESIPR_RRFIP | EESIPR_RTLFIP |
+			  EESIPR_RTSFIP | EESIPR_PREIP | EESIPR_CERFIP,
+
+	.tx_check	=3D EESR_FTC | EESR_CND | EESR_DLC | EESR_CD | EESR_TRO,
+	.eesr_err_check	=3D EESR_TWB | EESR_TABT | EESR_RABT | EESR_RFE |
+			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE,
+
+	.fdr_value	=3D 0x0000070f,
+
+	.apr		=3D 1,
+	.mpr		=3D 1,
+	.tpauser	=3D 1,
+	.hw_swap	=3D 1,
+	.rpadir		=3D 1,
+	.no_ade		=3D 1,
+	.xdfar_rw	=3D 1,
+};
 #endif /* CONFIG_OF */
=20
 static void sh_eth_set_rate_sh7724(struct net_device *ndev)
@@ -3131,6 +3166,7 @@ static const struct of_device_id sh_eth_match_table[]=
 =3D {
 	{ .compatible =3D "renesas,ether-r8a7794", .data =3D &rcar_gen2_data },
 	{ .compatible =3D "renesas,gether-r8a77980", .data =3D &r8a77980_data },
 	{ .compatible =3D "renesas,ether-r7s72100", .data =3D &r7s72100_data },
+	{ .compatible =3D "renesas,ether-r7s9210", .data =3D &r7s9210_data },
 	{ .compatible =3D "renesas,rcar-gen1-ether", .data =3D &rcar_gen1_data },
 	{ .compatible =3D "renesas,rcar-gen2-ether", .data =3D &rcar_gen2_data },
 	{ }
--=20
2.17.1

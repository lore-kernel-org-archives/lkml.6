Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E1CC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1626F20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TOmeCx1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfBBEH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:07:56 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:26407 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfBBEHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:52 -0500
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="24146380"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 21:07:52 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjxaQwIj/+IYFQkYFHMB2vafO284ePyLejTuUm87H1o=;
 b=TOmeCx1Zt+tKQ3OOtFIVC0EYJCwVEmNURU4Vc65jw6l8mlnHoXgr3N3vWKi59+GyJT6Dvwool+htvzZvIzyvMEZMWCQASCz/G8vVi6mHSmhHXungdwMwyrLMVgUZYW7dG5BGTuFcLH20wtEbUMAgVpgJXBx3nB/rIqSwP2ZT5NE=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1812.namprd11.prod.outlook.com (10.175.98.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:47 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 13/13] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH v3 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Thread-Index: AQHUuqzaAg1hhqTy/0qkkFhSooruSA==
Date:   Sat, 2 Feb 2019 04:07:46 +0000
Message-ID: <20190202040653.1217-14-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:802:28::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1812;6:aFj+GvzDPi0QxwQMK6dIP+WDNVw5/boU8MYV3QdKcBHyziCMCkaSIF/En2deZdK1lfh/rMzTK4rMgnpD6WduvtMOV/pnqPhPvBicikyfX/4Rf0q3zeznfid7dMD2RmvapuIwBThINr31i0PTjiGnwRmdEG+8EHBtvnw0JeUvgTrzH16GZmcdbQCrgLwCGeuijlyqAN7P5i8SoZZmV4ecE95hdQeYSxuh7Q6PThi/6q5FSWSvv5tejcQivgyvhYSg6vvPu6XYNIV+0MxU/Um0qAa0Ci627oTFbbNK5pLYKPeCeBPoH6Y41VOQxEVCGc199ZQtH2ZyJbDfp97MYDsoPxjXuqMMDXDJh+GBGT4GxX30eUjBtIpuIBN5eVKqWyyXVjADXhtqLymlLYNwolYPDTKaUiyQNP/gyy+IZD2L55jUe4FUQIVhTdclQrW4JtMgN3SP/Le2aewFWZkY6Dhr/Q==;5:pi8Csnriynjuw5TEW/7TIi9wLZY0AFWcdNC0rWqnlQ7chMasKPD2GaI2X4h+jHS9qLhlws/DVny80tdAyHFGQAwGlbprfjdqaXvl2U9Bk0d3IOntWZO0wXbZT8mBflGUL0xnTKstK3j3Ev8bgTgziwFfLQ+4EgejsVB0smOvE2X5Boca9qKFVxHrx0M9pFrFNPY7n2rTiz0Z7bBaNvrkKQ==;7:0sOquRucMpEWkh0pQ9S/074O5d1jTNvaJ5m6lYg1WqQfpMTF90iCbDNsDn40Ryh9DpvrVAImRWSrfFRCk3FpZnjyazioMSE1XZQ2qmgYcPAd1yrYInXZNUgdrE01o3sdK4ULYCOZCXxZ5vOEAQzgaQ==
x-ms-office365-filtering-correlation-id: 3d9bd0a1-b122-44d2-396c-08d688c3fd2a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1812;
x-ms-traffictypediagnostic: BN6PR11MB1812:
x-microsoft-antispam-prvs: <BN6PR11MB18126F5A58FEA97096B1908EF0930@BN6PR11MB1812.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(86362001)(72206003)(81156014)(8936002)(39060400002)(50226002)(105586002)(14454004)(107886003)(1076003)(36756003)(71200400001)(81166006)(71190400001)(66066001)(4326008)(478600001)(8676002)(25786009)(76176011)(2501003)(52116002)(99286004)(14444005)(256004)(110136005)(54906003)(68736007)(186003)(26005)(3846002)(6116002)(7416002)(386003)(6506007)(2616005)(11346002)(446003)(102836004)(6436002)(6486002)(476003)(7736002)(486006)(6512007)(97736004)(30864003)(316002)(53946003)(2906002)(305945005)(106356001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1812;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cZttGz4Cc4ctPg9/IokC+7du/Yef65ZEc1pLRmoCuT3y0OjQYTu1L8m5IaMlaK001enT1OFcBaRd729Zb0bfMWFz5vkWfsYHysJan+Ys9Ge9enPuB4iuJs+Y97J4yjlX5mygtoQe5vjYBUEaFzuouEaCQk96YGUbkhVsHaKZqukkQV5KDYgpVleaKIthdWqO5Ou9Jhmgw7CjTXOj1+aoWRy+E3ipkQNunaIkU1dEL30KSy+MmK4VTjdX0nSpTD8fEWXKaLsFpsQapOaXdCCml2tExLFhGCEPRq54n4DZ+Gtq4+li86tvs0YlrlWfDdGM52EOPn3CRJykaHtzh+t1EH8lmHkjnR1nU93+01TpGc5m+FgJq2LMNF7Pk/tz9R8Pia/PlyNo7nfZRyiVR26mRORuld+SViMbJ+JEQBEvNY0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9bd0a1-b122-44d2-396c-08d688c3fd2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:44.6489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1812
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory. It uses
different transfer type bits in IFR register. It has dedicated registers
to specify a read or a write instruction: Read Instruction Code Register
(RICR) and Write Instruction Code Register (WICR). ICR/RICR/WICR have
identical fields.

Tested with sst26vf064b jedec,spi-nor flash. Backward compatibility test
done on sama5d2 qspi controller and mx25l25635e jedec,spi-nor flash.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3:
- reorganize the code and change ops functions pointers to avoid code
  duplication. From the IP perspective, the transfer type bits are
  different, and what registers are written: ricr/wicr instead of icr.
- treat just regular spi transfers. Mem transfers will be added together
  with dirmap support.
v2:
- rework clock handling
- reorder setting of register values in set_cfg() calls -> move functions
  that can fail in the upper part of the function body.

 drivers/spi/atmel-quadspi.c | 295 +++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 234 insertions(+), 61 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index c9548942535a..af1e4e25097a 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi-mem.h>
=20
@@ -35,7 +36,9 @@
=20
 #define QSPI_IAR     0x0030  /* Instruction Address Register */
 #define QSPI_ICR     0x0034  /* Instruction Code Register */
+#define QSPI_WICR    0x0034  /* Write Instruction Code Register */
 #define QSPI_IFR     0x0038  /* Instruction Frame Register */
+#define QSPI_RICR    0x003C  /* Read Instruction Code Register */
=20
 #define QSPI_SMR     0x0040  /* Scrambling Mode Register */
 #define QSPI_SKR     0x0044  /* Scrambling Key Register */
@@ -88,7 +91,7 @@
 #define QSPI_SCR_DLYBS_MASK             GENMASK(23, 16)
 #define QSPI_SCR_DLYBS(n)               (((n) << 16) & QSPI_SCR_DLYBS_MASK=
)
=20
-/* Bitfields in QSPI_ICR (Instruction Code Register) */
+/* Bitfields in QSPI_ICR (Read/Write Instruction Code Register) */
 #define QSPI_ICR_INST_MASK              GENMASK(7, 0)
 #define QSPI_ICR_INST(inst)             (((inst) << 0) & QSPI_ICR_INST_MAS=
K)
 #define QSPI_ICR_OPT_MASK               GENMASK(23, 16)
@@ -117,6 +120,7 @@
 #define QSPI_IFR_CRM                    BIT(14)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK=
)
+#define QSPI_IFR_APBTFRTYP_READ		BIT(24)
=20
 /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
 #define QSPI_SMR_SCREN                  BIT(0)
@@ -133,16 +137,39 @@
 #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
=20
=20
+/* Describes register values. */
+struct atmel_qspi_cfg {
+	u32 icr;
+	u32 iar;
+	u32 ifr;
+};
+
+struct atmel_qspi_caps;
+
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
 	struct clk		*pclk;
+	struct clk		*qspick;
 	struct platform_device	*pdev;
+	const struct atmel_qspi_caps *caps;
 	u32			pending;
 	u32			smm;
 	struct completion	cmd_completion;
 };
=20
+struct atmel_qspi_ops {
+	void (*set_tfrtyp)(const struct spi_mem_op *op,
+			   struct atmel_qspi_cfg *cfg);
+	void (*write_regs)(void __iomem *base, const struct spi_mem_op *op,
+			   const struct atmel_qspi_cfg *cfg);
+};
+
+struct atmel_qspi_caps {
+	const struct atmel_qspi_ops *ops;
+	bool has_qspick;
+};
+
 struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
@@ -200,30 +227,36 @@ static bool atmel_qspi_supports_op(struct spi_mem *me=
m,
 	return true;
 }
=20
-static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
+static int atmel_qspi_set_mode(struct atmel_qspi_cfg *cfg,
+			       const struct spi_mem_op *op)
 {
-	struct atmel_qspi *aq =3D spi_controller_get_devdata(mem->spi->master);
-	void __iomem *base =3D aq->regs;
-	int mode;
-	u32 dummy_cycles =3D 0;
-	u32 iar, icr, ifr, sr;
-	int err =3D 0;
-
-	iar =3D 0;
-	icr =3D QSPI_ICR_INST(op->cmd.opcode);
-	ifr =3D QSPI_IFR_INSTEN;
+	int mode =3D atmel_qspi_find_mode(op);
=20
-	/* Set the QSPI controller in Serial Memory Mode */
-	if (aq->smm !=3D QSPI_MR_SMM) {
-		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
-		aq->smm =3D QSPI_MR_SMM;
-	}
-
-	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return mode;
+	cfg->ifr =3D sama5d2_qspi_modes[mode].config;
+	return 0;
+}
=20
-	ifr |=3D sama5d2_qspi_modes[mode].config;
+/*
+ * atmel_qspi_set_address_mode() - set address mode.
+ * @cfg:	contains register values
+ * @op:		describes a SPI memory operation
+ *
+ * The controller allows 24 and 32-bit addressing while NAND-flash require=
s
+ * 16-bit long. Handling 8-bit long addresses is done using the option fie=
ld.
+ * For the 16-bit addresses, the workaround depends of the number of reque=
sted
+ * dummy bits. If there are 8 or more dummy cycles, the address is shifted=
 and
+ * sent with the first dummy byte. Otherwise opcode is disabled and the fi=
rst
+ * byte of the address contains the command opcode (works only if the opco=
de and
+ * address use the same buswidth). The limitation is when the 16-bit addre=
ss is
+ * used without enough dummy cycles and the opcode is using a different bu=
swidth
+ * than the address.
+ */
+static int atmel_qspi_set_address_mode(struct atmel_qspi_cfg *cfg,
+				       const struct spi_mem_op *op)
+{
+	u32 dummy_cycles =3D 0;
=20
 	if (op->dummy.buswidth && op->dummy.nbytes)
 		dummy_cycles =3D op->dummy.nbytes * 8 / op->dummy.buswidth;
@@ -233,28 +266,28 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 		case 0:
 			break;
 		case 1:
-			ifr |=3D QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
-			icr |=3D QSPI_ICR_OPT(op->addr.val & 0xff);
+			cfg->ifr |=3D QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
+			cfg->icr =3D QSPI_ICR_OPT(op->addr.val & 0xff);
 			break;
 		case 2:
 			if (dummy_cycles < 8 / op->addr.buswidth) {
-				ifr &=3D ~QSPI_IFR_INSTEN;
-				ifr |=3D QSPI_IFR_ADDREN;
-				iar =3D (op->cmd.opcode << 16) |
-					(op->addr.val & 0xffff);
+				cfg->ifr &=3D ~QSPI_IFR_INSTEN;
+				cfg->ifr |=3D QSPI_IFR_ADDREN;
+				cfg->iar =3D (op->cmd.opcode << 16) |
+					   (op->addr.val & 0xffff);
 			} else {
-				ifr |=3D QSPI_IFR_ADDREN;
-				iar =3D (op->addr.val << 8) & 0xffffff;
+				cfg->ifr |=3D QSPI_IFR_ADDREN;
+				cfg->iar =3D (op->addr.val << 8) & 0xffffff;
 				dummy_cycles -=3D 8 / op->addr.buswidth;
 			}
 			break;
 		case 3:
-			ifr |=3D QSPI_IFR_ADDREN;
-			iar =3D op->addr.val & 0xffffff;
+			cfg->ifr |=3D QSPI_IFR_ADDREN;
+			cfg->iar =3D op->addr.val & 0xffffff;
 			break;
 		case 4:
-			ifr |=3D QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
-			iar =3D op->addr.val & 0x7ffffff;
+			cfg->ifr |=3D QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
+			cfg->iar =3D op->addr.val & 0x7ffffff;
 			break;
 		default:
 			return -ENOTSUPP;
@@ -263,22 +296,99 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
=20
 	/* Set number of dummy cycles */
 	if (dummy_cycles)
-		ifr |=3D QSPI_IFR_NBDUM(dummy_cycles);
+		cfg->ifr |=3D QSPI_IFR_NBDUM(dummy_cycles);
=20
-	/* Set data enable */
-	if (op->data.nbytes)
-		ifr |=3D QSPI_IFR_DATAEN;
+	return 0;
+}
=20
+static void atmel_qspi_sama5d2_set_tfrtyp(const struct spi_mem_op *op,
+					  struct atmel_qspi_cfg *cfg)
+{
 	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
-		ifr |=3D QSPI_IFR_SAMA5D2_WRITE_TRSFR;
+		cfg->ifr |=3D QSPI_IFR_SAMA5D2_WRITE_TRSFR;
+}
=20
+static void atmel_qspi_sama5d2_write_regs(void __iomem *base,
+					  const struct spi_mem_op *op,
+					  const struct atmel_qspi_cfg *cfg)
+{
 	/* Clear pending interrupts */
 	(void)readl_relaxed(base + QSPI_SR);
=20
 	/* Set QSPI Instruction Frame registers */
-	writel_relaxed(iar, base + QSPI_IAR);
-	writel_relaxed(icr, base + QSPI_ICR);
-	writel_relaxed(ifr, base + QSPI_IFR);
+	writel_relaxed(cfg->iar, base + QSPI_IAR);
+	writel_relaxed(cfg->icr, base + QSPI_ICR);
+	writel_relaxed(cfg->ifr, base + QSPI_IFR);
+}
+
+static void atmel_qspi_sam9x60_set_tfrtyp(const struct spi_mem_op *op,
+					  struct atmel_qspi_cfg *cfg)
+{
+	if (!op->addr.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_IN)
+		cfg->ifr |=3D QSPI_IFR_APBTFRTYP_READ;
+}
+
+static void atmel_qspi_sam9x60_write_regs(void __iomem *base,
+					  const struct spi_mem_op *op,
+					  const struct atmel_qspi_cfg *cfg)
+{
+	/* Clear pending interrupts */
+	(void)readl_relaxed(base + QSPI_SR);
+
+	/* Set QSPI Instruction Frame registers */
+	writel_relaxed(cfg->iar, base + QSPI_IAR);
+	if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
+		writel_relaxed(cfg->icr, base + QSPI_RICR);
+	else
+		writel_relaxed(cfg->icr, base + QSPI_ICR);
+	writel_relaxed(cfg->ifr, base + QSPI_IFR);
+}
+
+static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
+			      const struct spi_mem_op *op,
+			      struct atmel_qspi_cfg *cfg)
+{
+	void __iomem *base =3D aq->regs;
+	int ret;
+
+	/* Set the QSPI controller in Serial Memory Mode */
+	if (aq->smm !=3D QSPI_MR_SMM) {
+		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
+		aq->smm =3D QSPI_MR_SMM;
+	}
+
+	ret =3D atmel_qspi_set_mode(cfg, op);
+	if (ret)
+		return ret;
+
+	ret =3D atmel_qspi_set_address_mode(cfg, op);
+	if (ret)
+		return ret;
+
+	cfg->ifr |=3D QSPI_IFR_INSTEN;
+	cfg->icr |=3D QSPI_ICR_INST(op->cmd.opcode);
+
+	/* Set data enable */
+	if (op->data.nbytes)
+		cfg->ifr |=3D QSPI_IFR_DATAEN;
+
+	aq->caps->ops->set_tfrtyp(op, cfg);
+	aq->caps->ops->write_regs(base, op, cfg);
+
+	return 0;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
+{
+	struct atmel_qspi *aq =3D spi_controller_get_devdata(mem->spi->master);
+	void __iomem *base =3D aq->regs;
+	struct atmel_qspi_cfg cfg =3D {0};
+	u32 sr;
+	int err;
+
+	err =3D atmel_qspi_set_cfg(aq, op, &cfg);
+	if (err)
+		return err;
=20
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -287,11 +397,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
=20
 		/* Send/Receive data */
 		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
-			_memcpy_fromio(op->data.buf.in,
-				aq->mem + iar, op->data.nbytes);
+			_memcpy_fromio(op->data.buf.in, aq->mem + cfg.iar,
+				       op->data.nbytes);
 		else
-			_memcpy_toio(aq->mem + iar,
-				op->data.buf.out, op->data.nbytes);
+			_memcpy_toio(aq->mem + cfg.iar, op->data.buf.out,
+				     op->data.nbytes);
=20
 		/* Release the chip-select */
 		writel_relaxed(QSPI_CR_LASTXFER, base + QSPI_CR);
@@ -391,9 +501,22 @@ static int atmel_qspi_probe(struct platform_device *pd=
ev)
 	struct spi_controller *ctrl;
 	struct atmel_qspi *aq;
 	struct resource *res;
+	const struct atmel_qspi_caps *caps;
+	struct device *dev =3D &pdev->dev;
 	int irq, err =3D 0;
=20
-	ctrl =3D spi_alloc_master(&pdev->dev, sizeof(*aq));
+	caps =3D of_device_get_match_data(dev);
+	if (!caps) {
+		dev_err(dev, "Could not retrieve QSPI caps\n");
+		return -EINVAL;
+	}
+
+	if (!caps->ops->set_tfrtyp || !caps->ops->write_regs) {
+		dev_err(dev, "Could not retrieve QSPI ops\n");
+		return -EINVAL;
+	}
+
+	ctrl =3D spi_alloc_master(dev, sizeof(*aq));
 	if (!ctrl)
 		return -ENOMEM;
=20
@@ -409,32 +532,33 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
=20
 	init_completion(&aq->cmd_completion);
 	aq->pdev =3D pdev;
+	aq->caps =3D caps;
=20
 	/* Map the registers */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
-	aq->regs =3D devm_ioremap_resource(&pdev->dev, res);
+	aq->regs =3D devm_ioremap_resource(dev, res);
 	if (IS_ERR(aq->regs)) {
-		dev_err(&pdev->dev, "missing registers\n");
+		dev_err(dev, "missing registers\n");
 		err =3D PTR_ERR(aq->regs);
 		goto exit;
 	}
=20
 	/* Map the AHB memory */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mmap");
-	aq->mem =3D devm_ioremap_resource(&pdev->dev, res);
+	aq->mem =3D devm_ioremap_resource(dev, res);
 	if (IS_ERR(aq->mem)) {
-		dev_err(&pdev->dev, "missing AHB memory\n");
+		dev_err(dev, "missing AHB memory\n");
 		err =3D PTR_ERR(aq->mem);
 		goto exit;
 	}
=20
 	/* Get the peripheral clock */
-	aq->pclk =3D devm_clk_get(&pdev->dev, "pclk");
+	aq->pclk =3D devm_clk_get(dev, "pclk");
 	if (IS_ERR(aq->pclk))
-		aq->pclk =3D devm_clk_get(&pdev->dev, NULL);
+		aq->pclk =3D devm_clk_get(dev, NULL);
=20
 	if (IS_ERR(aq->pclk)) {
-		dev_err(&pdev->dev, "missing peripheral clock\n");
+		dev_err(dev, "missing peripheral clock\n");
 		err =3D PTR_ERR(aq->pclk);
 		goto exit;
 	}
@@ -442,32 +566,52 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
 	/* Enable the peripheral clock */
 	err =3D clk_prepare_enable(aq->pclk);
 	if (err) {
-		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
+		dev_err(dev, "failed to enable the peripheral clock\n");
 		goto exit;
 	}
=20
+	if (caps->has_qspick) {
+		/* Get the QSPI system clock */
+		aq->qspick =3D devm_clk_get(dev, "qspick");
+		if (IS_ERR(aq->qspick)) {
+			dev_err(dev, "missing system clock\n");
+			err =3D PTR_ERR(aq->qspick);
+			goto disable_pclk;
+		}
+
+		/* Enable the QSPI system clock */
+		err =3D clk_prepare_enable(aq->qspick);
+		if (err) {
+			dev_err(dev,
+				"failed to enable the QSPI system clock\n");
+			goto disable_pclk;
+		}
+	}
+
 	/* Request the IRQ */
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "missing IRQ\n");
+		dev_err(dev, "missing IRQ\n");
 		err =3D irq;
-		goto disable_pclk;
+		goto disable_qspick;
 	}
-	err =3D devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
-			       0, dev_name(&pdev->dev), aq);
+	err =3D devm_request_irq(dev, irq, atmel_qspi_interrupt, 0,
+			       dev_name(dev), aq);
 	if (err)
-		goto disable_pclk;
+		goto disable_qspick;
=20
 	err =3D atmel_qspi_init(aq);
 	if (err)
-		goto disable_pclk;
+		goto disable_qspick;
=20
 	err =3D spi_register_controller(ctrl);
 	if (err)
-		goto disable_pclk;
+		goto disable_qspick;
=20
 	return 0;
=20
+disable_qspick:
+	clk_disable_unprepare(aq->qspick);
 disable_pclk:
 	clk_disable_unprepare(aq->pclk);
 exit:
@@ -483,6 +627,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
ev)
=20
 	spi_unregister_controller(ctrl);
 	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
@@ -491,6 +636,7 @@ static int __maybe_unused atmel_qspi_suspend(struct dev=
ice *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
=20
 	return 0;
@@ -501,6 +647,7 @@ static int __maybe_unused atmel_qspi_resume(struct devi=
ce *dev)
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
 	clk_prepare_enable(aq->pclk);
+	clk_prepare_enable(aq->qspick);
=20
 	return atmel_qspi_init(aq);
 }
@@ -508,8 +655,34 @@ static int __maybe_unused atmel_qspi_resume(struct dev=
ice *dev)
 static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
 			 atmel_qspi_resume);
=20
+static const struct atmel_qspi_ops atmel_sama5d2_qspi_ops =3D {
+	.set_tfrtyp =3D atmel_qspi_sama5d2_set_tfrtyp,
+	.write_regs =3D atmel_qspi_sama5d2_write_regs,
+};
+
+static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps =3D {
+	.ops =3D &atmel_sama5d2_qspi_ops,
+};
+
+static const struct atmel_qspi_ops atmel_sam9x60_qspi_ops =3D {
+	.set_tfrtyp =3D atmel_qspi_sam9x60_set_tfrtyp,
+	.write_regs =3D atmel_qspi_sam9x60_write_regs,
+};
+
+static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps =3D {
+	.ops =3D &atmel_sam9x60_qspi_ops,
+	.has_qspick =3D true,
+};
+
 static const struct of_device_id atmel_qspi_dt_ids[] =3D {
-	{ .compatible =3D "atmel,sama5d2-qspi" },
+	{
+		.compatible =3D "atmel,sama5d2-qspi",
+		.data =3D &atmel_sama5d2_qspi_caps,
+	},
+	{
+		.compatible =3D "microchip,sam9x60-qspi",
+		.data =3D &atmel_sam9x60_qspi_caps,
+	},
 	{ /* sentinel */ }
 };
=20
--=20
2.9.5


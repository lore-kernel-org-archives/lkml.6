Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E3BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E955F20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Z7hLbe9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfBEPoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:44:17 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:13872 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfBEPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:44:14 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="26335563"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 08:44:08 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:44:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNsH8SnjHMWHqAugNHaFS1AxQC2PVXzOhqthh2ZNlx0=;
 b=Z7hLbe9sv+fBu/YGOWSRUwgnVabbGSwDCwhepCvOX0WYXH0gxd0OXnMUWS+eQrmRSLcplLi5rQiVBPK57LsSeAdJUXhGU8tiM8pDTqPAA6VztQoeb9OoVWqmGGpf1P18uoJdWFfDLDUwTpil98VW+y1Tqg7ZQXccy94A7OBHfCs=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1569.namprd11.prod.outlook.com (10.172.24.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Tue, 5 Feb 2019 15:44:05 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:44:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 13/13] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH v5 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Thread-Index: AQHUvWmf96RuSIlcIU2rieqj9mC3Dw==
Date:   Tue, 5 Feb 2019 15:44:04 +0000
Message-ID: <20190205154257.29529-14-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1569;6:bGTDjGvVFFddSVi48xZpl9EHC/aL7DM1OKLDNuHi8ceuO9zsR3HSCMowM0sg/2xUhVJNy+xoZ9FilwLS2imlFmH/rTEsktARxb9LdoSthz7OcGv99L/AZcB+pI4JANaICV4eUFOfyrbXHqCwYwmJQ6GpWgTB9CillnU7k+SJDkphYqSaPU+KOJOmoBgQiFIZFjw3k+jUhtjr96DjkvW3ehXVxW7rE7AlOEnQUln6Uj5Na9/YWIPtvwM8gIn1dVbsehb5Fc4yfqsWe8d3A1YekoKNMNgqsLEPSxLhX9+WSR10B2sVfrdRJRB3Et3TNyNRvQfXSJzJdYDGhNy9dwRd6EOrHo0ZKx775aTRlls/CtJIM3pPWNzt/XOcIXd5nyXnYlWxCbjxUBYZmBH/4AqHdPHT7JzXZ58giLT4TmH8mVtnWECkBlaISAw5LAAjMH/fsGuXFL3sW4lYawfSRNykfg==;5:yhFEW+hiKTR6GnRmNsUrj0TELdofDLXgSU2yTBdCCf9bczByM6xsvQQAhXAc/S2nmH6K5k6DKK/TyVLG7qPdrwcMKx8AJXKG3zh+ceWdN/+Ff/4SjWeUqqzWxq7epLY8ipi1IFF+rRWWyZW7zUb/cYpFw3GB+9y97vFzfHMmeuEdaFxP2caRZqw+LKGwNRNFutuwn5OYkYpCjY/EvyFJSQ==;7:lgD769S4fxZWUu2uZkCHcWxQndr8sd70m/bQFr9XPpLdpFoEtzIpTe592+prGJgjRbaXuy40d+a4OPp+7dDRZQWwpSTrXGGO5RytZPEu/SzQjaNpwtRsDCY7FLUbOpYJ/x3oq/tDelYzaxnppsoplQ==
x-ms-office365-filtering-correlation-id: 2284adc4-487f-4c70-ae24-08d68b80c1dd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1569;
x-ms-traffictypediagnostic: BN6PR11MB1569:
x-microsoft-antispam-prvs: <BN6PR11MB1569A5B313ACE7F3675928E8F06E0@BN6PR11MB1569.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(72206003)(6436002)(6486002)(2501003)(316002)(86362001)(1076003)(110136005)(478600001)(25786009)(36756003)(446003)(54906003)(4326008)(30864003)(14454004)(6116002)(6512007)(99286004)(14444005)(53936002)(66066001)(3846002)(50226002)(107886003)(52116002)(81166006)(8936002)(8676002)(256004)(81156014)(386003)(7736002)(486006)(76176011)(7416002)(11346002)(2906002)(105586002)(476003)(97736004)(106356001)(2616005)(102836004)(71190400001)(186003)(6506007)(68736007)(26005)(71200400001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1569;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZRvt9pW09XJWDHxGvFSahJPOo9DRkWomLrzHnkUC6NrdvlGLXx749AbyiRBdBMwqQy8e+IdN07qi5sa4JBpmZvXe72I6Rh0w9WNAF3tEzQEoGoovSAmD19MFRCkH7rZ8sT01lqMcli45Unmh/5XzOiOE8eqR1l7WgR4PIbYCsJgWiH9iMoQsSrAQfi+1hB8SMnyAC9FWzUp7tPsvrrH9p/Q5IYJcqA0B3dih84J+ICE1nhN+oHyhZL7h/to1sxPOEq1VAHwJNS+SLuRfNGQWCTQ8fDJqCcYFKuqZrBB9PbwRhcE6ktpihapGVSomdxxoEOeFdeO1hBZCKj2uvTm+z1jng8D0Bf0bqFzwHLDqgrsioaj5RtnsvrkkEe0AYHYR3RC5m8A9mUP3v2lNjBIBZIJHR3kC+lRQypmVYevsvag=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2284adc4-487f-4c70-ae24-08d68b80c1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:44:02.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1569
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
v5:
- use WICR for sam9x60
- remove ops hooks and introduce caps->has_ricr
- get rid of the cfg struct
- group IO accesses together in atmel_qspi_set_cfg()
v4:
- drop local variables that kept aq->regs and &pdev->dev, the compiler
  should be smart enough to store them in a register
- add comment saying QSPI_IFR_APBTFRTYP_READ is defined in sam9x60
- s/sama5d2_qspi_modes/atmel_qspi_modes, modes are the same both
  controllers
- fix kernel doc header
- move comment in function body
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

 drivers/spi/atmel-quadspi.c | 154 ++++++++++++++++++++++++++++++++++------=
----
 1 file changed, 119 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 336501d962e5..2d3d76565e94 100644
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
@@ -118,6 +121,7 @@
 #define QSPI_IFR_CRM                    BIT(14)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK=
)
+#define QSPI_IFR_APBTFRTYP_READ		BIT(24)	/* Defined in SAM9X60 */
=20
 /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
 #define QSPI_SMR_SCREN                  BIT(0)
@@ -133,12 +137,18 @@
 #define QSPI_WPSR_WPVSRC_MASK           GENMASK(15, 8)
 #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
=20
+struct atmel_qspi_caps {
+	bool has_qspick;
+	bool has_ricr;
+};
=20
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
 	struct clk		*pclk;
+	struct clk		*qspick;
 	struct platform_device	*pdev;
+	const struct atmel_qspi_caps *caps;
 	u32			pending;
 	u32			mr;
 	struct completion	cmd_completion;
@@ -151,7 +161,7 @@ struct atmel_qspi_mode {
 	u32 config;
 };
=20
-static const struct atmel_qspi_mode sama5d2_qspi_modes[] =3D {
+static const struct atmel_qspi_mode atmel_qspi_modes[] =3D {
 	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
 	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
 	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
@@ -180,8 +190,8 @@ static int atmel_qspi_find_mode(const struct spi_mem_op=
 *op)
 {
 	u32 i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
-		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
+	for (i =3D 0; i < ARRAY_SIZE(atmel_qspi_modes); i++)
+		if (atmel_qspi_is_compatible(op, &atmel_qspi_modes[i]))
 			return i;
=20
 	return -ENOTSUPP;
@@ -201,36 +211,37 @@ static bool atmel_qspi_supports_op(struct spi_mem *me=
m,
 	return true;
 }
=20
-static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
+static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
+			      const struct spi_mem_op *op, u32 *offset)
 {
-	struct atmel_qspi *aq =3D spi_controller_get_devdata(mem->spi->master);
-	int mode;
+	u32 iar, icr, ifr;
 	u32 dummy_cycles =3D 0;
-	u32 iar, icr, ifr, sr;
-	int err =3D 0;
+	int mode;
=20
 	iar =3D 0;
 	icr =3D QSPI_ICR_INST(op->cmd.opcode);
 	ifr =3D QSPI_IFR_INSTEN;
=20
-	/*
-	 * If the QSPI controller is set in regular SPI mode, set it in
-	 * Serial Memory Mode (SMM).
-	 */
-	if (aq->mr !=3D QSPI_MR_SMM) {
-		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
-		aq->mr =3D QSPI_MR_SMM;
-	}
-
 	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return mode;
-
-	ifr |=3D sama5d2_qspi_modes[mode].config;
+	ifr |=3D atmel_qspi_modes[mode].config;
=20
 	if (op->dummy.buswidth && op->dummy.nbytes)
 		dummy_cycles =3D op->dummy.nbytes * 8 / op->dummy.buswidth;
=20
+	/*
+	 * The controller allows 24 and 32-bit addressing while NAND-flash
+	 * requires 16-bit long. Handling 8-bit long addresses is done using
+	 * the option field. For the 16-bit addresses, the workaround depends
+	 * of the number of requested dummy bits. If there are 8 or more dummy
+	 * cycles, the address is shifted and sent with the first dummy byte.
+	 * Otherwise opcode is disabled and the first byte of the address
+	 * contains the command opcode (works only if the opcode and address
+	 * use the same buswidth). The limitation is when the 16-bit address is
+	 * used without enough dummy cycles and the opcode is using a different
+	 * buswidth than the address.
+	 */
 	if (op->addr.buswidth) {
 		switch (op->addr.nbytes) {
 		case 0:
@@ -264,6 +275,9 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
 		}
 	}
=20
+	/* offset of the data access in the QSPI memory space */
+	*offset =3D iar;
+
 	/* Set number of dummy cycles */
 	if (dummy_cycles)
 		ifr |=3D QSPI_IFR_NBDUM(dummy_cycles);
@@ -272,16 +286,51 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 	if (op->data.nbytes)
 		ifr |=3D QSPI_IFR_DATAEN;
=20
-	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
-		ifr |=3D QSPI_IFR_SAMA5D2_WRITE_TRSFR;
+	/*
+	 * If the QSPI controller is set in regular SPI mode, set it in
+	 * Serial Memory Mode (SMM).
+	 */
+	if (aq->mr !=3D QSPI_MR_SMM) {
+		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
+		aq->mr =3D QSPI_MR_SMM;
+	}
=20
 	/* Clear pending interrupts */
 	(void)readl_relaxed(aq->regs + QSPI_SR);
=20
-	/* Set QSPI Instruction Frame registers */
-	writel_relaxed(iar, aq->regs + QSPI_IAR);
-	writel_relaxed(icr, aq->regs + QSPI_ICR);
-	writel_relaxed(ifr, aq->regs + QSPI_IFR);
+	if (aq->caps && aq->caps->has_ricr) {
+		if (!op->addr.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_IN)
+			ifr |=3D QSPI_IFR_APBTFRTYP_READ;
+
+		/* Set QSPI Instruction Frame registers */
+		writel_relaxed(iar, aq->regs + QSPI_IAR);
+		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
+			writel_relaxed(icr, aq->regs + QSPI_RICR);
+		else
+			writel_relaxed(icr, aq->regs + QSPI_WICR);
+		writel_relaxed(ifr, aq->regs + QSPI_IFR);
+	} else {
+		if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
+			ifr |=3D QSPI_IFR_SAMA5D2_WRITE_TRSFR;
+
+		/* Set QSPI Instruction Frame registers */
+		writel_relaxed(iar, aq->regs + QSPI_IAR);
+		writel_relaxed(icr, aq->regs + QSPI_ICR);
+		writel_relaxed(ifr, aq->regs + QSPI_IFR);
+	}
+
+	return 0;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
+{
+	struct atmel_qspi *aq =3D spi_controller_get_devdata(mem->spi->master);
+	u32 sr, offset;
+	int err;
+
+	err =3D atmel_qspi_set_cfg(aq, op, &offset);
+	if (err)
+		return err;
=20
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -290,11 +339,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
=20
 		/* Send/Receive data */
 		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
-			_memcpy_fromio(op->data.buf.in,
-				aq->mem + iar, op->data.nbytes);
+			_memcpy_fromio(op->data.buf.in, aq->mem + offset,
+				       op->data.nbytes);
 		else
-			_memcpy_toio(aq->mem + iar,
-				op->data.buf.out, op->data.nbytes);
+			_memcpy_toio(aq->mem + offset, op->data.buf.out,
+				     op->data.nbytes);
=20
 		/* Release the chip-select */
 		writel_relaxed(QSPI_CR_LASTXFER, aq->regs + QSPI_CR);
@@ -450,28 +499,49 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
 		goto exit;
 	}
=20
+	aq->caps =3D of_device_get_match_data(&pdev->dev);
+	if (aq->caps && aq->caps->has_qspick) {
+		/* Get the QSPI system clock */
+		aq->qspick =3D devm_clk_get(&pdev->dev, "qspick");
+		if (IS_ERR(aq->qspick)) {
+			dev_err(&pdev->dev, "missing system clock\n");
+			err =3D PTR_ERR(aq->qspick);
+			goto disable_pclk;
+		}
+
+		/* Enable the QSPI system clock */
+		err =3D clk_prepare_enable(aq->qspick);
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to enable the QSPI system clock\n");
+			goto disable_pclk;
+		}
+	}
+
 	/* Request the IRQ */
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "missing IRQ\n");
 		err =3D irq;
-		goto disable_pclk;
+		goto disable_qspick;
 	}
 	err =3D devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
 			       0, dev_name(&pdev->dev), aq);
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
@@ -487,6 +557,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
ev)
=20
 	spi_unregister_controller(ctrl);
 	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
@@ -495,6 +566,7 @@ static int __maybe_unused atmel_qspi_suspend(struct dev=
ice *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
=20
 	return 0;
@@ -505,6 +577,7 @@ static int __maybe_unused atmel_qspi_resume(struct devi=
ce *dev)
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
 	clk_prepare_enable(aq->pclk);
+	clk_prepare_enable(aq->qspick);
=20
 	return atmel_qspi_init(aq);
 }
@@ -512,8 +585,19 @@ static int __maybe_unused atmel_qspi_resume(struct dev=
ice *dev)
 static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
 			 atmel_qspi_resume);
=20
+static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps =3D {
+	.has_qspick =3D true,
+	.has_ricr =3D true,
+};
+
 static const struct of_device_id atmel_qspi_dt_ids[] =3D {
-	{ .compatible =3D "atmel,sama5d2-qspi" },
+	{
+		.compatible =3D "atmel,sama5d2-qspi",
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


Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E0BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB3C2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HrrUP3mQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfBDKKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:10:25 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:33483 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbfBDKKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:10:24 -0500
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="26269150"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Feb 2019 03:10:23 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:10:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ali36uYEmRJApX2WSVWs24q65iyd2Qr87zsfVgfjAYE=;
 b=HrrUP3mQRlN+EyKQ/fNdIZlFml8/qrFzaqkE2wZxarWmVCzvcIEaOarrwi8EoCsBvrtqal9du08SXGXRWPxbP62Y9E/WhJ4HeuygFYeHXDb/oGw5Y76M4UirCnnMv/gxwMuJ/o35cFepETW0WpwRty8J6u++FZhBDW6PPkLErOg=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1508.namprd11.prod.outlook.com (10.172.21.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:10:21 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:10:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 13/13] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH v4 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Thread-Index: AQHUvHHWdNk7TDcc4kmbhc3k/0wcZw==
Date:   Mon, 4 Feb 2019 10:10:21 +0000
Message-ID: <20190204100910.26701-14-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190204100910.26701-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0270.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::43) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1508;6:+4YVLMz1wE8wyLOJhYc4d1eXbCzg6SO6wY6bPBUP6aMRQ8LouZkumUb12w52lUVLcUxgw+XmQqvlcZR4CAmm/Wc64ahJkVMawgwwNWro7hW/K2lGJaaW9Oic7wR18cwDGAHEH/5FtvNwMm6/gxE5ilzUlYvFyQShqeuACfy2rC9RqNL7P3LLaB9vJ7o6rbn/vHy3CLfmuyBVt7ujbkcG0HfbqHjdYAcxOn2aBOne4c32/PX62UBwxIfmC+cXTutJuOGz8+iOlnV5OaBjMiqmjNCdClbprX1IflVs7F7t1+HmMrHCVxWxpCAai0ufzqT8RAwO5Hk3+tt8s2ug3wpq0Js0mrCEUo00VXZg25Tug1zDjuyYrvFeOVRGCjIvZJeUDR0vbRsmrO3QaeCogLTE5SoyyYcU7+eOK4LOfxQzFh1Qelqv1VJ8PxB9FBI8wmb5tn0QoDpfMSXW86bqJzuNqA==;5:nA1JMqjxlSGPxRlTvG7w6wSCvN8JoJLdwXOuGWFyZW4tK+j+yIsgXKFEaHk1VrmG5OyTvESpmD0ky93FwDOaPgz8LbSXpFzMep6hDFtSqugas3x6YHKptlQVOatNAy6RytyIIRuMIRsPcNzhXefB7tbNHJqJz+2be47oQF0+2pU/Ma4SULOJmxmPHLpxzlrkS9mnKsV42didoNKdjDtM9Q==;7:deIhmbZTkrztiCHRvSr6t8ujIXP9p1ntJuYlxRnux8ZyMPkRd9Q4nQlzdam0M8uZyYWEZ1AkTZmAeBj6x9I8+EzhDwTUYNe6fQXHVl3m+P0ULczmfjBBYkeDnY+3E8oi2N7FP6cktkGmQG7YCulccg==
x-ms-office365-filtering-correlation-id: 21b5aea3-1482-45cb-e9ec-08d68a88f874
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1508;
x-ms-traffictypediagnostic: BN6PR11MB1508:
x-microsoft-antispam-prvs: <BN6PR11MB1508C7926051C5FAC9D1369CF06D0@BN6PR11MB1508.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(6486002)(11346002)(446003)(2616005)(486006)(106356001)(99286004)(6436002)(4326008)(105586002)(478600001)(476003)(76176011)(186003)(53936002)(305945005)(3846002)(6116002)(7736002)(81156014)(102836004)(26005)(81166006)(6512007)(107886003)(8676002)(25786009)(68736007)(39060400002)(52116002)(50226002)(110136005)(8936002)(53946003)(2906002)(386003)(54906003)(6506007)(86362001)(1076003)(36756003)(30864003)(71190400001)(71200400001)(316002)(97736004)(7416002)(14454004)(256004)(2501003)(14444005)(72206003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1508;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MrkUx/3g7DXJumJYc4wWetT0wRJymF49AN24nIn2DZthdQmsTm8TJMIZy6AsTdO7zwyZ2C6EfMEfRovbloU0W+IDywpg5dyTkypQ9h4aS+BPCZIbNV9GN22Y8bm7bSI+0L9Xao4aftY+v/w8spCgQJ2JXN+OmMUG5VWhONTURYmeomYmmQoxhIYcqRKmQSYcrb3/1PdeRNMqI0AgwsPvYpLymDRJofQ+LiTYZds1umR5WtUMtFVluRzCNTTf+fPEP+RWFNMoyQaMY+eK1ok8GmV2W7k4DCeUAcSrtGzAd/tNNWI7YGnMsEWlUouv7T72dEr64tETK5vxYS1mv8LNTlq5qHTSkOokwEYTkQ/jFbLj5RagiWSt0NEFL/3cc7MCWlgkZiM23abxxjYzobWEyAdXfCLli2qPggldWK3x7ng=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b5aea3-1482-45cb-e9ec-08d68a88f874
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:10:08.5198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1508
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

 drivers/spi/atmel-quadspi.c | 282 +++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 228 insertions(+), 54 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 336501d962e5..52e96c3ff9e6 100644
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
@@ -134,16 +138,40 @@
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
 	u32			mr;
 	struct completion	cmd_completion;
 };
=20
+struct atmel_qspi_ops {
+	void (*set_tfrtyp)(const struct spi_mem_op *op,
+			   struct atmel_qspi_cfg *cfg);
+	void (*write_regs)(const struct atmel_qspi *aq,
+			   const struct spi_mem_op *op,
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
@@ -151,7 +179,7 @@ struct atmel_qspi_mode {
 	u32 config;
 };
=20
-static const struct atmel_qspi_mode sama5d2_qspi_modes[] =3D {
+static const struct atmel_qspi_mode atmel_qspi_modes[] =3D {
 	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
 	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
 	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
@@ -180,8 +208,8 @@ static int atmel_qspi_find_mode(const struct spi_mem_op=
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
@@ -201,63 +229,69 @@ static bool atmel_qspi_supports_op(struct spi_mem *me=
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
-	int mode;
-	u32 dummy_cycles =3D 0;
-	u32 iar, icr, ifr, sr;
-	int err =3D 0;
-
-	iar =3D 0;
-	icr =3D QSPI_ICR_INST(op->cmd.opcode);
-	ifr =3D QSPI_IFR_INSTEN;
-
-	/*
-	 * If the QSPI controller is set in regular SPI mode, set it in
-	 * Serial Memory Mode (SMM).
-	 */
-	if (aq->mr !=3D QSPI_MR_SMM) {
-		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
-		aq->mr =3D QSPI_MR_SMM;
-	}
+	int mode =3D atmel_qspi_find_mode(op);
=20
-	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return mode;
+	cfg->ifr =3D atmel_qspi_modes[mode].config;
+	return 0;
+}
=20
-	ifr |=3D sama5d2_qspi_modes[mode].config;
+/**
+ * atmel_qspi_set_address_mode() - set address mode.
+ * @cfg:	contains register values
+ * @op:		describes a SPI memory operation
+ */
+static int atmel_qspi_set_address_mode(struct atmel_qspi_cfg *cfg,
+				       const struct spi_mem_op *op)
+{
+	u32 dummy_cycles =3D 0;
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
@@ -266,22 +300,100 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, c=
onst struct spi_mem_op *op)
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
+static void atmel_qspi_sama5d2_write_regs(const struct atmel_qspi *aq,
+					  const struct spi_mem_op *op,
+					  const struct atmel_qspi_cfg *cfg)
+{
 	/* Clear pending interrupts */
 	(void)readl_relaxed(aq->regs + QSPI_SR);
=20
 	/* Set QSPI Instruction Frame registers */
-	writel_relaxed(iar, aq->regs + QSPI_IAR);
-	writel_relaxed(icr, aq->regs + QSPI_ICR);
-	writel_relaxed(ifr, aq->regs + QSPI_IFR);
+	writel_relaxed(cfg->iar, aq->regs + QSPI_IAR);
+	writel_relaxed(cfg->icr, aq->regs + QSPI_ICR);
+	writel_relaxed(cfg->ifr, aq->regs + QSPI_IFR);
+}
+
+static void atmel_qspi_sam9x60_set_tfrtyp(const struct spi_mem_op *op,
+					  struct atmel_qspi_cfg *cfg)
+{
+	if (!op->addr.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_IN)
+		cfg->ifr |=3D QSPI_IFR_APBTFRTYP_READ;
+}
+
+static void atmel_qspi_sam9x60_write_regs(const struct atmel_qspi *aq,
+					  const struct spi_mem_op *op,
+					  const struct atmel_qspi_cfg *cfg)
+{
+	/* Clear pending interrupts */
+	(void)readl_relaxed(aq->regs + QSPI_SR);
+
+	/* Set QSPI Instruction Frame registers */
+	writel_relaxed(cfg->iar, aq->regs + QSPI_IAR);
+	if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
+		writel_relaxed(cfg->icr, aq->regs + QSPI_RICR);
+	else
+		writel_relaxed(cfg->icr, aq->regs + QSPI_ICR);
+	writel_relaxed(cfg->ifr, aq->regs + QSPI_IFR);
+}
+
+static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
+			      const struct spi_mem_op *op,
+			      struct atmel_qspi_cfg *cfg)
+{
+	int ret;
+
+	/*
+	 * If the QSPI controller is set in regular SPI mode, set it in
+	 * Serial Memory Mode (SMM).
+	 */
+	if (aq->mr !=3D QSPI_MR_SMM) {
+		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
+		aq->mr =3D QSPI_MR_SMM;
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
+	aq->caps->ops->write_regs(aq, op, cfg);
+
+	return 0;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
+{
+	struct atmel_qspi *aq =3D spi_controller_get_devdata(mem->spi->master);
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
@@ -290,11 +402,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
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
 		writel_relaxed(QSPI_CR_LASTXFER, aq->regs + QSPI_CR);
@@ -395,8 +507,20 @@ static int atmel_qspi_probe(struct platform_device *pd=
ev)
 	struct spi_controller *ctrl;
 	struct atmel_qspi *aq;
 	struct resource *res;
+	const struct atmel_qspi_caps *caps;
 	int irq, err =3D 0;
=20
+	caps =3D of_device_get_match_data(&pdev->dev);
+	if (!caps) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
+		return -EINVAL;
+	}
+
+	if (!caps->ops->set_tfrtyp || !caps->ops->write_regs) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI ops\n");
+		return -EINVAL;
+	}
+
 	ctrl =3D spi_alloc_master(&pdev->dev, sizeof(*aq));
 	if (!ctrl)
 		return -ENOMEM;
@@ -413,6 +537,7 @@ static int atmel_qspi_probe(struct platform_device *pde=
v)
=20
 	init_completion(&aq->cmd_completion);
 	aq->pdev =3D pdev;
+	aq->caps =3D caps;
=20
 	/* Map the registers */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
@@ -450,28 +575,48 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
 		goto exit;
 	}
=20
+	if (caps->has_qspick) {
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
@@ -487,6 +632,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
ev)
=20
 	spi_unregister_controller(ctrl);
 	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
@@ -495,6 +641,7 @@ static int __maybe_unused atmel_qspi_suspend(struct dev=
ice *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
=20
 	return 0;
@@ -505,6 +652,7 @@ static int __maybe_unused atmel_qspi_resume(struct devi=
ce *dev)
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
 	clk_prepare_enable(aq->pclk);
+	clk_prepare_enable(aq->qspick);
=20
 	return atmel_qspi_init(aq);
 }
@@ -512,8 +660,34 @@ static int __maybe_unused atmel_qspi_resume(struct dev=
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


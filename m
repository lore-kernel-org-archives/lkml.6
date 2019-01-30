Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F36FC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5997320989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QFS6K0Jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbfA3PJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:09:02 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:21605 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbfA3PJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:09:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="24020814"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 30 Jan 2019 08:08:50 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 08:08:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OaSCpo9vw4gbCsA7Dfhq0e7SofVC7nQqACgXlafFNA=;
 b=QFS6K0Jq3RHwxBxNmWjJeMv4eK0I0eEputSY86wD93YrlfzGpFTOpc8DjZfT20jKBvUTjbjiR3pLJGUDgGNk7aNSFgpkNwJAmxfpbjSpN3SOS5EhN5oKfJRXtIp0Y9V8iHkv/0T9duR8UDUAgzXTb6l65XNngsDOThWvVdQRBXY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1428.namprd11.prod.outlook.com (10.172.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 15:08:47 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Index: AQHUuK2zcy+YTju2sU2WL87l1ywXpQ==
Date:   Wed, 30 Jan 2019 15:08:47 +0000
Message-ID: <20190130150818.24902-10-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1428;6:1LpO6nHFtMoGGoJUrOaT6dbmEGaccXpE2UhKKsMawL1/elV/obA614LPtVu4c0jeaXAWokH5w+nW8++Z7mLOcojlpijuiABSwFFR/Ih2aodtfLYi1yoje4G748m2ZXynGD1tkMoghlThplYmG83m/UQOdVVfF5TZP7Q283HChFpIYufvcL5K0NPq6/TDMHHS0cXLqTa4M8PjnjW70poaz0bCVLioKGCWwzr7RIg4f5uWQ+qZ7KUqGx6j8sN8vfF3/W40SoKOJPtYHp8AWLw/1TUtQ0s7burpvjwXZ6Ju5yGqzjkblntOjFh4dlcDAdyPplufihKqySjXeO7JW7GnIIjOP4LK30LQKdocQ0e6/E1u1DX2ONjGg6W2Du0ilCRmMs8WHGJ0NikJ9G9xgbbLqD5QyMEU4Vd96YFe2AqXvfv53QmPdfhPiNInLrguSVpSQQrAvE79QiW5QPeBa5nbBQ==;5:+SWkmFS8iwWKxc0JbFSaDGEkjIItN6Q9vNSv1fBws9twbLlM8jdrjUxU86/Q/DoYXCNjrttmmCzv2vYTHD9/8VqJg5LZArMKc92HspzKL67wnWMT/UtF/cpx1wBoxiFkbzvtWmdLdlOwGq0PhVYz5Cn0KiHK2BTdyVR38GglmV2+oJ+rrAZOdraai2EuqB2lB7ss4aEPbJOZddmxNPUwrA==;7:EnJp2xGnuJ8+jWs5q/aOvYwxGugIfND2kU2Gh8aLUYtkMeXAQo7rXEnoGqoMdtFc4mypzeXOOqH++1SwE4SZryeYQ5djLeRgWLHCs3AHqY1KYzCZjMlqC5dhP7DBef/2HmCisuBbLtRm9HJ7EEMpOg==
x-ms-office365-filtering-correlation-id: 27aecd75-affe-4e64-f9af-08d686c4d564
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1428;
x-ms-traffictypediagnostic: BN6PR11MB1428:
x-microsoft-antispam-prvs: <BN6PR11MB1428CCF4350E760CF636D64FF0900@BN6PR11MB1428.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(6436002)(68736007)(97736004)(6636002)(52116002)(6116002)(186003)(8936002)(50226002)(2501003)(66066001)(26005)(486006)(107886003)(53946003)(3846002)(53936002)(4326008)(110136005)(86362001)(6486002)(71200400001)(81166006)(316002)(6506007)(102836004)(2616005)(11346002)(25786009)(476003)(71190400001)(54906003)(446003)(386003)(105586002)(8676002)(1076003)(305945005)(106356001)(2906002)(81156014)(478600001)(72206003)(7736002)(99286004)(76176011)(30864003)(6512007)(256004)(14454004)(14444005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1428;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hbGuU+hUgxcL6IT1q2WHukh4nP94+HJZrbrLBKQAfj1/ZIF8xfEDKAYS5eIb+sf1dK6Fpb9fv9fJyEPyL44Lbv+QMmmiaKQvjP4xqUirf/XoWcj6CrixZuqBujcLhyNWbf5Uav7dujhXwuQ40+SBfG5akliAdPuH9x3iocN7yTt1jdVyafC/bZkdki9AC3tSBxENeMjosllboiO+XC9lTqMSCCzifAif9GKA98EPlIle0DXbXfD7kkG4iOBex4EFJcVB60BD7bEkpfVLhIgeaomsxdnu98TZK6EoM68oxuqs+e21Yl6rCoflox0fLWZ0TRUVa5neBb7QbHP10exQ7epIaN3YWxrx9yhMGLjFP9PGCw7p0UwmcySOHTOgkeNgbr5WM93k3RB+aau017s2nN10rudlulAZv74G5EkY9/E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 27aecd75-affe-4e64-f9af-08d686c4d564
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:45.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1428
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory. It uses
dedicated register for Read Instruction Code Register (RICR) and
Write Instruction Code Register (WICR). ICR/RICR/WICR have identical
fields.

Tested with sst26vf064b jedec,spi-nor flash. Backward compatibility test
done on sama5d2 qspi controller and mx25l25635e jedec,spi-nor flash.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 331 ++++++++++++++++++++++++++++++++++++----=
----
 1 file changed, 277 insertions(+), 54 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 1d21db7851e9..bfdc8488f23b 100644
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
@@ -113,6 +116,8 @@
 #define QSPI_IFR_OPTL_4BIT              (2 << 8)
 #define QSPI_IFR_OPTL_8BIT              (3 << 8)
 #define QSPI_IFR_ADDRL                  BIT(10)
+#define QSPI_IFR_TFRTYP_TRSFR_MEM	BIT(12)
+#define QSPI_IFR_TFRTYP_TRSFR_REG	(0 << 12)
 #define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
 #define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
 #define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
@@ -121,6 +126,8 @@
 #define QSPI_IFR_CRM                    BIT(14)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK=
)
+#define QSPI_IFR_APBTFRTYP_WRITE	(0 << 24)
+#define QSPI_IFR_APBTFRTYP_READ		BIT(24)
=20
 /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
 #define QSPI_SMR_SCREN                  BIT(0)
@@ -137,15 +144,37 @@
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
 	struct clk		*clk;
+	struct clk		*qspick;
 	struct platform_device	*pdev;
+	const struct atmel_qspi_caps *caps;
 	u32			pending;
 	struct completion	cmd_completion;
 };
=20
+struct atmel_qspi_ops {
+	int (*clk_prepare_enable)(struct atmel_qspi *aq);
+	void (*clk_disable_unprepare)(struct atmel_qspi *aq);
+	int (*set_qspi_cfg)(struct atmel_qspi *aq, const struct spi_mem_op *op,
+			    struct atmel_qspi_cfg *cfg);
+};
+
+struct atmel_qspi_caps {
+	const struct atmel_qspi_ops *ops;
+};
+
 struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
@@ -214,23 +243,36 @@ static bool atmel_qspi_supports_op(struct spi_mem *me=
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
+	int mode =3D atmel_qspi_find_mode(op);
=20
-	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return mode;
+	cfg->ifr =3D QSPI_IFR_INSTEN | sama5d2_qspi_modes[mode].config;
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
@@ -240,28 +282,28 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 		case 0:
 			break;
 		case 1:
-			ifr |=3D QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
-			icr |=3D QSPI_ICR_OPT(op->addr.val & 0xff);
+			cfg->ifr |=3D QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
+			cfg->icr |=3D QSPI_ICR_OPT(op->addr.val & 0xff);
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
@@ -270,24 +312,99 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
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
+
+static int atmel_sama5d2_qspi_set_cfg(struct atmel_qspi *aq,
+				      const struct spi_mem_op *op,
+				      struct atmel_qspi_cfg *cfg)
+{
+	int ret =3D atmel_qspi_set_mode(cfg, op);
+
+	if (ret)
+		return ret;
+
+	cfg->icr =3D QSPI_ICR_INST(op->cmd.opcode);
=20
 	if (op->data.dir =3D=3D SPI_MEM_DATA_IN && op->data.nbytes)
-		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_READ;
+		cfg->ifr |=3D QSPI_IFR_TFRTYP_TRSFR_READ;
 	else
-		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
+		cfg->ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
+
+	/* Set data enable */
+	if (op->data.nbytes)
+		cfg->ifr |=3D QSPI_IFR_DATAEN;
+
+	ret =3D atmel_qspi_set_address_mode(cfg, op);
+	if (ret)
+		return ret;
+
+	/* Clear pending interrupts */
+	(void)atmel_qspi_readl(aq, QSPI_SR);
+
+	/* Set QSPI Instruction Frame registers */
+	atmel_qspi_writel(aq, QSPI_IAR, cfg->iar);
+	atmel_qspi_writel(aq, QSPI_ICR, cfg->icr);
+	atmel_qspi_writel(aq, QSPI_IFR, cfg->ifr);
+
+	return 0;
+}
+
+static int atmel_sam9x60_qspi_set_cfg(struct atmel_qspi *aq,
+				      const struct spi_mem_op *op,
+				      struct atmel_qspi_cfg *cfg)
+{
+	int ret =3D atmel_qspi_set_mode(cfg, op);
+
+	if (ret)
+		return ret;
+
+	cfg->icr =3D QSPI_ICR_INST(op->cmd.opcode);
+
+	if (!op->addr.nbytes) {
+		cfg->ifr |=3D QSPI_IFR_TFRTYP_TRSFR_REG;
+		if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
+			cfg->ifr |=3D QSPI_IFR_APBTFRTYP_WRITE;
+		else
+			cfg->ifr |=3D QSPI_IFR_APBTFRTYP_READ;
+	} else {
+		cfg->ifr |=3D QSPI_IFR_TFRTYP_TRSFR_MEM;
+	}
+
+	/* Set data enable */
+	if (op->data.nbytes)
+		cfg->ifr |=3D QSPI_IFR_DATAEN;
+
+	ret =3D atmel_qspi_set_address_mode(cfg, op);
+	if (ret)
+		return ret;
=20
 	/* Clear pending interrupts */
 	(void)atmel_qspi_readl(aq, QSPI_SR);
=20
 	/* Set QSPI Instruction Frame registers */
-	atmel_qspi_writel(aq, QSPI_IAR, iar);
-	atmel_qspi_writel(aq, QSPI_ICR, icr);
-	atmel_qspi_writel(aq, QSPI_IFR, ifr);
+	atmel_qspi_writel(aq, QSPI_IAR, cfg->iar);
+	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
+		atmel_qspi_writel(aq, QSPI_ICR, cfg->icr);
+	else
+		atmel_qspi_writel(aq, QSPI_RICR, cfg->icr);
+	atmel_qspi_writel(aq, QSPI_IFR, cfg->ifr);
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
+	err =3D aq->caps->ops->set_qspi_cfg(aq, op, &cfg);
+	if (err)
+		return err;
=20
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -296,11 +413,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
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
 		atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
@@ -395,10 +512,84 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void=
 *dev_id)
 	return IRQ_HANDLED;
 }
=20
+static int atmel_sama5d2_qspi_clk_prepare_enable(struct atmel_qspi *aq)
+{
+	int ret;
+
+	if (!aq->clk) {
+		/* Get the peripheral clock */
+		aq->clk =3D devm_clk_get(&aq->pdev->dev, NULL);
+		if (IS_ERR(aq->clk)) {
+			dev_err(&aq->pdev->dev, "missing peripheral clock\n");
+			return PTR_ERR(aq->clk);
+		}
+	}
+
+	/* Enable the peripheral clock */
+	ret =3D clk_prepare_enable(aq->clk);
+	if (ret)
+		dev_err(&aq->pdev->dev,
+			"failed to enable the peripheral clock\n");
+
+	return ret;
+}
+
+static void atmel_sama5d2_qspi_clk_disable_unprepare(struct atmel_qspi *aq=
)
+{
+	clk_disable_unprepare(aq->clk);
+}
+
+static int atmel_sam9x60_qspi_clk_prepare_enable(struct atmel_qspi *aq)
+{
+	struct device *dev =3D &aq->pdev->dev;
+	int ret;
+
+	if (!aq->clk) {
+		/* Get the peripheral clock */
+		aq->clk =3D devm_clk_get(dev, "pclk");
+		if (IS_ERR(aq->clk)) {
+			dev_err(dev, "missing peripheral clock\n");
+			return PTR_ERR(aq->clk);
+		}
+	}
+
+	if (!aq->qspick) {
+		/* Get the QSPI system clock */
+		aq->qspick =3D devm_clk_get(dev, "qspick");
+		if (IS_ERR(aq->qspick)) {
+			dev_err(dev, "missing system clock\n");
+			return PTR_ERR(aq->qspick);
+		}
+	}
+
+	/* Enable the peripheral clock */
+	ret =3D clk_prepare_enable(aq->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable the peripheral clock\n");
+		return ret;
+	}
+
+	/* Enable the QSPI system clock */
+	ret =3D clk_prepare_enable(aq->qspick);
+	if (ret) {
+		dev_err(dev, "failed to enable the QSPI system clock\n");
+		clk_disable_unprepare(aq->clk);
+	}
+
+	return ret;
+}
+
+static void atmel_sam9x60_qspi_clk_disable_unprepare(struct atmel_qspi *aq=
)
+{
+	clk_disable_unprepare(aq->qspick);
+	clk_disable_unprepare(aq->clk);
+}
+
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
 	struct atmel_qspi *aq;
+	const struct atmel_qspi_caps *caps;
 	struct resource *res;
 	int irq, err =3D 0;
=20
@@ -437,20 +628,22 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
 		goto exit;
 	}
=20
-	/* Get the peripheral clock */
-	aq->clk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(aq->clk)) {
-		dev_err(&pdev->dev, "missing peripheral clock\n");
-		err =3D PTR_ERR(aq->clk);
-		goto exit;
+	caps =3D of_device_get_match_data(&pdev->dev);
+	if (!caps) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
+		return -EINVAL;
 	}
=20
-	/* Enable the peripheral clock */
-	err =3D clk_prepare_enable(aq->clk);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
-		goto exit;
+	if (!caps->ops->clk_prepare_enable ||
+	    !caps->ops->clk_disable_unprepare || !caps->ops->set_qspi_cfg) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI ops\n");
+		return -EINVAL;
 	}
+	aq->caps =3D caps;
+
+	err =3D caps->ops->clk_prepare_enable(aq);
+	if (err)
+		return err;
=20
 	/* Request the IRQ */
 	irq =3D platform_get_irq(pdev, 0);
@@ -475,7 +668,7 @@ static int atmel_qspi_probe(struct platform_device *pde=
v)
 	return 0;
=20
 disable_clk:
-	clk_disable_unprepare(aq->clk);
+	caps->ops->clk_disable_unprepare(aq);
 exit:
 	spi_controller_put(ctrl);
=20
@@ -486,18 +679,20 @@ static int atmel_qspi_remove(struct platform_device *=
pdev)
 {
 	struct spi_controller *ctrl =3D platform_get_drvdata(pdev);
 	struct atmel_qspi *aq =3D spi_controller_get_devdata(ctrl);
+	const struct atmel_qspi_caps *caps =3D aq->caps;
=20
 	spi_unregister_controller(ctrl);
 	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
-	clk_disable_unprepare(aq->clk);
+	caps->ops->clk_disable_unprepare(aq);
 	return 0;
 }
=20
 static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
+	const struct atmel_qspi_caps *caps =3D aq->caps;
=20
-	clk_disable_unprepare(aq->clk);
+	caps->ops->clk_disable_unprepare(aq);
=20
 	return 0;
 }
@@ -505,8 +700,9 @@ static int __maybe_unused atmel_qspi_suspend(struct dev=
ice *dev)
 static int __maybe_unused atmel_qspi_resume(struct device *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
+	const struct atmel_qspi_caps *caps =3D aq->caps;
=20
-	clk_prepare_enable(aq->clk);
+	caps->ops->clk_prepare_enable(aq);
=20
 	return atmel_qspi_init(aq);
 }
@@ -514,8 +710,35 @@ static int __maybe_unused atmel_qspi_resume(struct dev=
ice *dev)
 static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
 			 atmel_qspi_resume);
=20
+static const struct atmel_qspi_ops atmel_sama5d2_qspi_ops =3D {
+	.clk_prepare_enable =3D atmel_sama5d2_qspi_clk_prepare_enable,
+	.clk_disable_unprepare =3D atmel_sama5d2_qspi_clk_disable_unprepare,
+	.set_qspi_cfg =3D atmel_sama5d2_qspi_set_cfg,
+};
+
+static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps =3D {
+	.ops =3D &atmel_sama5d2_qspi_ops,
+};
+
+static const struct atmel_qspi_ops atmel_sam9x60_qspi_ops =3D {
+	.clk_prepare_enable =3D atmel_sam9x60_qspi_clk_prepare_enable,
+	.clk_disable_unprepare =3D atmel_sam9x60_qspi_clk_disable_unprepare,
+	.set_qspi_cfg =3D atmel_sam9x60_qspi_set_cfg,
+};
+
+static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps =3D {
+	.ops =3D &atmel_sam9x60_qspi_ops,
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


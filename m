Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A9EC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C3B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tmY1OPdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfA3PIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:08:39 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7120 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfA3PIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:08:36 -0500
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="26094015"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2019 08:08:36 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 08:08:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6wQ6dQ7wO44QDdSxR25CKR0+gZu+1+vP5anujzgEEs=;
 b=tmY1OPdId8ET3tJn87sXdphy+Dn5FjvozrL8zSdRuEDaJeeVkxq2BOb9hwoQwIWEKhfT59HEVgqIDdDUVU9SNmGjhPCspYEDyOdLSrTg4JiILGk5hcmFKKU+LS7O3vAhOk5DbpDOBoqUCAJUhxI5QUBG2ZzHtZR50er3KShEoYI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1796.namprd11.prod.outlook.com (10.175.99.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 15:08:33 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:33 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 3/9] spi: atmel-quadspi: fix naming scheme
Thread-Topic: [PATCH 3/9] spi: atmel-quadspi: fix naming scheme
Thread-Index: AQHUuK2rht/7ZFEtQkGJmNLPHPLPUQ==
Date:   Wed, 30 Jan 2019 15:08:33 +0000
Message-ID: <20190130150818.24902-4-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1796;6:AEPj0GcsKJNgOaRfDioSNq5qA8Jb2kIK1NLrz1xJ+rd9+eGMXhvBx/7/UvYfwhnshgU0E48a/YhezjY6ZynMRius0b4uvyqnTFPW2n4MFH59H5bcWF/jpkGFuuftK8SiZqNxfOBpuE4hYfLFpBVfmMO7vXJKb5z8mx5H/nZUh8TZ3jTyAdRP2gXyXabNV4W3IeLL2qKz91koQFKFPV8p/357bwJ2ZCrrWP88MNWkbirRfZarjVGXXROOmbNwf3dEct0/29W7d/AlFpTm1Y5qYS/npvu/RLyLqaZBNFRWHTILbzPY/spv3gN3S3++mu9psX75UkBw9sNIdORdYpwrQuNJqwYdwqqb4ne6iv9akN7H0AxVd9vOc2Fzq3i6WPJECc8ThKPkaJ8/Ty0N//XHzDCIwdKJrcOwxoc+PRbThqclqCcnVAHKamyN65iRpauLMwbPnWE1fd7xjIUwnftm2Q==;5:Sm1QUxs8Xr2IHGRWTvVsVc2skHfRr31kIawScPgIzrXQSJPRZbkqnh8CLbizVMWtap6msHVm/XTdoB/fVbgQ85rpz/Evb7xcMVsj21Fm/3hg94iuBmWIlOG+nxHxV9JPhQYFSa5kFF1gzaK+UaO9yZDOAuBzDNLAHtjbbjE74jHZ/Witcutj4DPcF8nzmxfHSZCTo7KUAPhNsOW98SLjVg==;7:e9xyZOeprdmjqrdyh0XxoHrCbdqsuSE5FfmFnS+q6bCRKJqVTP7L22rHTHs/HpNmoZacceNQzeGwd7abhatHmKx+YiXGfYE9uhJhhcUriniF8gEpR1et0AQds93q0e2dBjmyEEVOoTk08TUcaWjD2A==
x-ms-office365-filtering-correlation-id: d6b057bd-2828-4ced-2f7a-08d686c4cd52
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1796;
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-microsoft-antispam-prvs: <BN6PR11MB17966341683AD0C562201B03F0900@BN6PR11MB1796.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(386003)(316002)(81156014)(2501003)(72206003)(81166006)(486006)(14454004)(476003)(110136005)(1076003)(8936002)(6116002)(4326008)(11346002)(50226002)(52116002)(6506007)(2616005)(36756003)(3846002)(68736007)(6486002)(6436002)(53936002)(8676002)(54906003)(66066001)(6512007)(478600001)(99286004)(186003)(71200400001)(97736004)(86362001)(2906002)(256004)(71190400001)(14444005)(305945005)(446003)(6636002)(102836004)(105586002)(25786009)(7736002)(26005)(106356001)(107886003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1796;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lRIAurCRc51BV6LQDcYknX4ZLsTm7V9QqmAHF4YPdLv2mRloO/8UXp7ehnompQ54Kaw5+w0F61ocems5WsDZuPVk2vKFbzGXg7razATVcZBoS+HMB5Zwlax+MgJwdWUrbiccF0p3rwVLj8he7Z2kRADaOGz2OWKdsl9rCgBZDL/OKc9YKnCCG5bXKaBH+OuNn896ahqOXak1lWnku1HS+7wDX+eq/GwurDUguPCSgHhkGN/hkBWfrfRuW/N5K55gMQBNl8j3pqtGyjbW+cDtpZHpYzFwFMqZqPd31bhYUuxVLmwnNb/jwr7uc0nGWw2RlpxWSnN7dOnKu9FqNbgy/2SFN8BPUItKQ0ACEcQFP7hwJ0jyS8aHLG8+eXd2/UneE3YKee66otCJza9nxC0Lz8/0DNLg2cHKwYxTM53YT9U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b057bd-2828-4ced-2f7a-08d686c4cd52
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:32.0999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Let general names to core drivers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 52 ++++++++++++++++++++++-------------------=
----
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 64475ad16c83..e156c345705b 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -157,14 +157,14 @@ struct atmel_qspi {
 	struct completion	cmd_completion;
 };
=20
-struct qspi_mode {
+struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
 	u8 data_buswidth;
 	u32 config;
 };
=20
-static const struct qspi_mode sama5d2_qspi_modes[] =3D {
+static const struct atmel_qspi_mode sama5d2_qspi_modes[] =3D {
 	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
 	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
 	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
@@ -175,18 +175,18 @@ static const struct qspi_mode sama5d2_qspi_modes[] =
=3D {
 };
=20
 /* Register access functions */
-static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
+static inline u32 atmel_qspi_readl(struct atmel_qspi *aq, u32 reg)
 {
 	return readl_relaxed(aq->regs + reg);
 }
=20
-static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
+static inline void atmel_qspi_writel(struct atmel_qspi *aq, u32 reg, u32 v=
alue)
 {
 	writel_relaxed(value, aq->regs + reg);
 }
=20
-static inline bool is_compatible(const struct spi_mem_op *op,
-				 const struct qspi_mode *mode)
+static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
+					    const struct atmel_qspi_mode *mode)
 {
 	if (op->cmd.buswidth !=3D mode->cmd_buswidth)
 		return false;
@@ -200,12 +200,12 @@ static inline bool is_compatible(const struct spi_mem=
_op *op,
 	return true;
 }
=20
-static int find_mode(const struct spi_mem_op *op)
+static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 {
 	u32 i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
-		if (is_compatible(op, &sama5d2_qspi_modes[i]))
+		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
 			return i;
=20
 	return -1;
@@ -214,7 +214,7 @@ static int find_mode(const struct spi_mem_op *op)
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
-	if (find_mode(op) < 0)
+	if (atmel_qspi_find_mode(op) < 0)
 		return false;
=20
 	/* special case not supported by hardware */
@@ -237,7 +237,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
 	icr =3D QSPI_ICR_INST(op->cmd.opcode);
 	ifr =3D QSPI_IFR_INSTEN;
=20
-	mode =3D find_mode(op);
+	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return -ENOTSUPP;
=20
@@ -293,17 +293,17 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
=20
 	/* Clear pending interrupts */
-	(void)qspi_readl(aq, QSPI_SR);
+	(void)atmel_qspi_readl(aq, QSPI_SR);
=20
 	/* Set QSPI Instruction Frame registers */
-	qspi_writel(aq, QSPI_IAR, iar);
-	qspi_writel(aq, QSPI_ICR, icr);
-	qspi_writel(aq, QSPI_IFR, ifr);
+	atmel_qspi_writel(aq, QSPI_IAR, iar);
+	atmel_qspi_writel(aq, QSPI_ICR, icr);
+	atmel_qspi_writel(aq, QSPI_IFR, ifr);
=20
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
 		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-		(void)qspi_readl(aq, QSPI_IFR);
+		(void)atmel_qspi_readl(aq, QSPI_IFR);
=20
 		/* Send/Receive data */
 		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
@@ -314,22 +314,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 				op->data.buf.out, op->data.nbytes);
=20
 		/* Release the chip-select */
-		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
+		atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
 	}
=20
 	/* Poll INSTRuction End status */
-	sr =3D qspi_readl(aq, QSPI_SR);
+	sr =3D atmel_qspi_readl(aq, QSPI_SR);
 	if ((sr & QSPI_SR_CMD_COMPLETED) =3D=3D QSPI_SR_CMD_COMPLETED)
 		return err;
=20
 	/* Wait for INSTRuction End interrupt */
 	reinit_completion(&aq->cmd_completion);
 	aq->pending =3D sr & QSPI_SR_CMD_COMPLETED;
-	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
+	atmel_qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
 	if (!wait_for_completion_timeout(&aq->cmd_completion,
 					 msecs_to_jiffies(1000)))
 		err =3D -ETIMEDOUT;
-	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
+	atmel_qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
=20
 	return err;
 }
@@ -368,7 +368,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 		scbr--;
=20
 	scr =3D QSPI_SCR_SCBR(scbr);
-	qspi_writel(aq, QSPI_SCR, scr);
+	atmel_qspi_writel(aq, QSPI_SCR, scr);
=20
 	return 0;
 }
@@ -376,13 +376,13 @@ static int atmel_qspi_setup(struct spi_device *spi)
 static int atmel_qspi_init(struct atmel_qspi *aq)
 {
 	/* Reset the QSPI controller */
-	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
+	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
=20
 	/* Set the QSPI controller in Serial Memory Mode */
-	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+	atmel_qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
=20
 	/* Enable the QSPI controller */
-	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
+	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
=20
 	return 0;
 }
@@ -392,8 +392,8 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *=
dev_id)
 	struct atmel_qspi *aq =3D (struct atmel_qspi *)dev_id;
 	u32 status, mask, pending;
=20
-	status =3D qspi_readl(aq, QSPI_SR);
-	mask =3D qspi_readl(aq, QSPI_IMR);
+	status =3D atmel_qspi_readl(aq, QSPI_SR);
+	mask =3D atmel_qspi_readl(aq, QSPI_IMR);
 	pending =3D status & mask;
=20
 	if (!pending)
@@ -499,7 +499,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
ev)
 	struct atmel_qspi *aq =3D spi_controller_get_devdata(ctrl);
=20
 	spi_unregister_controller(ctrl);
-	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
+	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
 	clk_disable_unprepare(aq->clk);
 	return 0;
 }
--=20
2.9.5


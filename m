Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbeEMEaK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 00:30:10 -0400
Received: from mail-eopbgr00126.outbound.protection.outlook.com ([40.107.0.126]:55417
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750850AbeEMEaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 00:30:08 -0400
From: "Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com>
To: "Boris.Brezillon@bootlin.com" <Boris.Brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jagdish.gediya@nxp.com" <jagdish.gediya@nxp.com>,
        "shreeya.patel23498@gmail.com" <shreeya.patel23498@gmail.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bos, Ties (Nokia - US/Sunnyvale)" <ties.bos@nokia.com>,
        "Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com>
Subject: [PATCH v7] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
Thread-Topic: [PATCH v7] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
Thread-Index: AdPqcw1t262DjgFHSjKF174DiCyylw==
Date: Sun, 13 May 2018 04:30:02 +0000
Message-ID: <VI1PR07MB1615A02B23D992E84A3B333F819D0@VI1PR07MB1615.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
x-originating-ip: [2601:646:8281:8310:f08a:db2e:32f8:9890]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB0895;7:WMgCNLlD0YS2Y0jfzgdFYsfO7C1l0EUxYxYwq/mr6sTEvnB/1DDNN83PgOISw3u7wjix6wxl/wSw8qbFNlO1n5ENidWC8JjjTXzm4tvhyLqviLB15Elx9YdQro0spwgELIXM2vMZEYAFDEmFkEFe6+JaDKa02O7Hmk4e0j+RXjIDwGIVekrpkCgV0vPf9v+6XnBYRl646R1SFRfcXTOR06/6FllEdV9eSqxzmx9dLl/JINx3jUfQ50PaCArof3sb
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(346002)(39380400002)(199004)(189003)(102836004)(53936002)(8936002)(3280700002)(7736002)(8656006)(99286004)(478600001)(97736004)(68736007)(8676002)(2906002)(81166006)(59450400001)(6506007)(6116002)(107886003)(7696005)(54906003)(110136005)(316002)(186003)(81156014)(6436002)(5660300001)(2900100001)(3660700001)(2201001)(4326008)(305945005)(74316002)(5250100002)(86362001)(7416002)(9686003)(46003)(55016002)(106356001)(2501003)(39060400002)(25786009)(33656002)(486006)(14454004)(105586002)(476003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB0895;H:VI1PR07MB1615.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(48565401081)(2017052603328)(7193020);SRVR:VI1PR07MB0895;
x-ms-traffictypediagnostic: VI1PR07MB0895:
x-microsoft-antispam-prvs: <VI1PR07MB08954F647A77F11D4514587E819D0@VI1PR07MB0895.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(82608151540597)(109105607167333);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR07MB0895;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB0895;
x-forefront-prvs: 0671F32598
x-microsoft-antispam-message-info: 75EAPG8K2ilvUrb10+RZMpelpUgjsK6FJha5YWH0I9xBoKomqpcOaPNnhVgf2riQDWrA8fCJLLEsb4LIpXwz7+M9iPhPJF611HNC8vl9bG6M+Dy5NStCmGi46Wz9v2lD7AhgzN19vLsSDXc/dXKOSQnKr0QpPjdhgF1RwKC5qyj253yF5e8bOzaHKuE2hgrsRDhB6VMEKvXPjKFqxkmyiofndbFjcOvtrnVLUwqoGvs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9f23d892-530e-4432-79af-08d5b88a31db
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f23d892-530e-4432-79af-08d5b88a31db
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2018 04:30:02.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB0895
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4D4UFnC023317

Per ONFI specification (Rev. 4.0), if all parameter pages have invalid CRC values, the bit-wise majority may be used to recover the contents of the parameter pages from the parameter page copies present.

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
---
v7: change debug print messages
v6: support the cases that srcbufs are not contiguous
v5: make the bit-wise majority functon generic
v4: move the bit-wise majority code in a separate function
v3: fix warning message detected by kbuild test robot
v2: rebase the changes on top of v4.17-rc1
 
drivers/mtd/nand/raw/nand_base.c |   50 ++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 72f3a89..b43b784 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5087,6 +5087,35 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
 }
 
 /*
+ * Recover data with bit-wise majority
+ */
+static void nand_bit_wise_majority(const void **srcbufs,
+				   unsigned int nsrcbufs,
+				   void *dstbuf,
+				   unsigned int bufsize)
+{
+	int i, j, k;
+
+	for (i = 0; i < bufsize; i++) {
+		u8 cnt, val;
+
+		val = 0;
+		for (j = 0; j < 8; j++) {
+			cnt = 0;
+			for (k = 0; k < nsrcbufs; k++) {
+				const u8 *srcbuf = srcbufs[k];
+
+				if (srcbuf[i] & BIT(j))
+					cnt++;
+			}
+			if (cnt > nsrcbufs / 2)
+				val |= BIT(j);
+		}
+		((u8 *)dstbuf)[i] = val;
+	}
+}
+
+/*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
  */
 static int nand_flash_detect_onfi(struct nand_chip *chip)
@@ -5102,7 +5131,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 		return 0;
 
 	/* ONFI chip: allocate a buffer to hold its parameter page */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -5113,21 +5142,32 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	}
 
 	for (i = 0; i < 3; i++) {
-		ret = nand_read_data_op(chip, p, sizeof(*p), true);
+		ret = nand_read_data_op(chip, &p[i], sizeof(*p), true);
 		if (ret) {
 			ret = 0;
 			goto free_onfi_param_page;
 		}
 
-		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) ==
+		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)&p[i], 254) ==
 				le16_to_cpu(p->crc)) {
+			if (i)
+				memcpy(p, &p[i], sizeof(*p));
 			break;
 		}
 	}
 
 	if (i == 3) {
-		pr_err("Could not find valid ONFI parameter page; aborting\n");
-		goto free_onfi_param_page;
+		const void *srcbufs[3] = {p, p + 1, p + 2};
+
+		pr_warn("Could not find a valid ONFI parameter page, trying bit-wise majority to recover it\n");
+		nand_bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), p,
+				       sizeof(*p));
+
+		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
+				le16_to_cpu(p->crc)) {
+			pr_err("ONFI parameter recovery failed, aborting\n");
+			goto free_onfi_param_page;
+		}
 	}
 
 	/* Check version */
-- 
1.7.9.5

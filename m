Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeCNKtT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:49:19 -0400
Received: from mail-co1nam03on0059.outbound.protection.outlook.com ([104.47.40.59]:52352
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751131AbeCNKtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:49:16 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <nagasureshkumarrelli@gmail.com>
To: <boris.brezillon@bootlin.com>, <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <cyrille.pitchen@wedev4u.fr>, <miquel.raynal@bootlin.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <punnaia@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: [LINUX PATCH v8 1/2] Documentation: nand: pl353: Add documentation for controller and driver
Date: Wed, 14 Mar 2018 16:18:14 +0530
Message-ID: <1521024494-30632-1-git-send-email-nagasureshkumarrelli@gmail.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--10.615-7.0-31-1
X-imss-scan-details: No--10.615-7.0-31-1;No--10.615-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131654981543436926;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(396003)(376002)(2980300002)(189003)(199004)(106466001)(77096007)(16586007)(47776003)(54906003)(356003)(107886003)(86152003)(61266001)(26005)(6306002)(87572001)(105596002)(110136005)(55446002)(498600001)(83322999)(73392003)(316002)(63266004)(82202002)(4326008)(51416003)(36756003)(9786002)(73972006)(2906002)(6666003)(48376002)(50466002)(336012)(76482006)(8676002)(50226002)(81156014)(2876002)(81166006)(86362001)(2201001)(305945005)(8936002)(5660300001)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2542;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT005;1:uLQW32x4ZnNnIMRWwMEtQVVbAU8uz+Z4QU1+n1sA2fv+hTs4Z/c0Lw3MT3DYpPPwMn0spTWwUtubzXcXtxUGSxeZAc0CXxF2nSZV8o3t7d5FYtlIcQvC4p3Xaho2Zq3o
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a77753-84b4-49d8-1916-08d589993a3c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:MWHPR02MB2542;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2542;3:xOladEg9OR9dTvVRoIZmvXWdwWgKSQdYN64KckkvDA4BzeK72wXNpFatp4deMaMg/dl809RByA1bm9KrE0ncMeoBIuagBMxLXOfpb+FxX5eiW/VFRWObXy6rftDSIZnCMjGdD1zQ0ZfgCQn3SIfTL3jAg08+NhfcTrJOZfsbp20gdBkiv+6RDov95DNQqEKEQPGjVmScSq15d2lFtaAbX/To9sXyLPqG6d/arUiLzMyMaXUkDq6vp85JAmL+ozS1Po0rt7p4wfcgw3v6i0+00RP9EDX1dL1kxtMhSaKRnd0fg188fyUCe6tpcqnEXGkGNcf0oZyv2rses+Y/Jz9DfGXKlzSPnmBGgzWeyhGY688=;25:vb4aOkxe/NI3nFQzy1JX0gGKPX7GpI7U50Fl20Sf2l1GSTAQJMLT4BNxywxCg2beA5/fJl3sSXukdTJgqZqbGRpeYQD3vQuO+ZBKCK1KtOf9N5/WTsGSE70WT5OuJSuLd9zDS4lJJkR9EZtmU7fONwMuWj1yTTWQ1kWrxLbmEQf9QJ6vZYzSbEhMds+imrVeFjlPathFkydnbBSdTVlIdiJ5I0lSh3ECUOlNE1Y94IzGFIhxUjRpt4N6JQlHWzachtTBdUsvoc99goq6QTxa3omFFqIBJzXzdu9HTbPOAuHXQjC3Eh+bhzBYox4DKcFQYHzu1u6n1Zja5yqS06mJWQ==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2542:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2542;31:RoQJ1QWjGwCE7NSs6oIJf/aRekbBCYWqU5d3HjGFff5ialsRAV9QGwUUDkjfkkbtHTPsAn4I5kTjAki3EKJSRXvEQrVGA3DvuKFJGk+aCbWXJeN+mgEuy2ZRlNLQ9wg9OU6XnQnOClWAsG5q7pu8tiPFlw1YiSBwso1ejs+Gm5ZeJveMGIWoL87WwsFBiDFRpiTXaYEV08wurl03zuzBpAU6L5+NwfW22F3KSuFt5k0=;4:cmje7TmCS0eJkT/U8QKDGLscR4mTmUdIXv4FBhDdE1LZsN7j1+bUrdpedtyxmSDXdq1ENtEgACdhZ2Ns2Co4/bGfXQqXUA3GzwNYhsb0IkRBjm8tXmo4feqFH89jmfxBq/BhLtmg6ebTRLW1xI9/jjKePmDtxdG756K2iZkrg6H6kGedXXoxNOnNR9Jf+mg4D6mSflKvk5wVmBz3ZwNLXVJQJ/PWD9HfvaKx/5aVpKSxrYiXd5mOz7lxNRojsseh32gzco6ZlVPsPwSMeXGvZ+yphJk7Qp3+Z7BU1xnQDwx8RmC312d5xsTc0GXc1PDx2qKVYklrQRUPHdU9KnRsHBCi+YDJdKBSW5c5+Uugzqg=
X-Microsoft-Antispam-PRVS: <MWHPR02MB25425CA850F4350A257A3F03C6D10@MWHPR02MB2542.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123563025)(20161123561025)(20161123565025)(20161123556025)(201708071742011);SRVR:MWHPR02MB2542;BCL:0;PCL:0;RULEID:(400006);SRVR:MWHPR02MB2542;
X-Forefront-PRVS: 0611A21987
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2542;23:XDtepdve8J38F/VdXj1uMJsahBxLNhAURrGEpSIUd?=
 =?us-ascii?Q?d2K6Y0H3jzvkn8z1TRrIxXCTkl9emY7dODPJy85WJhn1EmNQfPnWBmLvzlw7?=
 =?us-ascii?Q?gDQ5WmxQqBE/JdjvMjx8hIVmpBV02mSq9WFad+eeTCEWfSr2MvrlfsmH2Hm9?=
 =?us-ascii?Q?mfDMaetLPkDdw1ALnvVqugnLc6LXfZRQhi4X8r2uULUzfSbjEFaTvSfAle+N?=
 =?us-ascii?Q?MRCrEGFpo8aKJgzN0Xmf9bKdsFRWm9rhJfZj9jkaWgjWnxfzu6HJbMYIocY4?=
 =?us-ascii?Q?xSF9Xd1V/PzWmTfR778GFnHu0nQvj67BBBKAMyF/HS4KYkkfDUB81Wa1xKZJ?=
 =?us-ascii?Q?h7GBzP2RmYPpNvqvEM03TZb49GqpilZaATj4czcxrqZ/84mbH+Umq26m8LrA?=
 =?us-ascii?Q?LKHCt4U0G3nyithYLYEqY4A7Gb57Db6kz3eiUgpocQWYD2csp1i4y+3LG5ay?=
 =?us-ascii?Q?+2FkxIDxAsO+3S7Bkmh/EXGv5YYJPcxTyln1QIV//HpHKjGsB1cN8ARYZoVY?=
 =?us-ascii?Q?82Eh1juzYWbNfOJQJwUBnAN5kLqPoT1u/VWVtUY6N2YjxoHeQLsJ91tFPkku?=
 =?us-ascii?Q?ML2kRr5+kUPIJ/W1rwYUHnw5eEL3457Grax8zayPLKix9IKb6oJroHU7ZkoP?=
 =?us-ascii?Q?yjZJmyg0qbN9uCOrq0JUnWLu6hCjIgTHj5BNGKz6dymBjrOlIxYTG5VUQ5rx?=
 =?us-ascii?Q?EsosFEyK1zJlz6PAHuDNKM/QUwKE9TAylscKyPBSHU5yCOSGsTvMSzFBEcf1?=
 =?us-ascii?Q?xmaE+pojmcmdYWaBg20NnzYmNGpgfL+KAaVHP2y7+bgMMEgxPDoGKMfbDpdT?=
 =?us-ascii?Q?7pvGPEG4JsWa42NKsAfEEmy5t3bLrTaJopGZ3hah8wOBbbA76ynJxHo7XhqX?=
 =?us-ascii?Q?kmQtelcXZEwZChnayUAEwKjvnmETXHa+9lxuIE1esUo+BJ4pb1n9G2PLRjLG?=
 =?us-ascii?Q?lIAsqlTVZEUxRXopRo0igV4aSrnmQaQ31Lo5VM1svSoO0p8xLpzls6QNVGCk?=
 =?us-ascii?Q?EjgSkV4ocoj4VRxIF7PJHxMS8IVivmLUPMW3UJPkjgtHQr0NiHoNkak55SNf?=
 =?us-ascii?Q?aWooXTTF8ZNjQRtmfVgQ/wH11LQVE2rQZCVKPVM/RbwY3l/zXsO4h3LOFp+f?=
 =?us-ascii?Q?3fmYoCvLM2nUb7yRh6nsu8BE49V7Dt2jVrAcDcgpOrM2twgwgvJf5JCf1Eed?=
 =?us-ascii?Q?udcUynEhULjMLvCbyOQJ3eK7EGxpiMI7rjy?=
X-Microsoft-Antispam-Message-Info: D1nzciNFYjUi1J0NfdNzTreb8e1B/OtP3v998lru2o2l86SBxgbBHNdeNR8kfg5dRQkpxWdKnFM3wmzqBdL4NA3c2ouFSFzGEAU2NWPMEE0Ob7j/jIHIOf5ujGRRi74keTxlVbcseEiONZjtb/9xMs2Rnks0JKyl6VD0vG5CghcDyLwC8kRA8oBUOZ3jZ0MP
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2542;6:zWg5fvyWssuPJNu6X69jbl78L/ZapuxOKzyCHEgBkgcdwKamaRNB0PEkeraf3fl7tLcDEIGFTGKU1ByYRArGBMV8Pc4C4nt6wAzyCv0EVqdej1MxJYbg7QkJDbRfEoqseTceAmiqUTLZHYB1rdwkR6wNTPgjQc/ChOEfXJCppBtfmZvX9PPynBWqr0nfo6ygFnLfYlwTg3FLkVN3hwGEwlBH4Ad7RDNgQYR7lnGNPs8abacqIxg9HwM49t29MFjwEhQVff+shleYXPx3KaF/iZ4BXc4anQtUaxidEHppkgbuSKBOtTjvgWc6ZcRSVDfwAXXHIpKvC7LypPa3N/0LYo3iU/KbovWfEeazDlzvXCI=;5:v3ZJGwmfvEoSd562qRSDC0+1tRmIYWAUbCvGSvDcJyibe0XuqWZFBWYZ0GMfeq+T+GewW50VGM3S1WxA0lgGXxQ/f0rolWjqenyML+KhnPuGvwc1gZd04HBS6RvjBVQz6pQw4+FkEs0BGuT9i1sqzpJhprRQ8w8q2O6BI8P8Xwk=;24:83fqxXhHetOPzFBRH4xW4GbcxKWG43z5qCMV04n73O4UO3Pr6rcPfeXg6/t5CRsgEnHoonnfsmMjU1GpQvqgRopBpB0EG+bYb8jZ9y4nCe8=;7:kFtTiT8iWaeloh43A2XV7xkGvDpgMB7H10NEWk17TVlA5bLhHG48SWIoLcOZA5kPhYG7gFnWlyEJYRmZ0N9kg7DkKZlsaNJiuYjxjMnclDkYHS7ZDV7XcCCzhQgNZxLAGqWg/hc8TeLHGtP/erzqnYPEe1k5gWG0LUtUZYt5oQ5c2/ME9U8B9cX73xTZuEb0Vklnu49ox8HccYvwFxHdCw3l0n3mYf0SaPFZ9Ni6v9fuHaLahI44zd2Xe2/3ilJv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 10:49:13.7499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a77753-84b4-49d8-1916-08d589993a3c
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2542
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naga Sureshkumar Relli <nagasure@xilinx.com>

Added notes about the controller and driver

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
---
Changes in v8
 - None
Changes in v7:
- None
Changes in v6:
- None
Changes in v5:
- Fixed the review comments
Changes in v4:
- None
---
 Documentation/mtd/nand/pl353-nand.txt | 92 +++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/mtd/nand/pl353-nand.txt

diff --git a/Documentation/mtd/nand/pl353-nand.txt b/Documentation/mtd/nand/pl353-nand.txt
new file mode 100644
index 0000000..ac6fbd5
--- /dev/null
+++ b/Documentation/mtd/nand/pl353-nand.txt
@@ -0,0 +1,92 @@
+This documents provides some notes about the ARM pl353 smc controller used in
+Zynq SOC and confined to NAND specific details.
+
+Overview of the controller
+==========================
+	The SMC (PL353) supports two memory interfaces:
+	Interface 0 type SRAM.
+	Interface 1 type NAND.
+	This configuration supports the following configurable options:
+	   . 32-bit or 64-bit AXI data width
+	   . 8-bit, 16-bit, or 32-bit memory data width for interface 0
+	   . 8-bit, or 16-bit memory data width for interface 1
+	   . 1-4 chip selects on each interface
+	   . SLC ECC block for interface 1
+
+For more information, refer the below link for TRM
+http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/
+DDI0380G_smc_pl350_series_r2p1_trm.pdf
+
+NAND memory accesses
+====================
+	. Two phase NAND accesses
+	. NAND command phase transfers
+	. NAND data phase transfers
+
+Two phase NAND accesses
+	The SMC defines two phases of commands when transferring data to or from
+NAND flash.
+
+Command phase
+	Commands and optional address information are written to the NAND flash.
+The command and address can be associated with either a data phase operation to
+write to or read from the array, or a status/ID register transfer.
+
+Data phase
+ Data is either written to or read from the NAND flash. This data can be either
+data transferred to or from the array, or status/ID register information.
+
+NAND AXI address setup
+       AXI address      Command phase      Data phase
+	[31:24]         Chip address       Chip address
+	[23]            NoOfAddCycles_2    Reserved
+	[22]            NoOfAddCycles_1    Reserved
+	[21]            NoOfAddCycles_0    ClearCS
+	[20]            End command valid  End command valid
+	[19]            0                  1
+	[18:11]         End command        End command
+	[10:3]          Start command      [10] ECC Last
+					   [9:3] Reserved
+	[2:0]           Reserved           Reserved
+
+ECC
+===
+    It operates on a number of 512 byte blocks of NAND memory and can be
+programmed to store the ECC codes after the data in memory. For writes,
+the ECC is written to the spare area of the page. For reads, the result of
+a block ECC check are made available to the device driver.
+
+------------------------------------------------------------------------
+|               n * 512 blocks                  | extra  | ecc    |     |
+|                                               | block  | codes  |     |
+------------------------------------------------------------------------
+
+The ECC calculation uses a simple Hamming code, using 1-bit correction 2-bit
+detection. It starts when a valid read or write command with a 512 byte aligned
+address is detected on the memory interface.
+
+Driver details
+==============
+	The NAND driver has dependency with the pl353_smc memory controller
+driver for intializing the nand timing parameters, bus width, ECC modes,
+control and status information.
+
+Since the controller expects that the chipselect bit should be cleared for the
+last data transfer i.e last 4 data bytes, the existing nandbase page
+read/write routines for soft ecc and ecc none modes will not work. So, inorder
+to make this driver work, it always updates the ecc mode as HW ECC and
+implemented the page read/write functions for supporting the SW ECC.
+
+HW ECC mode:
+	Upto 2K page size is supported and beyond that it retuns
+-ENOSUPPORT error. If the flsh has ONDIE ecc controller then the
+priority has given to the ONDIE ecc controller. Also the current
+implementation has support for upto 64 byte oob area
+
+SW ECC mode:
+	It supports all the pgae sizes. But since, zynq soc bootrom uses
+HW ECC for the devices that have pgae size <=2K so, to avoid any ecc related
+issues during boot, prefer HW ECC over SW ECC.
+
+For devicetree binding information please refer the below dt binding file
+Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt.
-- 
2.7.4

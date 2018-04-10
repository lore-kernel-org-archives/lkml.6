Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeDJP55 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:57:57 -0400
Received: from mail-sn1nam02on0087.outbound.protection.outlook.com ([104.47.36.87]:16096
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752100AbeDJP5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:57:55 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 4/6] iio:dac:ad5686: Add AD5672R/76/76R/84R/86R support
Date: Tue, 10 Apr 2018 18:57:47 +0300
Message-ID: <1523375867-29616-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
References: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(39380400002)(2980300002)(438002)(189003)(199004)(7636002)(106002)(77096007)(305945005)(26005)(356003)(76176011)(8936002)(7696005)(51416003)(2201001)(478600001)(72206003)(47776003)(107886003)(5660300001)(4326008)(186003)(486006)(48376002)(54906003)(6306002)(110136005)(316002)(50466002)(336012)(16586007)(426003)(8666007)(2616005)(126002)(966005)(11346002)(8676002)(50226002)(246002)(2906002)(36756003)(446003)(476003)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3053;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD026;1:NOGuXZFxKwMArtC3EU6Vp0kzw/A7jDEXyP3YBQzsZnSW+jplWl3x5T8oZu1NA6moljtSmOZtJ7dzD5LTnisu5SKek/Xyo6/Ln1fgYORzOLlAio/2e/O5s9a/TaP0PWuo
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e536bb8-9e40-49f9-3166-08d59efbd117
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR03MB3053;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3053;3:uYiA/8c2c7jDRXm6e3XnyjIC3EZj7S4iPtAB5nHEvUoNjMSiGptvqRRha60emLO6k8lbuBQbe/4sh3kxfQ/zYjXdOMbVW1QSPxdKf6oODVen0ttfiAAzEtZxseG1jT8h7PeCN6XhXE0ojDJ7J3azfyYO4WsaAS620y8RVbR6Jgms+VUzadEvFaW1ludDglB2mY21jlAPStXsXbf0/+XuhSGv6sRK+9K4fzvxYmNkztCqoO3nP/jDOsFzhdzs03eI4+e/5XaR6LmYuZoaUVZzbxTkWZO1dwyOi0T+7Ehncl0eIVoH6eWKzF0PjvVKkQCM+oSAhNg5U3BcAOPCZ2mMj2RiuAGoSkcUIoCu5CW4Lo0=;25:KqZuVUzC7pOJyBuw+aDMdCGYEB3JNxnzFZLK+CfMeA4olKWGGi/q6mI8F45D/seURphjgOyr4jN0f50sBRWF2BNOWA0bxy1venQAmZdGEtQSDqRz9QWNDgXAMNR/2j4/Rn22ITWhQkuWj0948qrB3VBKd6ZR52ep1YqIdDQX7AcoB0Kv9W5lkamR2mbEYd81xTcr2zDnBlo56bSXCl4fOTpCMXk7mtjR7stHV4Az1dZSiMikHcMhUew47cautWihGW9w3V6Q6Lqg5s/ay1mnKqgtDnv2evk2KLgjjfYyxEyC8M1l8iwuogW8ctSeUbrpVkYAYLR3dkojac9gkg5dSQ==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3053:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3053;31:GZ0PuFubDLH7exCQ0c8MocHc9Oq64PF/HPeIf/1f6M+f5ye/IJo7KGZ3d1rpsfkpiMWWEX/JuFreRAPix6Kn7hLnFDZMxULRHC6l3PSBTS/BTEnWl5yKzqZ3pVoEeU8ZYqZzAB2DuNlrYtZZ2hSMTf+BtJD5zBDSQRBEcUAKhNU/mJSv45+2i+vQ62Dkxl+Q2zBEdLSM0XZWoGrc3XFxauj2FuzgWnPjRjGUXHOUS10=;20:PZ1UdsqNiYqZWiGH68/Qomgn0Lxl5KTdplMuhkkt/DE3MeqS56Yvjg8HwCSk74B1qx3YinnIdijP55MGQdjZxBf3KV/x8V54oWupdjOZOzQJVzM2gXwwjvaC1DY8poOLER6vcEFgqkHYAKgXmTY7g5i98BAhw1OfG1Djhr1agmcZn+8oab8PL8KVMvHsEw43/X5boyrX1fKLz4/TorOkM1jZucjazRwV75h3atViDUQNRokZPMT0134/fnQxJi/FJRTwUUQ+wtAnrCAqqXLgA7sOoTdRgAU1bvLphgYsG5ffWJ+K6VvCaRd3LbCDB7zkYY8XNLoxMQrcvGmELQlRDTH1tV3msgTG69pDpFMED5qC0/BI5WGFiq5vhL1cxvRHI8eosBmwpHdkjz1HSkavVgZet+TkTxQJ8BbukIJJRIniMH+3jcNEq1xrjp/qUDzS/v6HFsbRwQpZlfrF7vmrOJgkRo8UbV3i791KKpJqI9gY0Tw91mKhNrSUIr0F1N6H
X-Microsoft-Antispam-PRVS: <MWHPR03MB30535529E326F2B74294262F9DBE0@MWHPR03MB3053.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR03MB3053;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3053;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3053;4:SQUEW9vMxjpYX6AUZYZmupRRyZZ/wpzZ6poCU9WNn0zxBwjKnpu+m8nsB520qKgmzbLbbdh/cYoByzqYzWSRnAN5ppY5a0ibfqv3PeG8sXY5m6UxxdIHyjzoF/hB4uCwEq5pNbsyQ0zrz2GX2EbD/bNrzY8Zs828RRhLL5LNNaREZvdKyGXVdjFiHjr05Ap5kRGmb/CJ7qrLxDkA7xT/KHmq6wJ4cpMdjNBIiDSjCXVE53zhBtY2oRSyQpZzb1E3QX8PUV2/1rfp2uRCAvoqfYDpqNUI1xj7hhXrzG4uX7UoNsNMIsiZUkG9BZp998YT3/EMxB8fcRzmAoSCv4WTHunnM4e0oWBm8RhIz9iEvBQ=
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3053;23:knAGPyKPs2t67obsVboNB9AZmDXdcf/oubK20gu+m?=
 =?us-ascii?Q?UQWRyJ+QnUhQa3yc0N9taiNa2Pd/l3661+EmGN9JrZ2ukmEstIYIeOitV63c?=
 =?us-ascii?Q?B3/NL9QcUbsMzW8jgK5ONqxU6ZPDMtXE+aP5i3CLrMa4QMQqO8qJO30dsGZv?=
 =?us-ascii?Q?M2k1AJ2ARTWIWdQqnQSGUlR81vH0yffZwXAXqlyINlOBPMSmtu63IN5NCaaE?=
 =?us-ascii?Q?5yUwIePe6wgJ3NPgMgv3Y81SW3cNIXHLBQoyPDe8SXCmBzdJhlb7tj55nuPl?=
 =?us-ascii?Q?l6DWgnhIhxaRT56GXtfQsa4GYgQIYE37tMk1duWTZXmQKFFQlYTkne/OPvMC?=
 =?us-ascii?Q?EOzXVMm73B4E3xJY/zAvDUTpVs3Fzrhe7gDnJFvhRUUmDxWXNn48DLeYW/uE?=
 =?us-ascii?Q?mYh4TgCOlaVgR+7IoQzrMS2+sYlDND2G4UJ8Dk7idlaPc6Fjuh3gY/jZQ+x+?=
 =?us-ascii?Q?CyqslG7s93r9WCuisLEvQGJJGPry36ImJYNpBkppRLF7ADLYTP5mHl4XXg0x?=
 =?us-ascii?Q?DOs6Mw7WU9qxN7RRGlYmB4PXYZnhAAwMGRAoMBIefVInUuzIA9WLPeXdl1mw?=
 =?us-ascii?Q?iKePgZNdrfRdai1Bv5TVl45lvTWSI6WH1BMGUYpeSFm1HpV9H1LK4JuYFEYp?=
 =?us-ascii?Q?795DZ47R3EV1YRl2ZjkjfhFVTKd2cKXME9ZRXZHBgQmB7dHGFYZTsdMLKeeK?=
 =?us-ascii?Q?VmExef2xtZayOFz2yQw2zz4CxnEbrMYajwEfm9HQZVyxyDATDvfhHCJjeUac?=
 =?us-ascii?Q?BVOxAM9HdsCpYnAJ+7/l38nnIo+tO9ceObwoSzlI1Yx5VJH1lrW7REFSP6T7?=
 =?us-ascii?Q?n0CRDNe+z/j0/TzEyvJO6zJKYaUiGHiIKd4KIoCOzz1PGibiNjesRu2/ZPtg?=
 =?us-ascii?Q?MqwPJig3V+tZ1lOV+AY4A/l3MKxiE7UC4EgQxlP3HFlB21tBUEwNX2h4QQlF?=
 =?us-ascii?Q?AHMG4fjHVxOfA7XvsSIXRoPGbNoXn5y7JrMdYhGL3aJk7e9+gBfYwTRZOMXM?=
 =?us-ascii?Q?JhatSjR/nPOX3CClXNbHmWUu7wyzAGfIWy1GhLIdETWzazR9RGN+qRkxsyn1?=
 =?us-ascii?Q?DlWRPEa6C5KLxiyuu9X4jnSV7hZ92yuX2ovD6OqjRtyNjOiIA=3D=3D?=
X-Microsoft-Antispam-Message-Info: vMByBwVJqawz5jD8s8AslkoiFNWP8HZWVMs+W7sLRd0ZO9f/deR5pEHlt/4WFGegBJRwIWpPIwztV9EH8mQ08WRfQ7cdmQ/Fdo9J+mmq0wworDAvpuac5OqBhSEWrh+c7tHTGj33o3ERBVzx1HT1H2WPFWByOuLfAZFG93ODBBwff6yk6ua+fHJammx12u/g
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3053;6:/IAuOrSUPA58N5TNkONYEFkytYwy2NYHnEpYkzG0nwmfb94MpF8G46rumhQh6J8dtmdxXrobH5oHGiclUXqp4JcPe9k1XFUA+SqoC5DkGY62UHswknoIeeTdeMR9On9aP71VLu9f+mbW6d4+Z5AvhfrdkMGCaS8Gsj0JYnfkEdLCgFncd3ljKMuE4cgsahpPx4PV/L7rNLNDBG7AyqXEDKTiNzfU+U8EiJwx1gEKoHD8fQ2bbNnkQS6xizJ3ogmSHeCsVIHuJP79nCR25/pQOL0T6ILuGPJ753I57FGb2YsqQsB9t6N8p20G8ITi1zrwfisif20SswqKemfcArQ6EPkg7WgjKJiel2um9W3bL9cSxIYPbQXYRJreKktN+H4xL0Act8UyHa38M/VhHcsi7OicpuoyYUoLiuHAJyimoNoCn/qKrEY1c9iGox28J9hyz7Df5LioORokdWH6L1iJgA==;5:ygUn6av9Gc0/0uIvGQXCML90t9b09cChgtJ5G4pWfjcFKTwQFHcKbbrKM4OhPy+/SFovPlkovOTtSDS8LYkmsWPbc2vvhiHW3K8BY3rfK0WcUzUSifqG92lqapsvPZwZToE2zvx91jq+Imh9Izvg5y2czNKlaZ07e8L30eS6E4I=;24:xHH5qlIumixiHTJBdyRCzsIMdS4dGAvw2tLKw7TwKAGLpGF8f2CXo5vIK/k4ptpyMPULmCeBowItcJ1iqTWNzYMqXZwMPn/dcRN1xQQJL+o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3053;7:RZNnYZHx0bw65zTx7Mtd4GaPgVfeYiCiRi/sNL4pM2nqt+0jn4F3fIjgrqt/bMop+jAU79ahW8JkDEJZVHYNqgNGPDwX4BjyAl1y5jwkVvKcftujeTwZsbeevNLQFG3sBBhHhGUha7vAdLvnrF2r4dYAq0YbInevU8H6DlY2rgyN9SNV0jCYCk29ybihtPO2tiPrkKu3Ib3r136u32MQTL8GVMEOLF180d5KnaDbB+wjK0ihR7a+Y0/WaGhbYoBp
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:57:52.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e536bb8-9e40-49f9-3166-08d59efbd117
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3053
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD5684R/AD5686R are a family of 4 channel DACs with 12-bit, 14-bit and
16-bit precision respectively. The devices come either with a built-in
reference or no built-in reference.

The AD5672R/AD5676/AD5676R are similar, except that they have 8 channels
instead of 4.

Datasheets:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5672R_5676R.pdf
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5686R_5685R_5684R.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch to add support for new parts
 drivers/iio/dac/ad5686.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 7353c03..5fb0179 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -88,9 +88,14 @@ struct ad5686_state {
  */
 
 enum ad5686_supported_device_ids {
+	ID_AD5672R,
+	ID_AD5676,
+	ID_AD5676R,
 	ID_AD5684,
+	ID_AD5684R,
 	ID_AD5685R,
 	ID_AD5686,
+	ID_AD5686R
 };
 static int ad5686_spi_write(struct ad5686_state *st,
 			     u8 cmd, u8 addr, u16 val, u8 shift)
@@ -294,15 +299,47 @@ static struct iio_chan_spec name[] = {				\
 		AD5868_CHANNEL(3, 8, bits, _shift),		\
 }
 
+#define DECLARE_AD5676_CHANNELS(name, bits, _shift)		\
+static struct iio_chan_spec name[] = {				\
+		AD5868_CHANNEL(0, 0, bits, _shift),		\
+		AD5868_CHANNEL(1, 1, bits, _shift),		\
+		AD5868_CHANNEL(2, 2, bits, _shift),		\
+		AD5868_CHANNEL(3, 3, bits, _shift),		\
+		AD5868_CHANNEL(4, 4, bits, _shift),		\
+		AD5868_CHANNEL(5, 5, bits, _shift),		\
+		AD5868_CHANNEL(6, 6, bits, _shift),		\
+		AD5868_CHANNEL(7, 7, bits, _shift),		\
+}
+
+DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
+DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
 DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
 DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
 DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
 
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
+	[ID_AD5672R] = {
+		.channels = ad5672_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 8,
+	},
+	[ID_AD5676] = {
+		.channels = ad5676_channels,
+		.num_channels = 8,
+	},
+	[ID_AD5676R] = {
+		.channels = ad5676_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 8,
+	},
 	[ID_AD5684] = {
 		.channels = ad5684_channels,
 		.num_channels = 4,
+	},
+	[ID_AD5684R] = {
+		.channels = ad5684_channels,
 		.int_vref_mv = 2500,
+		.num_channels = 4,
 	},
 	[ID_AD5685R] = {
 		.channels = ad5685r_channels,
@@ -312,7 +349,11 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	[ID_AD5686] = {
 		.channels = ad5686_channels,
 		.num_channels = 4,
+	},
+	[ID_AD5686R] = {
+		.channels = ad5686_channels,
 		.int_vref_mv = 2500,
+		.num_channels = 4,
 	},
 };
 
@@ -392,9 +433,14 @@ static int ad5686_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad5686_id[] = {
+	{"ad5672r", ID_AD5672R},
+	{"ad5676", ID_AD5676},
+	{"ad5676r", ID_AD5676R},
 	{"ad5684", ID_AD5684},
+	{"ad5684r", ID_AD5684R},
 	{"ad5685r", ID_AD5685R},
 	{"ad5686", ID_AD5686},
+	{"ad5686r", ID_AD5686R},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad5686_id);
-- 
2.7.4

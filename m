Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeDKLxR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:53:17 -0400
Received: from mail-co1nam03on0077.outbound.protection.outlook.com ([104.47.40.77]:27517
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753089AbeDKLxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:53:13 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 5/7] iio:dac:ad5686: Add AD5672R/76/76R/84R/86R support
Date: Wed, 11 Apr 2018 14:53:01 +0300
Message-ID: <1523447581-13496-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523375867-29616-1-git-send-email-stefan.popa@analog.com>
References: <1523375867-29616-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39380400002)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(189003)(199004)(186003)(106002)(4326008)(36756003)(49486002)(11346002)(54906003)(246002)(2201001)(50226002)(426003)(486006)(476003)(305945005)(316002)(8936002)(2616005)(966005)(77096007)(16586007)(72206003)(126002)(110136005)(446003)(356003)(336012)(7636002)(6666003)(2906002)(8676002)(48376002)(107886003)(50466002)(478600001)(47776003)(26005)(6306002)(51416003)(7696005)(8666007)(76176011)(106466001)(5660300001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3052;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC010;1:UHgUE8pqpuhJF8OMjXRq0vLxyTIQ8M817tNO8XyzMNnDl3JYdVBG8wv9oKtK3eQimS47HER9fEY4eRWoOTBRpOTdhrGnivsRjWdBHXlp/id+vSktVrVzdydu11ESVr/V
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR03MB3052;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3052;3:PkTmP6E8OVsLxIKNKaE4YCdBW/+2fj9ZbuNs4cFq7utMTk1OqQkVneBEnB9tL1vurPUImtnxrzxSJRpWXZFFVeh784lAKmSEr5jdesWYAqludYm8pjBgQHP9GOIVsH+0kTiJM3P0Rw7mW1RkTaVFudZqAqr72LHJzz8ayh9eAWcPoPomGJGnTIztR+DLBn0rmhJh5XGZ+BT4dRTxy5eNQqUetxYUcqwOXknItu5mTRefzQU1TuQASdOOkAi609PFSyPJ6Y8zdKVvpnBQ8YKj57gTUO6wdVm53mSf4FOAfrjqswuOyv/XT8zFXcxmPVarfIy2gsQ5U9/d0mhrIS2OoA==;25:zNsbgC3Zy9pjv8rYgDlm9PAZZyMdbnUw9CFPKfAzWXfNyUMLQbSSuQUXU55mrewXCT3vfB3B3ltcETEQnIduvvi7tHUQQlpN7uFTBeNU0c/0IcJbP9rH3LutxyyGy0JJQrl4HE+Le55XAYZVt4+Ddm5B09OEXEeIYiA08fgU3aOqrorpBvKD3bqxTbtwe2WwuquH+TV/FWDjZBrEjYQ6U9MiBp95Dok06eyZpY60HTQolYargjnNe7TXqUJgSAK/mzfhldzEm5Q5YMH14PlCxp7VSuuZ/iwxzeJFCrHdZYMFsbBRi2Qup1WjiUvMhZ14bHDSwfgpIJn5OGZov0onDw==;31:dBEIaO+iEUBaAIeDsTacsP8j7rKbX36wZhtAAj668wZLW8i1KEiVVjS3djFAPHLgCtEmiS2xhZ2tQ/6yDi2IYopezy3E49XUND/wEvDFlLoT5+zgB1wIJ60FKv4KJCZpishmhJFiD+RZ9aQvo68vqvvpAj3uObqKQdXWKHpfHAM1rHepoctdl0nnEUuP2rAExKKDmyy/LjDOzwAvpil6yIj/U45yf7J3/s6edH5Q5aU=
X-MS-TrafficTypeDiagnostic: DM5PR03MB3052:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3052;20:cfHVuVXUWDM2Ulw3TXaV4vwEULnJiuDQkYiFGqht5/JcxhsRYv13292gLXjyE2k/sHcbbKl4Aj/Y3Odc0mIK+R4GCg8zoBj7CKRaEaFWWIIEdEKb/778Xly/LUgyscbxdmq3C2Il9JRgR4AG7a+ErrdOEnQPUYjOXO9lleMTR93QmXHcrzrOxd1blch0A9yHarV9lsE/z7ZYp8C927Xz3fiCntkgzmxQ7lpHv6Ug2lFmoJ/qdZoKPt9emaYgKCxH7aOq1P2EyhjNunFYwGXjpMFCFFWKvzWwOHu4z9NyXQCQJdIKXmVETfnoEE1xdMnUNNfyFCk9ArVh3wbN7LIzIFwI5/Ph0q52/K79bjRMGHlbs+eHQ9C4g79cbf9B1jPSC2hdiAUc2kLpiGY0ydTJ+zYcGVlxGtpGO8U5h/TWlNgk+ul6F8xGYZZmVE4NZMG9byvyMvLV9bndnDHDdmS0UGL6Byc5ZyEncBljvh0nEf74IG16K2LVJlvgzgVIpTZx;4:xpSmYWfodcHl3Jn7oPsCAlay/J7yvogPxNHfYnEUzOinAsQxEkF/AE95aewRFxtIft5PQukbr2WcQffsSJoEOyIlAF3wzYP9NRKrmk2pRvv44iXBbm2LiUz261jdt04MEFXAgJEIJlRPCt3vlkysgvAC8FN/ebsJv+hg0rzZdVO2HC7fJUxw9HKOQ5D41bLV1VS4lBX3e7yO/XXJc016OWlSEJsT03ugPF22KBtuhx0vaJ8CFRXYVfqBOVP6nUsw3Y0226ijZanjsi0kI525oJDt4ainC+drXApu3h80i/Hcr48oTRKcNJgnhIlSaTJ0Vk6WBh1L2MojCWgMcbvbWmR78gVCsoCV25/b8ZI3i0A=
X-Microsoft-Antispam-PRVS: <DM5PR03MB30527AD7E13F41F6C00E35229DBD0@DM5PR03MB3052.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR03MB3052;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3052;
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3052;23:K0LwamNDktYOhhJPPBH+yIRSZNHqBS0PO3RSJ0a3T?=
 =?us-ascii?Q?ClJGzHVQMaAMGMvhOoAewBnl/sS1A3VEYeBRjOHug7WUHUdgplzfZ0anoNeq?=
 =?us-ascii?Q?FTUrM/WSVe9tHzwvgjMyuasMSYAf8FskS/rAV3FDwHh3hisWksLa2qp1h3U2?=
 =?us-ascii?Q?QEQCJ9OXosDLY9iMn0g8mxICVMpZvI2910QlsneeFlUKeNoZ6wMFbXB9qtzn?=
 =?us-ascii?Q?2GJMrv7d6N5rwZBE0wmNx36CqO2FUl+kQp1XMVwWCQap0L9RYysP98LdhS+H?=
 =?us-ascii?Q?mjMAY44AMBB8mFn1qzWlaAJId8yvoXip1F5Zph3RmaI5afMneD9EUlCGPkg4?=
 =?us-ascii?Q?eXBu/Dg+/NAGqFut0lb64zBCzX73mqvTQh5f0xeEn5HhnHMY7olbXMbWY2G5?=
 =?us-ascii?Q?lxDE6jSaSfKRVkbKZpLOmKyMMkboMiGVrVOFbVZA05AaSxsp7tyqLwfb4+FO?=
 =?us-ascii?Q?D3O2c6M/tYP2ZauMabDr50VAqHvMHx6TiqxRhYVQocwxkEFlaXOICsLQupVt?=
 =?us-ascii?Q?T7dy+0dLekPPSMhFohKsbKQvN532v1HMhUZFbPKFY+58+TxKDLDJYNY+jp9x?=
 =?us-ascii?Q?2Kj//mQpoqOFiy+qCuMn/6L3yKJGq1pnby7F4zbkN4PsYWBqDijCO46xU5gW?=
 =?us-ascii?Q?oj76NpniHr/NFGfaGjZy9PPoPAT22hLPvwpI4JLXyX3ER9B77yj28OaSlwLg?=
 =?us-ascii?Q?i06wHp+Nc2+/NaFHAPofGzzWH0UP+osLgvhLY/vfMTkWTi1S8DX+HkUySuzf?=
 =?us-ascii?Q?YujXmfx88m4W6N+zXHLORD5gtFKZmlgYmm+RBZB6wfclwEGjLCNQVQy2RfXU?=
 =?us-ascii?Q?Xh3mmgJVrNHXDWDhp8B50Bo6Cj6Il+qGnmCZTHANvdxQLpe7ONgzPB4PO/sz?=
 =?us-ascii?Q?jxPcJWCBJ5BwqQwMWkyiEijGs8jnCpQYrXzt9AFgufsqE5dhdg75kJ0u89f5?=
 =?us-ascii?Q?Qe4jvceTZVoo5UlLZGIkFuekye8Txbm9fxUuvnei7IJ3+XpAmtUybcBtYzPW?=
 =?us-ascii?Q?mt7NEFueoh8s3bDVAu3TawTGRDUvw14Vn9Y2/Ax62ZJYs23zlfRGzsaHYArD?=
 =?us-ascii?Q?TRK8COgpkz+4gkZjEwbs0JDUXRvhlJoXd6JTJFvF5DmVGNyVYCLspD2zUBcJ?=
 =?us-ascii?Q?M3/QiYdXbgLu0wvLtct3NdwczhP2zmvkc5TqV3AE57+FkcqqSKCC1ACKDZUe?=
 =?us-ascii?Q?+KFQ/2eaGqPTxTozGezM2WLcpvkX/2zyWI2r1MdbwVVBlOjxNzKr2zylw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: fU1VC3DTyOh2tBhrN844ruH+OcwxlIB6hwp5TL5wu86+qwOL5GDdPWTABmpIo1bSwuMtB961vOoUuLCC0fs7z9SaRN3XC/dUu+h4rNSlIFx8QzFhCRYyMPGBgUacPZBSbLjWi+jvxBO7yz2RP8sVNy0O8qBxed9FM+3ZhKRPwTTOTa+Kq5H3UDD2h4UmtaKI
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3052;6:Xwq/Vdeha4alvge9ZpDn8fI6MUvA9ietoepQ/wrFqJPBxeMUq1HmPoCb4uih8lOydfULp4JT7w7qz/jdIb+KmHd47ysWVqLzA/v1jAD6SCy3fd+wa2RuTiX3e7bZp0rjKep7iH4s+ySpM9dn3iZ9WFAwKhbe57AhFFp3GqYinplX2wDlx++GFfa3+GJs7c1P0syUenzSSMXar/yKbsYmakBFTDGOETD29HsVThy8HFtn8yF5G8t1WE9GCfpCyqgBIXWGnVxbRI2vc5PKONQdRW+A+SYfhjNxLCKHGQyIxODC0nIsexMVFXcLg/j/vk4/A67pNkWczSXnyMqBKQ2rSu9c34FSKIfauMO5JrrDt07y7W7NkAcT6JWTkBq97LNhBjONQOlD7S+fn3nuoUVeWiQaUAW6xmkewnkcBN+vuDdkR9swpFt9/X7w/g6S4KONiW22G+Emp+WV1y5DxiwYWA==;5:EVU8SFinqIzafRvqCpEJQwNWg0wFgs1s/oXJQWUEPLI8PnLEIMW5I5MH7OaaQ5AkuXjWD/mPkAvyycXzePHxilUvJbah/a2W35Vh8JP5pPLor8hBvTuF7m1VnM3ScDO9zyHkTwau/Uvb2ncj+VYFHZIKE18MBUCflOlT+0IxP1k=;24:tEMjbLRAa5KEn3GEQ9N8qvDvkjzDhEJF/Jo/8NlKo7LsXxKDdOiXFH2cTGnQOpxbaw64QM3d3mPMC6CHkq/8pEmgSjMy5U15MyEFbp4svts=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3052;7:8ttzSPTu+mV+qQKjOVFApfAB6LMfk2zhEwoK3W4ETufmj9eibTeGRg57qAqNU5W9XJC/2wh8ddw9T8OjMFEBcRpTSlKCeCNPbkuu2XT2J41jU/LCRhoWvxhXmVaxaQvPptQe9uKieIaeHaeiwr1Q4wRBl4DFHbE3/LOpBStLdZleZNkxkkPsIrxIrEbxPF/MVp1RQiBX6EJ6VPFWjzTG49kzehV+cifFbu2y5yIcpintOe4jhVx8X7pfWB0LV/Q0
X-MS-Office365-Filtering-Correlation-Id: 0ca018f3-d4c9-41e6-b35c-08d59fa2cc23
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 11:53:10.0111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca018f3-d4c9-41e6-b35c-08d59fa2cc23
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3052
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
Changes in v3:
	- Nothing changed, just to follow the patch set version

 drivers/iio/dac/ad5686.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index a753ffd..54f67d5 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -87,9 +87,14 @@ struct ad5686_state {
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
@@ -293,15 +298,47 @@ static struct iio_chan_spec name[] = {				\
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
@@ -311,7 +348,11 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
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
 
@@ -391,9 +432,14 @@ static int ad5686_remove(struct spi_device *spi)
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

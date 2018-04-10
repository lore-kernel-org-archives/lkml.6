Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeDJP52 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:57:28 -0400
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:62159
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751856AbeDJP50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:57:26 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 2/6] iio:dac:ad5686: Add support for various number of channels
Date: Tue, 10 Apr 2018 18:57:12 +0300
Message-ID: <1523375832-29402-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
References: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(39380400002)(376002)(2980300002)(438002)(189003)(199004)(51416003)(478600001)(106466001)(76176011)(36756003)(7696005)(8666007)(107886003)(54906003)(110136005)(2201001)(316002)(47776003)(2906002)(72206003)(356003)(446003)(16586007)(426003)(50226002)(7636002)(8676002)(476003)(305945005)(5660300001)(486006)(106002)(77096007)(11346002)(336012)(246002)(48376002)(26005)(50466002)(4326008)(126002)(186003)(2616005)(8936002)(6666003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3056;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC014;1:6fKf3AOEscMJvtIsbJqztLyTN0F4gEHTOumMKMczVN3MqeCEmrExXgD91AcYAHNSQWOGeivYiRcqXdZpCeFe+ykpBpV6UKWN/B1hwfiDAe2i/JAhpAJ/6ANlTP5qu0Oz
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR03MB3056;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3056;3:yWqYKg6DAmxXFALXCgLHlPwChC5r5beoAXxhEESaZEgFb/m5BBWdrsfofV4eCsHIiGa6z7bNMhPz2rfa3GmuWiu/wOj9Enz9VbQXQxfl0R+5tKmFQeQVr60/YJ7o8Oua75EyMRmW94lh3jzt/+sVg6PAP2hJTklH3FOGYnwEI5map8W5yMQO3iOLlzwEv1dc7BJvM0MJTGozDgSwm6ljl7sCb5143gbn7VR7UcVJ4KQ9fqjMDpoMrSn+v5z53XUoItXFnAJuOyOPaBiQY7AEt6gfKx71/uUYdQQYUewrempgnWz6fnKSO019WzrDOl/5sxZ+lFMhICPMBRZXa7GZn/EfyCMOYwU1kCmylJ5oqe4=;25:7FcuASztC3xg6lYFXC57ml+n4e2iPv/DIqpHmWxNO39HG2scgIqhg/bFSA/lI0tae8CtezI09vfz0nCt1KO47JuPx0LGd+gdnUy1wfPS0NX4g22oWjCu0uGNN1FxKNjeSZ2gHyCchcZk9wPDzm+mdEgN3M7szz94RaWohcfQgUxnPqlMgnSFmLxnlXlkNCoNRRBdBBopgn4iHf+wyvrnVDQYnFcwcA829kjxmvmI6ApZU3nQj2sH6fYyQ7CwdfN43rpY6cFngPyerQ/CZOC6+lDXd1grhWTPXvhWKFdxbUauysTwve0xEa5dWY/QtQ9eh6E64ze2p41laegZedT4uw==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3056:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3056;31:q5qbLqPidNKoH4XkrtCMWJSRdTYU6MMr9c9xRICY1W5vzH9f+lYupaOEXpOgbDstjVZeVcRFD2XujOnljuKmvHa4zai9HawECSbxyAGKLquV5WZKoJO756WcFDb4jahoAyzCViCexpjbc3f8C+u8nHcEyy7mPhKIMFgU2mn3r4RLY6RdnYlHMuOlDy2dm4ci08aMBts0IfRmz5kPfK2UzaBK+hluyybeSz2FXG4h6k8=;20:Zb6QhJMJYxGH3HHq8N/EAjyZI5xYzqkEE8siEBj9V6wnnMBtDW4NAMg4AYY2VFPymArwNYX2wZKB+MYy6gQ6g1oey8akxL6FnpVt+3G58O3E7fCKiqbum+Akoev1Mfi1xS0usm6FY9I+vI9EnySVnIEOznxzgHiQ38Gdn3xWFytnmGtzkiR0JXJgaLw+XAaoz+zGkgkhlzIGG7vJrngLGAKkwXFJbHVSSJ0tkbVN7/toNra7twRibzJ04fdaOVKDQSIDGyJzQHV12qc0l+3Gq2jOinVG91WMlpu1u8fSR856RUL6hXUMZyB8+5YDNXdThuC+DFrpEZo351/ZeYa14tUz6EUlOg3+xPJA+iWM4dSHPzUy34taldxwPw+K+er/KS2I2kyBzrCa4VIuKk/7V5TxfU3zKMhUSGfuJX4MnbVzW4OF+v8r/WuVa1K02b8eLj+qVPlHNfpDUsURmZHZuchbEWaDIW8tXzV5CuAhKdXQ3Z2DGBjMGiV4m2yOoH2b
X-Microsoft-Antispam-PRVS: <MWHPR03MB30561957CDD405A2AE0C31AE9DBE0@MWHPR03MB3056.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR03MB3056;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3056;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3056;4:9tV4zgj6uDXTr7mP1A3q3xOwGyh/nmi3m/0mWCzZiWGm+wqVgJz6++hC3h3mOXyL/UXa27iPPlvkyrhy11D4Bk9xUCWd8NhdXEt/Tttj3QbFQ1pbNrFxigGfrY6wv1SQuUmCxi9Q0Kro8FtcxS55RT938uRs+6wXqPeq4NsOCEuiVfqiYzaIYj5LHqQ6Ghfn4mPCHRdU8F+Dgd9W4LISRfrR0fXkeGdAWvVe2DUBHZBPDxP7nhjlWQ6RpISkIfeneRJrAYsIsdpGYvAAY162+eMp/uoMDzvABHhBnwe5kf6sYj5oPyWcvHZ3i+z8zk+f
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3056;23:apSrzx8qEA/n15cvm62wGQ913nIuq1jJYFTbrokkZ?=
 =?us-ascii?Q?e1xKK8ht4e7na+xE+WvjTxk6n/kJNcWZaQ6EB4p9jbZF8KeMNGpNBe8QGOAN?=
 =?us-ascii?Q?PgfwtVCS3EMhHzpIiXVwCow0CDDoYko6OIV8sF3hC20O/bzOy6XBfxcwzC2s?=
 =?us-ascii?Q?RHICmLX5fT8zeb3yAV1ZI3N7TM2HUX0sOrT52zjemOWlgBKoLmuDZ1RRU7gI?=
 =?us-ascii?Q?+lLQMm9uVZPtoBN/93hEJuyH8fxzQ7o+LCRvxK0Hxq5fRGH6OjUdMLSAzdml?=
 =?us-ascii?Q?JwtEZWEAGW0MvjbJl2WH6qtSWPrxI21LseoC4Bd8SGnotPN7NKVELX4LbfTk?=
 =?us-ascii?Q?RPpIk/6UqB+JmbC/UheTHRytMVJoLuy1LyPhV6fA5vvwQ2CDKiB+TwgThhPN?=
 =?us-ascii?Q?+X1owbJyES7ZvSUy88W45SorHp+2dEBGsBDL4W/IfGJaNH9K6m0Gqolf1xIM?=
 =?us-ascii?Q?7a1o7vcl7fCgqK3N/AFvnsAJcBEP5Mx9s3asnHEM+RBH3FuGYu0n/wr5tevy?=
 =?us-ascii?Q?B0P+NTYoJ4uKJDdCHaCkghgF8J9M5rnWqAAuJMPSxyMtJumWEZsccCEImhI5?=
 =?us-ascii?Q?WpdPCbzg2Yxm3yVPLdyxJGC4/2K+ocKCRUFEB9eJ/Q5LyWnom4hm0CZLJgJQ?=
 =?us-ascii?Q?XX0J52ItrrK5L6B+aib/2Xoh3sG5XnIaHKx08WEwIIaKY64zfN+WAV1FSkl9?=
 =?us-ascii?Q?g8IitbTVnEXjHuHPCnpdR3SZluVdKPnZXV12izaUouVhZvWhZZu/kG6bphXj?=
 =?us-ascii?Q?8HTgcb/+RIblBE8KVETFP+nQNSOOj04nFIPbL/fazoTg6C4yh37zFnxnj3yJ?=
 =?us-ascii?Q?3FRmafjsE8uKzCf8Pi+QPT2G5hnTzHOm1Yv0KzGsnoxw5hlQkgYn6Ekdp8lB?=
 =?us-ascii?Q?iDdaahzm2YlAgV06HxfgdNy4iekKzqFTAyDmfuEZwfEzlfPXRUyRcUacBYQ6?=
 =?us-ascii?Q?AUoVgf3SX4tIpEucNdE0B9m3t++DsgfGTss4Ve1a98oaEYWhO1AHP3b5sQq8?=
 =?us-ascii?Q?vlso3C2oAFOhSVZE4ZdNDHxwWmZ+dCHrD2oQMskxDdI/boR6dKUVHTlardRK?=
 =?us-ascii?Q?b3KnPoTGyihIUfnkNNG3DfAstaNEhzYyUBEKD5JUtulztd8zA=3D=3D?=
X-Microsoft-Antispam-Message-Info: iKb+rkxIp0n4pwXhniNv3TxsEYaGqX55/UMOQ/k/BSz0pRtWR3Y5CIsCnWHtxQsfnD2oxuPGom70ae8KqyCRnMPMPlb+DfATuQZuDfQypQ5stNjwYqZNr5vwsDdZ4APwsyXdvumtNAHQfEFpHZJSr3kn3dqCw8svmsFRizglqK/f9wM8FG/MzoY5cl7Eeaz5
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3056;6:bI/dQ2oDoi53V2LhBs2RPQ0+ptS+o18aL8LW10ltrB/x9zdOGY/yJwd2VuDwdCsk90CAkrCNK98i9lYsirfPXli2jVgPLqiU8o+Zpw1PctmF8r/LswEn9h2EvsP8pa5YOCl3aLRY/kri39Hc/rkbYSoxiSbJby9LcKhiFGCQAMEBa81A8KPskHnaJmxwkx6GJLKO0QEGtlpqiwap58hrTyvpnfYikGN4W6aIFglVjcxW7NbQxpTwp76z6bzIDfMJhbJc31pxVXie9mpl6vNlWKe0UAHSuEtoNKFJ9/ALPStQisfNc/Lu5Wd+qjcvXK6NK6gMqNUG/RoYjjT4402mDaa0bKbFAFljuwFECatnsk/2gpnoWuDMQkOXOx++JhdiEXnDVFoiwr92ruT0gafZ5IVHCEKxuff+OPsg4BmDHeSoBTqFna8N2BWCorbp3G/dWYrz/w3yHggpuB2b4eol7g==;5:uzvvqQ/D+Xi8LChPPWhbyc17bV4e+2cC3Cze25FguzxKVLG2nQbQpw3NonX42Z8Naaq+a/MJZXb+jKvpppqyafrk0ROdE4mahCYYph20WmJUkr4GgBzfzPXJtNbh0o0/R66mWKoFftVhx4wUUaT04ARZ5bva4hNfz+YD2ij5foE=;24:QuqibXybuD8wCHdIc4xddqGSM9DOG9Afv58qJgzCW2+DdzR9Zf+oStZqOGjuL2aY1vpFeH3HJNAt6mqkZsEYZmOdWmS4Z+eDbJViy9/ywSI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3056;7:g0zzkEO2AIiQU/2K4M3EsJcVwUvB91SV7eigyskiyc9vZftQs5mfOGc/DxQHfVaeORW6kk+uH5qyIvtbHzRP+xhj/MpLeECtJHpmirFY0+U/sPHAidZ0g3Mpd2785oyQBqtjB653g3k5VVMEjWA2XBIoGPmr5B/gcpUZCr0UX9zDpQdeX35It2cJ2I7z5bj/KFzlL/KRRrR+aSyvxSRbwT+EooP4qeeOmmE1aORapsneWbIQMNLvpeEr75hdRDMK
X-MS-Office365-Filtering-Correlation-Id: a52986bf-81f6-46fe-eb90-08d59efbc004
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:57:23.7073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52986bf-81f6-46fe-eb90-08d59efbc004
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3056
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new num_channels attribute as part of the
ad5686_chip_info struct which replaces the AD5686_DAC_CHANNELS define. This
is a necessary step, since this driver should support similar devices which
differ only in the number of channels.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch to add num_channels and the new macro forms
	  for the existing parts.

 drivers/iio/dac/ad5686.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index f7f975c..4d1ae3d 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -19,8 +19,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define AD5686_DAC_CHANNELS			4
-
 #define AD5686_ADDR(x)				((x) << 16)
 #define AD5686_CMD(x)				((x) << 20)
 
@@ -46,12 +44,14 @@
 /**
  * struct ad5686_chip_info - chip specific information
  * @int_vref_mv:	AD5620/40/60: the internal reference voltage
+ * @num_channels:	number of channels
  * @channel:		channel specification
 */
 
 struct ad5686_chip_info {
 	u16				int_vref_mv;
-	struct iio_chan_spec		channel[AD5686_DAC_CHANNELS];
+	unsigned int			num_channels;
+	struct iio_chan_spec		*channels;
 };
 
 /**
@@ -269,14 +269,14 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 	{ },
 };
 
-#define AD5868_CHANNEL(chan, bits, _shift) {			\
+#define AD5868_CHANNEL(chan, addr, bits, _shift) {		\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.output = 1,					\
 		.channel = chan,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
-		.address = AD5686_ADDR_DAC(chan),		\
+		.address = addr,				\
 		.scan_type = {					\
 			.sign = 'u',				\
 			.realbits = (bits),			\
@@ -286,31 +286,36 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.ext_info = ad5686_ext_info,			\
 }
 
+#define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
+static struct iio_chan_spec name[] = {				\
+		AD5868_CHANNEL(0, 1, bits, _shift),		\
+		AD5868_CHANNEL(1, 2, bits, _shift),		\
+		AD5868_CHANNEL(2, 4, bits, _shift),		\
+		AD5868_CHANNEL(3, 8, bits, _shift),		\
+}
+
+DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
+DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
+DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
+
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	[ID_AD5684] = {
-		.channel[0] = AD5868_CHANNEL(0, 12, 4),
-		.channel[1] = AD5868_CHANNEL(1, 12, 4),
-		.channel[2] = AD5868_CHANNEL(2, 12, 4),
-		.channel[3] = AD5868_CHANNEL(3, 12, 4),
+		.channels = ad5684_channels,
+		.num_channels = 4,
 		.int_vref_mv = 2500,
 	},
 	[ID_AD5685] = {
-		.channel[0] = AD5868_CHANNEL(0, 14, 2),
-		.channel[1] = AD5868_CHANNEL(1, 14, 2),
-		.channel[2] = AD5868_CHANNEL(2, 14, 2),
-		.channel[3] = AD5868_CHANNEL(3, 14, 2),
+		.channels = ad5685r_channels,
 		.int_vref_mv = 2500,
+		.num_channels = 4,
 	},
 	[ID_AD5686] = {
-		.channel[0] = AD5868_CHANNEL(0, 16, 0),
-		.channel[1] = AD5868_CHANNEL(1, 16, 0),
-		.channel[2] = AD5868_CHANNEL(2, 16, 0),
-		.channel[3] = AD5868_CHANNEL(3, 16, 0),
+		.channels = ad5686_channels,
+		.num_channels = 4,
 		.int_vref_mv = 2500,
 	},
 };
 
-
 static int ad5686_probe(struct spi_device *spi)
 {
 	struct ad5686_state *st;
@@ -354,8 +359,8 @@ static int ad5686_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5686_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channel;
-	indio_dev->num_channels = AD5686_DAC_CHANNELS;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
 
 	ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
 				!!voltage_uv, 0);
-- 
2.7.4

Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE61C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63FD217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="MKD9bkSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfBSRN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:13:58 -0500
Received: from mail-eopbgr730046.outbound.protection.outlook.com ([40.107.73.46]:33975
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbfBSRN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3XDSMDA/5jfktkXGWoICBVli9a4nqsXRuMaNqaTKIY=;
 b=MKD9bkSSkjnH7uzqN5UTChzimj1OQxoPx+s5dCLSSDMr0DmLBsx8OjVvFaJQY/A0A9W1jK7jiDWrMyfpq+ydxYcaAhlcmb/FZNQ8ul4FCsxGR50b0yJuYJ1OqqH84/ea+wmt3DgqKTWNefMHoDUeJG13lG292xFIN2ZNoFWJ61c=
Received: from CY4PR03CA0083.namprd03.prod.outlook.com (2603:10b6:910:4d::24)
 by SN6PR03MB3759.namprd03.prod.outlook.com (2603:10b6:805:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Tue, 19 Feb
 2019 17:13:05 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by CY4PR03CA0083.outlook.office365.com
 (2603:10b6:910:4d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 19 Feb 2019 17:13:05 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Tue, 19 Feb 2019 17:13:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1JHD3rZ009167
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 09:13:03 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 12:13:03 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 1/6] iio: imu: adis16480: Use the default data ready pin configuration
Date:   Tue, 19 Feb 2019 19:12:13 +0200
Message-ID: <1550596338-24220-2-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(3190300001)(189003)(199004)(26005)(48376002)(51416003)(77096007)(7696005)(76176011)(186003)(5660300002)(36756003)(47776003)(4326008)(305945005)(50226002)(44832011)(7636002)(316002)(11346002)(446003)(2616005)(106002)(16586007)(8936002)(356004)(54906003)(6666004)(110136005)(426003)(106466001)(486006)(2906002)(50466002)(126002)(116002)(8676002)(476003)(336012)(72206003)(246002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3759;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c9d1b98-a791-4e3a-0974-08d6968d82ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR03MB3759;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3759:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3759;20:kKfuSKB34sX0k7pooAhD825Hw8cIusoKrCQ9UtZpMYbzEpBCT36FxOxdS+E36wpJOLfnatYhmq+W1aodz/fvpHF1FsLXyMq4wPpQ8/M1zSksaWnY4z+eJTBjBtrk5JgpVkVhWnGCsrMQtKVEk95OBVLamwsL1Ha7PNmOGfTOCHDdkwi/33vlbTp21FAUijG1uM2XmEoqGiWOjoeOBCNyAorssHW6xOt4KhQyy7a9G78Zu15CIEN6dNSW1ntMklYUeIIs4uj63ODb0C1G1T1vtisfE/Mdd1dyWg+UqPHbqZKiHePJLv11A+H1qBjjoGdX6QbXhqym3uKotAUFmKQqsymDqiabFlqiJtMoP1HWL777X2CzdKD2LsdQPkI3gffkLy9G55OJXpsMTq4K8WXT2iifMcrUL5zAYmMTacE/Vg7BcKvYzpnmT8QCmd/RCf/irz6/7sO7WDgFw+cW3l6PLKQrm37XxRbCyvDv/iqUDYZRF/Sl8dZ2+iwl+b9TR0wp
X-Microsoft-Antispam-PRVS: <SN6PR03MB3759F3E4A58F7441D391AAF49D7C0@SN6PR03MB3759.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR03MB3759;23:gV3ZGXfPJO55MlQY6KPPHWegaVXKKH+2dyOanwgOi?=
 =?us-ascii?Q?IkhWAcK+KdfGxOmyva/qKkTmx9IeUf3OSZOV0uI5NDHVgOG1yvmHLmLnIS/i?=
 =?us-ascii?Q?1DAhgDCEgrmF581SVg0oNeSrhTY8yWuI9Nkloj/8Pi9CsCQEM2X5ZDndFqmh?=
 =?us-ascii?Q?hoQvUkYPy+rhtBwzIWx5aNfANVBAAiV1bqhICOlK3lP0ZxQ7qjH2tFDLmxjK?=
 =?us-ascii?Q?BIAt4xjeW0rKtfRGYWazj0vyD5veLc9yn99bE40Tkqkm36YM7skBz4SntAIe?=
 =?us-ascii?Q?SdU9uK3bAtEayHBHLhuQkzCDWQELqAQeApVjjf3g320LMNo2rsGEhBALrWgP?=
 =?us-ascii?Q?+BaFxXv12zNFcQe4dm8l5ZTQf+5lrIypECu/brqxpecnid52x17+8mAvNnNE?=
 =?us-ascii?Q?lsHZe0pepMZ6cuTGyREexyRG/c1BrpIQASyl53pwk2HLOMibnBiH4NA5yt+h?=
 =?us-ascii?Q?cvbYTG9+a+zRPUMr8Hhs8WzYvKdvDbqJk7fP2OfjrcHuVQodZMCwNyNgC8Bn?=
 =?us-ascii?Q?t6K2i6lcvNjbs749SQhAjtEWQbBHWvFtc/Du3dVi5un4uI7w/QFTvFBplqyu?=
 =?us-ascii?Q?Ix5odSFRKNHZ5CKkKPpLcJkp/Bir8kN1uUopRG7WPZFly1F7isrPbZfVepTi?=
 =?us-ascii?Q?5Zo6HIDPHxZltS9hQRTX13F35X7NU4njcPycsEQtr986E6kbcIklBhjoie1Y?=
 =?us-ascii?Q?zt7M3vK1bDtsVoDQ23t9+e06BcgN/AzMDNJ5rjxVNwpI4RVzmM/Jys/8bq05?=
 =?us-ascii?Q?t8W7k3nUevChtpoYYqR9owNxiHJ3LRi8X3FHiIlwft8gJuv7W8Rj0ldpHWoE?=
 =?us-ascii?Q?eJR23x3Yf1V3uBeuM7IsdWTypWPtYrpmrH7zKEmIK/QdTzFvY03NcjhFMAh4?=
 =?us-ascii?Q?vHawttv2jG8lOWzfNetbp8iXg2T+qEOGLdIQtOp7aO1s253RPl3OdL5WQzzX?=
 =?us-ascii?Q?I9GtlG8rbWq8kwAieGq6/vBHb9np4pOEUsTjTgb2Q3Ga2Iu9Z68fqPeXENbm?=
 =?us-ascii?Q?3J0H22dZ3+Srbl6YvTZUcqiFW3U6DEchoCCcSLmewdWpCwiFe5WvBZhn+YJV?=
 =?us-ascii?Q?ylDTzI=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: iUKMpgfdbOjNHmvhJtAth4aBsZfNszdJay5KcZIrWlBROHx7V+4QnO96uBQHtedkXOVrRGoTw/acJs975H1hgwz263kOstRSpKaWli3VYEruzjQzf+wvSgI5lNX7SRvY20pluv5ffG+CIpy9Ka7nQFCl6DfGFYI9wZsoSodWnGEhTjvIp3GIQeTWEugai+x1oWm0VdfelFLYfGG2adCRlFZEWjIwWzG/RUqgYGskOfzc0/E44H32FM4U6/2rUdnVQT2Ghdg5IROugGWo1OmvhmJLQV48iW5wuTEsmbtppei8RDLm4M75fXnvu59JmEGW24L9vabm3JbVW/3DTVOBEeBkFdAFKQKipVw8BwPqCEKyppGMisEAakhNlIKcPeHNKYANRlvkcOkH7IWy4PBa6eTZaQTz3OBnoVjQ6YOXO+Y=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 17:13:04.3976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9d1b98-a791-4e3a-0974-08d6968d82ce
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FNCTIO_CTRL register, Bits[3:0] provide three configuration options
for the data ready function: on/off, polarity, and DIOx line. The
factory default assigns DIO2 as a positive polarity, data ready signal.

The adis16480_enable_irq() function, overwrites this configuration when
it enables/disables the data ready pin by only setting BIT[3].
As a result, the data ready signal becomes DIO1 pin which is assigned as
negative polarity.

This patch reads the FNCTIO_CTRL register and creates a mask, such that
only data ready enable (BIT[3]) will be modified when
adis16480_enable_irq function is called.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/imu/adis16480.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index a27fe20..d222188 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -9,6 +9,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
@@ -107,6 +108,10 @@
 #define ADIS16480_FIR_COEF_C(x)			ADIS16480_FIR_COEF(0x09, (x))
 #define ADIS16480_FIR_COEF_D(x)			ADIS16480_FIR_COEF(0x0B, (x))
 
+/* ADIS16480_REG_FNCTIO_CTRL */
+#define ADIS16480_DRDY_EN_MSK		BIT(3)
+#define ADIS16480_DRDY_EN(x)		FIELD_PREP(ADIS16480_DRDY_EN_MSK, x)
+
 struct adis16480_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
@@ -741,8 +746,17 @@ static int adis16480_stop_device(struct iio_dev *indio_dev)
 
 static int adis16480_enable_irq(struct adis *adis, bool enable)
 {
-	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL,
-		enable ? BIT(3) : 0);
+	uint16_t val;
+	int ret;
+
+	ret = adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= ~ADIS16480_DRDY_EN_MSK;
+	val |= ADIS16480_DRDY_EN(enable);
+
+	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
 static int adis16480_initial_setup(struct iio_dev *indio_dev)
-- 
2.7.4


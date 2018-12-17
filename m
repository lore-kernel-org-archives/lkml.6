Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3187BC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FE72145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="e0zHYuV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeLQMYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:24:24 -0500
Received: from mail-eopbgr780088.outbound.protection.outlook.com ([40.107.78.88]:27695
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbeLQMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efl6YdC5zuNQ/GgkPLl0lIMlcGZ7aQrZ+MS2QX5lRNg=;
 b=e0zHYuV0SJ3NOx+HtQH7UfPo3dV9Kaqes09p2mUSVoBZqMhSmpV560NmWzB2/lsbgKo0+gFPKILkwp/0ArFDgrdmPoMdEkwpylw6b7Waag1uU0NkeCV4treZT9mBFRi+pqCLWHdJOAL7B25On+/YIGkjZ76lIV802AtDqyPHmWE=
Received: from BYAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:a02:a8::23)
 by BYAPR03MB3717.namprd03.prod.outlook.com (2603:10b6:a02:ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.22; Mon, 17 Dec
 2018 12:24:18 +0000
Received: from BY2FFO11FD005.protection.gbl (2a01:111:f400:7c0c::126) by
 BYAPR03CA0010.outlook.office365.com (2603:10b6:a02:a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.19 via Frontend Transport; Mon, 17 Dec 2018 12:24:18 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD005.mail.protection.outlook.com (10.1.14.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Mon, 17 Dec 2018 12:24:17 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wBHCOHox016334
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 17 Dec 2018 04:24:17 -0800
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 07:24:16 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 1/6] staging: iio: adc: ad7606: Simplify the Kconfing menu
Date:   Mon, 17 Dec 2018 14:23:35 +0200
Message-ID: <1545049420-16484-2-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
References: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(3190300001)(199004)(189003)(77096007)(478600001)(50226002)(76176011)(316002)(305945005)(486006)(5660300001)(2616005)(44832011)(116002)(476003)(106002)(126002)(16586007)(50466002)(6666004)(8676002)(356004)(54906003)(110136005)(36756003)(246002)(48376002)(7636002)(4326008)(11346002)(7416002)(2906002)(8936002)(53416004)(426003)(7696005)(47776003)(106466001)(72206003)(446003)(186003)(26005)(336012)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3717;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD005;1:uQg2Ne+sarYRM4CfMAxfvjR6tmxE1YsDyY/CdJPvlspca2OPoLUr7EV4+lYq0TkIygMF5o8yqOYwEIw0+dDQnJSwuU2fERVKRqv0nETvH/lBMiMJc8HFgRpgWX2zAxHk
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55f42daa-0c36-445e-aace-08d6641a90ab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR03MB3717;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3717;3:hHTInnOXl/8aGNeOVt+3gtgVkIWz2LgCZ/PpfBxwePBqoXdkAMs03KZxGLt77jHMczW3KNNFbzZpTlHT5gwihgov7Iaz32cPtFR4Kl7mhnmTQFlvdkSXVPvqaylML1/Tod9KoicNKURK7q+gseCa+/H/sBflUIQWDT71oVdu/OWDvg3FIaXAIvw66hvFbs4lby9QunmLogc5IJPFXC1TmRl6NLoS07+0tWyObF60H+HH1vuyjAbFvE1DIBowySbCDvC9jVn3/rDmQ+3omLpx4O1hm9ypk49I/4nF9OdDaeuU2UV+R/8V7k34TJHZHi0XzF1Tnf4BT4RC3on+GHeOEe6UxIlNf0CJuox1fhI9M14=;25:axvDRGFhjpbfL+BRm482EruuLr/stKa9LxxRe7FMo4sOhF7rxE1202BMTjsYAgJWrDoIoD4aA/9uTsLYa6L2OKtg9+fWAFStsQucypRFkQiLGoAeOavyoVjcrAi6SYoMzMOkeg4o9GKO5j5GC+ZRASEZ2MQtH2iQB+B4WrDokKZgQDn04CzSoRJr1QppvC1EgHc5Un2+e9kfWBzUl2M6vLtH5I4b341V3KkncXtpJWZhvQ8u++dlwC7pgDnge9OVYnjwUoD9V7ZT1d/SmlcWNzSneRnZhG1Uh29lwUUzas/YEhaw9ks9Hv93WE0PaRfXF9l0wCvZ23p1wTJdhyxrMw==
X-MS-TrafficTypeDiagnostic: BYAPR03MB3717:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3717;31:PfTATKEi22J+SPDsPTi1WoAVxiR2TV9foYBJDmptr1UACdRDDI47PtoFT1ieaJl4KzqFPY6ACY9m5DOr09RnSt9swf1b3e0BHcC7TgCN+5aLBAGuWahLUVDekS+fsK2Or4EvU4em9+rKVNuLVBn+3ubN22nyqoY+XmamemfYYwiRthKDOq6Q7IGzt6BwOXt5vo8YvuPmTz1FDp+0ceRUW6UKgdnlO9hUp748pxZuoIY=;20:+Le7XTuxGnqicMWXTDqWM6Ny4Ff3Fi2NnGLNPZxDf86WnyMucOcWpzkFRU15B8J4fvAss+kAfaSEK1YMkYRYRQqgzy7RUoqADfsbVW5KggHIAkoDSHYAnDWtX7Z5GpEg1R6RiioVUZ9dHSht5FOlMrAccrOHrwfXcCGWvTnH60Mj8O+jY4qIDdisUOICDo0M/SG1DxMgF8KP7ikSJltOITfJAD2o/r6YQoF4j8PvqU6yQiGpaTDtDehzdF0O/H3BUHhduRw8QxX+c7ILZ4Rzeu/+hklWcdn2edRrbEHiL0lSjlyBAzVmMDXmiqKeIxnvlF0WLXS50CCAwh+mhwklCklCmWA2SacKMFzK4yY1MaQFRDRDSsedfw22uXEXCo9hv/qZ2xMocN/Cs6ecpTtsu0YlkZasXjfDq/q+uk56jK2wV/pTYyX8OUZfzglVXkVQ+Lu2TCin5izRlGC96dU3suEyhVqCeCjCimxDh/mP5VQaht9YCfcGUg8iDuDXzkCn
X-Microsoft-Antispam-PRVS: <BYAPR03MB37178C647FE8A2111B9FFAC29DBC0@BYAPR03MB3717.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR03MB3717;BCL:0;PCL:0;RULEID:;SRVR:BYAPR03MB3717;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3717;4:rVikKa0yBtt+35q51kXcp5SPzViN+0Di1w2adZziMkxyzNUe/6Pez8vmcW6XuT1z6qUPLtuanolZ/yzo6ONUj+joNjC4QslgPZPsvFRZ79RenQosp5BusDjv0n2Tl3Jur6PaXOsJtLEJkLozxr8eGEIcm/On0PELsgWDTPPV1JS8hVhfYxkc8S+CAtfty1C1kWXaz3W9MJ5GvUT+GupPzRx1p74IXyH+VAirud3JnTh0tiA0tO1Gm7qDRV3FeGKJ8nTT3i3BwnnwfO9/hPXOAQ==
X-Forefront-PRVS: 08897B549D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR03MB3717;23:aZOtpqLcpzUlsMD4XU0IAuRYbfym8jRP2j5yKkbxW?=
 =?us-ascii?Q?Z66P2Bmm4cIwrbYOjQCNhwroaedtGzonWcUaUp2+7YW1b+aTRoqg1p+W54ui?=
 =?us-ascii?Q?M/5LCnsl36Mkytb5Wa59UBMlPCPUCA5o9KR/cwwtSD5z0notzSnxNYnbM7YP?=
 =?us-ascii?Q?JZCqse2ESIi7lio7UFQPJE2tPvMqKLfR4Ew9OnOwNNXA/obxZHNFkgLkW8H7?=
 =?us-ascii?Q?ihC+GIw362Gmul7oGQSWbt0FDp/HmvM+3I23brwtAuQ19HtVvT0WKK+GbzR7?=
 =?us-ascii?Q?hbC4e9MRIdWzwY7h2fg01CewhHIACNBENHuWc40972t3dsS/L9nj9AoqcHkB?=
 =?us-ascii?Q?H7wgp6Jfe4XiuBEymEw2xzlGCf2Pf4T5MWfQjIk2gPvzuzBG+qMUIK7IU9eO?=
 =?us-ascii?Q?xAK0+k3qg7poOm+XM2BqKPG1+++Zsv/Q1CrRsMyu/5dz3TE7Y2H0g1gJrBPX?=
 =?us-ascii?Q?QqmO9x7D3DlmbhGHnYPqlg3Qlx0nykXM5nQg+Fy6wZfsn3YsPvQzVm49Ilim?=
 =?us-ascii?Q?bR5TvyOxx0hc3zA0DC7uVPL1xCb9W2Rd1ctHTZbqfapV96UqwsmZAb2UDdNj?=
 =?us-ascii?Q?you4MYyo/taaUb0uBl+4YPY6aznadIWhJnWOlsxBuEjiWvDALjmPVM2rhe6H?=
 =?us-ascii?Q?bVya3HBuW+D95hYey2K+xN4dEWoxt5msdAYOXtNzwwdh/H9ZCY3W1K0qHNhu?=
 =?us-ascii?Q?hdpYzPfDScvkRWAn0FlP3sK7+cJME1f0lK9D30FtjUILc4gDkkBix02Vr8Zo?=
 =?us-ascii?Q?Ze7chhKuYR7BixhkAwpo6mYRJy5WveJEffvm5MZbzII9OAdZuDjVVEVjwHWl?=
 =?us-ascii?Q?ucucbIviyQ5IbQW3h+VdYfWap1znqk1REbWpIOw7cpmucDUI2J8Q1x2mxZpt?=
 =?us-ascii?Q?y9U4vge/jEQwgOtBqOuNeZdLLLYErfX3nyCHO7m5Vno6e08WeAyI1yvCeO1n?=
 =?us-ascii?Q?X7NNUORSXNNtby4xAURSkASCrMeDOkZyDnsrABSszKRw5Utl2mFb1scYwp2h?=
 =?us-ascii?Q?GF4r+g+HfNmirMk3i0lsvJYoGMMyYyoXrBf1J+okak3FgsYytXU8IfpsLoTW?=
 =?us-ascii?Q?91GHfXCbwV4ZQtalsdKW45t5ZvDRxv4k7sQtrkV1rWjc6QVqA=3D=3D?=
X-Microsoft-Antispam-Message-Info: TUTUVQ80o9K0uNqPPusKDhCllr3qIXAiWvgQn14ikleQR5eY/i/h3ymJhC93RHWfyslDNwfNO1B0pD8sQICDTFgepQ6s9OZwK8/tZpMswjIU47Ld7mHKC0Wd/XhjJxAkNSOPe/EgDj1OEjIZa2mTRVWLTAtNwQpd+zvgxLYcgaGpOBBAqx6NX8TQ64mN4CTxVoL5xHik1ne0SUufITVUTfBbJvqubqSceZ2ec4chiG8uqgRy3WqywuM+4mQJcusKX0fBnNg+aoqoga3ejSWP1UeN1wzY2/8BozpDEg3mBTy+IpkJXzNLtje5idCwMkRa
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3717;6:JeG26eJ+UpJYkm1ykOHXG43KUU4E/PCEp59K2UjTzCf6Iw+6knw++L6D9T+IbyJhgxjqiKD22hWCvyXSx2PoCdilSDbgTDcwHg5ThWNDfVmksiXnqNRuG9hzQcZ6k6GA/vvQLLdEFVScvxx4gI0BeCCIhK0TUUVciXlOuPzmR8sQZ+p6DvQZ9LKZeKwGZBbWQIZdevzir/hurNqlJdA57e121nq1C4c1eFXERxuAED4OpFEgi2LlzS+LbKCd4/q0uTblaccRJHE2H4Oa3rba/kO8k1HHHm/qjEa25XPDGBmZAKZ9gw9wR76u772xwvxXJDyGRvHd3dUw1pO4aCpSQsU7X0zfSx2WGEqOol3P/7fOPZJI+wV470yc8+qSw0GEm1d7kCJkLQVMiM/d8Wv1Gf9L1wPULBQXKCDezXHdEnDgP3R4ZgaRWwArp+sZbiEwxhV/Y03H2Vhq/EmeSO34Wg==;5:ZKhni+yNW1XuRLdtYOyMNt5eL6HJX6VHi+TE/IeXtsFNumoDzwXs1ustGGj24JUrEjOYZXLaGw7qGBuMgYOUkpPxmP157S6b58UjLvuLm2KGMAvxAiO5M06Yx+7vTW2j1eQWYmZxgXKSDFGodKEi80WKL+BwB3m6ZX4vRn9osNo=;7:xN3vPu1zbmtWmgZammUzL3pVqmgaOAHC9v6Xo8riyw5eyR6Q0R9cviurd29LtO6jyAs9NwclCSAJhN+j0irSJDzWbjGQJf1PtyKuQ6rh+UcvLoVrOHQak9xM7gL7cm9OVBWtd/MkoXY91fQuRTkSlw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2018 12:24:17.5788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f42daa-0c36-445e-aace-08d6641a90ab
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in having three menu entries that can be selected
individually. Instead, the SPI and parallel interfaces should select
AD7606.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/Kconfig | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index fc23059..302639a 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -4,35 +4,28 @@
 menu "Analog to digital converters"
 
 config AD7606
-	tristate "Analog Devices AD7606 ADC driver"
-	depends on GPIOLIB || COMPILE_TEST
-	depends on HAS_IOMEM
+	tristate
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for Analog Devices:
-	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606.
 
 config AD7606_IFACE_PARALLEL
-	tristate "parallel interface support"
-	depends on AD7606
+	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
+	depends on HAS_IOMEM
+	select AD7606
 	help
-	  Say yes here to include parallel interface support on the AD7606
-	  ADC driver.
+	  Say yes here to build parallel interface support for Analog Devices:
+	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7606_parallel.
 
 config AD7606_IFACE_SPI
-	tristate "spi interface support"
-	depends on AD7606
+	tristate "Analog Devices AD7606 ADC driver with spi interface support"
 	depends on SPI
+	select AD7606
 	help
-	  Say yes here to include parallel interface support on the AD7606
-	  ADC driver.
+	  Say yes here to build spi interface support for Analog Devices:
+	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7606_spi.
-- 
2.7.4


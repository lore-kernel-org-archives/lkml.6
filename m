Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3928EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E5521872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="W1eXOH1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfBAQFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:05:08 -0500
Received: from mail-eopbgr790080.outbound.protection.outlook.com ([40.107.79.80]:51264
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbfBAQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV63kOhDvGnDomkWVg8Qav9Vz5w9ntKBMt4qM4a7hac=;
 b=W1eXOH1vGFJFbowEVEnoGhARkCdUH57HvzjuJsLD1HhZBQPRLzG4+Vdu6DzInoXkIo5Tm0ln7H8krX7gWL7Md8KiurW2UbaZB1q4jVjn3FjV/Q/mPLbQtlc3jSuniaexMLi7tgTLhK7sUWGzAmabEntIbD7f2uLCMGTyczFufxg=
Received: from BN3PR03CA0056.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::16) by BN6PR03MB3060.namprd03.prod.outlook.com
 (2603:10b6:405:3c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.16; Fri, 1 Feb
 2019 16:05:03 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN3PR03CA0056.outlook.office365.com
 (2a01:111:e400:7a4d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.17 via Frontend
 Transport; Fri, 1 Feb 2019 16:05:03 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Fri, 1 Feb 2019 16:05:02 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x11G50qh025011
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Feb 2019 08:05:00 -0800
Received: from linux.analog.com (10.50.1.104) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 11:05:00 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH] drivers: iio: Fix wrong license for ADI drivers
Date:   Fri, 1 Feb 2019 18:04:32 +0200
Message-ID: <1549037072-12770-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(199004)(189003)(7696005)(107886003)(47776003)(478600001)(51416003)(50226002)(72206003)(44832011)(26005)(77096007)(2616005)(36756003)(476003)(8936002)(8676002)(486006)(426003)(6916009)(186003)(2906002)(126002)(48376002)(246002)(53416004)(305945005)(7636002)(316002)(106002)(54906003)(50466002)(16586007)(2351001)(4326008)(106466001)(336012)(6666004)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3060;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT051;1:O7QIHMiFwr0oTMw6vdyrUw63H3KvUZNutJ1V1Va1YAqz1hK9WT6NSC3bnQaafqrOl1i0+0QBVpGBozZS9A1qaHlSi/haw3SUshdSETFi70CqMRraiC83m67ghZIrDoOYWtnVxFWg/KNgrYPN3Itb9A==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54083ef8-d5eb-4ba6-e13a-08d6885f067e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN6PR03MB3060;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3060;3:XhnAfWmy0YKZkvbh8RVX0H7MsqOLF1iIeCjDx5i4pJ7DYuCYKzusdhR0OBvsHaH187SQ+xBQla1HUiUuR+7l2GMifkQl4gR9IPX6j8VLt1S9wrT1gwXgRmkrvgjH4jV+pTdc/4Ogsgi3N2k6gmmOjoCQZsV+Sarc4AkJSjZEKC7jfDLKeG4KJuqssKzfD2ZEyG0/rRbpjAkXs8qCYFumFl67gxQfoluJAQyodbJirAlzwuj8pQuNwmZ64iHapDL9yEZ4gjTBvaUrsyu3MfKQFk8Y4p14HtH3wveyrSpq+A9SWCC7V2aao8jfW0SWrzrbDyNk/v9r6G1W5izNeURL9jtGfoDiVDL2+zWllxofQSOmPV912Z3sT+TTcoM87eB1;25:hap+eIP+4lkxbCNNklShtmdM3wP65DE/kU4an0b6+M+nmO47ZAwKM4cM1SAPJW70fHXYonu1nWweXlAO8oGXCdBymQ9kIxF6p/DRlhwrJ+eiB8JaM6xGzaGctTt3gFqHBYLdlph8C4YmRU0HH007ZFxCRWb6bj3HaQriNma1Ht9ICpac1p6m2dGdxmRxRV3mqxc+v13oZMNddCGvZSXTef1oLqXo3eIKR3n8EVHpbiciVkBEWW+GtehtmLQZxGY+n7BxIRCjy0eo/QaDUnlJOeMXMbBwQpQJa3nc4ERJaBCewTnuUIh8rzCSEAkqDy478oNS7c5QSzBxP35v/bJP5w==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3060:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3060;31:9acz9+onwV1hDOUF7mFxddSBiACOQRlo6vHtfgnODRz4oGMLNuoheleOsJ4la3aplJPzLCB8MH/PDGvMYj041eVK2ZXNAXvNRVuDPnFa6cLUIJkpI1TV23NFxbfsKB20pjOepXMU8tZ1e8ONWA9rfhHmdAaQVmX4hUCUbmLQiLSbKYUSA2mgG673CF+2+clQO0rTZdQwwE6yHuYDs0lSoCTTYdb4FaKnNZ8DuSd17Xc=;20:0tBDDs8fO1gp8oJ1/ry3AeHm4Y8UlPjq+fX6nPxEAKTQ+lr9zVJAuGF62H7dnOb9PWWKQnvhEmvLfDw7zO4ed3kMgfLY0Tpnb7Ejsq/COo3j/JLFxK4sfEsZINYlwLjzy7qv0U9wPxo2NZogI9C0wFx+9cEabmz3mfFS+W+FjJYh4oPN8bjFR0SDh/ytzD/88Xn/fIrTdrE69LWKi/JxIps+svbF6ir8mZXHaterBTL0ArLAHXurEmwlsKawNSHNuzuaePX9RnWd95s1WiiVw75hH/mqvr81OrGXVeFx00PE/vSZYH3alTzGa8M1cO9+mvOul+XXyHc8hQPryKw78wayQksapQEfJfrJHf/umCgJBwzBLMFfnYR2Bhzk7ZH8n3A/3YZ3z66xahSTSGx8KE8uBxh4PFHDr2NzkPbgqhXE95iYLnJZBdyVmf0FFbcql5hgKWDSkSkkRCPiUzjWQZBmydMyR4J33RX5LKdG8CPS2gP2eAFVkChz2HKDKEBq
X-Microsoft-Antispam-PRVS: <BN6PR03MB3060408171B899A24AC585669D920@BN6PR03MB3060.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3060;4:/QNMAfzmvcm1RzHr0XmujTnupmjShKUpUbAPqrB4AqMrBugy4zowKXcxMiyg5UGJc0ESe12TSnqnS21cJNrBXWj2bxO60Qw59kaDw7UnafuWnjlw8okYJY0W7Nuy7MI1ditTuy7OlTBYFhCy4fsgFMF0UQ8pYkG/AfijuT4X+EU0gDZpupH+ubF/FqfORQL+muoX5XJlbcGGy6A4GiayJFDTZD5ixvv+iC3j7p4jEihuDArhskAgvVK2BJ6sHAj2TR0wCtifMkidqTsJtAurZR3Ol1lCMkZvCXjjDWL6t4ONcn+yxV1Aa3McqF8QSsKJ
X-Forefront-PRVS: 09352FD734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3060;23:Nw/6iyJt6lguSDIAJXlEG9JkaD+j7hDvwEIySeyan?=
 =?us-ascii?Q?Zq2Iady3oUMkUvzBucuEkriHyKhrNWn2RWN2ZrtV/PN4teTlnq60c+77tRaR?=
 =?us-ascii?Q?Fkxn3lbascIP1KU6UIKVKpa5IXoMAY+CTBgj9cB1NmEIXjUgeLrQmlar67z4?=
 =?us-ascii?Q?x/HsJ/LsgUKTC4eaKF5LF20eyqkRmoEWDyo05FjwV7ElLtmcqqYJJFixsG9R?=
 =?us-ascii?Q?QJt2egVkSL7q3vwEYJ2ccgsPUHavDED8Tsa5+l7j7Nxxq+xDO5LmFyysEO99?=
 =?us-ascii?Q?hMK8k1U6c+PiF25BXPw4YA5GoiteDFsFqPdz77XEmFzuAsqQAIMvka9TPub5?=
 =?us-ascii?Q?Bqiqk0z/mWZ8m/vTh/JAfUIor7xDO+/EyJ5RtsYoCgnL8lopTMN81eQxE/a8?=
 =?us-ascii?Q?E2TGg9iRKJ6UJR88LL9vBZAoWSyjaNzu3+ICUP8/64uiU8Esj5pluTXrvCen?=
 =?us-ascii?Q?7pKp2zYAetgw6VhcnbRZTWK8mBu2/XdP7GvsWtL80mACO4/k1mSkpmS5MIWd?=
 =?us-ascii?Q?uzvuiqQgK3hXp4IFnaDOeJM7p+ifqHfUR8r+WgFaCrP3NpZU/YdZ/9Ocbgqv?=
 =?us-ascii?Q?mtFBJjpDuXgtE8LKZxCVhXKsEfkIrVCzocJFxzWRgMaBiUj9l46Gomy891Em?=
 =?us-ascii?Q?lUv7ol6NwOgPiBl45iaE5ENt+NEghSYZ+Ru1HwdMVjiIJKhVLcb3hC+lZKhZ?=
 =?us-ascii?Q?OUwMjwOiOO97aIYIWIPqncN8AAZG0x9eVvKruWyAvo4t8m9MG8afYaW4OoBz?=
 =?us-ascii?Q?5eUD0l+TqdAcxKYU3YueINRfsNy0/0JeFn8zwcjVDtB46Zd8fz3yLffKCknh?=
 =?us-ascii?Q?fEiKoqV7/qgShNGLfafMhk4qnr2Fz093YWGTJzTdIz/pygtkIlVqWevYYytX?=
 =?us-ascii?Q?8351qC32gW7J5K3s9gnJfuAYFWIvez+jInColi9UDU24G2EV2rfazGcLEq2l?=
 =?us-ascii?Q?JTBP6nWtTu5m8msdmYMwE1uAQLBajen3NzPVPouwxR2hYFGLYk181hkFe7uw?=
 =?us-ascii?Q?Po=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yTqhNCsRd3QaF60x9vhqsVXzcBWJ+0IScjHlPF6Zgvm0EggTR/JNv0DNg3Ts/zamPp3VDCKoqld6mdDnE+IMtSmZlFBSyzvs7TmPzmS4Vn5gPwHeaeQBIhH2t6UNF8WjSb1yLEOa5Fsm3XIMb+lAaBV2GizuwBcsKwAod/MkLKYvo+2OyyCNFI6zwln4FLVU6ZNoQdbbOk+giw/XEQQRlV9tF0l3aPLdDaPjmSSPduiDMPbu/QQqGf8aVPFoo0FyrOnk9RFaaQuqPHb2iSRmyz3uKe2dAqvP60AClkdJDzLJ923NbftNZ5eSE4XwBK5pJAGhFLczyk2PnCy23NQkp9ssI5RsayKytTvmb+il1Mf7tv/f+Gq1UD8FwhoBI7hDR9+iMJ++Diz2PLfzTkf6n4aN2lNrUFKzJoC2KVG25zU=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3060;6:1TWK0taX9wwL94bNZb4XbgUIEf3VM+OXoUY3nBC504RF/d5SGaSDhCcaDSZRD132DPaKjQ3yEJmu+hfloVuVxiNABcEBR5YCqd5TkOBNVmpQdIqJsKZV2bgbzIPMWE68Q/9OfC1QUZUBzO16EXgS42YXJ3xWgEweTymvyvBUaiQYp33KOoDI/qfm6YR60cdA/rdp2lxUtYXPMYDrocuJUjJb0fU7zBidvcHgQ+/G1Sgknru8c68efaO6MVYl61HKvMojt/AMWIbFjXM+YVKtCieLRUNVkWhNqX1XVTUt1Fa5XaKUSmrPfrT/v/Y4Zhsc7welSMhzuw96YBf9AU6Qsph4Yn7DxzquzlIcCI6+Uw3ItlZcsEqB08KXYtp8hgfvMmEQvWatTZINDdiIqKGHNc1r25n8SdbV3IhaBwGUg5tJnGJHsRXqJ98X84n2APRxlFnGTuiM2DVDLbZdXn+jYQ==;5:lVxzSR2C699axeKVu6dWU9+Ll/exduTpo0w+/Gv1tE3ACMc5puE0Im2unYGYL53u4yjZmOEJS2q6W19UaJvqjj1kY7JPW/ICrwl1eKi9N9aa2L/SDKeufhLbzuOSVpPOaMdItMQCnbdcwUHyYhgOD6RQdQcA0lA2gaKNaxHmMrxLbtkA77NyLm3dLLBBBU2g47VWTREJecG2/X0miopyRg==;7:za0k54kHl+jDEWkSvNfD1dzkFRZGmR1fyPNmWtfaFOxDocm9xyGXSDEH8RqhDZKs+jo3fuQddnyyvXdXZqcyJojb9lvuA5rgoX2XLEpfkZR+Q6AE9kG/xCOMqp8EKGoBRl7yxW7ErPYCt9AhunL5Xw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2019 16:05:02.5638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54083ef8-d5eb-4ba6-e13a-08d6885f067e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Analog Devices drivers are typically GPL v2 only. This patch fixes the
inconsistencies between the module license and SPDX.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c     | 4 ++--
 drivers/iio/accel/adxl372.h     | 2 +-
 drivers/iio/accel/adxl372_i2c.c | 4 ++--
 drivers/iio/accel/adxl372_spi.c | 4 ++--
 drivers/iio/adc/ad7124.c        | 4 ++--
 drivers/iio/dac/ad5686-spi.c    | 2 +-
 drivers/iio/dac/ad5686.c        | 2 +-
 drivers/iio/dac/ad5686.h        | 2 +-
 drivers/iio/dac/ad5696-i2c.c    | 2 +-
 drivers/iio/dac/ad5758.c        | 2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 3b84cb2..c735b4c 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ADXL372 3-Axis Digital Accelerometer core driver
  *
@@ -972,4 +972,4 @@ EXPORT_SYMBOL_GPL(adxl372_probe);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/adxl372.h b/drivers/iio/accel/adxl372.h
index 80a0aa9..967fddd 100644
--- a/drivers/iio/accel/adxl372.h
+++ b/drivers/iio/accel/adxl372.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * ADXL372 3-Axis Digital Accelerometer
  *
diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index e1affe4..f242fb1b 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ADXL372 3-Axis Digital Accelerometer I2C driver
  *
@@ -58,4 +58,4 @@ module_i2c_driver(adxl372_i2c_driver);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer I2C driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index e14e655..d486d0b 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ADXL372 3-Axis Digital Accelerometer SPI driver
  *
@@ -49,4 +49,4 @@ module_spi_driver(adxl372_spi_driver);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer SPI driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 7d5e531..9dcbfbc 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7124 SPI ADC driver
  *
@@ -681,4 +681,4 @@ module_spi_driver(ad71124_driver);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7124 SPI driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 4d857c8..0188ded 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
  * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 6dd2759..e06b29c 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD5686R, AD5685R, AD5684R Digital to analog converters  driver
  *
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 4c3e171..70a7799 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * This file is part of AD5686 DAC driver
  *
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 7350d98..ccf794c 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R,
  * AD5694, AD5694R, AD5695R, AD5696, AD5696R
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index ef41f12..2bdf1b0 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD5758 Digital to analog converters driver
  *
-- 
2.7.4


Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CC8C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5FA20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="qYTvLZD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfB0QPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:15:53 -0500
Received: from mail-eopbgr730085.outbound.protection.outlook.com ([40.107.73.85]:13536
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727400AbfB0QPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNsYpGHAvoCWUbhWjZeoTTbnuSxiGLVE1SeAF2MVw5s=;
 b=qYTvLZD0TR39ZdhOf5Kv4amOO6WRzGkyfbRx2PCita0U0ABFkN7ro/AwK6sOKdfDAxHoOJ1KLx2ypPaC+ySssdcSPQTrFHik2ClKsqt+Im3vpUD9foIbYBm6LFiIC+XuAy2R2wSOd0+UlNdIMno2AGY3KccUp3s/RhUu345tk34=
Received: from BL0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:2d::18)
 by CY4PR03MB3061.namprd03.prod.outlook.com (2603:10b6:910:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.18; Wed, 27 Feb
 2019 16:15:10 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BL0PR03CA0005.outlook.office365.com
 (2603:10b6:208:2d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Wed, 27 Feb 2019 16:15:10 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 16:15:09 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1RGF8HM021591
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Feb 2019 08:15:08 -0800
Received: from linux.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:15:08 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/7] iio: imu: adis16480: Add OF device ID table
Date:   Wed, 27 Feb 2019 18:14:23 +0200
Message-ID: <1551284068-4882-3-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(3190300001)(199004)(189003)(50466002)(7636002)(48376002)(305945005)(106466001)(246002)(4326008)(186003)(8676002)(36756003)(77096007)(26005)(53416004)(110136005)(8936002)(76176011)(426003)(11346002)(2616005)(126002)(116002)(476003)(44832011)(72206003)(7696005)(54906003)(478600001)(2906002)(6666004)(356004)(50226002)(47776003)(106002)(486006)(316002)(336012)(446003)(51416003)(16586007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3061;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 396fac34-9c51-452b-73b1-08d69ccebedd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR03MB3061;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3061:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3061;20:lLis4mLJWvB5Y4OjyGV2ume+oefWe65ILK0VMJHo1bBsnPjXo5o50mV9goQ9GhZodzcxr7hNOkqeWAfJ1gpiu3QdPlNY3YdNaoHhj/hZGc2yU5VJi3G6sLUEJBXtwLHTIdneEwYg5C9vmVVbtoscepqo56IDE6tEm6ym9Pj7Qlp5J5q/GpzswoQeagxlGDwht8dQBiUWYglQL4pj9Sq/JWNn5EC2QEllTUKqfADsl/omdaDcx7NktMWyY56LLgwyXN0DudKkHdBZgwl7mvdHuHssRwYNG8ZhryHpxb6P/QGKWzv4Es6EBy+8DBaBgB54QEly5BILpGpaEnW/Py2wsPVNuGa7FTtLt9FfKq/WLXtmvL5lsdqhydgqfP6zI7YtVq3unI6xpacrviDHF5h1/df5+pFAkkU4qTSB8eYyZ7IE8qyfLQAPuJJ3GmFckkmHJWliWU0rzPAzo3y9s3K3LYI/PkV/GBqjakA28T99p9YvM8mWrJXXwFepzP2nSfI1
X-Microsoft-Antispam-PRVS: <CY4PR03MB306108306DEC3386A6148EA69D740@CY4PR03MB3061.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3061;23:I97UmBx2Um8vjDgTedMp77dF/QwvRXeYRJwHlxgBW?=
 =?us-ascii?Q?ktBULsHOxkD48i6OE9lULRbNuuFleTlMkpknWuxPyZzCxU2OEfAztNyxvSdC?=
 =?us-ascii?Q?3Z6ZzLJmB4GbuMrVYfQhAeiDj5V2tXrz/OsuqtdiOgYa5h5uut59g2LOW2yZ?=
 =?us-ascii?Q?u+RUpIESagltF9DFIu6oSppGuIrD+Bbw8EdQU4M3HcK6973wxvHSRbSlc4lK?=
 =?us-ascii?Q?OW44SfPa6K9k+BDDAI5Wj5dpJOFUzxoptpigVROxeCCm5STP488mrIDdbnrB?=
 =?us-ascii?Q?RzwbeQ5KgXgPbW15qGeFOqlbHNcqBrPOVBMTga3zEJZ7O4kTIvy/6K199a6k?=
 =?us-ascii?Q?mm8Mg0Mp0ZXHZx5m/ePWClY7MRaii23GCAlvS+MK7LiCuBfYJOWkfJyNjx3T?=
 =?us-ascii?Q?9fuLBK4H5y5eCpoWKygNjEGaUO6Hy0NMBva5ajRFKzWHGbOMiFkrLWQo01eW?=
 =?us-ascii?Q?t7cavmbFTwZuekxL5y5uU0oDA5Hwf8tiA1n0mJ07i2b5c3Jaa/Wvz/X8LmAT?=
 =?us-ascii?Q?ktFQebzI9SSpfUEImrBEamyOWFQgiRx0aoGHtMOYjm44WLN4MbSyI8+ylXh2?=
 =?us-ascii?Q?dWJuiNl3cfaEc6FouDFp5kES7bx9ZjfFs07uA+uKI6tbWi5l4zyDXVj/xS0Q?=
 =?us-ascii?Q?MAKrYnCUj30Xt/hR7fUz8yUoQ2bQe7hUDuh9XIXcvklm92Hrhx5iw8GXtd/Q?=
 =?us-ascii?Q?1C+HD/1RZZLnrnVHSkV1PaJbzfaPxiAfJCGqBdFaxnub5V4cIm+OGpDzAhNt?=
 =?us-ascii?Q?MD1bGlOvZQVuXJLchHwMGYknsQhfgoU1YrTWCB/p966JaC6ZWMnHQTNqHzTt?=
 =?us-ascii?Q?L+M1/aikHGn/eiQbTo1qHL6ptqbf6gk06XdANcA5Hf4C1TkCnEYMOsRHsbme?=
 =?us-ascii?Q?7TCuZtOWbdJle/UKWR2ZXEWwj0QP1T0AOaiAJ0A3fsqGoqk2fxi11C9ZFNZc?=
 =?us-ascii?Q?tyMRJteKW8/Do06s9LbRpgju81qolynguozukwRYo+mR9kb7WzXlRIPi+Yvl?=
 =?us-ascii?Q?SQ6PLL6a8DJ5coJJZLekKhc2+cZCMV7c7RMegoa15728h6Z2P0dC7V9SWWe7?=
 =?us-ascii?Q?NuvzkW3SxyorBjZ5qHyW9VnlhdA?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5xqLf6kkTLta0SrUujAdFVHtxke73qTTROsZeoD1xcHDzPKIJJ3p5hLHvGYKSQ7IodYq0347Yd/kUp7gOs8d7g57v+P5MhR5nTb1Mlfi8vN5kAKVUPjgzR4XAeS3072PgKKzuS2nzkL2YL/uweUTMt12aw8hZ4qysRJCVdTwTpCTmNnVE3cgT74cSuQXLscMPq9En75nDGTb30gpgiejbjTpe2iHQA0hwWjyNSzVycM5cZgfqrLOZvWD8TK9cH1Cfli4GauHtb934P9jXNbmeLlMUpD6YzvHfY2cIznvZO+nIn4mn7NX1GrKcNckwlZ3UQpuPdQG9+NzNNYBlhJ+RzqJdYUN3tMED2946ZEQXj2ZYjQxRwEtjvT6yM2Wiy/+C1DqjCklsqXaZ5b9gWj3b2aslWe7W719XRi3ej3dNr0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 16:15:09.4280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396fac34-9c51-452b-73b1-08d69ccebedd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not have a struct of_device_id table, but supported
devices are registered via Device Trees. This patch adds OF device ID
table.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/imu/adis16480.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 98a23ac..150d814 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -991,9 +991,19 @@ static const struct spi_device_id adis16480_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, adis16480_ids);
 
+static const struct of_device_id adis16480_of_match[] = {
+	{ .compatible = "adi,adis16375" },
+	{ .compatible = "adi,adis16480" },
+	{ .compatible = "adi,adis16485" },
+	{ .compatible = "adi,adis16488" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adis16480_of_match);
+
 static struct spi_driver adis16480_driver = {
 	.driver = {
 		.name = "adis16480",
+		.of_match_table = adis16480_of_match,
 	},
 	.id_table = adis16480_ids,
 	.probe = adis16480_probe,
-- 
2.7.4


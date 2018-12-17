Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BAEC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36E120645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="P8sbdKyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbeLQMYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:24:48 -0500
Received: from mail-eopbgr690040.outbound.protection.outlook.com ([40.107.69.40]:15264
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbeLQMYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg/1+UU99U33g2Rr7bYb8mBQa9NmDrj5RvPVE6WHu8c=;
 b=P8sbdKyn6cCTXSY0zZJc2urUhyfTE5YSWAczJinYm/Hsocb5EbSCkq78uCD2tWofOuL5Kk2lvBy1MdGxs/fcPF1GmRaNS+deg9uboC6hyDs+DHXbmetCJNaDYi5/FSIFyrNtCU3PYFFLz++rcjLvORi6BUWtJRkdUPrnqxPIpCU=
Received: from DM6PR03CA0017.namprd03.prod.outlook.com (2603:10b6:5:40::30) by
 DM6PR03MB3756.namprd03.prod.outlook.com (2603:10b6:5:50::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Mon, 17 Dec 2018 12:24:43 +0000
Received: from BN1BFFO11FD014.protection.gbl (2a01:111:f400:7c10::1:173) by
 DM6PR03CA0017.outlook.office365.com (2603:10b6:5:40::30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.19 via Frontend Transport; Mon, 17 Dec 2018 12:24:43 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD014.mail.protection.outlook.com (10.58.144.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Mon, 17 Dec 2018 12:24:43 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wBHCOg0a016454
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 17 Dec 2018 04:24:42 -0800
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 07:24:42 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 2/6] staging: iio: adc: ad7606: Use SPDX identifier
Date:   Mon, 17 Dec 2018 14:23:36 +0200
Message-ID: <1545049420-16484-3-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
References: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(3190300001)(189003)(199004)(53416004)(356004)(6666004)(316002)(54906003)(110136005)(16586007)(106466001)(50466002)(50226002)(5660300001)(246002)(51416003)(7696005)(8676002)(575784001)(76176011)(4326008)(478600001)(126002)(116002)(476003)(2616005)(72206003)(486006)(8936002)(7636002)(47776003)(44832011)(336012)(426003)(7416002)(186003)(446003)(2906002)(36756003)(48376002)(11346002)(77096007)(26005)(106002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3756;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD014;1:Tum4ch4wq4hrejSPFDvaESSQrZ3LOgrO+h67wFr9kxqu+9RPZHEJMX9QH77d4QNjzenRWsJX4v9RNM88jLEm+y8slhQQ6w6oghbcXJ2jLj4nqyeJwLP7CSUX2+qo8aye
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84a8b62f-5b95-413e-1dc5-08d6641a9fca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR03MB3756;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3756;3:NDOugE1ewcwAhYshuPioDLWGByARIRdIS+X9LIUppO1w6kkw2/lshS9Znvn3hIAOEZ9NItx1DDXSBLIHIBNXYfzb1pAVDXrMASZki0CaWxOrh6T8jQtg6EuzMLjeix8n4/aU4p+Cs00kArj2emrau08wS6IBPv3ufgJGssmIFs3nx8zCS3Jy9+PJtmQfn0g6i4xsfrLK84g4i3UMXHLAbHE1UjvumfuyLYJ0QCpy1b383QTzV4F5sVBYDHXoDztPOPKOF0RTk63LxIglSCuPndTDFCZFnIVDq8OLIsnNYU1ryg+9d1qOyhOvTkrzhvW6S9Bbi1sUPBaHrTaaTjzqn9L5iWjMyEOLM2PpHXcQPf8=;25:/QE3L4wdRT+7APSioYsn3My3ItRI1WY4mGKQUDraeCJIP7Iq9hhoH3YInQ8iNt3amAPP5hig0ygLzLsVljMmxRZQfv2jiIwyLWjETtGQSPW3aVU9LMN2V3ehz+D3EeqaNiEArfKJ6FMyTyntUaXJt0iMTskswFFT5nb3EnJiH7ITMy6Iibl/cw7C8PIwbmbRQ7LEqL9eLTenOsRRYM7/gwipj+Y6GHCuQHc0X8dlJBxQnuz4vxqCKVarLP/m7lcxa2aJ0t5dDZyen4K+KPieW4kmLzxsXwDkWdsXoIQZ4UH0El15esJre6MzK1f/i7Zips5rAdUf/CVdYYdcDGl4Iw==
X-MS-TrafficTypeDiagnostic: DM6PR03MB3756:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3756;31:yaFhYprVZhIis9KvRdrlYqeYn16e0iuu4b5er5CIID6HzC9ktBTmQjWTiJAyJwVSzJg4tR5204ey4kOJxrisO3LrQmoAAD3xpKrnrRU1/hQyTRkqTvV/vIx2efzoGxSFZ2siJePZwOOabCzyPwjpOegxnU3u2YlBGpAWEMMHOUUjGmfbo3UIWshy2NupvqrixdPILy1P2/cHPFwn7OOTUpvmMqG5KmBqjMhSuefQ2RI=;20:WAeX88n5xLOhzQt6UQP5mLd80J91sVfQHVSiUjZEo35d4kPy7Q/Cizv3aOWjv59ckwczS65IAakfMGVfHleQgAcqikQLw3jYbpHpRPGOxeReAdeZSNKHXbq9HJ7ooeTq1NWF73byWhEip9ogb9LNjstKdFt4UMih3WZJOW8/6hsRCYEoRGR9qGoo+JXXWf5hawXIST9TMf9mbOrPUZpyE2dYUelqiXNvgeS+VrKymTpSLNW4R3uhT03MHYS44T/OvVGtf0AM/TmXD/U2HtwJ5AIawZmY1bA/bggTGHhksZGfhax+PPeNczSvJc/LCEnQAuHwmLlYvAX6Dpa8O4hT21gLWVNqvhw7OQDq6CBUVlY144ywYtw89DSD6JNZZ1k0YPsRnCYPCKZo0vywObbhpJ7eNr0akhKaQWHxKxTUEsv+0SWyjOxUb9euagm5MveSthcfeCX/o01HFPcetJ7PokO+QnKQ4bBm9EXP13lBLnPSXeCQfPR0KAT6vobmdrQH
X-Microsoft-Antispam-PRVS: <DM6PR03MB375684945E44E6419AFF81C59DBC0@DM6PR03MB3756.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR03MB3756;BCL:0;PCL:0;RULEID:;SRVR:DM6PR03MB3756;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3756;4:R2NmiQKLgVKXgyz/FnJ4iF/7wnEcKGEOkYfDUGenrrd2J7ubF3K/bFP8x6xmZRjKOTmNvwGaOX+1DEWI7aftXAfNnh9FPSCuw9DDZMGvrNwKGEO7zSM780eBt59fyofb/M0kN+FBlqlmmwuXMklf1aBf9qXDlfg0Rh/kAlgRQ/+YOT9pv77hgxVdDHMPKzmvsMMseakx/hQEmps4S/YfGK8FDUj2XdVI5Q9Q0FPbSGoU9VVC4BWJSh6uMTH9Kez4RzQ9WBGMC7HNikjpHUNYrA==
X-Forefront-PRVS: 08897B549D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR03MB3756;23:KSVCbYO6A3HoCOxIcrAC1Gk8d9XGWJbQmVONyeI8B?=
 =?us-ascii?Q?nQ4yi0wsdTuPhr3fGEyYir4HX22z+DrWFoty1n1uLvbcPwlNrDrd6E0O3RAL?=
 =?us-ascii?Q?jA+3zghmwlqQbqYKkWDPjdSEOBPgIgOmKG3RJhuTw/yOgkyAC/AQM63spnPi?=
 =?us-ascii?Q?Dlftd2TbpYLUHg2HMDxgadGVPYbGl6v/gVgOjVAWwBZ80zK24ecO1+vtcQQO?=
 =?us-ascii?Q?xnCOPOzsy4fcEy+StnZGencroUvTIoQEI2PTnLRaJssls2UBiwcrnBjrJso1?=
 =?us-ascii?Q?jvQE5W/8a6wP9mR0eI/yXlfmhK5RBYBcOmBjY0gTGc37DnZuLguNJrk6KTLb?=
 =?us-ascii?Q?9jK3kDAnX1hX+HVtaq2V2XXqCbDshQoQqtEBnleV++a9ulYnUw498Esv23Mr?=
 =?us-ascii?Q?wuqwFdf/t9UQV/YPg89N9b9uyh7y0p+PFXlNWwlH1iF9JLkoslDhgrIvkZ1U?=
 =?us-ascii?Q?34HxXNOhhymfr8QWukDtCxtSA8fi9ozsRacrjqQXGzIiRxgW0R6Q3PKmA+3i?=
 =?us-ascii?Q?LBQvv6qhQ/GoSIJcpRKzwK8ZGFrz6UyqoV5lE/jrXAUfzn4EW7FND6OTsGJw?=
 =?us-ascii?Q?sCNXhzHbUJnGlc99DfIQRsnmn6ICHVQwg09IM1zSdjfNbS7gyVlRiRwQoKEo?=
 =?us-ascii?Q?2BkN7pKGQwZvpXhqJmLqbY+GwXfkjVO4g80d6/hqMdl3w1Am7icoi7mmmnQC?=
 =?us-ascii?Q?ong8TqDOuPAQbCB0jBFwbvJbnxvlcYTSbFqs/cLwUDsPw7N0iLRg/Rfhr2Pl?=
 =?us-ascii?Q?yNdXrvmVLA2OBpXSl1nSLuKoqBFIFUQ2FAVtOraz4mqzl4S3fcHhhPlHNPnr?=
 =?us-ascii?Q?W9TEHvSTYSnGJdXc2F9QCxZ+JfB5ozuC3VRQv6rYskGt/3GEjXObsPOhyBNa?=
 =?us-ascii?Q?/ulTRv8KKAzlgxhJAce5Ejq2lGd24HoiNMmfmP0jh7fFMBoQWSVynVL6oXy0?=
 =?us-ascii?Q?ZPI3JEBNQ8yZmMgVJGyvbtGcXauDvTCwM58T3bJB6q08KL4bEOLoTKXywlMb?=
 =?us-ascii?Q?b2dPKofjZLYU/BfQ50a5mmyUr7HIRCWxiaePTKqsIa9iJEw47Yf7gO4v2GiP?=
 =?us-ascii?Q?hLrYgwQIwxAdHT85ULPOGxXVW1MJgHaIcLcvELm3FRJyPD0g5vo2MH9tzF9Y?=
 =?us-ascii?Q?fT2OdwORUY=3D?=
X-Microsoft-Antispam-Message-Info: qZUlYW63L3onALgRUGNyABA5bnTCBrnQvJYHFkaqatnxPh2EdZHCVFG5oaenDmLVtr9+KebrvNV6JEJKqZfwTlAJiS8Z2ehZrkVFTiILrJ0Ds1bp+e5BYGV+FcEPfW3LBvsyosLXU/9GW0AURHlvuD7w5yNraLNdGmjbEajpzVubZNy5n+KcRXuvs2+OscY3vg81gkkMLFA1gVhP8SljAN18RGdVcMem9COHfYIphQ2wuos7fIr9KoEXMwAIrO29RZ0eSo8LNVQWXdnDe95mZrYmqn8pzj0BYmmJBhLchZ1lMCbodDE+L0Hopr0OeAQX
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3756;6:P2ekRs9px3C1qObFlpNiKD7++qEWrMrAD5FgPIsjg5hBKYmKbUUC/OgM/RcywydF0G/fzpwajwd+p0WuB5ZrMCbaE57WRSET9MLoHSKlPmQkhqaEizB2Nyd984Gq1ZvDxlf/UC5bouQYRVGhQAZ5dQvV+tR+21nhNLWG/SNc33mWFFOSi0abuDRoNda7lgCzV+qNvVIAMnf6M7JKHE4fAxafO3q9NabBoxveS+NbPzpSZCTdMPgm+VlbZg/+vEZKDRHZO8q/anrj4dkUqjxNT2sQt0kdwaCNw/k98zyeIrD5CMm+Oiw8vmN4zVmYEquia0W8CFtZuqHz1+VhSA6wbLNAQMxoM8zi1/QInSO9CI4wNm/LOJ8+j72ObYHKRc5KqhjCa/CybYL9exZlFoCDJGgZndeZy82dj9IEVvJkVK0BGBmR7R59ePyPmV0lkQbTAFDYounQLvaFIDp/VR1UAA==;5:6jITAWp/pzJ8B2bdD6OkPulOlW3uhXK1M1ijwQnxKXO1ZnFL+HVvOpspxXlYIfsukOYsvCFd4NF5MH6oSPr6SB5xhRvBfM0EfMztbXWN1A6duwP1XJD2ECwEsnv7neZwRhZUbRtq4SxI8bwzCsElJBjNUpOb7jM1tgaQstv45Jg=;7:rLJFk0VSgt3wlZXFYe00qyOSgA+burX1sqo+DtwS7iDEQNeiOwWsVeC8pwRHfXFb7CbvC5SeUHtVJgYdFYBc8/qhgNhRQ/twLzAHnfzqvzMoR/FXrPm/6WU9wHcZY9X0PxwBopd+6l1sGMA4ySZ3NQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2018 12:24:43.0847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a8b62f-5b95-413e-1dc5-08d6641a9fca
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the license text at the top of ad7606 driver files
and instead adds SPDX GPL-2.0 license identifier.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/ad7606.c     | 5 ++---
 drivers/staging/iio/adc/ad7606.h     | 3 +--
 drivers/staging/iio/adc/ad7606_par.c | 5 ++---
 drivers/staging/iio/adc/ad7606_spi.c | 5 ++---
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index e1d85b7..97b4a83 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7606 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
@@ -531,4 +530,4 @@ EXPORT_SYMBOL_GPL(ad7606_pm_ops);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 510a93d..3e12fff 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -1,9 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * AD7606 ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #ifndef IIO_ADC_AD7606_H_
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index da26742..2d137b1 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7606 Parallel Interface ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/module.h>
@@ -114,4 +113,4 @@ module_platform_driver(ad7606_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index e533917..f38f0d6 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7606 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/module.h>
@@ -80,4 +79,4 @@ module_spi_driver(ad7606_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.7.4


Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C22C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687FB2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="iv9fzE2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfBDJTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:19:54 -0500
Received: from mail-eopbgr710074.outbound.protection.outlook.com ([40.107.71.74]:2942
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbfBDJTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0wzVNg7zmv91ZEu1DXug0xP/c+DaSynKJ3HDqmSxxo=;
 b=iv9fzE2Sywzz0QVitapTrv/PWbYndTMNcMwrJWQ+78w1wLIEneHIr9duZGrMXju1JmHV4y9e26nLrqp5NI2GGIfDi/yRiHZBUW4QgluSXmjNQrtokHBgprr0HTe5pT2+N19J9lSE10rqZHnajiVbAZbCy/NVPLgWxiHduCHPuH0=
Received: from CY4PR03CA0099.namprd03.prod.outlook.com (2603:10b6:910:4d::40)
 by BN7PR03MB3506.namprd03.prod.outlook.com (2603:10b6:406:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Mon, 4 Feb
 2019 09:19:48 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CY4PR03CA0099.outlook.office365.com
 (2603:10b6:910:4d::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.17 via Frontend
 Transport; Mon, 4 Feb 2019 09:19:47 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Mon, 4 Feb 2019 09:19:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x149Jkl2013185
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 4 Feb 2019 01:19:46 -0800
Received: from linux.analog.com (10.50.1.104) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Feb 2019
 04:19:45 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v2] drivers: iio: dac: Fix wrong license for ADI drivers
Date:   Mon, 4 Feb 2019 11:19:35 +0200
Message-ID: <1549271975-15634-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(3190300001)(189003)(199004)(2906002)(7636002)(47776003)(305945005)(50466002)(48376002)(4326008)(7696005)(51416003)(54906003)(246002)(107886003)(8676002)(316002)(16586007)(50226002)(106002)(8936002)(44832011)(356004)(36756003)(6666004)(486006)(426003)(116002)(186003)(126002)(476003)(2616005)(106466001)(53416004)(2351001)(77096007)(26005)(336012)(6916009)(72206003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3506;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT017;1:THRvchCSBWcWJIa4hXyaP0sXtjDFG/3F2fh0RMk3Z4k5QbrZ5RlwjEnXfjSVEAgnl+C/Q0wx2OUrQhjdCo6cliPkDVVyd3RXJpy8i615v+2NXRYsda+5PgkIGSVWgsSpQMiRkJ/H5QOd+CDpEaF4sg==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe4760d9-ee87-4a86-afbe-08d68a81e89b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN7PR03MB3506;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3506;3:IjWlzdMIAWtW56ru97E2FCJj2XZk3bGvaxFQ4oMwpa94YXbCOtKy9q2X5uQ+1H9CCr9IZ8STfC+vwHv3yTPMV9sXAnbNcQWm5URaABgFNc/JEVg4fo0P5kvhInWIg0E3EeU/Yr2QPv0IxtRtHxCvXU3qB4TGe7eB/W5loCpGCJmOtZjNmhPJKb1YeDC77gBsCZTry5pPTdkVd4JgmPoRLhAK4jRlgZtPzE5aCKMM8i+wcMbwxqh09lli2muRJr2hUQf9TvElG9yTv8SPyxQp6qtp/IKHDs98nOWGZU0b22a+kKk37ahnPDsgnKcQtioIi5rQu0wG19g503UiOOa36G3ng51IbUZoH/+25yaOnVi0UnSOKyX+ArWS0aPChlg9;25:QDNbXMPrlC94mji5L44TVx1KIc/joUPZU9dz+wqyMKzQ9JHFVQT4Q9W7fitlpFqJIffxo4g859HkWHojHsmugr4Q7awwWhqEHd+zuWwpg32g5OmweK3ht6wbw+6MZ/9Y55Gt10KHpMXL0fOXwu51WexbVoKPl7WgGOQqoYQ8+FQqU1aDLlvNlbJ9djmUaNDFcRqiCcYXoD10crjLJ3Hl2mAM5vlAr2clsOpFJ1dDJzmlRqBazlttVNrPPdsIXy7NLyPUTF0JbES8SXYHVZLlWIAU0zqPmujAcvuJ5T8EH0K9weqINzy71hByIqVDvPELoe36A8DizbN8u7mW2MLaxw==
X-MS-TrafficTypeDiagnostic: BN7PR03MB3506:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3506;31:hFHq4nHMIaTRdlpgK7ukCQVGB6U6pS7KMo87NaOugwnr3f7ZZRGXegDs/NSORMvGzPXyZmoouSfmwxTp2qBDvB6haQXRatAJS8P4yXfWyDy44m1roSjG1FsJzQB+yU9xzL08jzdhFvV0ZnoZ1VdPckZ/1vAY367OR4ZUHoQSIj41tk5IUCEQRHk2BC+EW89XMOLqhIjgTKIQBnXxvjLQXFjP8n2BgIFfS94ESOBtvXw=;20:l1OnlHykVfGR54Z2q8us7dyLLYTd9RMc3dbaEF1yclEJdHUtRb5bVU9w9n1DO1N0kSMmmgNuwmGlc9bnKNrvg2Ykz5QWivHtPxOaqihAscTKSTvczrXJAlnkiyo6ihk81IzQ+iif0XCe7X/aw5hRYvT2M9P2vbEWv7sw+T6+BEzcNx4VD0nTNbKStDC2VyEE4eG4NfDlHkq/RwQ9cPU1UFLOFxYjAv6+btJjR6pq4lfeN5Moavgds+I4/rl0ljd1Ikh7CxPskDPDuu+zWiMQ8Z5MR55MoiXiQZK18A4whoscWksoGqVjoUCB9J1qOqkwBhSyuvX/l9UWQu0ZEDpTTCkmLUhnk0HFcAWhrQn1RDon1BMg6WN/FowqWxriP9CoEs7icx0S8yq3175R5rBJx+FetAGkSJOlBTYhVT8lGtMSC1v7L6x0VOkr9PKre0d09WalD6qbueeKDJAhOLgpJX0gz7mZ+SVsfy0M6cm0LwABQ//c7dxLDTSrUE5DrlIf
X-Microsoft-Antispam-PRVS: <BN7PR03MB350631B2ED48F9EF766A0B4E9D6D0@BN7PR03MB3506.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3506;4:RvxrecgYGpoDLEiGW5E+WGS6oXJYxyTUDps9AYrJODvK+/XFxd7w1tkhxhIJu8WSjKwP48BWlqu+SBDGwX91yXz1y8klJ874dUgSy/E/tjV15DeulWRMFOxP3MvDvoEbsqoE2lx62spQOFNr/KUJPv6ppaZGArnlWGbBeZBgP9Eft/ffWVr52nql4awcW0IjDcOJJE8Uc8EQpgrTsvSKyn1nlx7WQQ2jj5Gzmbz6IBb9BtJke8zXv5dPWZlp2oInmwKp/K6UWgSDrLIgJ3j8/YZzvgmA/7cY+YDD0KBBCp+MKU/vPP+UUyX/0UUSiQH4
X-Forefront-PRVS: 0938781D02
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR03MB3506;23:oQvCW922DylFBJ5KlU+wRlHoXQcmhGflcaTYNAZlO?=
 =?us-ascii?Q?pLZBFB44H4OpGRmdBtmTBwolZh2HOhjuh+5b+ZpMfnKGb1qxcYW2aoZZAVKp?=
 =?us-ascii?Q?bBSqnc2MkDOaM0yGBfAkNJ2NoMpUG1bdHH6CJY9RbctqY1e6Vy3TYd2Q3GCH?=
 =?us-ascii?Q?4e/IXBvf6uBsX99yx7FKodtmSfguKCIRsdxSxWDUFi82ddLg/U+qv3Mmc2bn?=
 =?us-ascii?Q?29aooa9H/wga38gqJX2Fl9cVwLnAktcP3ZsRmCBXyGylT3Q/6aW5vtAGlGPM?=
 =?us-ascii?Q?7kpnBhVP7NhUIaWVWQ5vBMUPYBCDoWBCcmMLhVG1WUetzN7Wd6sSYF/EzEav?=
 =?us-ascii?Q?lxF9dFQvvo4NZ4zcBc4LJlR73pHQhQp209iRzVSPykYa35ov5TF0mzUcMTHF?=
 =?us-ascii?Q?Yee+mY058HP2RmBYEwAt7RApTqQACZwCdDQAQ+z3AcMSRh8H1mG47Fl6wexf?=
 =?us-ascii?Q?1rArK+t340sEXsxNyqPMjkiJZe0NdKdYBOWz7KN9/4lBDrZTLyGQqI8ZxU2K?=
 =?us-ascii?Q?AQTJUByKo1/7HTgYwJo2y3DK0yOp2M6uRB/LmNPC82kmyMxF4eiJIAs9Bb2+?=
 =?us-ascii?Q?OdixnMhTRf3jS6qlgajjolUValdTUNKCAuHRBVaUeTrqtRDtjvNPnmiFZlXY?=
 =?us-ascii?Q?9j4/UXHZ4DJQT7yl5QbEmcOlIpO36bSyvnlnZMgQr4qWnvuA/kBrLN9BGy6v?=
 =?us-ascii?Q?AA/pmjgtu9TKn8cLz9+FhzjWzw4f61OjJz4iTAb1hpCju4qjohYjLEnqQ24l?=
 =?us-ascii?Q?mDFyOjuChSyFoJDXn60BWHluOMbN5VEHfi4Cq1hz8GZAVXnpSHnbGvr/xJ8o?=
 =?us-ascii?Q?C+9lZ8kuFH9+vamPvwUP7N+jl/sz/+0W2tO0N3S92qcOWGMLDQN0iTOuYXdM?=
 =?us-ascii?Q?NsA9WO/cKCuUS+t8TPyAk/yzYf9MLL3+eS70uQFcoCrNH89dQrKge9yVlj3f?=
 =?us-ascii?Q?40sYGCd05DQ0PsGwFhNhyyokqNKdwQ6VUvHfS6KQ3BCceOMD9JGGX8oqE7hg?=
 =?us-ascii?Q?VvLIYGpbIpmRuWRzNPm5/315wUOB06TufI5qKPU2vVNeg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jJ8E9YuZEOQeV3RlzVBbVpAR6MML1U+o3RfHhkqaHztVupV8zJ3V5JdEwCQ12/fsykRiuk1sNJ3nqmcQ3qn/xCriGOdgJrSLnrNK3Zg+sQU4aT81Zq45kyYuVkPApKrbdpKLFGBtX93RG0LavftQ3xM4k7gdW3wq/Zhr0HO/ETwBhx+kQ89l3mCoaue1cfPMbL5teanJ//LMVxQbK5tgJgWVUekOd9Vh9D3+trSUsbaXwfHW52LwsG700e++dmCFK8/Jmb5sfBfzTe4ornmRz28F5AlcQ1O9zR7eoErmsglTMXdObhiwnLXR31A3Hxu7Z+nzSirSFplrxKmVAbQhA1n8qCyPCIJ/ZetoNaG9ZXM63Mri2qv1o8YgsuHB/+LUKaEHrt+J33feRONj4TZ3vj7DGf+LyhrLOHSTxm2TMxw=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3506;6:EShso6t+HBfoaTLeLNgd7zR/a7znShdEyt/3YXGxUtVgpqI9fgguSf6Z/CKUF9ZIUNlvK1vg7nV8t712NYLHyKVfIa0RMJ9ytgcySjq4hp9PDPl4AVZczYWYEkAd3YE84t2qY6szjnTD52t0swKc5PEiPUCuVvXLXD/LsNYteydgfLXdliJmBJt7JrY9Cuo2qljckHq6Y+GwUZRCsanV3YiXsmFhiozEFhvYVeQ8ZDFJB84A4wojU1KVTBf43pD332pPV2ImxTyGHxujtyECQsOCuyKQv5N+gsZBST/Nw+ixAG/zULH9BQ4b9z13bjBO7eNLLFIxdxflZBBTlsDN5MTJ+O31ung4JLDG2AnPo0EpgiMTc6NNT9Klt7xnNAf2gQ/Kpu1dtTkZAW5Gxc/wuCAwYM9O0kgPmGz3OAQ7Q8PXJoE4uKiiv6SUYQAzEamXbdLzqDiIHxTVQ4aE3VDQ2Q==;5:Xe4J0k3fXyXhBXWwTJ6nMsRdARxLncMjuVvt1tM1l+NqihIntX9VeByOvvinxmQiXKNeibL0aYfcVTafID+ITx99IQJV2teSH227Cg7H7XX82IDPQuyB2tS2JxINUmmVkaO3uqvUjA4wQISx44UQhQsi8liPZj9SacRpWapF2ioTpCm+U15LkNtKRcbaYzceduU76qpTJCxPhRK2atWUAw==;7:eN4H/jI9a2NXwS0icS8IxEJ9kt3IGZl+i4/TXhjWexSGpTyM1q4Dd59oUISN6Zx/ms7LLIxPRc4IzU6inHSKv6cZL9lIx/Kmbe69DBgK43VvxjPpoaCKteVpi7kanmLXvVTxFVTgJ+9j1fVz+1yu2w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2019 09:19:47.3501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4760d9-ee87-4a86-afbe-08d68a81e89b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Analog Devices drivers are typically GPL v2 only. This patch fixes the
inconsistencies between the module license and SPDX.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Modified only the drivers with inconsistencies.

 drivers/iio/dac/ad5686-spi.c | 2 +-
 drivers/iio/dac/ad5686.c     | 2 +-
 drivers/iio/dac/ad5686.h     | 2 +-
 drivers/iio/dac/ad5696-i2c.c | 2 +-
 drivers/iio/dac/ad5758.c     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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


Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C1C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB6220645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="krsQDbCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbeLQM1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:27:02 -0500
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:34827
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbeLQM1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s281Gs8KNyYQIpllwd/603PwwIgTjnQFAB93orfaVnc=;
 b=krsQDbCRoigtk2JQL3uJIomQSfmV75eshXAVjc9233R0bcprthlTE5UcUlbI/mD1Hd+gpSP+P+J0rzFN15w+RCLcy5vaFXiHbcfmHzySEv7T7GeQD5jtJB7JodOkSQURQDoQNjvzDuSgZHJi9F9AJsExfVItzlDESTp3zo7lhyk=
Received: from MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15)
 by SN6PR03MB3758.namprd03.prod.outlook.com (2603:10b6:805:69::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.20; Mon, 17 Dec
 2018 12:24:06 +0000
Received: from BY2FFO11FD012.protection.gbl (2a01:111:f400:7c0c::111) by
 MWHPR03CA0005.outlook.office365.com (2603:10b6:300:117::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.19 via Frontend Transport; Mon, 17 Dec 2018 12:24:06 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD012.mail.protection.outlook.com (10.1.14.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Mon, 17 Dec 2018 12:24:06 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wBHCO53v016311
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 17 Dec 2018 04:24:05 -0800
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 07:24:02 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 0/6] staging: iio: ad7606: Move out of staging
Date:   Mon, 17 Dec 2018 14:23:34 +0200
Message-ID: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(3190300001)(189003)(199004)(316002)(2616005)(8936002)(50226002)(7636002)(7416002)(8676002)(5660300001)(305945005)(4326008)(478600001)(246002)(106466001)(106002)(54906003)(336012)(110136005)(50466002)(476003)(116002)(486006)(36756003)(53416004)(126002)(48376002)(51416003)(47776003)(72206003)(7696005)(186003)(44832011)(6666004)(356004)(14444005)(426003)(2906002)(16586007)(26005)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3758;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD012;1:mf0SFmZtY2aPNqmJ7K8utg+M+G4Me2RdO/3ghlkYdwsh80p1PYgcXPE4nbeSWT+8/muiagcJO6i61fi607Ejb1J7+quwtZ4wuEicJT6MtjQjQijkkfb2EL63eXo5EloV
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf80d225-7fd1-448c-023c-08d6641a89d5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR03MB3758;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3758;3:pMfnwmmxPpiAClGn5D81BHcH90qNMm1PalPruMvGfxRsMsvzuNXVI9O0kZeQnmK3nJO3o4hKobA1Pb/14Lk2gXEDwoxtUFez/6UsPAQ1zu7m67Jb/FYNIIPt92sqyYgu9vuZGiuVWjwZXWvB36PQlZoUNnIEy0ea5Hd73RWJyKD7nfq+xcIrr42U5XcP/gLgF0TC10+s/TuRPQK5VAizgnkEwsd9bOOHo+0zli90FIYP5a4UM3cBWHyoDoFIJpcQ6Bu2hdTIfiLYm23svFR0l+CTsPBXauqPWHPra3KmaNdgUVb3r9/H+Y9pMuE5l75TSs93MOCZsSlFmHK561K7/26LqxsNThVfQSQonMyMdRs=;25:SpHeTSSWMk2842vwTHGvPpOQJaXz0LbCGz1nivS6wO8pAI78DVVMdAIvlmCcBr8wXWQwHo1FytAd0MUmT0E5Y12ZSVIMiMyI8mTLJYq6TGwg020t1MkvsN/o4oUhptrXUaDuiihTMy/LIuZwmMCo3AltsH7phsje6mYPm5i50usGkZKOJ8Koou1rGVwdU+d18J+8K5bJdmfFswYV0QgikFJK/H/So3IUVTUlkv+FFY199VWTU++PiXerTz3OjMJuqjyUetU5dIasZ6T0smekhRhnq4/7vPxkAkt5XsinPJe+/mkOCV7pI5L17yQst80mmc6K3808fFZ0hRZEI6QZ3w==
X-MS-TrafficTypeDiagnostic: SN6PR03MB3758:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3758;31:rQWrmsmhWqVtfUO/FH4mxatJmLA3qm1bFRkAHpvkznTG9eIxTErJUZbYwqwDNiuU7HcWy1iPNw0f41cmQfXRl0K3m3cDxSoO3L/+fPEmbr0stBJDDGBmbO7NdEDcuj41ZdvAZvNASeG/PSpbBdICN88O4U28xFl8THgJsfY8mN3meQNrbrw37R2aqhoBbEXjh3ESJL8porluXnJjUyR8pxhr3Xmi4gPxSCNYt4iUu10=;20:Ck33mRu4TQnTRngH+GRCuKIlhYDAHI3pcy7wnFVLql/I4zkWlXWHmpkxvpLd1qIe4o2vmrgGBhuuYR8E0uXOn5Sh52vZf6Z/T3QX9zNyUXES/TszNzAAEu5yb1eY3pTl4yuTqYBgAfKZ2/GWIdplP20z/+WWhjhzGq4ZwFRplT6aITWorMUZxkVm1D6rkKtmbHcUfoHlgCEj3Cs8gaBRny2wAcGA8hL4NDrH5DPFwKDiC64k8+u8S7EuRpwQvVgp6ZGxgLbyIGiEQBI8ZzviYkApneto928yV6v4JutGS4k57Jpbm7hkf4QRsS05w8yI2eQtHMxdqh3HERs4eJa4mmxNPhNp2PGm/YjG26Ba5dNEkr7bVdfF40u0EPSvGPj/h6DU4c71rbUSkSYtNpwNMfVfz27Kx6bdDWAzPZwOqmio0B7+UeybvrmNcPdLVNwpCATS5qV+lPoOFwvgNC3z43G/phSsi0EoGXIYyrTkLe+qtCyABAklpnxOiMwkBna5
X-Microsoft-Antispam-PRVS: <SN6PR03MB37585CC019562CF9AEE3D30A9DBC0@SN6PR03MB3758.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93004095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN6PR03MB3758;BCL:0;PCL:0;RULEID:;SRVR:SN6PR03MB3758;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3758;4:dWo1WUyEw7mxAbTeeCiFrViQjP0tvCof1Ja9kg7/s2ku7DhxUXUSX9AVJIT8SBRWcYI9zTsJI1+T9W44kyj4KrvHvILblQp4b7RUsxFnoGQnm/ytD+jP//mGO2oMTCb/poFfxqEUdR6tqQxfZgnsIw1gHOM71iO6QutfP0m8S5uutFlOHRN9vITuY8Scq5uYlk8ybGgCja7A9dhhIknoG9XxXqQlyOgLj8ISyiIzCmsJ0vFavAEKz0w6XAtHnbIq+qTJcM/ZZdfgi/BKpZrOkA==
X-Forefront-PRVS: 08897B549D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR03MB3758;23:MpUryssVg5g9ogArXC5OH9fmYfq/JD6vTD5y0e2t0?=
 =?us-ascii?Q?ktwiA4jPCWdlEaPNZpp7yfxVQtP4nsVsrURCo+MXHWcwoWSxgIgpcANbpis2?=
 =?us-ascii?Q?/WNylFdPmEbzGP/Q9mJJpjSa85fqM493/z7tH5xq4E6j7sGnyLetBtJoKSSZ?=
 =?us-ascii?Q?/ZGW+OT5ws5zqRcaa+d9X6fIzWNGyXmR/QRi52wc0d/XFNir+ip1chsBBSoj?=
 =?us-ascii?Q?PQ884Onm4tCSzOW/5C+jFaa7e7POvK9IFdnIbsMo0FvAMFKYWsybmSQpIQz3?=
 =?us-ascii?Q?emB5DX9/PnNLmoRiGKYGyPZt5b174HpubPhdPF5XkiYcBWrgP6VrTtiEMjjO?=
 =?us-ascii?Q?r+s91qlvbCTUQtf2KliBpLMdvT3IaP6m6Fd6+zmBQqyXW+ciIhPyqQgNX6jx?=
 =?us-ascii?Q?VkbuqQ0x0ptzteS8FtXskHnRnVKs3VEhZ05CUYK24LPGLvOAgJk5/6jfpdP0?=
 =?us-ascii?Q?hm7c0R0AuNCmCv+oPgD/ZPzoGveAqsV0fNIu91UPx2gdh4I6EQvl8g9Q5zzx?=
 =?us-ascii?Q?dv3/JWdu+cl9E6JB4MAH3VwpQz0b/pua9cqjXIeGDzOTejRlXu36nezTtn6d?=
 =?us-ascii?Q?Fg1DO92OuNgRGtBnHMCz1q16xiIJW2b7usZAFgTrA/a/gjtCf5AdD5nFFsu3?=
 =?us-ascii?Q?lmMYxAVGjXiwrauMu1QGi45n/qOliGUvsQ4poe0/8/ySRpMtM8+aTxaTSioL?=
 =?us-ascii?Q?gIrMBn0wTDNefb9B39yhTycmcAiZ9LWAbSKaQgqliFbj3d111uPGqlgV65rh?=
 =?us-ascii?Q?eWiHVQKPLZizh5xWTNfhT51eBxcDYf4SBZcrBJr8NZZfxcUXEUBVBOvotTN9?=
 =?us-ascii?Q?Ge1lg7SedjKx5gK4SmjthvTm5L0goesuxVAN4xDY8zVhJdQb6k7j+54C0LVn?=
 =?us-ascii?Q?Uk+PNBqYmQJqT9yN0XmuGncBFrDDAYBPBsb88cb955yxg28r4FxnzaV9fMrh?=
 =?us-ascii?Q?xIROoAntTj5V4eKz5suNlVieVU6Uc7Ff9PnrCzsJagSZjNx6G1+CvbaYIb+U?=
 =?us-ascii?Q?/bSLEPhYE2KnBNX/2GrCv2ZrCubkdEEasFhRCwI4y6sL5xN08lImsWXOzD8F?=
 =?us-ascii?Q?sVhkEc=3D?=
X-Microsoft-Antispam-Message-Info: 3q6YZswnDcaUxCiyhxO6oIEjLU0NerSpPlzaZfLSvOF9URG0e6ZNx2ENjDTdeN903c5Pc22CAsrUBdlfKMqOaeox+NHHKM1GiPrUc8rcjNOiUdNoxVC7RAk5Dt8qJfOz+6cMpYWMWMkGCDTA0XU74zFdrNqWEWDyT5+2zgz5AoAWaV56Tpq+98pTR5KYSVpobYuCk2tV4UHEAw472x1Tr/OnyRerwTAQWsYWGkaj52MuO+j0VPd7epi226ivTsyQ2kGWehOB8GqLoML2+wjM9KQA3JCUMeqHqcjVabSTzbLY1P36i/OlLuD2zdfojVJE
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3758;6:eqe6O4Nso8MeA9vgfLTfEkHF3wwuQksedKFiADaR4sj3Wv+xCbkhuzA809uE8nJqj9PBoVJd4MIm/yf5LlEQs6mq2FlMQW1C1vcNq1l8jKkR2i70ZW8ctcDasmR/aKl/IB1TO5Y16xJ9g8RCpqOYzRVj5OXcFsR2jkk/AoDY6BIEpggu1e1IbSCR6QC7FVdgL1/Rrs6hjeTP40HIZv2vy9UHhvp+EoUQhAFlMO26lXRgNoJE27egbyFeZw5/7RZZ/bSxsmaree0marUN/F0MXypoJApwQQa84gIx2mEDOaUvlUOQkZtL0KGABNs72qk3UE4aIaC62IIHgKNOGYYVpHSv/KEV4+ONnVSHFroy8A2DiPoN0pBVj5PfdCdO4y2Au5MeQPVNNXD5rKtocGna5znekol3VwOUAZfoXvhVnh/Nis5il3BykGfJk6B798haB7E5CmorIUNAeKKlKBQhoA==;5:7ww5mb7k3L722d/CH+VwZCHTYmzVEQtq/CWXDKjlNfMv+EAX59NEjzbcSk6e0D+v9SjhVOdPzDXDNBjdGUAUUsFmhaEhT7/M/VMKKmvFaZujNrWdUoV57zClA1Gcxttc7FdDZX2yOkyv+IZ03w13QqjEE8g4l4F91zmU+iUb+o0=;7:/AJYZ0qDkafyV9/KqyDgUrOV09YC2UpChhi7PZ6HsjcA/F11dxfUadftqg5AXYZtv5Nj+ZMYVixvu9LmxmwlJJvLybpkWg1dU5pbBtW/8CGewRGb2uQXqtndql+eJ+Ht6zLP8YPa8D8VW9NfB8q3dw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2018 12:24:06.0275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf80d225-7fd1-448c-023c-08d6641a89d5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
Patch 1:
	- Moved the HAS_IOMEM under AD7606_IFACE_PARALLEL and dropped GPIOLIB.
Patch 2:
	- Used SPDX GPL-2.0 license identifier instead of GPL-2.0+.
Patch 3:
	- Before disabling the buffer, there is no need to trigger a conversion.
Patches 4, 5, 6:
	- Nothing changed.

Stefan Popa (6):
  staging: iio: adc: ad7606: Simplify the Kconfing menu
  staging: iio: adc: ad7606: Use SPDX identifier
  staging: iio: adc: ad7606: Add support for threaded irq
  staging: iio: adc: ad7606: Misc style fixes (no functional change)
  staging: iio: adc: ad7606: Move out of staging
  dt-bindings: iio: adc: Add docs for AD7606 ADC

 .../devicetree/bindings/iio/adc/adi,ad7606.txt     |  65 +++
 MAINTAINERS                                        |   8 +
 drivers/iio/adc/Kconfig                            |  27 +
 drivers/iio/adc/Makefile                           |   3 +
 drivers/iio/adc/ad7606.c                           | 583 +++++++++++++++++++++
 drivers/iio/adc/ad7606.h                           |  99 ++++
 drivers/iio/adc/ad7606_par.c                       | 105 ++++
 drivers/iio/adc/ad7606_spi.c                       |  82 +++
 drivers/staging/iio/adc/Kconfig                    |  34 --
 drivers/staging/iio/adc/Makefile                   |   4 -
 drivers/staging/iio/adc/ad7606.c                   | 534 -------------------
 drivers/staging/iio/adc/ad7606.h                   | 103 ----
 drivers/staging/iio/adc/ad7606_par.c               | 117 -----
 drivers/staging/iio/adc/ad7606_spi.c               |  83 ---
 14 files changed, 972 insertions(+), 875 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
 create mode 100644 drivers/iio/adc/ad7606.c
 create mode 100644 drivers/iio/adc/ad7606.h
 create mode 100644 drivers/iio/adc/ad7606_par.c
 create mode 100644 drivers/iio/adc/ad7606_spi.c
 delete mode 100644 drivers/staging/iio/adc/ad7606.c
 delete mode 100644 drivers/staging/iio/adc/ad7606.h
 delete mode 100644 drivers/staging/iio/adc/ad7606_par.c
 delete mode 100644 drivers/staging/iio/adc/ad7606_spi.c

-- 
2.7.4


Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A47C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5A521473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ifAFTH7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5A521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJRRLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:11:38 -0400
Received: from mail-eopbgr690068.outbound.protection.outlook.com ([40.107.69.68]:10992
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbeJRRLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw6G7npdfufAtmvXxyGEIzt6i41U8MglwDTUJzReJGY=;
 b=ifAFTH7XML8zxaG3E7qd5S6xAkQC1w02cN0+rkOs1Ns/te5Ko+ZCXfDsp20Rbsy5pGKKkqU0G0gHA0DVv/vfQLqC1ybdZXPAqsqH6jp0rx+4WhfsrQFD5WG/Pt7IuYrYMsTjZ7S18OioaYXTsblSgIIHbcQm2O1WN2Jppa6tqmM=
Received: from BN6PR03CA0021.namprd03.prod.outlook.com (2603:10b6:404:23::31)
 by MWHSPR01MB303.namprd03.prod.outlook.com (2603:10b6:301:35::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.23; Thu, 18 Oct
 2018 09:11:21 +0000
Received: from BY2FFO11FD009.protection.gbl (2a01:111:f400:7c0c::138) by
 BN6PR03CA0021.outlook.office365.com (2603:10b6:404:23::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20 via Frontend Transport; Thu, 18 Oct 2018 09:11:20 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD009.mail.protection.outlook.com (10.1.14.73) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.12
 via Frontend Transport; Thu, 18 Oct 2018 09:11:19 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w9I9BIOi000306
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 18 Oct 2018 02:11:18 -0700
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 18 Oct 2018
 05:11:17 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 1/2] staging: iio: ad7606: Move out of staging
Date:   Thu, 18 Oct 2018 12:10:32 +0300
Message-ID: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(438002)(189003)(199004)(44832011)(6916009)(48376002)(107886003)(106002)(2906002)(50466002)(575784001)(186003)(53416004)(5660300001)(26005)(51416003)(7696005)(106466001)(2616005)(126002)(77096007)(14444005)(476003)(2351001)(336012)(47776003)(4744004)(486006)(426003)(50226002)(36756003)(8936002)(316002)(478600001)(6666004)(1720100001)(16586007)(356004)(72206003)(966005)(8676002)(246002)(53946003)(6306002)(7636002)(305945005)(4326008)(54906003)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHSPR01MB303;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD009;1:IbxI0fQwnOomyqDuIX7jhraZ57mZMt4HUJJ9SSZxlUzCLDvz2v9+RDE8vODmPyztPRo71aRalgyNG7jqbCNwJonRZ6r9NSMiX3k4j6Ar984L+KB83Oe4TvFQKpPEJoT5
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57e6e2e-18a2-42ba-7f49-08d634d9aad3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHSPR01MB303;
X-Microsoft-Exchange-Diagnostics: 1;MWHSPR01MB303;3:rEnui8QX7fWhQMPSgeQHAoPh4jamsisdpzl2eIhZaUWWsqNLA96Enqa6avDCv9hHT6cIQduKyYDvKBZMezBthDG4IkeX3G2fdvImQcUqj7JdHfBgckiP0E4Xpw6HtQ2EmrWO+ubgncM7ktLARhUn+0tdiRhUoCZAC/bKZpUb6eFqPLHZjsa0vDIJpCe7m8K67/lBWL9DqqfXTnARuUU/qZjQ76jAHbsCEkg6MLsNIKscKCvMvnCGWqySwDymH9wvPJnM026qHTzIWtmL4zVazi4bs95iLVOjdxrITfDPBurDKczSeY8XVrOw+/ajZpOPJn/hkfqA2IvcM5N3mhdfSBSagORxVK9Z98+55yLR2bs=;25:buq/O+gFFSMdwp/+W0nflxR0tbijvktM+tGQo0zbLCf49lRX8w+2oifvXb0+O2ERRtU5mYf40OW2mbWglj1NBB4WWv2Tv/PUOiRCLbEG/1OHa52a5C/XVicyATNPfy67uHH1cjspnXD4ItdjkdPUToQ+XCkxtJ8/ZtFznaPdnywqW0rkwzfHPDNu/ClkxH6hC2fZ16i3HYUciiyDaHm21+xc+Og4sF80l2dvugAqlX+VmsFU1YzdI2IO53xOL+oRAWUc1l1gwhJOxlwl6Mv1VIhPqw36+r6ZQZvfyIpj/u1dtk8QUZw0zQHmO4XCbr8BiMYxavnK1M/UUNW8oimctA==
X-MS-TrafficTypeDiagnostic: MWHSPR01MB303:
X-Microsoft-Exchange-Diagnostics: 1;MWHSPR01MB303;31:i9SNKilkOudqRV4Z1IkBmL5iUPGH/uQ6X+9Tl5ngDFnwtGfw2K2KQgAgxuXWQKIPofkgKEfxxzHg4grXKVhIQLcAgBW+xaEcvMtgETcp+FAER1nspuHa2M6PNl3l8Je37tq++B4lN9PfAH+coizUdJvzW+TFft8YH3eBgIQR+XucOkb2xVOZGk/U/iR2XZO/8ICtQqvMn7mXP8+EGoA475x0yS/Qyaa57s7Vqlz2sqU=;20:3uvRPUHaRRkW5Oc7L22jLTQ8kH2Gpx+MaZjRSx+kQ8QS/c/CNcHWUwviM+402bXbHOvK50qcxWxE0f0z6SPpJh8FIqHVON2OQvJraYnzDSwPc7I3Ch2yTpKWRZH1JZZrKwkT1DNWZLVInsjZI66Bb1W3TR6tKFIHtGKFoddZi7Jm/cMGdjSOROeb013yFuX/mDX4ldO6MEY7zzmHh0130ChPhpMjWRksfDeIaBWtXJmAUqea9K6ziuAW4DUoIgxhyu/glcMimPEEU6mgV6It3cfLmT1VVAjjKRCrNTQwgmOjGUqhS52vIAnvrAFKNsdvNJBHQGO7+dRoYNEar1w7Lw93UCeakW+8Ne/CVynnzbm+9CVDS3zW7/UP3be7IVoh/cI3Cn7lw1vdy+Bq+AKz+8pjdpy/QxYI1xy0sXDVeoAhiVczClP24LTrKzJNoKDPXIho+pCu7kDjt9/sT96jWJvWBoK8XTWLQ67LqS3Dj/qK9UHXjh/JkHb53MlWpAZT
X-Microsoft-Antispam-PRVS: <MWHSPR01MB303D63D858A37ACE71D13BA9DF80@MWHSPR01MB303.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(9452136761055)(170811661138872)(95692535739014)(72170088055959);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(4982022)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHSPR01MB303;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB303;
X-Microsoft-Exchange-Diagnostics: 1;MWHSPR01MB303;4:eLvrlOJXqZbIgGwxc8jmbs0DByDio0goVGXFyBuiamYj91LaBcc9o8ChrrpPhjfq0QMenyONvaJaNshSMtZdGg8mp7ZzJzPVI0p0MdsRH5tKat4KKZGMkjYFWYTivTSqieeJEjKuhiJAgksVIFoBni/vQ1NYUvQuGi5kfrc5Ya3ys91qal3jATR+0f9D1YWaJEo6nd2zpQqEeMTM0iTu/hMOdTa0z7eWW1TvMCHapsDR7HiT7dsRR232ASq2aXs3EWR1Vdgn93pxdFcD5ph4q61Lnjz0Y55FgMx1Nnf8mPA9zEFoWgH1fxNrDkEaSfKPfE+B9gMuDMglumJGLM8RQiZwdWxVuTX3bhbiut3JM3rLNnE5N+x5euJ9ZQB0e0FrUD21d8kDdgzw7gVhRLYOycPe6Tc4UG7DKqlo3DzMsy3A3bX1roMlJCcIGyHo/gxvuL3L2QDOu8fYQ4h01j5d+Q==
X-Forefront-PRVS: 08296C9B35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHSPR01MB303;23:XyxjUUVHf/I0SUGpgft3bF0bMQrl5wMuzuX2gQI8X?=
 =?us-ascii?Q?klixBaeOUN8DHQHsIZM4MrU9Peb9nlwVWsyCniS8ZfmVXCQ4lT7nFjlVTuoE?=
 =?us-ascii?Q?9ZK8h3Zdx/WzrBnb//fpCgw0CyLbd6meHtt6pNquOJH7rfej2+ZQjDuM85Uo?=
 =?us-ascii?Q?9Mdjf73GXDztlPrd1aWCwly1Qs29/7WU2gwOQIOmR3/FpILQMQdW7ys39O9t?=
 =?us-ascii?Q?q7IGx6Pokf4XpRI9xOfsaon5mAt7NNntm6gY9hNrdQFZdRvirvW8Gn3fladp?=
 =?us-ascii?Q?n8DdaWzVmnxAkpQptTUrVivd6hkXqxp8uH4pa1dBQdOVwDXOUZIHM30n5aNw?=
 =?us-ascii?Q?htx5C+ORx41IILQXNK2BMPd4RFRus9lNvrXFb2HWiAoEedZjAzc3kA8dvcMo?=
 =?us-ascii?Q?5Fc79IcaqfaLM3J+9JyP/TSu1i+MfPnsiHwg1jRlhyZ9ASrIbBQb4ofQwUCn?=
 =?us-ascii?Q?If1H3kmBWYhlc5J4n4Tk6YNGcHJWwuxNrXeyWGxJMehBjQ9xHHD3WB4mD/X3?=
 =?us-ascii?Q?5ML9SpynWQojQQ78BFkZW5JMlTn89jwtXqg82e0vEqW+KecG+5fW9ihJt1cQ?=
 =?us-ascii?Q?9MCvCbTew9qyKajFpzT7D6eyl1oyKZNvQOrwzc/CXeMPP+taWSvJCPAysTAI?=
 =?us-ascii?Q?JhubxRpWk6lHOunArGeiHHnMyfcNP8xU0rkQrTFfx9rn+7PgTHuuyRsT+2ol?=
 =?us-ascii?Q?ON1lo5f/Aoqd/gIbOAXxWleAHwX/lO76lWzPFMUjg0fvO2iDm/KvxIo0jVnd?=
 =?us-ascii?Q?KpocreuKHC+GVVrZj9KUFY1JssvxLiOza+EBRSBrJVwkK1LO97KTyxr2YRaZ?=
 =?us-ascii?Q?+d6g6i0a9gOQUElRd1eciQFiCnHfSpXqmInq+f/mmUmHLc8h80XL/VkmAPYF?=
 =?us-ascii?Q?l6hRPmofPrwo7S/M6mdurw4RB2D5lokCQDsIn2ksH5UKjTRrMBqk/pxZfQNk?=
 =?us-ascii?Q?jcpjPu5d0ygGh+rc6aLx2C61tMyubrpTc7OeL2AHvkFjGVRt2QMrW1ye9jmJ?=
 =?us-ascii?Q?dq8GWIUi+0KFoXN/Ma6YtpjX2qdadJqA1BU0bVc/yBaH8gHt/km85lfSPlQ+?=
 =?us-ascii?Q?UbSRLhVm5JnSN9CTi9UmUHAbn73zet2EKAbhuSb61SqOfyF5gy428ZmLIhnS?=
 =?us-ascii?Q?QvHOEUfIFuoJ/XsWqu98PCG65aHjulrqYw3QB8hryFjZZCKlL10E17AhbYMT?=
 =?us-ascii?Q?7ZhLbcaf7ZkigSsblisLooXHz5BtgYSPJKZ?=
X-Microsoft-Antispam-Message-Info: PSqydw548nXhVAOt4+bG6OFloG5iw9z4IhNSpNKK29OAhGDVPhDjBQarN/jrOMkVBL+WpARJRfy2g327sLKWUTouwwnCetM595MLXNZQWbCj1cPH+H+j8cGbhK4AQhVpLplHDDYeYcHuW8fN28HWzJht5serTnvqlYp/OS+ScR9qxIVRQN6kmy8HuYqKprW3Z2qONR7lrxabdgCPHftLJHKySPSIBoKbyLHnII+vFNUH9Cl9AHZ2vQpRk2Lx/+xMwK1HpeyF44NmXMSpFOU3Awj8VTPVMk+zREKpB39p2XeUqlWXPSVaVp/9WdHc3pwxJkbvc5HBCITOvI4kPpEgWV9rl2PYBfjv4woDiVpgM2A=
X-Microsoft-Exchange-Diagnostics: 1;MWHSPR01MB303;6:c3PISTh0tGWHGASzdrWKKQw3P9KNP4vIUFLA9+L4+jJGMnceK9pIE4QfnZxLy2gQbXc8z9X7msqZNltxeLLNhvh/Y6Y4Yc74feHqI8GY9OBS6mibanj3x2hUNot488i1xccd4LBFk3HRdyAq+wcLnqNDsWAvU8Uqb39yZbAZNoG97lFdS/BkDLLuxT9UbE6eJgQzi/1okM+kLhUNochO7L7ojQ9Ee+AEPOmEmVjEK/ojWZCXw9mPCAjRCXu+SKlJ0FOq+/YZBrKDu0FpLBTDJMvZqXJUfL7qCGXOfv2VRE7Z7bj7kIXqmF49hF82AqoATe883AMR4KqpSJWQwaH/ukA3cCXgWuu1T2KuAzyBd2oA3ZYHcMLoX7jkND/ZoPtlWsotYwCjeDO8GVqJ6H960uK/CSdsc+9oMP9h/O+OcBXQH9LWgH/G03bjRdHkpBZUshqVoPKXDWwXKvcFAQpJ8Q==;5:D82ohFLi1cT5Pk33KvnsCXGGb1fLCxxJRhG75n8RfDyVjTYrPvnw29TxoHgrBubIitcsK0LI23rl5N4sdhIl1g9bqjq7zjFVBEsxTqapWOIEm64ZORtfbrACyKZOHcLZ50k8b9AwHcIOzGBYN+9CngZfiWv3F14ESsqg/pKXyBg=;7:tGfuNBw1KI9vKtpbsSryrUk95NfcQ425Oqv8UJo/DZC+XA6aDjZ0oN0szwMPgcDEN+ufvDOWcvD2aymabyGXFsov7T4EqoNNO9dYaFyASVQD9oVmYCfFkd2LxmfJXqpQGIoNm95SprAX0LbDeXVsYqqWnnLvax+ldiuZxGMw6Vc15yKw9ZaZaD/1eSFEMaSB2yBbP8YGWhz73XgyYtMWKMtplj0twK2RCoh80BtbsTPIA3TkbMBRUAYhzeWhUUty
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2018 09:11:19.2101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57e6e2e-18a2-42ba-7f49-08d634d9aad3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB303
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ad7606 ADC driver out of staging and into the mainline.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS                          |   7 +
 drivers/iio/adc/Kconfig              |  34 +++
 drivers/iio/adc/Makefile             |   3 +
 drivers/iio/adc/ad7606.c             | 565 +++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h             | 106 +++++++
 drivers/iio/adc/ad7606_par.c         | 113 +++++++
 drivers/iio/adc/ad7606_spi.c         |  79 +++++
 drivers/staging/iio/adc/Kconfig      |  34 ---
 drivers/staging/iio/adc/Makefile     |   3 -
 drivers/staging/iio/adc/ad7606.c     | 565 -----------------------------------
 drivers/staging/iio/adc/ad7606.h     | 106 -------
 drivers/staging/iio/adc/ad7606_par.c | 113 -------
 drivers/staging/iio/adc/ad7606_spi.c |  79 -----
 13 files changed, 907 insertions(+), 900 deletions(-)
 create mode 100644 drivers/iio/adc/ad7606.c
 create mode 100644 drivers/iio/adc/ad7606.h
 create mode 100644 drivers/iio/adc/ad7606_par.c
 create mode 100644 drivers/iio/adc/ad7606_spi.c
 delete mode 100644 drivers/staging/iio/adc/ad7606.c
 delete mode 100644 drivers/staging/iio/adc/ad7606.h
 delete mode 100644 drivers/staging/iio/adc/ad7606_par.c
 delete mode 100644 drivers/staging/iio/adc/ad7606_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f642044..843545d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -839,6 +839,13 @@ S:	Supported
 F:	drivers/iio/dac/ad5758.c
 F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
+ANALOG DEVICES INC AD7606 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/adc/ad7606.c
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a52fea8..22bafdc 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -58,6 +58,40 @@ config AD7476
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7476.
 
+config AD7606
+	tristate "Analog Devices AD7606 ADC driver"
+	depends on GPIOLIB || COMPILE_TEST
+	depends on HAS_IOMEM
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices:
+	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7606.
+
+config AD7606_IFACE_PARALLEL
+	tristate "parallel interface support"
+	depends on AD7606
+	help
+	  Say yes here to include parallel interface support on the AD7606
+	  ADC driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7606_parallel.
+
+config AD7606_IFACE_SPI
+	tristate "spi interface support"
+	depends on AD7606
+	depends on SPI
+	help
+	  Say yes here to include parallel interface support on the AD7606
+	  ADC driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7606_spi.
+
 config AD7766
 	tristate "Analog Devices AD7766/AD7767 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index a6e6a0b..b734f4f 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -8,6 +8,9 @@ obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD7266) += ad7266.o
 obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7298) += ad7298.o
+obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
+obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
+obj-$(CONFIG_AD7606) += ad7606.o
 obj-$(CONFIG_AD7923) += ad7923.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7766) += ad7766.o
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
new file mode 100644
index 0000000..0b728b6
--- /dev/null
+++ b/drivers/iio/adc/ad7606.c
@@ -0,0 +1,565 @@
+/*
+ * AD7606 SPI ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "ad7606.h"
+
+/*
+ * Scales are computed as 5000/32768 and 10000/32768 respectively,
+ * so that when applied to the raw values they provide mV values
+ */
+static const unsigned int scale_avail[2][2] = {
+	{0, 152588}, {0, 305176}
+};
+
+static int ad7606_reset(struct ad7606_state *st)
+{
+	if (st->gpio_reset) {
+		gpiod_set_value(st->gpio_reset, 1);
+		ndelay(100); /* t_reset >= 100ns */
+		gpiod_set_value(st->gpio_reset, 0);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static int ad7606_read_samples(struct ad7606_state *st)
+{
+	unsigned int num = st->chip_info->num_channels;
+	u16 *data = st->data;
+	int ret;
+
+	/*
+	 * The frstdata signal is set to high while and after reading the sample
+	 * of the first channel and low for all other channels. This can be used
+	 * to check that the incoming data is correctly aligned. During normal
+	 * operation the data should never become unaligned, but some glitch or
+	 * electrostatic discharge might cause an extra read or clock cycle.
+	 * Monitoring the frstdata signal allows to recover from such failure
+	 * situations.
+	 */
+
+	if (st->gpio_frstdata) {
+		ret = st->bops->read_block(st->dev, 1, data);
+		if (ret)
+			return ret;
+
+		if (!gpiod_get_value(st->gpio_frstdata)) {
+			ad7606_reset(st);
+			return -EIO;
+		}
+
+		data++;
+		num--;
+	}
+
+	return st->bops->read_block(st->dev, num, data);
+}
+
+static irqreturn_t ad7606_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct ad7606_state *st = iio_priv(pf->indio_dev);
+
+	gpiod_set_value(st->gpio_convst, 1);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring buffer
+ * @work_s:	the work struct through which this was scheduled
+ *
+ * Currently there is no option in this driver to disable the saving of
+ * timestamps within the ring.
+ * I think the one copy of this at a time was to avoid problems if the
+ * trigger was set far too high and the reads then locked up the computer.
+ **/
+static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
+{
+	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
+						poll_work);
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
+	int ret;
+
+	ret = ad7606_read_samples(st);
+	if (ret == 0)
+		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
+						   iio_get_time_ns(indio_dev));
+
+	gpiod_set_value(st->gpio_convst, 0);
+	iio_trigger_notify_done(indio_dev->trig);
+}
+
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->done = false;
+	gpiod_set_value(st->gpio_convst, 1);
+
+	ret = wait_event_interruptible(st->wq_data_avail, st->done);
+	if (ret)
+		goto error_ret;
+
+	ret = ad7606_read_samples(st);
+	if (ret == 0)
+		ret = st->data[ch];
+
+error_ret:
+	gpiod_set_value(st->gpio_convst, 0);
+
+	return ret;
+}
+
+static int ad7606_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	int ret;
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7606_scan_direct(indio_dev, chan->address);
+		iio_device_release_direct_mode(indio_dev);
+
+		if (ret < 0)
+			return ret;
+		*val = (short)ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = scale_avail[st->range][0];
+		*val2 = scale_avail[st->range][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->oversampling;
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+static ssize_t in_voltage_scale_available_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	int i, len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
+				 scale_avail[i][0], scale_avail[i][1]);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
+
+static int ad7606_oversampling_get_index(unsigned int val)
+{
+	unsigned char supported[] = {1, 2, 4, 8, 16, 32, 64};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(supported); i++)
+		if (val == supported[i])
+			return i;
+
+	return -EINVAL;
+}
+
+static int ad7606_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int values[3];
+	int ret, i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = -EINVAL;
+		mutex_lock(&st->lock);
+		for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
+			if (val2 == scale_avail[i][1]) {
+				gpiod_set_value(st->gpio_range, i);
+				st->range = i;
+
+				ret = 0;
+				break;
+			}
+		mutex_unlock(&st->lock);
+
+		return ret;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if (val2)
+			return -EINVAL;
+		ret = ad7606_oversampling_get_index(val);
+		if (ret < 0)
+			return ret;
+
+		values[0] = (ret >> 0) & 1;
+		values[1] = (ret >> 1) & 1;
+		values[2] = (ret >> 2) & 1;
+
+		mutex_lock(&st->lock);
+		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
+				      values);
+		st->oversampling = val;
+		mutex_unlock(&st->lock);
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
+
+static struct attribute *ad7606_attributes_os_and_range[] = {
+	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
+	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7606_attribute_group_os_and_range = {
+	.attrs = ad7606_attributes_os_and_range,
+};
+
+static struct attribute *ad7606_attributes_os[] = {
+	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7606_attribute_group_os = {
+	.attrs = ad7606_attributes_os,
+};
+
+static struct attribute *ad7606_attributes_range[] = {
+	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7606_attribute_group_range = {
+	.attrs = ad7606_attributes_range,
+};
+
+#define AD760X_CHANNEL(num, mask)				\
+	{							\
+		.type = IIO_VOLTAGE,				\
+		.indexed = 1,					\
+		.channel = num,					\
+		.address = num,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
+		.info_mask_shared_by_all = mask,		\
+		.scan_index = num,				\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 16,				\
+			.storagebits = 16,			\
+			.endianness = IIO_CPU,			\
+		},						\
+	}
+
+#define AD7605_CHANNEL(num)	\
+	AD760X_CHANNEL(num, 0)
+
+#define AD7606_CHANNEL(num)	\
+	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
+
+static const struct iio_chan_spec ad7605_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+	AD7605_CHANNEL(0),
+	AD7605_CHANNEL(1),
+	AD7605_CHANNEL(2),
+	AD7605_CHANNEL(3),
+};
+
+static const struct iio_chan_spec ad7606_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7606_CHANNEL(0),
+	AD7606_CHANNEL(1),
+	AD7606_CHANNEL(2),
+	AD7606_CHANNEL(3),
+	AD7606_CHANNEL(4),
+	AD7606_CHANNEL(5),
+	AD7606_CHANNEL(6),
+	AD7606_CHANNEL(7),
+};
+
+static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
+	/*
+	 * More devices added in future
+	 */
+	[ID_AD7605_4] = {
+		.channels = ad7605_channels,
+		.num_channels = 5,
+	},
+	[ID_AD7606_8] = {
+		.channels = ad7606_channels,
+		.num_channels = 9,
+		.has_oversampling = true,
+	},
+	[ID_AD7606_6] = {
+		.channels = ad7606_channels,
+		.num_channels = 7,
+		.has_oversampling = true,
+	},
+	[ID_AD7606_4] = {
+		.channels = ad7606_channels,
+		.num_channels = 5,
+		.has_oversampling = true,
+	},
+};
+
+static int ad7606_request_gpios(struct ad7606_state *st)
+{
+	struct device *dev = st->dev;
+
+	st->gpio_convst = devm_gpiod_get(dev, "conversion-start",
+					 GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_convst))
+		return PTR_ERR(st->gpio_convst);
+
+	st->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_reset))
+		return PTR_ERR(st->gpio_reset);
+
+	st->gpio_range = devm_gpiod_get_optional(dev, "range", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_range))
+		return PTR_ERR(st->gpio_range);
+
+	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_standby))
+		return PTR_ERR(st->gpio_standby);
+
+	st->gpio_frstdata = devm_gpiod_get_optional(dev, "first-data",
+						    GPIOD_IN);
+	if (IS_ERR(st->gpio_frstdata))
+		return PTR_ERR(st->gpio_frstdata);
+
+	if (!st->chip_info->has_oversampling)
+		return 0;
+
+	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
+			GPIOD_OUT_LOW);
+	return PTR_ERR_OR_ZERO(st->gpio_os);
+}
+
+/**
+ *  Interrupt handler
+ */
+static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev)) {
+		schedule_work(&st->poll_work);
+	} else {
+		st->done = true;
+		wake_up_interruptible(&st->wq_data_avail);
+	}
+
+	return IRQ_HANDLED;
+};
+
+static const struct iio_info ad7606_info_no_os_or_range = {
+	.read_raw = &ad7606_read_raw,
+};
+
+static const struct iio_info ad7606_info_os_and_range = {
+	.read_raw = &ad7606_read_raw,
+	.write_raw = &ad7606_write_raw,
+	.attrs = &ad7606_attribute_group_os_and_range,
+};
+
+static const struct iio_info ad7606_info_os = {
+	.read_raw = &ad7606_read_raw,
+	.write_raw = &ad7606_write_raw,
+	.attrs = &ad7606_attribute_group_os,
+};
+
+static const struct iio_info ad7606_info_range = {
+	.read_raw = &ad7606_read_raw,
+	.write_raw = &ad7606_write_raw,
+	.attrs = &ad7606_attribute_group_range,
+};
+
+int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
+		 const char *name, unsigned int id,
+		 const struct ad7606_bus_ops *bops)
+{
+	struct ad7606_state *st;
+	int ret;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->dev = dev;
+	mutex_init(&st->lock);
+	st->bops = bops;
+	st->base_address = base_address;
+	/* tied to logic low, analog input range is +/- 5V */
+	st->range = 0;
+	st->oversampling = 1;
+	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
+
+	st->reg = devm_regulator_get(dev, "avcc");
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(dev, "Failed to enable specified AVcc supply\n");
+		return ret;
+	}
+
+	st->chip_info = &ad7606_chip_info_tbl[id];
+
+	ret = ad7606_request_gpios(st);
+	if (ret)
+		goto error_disable_reg;
+
+	indio_dev->dev.parent = dev;
+	if (st->gpio_os) {
+		if (st->gpio_range)
+			indio_dev->info = &ad7606_info_os_and_range;
+		else
+			indio_dev->info = &ad7606_info_os;
+	} else {
+		if (st->gpio_range)
+			indio_dev->info = &ad7606_info_range;
+		else
+			indio_dev->info = &ad7606_info_no_os_or_range;
+	}
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = name;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+
+	init_waitqueue_head(&st->wq_data_avail);
+
+	ret = ad7606_reset(st);
+	if (ret)
+		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
+
+	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
+			  indio_dev);
+	if (ret)
+		goto error_disable_reg;
+
+	ret = iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
+					 NULL, NULL);
+	if (ret)
+		goto error_free_irq;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unregister_ring;
+
+	dev_set_drvdata(dev, indio_dev);
+
+	return 0;
+error_unregister_ring:
+	iio_triggered_buffer_cleanup(indio_dev);
+
+error_free_irq:
+	free_irq(irq, indio_dev);
+
+error_disable_reg:
+	regulator_disable(st->reg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ad7606_probe);
+
+int ad7606_remove(struct device *dev, int irq)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+
+	free_irq(irq, indio_dev);
+	regulator_disable(st->reg);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ad7606_remove);
+
+#ifdef CONFIG_PM_SLEEP
+
+static int ad7606_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (st->gpio_standby) {
+		gpiod_set_value(st->gpio_range, 1);
+		gpiod_set_value(st->gpio_standby, 0);
+	}
+
+	return 0;
+}
+
+static int ad7606_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (st->gpio_standby) {
+		gpiod_set_value(st->gpio_range, st->range);
+		gpiod_set_value(st->gpio_standby, 1);
+		ad7606_reset(st);
+	}
+
+	return 0;
+}
+
+SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
+EXPORT_SYMBOL_GPL(ad7606_pm_ops);
+
+#endif
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
new file mode 100644
index 0000000..8618805
--- /dev/null
+++ b/drivers/iio/adc/ad7606.h
@@ -0,0 +1,106 @@
+/*
+ * AD7606 ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef IIO_ADC_AD7606_H_
+#define IIO_ADC_AD7606_H_
+
+/**
+ * struct ad7606_chip_info - chip specific information
+ * @channels:		channel specification
+ * @num_channels:	number of channels
+ * @has_oversampling:   whether the device has oversampling support
+ */
+
+struct ad7606_chip_info {
+	const struct iio_chan_spec	*channels;
+	unsigned int			num_channels;
+	bool				has_oversampling;
+};
+
+/**
+ * struct ad7606_state - driver instance specific data
+ * @dev		pointer to kernel device
+ * @chip_info		entry in the table of chips that describes this device
+ * @reg		regulator info for the the power supply of the device
+ * @poll_work		work struct for continuously reading data from the device
+ *			into an IIO triggered buffer
+ * @wq_data_avail	wait queue struct for buffer mode
+ * @bops		bus operations (SPI or parallel)
+ * @range		voltage range selection, selects which scale to apply
+ * @oversampling	oversampling selection
+ * @done		marks whether reading data is done
+ * @base_address	address from where to read data in parallel operation
+ * @lock		protect sensor state from concurrent accesses to GPIOs
+ * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
+ * @gpio_reset		GPIO descriptor for device hard-reset
+ * @gpio_range		GPIO descriptor for range selection
+ * @gpio_standby	GPIO descriptor for stand-by signal (STBY),
+ *			controls power-down mode of device
+ * @gpio_frstdata	GPIO descriptor for reading from device when data
+ *			is being read on the first channel
+ * @gpio_os		GPIO descriptors to control oversampling on the device
+ * @data		buffer for reading data from the device
+ */
+
+struct ad7606_state {
+	struct device			*dev;
+	const struct ad7606_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct work_struct		poll_work;
+	wait_queue_head_t		wq_data_avail;
+	const struct ad7606_bus_ops	*bops;
+	unsigned int			range;
+	unsigned int			oversampling;
+	bool				done;
+	void __iomem			*base_address;
+
+	struct mutex			lock; /* protect sensor state */
+	struct gpio_desc		*gpio_convst;
+	struct gpio_desc		*gpio_reset;
+	struct gpio_desc		*gpio_range;
+	struct gpio_desc		*gpio_standby;
+	struct gpio_desc		*gpio_frstdata;
+	struct gpio_descs		*gpio_os;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 * 8 * 16-bit samples + 64-bit timestamp
+	 */
+	unsigned short			data[12] ____cacheline_aligned;
+};
+
+/**
+ * struct ad7606_bus_ops - driver bus operations
+ * @read_block		function pointer for reading blocks of data
+ */
+struct ad7606_bus_ops {
+	/* more methods added in future? */
+	int (*read_block)(struct device *dev, int num, void *data);
+};
+
+int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
+		 const char *name, unsigned int id,
+		 const struct ad7606_bus_ops *bops);
+int ad7606_remove(struct device *dev, int irq);
+
+enum ad7606_supported_device_ids {
+	ID_AD7605_4,
+	ID_AD7606_8,
+	ID_AD7606_6,
+	ID_AD7606_4
+};
+
+#ifdef CONFIG_PM_SLEEP
+extern const struct dev_pm_ops ad7606_pm_ops;
+#define AD7606_PM_OPS (&ad7606_pm_ops)
+#else
+#define AD7606_PM_OPS NULL
+#endif
+
+#endif /* IIO_ADC_AD7606_H_ */
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
new file mode 100644
index 0000000..8bd86e7
--- /dev/null
+++ b/drivers/iio/adc/ad7606_par.c
@@ -0,0 +1,113 @@
+/*
+ * AD7606 Parallel Interface ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <linux/iio/iio.h>
+#include "ad7606.h"
+
+static int ad7606_par16_read_block(struct device *dev,
+				   int count, void *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	insw((unsigned long)st->base_address, buf, count);
+
+	return 0;
+}
+
+static const struct ad7606_bus_ops ad7606_par16_bops = {
+	.read_block	= ad7606_par16_read_block,
+};
+
+static int ad7606_par8_read_block(struct device *dev,
+				  int count, void *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	insb((unsigned long)st->base_address, buf, count * 2);
+
+	return 0;
+}
+
+static const struct ad7606_bus_ops ad7606_par8_bops = {
+	.read_block	= ad7606_par8_read_block,
+};
+
+static int ad7606_par_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct resource *res;
+	void __iomem *addr;
+	resource_size_t remap_size;
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq: %d\n", irq);
+		return irq;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
+
+	remap_size = resource_size(res);
+
+	return ad7606_probe(&pdev->dev, irq, addr,
+			    id->name, id->driver_data,
+			    remap_size > 1 ? &ad7606_par16_bops :
+			    &ad7606_par8_bops);
+}
+
+static int ad7606_par_remove(struct platform_device *pdev)
+{
+	return ad7606_remove(&pdev->dev, platform_get_irq(pdev, 0));
+}
+
+static const struct platform_device_id ad7606_driver_ids[] = {
+	{
+		.name		= "ad7605-4",
+		.driver_data	= ID_AD7605_4,
+	}, {
+		.name		= "ad7606-8",
+		.driver_data	= ID_AD7606_8,
+	}, {
+		.name		= "ad7606-6",
+		.driver_data	= ID_AD7606_6,
+	}, {
+		.name		= "ad7606-4",
+		.driver_data	= ID_AD7606_4,
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
+
+static struct platform_driver ad7606_driver = {
+	.probe = ad7606_par_probe,
+	.remove	= ad7606_par_remove,
+	.id_table = ad7606_driver_ids,
+	.driver = {
+		.name	 = "ad7606",
+		.pm	 = AD7606_PM_OPS,
+	},
+};
+
+module_platform_driver(ad7606_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
new file mode 100644
index 0000000..b76ca5a
--- /dev/null
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -0,0 +1,79 @@
+/*
+ * AD7606 SPI ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/err.h>
+
+#include <linux/iio/iio.h>
+#include "ad7606.h"
+
+#define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
+
+static int ad7606_spi_read_block(struct device *dev,
+				 int count, void *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int i, ret;
+	unsigned short *data = buf;
+	__be16 *bdata = buf;
+
+	ret = spi_read(spi, buf, count * 2);
+	if (ret < 0) {
+		dev_err(&spi->dev, "SPI read error\n");
+		return ret;
+	}
+
+	for (i = 0; i < count; i++)
+		data[i] = be16_to_cpu(bdata[i]);
+
+	return 0;
+}
+
+static const struct ad7606_bus_ops ad7606_spi_bops = {
+	.read_block	= ad7606_spi_read_block,
+};
+
+static int ad7606_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+
+	return ad7606_probe(&spi->dev, spi->irq, NULL,
+			    id->name, id->driver_data,
+			    &ad7606_spi_bops);
+}
+
+static int ad7606_spi_remove(struct spi_device *spi)
+{
+	return ad7606_remove(&spi->dev, spi->irq);
+}
+
+static const struct spi_device_id ad7606_id[] = {
+	{"ad7605-4", ID_AD7605_4},
+	{"ad7606-8", ID_AD7606_8},
+	{"ad7606-6", ID_AD7606_6},
+	{"ad7606-4", ID_AD7606_4},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad7606_id);
+
+static struct spi_driver ad7606_driver = {
+	.driver = {
+		.name = "ad7606",
+		.pm = AD7606_PM_OPS,
+	},
+	.probe = ad7606_spi_probe,
+	.remove = ad7606_spi_remove,
+	.id_table = ad7606_id,
+};
+module_spi_driver(ad7606_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 9d3062a..2c05adb 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -3,40 +3,6 @@
 #
 menu "Analog to digital converters"
 
-config AD7606
-	tristate "Analog Devices AD7606 ADC driver"
-	depends on GPIOLIB || COMPILE_TEST
-	depends on HAS_IOMEM
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for Analog Devices:
-	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606.
-
-config AD7606_IFACE_PARALLEL
-	tristate "parallel interface support"
-	depends on AD7606
-	help
-	  Say yes here to include parallel interface support on the AD7606
-	  ADC driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606_parallel.
-
-config AD7606_IFACE_SPI
-	tristate "spi interface support"
-	depends on AD7606
-	depends on SPI
-	help
-	  Say yes here to include parallel interface support on the AD7606
-	  ADC driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606_spi.
-
 config AD7780
 	tristate "Analog Devices AD7780 and similar ADCs driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index ebe83c1..57a18e7 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -3,9 +3,6 @@
 # Makefile for industrial I/O ADC drivers
 #
 
-obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
-obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
-obj-$(CONFIG_AD7606) += ad7606.o
 
 obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7816) += ad7816.o
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
deleted file mode 100644
index 0b728b6..0000000
--- a/drivers/staging/iio/adc/ad7606.c
+++ /dev/null
@@ -1,565 +0,0 @@
-/*
- * AD7606 SPI ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/regulator/consumer.h>
-#include <linux/err.h>
-#include <linux/gpio/consumer.h>
-#include <linux/delay.h>
-#include <linux/sched.h>
-#include <linux/module.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
-
-#include "ad7606.h"
-
-/*
- * Scales are computed as 5000/32768 and 10000/32768 respectively,
- * so that when applied to the raw values they provide mV values
- */
-static const unsigned int scale_avail[2][2] = {
-	{0, 152588}, {0, 305176}
-};
-
-static int ad7606_reset(struct ad7606_state *st)
-{
-	if (st->gpio_reset) {
-		gpiod_set_value(st->gpio_reset, 1);
-		ndelay(100); /* t_reset >= 100ns */
-		gpiod_set_value(st->gpio_reset, 0);
-		return 0;
-	}
-
-	return -ENODEV;
-}
-
-static int ad7606_read_samples(struct ad7606_state *st)
-{
-	unsigned int num = st->chip_info->num_channels;
-	u16 *data = st->data;
-	int ret;
-
-	/*
-	 * The frstdata signal is set to high while and after reading the sample
-	 * of the first channel and low for all other channels. This can be used
-	 * to check that the incoming data is correctly aligned. During normal
-	 * operation the data should never become unaligned, but some glitch or
-	 * electrostatic discharge might cause an extra read or clock cycle.
-	 * Monitoring the frstdata signal allows to recover from such failure
-	 * situations.
-	 */
-
-	if (st->gpio_frstdata) {
-		ret = st->bops->read_block(st->dev, 1, data);
-		if (ret)
-			return ret;
-
-		if (!gpiod_get_value(st->gpio_frstdata)) {
-			ad7606_reset(st);
-			return -EIO;
-		}
-
-		data++;
-		num--;
-	}
-
-	return st->bops->read_block(st->dev, num, data);
-}
-
-static irqreturn_t ad7606_trigger_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct ad7606_state *st = iio_priv(pf->indio_dev);
-
-	gpiod_set_value(st->gpio_convst, 1);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring buffer
- * @work_s:	the work struct through which this was scheduled
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- * I think the one copy of this at a time was to avoid problems if the
- * trigger was set far too high and the reads then locked up the computer.
- **/
-static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
-{
-	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
-						poll_work);
-	struct iio_dev *indio_dev = iio_priv_to_dev(st);
-	int ret;
-
-	ret = ad7606_read_samples(st);
-	if (ret == 0)
-		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
-						   iio_get_time_ns(indio_dev));
-
-	gpiod_set_value(st->gpio_convst, 0);
-	iio_trigger_notify_done(indio_dev->trig);
-}
-
-static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-	int ret;
-
-	st->done = false;
-	gpiod_set_value(st->gpio_convst, 1);
-
-	ret = wait_event_interruptible(st->wq_data_avail, st->done);
-	if (ret)
-		goto error_ret;
-
-	ret = ad7606_read_samples(st);
-	if (ret == 0)
-		ret = st->data[ch];
-
-error_ret:
-	gpiod_set_value(st->gpio_convst, 0);
-
-	return ret;
-}
-
-static int ad7606_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val,
-			   int *val2,
-			   long m)
-{
-	int ret;
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	switch (m) {
-	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = ad7606_scan_direct(indio_dev, chan->address);
-		iio_device_release_direct_mode(indio_dev);
-
-		if (ret < 0)
-			return ret;
-		*val = (short)ret;
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		*val = scale_avail[st->range][0];
-		*val2 = scale_avail[st->range][1];
-		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		*val = st->oversampling;
-		return IIO_VAL_INT;
-	}
-	return -EINVAL;
-}
-
-static ssize_t in_voltage_scale_available_show(struct device *dev,
-					       struct device_attribute *attr,
-					       char *buf)
-{
-	int i, len = 0;
-
-	for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
-				 scale_avail[i][0], scale_avail[i][1]);
-
-	buf[len - 1] = '\n';
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
-
-static int ad7606_oversampling_get_index(unsigned int val)
-{
-	unsigned char supported[] = {1, 2, 4, 8, 16, 32, 64};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(supported); i++)
-		if (val == supported[i])
-			return i;
-
-	return -EINVAL;
-}
-
-static int ad7606_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val,
-			    int val2,
-			    long mask)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-	int values[3];
-	int ret, i;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		ret = -EINVAL;
-		mutex_lock(&st->lock);
-		for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
-			if (val2 == scale_avail[i][1]) {
-				gpiod_set_value(st->gpio_range, i);
-				st->range = i;
-
-				ret = 0;
-				break;
-			}
-		mutex_unlock(&st->lock);
-
-		return ret;
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		if (val2)
-			return -EINVAL;
-		ret = ad7606_oversampling_get_index(val);
-		if (ret < 0)
-			return ret;
-
-		values[0] = (ret >> 0) & 1;
-		values[1] = (ret >> 1) & 1;
-		values[2] = (ret >> 2) & 1;
-
-		mutex_lock(&st->lock);
-		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
-				      values);
-		st->oversampling = val;
-		mutex_unlock(&st->lock);
-
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
-static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
-
-static struct attribute *ad7606_attributes_os_and_range[] = {
-	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
-	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7606_attribute_group_os_and_range = {
-	.attrs = ad7606_attributes_os_and_range,
-};
-
-static struct attribute *ad7606_attributes_os[] = {
-	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7606_attribute_group_os = {
-	.attrs = ad7606_attributes_os,
-};
-
-static struct attribute *ad7606_attributes_range[] = {
-	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7606_attribute_group_range = {
-	.attrs = ad7606_attributes_range,
-};
-
-#define AD760X_CHANNEL(num, mask)				\
-	{							\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = num,					\
-		.address = num,					\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
-		.info_mask_shared_by_all = mask,		\
-		.scan_index = num,				\
-		.scan_type = {					\
-			.sign = 's',				\
-			.realbits = 16,				\
-			.storagebits = 16,			\
-			.endianness = IIO_CPU,			\
-		},						\
-	}
-
-#define AD7605_CHANNEL(num)	\
-	AD760X_CHANNEL(num, 0)
-
-#define AD7606_CHANNEL(num)	\
-	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
-
-static const struct iio_chan_spec ad7605_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(4),
-	AD7605_CHANNEL(0),
-	AD7605_CHANNEL(1),
-	AD7605_CHANNEL(2),
-	AD7605_CHANNEL(3),
-};
-
-static const struct iio_chan_spec ad7606_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0),
-	AD7606_CHANNEL(1),
-	AD7606_CHANNEL(2),
-	AD7606_CHANNEL(3),
-	AD7606_CHANNEL(4),
-	AD7606_CHANNEL(5),
-	AD7606_CHANNEL(6),
-	AD7606_CHANNEL(7),
-};
-
-static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
-	/*
-	 * More devices added in future
-	 */
-	[ID_AD7605_4] = {
-		.channels = ad7605_channels,
-		.num_channels = 5,
-	},
-	[ID_AD7606_8] = {
-		.channels = ad7606_channels,
-		.num_channels = 9,
-		.has_oversampling = true,
-	},
-	[ID_AD7606_6] = {
-		.channels = ad7606_channels,
-		.num_channels = 7,
-		.has_oversampling = true,
-	},
-	[ID_AD7606_4] = {
-		.channels = ad7606_channels,
-		.num_channels = 5,
-		.has_oversampling = true,
-	},
-};
-
-static int ad7606_request_gpios(struct ad7606_state *st)
-{
-	struct device *dev = st->dev;
-
-	st->gpio_convst = devm_gpiod_get(dev, "conversion-start",
-					 GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_convst))
-		return PTR_ERR(st->gpio_convst);
-
-	st->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_reset))
-		return PTR_ERR(st->gpio_reset);
-
-	st->gpio_range = devm_gpiod_get_optional(dev, "range", GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_range))
-		return PTR_ERR(st->gpio_range);
-
-	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
-						   GPIOD_OUT_HIGH);
-	if (IS_ERR(st->gpio_standby))
-		return PTR_ERR(st->gpio_standby);
-
-	st->gpio_frstdata = devm_gpiod_get_optional(dev, "first-data",
-						    GPIOD_IN);
-	if (IS_ERR(st->gpio_frstdata))
-		return PTR_ERR(st->gpio_frstdata);
-
-	if (!st->chip_info->has_oversampling)
-		return 0;
-
-	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
-			GPIOD_OUT_LOW);
-	return PTR_ERR_OR_ZERO(st->gpio_os);
-}
-
-/**
- *  Interrupt handler
- */
-static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
-{
-	struct iio_dev *indio_dev = dev_id;
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	if (iio_buffer_enabled(indio_dev)) {
-		schedule_work(&st->poll_work);
-	} else {
-		st->done = true;
-		wake_up_interruptible(&st->wq_data_avail);
-	}
-
-	return IRQ_HANDLED;
-};
-
-static const struct iio_info ad7606_info_no_os_or_range = {
-	.read_raw = &ad7606_read_raw,
-};
-
-static const struct iio_info ad7606_info_os_and_range = {
-	.read_raw = &ad7606_read_raw,
-	.write_raw = &ad7606_write_raw,
-	.attrs = &ad7606_attribute_group_os_and_range,
-};
-
-static const struct iio_info ad7606_info_os = {
-	.read_raw = &ad7606_read_raw,
-	.write_raw = &ad7606_write_raw,
-	.attrs = &ad7606_attribute_group_os,
-};
-
-static const struct iio_info ad7606_info_range = {
-	.read_raw = &ad7606_read_raw,
-	.write_raw = &ad7606_write_raw,
-	.attrs = &ad7606_attribute_group_range,
-};
-
-int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-		 const char *name, unsigned int id,
-		 const struct ad7606_bus_ops *bops)
-{
-	struct ad7606_state *st;
-	int ret;
-	struct iio_dev *indio_dev;
-
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	st = iio_priv(indio_dev);
-
-	st->dev = dev;
-	mutex_init(&st->lock);
-	st->bops = bops;
-	st->base_address = base_address;
-	/* tied to logic low, analog input range is +/- 5V */
-	st->range = 0;
-	st->oversampling = 1;
-	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
-
-	st->reg = devm_regulator_get(dev, "avcc");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(dev, "Failed to enable specified AVcc supply\n");
-		return ret;
-	}
-
-	st->chip_info = &ad7606_chip_info_tbl[id];
-
-	ret = ad7606_request_gpios(st);
-	if (ret)
-		goto error_disable_reg;
-
-	indio_dev->dev.parent = dev;
-	if (st->gpio_os) {
-		if (st->gpio_range)
-			indio_dev->info = &ad7606_info_os_and_range;
-		else
-			indio_dev->info = &ad7606_info_os;
-	} else {
-		if (st->gpio_range)
-			indio_dev->info = &ad7606_info_range;
-		else
-			indio_dev->info = &ad7606_info_no_os_or_range;
-	}
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = name;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = st->chip_info->num_channels;
-
-	init_waitqueue_head(&st->wq_data_avail);
-
-	ret = ad7606_reset(st);
-	if (ret)
-		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
-
-	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
-			  indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	ret = iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
-					 NULL, NULL);
-	if (ret)
-		goto error_free_irq;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unregister_ring;
-
-	dev_set_drvdata(dev, indio_dev);
-
-	return 0;
-error_unregister_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-error_free_irq:
-	free_irq(irq, indio_dev);
-
-error_disable_reg:
-	regulator_disable(st->reg);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ad7606_probe);
-
-int ad7606_remove(struct device *dev, int irq)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	free_irq(irq, indio_dev);
-	regulator_disable(st->reg);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ad7606_remove);
-
-#ifdef CONFIG_PM_SLEEP
-
-static int ad7606_suspend(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, 1);
-		gpiod_set_value(st->gpio_standby, 0);
-	}
-
-	return 0;
-}
-
-static int ad7606_resume(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, st->range);
-		gpiod_set_value(st->gpio_standby, 1);
-		ad7606_reset(st);
-	}
-
-	return 0;
-}
-
-SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
-EXPORT_SYMBOL_GPL(ad7606_pm_ops);
-
-#endif
-
-MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
deleted file mode 100644
index 8618805..0000000
--- a/drivers/staging/iio/adc/ad7606.h
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- * AD7606 ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#ifndef IIO_ADC_AD7606_H_
-#define IIO_ADC_AD7606_H_
-
-/**
- * struct ad7606_chip_info - chip specific information
- * @channels:		channel specification
- * @num_channels:	number of channels
- * @has_oversampling:   whether the device has oversampling support
- */
-
-struct ad7606_chip_info {
-	const struct iio_chan_spec	*channels;
-	unsigned int			num_channels;
-	bool				has_oversampling;
-};
-
-/**
- * struct ad7606_state - driver instance specific data
- * @dev		pointer to kernel device
- * @chip_info		entry in the table of chips that describes this device
- * @reg		regulator info for the the power supply of the device
- * @poll_work		work struct for continuously reading data from the device
- *			into an IIO triggered buffer
- * @wq_data_avail	wait queue struct for buffer mode
- * @bops		bus operations (SPI or parallel)
- * @range		voltage range selection, selects which scale to apply
- * @oversampling	oversampling selection
- * @done		marks whether reading data is done
- * @base_address	address from where to read data in parallel operation
- * @lock		protect sensor state from concurrent accesses to GPIOs
- * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
- * @gpio_reset		GPIO descriptor for device hard-reset
- * @gpio_range		GPIO descriptor for range selection
- * @gpio_standby	GPIO descriptor for stand-by signal (STBY),
- *			controls power-down mode of device
- * @gpio_frstdata	GPIO descriptor for reading from device when data
- *			is being read on the first channel
- * @gpio_os		GPIO descriptors to control oversampling on the device
- * @data		buffer for reading data from the device
- */
-
-struct ad7606_state {
-	struct device			*dev;
-	const struct ad7606_chip_info	*chip_info;
-	struct regulator		*reg;
-	struct work_struct		poll_work;
-	wait_queue_head_t		wq_data_avail;
-	const struct ad7606_bus_ops	*bops;
-	unsigned int			range;
-	unsigned int			oversampling;
-	bool				done;
-	void __iomem			*base_address;
-
-	struct mutex			lock; /* protect sensor state */
-	struct gpio_desc		*gpio_convst;
-	struct gpio_desc		*gpio_reset;
-	struct gpio_desc		*gpio_range;
-	struct gpio_desc		*gpio_standby;
-	struct gpio_desc		*gpio_frstdata;
-	struct gpio_descs		*gpio_os;
-
-	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
-	 * 8 * 16-bit samples + 64-bit timestamp
-	 */
-	unsigned short			data[12] ____cacheline_aligned;
-};
-
-/**
- * struct ad7606_bus_ops - driver bus operations
- * @read_block		function pointer for reading blocks of data
- */
-struct ad7606_bus_ops {
-	/* more methods added in future? */
-	int (*read_block)(struct device *dev, int num, void *data);
-};
-
-int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-		 const char *name, unsigned int id,
-		 const struct ad7606_bus_ops *bops);
-int ad7606_remove(struct device *dev, int irq);
-
-enum ad7606_supported_device_ids {
-	ID_AD7605_4,
-	ID_AD7606_8,
-	ID_AD7606_6,
-	ID_AD7606_4
-};
-
-#ifdef CONFIG_PM_SLEEP
-extern const struct dev_pm_ops ad7606_pm_ops;
-#define AD7606_PM_OPS (&ad7606_pm_ops)
-#else
-#define AD7606_PM_OPS NULL
-#endif
-
-#endif /* IIO_ADC_AD7606_H_ */
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
deleted file mode 100644
index 8bd86e7..0000000
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * AD7606 Parallel Interface ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/types.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include <linux/iio/iio.h>
-#include "ad7606.h"
-
-static int ad7606_par16_read_block(struct device *dev,
-				   int count, void *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	insw((unsigned long)st->base_address, buf, count);
-
-	return 0;
-}
-
-static const struct ad7606_bus_ops ad7606_par16_bops = {
-	.read_block	= ad7606_par16_read_block,
-};
-
-static int ad7606_par8_read_block(struct device *dev,
-				  int count, void *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	insb((unsigned long)st->base_address, buf, count * 2);
-
-	return 0;
-}
-
-static const struct ad7606_bus_ops ad7606_par8_bops = {
-	.read_block	= ad7606_par8_read_block,
-};
-
-static int ad7606_par_probe(struct platform_device *pdev)
-{
-	const struct platform_device_id *id = platform_get_device_id(pdev);
-	struct resource *res;
-	void __iomem *addr;
-	resource_size_t remap_size;
-	int irq;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq: %d\n", irq);
-		return irq;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	addr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(addr))
-		return PTR_ERR(addr);
-
-	remap_size = resource_size(res);
-
-	return ad7606_probe(&pdev->dev, irq, addr,
-			    id->name, id->driver_data,
-			    remap_size > 1 ? &ad7606_par16_bops :
-			    &ad7606_par8_bops);
-}
-
-static int ad7606_par_remove(struct platform_device *pdev)
-{
-	return ad7606_remove(&pdev->dev, platform_get_irq(pdev, 0));
-}
-
-static const struct platform_device_id ad7606_driver_ids[] = {
-	{
-		.name		= "ad7605-4",
-		.driver_data	= ID_AD7605_4,
-	}, {
-		.name		= "ad7606-8",
-		.driver_data	= ID_AD7606_8,
-	}, {
-		.name		= "ad7606-6",
-		.driver_data	= ID_AD7606_6,
-	}, {
-		.name		= "ad7606-4",
-		.driver_data	= ID_AD7606_4,
-	},
-	{ }
-};
-
-MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
-
-static struct platform_driver ad7606_driver = {
-	.probe = ad7606_par_probe,
-	.remove	= ad7606_par_remove,
-	.id_table = ad7606_driver_ids,
-	.driver = {
-		.name	 = "ad7606",
-		.pm	 = AD7606_PM_OPS,
-	},
-};
-
-module_platform_driver(ad7606_driver);
-
-MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
deleted file mode 100644
index b76ca5a..0000000
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * AD7606 SPI ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/module.h>
-#include <linux/spi/spi.h>
-#include <linux/types.h>
-#include <linux/err.h>
-
-#include <linux/iio/iio.h>
-#include "ad7606.h"
-
-#define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
-
-static int ad7606_spi_read_block(struct device *dev,
-				 int count, void *buf)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	int i, ret;
-	unsigned short *data = buf;
-	__be16 *bdata = buf;
-
-	ret = spi_read(spi, buf, count * 2);
-	if (ret < 0) {
-		dev_err(&spi->dev, "SPI read error\n");
-		return ret;
-	}
-
-	for (i = 0; i < count; i++)
-		data[i] = be16_to_cpu(bdata[i]);
-
-	return 0;
-}
-
-static const struct ad7606_bus_ops ad7606_spi_bops = {
-	.read_block	= ad7606_spi_read_block,
-};
-
-static int ad7606_spi_probe(struct spi_device *spi)
-{
-	const struct spi_device_id *id = spi_get_device_id(spi);
-
-	return ad7606_probe(&spi->dev, spi->irq, NULL,
-			    id->name, id->driver_data,
-			    &ad7606_spi_bops);
-}
-
-static int ad7606_spi_remove(struct spi_device *spi)
-{
-	return ad7606_remove(&spi->dev, spi->irq);
-}
-
-static const struct spi_device_id ad7606_id[] = {
-	{"ad7605-4", ID_AD7605_4},
-	{"ad7606-8", ID_AD7606_8},
-	{"ad7606-6", ID_AD7606_6},
-	{"ad7606-4", ID_AD7606_4},
-	{}
-};
-MODULE_DEVICE_TABLE(spi, ad7606_id);
-
-static struct spi_driver ad7606_driver = {
-	.driver = {
-		.name = "ad7606",
-		.pm = AD7606_PM_OPS,
-	},
-	.probe = ad7606_spi_probe,
-	.remove = ad7606_spi_remove,
-	.id_table = ad7606_id,
-};
-module_spi_driver(ad7606_driver);
-
-MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4


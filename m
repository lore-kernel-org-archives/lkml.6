Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B6EC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EB421502
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="YHVl4sQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EB421502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389816AbeHGRJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:09:31 -0400
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:21856
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388593AbeHGRJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUhSTTFWjq9QtTKogSkoK6OCRvNrcnQJQ5bYOOrEfBA=;
 b=YHVl4sQ0ooxKXWrNa7ajwVlREb96NOP8uyfTIqcZJZFqdUiabU+6qQXYtGjIgj6xNwuCTD1ia8EUIDxdQxIjCDQh678q/VFEdOFV4YOjCpxHaeauqqWO5YXR40aPsWNwVF2H3wIbUKtbls6wPn0iM/dSf+o3g3fXixAhLVHN41c=
Received: from CY4PR03CA0013.namprd03.prod.outlook.com (2603:10b6:903:33::23)
 by BY2PR03MB554.namprd03.prod.outlook.com (2a01:111:e400:2c38::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Tue, 7 Aug
 2018 14:53:04 +0000
Received: from BN1BFFO11FD007.protection.gbl (2a01:111:f400:7c10::1:106) by
 CY4PR03CA0013.outlook.office365.com (2603:10b6:903:33::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Tue, 7 Aug 2018 14:53:03 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD007.mail.protection.outlook.com (10.58.144.70) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Tue, 7 Aug 2018 14:53:02 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w77Er2F4017329
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Tue, 7 Aug 2018 07:53:02 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 7 Aug 2018
 10:52:59 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/6] iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
Date:   Tue, 7 Aug 2018 17:52:15 +0300
Message-ID: <1533653540-24796-2-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
References: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(438002)(199004)(189003)(486006)(126002)(356003)(11346002)(476003)(44832011)(966005)(478600001)(7636002)(50226002)(7696005)(26005)(77096007)(51416003)(106002)(72206003)(76176011)(316002)(110136005)(48376002)(54906003)(575784001)(426003)(14444005)(16586007)(8936002)(446003)(186003)(50466002)(2906002)(305945005)(2616005)(336012)(8676002)(6666003)(47776003)(6306002)(4326008)(5660300001)(7416002)(36756003)(53416004)(246002)(106466001)(1720100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB554;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD007;1:vu38rBrG0At+iuxc7nK9Nv92vT/799nVjDrOe0h6SQ+c0i04eMZbRhDg++kHya9jyrYjbtBWk05L/Ub/neHU+9ZhFT1P4cZah1EAd81Vulyr67LL399eRxwz96fRZY5Q
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bf2099a-186f-4791-57dd-08d5fc7579e5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR03MB554;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB554;3:GzrhAwFkJkyph460Men2SnPMN/xkuew6KZ6XrPZDQWSoNrrDANXiPpzrmI8j/Uc69NdUZyOG2E1CnDUlXOgh31cDdFLyeHl0GZ2DmjV8XlHSTJ330BpYAt4AhbTG00lVhw9VZeDm9q1eBOaXhEduNjchtMhlP7IpHalIyN3QK45yD48l6SINdvXA/oSr8sUU0RzgBoFT6Ca3sLiPmI5jeLRfDeVYpO1ovj5m4rHTehuCA3QWbanRa45Z+3VLyNesyyesqTVaNMGx5/SDrWscQcS8gFozvQqgd3z+D8rJGcvpG5DXf1kkDxcBtJ1vm0L1TrqTWlCBsKRJUaJG1dT6JwekRpl2YXsYdt8X/3f3CF0=;25:cSy2/eRe3er9capBuu3ojQjHDpbCHc9NCDczTPRQ3MPdjAQmOpR4OPYoOiBh08t6knmdVsv0zwnP3x8+P6hAJ/KweXRJ0RZH6b1DspWjHOXHVhc0OfQ23OIXp3y/NtwwHZPcZdmfxkc8yDJQfh10iesuob4ELzP8WPCxwyPxQ7D5L9MThNrd5MHvDTL/bXXqsblDbdKJNQAgvIZm1Isk+QDhU8EbvOg5LDNhb7dBjVDA2KfVyrWHq0OfUJ6TmwfLOngN1dL6OuCE719qpTVA/O3si7vB2xsBPwP+tJoB8+JMoGgsAFJSceoRdZmT7D12m95Mh2HPNqeXdb0T9AsI7w==
X-MS-TrafficTypeDiagnostic: BY2PR03MB554:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB554;31:OMe69eygMRW1LP2ksfrcRymZIrwYFhkImv1vcEjgbi8qI1z4YYWXC3alNAw8HNPQuSKP7/p8hfoF1gOwoGJj4DHR+6hjOVQSL0XASIDJi457xMBnDQGtRtM0hAaq4KSvA2Cu+VyVby6zTNL0InsQoqyH/grCVFB3tWT6CCqucOuUf5C7BVKzWPT9CtACEP9mS8BcxCiCN+S4F0+Y6umKsFUQDbtOgBFBy/w+b8CZcxA=;20:wKLT/LZjzQiqvInBF6LNQoGJ0a8txhXy69VsMadnaDTEON85occxBYiC+T9P6mplDfSbmqibr1DFNOGxd1IMjf3rsjJ8QT5meGi+rl/PfrUibNiCSmbaA+wEQCb1/gqjnWoQmAx2RGL3i9++m/roGaIP57H7tXcKolEK/JFmQSWEsZu4zUJUrWWRysgrK13eBOT6mYVK5aCKcYrpmTpOg3NQZOgDUoqRqffPTHwBUrWdMJ+fojoOjyouZAZeqEwiZMy9vR7PfTUi2VJpL1U1pE1f9yVOJtTeFIVyxdbLo9fi8BKATNpVb9Rph34j8pVL8oIJ0YeC2Pr3C7aVpFqr8dRqdF7vPCt7QIVS7KviDngjYDyzydMk83ypHFbwIuz/hmHAnmmvQlX7qnc9b3Riz16x+6SZk+DXLG5JsPoOt6xxa3yyVuFQ5AKW2Mt97hAk8iIxi6LIwZXPtySt6Agjt0DVpuDQtsifhANg7iyiz0di6FmDmFzwH0+n83QluLwK
X-Microsoft-Antispam-PRVS: <BY2PR03MB554781698A04E13EFF8C3E69D270@BY2PR03MB554.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB554;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB554;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB554;4:TVjJTTbXEea6KTtsc2u6jJaLCnI+IzeDEGuyLC+srAdl4a1yERZFCJKOGr+lU3eKyEnQMtynNO1ZkdJoiDq67HYaD+43J8ZtMh56gFt3BwtI3xT9i1/ptzS0WXaz4mSSV5YUsSm3gFncuZq9Jyw55ok3vzN/kqfIwB8TRTnfq1MdWjgIyC6Qb0UKKNvhNMW1lsL1P+Qx67UhsmNB0G2W0ngARjT6wBbRpbtyJbpGh+ewEvvsk7D4tbX/XQRb4iHBFHur8GVArhVw89RLbhVARXaEDYP/Qtrk4XjE7foC2Rf8wXgKR/Mmm2fSPaUk7a3aLU6+5AQndCoxOsI6/QlNIMjsxFziozs99MeW11Ch06EpmUZyC23O0UKSKUcqdPUUMSPxB2wOwKAP+uLNUI6+zoIM78+Rn+DwBD7UjMypWfk=
X-Forefront-PRVS: 0757EEBDCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB554;23:6JSqFKFJI2H0olSxq8c1lPMvUxvt0u3mNR3PNZNoIO?=
 =?us-ascii?Q?hfXxfq5UKtCySjwO8OU+6apO/C6oMrTxepU+szHexVR/cH8Hu0cPjp+Oo1f6?=
 =?us-ascii?Q?4asL7MRcp21kV8qXjtIHzo2LOTEB22FGL1mhRi71glGS6mIkV5p+h2LFNPKl?=
 =?us-ascii?Q?gV9ij1y11WLU0xe0jOMglGoyg+qhuNMOrG959apvJtZiuvyYb2JAZSRS0EfN?=
 =?us-ascii?Q?cszSi2kUBTU+SnMFMyUpjCgLecZYb10d9Rky5zZaP5TcvZfuG5ZzelekLA1Q?=
 =?us-ascii?Q?duKjBnsuKESRJAe4Ox+0m7o4is0OzylQHEVLtHQU8b9FfoYEOMaX3H1/xOj+?=
 =?us-ascii?Q?xwUJt/9w71fppiXVyl/AkemFJZa/tc9+EJ0+pkLSeXhjtqX3drw+wd7SgKHF?=
 =?us-ascii?Q?27OYO5KxeFUCueeP2H6D6/CHvRjZgZYj7Cp11kx9LBtfNovaGH3y464PHmY0?=
 =?us-ascii?Q?/NPCSAiwl8tZ5BOXK2Z4UTtYGxWQrT4/10B0dx86Zc75BjutuqjcHy6nqCNS?=
 =?us-ascii?Q?LTN4vUsxkei7jz886VRvQMUbH0zhxaE0r7CuBHHcU6hptfXr5Wg1tHgR/d/O?=
 =?us-ascii?Q?+3ItbotYKh2ZVApDKwiwGp2lUcMVdFniWtjHi+Y6kqD8/U2evQfi7c6+95yn?=
 =?us-ascii?Q?SvIssS2Wddr8L8+rIXdzo4CgQEGrSg3nW8VMhEz9uNLiUP4kATh2haVr/5yI?=
 =?us-ascii?Q?acwJl35n9ln7VF1mpF/cf2SP/8OurTnS8jPQNTast3chYqz7kg1XYDzK90bM?=
 =?us-ascii?Q?6//GjTjTinNq7zzPONeg7jYKFWifHwt9GbNBou/k4vj4T+dBkN8hG8+l4f/V?=
 =?us-ascii?Q?UAvOZhgzfaUFgKkXS3LXTCoap+Lu443X7hcdAuHFGrwqfzX3Kff5BIhbZUwE?=
 =?us-ascii?Q?73J9P0sTbLhQ6DBf8kK6JGedOImeniC3ZdUbzV857t5Gz4bzGp24URktCqeH?=
 =?us-ascii?Q?PArh1cUrAoyrtPgQfz3Ad3UZvFqdvaxktAgUqZCefBJi1K5oqYKorhxzM6zQ?=
 =?us-ascii?Q?r73E8cxCnsKev5s4Uk7RGmADQCI3SM5mAdLxtKud4ekNSLEHVkac9LA60OAc?=
 =?us-ascii?Q?9P9M8MS9XwgV2C4i1Jq6CK7tICedOQLYYfBJZ3lUBm4z2zGTt4k3DXHfzfVW?=
 =?us-ascii?Q?4vr3Vcxx7Qz3vDNn0jGJwim/AVIrtVzAHxzkR/jtBSa/yGbJwNGqXdZnQ3V2?=
 =?us-ascii?Q?7zWZHsov09wxQ=3D?=
X-Microsoft-Antispam-Message-Info: J01j9Q2E4nxpGCd+MDYB2T/MmG8lh+Xr6B5fptVz2lkMKqebHqsDh2tv5ngFaVPSi8391zbdexlURqzuSQJazF2spnEkfs1uGSbLu2iAnIbWte0lwgGyt3sQK2YcIb/w4eyf1anSQtG0gP36OrHI8pMvrQxg3Nl7zld3zc2nwm2WczhJjEEFVvRk13619ualBQL048+XQOdVf4kTgNywMzb7FHWyx268TkVYySZ0f8QgRjTmFeOCdVRX3vxI86z2QaPfKNvYD0AHQBvqq7peVi5pRJ6f9PC1kDUNO6BfwZdKI6ohMAnfbU/Jp84nQ9BP+E7D7qRg76CHlavH5zzRx5SwSdQHx+3TjAg/K0JGAcc=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB554;6:52cVBV5vN8kNXAsatRoiHxIMGwy2zy/3VF/1sbx/H/RIUfrd/oE25xDNXKd7Z34wKlD20qomplpd8/Y8I7nyMAIpBZQ2oGB6/2ifQ8XFCi1EV9icBSwp6na5dzoHUfFT7QWQOO6oLiVit4rieVFQbfD6goxonVnxWqrJ0pdxG/le9bj3K+VJm04TY8AsmJHZQwOBxI43zRlE3gJyUA2z8nsbFR3b4yDDadHYxCuo/NPBXhb1fhepAU/9apPcoVuB+DWNF40F884uO0WXaqnO+nQSfTK9Lbzbh+s/d2LaPoC1VFKYbJpUvhGnZnbtTSDWo3CulmvvJMqLvualhzdvyoj83B7hGWUotpw0D4F0C/pdqYYFRznfdO64cQNyXhyffrefWCk6XMV7R5ROhVPRW0oASWzUcYLYAFAdOtQMRR3rtu8cq1mGeR55jXXE4InUDFWX2/s/Jzm5lLGWE9bqhw==;5:srUJiLzWQm9KxO8XM6PWj2IcAVgjxddnJqN2JImRNsgTQNeCSvwYnv0o8pB1Lo7E8rnsLQiuyyMpa1BXqaNE3ebSx+XO5BtTZHRn2C/Zy1HUGWQBoXxvnmz9H8otBB9HN79pSmcpMLMC8h8U5KK+R1sL2ABB2YCQuTh/xV1fq/E=;7:vVzc1eUyCPXdznwTpQFVJjh5ucc29usUEwzQMHbq/3lEEnPFZezdwouyaT2pAAglRFbZYo61MEBProt0AyPsB6qlPjXXRuGVuSdipFYoxvRHgRoaIgFz9aYQbezdL2YC8C8YSZiQ+EO4hHblccgFtQCojl4wYf008TOsi6UtAELNRmHdRLRbFQjFtFkcd/AXXB0kwOIZZD3+zd60fI3MsAFgF2dvhQf9P67ADIrLwKcwiW8ERiFF7uQuAuPcSH4k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 14:53:02.7207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf2099a-186f-4791-57dd-08d5fc7579e5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB554
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for Analog Devices ADXL372 SPI-Bus
Three-Axis Digital Accelerometer.

The device is probed and configured the with some initial default
values. With this basic driver, it is possible to read raw acceleration
data.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL372.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS                 |   6 +
 drivers/iio/accel/Kconfig   |  11 +
 drivers/iio/accel/Makefile  |   1 +
 drivers/iio/accel/adxl372.c | 525 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 543 insertions(+)
 create mode 100644 drivers/iio/accel/adxl372.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 60b1028..2ba47bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -543,6 +543,12 @@ W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/input/misc/adxl34x.c
 
+ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/accel/adxl372.c
+
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 62ae7e5..1b496ef 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -60,6 +60,17 @@ config ADXL345_SPI
 	  will be called adxl345_spi and you will also get adxl345_core
 	  for the core module.
 
+config ADXL372
+	tristate "Analog Devices ADXL372 3-Axis Accelerometer Driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to add support for the Analog Devices ADXL372 triaxial
+	  acceleration sensor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl372.
+
 config BMA180
 	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 636d4d1..5758ffc 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
+obj-$(CONFIG_ADXL372) += adxl372.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
new file mode 100644
index 0000000..db9ecd2
--- /dev/null
+++ b/drivers/iio/accel/adxl372.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADXL372 3-Axis Digital Accelerometer SPI driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* ADXL372 registers definition */
+#define ADXL372_DEVID			0x00
+#define ADXL372_DEVID_MST		0x01
+#define ADXL372_PARTID			0x02
+#define ADXL372_REVID			0x03
+#define ADXL372_STATUS_1		0x04
+#define ADXL372_STATUS_2		0x05
+#define ADXL372_FIFO_ENTRIES_2		0x06
+#define ADXL372_FIFO_ENTRIES_1		0x07
+#define ADXL372_X_DATA_H		0x08
+#define ADXL372_X_DATA_L		0x09
+#define ADXL372_Y_DATA_H		0x0A
+#define ADXL372_Y_DATA_L		0x0B
+#define ADXL372_Z_DATA_H		0x0C
+#define ADXL372_Z_DATA_L		0x0D
+#define ADXL372_X_MAXPEAK_H		0x15
+#define ADXL372_X_MAXPEAK_L		0x16
+#define ADXL372_Y_MAXPEAK_H		0x17
+#define ADXL372_Y_MAXPEAK_L		0x18
+#define ADXL372_Z_MAXPEAK_H		0x19
+#define ADXL372_Z_MAXPEAK_L		0x1A
+#define ADXL372_OFFSET_X		0x20
+#define ADXL372_OFFSET_Y		0x21
+#define ADXL372_OFFSET_Z		0x22
+#define ADXL372_X_THRESH_ACT_H		0x23
+#define ADXL372_X_THRESH_ACT_L		0x24
+#define ADXL372_Y_THRESH_ACT_H		0x25
+#define ADXL372_Y_THRESH_ACT_L		0x26
+#define ADXL372_Z_THRESH_ACT_H		0x27
+#define ADXL372_Z_THRESH_ACT_L		0x28
+#define ADXL372_TIME_ACT		0x29
+#define ADXL372_X_THRESH_INACT_H	0x2A
+#define ADXL372_X_THRESH_INACT_L	0x2B
+#define ADXL372_Y_THRESH_INACT_H	0x2C
+#define ADXL372_Y_THRESH_INACT_L	0x2D
+#define ADXL372_Z_THRESH_INACT_H	0x2E
+#define ADXL372_Z_THRESH_INACT_L	0x2F
+#define ADXL372_TIME_INACT_H		0x30
+#define ADXL372_TIME_INACT_L		0x31
+#define ADXL372_X_THRESH_ACT2_H		0x32
+#define ADXL372_X_THRESH_ACT2_L		0x33
+#define ADXL372_Y_THRESH_ACT2_H		0x34
+#define ADXL372_Y_THRESH_ACT2_L		0x35
+#define ADXL372_Z_THRESH_ACT2_H		0x36
+#define ADXL372_Z_THRESH_ACT2_L		0x37
+#define ADXL372_HPF			0x38
+#define ADXL372_FIFO_SAMPLES		0x39
+#define ADXL372_FIFO_CTL		0x3A
+#define ADXL372_INT1_MAP		0x3B
+#define ADXL372_INT2_MAP		0x3C
+#define ADXL372_TIMING			0x3D
+#define ADXL372_MEASURE			0x3E
+#define ADXL372_POWER_CTL		0x3F
+#define ADXL372_SELF_TEST		0x40
+#define ADXL372_RESET			0x41
+#define ADXL372_FIFO_DATA		0x42
+
+#define ADXL372_DEVID_VAL		0xAD
+#define ADXL372_PARTID_VAL		0xFA
+#define ADXL372_RESET_CODE		0x52
+
+/* ADXL372_POWER_CTL */
+#define ADXL372_POWER_CTL_MODE_MSK		GENMASK_ULL(1, 0)
+#define ADXL372_POWER_CTL_MODE(x)		(((x) & 0x3) << 0)
+
+/* ADXL372_MEASURE */
+#define ADXL372_MEASURE_LINKLOOP_MSK		GENMASK_ULL(5, 4)
+#define ADXL372_MEASURE_LINKLOOP_MODE(x)	(((x) & 0x3) << 4)
+#define ADXL372_MEASURE_BANDWIDTH_MSK		GENMASK_ULL(2, 0)
+#define ADXL372_MEASURE_BANDWIDTH_MODE(x)	(((x) & 0x7) << 0)
+
+/* ADXL372_TIMING */
+#define ADXL372_TIMING_ODR_MSK			GENMASK_ULL(7, 5)
+#define ADXL372_TIMING_ODR_MODE(x)		(((x) & 0x7) << 5)
+
+/* ADXL372_FIFO_CTL */
+#define ADXL372_FIFO_CTL_FORMAT_MSK		GENMASK(5, 3)
+#define ADXL372_FIFO_CTL_FORMAT_MODE(x)		(((x) & 0x7) << 3)
+#define ADXL372_FIFO_CTL_MODE_MSK		GENMASK(2, 1)
+#define ADXL372_FIFO_CTL_MODE_MODE(x)		(((x) & 0x3) << 1)
+#define ADXL372_FIFO_CTL_SAMPLES_MSK		BIT(1)
+#define ADXL372_FIFO_CTL_SAMPLES_MODE(x)	(((x) > 0xFF) ? 1 : 0)
+
+/* ADXL372_STATUS_1 */
+#define ADXL372_STATUS_1_DATA_RDY(x)		(((x) >> 0) & 0x1)
+#define ADXL372_STATUS_1_FIFO_RDY(x)		(((x) >> 1) & 0x1)
+#define ADXL372_STATUS_1_FIFO_FULL(x)		(((x) >> 2) & 0x1)
+#define ADXL372_STATUS_1_FIFO_OVR(x)		(((x) >> 3) & 0x1)
+#define ADXL372_STATUS_1_USR_NVM_BUSY(x)	(((x) >> 5) & 0x1)
+#define ADXL372_STATUS_1_AWAKE(x)		(((x) >> 6) & 0x1)
+#define ADXL372_STATUS_1_ERR_USR_REGS(x)	(((x) >> 7) & 0x1)
+
+/* ADXL372_INT1_MAP */
+#define ADXL372_INT1_MAP_DATA_RDY_MSK		BIT(0)
+#define ADXL372_INT1_MAP_DATA_RDY_MODE(x)	(((x) & 0x1) << 0)
+#define ADXL372_INT1_MAP_FIFO_RDY_MSK		BIT(1)
+#define ADXL372_INT1_MAP_FIFO_RDY_MODE(x)	(((x) & 0x1) << 1)
+#define ADXL372_INT1_MAP_FIFO_FULL_MSK		BIT(2)
+#define ADXL372_INT1_MAP_FIFO_FULL_MODE(x)	(((x) & 0x1) << 2)
+#define ADXL372_INT1_MAP_FIFO_OVR_MSK		BIT(3)
+#define ADXL372_INT1_MAP_FIFO_OVR_MODE(x)	(((x) & 0x1) << 3)
+#define ADXL372_INT1_MAP_INACT_MSK		BIT(4)
+#define ADXL372_INT1_MAP_INACT_MODE(x)		(((x) & 0x1) << 4)
+#define ADXL372_INT1_MAP_ACT_MSK		BIT(5)
+#define ADXL372_INT1_MAP_ACT_MODE(x)		(((x) & 0x1) << 5)
+#define ADXL372_INT1_MAP_AWAKE_MSK		BIT(6)
+#define ADXL372_INT1_MAP_AWAKE_MODE(x)		(((x) & 0x1) << 6)
+#define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
+#define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
+
+/*
+ * At +/- 200g with 12-bit resolution, scale is computed as:
+ * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
+ */
+#define ADXL372_USCALE	958241
+
+enum adxl372_op_mode {
+	ADXL372_STANDBY,
+	ADXL372_WAKE_UP,
+	ADXL372_INSTANT_ON,
+	ADXL372_FULL_BW_MEASUREMENT,
+};
+
+enum adxl372_act_proc_mode {
+	ADXL372_DEFAULT,
+	ADXL372_LINKED,
+	ADXL372_LOOPED,
+};
+
+enum adxl372_th_activity {
+	ADXL372_ACTIVITY,
+	ADXL372_ACTIVITY2,
+	ADXL372_INACTIVITY,
+};
+
+enum adxl372_odr {
+	ADXL372_ODR_400HZ,
+	ADXL372_ODR_800HZ,
+	ADXL372_ODR_1600HZ,
+	ADXL372_ODR_3200HZ,
+	ADXL372_ODR_6400HZ,
+};
+
+enum adxl372_bandwidth {
+	ADXL372_BW_200HZ,
+	ADXL372_BW_400HZ,
+	ADXL372_BW_800HZ,
+	ADXL372_BW_1600HZ,
+	ADXL372_BW_3200HZ,
+};
+
+static const unsigned int adxl372_th_reg_high_addr[3] = {
+	[ADXL372_ACTIVITY] = ADXL372_X_THRESH_ACT_H,
+	[ADXL372_ACTIVITY2] = ADXL372_X_THRESH_ACT2_H,
+	[ADXL372_INACTIVITY] = ADXL372_X_THRESH_INACT_H,
+};
+
+#define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+}
+
+static const struct iio_chan_spec adxl372_channels[] = {
+	ADXL372_ACCEL_CHANNEL(0, ADXL372_X_DATA_H, X),
+	ADXL372_ACCEL_CHANNEL(1, ADXL372_Y_DATA_H, Y),
+	ADXL372_ACCEL_CHANNEL(2, ADXL372_Z_DATA_H, Z),
+};
+
+struct adxl372_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	enum adxl372_op_mode		op_mode;
+	enum adxl372_act_proc_mode	act_proc_mode;
+	enum adxl372_odr		odr;
+	enum adxl372_bandwidth		bw;
+	u32				act_time_ms;
+	u32				inact_time_ms;
+};
+
+static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
+{
+	__be16 regval;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, addr, &regval, sizeof(regval));
+	if (ret < 0)
+		return ret;
+
+	return be16_to_cpu(regval);
+}
+
+static int adxl372_set_op_mode(struct adxl372_state *st,
+			       enum adxl372_op_mode op_mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_POWER_CTL,
+				 ADXL372_POWER_CTL_MODE_MSK,
+				 ADXL372_POWER_CTL_MODE(op_mode));
+	if (ret < 0)
+		return ret;
+
+	st->op_mode = op_mode;
+
+	return ret;
+}
+
+static int adxl372_set_odr(struct adxl372_state *st,
+			   enum adxl372_odr odr)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_TIMING,
+				 ADXL372_TIMING_ODR_MSK,
+				 ADXL372_TIMING_ODR_MODE(odr));
+	if (ret < 0)
+		return ret;
+
+	st->odr = odr;
+
+	return ret;
+}
+
+static int adxl372_set_bandwidth(struct adxl372_state *st,
+				 enum adxl372_bandwidth bw)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_MEASURE,
+				 ADXL372_MEASURE_BANDWIDTH_MSK,
+				 ADXL372_MEASURE_BANDWIDTH_MODE(bw));
+	if (ret < 0)
+		return ret;
+
+	st->bw = bw;
+
+	return ret;
+}
+
+static int adxl372_set_act_proc_mode(struct adxl372_state *st,
+				     enum adxl372_act_proc_mode mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap,
+				 ADXL372_MEASURE,
+				 ADXL372_MEASURE_LINKLOOP_MSK,
+				 ADXL372_MEASURE_LINKLOOP_MODE(mode));
+	if (ret < 0)
+		return ret;
+
+	st->act_proc_mode = mode;
+
+	return ret;
+}
+
+static int adxl372_set_activity_threshold(struct adxl372_state *st,
+					  enum adxl372_th_activity act,
+					  bool ref_en, bool enable,
+					  unsigned int threshold)
+{
+	unsigned char buf[6];
+	unsigned char th_reg_high_val, th_reg_low_val, th_reg_high_addr;
+
+	/* scale factor is 100 mg/code */
+	th_reg_high_val = (threshold / 100) >> 3;
+	th_reg_low_val = ((threshold / 100) << 5) | (ref_en << 1) | enable;
+	th_reg_high_addr = adxl372_th_reg_high_addr[act];
+
+	buf[0] = th_reg_high_val;
+	buf[1] = th_reg_low_val;
+	buf[2] = th_reg_high_val;
+	buf[3] = th_reg_low_val;
+	buf[4] = th_reg_high_val;
+	buf[5] = th_reg_low_val;
+
+	return regmap_bulk_write(st->regmap, th_reg_high_addr,
+				 buf, ARRAY_SIZE(buf));
+}
+
+static int adxl372_set_activity_time_ms(struct adxl372_state *st,
+					unsigned int act_time_ms)
+{
+	unsigned int reg_val, scale_factor;
+	int ret;
+
+	/*
+	 * 3.3 ms per code is the scale factor of the TIME_ACT register for
+	 * ODR = 6400 Hz. It is 6.6 ms per code for ODR = 3200 Hz and below.
+	 */
+	if (st->odr == ADXL372_ODR_6400HZ)
+		scale_factor = 3300;
+	else
+		scale_factor = 6600;
+
+	reg_val = DIV_ROUND_CLOSEST(act_time_ms * 1000, scale_factor);
+
+	/* TIME_ACT register is 8 bits wide */
+	if (reg_val > 0xFF)
+		reg_val = 0xFF;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_ACT, reg_val);
+	if (ret < 0)
+		return ret;
+
+	st->act_time_ms = act_time_ms;
+
+	return ret;
+}
+
+static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
+					  unsigned int inact_time_ms)
+{
+	unsigned int reg_val_h, reg_val_l, res, scale_factor;
+	int ret;
+
+	/*
+	 * 13 ms per code is the scale factor of the TIME_INACT register for
+	 * ODR = 6400 Hz. It is 26 ms per code for ODR = 3200 Hz and below.
+	 */
+	if (st->odr == ADXL372_ODR_6400HZ)
+		scale_factor = 13;
+	else
+		scale_factor = 26;
+
+	res = DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
+	reg_val_h = (res >> 8) & 0xFF;
+	reg_val_l = res & 0xFF;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_H, reg_val_h);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_L, reg_val_l);
+	if (ret < 0)
+		return ret;
+
+	st->inact_time_ms = inact_time_ms;
+
+	return ret;
+}
+
+static int adxl372_setup(struct adxl372_state *st)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL372_DEVID, &regval);
+	if (ret < 0)
+		return ret;
+
+	if (regval != ADXL372_DEVID_VAL) {
+		dev_err(&st->spi->dev, "Invalid chip id %x\n", regval);
+		return -ENODEV;
+	}
+
+	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	/* Set threshold for activity detection to 1g */
+	ret = adxl372_set_activity_threshold(st, ADXL372_ACTIVITY,
+					     true, true, 1000);
+	if (ret < 0)
+		return ret;
+
+	/* Set threshold for inactivity detection to 100mg */
+	ret = adxl372_set_activity_threshold(st, ADXL372_INACTIVITY,
+					     true, true, 100);
+	if (ret < 0)
+		return ret;
+
+	/* Set activity processing in Looped mode */
+	ret = adxl372_set_act_proc_mode(st, ADXL372_LOOPED);
+	if (ret < 0)
+		return ret;
+
+	ret = adxl372_set_odr(st, ADXL372_ODR_6400HZ);
+	if (ret < 0)
+		return ret;
+
+	ret = adxl372_set_bandwidth(st, ADXL372_BW_3200HZ);
+	if (ret < 0)
+		return ret;
+
+	/* Set activity timer to 1ms */
+	ret = adxl372_set_activity_time_ms(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set inactivity timer to 10s */
+	ret = adxl372_set_inactivity_time_ms(st, 10000);
+	if (ret < 0)
+		return ret;
+
+	/* Set the mode of operation to full bandwidth measurement mode */
+	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
+}
+
+static int adxl372_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static int adxl372_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = adxl372_read_axis(st, chan->address);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = ADXL372_USCALE;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info adxl372_info = {
+	.read_raw = adxl372_read_raw,
+	.debugfs_reg_access = &adxl372_reg_access,
+};
+
+static const struct regmap_config adxl372_spi_regmap_config = {
+	.reg_bits = 7,
+	.pad_bits = 1,
+	.val_bits = 8,
+	.read_flag_mask = BIT(0),
+};
+
+static int adxl372_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adxl372_state *st;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	st->regmap = regmap;
+
+	indio_dev->channels = adxl372_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &adxl372_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adxl372_setup(st);
+	if (ret < 0) {
+		dev_err(&st->spi->dev, "ADXL372 setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static const struct spi_device_id adxl372_id[] = {
+	{ "adxl372", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adxl372_id);
+
+static struct spi_driver adxl372_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = adxl372_probe,
+	.id_table = adxl372_id,
+};
+
+module_spi_driver(adxl372_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


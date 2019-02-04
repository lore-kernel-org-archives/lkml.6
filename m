Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD47C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AA02075D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="nusC9GuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfBDKak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:30:40 -0500
Received: from mail-eopbgr800081.outbound.protection.outlook.com ([40.107.80.81]:58176
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727419AbfBDKak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JeUEw6FmfVRjVqUPLSE0I6jzLochFXXfM/qjyKr4sM=;
 b=nusC9GuHe3AGt4kjQU6uoZf5E+cGkYPPDklJTbTFA10wp5xa6pogXZcMN+Q50FyG9XIaqATRuCr84/TzEdQGGkSXqs+XhCfCKNRypkO07AzDJHf7vUysKmPthVJcdOH2KYSR+7vZ2ZHTOPKGB9jlkfyO02KnW5C8OBlASgaccLo=
Received: from MWHPR03CA0055.namprd03.prod.outlook.com (2603:10b6:301:3b::44)
 by MWHPR03MB3069.namprd03.prod.outlook.com (2603:10b6:301:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Mon, 4 Feb
 2019 10:30:32 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR03CA0055.outlook.office365.com
 (2603:10b6:301:3b::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17 via Frontend
 Transport; Mon, 4 Feb 2019 10:30:31 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Mon, 4 Feb 2019 10:30:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x14AUUdW007100
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 4 Feb 2019 02:30:30 -0800
Received: from linux.analog.com (10.50.1.104) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Feb 2019
 05:30:29 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH] iio: adc: ad7768-1: Add support for setting the sampling frequency
Date:   Mon, 4 Feb 2019 12:30:15 +0200
Message-ID: <1549276215-29570-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(3190300001)(189003)(199004)(107886003)(14444005)(44832011)(8676002)(53416004)(106002)(116002)(50466002)(7636002)(126002)(6666004)(476003)(2616005)(6916009)(486006)(50226002)(356004)(48376002)(54906003)(26005)(77096007)(2906002)(7696005)(51416003)(2351001)(336012)(305945005)(246002)(186003)(4326008)(47776003)(316002)(36756003)(106466001)(16586007)(426003)(8936002)(478600001)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3069;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT055;1:VGnqXhH7XRDnFFxMVQiZNVnTpAMp/Y2KxbsPjAvr5bSa4pzquZa9yXN9v+8ajqCoaP5MOBAKZbB1gr7NFKa/gZ6/TE4gsNQqDnZeVKzr7gZzvtJOGwAFRdsi9NIVppZzyoeX9Nx/sywaS8aZDUUuHdM1jstkkGVUKDTbMSVcsKM=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 249da6fd-f30b-43e3-2fd4-08d68a8bca24
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:MWHPR03MB3069;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3069;3:uc8tFxyH0C+CGzW3p6EM+9f708F+FIlNqv0guQ5KGY3FKCe92UzzhoojQSMUCC25+4rVDVmOHVJGojmH7v+37/D4NE7CqYsn22tSsoaRh6EJPr6oLdaSZvRbd8KTwwA4s1JVOfpS5qqH4qhBRd3b8NWOyCucsdpoUy9PIcoogLAt99WYmwWKqULF40qqSwGQBiNJgWPqJMLhaII10O17ns0RB2B2tO8y7BjA1jwzB2R3kMKFA4lUlQYiXdkB6o/XNF1LlPpD2c/yt6Z62HINzqUDGqDezhvwlMJdN6VdmbyO00Y6BwS+TOF0YPmCK2I9xmsZXL1ZRBeG4TvVFM4PzuRl6GOeu2ZBN9u7VxtDQzDFEcgzsPWrOkYUxQPfIddY;25:yO7sH7Ws86krlsmAK5zze3c4taeAgP3ar0hAZ06vG23CLBf3QRB0qJ+tkZ/hsKNkuZ66a6in7f2fm6SjJeqVS8C50cn4aqBCqHarOZFSuZ1ovVLs+/qFcWtbqZBeDGA7Yt1nzGzPeOCInqsWK0gOpQGNRbFMcutWDdPQjEamtUli31kEIzduhGl++C+cSGtrmyCEiZnApPNbI0OMU7y97i6vCozexV2MfO7KPT+QMcJ7JPvpelAOoKs/3j0+qCOd303g+LrJ2VJW5JLXPnN3NwOF3FJxWSDKMjbKZZGIfXq3ynkzkrDRe00Mecog9mmR7kJeBm0UI/u3OQocy2pR4A==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3069:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3069;31:v71x7XYwRO90HGniC3C/F9m1UICvxxu5ozauT+eYj2qnA0EYnxD9fqPInnEiFSr5BLlIbNcxH6SiWvtcSC6le2LvN4Rmaw0O0cZIPjH+HlJx+98N9IG8pRtT1BULOZjiV/EsmG8ZQIL96IDY2wnz9RQUCNK4zBFzJoR4Ga/7Y6AG1apFPVOC3gJ2uQ5+NaY1orePGFfmg3RJZW1QwUjO38qZy7eHJnbFUT4U9rMKI/A=;20:eWrS0gXGU8TXGQonJ4cL1AR1xndvWkbBWheGpuJTJXYUveEjM8r/x3ap1QGezNxsPCvkNGNt96ZYYoviwtOT3P/OsTHAihuuqtQ3fIDfUOv0zoSTkIrqrINxQjYf32eTJZ630hl6pV9tUVhGOZdS/tlbnZWRtXtyUbfwWmRGEiRwL/1P1IhmSmbqo50wx2K1QIwy2rYkze1cqcc1EgZcDWMVtEvUxMM+UsBb96Mk5W61SNLqA7PJ4w1yLPCprKHAU3GaCZFPHWEqRAmVW2dn5MVBt0mwOS8baiQcDeZcuo5f1NJZUsNR1UdSQ44/lL3vyNhAhRWi0GUK6XlOWJNbYtdBHwGA9sT1ogaUK1E98lfnyPSWRPlHw/LhrhWW8v43N3M2pp/xk5d887PGMkirbgYfp63f5aeEzyU0CFwgxod3CDYMbJGIWkWruHVi4cYwzsbaLtKYoz3Gop50eNmZtNPW1UeVPC1Sn429Y7pv9K/486LS2P/cx5q5n8FQZfQS
X-Microsoft-Antispam-PRVS: <MWHPR03MB306951A81C1742DA531E96BC9D6D0@MWHPR03MB3069.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3069;4:LUcbC5z4661GFM43QM90zM10H2qkq52vbTFaHvozgOOdx/L84+azhzJkHjYlIvm/2z0PqEc6gxyxpLPXvN6mbB2W3tfmiZZWKZ829kbbgRmhcV4cusdYNJ1iPNUo017o28PpPVwTELBsVJozk033ZoFpAPRuNXtcb4lGbJThVE5kRXn0AGFrAf8fzf/8o7N2OVy9pmUwISW0bgr/NFitF39HczGwfNQ+r/Rz/HYiEAfl9Mo6LlkR3j8P9JA2Q1v8y1Mm8rMoFLr6M3qwJBHXs2kRNYkC6exmUhGtK5wqW66mkpx5+KUv3feP9/Mr15BB
X-Forefront-PRVS: 0938781D02
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3069;23:nQPnDuq3oJrQA9K6TiZmFCH7ofr+XhzUeqDs5q08K?=
 =?us-ascii?Q?ibUUoukGGpHbs1tU02LzzpLcBYNCMq73PDMZEBHKB0cttBnmUIXgXB3IpMea?=
 =?us-ascii?Q?GDMCDZinR5yA9WXMg7wbUhPBdQj2oJhas4nNnzTAIKGYOot6CZ9v+Cg6rCvM?=
 =?us-ascii?Q?CoDst5sxdWF5EGiM8x+omwRoHHnEiUzI4vBevCSjcCfHaLWBah84XugF7AHD?=
 =?us-ascii?Q?abYg/J7PbbzPHBiBQA1JafXuMYeoULwwGHk29R5nj4IUaEKbwtb/kzXUqjph?=
 =?us-ascii?Q?RYoBODdCdjN9cW5pZdl9UUTiSIUpbX/QQtWMbFpob+E/wdWDyCnMEOKTL+yz?=
 =?us-ascii?Q?ONigZZzps4QWGK/GVkDb1yHa6swkAIhfaxwBfmt/02fOTxneKoTctJeyn3F/?=
 =?us-ascii?Q?WwgBMjSC5H3ij/0HU6KIArp98R98M5kKhlHFQKVjTndKxAOpqZL63+yAnh1/?=
 =?us-ascii?Q?To4wo02XjF8d83rez2snr399VU6gT7iR58VeuWWY63a6C9OpFah+qJtsSyHy?=
 =?us-ascii?Q?A/mQCquJrpUOLqkfcOVf1a3rZefhYfAVz9/S+RalV7Be1oETyKnjraUO28KC?=
 =?us-ascii?Q?xG3vbBohR7Nz9eO3CxVquoh+SddeVZs6c2HSzeDum3t143JJOavvbyl2i8GQ?=
 =?us-ascii?Q?WEGCS8mc0WPOI6szBS9m2uJhsStTKIz/nmFQ/eS85ZIPSduU2QBQ0YGp7Hx/?=
 =?us-ascii?Q?6sil9a/oyfzkCLFxSajbrDviZpNcE3b8Ory2RDYiIV9iQXG6AaV3RyUiP6kt?=
 =?us-ascii?Q?E4ZOOPDnFkWIVCQxfKcTwGb3SPpeSgH6/sXX+grTNQ+JAYPOARCeK+6ei/he?=
 =?us-ascii?Q?4CC1+huGHdmsZxP54oKTGgk5OjvpBe0WkJurS0O8V/h/lCHHIOpTVDR52wwI?=
 =?us-ascii?Q?SJtj2+E/eCCuJDUJIVntz707vgPjcK0jYPCy9acfzio7zxnTCUlGPcR4nRZt?=
 =?us-ascii?Q?oAfDBthi5/R97PYXFs7aw763qtpCxLy6aWVZEQYK0t8RehdQzYzNu3qznBSh?=
 =?us-ascii?Q?x1PVRihionFrq06YgoQjwyh6nkEeLZVT5b2sRcN8KxfNvAg6HL7U9GfBX/Vi?=
 =?us-ascii?Q?aHOqgg=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RmXm5Q0uL/4gR0i3laBJYcekk1OoPOBJgIAfUdV60+/o64AXrJKz2R+cW/MRqJWsEepZxrYCp3YcAMBODgD3xzX5ZDrPpLFpQ6YhDFmYqt01EJbQVKt8Fx2Z4SiMyD2PytyV+dpUYD0qeHA52A+BmAOMgl8sYr1+fLbCkVZDYN/rnprK2WmTetr616z44N09WB91nOefpn5bL3aIWYYIsKOJ9Uw5s1MOm6xKO6Ds+9erXOz+WvUt/uPJUiQHk9RglfDFFpvktZuUs/dNJ5rxUEB0p/Y4M0hOkobsCGUjsHRVWs8J8ssOxpbCrW2gbg3XnCQ69PGY23ninXejUMRU4+YIblg3QWT5YwNRhbGP38VQbw+uEFlKUbCZn753r4JIDAtvv93xuwkUIReabSfA+ESEyiNftGN3PoYtvEXR51k=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3069;6:MbNLkdhnEibWSTxEkFTL3M2P7fRbUAiZBwndtTnTuAT27fI8hZ0TmGTxG5T8bbcLC+iYn3pIsc016o3RXns1DSBlpcGaYsMrYax+wdMBMCwyU2oMVMC8iSLADF29+mbmOORfpDpNAtDaaUJfaShcfeaSr02hDb+BfMZjFNMkMHJGd2mwhMk59oEhZ125f7tbU+h44iBCd3IEZD5dNC2+wnqZPvWT6x5Akm9XUNCfz9mGckXRvhZOORjn+SzXfrVoNxKbbTXoOk1IuYMBnkydRvDUBRUxdsUgDwazHY5a5XUeJo62fHTuvxZzgvRCSE4LWTo6hJdf9Yng57SUQABlxTHtNfv3f3f7e0EEVjauNwBw8nCj1NkN3e8tLeAep+fphOS7NgMLpD+ukLFSkc7Mdkvjb/v4IXknykOU8bVjz1nJoi+uMZIoKCpoathNtZOSYUhriji6SFVHJmF9Xahp2w==;5:W/0srqVqlFj+Zjf9XzJXzmDC+SbOIG2vPMu1D+u68yjFoStukQZM8i7jWG5G5J/AeUWRqEwc2BjTNp270D7juOgIvm3IyPz1NTbQahSQI6Nd/12DuXyawsDwsAeK2NAjUUKdXQTEQskzCpU7dGj2i/ROqZ6ZwvemFJ72VSc1nDfSG2AGBpap1MfkcnTAbnj8Btt1gOAO7q4EK39VU/ZqJg==;7:Q9Oa0t5fcjpQn9axGJ45QrJh8y8qJeBCZmAxVTHEj7RqA3K/ye33JjbqIzC6+c+9AJnHVYpIrZ1xSfoCAfMUCrXlnfkpVjQ6i6BaQ7adyezjplT7TSNLiYEYxt6GofZjxmV9MwzQ3PGaGzaJailUtw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2019 10:30:31.4999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249da6fd-f30b-43e3-2fd4-08d68a8bca24
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD7768-1 core ADC receives a master clock signal (MCLK). The MCLK
frequency combined with the MCLK division and the digital filter
decimation rates, determines the sampling frequency. Along with
MCLK_DIV, the power mode is also configured according to datasheet
recommendations.

From user space, available sampling frequencies can be read. However,
it is not required for an exact value to be entered, since the driver
will look for the closest available match.

When the device configuration changes (for example, if the filter
decimation rate changes), a SYNC_IN pulse is required.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 202 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 199 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 78449e9..0d13270 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
@@ -59,6 +60,18 @@
 #define AD7768_REG_DIG_DIAG_STATUS	0x30
 #define AD7768_REG_MCLK_COUNTER		0x31
 
+/* AD7768_REG_POWER_CLOCK */
+#define AD7768_PWR_MCLK_DIV_MSK		GENMASK(5, 4)
+#define AD7768_PWR_MCLK_DIV(x)		FIELD_PREP(AD7768_PWR_MCLK_DIV_MSK, x)
+#define AD7768_PWR_PWRMODE_MSK		GENMASK(1, 0)
+#define AD7768_PWR_PWRMODE(x)		FIELD_PREP(AD7768_PWR_PWRMODE_MSK, x)
+
+/* AD7768_REG_DIGITAL_FILTER */
+#define AD7768_DIG_FIL_FIL_MSK		GENMASK(6, 4)
+#define AD7768_DIG_FIL_FIL(x)		FIELD_PREP(AD7768_DIG_FIL_FIL_MSK, x)
+#define AD7768_DIG_FIL_DEC_MSK		GENMASK(2, 0)
+#define AD7768_DIG_FIL_DEC_RATE(x)	FIELD_PREP(AD7768_DIG_FIL_DEC_MSK, x)
+
 /* AD7768_REG_CONVERSION */
 #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
 #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
@@ -80,11 +93,51 @@ enum ad7768_pwrmode {
 	AD7768_FAST_MODE = 3
 };
 
+enum ad7768_mclk_div {
+	AD7768_MCLK_DIV_16,
+	AD7768_MCLK_DIV_8,
+	AD7768_MCLK_DIV_4,
+	AD7768_MCLK_DIV_2
+};
+
+enum ad7768_dec_rate {
+	AD7768_DEC_RATE_32 = 0,
+	AD7768_DEC_RATE_64 = 1,
+	AD7768_DEC_RATE_128 = 2,
+	AD7768_DEC_RATE_256 = 3,
+	AD7768_DEC_RATE_512 = 4,
+	AD7768_DEC_RATE_1024 = 5,
+	AD7768_DEC_RATE_8 = 9,
+	AD7768_DEC_RATE_16 = 10
+};
+
+struct ad7768_clk_configuration {
+	enum ad7768_mclk_div mclk_div;
+	enum ad7768_dec_rate dec_rate;
+	unsigned int clk_div;
+	enum ad7768_pwrmode pwrmode;
+};
+
+static const struct ad7768_clk_configuration ad7768_clk_config[] = {
+	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
+	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
+	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_32, 64, AD7768_FAST_MODE },
+	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_64, 128, AD7768_FAST_MODE },
+	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_128, 256, AD7768_FAST_MODE },
+	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_128, 512, AD7768_MED_MODE },
+	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_256, 1024, AD7768_MED_MODE },
+	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_512, 2048, AD7768_MED_MODE },
+	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_1024, 4096, AD7768_MED_MODE },
+	{ AD7768_MCLK_DIV_8, AD7768_DEC_RATE_1024, 8192, AD7768_MED_MODE },
+	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
+};
+
 static const struct iio_chan_spec ad7768_channels[] = {
 	{
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.indexed = 1,
 		.channel = 0,
 		.scan_index = 0,
@@ -102,8 +155,12 @@ struct ad7768_state {
 	struct spi_device *spi;
 	struct regulator *vref;
 	struct mutex lock;
+	struct clk *mclk;
+	unsigned int mclk_freq;
+	unsigned int samp_freq;
 	struct completion completion;
 	struct iio_trigger *trig;
+	struct gpio_desc *gpio_sync_in;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -210,6 +267,90 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad7768_set_dig_fil(struct ad7768_state *st,
+			      enum ad7768_dec_rate dec_rate)
+{
+	unsigned int mode;
+	int ret;
+
+	if (dec_rate == AD7768_DEC_RATE_8 || dec_rate == AD7768_DEC_RATE_16)
+		mode = AD7768_DIG_FIL_FIL(dec_rate);
+	else
+		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
+
+	ret = ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER, mode);
+	if (ret < 0)
+		return ret;
+
+	/* A sync-in pulse is required every time the filter dec rate changes */
+	gpiod_set_value(st->gpio_sync_in, 1);
+	gpiod_set_value(st->gpio_sync_in, 0);
+
+	return 0;
+}
+
+static int ad7768_set_freq(struct ad7768_state *st,
+			   unsigned int freq)
+{
+	unsigned int diff_new, diff_old, pwr_mode, i, idx;
+	int res, ret;
+
+	diff_old = U32_MAX;
+	idx = 0;
+
+	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq);
+
+	/* Find the closest match for the desired sampling frequency */
+	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
+		diff_new = abs(res - ad7768_clk_config[i].clk_div);
+		if (diff_new < diff_old) {
+			diff_old = diff_new;
+			idx = i;
+		}
+	}
+
+	/*
+	 * Set both the mclk_div and pwrmode with a single write to the
+	 * POWER_CLOCK register
+	 */
+	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
+		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
+	ret = ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK, pwr_mode);
+	if (ret < 0)
+		return ret;
+
+	ret =  ad7768_set_dig_fil(st, ad7768_clk_config[idx].dec_rate);
+	if (ret < 0)
+		return ret;
+
+	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
+					  ad7768_clk_config[idx].clk_div);
+
+	return 0;
+}
+
+static ssize_t ad7768_sampling_freq_avail(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int freq;
+	int i, len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
+		freq = DIV_ROUND_CLOSEST(st->mclk_freq,
+					 ad7768_clk_config[i].clk_div);
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", freq);
+	}
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ad7768_sampling_freq_avail);
+
 static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -242,13 +383,43 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		*val2 = chan->scan_type.realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->samp_freq;
+
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
 }
 
+static int ad7768_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad7768_set_freq(st, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct attribute *ad7768_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad7768_group = {
+	.attrs = ad7768_attributes,
+};
+
 static const struct iio_info ad7768_info = {
+	.attrs = &ad7768_group,
 	.read_raw = &ad7768_read_raw,
+	.write_raw = &ad7768_write_raw,
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
@@ -270,9 +441,13 @@ static int ad7768_setup(struct ad7768_state *st)
 	if (ret)
 		return ret;
 
-	/* Set power mode to fast */
-	return ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK,
-				    AD7768_FAST_MODE);
+	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
+					  GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_sync_in))
+		return PTR_ERR(st->gpio_sync_in);
+
+	/* Set the default sampling frequency to 32000 kSPS */
+	return ad7768_set_freq(st, 32000);
 }
 
 static irqreturn_t ad7768_trigger_handler(int irq, void *p)
@@ -356,6 +531,13 @@ static void ad7768_regulator_disable(void *data)
 	regulator_disable(st->vref);
 }
 
+static void ad7768_clk_disable(void *data)
+{
+	struct ad7768_state *st = data;
+
+	clk_disable_unprepare(st->mclk);
+}
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
@@ -383,6 +565,20 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	st->mclk = devm_clk_get(&spi->dev, "mclk");
+	if (IS_ERR(st->mclk))
+		return PTR_ERR(st->mclk);
+
+	ret = clk_prepare_enable(st->mclk);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, ad7768_clk_disable, st);
+	if (ret)
+		return ret;
+
+	st->mclk_freq = clk_get_rate(st->mclk);
+
 	spi_set_drvdata(spi, indio_dev);
 	mutex_init(&st->lock);
 
-- 
2.7.4


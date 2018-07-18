Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94A3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE542075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LAMeeBqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE542075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbeGRN7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:59:14 -0400
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:16000
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729324AbeGRN7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXhB32xMdKqc5EzdZJhVdwW5ldaRto2r1aXCqC4njwI=;
 b=LAMeeBquTqtTYXJF+UayOIYcdPxHXmBFcRNWksnPT9uIsrlvTSlvCIF2o2a2aznzjRyzcdeoxuIUTIOeNQpYaINxd2biO+ZAXWpzFm1a4++vWPcEo+t41fJ1B3WNvyMdFBeVmhqA+kGzB83J0eI2oMMngo4jrlkfchfrrC9FPng=
Received: from CY1PR07CA0033.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::43) by BN7PR07MB4707.namprd07.prod.outlook.com
 (2603:10b6:406:f0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Wed, 18 Jul
 2018 13:20:11 +0000
Received: from BY2NAM05FT020.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::202) by CY1PR07CA0033.outlook.office365.com
 (2a01:111:e400:c60a::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 18 Jul 2018 13:20:11 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT020.mail.protection.outlook.com (10.152.100.157) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.995.0 via
 Frontend Transport; Wed, 18 Jul 2018 13:20:11 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6IDK8a8012402
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 18 Jul 2018 06:20:10 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 18 Jul 2018 15:20:23 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 18 Jul 2018 15:20:23 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6IDK7la031401;
        Wed, 18 Jul 2018 14:20:07 +0100
Received: (from stelford@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6IDK6KJ031351;
        Wed, 18 Jul 2018 14:20:06 +0100
From:   Scott Telford <stelford@cadence.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>,
        <dkos@cadence.com>
CC:     Scott Telford <stelford@cadence.com>
Subject: [PATCH] phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY
Date:   Wed, 18 Jul 2018 14:20:03 +0100
Message-ID: <1531920003-7364-1-git-send-email-stelford@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(199004)(189003)(36092001)(87636003)(16586007)(316002)(110136005)(42186006)(50466002)(48376002)(86362001)(2906002)(2201001)(575784001)(26826003)(478600001)(50226002)(8676002)(126002)(305945005)(6666003)(47776003)(336012)(7636002)(486006)(6636002)(26005)(14444005)(107886003)(5660300001)(4326008)(356003)(1857600001)(51416003)(186003)(426003)(105596002)(106466001)(36756003)(246002)(2616005)(8936002)(476003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4707;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT020;1:V0hwtzXDeCWjflfL9kmmGoyU1WiXrn1r6t/V6zHAUZlPZ1hbB6Ffd5lLfnew3Riot/pHT0UgJGXWx5nK1XBw78TW4TmUHrp9IT0NUTEPE/yNNY8+MaUdgrLcwb5ADjzg
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e31db2-bb44-4d26-f9ae-08d5ecb130a6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4707;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;3:QaKNwg0q6j/re7plzvsDz6AJEu/kHlNRXx1fR9tpGcSZuwwqfGMICaYAebaLhuwxyZFNsHA0rqpJqwNFstsjmKpBCPlUT0idWMmviLJOm37mzwTvOJoTSEVUvZ1Ote9Mij4vG4ZzsSBxEBU85ohgT8oYdQao6ITUKIPcROy+V83w2jFKDYNvMO8P8TKw+eLD2vvd2W8FDg0MLahfpLwyZlXrvDpV6ecLRmErB7CAUsSXLEYZFT1P1DpA/U9nMIcV3bG23hNy8Q08lY8FZZ6WfScPMtSisWDF3v6fXxjy6jD9L5iYIlfBEo7crgWgY/cO5pgop7GXzAtwpL3DTZzKWg==;25:l8uB1tiwkztWmyUVArvihsCadCBjwgPc8n38PaO2kU4MQ3oeMwZbnQN8kI7RxzujRd0Y/vGAWkb9Smqpshk6m2tNbJnKv3DIcKjV5laQdKPUg2udSok/RuPGwkUbsZl61m+6Erar82blLRz4JIdzrZYn+ojvH8rp8MsIyBq/+kv2yOL5cckB01K01byMOWEDMMs9aEPwdaOPF7I2GXgRLkQEpjNtf5RQ/nNJDY4oQ7tyVOh4R9DIpPsTXsTJLzOQZWDl5rLl2cQ03qC8MSTKdpTRl28RCYWBIDV+NJcV1nCkFZHvhu2ZmYZt1TmZev2IHai8Gt2iWMotkLlvPOR2eQ==;31:ogI4BNzaUjLNUJrdyCEmly1qIn/m1afF8MN4C1ZM7NuVjKBbsL57gvTkhBQB6BEaVIvRSCXhTKcn0Q9fOWe0jj1dFbn6ODgaXElfFXBdRtHUBVzfGlGQW+R+a4V1rVJA3vLaj1NlaK7mdo2WLXUaXnqco/gEfIw2/xT4nFdZdTrBok84u8k2uH1PEGF+ajzFvntgBbj1SSYk7c6WHuMxtxrGhzXaYg6wZu+8GNJx7ck=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4707:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;20:l4wPHA0hIXivtWhO/xnJDAvpUo1ox7CZCF5+Rg81lBnH1yDgacCERiquxtMglIlFiZicXfhLJCm+I9N30unnasETa9MiSMYjFL8gvCIPJY4TSx4kZ0QqzYuUuQveO9HHfqWpZ0NGjUon5cg4KVImBDkvHoRJhbhMezfDO6VD1TjF02HIQSfJa05+87DshfY64ncB/grZch5Ox2hPyxzilFl+/FRPCgSx/u6EBMHSTv+tZzs5RNT4+Xnd4U/6cCrzjiDz3sjblpX1zLkPAmXqE1hg8B4w589XVWUZZ+VCJgAyAKE2rYAwzluFQPS6HTuz0M1T2gSklF5LU7WG7AC3MVP9zqAi9IXJ0hXK6nrft5vWKLIox7UPCCiC7YG3sJ+QHTNrXLelthtMZbm3ZB3WI5kPiQ2NUwywj0sTVF+sr4fNfG+hs9agJD7GgtnBt+5yaKIwziYInliZfAcox6NBu9QiTFmCN9J3ycbMM8X5d51EABWaKQCAmqG7J2uTP0i8;4:s1QIOEbIb4/WX3xuZraQ6P7q4BwhiGll3AZ0qeN2xLJfsJHcxSqWEYJ60ds9zm99Ow9t+E52rg7hvm0Zq4NORXK5CNHHxb4c1SCFsYfP3OXQoNh9Dt77nTtTBdcxHczd7TQ77jhXMkk3sy1tocKL5q7wmUPcp0MPXiXqDm16qb7J0YOVaj3dvS82TLhPerZlTDXSQu4jgBz4rG2lIFKgssK10jegswJ9a6IhbVvdkyI/QnnlI6tMHXfZrlStApqeVDzJLtHO0nuRXl9Zy1AbksuMXi58bL7UvWiQXgAMPvKFO2X4eo1JZl2kOUU6Ycr+
X-Microsoft-Antispam-PRVS: <BN7PR07MB47079577F98AC5EC93C583EBCF530@BN7PR07MB4707.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93003095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4707;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4707;
X-Forefront-PRVS: 0737B96801
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4707;23:Q1G8fL9lHft/RzJC5aKK877IADiaKX7TYlXlgTpVa?=
 =?us-ascii?Q?mUxcs7ySdZ3EgF2kdLQpMaRHHm71C9/hiGcVjOXwdXAvQcOU4QCEpvIp+NCR?=
 =?us-ascii?Q?YfVgsjp9o+DbYZKxMBAl41CENjR9GHLEUpCKc3sP/ERsqCBGXzpWIE8ZZxUA?=
 =?us-ascii?Q?qTxFS8kwxXBJMj6+iT7yrMBqIXkKAD8bVLHchjRiwIo/ZsCBLumyTgeSpJZu?=
 =?us-ascii?Q?ihKQu5VnGv8BzK8mTfTF8wjh/eMZA1ule+Ju1pBbe0Elb85ZbQa2TgE7Frlz?=
 =?us-ascii?Q?2fFmF8uZMMr52yPSGNlRW1mPWTUgLJB/ufJoal5WxlS+bqlYXtN6eQ+J90YK?=
 =?us-ascii?Q?3PuMDj3A+PcxyRL/Jx0tgwcs93N3Ot81Rr+mcCNGoUhwBd7P4+I9rWS52tzT?=
 =?us-ascii?Q?P636JxB5yK7dOtKaKk4fK4Ae+dNpdk5g7M+a2gatCos81TH6dHoqkJdEs5sb?=
 =?us-ascii?Q?85Vkasbuzue0BWYe+npxw3Ypl/dYFm1dpnikadANGV1z0IRGIncPVlvI30Yp?=
 =?us-ascii?Q?s47bl9UGslK7YKXw7/zWc81V3khiYlBRe5uH4+0gaXmc32PcjB9fr1Il6/+x?=
 =?us-ascii?Q?u0eG5AbmG4W1yIlWZXViDxFAbgWo8Us1q12xu+wr/8B3iX7ni+QCyUo65wI4?=
 =?us-ascii?Q?GFYFqli+PuV2/aMh3Ppg6/gQFxe5IH5adLwmnuHPYB0gd9xuMpbM9IW6tmg3?=
 =?us-ascii?Q?DQ+dDwGnG9g3ttqIAanXl101HomXDm2E9+yLwZ4CQhXOWYKWwIrndu1uZ9Wg?=
 =?us-ascii?Q?H34cA/ysR3Q5VM3s4oWnasLQNeDAt1jOQAdUBVvAwspSoBsxQfIA5IOCn64G?=
 =?us-ascii?Q?HKVkwjLQCbGeBoAuYtfZjiIVWkMP2yf0NmvqIwuZjp5CrfnhfnssIP4di2Zu?=
 =?us-ascii?Q?8DIRvOH6XNcigWv9IxxRZlAdoovlv3++ibSK5e5HDwvsM0mud9xIBxtmBWQH?=
 =?us-ascii?Q?YCcgyHeOziTbVuOl0ANuVYjYB8URFaXsvrLsq3F2fkQ+PwtC1Bsq5u1LOmVQ?=
 =?us-ascii?Q?mpIfAwjO2qrKMMKDFL+p0dpoB9BivuqxUFX9GV8Pa1tygIkD0E5MyqIWKIOa?=
 =?us-ascii?Q?YRnf1+MDZ4bNHfr9hvXtMvM2S9OSitfZblfdY3Sz9zLrWcKePKafG+uVhI6J?=
 =?us-ascii?Q?tJd2Eolqzs=3D?=
X-Microsoft-Antispam-Message-Info: hOMEHxfAqAob5gCQvllYSkNSMEVV6csnwEza3JzLnqAkVELql81Shd6R3JP0+FrvyAcF+ODzXmnHBHzJj6bf7iYbDLo3GYNeZUdg81CX9uMGo+55zN9pLATEip6RtvsgGHV2oo2leyh6iMkE781XzCAzIjrIIjWds7xIMqeKLfR6y0Uzk70+BIy3oDnf2cwSgbgTefK0BUQpexW/YXWTm4cadcSu5Yd23B+qM6TXJz4gLwNdZs+yYWfHeqG4URLwnyHNc3SCO0J0MXWH4NGg22SAxb7nj4GLR8iAxDDKrub9BwDO99f8xpe3mU3zITfM2FE8yCKltu2gt7/Ulv8XFqLGwE3op+41dCE50vDrTUxTxkSZ06bQE+6yOnIFJii5Ke2QVnK8TGvDQBYHxyOb/g==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;6:9TFVnY9GXGT/feFmNNNiqO5QxBx6TMaYAqkLpZ0C3GP6C16z/NwCIbs1riOaOpC9/baRIC0g1cxMgSs14yrAXDzm9n9tHO8BwuYBrOShRJz/zlUITGV6Q77VW55ba1tgmGihHkeCT9dSeg2yAoK1n9R47mQu2FwU/GWow3D9KCjOnE0r+cMGlNjwJXvlElkeaeN6TfKYz/LtSSPzEtrmuko9fUW46iK7zw+uOknb6DDJX76n3eRWVH3szl4cNlG6O8xrUocKBWoVRtHMKbX1maJy02qFlIC8NUmPETQ3Honv1U/YueuicAi2wcK+sqjhOePa0wOmu49Iy3q4Zdt4+HllwZHRYVxKdzK4J3NPqPZtfoWSdt0GWflsF9kg2KJff5k2uoEjDJLbDyY96LR8+Hgm6ZL/EtiW5QquBNKhErSF1SLu+VkDkYzlDG4GKPwnZyN/yUK2dvPnkYwdY3v5TA==;5:LBIoRFKdeaQgGvxzUp/FBxVwtldko/b8Rya5EcvOEJ46QHtmqFbov8ZHsllgrOvzbIzIKJ+Q6+cUC2CGaBpgaEPHdDhj85LVC0DRI7DNfo5Vxx7BKX+77k+2Sus8HTlrWtgSFOdzC5H6XZ5XeH+JaSDfpzHOEkk99gDPNM5EyVA=;24:Rhlp7sjyYQW6mEhFRypRzwLweI4fHpyK53D32Vapzag2S93PTc0/F5EcRWT67ro5sHs3bJHY0fvnuYIKtiXSa5rc4v67DxtcAvrfdFGetcg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;7:GsHOrINoqlXpoZx8dyxuyD4DvCD0IFWSHOgSw+5bF2YHn+2B3nydJkKdi2+E4tnmy1FdrVgQoqdRXzYUCloXfbWP1sdrAEFcIkLTF0A6uyKhZRhU+Rh+E3o3dhOwRSgHVSy655Ldw978BmBPwqGroZgLUlZeJ4W9fp5zUId/mJXOJrfMNIGB7pYpqjAx0MbeXf1+IH7i8O5Od/s8tKinRm1adN4w8X18CGbw5HmzinzMKMeeD+VyO1QOyq9r7vSQ;20:euSu4fn5TkQR24AMj4k63GyYFocZDB7jJLece1qvpI7Xc8wwJc8iUlFdPohCv5tJyvgtNonAY8gjBAiA/Y6tK7zz4hMckl27odWEaM41fDYn0Mw/phECZC7YCHy1yaxSaQwzoGRxFaLdQksr7qv+Oc6l4IReTPjaNMNwKOtYrsnSQgKL+N8DQi/RUMQnpVilxSfhjho+zugrccs7H3p81CbgiB4n7Oub1urHxCKp8Bs5StFjJiB7CxKiN020B0Ll
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:20:11.1783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e31db2-bb44-4d26-f9ae-08d5ecb130a6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the Cadence SD0801 "Torrent" PHY used with the Cadence MHDP
DisplayPort Tx controller.

Integration with the MHDP driver will be the subject of another commit.

Signed-off-by: Scott Telford <stelford@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-dp.txt     |  28 ++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/cadence/Kconfig                        |   9 +
 drivers/phy/cadence/Makefile                       |   1 +
 drivers/phy/cadence/phy-cadence-dp.c               | 436 +++++++++++++++++++++
 drivers/phy/cadence/phy-cadence-dp.h               | 117 ++++++
 7 files changed, 593 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cadence-dp.c
 create mode 100644 drivers/phy/cadence/phy-cadence-dp.h

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
new file mode 100644
index 0000000..8de0526
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
@@ -0,0 +1,28 @@
+Cadence MHDP DisplayPort SD0801 PHY binding
+===========================================
+
+This binding describes the Cadence SD0801 PHY hardware included with
+the Cadence MHDP DisplayPort controller.
+
+-------------------------------------------------------------------------------
+Required properties (controller (parent) node):
+- compatible	: Should be "cdns,dp-phy"
+- reg		: Defines the following sets of registers in the parent
+		  mhdp device:
+			- Offset of the DPTX PHY configuration registers
+			- Offset of the SD0801 PHY configuration registers
+- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
+- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps (2160,
+		  2430, 2700, 3240, 4320, 5400 or 8100)
+- #phy-cells	: from the generic PHY bindings, must be 0.
+-------------------------------------------------------------------------------
+
+Example:
+	dp_phy: phy@f0fb030a00 {
+		compatible = "cdns,dp-phy";
+		reg = <0xf0 0xfb030a00 0x0 0x00000040>,
+		      <0xf0 0xfb500000 0x0 0x00100000>;
+		num_lanes = <4>;
+		max_bit_rate = <8100>;
+		#phy-cells = <0>;
+	};
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8d452..cc47f85 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -43,6 +43,7 @@ config PHY_XGENE
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
+source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
 source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 84e3bd9..ba48acd 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= broadcom/	\
+					   cadence/	\
 					   hisilicon/	\
 					   marvell/	\
 					   motorola/	\
diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
new file mode 100644
index 0000000..0cb12c2
--- /dev/null
+++ b/drivers/phy/cadence/Kconfig
@@ -0,0 +1,9 @@
+#
+# Phy driver for Cadence MHDP DisplayPort controller
+#
+config PHY_CADENCE_DP
+	tristate "Cadence MHDP DisplayPort PHY driver"
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Support for Cadence MHDP DisplayPort PHY.
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
new file mode 100644
index 0000000..e5b0a11
--- /dev/null
+++ b/drivers/phy/cadence/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PHY_CADENCE_DP)	+= phy-cadence-dp.o
diff --git a/drivers/phy/cadence/phy-cadence-dp.c b/drivers/phy/cadence/phy-cadence-dp.c
new file mode 100644
index 0000000..c1cf89b
--- /dev/null
+++ b/drivers/phy/cadence/phy-cadence-dp.c
@@ -0,0 +1,436 @@
+/*
+ * Cadence MHDP DisplayPort SD0801 PHY driver.
+ *
+ * Copyright 2018 Cadence Design Systems, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include "phy-cadence-dp.h"
+
+
+static const struct phy_ops cdns_dp_phy_ops = {
+	.init		= cdns_dp_phy_init,
+	.owner		= THIS_MODULE,
+};
+
+static const struct of_device_id cdns_dp_phy_of_match[] = {
+	{
+		.compatible = "cdns,dp-phy"
+	},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, cdns_dp_phy_of_match);
+
+static int cdns_dp_phy_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	struct cdns_dp_phy *cdns_phy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct phy *phy;
+	int err;
+
+	cdns_phy = devm_kzalloc(dev, sizeof(*cdns_phy), GFP_KERNEL);
+	if (!cdns_phy)
+		return -ENOMEM;
+
+	cdns_phy->dev = &pdev->dev;
+
+	phy = devm_phy_create(dev, NULL, &cdns_dp_phy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "failed to create DisplayPort PHY\n");
+		return PTR_ERR(phy);
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cdns_phy->base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(cdns_phy->base))
+		return PTR_ERR(cdns_phy->base);
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	cdns_phy->sd_base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(cdns_phy->sd_base))
+		return PTR_ERR(cdns_phy->sd_base);
+
+	err = device_property_read_u32(dev, "num_lanes",
+				       &(cdns_phy->num_lanes));
+	if (err)
+		cdns_phy->num_lanes = DEFAULT_NUM_LANES;
+
+	switch (cdns_phy->num_lanes) {
+	case 1:
+	case 2:
+	case 4:
+		/* valid number of lanes */
+		break;
+	default:
+		dev_err(dev, "unsupported number of lanes: %d\n",
+			cdns_phy->num_lanes);
+		return -EINVAL;
+	}
+
+	err = device_property_read_u32(dev, "max_bit_rate",
+		   &(cdns_phy->max_bit_rate));
+	if (err)
+		cdns_phy->max_bit_rate = DEFAULT_MAX_BIT_RATE;
+
+	switch (cdns_phy->max_bit_rate) {
+	case 2160:
+	case 2430:
+	case 2700:
+	case 3240:
+	case 4320:
+	case 5400:
+	case 8100:
+		/* valid bit rate */
+		break;
+	default:
+		dev_err(dev, "unsupported max bit rate: %dMbps\n",
+			cdns_phy->max_bit_rate);
+		return -EINVAL;
+	}
+
+	phy_set_drvdata(phy, cdns_phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
+		 cdns_phy->num_lanes,
+		 cdns_phy->max_bit_rate / 1000,
+		 cdns_phy->max_bit_rate % 1000);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+
+static int cdns_dp_phy_init(struct phy *phy)
+{
+	unsigned char lane_bits;
+
+	struct cdns_dp_phy *cdns_phy = phy_get_drvdata(phy);
+
+	writel(0x0003, cdns_phy->base + PHY_AUX_CTRL); /* enable AUX */
+
+	/* PHY PMA registers configuration function */
+	cdns_dp_phy_pma_cfg(cdns_phy);
+
+	/* Set lines power state to A0
+	 * Set lines pll clk enable to 0
+	 */
+
+	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ,
+				PHY_POWER_STATE_LN_0, 6, 0x0000);
+
+	if (cdns_phy->num_lanes >= 2) {
+		cdns_dp_phy_write_field(cdns_phy,
+					PHY_PMA_XCVR_POWER_STATE_REQ,
+					PHY_POWER_STATE_LN_1, 6, 0x0000);
+
+		if (cdns_phy->num_lanes == 4) {
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_REQ,
+						PHY_POWER_STATE_LN_2, 6, 0);
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_REQ,
+						PHY_POWER_STATE_LN_3, 6, 0);
+		}
+	}
+
+	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
+				0, 1, 0x0000);
+
+	if (cdns_phy->num_lanes >= 2) {
+		cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
+					1, 1, 0x0000);
+		if (cdns_phy->num_lanes == 4) {
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_PLLCLK_EN,
+						2, 1, 0x0000);
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_PLLCLK_EN,
+						3, 1, 0x0000);
+		}
+	}
+
+	/* release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
+	 * used lanes
+	 */
+	lane_bits = (1 << cdns_phy->num_lanes) - 1;
+	writel(((0xF & ~lane_bits) << 4) | (0xF & lane_bits),
+		   cdns_phy->base + PHY_RESET);
+
+	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
+	writel(0x0001, cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN);
+
+	/* PHY PMA registers configuration functions */
+	cdns_dp_phy_pma_cmn_vco_cfg_25mhz(cdns_phy);
+	cdns_dp_phy_pma_cmn_rate(cdns_phy);
+
+	/* take out of reset */
+	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
+	cdns_dp_phy_wait_pma_cmn_ready(cdns_phy);
+	cdns_dp_phy_run(cdns_phy);
+
+	return 0;
+}
+
+static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_CMN_READY, reg,
+				 reg & 1, 0, 500);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for PMA common ready\n");
+}
+
+static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int i;
+
+	/* PMA common configuration */
+	cdns_dp_phy_pma_cmn_cfg_25mhz(cdns_phy);
+
+	/* PMA lane configuration to deal with multi-link operation */
+	for (i = 0; i < cdns_phy->num_lanes; i++)
+		cdns_dp_phy_pma_lane_cfg(cdns_phy, i);
+}
+
+static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
+{
+	/* refclock registers - assumes 25 MHz refclock */
+	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
+	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM0_PLLPRE_TMR);
+	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM0_PLLLOCK_TMR);
+	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM1_PLLPRE_TMR);
+	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM1_PLLLOCK_TMR);
+	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_INIT_TMR);
+	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_ITER_TMR);
+	writel(0x0019, cdns_phy->sd_base + CMN_IBCAL_INIT_TMR);
+	writel(0x001E, cdns_phy->sd_base + CMN_TXPUCAL_INIT_TMR);
+	writel(0x0006, cdns_phy->sd_base + CMN_TXPUCAL_ITER_TMR);
+	writel(0x001E, cdns_phy->sd_base + CMN_TXPDCAL_INIT_TMR);
+	writel(0x0006, cdns_phy->sd_base + CMN_TXPDCAL_ITER_TMR);
+	writel(0x02EE, cdns_phy->sd_base + CMN_RXCAL_INIT_TMR);
+	writel(0x0006, cdns_phy->sd_base + CMN_RXCAL_ITER_TMR);
+	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_INIT_TMR);
+	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_ITER_TMR);
+	writel(0x000E, cdns_phy->sd_base + CMN_SD_CAL_REFTIM_START);
+	writel(0x012B, cdns_phy->sd_base + CMN_SD_CAL_PLLCNT_START);
+	/* PLL registers */
+	writel(0x0409, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_PADJ_M0);
+	writel(0x1001, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_IADJ_M0);
+	writel(0x0F08, cdns_phy->sd_base + CMN_PDIAG_PLL0_FILT_PADJ_M0);
+	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_DSM_DIAG_M0);
+	writel(0x00FA, cdns_phy->sd_base + CMN_PLL0_VCOCAL_INIT_TMR);
+	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_VCOCAL_ITER_TMR);
+	writel(0x00FA, cdns_phy->sd_base + CMN_PLL1_VCOCAL_INIT_TMR);
+	writel(0x0004, cdns_phy->sd_base + CMN_PLL1_VCOCAL_ITER_TMR);
+	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_REFTIM_START);
+}
+
+static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
+{
+	/* Assumes 25 MHz refclock */
+	switch (cdns_phy->max_bit_rate) {
+		/* Setting VCO for 10.8GHz */
+	case 2700:
+	case 5400:
+		writel(0x01B0, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x0120, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+		/* Setting VCO for 9.72GHz */
+	case 2430:
+	case 3240:
+		writel(0x0184, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0xCCCD, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x0104, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+		/* Setting VCO for 8.64GHz */
+	case 2160:
+	case 4320:
+		writel(0x0159, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0x999A, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x00E7, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+		/* Setting VCO for 8.1GHz */
+	case 8100:
+		writel(0x0144, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x00D8, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+	}
+
+	writel(0x0002, cdns_phy->sd_base + CMN_PDIAG_PLL0_CTRL_M0);
+	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_PLLCNT_START);
+}
+
+static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int clk_sel_val = 0;
+	unsigned int hsclk_div_val = 0;
+	unsigned int i;
+
+	/* 16'h0000 for single DP link configuration */
+	writel(0x0000, cdns_phy->sd_base + PHY_PLL_CFG);
+
+	switch (cdns_phy->max_bit_rate) {
+	case 1620:
+		clk_sel_val = 0x0f01;
+		hsclk_div_val = 2;
+		break;
+	case 2160:
+	case 2430:
+	case 2700:
+		clk_sel_val = 0x0701;
+		 hsclk_div_val = 1;
+		break;
+	case 3240:
+		clk_sel_val = 0x0b00;
+		hsclk_div_val = 2;
+		break;
+	case 4320:
+	case 5400:
+		clk_sel_val = 0x0301;
+		hsclk_div_val = 0;
+		break;
+	case 8100:
+		clk_sel_val = 0x0200;
+		hsclk_div_val = 0;
+		break;
+	}
+
+	writel(clk_sel_val, cdns_phy->sd_base + CMN_PDIAG_PLL0_CLK_SEL_M0);
+
+	/* PMA lane configuration to deal with multi-link operation */
+	for (i = 0; i < cdns_phy->num_lanes; i++) {
+		writel(hsclk_div_val,
+		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i<<11)));
+	}
+}
+
+static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
+				     unsigned int lane)
+{
+	unsigned int i;
+
+	i = 0x0007 & lane;
+	/* Writing Tx/Rx Power State Controllers registers */
+	writel(0x00FB, cdns_phy->sd_base + (TX_PSC_A0 | (i<<11)));
+	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A2 | (i<<11)));
+	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A3 | (i<<11)));
+	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A0 | (i<<11)));
+	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A2 | (i<<11)));
+	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A3 | (i<<11)));
+
+	writel(0x0001, cdns_phy->sd_base + (XCVR_DIAG_PLLDRC_CTRL | (i<<11)));
+	writel(0x0000, cdns_phy->sd_base + (XCVR_DIAG_HSCLK_SEL | (i<<11)));
+}
+
+static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int read_val;
+	u32 write_val1 = 0;
+	u32 write_val2 = 0;
+	u32 mask = 0;
+	int ret;
+
+	/* waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
+	 * master lane
+	 */
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN_ACK,
+				 read_val, read_val & 1, 0, POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for link PLL clock enable ack\n");
+
+	ndelay(100);
+
+	switch (cdns_phy->num_lanes) {
+
+	case 1:	/* lane 0 */
+		write_val1 = 0x00000004;
+		write_val2 = 0x00000001;
+		mask = 0x0000003f;
+		break;
+	case 2: /* lane 0-1 */
+		write_val1 = 0x00000404;
+		write_val2 = 0x00000101;
+		mask = 0x00003f3f;
+		break;
+	case 4: /* lane 0-3 */
+		write_val1 = 0x04040404;
+		write_val2 = 0x01010101;
+		mask = 0x3f3f3f3f;
+		break;
+	}
+
+	writel(write_val1, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_ACK,
+				 read_val, (read_val & mask) == write_val1, 0,
+				 POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for link power state ack\n");
+
+	writel(0, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	ndelay(100);
+
+	writel(write_val2, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_ACK,
+				 read_val, (read_val & mask) == write_val2, 0,
+				 POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for link power state ack\n");
+
+	writel(0, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	ndelay(100);
+}
+
+static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
+				    unsigned int offset,
+				    unsigned char start_bit,
+				    unsigned char num_bits,
+				    unsigned int val)
+{
+	unsigned int read_val;
+
+	read_val = readl(cdns_phy->base + offset);
+	writel(((val << start_bit) | (read_val & ~(((1 << num_bits) - 1) <<
+		start_bit))), cdns_phy->base + offset);
+}
+
+static struct platform_driver cdns_dp_phy_driver = {
+	.probe	= cdns_dp_phy_probe,
+	.driver = {
+		.name	= "cdns-dp-phy",
+		.of_match_table	= cdns_dp_phy_of_match,
+	}
+};
+module_platform_driver(cdns_dp_phy_driver);
+
+MODULE_AUTHOR("Scott Telford <stelford@cadence.com>");
+MODULE_DESCRIPTION("Cadence MHDP PHY driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/cadence/phy-cadence-dp.h b/drivers/phy/cadence/phy-cadence-dp.h
new file mode 100644
index 0000000..8807b0b
--- /dev/null
+++ b/drivers/phy/cadence/phy-cadence-dp.h
@@ -0,0 +1,117 @@
+/*
+ * Cadence MHDP DisplayPort SD0801 PHY driver.
+ *
+ * Copyright 2018 Cadence Design Systems, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifndef _PHY_CADENCE_DP_H
+#define _PHY_CADENCE_DP_H
+
+#include <linux/platform_device.h>
+
+#define DEFAULT_NUM_LANES 2
+#define MAX_NUM_LANES 4
+#define DEFAULT_MAX_BIT_RATE 8100 /* in Mbps */
+
+#define POLL_TIMEOUT_US 2000
+
+/* register offsets from DPTX PHY register block base (i.e MHDP
+ * register base + 0x30a00)
+ */
+#define PHY_AUX_CONFIG			0x00
+#define PHY_AUX_CTRL			0x04
+#define PHY_RESET			0x20
+#define PHY_PMA_XCVR_PLLCLK_EN		0x24
+#define PHY_PMA_XCVR_PLLCLK_EN_ACK	0x28
+#define PHY_PMA_XCVR_POWER_STATE_REQ	0x2c
+#define PHY_POWER_STATE_LN_0	0x0000
+#define PHY_POWER_STATE_LN_1	0x0008
+#define PHY_POWER_STATE_LN_2	0x0010
+#define PHY_POWER_STATE_LN_3	0x0018
+#define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
+#define PHY_PMA_CMN_READY		0x34
+#define PHY_PMA_XCVR_TX_VMARGIN		0x38
+#define PHY_PMA_XCVR_TX_DEEMPH		0x3c
+
+/* register offsets from SD0801 PHY register block base (i.e MHDP
+ * register base + 0x500000)
+ */
+#define CMN_SSM_BANDGAP_TMR		0x00084
+#define CMN_SSM_BIAS_TMR		0x00088
+#define CMN_PLLSM0_PLLPRE_TMR		0x000a8
+#define CMN_PLLSM0_PLLLOCK_TMR		0x000b0
+#define CMN_PLLSM1_PLLPRE_TMR		0x000c8
+#define CMN_PLLSM1_PLLLOCK_TMR		0x000d0
+#define CMN_BGCAL_INIT_TMR		0x00190
+#define CMN_BGCAL_ITER_TMR		0x00194
+#define CMN_IBCAL_INIT_TMR		0x001d0
+#define CMN_PLL0_VCOCAL_INIT_TMR	0x00210
+#define CMN_PLL0_VCOCAL_ITER_TMR	0x00214
+#define CMN_PLL0_VCOCAL_REFTIM_START	0x00218
+#define CMN_PLL0_VCOCAL_PLLCNT_START	0x00220
+#define CMN_PLL0_INTDIV_M0		0x00240
+#define CMN_PLL0_FRACDIVL_M0		0x00244
+#define CMN_PLL0_FRACDIVH_M0		0x00248
+#define CMN_PLL0_HIGH_THR_M0		0x0024c
+#define CMN_PLL0_DSM_DIAG_M0		0x00250
+#define CMN_PLL0_LOCK_PLLCNT_START	0x00278
+#define CMN_PLL1_VCOCAL_INIT_TMR	0x00310
+#define CMN_PLL1_VCOCAL_ITER_TMR	0x00314
+#define CMN_PLL1_DSM_DIAG_M0		0x00350
+#define CMN_TXPUCAL_INIT_TMR		0x00410
+#define CMN_TXPUCAL_ITER_TMR		0x00414
+#define CMN_TXPDCAL_INIT_TMR		0x00430
+#define CMN_TXPDCAL_ITER_TMR		0x00434
+#define CMN_RXCAL_INIT_TMR		0x00450
+#define CMN_RXCAL_ITER_TMR		0x00454
+#define CMN_SD_CAL_INIT_TMR		0x00490
+#define CMN_SD_CAL_ITER_TMR		0x00494
+#define CMN_SD_CAL_REFTIM_START		0x00498
+#define CMN_SD_CAL_PLLCNT_START		0x004a0
+#define CMN_PDIAG_PLL0_CTRL_M0		0x00680
+#define CMN_PDIAG_PLL0_CLK_SEL_M0	0x00684
+#define CMN_PDIAG_PLL0_CP_PADJ_M0	0x00690
+#define CMN_PDIAG_PLL0_CP_IADJ_M0	0x00694
+#define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x00698
+#define CMN_PDIAG_PLL0_CP_PADJ_M1	0x006d0
+#define CMN_PDIAG_PLL0_CP_IADJ_M1	0x006d4
+#define CMN_PDIAG_PLL1_CLK_SEL_M0	0x00704
+#define XCVR_DIAG_PLLDRC_CTRL		0x10394
+#define XCVR_DIAG_HSCLK_SEL		0x10398
+#define XCVR_DIAG_HSCLK_DIV		0x1039c
+#define TX_PSC_A0			0x10400
+#define TX_PSC_A1			0x10404
+#define TX_PSC_A2			0x10408
+#define TX_PSC_A3			0x1040c
+#define RX_PSC_A0			0x20000
+#define RX_PSC_A1			0x20004
+#define RX_PSC_A2			0x20008
+#define RX_PSC_A3			0x2000c
+#define PHY_PLL_CFG			0x30038
+
+struct cdns_dp_phy {
+	void __iomem *base;	/* DPTX registers base */
+	void __iomem *sd_base; /* SD0801 registers base */
+	u32 num_lanes; /* Number of lanes to use */
+	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
+	struct device *dev;
+};
+
+static int cdns_dp_phy_init(struct phy *phy);
+static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
+					 unsigned int lane);
+static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
+					unsigned int offset,
+					unsigned char start_bit,
+					unsigned char num_bits,
+					unsigned int val);
+
+#endif
-- 
2.2.2


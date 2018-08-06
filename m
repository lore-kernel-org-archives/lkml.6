Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34925C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F80219F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SQq/zCEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F80219F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbeHFM2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:28:35 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:9435
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727583AbeHFM2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv29mq7c0ja38BStY4XlSoA6FxwQmKOIvOSjM3ItXGU=;
 b=SQq/zCEaSsoDa78+rK3krQ/zSkgJDzUze5pO0V0pBqjaJ1UkUIF4Rxf5UG9CxLo3DSSrdDx77hj4yUGB3pslCHt45NviclKqpw/nh3B+vELng5kp7qLrqhKN/FN1nxM6j/yW5RJCGd1lEDgN3Zlj6pXSG2i31nXtgAhwuV/ueX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 HE1PR04MB3228.eurprd04.prod.outlook.com (2603:10a6:7:1b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 10:20:06 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: arm: configs: imx_v6_v7: add CONFIG_FW_LOADER_USER_HELPER
Date:   Tue,  7 Aug 2018 02:20:55 +0800
Message-Id: <1533579655-5498-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:203:2e::33) To HE1PR04MB3228.eurprd04.prod.outlook.com
 (2603:10a6:7:1b::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e45770e7-e0ea-42a7-a22f-08d5fb862fb0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3228;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3228;3:O3QndewaCg+HHKkGBThxpCvTrfzSnWOJTwOrJorDCx0pcREQnXICUTIszjZszM/f/ou/CNjORp20OWAi/Fh+y14TNfmRP9EZ1i0nL7mHvPHYOTmPwmyI8CkNsMGgzjrvyAOwaMDonkxuenFGeYEcFs3NLnk0zu2BMPkeiD0zgg2FhUziRzynKelQKwZJwYrXA9g2mVokE3nViNKc8EtTaiAqMzizzmWrY4e5dj2SrWfQPNAR8facnFms0JtiJGlU;25:WNhhbT+2GbCizy5yV0FTXrbpnAQZcxHYffotF/0btWHVcNy89cfMsvrqWcgh+RLMu9Q8PyzvdA9dOyBCm/yV0FaNvzpQqoufzpVhoCjLaSpjGaXpBFPxVdWvP0FXo+GcSDAgt8DrGItZCvqYLMRSwzZYRSc0Pjiv91QIdeGqu5FCjmVUQXMgx7vywp2/d2bZG7484JHFSiGB8gKKhBED6eW/dpV50OJd23jNfrHz6fTz8Nym/f3/Ent5bxlifUak1SfXfdsXJQGGGbdR3ZfVkmKeXcMH5nLnKuZEARuIIlHYlWRrNAnTiiPf71DjCZ12If+lLt/RXN/VOWaM17Gq+g==;31:1SLp7ptfS3JuVTxguYMuXbxpv/BjPoi1HNyx3+82t8xvnz3eWZrCV4zHXskZo/+en4pTn+Cop68pAkFKTSUlnqu3nSSUJtEvLYHyvK5+vAVe0/kjzL6UKffnt+SAJIB+CjVmTQhtwlmUzzz+Rn+3eaj/FhIaoxD+Bd+33FnVPyEQ/K2fmg48iHfSwfuSzekJnPArd3tpWOwQCXghIAGJuDsJFeglqrW77uQluM/AbSI=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3228:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3228;20:fFVbaZNJvKN1hv/9fVnEwrugEHnPf1fz23YKrxaV2wEU82z+nxSXyKOKB5tzqBxWumdiqNu57z7Cfvd6uzH8gaBoMaTUkg/dlmvRwOnwL32rZFwQ4Lo3tXM03PvZzDbL+BXXAj+LoerQBU/HOnbnxIm0pfFuu4lMD9RS66thIfo6kUzr7vuWsKfhVlp+QpqJxuxDuIRlOTL3f0PNZWkl0WlWVDUzzWkP4aGw/cqabhgcHu4xcDY/MivvynhxLqDknaGSZ2BKg2U6mYgBjPKqJduVYnJE974sKBbK9j6wohUEcxqry9X7N6MBDZPFCoJQMA9o89vZQoT9OIxmAP/qv4BMyOEy7IoGItuZfz/FzP1L116j0Yitf0Y12kaaWXOUFsbSpAtSZ0dUKEeIZ/2rD2PEoptLfPC4Nz0kH8iqLaPIOccUfpKn3k59MKMKyN0HP4ZeV7vyk0id1yVy1uyyVXZ0TpWYDiatnLVjzeC0UYfP5S+UXogG25BXOETBjKK0;4:KNsPEZxfncqLapFcQHLbsIXoXQI5adJkFqBPMts6PslEmJisakakxBjrjLuAApK2uYbeKvlVA41qixWOSmHGWmgX4V9qc/F+7LposRfRljklZwME1M0XFjGBEOsqUF3cC06uEKxZvOkZRtAg2izVCMl317w5p7/fLAQKDy/icGa5K4S2vtIzL7uJIX8vq5EpTBrhyh/T9mvspHaivRSHN6e0dIJJ4QIsp3TySUzs7wpoRNlLyLB5IxzQl/vgU15EpihVerm0x3U/ofuc4TBAYpeEez7yJ62j0OyRySHjtBtzC9kC5+t6LOM5diCQiU96OoQI0dtSh8UHu61e1R1aM9HRucvfhThNUiIKfPsq1Uo=
X-Microsoft-Antispam-PRVS: <HE1PR04MB32283B13758E9FF1FB1A8C1389200@HE1PR04MB3228.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB3228;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3228;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(26005)(16526019)(2616005)(956004)(476003)(486006)(6506007)(186003)(47776003)(386003)(25786009)(66066001)(4326008)(68736007)(50226002)(53936002)(36756003)(316002)(16586007)(2906002)(50466002)(48376002)(106356001)(105586002)(51416003)(52116002)(6116002)(5660300001)(3846002)(6666003)(86362001)(97736004)(6486002)(8936002)(6512007)(966005)(305945005)(7736002)(8676002)(478600001)(6306002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3228;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3228;23:jv2bhm308ExjkWwIqSeoVXKFw/xMquNVHL1QzL3jH?=
 =?us-ascii?Q?HryZHlEMGgAaRwabRl0kx86K53Rc9ZZlMruflTEyTa+vt9r/jLv33qPgJvHa?=
 =?us-ascii?Q?uG+UALgWvM8GSSDKxnF7UAn85V6xQG930QQnJpIKKadSVQyYyWfmM33eMEcU?=
 =?us-ascii?Q?MIUWITd723ogS/w7pITsFjTcakMgJY8QQDEza54a6YpLNqeFu3I4rX1OZtVA?=
 =?us-ascii?Q?Jl9YJtQPICEKpN9/LzvMzTHNr5VDnzGfaBVJb/PwquhM6Isd5aIr3WVLg+J0?=
 =?us-ascii?Q?6ptp0bRdHM5iwrMN4RPFKb45fEwZwBxgSXDOa8O6tYlS+ppOzDcmn5/s7Rnn?=
 =?us-ascii?Q?UfTZU1ggSKcHaMZp6sx2fqC2Ey7j8ZO6jdO9u0WmYxLFUn6GsWvRtO095dmc?=
 =?us-ascii?Q?mBxoeb+NLRov18qGKNg1J7TTMUD7/cwbXeu2SjaaWPJZ1OlmaCGP5N7jvRg0?=
 =?us-ascii?Q?0HgzshmRsy6G7IKxHWP0U4xQI0XxnAvczCScW7sKdewmaaxKYzIcDANx83zl?=
 =?us-ascii?Q?SmH7tMKodL1pZAYtFGI02OFqSfM2LqVMpra11NGi2r+0zxpff9KkrOnT6T/Y?=
 =?us-ascii?Q?GoUMaBamLC/i+P8lrfjpKBbPOPEG/SgDxjN/yLH72hOSO0lqKqLrqYTIEs5a?=
 =?us-ascii?Q?kNX0oqCECk4+C+7obkCiCsNAETYUTjvbgAToKc0WenPE9YRoLu0wsxW3oAUj?=
 =?us-ascii?Q?dSmUhCIGhgYTNaiGunh77F1XHXM6WT58UPlFJb/8oO0NonIvj1qg5ZDpkvDJ?=
 =?us-ascii?Q?5vTHHAHzKYFJK6iDPfD7Yf5ukKSnxVXw/bEP/y/P9N9P66jAZoneDFfdBhIg?=
 =?us-ascii?Q?A1mxIPOYiA1VF3rTBE2cJ4S6E4v8/G+AHacwZPSaeNHsWQScYcCIKVzuUs1L?=
 =?us-ascii?Q?OJBymxGG8Dh2OKDpaTVbQ0AUJZ1KUfG261wUE09SHBBkRKPWvGweBfJf4HXt?=
 =?us-ascii?Q?IzTBGvxAxJv0NZMAqPkGRznIFSrmZu7Bhi+PXc2XLwSut7v4TRl1Cc3f7B5H?=
 =?us-ascii?Q?l9oIq+hHY2PrDb+uHPJz5m/zhihAHQS8qS7H5mdDEee1xrRLsemIjUGMptf0?=
 =?us-ascii?Q?qz0XyQIMZN/cylJeLW05swIiNcT2z51jV/5SsyXVvodLkj5uDMyQ8F+kVQkO?=
 =?us-ascii?Q?oJULzOH/Jc=3D?=
X-Microsoft-Antispam-Message-Info: Y4rRgAV/ejikpZbhy4vjTZ6U4fCNsyKTB+eMHvmEMChL5EO6zrKZ+wsbTAGgF+PBDP464EC85pbVTiDQlZnot0wIqx+weFY7XRXGBgyuzq13C5nSQ7kTqt3Qb38SqNHvLlY3Hhe1qj+qlwW6dFAfLseDa3BXaHoQZCvXnasKyHPwe9876vsyN2M4SzW71y8GTGIf4QcD0Csvu+G56p7Gw2jvxqKotxoaVRmqQwMyi9N6Jlcp8GZ2gNW7hhtBTFINp9z9DAPUKow40pz1/uOrk8hBIa4XJYreTyCU5Bx2hcQnCGZCWbgzT0kNnfMXaEo58IxVDepRTr8suzinUbHK+U5Qnv2sD42f7cMncDzfX/I=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3228;6:tDkWLOLAn5JbpcYPiPtZR58RixLoFCBhdrM6wcagLNlKvFNoJ1lCyEMkNS4DRHWeunzLX+ChLRHDo8c3pVhQqqcvCX82a9rSshYWAiXz2qrxH4Klbz+YWSs00sGOKvaTa/5BdXl3Tsr6q9NuChR3884sJtnxK+8R736mjVur5kVxdzJoy0WN3hQktBuCCULeiv1hwq1poJK1wGYbQFUUwltu3b/7iCNE4ka3g492oD+YMSMRxJmmaoCzhgB0Acg3F4lGBwf+JE5XRaUQoS/4EjAnDkGnfVfqTB2scLlC3wi0OW9rzNsw6EvIvPLQBz4Qqq7rfEHT61+R923NKhzpd0kNF/THZB4o0Kmic2ol0VGlqQ3/gQ4z7tKZM9avFgwBoNiX6hjA3j7uKOti50aNXXbYItKL8QVnGDD2Ym1r/olR4l8dDtzFv0v2q3nKLw3oOGqKJSDWvQnda1cI6nL/eA==;5:pHhO+oy0h+RmfZm/wMjgVnDNwsf/kUYfuDyvDSN3/51OYdZ0F6x8bNoAGdj1/mY8LOeHnRpBns58zk+sUfxQwKnb2L0q4R2p/dbPNytaVE3BOwv3eiB6+48laeliBKo4zE03mm1uK1voFZTx+PKtILU2pt76Wpq7tLEgn9ExIV4=;7:BLP+854Rj9S9b5RWjjIsC9adIkN0WWsoQw203LPoekbFb9JtAXjiHNZeyUsvSuz0L89zafHxjdkhoi4cPTgI7qB9LS/Q+V9TGB10/dwob7XAhwUhD34oiXOImnQ2Dvl8RvhYj2w4IPn3Nmk63RTp9930ewvyMTBLL1O/fZYk6Qn243mZn+XRjndz9yy/ttgDooBodHckBZ+EVyC1QlefVx1Ea7839JskdW73jNW9jxs1WmYP92KV3UH9OjKpixgP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 10:20:06.0038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45770e7-e0ea-42a7-a22f-08d5fb862fb0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support loading sdma firmware automatically from rootfs, enable
CONFIG_FW_LOADER_USER_HELPER/CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
Please get sdma firmware from below link and put it into
rootfs entry -- /lib/firmware/imx/sdma/:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e2c1276..5e35d7e2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -90,6 +90,8 @@ CONFIG_RFKILL_INPUT=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
+CONFIG_FW_LOADER_USER_HELPER=y
+CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_IMX_WEIM=y
 CONFIG_CONNECTOR=y
-- 
2.7.4


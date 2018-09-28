Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29200C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42D020779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YLKeyUNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42D020779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeI2EoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:44:20 -0400
Received: from mail-eopbgr720063.outbound.protection.outlook.com ([40.107.72.63]:38913
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbeI2EoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JctSCkvnYuQL39hO7em4L0sjDjD8xhRaTURJ2wgEFXA=;
 b=YLKeyUNlOkW5MWVcjlgGMfGqaoh8egGKkelt4RTP5oit1qscvo8cV6E1LK5F3D8JaL60VYwguMdS4IAWfdRgLwvVQBV1d8yzEeZcybTPUmT4GTyaNlEnRRIKlrGzYtiOQAO/jMUlkeIk5i9oeFK25Y9eK8Fxwxut2fpoxX2HXYI=
Received: from SN6PR02CA0025.namprd02.prod.outlook.com (2603:10b6:805:a2::38)
 by BL0PR02MB4466.namprd02.prod.outlook.com (2603:10b6:208:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Fri, 28 Sep
 2018 22:18:26 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by SN6PR02CA0025.outlook.office365.com
 (2603:10b6:805:a2::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.22 via Frontend
 Transport; Fri, 28 Sep 2018 22:18:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Fri, 28 Sep 2018 22:18:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:38999 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g615d-0003vZ-Em; Fri, 28 Sep 2018 15:18:25 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g615Y-0005vP-Ag; Fri, 28 Sep 2018 15:18:20 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8SMIGpK005849;
        Fri, 28 Sep 2018 15:18:16 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g615U-0005ux-8k; Fri, 28 Sep 2018 15:18:16 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v5 0/4] drivers: clk: Add ZynqMP clock driver support
Date:   Fri, 28 Sep 2018 15:17:56 -0700
Message-ID: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(106002)(7696005)(51416003)(4326008)(72206003)(54906003)(110136005)(478600001)(16586007)(2906002)(48376002)(6666003)(316002)(50466002)(14444005)(107886003)(5660300001)(2201001)(47776003)(34290500001)(356003)(81156014)(81166006)(336012)(63266004)(305945005)(8936002)(50226002)(36386004)(8676002)(426003)(476003)(9786002)(2616005)(6306002)(126002)(36756003)(106466001)(77096007)(26005)(186003)(486006)(44832011)(966005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4466;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT055;1:E+2xzXU1Sz/hmTEbV4HNGFelzCm0GsXjx04h+MWxNg5btxfkk25t0CkRZ/YByx1bJ2JEHNh/FT7Igbfcyq2VsSbyen68tsUt2c1e2ukesboTcTjIOMEiVajI2QSYD6h4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eab2977-4c26-469a-1a8e-08d625904fb7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4466;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;3:mexYokG9GRcDzEJwpooQj0BSoCNkaSopoSBezxOQTqE+IE5wlqD6XD31EUb6mTNZwtkvGig/mWeiWWGxBB6SfLrkdCnggc+ZtcBISh9Dyn3UnUU2SYNSsS/AveO5lb4zedk7ZZDJt/TtXnLkbVsgEUawVGDG00K/RV0vm1Yv+xQUe+lOfw+mYARcwD5Z5ELjU9gM15TN7Ukc5xIsH6By/cc/xQaTAn5MGYh0jQy/S92Zt3huQEnSnqrm0Ow57TiX6EphBo5jpbXr+lDh/Csz1H/jQQbSS3+SVJTTMJsP1xzxIO0YkbUjfaxJsXlGREXPQAxPZ3MjFKEMR+fP8uVtuoqlDXLAOCNeyXdiw24jbhI=;25:8cbJ6KImNQTTJYrX4hf9IuwsfXL1zn1fivZjxx4g+CuUG7MQR0KjXLKFjJbfPIriR9DngPQIcv4x0AaGYZALEL4PQjeYLQYXUn+l31QELKfT6Bn+PVRL4P4OCjdjzsMrUi1KveirhoS3scywW6ldeeeMQd3OcSnigZp8yjVsqGG3xeHCPI6MUtnl5lN5UircunIpjtutUeApME3v87RDhPyberxXL6as/rMnIyJyC0/k8LKu9hKVH4NreZvsYuTNhCgMTBXKNLrrDz9MJ12C78CsuQSRIctl6Rt1VedQWHRJaBZaeVE9BymzJ5bG2kI/zYp5PnKFCuMP+AuCauwRpA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4466:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;31:kKiPb5NLx2a8z7ttrn0eXSo3EGW2NV+ICkNVbbfppoE3Qygs061RWzRoPc/fCKqyqNMPBfTO0W3sde9PC9mbJ2FsayF5m9reOTAtYtxFKNRkzzaW5sKBtXfb5Py/aWq0d6cc7x56qFZlA71prx/Hwm42ApXLGO1jBfq/sCpIBaE/wB2mpzRE97IteiRhKo/5dNWuNlBOIE6ZbaCrjRdMPF+GGXL5at1YCTNprRW/gYA=;20:724c8Nm7MWutLXuoybiChPxcYaE8+Wr7gzI7CSgXnh9RXrD2TObxoufe0LP+8vZxD2UDjMTDfLeWOLgZ0PxnjGM8qS0hTwKAMq8cfGf2/zrTL+gXUegfduCnv49abKJtiIqzWbRiptaCLDIJjF5x+fdqBKXyQVjiH0R3biLw7U6G1XoUT6EdxZRgcMjIxhJUlN7uRKSUxTtNmDA/gu0zxSjyf3oMU/8Y8RgzWCnBMqCYwbJloB/KZzyJMxhecp5OFScl+5pN2o77vxUlCAeW/dOIlso03oW+sgeKyIwDmHTUNJsa+MhgjyPjxcSM3ZDHzwaO8UjSyEv0LTb1v7ResG1NS6XqHR2okULvWO1c2RU1EMTdZWbMyhBKQezAL9W8ubM3uM0AQZ/L1tl3n38rnhZ8C220j/9AH1dKl2ajmsOIYw20PQm8s4Mv98A6euVueeWMf1KWsCoFM42bCK9+geqGobkihXspNQzkUIfnnngG3j0jBgegwc8yhPCfoKA0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4466791796D91B3D6E9B12C2B8EC0@BL0PR02MB4466.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BL0PR02MB4466;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4466;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;4:l5s7jLy1VUr+rlsw51i0NA5zGxnY8QPn16lnGmsCyCyJYai9h9gC3X40fdU1DIibQ7HcwjFTNDx42QRBdXSUG+anAAP0IyYIds1We4nCJaS3RltEVCRwdZIpSRpUMe9fEu5na1ZvTHhLzSitpkLuhREg6N+exLWUv1Y4dom1+FEf3/kbeeT67zIDVXH/JGzxInOoswySogiWqclZ4fEiaAwfo/w2RYcgoxBMxAggo8sDx+3DRB0lhVBzfSEvos726xVLLGkQwNLvJAVOqwTVk92F++tViInbySdj765OYL19yu3ssnx0tt0yMzpJgWNZ
X-Forefront-PRVS: 0809C12563
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4466;23:I+JprBBu4kmL90+S8laaVgbZlamR6ir0HCbjfwGzo?=
 =?us-ascii?Q?9g9ZJyatWUCENPeU6dWgx0Isny7u91Yk4DgpyqLN4lywAWXO2EJ2QokWhs2w?=
 =?us-ascii?Q?RifQ875U3BaiZvMULzr0RSyJ5f2NfWJ8q8Zo5ZfPQsxEOzcpcfrh2fEThMs2?=
 =?us-ascii?Q?ToC2598GmC2FBsDaKW25Xl8/ipw0/SmGj21b98umoq1ZcG/nIdUxea1x3QiW?=
 =?us-ascii?Q?olYuAL0xbNCRfi7kjahUjtriGh3+8QTXkX559RvtBIXj8i+tpi9mIotbpTDo?=
 =?us-ascii?Q?2LH64d86TNv/RiRbVhOfSu/5P9EADinRYOkQRhJDt/EBsmF24kK3/Opn2MYc?=
 =?us-ascii?Q?dQQWFEy8s/7RCfvmW9jD3C+481nA9R4byZ1B7UhTiThtNwbWIYpyzrWU5ABj?=
 =?us-ascii?Q?v9cDN3vR1rOcWXCJoUkF6uM6jeHl8XZISsqM+RH3OrJvyB+IC+9qBgCWlHkd?=
 =?us-ascii?Q?3TDEebrlghkw3V2f/A8/gnbGeSJAwwCBmzHKzxQwRacHBTw8l3PwQ43mMxbI?=
 =?us-ascii?Q?G0zxkuUom/6KkJoF8URG0Yv6VtPJYvx1yH5nv6w/ROgrY/fnJ5eK3kW5VRPs?=
 =?us-ascii?Q?Pm0jGqDJuO5YaTTrVzV2dpyQ0TjPI67gfUUq4hRyydzY7K2CzOwzIJscZNNz?=
 =?us-ascii?Q?VyVW166NyemMjVfe5k6hAClwsvuaHF8HFviynR0xsqLBJPfkjeZG/QU4zxTF?=
 =?us-ascii?Q?cGtiw+ShWsXPj/g8ix4OCucIvhPim46lsCzi2tRWT8soCa9VQi22q+ssmzBm?=
 =?us-ascii?Q?uGXCxCUnYe5/g+Q8Urk4eTijyxnCgIeT7b3QCMTexqUxNeeGvBo9cJ6x0yTL?=
 =?us-ascii?Q?jAZ8+kx8nGmwbiKOOryLqGJ60OPYaTSiLY2EhLfwx2yQxy1C81pgdV8nDkCZ?=
 =?us-ascii?Q?ib2Q6WvIUeTv2xWbSR5zRpveCv8Ub1s8kS/TX0ttOIvLpLu1jDrWoNJHZj91?=
 =?us-ascii?Q?HQ2KB3K/MlLdErWE7s2uLHuLbC49VhinF2MUROVrDfgCVFafO0Jwtl3ez3uh?=
 =?us-ascii?Q?htsdwX/u22tEpkRsL1SfZnSL0AIuuZP1xj+E23frnptPSgoO3Az7qtPNLetC?=
 =?us-ascii?Q?3KEpWCYDjqQsN8XyHXbcCbZeujMcsT5ANqyv8gdO6h0BODP12K/m5o5vfI6E?=
 =?us-ascii?Q?h1zXv2x7iafc70b6MnUoB3yL5dBRkmwGkWa4bo25HLB7GBPw03pTZBnatv8L?=
 =?us-ascii?Q?2ZMKZnJENZ8hyaHDbXEd7XT88AEtgDWX/zhvc8Eqx9Tb2ni31DvDHSVHw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: c9BC62DLsLgMa+lgIoMbSrWRj8GNvJHlNMvPK3ycxMaP0GPVgrpNbdZYk5DrJ7meiTgDZBfHh41MacbEtVdxdyHKbgvmxCATme0AaYe0VZepifgGskBFvLXA2MC0VjNUDBWiEJHyDtrNyxH4eYoqS6MWp5yXKSkivs8kga3IEEoaA9vDIJ8t7/ziv44/wz5KkXybK4019atzzGHVZeCpd1x/0V8hc5yO0u1YA0LXic+WAyemCRtNVUMdN42q+RH14lOaT7bIkQn2eLD755wS3HLYU8fUiC6UDwZx7+tA5Hl9egXUq3SvOPoMTexfKqHglXSlClFN80q6eFkaMfCHvQb6Xsgq690nECkEpckbEIo=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;6:k/nF9pSKCsaee0TWJouV0PjXq8vyS1Vos/mSEgmAylajO6ldgUZWIRl3NtBSwK7oO9GyeIKdxZWBWWbeiESzXODvK/86GJwDOScL1kmEQ9M0jKXxN66T+ru/LU+XWwo9dj6cVP9eRW4EpBdE+urX0/k8s/aJZy5nH2ovowmTZ/spUNZC52re6hmdEo+6QB8w7KFluh1Z3YPuOo0HeQc0SVLiPWIBPCEqiA/FYYGIDCMWZEa4Ntv3APZHmLyrfSRRHK4ZNiPVoqyNqlJHWX5Q8hEozhfDQVyIyqNRn3xeoUFsBQoRWXG0UAiaNwrMnS4ziACjQH1eQPMZvAL8Q7htYo4D+m/ZKgO9TFtwH2d0T00IkAIJhojNp8Fuq7ql3sDLd5kd64X7v20T+7BuanpBKsvvAJu7zhn5Dp0WA1bd8xTjsbabJGQFp6VEpv5bC9IX4S1IcxlfWzV2Ne9K4VazIg==;5:aSO9fGvLfs14Bf2mtQm+YEKHMoN/dDaOYQ9X4eRdjo7834S5gj90W0TARbi8uy+J9PYQxPWT394kF5sxsThU8VrWfiJUCCQrvvzyR6qnn8MSnse96OY6+62HQmoYBPsxax0s4EgTa2YTtFzH2D07wd33UwuYMiXtLbUCnBUkr8g=;7:nGPAlLW2BLWlZUEfu9lpVs4fUL4Cl/5YLmpVDBhH8EjKLrjy/2Ij3FaR8ffBaqU1SO8AsI7G8d4oCOMCG7RzyhCkE6Ck4gpCEJnqSBZG7lSE5pyK7MIXsE+1cP304QAwFVazgtcM5ezk/S6riMbYCmcLup16WVKLMFki6F0oTqt4eM6EXdUX/lh7h0asbqN+KGilINDc0eFCLy/X6umAGnB/Q0ES88Kp01KjYOt7NjA4CVkqxxGOvnPcj5qI3wrB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 22:18:26.0547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eab2977-4c26-469a-1a8e-08d625904fb7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries 
supported clock information from firmware and regiters pll and output clocks with CCF.

This patch series is earlier reveiwed as part of FW patchset (https://patchwork.kernel.org/cover/10555405/). 
FW driver from that patchset is merged. This patchset contains only clock driver and is based on top of 
xilinx firmware patch set available in below tree:
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=next/drivers

v5:
 - Added "Acked-by: Olof Johansson <olof@lixom.net>" for patches
 
v4:
 - Fixed minor review comments received for v3 patchset
 
v3:
 - Added check to pass only valid ioctls for ioctl eemi api
 - Added eemi documentation including ioctl details

Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (3):
  Documentation: xilinx: Add documentation for eemi APIs
  firmware: xilinx: Add zynqmp IOCTL API for device control
  dt-bindings: clock: Add bindings for ZynqMP clock driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++
 Documentation/xilinx/eemi.txt                      |  67 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  10 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
 drivers/clk/zynqmp/clkc.c                          | 716 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 217 +++++++
 drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  42 ++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               |   5 +-
 15 files changed, 1919 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/xilinx/eemi.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

-- 
2.7.4


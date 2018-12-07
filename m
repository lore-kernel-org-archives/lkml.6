Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF62BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8DE20672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Q8SYU5fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8DE20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLGSgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:36:43 -0500
Received: from mail-eopbgr820048.outbound.protection.outlook.com ([40.107.82.48]:14880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbeLGSgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vWceXySRlVZwyvITO9vZWdEyRW3Era+K6ujUiSljWU=;
 b=Q8SYU5fvUu4XQc4na1ZtCspxFY+qqLSOArZv3OfVWzUU3/DhLTwbC7UZMEnOS6wYR1DXA99uS189tfwaK+Q7LrFxWmkGAbMP1sbt3MGGh63mAoFX3NVBKciTd0+HmNTTnCZzJtdkqrvwZY26mNtEQs6FE+WG+5e83kM0+lgjXtk=
Received: from CY4PR02CA0048.namprd02.prod.outlook.com (2603:10b6:903:117::34)
 by BYAPR02MB4326.namprd02.prod.outlook.com (2603:10b6:a03:56::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.22; Fri, 7 Dec
 2018 18:33:47 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by CY4PR02CA0048.outlook.office365.com
 (2603:10b6:903:117::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.17 via Frontend
 Transport; Fri, 7 Dec 2018 18:33:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Fri, 7 Dec 2018 18:33:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47464 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwX-0005fv-QL; Fri, 07 Dec 2018 10:33:41 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwS-0001uC-Mq; Fri, 07 Dec 2018 10:33:36 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwP-0001ry-SN; Fri, 07 Dec 2018 10:33:34 -0800
From:   Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] ASoC: xlnx: enable i2s driver build
Date:   Sat, 8 Dec 2018 00:02:38 +0530
Message-ID: <1544207558-72508-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(199004)(189003)(50466002)(76176011)(7696005)(39060400002)(51416003)(106466001)(26005)(186003)(8936002)(50226002)(8676002)(336012)(5660300001)(2906002)(36386004)(81166006)(106002)(81156014)(356004)(2201001)(48376002)(486006)(316002)(110136005)(16586007)(305945005)(36756003)(9786002)(77096007)(2616005)(63266004)(7416002)(126002)(476003)(446003)(478600001)(47776003)(426003)(11346002)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4326;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT027;1:aKBoJ14K1aYjfLsYEtFui9QcL7xb3tTC0ixfD+l+0/joCQYc/hinCD4wfzfEKjtx/rLea+9pGVqW0Mo7qcXsnWY58GA/xN9ydqnZkbzTNHrssoDB+Oskp6q1hmAZN2a6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d8e51c7-516a-4792-dd1b-08d65c7285e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;3:dory7lSFo3iambXezml8qt76CQjsN0jsKel8Gj/2p4DhTfqizACey8UeycsIMt7pPR9ZaG3bIzm0Msgd+pb0+CWfjVcQ+QKHRW+5Q2A8KngtABI/8uiuvcSw8csw38wu/p+NFQtRAX8GkZH6ZYDnLq4FzaIss7fMUdRlPFwYN3898agB4lkrae2QyRSYrBZVX7ISN3eaWqPwrV7fMS8HxVS8WBqWaursJtP3/neCp5t0Unv06D6IRZ5uPIJSbkRly2bWMjZ1Z2PkLbQQG/gghQflF+2KZntZprUCpRlHU0dkw8P2cYZaEoeALr0ODhit8K6bw/2/iyLHAEOyF9AYdOnRBYxzVxzX6bgyHGqrLq0=;25:deZm7xSzXzUNuGfwh8ReevsmJn+GmOHFh81Zzf/9tdRo/3yHg7w0dPhj6viwaoLyWi2xe60wQm8kKVtTlHAmu/bGjMiOoaDITb5Pdq4om2y4wbmwcOG7A95yJkcdj3/cJ4/omaolZgNAI6UCH3QPADqD+R9sPl2dkAIst/F2mxCCKLxRFTBe/tcWEfve5ZIo2yMD4k1mZ5gnnocmwdwLEyd6B7mwfO6sJJL1ckS+F7CQYuYmHPkKKxoUX622cifKYrBwyuqPVOURgSseQakfNQ/GhWliS0uKiKl8kQqPoj7EM2e2J4n27yS0NuWTOngVHifzGru/xioU3Wxbivy3vw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4326:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;31:9Og5UkXN0xQnjLglUvtEkWM4CNoQ6s9X+/bbj4D4jwF5HtJLB0mN6nb3dSmOG5+GjArdHmNqgO1guM56Sflou5J4p7tsCthEtI12/mTt8cYgeEEKaYbbhPz+sgeJuNvvjxy3lgErmJ0ja3t13z+34g1YhoDNLDF6q/U5GjLHT3YFH3pFAMrgDFJLBMZJ2HDWvUx/PN5UaTaOboNVtuBnD04eNxWoiuUPnzt+ps2zI3c=;20:c5mkeNfEz3b3HmILQiCmUdK8ZMgbShc6zY7Kf8aSP30C1Rw7uiatG0J+GDl7R07OVGe8yjNcpBjyHooOWDHpNDg9uMKMCWupoL6pkrDNNEIV5EMX47r7DJWdudvAAKCEim6iKOvnu9D9a3dEjqFhvKg8FEGCmgM+Yn3r2j6JE4ObkPeVV2tT5qN35STuVkd+MIbRmxN7+Qbq0x+GZyWles/KvWj5/ZHPLPzwvC/LEPhBEAqHBDWme2i1tYiEOV6cCcE9Gv234MsOvfTubkV5voMjC8eE0B23LfEVRobTjVz9uz4N5f2H8OlQywFPlodm7j3IqCwQ5MGCpzEgGs9Nt9/T0rUuRZyvgb+VkHP0LM/S/zsMQwnviZGAAclH9DMhR4isBbFM5kUDE1IHJgQpXUpnDrRFgj11iN+qKII4xhZ/fz0MCF0xt1HWKq2iYyoq9DqqYfMVYIzMX/S+I5fAVgdlb52KNlbcvclxFcfyU5l718bSzjISYS5j5+WhzL0p
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4326FA9AAD6622CE226913B7BAAA0@BYAPR02MB4326.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4326;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;4:9gDXXwJtYQHwmGI4K9p3roSkZQU5R/xdiQNvhBz2GNCDQRtjr066VOlAWXwUxBzb1om5uWttNitgsb9OkjVfNwEqFn1uXXYmmr4BTyNUMB1A8Rm7kN8khYzf8MOlGMoBMeaxn+LvIJa4l/brjvJc/5CPhfqavL3+prNSYXiDjwsdAWj6Yuuw+0rC0Sb1hKMUubT8LqTBRt+39thdTBxsovwmXlQ07L/4IP/rZPFylBS86ECQA+fw5+XMu4Fvb0BWGPrptw0iy0FqZQ6UqiUgZQ==
X-Forefront-PRVS: 0879599414
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4326;23:35d0jBPmZJaYjjXxDPMWjx+d8py4SWwVh3QWePZQc?=
 =?us-ascii?Q?qXyXh0mLl0V+hRfbBH5yc4Iu/2Z1hFgrX5GCxhElaiMitNPHaPYo9AiFExsA?=
 =?us-ascii?Q?vOw0gymk6h+janv0A1i4p05ZEIPHK0AY9AzgE8jsBgFI9NXsFv2YKyZrO9+P?=
 =?us-ascii?Q?ZVgAXVFgyp5PW97ZQ+KdXkOOM4GjktivIPP0HMOXYyCbbv+2rcxQ49KO0k1J?=
 =?us-ascii?Q?UYlNc5Iyq8fN28VDhlpPXBPHr7+wY20xxGLrr2tk/8cFTaqkkmn6m9+poM2K?=
 =?us-ascii?Q?afAahRRy7sQ6HfTQVHr8qldZ8cXt1d2i+9YNTYgvrvyNgJIABbpBN1dn6QH9?=
 =?us-ascii?Q?ZDG5Pl426fvPn1kZuwMKYpkzk4nymBbiUWSt3qHED0AEieI6ez4S+9c7mRhA?=
 =?us-ascii?Q?t93cqDgNOW4Ru8xWkqT5SfXQKz55KRq7VFGAhITRAKzR7Ii7bG88XWpA7cD7?=
 =?us-ascii?Q?VbEN2cEboZwBJvoPZooCXXggu/gMafwFDIdfruME0+Q3/rxw2xzIerKDLUK8?=
 =?us-ascii?Q?KN+ppYav68gc8ksXw+bdy+EQzZncw7N+VWXBWme5ylsfmhJ9pUfVQjr0omjv?=
 =?us-ascii?Q?wcQfaNrg+K82uLCZnAzMNFiFWgnsgcZN+lWsqiU3js7/AEAeErTKa4blO+Ri?=
 =?us-ascii?Q?+8spQy1xZPBPB/+KDEslS1RmFzVdK5TfAZEp5XYoGHHPyU2AlQPnIHoUamiO?=
 =?us-ascii?Q?KOFPYjetBanecMesi/jvNw6Ng2aoa22BjlAOwrvAdmDxX8Y3dfdEqzGktEWa?=
 =?us-ascii?Q?JaKLoO3WIBo+4XVHN+/UCnxuKcbE5dw0VPZwu1AioCq1blawBlOfvCEUTf+I?=
 =?us-ascii?Q?MGaSEYJskKwezkx9PIxyaTV/6C9T7A6NBJO113FdLvodMq3nHgMDleBYieT+?=
 =?us-ascii?Q?755VN2COmlZRe+20pu3doDZYTbAyvJJKY0JRzbbXFjwKgDPvWiPkV8qOGLpi?=
 =?us-ascii?Q?nWFtWwWF45CtQRKCo3+VwQDSndXEPCigGbU3DXIGF+OB3QzE4MJrs6TomjR+?=
 =?us-ascii?Q?QpfAUtnq5cnAFLoOPLcuKqPvcB99mGV2E7NoBxouGcx8t7bz7NaK387qCf3V?=
 =?us-ascii?Q?wIRA39JOJ7PiUKE4CQZxNlWSuZwZQ/WG5fsy3vhcSiSF/Q+odf/GgexEmVJi?=
 =?us-ascii?Q?xNL8MkFTJ+eNYsPI7wkMYU0JeIji6Nq?=
X-Microsoft-Antispam-Message-Info: klY7WNVKPK4ZeG6+IZGrnTOs5a+LIttjNzRH45RJT1sNQA/kqLIPDIIuhNJ5HsffvL3VdK1DF16+BIO5jsSyPVNbaxOYcXCObbYLRQ6jPi8VJJXjOBaj9fGC8eJTclNz9/dtHeFoEkg0bBTSy4HWBIkRO9HlnI5fVgrzBwKGhR6MYZEhm5XTEAx55Ds6hyTkER6ht6rs04rvf/O8uCqpjnYhUcHmL77m4G1Ehh2EgC1KnZ+uQAhOYHCfmUXqfqHkrBKGH62D9AP/Ll+Ux0T4iBLI1thYYMYwIu+nBwg3bw67IaZQhioIK5vDvb9aYv1CyqiBo9LxekVevkcIt4mGF9OfQrUJlIYOaNIhIzqRKLk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;6:HWO4NtUn257uFKdDGsLwRYwBijWSfMWnCEhICS83cPKB5v0JvMjJH9dlhg3Lb/XaMwEs66ftZO66TeVQpTHH407IhkYIcPVAH7dhKgyux8/I/HGIW/X6uDtlL42/pT2ZAERuJIdsN5RDrbVKluMqN0T3mx5dEageFvS1s8/O3mtZIdgZ2iyqvsZvahRcq4LBw+G0eAiAEBOO7SJU9A6AmlQ/6X0kWkZF2jJ9k4d43ZKjl9KBSZITaOmLy6Suer+FkJmFGpdPnUcDe5yRuvcQ++tqo8i+8SZQ7LOEnG7y8v6K6MgfSofcWpPNzj6KCawrAAp2JBdRKqpAlcg8Y4WlvBiQl3IEUrI8f5v08kWfMzMFsKSukZlap9fgyH6sVmXlvXO+V8MagFGDO65fVFclBPnCiJHJmthGh4kMj9vhpfZGxXP4bucH4uvA9bsou6gGptJWLNay9aUG/CGlz8X1zw==;5:ykTDPkfNhGZ5lt9QhG5sgDNTT8lXVmjSnkGqWlVVep9uZd9HLG/Fma7c4Vu2CSJ8ud2ua7EfwsXaqxg3p1bX3vSILyZV4JirgKcteJ4LQKl5p+CRE3ZOWxc4EbDsqOML3UKiydHppF0q16R89hO9nhoaVnWwngeCIBoYzRVGjGA=;7:fwRSf2Xxwo+gtVK+o7pOOpzTLb0AWOGreGsiS37mos9mQox0l4hIpBZWFLxw99RQaALw+DTnBIh1z0blvDeydc9NA9K7iZVO3l54sBbKUm6oOpCizV239h4XnVSc9T92jetrGry6EOZwFJG6hlJEqQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2018 18:33:42.5310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8e51c7-516a-4792-dd1b-08d65c7285e6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled i2s driver build option.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/Kconfig         | 1 +
 sound/soc/Makefile        | 1 +
 sound/soc/xilinx/Kconfig  | 8 ++++++++
 sound/soc/xilinx/Makefile | 2 ++
 4 files changed, 12 insertions(+)
 create mode 100644 sound/soc/xilinx/Kconfig
 create mode 100644 sound/soc/xilinx/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 1cf11cf..d21659f 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -73,6 +73,7 @@ source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 source "sound/soc/uniphier/Kconfig"
 source "sound/soc/ux500/Kconfig"
+source "sound/soc/xilinx/Kconfig"
 source "sound/soc/xtensa/Kconfig"
 source "sound/soc/zte/Kconfig"
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 62a5f87..aff7b19 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -57,5 +57,6 @@ obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
 obj-$(CONFIG_SND_SOC)	+= uniphier/
 obj-$(CONFIG_SND_SOC)	+= ux500/
+obj-$(CONFIG_SND_SOC)	+= xilinx/
 obj-$(CONFIG_SND_SOC)	+= xtensa/
 obj-$(CONFIG_SND_SOC)	+= zte/
diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
new file mode 100644
index 0000000..25e287f
--- /dev/null
+++ b/sound/soc/xilinx/Kconfig
@@ -0,0 +1,8 @@
+config SND_SOC_XILINX_I2S
+	tristate "Audio support for the the Xilinx I2S"
+	help
+	  Select this option to enable Xilinx I2S Audio. This enables
+	  I2S playback and capture using xilinx soft IP. In transmitter
+	  mode, IP receives audio in AES format, extracts PCM and sends
+	  PCM data. In receiver mode, IP receives PCM audio and
+	  encapsulates PCM in AES format and sends AES data.
diff --git a/sound/soc/xilinx/Makefile b/sound/soc/xilinx/Makefile
new file mode 100644
index 0000000..6c1209b
--- /dev/null
+++ b/sound/soc/xilinx/Makefile
@@ -0,0 +1,2 @@
+snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
+obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
-- 
2.7.4


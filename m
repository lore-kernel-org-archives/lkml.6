Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ADDC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF8F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tpTe0/pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF8F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeJXQBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:01:46 -0400
Received: from mail-eopbgr710061.outbound.protection.outlook.com ([40.107.71.61]:37683
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729390AbeJXQBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+HJL9M9zfeZdH2J17YFpkrfwU5G+gLlhXS5AWmGOuY=;
 b=tpTe0/pvenvFFLwp5CK/BdnLn8qAshywjXhMOKjFhOk5Z9DpjWDAyJ9n9IE+Us3O1o+tDM0tdvFmzcncvlRBQvx/oDCwbfcc1IT9FMR1TpnomNkvBuTpkTzavXopveRFDAq6xNkqqXn1nhp7vn2u92i4zCfulKsexlIbtT5CyYM=
Received: from MWHPR0201CA0045.namprd02.prod.outlook.com
 (2603:10b6:301:73::22) by DM6PR02MB4457.namprd02.prod.outlook.com
 (2603:10b6:5:29::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Wed, 24 Oct
 2018 07:34:44 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR0201CA0045.outlook.office365.com
 (2603:10b6:301:73::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.18 via Frontend
 Transport; Wed, 24 Oct 2018 07:34:44 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Wed, 24 Oct 2018 07:34:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:57074 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDge-0004Oq-FI; Wed, 24 Oct 2018 00:34:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDgZ-0005zV-BG; Wed, 24 Oct 2018 00:34:35 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9O7YW0S009512;
        Wed, 24 Oct 2018 00:34:32 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDgW-0005vF-01; Wed, 24 Oct 2018 00:34:32 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v2 3/3] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
Date:   Thu, 25 Oct 2018 13:02:06 +0530
Message-ID: <20181025073206.9264-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181025073206.9264-1-nava.manne@xilinx.com>
References: <20181025073206.9264-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(2980300002)(438002)(189003)(199004)(51416003)(16586007)(5660300001)(476003)(76176011)(478600001)(446003)(106466001)(106002)(1076002)(7696005)(6666004)(36756003)(110136005)(316002)(486006)(305945005)(47776003)(2616005)(77096007)(426003)(50466002)(8676002)(186003)(356004)(9786002)(2906002)(11346002)(48376002)(81166006)(39060400002)(126002)(8936002)(36386004)(26005)(81156014)(50226002)(336012)(63266004)(2201001)(921003)(107986001)(2101003)(1121003)(83996005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4457;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT026;1:0jgoAXtIjuvHyu6ZxHLuX8CtuiL3GgRqcVl7fvS6X5XJ3eOuuxImqZBiqX5OZsr8QHCtlRt350aMDtP/vncCvv8qfYpj1UMkaIYEMNw5mpGgHleWsGO4O/GUhEoekCTa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dff3600-0f83-41a3-cd6a-08d639832aa8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;3:jKyBoj3UJCO1SR+wV5k3iubYdmRF3hcl6EmwObBKeg+olOglNTB3lD0V6Y2dAye4TBIiBAOheeeYwkCA1kC2fKrmQZVfnuB+YrP8R0RyuH8Mq0bL0ho/gTOb+UllUapcnevyCFXlMHiOektHX33McIqDEFukbTGz+7g4qC+0Z26g7dWypH1UvUqO9GdiBmzIxsm2hMY5pmgCUGA7yzb4kZJikdeo1PMZlsnU5yMwQystBPpwbnwenbO0WPXDCmahdkPPVUls90jVZo8kc1nn1JHZ0PJ3JZn5Ud+Zq/NeLzKh8mmvfMY1G2bx3zv1g9tpWaMuu01gLEoy15+OenpqiLsJTPF4vkMWzooX3KGsQAw=;25:dDl15f0ojgywGEyGAza6mULQ5oXrXk9QH7dIbBX9EZ5+MFI3LKpNho3LsfSx89tHSKBzxo6BUh6Exh95fIeegQHbudRJIaO37wZouGhkTxQBF4WQMw3wtnYSPRN59R7TOGKXRbyiVBhqOTTdokdFlu7FNOcmA+ElWaSxFhj18BOJWNbDszi0IZGkSIPSgVk6ImZETv7CNcQHVNPPH7aGD4Kg6Hb0WJwTBoRCRlnu0mBYzYFvkPrrI+mQ5BSHrLUxtf9/Q+fsFuAnmsg5aWUA2CHaIxkETRUlzqq0qF7/ILvWjpmhlyBJu1GJRfLQWIEZTTrj15RbWwczxzjJjYfRVw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;31:jb9cBf6ZUtG2oFsFm2bYRtdmRtH/r1MjOsW5Z4JxxQA0GgmXxCvL0ndUzhF0MhfEnnIJeNYoGB92oH/YHaCFiJyBLB3sGu7y/maui43tGGL3z0wTWe10YiGOJEh69gdfhHZYHJiSw2UGkZB62FJmg++W3YarHEQDndGXUlZcHErcSNpReg82CP2Sc76QbgtSUzVfYrbbjXKJBns/Mc8xl1jFDNcycNbw6D6sAuSZnH4=;20:QnTFHd1y7ZobWVq/Pa33loCkSZxVeBAON9/eVbjQsojj18XdfpOjjseJyjZavfgD8/o8pddXqXYkgRyYGlX7zSjdH1e1c5AqpgP+9QtxT85Su0astt2vp6INsMe8UQLCi1hJqIKh29iv6TB2Zp6QKZ0cjEVI/r9D7ASquAWtnEaFvoOSNXHeiOo7cip+47wiA3VvDjmZQuZ2VV0WSsDsRGlSth82lR1v+zkR5EUi4lLksqvqVEc+/jFpF7K1pQmkIdbH9oEGIUMZ3/SuyrgWYhrBPBeVCkeBwe5FQ+jepQJlBDrZQrvhwHyS6OaTTyCxiqwZbvwYdCd+HtFgFSkGpmvPOrOq3NOqU7CkJrJ49rhwqQgnC0HSvq18JFXaPTYeivQo6cWXY1n830YSKETfILk5NOzS+5byYgKYSiqLCw9tPJS3muqmUtF1m3c33p6wXohE7n7i525SxE7lu7E/t3qYZOVoKCVxWqWJMMKdM/JCMOvfsAiy1ZAwwmBJEfSQ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4457574724DD6A25FD4198AFC2F60@DM6PR02MB4457.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4457;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;4:RFElxM56aGZM6LHdbxKw6nPzriRB7Wq9pjdwGH7Rwqlzvdhj6L4toCyiru8yP/1jBgaWQTLI/0drsr8JgBttjPjZp16l68L3pGaQiK5V43K9MO8G8jn3mNmWbkNVmJqBiMVarpJsFaNdEQNiquI5zKgYCftZvNg1L1Qy2Hp1ADCkakhzBYFWFlSS4wyFiT3MaHBiZS2KVz0H/gq/8Xy9vcoGAIlGDIjF/nEetR0w3Gf5b+3jlh8l1iKCZHTpv75ptV0qwdSOZQKanKcC5pRQ5+Kbh6v/y0eL9FZY6xQNJl9lLsjPiO1vcPnxymEWbIxH
X-Forefront-PRVS: 083526BF8A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4457;23:aom9DiMQczjXapJnN0rkziA4GSzxtocjhU3JpSCYI?=
 =?us-ascii?Q?XF+XSAR4ohH258dwhd0eWzbRNEtMUQ3rPvuxoHuPUKB/Qk/mu6rg0zoFdppP?=
 =?us-ascii?Q?WdNUWaCmI017Awgd8rW1tWKc4GOaMjbcpyb5fW6dLXkhwjMWHx73OcTdk0m1?=
 =?us-ascii?Q?8D9BM5QvGW6smJ6rLZ1lS6brajuhfsfqCMZpEWHW3mXSdPmp0/PfAUFfjgGA?=
 =?us-ascii?Q?Q5xcEWxi/qyYDFw37IYIR6wTrFgMoDvZo3HSrQn1W0K2CASJSTWfk+OFLHmk?=
 =?us-ascii?Q?YcEf58Bdq9YtIfXrRPkN9PNpiWqlAGho48sC4QlhtUJ2I8ly5aqMR1ic2+IA?=
 =?us-ascii?Q?2QGIpcyUIuDYaRBW2PzXDqmaD3XV/+t7hwZP5x9vbgQnJ5/sgyNBkGPzoQE0?=
 =?us-ascii?Q?o1UGLlLtKFZ4nULzxTkObcSbfO6nkKWMTpY/RiOJ78cX6seREyT9C4WjVoX4?=
 =?us-ascii?Q?OaA0e9QuZern4ZvcFCIo0mWoPmkaub872ehkXaWKXVjZKHriwS7oEQORA48/?=
 =?us-ascii?Q?vk7XgHaO08b9sTEoSVARf1jASpGSlutUPayHtjv6UUlWkrrpEWdBFzXhr9fs?=
 =?us-ascii?Q?gAd9z+iUHcLzlaw0Iqc11wKRmihJwtrQ1SYlrsJYBGz/ieOxxG9pFu5j74bb?=
 =?us-ascii?Q?+eNL/FifrbBfAkE/bDXeyJj1n8n6kBjTrpC7IYQz9P0BtKyEpi5L90QHuQT0?=
 =?us-ascii?Q?T8+yDFqIACA5q1ifD+cEpv5XqbwsxfGvaRJf/axA3nFfn1Xltch0eRbhKjrA?=
 =?us-ascii?Q?TCugXGsIs99h0KnE0cE4mV40uV5jjSgIUX9NAK8CwVb/a1NFZCQ3OVyeWq6x?=
 =?us-ascii?Q?XM8R1W8ZKxNls7p1LnpfJkC9F3zogzVevpu4NabFHBSQVU5FABr/oHjnSXk5?=
 =?us-ascii?Q?AMgExl0fHc60xDzSBPnzJpbBs+Xy2nWw85kyY0CVB9tI/izbMR3yxUMbH+LB?=
 =?us-ascii?Q?c/W9QOj2aURzYJSliYFDK4XbgSbLZeM4SP/EzQO9Jjw97zcI6l9Lv0NdPWJ0?=
 =?us-ascii?Q?N0yj/TlbO66FW1DTSGRoIGIcOAORoeegJ3cIgk2rerVHatDeaNkZr5D3XSMT?=
 =?us-ascii?Q?LBMpc9KgVqLhCK0EROTBGtWHLn+qkDmRaDYKRwNu25KI4MmqrERIq+TUj5Ki?=
 =?us-ascii?Q?M4noInGZe2TDEdrR/DYeqmTbnvyT4s4yicjmW/yeuWcG5B2GVU+xCNDx9/oL?=
 =?us-ascii?Q?liSMegmVJDwh0ZcBHXglglxWXu450T1lOgfxZMF9w7oiusFBGnnATu6dg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: KbhTirog38B/kJvq0MlhifLucGK5hbs0pqrh+/0N8pfi4BVLK5vN3R19JRiZgoif3wRWlSDmIU4ZG7N6XGS92c9gq+xy68iv5ed6QkU7xXfZqDV23rC1QRzFJ11XJJ+ojX6ew+A1Rxg/nqOKznqvdp/uYw86vY5OPXijgYgDfr31ojvvBOmQSX/82tCQidhmFawl0kDa1H36BgCydX5ydqvcOgmG3Tdzvgx1zlxPfL0OpsmrgpdgTZXrrYPU04edBd6hhRPVnxX8tDrmSg3df2SI5EK/g+IXPt3RxOVICKEv6G3YWZfGCmVkp2O0Jk1jXoAu7WK/MOHUOfQW4nFWfgN6gBqD5Y1V5cJzecA3l0g=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;6:Qxk2R24IB0r6xJn7+DTglmweR8aWbe099nMFmmRZ2/qrD/0xXxo2+K7atix2B/V6I1/NX2MqaP8WyLfy/GyphqvmNtBW7CM/+np5vkcqR/5UfDEQGU1hSJ8E3g8I/56aEi9iiJNh5SHlO20+6wO0QrzTpEsTHrRNuVZHsmNm0EWsLb0inuemgzkwlQq150DbNIYF+3yz+bR6DMZZujyYLrw869i0woKCZoRQUCYTbvLIJKB3oC+sIoPUe/ddi1qB5b0ZNUVziAse8uaQze7hRS9tzSADxMyeWN+4VIl3ZlqgxlXhr5c03AtYbiR+tS5UzD+DOC82VovaFiy6kriqN//M2Zsv0t5odpmFgiigUu3HOJGJdMmllMd7teh1VVgrfAGpVRdjsRwX2nGG0iWT9i76HtiUNZtqHGN35Ca8p+kdoUK+SBp1Z0Oj14TP9fD9tLqmAe32LY7Y42imgg4sfQ==;5:CMkWE93OyfJZ612GyTMdvfd4wi5ZKiaiWu0Y7FQdMhh032Pe47wPyZFj1VU4xBkUCcGSfhVppyXOxcyKWfn5dmV+osvFPSKdnS54BdkrNtDMtl4WN6bdjG9CIM1n/BQ3wI9BHofHnEPDVnvpnFJOy7t1cqM7SWY6IUuXNxEa/1I=;7:wCW3nxge+Mig7z2HKqTA99ArlF1wOKDebkObBSS6od+D97DFh/7TIVAt/eC6QK49IMPiMsf0kZbwKNgaVjkpqBL12hIvlYdBn2YXVm+EA2BrlbNgk8giMkzisWThNg237vDMMa8H0LwsecbFjmBYrJbxWMo3Pw8ajmyT7g16/x3YdrF3pgDP4RFmLD0RKFt2EC3W4bK6PC8MLnLHyvVDnp3OW+XBFA4mKW2CHQuLdP57s8aQammjmvvgoifl5VeW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2018 07:34:41.3395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dff3600-0f83-41a3-cd6a-08d639832aa8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FPGA Manager support for the Xilinx
ZynqMP chip.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-Fixed some minor coding issues as suggested by
		 Moritz

Changes for v1:
                -None.

Changes for RFC-V2:
                -Updated the Fpga Mgr registrations call's
                 to 4.18

 drivers/fpga/Kconfig       |   9 ++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/zynqmp-fpga.c | 165 +++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/fpga/zynqmp-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 1ebcef4bab5b..38eed4f9d6e9 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -56,6 +56,15 @@ config FPGA_MGR_ZYNQ_FPGA
 	help
 	  FPGA manager driver support for Xilinx Zynq FPGAs.
 
+config FPGA_MGR_ZYNQMP_FPGA
+	tristate "Xilinx Zynqmp FPGA"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
+	  This driver uses the processor configuration port(PCAP)
+	  to configure the programmable logic(PL) through PS
+	  on ZynqMP SoC.
+
 config FPGA_MGR_XILINX_SPI
 	tristate "Xilinx Configuration over Slave Serial (SPI)"
 	depends on SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 7a2d73ba7122..3488ebbaee46 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
 obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
+obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
new file mode 100644
index 000000000000..3c8fb28ef4ce
--- /dev/null
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/string.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Constant Definitions */
+#define IXR_FPGA_DONE_MASK	0X00000008U
+
+/**
+ * struct zynqmp_fpga_priv - Private data structure
+ * @dev:	Device data structure
+ * @flags:	flags which is used to identify the bitfile type
+ */
+struct zynqmp_fpga_priv {
+	struct device *dev;
+	u32 flags;
+};
+
+static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t size)
+{
+	struct zynqmp_fpga_priv *priv;
+
+	priv = mgr->priv;
+	priv->flags = info->flags;
+
+	return 0;
+}
+
+static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
+				 const char *buf, size_t size)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	struct zynqmp_fpga_priv *priv;
+	dma_addr_t dma_addr;
+	u32 eemi_flags = 0;
+	char *kbuf;
+	int ret;
+
+	if (!eemi_ops || !eemi_ops->fpga_load)
+		return -ENXIO;
+
+	priv = mgr->priv;
+
+	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	memcpy(kbuf, buf, size);
+
+	wmb(); /* ensure all writes are done before initiate FW call */
+
+	if (priv->flags & FPGA_MGR_PARTIAL_RECONFIG)
+		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_PARTIAL;
+
+	ret = eemi_ops->fpga_load(dma_addr, size, eemi_flags);
+
+	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	return 0;
+}
+
+static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 status;
+
+	if (!eemi_ops || !eemi_ops->fpga_get_status)
+		return FPGA_MGR_STATE_UNKNOWN;
+
+	eemi_ops->fpga_get_status(&status);
+	if (status & IXR_FPGA_DONE_MASK)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops zynqmp_fpga_ops = {
+	.state = zynqmp_fpga_ops_state,
+	.write_init = zynqmp_fpga_ops_write_init,
+	.write = zynqmp_fpga_ops_write,
+	.write_complete = zynqmp_fpga_ops_write_complete,
+};
+
+static int zynqmp_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zynqmp_fpga_priv *priv;
+	struct fpga_manager *mgr;
+	int err, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+	if (ret < 0) {
+		dev_err(dev, "no usable DMA configuration");
+		return ret;
+	}
+
+	mgr = fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
+			      &zynqmp_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	err = fpga_mgr_register(mgr);
+	if (err) {
+		dev_err(dev, "unable to register FPGA manager");
+		fpga_mgr_free(mgr);
+		return err;
+	}
+
+	return 0;
+}
+
+static int zynqmp_fpga_remove(struct platform_device *pdev)
+{
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+
+	fpga_mgr_unregister(mgr);
+
+	return 0;
+}
+
+static const struct of_device_id zynqmp_fpga_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-pcap-fpga", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
+
+static struct platform_driver zynqmp_fpga_driver = {
+	.probe = zynqmp_fpga_probe,
+	.remove = zynqmp_fpga_remove,
+	.driver = {
+		.name = "zynqmp_fpga_manager",
+		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
+	},
+};
+
+module_platform_driver(zynqmp_fpga_driver);
+
+MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.18.0


Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB98BC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0522133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="b5Yxdsy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0522133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeIMApU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:45:20 -0400
Received: from mail-sn1nam01on0062.outbound.protection.outlook.com ([104.47.32.62]:60160
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728103AbeIMApU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=priKkztjrpjFLOKv4LnjLVrwKzMjFsQtifYDQFa1OkU=;
 b=b5Yxdsy/MAb72EpwNBgQa2fgoGE7J8c8ZYHTXOBHE3n3aIUd0QGNIaVM5NKRoUET67Xd+hWBQTpDul1P5ETIh59ImFA7MhSwClVLblLq7Ol+Re0l/PIi39AIY92c2bqBx5IC50S+pXwTli+RYPCWGoaCQIVOvRbmr7ePDmA1i7M=
Received: from SN4PR0201CA0045.namprd02.prod.outlook.com
 (2603:10b6:803:2e::31) by BL0PR02MB4756.namprd02.prod.outlook.com
 (2603:10b6:208:5d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Wed, 12 Sep
 2018 19:39:15 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by SN4PR0201CA0045.outlook.office365.com
 (2603:10b6:803:2e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.17 via Frontend
 Transport; Wed, 12 Sep 2018 19:39:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Wed, 12 Sep 2018 19:39:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36147 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayo-0007VN-KZ; Wed, 12 Sep 2018 12:39:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayj-0001JA-H0; Wed, 12 Sep 2018 12:39:09 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8CJcwDE027618;
        Wed, 12 Sep 2018 12:38:58 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0AyY-0001Go-Me; Wed, 12 Sep 2018 12:38:58 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <michal.simek@xilinx.com>, <arm@kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v12 3/6] firmware: xilinx: Add query data API
Date:   Wed, 12 Sep 2018 12:38:37 -0700
Message-ID: <1536781120-22794-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(11346002)(26005)(446003)(426003)(186003)(336012)(77096007)(476003)(2616005)(486006)(72206003)(126002)(54906003)(106466001)(47776003)(478600001)(9786002)(110136005)(44832011)(2906002)(36756003)(63266004)(81156014)(316002)(6666003)(305945005)(50466002)(8936002)(51416003)(356003)(2201001)(4326008)(81166006)(5660300001)(106002)(14444005)(48376002)(8676002)(16586007)(7696005)(76176011)(50226002)(36386004)(107886003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4756;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT018;1:SphgYn8PEKebp4p2w/YBEhhsMJa07Be+jd486rGC/1Io9XBo+ArFl8EVdzWmDF0n2RkOF50T3m8l+m6brxRHZt002APJDRQSxCk1K9vH8Zh2qeToIYTCFZ/xI+0imYq+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cd55b27-4714-4d38-76d5-08d618e76c41
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4756;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;3:Gc0wkfwaGpkgxlrS0hENWuORKMj5pdA/6ujufDt01msSl6OfO8c0oWw6atWEp9UilAMBscB/90zQQvtpgeSZYsls4TOu6UGx3mg+VfWDXBbT69nX43bXOAIJZjbk2eEfg+XPnT+XTmTtEHjOLruTAhl9IiXEXsC4N4xp3ic1AlRNNVe+UjVyXMJvw8YhsexzirUMGJrxlwKXxhcULYA9E3kue6sJW/0SP2odoUqw4W9YZN3dmw4r+ifYmrOD4aTgWY5LSG5L4qiF50ME6jRj44J0eagfyMjd/oRqHqfq3nAq3En/ldQKD8myPkIwkmJApQq2ouqdTYOYmLV0L5UZC4mezwLTfHwsAtIOJyNVdJM=;25:4Xa+YqhBUKytH/6XCmTyToQKS/v6vtOB9zy+bOfhahYEb/djzcpl0ELwMDrA1ZwNsn60RnFn5vLhB5iNXFiYMpUtl5a6AY0XZNI9OxP+L3Stl+NWZQ2AVBxInIRXTnuo1xsNmXCfLrLFdBkhyOjiiPXEUcAgurtMY89+XZldA8/m065CdFG8UYQ/mnifi8pV5zBJbEmCeA1+oEnwMk9bmOQW/o4QvQKKkgjBzB0tPH/7XWhIwIHlB8tRKpCMDV3T6RW1COMlelhMz5aXvQJHZ13ZCm0Ch6ajrKiGLy9aK/gVOhJNWNFP7w8aV8s9U6Moo5PGLNgFa6WPYj8hV3T3dQ==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4756:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;31:TctqQehw2IdoR/KpEUJvRd/0V1BcNC4Q6SQR9BWMsAOCM0Xdcu095wg/eVP4peln74RbrMzxAHny9nGtal3Pj/1XIp/gHcNCgiXQMpFTv723EHNCkm3z6Ut1/RlXbDZw2oSwJut+UqWkssWPG0rZodzOjM5cRPK+ObMwcCHiVZKEpg8D0MOskvi7XmeGRZAnFaQP7vPUoIhj4EVKq96HUpwW2zeeHVNmS3pt5D0MuQg=;20:ush2X6tCVt6onZtT3V81BT8QsYg1pIV1Xl+oN/1nLtfbpHZ+VUzSI+NGwNPdo0xxLUnkT1X3s92oVag6rXjzTSTimJJj1In2gUop9W/iQoN1l00LQZJy8NGB7259j7lwrgdxUuyaLOkUGG5/rrfOikEhiIiaoy/7v1UMzMw2iXKwk9cSoeJNlCD/pxIGQ+uTH4Kq6e0wAJYRLNHpkwDjuOhSqZg86/Hcg8810u+k6xvYN54Yn9BP79um3dgqbVWx8OdbzH4GjLuVVodk3dKKpeeoqwyfkQpnC7JrXbzsLwHR5Iy1+eRe+WgJtb0mj7QR7T1gQ+4PdNs6s/vJP0IZd3nN/G9jBmLi78qxEfv0iN6VrlHeIFQnnZB2g2vqM+gJC5zB8ac6OaygMZYjTxwzuzbggM+9QUgcPWOV0Y/DK+QmOjwv/3ATX9o5q6iLZ3T81IfGfRkF60lN1zL4KPynSjB9Ix/YnmPMz2zw0mkedOmIsJJ1i3IvYHZEs2bMQXzL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4756D24FD523C8E1233FF2FFB81B0@BL0PR02MB4756.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:BL0PR02MB4756;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4756;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;4:+oGYmqCH9mNywReHDrZ1Ferk34miGVKdAbn6oPXgxJnDgrYELDDTKNx+DsmSCJY8LbHk+pG9by6m/ohP4mdlbfRLV17TTjFTxPVN4ZSKKyeRJU0IB4li5pXXku73NtGcOpBqs1V0x1afsyjkZ9tvtQsMYn+elMv87dUy1MvY0E283WH2nswZVwTCJrHnfLy7h5uaLfk6XJygFdL0frbePMkI0utKfCOP7rH98RgNqCqW1p3Jeo7HvBipAiWuHvD8D096Jopfp6FFN22t+OpTNl59QJzVqrP0Uvu14fpnBkMjnHJUCHG64KgLO7CUP6bW
X-Forefront-PRVS: 07935ACF08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4756;23:Ze1pVzgWoCAHh2DpQoimcCVeQKhhSyvJvMon4XJZz?=
 =?us-ascii?Q?MbKEtamigZ4ENdKW6UlOW2FHQYHNw5fy4GXnz0jcbegrAjtJ479WlznJmN1X?=
 =?us-ascii?Q?G6TSbRRYCYHLzKHZcat06l98I7NCSaHvwsb9s2H5fYtpssV2w4w4oEoZlatC?=
 =?us-ascii?Q?XZ1J5hkUHCAtGdKYmXklRm6oFEcDdOo8KL2A0A+w8GSTT7iDXjILY3OcKTOK?=
 =?us-ascii?Q?+nmIfgCWGzd9+/p1jUdqANBOEL1ExlZOSfnAx9N6vaZtM6NgyNc2v/GqL90t?=
 =?us-ascii?Q?sn1I9+ljbcEikDv88PTLUgEMWgeIe3v3JpdwYgwXO1R6ZSDseOi6O5/4L+Qs?=
 =?us-ascii?Q?1KtD895Uv+XqGdr2uDWr6kZqUV1YU9vZrBHLVE1z9Z/dPpEazMkM+3B7VzIH?=
 =?us-ascii?Q?E7tK8XFJHTjPsPi9oGgS1pJdAr+HEsHVb0qSonyJ/1b7QXKaDP4YKANgz5Vr?=
 =?us-ascii?Q?yjO8RJJCVHbG/L3vaIkn6hvh7SJZwnaXH6vFbb0ez6Zba9WQwDKPMm0+tfJS?=
 =?us-ascii?Q?5lQl1vS0XIw+K0+ncJToG04ojse+Ukk7ucVeRvpltOSk7haGBufeVs4nZQ64?=
 =?us-ascii?Q?R6riW2HQzPASZcExc7FLu4wxfuarImrm4S4MwDxVFpplvBe865qQcYYwNHUw?=
 =?us-ascii?Q?tsD0q4zd++hO6LnvFTO+Xr3GIRI0wjiiY8YLxyIRkPz4CCgig+iUj9Yn09Ft?=
 =?us-ascii?Q?QO2363P9RPEXsHVo4r3ySlojATt197NG+inmewMtg0LB/DNi2ZwKZ5d1SHbh?=
 =?us-ascii?Q?0lQi/6ZqUIoR0zMPPnMDdcEJlCAsqgPDwuE6oApPcS3fNc71Cjy0+KDKL8dx?=
 =?us-ascii?Q?idncrm1tAToi0XLKgEz5wBMfV+NNRuh3qbyPv6nCpd0jL+gYdPaqvc8LdVLC?=
 =?us-ascii?Q?aRNOwXSWFundpzxmwBEm6hhM4O5qjAXLU9xPZx+zZ1MB513sBHOVmuTqLgeF?=
 =?us-ascii?Q?BDuJC69bZCaCdI7eEgzBN1Obh/NIcCFdG/8hPi/yM1lF7Na+1Tz1w1LKr08f?=
 =?us-ascii?Q?0CKRBOkjvlI8ibHPN9RPrWgCa6lFdMlGXZbxuIO4eIn274RXnk3gI+dijima?=
 =?us-ascii?Q?xH2GsirzbyCwtnRnR8XzA+We2MTSjH3y1nEYX9DGXNNkLomiMxuUKOgL5xRK?=
 =?us-ascii?Q?4Ys+GHRXfK4L0wdZiewB0Ydz3HRC0MLetM8yJDT6F9kKIB8UQ54h60Qrf1iT?=
 =?us-ascii?Q?ZlyD8fS54hSXH1Ceo/OXe4ONYIDz2lp/dTSiMHNR11HJjrkWE7rOUdYvg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: r9TkNryraBd/ebBFH/ZPbLuhs9qPo/Jks/83LKbc2me2gUpuxPp+5jZNQ39dv4ARZE0uUoRagTRVyh2hjyvNBfX/J2ME0VmAnV6sg8rSq5dTB4xPIgQy4vUqd5Mfj/umar14QR2wWOIL8UGd0ZLls85IXgE7w+aOuKt0w9R/zry2XHavc/xZflRql3+cBsR2iDysFcQPiZhYFn341zXffYwSedHcBpg3JrAlq5h096yekdCVroBEIJUKy6v9VDsa3LVyUZbyPuUR3KV1eF0tce8EF0pdzkZ4HR7z1pzBW/TPwTg6j5aZBRwu9TMZu5FBOPWuB9B/iwdM98Uo7FLt9kSkmfW73tMcsztSSQSoqSY=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;6:GKZeX53N0bGzSEwjFRiRl43/bXmGuZfNSeTh3TyZnKA6jhqL6SmpTAXwJVnbHGFNSOJraunOtcMR6oaCiyO1q/oPNgq45ZRTkFIN0HqeScCetAlJ5/gjtxd7El4aUm28DDNzk/vpgn7+jYlgXA1XIT/ltLozKzTeTEbfQYRx43+BCU0bAQJM0xQffRbXOJYoefPxnetBxcArZW+4RLZCeQqyYbui3ojn5S6EDeJQ4tdLnPQAaMNDkmYosVpKRXcRE9Nt8svj/Sq+c43EmJfuEe4vPKz6FahXIOAUP8EdXtk3b+omVOGHZmcWTWVUMdWYzH6G9z26g9CmV7PRvAk3Ll+UqxDhRDlsKKAxBK5Iks6Kz9YG+DoGXNmNNkjNRpHfzJQ8A3ri8Zyf6yVFGh8YTFTOy2TQK9HwBRmSxEpL0AKicHq5nIK2P/Ssm7CuGBp/Ik5eFiwdEwljQO2I1ng7ow==;5:f2QGv3hIgPDjw2MPoeKeJnUzi9Wcvu1UgzW+wuCQmDiKd4aBFiHlaMypdif9XbJ+1NhVIx8P5GYGX+l9e/+ddhCPbw8cWo9rlUTiuM9JyMHb6CaEY48jwBkiLvIUpI5Ps3BEG/pLwDjgV+ZfX3LIPTRe4PWFaHx83CoKuoUxDmc=;7:BAVDlPZkpS0ZcLW6r23TgDWo2JTUcLPz4A9LkwQ7tdMr5akHOIdC1phgb9jkC8XcJkd8bIiya5oT4f0tDZdlVxDzfNNNxixYlh0POs75CP2+xjkv1NbbCzoDqrJvuKxcEGd4Dwxt4imCe04qelIIOKyL1gXNVBqHwOwJo0tXx245INcn93BC7GsL7ykZ8rZs4mon/Aqod80H6Qc7NZE6tl0dXEAXsKxMufjRDMFQz//KZ168ajboJxO3k8JC3+n+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 19:39:15.0214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd55b27-4714-4d38-76d5-08d618e76c41
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware query data API to query platform
specific information(clocks, pins) from firmware.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 5bf64ac..2a333c0 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -241,8 +241,22 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
+/**
+ * zynqmp_pm_query_data() - Get query data from firmware
+ * @qdata:	Variable to the zynqmp_pm_query_data structure
+ * @out:	Returned output value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				   qdata.arg2, qdata.arg3, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.query_data = zynqmp_pm_query_data,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index cb63bed..287f42c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_QUERY_DATA = 35,
 };
 
 /* PMU-FW return status codes */
@@ -47,8 +48,27 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_query_id {
+	PM_QID_INVALID,
+};
+
+/**
+ * struct zynqmp_pm_query_data - PM query data
+ * @qid:	query ID
+ * @arg1:	Argument 1 of query data
+ * @arg2:	Argument 2 of query data
+ * @arg3:	Argument 3 of query data
+ */
+struct zynqmp_pm_query_data {
+	u32 qid;
+	u32 arg1;
+	u32 arg2;
+	u32 arg3;
+};
+
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4


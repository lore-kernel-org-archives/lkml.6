Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6FAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8176821B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="CD/+YVab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfBKQtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:49:42 -0500
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:19492
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727521AbfBKQtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBVm7vn2whs9bYtdJvLQZRIQ/YXQCA5/XUjonZ4b62E=;
 b=CD/+YVabXj007jwBz4Fxn9c/apdkvwaWfLvGSvfKsbeB8CdWGbd8ZnZIz6lxZF/fOnjJgYsIpLw3mDk82+wEYLs89TTXnL+bOzCMWkCTkUe8r5UMqIeZ8iHdHp2QZYNnHdPCgi8CpCpjr44dTKTmpJkEVFc6HnCCvfcLtNPNE4I=
Received: from AM6PR06CA0019.eurprd06.prod.outlook.com (2603:10a6:20b:14::32)
 by VI1PR0602MB3534.eurprd06.prod.outlook.com (2603:10a6:803:a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19; Mon, 11 Feb
 2019 16:49:29 +0000
Received: from HE1EUR02FT044.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::206) by AM6PR06CA0019.outlook.office365.com
 (2603:10a6:20b:14::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 16:49:28 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 HE1EUR02FT044.mail.protection.outlook.com (10.152.11.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:49:28 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:26 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:26 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v6 4/5] i2c: ocores: add SPDX tag
Date:   Mon, 11 Feb 2019 17:49:12 +0100
Message-ID: <20190211164913.5988-5-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211164913.5988-1-federico.vaga@cern.ch>
References: <20190211164913.5988-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(189003)(199004)(66066001)(4744005)(476003)(36756003)(486006)(86362001)(76176011)(126002)(246002)(356004)(4326008)(6666004)(47776003)(446003)(11346002)(336012)(956004)(1076003)(2616005)(44832011)(426003)(50466002)(7636002)(186003)(16526019)(48376002)(8676002)(2906002)(110136005)(50226002)(6306002)(51416003)(106002)(316002)(74482002)(478600001)(54906003)(7696005)(16586007)(53416004)(107886003)(106466001)(3846002)(6116002)(8936002)(305945005)(786003)(7736002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0602MB3534;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50abbd1e-7018-481c-1ece-08d69040e35a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:VI1PR0602MB3534;
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3534:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3534;20:BJHNJR9mfLZClaRQ6N2MCFtXge+wX4olAwBUtdTmFrJsAywuxSRyjQvNau4nLE7i+cYIplKX2+y4D9Cl+di27fMwTCTRBYX1kfcS7lZSgYZf/NQuEYu6JX+XupyqweaUgiP0lb7Q+B1qUbCVLOeoPl2OJTetT/IEcaA9u4srlIbCAW2NSQkfJfMnLmQJxtFHI+ljgovH0bhipz7DjSIe6x/+XCDYUcHzZivx5SSteMyBk1B2HzM5fLp+M12hT00mLYdzYKhYoYtIqBj3tnqZswLcaCMDsHNi4hfGrn2Hn9jk7eT0f6GLHpNwdJbsrG0xLu1ZQp+wIJXw0Odjq82qqrXbY9UqCD8taNgfO46wajOS1YUouhuuWh7Vo8GX2SQM3cZDXbGudMZHFqyEl0S7NOZPjPO+za9F82NetmssSJYY0ImP4XDnXH64693IleMXEOM9LzIMGuuDioW32i18CrTE4asaCLH29tK71SBE1Bk5NC1cL0oJfYxxmalKL7ym;4:48VjVhIyDJ0JgKmuYDPi2id968lhrFr70yBKDZRI8tS53UjiPF7Shd0q+9POlCJKgMy9aP125yyT6GgIwogmmOhICWX/FEsQ8K3J0li11pdQedU7+FJ21o3Z32GC7F4Xpq+cBSZo0uyxV6qLPEy6BYoPgPqu6mvFVcoi986VACbZi7F4dH1oybmU416CT8zAdhd/wbNq3IXsPzMaelysSAJBpY7Q4oGbYeOl1j5/ps9OAQTcx3suuxyvr+bdL4jqf0JdC2RapbMr4VRGX4HgQYVaQOeYc4X7K2hbl8FBXTo=
X-Microsoft-Antispam-PRVS: <VI1PR0602MB35342436672B74B92DEE76BBEF640@VI1PR0602MB3534.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0602MB3534;23:jBc1A4bL8tvi7X1y6OEVR6Z2jxRoeRxX5QO0hGl?=
 =?us-ascii?Q?o47RCvx7YZ1eVuB7z3qPoL8C8CXQuf5Lq6GL7U010I/s+M5O0LX9saHuQrUY?=
 =?us-ascii?Q?+HPegzMeUzTrxtSmBz54tIPOX4Fn2FOS60qfjo/ZV+BBvS1d5aGXivRUlw/J?=
 =?us-ascii?Q?65UiqxbPegElPpqgpuiwnOQDt+Tk+3yc4gCKFvKNHn3H6K41Qr8G9Fu3tHoo?=
 =?us-ascii?Q?g3svnQTCOn3JOde/vQKYHNz+6bd91ItAgp4epUHpsOL+gkGdjqEJa3nBJGXx?=
 =?us-ascii?Q?y2jv8FX2+PK6dX8FpufuVNegMnrTMfkuGWl7vfMB2F0Wr/bnABmULfuGLPVv?=
 =?us-ascii?Q?fYVZrInX3FNYuqcgBVdcMtovTRooHtxJIhlVVKyWytdPu2A4wIGBXz9P625L?=
 =?us-ascii?Q?b0GbYUr8Ljmv+FSPOgOYCe/JzYIi2rChyHHitnHgwoHbmmJb9p8TPGRWlecV?=
 =?us-ascii?Q?njGiFPR6Qm6TryLF7i8efl2jOWpqE93/SdIRl1dyJfR6MaIAA+nuuCYv16Fx?=
 =?us-ascii?Q?9R0i2Hl1s2yrFmgM3jG+WBIxx9dj5ex1GujHLfmKgs81QOzHPDNrVfmO2hr/?=
 =?us-ascii?Q?qf6G665JIPogvflthhnItbY9gOh5OV3fATCpLgS4vzzOay6LU7o1Y6aWQgh4?=
 =?us-ascii?Q?aP1he4Ilsn+Pfgw246ri28pnOkd2QhTQEKxZ6rEM9Sx885n7YE838EyKaSVk?=
 =?us-ascii?Q?mSYi/DzM6Kq8f5wCOE4MCMWJTSwzDBaZgqooQWPctXx6gpaK4c8/hJFcfYaM?=
 =?us-ascii?Q?THEnNA+8wKLYJ8avy9Rb96+o2jkly8isV8niAF+M3o/kr3dtsOwmnahKs2KW?=
 =?us-ascii?Q?dVuxSwu5rOj8VI5cKZi5/EAe371/KcmXdn6DeKW5neMpoE4tkcFDUvDRam0A?=
 =?us-ascii?Q?s7Y58vrTzRqAfVSXJnT8z+laxH3+6IRinGwFd2SU05EpZ50rmq+QiUgHrD4W?=
 =?us-ascii?Q?vMmBQq63/SIbmmR+OfgUy1R6wASrZh2GHJyrlK8AxveV3zHd3P3eyjYB0d1c?=
 =?us-ascii?Q?aTUrwQQ8wYvQ5ihUtAYJo1ivi4hVp2nNTWVa+GoiKrtoJ+HYgVr7FcUDjRWM?=
 =?us-ascii?Q?xHyCT8CoubO/LLg6Q5il2c4jmx1qmfylYOiVN7QB1N7gFc8huz9nt9t7vdKB?=
 =?us-ascii?Q?LZa1/dKjUaq3K9MBEh0YxxJ8EBXjjH4eGJ9VGIRO6Ss+hXwCzpjvpw/nEf5/?=
 =?us-ascii?Q?a7iZLB3GornTTRRtGonA090M7Bv33rxYbzZpm93yQpelCA4aGnGRashUx7Q?=
 =?us-ascii?Q?=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0eMTGCi4Wf1fv7n9tCEUnetTl4PnuvMxBxoOlQYSTB9TEV9m6NWh65SjgJQdJFxvI21hn2hiIQt5/+ZdtWSDkFxiTgBaSCaZmKtUZ1WkgSmvkcGvl4eBRcQTW7VyxgFslbF5L1iTlM4Fde4fpcwznurRQTTYL3nAUPA5bIDlxsgaDdVgEgxBNJ3rWQkPlJroo+CHdtY9Eyeew1kD+HGRhe2bFpWwOdyiSWlkqWGT20BJZLqE2SkmAMJpB6AZL3YsiHQzMzi5xjXJ122KfySf7I5s+BOatQvZdlybZ7SrbrCwOUwJlpbuoq7LVNtmpHMUG0FUl7v1V5x5lncfAsEhC7b3AMm/fuCwbFxz/n7/0DSDMAjpPsk0rT3occLqfrXxtGDFxNxa36wtck7jnWMdisDlAXebI23bTmXHTwQ6sxc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3534;6:kEiJc6aWqyq/5aRBf+B7o16G+rwN1alLbFitDZ7rTYrSNR4KHiZGAHNJJPxShXw0crcN7FdbE6yRnvh98qWLTz9B9NU2uoPKa9XMeb3iqsGh1CfSUF+qTYP4Dh8UFAJkZTIM9ZT0/QHG08tCDAXWQVTyAJQ+gQ4tgOt3Z1we8JwFPLlYqLnjvqdwhoAZ958SBxG5E4C0tBxrGrKuyuldgbMc5/f1muUSuYu21l1NVcMIqXVmqBGb2TtABghDvfhYUD6itX2YUwnPE6Vfy8ETwtrzJ/WUMpnIO8ZtphvD22TRlJ34vEtq6vOYPa0jYC52NIj8e73ucbkH7NyCJZvZ30X/xdLZO8AClyq9cCkgmOiMJej0HL5T4GBO2gyKq8+rpk7PL1FMyTtR5NRjpjO4eku+1t6s5fkxrfL7pgzI+duGu0/bDxwv6v1e42l/S5bucEB6oE6mfUPe5OYyC5TIhg==;5:7zDz0vfrmROue6Mcf3fEUViw1TeN4ty9CiP9BFtnCuBZKLR48Ifg9lxd6VYu4/avndNR3ftOKR8WHXTZCA941eYh+kIUL/GQ/3Pl8PPH+lHfXsWRx//5KoLjKHSzmECFNwMcFSz5v2W7KVvdUtT3W00ofC6RSsmSReFP+hgjQNmWohDYzgNpnzXkSCBNggswwEOngVsBLS/99dLzl9SkaQ==;7:v64IeU9hJxyQvT1UJ7uY7y3v7ny1sqs8SORV0DfkRZDCQyAj2ppCnlfR/get60eHfrwLtSLbqBxDOfdjIHtAYe3ImoDW0POacm4A+o5HafLUODpCEcMsjSLZ+dbtWo9kb5aHwhSJ0CDfDtlk19uIUw==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:49:28.3102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50abbd1e-7018-481c-1ece-08d69040e35a
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds the SPDX tag and it removes the old text about the GPLv2.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 5dea7b9..78085a8 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * i2c-ocores.c: I2C bus driver for OpenCores I2C controller
  * (https://opencores.org/project/i2c/overview)
@@ -6,10 +7,6 @@
  *
  * Support for the GRLIB port of the controller by
  * Andreas Larsson <andreas@gaisler.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <linux/clk.h>
-- 
2.15.0


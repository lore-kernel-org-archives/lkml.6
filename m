Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965831AbeEITqp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:46:45 -0400
Received: from mail-db5eur01on0115.outbound.protection.outlook.com ([104.47.2.115]:14512
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965181AbeEITqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:46:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-i2c@vger.kernel.org
Subject: [PATCH 1/2] i2c: pmcmsp: return message count on master_xfer success
Date: Wed,  9 May 2018 21:46:29 +0200
Message-Id: <20180509194630.29047-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0190.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::14) To VI1PR0202MB2781.eurprd02.prod.outlook.com
 (2603:10a6:800:da::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;3:GDdyS2btGWFSd4yN7N9PZeGpqHurbai9IVveT/7q5RXH42t6LirMVAzJAf8/670hkcyZQrygL8ksvyq/h1Nds8912ueQILnKMJOqjHOJ/Yly53f7UV397aDmp3fcxkBba9ImU8RPnvH4ZARrDyeuE+++ZH+bcy9EV83BsZ/TIUKfL5jEmHncoeBB1VH8BfCDDessY/g6KVzobTqitBHyQ+Lunhy/vzRWyf8lTH+TZgv5NBZQXSSbrrAnyHbmsRqg;25:j3ovFbBzA/OYbbT1h+7Om+L8wGnmI1kRR8pZoE+ifpSYhkHun+ToER04k14IRDNfZrH5rVSWbuI2TUNZrcvzbwhHAQGglURiSQPYarfNRL61CWFnRrZX2GWE20ricRaIf9BW1zGs/4Vxsc4crxKLY3HXv2j9p1Sb6+1NoblK7KUUWGH3tb+ygBzXpibFubN5wWMrN7EVVisWNDhwj/6ilQsluAduz8+obqUeRi0h3BTVJGOwMK31spHg5eets3eW/DBuzcQwqNDSmZfgxL0v7ZdX2yJv0hujTMmRXBjgJ6RvsELqzIcjjhkQtSVByegmL9m+FQ1UlZvEogRw6UCyGg==;31:6IhnVR1QrtRLXSC3/R9r8UhS5zHPnk2gCDqADhi5adGt6ucl2L+2G8QBtDSmKir+0eXZMzHFIjMgwA3TD7+K8e0p0fUFpbzuXBaxw8QJLPatkgNV/OdV/1kpnWOHDV+zkUSd26P75B6pDDMGk6A/YhQgoxVrB3IttFIIuehFUNbdJdWhoOzPAeCk4qpFMI9DdXO81kPvcpvjVQbSW/sVfHI8HAgAKSwthq/NIWsZGxM=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2781:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27814D8D1A18208B97DC4604BC990@VI1PR0202MB2781.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2781;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;4:fEN+dSYTQ6IIPIkliukNPngC+z6efgTkjfMWDbJm3Wy4N8MZFkEdG+5OwfNKTB1S41mYkx4Lkz5oqUxODiEKAgScv7rEMdYrt3cDmJWNKlhRt/KuDrEHW4NZJKArSwPHnyd0f93ogQjFbslLWBoXbtscv1ebQakmn6Hh15yBHxD5kSTTinTNav/1TnLDx8JtMg+o+qFsAgip4NZuRWTtRRae2hiJVwa7l0UH5VQqNXSuqD3rRZwF9dUPay0FjrzgBSR25QkafY/bwIjm0UPYDg==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39840400004)(366004)(346002)(39380400002)(189003)(199004)(6666003)(1076002)(86362001)(386003)(575784001)(6506007)(25786009)(59450400001)(305945005)(6512007)(68736007)(26005)(2906002)(476003)(4326008)(486006)(66066001)(52116002)(54906003)(2351001)(478600001)(16586007)(2616005)(51416003)(53936002)(7736002)(36756003)(47776003)(956004)(6486002)(2361001)(186003)(81156014)(8676002)(81166006)(16526019)(6916009)(316002)(5660300001)(50226002)(8936002)(106356001)(97736004)(105586002)(50466002)(3846002)(48376002)(74482002)(6116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2781;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2781;23:e0bSBaMrLkgSSz0DKTl6A5V7dODyNAP5vU7ztRz?=
 =?us-ascii?Q?PIDROiSqKlfKCMf+q5Bxl+5KNltw+1JDAlJra4//X8N6hwU1wdEbISpxGGh9?=
 =?us-ascii?Q?3t7eEbBxqwmU3VxlFLV3wKuU/ePvfSX6oTxdr5fbz7jdXwpSH9PmegxJNYOq?=
 =?us-ascii?Q?3z4HxB94DI13FvBQx53IR8yOg9bE1S8RAQ1fG30McK3AzlECQnBFU6+unZ1r?=
 =?us-ascii?Q?cIx3XZB0fyYocWytjWnEuQZNuTn6VvuJ8RRj0I0FWazwRHxeB2Z+s2EiryWQ?=
 =?us-ascii?Q?CUvSFbgkamo0oalEJt2dk5IJVNJJJP3u4OpWwF9PVLkqrqd9Bhz8kDoy7i0M?=
 =?us-ascii?Q?Q1D6qWpqYSCXMfeyIj1gUzWphRrYD3QMfuDpHCT4AO6QRIXIgEBfCZ6KKc+G?=
 =?us-ascii?Q?BBAmZimltuRwor+PA+Jd0p9Nw4n60nsmWqMO62mOMMN03YQQm26LVpmVkz30?=
 =?us-ascii?Q?zM/UEL89m4FPII7kSHVx2xwndU4LeEOTjUWVAk2Q7nYsvsnmCofX8p1NSyoW?=
 =?us-ascii?Q?4uVDUENHtD5y6CIQxWT/+UtNt5O3IuA9x/6ur2thSPl9ZSRMy2PW9Qv+B1RP?=
 =?us-ascii?Q?LbQ7fuoaOIJW4YKc0DFeai9PpyqmwPUk4G/G/WJUGPxRxNKd6nVdZ69iZDRS?=
 =?us-ascii?Q?U7lqjx1fUMP2npcfy3+v1kqhQ8RRSwitbpkJg+iAVraR1FkUIVbr+yT1TkvO?=
 =?us-ascii?Q?fO0z7YbhgEmhBPWUSUXerC3GGbsf3rlfmIIKeAkJ2gW9WgBKKol4EGXD0Gvt?=
 =?us-ascii?Q?Mn1PcnNLRdx3G+B7pYjZAqo/ZjciJTNWjNVa3ERZKtWM2EB9o82G+xnYgI5x?=
 =?us-ascii?Q?+Gd/cjUtQYh7LlIfmPlFobdDd2/KH71Rvaek4zNahowyRy52gKD5pjeDtRyo?=
 =?us-ascii?Q?JzWT0suEQ8m6Q4x7TqeoHZepxww7kIomNo0zBlmszI0fiZuUIYyxznqfOaS3?=
 =?us-ascii?Q?KZjpr0RL73WwxDU0vcYz0CbMihRZd+ez+sifLaRhu1FfKE1AWJPjTsSXy07u?=
 =?us-ascii?Q?07O7fumQ4bvtrXhkikEJu5MlC5jfcglcFYxFTcSErGZ8LryxBpBKftXAzzin?=
 =?us-ascii?Q?RHkpEKH45tccIlzNQoe8g30qmQjt2fRQFX90+pGJyqcaJEmNaWSTQmiwLQAH?=
 =?us-ascii?Q?Cnlo5dK98J0wH/iO/ZtSWHrlUT+GRH6FxbAExHj1syERHC4lMXJo8jogHTi2?=
 =?us-ascii?Q?wcohEu2y60Zd4ZqJIaBoZ5S+yv8VSgniy/LriEFMd8pTr2jT8GEm3rsCLrco?=
 =?us-ascii?Q?qOY10aIqou3NxXVYu5dxyZUhD3Yk33S/pZP338dHxiQMNOnzjXbuK6vve+W/?=
 =?us-ascii?Q?DjA=3D=3D?=
X-Microsoft-Antispam-Message-Info: WFrusfLF5GSJfnIspwgJjGZ9kxYhxxf0kWapaet9lSGqezk5TId1rfYvDaiQwWfgtiO1ZcfSpSgL9ehL1cGmOGgYK5R4yLT41fsD/sMn14vsC/ugno9wtLgLYKHwH+vW7ltbJKsNG10YXx5XRqW0cI30E6G9XrpA0A7et6OkUrHHmzABCU1dwD99tH+tfoIK
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;6:hdP6II1B+1SG5vLr0OhOa+/arrL6Xfe1TZ2d35jv2BwkjaL5GxzW269cfGp4fxl04LEzB8pf7djAGGAfxoHNKNFyAbPizh7TjUcvEBLrWQclT7IdcvbkGCpBWpVTr53wWPaisnU96vRZKsXHxdzIgZx8tBLfY8aE18eU6iyKqpdSUbK07V3uk+ybBt2j/Yp1OYt+1cDhtXD2GJHT4DLxoo5eIADObTZDQzbSPLIekmGIGgYmBSbhziGK/Z3VCHvg2ctYoMQHNY2R6gFTs1zjsOsnIqSuMn54m+k77UqUk97m79fTqsiuoCHvAuwcrJD174Oi32YYkll1mUlABwYQ1YT6VWHIqHNWP0A6ynakZ1s+7IAx/dwC73cgYF0vSCPFR7qFpi9Z03PYkO1+5K0GVWPjJeIXGFVnlYBMpTKog9ieBunp77QxkYLDhEqN0r6ZH5DSKk+87gDrakmPWsX3sw==;5:RHQuprF7rS22q9i0SXE1pDJ9fDbJV/j4xVyoDGKdSahMF14qe6YUZ4kJY32VoGIvlZ1eZBHM0To/IgN+Pd1iAPd68WvFdmI44L3BukpQts9mIVa755Qv50L/vgVO0l+QnawTvJfz1YJEX/cRPCjKr9bX1HU0lgbX+KiuTR4dAU4=;24:+FMGvIXKBrvnETWh7Fr+U/U9/mzqm/Foqmppf7Q5xNwDWs7/2AgCj4FmAeddazGknEI81ft4Nv99TjbXrOaZEBIxGoALGhAWkya8flxxZFE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;7:Qnray8FvXXVdZuVqo0WuHdeSBJyvmH66K1+3QzEfvhI+DiOAs/STebZWPg5FlkxRTRhmwT+dQES+kBGlLP2xawxwqWClRNJLIajs97UQkdqbg+yScdy9z76f1WExjKX33BdM6260CXDQVJQfvydD0YaBue2o8OUXgmJhZvm0oyYQrzLE1WIacaJSmhYwDqJ1KAJ56UruvPVcvVUCk5WaYprW90GACFt4IAmp90rVqzsgJxPuKLaIW66wh0oqL1I1
X-MS-Office365-Filtering-Correlation-Id: b1ef5293-ca9a-4d0c-32ac-08d5b5e594f5
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:46:38.9341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ef5293-ca9a-4d0c-32ac-08d5b5e594f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2781
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning zero is wrong in this case.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-pmcmsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 2aa0e83174c5..ec27e27e8d06 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -567,7 +567,7 @@ static int pmcmsptwi_master_xfer(struct i2c_adapter *adap,
 		return -1;
 	}
 
-	return 0;
+	return num;
 }
 
 static u32 pmcmsptwi_i2c_func(struct i2c_adapter *adapter)
-- 
2.11.0

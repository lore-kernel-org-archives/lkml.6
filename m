Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeCTJcg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:32:36 -0400
Received: from mail-ve1eur01on0105.outbound.protection.outlook.com ([104.47.1.105]:46160
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752330AbeCTJca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:32:30 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>,
        joel@jms.id.au, linux-i2c@vger.kernel.org
Subject: [PATCH 1/3] i2c: mux: pca9541: use the BIT macro
Date: Tue, 20 Mar 2018 10:31:58 +0100
Message-Id: <20180320093200.19179-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180320093200.19179-1-peda@axentia.se>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0502CA0029.eurprd05.prod.outlook.com
 (2603:10a6:803:1::42) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6352714e-12de-492a-95a3-08d58e457eeb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:M5wjOmlhJv7e04ar3PlxoQVlAdRBZOq2/Ur9jbD34IQjBmVxCq+VJvKil+MDxUz0U9JymJPjWlBr+QKOtxAMT4C3zmCaQ49KLwK5qkJ2BQhE34MgLwrd7TJivW/IbvnSf7W7am5oLKPyFNDycL79Fp7GEZxZs15/DqwV4iehBrupYGI7In/m4Efz7KirArzsT/NgK/fXWorry3jQZzfFFQcEkSUa9rafkiIOGwoBRjiirwKLbZ88BK+ya5wNJpF9;25:FlLeyC28rWM+jC8bOrMJpZS8+4T9RH3Gu0xbuSIycL2rSU1AJUCHGkrO7gYGVOflsQ/aEAJOMCtVNiPSyB2030DCpIZWnpt2lgQolCl5wbeAKgBhkqZ95x0JOLauHgQZUA8w03gWHCtuOhCdHQlNTba2SynWH+8aLTKhjB9abxAPF612egq+dQprCSTjaCg1x/D1ell2b7sBAGRctlzQCVOt8nqpLs5lqpwUdFEWay6vyCCK0NEh4VY0IVcsFbLeHf/N1H9QjF0I+BVpT4u21QTNk6PjRzHyYIr/ZGWOL83pYkO0qBYBTmQygUitR2gZj9bTeZ2FWaaPv2SSg+ha6A==;31:ohgFJQ7p6YBtGba70l2wjSeLdlIfVe0LN+r0fa4xQl24iVo4FzjXSGhrWtap8juZMhqdfBw/VSd8hPztbGZ2KzX2WZZfEyGzqrxh7A7vjs42Z1nCtxWeh38XpTFU5AkYX7oYaQQGHNUnuTNMv87dhhsPalVUTPD6pwGt4ELvmlRSXE1K7a7U0QdJ4jKMy/P59B0A1vIMC8DidYLgS8KT+4t6A1HY3peHlA5wlacxeNU=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776A2A0B893D191BA5A220ABCAB0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501309)(52105095)(3002001)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:f/i1nA6dCyc+UDai3Ak+Dwl8nZ1w/RJhKvHngqgJiPHrP6THVmuZReUF6/S0COu5wSOoUeeXs/lmwmqUASwaFWE1e77U1kQchRHX2BiSB3pOLUzZml0wo27sDkzXHFRePc3QuOcAYBqYjcRTyfY34rlse+K9myRLtPEW3rsiXKdrnmxIoF/PaOvbTRA2YkypKiyI+lr4CfpZs3e+Z42s3xA+6Rzmrdg/ooeK8FICD4oPQpIL+WSWtE5WyH/6Je0mlDHgOHzW+XDqIYTfpyxJ8g==
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39840400004)(39380400002)(346002)(396003)(199004)(189003)(8936002)(16586007)(54906003)(478600001)(81166006)(2351001)(6346003)(3846002)(2361001)(25786009)(76176011)(106356001)(8676002)(81156014)(51416003)(86362001)(6506007)(26005)(316002)(386003)(186003)(16526019)(50226002)(53936002)(36756003)(68736007)(47776003)(4326008)(97736004)(5660300001)(66066001)(6486002)(6512007)(305945005)(50466002)(7736002)(2906002)(48376002)(1076002)(6116002)(2950100002)(6666003)(52116002)(6916009)(74482002)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2776;23:aqM/fSOaXO97zMLYXpH/uG+OmSDcHDfzfK5Vvtl?=
 =?us-ascii?Q?lzaoOI8UmwrsocB3yjWmPy3kJMIs7lijNBD0umhwgCBgTtGoBhehPE5EFjOy?=
 =?us-ascii?Q?CcE5wdkFCyfDwZT+qABGS9x4mvIKpxQ0MSY2TNTc3tcRTye+7f/tWadwuwYf?=
 =?us-ascii?Q?ntfAAR7+PIeE33mBPjhDHpFNW9/0Yf4eZcM4gbV4KAk8/ifbe5IlzEt9USHm?=
 =?us-ascii?Q?u1fplPgQ4E0+PYoc0z8z7hc9C+Coyhg89KicRAokNMIbYv1vvp3TjV15iX3i?=
 =?us-ascii?Q?AA0dGvczndpSudD+3ISmMCjS2xomT9mMKJTLDRUzg9WbiQy+oXXyqSUr3Cva?=
 =?us-ascii?Q?eheMS4rcIRiXfBlMECXUMLRrXkw2QDpT6OuX5ofzCE7Oh55W+5IcgknA23Cs?=
 =?us-ascii?Q?unCSPXKhZBxZigywnkoODTwtmDDFks8aoiLmK0P/0oAADeYBTCBVyamgjiK5?=
 =?us-ascii?Q?CHTO24Ll4ttArvLOvCLZWKQfH98bDiQ0hssl4MgFxyKHw+R6oefMFCm6TNeX?=
 =?us-ascii?Q?0DRs9yxYSCAicGwOXuMg8To1riXXLWRPHyf/pMoN0gMMErKOScEBUCXmq7Eg?=
 =?us-ascii?Q?nUIJZnxqDsoY5J1HBC9qmEq+y8u4bWd3RqFu9K0VZo8ng61c/8BPA6AngQE1?=
 =?us-ascii?Q?lP92X6hNunP295GyA6C5UnAfzWzwxPMxwwVT5L6CGmX9uX0L10C+TO2nhLJ/?=
 =?us-ascii?Q?GgjuP5BvYYelZd6Fi1TAjfPePpQEHMnKYRIN5x9w2Pz1+x0bKBJlrT82xIAX?=
 =?us-ascii?Q?NX6wZS1tn3epD+xaJXWFQDssrEFsfVvnyWp4QSEud/4APV5dqwN+ZDSkBwTC?=
 =?us-ascii?Q?eBmjz1w1twbJ+ihA8qMflDqmSLW/9X4emNv9ErSp4ZqctLOQIpJ3ukZFuwqT?=
 =?us-ascii?Q?Ll5K896bPVFQZ3x4qF15TsC2JmSQtpb86ffmi18BCkdNl7TVd7ef4WjGURw6?=
 =?us-ascii?Q?qit0pWR74yuK+Kb9CEWVY1Fas9De6rZJ9dzQYCMfy70G8PPSfgAg7aROwE9w?=
 =?us-ascii?Q?/itz2zKBAqDtI/fTzGc2z8SKZyl8p9uFbAyHyuXU3hvtpTjuUPYeEga97f2d?=
 =?us-ascii?Q?khfgeqq0pS7G/Jxipq7yk020qiXqlcdcIATKSDi33vgTESQ/UTwd43v+Thd/?=
 =?us-ascii?Q?2LfCcGvs5b0soPW7FdcTgncqAHXy1viZV+KEqbVYsJpN4VV8ROARILgGz+3c?=
 =?us-ascii?Q?P2OGErBPTH6jyaxjArZ6CVa5XSorHyP4UDTPQyIhC6hj++261lTLFrvurzC4?=
 =?us-ascii?Q?wNko+WLAi9UfLwJLaaCA=3D?=
X-Microsoft-Antispam-Message-Info: yQWpoaXMOMbzj/6UzJH9EUgYfTbpoD7AkvERNFlCs8StaEl8duiyLTBzb4tH27fViMv7k95derFP9j1wfPcAW4EfqIdw35bNdzUv0hzGUePb5dzCHVM6jshOOa/ISzfq6sm4DUuy+MlzyAbuG0G3CUOhEthiVShd80eQvslefoW+YkQT5Daw6otngx/YgmGk
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:Wd94hAIRsbdHHh5b56BZSif9++K1TZvn8UMiadREMIp0B/abwZiqAzan26t8onqQJXMPksAEyk5l4BKlf7KooKdMTxPkgMTYyPvEJT+1dKF30kqmXvWKyMNGGiQc6fDy5ZHpUUqJ90eezyLeNbYV3AVgDdlLNXgI3vwAZn+p8yOtkETIzJOIOFJoZ9S5j1Ztm+9B+aMmb5k3ANB5ybzyqd2TG5F8slGY60xYALCXf98yEwRgLBz41KgMnxDxbQDH3WwVNlvXrOvHKsS4/MaaTAbksAqqxHRaPdZGqAjieNklYfk7LPkETr9lvDovMUnVhIXoxzStfkXnoNuhvFx0OsuoPxOaQ3cFIk8qfuHy7Lk=;5:KoqrqQIW3DEMoQf+SEeQ1riFY9Paqm/xMpLikreVjWrgV4LwVU/H7CFhkXYEBvND/vjvQZO35XXjmPoUgQYDGa/sHPR88taPe4yBd1rM5CDUlyePYyelUfI68DQyWTJgf2PG82WFC8e26m49Hg+4riGspAQlFN0/6ISNUY0m6+U=;24:+pCQlkfWEW4/ZOcivUifEtVxFHmWr6ZRoXHRcw/taOTUtR441NPuZuKDdMj2mYvJYdbL3tuiK8Kng68nciYhr/MtLEORES4NzEu28yV2i6s=;7:8GOfNGjjj4onG2cQQMUwrzk/DA3tcLgHzEXRRaD9kL3/fLw3vPoHKIMKfY9/iyijnFjZwt4W15tdZh4APAaATUWGOlJKacHHi9b02f3LG1TcgYb21Z22cf3W/1j9Juq4XMmHaN0BtXFMYL7I/CU/2Zhx/IxzbNzfksrpaRueU6Gh0HUpxv0PxEp9ceEgm6E8eE2O964Ptdmcd38hGg8E4DShIqNmE4yBoI3Y3oAsrVzkwD7vEYw+dB9/EUWLUZ5F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 09:32:26.2924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6352714e-12de-492a-95a3-08d58e457eeb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks nice!

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 6a39adaf433f..ad168125d23d 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -16,6 +16,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
@@ -43,20 +44,20 @@
 #define PCA9541_CONTROL		0x01
 #define PCA9541_ISTAT		0x02
 
-#define PCA9541_CTL_MYBUS	(1 << 0)
-#define PCA9541_CTL_NMYBUS	(1 << 1)
-#define PCA9541_CTL_BUSON	(1 << 2)
-#define PCA9541_CTL_NBUSON	(1 << 3)
-#define PCA9541_CTL_BUSINIT	(1 << 4)
-#define PCA9541_CTL_TESTON	(1 << 6)
-#define PCA9541_CTL_NTESTON	(1 << 7)
-
-#define PCA9541_ISTAT_INTIN	(1 << 0)
-#define PCA9541_ISTAT_BUSINIT	(1 << 1)
-#define PCA9541_ISTAT_BUSOK	(1 << 2)
-#define PCA9541_ISTAT_BUSLOST	(1 << 3)
-#define PCA9541_ISTAT_MYTEST	(1 << 6)
-#define PCA9541_ISTAT_NMYTEST	(1 << 7)
+#define PCA9541_CTL_MYBUS	BIT(0)
+#define PCA9541_CTL_NMYBUS	BIT(1)
+#define PCA9541_CTL_BUSON	BIT(2)
+#define PCA9541_CTL_NBUSON	BIT(3)
+#define PCA9541_CTL_BUSINIT	BIT(4)
+#define PCA9541_CTL_TESTON	BIT(6)
+#define PCA9541_CTL_NTESTON	BIT(7)
+
+#define PCA9541_ISTAT_INTIN	BIT(0)
+#define PCA9541_ISTAT_BUSINIT	BIT(1)
+#define PCA9541_ISTAT_BUSOK	BIT(2)
+#define PCA9541_ISTAT_BUSLOST	BIT(3)
+#define PCA9541_ISTAT_MYTEST	BIT(6)
+#define PCA9541_ISTAT_NMYTEST	BIT(7)
 
 #define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
 #define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
-- 
2.11.0

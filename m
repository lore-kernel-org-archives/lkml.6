Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965615AbeEITps (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:45:48 -0400
Received: from mail-eopbgr50115.outbound.protection.outlook.com ([40.107.5.115]:56768
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965398AbeEITpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:45:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Andrzej Hajda <a.hajda@samsung.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] i2c: exynos5: remove some dead code
Date: Wed,  9 May 2018 21:45:31 +0200
Message-Id: <20180509194532.28929-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0197.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::21) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:b3brqDRRxFpYDE5gp6QfEHjIH9Wc+KKZPK9s/3WFzLnhMuHtri/3QRKhghOZ9KOaJgTMXjeeazLwTJ6rePQrQlZWjhk+wKajs4Hqgsu6vE3R4uKAFUkaEGuyilY9uTkJ210vrqFXy2ukMnFiligWr/1eSgUkMxAxlikOt4yEJuRCMuMXalqFhgE6/kpNTS2D9l/huitF3Z2TZ/Vxci3CT9B+4PTOFww4LmmxJIyTQSJNeD13mnq78eYqi8Q2SqAF;25:BaBdiG/Lvt8HQVPo+ewvmPBa1lfOQkbtWTSNFYhz8R3BLhPxW2rWEFnEJ4eoUgam5/BUdvGBzQsOeG0b0pO9ZbvyhpQx2fyt+EdynkAiclyPsIvgiFZGg2lyZwJlO495vH413boVIuZDzA2svFMOuATRiAqCAb5ncDXFBl6j5bkGN160+D8JOCGqYF9B2YwK10zlLRQ0AgjUGNoo8HoOa4yBf0EJwH+yWnD1jj0mBULjYcGPKQv5JEUqeoa/03yIvP6OsD58Ed9wwpXkGakDfeWwUTUmgQDmUIxsFn+VzO5AIa66xnc8VAnHBLmb60LPkTMsE8pI21Z4R7gFTzMAPQ==;31:rKlcA2fU82ZSrMwoc5iBvCTMYDxwCemv4JfAARAqGIaBeDwZ1f60NasEz7GjgqSKqLSVAjuO+DL0khOuzmo7YH6udLW0vtzXPudCiloOaLyrWe/3UF/qK5/kveOdjMbfJ9Wmjxw+H2KjRrbUmqG9U0vP9s+DHQjiGAzOYCh9acTIZn1Io1Ey8OTgITSUzKYQRz4ZBXnEHq9vc/e+1n0MbE+izoEbMm5ih5vShOtFcX0=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779BC480D96896D352E7771BC990@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:0vGbRB23x8Zx+TO4qJwXSzK8m2DdvCaO6+aU3R5gnR3c5fke+2I9RsMdatJcctFNqJKykB+bLd94geh/bxI6udMBi7yWX8E6jJWUb79/hDKksO5OtbXRPxPZBbJLmAN2NRIaZGuqpmdHyKPD8S1xBrysoNAr3Z6qv94C4+gLJqkd/Y3SqHLNF1dfJ/UxgV3ZlrQMJk3HYGZTKcFTH0fYUJ8K+zAeqWiRk/BMlKgfE1Uej6Ujoy4MEEdZQdh0c1n9LfkoU3Tn1eJT8MUC0gVq7Q==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(396003)(376002)(39830400003)(366004)(39380400002)(346002)(189003)(199004)(6116002)(66066001)(1076002)(97736004)(6666003)(6486002)(6916009)(50466002)(48376002)(2906002)(478600001)(3846002)(16526019)(186003)(26005)(25786009)(47776003)(2361001)(86362001)(36756003)(74482002)(6506007)(7736002)(52116002)(7416002)(59450400001)(105586002)(106356001)(305945005)(386003)(476003)(316002)(81166006)(486006)(53936002)(81156014)(8936002)(956004)(50226002)(54906003)(2616005)(2351001)(4326008)(5660300001)(6512007)(51416003)(16586007)(68736007)(8676002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:hPrbtRNrP8vzbr2mbXd4+oFG1D/k/AfFVBvI3WQ?=
 =?us-ascii?Q?G82UcIWRsxQEzLprKP2tFww/n9SHKCyEXhf+oTgx29PH8f/JCDtNy7SOoOrS?=
 =?us-ascii?Q?IkavKaILQrydF6JJ1zptlTXNG8wCRW6rH2SlFTVuPuTN4sPiOpn2pmCLkVhe?=
 =?us-ascii?Q?WE7tygI66mJ9Dbbte2jKBmexT6qbBMTA4lld92WzBS2XUOfP6h07dTmJwYYh?=
 =?us-ascii?Q?SBOQYBzhXKgPuvF7DHx4UV0c6Add/wQzjqlkB2yQlSpqp4dbJBCiz4N4qP4q?=
 =?us-ascii?Q?d78Ofye9CDRXME4rtwWokZjwZbLJUtQuizd8WRJjaZZlFcCYQuMhsmGDACAz?=
 =?us-ascii?Q?/l3pjTuCqq5qY+BC3WYeJnSbnbXNJ8Ugj1YD6Ob+6VAPvtD7tBVV/cDtyszq?=
 =?us-ascii?Q?FpP6K3SkYbtKnLAPIz9zQ0M/XDGMQoffA0lCYmFOy5c8aEmH4c2B5kpq+YHY?=
 =?us-ascii?Q?Ub2XWqiIMD52nr1XTzTSqPpbCOpDiRQBhUUFJPsv+1s4vbK5udBpOB/dmSJY?=
 =?us-ascii?Q?5P8IPlH3EjvjVd98KzhPAxu4xmiMdUNRwwsQ0LxYBoIQ+p9K8fIbCse16/KA?=
 =?us-ascii?Q?TV3OIkCbYuM+nForD5Y7zmIcoTtVEfbBZDlLD1lhTfcRDAnwnq+zzIN+n2N/?=
 =?us-ascii?Q?fbOIWQ2Cy+J+9yHyl9iysNOyYu1gSM9WH1W9nRoNMxAyJkRP2oMZ1FCKgamv?=
 =?us-ascii?Q?FMBI7vp/ZUjuCU/gzB9RpiJd0k3dXKKo9DsjhBKyRnGeeiZie21ZHu103Y3o?=
 =?us-ascii?Q?rcfBNyCUHU/3SgGpl+9lTamjLo03KBl5DS26rWirqYx5kzUfcyEo+3DUQh9P?=
 =?us-ascii?Q?tFlvxteDomBi7nRo5hspJVKMs2t8vP3ud2j56YRfuLWbJSHUeiFf8TBpnoJ/?=
 =?us-ascii?Q?bQSr5sjtnANBQKkiRV6GRAeoC7+q6nifoHB8kQMBcVI8A5v2O6LY3GGk++Al?=
 =?us-ascii?Q?qF6/TTmWKeBvjNAY6c/iHwFf8OA+nS2N0NyPYSXpGQMlhMUQZpjnh0YWoV2q?=
 =?us-ascii?Q?U4CQEaSkk7qgreVSazhY4AiBnhjMcimcLcP+JrUkkFp2/f+RqPoFREkGXFGJ?=
 =?us-ascii?Q?+cTWPM+zlJDwn6Na3vrFShqAZgiuKIgmrgosB9CxCOzHYb1buNluo57m+X0h?=
 =?us-ascii?Q?akaqu9pgp4G1pWN9RrOuMpXvb0odEE7L5tv4a/5lnfKVwoBdzFmheqy+priA?=
 =?us-ascii?Q?EgDgDfvIjKuS1AZeaslqDxDM3ZjfUmlMKneQvsj0PbMPxtKMkEtguV6RutS1?=
 =?us-ascii?Q?Wc5E6Or0XtUywh6wXXAj99gefY4NUu64gViEWXiSCC2Z4ugZ9cD3yL2wD4d8?=
 =?us-ascii?Q?Ny9dUtwzpSp0atid09sJQQ8XAFndAr1tBb/zRzLlzq4V+f465nzi5kBDhYOv?=
 =?us-ascii?Q?77R5DChJ2xNTbESfjGbxMr4NAlvk=3D?=
X-Microsoft-Antispam-Message-Info: oKNSFoux/K0iOnx+9VSFkUEdnJHHvDR8xiVZuoHq6iYZvkoSHm0jbnD3eoTCu0KWMHUCicod4UQDraPLPSbhxR/1H74Q7Ln2hsSWR9kxLxHBsQnygVOlhy42u3U0412OHSuRvGv3e7pMIxketTmCtPe2CVhHvSAr02IP5rjQXtUKVQcu9rv4iiFkW+2nckhq
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:5yRVmV/7yJQ6O1nbIozzFLSgzHMkytgw3c1Dmv8ZfGiyLVQKHXLX3t0CHSjncKg0vprYWyB7bIARFfgDO2rM2oJflkBYKfJF2kJdHeinIcZH1Y+w1YdgBIKa52MZTPVHwFvO8W1m5P4ATjE0RQTL5wbPj1Ljsbu7y8gg00RrzL78drilycwJxjqyVxuffI0eF6JMkTAdvtRElyA1mZqkf+aqb1L081jdZQxnTgQznWkaND5mS9iQOhBOX0lLDcF7IYOPrO0dq1jS9pxCtJU6NO3NA595uLue8/grEHguj0dVdvJ3YLIHlo9L4d2Grivt9iW6x3uvwtl5xoxN4s8fRvowd9LyZsGej6++gr3WW+ddqYJ26kb5/7ZH+uKQroLnKl8XyjKOtRcRqjahxvukpydOmMnJqspFskaT2COa35axkSke0qQVfGAo5xUlmllJbBDWVG6QGDbbR+MlN2vhDg==;5:3Xo+zHfamuIY0QWkna3+s7v8xgFFJWO45ukrND5h7dO3JK9aEVH7Ln2IpcmTD/tMbEadAn4Ky+VwMUSSbnYO5UddVoKueMmOcptus0/TiMAsGntUiYKz86o1cRKLP+SkwXl6QaFFJHR/btxNToVqd5NGCJKp2KLfGw4YtI338U8=;24:cC+sCbLyzKYTRZU4icUzHMWTtKiAjSyXTerFxFAj4wAKFhlzIzhYTiCF4enBTC0fSqRHiiPbvN0AW/hhBxBYfaml7FK4jUtazqbvOhPbp7A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:16ydtzBzLBeaDxy7pk7YrHsIPTz5au15SB0kJDJ6VlIONuXxiOzAQ63WO7+t/oYRQkJSD0fCwJoxiXeuwi/2E9tH4qbOZ9Ds5QShabrtOB/hsA9BVdtS3zpg1WcqpX+FcSEWTzEjmMYzVi5boe7kz4XUbpckLsJ+HHi/WLHgCVcvcG6i5apsPnDTzsSrgYdyKog+r7gvrOlj+EqGKfV2MT6dRmDv0+GlpnizHDV6Rfp2jh11+ric5R9GEtPGizXl
X-MS-Office365-Filtering-Correlation-Id: 399b859f-ca4a-45d1-80ae-08d5b5e5720a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:45:40.5253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 399b859f-ca4a-45d1-80ae-08d5b5e5720a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The else branch cannot be taken as i will always equal num.
Get rid of the whole construct.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-exynos5.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 12ec8484e653..a2cbc779c33a 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -727,17 +727,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
 			goto out;
 	}
 
-	if (i == num) {
-		ret = num;
-	} else {
-		/* Only one message, cannot access the device */
-		if (i == 1)
-			ret = -EREMOTEIO;
-		else
-			ret = i;
-
-		dev_warn(i2c->dev, "xfer message failed\n");
-	}
+	ret = num;
 
  out:
 	clk_disable(i2c->clk);
-- 
2.11.0

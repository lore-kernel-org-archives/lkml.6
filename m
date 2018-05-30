Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936018AbeE3HQa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:16:30 -0400
Received: from mail-he1eur01on0083.outbound.protection.outlook.com ([104.47.0.83]:28128
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932377AbeE3HQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:16:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle driver
Date: Wed, 30 May 2018 15:12:38 +0800
Message-Id: <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0071.apcprd03.prod.outlook.com
 (2603:1096:203:52::35) To VI1PR04MB1326.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1326;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;3:zl1MFvccY14WTQEhZvjJiYXa9ujkotPpfKLGoAoSLBiKsGz11OR6fW7OcFyZzTYiklAuc1OcZKlCD18oentKURSvvx4+FINXBnBOKqYi3a+6U5XhCaDR4eJCnKx8nR61hqcin3LTS/xXIihH6ULkcBIEQMf/uMT+W3tB30o77zH2miqDu8ivhgpciu7zgA6rfWB2T04ay1KxYkJ2PSxKjiua/rhQK/PBNH2UmqaSFJ8MGzsQPvSnYGCu1EHFz1CX;25:7LjyfHiaN49ekuw+1AKbphH6uyqJDVkljNM5djVCyknWeOpPk5WgMm04nBbUOvSaHGPNuAAvFUSL+BDqLBtb4MPdbSeyjsknNcz1V9YlHBufi2OVkhTGMII4+dPsE891W48q46D7lQljRZLqVJQsYabwZGiLRTEf8dJXk4xo6VB3/Gkbt6jPPFQMw3nNec14Dv+x15mPGHCu3E5pCNyrY/tY8wRNNwYy9CdMhplsBdKskm45ZuQcAMGCNLhBN48nly9yGSNPN36MDOGfEz7Y0916GJ4ccfxfygni/aUtcEhrQM5CKdQn45lpEluiMwruXBrqBxzCZSsKLMQvXmr7ng==;31:cKh+QYY5wjRuroL7+Zlv64+/pEcxEvjvI2nJwkK8DdXt4KyT5IKe4OI8UAOwR6fr6zCmENsQdhwBryleNv18fgPHD3n4huIA3BV8mfP5s9xd0FKsUyqTsW+1LGXLZLd+CniFo139yht9nMDf+73gfhevTyaEc/ZfYURJQWDFE3T2zIVZXAhe6B6jpmnYiG+hn9AuPo8803WzrEqmPQQfVUswCpI/L45NoZWI7rAiWiA=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1326:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;20:I5cXHzPR+ZxuSF/zhxImh6d9oZQGKRs+YC3AjnlrB1TlZT+sl+BOJLIQcEAmkw7AsOmenTu/SxBhNot2IKrqjuWlyIeqjij1HhQuc+YmqemXr/OYcGlhVv/04FylVx82l+Gqqugpqq0p2+i3qHpimxuYHt0iZL8km/yvac5/EzeYfihoWfYpmBETFD3LXGROpPB0iXEaPXJf1PCoXEn2iIzXjJYLc8x6FYbJL9Um3x9yKNZr3zpHdo1Dc1Ah/aWp+tAe9cSgRMlBaFEkzC7WqEFsLEYcFVnroaf9vlyC4AmaQVvaJqpUWWUa6MKOH/rHYVTSg8Tf+mpcvEdxar+ot4NDjA0MQytVBrMV223BWkHxMPeCHt1Kx4TiyzBFxqubNPHaPx3LweqS2ymdzBrXzYA/iGU9P9XA5Z7rXsRhBtpuZZJRrFcDYuUEQNEx2k2buL6o6X4CqiGE9yBtJi9qPaSjT6lFwqx+sN53Jwg0+8F+tuPOrqxJ6pmx2VDqujC4;4:WhKcdI63hecrJv76PQ8nYhzL42PQ+xNDjofd2M3xCLYnZy5fubEXLS4FP7uF0gcHovY4cpUdcWXre3pJnjI/wyPn51KEkTA848I6IE34mSpeGKc20Asy87mopQ/dkKjYg/ZEeoWTKNcGFQnY6hK/0W1gDCLF0rPKcvJDMo54Wm6WIVKQYaRCI3SAXnz4OWlWsdM9ZuU6Gl0ZG2R85j5+xiSCttn4L9Tbdp3Q+UrHMOMFmBr7whIyJnE5OMR0IYv3xtXby4SkMnVsKm+7UXRYmUVoozSI/cpP2nDOuzm+yMWmUpQ9FNGzN416j/98inme
X-Microsoft-Antispam-PRVS: <VI1PR04MB132617081C7F7EFAAE3630E4F56C0@VI1PR04MB1326.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1326;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1326;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(2906002)(6666003)(81156014)(81166006)(486006)(106356001)(7736002)(305945005)(6116002)(8676002)(3846002)(50466002)(48376002)(68736007)(16526019)(478600001)(476003)(105586002)(5660300001)(6486002)(86362001)(26005)(47776003)(316002)(16586007)(186003)(36756003)(97736004)(386003)(6506007)(52116002)(25786009)(6512007)(11346002)(446003)(53936002)(2616005)(51416003)(66066001)(76176011)(50226002)(8936002)(4326008)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1326;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1326;23:gmX74ffFRQFp98bvIbXcNcBii6FiiWZG2cgwiYEdN?=
 =?us-ascii?Q?jl88K3s50eEAy1XJoNOzX8QRGb2rNTdhoHSejLf0akGgXsdqJsL+70c97RVa?=
 =?us-ascii?Q?JXsHrU1RQfNmayPWU0LzHGh8NGhPP7jkSZEbMZSZW+Od1lpA6M4IRJdosOxI?=
 =?us-ascii?Q?AeijNQOYo5hGeE6T0IuNZhZoB9gG1MHeAC+aBMtcRaES3nDf2bpD1l9ULNHV?=
 =?us-ascii?Q?Q1kg7F+qRmAQeT4PdJdu2A2RQ9ecWkfagRc17BOr/KH7CjDQ6TAa6plotCGv?=
 =?us-ascii?Q?nLANlKNqwRXiMpryqyx37nsTBrdHlveCFeDQQWeauK++GRbyzAItzPwgSLL9?=
 =?us-ascii?Q?4WCVpL6IwzvkZb773UZ3F8+lw19eg3QxBs7un0HknmXNsoMBUgWkzOdCVnMk?=
 =?us-ascii?Q?BtnW0kDiKrgc2cx8LZV83+plisEFBvcEIgQHHjwoI0rCcgYhy5tR1q2TNbGm?=
 =?us-ascii?Q?9tCRYFNG4ua0QuYVFF7GTBHd/DxR3G+MVDQ9eiIV8G7qoBqs2Y/gF1FaBQPG?=
 =?us-ascii?Q?lpyDySPGfIHEBa+RghKgJdyeWv/WwpirWU6UEbqiwMi/X1vfkuFbgE8QCyAW?=
 =?us-ascii?Q?8UBN2iY00sytL6g8V37auGTe6qV92VzhoF/LxPY0OJdG6U/Zt0gra5cMbuQ9?=
 =?us-ascii?Q?46fXgmlWgs/AmVcSKNlD3qDxbSll0apC45WQ//smI+Z+UMk6To2DrGHRS+Fj?=
 =?us-ascii?Q?7EanMFt6Wt2kVlrILczqwpf3iiEDAoTyZEe3pxhwej9jzYlLP0bsq0X7dOwj?=
 =?us-ascii?Q?d6oOVD3p+bDiYLH4fmreSAyi5goKqVqSbempgb1LQxE+XvpipnyMOqh4jp5v?=
 =?us-ascii?Q?7jQhijN4zkinvt33JQZOZP6tuV6n/PbcV2LCl6PXoDOd8VOUWj4JWkLeCr0l?=
 =?us-ascii?Q?TgCFFDcrDlWtdBRDejj5OuntbY0iNaFrBW1GOFE+NFrzq4cXcgd8wMuneI9x?=
 =?us-ascii?Q?+rbUtvEYI4PII+zYFf8SF0d8RbubWycDTFmXALF1VRdw4oEWIG+e0kgpLYfT?=
 =?us-ascii?Q?dfgu4ar6CMV81N0S7nLU2VYAlDvLOerGKht4e2qnf6+AyOqi/BiOeROc5v/S?=
 =?us-ascii?Q?Tft8K5Jw+WzUOdrERoF24is5CzMsifYV++uB3A1I1nd6SUDuQrRkzyPk5YSn?=
 =?us-ascii?Q?f6jn+PEHVUPYKQrxk9WJQDf4SxsSQGzGLzFJcNQJCWMrL2Fg2guLw=3D=3D?=
X-Microsoft-Antispam-Message-Info: P6keBdlqC3SdjDSNSEMu0DpP51ZxtzwEdGVLga1bZ86xgGaU4PO0Yj08k6AUqnohzPO/xO3ZAMfB+rzMy9qVrJcY6vc99OUvoTvyYHjlVMs/DxWIjEoDZVx+6ekQfioeOliNnGGEimCmz1PL6DIWDwjaSrJW8fB+j8Iz0iPZ382drE5uDf26Qqu48qgrFwI7
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;6:5jKQ8t/foOS2gqcCW9fIEQYLcVfS3u6zqMTwpPdXVou7pfGQ3SDrz24xfoj9beUFtKp/9nbZXyOQUMLzfSj8NzSRCUlIw8SlOfsBZ2YbZCmsA2zLI7kgsm/PWzA7VwPDmXOq3vJSg1ls67N8JbCzdsh9uk2ZBhKs1GVnKJHthkFPozRD05si5G//txrwZFz/kf9ZIjDSjTIX3jBTpAOCz4Twnn1zklfYLuV2b5bS9JKjdyxv61Yt7l3H12FyIWLxLxGfYNk9mIK+nMoRuy66K/rffDKsc351ki88RGKNlsXeJb6nemf1tL2YJeWJmgaEpTFwPLBeeFFsbHji7zJPrAO6un4vb8TkXLgkawcWvfL7TPpeQEYhGFQEIzCvYBbw/vMqVkDlhUZvcZnyrexxrnSZIGRNKGHFsmQx+vt74FyXi4aROk4S8g4awGoxQKQ43tag+TD197kq6RxZ3UGSxg==;5:T2noAm2tAR78a+2Jc4cPB/Jm1x0COimgP24oQHmq+SYQgGHhLiG+xKMcoa+7sAU/Qyq8CNla3mwq3uwnw+xQq8e8Km/noMRIwUgtkki5MQl5ZY9n1FiJsFLmFFry43U8u+c8l+V240cADAGuOQwwf+XhZkXSi6p3AgzokaRBNA8=;24:eqno7cVLjjNwSlhbd0MWx7OkziC6Rd6oOjfT4/9qV5lIetgil/5ZawwKFGk7U9eQCFinQXumaej66OolrdVsYVR1jGSsORQsOO7ekRea9xE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;7:IXGHWVyqH4IerIZ50vVl2ILUzLSQd8rJ2VEohVTshqDxPcrfLZquJZZLUEUPmTns7Fb3jB3uF/vBL7zL2QwV/Uu8fcnd+5p/uqdsmollTonzz7S41fecJvFPGVF6AlIws5TBblcj+88EFOlI8E4Do0rek24cdFgJkmvBfOXIlnNXMYpJEYnXR+Ly9KtDrUHJDlaM7TiTnxUx4afYm7qKwHuMfXJdkgLbqtLAsOVoy6RsJQ0fLiCMmik6DEHdr6rf
X-MS-Office365-Filtering-Correlation-Id: 35f791e6-51bd-4ec8-32f4-08d5c5fd3d1d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 07:16:15.5669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f791e6-51bd-4ec8-32f4-08d5c5fd3d1d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1326
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL supports ARM power off in cpu idle, better to reuse
i.MX6SX cpu idle driver instead of i.MX6SL which does NOT
support ARM power off.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/cpuidle-imx6sl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
index fa8ead1..8d866fb 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sl.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
@@ -12,7 +12,6 @@
 
 #include "common.h"
 #include "cpuidle.h"
-#include "hardware.h"
 
 static int imx6sl_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
@@ -22,11 +21,9 @@ static int imx6sl_enter_wait(struct cpuidle_device *dev,
 	 * Software workaround for ERR005311, see function
 	 * description for details.
 	 */
-	if (cpu_is_imx6sl())
-		imx6sl_set_wait_clk(true);
+	imx6sl_set_wait_clk(true);
 	cpu_do_idle();
-	if (cpu_is_imx6sl())
-		imx6sl_set_wait_clk(false);
+	imx6sl_set_wait_clk(false);
 	imx6_set_lpm(WAIT_CLOCKED);
 
 	return index;
-- 
2.7.4

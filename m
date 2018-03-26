Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCZNFt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:05:49 -0400
Received: from mail-sn1nam01on0045.outbound.protection.outlook.com ([104.47.32.45]:39050
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750984AbeCZNFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:05:47 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>,
        <shubhrajyoti.datta@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: [RFC PATCH] spi: zynqmp: Add pm runtime support
Date: Mon, 26 Mar 2018 18:34:20 +0530
Message-ID: <1522069460-4703-1-git-send-email-nagasure@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(189003)(199004)(2351001)(36756003)(6916009)(6666003)(50466002)(48376002)(54906003)(16586007)(2616005)(316002)(106466001)(426003)(5660300001)(305945005)(356003)(2906002)(336012)(36386004)(186003)(77096007)(26005)(106002)(50226002)(9786002)(81166006)(81156014)(8676002)(8936002)(51416003)(59450400001)(7696005)(478600001)(4326008)(107886003)(39060400002)(47776003)(63266004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2270;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT019;1:GOJdcu85qF+fvUMQ7hxPtpc6nJ1I0Gia/jXLn5GYrg3cqQbhHrhfRO6meZHYOoWv/PmX/zzkWgblK0TNoiJz5j0Ma2nQoHlheZvqs9q77+YcKfH5L+T0Z/3Vf5LgAI9Q
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 568c6b16-3d7e-45c0-26bd-08d5931a48d7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR02MB2270;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2270;3:uyDwIs3/6WuPCqwFLPgy4cVczdGRwl8l8Istj7h7w1wbd2UqDQ5S5lDqH1wMi0zsKJuJ7En21vGNzQ0SPhSKvWRQI+gyXc16f9L6O6AvZBZQOBmQwxpns5Bgotmup54Pg2aZXFVR2V59IFqC9OFRgrsjkmlwPuPSirrmc/MJHY5sQxLiYrzO1vxwkjydtVvTdJpVQcVKEL2DEIszFzMCa5LCImyevg4h0vM8zYZTiy2MLllxHsA9khTJisf7SSGaEoGPKAZ+ZhezV27+H9IrhgYmXyE2/Au/sDD5WerzXelNGIHtqMS0adXNqdMWFii377zBk1wr84twbshP4cXBhko7n0dvQtky70u/iOyaUkI=;25:kFZLfxh1TX0JAIuhgJYqeq9SBMFslk96degpBEcmLy0GTUg6HHLMAjb5rU0Ee3umnlSQrdcaD5/wP+pD56coh1kpqvC5k8eJ9J6PKNrjZSU0OazWcFdfEIz+dWSUQWS5LAmwfF1UJZ4vQ3RqPBrZ4tu3Ppr32R6jLhy/AA14KEc7KmFxKd+63lrXI6N72k6tKpwja6egMylp40NxjamAjsrcf9HnziHmNFqr+tz0CMIkStQPToADr3yHwgsteeI/p6/gd61J8naRXU82ub7oOmS6Og+vsirud1i39Tui7f8bW/JTdKWgAwD9ZW6ripz4wqTWli3AJbEk0+II3hgcWQ==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2270:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2270;31:1NMlPVp+x+ft1FC1j2Fau5oeLPeCRzcWKjoYp3tOgipaN56ke6QtF6q5sER4gQO1Q2LRrjhi51mLQd090LD0A6Wp0Shn8kGMWdmoRJ3QKmWCC8B8sT010rPk/91yVHNCrhymiqMUuFXxu8mxOts2IAI75Vx95EW88Is1QamqZPzHjPWiofDpzT5AqTolW5cBv4guYrwiMSCARQqKrkn6NvoQTuGo8cselxHllTWnYlI=;20:rMXejSQHIglvxjfRhYj1o/EpxQDgtBwjvVVz5m44Tll09hTWgwvvvL+a71rLVkZf2eNYysCOf0agpO/4HgbAjWTT4KEEkrz1axB9+3rjjN0AMmlI9d8nTxKOlJ3xg6FX0I8wuR7YUY6eMymCTMFUbDpJm1yffILzhHqBsBrMZ4DUFQc4VfE2gp/IX+G9CklaNWRDmvEZOjkui+ZrWqU8PBpR3AMBdDeAzyudECoW/7rKltm6URUa6xIfk8KoIQYTNfrFZmhDqDk7U7TqzV32D5uPPeyj2uSh1X41TtDVclkB2tgaG4KEhp+stKwlmFJmtgtCILEoB9BY5f3euVrAOPtebJ0h/f2gAOatRhNMNHvxsfjqqpupoZFARE8f7FPonCkEEpFB+UascHRrCH5dvZ7eIzuthIwTqNap7+4XGyOi2VryQJsCss+a4QWFTvd5ess17H2rZ/44n+QB9qsoHafFbjX29/n3nCrFQ5PTHDtWQqxxrPRPzPm+iSz1/Dtp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB22706D5C7D16D33986A501EFAFAD0@MWHPR02MB2270.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR02MB2270;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2270;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2270;4:pirmT0FgDEKUj+srgAg4XsU1xqlYzH85p7zKW/NUFiJvUQgEM3uulgixkKdTe/P4Pg4HCzNlhtGTuwrZN23H25Xj0DT4Dr9rwrql9wxbdq9SqZD9bRnm2mfKi5mtY6c3mp1n9PJGUV6V7aggSLsLLS+xKgfIozblaI31OXIRlfteBiLsE/dIa84TmkA8nQ93dzFLnpzi1DRUrI7xc8WUqjPRLlfaBQIX7gFS9d/vBaCZQzrdChCnoOef15iuZY+MSAIzn7LfTb2/2+nzFB2F0o51iCbqTIlmhXJgeroL0LuNZUieOq2QW/RPZiSNCVy2
X-Forefront-PRVS: 06237E4555
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2270;23:j5uIeno5Gpq4OYEsc9IthuIjje4foZeNQdLJ5umsb?=
 =?us-ascii?Q?3jxr5EoHkJsdafeX8en+3hn+j5IESbBarn5G72eC5o/ZrPjUfuflThr+HVRj?=
 =?us-ascii?Q?Z5wSyohULZjvW6uHGAB4uY2J+BSNSNJUYnttoOBCV3wiVjUKcGPVPxNbCLuU?=
 =?us-ascii?Q?TYxiN2xLQqHl8avVYh2IVjcJlC7Kp9evawxyBRcjNCu9zgESfFjgtqUayrNN?=
 =?us-ascii?Q?Fb2WOcGv2MWOxXV58kQgj9PzhhNrKWc1YakL/biKh5KXjYYuF54jIQKWROWL?=
 =?us-ascii?Q?HYJIe33psUx0nEHzumooFyZT2tq/x2YwEMRHVe2G8rUwNZDzGbBhUNC1y9Ei?=
 =?us-ascii?Q?RVZu43ibseFKr/XqY6tnDs6o5cP+7msRxWp+Zys9AsylsC9Lvg/JWJIP2L3P?=
 =?us-ascii?Q?4CCDEazS+vNjyUxXjvsr7tULs4ln+5QKjPfOe8DPueABJwnibPDRUnr0m7oZ?=
 =?us-ascii?Q?olNM4x8nmbObvimV5RA1l+fUboDUt65k/19aSzhVCsVLKvbtJpE9Tf94cDxU?=
 =?us-ascii?Q?VODH74Q+5Nk+03SP8CSG7WIXJEcxYR8jcl/RpXNSdHuN2xlMa11Y+lqEobQo?=
 =?us-ascii?Q?rWf9wwm1C5C3lmVwXg/gFLc0KfqmVI6IDxb8la3rfkgJvPwj6ZuPfoO1RasH?=
 =?us-ascii?Q?ydhqHiQLaiRAGskRO5nIYbnI7MrZQnviTGjkThUJODPq56mazckTH+bkjMEN?=
 =?us-ascii?Q?5BqKULPhyQq84/pJJh0LDhFH+t4v5Agi2pEhDEuDvklca2OlZlYoiJfTBoVI?=
 =?us-ascii?Q?FHcF324hxBs32pfpqIOSMb6Y1qw6c9bN1+xQDIbRZrGHklaKFA06/sJJUuij?=
 =?us-ascii?Q?mp0iWJwcQn6BPOawyq0cPi7dZj5NQKcz1D5ojafj92SVpNJcmY1ZNKKjjv42?=
 =?us-ascii?Q?kXrZKYTxHv4AmdHOEFIgVHRGYnlhrVMzxSXmuJb0scbzQt0n4SvGe41vLVZ1?=
 =?us-ascii?Q?y9oLjXgzBax6/xvTZ1zhzoXcl20wQz4K2PjaIWCxiZKlPuPju6X/2fwa23NQ?=
 =?us-ascii?Q?3F2t1fo6no35vEKdQvDu5iNXjGsDvkQ4fCHvocDh3ETlJyMtat8CTTrHls8o?=
 =?us-ascii?Q?0PORstlVS6FCG+LXceDaS481W6g?=
X-Microsoft-Antispam-Message-Info: 7OH3hcNHyubcOYHW4ygabmfJd8D8JdKgnQ4BSDUihwzh2+9IYA+8iFd6UyBK5oa1VIFqBb4VRz7MYE2BqhCMlH4gtpnAPbInddSnp89oAdxwdxd/sbUbnPraq3rxWnIDQ7X/hYFZJMyh+dfma+PbUqldbwKCW3tGV4G2U1CIieY3yir4SQFsIfVozrt2H08R
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2270;6:+P8vxT6CeB3DxHxz7ROSRHRRmoBIgsaZccuxTQGbLhXwFhl/9l6HiKiZI/Vef8U8X8UUTgAkW8ClIC/V25RVDzjZ2WPFC7a8LR/OjDd01gEZze+4RZu7/dORV/77T5h3oh776o72/u+ToURRQs5gJlf8xczXZWoXynskP8IrEUdlXZCbuto/2b9dZblwfvN3hwE6/u+Coyn0A34QWSDAa7WHlhum5BJwxhoBfYD3gYoW3DMtSJFpqhAXaYHY5ZwqJw3awGZzNnkUBs0iefH4Y//yI4su4PFMOIxhPLyTuEEzvzP6gNcPHWxKFJpzo+6Ko4kF/DhGB5emr7Qq/Ok4WrwUTK/t3sU7NW7fwXRFIV/0gUim+dhAjjJ7EGBTryD/OJ0Em0eDcBXVowQLY0UVfDJ98hfQtzzLg5iVElIIHDj0WuD9LMunxjknxRFHliBsg6Zavd4aYsjmJ4XK9ElBXg==;5:/PeXZfrOOzWaLtqtOEojB53+PHrM8IGU113noqroP/b/TgVOS+nFfmRyMI8NoUV8/u9eO9KCIg7bhvzLfUNPbL33kYkR496T6vbCGjc2hFcvo+7miKf+EPZfa9rJ/VHE74Q7jt4mGX10lXSp/I6g32BjJ5dyLTTqdRmWntdNaTM=;24:mlvQRpCzn1VaS2nysq3EdwQVtd3rtG/W1EJg2+SSI+4re9VcA5Z1MKMPAypwg1nhg/YVrV+3cDs0g1PBycU85j+wmNqKLMK6ukBRqULEwp4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2270;7:rTPicnNkVDEIV2ZHxCqnh9WpEYWiuVl4BMokKaHuIm20XXa5ds/k7VI+OMsWx1yhZhrOd87gFzQlFGSSJ6I7RLRx82TQ6Es1dvRibNIw5pW2/AhhgSueHo9qgyaGXf02R/rnxS1+xKCqwAORnq4cx6yl5DUve8mJWkTRGoK0pirNK0ULsD35GoilRtjB87XJ+YpXEJzyRDxN5QawF+LkD0UsMNRVDWk2CdtF30EIXNQ+raxfYk2Wm2Pfwsq5NX24
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 13:05:44.0629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568c6b16-3d7e-45c0-26bd-08d5931a48d7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2270
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds runtime pm functions.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 86 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 18aeace..26d1ac3 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -135,6 +136,7 @@
 #define GQSPI_DMA_UNALIGN		0x3
 #define GQSPI_DEFAULT_NUM_CS	1	/* Default number of chip selects */
 
+#define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
 /**
@@ -356,21 +358,9 @@ static void zynqmp_qspi_copy_read_data(struct zynqmp_qspi *xqspi,
 static int zynqmp_prepare_transfer_hardware(struct spi_master *master)
 {
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
-	int ret;
-
-	ret = clk_enable(xqspi->refclk);
-	if (ret)
-		return ret;
-
-	ret = clk_enable(xqspi->pclk);
-	if (ret)
-		goto clk_err;
 
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
 	return 0;
-clk_err:
-	clk_disable(xqspi->refclk);
-	return ret;
 }
 
 /**
@@ -387,8 +377,6 @@ static int zynqmp_unprepare_transfer_hardware(struct spi_master *master)
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
 
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
-	clk_disable(xqspi->refclk);
-	clk_disable(xqspi->pclk);
 	return 0;
 }
 
@@ -959,11 +947,67 @@ static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 
 	spi_master_resume(master);
 
+	clk_disable(xqspi->refclk);
+	clk_disable(xqspi->pclk);
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(zynqmp_qspi_dev_pm_ops, zynqmp_qspi_suspend,
-			 zynqmp_qspi_resume);
+/**
+ * zynqmp_runtime_suspend - Runtime suspend method for the SPI driver
+ * @dev:	Address of the platform_device structure
+ *
+ * This function disables the clocks
+ *
+ * Return:	Always 0
+ */
+static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
+
+	clk_disable(xqspi->refclk);
+	clk_disable(xqspi->pclk);
+
+	return 0;
+}
+
+/**
+ * zynqmp_runtime_resume - Runtime resume method for the SPI driver
+ * @dev:	Address of the platform_device structure
+ *
+ * This function enables the clocks
+ *
+ * Return:	0 on success and error value on error
+ */
+static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_enable(xqspi->pclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable APB clock.\n");
+		return ret;
+	}
+
+	ret = clk_enable(xqspi->refclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable device clock.\n");
+		clk_disable(xqspi->pclk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(zynqmp_runtime_suspend,
+			   zynqmp_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(zynqmp_qspi_suspend, zynqmp_qspi_resume)
+};
 
 /**
  * zynqmp_qspi_probe:	Probe method for the QSPI driver
@@ -1023,9 +1067,15 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_pclk;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
@@ -1063,6 +1113,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 clk_dis_all:
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
@@ -1090,6 +1142,8 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	spi_unregister_master(master);
 
-- 
2.7.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbeC2FtZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:49:25 -0400
Received: from mail-co1nam03on0053.outbound.protection.outlook.com ([104.47.40.53]:60384
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750707AbeC2FtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:49:22 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <naranimanish@gmail.com>
To: <adrian.hunter@intel.com>, <michal.simek@xilinx.com>,
        <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Manish Narani <mnarani@xilinx.com>
Subject: [RFC PATCH] sdhci: arasan: Add runtime PM support
Date: Thu, 29 Mar 2018 11:18:50 +0530
Message-ID: <1522302530-27550-1-git-send-email-naranimanish@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(356003)(103686004)(73392003)(76482006)(186003)(50466002)(48376002)(26005)(5660300001)(106002)(106466001)(110136005)(305945005)(87572001)(336012)(82202002)(42882007)(2876002)(6666003)(2906002)(4326008)(478600001)(6250500002)(63266004)(36756003)(72206003)(51416003)(86152003)(42186006)(36386004)(50226002)(107886003)(8676002)(90966002)(81156014)(47776003)(81166006)(8936002)(6266002)(59450400001)(2201001)(55446002)(52956003)(316002)(16586007)(61266001)(486005)(476003)(126002)(486005)(2616005)(45356006)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2260;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT059;1:+qiVF+U/0187zp+uH7Dl7VivuBlO+PIKyIHpko/MAMJNqyC1gxCySWsPNGkDXkXKL3dvIOmYFrx9aLQrYSnkD4uNb5GPDM3vjzg4OgD2M/Sgjbjfs+sASv837BaJf685
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 891386cb-7aca-4c3e-53ba-08d59538d168
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR02MB2260;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2260;3:TaqYpWnSJJi4k3kRax6GpVblDcFkfBj7NPQYLFa0NYJ5IpTr9Vo7JWeVdwOZLz/DS/R/uCEFc3tbxcG1R6Gp//59LM7ksiqEdpFW/j8qH0oWx8lDjDg/xesn5dl5ZO+X+LO/4/DyJUdt0qSDS3FdvIXOAFxY/hNwLR8mqc8WN3O30aqSrORXQtK39s13fhLs8ZPMMUSPvLTrnLayzQ6Mt08KYD44KBnTCCdK/4ehCXD25tPe/WeebPo82A5tBqYfztZqNvXvRSqv7Or/giCO2j1msrAjHtyN+vluv/I5vdfabt2TA9W3W4/WjAzhN4Upf5w17yxyh6nj8qLXHs9cN4HiVUjpVdBDyrXka4xlo0s=;25:q8egvry3w7vop9VPuLnkxO2Ke2w7bLhKqipzx38MAc8iCZAXS/EpiKWsNpA9nG1Iv3hXXaOGdh3tyvXPlwPH99Vspjn/9cD3bhcx4OpkkOP2pm2jWZZyKUTK80dGr1J19Cyzi6lgPxQ71EI77N8+A7CmXovjAmU8dM86C/PtA4M1NufkNSoDEacqY7zV4Q4Fhb8XBNp1jjR8R/V8C0Vd9aox1h7N6TyXA7nHrYo+LDU3yXOCsiehVsen4oxbDVuzTnaUAAT6D4ArUwLkbw240ot2N4A+UFZIrcneaKQ+a9CkRshooZN1CCydqQkkjmF6LYtmCbkJm4wdq3Zj24zlCw==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2260:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2260;31:dION8NfKrkLXPhk09nTcgvD2KBRY6Q/mZkXm0VyzML0Tb1AJ6b7RXresRKRRLYXOhtoFTIcXlsu11upj9Liqw6Td21CGEoubwkCUgjpW0qQPVNrhRWCs42NToJRbKP0Gb50rVo5jjkgE6dewlDJox6zEWMOJiQJE1+l6AJUnHfbDTcEKCRzn9bGglit5j7SX1mIQ/4eZw9ZRJ4VDwhDt34QiBhxig/bzHV8W/vsQjBg=;20:9Z1NRc2ZcopVWULJzzfM93S/jyWwxs5YjxcOgHUC9uWVC+zKEEyPKH3l+xYEH45L9ganzpufWSTGErEdoUIihzaCvzNiVM0CBpsQP2q6z7+M8bM/WrYG34uu4zcEF9jjpg/IKIkKKHbYSzjtZwrSf+SBuyIsB0Ls+dQp//b/gM/psb9nFzGxdlwNh9a5s0+2rs1naPCGj77fX9OEWMM3yMUKo0Lr1amB60UEVWFP+ecKU4uhxsVsJoWet79ZeVqHa0vvcu+Eee7DFMfYos1NKLsE5wOd5ahxblDt0iNOp/CDXO7kBWCekiEGvLIP4RZcjAeuk2ltIH5s9MOmXTXVI6nkGEKqcoaeNYMJW1ib+FmAmAExKEliKuSoFSGxk0h7A8hUd8yNrGc55XTJFc8SVg6AkIBtjRuNN9dLAw1Scvu8tigqmwjVtQLOm+9iid8AY420NArAdfgzOEIKSuToqo/W/QBmEzXEER1hfm1dJ5elokNUn4X4iBfZ+4HB8W7z
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2260F7B2699265F6276C43DDC1A20@BN6PR02MB2260.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR02MB2260;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2260;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2260;4:2/zGZs5t7lLd9I9jY6SbakTiypRFli348myjqFsajCEQN/o8Yt5CQNIYO+fbtfrI01tmzMjiRpDaFYj/AE6d1BKTHk+JMmXfulMfMVpiO+K8KffGTjvMCWD7HGJ/nrN/1gclRQIcHpWLo6RZ8reNt+i6zN/mXX5wHpeWoY0KjLabCQCrpMULjXd3M6ktnQfn6LLW29S3Hj/h3Lh7n7wwSc0GMkazDXKUJtPcmpSEiSptI9fD/cCMtIV500LnNuNbIV1lRYGxgNcgix3vZ5swiNDbtiyHf24z/2+CwyHMxLRkIgg0OzGiwZ26y/0q33PO
X-Forefront-PRVS: 0626C21B10
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2260;23:UWyWDMpDytzCvMyMy8upnImmjTcQYyJjWyrep/Lii?=
 =?us-ascii?Q?9nPw+mJv91VE4sLEyhwbRkpHhg8rtLBDZdyvRjU6q4+KWNfoXaJj+sr50LZZ?=
 =?us-ascii?Q?d+0KUlRmkUDJvI/fgM1eI/o1PAaRPKg+Yz/Yg3KskFFpItxXq4I1on6uiDO8?=
 =?us-ascii?Q?+dh2uvcBec6Bk5uVv0cJd0iJhxctN2T9FVU3ulRF8rOgHxx9tWyi8RtD0OAk?=
 =?us-ascii?Q?wcLUYW0bdtHA3pwf9lPa/PE5MP7GLZZA4juo8iRHas0f0x/XAvCQnnVNbFBQ?=
 =?us-ascii?Q?kQEZHyPh9iHWCWyBMQzfE+JeHKDg96KfMd0uxUkVSDGdtOkAH4P3+r3Pu/Sh?=
 =?us-ascii?Q?UBcdje2TeR+QhesOCtmRFDWhgNI5b4Yt2m7PfbV2dFIHTkXop5DRze6gUBcK?=
 =?us-ascii?Q?mIJzfA2D+UU29nvjnPtVgK/GuZu0HdOaKGRRd9He3+8nB6c3vPRnlY11gfJt?=
 =?us-ascii?Q?JXtW6GoW1r0PyNXQaErUrZHPrHzdiZdfbBGGi7zml0uMFk36Ue3kQulgwoXl?=
 =?us-ascii?Q?+6fkpbir2gp/OKn3Vg4EtKeXtKak/Lrg2rfJUhy7sswHMXiB4YYBMgmF44VP?=
 =?us-ascii?Q?V4KFLeIM3R6lIV2oONsxfUEo2JwaSfi6jc0uGmtAOhDtIrc5f6d0XfqSpQ+9?=
 =?us-ascii?Q?o2V5NciH/F7XkmoywSeAnp3euExrEqKXepxqh807CvdUvlvdYEFl9OawOHwV?=
 =?us-ascii?Q?0Ey/moiorEv/wLtv6BWr3zjYzCzrLOam3pvmj+jHDBK+2xFwtREmnuACxhnF?=
 =?us-ascii?Q?icoUp9XKnJ2QFEfIaPCK8wW0Vebxy71csSHuHdE/Hd8ROmS9bWfutwVL7C3a?=
 =?us-ascii?Q?AndL3OMW/fhnhORTaRj5H/9bHwP3dmVUjuzdDxO99ftIzY9cMn5hVO7he3n5?=
 =?us-ascii?Q?gpMcEkei7zbZ+e8tN+Br6tjV+SmCcNbxAvO0l/r4lKsJY/LwhpMinoy6JzJx?=
 =?us-ascii?Q?40rLFYGihFl1Lh8RetQIGw5+kAsOx0dkqN1BKMMzEg9R8bThrlR+bgBICxFJ?=
 =?us-ascii?Q?hyBhj6T9hQJ3jm6sEskTlsJZKqWA1BRpVM4k7iKJSY2PyocRl+Za3FmQlp+i?=
 =?us-ascii?Q?DgiZS/C3Q469M/B4OvNQuUn5F8yWwP0bgEHckYKso8QpWOY/VeyuaBSGVdVc?=
 =?us-ascii?Q?3hyOeQulBKXYFPxc55YtjIpC6G2PJuVtCs/QodyrOkE9zKmxebpy5PP20//R?=
 =?us-ascii?Q?+0pMPR+0oIrHqLHI/0Z+VPmEDEnwHlolQUT0mqMZbn3hCUPKY+v6jvk5pwrx?=
 =?us-ascii?Q?U44BxIzo9z1J2hwbEW9fCmqKxATmNoQ+lXxzGcIH87l9iiMNja0nLvb+SUEp?=
 =?us-ascii?Q?/CuPH+eyJGdWpoOa/2UbPqM8gbXmYXD6ePtneS8+q0fr0/NgANkjxqqaLN1V?=
 =?us-ascii?Q?9xH8moyeNAF+ZIPxG65K5MUmoKVq1dq56nRQaRYurUmjxuz?=
X-Microsoft-Antispam-Message-Info: /ooCuuauWJ5snkuUGPqs9TnmRvC3cQPFucMZK4t/6H5f+XRwHQtrHp6WbQwuHY89XVylnQfKV/ZKPjsndNf1VcXwb+Elomlch/LagDfCUBPVaRVwihceOTxyzCZNVa9k+hyKX47bfNdlRB3qsbcYVvwXKmCQELF9IzbPldUg8E40S4RaedDdKMXPpfaBcA2D
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2260;6:Zt15AkG42UhU58kttFeglh9I0Yj+83tyzUz83jcpgFIOGTDCEXXi3PZyyGTvsn6t1ynEcVDcruJF20a+F+8kFr8UEYLGe6ZL8ja8sWnSEoJvRlBohytraNe5r1ZD/8kHJw+osYhQ3ZeVvhWYENVNH/oDk71J9nXRB16C/GzhHU7mz80pFYGoDcv0LJmmR4SwylvlFYzR0GKRixSFV5/o1wUBKjZGM7a228v1NbCMmHjHL/DCCtIQquktoIc8nZ/mBhQG6lwErHUEttcxQk250opzMcP2KkaZMOYEkfv4oDaxj2pb87EDlC90FNJ76W4KehhyZrTOpuUAkoMRXxDx2wZUj3/MO2q1UNNFIXrNKrTFpXn4oDMs5+6fwjzO64FVdoDyM466jg0czNS/EHuY1KseeN8I/sS0NayRRi91K+fzYpHyNIenH0HRgEx7VC1vOVNAuGc799Edif8p3CfOFA==;5:d9A/zvWv7G3pJo8cuo6PtPYYbYw+4KtRt1fK/NWBcFcWhP5HFgpX0pnIIP7SBzR+cJM3K0TtdJpMw/5taCLnT4NFC/U+b5XPz/Rb88EXodynFRGcuR7IZ0Nikcp1UFO97ICKWF8IZXBlI6QAE2zkTOXKyJuTyR0vC7Oc9tDzfbk=;24:7oqgbdkZOk7MGJt5XG98rKP9csCrJQnpUaLY+xdG+r4JHf+PhUNnydi4OhYV9sjb3WSC2p36mxWJn0iUOuZHE4MLQxUUZ4GqTBuzHag3K5k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2260;7:PEBkp5MwCRS3MLLX9Tw1koi2k9a4wFc4OiE2ZBRSWQkoohV8hBOGn3scKHYFk34atNJ7qBPeKuPKoSyGGlw1qApselGL1PEL4KszS1nHBAMQsRqusi49+PHzWB1fsGrmd+vxb5JjwGJPe+VHxdgfRHBd72/VWqwDgu1PCRFu97Z0ItzQXDSypBVq8VIZm9XmqMb7y1eD4O0dwuCnC3I7NVZ/pJlDa470f3TPA+hhRtI8BU5iHYJ/H4W64proNkwT
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 05:49:20.3806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 891386cb-7aca-4c3e-53ba-08d59538d168
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2260
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Narani <mnarani@xilinx.com>

This patch adds runtime PM support in Arasan SD driver.

Signed-off-by: Manish Narani <mnarani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 83 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index c33a5f7..47196b5 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -23,6 +23,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
@@ -349,6 +350,75 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+#ifdef CONFIG_PM
+/**
+ * sdhci_arasan_runtime_suspend - Suspend method for the driver
+ * @dev:	Address of the device structure
+ * Returns 0 on success and error value on error
+ *
+ * Put the device in a low power state.
+ */
+static int sdhci_arasan_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = sdhci_runtime_suspend_host(host);
+	if (ret)
+		return ret;
+
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
+	clk_disable(pltfm_host->clk);
+	clk_disable(sdhci_arasan->clk_ahb);
+
+	return 0;
+}
+
+/**
+ * sdhci_arasan_runtime_resume - Resume method for the driver
+ * @dev:	Address of the device structure
+ * Returns 0 on success and error value on error
+ *
+ * Resume operation after suspend
+ */
+static int sdhci_arasan_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = clk_enable(sdhci_arasan->clk_ahb);
+	if (ret) {
+		dev_err(dev, "Cannot enable AHB clock.\n");
+		return ret;
+	}
+
+	ret = clk_enable(pltfm_host->clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable SD clock.\n");
+		return ret;
+	}
+
+	ret = sdhci_runtime_resume_host(host);
+	if (ret)
+		goto out;
+
+	return 0;
+out:
+	clk_disable(pltfm_host->clk);
+	clk_disable(sdhci_arasan->clk_ahb);
+
+	return ret;
+}
+#endif /* ! CONFIG_PM */
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -443,8 +513,11 @@ static int sdhci_arasan_resume(struct device *dev)
 }
 #endif /* ! CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
-			 sdhci_arasan_resume);
+static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend, sdhci_arasan_resume)
+	SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
+			   sdhci_arasan_runtime_resume, NULL)
+};
 
 static const struct of_device_id sdhci_arasan_of_match[] = {
 	/* SoC-specific compatible strings w/ soc_ctl_map */
@@ -806,6 +879,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_add_host;
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+
 	return 0;
 
 err_add_host:
-- 
2.7.4

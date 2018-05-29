Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966467AbeE2Tjt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:39:49 -0400
Received: from mail-ve1eur01on0055.outbound.protection.outlook.com ([104.47.1.55]:44901
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965980AbeE2Tjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:39:40 -0400
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/2] PCI: imx: Initial imx7d pm support
Date: Tue, 29 May 2018 22:39:17 +0300
Message-Id: <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1527621510.git.leonard.crestez@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:203:91::23) To AM0PR04MB4289.eurprd04.prod.outlook.com
 (2603:10a6:208:67::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4289;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;3:a+xDXzDj8A14zsQVAIo7GcqBWnOHJp6aG/CsiSRvQAkLgWpOvbnhOYkRLYkBNPdTisgGXpnD/Nm/tylh1WAg3zipw2HQTNGOziyNRvQ4eOT1pZ+kSMIQWMbs0xyBnFTC4ZyNt1wPXRGaMfmx2OfS7s0MUphNFgIt4ODfprqkIlBqzrVOr8lsupbrSx4RrYefjN4P+nrPxyEmaz2cLUebQX/UvjXAIlejzfmwJ/k8X2lXnnBwB5geGeUIaqzNC+Xj;25:UT3mJussJXL8ImLoIdeSefYkN0RRM6opnnagwsdXlo7mtP8N1x0/hcCWIzI1vY8WEUSNKsnww6eTyWWoRYsTVlumKuYcZNp7cCfajnnPA07fQ6RJXfpMi4fR+SxXHjWD9D4xeDtZHFlCWXbduI9uk2Py+tFCvO6et5Ig739mHrRGRj6hm//Z/dgh4ntYHJfjoDZkJNlgKHTOGWT3MEfd0E+5pGmaLdDSPqKSkHdNMSkm5/LmqAYq1oJLDJfZ+sB5dqe7c/q02gJsn6LFPcph1w0HkXivxo07VaS/ZQUs3eY5zSZHecQO2vUpgJA6MwkSJy/5ppfoy+ujznB0cXk/1w==;31:NMHdNgo0JSO8fMYyYvmTuioYX9zk4+cSzH74BitvSqlP1+n0jrBQ+yhE6EfnlGHY/dC7InRvTUWg+lg8oArjeweL6mjQM4ByWwlmysLmTxH5yvKw5GxdSaiQm4whjV5OM+v9yTTUkKaMOZ1q2WKraGr0vCOjrkTAvFRbOyp7NPvMgGBJlIgGu2UEAjaV2AmFQzUeUaryUze0sf5crkq7Mp2eQBbugVPczLfGW7loPP0=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4289:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;20:sQtrk9fDYNUnaGY5+iTSnivDUMygEuGkJsv/Bn+3UW6uKO1wSen3eNvMNPvS5277BOD+hZfioNzyc4hHceElnB5MDAEThnqvLcI6ZmD2rAD0fgTIzfjKy7lTpZkwAjlZFLOB9Shuf40ptTfJ5+oc3pXA9J/FMc9KK2HfRwzhtfLklV/Ynw5NeN/lo8kGPObGTXB6YzW+iWbex89OYfzhrJYUqFWCiM75Rh9QYrkk+eBIFq6c86hV5teKvq0xu1i97a3Ze0dkvJaU2kd/6iuPt5TDFJkyUa2YwjMpHdxdkIviEReAUq4iXI5Oakbv3ofsFa7iAtUrNgh+jpbwgcZkE19kVJjnCB1ZUEqRn1/Zf9YN/8jrOZeZcE+CplkRSn8ghmTx/bB7kUBZdg38Xr2A061DtooJDeEgsc/GpYA4RYQz+2wb5K0RPCVp9wIWuWNdmeIVMYqwPx4mye0OP9kjNW51rPft4vGjVFvmV5co/c9wttiIXuKiHapvdQvpJj8D;4:giVEFdn71F3IwMlR9EVTJGGFY7rTTpImVePMuDGkB0dejINhZngDCDczbAcxw407k2mD/eGwQrjoXH15SZkQ3JuswCQpKvSDzAjbP67VIknIifyiuqU9ykCQJx6O57G1X1p/xGwY4nwHlW6znN1wzHC2X91xfUDuQKeG6P/C492HmK9IwA1tXUWzMTwUgdw581TVVh/8oaNbkmGiB0jQhRlD0T6QJlYy80t8vsU9Hv/dnYqReFbCZLcA1/Cn7NODc61L9PjJIkJv7cA7HoJgbYzbLsJ+XpennPqmo/7stajp2Cb94Og3uDuD2T4JlYjw
X-Microsoft-Antispam-PRVS: <AM0PR04MB4289FA04D7567453229C7029EE6D0@AM0PR04MB4289.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4289;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4289;
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(2906002)(3846002)(50466002)(16586007)(48376002)(59450400001)(8676002)(81156014)(105586002)(106356001)(50226002)(476003)(6116002)(86362001)(81166006)(118296001)(305945005)(7736002)(8936002)(44832011)(16526019)(186003)(66066001)(486006)(26005)(54906003)(76176011)(36756003)(110136005)(6506007)(386003)(52116002)(11346002)(47776003)(51416003)(446003)(316002)(4326008)(25786009)(6486002)(956004)(2616005)(6666003)(68736007)(53936002)(5660300001)(7416002)(39060400002)(6512007)(478600001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4289;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4289;23:NMA5MtGSrISvgVXiToF7BcFvsdFWiemxAAvoaFDGX?=
 =?us-ascii?Q?LP7IlhIzdfUZ/w7+Tu9aBSgZ6/JEvFeVMl+DUZHm2wpRZ4tARz91MZr5nrzm?=
 =?us-ascii?Q?f+Gopwyz3EthnFK6omvIJbR2Ot29tMpfdTDysSWzwZNjdv6lDosJwB03YEu7?=
 =?us-ascii?Q?n2aZzTHJ00RmB4jap1zWeeWTpw/MtzirxELJ1cb53SKygTC5TgGT/moOX1YB?=
 =?us-ascii?Q?gLKi/P2L2gSj20vIT0T+aBPxgfhAuNzAvgmJayQS9aI1nsjmbTCqkxxXXLqi?=
 =?us-ascii?Q?UrJg+us6Krt7+2fTjOaRo60qYcFZpBQUlR46pk96FR22U0pcpe6UBLPTOxDl?=
 =?us-ascii?Q?i2PFYjnbKq5YuYEAuu8xON7htNQ5Q33nTr8Hv13VrC1vY/ACYEhWK9fIfoMy?=
 =?us-ascii?Q?9lwHJ37GQqhq2kdHReFybohQCTA3hup50rbMb/Ff/Q8eUP01rqC6TrjtVOuU?=
 =?us-ascii?Q?+HKqkhbA3HiRlYBcWxCtpVpAzAlEKtyBM+OP7uo+r8a3KVcTNQXZQFp1t10C?=
 =?us-ascii?Q?nk1jl5FSD7tfF/Dz1/o2XmPTGmBSRXRls93O+MQJSEnTyawLTKSVh/XQk8Ad?=
 =?us-ascii?Q?DKt8lmoolHtAvIa9UnPmjNjmeP5Y4DERprynm8SEQep6zTlcYXZn/IRAzgrk?=
 =?us-ascii?Q?piiYsNfiBGIX3BvS0Zjcl2LyAsd5KrhwikDTCHNqpfjfO5TsAvQk7FgGcmYO?=
 =?us-ascii?Q?qQuOMHV/pddH5RrZc3TAOHoEseSxnNZ4zpBtgirfq1z0DziCiib4RZjPNqeI?=
 =?us-ascii?Q?w8Sx6FTB+sg0PNJ/sp98VGi16xJmIDzB93RrNZeKB/PRsoJ34CbPPOa3HnwJ?=
 =?us-ascii?Q?fUAo7ZtCo9Jp/DWRDWUacFCAdgqGqDP0yHlU3dCKkomxNTVludg0+XXR7axG?=
 =?us-ascii?Q?HPb7v0m/jhmG1Nz6cHKlzOavBSQ3tO+9xGN4mYJfa75lk4xGvxUky+Gk2JhR?=
 =?us-ascii?Q?NtLSRYf2GXA0151wtrI5w3qm+KhV0exV/hPKFy2GLCdaK2OM0cijcgFGOdTB?=
 =?us-ascii?Q?cfFi3mgWw/xFyTRKScbdWDmts0ekmSrt9AP6p2CloRa+LllSJmLcaDssXB9d?=
 =?us-ascii?Q?kDHJY5HzVK8d5UA+KGCcUzDzkt23q0ihKnmQo38paYiFyjuGqPDMQFwUgL6n?=
 =?us-ascii?Q?vXOYPy8QGsp9n81Ff+tBfo4hO6twCw5LEl1/SygRAGUGBIM8SpeXGkJ9pn0u?=
 =?us-ascii?Q?EWZVIYrSWifV3nY3ZqB/7IhnqHBCf2OF3JVdbvonUarFoVQ6LcqOTowMmGAp?=
 =?us-ascii?Q?8aswykplO6ldo9UD9McL4gxq9nOfB1nCiouDAszCY5WDxrR9mJX6jFq1IfmU?=
 =?us-ascii?Q?KU1k1A1cjI5HiAd5rkT6kyDPQ8jcI/Ffc1Kl3n1qk4v?=
X-Microsoft-Antispam-Message-Info: PO4AC2ovoRiODvgXVqUu+9vooDm+AxsrnCPUAcMDoBr7mtWfh21Gs5czq9AI56NdWKS54/0xiNiasnU9PWookE2OFd4bgTorK31T5nic6DOlRqOPiA3v7QHbgthzYaNdXcCVikm7vjaG9s24SL7LNGE3KO6Ap/VRaun3NapnYV9i1RWV4qqtxVueiAUSD91S
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;6:VWaEeL185vpRqyQR+qDaJLpAz1HfFDc0qzQTeLeNjPgLPMhc0tmPZWGsZCrnsYDwg8+q8Y+JgP7gm6C+4wTOjrV71P7rnyP2RmwZ/Ot+k2B7r7LDLcNlEzFJdyh/HWJj3+t5NBVdufS166ryj1ZtINqN3X4r2489XKBHegSYVWBi1KVze5XsHAGe+KR8BxcKMb2k/5AqY34AubYsVsL9sQzWzcHR5rPrS5cqtDRhEelNJ67bwtVYxCIhuGcGXUT8FhMZ0wTol0JyxrSdrqI8SSoHbVHcKIA+KvFFUAGze48IbIv16zhAVjH1OQGgfMoEng0uz43yWelmBsDsm85ze4DwwcEKHMTVM4R+n7zqt5+jAizDUBMSQw0a6ti9VLvvn6SqBu53Nftr1XTOONV2iGv/PkTQOHr/eNXDcSYea+/wfoW0KKUGqAHvWNdXdtpKLpiXXiIS0L55nrFD9f4XFw==;5:NfBHyxIwpKB9wb5nL8LPpk/XVavLEZY92U83eOL8FbhKUwdBREJGNfubOo9964iVtWyxtRstVC1zfXF9eMPich12KMYM274WgwwH8C/RG+qtbat6s/G7qUlB/0HvMmeOZRhZ1dFUbvOFmhdQfJ1G4pIwPh1GznKIJB0ckAJp+BY=;24:0HXY/rKfQiwRjxxkLJiogIrHIupGrtq5rDt8gzZwo9vJ9D3L3ZmFd+IRDdVlLmKV6U4LClKHFM4LZRzymzqxim1ikSvjC0QZJyLC0wNIec8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;7:HwJ+aCDUUDPYeuRsLg5Tas/Mj++KJLBwFm+T3jW/Am/gwNp/MYgAlOT9w5NN7e+L67/ezKYqnHMNYTn/UUI8dVHW4DGhJiuYtAAA+VZO3XBuxNTvyWutIO/M5pMGdaHZftHqHdZD7GXrIbwkhKGBvmp+hKpUdA1LT0rn9o9ONvlpHk9u6s35hfF0cjeWb5Q78hkZO/gy1zJFEeSsEXAmZHREZbwh9EpYIcfES/GiqasBUEQCOTr70XpqkGD82rKA
X-MS-Office365-Filtering-Correlation-Id: 553c5012-f858-4751-bf41-08d5c59be863
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 19:39:34.5362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553c5012-f858-4751-bf41-08d5c59be863
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4289
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On imx7d the phy is turned off in suspend and must be reset on resume.
Right now lspci -v fails after a suspend/resume cycle, fix this by
adding minimal suspend/resume code from the nxp vendor tree.

This is currently only enabled for imx7 but the same sequence can be
applied to other imx pcie variants.

Tested on imx7d-sabresd with an Intel 5622ANHMW wireless pcie adapter.

The original author is mostly Richard Zhu <hongxing.zhu@nxp.com>, this
patch adjusts the code to the upstream imx7d implemention using reset
controls and power domains.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/pci/dwc/pci-imx6.c | 94 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 4818ef875f8a..ff6077eeb387 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -540,10 +540,27 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 
 	dev_err(dev, "Speed change timeout\n");
 	return -EINVAL;
 }
 
+static void imx6_pcie_ltssm_enable(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	switch (imx6_pcie->variant) {
+	case IMX6Q:
+	case IMX6SX:
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_PCIE_CTL_2,
+				   IMX6Q_GPR12_PCIE_CTL_2);
+		break;
+	case IMX7D:
+		reset_control_deassert(imx6_pcie->apps_reset);
+	}
+}
+
 static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
 	u32 tmp;
@@ -558,15 +575,11 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
 	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
 
 	/* Start LTSSM. */
-	if (imx6_pcie->variant == IMX7D)
-		reset_control_deassert(imx6_pcie->apps_reset);
-	else
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
+	imx6_pcie_ltssm_enable(dev);
 
 	ret = imx6_pcie_wait_for_link(imx6_pcie);
 	if (ret)
 		goto err_reset_phy;
 
@@ -681,10 +694,80 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = imx6_pcie_link_up,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int imx6_pcie_suspend_noirq(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	if (imx6_pcie->variant == IMX7D) {
+		/* Disable clks */
+		clk_disable_unprepare(imx6_pcie->pcie);
+		clk_disable_unprepare(imx6_pcie->pcie_phy);
+		clk_disable_unprepare(imx6_pcie->pcie_bus);
+		/* turn off external osc input */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	}
+
+	return 0;
+}
+
+static void imx6_pcie_ltssm_disable(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	switch (imx6_pcie->variant) {
+	case IMX6Q:
+	case IMX6SX:
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_PCIE_CTL_2, 0);
+		break;
+	case IMX7D:
+		reset_control_assert(imx6_pcie->apps_reset);
+		break;
+	}
+}
+
+static int imx6_pcie_resume_noirq(struct device *dev)
+{
+	int ret = 0;
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct pcie_port *pp = &imx6_pcie->pci->pp;
+
+	if (imx6_pcie->variant == IMX7D) {
+		imx6_pcie_ltssm_disable(dev);
+
+		imx6_pcie_assert_core_reset(imx6_pcie);
+		imx6_pcie_init_phy(imx6_pcie);
+		imx6_pcie_deassert_core_reset(imx6_pcie);
+
+		/*
+		 * controller maybe turn off, re-configure again
+		 */
+		dw_pcie_setup_rc(pp);
+
+		imx6_pcie_ltssm_enable(dev);
+
+		ret = imx6_pcie_wait_for_link(imx6_pcie);
+		if (ret < 0)
+			pr_info("pcie link is down after resume.\n");
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops imx6_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
+				      imx6_pcie_resume_noirq)
+};
+#endif
+
 static int imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct imx6_pcie *imx6_pcie;
@@ -847,10 +930,11 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 static struct platform_driver imx6_pcie_driver = {
 	.driver = {
 		.name	= "imx6q-pcie",
 		.of_match_table = imx6_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &imx6_pcie_pm_ops,
 	},
 	.probe    = imx6_pcie_probe,
 	.shutdown = imx6_pcie_shutdown,
 };
 
-- 
2.17.0

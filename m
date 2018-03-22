Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755657AbeCVNzU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:55:20 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:8243
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755632AbeCVNw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:52:27 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <harinikatakamlinux@gmail.com>
To: <nicolas.ferre@atmel.com>, <davem@davemloft.net>,
        <harinikatakamlinux@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <michals@xilinx.com>, <appanad@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [RFC PATCH 3/5] net: macb: Add pm runtime support
Date: Thu, 22 Mar 2018 19:21:38 +0530
Message-ID: <1521726700-22634-4-git-send-email-harinikatakamlinux@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--7.673-7.0-31-1
X-imss-scan-details: No--7.673-7.0-31-1;No--7.673-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131662003443642492;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(346002)(376002)(2980300002)(199004)(189003)(83322999)(73392003)(36756003)(110136005)(107886003)(450100002)(87572001)(2876002)(2906002)(426003)(2950100002)(86152003)(59450400001)(106466001)(336012)(8676002)(6666003)(55446002)(54906003)(4326008)(51416003)(76176011)(48376002)(82202002)(8936002)(2201001)(305945005)(16586007)(316002)(86362001)(61266001)(47776003)(356003)(9786002)(5660300001)(50226002)(50466002)(73972006)(81166006)(81156014)(7049001)(5890100001)(77096007)(105596002)(498600001)(76482006)(26005)(63266004)(446003)(107986001)(217873001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB327;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT035;1:TYPrC9mbJhXg9HZHAz3UrHZmVJh3b4utLY2A515YRiaMoPAxw2YZjQxyiMmPmzVJT91FUuBMhmDporDFarsCETRj5BmQL3YnqB1LjnH7j5Vaof9lSDEO7/0Xqftu+WJS
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5953bd5-0863-46a3-4e29-08d58ffc2421
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BLUPR02MB327;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB327;3:fuw9H1AuQd9SDboypAkxS9XmpbFzqGMlPhFVp6EGaFfxebNMIw0/iw9Hc+pkN6pswVVZW87ke/W4Y6ppPSN9a8cIxv0BJI3r1b8SnBAJcl8qN/saP083Q0wRKy1SC9A77sa7342IlYrbVQOqvQu8s0mERTMaufp+aQTMTGPBFoM+xdd2QXrV7L7ZAzjYWn5T3MsLZYlgdspfH8DvndsbmvITJFMveMO/S4/48wGhpIMzeEup5ccNRHdgMinNxS+bUmYlbdV53NJ5dDrVN3ioO1N/k6t51SNeuiInvSOCmXA9LMC4/LCFEKlFmDVjGoJrkNcVhy0I5mxv39gA9ZZ+PoKsCSoYI5ahK4uBIyEGP5Y=;25:rSnsxPu6gvWilvaIz8pq4s2fLw58FuWk2+smlvniyUmkaySx+59RKSLGbe/eYht+/HI80sfZ6No2J5e3mD6o15Yy9fx4i0Q5WNMI/P9M0fiTdvMwAvlD/nVXNolOJpZy0zmb0e9PZlO1aBoMc4wYj6iFggKEW/TY2LIbIdfIqj5U9Ii/1Cn07wWDHe0EdM0hdrCJPFI6eES2ymeVLLThro30dpuHQNeXZIKe4SRbwdmywR12DvS7le2e58ixos47pVYeOEz8JHf0EowgCKnVDCLo5lJlw22GWoR5mecDXQtdMlRZNZGifp7VvdonxNS4qzLMMFbF+iMih3fZQaRNtw==
X-MS-TrafficTypeDiagnostic: BLUPR02MB327:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB327;31:5qS6bZlR/yE24MJJSy+CvDmrbf80CAGsbHsCYp55FhlUItKYo2xOtgRM/ISyW9uobg4KF8LPgkr1IK6LD65wNkNBZ0FFFcehCPTG074ZHy2xY+eEBxf0pfFKIe175yKVA2k9B+qsaubIsce/xJAejNMCBtNKOeiIpn+di53Qhj80Uj1/ZjXf+pGmvifM/QSRWOQMfNT4H9SjA2aGAu1LafXkO9S0kCmq11o+1mCDs58=;4:LO7tiN+Ncc5P/iO6mCTR3qGWBGQqa1UtlGuKYQ/PPUcqyFerZrrfSbcvWnq5ez7k0LokfUOZm/NfV5VP1vAdNGyZUUoBylpiXDUfEcXRF/ZRaWV9aqNmefvX3Va1qrCPW63CSulwxMosx89FowV2dHhN1iIqVPy9Te0124kOdNmFKTMBLrcV2On5Vv5Q0mHY45rdCebLphPzytGpcVt7ePZS6y/7DTNeaJcSzSLhvorFQL2mRV2AiFREdaRuEqQEcKl+PU38u14ovcGSV7eIP4SWo4GgrLAgf5RkJ0O/oifoZ9UD3/MLb+Y5yxbqp25F
X-Microsoft-Antispam-PRVS: <BLUPR02MB327279C52A522860275BCFED0A90@BLUPR02MB327.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(6055026)(6096035)(20161123565025)(20161123556025)(20161123563025)(20161123559100)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BLUPR02MB327;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR02MB327;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB327;23:uc45tgqsp/jTkx7BOzJySut3Ai6qrneFlPJIAJUQlF?=
 =?us-ascii?Q?b8ivgrZ86LVs57B6fn3JqTCBlE3UlGoRyWWvyqCGjlp/oZ3sQfknQOFTNay7?=
 =?us-ascii?Q?WV/fiU4U1Rl5jc1o7Mtn7JtWdhzFB9WATwFzjG9w1KJQsz0wDYo0wkf7IKHy?=
 =?us-ascii?Q?cHi9paIwvoAhm6MUYQh/WPcsgKay3eHYkxsVRBDhkJMOHjSB/WCHolcs6Po+?=
 =?us-ascii?Q?dschMGuBpQj2rmk1QkLl1yMf3n7/rBzXMEfnWuUjY+qsup3Cr6pup092VKrl?=
 =?us-ascii?Q?h80xuUrLFHq00C/ntVcskXbrhYRlibfg65usAb+oBDlrrtAM3/tv4DyIm7xP?=
 =?us-ascii?Q?SwIGgOKj1iOsHL94h1fhOmf/F64q7VTxjOoovIh4c1vH64R+W0vwI+eppzhF?=
 =?us-ascii?Q?P0bogcPb8obBfQ/HYQjhOduoZ/w0K6XAESdQDzVXEWXW5CVHgyenbILOrlbg?=
 =?us-ascii?Q?7wzseAddmU90Jrn3A4p+63sohZKBStJ2Kg7I1+htEsY7rCqBNN/xwCchHZKE?=
 =?us-ascii?Q?BhPFrP+PaPEsTYbh9jeGGCgd1uj/mARyiWafuWnWBioMhdGs2A7pSEBOL8tX?=
 =?us-ascii?Q?dSU+fs/lFi95MeMPXomjGl+g1zGP42jfS05tpg1JrL1b3AlqsevTcdmJmMSd?=
 =?us-ascii?Q?C1YXVHdJkS9Xrq7VMIjIS5gAmVcanmOzJwbD+hvNMnPYS4iEnR0DpbVIeYN7?=
 =?us-ascii?Q?K61XnFZS1KPJhd627HamHwWweTTd9PPSotLVjY8WHGywRasrT4lOsgrjZ5Gi?=
 =?us-ascii?Q?/0vEpIBlKcKcOagYzU2flgyJKtyhvfqC5zYDOeATIJtq6nOXOjcas+2+PCdx?=
 =?us-ascii?Q?hvo4ZKZOafYDkiLWgHqXY09BRil+2bTqhiORQbTafU1JzE8Tl200MahFC14M?=
 =?us-ascii?Q?G39TMZ/nf9toGXEJ6ak8fSauTNEwS7tAKtCtQYMYFbQD7/gy/Pt7BaFAixLv?=
 =?us-ascii?Q?MQ2fghPYfKfPO4PTmUhKQ8pRbEnTD6yVr0Rr49sDcB8xpjkuabvxKtf0qAnK?=
 =?us-ascii?Q?fCWW5b16NP0lrIbvx1Pv2lLwqBtS8FCmhcmXhDoOzaqpnvzOHc9qAcVov/z6?=
 =?us-ascii?Q?NbO/YiAfyrLSG/KSEyf7OJnz+oASatF2NrzAv/3nf5UETxK68nc3GAirtKrp?=
 =?us-ascii?Q?WSqnt9YTF/6XjCLBjwvuP/q+uUX5K1Mn5UsDNJcdrfj2e4IcPfTLDSJpTPmm?=
 =?us-ascii?Q?ytCQ3HBroVPvcvAfFX5w/4WuP3KwAvrwrPyXs8veZEHcx7sbnp4ZQ+w/c+1s?=
 =?us-ascii?Q?CZ7ssyPI54Is4RuisCPkuP8aD8PaGxbtCeKehkpRYPWc4DWtj3QXS20CQIDb?=
 =?us-ascii?Q?xIS6/fqESpoW/kkhtE4UlY0aqs2Lf0XSI0G3A37dZCs6+LUGRo3zuk0QoNZC?=
 =?us-ascii?Q?2CbKGzwVRmAwhkvIKTsmCJFPndOcLwDH2PoWLHk+ahRLWL?=
X-Microsoft-Antispam-Message-Info: Tc1X4+CNMxDDN5UxlSmt5Z0hmsX5SxNu353UwA3vdrbdp0OzgAqqLA/MdxljOdZSlS5sG63ErEFTLAxNRnrYI3SvDbDsaU87qQNeTQug6O8pNPJ348MzQHq9PqeFuhw6Gdu8J6F/urhQ60a59ecygmZfnJby45S7SG1GAB2n2Mx8MyCxeIJAmb7EIXG+94YO
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB327;6:9bcfAfHXrr5Bfn/j2dq6L2sBnuIhNDYkl76hzelLEsXLWxC0yLEbqiD7pNdv7M3hSsGe75js20gOS0pRdW7cRgfPBPbFBOVuIek8ODUh3OBw3MBfIg6ATA605NqsPa6KK1CvJYZ785PhszRhByb1edVYC21C3Go1mxJWNmtU8Su/IJnrYqVNtdvTdu/EkC6ruGEJa/w/YB0ekKKoJYL+nCyQJSZB3SJWKuYLlYB68dLzrD5JAaJuo8rK27APU0HFGw5pjKcwjGclR8H/EdWw7SXXHikRVnr6GFHRYmxauPE8+hc2e1w9zacvCX9AtGlJJwxpEfysDrSoxTT170Rz5DEiRiVn62/LzhG5lULzcl4=;5:yfpKdt0bu7O2Ei3PENOdzoUAUlJTJ3apmTWs2aFwEs67TYMz9Oh/AHZAhDgrzqPMKihIGXN3SNTCbzM6DPIsaAY1y4mVtOw+Pa3YVVDj5vWiblLQdcltnO24AH+dlw9C4VnLnKZC2wMChS376YKaUPDbBb1U/DJRFd1INUk9Bu8=;24:KazuB4+BElc+/wL4g+o7OZlXWRl8wXOnAdRUK8d9i+jggmdaSI/qwrEnx0eYxlXv2o5ykY/M0cvnHIYhEEbAA5i+iaVVFoAK4iQki+T+QDk=;7:z0xncfoLvwGGjCAPrGjaXMpXn6LtdBHNsj30K2IPrHltsIVpe6OuYeGIx5M1/LUM1abZM+XFtXtNpwr5AzCGDaCGDtGmOCr/i5teFQw/fgdyZlxzf3xPgDHfrzOnl/N3rczj6cOi6TOlrCGlNzK+dngT8LS8tKsO1PS6q1rxcdV1r2rZqtZWtK44vA8XMUq2J/aICXZt6dmnKjARyB3hd+EjZSO+e7uOk5wxg5aX55fO/FFN3AXaxVxULs1vEumS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 13:52:23.3798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5953bd5-0863-46a3-4e29-08d58ffc2421
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

Add runtime pm functions and move clock handling there.
Enable clocks in mdio read/write functions.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 105 ++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ae61927..ce75088 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -35,6 +35,7 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 #include <linux/tcp.h>
+#include <linux/pm_runtime.h>
 #include "macb.h"
 
 #define MACB_RX_BUFFER_SIZE	128
@@ -77,6 +78,7 @@
  * 1 frame time (10 Mbits/s, full-duplex, ignoring collisions)
  */
 #define MACB_HALT_TIMEOUT	1230
+#define MACB_PM_TIMEOUT  100 /* ms */
 
 /* DMA buffer descriptor might be different size
  * depends on hardware configuration:
@@ -321,8 +323,13 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
 	struct macb *bp = bus->priv;
 	int value;
+	int err;
 	ulong timeout;
 
+	err = pm_runtime_get_sync(&bp->pdev->dev);
+	if (err < 0)
+		return err;
+
 	timeout = jiffies + msecs_to_jiffies(1000);
 	/* wait for end of transfer */
 	do {
@@ -334,6 +341,8 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 
 	if (time_after_eq(jiffies, timeout)) {
 		netdev_err(bp->dev, "wait for end of transfer timed out\n");
+		pm_runtime_mark_last_busy(&bp->pdev->dev);
+		pm_runtime_put_autosuspend(&bp->pdev->dev);
 		return -ETIMEDOUT;
 	}
 
@@ -354,11 +363,15 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 
 	if (time_after_eq(jiffies, timeout)) {
 		netdev_err(bp->dev, "wait for end of transfer timed out\n");
+		pm_runtime_mark_last_busy(&bp->pdev->dev);
+		pm_runtime_put_autosuspend(&bp->pdev->dev);
 		return -ETIMEDOUT;
 	}
 
 	value = MACB_BFEXT(DATA, macb_readl(bp, MAN));
 
+	pm_runtime_mark_last_busy(&bp->pdev->dev);
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
 	return value;
 }
 
@@ -366,8 +379,13 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			   u16 value)
 {
 	struct macb *bp = bus->priv;
+	int err;
 	ulong timeout;
 
+	err = pm_runtime_get_sync(&bp->pdev->dev);
+	if (err < 0)
+		return err;
+
 	timeout = jiffies + msecs_to_jiffies(1000);
 	/* wait for end of transfer */
 	do {
@@ -379,6 +397,8 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 
 	if (time_after_eq(jiffies, timeout)) {
 		netdev_err(bp->dev, "wait for end of transfer timed out\n");
+		pm_runtime_mark_last_busy(&bp->pdev->dev);
+		pm_runtime_put_autosuspend(&bp->pdev->dev);
 		return -ETIMEDOUT;
 	}
 
@@ -400,9 +420,13 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 
 	if (time_after_eq(jiffies, timeout)) {
 		netdev_err(bp->dev, "wait for end of transfer timed out\n");
+		pm_runtime_mark_last_busy(&bp->pdev->dev);
+		pm_runtime_put_autosuspend(&bp->pdev->dev);
 		return -ETIMEDOUT;
 	}
 
+	pm_runtime_mark_last_busy(&bp->pdev->dev);
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
 	return 0;
 }
 
@@ -2338,6 +2362,10 @@ static int macb_open(struct net_device *dev)
 
 	netdev_dbg(bp->dev, "open\n");
 
+	err = pm_runtime_get_sync(&bp->pdev->dev);
+	if (err < 0)
+		return err;
+
 	/* carrier starts down */
 	netif_carrier_off(dev);
 
@@ -2397,6 +2425,8 @@ static int macb_close(struct net_device *dev)
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_remove(dev);
 
+	pm_runtime_put(&bp->pdev->dev);
+
 	return 0;
 }
 
@@ -3949,6 +3979,11 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, MACB_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	native_io = hw_is_native_io(mem);
 
 	macb_probe_queues(mem, native_io, &queue_mask, &num_queues);
@@ -4062,6 +4097,9 @@ static int macb_probe(struct platform_device *pdev)
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
 		    dev->base_addr, dev->irq, dev->dev_addr);
 
+	pm_runtime_mark_last_busy(&bp->pdev->dev);
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
+
 	return 0;
 
 err_out_unregister_mdio:
@@ -4081,6 +4119,9 @@ static int macb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(pclk);
 	clk_disable_unprepare(rx_clk);
 	clk_disable_unprepare(tsu_clk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	return err;
 }
@@ -4104,11 +4145,16 @@ static int macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		unregister_netdev(dev);
-		clk_disable_unprepare(bp->tx_clk);
-		clk_disable_unprepare(bp->hclk);
-		clk_disable_unprepare(bp->pclk);
-		clk_disable_unprepare(bp->rx_clk);
-		clk_disable_unprepare(bp->tsu_clk);
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
+		if (!pm_runtime_suspended(&pdev->dev)) {
+			clk_disable_unprepare(bp->tx_clk);
+			clk_disable_unprepare(bp->hclk);
+			clk_disable_unprepare(bp->pclk);
+			clk_disable_unprepare(bp->rx_clk);
+			clk_disable_unprepare(bp->tsu_clk);
+			pm_runtime_set_suspended(&pdev->dev);
+		}
 		of_node_put(bp->phy_node);
 		free_netdev(dev);
 	}
@@ -4129,13 +4175,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		macb_writel(bp, IER, MACB_BIT(WOL));
 		macb_writel(bp, WOL, MACB_BIT(MAG));
 		enable_irq_wake(bp->queues[0].irq);
-	} else {
-		clk_disable_unprepare(bp->tx_clk);
-		clk_disable_unprepare(bp->hclk);
-		clk_disable_unprepare(bp->pclk);
-		clk_disable_unprepare(bp->rx_clk);
 	}
-	clk_disable_unprepare(bp->tsu_clk);
+
+	pm_runtime_force_suspend(dev);
 
 	return 0;
 }
@@ -4146,11 +4188,43 @@ static int __maybe_unused macb_resume(struct device *dev)
 	struct net_device *netdev = platform_get_drvdata(pdev);
 	struct macb *bp = netdev_priv(netdev);
 
+	pm_runtime_force_resume(dev);
+
 	if (bp->wol & MACB_WOL_ENABLED) {
 		macb_writel(bp, IDR, MACB_BIT(WOL));
 		macb_writel(bp, WOL, 0);
 		disable_irq_wake(bp->queues[0].irq);
-	} else {
+	}
+
+	netif_device_attach(netdev);
+
+	return 0;
+}
+
+static int __maybe_unused macb_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
+
+	if (!(device_may_wakeup(&bp->dev->dev))) {
+		clk_disable_unprepare(bp->tx_clk);
+		clk_disable_unprepare(bp->hclk);
+		clk_disable_unprepare(bp->pclk);
+		clk_disable_unprepare(bp->rx_clk);
+	}
+	clk_disable_unprepare(bp->tsu_clk);
+
+	return 0;
+}
+
+static int __maybe_unused macb_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
+
+	if (!(device_may_wakeup(&bp->dev->dev))) {
 		clk_prepare_enable(bp->pclk);
 		clk_prepare_enable(bp->hclk);
 		clk_prepare_enable(bp->tx_clk);
@@ -4158,12 +4232,13 @@ static int __maybe_unused macb_resume(struct device *dev)
 	}
 	clk_prepare_enable(bp->tsu_clk);
 
-	netif_device_attach(netdev);
-
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(macb_pm_ops, macb_suspend, macb_resume);
+static const struct dev_pm_ops macb_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(macb_suspend, macb_resume)
+	SET_RUNTIME_PM_OPS(macb_runtime_suspend, macb_runtime_resume, NULL)
+};
 
 static struct platform_driver macb_driver = {
 	.probe		= macb_probe,
-- 
2.7.4

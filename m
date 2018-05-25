Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935558AbeEYEoD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:44:03 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:7434
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751988AbeEYEmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:42:16 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, <claudiu.manoil@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
CC: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 3/5] net: ethernet: gianfar_ethtool: get phc index through drvdata
Date: Fri, 25 May 2018 12:40:36 +0800
Message-ID: <20180525044038.37756-3-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180525044038.37756-1-yangbo.lu@nxp.com>
References: <20180525044038.37756-1-yangbo.lu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(7966004)(396003)(346002)(39860400002)(39380400002)(376002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(446003)(476003)(50466002)(2616005)(76176011)(5660300001)(97736004)(48376002)(47776003)(106466001)(36756003)(39060400002)(51416003)(81156014)(11346002)(126002)(336012)(1076002)(316002)(508600001)(486006)(110136005)(16586007)(8656006)(105606002)(44832011)(2201001)(4326008)(8936002)(77096007)(6666003)(8676002)(81166006)(356003)(305945005)(26005)(53936002)(50226002)(2906002)(86362001)(85426001);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR03MB2183;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11OLC004;1:MbXaaiL7LuMklDlh8H3nRHhnwNkplxgdDd/tIjYKtWcxWqzpAGOmUUEdhlLgaoDCGWNNwo1+3g2v1DK3Jm4/DBePhMhyiYwEy+xq+zzDxt+WXwMJNy22qh+LK30TeZvd
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(2017052603328);SRVR:CO2PR03MB2183;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2183;3:8ZTUv3R2sYMcBArTaLiJ+V2y58ZpZpMu9JgzN7kgwiYdDVr51z73HeBenHn3B7GdxKB9QrfUl+s+IB1tx9Di8GgQegHMmKxBqIRAaJqdTc+1F3AdUwe6tLgqTfOm0TJh1RTOcPaYjELuHhxDIOKmD6ylBj41Rl+Cwp2I9xFWivw7vnUQ+3mmQIJzZIh3ryRE73JybJOtmEbyrHlZXLNIb7h1H8h+SUktGiNceS4ST0cLjssuG5yf3tOyKDDggJg+uogwRBOVFyb7421bqdq2lK/rYVC4r1Twzp+C3i5gqX7bEmtUVAk791GC5lYZR6Ws4+o+934fu15BG2YuMmdjOblYb4ISZ/RK/80ohUdDJ6c=;25:wgGuH2x44P5ABU7CZ+0lcLnfFtbr4SlzQkMDLmIxOqR0+0Gcy5nOuHByvYGnHeYPCZnnZINGRhKzyNRdwH3i2q/OayXaasTSsARrOqDlIgNwWb58CwNCseSk/Np2VUOqGtcQapp5QytnBwmJ4olQnJD1LjtP3zOR4n72xb2XYIFcrupuwQAjcYKJfeRuXWfAcgQWYYJWbcLCYZja2J6wInYLAEVJ21OYSGhmJHVpFlyqDyquYoWGC6IvWtZMXSxf1IAfVvusEVPSc7s2OornptYPFgd2U0Ex7kZr/Y2YTApR9Dyqdv9bKe6/vZOqwpyakmNZwAYzo8cBrmt/hx4CEw==
X-MS-TrafficTypeDiagnostic: CO2PR03MB2183:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2183;31:NB5zhI7UIArI0FADYO2+G7QFLKV5CPttV2AZH9GFF2ELTmjWiD5MAJ7S8AGunQArXiBkGp3nvlnNXuYFopDmgMfms1LbD5ee+h+1enACA2aHLAH8uaE4y+dNi1+eW/WSMXLKRCEcsB4rXxuxfwc09i1fwISFOqdcY7Z5sf6zeRj/jMkRq2zmz7TycfDcUKhRHspK3W5hIaykHSWEhUwhnkQE295CMAE6cBCo74AVWR8=;20:ZsWkcaP+FxdKuxUA+uWotYY871p5w7L4C4hSQdThnVWK8UBMQSr7/XCIPwqAUQjP+gcgjgnP5hnA112nfS7Y7yAdP4NFSwmTVDEGpRGmpYzr2CyMoKpowIlhipK3snj764TU4nZEprCX1PREUc/SqE1+HVYMdLn0oIlOJMu5g0yq+HiBFLrTMdHYHya0DgezYGd1uLlpGA0DrVz45myZ5hYamgMojY7tamrGK1e6QsHnFaNBaAc+WAoncin5EUYbdsm55B3Py//Iw/N1jqeh5bZgwqYzw4xgozRY33VSAr4jZ3qlLNPF6rQYygICyw+JspMpU3h5Wj7cAFwVU0yEbSqs02LyL1kqmHoT6P7aN1k32ml9VNGlIlLivXvDlFdu/RXGNdZttwNdnCKD3gm/xg4uqHmdTunRR2ZqT/HX1lXnTA+E4lTq66wIESr8zehLDhAfG7SUmlZib9zjmwin7+0cwqrlVzpYYBliZ6RqjrFnKPo2rzrL2T8u1lDVqc96Y8xgWcfrklnlmoGVhpEHs1S2kulWIcqjxC90gcOvYkIZFSfYlyeTu89ZzJNsu8cUj9j8Yd/LLTJXGuRBeJBY28hd2zzK5ekxSG1I8n6JzOg=
X-Microsoft-Antispam-PRVS: <CO2PR03MB2183F34836483A7DE9DBD53FF8690@CO2PR03MB2183.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(6041310)(201703131423095)(201703011903075)(201702281528075)(20161123555045)(201703061421075)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CO2PR03MB2183;BCL:0;PCL:0;RULEID:;SRVR:CO2PR03MB2183;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2183;4:WumJFD/riHGpGgUThyiJ68sIN+LQSffvg0G4+6+W/13/AzlZ5/e9MfRaebgee0deJF9QLKe7I4YpuH/y0qpUYw2uUnwDWgKRnY6+whNWAnkyfa+6aMKfXrbJPOqc5i5Gsi+ipd1XxaWGzVOfv5lxV7apiAMow8cXTdG9dOIRS/Le9IaDyCiHl1ibsic0vgh1bKgv8lFMwTdvP4QCOHwHfKsC6YdMRs/GDhCOptzuIzRh8Ax3b/f5qCjeoaC5NhP+mkuijHfHOnp9M4/0AzDQ3DmIF0aiovjObtCES+vKF9RsisCg2G0IC4PxX27dDfGF
X-Forefront-PRVS: 06833C6A67
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR03MB2183;23:2VT+EPkMxZntJANdB9SwNeGCXFJZ/vVIw09JO08QS?=
 =?us-ascii?Q?ZNCew8bIeHxcKNtPfqL5jpTIF+tKwEb8VNtezxmtLLOd0sLj7m1o2r94PJCA?=
 =?us-ascii?Q?umHgl3cqcgU1GGNUq4sN9kxxVLafmhHj4CS7d8yjQFPiP9gRz+ogoe3h1Aot?=
 =?us-ascii?Q?TZ2+7C9KnyZVDszC/IL6pYfQ3FcBTF+kEks6mKlX3lPLids9qJQKzfItbKRu?=
 =?us-ascii?Q?+2jci2BDQbO4xuwcyf3/c1/f1M8D8u1r/9EMyRIezdYdXSPFQJeV6lwwDHu9?=
 =?us-ascii?Q?2Rzmsr/qWmWZJBBuVYcjkaJEsmVxf8dqjm3PiB24a+IGDrJfFLxdKUufxfbF?=
 =?us-ascii?Q?E+dJEuXopaO7c0sDNaCSxswucjirn4RdOlluKWqzzLLnfNWfdJZvV5EMmkEk?=
 =?us-ascii?Q?co+H3je4ehQskn9YgpGkmYc9KTufjgWmzr6Y++rcJq6HqrR2Wa8XScJHC9O2?=
 =?us-ascii?Q?exQiF4vrElI7sI+OP4z1gdTLN1X0zO1vI9Mqe7FSKep8/EBnrGUpgyM5wIAh?=
 =?us-ascii?Q?JA/1+YiPjdXsPXwte67D4wc+6JDvY4gfc2x5/DsteeHnpDBYl7W8o9irHef5?=
 =?us-ascii?Q?BrCmzLJmobEEUE10qZ+NAcChSq6sEkE9NtUIw+6uznr24ShI9s8Ixh8cfgH8?=
 =?us-ascii?Q?6fiqxcrJ2WRTSTxFsFro4Lxm/ciGdiWb6307G+qBMu7xz3rpuzFcoyGPbw1c?=
 =?us-ascii?Q?hVH2QIcgj+2P5NyTh9g7RhcyKLdSEwJ0D2CEt65QF9dyMHbeYycCmxlEJoXr?=
 =?us-ascii?Q?7LdThMyuNrYCwU2K8qGrTXy6I7aOGCsDbIP+3q2gM/6yA7vuZahL5oDUDB62?=
 =?us-ascii?Q?AOjs8WgyTTCxDs36mO9kE5ItV2fdkzVLanU/sGxPgKKdyrB19HKL32W8QZP+?=
 =?us-ascii?Q?qieHTgoBItTbjP0X/YuHGe8Q8kIX3cSDpUEvD8DfYT7ECqFXZ9QlLk0SKsiJ?=
 =?us-ascii?Q?AY0/dTrwPLHILKvUFR/XMBS/0+1sQvSXNHUiO4nBAIPG4bMbMxYLmWpGdhVE?=
 =?us-ascii?Q?YoSUOc9YuhS3Wb4WKcsPE1q9r5RVoqe620CzwrG+0eRPEEZ8qLbNsDLjGkAK?=
 =?us-ascii?Q?nhuv+Tf4Uhjc/VNbreZTwfFjn/qJHMupGTdoppE0lY+a5ADvHsID3XaKzbof?=
 =?us-ascii?Q?EzP507kwx9FPnSDJm6Y8rKiXwcug3bH7D7uOU/9EXyTg98JmHaZh8a+hM/AM?=
 =?us-ascii?Q?VMzWBNi4jl2yZF/s0fYpFsh1x/KVJghVYDd?=
X-Microsoft-Antispam-Message-Info: 7kAzVznDJudGZ3KnK/lxgS9QImdYZBTxvYdBT0yjZdJ4j1wKTZQ126IiuiWHa8BtfVtF/gWOqo8DuZDamD+7gqZBgtP4mnuSlPHsedlacdhGTPb+vb2ae9q4D+dGFGBWHOjSezNAiRwiLps7jXqeABnuovlRCQ+lNQyUUbYhlP7umAFl8D5wtdw0Zk4gaUeY
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2183;6:L5WzC1q8Y979MUslDmOoEkuppS2OzzvYkR6SCyauRj7NbSmhobw5ThLjGExYdSko1aOKBGk7b3gU90UxDcCYfY0wm6dOoscmxcdTEBDoByAO9+Tr1bCZyE10L02OLQdgC7jbP7bCMHyX/t7UR8fRcQt0kwJgvMKxusafOjrbNoJtzMpc/NrVMaDnl0M02zZT5IaiyJWiyI9MfH8FnjmNOx1p8lfePFCfIWHe6KVFWYuW1ASW1sbmr5Blc2WuQ9EY/tgBqZB5VernBYpzEHp61Z/LO6y/9iYAbAcNOHKUyHrcEmSWSF7XUdtZv1AKzbsd2zdTWa+UMrfpD0Xnvz4hurjLjHn+mN7TJH5qTbSWgSit/7GS9VA9Kgd2uyuOPeKbhY0QR5h43WLSNPD/gQCaFQCTfa8YaxiT1XeoxQKnRcgJw7Z+DeNdCyGSptX43/IISHtM2M75d6zajhhMNNlpfA==;5:Bb/LFk8SEcmrU4rUdHypOkIPvl25Sow7RaX4mYwN9HQ+d8Y3sinqcB2fhzHaDMsta0LdVGo4jTtkV0KPUgHqgO5p3Rmg0ciOzCWsVG4nr2thaEF2srkDsegJyrNC0Fm1r5VesadFsyQilBl1RC0LURW/W1tEC7ybGVeb0DWcz+c=;24:yS90D5jJr70ByXRZKyZg6khI6ykscdZzqtKheI9CyNd+pC7ut5475A+Uvr8vo1iYegCrpSAWtmcC90b/dNZhG1s/wI1OsQQRyNS8xDtBcr0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2183;7:8tXczOQntNgYal/5kOI2JwGMF4Rat6tsdWKl3a4s3iNN75fkqAt1DoKVb/bLY65ZnHwu0QH1u8RzE9BkoI6YDK2dbNPi475DMm2NkxJblvKXc/xMnlV+22zuD0YApgO/hs77rtH4cqLTk7Bjb49HeDhiXyCl8Vpa8GXwW2/fglDyHvFgGM1YpfHl+lREowAAcF2ZDaWEMWPBnLeIX3x1ZJJnvJeFDXuLNoDag/osmKoLhd7MTbZD8I57w9hfG64s
X-MS-Office365-Filtering-Correlation-Id: e501162c-8ef4-4405-8431-08d5c1f9e1a0
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 04:42:11.7487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e501162c-8ef4-4405-8431-08d5c1f9e1a0
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2183
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Global variable gfar_phc_index was used to get and store
phc index through gianfar_ptp driver. However gianfar_ptp
had been renamed as ptp_qoriq for QorIQ common PTP driver.
This gfar_phc_index doesn't work any more, and the phc index
is stored in drvdata now. This patch is to support getting
phc index through ptp_qoriq drvdata.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/net/ethernet/freescale/gianfar.h         |    3 --
 drivers/net/ethernet/freescale/gianfar_ethtool.c |   23 +++++++++++++++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.h b/drivers/net/ethernet/freescale/gianfar.h
index 5aa8147..8e42c02 100644
--- a/drivers/net/ethernet/freescale/gianfar.h
+++ b/drivers/net/ethernet/freescale/gianfar.h
@@ -1372,7 +1372,4 @@ struct filer_table {
 	struct gfar_filer_entry fe[MAX_FILER_CACHE_IDX + 20];
 };
 
-/* The gianfar_ptp module will set this variable */
-extern int gfar_phc_index;
-
 #endif /* __GIANFAR_H */
diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index a93e019..8cb98ca 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -41,6 +41,8 @@
 #include <linux/phy.h>
 #include <linux/sort.h>
 #include <linux/if_vlan.h>
+#include <linux/of_platform.h>
+#include <linux/fsl/ptp_qoriq.h>
 
 #include "gianfar.h"
 
@@ -1509,24 +1511,35 @@ static int gfar_get_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	return ret;
 }
 
-int gfar_phc_index = -1;
-EXPORT_SYMBOL(gfar_phc_index);
-
 static int gfar_get_ts_info(struct net_device *dev,
 			    struct ethtool_ts_info *info)
 {
 	struct gfar_private *priv = netdev_priv(dev);
+	struct platform_device *ptp_dev;
+	struct device_node *ptp_node;
+	struct qoriq_ptp *ptp = NULL;
+
+	info->phc_index = -1;
 
 	if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER)) {
 		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
 					SOF_TIMESTAMPING_SOFTWARE;
-		info->phc_index = -1;
 		return 0;
 	}
+
+	ptp_node = of_find_compatible_node(NULL, NULL, "fsl,etsec-ptp");
+	if (ptp_node) {
+		ptp_dev = of_find_device_by_node(ptp_node);
+		if (ptp_dev)
+			ptp = platform_get_drvdata(ptp_dev);
+	}
+
+	if (ptp)
+		info->phc_index = ptp->phc_index;
+
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = gfar_phc_index;
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
 			 (1 << HWTSTAMP_TX_ON);
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
-- 
1.7.1

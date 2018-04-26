Return-Path: <yangbo.lu@nxp.com>
X-Google-Smtp-Source: AB8JxZrPPdBtbnsJzbdXYo2iYsRYGg7MC3K1W4CYe20B/sUKrUzun7CPQxsjxmgyaQ2x6UpBeYl3
ARC-Seal: i=1; a=rsa-sha256; t=1524738282; cv=none;
        d=google.com; s=arc-20160816;
        b=ptyK1vtcu46eIjQIMx+EJ7qqO/IYw9yXXkvbkPJM9G/yLCq5RsDsxdGiBD/L8Q0ghl
         1qIT8+asNA7i4OYqWUfPHQsQKDjt9IhcYy0HUiIAmzjE0bO+tNdTbKHUn+bSxXqTe6LE
         w2hI9zJ50YgmooCxhyZ0EiyJgw1m5IuYfw89m4XBhvLFnY6QQFjxO1lN98/McVXPHTu3
         +tn8CAufFPEezen0KYP6jw76KE22aG9kAQr+KtZEQRrxdXiWP3Fb6xc+AcutvmSS6nJj
         Yh+ec+Gr/w3yO/t+i7++bUGOsyk/Rf5fkI8a7NuO+RMhnw2VpME9WZNqLIbugKCnzhBH
         YlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=8dglrOq8efVU538mHT+ge++lZlfVWo7QVMulz9E7+40=;
        b=qqqySEN68Tzt/JN/2PwtChEkU2FQfzO9SV6JuvqA8CG+iH7+eumJ+18upNPiT3vh96
         2ZrrE/tVvhWUcKPMNq+jE60JZR8lPZfo4gCD1M2S49fBEbf0KFppGfuCN+I2S78INW5z
         uRQ5WiYW5mwf3lrP3AEZM/xmnQjeyXaOvbGBi0AnqHPwLHpmdcO0OQB8ylRwBHlrDWJn
         Ri5knIyKOqAmYIn0fbq3cYEMKXyxjuCUPhV19tlMME+i9EYViEga3ixNpnRnxaaQk6Kk
         MIn0z41zj9AmXR9lBFVvP7EO3wDXtsT8+5OEB40B9z/CstMnuYBK5ADz7PlYGzL0G38X
         AhfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@freescale.onmicrosoft.com header.s=selector1-freescale-onmicrosoft-com header.b=TOLUAJ13;
       spf=pass (google.com: domain of yangbo.lu@nxp.com designates 104.47.33.135 as permitted sender) smtp.mailfrom=yangbo.lu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@freescale.onmicrosoft.com header.s=selector1-freescale-onmicrosoft-com header.b=TOLUAJ13;
       spf=pass (google.com: domain of yangbo.lu@nxp.com designates 104.47.33.135 as permitted sender) smtp.mailfrom=yangbo.lu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=fail action=none
 header.from=nxp.com;
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran
	<richardcochran@gmail.com>, <dan.carpenter@oracle.com>, Ioana Radulescu
	<ruxandra.radulescu@nxp.com>
CC: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 2/3] staging: fsl-dpaa2/eth: add the get_ts_info interface for ethtool
Date: Thu, 26 Apr 2018 18:23:48 +0800
Message-ID: <20180426102349.45222-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180426102349.45222-1-yangbo.lu@nxp.com>
References: <20180426102349.45222-1-yangbo.lu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(39380400002)(346002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(5660300001)(336012)(8656006)(47776003)(11346002)(305945005)(2616005)(53936002)(110136005)(8676002)(498600001)(356003)(48376002)(44832011)(316002)(36756003)(476003)(446003)(97736004)(50466002)(486006)(86362001)(126002)(81156014)(81166006)(16586007)(39060400002)(6666003)(4326008)(6636002)(106466001)(26005)(77096007)(51416003)(8936002)(76176011)(85426001)(105606002)(50226002)(2906002)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR03MB2177;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD019;1:8MLrpe//8uj2P1T92BOXuxNJ5NBsFmfTbEYxIrt8pzb5lDJE5K7xGL9arfTDPg7DeP6ORGzLKzFmptInmXpVIId2GSJcrWkD0RHRxKXy1rtQ4g7xOZjvMATF13bFR8mE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328);SRVR:BN3PR03MB2177;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2177;3:rE4zJoQNJzFHZ3xLYF30nPTF5Z2IShdQ3YXjIRiwCvq8UudSVdjGpaRzvLakLnJHEA4j2PMRUVA2xQrCm0nXoR8ennYbCjj1dYd2yk7ubPo2XWRmX2JL6hZtMKoValU/YamRl8a1/Gi+F66pjgXdnyQ53yR+8BnIteR2oRAbLnmy9Y9TxiY3fyUKnEdwueiTfWYxSkdlskHdFIMHeDWJp/4nOESLvMJIFHzlRTnHRd/qmAwe9DC84MS8kcrGHcOJFO0Tx/5zcE2ItuXkRaJamIkKJ0DFjgK34Pcg7E06Slg4oErkKJZeQHnSyCgNGqsGpoOG/4yul27qhq/EHLaAxlj8uw9EHC4Da+mq+rt2M5A=;25:2okmpEgoCvshiZmN188dooENq+P9J4xv2zPHydKUGHH+iCIC0aVvwK+n+4PvYECK8corL+y4FM9VO/ipvyHeLtnF+T6/Ab7xoGjJn2nruspWXfPNadv96isjWyq4AS47/O7JVdMXednVKXDkP3r9HFmc/8srQ/OaJoKA/SJ4AxFNVDoSzJ5CCeAE0bkvH7PzSN3ThV+tbQh6vZieLbpHPJlm6jXlRzUaszNHhGI9xlBvi7gVBISzEpOFZqQeKiQUkMx1sxYXNSKoDAzt6eBGS0HK4SEiN9PH3j3dnPXNib3rospX/85DWcU/BvtGTsOb7OAppkiDC3azfYw4tAGZaQ==
X-MS-TrafficTypeDiagnostic: BN3PR03MB2177:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2177;31:WwTZ+Hl0ktmqsz5KWvsstmp1oGKe9Auv/AavdbsFjMbb2ZIoijkDpatbYtMRoqcSdTQiPEbt8HKaPHmxWPh9aDyEQ/aigEU8S7Zow0KnrPAJj/YUJBuC3eY6ZErkVNKWXV4pT6x2GiLEULz7+QQARTyF4qldD3S2i9xNOIPxEM05NzsW31u8LZZKpH3WETIsXGqzv0rmz2r0oO+CSxJK1UC6x4eH9Cf4qiAhRtt1eLk=;20:kFF/rd1zrw3jjXr0bDcK5a6Cz0wD/Sws8TctnwAppwsOE2FUXJytVqf17VxOqbL4C5VXnSV9fvwjyWGOIehRMuO5lQGLW8BL5oEkPYBXahqD6ICSuCQmq4d6adzOQPzCX6Ofm3BSARNhvQ8dQ+bAZhU+38ZtLhFYPzlH043KsTYVvIJRioxnTOoXPMhft7bmYrFvHsDcWVkKwoAiMIR3CfM3eaGNQ4CxmHVeyIFw6ymBEAyO5gQhmzplO/kkRZwUGQ4R/tSba/iT06IRoXcnZdvf7i+MyfS1G35fDPnSuus3ZcRKD0pTqd4S+7QRrf01P4wewYVJDZXG1OemZxvYgjL+5vyK1cmP9F8lJOY/xYBleZkeVMBIQIF/L2FA2i1V5L4eS8jR05Ef1Z0Ju+3zUM+6G0lpurjhjm8lI/ffGMvIQnSSoQn2vA/Lr2sdfhyCo0jlRVFAN+Iffs1M7ngOnPhwM2FRBouwulwmDTILFWDw2IYRcxu+cyTSoz5lP7n81n9xlksP8Wa6tiDEu2rhacFDpSy/oH1CjCNDwyREghWsgDTie5wgxsP/Ou/bnNzpbrCiCxBkOLyeD+VoWi+lmg0yrlLv1HHFYRo+KgjOnP4=
X-Microsoft-Antispam-PRVS: <BN3PR03MB2177D64920BC3C825880CF07F88E0@BN3PR03MB2177.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93003095)(3231232)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BN3PR03MB2177;BCL:0;PCL:0;RULEID:;SRVR:BN3PR03MB2177;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2177;4:5EeZqalYtKPwfwDD0RSGkp1cNFqMzKLgq9/pw7c5t7cYrlEGNBIKsM3NwAaFmvv6zjM1LDBSUeHE/aYXDBHo1nQwesdFv8iJ3r+SIhBFD5FN6fjCW4/XYHKlcemmKg+aYDa6MuBQNVTqLdrkj9jWYurKiJn3iTW6qtmLMK8uPInjySsBS9PhZVxfob8CUkDOGoMIvErvUWHzJqdepre3vUpF8xPttlY4gWgvr29XJcOzM9MsRaQszMKty71RdVHrie3IuR4FBq9h+sdGJ/QhzXy2jdvivHvb7XrcuTPBIy3/X7S0qNSsGJJn23RLSm7N
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB2177;23:q4+zCUgbp3Uzd4dRfdGRlRYDc7gunzhVoDzGoqhSM?=
 =?us-ascii?Q?QDMCfdWYjlfgp73o7/15aeJ+jJKOuxhAb4uxK6wdUzN8+aMszmnhn86+ohIw?=
 =?us-ascii?Q?2RG6DpBxd45aYXI7/QcxXP6jJSLPsO0t0ckI94uz+hbzi+SXujo22Nu7iJ+1?=
 =?us-ascii?Q?498TWzXEsbp62uFa9w/OpDc/0QsEg16kh8AjA2La6MdgGxnVRZtCdSh+HoQe?=
 =?us-ascii?Q?VmSFiT/jzGrKGSwW+C/8v11DZnHBb69jjVrMn+sCf1nZjfZ5gt29bAFcUtNL?=
 =?us-ascii?Q?+C6ZCgf4KPcqpTh7fEF7yrB5p3TdYQFI6XsKx+EdvnL+Y0vKHXcWPlBTv2ID?=
 =?us-ascii?Q?SgWqOzygu4Yy45tQs8NPJ3pak4tMrTKxTvA/cnz5KUNFulx6ln99U4mUo4he?=
 =?us-ascii?Q?kTSxO3uTltJPWcHjfdoQCdzYcIr3Mw8YgyK9LcnvS8QzPPJMvwVUgFOHSp60?=
 =?us-ascii?Q?OkEh+RUBEfVwouguDiIEDueO678TyEji7d4rwcb9+KhsZAZpl+dgomHQ9SBh?=
 =?us-ascii?Q?9NeJu9wdxCCvEYH9oujKLc5vlMNL2jB5CvjnMfChQwzox7piWeA2Szrij0BO?=
 =?us-ascii?Q?VbhJhqwqC3zK0zOw0CAqlO9PndMbKMg7GGn4tCILExxQ1bQMH8X6BhYgGjfs?=
 =?us-ascii?Q?q7Q8Uo0kE9Mkwq9cfOyd/Pecc3nLz+P2LMHXD8Z1DlUfctjWM/O+GMYRZrTW?=
 =?us-ascii?Q?UQDTYqDO1923uGQaK13ag7h9xATSwey497qxTpOl+QC5CimXR+vAFoamB/ig?=
 =?us-ascii?Q?r4RLQ9GSUhcg/0TdDwnINy5ihi+6LXwkpXKbz/9EgfcgQWhyKY5H1mWgdhRt?=
 =?us-ascii?Q?sWP1cwaiZbfPbcoiqytp4629WRVj5MbUsKb0UbD9wc1PDJi+LxbWd0sEU7+3?=
 =?us-ascii?Q?qt2GHcbVdmTQTORwJ8W496M4Lak6OrkqCmopSOFdwepgowyN1nc/0q4llaIL?=
 =?us-ascii?Q?DEFAm1yFu+bguoBtgxWw4QhAibilXgHbAkIeJplBbGoUuAu1qmXu8tbkhxJb?=
 =?us-ascii?Q?c/yCylP59s9LMzevYHXg/qyMTVxJz6PkhGz2/VviTPwx+fxWPzfzg+cbvj8O?=
 =?us-ascii?Q?tvd0KmM6/6rddkF5NVCVclR3juCGjerG9srXwf2kbA2A7enYZa1j2zRt6UEn?=
 =?us-ascii?Q?FoVKELCI1/jeGQWyf9YUZSNAMQNd69bUyEND9t79fcV9bTtpZ6gIO5Bom2+R?=
 =?us-ascii?Q?7W6ATHF1qY9uA4=3D?=
X-Microsoft-Antispam-Message-Info: yD+R2ZBK+CbeqcHqXWE7gOJinBPFSjTdHRvtqmT+0kJTVIx3zvgMKGFBPxz4qYC6JFU4FmMfxZmQ8SXPOqyMq/2tEftdWw68bVoW+/O9Vba1xElb8JtuAHlyPFqdxMkgabdXUizaq2pNKT/LZal5YOHWpncgwQNKil9KJI/LpMTA3yLvgt+x5QnAziZOvP0f
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2177;6:t2QgpNpXIns86pIpFH5r1dfQjMzEUpFwaTXNqoOsoz7NW1XHDZ1WXRdEx9+A7WLxU8A+g3/wD9r1nIbkzWaeIacnMjggSVrCNZy6vBmjwooJ07a8zD+JcJsnHcMOZz2efGZBak7LX+mxSY7qwLSqtn3Loh46+M/c2KOfWPO7X+djAtPBIVDSnt1uhraO0LNRLRDcH4Z2t0vg09hvhKHT0X4COvXm2qZirizusB8C+r+nUl2jYeTLM2Y3+n/YGTSpIINOiQ51yJ2xncsXjWVUfRo1D1KSi+EuBHmTkgwuf0RW9KMsQk78itAb3hBiBMW3342V2JGTlyfv+KD7fnBWzYnoJLsIB3twq672EjyZ5BtxKUtCl237JH5a0Dd7WYh/obC5R5xRArekQfALE6qlD9rplVfuAdQXvc7qcC6hIG78YqszNthJ313JHeTShj3XDyC9IwVifK5ETPcVH6vfPw==;5:+gxaA/sWbVmoV4UJqsvDthvEVkFab8Fxt6QU6mPjdzj5ADUOSlcG/G71tw6Ub/XaVmZRd6SU7NdEpWT/KpHRddSbbDrxo9ViYzGnMx0Q1v81PC9kxvMqh5vWREk5TI1dBwZ3F5J8n/wWhG2Ldyz30jx7jQs0yCxUXQsCRSdz4hE=;24:KwH2lX/N8IdfVFeaVA2A8SRmL0q244V0yWXOcx5Qei7iJ7zc9M85nRqYyHsqZCjedrEeR3Ds0Wiyc+TCSM5oDfZq1S6E8b135k73Ajofs2c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2177;7:YCxRbplOuL9cP2M2eVxiRpmZInl+83VsrDIBoWhCyhGMw5H/RDl2hzhVfiuifMa8qwIoQUdE7CXsOqAvtV1DPSI0bGHyRkqIaXq5rVdtjJuOfGOEJWkoq+I0B1MapjwCa5DOrkrVgOmxNwVcayxfwgo+tPN1eSAE+IEM82ZAnA/TLtyCsXf25f/wxgqstl+GzjpKZosPlilW5Y+IU4O50yoIotjil9n25GhWGdXLKqP49ZuanU3DWKcSPKj/Hvbr
X-MS-Office365-Filtering-Correlation-Id: d9e4b65a-b195-4508-6f92-08d5ab5fea5b
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 10:24:38.3024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e4b65a-b195-4508-6f92-08d5ab5fea5b
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2177
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598803969254694104?=
X-GMAIL-MSGID: =?utf-8?q?1598803969254694104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since hardware timestmaping has been supported in driver, this
patch is to add the get_ts_info interface for ethtool to show
timestamping capability.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Added this patch.
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |    1 +
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c |   23 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index ff204c2..905a4e6 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -390,6 +390,7 @@ struct dpaa2_eth_priv {
 
 extern const struct ethtool_ops dpaa2_ethtool_ops;
 extern const char dpaa2_eth_drv_version[];
+extern int dpaa2_phc_index;
 
 static inline int dpaa2_eth_cmp_dpni_ver(struct dpaa2_eth_priv *priv,
 					 u16 ver_major, u16 ver_minor)
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
index bfc8b64..1ae779a 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
@@ -30,6 +30,8 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#include <linux/net_tstamp.h>
+
 #include "dpni.h"	/* DPNI_LINK_OPT_* */
 #include "dpaa2-eth.h"
 
@@ -274,6 +276,26 @@ static int dpaa2_eth_get_rxnfc(struct net_device *net_dev,
 	return 0;
 }
 
+int dpaa2_phc_index = -1;
+EXPORT_SYMBOL(dpaa2_phc_index);
+
+static int dpaa2_eth_get_ts_info(struct net_device *dev,
+				 struct ethtool_ts_info *info)
+{
+	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->phc_index = dpaa2_phc_index;
+
+	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
+			 (1 << HWTSTAMP_TX_ON);
+
+	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
+			   (1 << HWTSTAMP_FILTER_ALL);
+	return 0;
+}
+
 const struct ethtool_ops dpaa2_ethtool_ops = {
 	.get_drvinfo = dpaa2_eth_get_drvinfo,
 	.get_link = ethtool_op_get_link,
@@ -283,4 +305,5 @@ static int dpaa2_eth_get_rxnfc(struct net_device *net_dev,
 	.get_ethtool_stats = dpaa2_eth_get_ethtool_stats,
 	.get_strings = dpaa2_eth_get_strings,
 	.get_rxnfc = dpaa2_eth_get_rxnfc,
+	.get_ts_info = dpaa2_eth_get_ts_info,
 };
-- 
1.7.1

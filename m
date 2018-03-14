Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeCNNif (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:38:35 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:55200
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751426AbeCNNib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:38:31 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 2/5] dpaa_eth: fix error in dpaa_remove()
Date: Wed, 14 Mar 2018 08:37:29 -0500
Message-Id: <20180314133732.24068-3-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: SN4PR0601CA0024.namprd06.prod.outlook.com
 (2603:10b6:803:2f::34) To AM5PR04MB3267.eurprd04.prod.outlook.com
 (2603:10a6:206:d::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b216b16e-f422-44f0-a185-08d589b0ded4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3267;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;3:YqOUaJ27KMpcVfu1xjOzhwMpAtuGFfc3Qs8VyMlJBjsycfnnmLw/CdFe4dNz2Sqrp5QPKefBNuKcVd5/H9KbB2cHZvfmV0qQr1zeVh1AotkgsJ04Wzhm3lsQ98yRoajga0pXspLUuIh1qPufUjuysg/jufGB+4EInVoKimFxsplniEuzPRaYv8Y6m01hSwPv0uj/CUeM1gWyAOR7Sgqr6DeXdC4fIKlNEDh3vNhhXGXijAVfoSeqV2eNb2/xxzTk;25:722utIRu44hLDxF/VgoQ/HVRI0jo9ZhleesfHZJTI5uNJd2ja+/+wODOjdL7iYLZJxyumKL2Ivt+iKw0729PXC63/eHM194BgHX91MFwT21MOQpwEiS1npYDfJOHq/ml/EzxvO+NnqNVvMMPdwEnJpoNwIwEJQhlo/FuUaUyJkbDFol3ZltYPCHm7tUb7ASzbV6xsAo1QPRaYZ4EHwpL2MHy61sh9NyuXJ/2QcDabZTPHNfNMK6F2V6LoRRDLTHl5aEhWgwbhVm+GpgbbvuVvRJCM24WPmPAvwF2IuwvoWLsWWWoi0scJwSt2djN8Bc1+qIGWCij0iicxCD5NRVAfQ==;31:J7XNJ6r+PhikzkNoVbOdmihH28TlAIDhRbTh02qXb7jj2iLP2l5Q1DqI8HD0svadMclvikg2Qg1qiV9xCDiKHqnWZRiZxGB2cozoyRFUfULSxZZT317jwKgiDj6P8uxkOjd4L1HZxhmyb4uTizZqjTGj+9B4Zdnds0TzIDhOW5CQl3CTc6LVfv47rkaa7+aZYtfTYhYYqO+h265nh2YeVu6aHmVLTPEQsY8v5saxUm4=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3267:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;20:7fiSMEpzHn9nxNxrOMyotHEePrydqSqZCdH6cEBiwK7Tl610lS8DYHKU7U1jp7A5n/cdBzVmDe4Zd73Up2itqnxTH0TmeXPaWIyQIDP+fI/+gaG0HT32mDn0ow1vSaZR/ZqmmsZ/f/oYv94AZiJSJBsqnZZVse2Bk7wcZHXaOKUd79huydSA6ikPOY/1fxwg31EUf/HhguqBReiTQxRcdjqxd91oshC+yT7pOoXWQZlAJui78WwSuv7LeuCyf/ZXkuDrq5QwOEdMlOb4PEu13X/tE2gITZ14MD3KfhILp2Y4nwuAixbtXuqcJlfb1X4Y40aly6d4mu8Gv7mce/y3j2tZ+ACGia782UyrDLQ334KFq/QqaG8nFguWDdyqe8p+i8I4e2ckyvyDQFatMD5L4GIWIEqBeNWuSVf3TP2YSgOYSJnuVPaHpWlFhj1rN3HNSfmSx+beYp5XVMnfPZnVv5KnborRX4+C5rQoUwISu1r93nmMpDYF6O6GgZRy85hn;4:n3mpjQ8oAHWlsEmIMOuHaPZfIjlrkl/Y+4fJokL02YQcPsiDdU+NirMHYuhwEZScvrnhUZIbrNNGrVuVLgCIJ9fSu/wlDLyl8l/pi3Zmt2Sp2fzoI386zKkHvH0IlLpo5MKNbSgAzjHvDJJlhPoI2LRME12/yNRb89TwjiHCO5SPDUexvG+egyTPrA4+Ydgga+c7tXix/T/LLBnDZWiwocuTvpWHIIpuMA9zp8gah3fmYmZMqu0bRvLCeGxIL8PiiByMm/Auvm64zbYFyMfIpmRoG9p1zlXrldE5EIb4ZFN3J43+Y7Fqlnqaqg8Qaxx7
X-Microsoft-Antispam-PRVS: <AM5PR04MB32671BDF9990DB31660C7359ECD10@AM5PR04MB3267.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR04MB3267;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3267;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(366004)(396003)(199004)(189003)(1076002)(68736007)(7736002)(6916009)(47776003)(4326008)(8676002)(2950100002)(316002)(50466002)(81156014)(25786009)(81166006)(66066001)(50226002)(305945005)(3846002)(8936002)(53936002)(6116002)(36756003)(48376002)(575784001)(2906002)(16526019)(26005)(3450700001)(2361001)(86362001)(186003)(59450400001)(478600001)(51416003)(76176011)(106356001)(52116002)(16586007)(43066004)(6512007)(2351001)(6486002)(97736004)(5660300001)(386003)(105586002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3267;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3267;23:iRdsc05GfH8ktpU6eNdhAeFnW/W3w0IGCo6Wno+C2?=
 =?us-ascii?Q?zf1ay3nQiiv5JeLMYYFpBayQvMh7W2Tjw4V80HovvSUWZKbMndJIw7uW/K4h?=
 =?us-ascii?Q?ntNcxRiwuG1/xreWUz6sGJQhpx6LXj/A9YVZris48K//JhOc1GWxFbyyW+4N?=
 =?us-ascii?Q?1pND4npmsjk5T29hkLs9JHBcw7oav92/X8pePubwFQUi8sF3CKjbJ1gFN/Zv?=
 =?us-ascii?Q?bzpCM3WW8iIuWJk4ijeSfZd7dtTDhtpTBMvmQ4+wF+oMAqoE1zWbdzfRpFyU?=
 =?us-ascii?Q?v0nSQqCPEfetHMbBdefN4C3XAojpDIixCRYvpFBTJvUw9mDtgAdoyFuyM+FL?=
 =?us-ascii?Q?6c4qLruFCF25/Hr7Xg3QZdYAAdxRdUeAOu2UZ0w1ZhwSlcIIB8Zr0JWSiWcI?=
 =?us-ascii?Q?8X7bqDZeH+lMeByhb4sUEQY+26cPJyFO4fRMmCa3xI6HgDSjBHyls26frtYy?=
 =?us-ascii?Q?DpYgkJUd/jwK96jC/CwT422OyAr84b6eK2aCgrUHWTbT51WGISvkWrnADvZx?=
 =?us-ascii?Q?lY1l3+gQoFT0Ngggs44TrMnysuHHzeN9df6KmZucRJ6gxVyT6hxLyeBeE3OO?=
 =?us-ascii?Q?o/W/rDd6W5rfhFmjrSVE6e2oaHLeQdVfqFW6RW8ALHISFsSqOD/TPKvspCUV?=
 =?us-ascii?Q?1wUkvOlsY2OblHhnKxIg0IbORSk0jeCHqm2cDeKpZB7v4ZKHS5f5YKwPTgs0?=
 =?us-ascii?Q?qQhGbDJxP8B72+J05oHjvmsGgct6sSLTSf2fUlUtqjYvEb/ltDrMQOzdzjvZ?=
 =?us-ascii?Q?JT72wPUnRHySZVrV/zh/6B3DjgS6oFNSVMI2ti4cgrd08E91O6piwEOxTA9k?=
 =?us-ascii?Q?9chPeGcpBhIm9Hhd6Fce+7e6KCldSYCSd+80hBtLU1tbKDe2MOdLvGJJYlxW?=
 =?us-ascii?Q?rFptFZINQBcpf/s/uPKwxpQzEJQ7XkM0HkLb5ZnBC3hoDaf5OUb7+8h8SWZw?=
 =?us-ascii?Q?DWQ1uqGRHua5N5tLhU2IKeQRKa/ocy5Yw0EGAZYfWHhtZE5kl5a4s2jN+99I?=
 =?us-ascii?Q?DSf9peGlzOrfApz2nsD6p0kTjXZSaG3tvlOFbQHCs15gu6hVwrytW7qObT5F?=
 =?us-ascii?Q?PcHDMbxrm7Hs3JDayKY8lxl79k6Tat8Kskg+YUiz80O+dQuWtVongQOHamyh?=
 =?us-ascii?Q?mjGnH0HmdqIelCqL1OMWxtFhg1FdhC/Tuwepz2NiMn6s9p1RruPmszQ8ZTju?=
 =?us-ascii?Q?38Mg27lXJ88e2eE2NiFC1iTdZ7kMn6LAGdYADzyM2/rJM6Amznyb5DLIg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: tw2v/TeWxvo2yT+kge43gSVLHOS3yo0d0hUZ8LTT9dn2OGRSubzQV9FOkeiIdz5lz5whYrnaQpT7Oh0xTr6tSZww1JKess2Bx1GzE4rXX9DNV4mw35XC6S1jb8AaZ0+UZT/p8oyL+dxF0yq7DbP4by4Uyc+2iqjXFlHT2eyH8r4TZgEt+a7DwQHARDETD5jU
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;6:OvzM4+0VZLeA9j2w5nFSBtUxUaoQ68s3rFaDxQqdUGBmp7XRy5y82muU2AIq++AMzd6kvwbvnjDvwAUZY1Qg2Jo0ehU4Q/jC4Ve7yCP5BxOTiG02Lv6KHsOlmJHKwfKemFqQQzIe8ttXoga+S2D5ZqW+6OT47mLMrmpoVl0ZcIrj+yC54TdgIVLWvw4YXFRhC0l0h5OO65yM05+T/pYBKG6zRyoKwFq2xUdIwD0bn2MHMiS94kmAkfDyNPlytGGnnDSfnydaEwq/YgK/prTThBxE6Fr1dYo/m5uBEzJ7OdRXriSjI2OrfbSwUdvWoqjwvzQXnNDNS1pqS28dZcgIl9YkYQLQUXuGSnpboIjJExQ=;5:oyzhdWMbX/bPoeBGcr3prMrAMpwnNsFDLFXiWwryz8m+1vGAvadWMEbJIMWo44vbskdyBggjIlj7Tte8cMp+MuYlvo2SRYCVSLu637XBiivTxh325tbs0hhXyqXGlUJdWhbrQaQ420BuCBBRhvWB5i2i3TIlfqBuhu/mBH6dYz4=;24:8x0+N1L46KrPE3tngOWFN57d3g4opZRLHgramX66oiI+0tTyAu8SNZLUgjFjC3sbUnpBD2HGgmBkEFjy6Ya5SgZOzIf3uNA/JAx2WIZDQxw=;7:sXza2gqQDWXiNym0jLOfmp66EvRubZxV77+zJHJy79wv7MAom7Ywh54PZ8rV18dDtHwm2PL+zgg7l8H8vd4WlY1wn2WDkjOmvHz4NQOybjXdNRDTXrHiYuUvrD5DwTw571TCu1ij3EXiQE0Wtf7WH5DkDQMsutD5kWa1lPcXLHcawYAEpme6gamJ8KAoRcka7rA+24e0rvoGrHM+yomUu3DDt0SjZ3CSRwb2iMESboRCoRbOxq4G5n3KrWSlhflH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 13:38:27.2425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b216b16e-f422-44f0-a185-08d589b0ded4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent changes that make the driver probing compatible with DSA
were not propagated in the dpa_remove() function, breaking the
module unload function. Using the proper device to address the issue.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 159dc2d..128e0a4 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2871,7 +2871,7 @@ static int dpaa_remove(struct platform_device *pdev)
 	struct device *dev;
 	int err;
 
-	dev = &pdev->dev;
+	dev = pdev->dev.parent;
 	net_dev = dev_get_drvdata(dev);
 
 	priv = netdev_priv(net_dev);
-- 
2.1.0

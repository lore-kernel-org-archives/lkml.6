Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeEPKTv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:19:51 -0400
Received: from mail-he1eur01on0101.outbound.protection.outlook.com ([104.47.0.101]:1443
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752081AbeEPKQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 15/26] drm/bridge: synopsys: provide an owner .odev device for the bridges
Date: Wed, 16 May 2018 12:14:59 +0200
Message-Id: <20180516101510.13215-16-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:XFTVdooR5mWtVFWFQznDQmIULtSgoYQgqx/kc4OJzvKvnjYYG8/VdvaGZHRipopTlrbGZVYRQd4r6ti8sgmDcBLVJDlrYZ5bIY7dyeuOzn+1I8oqODpXX+9zYxeRIyPJd/8tACEaAdWHp8Na6XH3yxHMTXFwObiVwSNsZbZIRkfMTR9sKvZl9RKnjwhipFoX1Mm3AikxTjUjtJKWe/Ptude+kH/DcZ2xW+1huBzRn9Ky6nriYfxkFC4J0FYhxiqE;25:4eSBlU48swYBA1T8UNnL+x/EgobqhYHBrCSDY0k01j+C7UZbvwFUA8fbWEi0GffcOyJHBE60khHSSFj01lE3FIMgkRnndNqJQz+5k66+AoAkzk1Zvy9RgjJCFa2/PgSyXI5H2W1fbZ3VUTEjthzLuvl8mHF6EzpcYO8EzBcUHF/91fYI+76mHxVvrlsfX11ES9D/Hk07nFS4f8GZi65iOtqtWGkuEnDsFnzjkMx+4DuE08bdiACMQ8eugI1GaBvnTchYG+gdNfNEQQ/j0xJ1PEISBSc3bKu+ZYvDLM68Y3bGp4pMSq+kyKAx9yksz46//ukD7ZUJVFHxaIGWMijt3A==;31:BmWhp2dwY3qnlZCEMRpVr3yBXWfAr4+TOBbfumF2H9j/bp1hX4JO/8eC0YMZjDeIcLWJd3+ct9hI3YRbPe0uri2BBhXTQpSm25mtpfU0t5HB5OtR5WOp5Uod3Uox7oOJekaHVRPb5NWkJ3Rsg4OLd+iBQj0J5vpPpU59aUF8eIqKTI2qtPa3Hr71Ep2PTKhVz52wNJx1sdvEQIvbmgU0V5B3gnaWmRmILJIECT1AYlQ=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772FBB5A46CD8936CE9EBCEBC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:AR8G0TVZv+YQE47vleY47lVhrspNxmw6SKMb/PS0/slz/Mu3YPbQ4oJPW9/BzMATcnZzrZhPQARjOx74iyYVQBy0l5mw4tNIgp64sttRRDR7rRdAaZTksDkrRZFqMf989YZQlMfdN1eZnqAWtD/h6TB2WkWJNHXLwlE0CRDMnR1hjE0m9CUVJgxBBpJrm5AsoU4wUrcesju/E/0CnelWKTnC9z9/wF+K1XsrdzxDcy9E8O57A4kY2X/uaJDU8mH3DMtidV7VGZx8gfEZO8awBQ==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:43kNo/mXxUHAb8Q5YzjJqVX5QsQtcV0v95OnP+w?=
 =?us-ascii?Q?G74+U2jkkJVyqsfHhz00gw3/WJ0+Ji3nGOnlFYK9kGmvcwl6y1VjWnDU+ois?=
 =?us-ascii?Q?+oPQ+128zoMdBoDDKckq7yjqgMw9pxV9GbOVaPlhiqKLezVgDmpDINf14Q7G?=
 =?us-ascii?Q?5JMz5oH8ZGmDZiavPrwU5LuWhxwEJqSNBfKJnZNhcd96dJa1JsjVUxVOuEw4?=
 =?us-ascii?Q?NT5BzvTVpf0qIFQRl95R6Edc8xYkCS0Zk5kcTMeN1Vupi5df9mTmMzMageSi?=
 =?us-ascii?Q?bO1GqTco32hZ83MngLEKYrgv46MqOwehwJ3Kra1F7Odz0VfUFZktVA20IEEA?=
 =?us-ascii?Q?ZwwnTcdNjjZysNIbywIUGXI735GtLSNnyzZnSizaBvb127r3hEwUNd5MSbGr?=
 =?us-ascii?Q?l8MMsipIxs25iBUduyFTaFQfEYTvxkKwhY8/wqfaH8Xe72pnabURZnIcGpbu?=
 =?us-ascii?Q?/RJoSkkcbrp2QcmdOSwk7JAXut3PZYfKqGREzsGjwn+4/TwMmK4Fb5Z8XXgW?=
 =?us-ascii?Q?MymyEwwvz/eBCiZz1/iLzHdynsZW/PHmNqTE5/zoelqAylb0b3+JBKpKlTve?=
 =?us-ascii?Q?/IAEGaZkYimahV+DbFSAr599vBV6pFxkgTmh7Y1USqOQd5vQDbl2LDJdbUho?=
 =?us-ascii?Q?1Y66KLGQ0BOS7FM1QWkPfeoNYFoP8w9dgshE6xdPKDMwGfcghDPcXUtclhvc?=
 =?us-ascii?Q?1BJYcKtDOtvKZjeVNKrfVuIXkmXmNO8vRkemZQe0GLQRQpZkDryQz+vfiZEL?=
 =?us-ascii?Q?QdgG79bE5N7Hmq1c1M5a0aTFhqmX2dayIZCH+sjY1b8c1dPUZ3jPcho0EhAk?=
 =?us-ascii?Q?jdNOkHASuiylpqdWFN1NubQ+VufUx2Xupe3pC8iv87lyIJu1ei/yrBcyAkhE?=
 =?us-ascii?Q?7/eCcODl69XiSaqUpxW9VYh2PWT7MTUtYNea1diNb0Q0yF+nDnPS5qzQ+bRX?=
 =?us-ascii?Q?mzcKyWA5wqSnBWy2Ju7ExV8HGZREUTj2E6heLEjPiaa09F+01nhVEKBbE12M?=
 =?us-ascii?Q?8xu1FQMHduxo4ICbBAHUO+Ix2CYo+EQUQdRHPMR5OscsZhikGy8Sv6sXM3/I?=
 =?us-ascii?Q?GGnaiGNkCgyP938H6MkggWXQ9Y862p/ucu1aSGJSePHDO6SKcnuYDM45fqgZ?=
 =?us-ascii?Q?Vg9FoYmPE1Y1Uuf/V4sCylb7u9ajtD8ef5Rq0Mw7EIpM/5qMvCObffXpvsgo?=
 =?us-ascii?Q?hntlDXFk20cTTrvWp7xgtKRd9Xmgitb7u+XjXljNvc8CZC+sE+Jjl8qlCI2O?=
 =?us-ascii?Q?NnfASOsHYzy4U7AQX64rSnmw+G6c8DYpDB28ydm5qfmhOCEjchQZxtPq+oW6?=
 =?us-ascii?Q?zJI5sq4GJIJRJgINZgdEjbWY=3D?=
X-Microsoft-Antispam-Message-Info: ZODoIXCKkCOX78wX9GcQxEtzqhzpuEHuX7zhvHbbaVUdCb0i4Zug5ty85HmkpohqTce9JqfpmQ8CNqcniyMsjIyxcolv6QBbd3w+Ff28LpGlvaoeBgEmKhvbWw+W9rbnDT/Hwet4GGGhyiC0J60FMOb3sXblvuqvvhzeG6Khhvw8c4M+RgCCEhprUwYPjcXr
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:Y63M8RtiIAHJq9dzhNRaPZX98d5Iy0l2Or5t1yMS9TK5pyHC65WiaV4g7GAxHjs7ik7wNjWkWBmIafJNda9Td1dhPKJAhpbcDme2jmJMmaKBHhdxY/YJPVWNpY6EcJy2iI0FzsKRHBA54bR9IAHg19SCbR6GEbGxgx0xLp1/OtnlYl5tBuyIBmBjIKvDHTyo/Psdxw5idvLd6kpeydWuqLtYFYULxYr9N/hIWLBME6bIw8fxrgonK5CiGngVQRCs6rM5QTdIbO8s5q1UvYSJSlHzObmsORXvlwbeeVAO2l60MRNbi9645vYFX64sX2nxQJkNAx9v46ZNvcUpdL5kPBagaxPtI/jurMyWCmVuxkzWLt2krpC+emedbAUobsTwCIu+7iGZLVv1tSLP2ASU7/oDXx/bhjv8biln3VaCOm2YbYMEWYCsdNEv5+UP8zj0Saps9uJsx2S2k6L+4r+kWw==;5:5sjT6yJ60wYp5VzRaah/JTaCaJPfbp4Zy2d7/L1IHHxaAgo9c6R9ynMvh8Fs8nPNo1dtTqyXqtMWKG4GYXUS4UOolR2nuj9xE/GpnCU7byNiVEsWu3OK/Pe61fe02CkuurM3tot7Ur5v5TFLtKEq2gKSNfaPNOJlmEnctXp9GJ0=;24:6FV1pfsLWt4ICzsleBqUmXh10/WfOZXrsRbd/uaGIeavfKx8F27XM0mpJkMS4FlyBbfAidKpmCghn1s0/0pIaWyTA3you3nTHwDHNnsY7wY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:lGm16Hzav1QsoNcFQhp6tI+4wLo36V0wNm7cqEVhAOyR3fJJQ4CWdvlVj7LrwviBwVJsGIPUGNieYklKXtd8wfs57NcVGLyt5IsVIdCmPOgf1NYixa+SqBC+ptG+5iMcVkNnr05a387xBMBfp8OLXCTllT9zYLzZst9WHBVrN3VufIOjG3PGYISyXcSPcXphsfHvkMuk5B5KiVmwTmsXExuFizyDvaJGHdaGIr0US8Qb/N90Ax+yCJoG0pl2wao8
X-MS-Office365-Filtering-Correlation-Id: d4b3aa45-3f02-428e-45ae-08d5bb160f0f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:15.2981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b3aa45-3f02-428e-45ae-08d5bb160f0f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gets rid of two #ifdefs and the .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 4 +---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index ec8d0006ef7c..e3956a7e827c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2471,11 +2471,9 @@ __dw_hdmi_probe(struct platform_device *pdev,
 			hdmi->ddc = NULL;
 	}
 
+	hdmi->bridge.odev = dev;
 	hdmi->bridge.driver_private = hdmi;
 	hdmi->bridge.funcs = &dw_hdmi_bridge_funcs;
-#ifdef CONFIG_OF
-	hdmi->bridge.of_node = pdev->dev.of_node;
-#endif
 
 	dw_hdmi_setup_i2c(hdmi);
 	if (hdmi->phy.ops->setup_hpd)
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index fd7999642cf8..7c8d05f7cecd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -930,11 +930,9 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 		return ERR_PTR(ret);
 	}
 
+	dsi->bridge.odev = dev;
 	dsi->bridge.driver_private = dsi;
 	dsi->bridge.funcs = &dw_mipi_dsi_bridge_funcs;
-#ifdef CONFIG_OF
-	dsi->bridge.of_node = pdev->dev.of_node;
-#endif
 
 	return dsi;
 }
-- 
2.11.0

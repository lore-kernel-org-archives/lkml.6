Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id K9bQKiUYGlv1fQAAmS7hNA
	; Fri, 08 Jun 2018 05:47:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4EFFB60908; Fri,  8 Jun 2018 05:47:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OriHaVfr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D13886089E;
	Fri,  8 Jun 2018 05:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D13886089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeFHFrR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:47:17 -0400
Received: from mail-db5eur01on0067.outbound.protection.outlook.com ([104.47.2.67]:28736
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751152AbeFHFpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBF1dqAC5y8DFelpAd/su25tw95eMv2g+dhf20EecY8=;
 b=OriHaVfr9VUKbM7HMH4Z1gyoWDvDV2iULHJQPX8US/ik13Dqz4W4To5cQvxfvui3dd1jzbCxzZT1TBXZjKTLdETGQHphsS7pmAdCTWQXzLyo+MiBCUDIHDilfOOtb3s5lsIgpw5bfcBp3ebQyf2K+shGpxOn8Qu66xpRqPjWTBY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Fri, 8 Jun 2018 05:45:46 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v2 2/5] Revert "dmaengine: imx-sdma: fix pagefault when channel is disabled during interrupt"
Date: Fri,  8 Jun 2018 21:44:47 +0800
Message-Id: <1528465490-19684-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
References: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To VI1PR04MB3232.eurprd04.prod.outlook.com
 (2603:10a6:802:6::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:nqfa/R16xLPNmDZxSH9//7cAHX+CTrV3JBXGbttvSvsY8q+jeVFLZ2QLPrMUH1sidYIagHllFZtTIYglpXKqlZ8EhDWw7t6fKRMDDR7ghsGshnv22b2GmL8rFULA48oQ23b/lRb1JkyjZahK6yE5EnNVIyfMXQhMWG+bd6JNoVejOIvsyuTtAvlUAw34BYeVcR8s7jNu8j/k5Ews2x4bBykpsWU6SbcMxOkJWjquZJPirayCcrpVkKlxOFqv1adT;25:r6w4Xcv2uQEZCjdL+BrwUPfQFyuX1jd3QwZDfwFBLv4bMNblYX/W+IkqU2fQ/90Ts+ds0AHdPGEg57BB2SHfQ7wq55hG7QyboNc0F6rys87U5sPVurPwHaoXG4mon3aqqDJEMpbDv0ZhLjYTIMeBdc4/XBHrUK9x/95W9hFVRIabFgUh9YpXQVP6eAw2fBqme7+A8J5YTI14V66rbAbEA9+B2kccAtp2OGgsAf6Kr6EPGWlMOIsllBzWrhH0U+4s10wmMiPlfUeWfBTyJGyrHqGSs7m76IV1QHl1CiajlZLutUc3q+L0DD/FQlucxcIvBS3uvDcYE+lxvL91W2iJFQ==;31:0e2EqziK/aDQ6hd9GxG1tJfOTQ73OK4FcQMlb6SRfPFL4fcxavBuYZYAGteCytjbDiADCfKhQPQPYj/MtprfVK/5fSZLNQ7o+jqz3XGov/hi8bhhzOJ1vDUrBUKqFTcIggKSl+qVsUc5nuAE1fvfR3yrfmvBo9qGLIFiVaSRupbicPlrkt9+uoa41KKk5OcL6lp1GNRS6jCVQ2bvt0rFjdo7Q2eQIK+/Bmgv6snlGLY=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:oZxBgn1ZPYDvFMq9gp83IKucUJ5b0XnmymuIobwS95DveDdOwNlyY2UK2kyif5mPiKwbReTvxfwLHnl86xPJL14ZTosAwSbzUO1R6RHoOJbnO3+P+Qp4dsQIhqnyofPzgpHOgQ8yeqZUOUr5iDnpn1SZ+/hMiiOTCCN4Dq+4dlmvM6YM/HN/IyzGG8hx6wwpsqzWnEKgDbq0cN0JYhRR4ooL0RIVs348Crpeo84cYBNXfH7OSa48ze30NZhASGYS2Yn4shB6675DkKLo9/gTE0pdBFmclfm/5qTeMfqfInytuQtiVM79lbBuj37hbiIhyL6I2pGLimlChYg/HtU7LtsJthqGwiVPZjXkwpW2HaSw+ylVF0XL8juM3hUYN0p6kvDR5fBkVo/ih6Sn80Qg1sI4PwbqwPUVXWnKmNcUNNK3/9B6zqujY0ECvHmIFiNbriYujHFolj0FKeyY+WF2WiJxCCoQ3urDcBCZfvsVa/vdpyOStyvFU0o/UL29CbVf;4:1SPwGmHg/WkKMn31fn3yrBJ/His/HWDa+ZyOCpd88cpgkbikuUusSUHe8L/jAf7ICnCHnKHzFcbBVo9+IDZiY7QEc8Pb8Uo6Di/H9UlFjtxSs27jFLWRjO4lAyh6tsLPBQlSKtc2CVQLa43+kMJ16slL8BD2A4HD53nZRfPqAKvg28l5qJR3W+jnnrgFVc/l5NbXk3QN8PDSqJIyZtieQVr/VCKgN//MfT1FXmYBCWPLrKg8EWEABLHhHmRm5KvI10u0mYTXYVWKlZ/YZ+1O+C7U7hjv7ZdP3j6zDRGWnJQ9vjCXGkIqGOUdKCQRAzWL
X-Microsoft-Antispam-PRVS: <VI1PR04MB3232CD0EAE422754711D8003897B0@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(199004)(189003)(11346002)(6512007)(386003)(186003)(66066001)(48376002)(2906002)(3846002)(6116002)(68736007)(16586007)(52116002)(36756003)(97736004)(53936002)(76176011)(86362001)(25786009)(51416003)(26005)(59450400001)(316002)(4326008)(81156014)(2616005)(956004)(446003)(476003)(50226002)(486006)(575784001)(81166006)(6506007)(106356001)(7736002)(8936002)(8676002)(5660300001)(478600001)(16526019)(6486002)(47776003)(105586002)(50466002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:CD987bSSYt8EEfZNSmXNQeuUGk+lu6hqmRcfHlGWJ?=
 =?us-ascii?Q?2zgDCFNwAjK2vhewaBOxq2veyZEtx13VLNE//wTVn4T1acKOwjdvxh0MZaTw?=
 =?us-ascii?Q?+pht3ulER4OLsJPdkV+nhaJwXJ4HO9JKvlKwMh00cUh3lbMp6w4xX7m1eHNU?=
 =?us-ascii?Q?ysYiAU6705B8Bx7UmNKZ33HwNyZRUCn6a69i0n3X6fHDNEGm00Y1nNcZ2VL6?=
 =?us-ascii?Q?UAbxNndG/RpNckikOjcoi3Y7cAPEsLKDUIQ5zFoRXxz2/0DUxPOXEQe0tRHn?=
 =?us-ascii?Q?sm+TlPgv1MBJKfr/23ajxPR+r8iyAtd1E+5vSCj60pZJEy4NB7a7pt2FdkcJ?=
 =?us-ascii?Q?fU4o9lyACFSJqP7Q9fNAbb6L8LS2qUzxA/fKoK5CMZhaTnN2nuJOfVUn2yF0?=
 =?us-ascii?Q?F4gZvePGST+4Hg5pX2VxxXO5Td8ZOJ6z5oN+9JEYwTXHlKaDLV3bogbH9b/E?=
 =?us-ascii?Q?3pIZ01Ki6T7dhPHU7vDkKWdO6Nx5azkSF3ClTxPtAQAK3VzuCH72QpKOfVBq?=
 =?us-ascii?Q?NkfsXDXi/7x4FJTyqA+LA3pWe8nSDe9N5MFuBHZ8xeN8HETfqpAl00DXDpc/?=
 =?us-ascii?Q?ZJ0VNPCShOV3OK7KVdgrs2i5XLGsz4jfRPeZIE5PlfdHUrk8FOGm/AGjMSGU?=
 =?us-ascii?Q?RcTsfEBWUZP2DJFssQzjpxbLv+9uQNZyPpCDgVgs4FyJAST+oprDQgaZpe2f?=
 =?us-ascii?Q?VhhwRVkqMRaFVw7jHfWDu0DCPQJNySW2Xmycm7IIlZnbs18XSMhCX7c2UMKr?=
 =?us-ascii?Q?hqTllBLrb1HGoWheD65tJ/klPxTQf8Sn3AG9I+0lkx0uyyf6WRinQH0uOQ20?=
 =?us-ascii?Q?adedEdd4pxwmBcFOREIq/PVn7b6zf5abJHjC7DRFJ9XFjb9Sm4ENv2RHKI7H?=
 =?us-ascii?Q?MZji9806GH+bywuooFJH2OPDxT1E/4trNb003Aan2b3FZadvUG62OuJ9RCUq?=
 =?us-ascii?Q?0+vw2nVGkkUChdgXo1zLGvFzd8XtWp2T59+uyQFSNiaKILf/O4viC0PgdSeo?=
 =?us-ascii?Q?JXNyQzRIxddIRLzsNQeLSm4y8C5mPFaotonbc/SFq/vU2yli8P16ZaddYjOh?=
 =?us-ascii?Q?Zqq2Pb8fkrZtQNsinKqQWAqlZx49qmraxb7+Zs3VdWwH7cfQBoJPLTm2eXVC?=
 =?us-ascii?Q?JQmaty2aBGCuu7aNCx3X0NzfWiI685Z/ewGe+Udi3nJJqFLZQ3ca9Q+LcZLJ?=
 =?us-ascii?Q?+QNybT4EF2Xnuk=3D?=
X-Microsoft-Antispam-Message-Info: +AuFL3VZckm+d/eU/XFVTX8fGQvUDSKHqq3nhMc7WYvqRLeV39oPu/iFCmt15bHjdz28hq8HEb+NWI4YcUKPjnMSxyzeD+xZR+7+SqekGsYlauVZDkVt9AmU0COENkBfU4q9b5GfO0VQvBoBQXl6o/NS0Dx7S/V6z/jDzxOKEDllTAa/Mhx+A+JFfbvsG4hc
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:/U53P6lusDxwL0b23geyEo/7rGKuedPz01XI4Zf0JG22gR3aCJE6sCytl91PKNK3fnL8svAPwIMonhUMDFmrXngAazsH/+EdetE9QlNagrOnxHBA4i7itMpxFUf7N6RH8uaFzg/Dyn/7YwmXKIsMG/UZv4xFLS6WvUJ0YiywxENC8u2rYXOdmusYmGcrITYiQJSq2Sas+gU92Gv1kHTUznrzkp99yk2+lWKAyyoVtCD8y178FScIayNIpB9KRZ0GMJ8+7KPlKl1qPWMR7GM4zgPS8pqVFcrVdej0gT+n9RDjMIpCTw0xhcFTRYs+iW2h44ySbdug35a+NF2a9qpCFNp0emcIQngU2dQvA2WPfeRSh6RgivaLy13oPXkyNu0DC4ZCYviLWhHwNChG8XTT1PGTXSyDEmwVMsazI2snue8WGrjKz2Uys946YHDEYUol+MnqQvqgBjPR0fz7Apq76Q==;5:qdvKV1NW10JVo22sAT/liwsQ85tKR3FZK+4tuDgWcj0iqr3JVH7KjzioauO7cAmZHkmNGse9KQg8bBU/EFGL7U4M5P9gyGOfudEyoY9YYOgwR7N85CmXI9HZjbDX30BgXm4oTUjF75Jke0tIaJiTPavvFVO9bNvv8AqiKjtbmhI=;24:rAs6t4J5zE6j9URJl5G3jx5oEECOWzS7+GBRqWS4wYraJ7u0uwYc2yKRNFnGGCXb3sYWdlTWSB+do5X4BQJ90Hm6leK1tEp+337slhLbAro=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;7:G/vOWLup7nP1m2QKWthtSps9sohiC1Sz38aVjBjdFUueyDVF6tO1/h74rJ7WVsgQrc+CA3sijrxXOCR2fcNHoddo1N//38AE05gMIWS3W3VkZ0ME6SEok4BX9ajHcKM806kikBLi16L9wMiZzSvqaUnpvSVz7E+xV6BVIQz5RGNX5+s8mksIIRgv7l9z0YHQoglXvCl+/Rq+P+h9WP0Iy30QuEdmkIJUYatSxCmeLVE3criD8TkA5QMe74GjGWqs
X-MS-Office365-Filtering-Correlation-Id: 785e10f9-2aae-4e72-9b85-08d5cd0316bc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 05:45:46.9723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785e10f9-2aae-4e72-9b85-08d5cd0316bc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2746e2c389f9d50043d21e2204270403efb9d62f.

Don't need this patch anymore,since we can easily check 'sdmac->desc' to avoid
handling dma interrupt after channel disabled if virt-dma used.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8d0c1fd..d93b58f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -354,7 +354,6 @@ struct sdma_channel {
 	unsigned int			chn_count;
 	unsigned int			chn_real_count;
 	struct imx_dma_data		data;
-	bool				enabled;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -615,14 +614,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
 
 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
-	unsigned long flags;
-	struct sdma_channel *sdmac = &sdma->channel[channel];
-
 	writel(BIT(channel), sdma->regs + SDMA_H_START);
-
-	spin_lock_irqsave(&sdmac->lock, flags);
-	sdmac->enabled = true;
-	spin_unlock_irqrestore(&sdmac->lock, flags);
 }
 
 /*
@@ -740,14 +732,6 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	struct sdma_buffer_descriptor *bd;
 	int error = 0;
 	enum dma_status	old_status = sdmac->status;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sdmac->lock, flags);
-	if (!sdmac->enabled) {
-		spin_unlock_irqrestore(&sdmac->lock, flags);
-		return;
-	}
-	spin_unlock_irqrestore(&sdmac->lock, flags);
 
 	/*
 	 * loop mode. Iterate over descriptors, re-setup them and
@@ -1008,15 +992,10 @@ static int sdma_disable_channel(struct dma_chan *chan)
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 	int channel = sdmac->channel;
-	unsigned long flags;
 
 	writel_relaxed(BIT(channel), sdma->regs + SDMA_H_STATSTOP);
 	sdmac->status = DMA_ERROR;
 
-	spin_lock_irqsave(&sdmac->lock, flags);
-	sdmac->enabled = false;
-	spin_unlock_irqrestore(&sdmac->lock, flags);
-
 	return 0;
 }
 
-- 
2.7.4

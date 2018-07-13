Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933C9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFF22147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a3VXfa9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFF22147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeGMFXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:23:11 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:59952
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbeGMFXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dGpd66jhEso6apISiQaFJu5TVvSKsEqdowif2s3tEk=;
 b=a3VXfa9rZq+E+eAToV2ySbP655Zu6CJYeAFK6dfMhG2Ft1LUV3/fV1yv/QMz0UD7Uqhe67CVx8CRlvM5R/XvQHTZTEDJ41g8lvjtE7AA40vgIL5a6aTbjgpV00hvSe1wO0VPqn3wGLyiWpFlF1LBv1lnQWBA6B0CGNqC3dWlFEI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3230.eurprd04.prod.outlook.com (2603:10a6:802:6::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Fri, 13 Jul 2018 05:10:08 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v2 1/3] dmaengine: imx-sdma: add SDMA_BD_MAX_CNT to replace '0xffff'
Date:   Fri, 13 Jul 2018 21:08:45 +0800
Message-Id: <1531487327-21879-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
References: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0039.apcprd03.prod.outlook.com
 (2603:1096:203:2f::27) To VI1PR04MB3230.eurprd04.prod.outlook.com
 (2603:10a6:802:6::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f17385b-6145-4143-cb0b-08d5e87ee931
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3230;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;3:dW0YtjHW+0hr7j84r1mK7DwNd6XEqfdP6Ipn3mECFf/ha2VPVduUs160DMG73W+qw8pEyG/6BFsOdK9IDnOBAlZt82Xp1EWWe+yfEDgGRj+c60pNFLJR9iLoh4Zqz3khGt2iGdjj7PdlUixFGRQiUxdQiLs/5/jdFQT6QhOq54QKUUXfFU6GFnhBXs64JuXzvtIEfNvOhkpFnT8CiSPY98apM+MJtKSItlsANFDVudQ4NhogqCARHXZicb668gla;25:rW22s1G1sf7mF8sBX7F9ihvIhRJHvr8avzCSbLEEdwGMHFjeMx7J8wcgpHGGGKg9BJVmyLoo7IaztgkYZajaTC8QJDmT6WS+EXotLM6z52vjD9Qmwwqpc+BJZf7fLbkqi8kjqgX6nZfAciEgBlruOfK+KZOBFLKN/6sxC4gmlkewLg473BzDbCSn/j+WsinmgydQcGCHqrPaAx1JDfTgMLeLPDgQQpPPX5S/G9zH2wA8qJeMxuu5JrmhJ2TJTvKu0o14AdNpTdvwaK2mopgWVsQBb3rIq3l9a5g2gsEFjjcCgkHJjqpb8ojw3/U+nVCJFjGeidVEa2XoEB5ET6rHKA==;31:ekugZ89wllaKXF5MlhonxxTGLviNpCkDKZlD+3gGJQvbdz8EyYjJN5NXwVcIS1y+1qQWjAruJ07gwrjCqZdpTwlXH3vsektehGcA3R3vxFEruwkUKU0240zfkC+qbddjSiFiXFvDT+7jesMABYAZWsEnE0+uar1lxsbuFuguwAFjri9bYT1mqi6DxQMfG7kvXWR4rqCWmxvNuxUtbdy1XGIiSjAUUUf8iD/Rhwhtf3g=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3230:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;20:/troBv3k3971o/0u473zrXXV9mGrv+F4bFNB8jGRsXaRSWDcjD4bw4QsjTrMKRkF+Wv6wUdLNOp7Rnuls0UyKmAxQ0OInp24qm2O+rKBbqxmCf1TvS775HPF/qx6SdfdfE56tNEjHA1tXPjQYbE9ccrEqBo9CikMAvQjY0QAqZ7a3beigMNh6dWuuE6kPVo+TxWAIZ91Y63hE120BKz2ylH0zc5Jk6HgzhoeM3l5Mouj9yVUAuOtnpxLLpUyZ7ES9D7aU6GMheCx/eKJRE2rNEf3Kp2r0ZxH+SCrng+DcJV0MjUzpP1gpfwpkCCsDT0Nn7u6zgcVMCS+axvq8rOoxyj4PkLS5pAButA4VyxmRbyyiUozEnMAFn/whX6oQQ2sSKkrCDIg7U6TgDOvZoxFGjYZHzKM1+aTa/vt2iIA7NZAewrOmOpdt9XKSyfUDZRulda8mSVow0Rg6slSnuHeqhaP0l/Rm0Ps5EPrLTJ19/bvi/5aOlCayRvpH0lUVKFE;4:/Tj2+H/bSmrcn1UvI+INWCAbvtmXBox9y83DkejTXb7rV2cNYZOergXwHAguD1GfBd5XLTwswi8oxTv5rs90Xd8i3shoR0PV+U6Ankr27RYrm1efQtLsdiAxtLg9LEFP5gEGIbow7QEGWEyFqojQFKZkR4SEFfP6HBEXyVlmSFvBPxU7U0esJKJj4GzPfpPSS9r75wsrnEw9tyl4yGC8bJX8OTWjMXw61OQe+H/7reJfEAmH1c1a7Wtu+xRqTgAMg1q2Hdwa4Hx2xbHCwQ7GRIynI6tTNL9Y9IY75dIjSNY/gv1W4shVVGuEMtPVc26ZIvfT4xAKcXL9PeAlQjOEeA==
X-Microsoft-Antispam-PRVS: <VI1PR04MB3230BBB593FA459F1EE4512089580@VI1PR04MB3230.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3230;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3230;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(6506007)(47776003)(6486002)(4326008)(51416003)(386003)(66066001)(8676002)(76176011)(11346002)(446003)(52116002)(478600001)(48376002)(68736007)(36756003)(106356001)(6666003)(6512007)(2906002)(16526019)(105586002)(186003)(26005)(25786009)(3846002)(2616005)(476003)(305945005)(7736002)(81156014)(86362001)(956004)(14444005)(53936002)(81166006)(50466002)(8936002)(486006)(16586007)(50226002)(97736004)(5660300001)(6116002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3230;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3230;23:WfRqlIr5Tc/p4iHOvXOtfUflEAd49QiAvnLp9fvL2?=
 =?us-ascii?Q?pENiEvm8sXrl2iCfoLUqHyC+rWJG6iLW188RdCZDwcBI/kHttJKswkBEZDVQ?=
 =?us-ascii?Q?B7WIFAYj4r14oxZpoCsRFUDwDENzqa9qZHpNDT/Mxa8pTBBbVuP0wCVcP/os?=
 =?us-ascii?Q?e9Qpn+CoT6YNQTcL/OYeT7yprAnKrlR16Rr3C0CE8/TSpuGgQbro5MTYLz5E?=
 =?us-ascii?Q?eCd3W1Wgp6sknnLL4W20QBRert/HwCA3xGtV2pYxsfQhF0zQZDMe+5DfTjNh?=
 =?us-ascii?Q?gmyLK6mCHuwMpfJ3zdUE6SeSpTsI+0D2HmNT8SFQmdk7hpVT6Yujzr6w/wP4?=
 =?us-ascii?Q?UrHYf9WXL9MWEFNm0jjDWJ6eLXTkZ/03nmhyeGxZ+EvBKh/CoI6wEwDsItOe?=
 =?us-ascii?Q?yQORO7brv3qm1NyHHMJAJAt07DZwAmHirfZpL5Cq1wGvLv861otzbGq+EaHJ?=
 =?us-ascii?Q?WdSg+Bb8LPMyUobgR7D0xbIGCcrh24DEgFpFbXXDJxZRZwkSKmkrSX/qa8ih?=
 =?us-ascii?Q?J45Y1sVchBr2r6NtmbojmS7wlGy+bsyxNZNsNoyVeThlg0sn+q4GCURql8DD?=
 =?us-ascii?Q?htlIXh8EaEGRXuTIKISctquRMa1QJqTzvcWeEoeap0qNLUVI9s9l8uoZYO82?=
 =?us-ascii?Q?Oj6Y/dlK4DTxApuz8WSWl3/WJVla/BFXG7NgVpyd+fpO/m5kb8eNNipPnJsl?=
 =?us-ascii?Q?TzJGZ6fL5TdbqZZqIBWGQ9KdBbtGrazLNGCWpRPKd38chsFyO+eiXMrzkgnw?=
 =?us-ascii?Q?HRiZtTCdDU4FsdG3XkEq6zoKyhujWkE31NfyClcQ24u7uHC/UYNlMx7lLAso?=
 =?us-ascii?Q?5GlUMUmUaeiSBB0/FZVdn02DWcRPkCvTtVPNWnXYIRn/UplY2Al7NPXALYbT?=
 =?us-ascii?Q?g8fFAlVfwNtBWZaVNjzZuIZYD/Nq940pbv3ufykA/wjaCGO0brzvzKuCQEb1?=
 =?us-ascii?Q?+oen79l9ILl3oqsOJA5gbmVAfL+O/V0s0bln8HKo39ZvnBbQYwJIbzV4kao9?=
 =?us-ascii?Q?2/HsJ8rR7rjy82NxXYE9Bpq/HwLTqj+kNM+FfiMPT2dNOAGNdbIHHXbHY53E?=
 =?us-ascii?Q?IKHM8Yv3+VCac1E98u6RhtEqqkDwTKKN//e1rq+W7rbeSFdEGhy477KjyiHr?=
 =?us-ascii?Q?/kJRmWKqlN9X6z0iREmH+iECZRq7UbxEsZApn3xRDqgoQcjAv/rSQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: hETccG6kSR2PWzicCuiDxENG/Q4Xjv0Hd9+8dnZk9bHU1y/jQ+LeHZMcx0Hhan+wyZw+Bwa9GLT99r41Rr8MWogPlrwF8ah5Po30bVXGtonx2dk4phofXbdLnDvpI9jwZv2F4ykoZAvJjTRddPeIxaKm9g+y1IRjR1lZLwdUfg4rkHyMCuNLPWJn+iiIv7v0aesVrUNjXfJAABhECdcsPwKred1rmOuW/EocCzQiwddqAs2qa69FsRhD5c/mmoi7dbA58OC71QbwcPBU2FWCl5hZks2diCtASgG4hrRq+dg2wWxjMkODiHYw8e4Pv4IBgDPp5rM3gsz2X9ufYK5YzBo2werwqup0UnjZaeFHhaU=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;6:mXFkl32+apU9Y/0QjtUUh5Cs+jzFeI7NWyDOi0zGuhJFwd4JSvgFyE03xksxQMs4JM5McwFHA7Qrol0AgNmBwjuHe3sikc0jQaozEM4LOMrVoyTWa48eRxcKYxBKElXD7j3ysj6JPajKTT6lzPdtNQnuH+F0Y1dP+fKrurUIkBI54JjEehvT2axntBBMzghfon9Y66qSDhJZifySjtbTKnoAYPh6B9iDPFSNDAgZJmi17uY5Ce4l3bJ9UVRyGlskpedo+TOGesFrntHlesZmUXFczidV9G5yjo7ciSbjJzd79vWP5v6tKLw25TCrLx52IbK1IOa9IGA2DbSdaJpP1l7SqXzMQHVI5NGzq7zWWyEmIICND8dw42Mj3gAwnWgJoIDUl0/9yidzxHfLT1gkug72vSj8CI6YngFgh9pEuWFP0FwjgziUmnSyFB7/JsBoDmGZrLya67w+xG+ue0J1FA==;5:whWYaHEnfhaJQjJCu00j89SaHfhgnreEbduLOL7E7tHXvBHTp4v9fFSxr6jCm0FIH31XGxZZfPzHksM2cQVyHL1y62HlzTWHkPDah6iA/O/ql6a0oKXHJ7oUdqZG9waZvTM2eP2XmPOU+1jIlHpfy0RuZVjB2XhrCvtd3aWFlvo=;24:YGCAN0HksvDsZMFRnBOmordqp4sZe0ysirCRN1pgtrvinVQJ2FPcE6Zj6DbTDzLZVHsQu58xDyH7ANiQUvraWl/ggq8+fnH4/ODZ1tV6wVk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;7:pPpeyN4addcxy7xkA+TJL/gSOURBvjMxKftt0cKGSCwGXCk2Kt27cTk7DyL/hNDdTGRiUS0ycMIVKqrukVXjYmJnB2ewbDM09Z6KlX0Ie18m6xt8tWePB6WmN+M6H2p8EoW2wKrK6gOh8VvojyH/PurDYXdpJdg83yncOkYqtNcEKUM9S87wu1aGf3+opjjt1Ume7MWLEZ+i4suVABfyRjJx2Nb+97Ufr0Dhb6TB3DXef0uhDNbsDjHwN4dwLiSr
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 05:10:08.6278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f17385b-6145-4143-cb0b-08d5e87ee931
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro SDMA_BD_MAX_CNT to replace '0xffff'.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3b622d6..e3d5e73 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -185,6 +185,7 @@
  * Mode/Count of data node descriptors - IPCv2
  */
 struct sdma_mode_count {
+#define SDMA_BD_MAX_CNT	0xffff
 	u32 count   : 16; /* size of the buffer pointed by this BD */
 	u32 status  :  8; /* E,R,I,C,W,D status bits stored here */
 	u32 command :  8; /* command mostly used for channel 0 */
@@ -1344,9 +1345,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 		count = sg_dma_len(sg);
 
-		if (count > 0xffff) {
+		if (count > SDMA_BD_MAX_CNT) {
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
-					channel, count, 0xffff);
+					channel, count, SDMA_BD_MAX_CNT);
 			goto err_bd_out;
 		}
 
@@ -1421,9 +1422,9 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 
-	if (period_len > 0xffff) {
+	if (period_len > SDMA_BD_MAX_CNT) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
-				channel, period_len, 0xffff);
+				channel, period_len, SDMA_BD_MAX_CNT);
 		goto err_bd_out;
 	}
 
@@ -1970,7 +1971,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
 	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
-	dma_set_max_seg_size(sdma->dma_device.dev, 65535);
+	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
 
 	platform_set_drvdata(pdev, sdma);
 
-- 
2.7.4


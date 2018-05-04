Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeEDN63 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:58:29 -0400
Received: from mail-eopbgr20121.outbound.protection.outlook.com ([40.107.2.121]:36370
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751533AbeEDNxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 13/26] drm/bridge: sii9234: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:59 +0200
Message-Id: <20180504135212.26977-14-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135212.26977-1-peda@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::25) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:SNtQ0G/mEiPbP9uH6TpER84m+/LydE5c8tcb78uHcTCQTLbsoTPnWEqTbCfT39eNRRKdXasUHxVKKOQs0ZvRw8neiDsX0CIOPF9UYELCIi1mwJNC1NuKVfPhgR1m4Lba74hRzGj5eKNtG7SAPpohGPqFkm/F9GgoyWJPjvZqjg4QG4ZkgvibHNoj4N5mPfig0pUfjsN+0MdcQ2s03jR5oipPfIYa42iHYMruW6EtNF6Lj9f1pojbNi8K2yfQvkst;25:YX66y+GRtrjQSx3el5oYuvIQ/RGpShdxt+iowtrXrDEGXGcoPQGWzAofLrGRNZY2GzZNyWAxqkZFNVWrTO4VqIYcoV7YJ5G7F38KI7gIBoxWUH+NK3O6JAckHXlxbQ8i2ZTMAnBzYuGBLfHTxEKfqpr7nodkN6b+fJtXntBKGeIfLoct1bcmED0d1I7ydgDRNZBMeAfuvRjU9JMoo5fJSd1/yq5+QEI9NxeWtyJTunBBiIGir89zqA8sejyTtH98RbOSHVBAXc63VKFmlQQWCV3z4JYkRqo+4t0zE6ZSQEZfyi4KsHurw/Ex+b9FZm9JdMfKBRo/lYsZUTBhda2eug==;31:kKXRH6I5sEWDSzQTzo2ZDc2PjVSY6t3BiNO1t7MDabsZRq/qpyjb468flg29knNmGMRHQDq0lumwp0yKkXr5Z7EfSbJGMtSNeVcdfBPLk11bKaUWcszZptHd5OG/gDHBesOVNaGUtHmvPQNbYRcK+I+HfSBmbj69U0sGoUK9XG2kLHHcAcP8+C/2laq71aF9M2Yrlaetqn1OTSGFwoSCpenGZ0Bnkn6mLQscwRw0pTw=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769D9F57D0BF4A3D21C9E96BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:mGtXJaVMWAZoSAdl2b81+fEWn0TIvJVOA+NSnRTn8fb1MvECKcwobXrRTHMYr7hR/H8HFU9zpLjA35gT2iH7aBhKnd2doz1FRfRn0hIAmzS+ywuhNbDtddH97Oau+5kbyp+6jFJG2dN43l6Jf88LEtvW3kC87fMAn9IlEqyuC6CkUo99pCjgCjiuEP7zVQjtKwNXsYdN3JmEq70/meQWRzfM6/iBHi90m2CU4griAh2svs2+Dl/P5GLIcoQ9x2PFPGT+eA9B+XCACazR/9p0ww==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:uo/SmDa8MfX+4gPm5DvYey3B6iWtK0Rcf84CoJF?=
 =?us-ascii?Q?xHpsUAdBLsz4lsnuH0fgR8i5GHQQP0AOpo5bXYSJlBBp5R/PfFNt9coFilGK?=
 =?us-ascii?Q?fCD+YPvAubgYdqZ4mLUObtaeNYZHv6SZrTLLRGqMerOHqZm4bZC7yZ42mCZj?=
 =?us-ascii?Q?JdUbUsc2bY4DW7YziSxKSLFsa6BcvinHwwmeCTp1ZFuY/REBHqfUC7UUwPuv?=
 =?us-ascii?Q?deEgJK/qvvg0mHBIri1N7y8RX+tf9rMdL22MaJhT5gUBTp8Qn/scKIp+bbhM?=
 =?us-ascii?Q?K2jV20hqqjtdzai5M2hhQT0FM2EDE99F07E+S/8WDnk9R5Flq79HUK68NKf+?=
 =?us-ascii?Q?9KnX+Xauil0+Q0LIrjBeEpK2M1miXaxYYbAqlbkoaFVfTSfOV5UNeulouCt8?=
 =?us-ascii?Q?jznpjLMKuxkOJDptJPMbwrqDSEoU27pXjs6I3RGr8UN51i4gvE5tLProZ/qQ?=
 =?us-ascii?Q?tWxH0lQRJU4ooPz1Es5t40ZbPWd6RahVBo1XjMmfV5VuSRYS2Zu3T3IZfJKA?=
 =?us-ascii?Q?/q8wPrUPZxlEkGmftLv+IlHkpOpUugkhY348/hn9QsK4E8vHZ/bANFmA+n+9?=
 =?us-ascii?Q?qbhkc8tmVrHXxu3q7EgKriaGWBnxAuW3cCdp4d3M5nQTbfp2Ko5EIGYGbuG1?=
 =?us-ascii?Q?IhBJNtAx4hWo9ZRtl/ZQfYVVlR1I/EzCuoD6Tiwo+osIHJfqRedgEMFnjITJ?=
 =?us-ascii?Q?63CPKOSiHOgf/kEVzi+dQ6S0nIZ0tkMwOaU+J7QpWw3059B8sj3s+58Jt3ea?=
 =?us-ascii?Q?L7e9Uf7xeQaJCMb2w+iou5QcrU7/xFSRu0+0OY8RJq8KTY7anx6GmFqchJR5?=
 =?us-ascii?Q?g7bcRCE5ihcM5jyVJyldjOeYYHPDLweHHMagkGiy6FJ7xefBColxQxW0cLzN?=
 =?us-ascii?Q?GIqhKiheKbR3CqejjrNxwf3Bn9gHOAGVBHcJm2AcoG+bExsUS1Fok11PD+hv?=
 =?us-ascii?Q?hSNx7FDFMAs4+Jy/LNNXItgIU7Eyeoa9yJkWinaAB3ozgShnCKlP+8VL4ekx?=
 =?us-ascii?Q?hZcsTGY8DCfSG8+7UFpQD33biU57UlLv64+t38qS0Q2X5jlRG8ajMKbumcpu?=
 =?us-ascii?Q?PXgz9RlDK5/6WcANMPRf6UqdUbNRxcIAAzLwbB0/aVRpUUP5BGF7FAE4MuVg?=
 =?us-ascii?Q?wHwc+Hn1aD5kQzOGHXlAdFTqKJ7iy+adLuhO3z+GMdWmgfH0WzL7cE8uj1Ma?=
 =?us-ascii?Q?xgyyX3y3gw5WMRtbDKPIt2c1RfP7zC7W6rLpbThkdDiwTPrns2GdcQf05OtK?=
 =?us-ascii?Q?pUpEJeDrD52j/sP8EfzlMXKWAs72Xi2JqKDcTphmpUagZXiDff6OE/+SAzuS?=
 =?us-ascii?Q?ZOvTJNqfc5WJF7M6jaZ0C0IMj1rakgG65cIjKKW0kWznZBxC8e3IZ+embrED?=
 =?us-ascii?Q?lraqNgQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: E+UNP8MZAKElebgcxNrKaQmh3fxzfMAVggyHE1W7cApxbXrbaCQ8MEFCb22PuyUEfG+mXl6igtpMGXc6WDPmym8dBQaxjYY2qNY1GzaqCAClKZUq4MMGXljp4xxklb3pjaLr4nfJcGHP1Q77JtIv8ZDgcdyDqHKsVaFuP+jpW1So/MsmrNexFhNRNbkbiuUF
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:FIUIR2Qodsla1BFoCVJFmCJxv6EdT0bXnL10FMn0SEo1fRrcko36MBiIFWqwJTBH0AMnoUSd0G3e6a773GTy/XRoZ95Fv6WMbJivh0XtmpZofW/YhMV5K5pjSVsL9O5OFkUE5qP7jcIbHEl30ygaGOCtABtVP4g9EQZOHlR9s34Kc6r0uBiD0emoErElTRYcy7rBrx2pz/840Ib6H4N2GQO2jgRipIjQhXm2l1JtJMADxYbQZQUADMHXuIT9wDa7BF9NsdUfxFA1+4LWaP08fXrdzIT0DJeTStoHhqPGIrIdaMoT/of8Lbr1GBLT9nIeRTcvdu03taw+VPOp4m7Y1BCZmSv2XHMFUEgPlI1S8rjCMkoJLU5i1X/wbbKRheBcmLLG6q5Xxnm+akoPL7LQa051mxRoYbbsT1v9sLd3Fai7XlJHWGG0/QjIw9ZDUeMZmbnx79/IOMdUk4TIJyorvA==;5:y7x1Xe++5NJIb5TXG1ybx3kuJuw35HW+xvbz0Kc3i6faKz5ERjukOlZRKTlv4GxQqqUbZgnyaCgzHeYBGTwgRUVL9ZqwHQD/MkCPRaNnoG44hVZxnzl6mSK1o+O/t8HIOtpIC/NF+YNLPN537nPHtbsgMvg7pF/DTJX1GfK9qRM=;24:a9DRwP6CV83yL1d2wGsSNYXxOMh2WHq30RkV5NemGinpFTlxceHyUkvyr0F4zX5XHjTeqwGScm5R27ZeazmT3uLcTgvoPng3F3u3rKegUbY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:gyEJ3x6Rsg0KaWHYun5v7vK+6s2FqYV9lytmALTz0ry4ahoJTQOYKRA6GzocWy3YqMgzVQWvCb+QheDIv0kT0q7bURCVC/QdR4HG2fdq2EaIWaoM0MmCrwFOqvduXYqEdRw5pYIAo0aMGcjMQIIOL4t4ldJJhFc7xhKPeTHAGvjhGTHJvZMWAJcn51llYo9bn9NO256yTAcHLw5zNUpjH2ysOPnznXPpYJgx1f81N7toqwDWWamzY8X7tCmnqDPg
X-MS-Office365-Filtering-Correlation-Id: 73c2d665-5b85-4d07-5d0e-08d5b1c66165
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:13.1911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c2d665-5b85-4d07-5d0e-08d5b1c66165
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/sii9234.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index c77000626c22..54326357b2ee 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -948,8 +948,8 @@ static int sii9234_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ctx);
 
+	ctx->bridge.odev = dev;
 	ctx->bridge.funcs = &sii9234_bridge_funcs;
-	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
 	sii9234_cable_in(ctx);
-- 
2.11.0

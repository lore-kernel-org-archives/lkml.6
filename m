Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757302AbeDZWga (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:36:30 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757106AbeDZWcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/24] drm/bridge: panel: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:24 +0200
Message-Id: <20180426223139.16740-10-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:gJBcJI/Je0stoLXpi/qrh/+CioWb4yGLsjfhUGA77qCk7Q/LraESc3pmy30eMmoDD3dHZjplJitiEQNuc71jw7EsgRoC3pPq5obreXn/7C/JR2kH1O3h6gPHog2kQ91DmUFCUq40YY5uwsqLL44/7CZgDcqnBzmesgYWYhj1yRk8axnhxVuWJJd4aYBYEtOKhPA1lG3IYWCk0ctqkP27z7id8f/ZGjSznaEI5W/+CAm0ELzDyz8VnCKWwfs84X3j;25:Wt6XnJgcV8WAgkbhdbshZ8bCvE2lcxzBzgRQbKPd9THLfgMlMfhQOjlJTtVpGDFDsDRxA/27ztLOQ20ebaxATnnHvsqz1ETxd+o5hNkgFU0yC2q1JDz77dbDood9RdJaHUqqIMox82EWuY5pqp9TdeeEkEtkuCt7lIF6KD4XO0G8qV4wgUaOvTy3CF3a/mJ2XAHNKiHakM57U9rgNBTt+UxYGtJJIuE308LpJx0QQd/nq23ilgy80azHwd+5aVUr7Zx9y4CkUIqLKcFEps2Ramgqvt4uUQcMUnXyklXhVro4+IfoEMAy9Ok/kgf6C5Cbx2KLUkmyCEJ5MWwJ5mR8UQ==;31:tMtI7+b71piVbVl8GZyJMzYetk+UxjP4zSooBVKxPiy+3HMw4p2utkrs/0kmj5N7kcfpJpoPU0rSSDCGPdxoMwTKA1B5s0cceZG+WDDViP1UQS9E4/g979XLu7UPMhSzl7qWH8uanCjN5ppUcfVR5dOVOaw/pz0y6WFse7T71XIvxR8vmItCLtqeXX6yxCQnK6ZsoN9dgthlfnHOOksGg2KpN8wbyzHjk/2rG9gF7RM=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27826BF14A9AAE75A649756DBC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:Ma+VOHMTrscBGHV+kzqZmukfZ1opun8DoJKIxbw/cNIASg8bhRIDs6v+Bd8Hd0gn6ZLer574pzbnchJPqhuSEVlqL+tEkF031l+EAeV30j/V922E5RyZmuIi15ISbQfHogS7AMjzBhs8j19S4C8UVOCQHxRz/Yu1U+frSaWdnz4uo+yspW2rozkT/RCaifTRqLLyVriPaBJXgwhV1/kU/Y1IsEzIV1OSGvTSg6++0XANZYhPqL/Awrxht1W9V9Rzi9RrdNdpqQWbDBQPAyKZaA==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(6666003)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:qwxTxdyXqukkFAhbZkBEGHPUyqYtY2HPs0DoHpb?=
 =?us-ascii?Q?IDCCQ/KNPXVzGst6LgYUcrDcbPNqdc+S8LwgnvZPnPwWs5wQQFa+LivK4yvC?=
 =?us-ascii?Q?2cd4DpYGoUkiCodmyfEz+aIRp+CMtEZ7I/jOVVpnPqij4Hhcb0YdE0SFJ0Up?=
 =?us-ascii?Q?9js+LtXbsTyYYe1vzBQv2xO6idvAsxNl3JUpQsK8pWUv5bAtcrNBvcbRpE9E?=
 =?us-ascii?Q?9iyE7BWqXBbHSepXml1n2Rhr1VsAn1C2BgLZ5Yikrl26PRqc2Y4hYz5U3jwJ?=
 =?us-ascii?Q?npsuNk6dGBdMN1CjyjM48V0gdJdSObDI3H2/9+ULon56+yha/M6bQGrh6bpH?=
 =?us-ascii?Q?YJ7y20SfNHPS2wgenBOycrG0RATfmtpd5Rv4QVZuz+AM8E6ORL0BSVbhB6sh?=
 =?us-ascii?Q?8f14yfkRuju7+oceVTCC6mI4cQWKQK5I+MYxGYnofjkigGd6KobTGnWkbvH4?=
 =?us-ascii?Q?67TPEcrBPE1VTMYzphfWwGaeGKBvyAGsephmcIKK0qLSfwl/X0CGmVIK7TTD?=
 =?us-ascii?Q?B7VX+tWOmEScTUWieq1YZlaty8VGowOSdpPU8LyxxArHVPS6K5vdet12xLER?=
 =?us-ascii?Q?ujLuXVqyGV+BcZ9o8fhi8Q1Eg/iIKFf5DoRCbvl2acp5LLV3Tc9w2W2LV5kj?=
 =?us-ascii?Q?YSFxdHkynuuBLXy78G6qALXSyP8HG3X84AmUAHZhM8OwtsM8ycGjEQSM+YxK?=
 =?us-ascii?Q?NS81JdUzitMFUfgHmJ1oAswwYf2hnQNw+Co/173a8HhzRTswM5XdpFoRpu7X?=
 =?us-ascii?Q?0GMr8MJ6NA5se0gnoxlRmYzrYnBkYtiCBAAjperxjWX3Yog5wk0rsdu6lqEr?=
 =?us-ascii?Q?DBBrcHYaetSYVwgkNwd55LSmZL9aSGTjoHl3UPYdJlPmWp8SxESOR9pocrqB?=
 =?us-ascii?Q?4tJ+89xX70VufvcvO+r+VJ7BK9uub5RbzUz7Pgf+V4l2W5mFtVyHKSme3ZYi?=
 =?us-ascii?Q?qILMnHqQk2G/UW6l/Di7+wuRiCtE6MDw/lsxskJU8Fh4UH5z4SZm6f8jo8hw?=
 =?us-ascii?Q?85kKTd7JcAPynDMUZysKyl43HUQWfyQhTtUl3kr4guhQNy3V+/txp77OKxS3?=
 =?us-ascii?Q?0degHGuvOxZ1VYi7thcuXFTR61SDSHrAEsqDMXzxYE/cdodwgNkt1kdpLHrD?=
 =?us-ascii?Q?Da88kjIET4ZDl6w0dEpP+3DB3eZPM2Sp2nHU/vnfYQys74sexnNSNXSBAvsJ?=
 =?us-ascii?Q?+8AKPRvJ7T0n8hrPJvBpogXAsOHAc5vnjOcUxPGGCXmDlxdgT1J3KIWL21sA?=
 =?us-ascii?Q?9o7Ob+pCcORFTa4yab23fy9gEOeLq8FwWxVLaYgXswqraAXa4F9WLJl1fJmh?=
 =?us-ascii?Q?ZKZvxygsC37/ToiZ3d14sa7o=3D?=
X-Microsoft-Antispam-Message-Info: xSlqDRDdzhwgMRAgsLt/xyB1G2Obv2my8mQGa90mRqFvSOi+asLsHu3N7K4BX55FnNl0Zi0NYupfKpZZc4YZI/2KsNJJ9UiZFrTvCIB5O9bKmAA0jC157c3SJCp/JZuWa7c9lTsYP4j+TCDV7dKW9+Y13g+X4SvzPsK+cDZnjIx+ahUyGcjLJTiHHbIOgh1x
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:QzcABYRk14ilu5rLWlU09WB6/DSyllbwIYplzjQcdtcECy0wZvF7q52Z1bm1wKXjP29OJlJmVIGqtAaFx8SCfdmBJ8kGz6mwG+WgJkOveig2ikf8heVHu6YGnDZeT5dDuxdijkdUIcNONff17mQn6CJ8ZpnRedz6m0CTwtOiyHISmBQ9foljKMj/ia+CC4/fLvAm5D7+e15vK5HlzckdaIKccB7WpJMwW1uNk2QIgn8zHHDFT9fzkD1bHZ2wvNsNwrN5SuL0d+TlqvLsjaoc458VSv+20hPIfLrGHvc4VbH3E2C4o9zbtv9i+x0N+YgBGPwyJsquX3ns9brNcm2mLxmHwIQoFmvgDRf3zQ1SvZsoyNKfaWZQdH4kXq2ieFFIhB7RZceCmAXpDiBCRzOykH75nc4ZcStGP1awscNIWJ9g6h0jiohGUyYMqMx24eLgXq8tsZtGFPc+tBCIUH6SuA==;5:aAHtda3QNqO7YYEI5a2VqlUY4v6+g9Lenns6QoyAQApyTiCtS7m2rosfwqfO/wKmYnKiPm9gsbSm9BD+LOAuGhUFL0Y1p3yC/M4Ku19IuGF8OdyL2+QL/BucI3aCnPCd+OgbpSEKPW+5LKKEyvZpfpBTSiD/+usd402jsPNE3/w=;24:SNs5aQdu2aXcjhW+Err5MBRKXJ3Ge+gF+awuv4i2mZFsPRop0I0vEn4gT04aqpy5Kg1IEz0AdwP39yLPVfYR53RxOOy5EMnwadFqsfhYehU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:lGyqBc/iCS9iqZ7h4tpxvgQgQ9/1/wgNtxeiiS4VZ+nKRNmlntIZFgD/nOOb0Or9hbsxD2mzi8rZdZ+wtg7MI9/l4XZcsxhHeGYlrqNdgWx1KTjzpLNJx3idfSfYerWj1irF8B/cHnVFbmhVXhmsHv6iphWVtRGtPf2vk+JeJm4YlKLTsg16E1VTY1jpM2yuENS6P+ET/hctBhTf2TD7eFVhUTs3sdKHyDfwcC6xknCkdEaoO5fGCycTUXT5CIbo
X-MS-Office365-Filtering-Correlation-Id: e7059ba5-2356-4ae5-6452-08d5abc598cc
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:29.6356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7059ba5-2356-4ae5-6452-08d5abc598cc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gets rid of an #ifdef and the .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/panel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 6d99d4a3beb3..279271a1d7e7 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -169,10 +169,8 @@ struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
 	panel_bridge->connector_type = connector_type;
 	panel_bridge->panel = panel;
 
+	panel_bridge->bridge.owner = panel->dev;
 	panel_bridge->bridge.funcs = &panel_bridge_bridge_funcs;
-#ifdef CONFIG_OF
-	panel_bridge->bridge.of_node = panel->dev->of_node;
-#endif
 
 	drm_bridge_add(&panel_bridge->bridge);
 
-- 
2.11.0

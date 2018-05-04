Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeEDNxN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:53:13 -0400
Received: from mail-eopbgr20093.outbound.protection.outlook.com ([40.107.2.93]:22400
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751533AbeEDNxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 10/26] drm/bridge: panel: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:56 +0200
Message-Id: <20180504135212.26977-11-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:RP3kmm1+93fUApgvKHgN7vzX1B/RGAdt92L9voBgRet8C3BVEH775l2I8r0hfLQxXEaZsMyXqku6ORtQ3arwxRr7j4V7vwGTXdKmutOm0Bwiy/zFZX0vynKv5dAJpuWKT+gRG5csZU6pYq2J9KtjJPz+JaINkutEw4a+ANLocvaV2Z+LwGi4rzyGMhawhRPjzj4jr744GOE7Z0Jy7zrk63ZWB7dM7sFGojD9OllEMwIu70X54P2JJm3x58bf5X/F;25:dEGG4T00nsLDvcx1mwtYBslZ0DHSuozF+ycPgS3DajLcsdcf3/JC2ST5mbZZJJmjAnTqVr49C2JdELvqfZSMbZfSWIYGs12HSU7Seod6aKnFEx5kydqn4EDYraTS5rxjZ+ETAn2g36PNQdqgDFTp6a5hA9tulRkTmhmQL2bHyqYsqXKAUBzePfc/7cT9qBwyMwB2pA1UP8IaybyyUFXhpr7LXQCralNDD2GB6ff4I1vEbDnDb2r0l/QWV2keTPRZ5Yv1OSee+XHyYR84zXHrjxGc+ofVr9W8KWkTjWRafg8HgYIzxOhLFJrlmmKe39EOgA1EXq/zOyF2+kaiZWbQcw==;31:RVmNyii+bWOcSXhVeIngjggH0LMwd2p4xZmu6hBiiA70xKb6kIwwHbk49vkCWHDR1X20/SyWHtmfAxDC7HsvzaX3zm8hMN1+12Auy4cT/SX+aaGTwQ6kbDEKBMAxctziSSEKspclBcLdF6NoGHOfo9ogS1dH90mZye9GG8TZSc5tNhJjmrwX4nj5dYVoTq8yXE/PrvYe0nIw0sZSl1gEK6TEJf89t65fm0SfBX/NZds=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB276958DD1F883FBFB828D516BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:zFa9X9WYqM6cu2mhajjhMflL94ci/o7dFN/d4K1zWTHFN4zJYYCMNRuZITbD+wJCgAX2fpX78yVFP9t+cUBR1n03F1UrzkwOcEDFJP80vx+TIVpdOudM2FbFYKb4nD2zfLuLzDhxuHptT6uVRMn1U9x9zekNOILRY8ClC99GaL33bJKnBJuwcGphQ5WSlxbrtwneOUgZzkubBWv+rfZx5T1nlIIOb2rX+mKNF2Gy4nFaE3kC1XbsiSCDeurAq4ghI0dnnoLqfUNujHBWtMubcg==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:C9V8pCVpw97D9rVj3JYxDDKq80E5+IemstUG2q6?=
 =?us-ascii?Q?A2XgSbH7iSeOYoRzlBGgLhCSe/lasptHghS9NJwIfKEJ/rF2/iyTKOnr2T0X?=
 =?us-ascii?Q?uUgjVELsBzQmOptpFGwxM1Zjv7IbifEFpJm/chDQP+mZ7ZqTYhGcmjkQF2cT?=
 =?us-ascii?Q?epkYY9LtoDcH7Apil98aXPYfNWRTlLQgPJgOLemUUAJL8SIrRhXsfw1Lehr8?=
 =?us-ascii?Q?Zig/dST/+R31GFrHe7UZ/pmO7fQDwLjZcu0XhYdoxPG/7uWX7E4+g4oN1kwV?=
 =?us-ascii?Q?thzdTeH62uSPF2fZ2kGORyHiBV+5R7rwzv6OIw3SGAXsdkf1zoILNoxZHQoI?=
 =?us-ascii?Q?Zw55YI+YlQgmbzNVmxv8kJnUWGmDokUhKUNAGJ6fnOcv4+9bGKMMXulRjfBr?=
 =?us-ascii?Q?1VcYpvsnrRSDOYx+54h3a9/iuhN/38JGFATTmx4aWnNN7sCMgGP4HE5aFpi4?=
 =?us-ascii?Q?5vOF692ttn1W032bRtNV1V6XKSIKtY0f9zdoAgiALKdgCfC6JC993exxX8oc?=
 =?us-ascii?Q?Y+57lJ538HWk1WBDKQDhxcNS2ueicQBtsYDYlMKIcpVl3sWFi1S76o55D4uW?=
 =?us-ascii?Q?WgCz1IIUraMnZyMQKrdvyVyx8li/+Q+TmRnfkx2mOa/rJQjp8D0g1wMIAkhh?=
 =?us-ascii?Q?ppzfGsLIkNvEgA+/YNXf38yaMKpyacd7s6rEzqXMd94Vk9Sqz1dVcpUePmRB?=
 =?us-ascii?Q?3x/bnMx6wz2zPtBPBdOu0eDYeiqQ2tqMsTibWTUO8JgABX5OSh+e0yDJG8tU?=
 =?us-ascii?Q?ZScL6UXr69YzDvxDM69+h7+vSnw+0YRb8MNTOd80B82PFyFmYFsS+fvzP8gX?=
 =?us-ascii?Q?B7zjjSyQL6Sduo8JwfadAyRoyVOE3UQCKJmGOq/Nj2yAsWs+f8Sf/+E/yDwm?=
 =?us-ascii?Q?bdSmvCCxrPZvagydSwZ77ugkJ0eflwu51deTKgd8Ycvkm946axs3knw+4G68?=
 =?us-ascii?Q?y4tIbROtJEjrIGFjHAfLCPtAVSnP6CfLJM/TpPjnPbX9lB3+LXDs+ckLHdNf?=
 =?us-ascii?Q?gd0oB3idSs4LowqPHTxbaiY72L/FkrE0wMWCRyKwamnhYW1l5elDX/hdnUYg?=
 =?us-ascii?Q?D36/HOove7gCJ0h/3eoMAh/xzpaZNyffBXs1RAT+/9KbgtJ14pCX6aj3zDp2?=
 =?us-ascii?Q?KGa36/o8x0MaAZlSIlcup4h4J4vqE0bWI6kXRR9uWMlg3ial3ZJAr3Q/EQqm?=
 =?us-ascii?Q?wclYO9wauiHUOcsSev3tsHZin4bMxCmjSop5/197QkQoRyIWFWD5jww17lOs?=
 =?us-ascii?Q?VYwF7qmZTybYiskYJQbrZ3VKnGumm3BPPJDM+eJnaknhL+tzsdvNHEhueP3H?=
 =?us-ascii?Q?VGxssPrw2FIQs3pqJUJ3HLDg=3D?=
X-Microsoft-Antispam-Message-Info: MNks7IO1jKh6AD4rjFM8CXVjm2sQaLq97ZeycoRTY5ztXn/0expwiOtLZ/uomXI7yhbK8jFjRgJPEi91P1Wjh+LYnjB4eZb1NyeTFBZT4AnGXyN/dTNyw9WE9QfZNoAXVKEP3L0OoBDNoq9kignWzO1vs+7RUuN0JnBOtpi2FRKY+kzxO44434IcPhYxCNtX
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:0ifU+GsyAjEYqoxhf0/frnsNnTN2szcBP4z/4fIbH8ySd1NJA2ExHiP/ykCQdEiKp2GX7/Sr8sc9SYBa/xqQKiEB6DJ80kcCJuMHk0WmrZPeHJzUpL6wseSpNwbQKY22aobEsbUHzYtDFoBW13Dh+N9Rxy1A+h5NrEWTnEErRdiS14u2E/qgQR0nL8i3G+0QjzooWwDgNTWX4jwwpXh6kAgjJqYNb1YzdebuOHyxKqiMHt4jludfS+yRRARCRbhXU/3u4TlpzLtCf0cc+qQ7eHehJ9U2VLqXUtOTUJFRzZSxDMmbhq3uZKVOk0I/bkbYV+U6L/SfS+Vl3jOK7R9/8HIP0NWX4mhUnN7ApNfArGkb4bPp3Z9pVxw10yDeVh7RRsNIr/DOooQeHS2Q/h5RNrMUUgRdqYY6UK9PyaQveHW1Wzt0Nu371LMegWbIDxqAe9vJEiPsnE9eqHtZFYrQ5A==;5:GELpu1/eOjjmyoLuKSMRDLxfq2TsgXciTQ2d5v310Y1PNch2kRjmakgtALzWHfUHIXB3WmA6VjlInNkuOiuLz+xSh6v5SHSBmTmijs0cnwGbWbwD+6zyWuIxt+EvKjIE3H7iHOX79MsMCgg17w3Fh7cLyWrJcYx2uMrHPS+jJhk=;24:qyXUYwrzmt00JPEBEa5YnPvOPxb2rgwkMpStTEinW60m62M9uSFhqHCp++9ZSjphHJzWTK4yWXIxpBHbR1p53/lWZGyUU8Twy0+vvb2FGfM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:G3cv1FBRMb3YT5XZduZrM8R+zU7cvsPZrLau/zBdv0/+VhK53QP6U3F06Ct7tjD5qiYpZWgquzuuDJG3EwixGqcdVKc0ehstOH1Df7uRzhIfuXB1LwV6oAwnhVQt3uixorHvn+hVSGlMvapnR6idgZ11ARRbkUpXBKm4S2oE/aYYxdcmvJETf2XfYUuJRh6s0hWADs2Bv7+NjL6VnM1vwOEp7x2QP810y8vxscOkfbbnQY8B/1xE92He1wt0kuJu
X-MS-Office365-Filtering-Correlation-Id: 565eb2da-1625-4a5a-87d3-08d5b1c65c1d
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:04.3307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 565eb2da-1625-4a5a-87d3-08d5b1c65c1d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gets rid of an #ifdef and the .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/panel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 6d99d4a3beb3..f43d77b5ed20 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -169,10 +169,8 @@ struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
 	panel_bridge->connector_type = connector_type;
 	panel_bridge->panel = panel;
 
+	panel_bridge->bridge.odev = panel->dev;
 	panel_bridge->bridge.funcs = &panel_bridge_bridge_funcs;
-#ifdef CONFIG_OF
-	panel_bridge->bridge.of_node = panel->dev->of_node;
-#endif
 
 	drm_bridge_add(&panel_bridge->bridge);
 
-- 
2.11.0

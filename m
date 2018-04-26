Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757238AbeDZWdM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:33:12 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756585AbeDZWdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:33:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 20/24] drm/rcar-du: lvds: provide an .owner device for the bridge
Date: Fri, 27 Apr 2018 00:31:35 +0200
Message-Id: <20180426223139.16740-21-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:rb6JXMyxgh5nHSiN70mRvvM+9rV6O6hPOSiRcOmDDAHguZtYj52w8WN82j0mO7UHYMGYgYetTqrot1KzihdkWuSJolPMVBlQOc7t2PL/7jQwsedTcbxtqXH9ELU1scPlAcaYsdyu4ep81CQoJtHdc+WpEN49AVo/CNUw0D1Jzxz8n2JWtkgzhsHdF1Ah41ljzuhmANaGyX72w5GSYupyUlt7jSqrpYZKxZhoQOYfaa4PuRH/nrX55g3IUuMlbDAw;25:B2JhRzPcwdGje+xNg0C7cfZsi3J1eRdolOdzonvSid6ZgqXCxhfHohc+ZcrwDUudFip8ferxl12GSmqDEOsFZYDfhPsbp2MdyWcRMYU4v/U9FGoXUyO9mmGeegFIQEtkwOZMiMfYcdjBLHm9PG0meAzC5lz7R/6KFtcW2qOlPQcIC7Y7d4SAUCNLp7+bWyy+OtfuS9X3R0ps1Om3/8z8egpivf0r0p5aUqNmyZMO1c7xLziOv9brAW96zjRhmeokdvH5YB56IvBgSzm9EoSOa9/leoUjcmjinwy5jTOKhXet5/sTsLIouClefkDbOiNfQpqH48XjmGMFInzB+Qki9g==;31:hpS8yfNYnVV00mep88bonbBNAVg5BVAdBCE9Qog+9fhumwOOmNra3u231m9mVUTt1OgWmB0w+Rr4KYu1MwbAbBfBqQPvkR/qnauugauQR25gEJdpltAcCmb7J85WMQYmGJcIQLhneMZMioAztipraS/MoLDyzG4P5EBgiCOVsAxxAFbJ2jC8vFyY29VCZnMUq1TBLCUQB7msuth96nGGITo/kmX46CybGKOpuawUPv8=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27823326E52D01B79698AC3CBC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:dKez7Oc4q94d0+JKzw8qyFrzg0YCHUPfl6kMVdOcqz6gefDWekyehA5rAj4dHKF4qMbYQt0rMnQKK0y7/IEo231IunMD3rU2Yi2dfQeW9JP/VmShVXMqirkmFa1y59qRYTKLuJMfzxsTUfiwQrGr+vfuXC0KE4TZNw/qIvC3887e+OVZgOadZqf7EjBvYJeWkqMMwUxKz37ixARvD8p9cR61EbKrbgkRjOuDk1h2yzQf0PqyKge0d8Peeb39l+ck47cv+NQGIRLCL074UgZ6lQ==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(2361001)(66066001)(16586007)(6666003)(105586002)(3846002)(7736002)(6916009)(6116002)(36756003)(74482002)(6486002)(48376002)(2351001)(25786009)(8936002)(50226002)(47776003)(81156014)(2906002)(16526019)(1076002)(81166006)(53936002)(11346002)(51416003)(54906003)(68736007)(97736004)(478600001)(446003)(186003)(50466002)(4326008)(476003)(59450400001)(2616005)(86362001)(956004)(8676002)(76176011)(26005)(6512007)(486006)(6506007)(52116002)(386003)(305945005)(5660300001)(316002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:KWGxcSCWxbcxOy4gXY+YaM091kSvpj5CjQsdFdW?=
 =?us-ascii?Q?zGXRIq2xE4szmMxmQbpXbVULOCbVrG6afoGkrzMLxuMkDym8tWlP8FrrAPHl?=
 =?us-ascii?Q?hrCdDuFViA1NaODT0zVplCxXtn3xQ43USk5/E7WgNYiUzrzeCA71uNfm793O?=
 =?us-ascii?Q?ffDZ4vWYAP3/z65PVe3/NqpBNzFV6qUbmpQzKwEAoseZA+SXXdBU+l/POLVQ?=
 =?us-ascii?Q?eRqKmTJp3tdvDq8pPUcVXyngMsWhFkVasfBL30HiBrwuEXrwZsEckAXBe68A?=
 =?us-ascii?Q?tSsdps9SODspM74nRda2y3eNN3A3r2C8OLCgv9mzAXku6oC6MLWwO6QetQAN?=
 =?us-ascii?Q?mUIzKsPT1XGNauOKV2QgwM0Lc/dNEQjpOzG/dnCTMSqZIc+o61UVOX3S/Z81?=
 =?us-ascii?Q?BKzjD96lX6xMVAh2w0uAKuF3qY4NZv0rPX4sSXVbWrg/eCYqBz9ls989dA3n?=
 =?us-ascii?Q?cZWCMyOLeqLjOdt46I3K1w+Sqq5sXqFW/ebx+taBTcW/bHSUSHwkbu3Sc/ma?=
 =?us-ascii?Q?8/PJZ+xsYTY0mo1eX2E+ImDbF/CMvgWyThtw3uTiwxUpslMaLctuGAnU5i8g?=
 =?us-ascii?Q?ARTTrLktkwom/GQzqC2ASQhgsIbgLSJrPz10Wh269G5KE+GgCAGIOdr5GQTS?=
 =?us-ascii?Q?iy/OJLfFkj1u3AfoSu3TzS/PBFVXEgfskSnQi+Sj9irWatNQL6WxDqeTWl06?=
 =?us-ascii?Q?7fcxQV9QhVltblR6ZOB/AygRtYnOpkgyUsgUmaLWEm1TcvcUDL5eeE7C/2e2?=
 =?us-ascii?Q?1DeKOJrQ2aJwyDhckgTcZQD7/+rKTI6FJikUfDMnZ8SsOrZ7cCefXmQ/YjGe?=
 =?us-ascii?Q?kKcwXxbwMAUQ2dyuqlMFDbuSNHXTHe4xTcqCXw4a3nh8KFrGRVVpN/Br4oWP?=
 =?us-ascii?Q?3H3hoh5VX4h8tOY78Oy2fbokuKZESCWtPwxi0sk/0hw/LsSWlC9kAvnr6sR/?=
 =?us-ascii?Q?kM1IXBK7sGpioDcHDwaTEBfUCXrJWxxrE/Ao2J1lycTP93MOUFFXYjd/6X3g?=
 =?us-ascii?Q?9StcyOPW9f0GjGub0yvA+EyKD2kFVcvfAHRTtZJKwMsB7E7+bwP5+S04pzJC?=
 =?us-ascii?Q?9j84CxJj1cnLzwmrreaYMCMAuP2xteblUSlDcBmxceuZncqAN9FuM54o+wj8?=
 =?us-ascii?Q?njH4eIA3qgWI+nqexTqZbnDpsza/dGPxZz95SeH4jd28QwlKrzSRr7s7y8OT?=
 =?us-ascii?Q?IFrU6tpNcEyW7hjexzoD8+qUwgUMq9IxG+471w6qbIRwYmeuWD/df04VnyK/?=
 =?us-ascii?Q?wS8NwfXHYt1qvgdgaH3gVq+L/SBW+f2jjzdmpRXV0TlVFO9JJIcBtNw93YxZ?=
 =?us-ascii?Q?x2t5DoEqc/GnQ7J5k0+F7kN4JoVT1He/Hkh3LzquIjSLld9kQE4NKq5ho39b?=
 =?us-ascii?Q?es7O0Gw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Yw5KMzKOs9F4eB5xvF/EwPdP3oe2S0w+6bsxuzIO6TOlJ2ivY4qlZdXCJ0rHg3b05EBqrdKucrO++rtElg3DhLyrsTCrnM5cXOhtfnZKJNPCH8Cj8nd8oYH/s0qoysI3kXjVQFp24swP8gaKycSefLMHZ//+urfFuY8ESSxE8dU06IYO4IQd+h2SgbMZBK0+
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:QvghNn2Ob4hot2Pn9FCW7iAxxcIW+aDFOf9aHUmcZYq82fj3I5UFAiZ/U74d9ZwbPswJQyYB8ZVNx5f7EyuqXw/thyyF0NASvlFXeBwCxNVjwLGzuC4QyG87Qafs//CaXLUWB7utlQxkPLNM6tUzxxgdGxHxQPoBKjnvWtbnu8zhNTZsKyRWW2aFLrjHU4KO0KoTPIqhiNGpqtUVYvQ8THLCKjwEZQxznNNWG6Hwtzf96wtpq53FdrB/Ktd55eXZVKclQ7D0XTOxX3yHiSIxGCQdKSYrTy73oaTBhsiw/6mICheWKdLu8apFcpTpPWVm8RVwMObf/xl7IeuTtDho3bT5B0eRyNJ4yQQWkY14i9qmFya2OgpR/Na8vJ5AVi2j3GWIxDfe/pLaIg6jPzEnn+wXwc59h2iNv9I36nC/q/xPus4bX8Zsa7/GnUQBgcLPxxM+qgph36GvN5NW54dUSg==;5:rbp+4sAzUhNEdOEQJM/+TgXrCBKKvij2n85HOpLMevDneIqI6JXwD1Yk8oGFf0nCaYis82uL3ViQX1dhFPsc8VUZ7QF2LkDYD1JjjQcHTW3G8OLXTmMO76WdyUQQimRtbV4SV2KSB8IZS/3z1FFL3G7Cz8pxDhmIBymaJj6p3Sg=;24:FUZO0LhAM0k+UoWYvSWNOPzVyUiAR9ML7R120RsZRT1v9ltg6oOhS89Ggd7lsc+RscZORglafDKsEwSEHc3Oh4tpb2vIZu2HWN6qKk5zTPY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:Jc0yNs8Sm7BNa/DEQBoyVQAY4mN9sk+dw9ntv0LWyB1mEdNkhpaHiJzWzzxJu5rapJDKS0g3UaWkmd0nivgNuvMN1X78VOE7LWhhAsL13iYs0kynZU4AfQAfC0UlSRD0gWJf9/uB1z2O6KZCxS2QuwdS0ZMzi/LoFLox8XHqrFWk4Fg+z5zoSBiAH/qljd0sAqCUpU8SCvU3eCpK9UTC3MZdUy+JiWh7vjlzJNNyE7RDhRWBM07nEHUKClyUC0Ib
X-MS-Office365-Filtering-Correlation-Id: d5c9225d-4d5c-48b6-5257-08d5abc5a79b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:54.5424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c9225d-4d5c-48b6-5257-08d5abc5a79b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 3d2d3bbd1342..5984c70b5590 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -463,9 +463,9 @@ static int rcar_lvds_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	lvds->bridge.owner = &pdev->dev;
 	lvds->bridge.driver_private = lvds;
 	lvds->bridge.funcs = &rcar_lvds_bridge_ops;
-	lvds->bridge.of_node = pdev->dev.of_node;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	lvds->mmio = devm_ioremap_resource(&pdev->dev, mem);
-- 
2.11.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeEPKSn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:18:43 -0400
Received: from mail-he1eur01on0090.outbound.protection.outlook.com ([104.47.0.90]:36556
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753447AbeEPKQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 22/26] drm/rcar-du: lvds: provide an owner .odev device for the bridge
Date: Wed, 16 May 2018 12:15:06 +0200
Message-Id: <20180516101510.13215-23-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:tnEgF/CwBzAUDWpx6ZOLIc7BtI+W0S1Byl1S/LSJ3eyfJn+ztxwBl5tK7pApW2iC++StqJxfUGzCRqcdv9yz+9MKwDihGv1zMOrk1oah2+pdXr4w1iEO7q4/iH4PTA4+ZYkvv3bdvx5b4eFIe22OdY1dN55Rbbeuu6GcTwHoRs2/SLYBjOxCYFJCOdm+ocWjUtnNLfxtcO00n45kRaia1uhW6AA75WlWAM/W7ibzjQj75zWma4riXj4hFHpPWD5R;25:gtvYtv7lRj1Y4w8bo8uuulqf0IXHDbxvXTOhT4XtRv80mq5gT1KKNsuPS+XEwwQSzfoNRv7bNM5b2L/VFhaPPF3LV4M4dHBE9UQUJOI41wT0N+F3kQ0BMkLRzbXt8ZEFuQGF8dNgAflAXowCh0HvZxH9Sl58Wx76Uc1OHXb8l6mayomXnml2XgZMFgvf/G1vBdk4CzwUt9HX1YKkVOF6JA/fyqG3wrYQ8F8598lmM4g5rVtR4nPxqp35hssIYAMnh3FJsf/BLadzMMeTWrbWueBigFMM15iGbp8nmd1GRlQAxfqazxZq5uM9lvCLpIOaKad06GHZ924dLqje5iW9XA==;31:RMhJlpBewBZL0feHoBtg8P7RKuAhs6mNf26uJpsm8l53bK7QTnG6Wt0CGcbeHkrHGqHNkPqyw6LhlVHhw8ca7NvZtSq4xAGdw1v7cUD1PLHtb6ZDLgqCIbFiPKgfTk7eEhPR/AxAYIQ670aJIN1howHmZoIqlPtrXw97YlU+R2a94ng/pvJ+6DhLXAxFzEZS+JAGRQs4rLrVNiVw3oON1q2P+77NehiWmi6b+NWMjkU=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772FA7EA175BF7ADE8B7EABBC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:/XCTcaibkjA1oZsEGFxVITqEnMF93KtUbFIVopGPxKbyGvQyzlY+HEs48b4TBPdc6EPQ/eydRIncILdQY+0sByJe8NB4n5eDYRdaovzwGrjEp94Pmvcgr7w/dvunSq6ZXmm4NvKCTeTNypt5fex3tC0meDQ5dzBDPgUvMrdpJd1LF75PUR5wWrQe5LS0bqsrHqDj5vc8tKR35DcYFCqwIoxxMFLkSfBxhs91HCEl6DIPIyJJCEY+vneE5Lp/8xAwGdXlhRYLBC4IxQGmAlLMcw==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:FzNsBCI6NPKGGTNI+H2wsddGuUyTuTfYFVar02c?=
 =?us-ascii?Q?glHemhCstV5aIZT4P8AViASrVwXyAiI3YRW90seweYgDBGtdb6CpfisTevJM?=
 =?us-ascii?Q?uLXMLAwb0/YzOMNBp3r3nfhU18g/01kn09+2DDB2yNgzJgBqsXyBeiZTO0fy?=
 =?us-ascii?Q?t7+1kZCs8DFanU1Kx01IN788oo9HGB1GjI67Ie0uTSFnu9RWF3YGWoEDL6VG?=
 =?us-ascii?Q?TFjeOU9ZPIQbDgaTCVwGe0dIbODCWEqEDQaCqf546Y7BBVZB3ZqV6iaYb9x7?=
 =?us-ascii?Q?QYMhC5DTgGQhnnMfE5d1ROT8ym3g19zbx7JLP/FsavzEHzJZ7ly7mMB7J2bw?=
 =?us-ascii?Q?0NRhyPz2mM2WdwZyCPSToH20AoxCKH+nvJqveCPyO4maVk3y+PxaMc5U4hEm?=
 =?us-ascii?Q?QulbuNV+rdwpXZ3/i6VlN0luzGElxC4KSHCxIu9DmG1nT7PrCcuWFx1WH/oK?=
 =?us-ascii?Q?9ylp80AWqFpgs0AGSpFtdwIu2ViTOon2atyXTdiK3I4wyn7ag1Ld25OyQQDm?=
 =?us-ascii?Q?T0OgvVj82UhLOcaszixMA5P6LQ1Qipn0rOvqx+IFIG5dI1wl9SY937yAzmX/?=
 =?us-ascii?Q?p5pMSYEmG8IpKIg8tpNhpa0mCIf+d30joR5yEAtWQIfrjiZLmJpkT5vdedpk?=
 =?us-ascii?Q?BIkb5kLnTmAGiY9YPH5nRA781sP63sRY3rcLBgf/1YeFA9nnuvL0kD5fzra9?=
 =?us-ascii?Q?kQcOsz8kBj0FcX1AH7SjARvPWGTHQAUNLoZDnztWl4i1bhbbI+m0LU0xSPQ7?=
 =?us-ascii?Q?lusdEqi7SAToqkGPF1IEqBGrSVfVPAeUi12n/GWBOYL6YU2v4zP3b+b3lNd1?=
 =?us-ascii?Q?TqAIqfrSuMgnTgMcaCIsgH2A7tvtQM8gN5FgcmRoYB93OwtD+aP30GAMiAZB?=
 =?us-ascii?Q?uajWYY1JpVvVgUMhYff6Uk8eg5pOAM2lqVvwsnMW1q8rM9G6GUO3xhiS2KPu?=
 =?us-ascii?Q?Hr1TZWquKMPQo7JXZhviYsB6Ep9ILDyCSCKXqKES+WEc5lDlaEIp1ivWWHWp?=
 =?us-ascii?Q?n4OXRMzuRpJBtS/xGjaE6gv/ljWIlpFR4K+7Ws8F2X72TtWWj09NAWjlcAHZ?=
 =?us-ascii?Q?lpOytNEC2h026r0gzNTlrrdAxnQyudEdKX+pXgM9i7+cRvxAQajruDiNiIyi?=
 =?us-ascii?Q?rgzT1AqaBNiTnzmAr6nNCI7JLpGhPcbXoszgP8NyraU9VsidoJOcE2V/iHIH?=
 =?us-ascii?Q?J1TThT6SvXS47gRReGY/z2R5gvRbwulsb+y+9UHXk2hPtMJQhhkzKPOyqdwe?=
 =?us-ascii?Q?dOwQoq/vqXZ1H2qe9+SgUDFyKKcqIHBzUBkCGbF/kNL4fazpTJXJ6yavtl/P?=
 =?us-ascii?Q?bnaRnlfZKnH9eJ2uiMxnLyqy/z3lhnzBPzEiNGSpaY7hG0Xo/sORmbP3gPXu?=
 =?us-ascii?Q?mbycQFA=3D=3D?=
X-Microsoft-Antispam-Message-Info: PoiOTunGHVJiRruRgwNvicKogJ8Djk4fmMZkn1nTr20/sI7Xgo/GgF+2xZbF+4y7G+a6SqLFTMj/Qk9kwPdJqK29nm71NWU42PihcKJiGWssxydZC1TRr22zZx5/ZWf884vNrda1GI8z/SIggXQP4BAvBBZwWErVPlRoMOJbjIgt4vFdZejnc61QZP1s49bX
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:diYJSBztWF7EieYf8GNeRgmpxJBzjCb3etfifFQ28AB8Bx8Tg9tTmDTUIQHqgCgRrflokfkk0I75Uq21H5ixqg4JFuclHQkutuI7cYhIzquoIcpstNDtGIKYu0nw7d1kXj0sDLcx7Yc3J3wNDiMBP6tGp62juFCi1uACB7Y95o2YZjk3WddYHlL1YHMranqHtBmsot0BW9L8SF5LfkDIOEdcFLzPgzRWa23JiosjdQz91KWrW5uAmlP+on52LneIPJ/t/NfY5+C7o2z/xtQ1ira6A35TOicpsfZE0xxueZdmcKkQkjFgApk49xjuMLPvlw5DVzRTNDVflU0jvwR2exNelIEVCCJHaXzu8kdz1GQ1lUay7DhKqUZmUabtERKP0FbYR6NEfRbyG8K//rMNY/g37dD4TY4//oMUKXoV+peJSs+2ehB0iMRpd1VNShdxW7MxlniUtZFPvN5EEAMrbg==;5:W35nApOwS6VvDVcVKclljZd5NXwz6xCpXDJW15oUQZv7gNS/aBX9+0qEeG3LB22dtM+KQwI0UEPJkYh6g4cSXyk4TFevrKuAWDJ6dGLm9nPuXrt+V2hHCgZg3dqRWzImILw5WYrzHrKLaDDe3L9OLdBehE8Gb+6TkdmCwRtEKBA=;24:KlIPqmTmovk3+VufdeIp9yRySd937qiZk1wMg8rz7jTWybW2lA13nE/6iz0aF6ge0kkLtolhc9vlqtBjR6gO3WEMjywfofMgq0N6SKaF1sg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:ShiLgW+zsqW86RNaUfH6JGkndtgi8XQxGC6jjdpVNn/NCfgLtpaHUx/qimgkcZBlA1dq/UXHSIfZ//rA8nUzDXZAqhRz7m2SvxGfgS9qMmewqNWFuf9nZ152CPpu9SSZF6nT/NQkFVTa8iQUACsTBFm7B6NLemt3i+l6zU4ZwbUo+yLH3b+rHdVeYDGjErd/3xua2u9BhYamNCaUF8MN+6THoxYE9UesZKBIb4N8Kl9sVEZ7hcIlJZvj/86DrNmZ
X-MS-Office365-Filtering-Correlation-Id: 0678ad37-c43a-408e-743e-08d5bb161beb
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:36.9288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0678ad37-c43a-408e-743e-08d5bb161beb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 3d2d3bbd1342..efda02f55c95 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -463,9 +463,9 @@ static int rcar_lvds_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	lvds->bridge.odev = &pdev->dev;
 	lvds->bridge.driver_private = lvds;
 	lvds->bridge.funcs = &rcar_lvds_bridge_ops;
-	lvds->bridge.of_node = pdev->dev.of_node;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	lvds->mmio = devm_ioremap_resource(&pdev->dev, mem);
-- 
2.11.0

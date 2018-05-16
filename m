Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeEPKV1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:21:27 -0400
Received: from mail-he1eur01on0107.outbound.protection.outlook.com ([104.47.0.107]:22847
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752641AbeEPKPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 06/26] drm/bridge: vga-dac: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:50 +0200
Message-Id: <20180516101510.13215-7-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:kDoLyiohxGpa99aO9mfDWrUFYeBFQj7DKlFLnfSL68rLBnMN5LneoO4m0XQ/aqXHHAbJVnORSXKDx0HOIUXUMH9PDmwC/3JjVoE+QKnPd+Z5oHS2/JqpmhJToYrFCkIvN2vtA854pdzSwBJzg2t+bw70LN4VCnm3DS5AAImCpdNBOBcV1J4+2trjlEIZKzs2t8f05TDn9MBKOYKyl+ib9vsgwZQBOjWmUi9REV1vJdna0ISEXVll+GY2aANXyiB0;25:cJhQcSjSBW+10q3tankz6LLAoeHp9cqIsHI9BfOVbNxJ7qbraYnlW1sqvZxfgHkkW+/l4F9dZS/EcZ1uJ62jgFrHrCvFpE4Ln2EEt12pAxrAxbFgmOcFm9xSFl+QzlpUJ0CAyES/SQai1RFRy6ub5bsu+HY/PTStwshH9OJZmK4E4uBimBEjmPl5TS9IQfhnvA/WKe0KnTPlPiBipbR2vtKYrw9C51P76EQDnKu9BjJVtjL3+7aB/1ZJPo8z/uByYO5jbQJgS9Gmfdr2uqKcbWO3ENXFL6zrDbjYcaZRxgntQ7vzhLlPEMOOh7MaNknSLBXRQHNGS2e8WFx3CwDc7Q==;31:HWlQPjCsmAxoY4IqtUDPBAeq+T5wESJUQvRWA2PXfTV5l2CQvCeDXAoWMFFGNxSp8nQ5anJfc0EhWt8uUvfnThTodi0iXwBWowMCEAWxQ/DRIB1/G3dEIYhlJ3DfEli7Tr7quNacjve2EoMdxeNs8KOLmK8cMhC3ifnM5lGPPb0iAiYhYf0srScTi2SWF39cNj5r/B88/mx3+UGOvhosC6dLhBHMoLVwTM9i6eH2wrY=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27727192AE794C143DEC9769BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:ntubLWe5GODei7pMe5plBdGajwHxnKQVGN8ap3fo2FKf1NhHOttVKnOEruNkzWYUrCXuVjg21wKWn5cSDXRiHR2asFabgg2CIBqxOBC95KYQeylxbpCvTv0ELpClI7SnQKjpvoyhMrROm2K8scAwNdAxwLg+0IDKh2uPJJmuioRwbqJn1Po26nyBQv4YOrwrQRpEOfFaQL0mr4Uyn//31LMMHuFRsC6y6rvE1xbn/lpccR1QfnGnvg7vguUK6uhN/2rlqw29z04DPYut42LbkA==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:xB4YDeGBndutBebEUxYswii5/NH1cXBZiXqxN5M?=
 =?us-ascii?Q?sUJwyrYgc2VjEaZ6sW4sHA/Q1QDC9Fizipw8Yvf6NhEXvNtgJKJ9jtNZnhFK?=
 =?us-ascii?Q?pQX70GnNPuS3oRt5V3IfIgIicVzVrl+ZZKhWURrVbP1FfrPJ5D4RMZqrJnM4?=
 =?us-ascii?Q?z6U6Y21ikf++8FZWxQU5HaSnYh51zuzyb/3LTcWpUC1Zx1PIWSWuo4XYisgk?=
 =?us-ascii?Q?0Oji9pM+zWDtLaWAVsl6SpjSQYnrLRh9oi3B04OLQlQ/PeqIQ3h5mN6SxuuE?=
 =?us-ascii?Q?nPh87Kh1qGMTcc4/FYRJy3js+Qy6lHSEda2LVu1gqwt9iY8nq0ZRDVxUQVhh?=
 =?us-ascii?Q?BJN86R2DPlDGIPfvsnU5+PCvSReoquRcAp5ftaYiCyaXG/RfcxEY741zLtv3?=
 =?us-ascii?Q?pjhu+IVLwGTGFZ2IU6ClcOUTqlmeXNYOaJOEvfUnN4g7OkspBdo9KIVA2JrI?=
 =?us-ascii?Q?fXPwFKcdScOPSh63+FdEnmSP/RqgTvuU3nqMTVIgdxDUTCvF4RaV/29df2P+?=
 =?us-ascii?Q?EbbgEm+oync6+bDRPk9vWtIVcHIIZHDRd9HYVL8p+N7XEJnA2CJp9rCz0o8t?=
 =?us-ascii?Q?Whu9tJVJPMe+kTiwc9HnvbGDcSUgd6Zwtpp8vDC2y2qBYEQaKaA8gundOUJp?=
 =?us-ascii?Q?CuzCCz29Ff1Kx8C0P+nBDo15Kj3YHMWWucaejlx7PEwlft2UgvKzcWR5iq51?=
 =?us-ascii?Q?6zmHDHvVDRPzXn2lreaPAuU/r/GxXmyP6g57a6vg4U7Hi3Cb0FEZRWBEigc8?=
 =?us-ascii?Q?Wh2j1IrRJOjipuRcYzkSGyXhrlqv27V3VQHq9XBUUPSUtJkBqRXOQvz/Y9FP?=
 =?us-ascii?Q?UyXJZ15C4typlHxTY+NuNx4A3P1nnIaEHAYOhV8yXeNGZ+EYTPv/nJ7J6m/t?=
 =?us-ascii?Q?GLhDgYnUeXy/WU+xJOdOyiHr/Ikv95JUxVnLVq/0bKj0LKnHonns9IWMm8ZB?=
 =?us-ascii?Q?Xmq4pYCNwI7+5A3d2hRjeR2lL3pGB9OvE1ei/DQHuKKS63zJz+Xyj/0N/ooX?=
 =?us-ascii?Q?+A0BwL8lS/6A2O4q70rMx/1ZEFo0hRRDE+W8mHhK6GFCI3PUsP9Gwdlu8a73?=
 =?us-ascii?Q?hUtKzb9eY4Sko+FaEYTUvOSDPInsgAtuBzyp2WFMsoZSR1Q5QERGSx+pBb3s?=
 =?us-ascii?Q?ySc6hbxiK5mHSfNVSs93Zy05URJ05+hqstbpBMF+5JNlHhwzw1HWg/Is+HRf?=
 =?us-ascii?Q?JGB0x4K2aA/CCiunxpxA9M0TyoztlG+h7CsNAcbSd3XrZjS4cR0cynW3dtAB?=
 =?us-ascii?Q?XSYKrD7CPjm+Yh4sflryAIyZEYEJlbePG7LkcOM0ZnqJAMCmFzB2eAaRFO9W?=
 =?us-ascii?Q?yrXfBKsOA+Y9rU1lijAUUG0MJkzdqUniPX9i8lV1t75y1ZgmgLCTd2eUCb8L?=
 =?us-ascii?Q?HngQPTg=3D=3D?=
X-Microsoft-Antispam-Message-Info: fMZFlSMfb19xQCOvh3rmvD+EQ00t7vH21k/zc0YQZdoiQTFhhEZGvBnr6MmxRyuFKs0NAypbUXVINL/EuttJbN9OHlIRXtsVruYHTwptkIp9MEYlTwC/eZxbcs/Zj0hHaXKzAV85WuIRREQP+QREFp6LXU7kkCuOoTy/4bUALwiuCrWCw+ijJ4ax48ji6PT8
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:6YWAf8ff/1LDJ3Cbz4AqbqYD8s9RiJnpfYU+jC7ohkoQeI/uze+Q4Mg0nBxOmCIp7a6BXms0VZrOs0HyTOmWw/Hh0QhQDSBMWX6bqYmjAH6lrXS9p3vO/Q5EA16AZX2O6k9nLTWXFQtPqmcKccPmX0qSaPRj+xjRvcRAtUQugvwGs6ZDMwn2i33K5GsTJhdZvF0UEEgDD/E6h1ORnuVReNN9M9IanbqkU1xdXyj0qRdJciocw1rvBMKEbQDxoMxAEFaZgEazXG1ngc4znjffqT/FL6oYr272oGbHmNYH8rkHPzrXcREq/exYqj7ZRoxAD90SBvjliKrSDTON1oEIF1ZrNMhljj6m72PKc37sQ88Rmiwhjx6iiHgo1n2zQYNPeZHbnA0mTOqbgfQarXZQ2QTP7p0NZNTCkgIYtwl37i2QEyOLYE0oMUQLhU2Q6/SsdnOZiCZSdfIsgn9ORz/a6Q==;5:110UlAdqT3qK10tjf/IXEdVrlsREtjCybnIgQUFkSuoW8eXU+OvhadjNK6E1X/o/nFSmRRmmITFJuHE4QDw6jpdwZZJuuowPPDksooYowvkx9A3n65pI0/rr0XiJGYxJ0E68AUFEYb5wKKSU8yfaj5K/nsqnQci2L6Go+/lbgzU=;24:R5pCG24fB6Db6nWpmHS2yyA4l1qMG5c0YoOhnfWkqL0btEzFIGYiT/bxS8f+5EjoFjo76u2NzjmVLuJKuvNWIQEtcF7wo09y2VckRcI3MBQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:o73iYdhsqnnvg7fbXloXAk+hwwKNxs+CN2LJqMh5ACXej24vF0Jg21JKOXPh+hFXQcDRv05NSsrQkKR0d6RaIuEcNCSEuuOFKYDvjATAcY9RRnoYauf7b4Tl4G9DRvxMNTbVVS3HYJen3V21lbbZzOYMXrpNz0cEfpd3k3/zyPsPkPTVPeRY4XVJuRC6bNQ/z+R6pgh3EBFJPdsBQf4bqWveUQORcO49hhiczZBLFH4+62Io3IqozKCVldsvg786
X-MS-Office365-Filtering-Correlation-Id: 064441f9-314e-48ad-fbfa-08d5bb15fe53
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:47.2262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064441f9-314e-48ad-fbfa-08d5bb15fe53
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 9837c8d69e69..95cce18e8943 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -205,8 +205,8 @@ static int dumb_vga_probe(struct platform_device *pdev)
 		}
 	}
 
+	vga->bridge.odev = &pdev->dev;
 	vga->bridge.funcs = &dumb_vga_bridge_funcs;
-	vga->bridge.of_node = pdev->dev.of_node;
 	vga->bridge.timings = of_device_get_match_data(&pdev->dev);
 
 	drm_bridge_add(&vga->bridge);
-- 
2.11.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeEPKUO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:20:14 -0400
Received: from mail-he1eur01on0096.outbound.protection.outlook.com ([104.47.0.96]:23525
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752736AbeEPKQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 13/26] drm/bridge: sii9234: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:57 +0200
Message-Id: <20180516101510.13215-14-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:g9AXL0rNV37YfHRoC5yAmcmuWIiFuUAEVZP6n32HioIH3MZs7oYO11jCiKdqQ8kA7OhIvYelu0puvr3Wdf2hvkc20rbwkWQ6pTpDW3L084BbAKSRTiGaXthihz36fiRaP1f4YQ7E4tijVRfg2bg510RwRcgubzN3Rm6OGAbfLjKXopET28LN7ZKvdg5w1BIGmvRBM8xSyHIe6gtKpP3WQCaRCA7eC8mw030ySjG/l77fnthiktc2CcVMSpu3i1jn;25:Lh5oz3xKJFqxol+cPAfNEeqSaO7vdOFo5AHq5+0c1REGfm2IC8ckrEkPCuq/GV48lpGW709B2iIumc/yaB+M28jxAaIhT/ea7Sk3mCbPLQwqyCbN4w+4ElPklKECp+u1m9bsjtosCJIMMGXi9QY4MDBOi3pz5d2TglQSb5zPENQY2UDRO/+/ag341n65mmZC3l4Bn3khOA4fXtGPuzlU3sb9seqq9bkVXEXQU/d9HIZ1cugCE7pKG84F7pJnJbAt8CI+4kJfURsz/zWeOS6VSZ+F2GmuTeL2awlEKu+6F6tRSdnrdVGgQpq65Wn6D0Mf1ecbEhdxJVqb8hmcd4BBmA==;31:MduS0Vv4kzTcCgE7SBJ11jIKaG7O8IegSW/JupojDrYZ8oscgWZUS+t19eOpNACPB2qTpMGUMCLCVgq+QTAXATTLMsKHCQjNU8ctzVx4r78IhKE8crFVpdIzCxndSbvcD0AV0EDYR7XISB+gZSvUXgpXzp8hcHcyIqHQno0hra0WsURvcYfCZqH+FgSuBk0VhqhHwp3Lq4eLRjtrFUVfhIl74apvtxXS2ZNZnMhC1Nk=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772E44588D28C706558F728BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:PHHyTUixyyJJ5454yFxI7ad9iK4qbfjblDil1B9sugirE0Towu4I/pwiHgXP3k+6wWvoJYGb/VnHYmDHxhzPnAfTORjDH85Z4iPQxYbC6E7qgaalj0XLXRveOY4I73NWO49TYnRshoQH+JyUSd+Lba8AMv7Rybk2tCKiIxBz/NxjdqjT4/0ZxTvJh7U8ZG4jyxS0TA0LVmacC7rZJ4xULvXl02PnvyvB6s31uA4MZ2UTTeT8dZk6TK23RPQka23mOc9XbOXVe6rQ7d+aY6rX6A==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:y/dHSYlTHl+E+36DX7p2CdwhBKONLjATvWhx6cV?=
 =?us-ascii?Q?xsWvpn0bTFS1EPkuoW0k8cDV0ijIyU8dkJ+8CNHpUN+NeBoiY4o/tuCe4ATi?=
 =?us-ascii?Q?HwLMg/MlpqAWQox++gSgkdISd68qtiilzPi3n+kSNHKOKxEARJBMLpv2TRwf?=
 =?us-ascii?Q?heN6MmZ7FUVAlBrhYcY9yazRfm3Ytxrd3v3y32teFqjq9WDAVax1HPOi9tHi?=
 =?us-ascii?Q?QntpI8SupLkgIzAsIf2GHJKiEFS2JCpMI/Gq+iVoOELHy4wdX3J59yty4BG8?=
 =?us-ascii?Q?lnLGCwloqkbv6L/jrZJiURDihzhxZNzVFBEntPDxXlQBflR7kNK3Ppmp/dSK?=
 =?us-ascii?Q?eMDf9WbwCnkioLxVDimVEi8GmZ00nbUXYrRLDymVU8zdl9G0suT7gfoLzK/v?=
 =?us-ascii?Q?hiVPqHNXwhnNrld3i1fxD4vZ+8WIfM+3qbSFyehBQzH19kHXVhYisvBCWGp5?=
 =?us-ascii?Q?z5sQXzS6/+FG6ufFe3+Jp0DO/HVpCHRL9F+pjVxW1sJGQZS8K6K1E4ZS8Tds?=
 =?us-ascii?Q?3ync0hbNZed0clzxQYpAiQaHSW5o5xBX90D5YWBuJi67WhThCoWPkmVQ22G7?=
 =?us-ascii?Q?jQvqJPtx3w7+voIbn1/UVHUT5x6TW4xRAavDeX195SW12zH0+IgOJSIpigBz?=
 =?us-ascii?Q?4lCfYa7NRgSwz4Iw2DZKWPzqLEB6HVSZv0McJHBCqb+Ry06PEP7R+YMGHKa8?=
 =?us-ascii?Q?GtjvvNICLN23rWKJ3L162cmMj/ejU3qqXOq72quT1KkYoz5taVRBeUhC3MsV?=
 =?us-ascii?Q?PYXDgoyp1JIKpIGSVMiBCvDL6Gyc1oWJUDRWck/sDWtlvK9GlNIB6sH1VdYk?=
 =?us-ascii?Q?jgxik1OcgK5QZV06LNhR+7bKfLz53F9CQe5eO4L6D0pfELWiTQJsp6JetF83?=
 =?us-ascii?Q?dv62A2orIuSVO/D1k8TV8CQKxhZuH/WVq4E++XBz5Mo1BIn/dvQgCUn+TsKo?=
 =?us-ascii?Q?1AQMYbb59eMjbJq3hwBfHfUovzYft/QjTjwQ0zVAMIJQAblNYbLEZDfnIUtn?=
 =?us-ascii?Q?jNfuFOP9d3uyvBclqlVY3PVDYiTGMtHUul5LcZ4aVEbnC2D44xlbNPjRg2Lv?=
 =?us-ascii?Q?F9k8IzjYOwPQ4AK1+Irrb7+76rJ6IkWAbu2eAHaNcPWbBBm5QLq1mbSqQvdZ?=
 =?us-ascii?Q?NOr2ck0w+cLO5y4t8rje5mZzij3HBh1GQ11YQWypR7OfwLXqCUpsGhbbvaE5?=
 =?us-ascii?Q?2xhaiNOoWXylC3xd7puhS/rOP+zbVV3cgxxcHS0B50pUIxMa2sugDba1eyUU?=
 =?us-ascii?Q?t6NvhEEd2p7uwf2z2llCaZ4JvFOwV9zfx1bZCjKLV94zNFDedRKiEHQ0vaTX?=
 =?us-ascii?Q?9VlUHkjh4RLFjr/Lv1XE472/HbqU2Z12IFykbsIBjzADwLs1nUaH29RYqlH/?=
 =?us-ascii?Q?8/8H3oQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: S8Q38olVIiDVWe0w4KIR8biWP00nIpayBfrj+Ssi7jMfOK4e7Otir7EBZlvmyztWfm/B/91ltKUet5IMxosyoqhbYhD4YXjzgShjUXsF49jF7WqPqEmFffr53xTlbHFGJ2dj1RQVNYeOA072sXlM4mXHICNuog0hG2xx4xQ5D4S6ieYFuA9/zvin2Hs245k4
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:XvC8nPTfrwBq3CxHoKZBoWEd5CKoawEX/99lU4Tvbp59pMvlt8e1bSei5z6XBk5DTgwGg0+5ux4/ZRyhYTrIewKJpTYz3vlN83u7fMsNsJrHvtpK9TSxNOBEWlkRsZkgbXUO/JLOjle4uDSzF5bCvAGEWgzq8jKnYR02Goq0EjJ7WBsubC6ypeGUyBIeYO0iJKyo9DKQG5ag0uUKVWgl710JCdmXMdefVdhvi4xYYrf6OuqKFUh4W9wRM+NFuLS3WQpwxzsxSK0bssSJsqfr0uWx/9j3iBfmr8m34Qqz2z0IgtQSAu6FPigqLNeepIYICrQcPDgDGCGU6LZpN+OPL5wlfk0pNTMwRKrwHjWQbsCsRuXDyhj6c3uzXaG2ut0AwK52Tog1qrqayb34bBePaPrS9z89k3tclo/dEDvQ2gMZQHkW/HBSyRhnnbDrZ2kG7f6X5QZ5kfJyh4m/D/n9rQ==;5:ndgVjMF8YdNvonzX30dJXyzbyA7VB5gNW9Q+ohX0cbzfGW5Hp99afqkxCF8cQZFypOROuRjXhb8Uw+/QgQLznuRampnFTnMw+NhOnes85jheN1Bj1R8FnuakhcGxLjGc3mI7V4ojyATRNzNlr9QSFJMnB/Isi0oW7ljbW0ZOEak=;24:k9GGKcpLcTsCV5t1QNnh2tubJ7cP4qZfHr/JoUDkMHeD0PGN4TfvOpHNgvKMXl7yDvhVjiw3IzIzs5n+jaQePD6bp1kbEPTMxnbGy/HTS5A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:QTADm0eZLdalSf3FkL8Qasm0Zutcfubv+b0vRtOViquxaztop+dq3ZHa056RddOaZiBA4Dd1saIMZ4lBP/yOXkyORrQURzklbQayjxmFOf1eJ4CsnYxOrbIi2KqVdyR4AcEh6/FfAS5crSQ3MWy4Jsf+5feWTtlP4yJAewxc0PXXS7jAWZE5ge/uYRKDA/DwCSzSzo1IMys28ORwtro8PkChF66g8JkCfd+mCnXuOuMlfdQWmmnY3DxtK2f1vypr
X-MS-Office365-Filtering-Correlation-Id: 3b8f3a85-7d19-4d17-4c53-08d5bb160aff
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:08.4816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8f3a85-7d19-4d17-4c53-08d5bb160aff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
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

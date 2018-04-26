Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbeDZWfz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:35:55 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757153AbeDZWco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/24] drm/bridge: sii9234: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:27 +0200
Message-Id: <20180426223139.16740-13-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:wxaNpXyRthjviDxpOASxt9N1ZKLw13OmWmO4/CCdlkwe4liT0i6aqdAULCZzBFIP9AlfVnW9BLznM1N55uHjBU1le8tqBB6Tm5hRaKTzNV/eAWRJfMELDyT/Kw1N84FOijYW8434xheAq0SxMNJRy/seYaUCV0d7wQw44HQKQxY1jO/BZlYkxyYVv5WyYwl3+ZJb7zXaN4qQy9768Wdy5s7an2Bgr/T2KK/l4jJ1mvtnC7s2IZQvD5q9chzeJuoo;25:HAjo/m+K82pm3XViOVTzzubhXgRQUIxhETtzRp3NWGOlCxgMlO/R6WW05QvIauXzmn94Orix2iuu19EgrveIkn/D0nzh+AfZav/YQmLuWzKWiyPAjtHy3exXPTgu6vNUTLtxsZ98aIqEMs3JN8UwTwcqxOfezxBJDUkQK42iGNkul6u2IBwovxpTll30KPYLx30qHPaPoFlHg26kqWEr804ZlCqJChbJXFQw4uDFY2B4zMp5Udjz18Bo8mMdpbq4+Fg0ldhSkal3LpHzqC/0Hnd8oONnv9QSE0rE2izdRKmGTxUVLOWIrbI/BFBAkvL84iXueaUVVmfV5Lbq9ib6ug==;31:+UOsSq5dWkx+soxjISh4ZD3vR+6YhnUCrkwvl3yLcIxBBkjVtWiAY46CULKoZ2astMpJ7t6LkpsPC1yh0iN/SHFT0cduQJHvMAoeaDl/U1A1u9b0wDZ/gA43RaplDy0AlTlz2gTjZS7QQU7cRaNgMqEo1yI72IRPQJ/z1ig/zA2G8EAQpvFwg2AGlGiOPhGIrEx9rxmYbBC/IqLVENOjZCxbjuL3gMMG0sg0TBCrUWs=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782D4E24C6DFA209AEF6552BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:/RKMt9+mua21mY412oAF01YYVzNjXRGCeqcn89pm1h++x5sXQHvhG5FDPJSxckvh2uzsy8vKAG99NB2094eEyblUSG1OUVXKCLZzMEFoObPHdFkNg1X4KwSXLB0L2hqM2ULYshgQyD7fOYL72OnKiCpZ/iuZPgbNRRApXqlzIOVhR1eKzFLjuk5TTbuSMn6tbrNa7lidZTPhzPopaXZWUuqc3rpf/9nHLo59EZdnqavH1ED3YO3fhzmTJzAWLkGRjVTX7ZijPO0zPLVR70NElA==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(6666003)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:ZnLe7DkK1TnzX/wB8Mc5a2gjmd9r2DRckkYeA4n?=
 =?us-ascii?Q?UREelHFzaUK48r+bEOJNpDn2dk6NSaL577HNb//8keNSgW84Itsy9RrpHHmM?=
 =?us-ascii?Q?gkul8cpELllZe+OdkdJZNH6MeJq5/s5x/N5l3cUVH9OjNyzPyDhS7nBebiqA?=
 =?us-ascii?Q?1JJHbMKth7kSfCl5/0FLnpiDO/sBeGHM139B+OlmLGuR79ztRQTtyH2Mwiri?=
 =?us-ascii?Q?oCsaBua26siz36WYwfBy8hVApBPOz+TOvntOI6wZQa8WFoVIH6ZCqKq1nHyH?=
 =?us-ascii?Q?XCejG46d/rk7qQqXtbP7z9bi/j6Bl3BtkuAPmwq82rj2HbwfjFAHQTUhbE8s?=
 =?us-ascii?Q?33zHTgLqe3+o2eFPffgQ3ICGrofZM8ScILg6p3HcLKUUy3Qwqd+e72xhZ4S2?=
 =?us-ascii?Q?sosb5c2CjqfmFUUJfBqvURUJeNKcMhGpMuZZfRr+F0N6Aj+0S7A/mNK8hEmE?=
 =?us-ascii?Q?vFDCWTFJ1EfcIDanqoRZGJR0WE1Maeog+3hVlwcHAIgV1rbOGke9j5lOQXB7?=
 =?us-ascii?Q?rCivSRq7U04KyvNW2zq88tqslVjYSA1lWXnWwuqEOSQaJU7iSdZ4czpZ9QYw?=
 =?us-ascii?Q?TOxQQs1BKYAj49Mtbiw7RxXA2dIXEWYt9UZEJXs7sKWG8/tmdD1c+ckH7sKh?=
 =?us-ascii?Q?kDpkdLVAT1hf9qYcX4F9HuwSA5cOR1nkwtJ8SEhGIx6Q1DJXyTaYtgLuNd6/?=
 =?us-ascii?Q?Sb1n5pl8fl85kLYXUrXjDi45iP67LUTYEoKtzvY1P+XTEwJsJ21G32Poef0J?=
 =?us-ascii?Q?b4IPvvIXrmHI3EqrGC5meb3yuETUpcdgflOJ5eqbXZ11pM0Y6daUG5kU7eO1?=
 =?us-ascii?Q?ptoSXAjZw99aw5MmE5Wd769YHOlQyCPD5YicgPpmOLorWpbuFEtuaywoam+D?=
 =?us-ascii?Q?RQpANfwdmNfZBSsXzuAHw705MSwWhfaCyztSaFz7o+UwSaFfwXpSNU22PGDy?=
 =?us-ascii?Q?K+x5VGRxZJlbM9JCsgqrkDLQee4D9mA+AHkwGawWrpv3l+hQ1HOOw7RPfBFm?=
 =?us-ascii?Q?Zk1WzJuSQKnh394EN36D8ShH4UGwVb+ZzfRNaSdAhlhx/WJmqQ3jD3BcaGs7?=
 =?us-ascii?Q?efXF69DPBS4doopiXAdLPlX84iK9dGGySSKL08yFaoBOikNsVHPlHxHIFSGd?=
 =?us-ascii?Q?gtz5chej0iEgvrcxCOK1TJinXcxgC1He0XSbROej4UJwRKpAdxZ5lhKRi2kn?=
 =?us-ascii?Q?8MEudE/eOrrxyYc+IXRcMIDUpwpKuX8PgH9no1tPKb4cH8QaecYEJH9JuHUH?=
 =?us-ascii?Q?TvQ7xtO11i9Plrs/6/DScmhCnWy/8mcOrc1WET+VkIBjja9TC927rgOmCJsY?=
 =?us-ascii?Q?kRCehJNVQYAB1wvXqhuT2mtF0wLgLCxxScJ533Yz3nlcHc5DNpmfWKkYpCIW?=
 =?us-ascii?Q?yviDr8g=3D=3D?=
X-Microsoft-Antispam-Message-Info: YySVNWHTELS7YkfC7NYptcPnLhkCYAHwLxg/pSKlHXWOdSoVPtnTUnWpRzmjmEAmWkR6ATSW3Zd6gygRG0PDRim2PfMh+hSzPJwFgMR7ReypWxlmZWLzhwCeeEMmM1Q+BM2XphjTo980rShFlD+HLB0t+Fyjd3xGpG6iaUaYccUtkeN7bqxs1onBGzP3934m
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:EVer3LWzRP7lZHExMSwowaBEi9Wvd3tLNqGwdljtTucOosHkh4vZczLgxX56jb1wYo0CpT7YNiEHFyVdPIZN/+fhs1p6eDqKs2Qg1NCOCGJfHCi6Oxe052L2tWVR0Yf22oa/cDS1reZ07DXiUwNsbxnoA41KOTJ9MHCcCbABMg9tfzWnCSdxyhjW1wvJUQHkyfB/78CDBHktd4gsoOUSBEDnjQVJRwbCwQBTwBp9einWbIWMeQ2eROeloq/Nqs2SrYvQUN5UK4gNbyPa7j2YfOrE5Kr3K4nvVPsVjUTRe2AjVGUN/8TTAUNeq8dNLywIOOdVmTp5M9SEepBAdH01cZIIh17Xs3q2lLkMTEaUtMdbCf6NkhKG1t/03PCH/j4ECu38PgzVga6JFEnrHPWlip90dhR8edF/+VbZY0v05BC3+Gdq1lobm4gbrhblHu3KeLpPbuHDgbRDlfPhMrgtTA==;5:k91a9YKJSE1vYpY2N+yOjNwfJ2pIEsJgCBUUg4it50UEs8NApCbB/QLkzjqnh1adLO3zzsq911zyr8JvMcXS3H1EJtmC6rfIDO20Mz4jLq4pAjOTc3gIWhUqKnO/5hX+6lmO0xVJrQNAcrSEZX0sruikWMm0M5zAyRAdoX1di4c=;24:Sk0OTWF0T5dndDgvwWi1qy31vU4MJ3C9/7zd/DzHU5jroNH3FOb/DFcEmruOhA8zrYWXbEQBmKIlMGaBJoJcU7Iz+348DKRQAW+jhe09+Sg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:I28j9vs/CAjff/swltN3v1Y8zZY7hgfIJkbDVn5dSppvpVumFUILjT1ofllvaWqPnB3HcfHTJ+QuPG02upVSRSAYb7rxKT4Qukjq6cFGNnyQgHD5n2Dl4iaBOIYy4YrMLQ1QGHQIkNbdSkNQnKSrfRbKgxi9k4fGS7XtkyZbj7IpFtsZXquI/EoIaNI9OfremQsdr3FJgQAQkbW70FrrGLqAkGy1S0rm/cx/Pqkzqqi7xywsFUfQdH0R0D93jgMK
X-MS-Office365-Filtering-Correlation-Id: 6c4bdbe8-e12f-4766-9df0-08d5abc59cae
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:36.1514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4bdbe8-e12f-4766-9df0-08d5abc59cae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/sii9234.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index c77000626c22..879d9b5ef4cf 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -948,8 +948,8 @@ static int sii9234_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ctx);
 
+	ctx->bridge.owner = dev;
 	ctx->bridge.funcs = &sii9234_bridge_funcs;
-	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
 	sii9234_cable_in(ctx);
-- 
2.11.0

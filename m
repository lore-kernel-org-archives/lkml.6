Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeEPKQa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:16:30 -0400
Received: from mail-he1eur01on0099.outbound.protection.outlook.com ([104.47.0.99]:16256
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752820AbeEPKQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 18/26] drm/bridge: ti-tfp410: provide an owner .odev device
Date: Wed, 16 May 2018 12:15:02 +0200
Message-Id: <20180516101510.13215-19-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:8Q1RzfWwktRths8SQMn7rZzvxxKvXQ5iVEIg3U366q/lk+YkDTS69Mgm38p+U8ZqAG6MZDE7HCqLtnd0hJcQtTEI30zVWz0vjokd9Zl6Bm6OCKydDHxOhWRfIG6vl1nVdIdmSA2E8j731PtNCpGK0QVGR3RlBzq4I9nCCcq6VL6X26/B43JHP/+riXb0uvwkd2TOtnti9kQmBkGkWSDvt1P4ahf6jtLVQVxUEHVX+CndSoWspmveSzh09Hue0NEN;25:RVyerzuuG+svsaLMT0ChEVYXGgYdd0BWNWdRoi/43cA9ZDi+9EBY8u7bBee942fGc7DgWQ4NslSk8Ni7ymPngxMdLD75ICSBdzA35QDxHxLcbEWwIWkzJC3xHpS9FYChfT6rdqqCwOhAIaTb1ehM8bqZ5tpTjIsGXjMrpuXzgH7Oh5B3H4qLNUZ28SoHRcfYoZdT4peenpubYH6H4TcAR6DHkvNDz4Tc4C7IdJb2lCgaSZ+cK2kEkARgxvjYO8Zd+AZPu6ql+q7fJbJF2BNcGypbxgO++6EN1zzqoLBR0/1NXQUMw3CDIyiODw8Sn0ADfYmR9F6HrNMP9Os50brv3A==;31:gW42sTQLb6GzKkhGQQxx6XMiHQHVmJB7kMPKf6Is4z8C0wy0uoEFkMFdu4fLDTPboWFDXXm0AXISDE2s+x+K3SrB1WnXYzo5HzdiD0ryFORxtoZAYGTT8HZPy//B9rwbAql4EFCOvSuadpyG9At1KjhejZiZiV4vcI0kLof1g9erKrBBUDn0wh6tf7ui4hg+RzZCitNIOdSgdM4MUcXGCQemcFAkXD8wq2WNkVEaCII=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772F766FAB7AEE999D89C9EBC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:8S5hJcchdm+JWYbJQ0qJXm6nf+mIrypYr1DAgqQWKNmvoLRoKZ+zj3ksqzF6WFNZUt3HJd/ughmvas6ukvDfUJ0ebYIevjFRr4QEPFY4I3sgH0s9WnlOh4uIMqvvoLHzRtfXijyE2RCYO3tl2QaEKYaxKCcKA/aHBW9kVVkGcfeFDiMc2GVLtU3xTCTgSM+VRFJuTivbZwPnorRiidgN4R5UWAvqHYoqQ8mZVtyIDaS75niYkREFGWMwidMnV49gomepbwTawU4sYK3qK/H3qw==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(575784001)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:X/7uob/mO4PqhZHgh6JLcu12Tm08NxJ7JyA7HXp?=
 =?us-ascii?Q?HKIDu66t0eAgNq/ykLDjEcTFEUCozx+YnxRaW3jNiXV6/y57el2wNt1VLh6v?=
 =?us-ascii?Q?lLPpNLCK4EpGaNnQhr92NXPoDXoSPgfRI3wDxAhCZl1uTLF6mHtdtVKsWdiS?=
 =?us-ascii?Q?8ZOgUFE5NqeRRgeDzwYA/lc8gGR1ow9FSXDw3y7NK3hJLmeSMSWohAt3h7h2?=
 =?us-ascii?Q?a97Xs5PArRrT1o1lNShLwWHimv8VQ3qQUp91C0NF4H2bFsJc/QEt44094bdy?=
 =?us-ascii?Q?d4XucqRj1C2rBn9/ZueTdNcOQLd+3Vzq3DSmbCcSVcoM1bQINyHXBqfsXs2R?=
 =?us-ascii?Q?9FxlQ/12TE6GrYo0F0rbdmyI4z9l8St+CVaRqxHOIj4AYw8oI6gJH8gB31TV?=
 =?us-ascii?Q?lDmuaY21sF2n3JVGGNrV1TpuXDc6N+uszH3/GB6iJ7rZbkQYSlDLZvTxdAeY?=
 =?us-ascii?Q?D5E+JujwgDXib9zkQWhj7d1neFW8AIRh115bVcorhhZA5K2Xu+KWaoN/4Bfz?=
 =?us-ascii?Q?WMMr8DCqv12S9JRuErz8x5Qjy6ULULsA3yAeveoGOy4yFuOrYyM4TKMMnRq0?=
 =?us-ascii?Q?QfQfiW9/v1jvVbuxBpmY7gTF9n95EEntp+VDkXivrIFbyuT7d2ZLXetGAd2j?=
 =?us-ascii?Q?UsaFmXA83onRqCmm/lmXjGrfVXixaeVRk+XRIurLXFHrqk/uAUO05A8BbSrW?=
 =?us-ascii?Q?0lyqYfqqHAmDL2tE5i7jgTj3Mmlou6kHCyR9/38m0pB5qDT5o2rkbhZb8oQ5?=
 =?us-ascii?Q?WdGeU2Cvj/DW+2ifYXPmQnPohZwVCdpW97zcpvR1rvrPDIYZllQSgIMyUQiF?=
 =?us-ascii?Q?L1jwaejWDQ+eQIClGzWM2LukJxB7k2BCrg+YR4WSdwS4A1Uym47skcrkOB5H?=
 =?us-ascii?Q?W9ZuW5kCyAX/PaqKe9Ng6qX9kAt2/dkvwTzD/ZduQT+9KL/fgbjRvihXow+O?=
 =?us-ascii?Q?Q8DFNhLpLLsxuraumFWANm13muFG/pkognOs+UDV4kErgTDlk9CqOLO/XRFS?=
 =?us-ascii?Q?ruDnqh7dKVcndlBLs2oyUHFWzZo8jcq/BwaBHKg7nQZdd8w8+p4VmQok4eKJ?=
 =?us-ascii?Q?mAiSyKvQwnA4+PYoOMcWWypuJnGnqfOYv7xV4iWAiBqDlXxLvfIBYL32iKAm?=
 =?us-ascii?Q?jWxl61leKXw/0oGX5EyoQvhluSZIjDyxJ4Wvhk1sKjgIU9s+8I9ObqNGnzsh?=
 =?us-ascii?Q?tA0FESqKSohVceDN0IxgLODRvUcHuxU4jNH+h4YR8HKUFB3SOz2bRV64IUQF?=
 =?us-ascii?Q?w4QJgPfwqgyOXTxstxOTb/RCIq2e2uMmuLC7qwpb1ue5gDKMxm8IfmBfrqEU?=
 =?us-ascii?Q?GFJ0WA7yvpYWy8/TqeBgZGoyg2dGSDJ2DEESzHcGuUAdu/ebW6Y+2RhfbSPE?=
 =?us-ascii?Q?QT49f9dP4sE45ONX47a+aZSAl4Ng=3D?=
X-Microsoft-Antispam-Message-Info: rMpn1M0NvAhED3iDaDCULV3ue8MW2fxHTk9zuG32C2jW3BizaQVaE87Y1OL/E8BWX/Yy8rPgi/JFSZihNUEkNOVWkKtWWuz/7oS61Bh0tr+EP8K7OawhHuBqx+TdWr7xQdkFLmzPvcYU22NCVmvK5u5yvFGPM8E1LayYbQVVA2W/WbOoHpQ9bo+FCpiIOfMD
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:QS8fAWHp9pEY3lBuVZOa+rXTkvAkdFl1o2s37kJo/awScCVPPK7b9VfN/tAey0TZQE/Bir9RahL6HRzSJ4sQexJOLPhPzdzYR/fXp7YTR9kviXYgIdYmvdDc/9zbhc9L2TRy6DzfzGE52nfnBmaf7h70u92jnn7epyQbDEcS1DybZm4HnQh8DTZF6JsAtf1r8H+UPkrxqpMEq6pR3Gv8q8mYuD4oFrtdjgz86v4/HAHz0cHZz8JihbzeZkqZhXL6gk4J1hvTEKxjD982iLWZ9/fXDu8NEHBmeNkEUaxPaLeN/ZISbuZq1Ob2AsLyJetXn5cof0ORu0NbvptSr/9ZgwsX8Wb+9Brl9MyUj0U021wCDnJGqkDsGJpK0S2wvwlGSWV/D9pnzS38j4cOV+8wJtGZHgMQuux5dPYtKM2Yz20G4bO0Z2rQS7dJqL6X0ZB4okiE7KInRan7EhFNOYCUIQ==;5:dmHYgdAoWVgKNQmSQY3zHzsCa5bXly7Xz/R+AvViufJFoWg3C+bXuODgWL8FGlBXe0csIbIc5RKGg7jQrR4cnS02dwAdceI2JMp+voIWzlw63C/dLC85KcDMX7uCaet5WMQVsTqy3YF8zmU4vhGv0oxjT+ClYvRceYm//Hz4HcQ=;24:M2krwTkJwuJgNqBodsu3wi+EvUUl6oCwY+i8kZe4NpayiLbIEHxvZYPCGvZ8b0lCAGOs14RazJywo1ZZ09Ox48/vw+Qk5gBgZ64rnyNTQQs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:F2bcm6K8Tt87B760uZn+RfNhgcEN5PvB7rMinBMU02oW5stTzOodNF8EvWPctSdzbnNbtL1gvEntEdNlX9MbnOumzh2xRXg+DZbAY6rDMqtBFItUzckrNG5W7jEHl9LzzMWpzqBWX4ZzP5/K9XaXTpiBINQn+nJqskcoHWUFCxbVvR8wySshbFQRdVkJtcozVyliRwI/8Qw2ks/1QvYD/thO/fODlDzL63zN2TQ+HCHI4tqY7rDXTgWTJMfUpc1C
X-MS-Office365-Filtering-Correlation-Id: 4e98253d-b19d-4ffe-281a-08d5bb1614b5
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:24.7309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e98253d-b19d-4ffe-281a-08d5bb1614b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index acb857030951..4745838fdf0e 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -215,8 +215,8 @@ static int tfp410_init(struct device *dev)
 		return -ENOMEM;
 	dev_set_drvdata(dev, dvi);
 
+	dvi->bridge.odev = dev;
 	dvi->bridge.funcs = &tfp410_bridge_funcs;
-	dvi->bridge.of_node = dev->of_node;
 	dvi->dev = dev;
 
 	ret = tfp410_get_connector_properties(dvi);
-- 
2.11.0

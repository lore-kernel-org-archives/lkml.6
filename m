Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbeEPKQj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:16:39 -0400
Received: from mail-he1eur01on0106.outbound.protection.outlook.com ([104.47.0.106]:47520
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753409AbeEPKQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:31 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 19/26] drm/exynos: mic: provide an owner .odev device for the bridge
Date: Wed, 16 May 2018 12:15:03 +0200
Message-Id: <20180516101510.13215-20-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:X5rjymtNssOK3yDIesylX3OAcrMysVPIf0FjjTP3O0r5sN7NuH3hIHK4SaaqxgacjS9SgetL7xCqyniZEiEpDMd7Lx5Xc/MQ8qgFcDLsUrggUEEag+u5ATgAfijvjR1zeNdlN3oLZHxY4aRDn8TdEBqR9NIHi2UNvDwwEEhhch1OJ9NMrhaC1MGyEhzO/k/wja20f2EgkKmJAODUH2kCeKVUF7GdgK5mM3VicB/37ev7LAuEHXPRJf7ttH6FYZCi;25:Jy1TZqiS/9dEP+SiEfS+MZT7SCi5L3RnXx2iI6eXNhGHriAip3FLE2U2VHKlh3k8wg1h3LHf0jK3RKzms9mZKRBP7wcx3cEKpi99EzyZMlW+dX7i/GTFtziYAQWrO01cdzrgEPikT/3R0qe7c/aaFBytJ1aBlqLRibvQrznJjfRoq3GgvlM27MCfra+ieJ+BIIcyJvZ0M2O0rAsA37uer7TgRLytvy7jDCxKAZmWvllXZ3DzzlxRfBRhp/onbxrsAvAZawAX+yQbjOa3/H6HV0Owv7BC7yHIlg6SbFTsDLXZO/3Yb3xBQOVF0frlh50Si2uXA9BOkJM1zGf2Pbt5Yg==;31:TJpmirGIycmzI0BDP4HyUvFwZIhwgw0nLLCh/lkA/4jB8mctl7hhe/Ivf6DsFcq1P6aa12+ly4Dsf0pRAXapuuB2TZY2hX84CY0faJ427GKDEYuFupkZo1UndzRurlo6XFy8fpzr6lDKUxSZzp7CYsqe1L0TTolL4p3BT4z8M3a85oepDdsgnoSytcEMGcWul01PteO24UgcZkbV0Yt/zu+9GBAFQrkBUfs5ScTr+FM=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772343625944B3FDAED3E19BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:h6nWe9WAPwF8Cecrp/C42PQoP/hWKYMWX0rww6YWLWJRXZH1lAb5p5qP0DuHP/Dm/jcCvnYobiVqh2s+BgCfrHq2dM/pWrZ+N3Lo9IoSVOsjOnEc+cJsBLF0Lg19jtMaXmqqfFAfaJgMnHbGStVUz+jHTcyRTCPg0RZzm0xEE7WgcA3DwnRZX16KwIJKSyfancEoLS/xdjNTTwak5HSCJUBsaZqdR1sFRl8zv2PvlYllxpkNSxAOIsVOtujutzEMQsnW3KEzv9kgwymZhfOvhQ==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(7416002)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:AvbuIeQq7CPhzETqZIbkh6a75Zt2d/AyVAEvk6S?=
 =?us-ascii?Q?YUT3ZVhWo3Mi4MGcl6G78jH2E/fO96oOFgWvPyaAriRxbv1dBfpcHaw9nTOd?=
 =?us-ascii?Q?6UT0zpd+FMroGyMWbiW5EgWqDALAH4CevB5CJyBCeLBRbm/bl2/IWxpPacRx?=
 =?us-ascii?Q?VGuzKvl1Y8OZBRDm0ufxD3yecv7eqakBNbVTrSwhWL/0VrMwUdhWOizBIIDY?=
 =?us-ascii?Q?cM8seZDyKlIIwsgIsdVYmIyY3yJp34+fVeKpkw9YVek6jSuzYYa4ynkVibtU?=
 =?us-ascii?Q?HfG2U2asn/g3LHzNJNwC8eB9TABzUiS7LR6KQBVFu1s5ITEfzyZPpLbPCVyD?=
 =?us-ascii?Q?ZMB5J5eVJVGfoDnjtWqtnhg7wFbZn1fOyWp1kqzYdAxYpeZ6UYGqfkdR0ldq?=
 =?us-ascii?Q?oZ7ELeHYIfpV6hHl+K49Xb5LtUi8HuVTcqgdXP5o6vAjT3aBIEy/Kb0r3iR9?=
 =?us-ascii?Q?qbnWRlAfKZlaKlKJzyK208HegYgRmRQkM3hnlJl43b2721tZgTCGMx8uSAdo?=
 =?us-ascii?Q?ilT7JuyGzhcNDRxrxQC47F7xtEUEw+Osp0CnhUk0T2R9d4Zmz09VV/YMgXVO?=
 =?us-ascii?Q?svjjXqnmmUJmDnbZmV//6VzoCR9CLPrx2DanXlQOc2WsFVSMpKj/Okm9r0n9?=
 =?us-ascii?Q?35V3JRa4GsYbMEH4fXpHgwANMfaouFpchAnvOzOZQpAPmcIrjdBgUyRAW1TX?=
 =?us-ascii?Q?KQ/0ExiKzoWdxiSh2VmrCqYxUaHHpO5Z/wLllbxF9SPvVKbjDOxWSY5BQI68?=
 =?us-ascii?Q?RL/yROhzR/nBs/xGiuJ4DjJevRJeQugqZspc1vtHpLpA71ZDZsUKMAg0Dp/7?=
 =?us-ascii?Q?qlG1J2cbx8n++OkbideKqVxa1gjcZstVi0NDadno6DHT5exDgb7X2rVkkipV?=
 =?us-ascii?Q?b8XJ1S/v/kcY7du+92nmy2VI+uXmMPB8oJ0yntBZ5FIJIiJCeQzzWP+mlOfW?=
 =?us-ascii?Q?DLFWEAwdN32WWMS2SU7xRu8kVSfQPv7sjHYqu286Kc9t9fGt5pvTsXrz5wmZ?=
 =?us-ascii?Q?lu5mLPggJdwYVH5LNDgGN9RUaaGZDk56JRry3WyVxGy+U0bTX539jBpWHDnz?=
 =?us-ascii?Q?WO59lq9uhjnkjYKN1RO4R/rovfqPSzCLQkOecuWT77hBYPTJg6Bed46I1fd/?=
 =?us-ascii?Q?H6gtlWrG2Db9vMyW2PgvE541tNIgj33PfVAtzg0D4zaJcQ4flj/HZ3lvnQt4?=
 =?us-ascii?Q?73ILXouNGxThJdu1PQzsJ8pV8V8PnEXlEx49vBZ2jdQYXuH9eQe28Gwl5prP?=
 =?us-ascii?Q?Cly1iUhQFqRLxIbHIPYCjkWiv9hDoydlpdsvCKMY6pbNd/vgbNPRU+mqym8l?=
 =?us-ascii?Q?9BL8ozrz9rOy9dN18cenOG3kP2ZPXhoxrtbmFtkq/r4yHzeCcBs2GNbhLYOV?=
 =?us-ascii?Q?2tMeezw=3D=3D?=
X-Microsoft-Antispam-Message-Info: C2sAfPqyMv8Nj/WcDz9jIpOYnA0Gob207vfamgdFBaAgeE8hWoiv+zrnFUb2smt07hc8cvekkRByGi3F0NqrNzhVlycwUWAGgM+SA8dXmQXulkjzBkflGHMmYH9J08NdkBoeTWCTSk1bdHpbnVB9kwkF1JppBcasnGxMFs1yOuxGB0avOHuHyP9M1OR3drK8
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:UaozFeT1FTjG3QRqDDRnftjBzQ3BqgqpEgkBv/SpnRZHY8gPauC8wKurJfLPOPtW/vxdlCsj4ujudZarY26o6PbWGDJk2XQi/YQ1phhSSAaU+VHenIrfoGKWxK12wCHlq6b7PsJom4ObRUGK3lOIh6UhZqAglmqXdA4mK3g4YV9o+SNroY0bye9zCIMgdET7Mf/2Y3IHCFp7+5yGkAqe6skd2OYgRrrYue+Bt1wMVZn8S1kzFeVDeqxEL471wLWyJGcX9D1AtrcHppKgMTOUSLBj09G21Ru4Qwc3rC9eqjZJs8qNJgT50/Q/VgmgP9W6k29PqGQoJX9WecU7KG+BZz/cVVNysvkQNYrPcPsOPaDEgpyXbqUQRExyG7Dl5JKc+XgUop5xbmdoX6HoJCz2INylgHanN2ClXljpY3UK0Cj8X33puj9FEerEKWVk/iZVVRBdaq5P+wELxuqmW1Pz5A==;5:qN58CkhPcH6AgjPeNAog4hII8u3bnOvGgMqMzc/gIKmRDZpUK3yGFIba0dyzTL+2id62PoSo+gJNpZGgzcLhTQOQBhseYeOia1/JRH4ZtDMV7BFclmclocfkRnFNUrlGIJHBjCYqv95+KyjCrh1dLM1hktmyyam/Y4WBd8v3rmc=;24:fzL2J+6KBE6m90sm+yGBku50SaTXhiGVcka41EqWF2q9+nPzlPx93zWk/h7FdpYuQSQDWiEoYlQaxyTWmaIEG2PV9eu2xQojJbqYK0tN77Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:bLxoZDn6dKelsl31doncxuT/U5ZqNNU5cPLUZ+XMQCP8LTcTTgXU7PZRbvOsOKpYswl3MVkrz5cw3eBOSvM+9AzuM2N4qj7epQO/GvveBHtelGoNZBe/4B9pLK4UYP/82eKztQhxoxzmHaN9NWW56QsPpNaiQMNABHUHirprbDoQb16UNuU+O+knrZyv9TgBsdAraNSO6//1hfyEWbL5clPgBsyySNenGCAMynsPxIPRqXHBmjsNPMAsA5pjG6SW
X-MS-Office365-Filtering-Correlation-Id: 1eb864f7-f4ff-4400-7921-08d5bb1616a5
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:27.7453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb864f7-f4ff-4400-7921-08d5bb1616a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 2174814273e2..f9ff8d3ec937 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -417,8 +417,8 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mic);
 
+	mic->bridge.odev = dev;
 	mic->bridge.funcs = &mic_bridge_funcs;
-	mic->bridge.of_node = dev->of_node;
 
 	drm_bridge_add(&mic->bridge);
 
-- 
2.11.0

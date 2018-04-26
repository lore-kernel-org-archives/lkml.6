Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757312AbeDZWhl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:37:41 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755095AbeDZWcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Heiko Stuebner <heiko@sntech.de>,
        Thierry Escande <thierry.escande@collabora.com>,
        Sean Paul <seanpaul@chromium.org>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/24] drm/bridge/analogix: core: specify the .owner of the bridge
Date: Fri, 27 Apr 2018 00:31:18 +0200
Message-Id: <20180426223139.16740-4-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:bUxjjJj2+RBBJqUFrkJ+HCGjsRmQ3xOxRfOD5KXhCNObtdQzZ+kLo9Uc8chKu2ITeyN3kO0M7hRwT6rzHZ14qrxoMEvHjcKBq0LhE9pmXyiA5I043ZoJ5RY/2eH9oqLB6GatXGkNL+ffhmbsSBMUPyGaF9UEXL30IYngl6MPPXdfRj3obRK41c8ken4euQjB1EH1BARNouTp+xL/cCjBm7WqNpLzT2IqteXsekuLQbVc3GuJ4CJ0R60xzDUcnJCy;25:ZllVVEp1V4gmhH3jOJ0/hBpx33llQrsKqGH0hR9YKbXDfnbaQBOIHjF6bIX1vVAHvpMW+Y9Wybbpc6AWSrEWzSOeWGIs0mIAFxUjoSSWD9d0xoTSbcKbsnMWTWQuGm7G8ceTBE3SQmWAsc8OqF0kP/1gqssrqlHLuiuOBnsGPE3y4zRvrYa65mRt+uQPdlNUvlQw8V7LozdH+ir4JphMeO/GQ8vewbyQ5/xlUbFt8eFjo+fIxnIk8d66KOsqB9zrimR2KUlWY64l8tJZQMwQNnuDq5HkbOZVzThWxIrUpaOeVf0E7uhRXXcy3BYkWMYsvF7DhNwnJAaqlMQv2HWaXw==;31:H2LCU++9rkxFqwtqOhWOQxyljb3t6LTCiYUzZeoHlImWrGvpS8/mIGZ0RrHk592cK7MeMVh7ftvhi2jDg1TJn23LZUfm7EEEdtEQITj7PCFsbK+xzNK38KfXvEfXzoeBdgCBgVY4qHEU2epMxFK3b+7WeUgmKWLCTK8ITEA6Lo+wiQIrj7dlUqqKoJ+1ryDrhEAgKd7Bv+DC82KVM+Lsj7ye2dmt5EKqbqyPxF/IqHo=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782D407CCBB4683356B032EBC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:GSVsmXRCfLCWs7Hbm9ucJ1w7eEH8cbehQq5O0WVZjpdWbBKvmGVwWanNGK1rS47wAJwLNgGtTDaiKd86SdA0bW1I8v1H25X95K1965vOr8i36OizBuZ/dAX/8WUJkHyDaaqIligqEmbBjHRppqWZIv8pTH3WOyqDgisqr1eNHRg2AH041mNqwWMXohpapzlS95tN99zYz8BGUQZlF9Z4giK4U/4iJ/8Hb9vWsVV5N57IvKTaYmeJCeIku56W8HP6ofyIXvezWZ0HbIq2W76vsA==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(7416002)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:hdAUAaopcgRmdll6ViJMoXOnbVEw8QBFCDJQEOC?=
 =?us-ascii?Q?Q0LPdLqs7njsUXmoHI1oHdIAU9JiyBlE+FGwEBLAsjr5EZyTJ7usnVyWcEZG?=
 =?us-ascii?Q?cXncesd0dZ1giMQcYyFSD2edStCOolPQFo2CP+lgvu9utqXnL7dsyqnNuFmI?=
 =?us-ascii?Q?9duoxLHgN/lYMoqcfHXvY1+8QlAj8pcBGPv2XriCRg951XmmrBYz42AFPIn5?=
 =?us-ascii?Q?TkYg31vzsim/onTlnTSv49r2T9IUZBKW2wZoUkd/eoyqfrWpz8dR4dxOVKPJ?=
 =?us-ascii?Q?MJ4JLR7vmtpm0H14cRTX4WCbxTTFZaXmjUJfSG44Cg/q6RVU6atmC/Sqn382?=
 =?us-ascii?Q?OPyo5hTSNC1wGfSTKiv7sl8BspN1M1LdZ81mH5oGeMuLMuQInP4mID1S7MoF?=
 =?us-ascii?Q?fdS9RmGGVClyfXXLyk1mITDneGe7CW26yai/oXR5K432NJI5CQk9Wm7v4CgJ?=
 =?us-ascii?Q?ZSi+JRukmvXAv4Kb7Hl8mfb2jBz7j0zdA8rTrwBxRLTrDDCsm4p4M+A+z6Te?=
 =?us-ascii?Q?X9+agiPFDUgjOs5utMgaoEa5KKvEqyqbErzAEbXbhWiL1wejS6B/cJV/GDPF?=
 =?us-ascii?Q?rs5blt4Zl+HFnEhWFzeVDhiGj2UHSxXRH238dQphv2I7bk31muk1bNU3WoE5?=
 =?us-ascii?Q?HqXPr9igiNsMxAZQb89OnSISE3KmnUG2koj3zEJKaVfwgFwqzFqWDj9XZizY?=
 =?us-ascii?Q?0FT5q/sugMAawCLa6JcPqEG9q4dHgHM8W1nzj6ghWfpP7SSEzzgMG7xnn+5v?=
 =?us-ascii?Q?nEhcfaKt8zuPb5CQsqGmInZopXmsDFep8/Dgm59cEWdRZ3EvmThtOE5NNF7b?=
 =?us-ascii?Q?yMyYhV6tCPT/TN3wvq7uchLPyoNMzdKmLo5rzXvyG/zPXtbgEkxdgv2TvLHY?=
 =?us-ascii?Q?j68FW1QSommaM/61T+hBSTTyFXpuRyYpdFRBcAKmRjTQgofUa2vC3Oyj9cAG?=
 =?us-ascii?Q?1VAU19m8GnM0WK1yxykmJ8+zsVseOcqKoF1KGTNHDOognQJ0LJw7Xv3xwl8k?=
 =?us-ascii?Q?ESGh/WVxFkyfeSViCPEkgs9WvxiuqZ+vaGedowPe8iEbqqKER9k3Tc+c2Mko?=
 =?us-ascii?Q?/Jv8ilap3+eltNeC8BTuzpjGU5YBAsQO5CiBvTOdptG2vnybqHvo4jrL8+bR?=
 =?us-ascii?Q?20XeqJUywe6eIBbVxBMqRVJ7tBXdafTrqzLtWwxqcAj1GuEE7HL+H0jXugey?=
 =?us-ascii?Q?4APRFz47p2tGbD+DqXo6eY3oY+XDa7pOqok7zFkToh3zOMj8ah4SJ7M4MdIO?=
 =?us-ascii?Q?nFq6DkcTTU3UVcw9HswcnivjUDFGtNY7wXYVPnKE15iCJZ9zf3yBnsw19erC?=
 =?us-ascii?Q?VKKIoQX/3BXoyxtZi8zDxx/U=3D?=
X-Microsoft-Antispam-Message-Info: hpDo9ltG6MpNJEMEUpjxp0TRT/5WD0QoggbFPvgfdkZYTCKLqa+gS9HpwmL8IZOE0P3vsRjoDO+ehdmNd+fpWL7P8nSXK3Dh1b1Wducedh7fGfR1LD1JN6Foi8I1pfcTj2Bo9w4KlqRHMlzj44n/79YMHjPxCkOOjss7C+VdzRKV3hyPhjWztXhIZGNTjwdP
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:M4ibEoqPQdShuUrCjlmne1ea/xWC4npHPww7/hsWTeYcQwzVR0BIZNhKcZ3HDxqAVu93M/8Py5Hg/I5GOmQicsSTB24auLr38B3NZvSeRiPQ+cbFAuu1LKZDXei+5VGAhDf3gMBNFDvviDyKWygH51i5bBBizd7kF1TbeGfPmgQUTl1ZPjqQhVBJJ+Jddgcu0mK/4N9t2pHiSMqztCkKJjNQQVgmkJ/WFSAFN9mJgwirEEi7IkyMMKeOS7v7bmgUHikK4vEOr5M2qIuQR2sRtfZk9YIFRpvRGvXE/4NHc6JT5rvp7CIetm/IJ4kXfGqjjFrRnPgFjR61vghsAu022aXsWY6EAjq9865AaKlYu3H8GMvK331B/7YeOZnYKf5Q0Y7nOPmcTJAoX8G5QDrhSwOoCMB5OnuLA/vSEroHoAyYOhXffKUuvBCcAjdnssCkCKfihFBoE3bOAagr8pBfbw==;5:Nkf2hQHbfmWtJOgQseeDPWxb93OPE71cwM8FO8ztxyAKLxSk3Loz3UrvevypP6ae9iPYT8LuoRV8tfXxYNWKJCQUr410r1e3+SQk/TUh9gnxpr47KhiICFD2dT89RtT6qR8/fxqfoE78HixPcQSDrZa1TeztM8n9zV6Wqyeq9ZA=;24:yQaHUo4B1YIcB/SyWFx6RzNSTNqMU7FV1ewWlp7WcYNMA8WQVHorBrs7uIkFWC0R7v4/VX2bis/lM6eVjphZCseqJWKvF9tjgOKXsNpe9lI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:PkfsldeuPJmFHqN1TOO8VkpiPc2DjJJbLvwNVlw8AErQQ0fvZCOS38+x6TOnRScTeyGcsZmI6UP1vvbVgkgeLAA45hlWgaT67us8ODf9dRz0sHtY3dtoRosS5CFYsAyG8uzS5heZjWFtHg9EBuAdTEGO5UqHm8BvTrjgtybv+XEYxvCMxyzoVu44/toSefqm0sGFDMnD8YVGMRR32X8X2eK5z2aFCATeJBETdRIZQ8fDfD/ejMKXJq660IfaQZi5
X-MS-Office365-Filtering-Correlation-Id: c71818ef-3858-47fd-bc36-08d5abc59071
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:15.3697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71818ef-3858-47fd-bc36-08d5abc59071
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will become mandatory.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 5c52307146c7..5a9dbbd7897a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1308,6 +1308,7 @@ static int analogix_dp_create_bridge(struct drm_device *drm_dev,
 
 	dp->bridge = bridge;
 
+	bridge->owner = dp->dev;
 	bridge->driver_private = dp;
 	bridge->funcs = &analogix_dp_bridge_funcs;
 
-- 
2.11.0

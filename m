Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753506AbeEPKQt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:16:49 -0400
Received: from mail-he1eur01on0090.outbound.protection.outlook.com ([104.47.0.90]:36556
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752611AbeEPKQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 23/26] drm/sti: provide an owner .odev device for the bridges
Date: Wed, 16 May 2018 12:15:07 +0200
Message-Id: <20180516101510.13215-24-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:madneDj8taZzFdipW3CfDZlPJjDjqA+v/IBw21uVN2qCbqU23xmLW12EDvioWGV+EuGPW6J3S5YZBZeQd1QeoasqF2d6mhiEbJDVuWjBwZvfc3E6pd/Do78IfBvexs+OOR2Lv3swl7aBL8LHZgvNi6h0gBxcrCBn5tU0f4CaG46udfvumhswSszWuPyTHLBsYbShb7tI+BRGj/1qhjpYankVq5/E3xrDWsbcg5r23CKw7asvkOcaapbdBm4mW/L0;25:bolneofmhudGPbIVzJJkkObL4LS+uyMAfHtGX+UeI/eQnyHh4dIKZgOJb3XrHu3cTPVa3se1c+0nnQpFdvFDB80x22gI8avRdgOZ24zWlOimt17yg77v2qs5n5Plp93Ct6ZBkVlzw+v41atrrXFheYH1iqeY+Babyrrr5YM157B0mWf7aBj6TJy/fbRneooHwb/7I1eUhe2fOHO1xLdukGuaC1bnpWQfp1nNer6M1cJqLIkUM+3Vl6p7XbJP3siT6ZoopLoq1R1YCPFAxvf528SF5mElG0kL2NVLDVmFmvTa5/ezqFxClyq11v0wfin0Rwe4tvCbM/Tt6QCcQ0j2AA==;31:wtSCrArDU+CRA4xClA8TpjS2V0AMmwye1GBmUCbDvMo6yhCJG5rR7m0zOYgAumpxIGdfnB7gsuxox843dil4E02o46k8kmRj9qY0xeM5dftYt+jUaspxArrAl2Z0PWRF1jtsZJ5OOJuQEp+FFuvfk+LywGRxhwYMgGTuUSHgpNAb+se67HEbfZT/efjt8pCFE+kz1oV5WjaeuK6zlJ9SQ2ddHmaGYQhuJKCjFMZJylY=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772203D73108D3B2B8E8414BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:lcxn6N8T6c1Dv8XBo8LWCfV3cxcZYgOiBzyvNm7ndPrsXjCYzui+SWtA/wmUft1kXZedGvJFDiL3dJ9Jzx5pCl5KNQjowtWggy7h/vTjdGkkjT14POvLc4G+Q0pnSAqzWSQohFHdCNGAGLuKXLt8CMV1qs4YvZRTqvw2QK0PpX0IFcgKI6RFHDdTOo2gXzyxP/jhKyFanQaVmkZUcJU6RRm74qeP/WjZqTTebTM1YDEqu3w+NKIgr1qjuHlRBIVNtRV7iEb1tM928YYPEpx1ww==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(5890100001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:6QPIGEv+K0t41dHEHrHy4WigKotAFHDUZgsQs2n?=
 =?us-ascii?Q?pTGfrflofO2/fraseW/rW13HmiDZ9MyvaskEITrHMihFJoUA21pRwlWjUAkF?=
 =?us-ascii?Q?kXXAQrhDolE5UzwQWQI4Vmf60Tk/aIy+f4WKtcMeZ/hgBI850V5u9S9/Q0kl?=
 =?us-ascii?Q?dkGAcdEru80/rmH/uTSSwEmOqbjvsN8UlBlSGpGGQnGCQ5/FgLX7XW3txtF3?=
 =?us-ascii?Q?q7t9y32o1SW4qr3Hrn6pn9FS1oDGvlz+fTnP8N77QQB3zSQd2MErAesjchuR?=
 =?us-ascii?Q?Aa0C+9bHRLSO8dO+6vrRlfC8XTGC4XRsZt88cpwmSVtm0GqKYoGtJNlre3ke?=
 =?us-ascii?Q?lEjLoe6M/3z86+vCb3h9xOkreATxtBFz1XIAJJFMDNV+gxOgaPavmIraQmRy?=
 =?us-ascii?Q?DJev3UY4YkYurorlwHiNDH3FesQH9gDZj/PTwjHwTVPFLFN+IdDHUaiZA4N0?=
 =?us-ascii?Q?0phBpgPtRlC2Qm8rm2ZPEsdfDZ3cpVUcDB+7ondbGD+4GD2L7NYt1udk6p0x?=
 =?us-ascii?Q?IYEkTG7f5pa7XQZmvpquTZM7KElke7d8hAfQouZmd6HiPbYRIULcFWN/MDV7?=
 =?us-ascii?Q?5RJBys0pe30DffJkb2lHSYX2d7MsgJy1j8v2cjjupBRp/QUC2/e6Ohw64rWX?=
 =?us-ascii?Q?1bXekh//2sevvCtCixGtSBqGfxE+3QDBwrphiafnt5rpE0DGgVPYkutf6iqs?=
 =?us-ascii?Q?yOi+iaNTveGwjM3y69vbp3UL7nlmTQdCeAJ21t02IvVzibqZgnlS/LgFufLx?=
 =?us-ascii?Q?iWQ4FTrvlsNzwT9FJFj1LjDEVwstGFzhoTf4TazkHevCjVaDWbZgNzQ3xO+o?=
 =?us-ascii?Q?2seB5xIHkJYY85c+PqVnppFARpcOoHX+kgfBsR9DwEYGOTF1AZo5JM0LIFTg?=
 =?us-ascii?Q?dnytDtcYYr/c69R1DCrAvO2SmtA6DM+LQKihBJnL8RiFpfR14bHsE/NxXpkl?=
 =?us-ascii?Q?Y6HbOVp0dkhGj0Tq1/DeDziaOMzGgGGtRD/kVuqaueegIhAErEbMO7MsGx9I?=
 =?us-ascii?Q?igGNABJjwPHig2CwvwbfnFIbiSutcLUagkkP9yWha2RVmASltwGPQhqSVntB?=
 =?us-ascii?Q?OMXvH5Q+SNIRD5p/DwrUigWTHe9IIgxEu1pJ0d02Dx/6KNyloLC5Mr9oyTOU?=
 =?us-ascii?Q?t+NKHEoEY9n4QXwdj+uWH4jXSs1gX4qZbsP882tELiHO+s5bjQTVoxUqgW71?=
 =?us-ascii?Q?cNh/5fd78DHP+BRRNCCUFtaDlLWsuWMKwlTyFpvxzzo0yu43czMBdVaCEi10?=
 =?us-ascii?Q?WwxzsBBbTeFaT7E40cb20UabF885hsJ2H6MeaAks1AABs1GmSo/6LAgy7Fjk?=
 =?us-ascii?Q?YJAzIQnFT9ld8ldSxa/8Q2utDktF2VQOrOh6QBgvLKUTU8JXhkY99/o7UcKX?=
 =?us-ascii?Q?aHRSpY1Jq37GCaLuSfujfbQyW03M=3D?=
X-Microsoft-Antispam-Message-Info: YPF5Kv7yBjmnk7KcLln8t1sXFWpXjs2tssrXZ+4QSWxoz4t7SqbJS0hfuiGX16oLoJHh0A7//qY6elWjGrCeZGHohVCIGIWQUcXMNmVm+aP+qXIzWYFHW191kdqBc6aZMZ/OKAk2hf1lRZpsPELpd1phVxwwZZwwWaUCCiyXsIJfpINkEIj7lPGTqyJoCGRU
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:kdeDXrYYeCi9zUhurndOLsFy5g0ELrMB04cwn0JO1e1R8cVAJGMQhR+9826DNSht8mxnQ5tQqFXjTdeV2nMtoWIU/fnNP3zqklOF6e/SdCfqqzIp+i6U8ljXdZhtbzd9D198ZKfQCe3kTuzWbElnAxw8VAqrVuouEK5Sv3Xch8ngB3IujGaEpEuDLm34KxLXlkZdRr7+6BXWW1JdnUGKChuozl2PcC2Qix7zaa56YEvu2/Ugz4OciVU1l4LmAQFudPLmRrGs8IV/Oc+QnnkGD4fugm99jHZci5qAQSXu5QY6YEGdh9U8wX1kONz904noxXbVsKgXmNbAqhVBEjeghXc3aTRV0kfqx4S2TZ6F6eGNFZ7wDNB2aV8YgZ894owwdqoaG6KlE1qXhlEFtHJygVW+foqdeYlw2jFD4hB9KV4jLnIVrDQA85kFmfc477jtVukpwj/TOATEmCki9aUZqg==;5:fxsXklL106CaA5vWTuOAWf4LSojxp3Z0VslUwKSRMLAU1RO92FCB/bv+MEtQX/As6AeGYKcZB8nbBYK0+yqM6oZ0n3HzGGEW3LU2id27EKorEI3ZbMgRALgv+/aVNUQKC0gR0EfdkDOHXHrGPWzJZXjeLnt+2+mAI8uae5OtMU0=;24:9LxpnZZXOByslvpewLpQyTS9EUVaX49964yrGMKUSja6o93BXy41K5mFnFfApQ6gINFwb6XZn6aZE2iVbyVlCwmyeoJeAltHQuGTUPlBJ08=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:Jgkh44zmGfIskDkm2kLVIsKXwJzleECgoQEsXwRpdAD1fMBOyKLyT4QbBxivjxDTvh8+8VIrTuNo+4VT43nO7RGTxXCQz0hvLFr/gEIiBiKBss6oyQFH2/kl7fOHN7m861/EZLv4FjkAj2NqsCPwhpqoBBBXl3kRflHMdZlfoqPxIwD50TgtqlW+B5g7s6cHj0xUyyQ7DhScx2kPOf2wgpaE4FXkqHheqGBNRAzYJFLzZ0NjB+xFNudkXzxtzmx8
X-MS-Office365-Filtering-Correlation-Id: 01332fbc-3b5a-4a62-6e25-08d5bb161dcb
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:40.0744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01332fbc-3b5a-4a62-6e25-08d5bb161dcb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away and providing an .odev will become
mandatory.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/sti/sti_dvo.c  | 2 +-
 drivers/gpu/drm/sti/sti_hda.c  | 1 +
 drivers/gpu/drm/sti/sti_hdmi.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index a5979cd25cc7..f2609725f8f1 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -460,9 +460,9 @@ static int sti_dvo_bind(struct device *dev, struct device *master, void *data)
 	if (!bridge)
 		return -ENOMEM;
 
+	bridge->odev = &dvo->dev;
 	bridge->driver_private = dvo;
 	bridge->funcs = &sti_dvo_bridge_funcs;
-	bridge->of_node = dvo->dev.of_node;
 	drm_bridge_add(bridge);
 
 	err = drm_bridge_attach(encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 199db13f565c..7fcd24664cd0 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -694,6 +694,7 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
 	if (!bridge)
 		return -ENOMEM;
 
+	bridge->odev = dev;
 	bridge->driver_private = hda;
 	bridge->funcs = &sti_hda_bridge_funcs;
 	drm_bridge_attach(encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 932724784942..d1d2e1a1920c 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1270,6 +1270,7 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (!bridge)
 		return -EINVAL;
 
+	bridge->odev = dev;
 	bridge->driver_private = hdmi;
 	bridge->funcs = &sti_hdmi_bridge_funcs;
 	drm_bridge_attach(encoder, bridge, NULL);
-- 
2.11.0

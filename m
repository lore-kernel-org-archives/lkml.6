Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeEPKTD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:19:03 -0400
Received: from mail-he1eur01on0090.outbound.protection.outlook.com ([104.47.0.90]:36556
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752659AbeEPKQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 21/26] drm/msm: specify the owner .odev of the bridges
Date: Wed, 16 May 2018 12:15:05 +0200
Message-Id: <20180516101510.13215-22-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:+YZTV+PUxZIb6QzF+jA7OZA1blKO8PFPCE5m1Oex98sF81qCaPewXr3G0MfIz2o9rzhvE9PBL1kxT0n1PXlrQjoa8M/HUZVz2yA5dgw25eQsH6HBKaQeeB/X3qDLmKgYcgWCEQSfBHvVhW1USHrZe+x5QwG5T1ZyITOaMq1EC6WLgDYgDqGPVcM7zorxGDHQv4q7SpL9ly9CY77+TgeMR7aq1zvw+4Ujc02YWudlPzPV1OwlVCGNmJO5cuuqUOxg;25:rEr0f7RNpIBpoxkSPtlbF82nzDxPxkcpiB3JL9tY4PNSjYDGlZzzHvC7oUd0AnuU2LI3Fh6R7QkyXfaU9HfJGhX+62Zmz2N2xGtORvelMVQ6HEUn+r1aa/V0Gw423Cli7fMZzUPeIsP55szPO9AG6l9JJA21IR62uP8XRgNMTfmbE8v8Mv+Ansh5XyVBpX3Hg9AKcM33BpNWZ+UOGCStSszSIC1Ob81OZWSfuJzRKI6o7rTt9DH/jQbisQLkM2cEI0NBVcBfa7k88fNS8HRzgFGGbvd+vX8Fr4jtY9pwRlF9keIGjG3katUFC2aBWemEiTUAPgQhXmDCFxwd6yhLng==;31:dDq2sTtMmNdpCSNp+GuOIYy/O+4SABxuqQHK8rlV8eJFwwq83owefelG9okq9TeXVfB23VSsAcjI7YafLtZ40PR9ybeb77zLEHETobANIixD7oxV1m5PxVCxn+MCr2uVnjvoyVMHwJDSbyKlZ3l9xSNfck1IVpQfRaIiWGyc+Sc5oO2pJ3nFpVFUHVXiHa3Midn+jvQ/oc9HsU2YLMjxE73uxFtmPzRzbCkbqQmFAhc=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772AB9E60D04037C2840E37BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:iVrDiZ615AeeLNhG4xZ/fjxRLkZUUdJGFsMguZzdPVlQJPzA5U0vZg8Zq1MhRPoDxH2ZHzyy6abBBn1edEthzMyK3ewZ9iRD9circ+fR/GGfGHYKnCGUGByAMtkFpc+DoXREWsVLZPX1wtKs9GvfBk57oAOcPTVlbuIzlDKyIn9Quzv4VCltDR1QXn1o2Tit00CbSRvyl2eKPFipG36jJhEHz7dV0ebqzkf5by73KLlsAVrjpjw7aBCDAqLR3p4AqcRLSCW6ejhWz4UT3Wzu5g==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(39060400002)(5890100001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:I5qVOdfOOYNjleAQ8nYGDeHoY0W1Hmd/xwN7djA?=
 =?us-ascii?Q?uVbntGIYiMKlgtstpZYxEYpyLuj6m81YiAdhZLccIs/WwLTBN6gBf6kozHx2?=
 =?us-ascii?Q?w46LtX++Owoxnu9EEi7W+V1YpJzoDwwftXSn0vkxj91Z3nx1/hE9gv7ep794?=
 =?us-ascii?Q?JISusZQQdE/jBos/1NVOA5gjDDJlo3ZgcYaxRi5R8T2/iyI6dxVzo4xU1mRY?=
 =?us-ascii?Q?luo9jB0viB++LwQAz1UgT67n6qYpCsR1XP+V6a4Aw52d1BkHhz2vmvdbqC15?=
 =?us-ascii?Q?U5VoPdrStUqk648+5TEKQd/F0wdhb6bkdoAN/MYDmMaUz2tDxewZgVtYzfl+?=
 =?us-ascii?Q?nZkhT/Ov4okjoYAII7X0Ug8LRZaTx3+BOyh68sSw2zNO2AJPBPEx0VozxkwF?=
 =?us-ascii?Q?qo6b2gpnGXQphY+7JHzYS/AztsSa+fq0QfU6hsEDmNBwZ4CMOWPjU/44JWDB?=
 =?us-ascii?Q?yNR77xeapEHFUGDxhtY4JSpUSY+2Xl+em+4BbZozrzs3MM6fVZyTDn047Ask?=
 =?us-ascii?Q?QOJczDAZsoht3y/zghCq7wpJBRM55Vpc37pNfY50pT8KDfA/2kay46T6oi12?=
 =?us-ascii?Q?y2M3dnnX9hfDGJ+YMMoFETcSoio/WRvZmgFD2fXLBp7urGXNr21CZA/tnKhj?=
 =?us-ascii?Q?fMDb9hPdDhOGXot4aJLuEgrB07kHgKc6Vr/S59onDk6K0GZLMcfIXc+h0gC3?=
 =?us-ascii?Q?udxjOnCza5jE4Im+/96JU7h4zzQBNYCE8n/F+so8VUq4Rm8tYn3q6cD7Oz9N?=
 =?us-ascii?Q?lKHxZWEmcxlnP4HcQgOpC20deac/CXBr31kaCkpDpOevn7hgmvkvqdDwBOh4?=
 =?us-ascii?Q?pY/jzHMUplaXe3Ybnm55uTA8nTGKsp1yILaohWVFfaeSZlcxy/OW2RQrfcfp?=
 =?us-ascii?Q?2EBC8QmsvwgdIkSuEAA4ocUEIWKVLnS48Qnw1s99RyKhh3sEKBV/10U/4ZX4?=
 =?us-ascii?Q?u5hHOs8d4yZP6lgV5CCd9dkgck/QLGZXPO7HGGsMdF1MwN8ECgsWUfwA98ni?=
 =?us-ascii?Q?AHrEK5Zkan8dkljCOSThb9ijw/8zlcEKqyGU4kMwvrusgXyIvkeneQOB7yRG?=
 =?us-ascii?Q?2/0WLjGHfCEpbVDOOuSzAdT2OOGhzBnErtx7wKqDpPlLSmSUsqrDIb/UUiFj?=
 =?us-ascii?Q?Y6NYXVqbUWtoTAiumOWj0l7QSYkpzOyZ2B8CDEdFVHDgQK5gUZKxgfFuVnWh?=
 =?us-ascii?Q?QaYKTbOC2mHVXbxXacVD5qPG5/jvsP5anfovUJdWczOCxu+bggAbnUzckIFH?=
 =?us-ascii?Q?mwmWmhDfrafCSNhXihm9q0t4UwHgO9KORNjzDNN89mWAKPSu/x4/Ynm7Z9rX?=
 =?us-ascii?Q?fTGo0s1/W25ofMIxWZQjuuZ5jucHAFsCq9gYOOe2UWwxOD5LbfX8itgRfI6C?=
 =?us-ascii?Q?6ENEIAAYz+029X+r8MOAFzon8os8=3D?=
X-Microsoft-Antispam-Message-Info: jZZ4/lf+Q5qQk8gf8o7vqJZM95LoZkVWy1pDvQOBXqySQ/S7QRggU4qoPp389/kueF5sd8VAuc28yf5Z4Pj52W6EoMR7NZxKghmauMSpl2SbaKpQHV3IxJDMnEytlBLT0YuSZnKOm8OywMfjIoUOMCDm4bZ229lXojm780TmbKuRlH+hoVp73i2RMHREhteu
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:nSTnXwbIeo8g49HePAvnODqT9U7Aq8j3M8FPMdda64eoBPnAeUiHaTkEBtUqulcDK0NkcSitUcd2cbEDTsGVBm0Xn83LgpRkuREm1GOZLkTFgBo0Mud621PcCQu97+GGME7oHPMIxSwUzjgMcSqkhQL/3rHDQ2UqIGGhxwm88I0q+wZaoKEieCwJKG2F92pdndQ2b32dhLiYxtSd60Wkub4q3HkfFdK2Q5vAhuohIayyKQybABzBo7OhmOtAyRvrbxeO6tx/owZLuG62fYRl2iCIZ1HYoW4QpOD4hnN3nHrq1aiD0g4wo9nIuiNeEDKkym2szK0WkOBf4MyS581g5g/rpqk3ha4kr1DbynYhOss2ML95ChjV5YvUYzELx+gUTiIansB6+bJjuO9gBQ2MFFTrEsHW2aVxDAXrFxw9rAaHJ1NBjO3JpQvzJG3a50lXJU23mdAvWgmnPfiP5Jcl5w==;5:tRgMCdUFBy98ZNIAk+XI73CD5qk6SsXqB7+5TOQ886nSRTLkvNLU9knscsmGhGcS7GGj8/5ShQTebRv4CHV8wEe6lXSl2XVPdkNB+mnUO5XHC+J4DQcKIBxFlrsM3imcmlPC8VVYfJwqLXhERdlEUpmzKo1yx6ktCGNoDC6TaiQ=;24:gRDey3QS37zZDT4axl7QtRK15YLNmKrNZ3C83p2m043YAg3+y07cNI96d3cnn6cufMOFXw453hzYrXnPVogds6He4WF5Q2Te25VRP490DTw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:DdzkSLTPXMz/whhrkxdSPgfPYQNUEDzn/cacthuiOwFb6ToMKRVgRfqZsF9+CLXXjJ576U4kLSssJtdUhKe4I/RC8x5DNUH0Hn3BicPYAWpACFHIpJX0aJ2RpDLv6Xy5FZ6FlgifKo1l4UYgbqR2ueBQcoWuCKyQI7r/kV7MK8nrDtDvn6eIkiUA4KU1vENFyOssrZ0/CdSzr/avICAO/lQfH007eYLz30i08DVJPxiFJOXsCLbhV6/fJVmnREvf
X-MS-Office365-Filtering-Correlation-Id: 59d16624-8be0-4c0b-053c-08d5bb161a2a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:33.9274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d16624-8be0-4c0b-053c-08d5bb161a2a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will become mandatory.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c  | 1 +
 drivers/gpu/drm/msm/edp/edp_bridge.c   | 1 +
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 4cb1cb68878b..1668e8abe5c1 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -710,6 +710,7 @@ struct drm_bridge *msm_dsi_manager_bridge_init(u8 id)
 	encoder = msm_dsi->encoder;
 
 	bridge = &dsi_bridge->base;
+	bridge->odev = msm_dsi->dev->dev;
 	bridge->funcs = &dsi_mgr_bridge_funcs;
 
 	ret = drm_bridge_attach(encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/msm/edp/edp_bridge.c b/drivers/gpu/drm/msm/edp/edp_bridge.c
index 931a5c97cccf..4c56e29c57b7 100644
--- a/drivers/gpu/drm/msm/edp/edp_bridge.c
+++ b/drivers/gpu/drm/msm/edp/edp_bridge.c
@@ -104,6 +104,7 @@ struct drm_bridge *msm_edp_bridge_init(struct msm_edp *edp)
 	edp_bridge->edp = edp;
 
 	bridge = &edp_bridge->base;
+	bridge->odev = edp->dev->dev;
 	bridge->funcs = &edp_bridge_funcs;
 
 	ret = drm_bridge_attach(edp->encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 7e357077ed26..aa6dd1bc5dc0 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -293,6 +293,7 @@ struct drm_bridge *msm_hdmi_bridge_init(struct hdmi *hdmi)
 	hdmi_bridge->hdmi = hdmi;
 
 	bridge = &hdmi_bridge->base;
+	bridge->odev = hdmi->dev->dev;
 	bridge->funcs = &msm_hdmi_bridge_funcs;
 
 	ret = drm_bridge_attach(hdmi->encoder, bridge, NULL);
-- 
2.11.0

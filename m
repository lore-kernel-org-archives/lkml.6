Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeEDNxk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:53:40 -0400
Received: from mail-eopbgr20091.outbound.protection.outlook.com ([40.107.2.91]:36544
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751713AbeEDNxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 20/26] drm/mediatek: hdmi: provide an owner .odev device for the bridge
Date: Fri,  4 May 2018 15:52:06 +0200
Message-Id: <20180504135212.26977-21-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135212.26977-1-peda@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::25) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:5EDMWTeYx9WJ70l+0c9EQl5UudPXahPL7ynCfeUTxIGiZl3bTz3w9EOk8SZZGC6661W/m7FBwAEb62cpRunJSCjmJn/6pn3MxY/6SIZNmrpMY5m9Lqc6LLNehEd7EyM2FZfAjbPoqEWs2xKGVPf4U22zHpUSZqjf3cZ4y6j8HBh1BVoyN82drEWVFRb9Be3rDmnKyNu8XQUoYl132iPuSPPZ8HurQfJvcKp4xR3dYah2NhTc4Nwq+8/FAnNx6dUP;25:2juHbijCULb9tgpEqqybCyzppZvWRGdp7IQjQbM2oNhM62kUq+hZyJTYtaRcz1N9vPsE9tP+n9/8F64d9ePCNycnJhowPCdEK0dqrDX1oTAms85SgCfJc57sGTYVRKPs967sqOZm/8ErIUkQ38cRxeJFp0svym6J2apjKZYUF3Vlbqc0NhDow5spcc9pKB7F+/AkdQkEkRjyAk24dorQpZJrLa2Qvq5tsQzrQwYyLp9eR+vZSIVRxVD/PUVUs6pX1UziJEs96pptl0gk+K/Up2iW0x56qIpmgU8Xbq0YKVXCNQT4kbVqM0vyilRnhi2XW1PxYRoyLlqdRhG7f2P4FA==;31:I58uXhqsoq57loZJYJosKMzyQcsLyqoKzmL5uUHr9gnyCvTrpxoLacAiBa9k2lJlGCnjRZMaPtaAvG0kmctU3IPT09VCD4b7BDqqsKFwAPWEpmRMT9G5NJJ/BHjFxFAYUInXSmQqQ2Bnb1IEdkJtpdJa+X9x4zgnOjWlWRnbXCILrVgeOfcdwpsTy5gwb5GnhZ6T3x5mwRjnXDIyeqWd4I02pql5iW9Rhzh0iMHL1G8=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769D6644ED5D17D2C0B1186BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:ye758eqSxjP/+MKdkzTm6xynEBV8Jlmq0KPjW2W45sCrkX1K6v4ZbA0YaKVkjFY/s+eX9cXkPkUNhuJW1GYfVe1FHwkaV4dXQJHGKpZp8YHlBuTpIboMoLBUQLM7tRE0QyEWqYa+t7lHFxp4i0n3eDeq6JmEtKkszZoqvb+JV3rTPh40hdtlZOxiafKiJoRSK3ghTd/TGi52rVXSHgc9ahm+gamE4P5UoQ5z+R+lDYO/iARMe7FGmqj1NRVIqLpNbQZNoZNL7kGoX2o4Nj6OZA==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(39060400002)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(575784001)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(7416002)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:XEyBnxdpER6Uy0pzaJoXgMDkgOEZQ8LylorGRdS?=
 =?us-ascii?Q?VLQ5pk3TLEtG8hMVz9Pa3r88TA9K+jHU5vZ8awWg6Sg9oa9Uz1a4ElMiq9BE?=
 =?us-ascii?Q?7YsUj9gPw1sPg5VaSfCsyhyGazem6pGpRZB7faG9e9zoQZJSj2qAWRbpiGKL?=
 =?us-ascii?Q?xMbHjtvgSDRQBJuQztJQm0s9uJr63vWTAdzDWICLCAIs+1c2pkgqou2ti+Fj?=
 =?us-ascii?Q?x//BBisOMbAnIeUBrKr100KP7hG21u/gA0detRldQ4/btC1GC1tHJGbAY6tY?=
 =?us-ascii?Q?U8zH3Tos2tPQ3eOYNGJ/9ep9xGUAE4Uai7hTKb3kNGVfi422qo0s44T9aRRM?=
 =?us-ascii?Q?BDOiVJd4HtZcUZG5xwwsbY8aKS458Ay5Hn+BpyrJihC5M2OIZIphzxLJFGga?=
 =?us-ascii?Q?7razPYLp2vC6Bi1tlxXFpD/ErzWuQ5yJnDnUeTAtVPpSBdhh9zgYyYx5hoqQ?=
 =?us-ascii?Q?nDV5cfFjcOpsaPkVMJ0FuMgrW7bBAGTgzSHUjDooEsCDtNCkKDZkFNz+6Y1u?=
 =?us-ascii?Q?7DuqQyqR9QRcAMq+xPjkPMNPTj/WYmIEE+glRdZR6vugPvghECypmlAnSX3b?=
 =?us-ascii?Q?Ynh4/l1LJ7cIU3PLcSSnYFlEI7u6P+Z5s6IPSO+87aiqsKCJxG7wMn9D9Ffr?=
 =?us-ascii?Q?REqK+9q4faKMOVpnItRFCUJbo0Crgsa1TB6gTFiOIRtdWdRc6Ij3Tk3yIkXB?=
 =?us-ascii?Q?t/8Z4rI8mHRK+UjVUM32GGPREdFMHY8tiY0wD8+CCmko5icVNNrwo6Tjos72?=
 =?us-ascii?Q?zxSwI6oQjQgTHtqq8S/RvF69sqCX3bCMS9UCZ9MUQfOcuCgxgiTK2SBSBEWl?=
 =?us-ascii?Q?CVE1rMJij2X30YHsYOt9mRn4x6+RQdwWlvbo0clB1iL2HKMo7Rf80g7J6yTW?=
 =?us-ascii?Q?cv3CrgUAj/baM61cwFCjYbFK6xPxFOiF4moRDGyU2Jdt9BWjynXsvhRQ/Gb5?=
 =?us-ascii?Q?RfCfvzRnxSNMfXmOp0uzePE+ha/FpcGEnXadG2A7+pSSx2z1yk2ViFue6Lyb?=
 =?us-ascii?Q?f7PYuxYpA7rLDi3mE2DE/t5HxeoCSJXtXjcLkZdMO96hra9T6eVSE8WASLPu?=
 =?us-ascii?Q?fe/GoKZofx5xhxE8szkpnjIVfdW0ElkD2l2FEIM+d4ik8nTxpiyBDK3NBs/v?=
 =?us-ascii?Q?paUd/PoARVaocqHR6L2MP670pFyp1u4UuqIEwUZ46mEOy6Oq/W35zVhHVHpN?=
 =?us-ascii?Q?7bqttQSmttsS2unvJl2Dsg1GMRHkjS1djmuL7/j2qd/Zot76P9Yl0WIBXafH?=
 =?us-ascii?Q?ZqbKxrgJf+iiLuXbwUu2ku4Ajcw5HlItgrsjHhWhjWzQm5+lL+CQ9ub8DPUq?=
 =?us-ascii?Q?1Vm6EhgEvyKyZcwHsSJu6x81V+5rVkzpXw3K2BrxSqhyE7/e6ta6OVCE2VIP?=
 =?us-ascii?Q?QUd9NZopEOv4K9wriWEQSBDKQa90CxLPcX2WdbvBVvjXrDSBSJo/wz4zNSbc?=
 =?us-ascii?Q?mgK1puZKA1Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: Wju5l3ap5lFyJ7L+7E+cIEW9ImQrRdfH7BO2hJqMPn0IQvFl5qYhOMIS0iaGB6HYN9tfkT71udBZowrouFVxI8ImW3fOv4o3HxdGOH4LMJNVMdgAdyQDaYE4RNMLTJ0+tWvc3q9YPy4ZyaOcJN2eXZUHIL9nbUdqMPJHy3RA5Drb7shHhaWvGhiB+J4gUijQ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:V7MTqOYefJHSf3IIJfBzGryWhsLoKycHHHLgnAOKstmFgTy/zfyO1LeQhlfBG701e3Va05juRaKGgC3o8cSiYdbkfZeUsSOu+eQpevv0OSGgjZSQN9dkEMSTtPafjFku6B2sDHxf+4tTC2c/gPuSX43mPcTSpaGJiFUbdUAgds0LHDrZuwR9lf+/JQnaudV/j5l88VFEtm5s9G5Ejp/bHxr8cxEkEGqSd+imXur3F8ZV7svj6wk2LEJx+7LLH1s4poshWjMMhA7+gHkUBuwXknTtjQfR7FuxxguFFBgn2iLTfnkUBwjUahzzCPIhuXgbbZahQJiu++5J93NGv9L0OQ1iuwYqcYk2Zn1NWSNO3UdUy2qGPF7ZHokqqB5BbDrRIJupHoVePV1vjgvnRZsy3mloD8qBclFpXYA93t63TweP9ESVgN+hnTTGGEtX3T7pEpdMK3+7yQmFUqslnbUNPQ==;5:6UvalSaLEasSTEEaxPIf6OCAGkUj/gicarfYfl2w4Jy33OiRslmm7t/xE88ceE399sn/MQd791yQMCJ+m9h7dnC50ZUNWjAZMgxADZcv7pXXj0zxW93K55KAVEqdpUI6faenW8yLrJdKPbWNq+qAVygPJsKdjcBcNXKrclF+gSY=;24:BOwyIYaynQev3UyU0fCrOSDeZEZTZWeb8B/k/33IQ4mQUw91cb8pieiTjp0Wfwjea329u+3/vCn2DJVKZuSVxX6oKMNsu0fC8xGiAy2rR2A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:KVfpyracz/lZIIcwvLgAGJNjx1UeDy5v8FX1ehugJAToJkaIwAlEmC0eQzk22lUfVdcMZzeYNZCot/4YHBGK5y1fEk3cajnsqJcS9cOtST2DE9AkqnYFZYON4n8GC2ucTA6UPgIETeUm1OxfcEKgJOhbhICSdFq34SjWNAGrXt24ZHWw690RWNXEnigZ9LgGaziydS7NRfhwZ+FL1DripLTQQXv7rw52oUcz6+7ICcHHkG6W1WePvb4LENMIRHdU
X-MS-Office365-Filtering-Correlation-Id: 5b2f9084-0f2b-405e-db40-08d5b1c66c69
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:31.2441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2f9084-0f2b-405e-db40-08d5b1c66c69
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 59a11026dceb..d8c7d93d0a87 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1694,8 +1694,8 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 
 	mtk_hdmi_register_audio_driver(dev);
 
+	hdmi->bridge.odev = &pdev->dev;
 	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
-	hdmi->bridge.of_node = pdev->dev.of_node;
 	drm_bridge_add(&hdmi->bridge);
 
 	ret = mtk_hdmi_clk_enable_audio(hdmi);
-- 
2.11.0

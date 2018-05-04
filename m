Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeEDNxn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:53:43 -0400
Received: from mail-eopbgr20091.outbound.protection.outlook.com ([40.107.2.91]:36544
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751756AbeEDNxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 21/26] drm/msm: specify the owner .odev of the bridges
Date: Fri,  4 May 2018 15:52:07 +0200
Message-Id: <20180504135212.26977-22-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:TTZQQc+t6e73mMBY7PX8/t4e7/wVuo4aamaQLOcsr442kkgsBZturXXICMwN8fPdojaAyyD6t4KY3n8DZM3Hm4sQo+d5tF0ejGGkfIBzJrBJIk3Dp+tpmry5xQ1OQ4YiLwKh+87EHLrJDd5K3pesKXrM6bsFyOSWcPivM9YUaMqmLbdGHVsz0uGQNqevfcbHL2/Nvhl0hmB9Ix3588+iKVUL4v8t9URbi6pqEYjPI3Uas6ItuomP0X+2fAnWBJ94;25:OlTUZWX0gsjeYzayc4mncowSlx9QGDFDiEXzhGiiUh9pqKA2E3e89HejlGCQkG4WEkfJNwtwvxLnrBfVq07Q03mRHjBdvSKkmQgqJYLrOoxRXDEeu7ICwydqErMq0t8uG71Oc34ex4znlK4OPyvBpXQtvXNZFJ0phQvx/khyK+3O9Xm47EtcJu5cEHTqYkpvcbPaHOOFQMTlK37OPIOjkpaWIMZM0UTkZXvR+pcphwVjZM7YsNE1xBDFcwsdWfauf5LgRlJo2ZCmZ/h5sk5fmipk9xW+Db+VPYBq8veGc+Z7PIPwV8Xt2rc1TLr7OpHrq2GTaRvjoVp2X86PskVzAw==;31:Rm14I2DLV3VFMabY/phkdLQmAYG2h0MlxrZ1EhzSqXuA7XVkxbrw56l7bixM5zlxNuI9Mo4SI3s1L0DnNqrNLRHouXLRDmHkTs52tdTQHtOVSY/R5SOAMoOHovuRkajKy/solFuEtz+WqTcz0x4QnLZ/iPr73kZr9XlQ2HYSS1yue6LVREpsAz3H9tfKRDiFoVu4R7+0aGi0OMhVF2bwsBnCzW8UC560KvqyQxLiRkA=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB276936E17CC9819F4BFB46AFBC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:RzjfTdLGfqBZYYju/9zzh6MkIKXkA4O70UhgXkFKhis2TpO8YE5xk0TY7BwDAVgBVwMXNqx64hD5Y4Pzx4qJ8ySSmTggOr/3na8oJHJ6Na+rjzX4ej963pLl1aXYzMi+PC/N6NbFwvT2P30AEvh3/NdotZEwSH6P1QbezAcyImxk8k4sHm/5kuacyJeYSYkTtpaVt/BAOO4YibxQ2FjTgw/SR0KDVCDF+8fMdoKDS4Ql24TaYeq0me/Ak/PL7F/GE254L1GBbACa2bQOZQJpog==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(39060400002)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(5890100001)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:7N/J4xFb6NGHfe4r4ni/+txemwlvt1JyhpB3R6z?=
 =?us-ascii?Q?J88kEZM1rWh8LrrKPa2Fad9NFx4A4US+7lshGzUSty+gi+lk+Ry4CCW3Ymv3?=
 =?us-ascii?Q?1WZRFoxF5Bj3FhFkstITISqHxpRPIsteMdDwBKIBKHlIwYeJaO+wmp3AXdYW?=
 =?us-ascii?Q?JhxeE6IhNFgBrgaBRtTzf2WPNh4ZZ31N52NpUlcQcX/a1zNlcTwoQxKwirKE?=
 =?us-ascii?Q?X+Ef5uyB0EvZiUr15fQfaqUF4Asbl9tzQ81aW2K2tlfS4fTWI4iF3nsMgQ3h?=
 =?us-ascii?Q?5/RcoLE/hRr+Zhiv4xOCKRdbG5Sdgmap2T3p4dWZvPBfHHvI2ZrEmAoKGmSI?=
 =?us-ascii?Q?pgqQo5Ww76thbvDjWepuV9qGo72jzjcfgsHELd33bRL2vN8mLpfrVeHlv52V?=
 =?us-ascii?Q?HPwF7IZgMZWxkg4XCI/nlY1P0RkokZQgk6gxaRX6l1hZXIC4blJlc9bzZk08?=
 =?us-ascii?Q?VEzjuw7axI+3teH/aqI600UAS/jkF0LgMKJXuhmD/ZI2ty0IM8MJ14jk3KzL?=
 =?us-ascii?Q?i/2LkZ+ONgFzgsRziI/GtM3J+saSznCTkX3gGs/BGh0wGQ5F3nAkhSEJs8ic?=
 =?us-ascii?Q?qwBLfMPK93uMgrXGYHk3OI0icrZXWguXdC1b7zbB1056tVs2sfeb8HgZKYAq?=
 =?us-ascii?Q?/LOp4O5HCrvtfvwOxf5icnZGzACG5PULVkmWlG+Avh+cnQAAYDdD8gkRs1TV?=
 =?us-ascii?Q?iiB1cRzRRqE59Irbdtr1Vc1uHTnaMGCFNmywQK2jUKb/hpFiBqtHUO9b58zP?=
 =?us-ascii?Q?FhB9ipeMUKARPRCmpmZrRv1NxoVv/tl4vzldGcSDsi6jBt4qqsz39P16iLrh?=
 =?us-ascii?Q?1IuZuqXo4Ra7U4pE+rUHNAFJt7M/U2ExdxCyOcnkQ9WfPIsg7HQsHCJ2hBbk?=
 =?us-ascii?Q?nsUFO7WFeuj4F3fH5yfDNA/wpHzZuQArQqL8vg+CKeP3pJAytn51oDRUQw2o?=
 =?us-ascii?Q?Xz80tu20WHLVJ0R23enoZchkyAMNaqVWuyMNztmxfvyFVMgWnXH/BOT/L6mV?=
 =?us-ascii?Q?2DZDCV0IM3QuhQ4E5SetkU/r+AALDQUnt8uJHMXAW4VsAqxS32KCc+KFo8GQ?=
 =?us-ascii?Q?SqU3Abww4HmXLn/7d14IKAIQZjmKGPWnFdcsuvauK5WKwlovQj48Ey0nMeBC?=
 =?us-ascii?Q?3/9+T4TJY5JVTwEU8D0OeRNRTxsB0xCTS4JHvRuwvKw6N3i2quMrPZ3wM7gk?=
 =?us-ascii?Q?NO+3F/MxfPGiMy2BocOZv/MvYNsl1ekOl6sOB+fkSdtiUxBpojq/oDO/jplz?=
 =?us-ascii?Q?ViE1ZDfNkzChwnqAQxeAH16C0+xRt92hT/A8SP+D88HBT02W8X+Zi54yTMUs?=
 =?us-ascii?Q?O1CcKjY4Ia9i802Q6AJaV55wqiUwfMLeMQ153YcNPfKkUSy7vrrouL75pQS6?=
 =?us-ascii?Q?tE6NEv3gPLMxK4DN4RvuEjW4UmiY=3D?=
X-Microsoft-Antispam-Message-Info: Zegoj64C7KmzyZ/cH7r9+xSdlXrX0PTApJrxwLGNJ10ar9tKvMohxdETvNhBmYghgBqP3EgPfCfqbdlS1L3s7StT9e6pBmlXZ7qV3YmrGkGYKqz/zt3HbHZhMAc8FZBkTY74mEYG+SqrC0nDRAYyxA9wmOh0ryObKgd4BAHv4Q04nQp2wt8RD/dPxeux0MKu
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:fL9ItpO3WkQK6m3Zg1QfdxCwZaE70iIiV+a571KA34VvYP1eeXl/JRFa2iBwG6dsph4+buIggaD0PZ3AW1kMCY1+GV6kbYb415EUHoC55n5/VH8anFpntgdj3fRaKhC+/8kYoTo5vjV/NnytyckDdROkM6VCRFY/9xBSKUoUfb48JnqNnWyJHhBIgQ2P0R533hUR2itfAVwfgsvCUD4fqW82o2434av1CLXNlmk278bVaPG5gZwqDetxvv0Uxwl/7sAZBnFR+7TEaMsG/XxK89abwxdHsnqu4Kyyz5U2d2Oc4+8a46bpKpU7r8Acp53gEphGb2yWFAFJCFDfmrn1AJ+Ag+69hLto1X9EuwnaQ8v/LGLIpTzK7/THf9IFMS28z+3ut07Mfp0yAwnS9RspEE9CY0bhUjmIwD1CHj14nAwt8V1pzI2sKW1a0VufDDML6YT0qfGAkbjdGS6tzHjPTw==;5:EGr14LGK/fo0pNjZ+v5/xhXKnVMysKRJwyAS98FjNld/5WkIviuDSn15x/UAxR+9w0SCanERZxOwI2/B01u+D+P+A/MdVYStIY57BFHyQnriQh0cVAD1XCgDcASfZN04JpfRpmw3aTm14fxlP3sIJ6vZ0ika0VHS38j9JlGNvdc=;24:k/Ph0IFo4vS/Zojup6vq7/wutXYm0Qz8puHLmRDPl59m+eDsdO41G2QdEip5kArLyd1f8fZ8nHtgfGwbXhDZOlE0V+g8iN0R9K8LMAa7SsU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:owJa5UmRU52Klbe6jkpW1al7AeNU8uMm/TxptD3h3/P8DQXr1TbLEK3m+sK68SeZZnVtDC062DvUqcn0GU2kuJTXFwVDWSN7gSiuYabnjYg0/JjmvI8Wlm0vCy6etyrsa4Olsu9cYg2dGdEZqSmkosiZP/Wo/JGN7mAJ2YmKTouW62RHDSFDHdklnYXomz2I2RL2OKTIbekUA+i7fgzC/NSNLX0iKkDgu6yyyomHC/31v2nhjwjjPpzDhKokxPHJ
X-MS-Office365-Filtering-Correlation-Id: 7ecefeff-3acd-4e29-05a1-08d5b1c66dbf
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:33.9104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecefeff-3acd-4e29-05a1-08d5b1c66dbf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
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

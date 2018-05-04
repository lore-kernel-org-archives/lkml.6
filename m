Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeEDNyj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:54:39 -0400
Received: from mail-eopbgr20104.outbound.protection.outlook.com ([40.107.2.104]:7868
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751833AbeEDNxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 25/26] drm/bridge: require the owner .odev to be filled in on drm_bridge_add/attach
Date: Fri,  4 May 2018 15:52:11 +0200
Message-Id: <20180504135212.26977-26-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:uVpej3n/jhcFWhTGLC5sScv2xdApvjB/xIEeIumpR56ZH9N7V+oeGmSGML15BhWvYpN7/OrHYN2w8BE6wDhCC76oJlSxOcwO531fqoyX+IbdyDuCv5YH2Sf9e388wSxsJOyMqv3u+/ws1IxKfpb3/1SEIFBv3/NXJ5yNRXhAPqxvKbnAc1zqy5RgZa6Yhka8zKz10rOWu/60OeZCB5m5xJMPrxPV4RG/UER8l/lqtWeP6MjjoVwWx/jXV5/awNAF;25:MR7/rCgi6epME1cxyJ9856FlTmVvBjhWGAin1yVRdq+8SE//O/+l+v515wtgGP6YOPmKau9H/GjJtak+RcmZDt+V23SA6LEcHEkfJ6/EdEvaYwLNKGMPhCnpS8rGwGPAeMXHGM5+3ucORY6JAv+UyIjXtiUYdDNSySGUwagIW0Zo5mvUGHfPN0CGArGJclY3saP0aML7Z7MVRt+Ga65hjooVMzYGMpt32GVVCUTDtm7rSn89PRRwapVsyR5j+mnPrs3aA2gq2SRPuQT0VsHWsIAf2LbdyG7cH5RtUYWNZkFP9+ovNX9YytlqCRhzjN84i1vwkVRqYWjRr4Chkv66MA==;31:5edPzerELf4vn2gwe9gu5uWprscMcEcmhirzqrd0mLjGrowXSukiwWwoQXShNs/j+Aw34cjtKSSN8tZ24S5caIawgVJ78j/YEIQ5NVC9j1AkO5NkjDGJPtIAryK5Fr4UyGVnsZi52KrPnLkdkaR4a3auj80ZZThXAQ9t+A2Fe7lmxIe/Yb7Dz7ofpaNSrTDkwsC2jSlMvs/cZ4wCxvAqk4atjuJh7ivENuZmutTuK1A=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27696A1609DA64523AA53E0ABC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:CkgOU7ivH/btaiAG4UlbLpM6rz9wNXTBtnpkPvP8N0BVLqiYvwk4CTeLebpZV/8ZSoKh9AGlgMyDO9Wpv5GFtO82xH8pdJO+WPSpZs8uQWRxpFy+U7ZQ8Hh3coWl6g669iHPXZm2mRq164c5wenB9rGSDaIft1XtAIbi2VbkUS2dEHerDzvEx6bWRwUopyE0MWJmyxF4G7HgsaRSJDXTGkMljvb6gSNhgBFb1cNPNbksZuUWhb+V1RyJVK/EQGD+8B19FfYiAGUPlXyhk0krXQ==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(39060400002)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(5890100001)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(7406005)(956004)(105586002)(2616005)(7416002)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:hr1ncnP23Rt2XhC83AbIO6eTl9W+PEb4NcMNjWG?=
 =?us-ascii?Q?282+XdRBz2T9+KGZJq19NQQZHRw/BsFYC2nX/uegpRJTuYnWeFEjZGXR0gPD?=
 =?us-ascii?Q?MkUfQN1Nxd7d6F7Rciw9aOgli7Uook+xTSWAuhzixbU2faU2R8n29lhHeGdH?=
 =?us-ascii?Q?VkraFZW+EbAOhIXATBSHjLOqa4xiaYJRuS1EEG044Str0BonaBaJeZb8f6YD?=
 =?us-ascii?Q?bP06GATOEhkOwe/hokMJ86uhFSvV722IDXL5aNbxw5/Sk/OxBOzdbTFFj822?=
 =?us-ascii?Q?cXjkHyxw2SW5ypQ8jDCUA+6X184geyb/jJQOzo+5bK7iWyEPb6YLaWPhy3dJ?=
 =?us-ascii?Q?9OIlBDax2FzzlbUyxTDchJuxzfbepjBO4DsDauTk9DkAHSKgk+4A5pS2HlLE?=
 =?us-ascii?Q?VE9ZffyYfeICma6cBFmUFh5drU9O2P/5g7epk51kZX4uGkDDoZIyVzHifR5y?=
 =?us-ascii?Q?O8p4CtHyy3pTGQqvX2DmZGbbhLfH9SKDq16QGq1vFYUsklUoGkqa1rStf3bY?=
 =?us-ascii?Q?n5uLHZFzorstVqi/HEywwGNsukTAsxgAGXZLy4iLndzqQ+wVEV5qoXqFMXK6?=
 =?us-ascii?Q?HOeq2mCUQnkiO6GF5+vTfuIv1f9H9HGogAWKbP7e/WIW9Y5f7vHbgtaA94yB?=
 =?us-ascii?Q?607sq5YgRSiXi9zzXFvYa+SPENmXH6/GKkhUhQDsVS76cbJ89m5nX6A519SF?=
 =?us-ascii?Q?WOHQlPYIKA7YXH1NVUOMr/J8JrH9gjHN+tKNaVMXI2RY4b4WSCok+jX31P+M?=
 =?us-ascii?Q?VOrfQ5dXJhWJoNns9yZsnRoIVuITPFN6bo8byy5cJcrloCN+2Jhbsupn1B4x?=
 =?us-ascii?Q?0zyagcse/BA2NVk5rXmO97o1mkrcXZTBTpfFbZKEdnpui4kyV7KMC+4wwiLK?=
 =?us-ascii?Q?I2I2BVOKrA7bi75FFiQz27CJ30VLmqcix2qAlEZh/Bvmwok2uWuRTFz/Eedt?=
 =?us-ascii?Q?roUOR6AUeXHdpU84A7k2yO+olzeTw4OqDfWg7t4qXydEC8LTB067lsO+fglg?=
 =?us-ascii?Q?L6NcNA8rdfZzRcNbv5LSmNY8mVnh/2KC1eM++K+2dIMuI2b5KO9RzwvjFc1w?=
 =?us-ascii?Q?2LMBJTfKvr35zPzSGrIMZk8BVHi2RzHH5mWvwxB0PTlSdLoBEddPniBUSK54?=
 =?us-ascii?Q?txCpRoegD491/s6sUVnxG3VozzpnEuAn3H3f6Ja8uKIhBrI8iVJowu8UJ3ud?=
 =?us-ascii?Q?an/NgxUbDHLbmnkfjIc1yapRpDqxJ09u6USPBbcDFj8kNF68Qm+9k4Y1bJIe?=
 =?us-ascii?Q?vDwbzg7kAvbR/UGNvMXrmvppoGqyDGXFwjCOZGpHHwiosDp8BjW9DX5XiqfZ?=
 =?us-ascii?Q?+rcLJSYu/IGgit8rUqGleQMqxUyLXi6/v13mMwDb22wSTfBOZZdWFPmG2Ksv?=
 =?us-ascii?Q?jolSgjQ20SZYvynSqg4SeHv6l1OZ+RWJ3P4kdfTtANmyz5whHb7t+ciOctC9?=
 =?us-ascii?Q?WrcEbWEX51242CFwo+SsWLtxqZfe8khKXbS/ISZlNHyiSj4PRjpxF?=
X-Microsoft-Antispam-Message-Info: YnrHWm1Zb1nkI9WVFZUGrZYLmT1Moqfo7FO68msa61lg8+ELOJ/9MwkON8innX7R9JvJbBvm6dfavzLQ3MHr7yKCDHLlNmenP7dtl59uKtf+JQnKa+TkWj+CdrDfs/m6ZJkmLCpB9xBjJlYsS/6c8q+lz1ybi2E11mNYjmF/2hJ8P47TjQGdq9ppd15s/TGL
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:Lw0Myw/ZBUPhWQCf1E2VyJQCzIMsPSYdvt97EUtY5IPIgvH2q37R7Q193jmzhefRrAb8/yNNRzEEXpasb/8YbNs6tXZuoFrkX0Y5Yylf5caDriCJTPZ7QoOWlvcW1ZlzRiZQIts1hte53PCPqU6m7d/4ktOUzVsiGyfOEW4AdfxDOL6ftSnG7XlDQIa/wAKHgbLumX2/pfdB6VzjCPJVsohbcL/fSec4rvDEipSO/5xzVteURu4+4bfJ1fIHsK22G/C2savxWqxhBLIY1G/ypgrmmJ296hGFtalpWwvCwZ557DVx5o8LSHM4jA8e1UU0ZfWiSR5a5/nVSTbMkjmICAa/2YaEmk6Tut1jqmJxuw4tnXgD+rAKdir2QOnJDx6JIy2DOeNTmd8R2uEsXPIgv8ljYSj1LYSdmzEdoTgIseDEMoagU2tAFjTUFHamzisVjPjvdsg98ei4nJPOsAIcUQ==;5:RKUxsC+LmtLnJrjLeWbuOrwZhJRu40PVe9i6o+TkEyBRywNRVVwrnRy6/RqbpuSfZWZSIpMZ4cIZTITJuvlazg2OB0WnyznPeItMYisqhqE3JgBPbX2mSHYedaKNpRW7lj4vwfcTk2MYZqX3oPNvDg49orSg147Ho7IvIvJAPmA=;24:mdFXNZrKzj7GT/hcTYxPlJ6pxK1R+n8D/PA4O6ueIT5XKe0RyUyMaoEMbyavOekBsCFmZVgE/By6Hh0IYVhdNIRFUaM9ygUm57vZPWZ14wE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:CrwtoTtfe2YXC9P1AXs/cxmw+SIU3WHvpQHPGl6T3M9wniCFrUgoum1VAZxVZpNDDRn78bP+YdDj1af8cgLvms2XejogeW/L3PgryG5DY8x4MNtSAztIqJYnQtbZaElpY+HefjU6FvxwwPVDEXyw/u6Ltg0ZVtxUl7aGVfHS7t0KNsyhpvU8dO5XGcfBbFHwJuCCI4fs3rEx6C+1yMIgsmub03ul6tmX4hkxHY7Y9pr2GzFcIRNZk4sKh7h5cWpZ
X-MS-Office365-Filtering-Correlation-Id: 9ce7491c-d39d-46c3-7a6c-08d5b1c6756a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:45.1607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce7491c-d39d-46c3-7a6c-08d5b1c6756a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .odev owner device will be handy to have around.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index df084db33494..78d186b6831b 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -70,6 +70,9 @@ static LIST_HEAD(bridge_list);
  */
 void drm_bridge_add(struct drm_bridge *bridge)
 {
+	if (WARN_ON(!bridge->odev))
+		return;
+
 	mutex_lock(&bridge_lock);
 	list_add_tail(&bridge->list, &bridge_list);
 	mutex_unlock(&bridge_lock);
@@ -115,6 +118,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (!encoder || !bridge)
 		return -EINVAL;
 
+	if (WARN_ON(!bridge->odev))
+		return -EINVAL;
+
 	if (previous && (!previous->dev || previous->encoder != encoder))
 		return -EINVAL;
 
-- 
2.11.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbeDZWd6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:33:58 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756585AbeDZWdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:33:14 -0400
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
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 22/24] drm/bridge: remove the .of_node member
Date: Fri, 27 Apr 2018 00:31:37 +0200
Message-Id: <20180426223139.16740-23-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:r2HN23nRZQq7oTSggAEBjPxRCkhads0nZz2xaHEyH+ayd71bbAW5H3B1ATknp9mUsa0oSu2iKfFS4lWbY0DpCqzNw/DwfFf5rUKP9uZD3FA3uh2sRZl2qbJdFfpRN61f6+7dQcXrWf2P9zCuBFwZF/51MnaQkybDlHPtP+/YSk31cTmuxxHAOy9TqtdR6AKQuKw3y5JnceUepGmeZxFpt8wztcN+EyKLVkhT/+eyUeer3Mji37IQnB/XsSHQWsKV;25:pInTqij8MEAMYAa13QCfANqSunWJnQRsCIDlg29qAI+0uBETRyT09X9pzo2sHipFEU84RzMSlFsWHLAL0efuKhGag4p3XLc+55o2YNSb3gCynmQJvRoQhQw/TzzFEIR/dIeoauwQEARKs0Utrcrq8HpEBMNkTSEMEux0isKCFzwHgbeabNA4+VwP9lK98UkGV6YeRw60XMYm6hlMa5CyNKNLGcKDXDph6PHhMJq1i/xcqHm+Du2WY7d1R4AUdUShNYVNiPGsuHSNstilBp44FKgb6ZAdu74EPga2iuNL/PMThNPvmYSQYNxAy1iZd+gOLJc/LEaTBoN5WiiWOH6jGQ==;31:BeGZ1h4Ma9rw52SIgFyhspyK7oYx3EkOI2QVN5s/o3pFCzZIeVj8vS3nZoxpPikOTGvmPyrZmLNkqOb/NpFtvB5eq10iO/PcYoLaCyPwOxiVfqZKwsJrgmiNvVt8FnGnii/8c+g4l461XJH0EF/n0ezSXqmrS1woyujLMrg8F31dpOFXjM2WWlbtwyAm44tVK1v76412w7So+cdnYwPaME9mt1XLiPV+TkGy0vHdQZc=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782801ECD6B1BAB6A8FBD7ABC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:kGGaFbJ4g8aQHkfBDBIzOaxufI5fz+Ml3YTDnkO5LUlsiO6pZiqgm57vvyUP1S6XgULkL7PVtn9bSKcXGgUzdTtiCDBgmS+tZMMkV8d1IJ72fbp5CVO2ulE+fY2rS1Cg6m7WQAYja0OHbM3KQy/5PgqzvqwI6d8NSyqLUjAeLH2hK1Z3+WwHKH6Gzg3qQO0aqSAfY0/DlmOWgwEz5RIM5DYiD530WMD430hMbphRLJ2YnGcONIXnb0NXAmByloXW+mZYBHfKOJl1aThwTufdLQ==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(39840400004)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(2361001)(66066001)(16586007)(6666003)(105586002)(3846002)(7736002)(6916009)(6116002)(36756003)(74482002)(6486002)(48376002)(2351001)(25786009)(8936002)(50226002)(47776003)(81156014)(2906002)(16526019)(1076002)(81166006)(53936002)(11346002)(51416003)(54906003)(68736007)(97736004)(478600001)(446003)(186003)(50466002)(4326008)(476003)(59450400001)(2616005)(86362001)(39060400002)(956004)(8676002)(76176011)(26005)(7406005)(6512007)(575784001)(486006)(6506007)(7416002)(52116002)(386003)(305945005)(5660300001)(316002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:WNV9/Lg2H3D8Gn5Jd9zGjHkgce8rHAm4l/aPSXI?=
 =?us-ascii?Q?3sh0uzHicjOMXTbRVdx1SEJ9F8h+F9/w4YLO9wSmvchAgqXx5e59ZRxmj1Xe?=
 =?us-ascii?Q?8IXmu5zUTCMmHcemGOXUgIm6Q+duyTEE0Z/HiPhFkrGCTQpNTb8WQXgADFF+?=
 =?us-ascii?Q?ip2Qr42GXvSSP3StNDAZ/JmlPMtGF1HhSQWbdp49dDPwm0OFJRkHBJSD/qBa?=
 =?us-ascii?Q?VviAbnHMYlT++kmaVWOmbi48Qu8aB08YC+WunNzeGZMCwfEw7VTwM9ArSabW?=
 =?us-ascii?Q?xVSxm7hiIEqkaDYDPQ7A8zcePuI6+Qxcd7OFALjS0tuxdWGQdSC2JDKdVGZs?=
 =?us-ascii?Q?XuohNgcZ9kM8RHgJN1zKl71LbQal8IGQRciVpntOEplaF7LifHUqWomIoNGF?=
 =?us-ascii?Q?F69tdlEI91pT+E+oSSo7NH3pCQ6seTkj51W4QlVMne9tj7VYWRMDMg5BCeaS?=
 =?us-ascii?Q?/2Iyy7TL3FX2W0/rKoR+JzY7WGQ02f/1Yvx5CWtkVi8a7lEEhe4btHLf43wJ?=
 =?us-ascii?Q?LnurLVqCJEGG2h5FRTyIilMQN/FZBcakimZBR06Uu/AyVWRc5wFGrCTP0CKO?=
 =?us-ascii?Q?HQ03HM5Qy2RMRiYWk42HRgBY47+u16CCFuK8fiVb2RLJa7PVfdDsupoDkmI1?=
 =?us-ascii?Q?jZE2bJEZ19YxGspMQUKz1qPata5jhUz5KjcswKu6R0PhTHMjx5b5G84StTJT?=
 =?us-ascii?Q?kykj3UQYlMUBfl5Ovf9hgMlAmNBhXS+S1J2dHOopmS/tZ0s7my/K+aIprw7q?=
 =?us-ascii?Q?2iFJ9QHPcERKwPZVqO5gHhB6e33GIz9iT8ekhfj6nKazTF9qeGplRH9TVB/l?=
 =?us-ascii?Q?Alo8rA0lxEJePzkg8K6MRNF8319RmzJdXY8G2wYS3zSTOry+aqMIXsHPeoAY?=
 =?us-ascii?Q?WzAQK+IwEPgEv5bRNcCXNps4ON0/LJzb0lgBj+QVNNylwL8CcCD67iz7jLXL?=
 =?us-ascii?Q?Dtg3fwCotOIp/JsTCxqspOJYKnmgSxBb+fhPvTLjeb0NA9l1Gu+t9fAalPow?=
 =?us-ascii?Q?bQORQnUtAqCWbyoGtQc4sFF+TbZdBx/E5jCOrgW1PTHS0JNtWpC9Bd8Ha1S/?=
 =?us-ascii?Q?D9C0kZw7KgVc3zhpwYmLmCN0mmbihvFMoa6FfLxCFsby1UXOOrXXf4R3YyH/?=
 =?us-ascii?Q?oxie0WiQmFCl/0XX43A56LX/stQtHO8BNx3eXADNxiGm66B7zDQR0pu18eKC?=
 =?us-ascii?Q?LFP0ax+ANSvd00DspqglZG29U3Zi9DyAjP41emAGikTUBY6NB7X5PoVAO98t?=
 =?us-ascii?Q?YRgDVnjr/5JjjAB2uS1lJ4aocpf5gRykqE/nIyAmbYLptEwSA7uIMEwB4yMP?=
 =?us-ascii?Q?q5KL1yi71L50bJE4TI9yy77o9bri9oIB8FbPVqmCOlkqw2ZRphgzsjiV7pyi?=
 =?us-ascii?Q?AfZ9d/adzct/lhKKF0W1IjXAVn1XovWPZKEMziqgIErtRzYVTu/wC/EPSUZR?=
 =?us-ascii?Q?eNlm2byhkbovH2gq2JGztBV7W/S6iAJ3oO0SupERZq8VR8qcd6DAp?=
X-Microsoft-Antispam-Message-Info: HYYcNTZlJIKiE4PJ0d3vy88H6K076Y1/k8s6yYSHFzIb1fF9eQ+wADjg2lRAoFIc/VDrT7qI6mkTH0HOTYqQFEMcE8acmYRGP7IOLxt733h6ZVxZ17yH3ZHZPe+iIY7t35qThev+eTD3SMv7m/ZukL2UNaN2AKVoWtDn90Jkpb7UkVtUaCgrd0oktFYwEV1K
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:1P8EERhI91QdLxTzgapxMRyRTr8Rx3cLfmMUW1DGlhO898Rj2LZCbeOlsq4BI136iMYhat5KasVM1KCX6KVfBjWlyr3tR3EBLMF12V+CBtLURtcPMKIP/lXfcLv0FU3dKVfUIN6VcUMW7VK7YrOMkjC1opl04kR+IgqluyYH4nJS249KvVVRz/qN19YqfZj4O0OGUihClg+DAKTrFRICpj0zb9W5n4EHOOpzKHTd1XTlYcb+Hvu6kExLHAhUO2eNZGcVMw3PyndviIRwzd048FaKloTZsycXdCSHOOmk3xq3YFqU861Haf/U6Fp97eLOYg65zoOjHg7Sa9rKB8+Ot/gQJ5eHn2DKEVxOV6xgzkHndylEhTOk4we9uZhxZuuEvgEI7MubcZXreA+p+ehXkrFk585GQisZktdt0I7m58tGLgl23S8qW1YGZFuGVcnsp+9Dp40enAxpM6dec4/WmA==;5:D3ylz+qsFjWVwBKV5e9pidZNIBbcKbo3TbOXseTkvww8taJ24Tq0bDflTARcJL1Tj2PsIJpcByTA2Va00vnECjiGMJsEDmwhTJiZpyiVCC1KmW4BgRXF0sYU+vD1wXhVoXXYrOmKLXZDTO9b7ZVLkklStU+JB4+YDEjlL9eStoM=;24:t3S32qp/pPYSh8lOWfmQNkq9tjOKVdPi3D70YvD5L7s+vipmwPkDZaSa4Xq4BttnwfotcpAQKvjhQgqS9jaTn2H0weY+EGoEnggnvVtyQf8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:rqeCuE1A0xq7y39Wz5ZngesRRmBV2lGmzOkQx43NyFlytIkYc34IQHLlKp6oS+4K70xUGQkDMb1Y5Zir0nk8XnAuwphxL/JvbvB8MI3ik+cGlaLBjY9dC6eM+vrNe9MPVFqHYbU3x37Y2lt21xGdsKymC6C4ufoN0+nA4H2GmrnMQNiJiFAkOVDTHah/KhoF2Jci8hVdNyXFp4G2ia5zSJl4Fx6V5pINLNSKRIQm2GxPYX/+Mk2da84sw2/yDrlN
X-MS-Office365-Filtering-Correlation-Id: a6e76355-38a9-4b10-cc5c-08d5abc5aafc
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:58.4643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e76355-38a9-4b10-cc5c-08d5abc5aafc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unused.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 3 +--
 include/drm/drm_bridge.h     | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 67147673fdeb..9f023bd84d56 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -365,8 +365,7 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list) {
-		if ((bridge->owner && bridge->owner->of_node == np) ||
-		    bridge->of_node == np) {
+		if (bridge->owner->of_node == np) {
 			mutex_unlock(&bridge_lock);
 			return bridge;
 		}
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index c28a75ad0ae2..3bc659f3e7d2 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -258,7 +258,6 @@ struct drm_bridge_timings {
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
- * @of_node: device node pointer to the bridge
  * @list: to keep track of all added bridges
  * @timings: the timing specification for the bridge, if any (may
  * be NULL)
@@ -270,9 +269,6 @@ struct drm_bridge {
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
-#ifdef CONFIG_OF
-	struct device_node *of_node;
-#endif
 	struct list_head list;
 	const struct drm_bridge_timings *timings;
 
-- 
2.11.0

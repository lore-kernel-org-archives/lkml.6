Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeEDNyD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:54:03 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com ([40.107.2.116]:14176
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751756AbeEDNxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:55 -0400
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
Subject: [PATCH v2 26/26] drm/bridge: establish a link between the bridge supplier and consumer
Date: Fri,  4 May 2018 15:52:12 +0200
Message-Id: <20180504135212.26977-27-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:h/EL09aUjDZaZjsfyhhDyMJk/7+F39FKubOM2AtQ+PDGk52dll8gaNXW7/Y/1ywkP7AueTutTtWrUD9+Q3pHwT/ejm2JjMsZL/Ok+8EYSTOyz5ocghqmUbqjs7JGggo/38UxRvxka+I8zDuC8DDO9NdizG0np2czmYJbwU5aYX24dgIWfXqMiheR8Z3xnsRJkErvmbqVLxvjVCN0+QZ/7wnp5E78i5oUZqbhdMgmoB8HLyn0qjPsGW6u2pFAGVJm;25:ieW76aSwOiutPc4IkO7JAXu6icgCwkfNlgWSnV0GRxAQOQ/OdI0X7VBnVLYle+UOyfDr7kY5gbGzveXWdlGakCdunhMeqKrZ6CmCz5nCekgN3ijAp8lstqMNPFYaKR0AgFLZF/BULXLvbpr+5utrzNn2010TfOCYQlCUbSINjsTNUc9sof0cNejd8GaP9uSwH03RvGM+gPbCp9Cs3AWpyt6onj6BMKHQZOr5a/8/3vwhDvmPKgZLHeiZMP1ZPuoXOQeJfMulWwG8xpUTu8ou6oG230eKfjInTYvOdeGGV6fmAWViZ/LxBhTkFkP5SGH5leZKzz/AoxdPwQKaBsIt+Q==;31:ti6GUcWnxq+0NCLe7IEWOSttIw66tV5Ys0UgrWjR2wEVt2U7NObnHbt+ACzUQnqOmyeM1cW5+4eRNVfvzpqmSs9ZbCqWDe/KRHBiqFVcaqtyUIR9sAZQmkBbQFoesU1+1q05YUBMNyzmn1Y3nhyw7Nw/zOMaoR4l+uHc2iEqJhbgX/3MUfWxyqomrOQJRbPbFYNYDbSdyecyyTpIZwpm/EyJMfkcqlztEPQzq375KC4=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769B5C9F8BD32F3BBC0E270BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:7h21nB+eEtmQQQ6bXtL6V3+PpY4+UEiS2ja9oGx9+Fs8hw+lrpfNYrJ8cuLwRUGjuDmww8ndEnrmTO7cwOfV0sLXOOyp/3TvPCeP29oeiSFz6htJ+EkuNbJ3bHb3XEWrpCZ4rt8uTCqYYR24rmqC7e+CFB5/Wtb7noFFAmuznLMpR8Pz07TZs6547XoLpRLGJtrtfVVjLwhNJuXRhdarfcAkR+iyAMs6+Lt+Y0xyn/ta8zuiFs6Iw/zY60EunyMofGAsWUWhsGLg7bwEmQUyNg==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(39060400002)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(5890100001)(106356001)(478600001)(11346002)(575784001)(486006)(446003)(36756003)(25786009)(51416003)(476003)(7406005)(956004)(105586002)(2616005)(7416002)(66066001)(6512007)(186003)(26005)(47776003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:zNOFy6FVuiMFFpQNmhZ65YYhQ9jHfYRxEVWMA+s?=
 =?us-ascii?Q?sjtcLAMUJEJV0WLWnVQMh3ZRw3T0D3hPV87eUU/SG241LcmrVZQeWykESpXN?=
 =?us-ascii?Q?/8esDzq6jsYqoy67m3zAlyvii4BqJsq0xxcLiA40jdZugHhiku/ySoyEBm6X?=
 =?us-ascii?Q?TiQziP/t9x6OGG0BxGc4eME/69PIb+82ulZ6NwefqVdS4PHe/ok0C2ir7f+q?=
 =?us-ascii?Q?qXB5mh9lWO338Bmoi1mT1C2JZS0n6UBXvqN/qDuLHbj0BSR9GXw1ucddAkg4?=
 =?us-ascii?Q?OXBfXiUTtDooc0uj3GmGfLdVNMw6ZUGqePjD3evPc4uVAYRmbZTI/MLtqK6/?=
 =?us-ascii?Q?BDJ4ts4wNOR8EKK9tlumARd7apNze/D3wMWlubz4+0Cdi91l81ieW1tJX9df?=
 =?us-ascii?Q?HbwWN74SHKpRoS9RCTxblDi488LCb7hcz6o0mK0DuUIsrPMIH/6mZGVMDkkI?=
 =?us-ascii?Q?5KrnWvx1BdbHrYQ7/GYYdeCu/53C0Mlk9fbUpGUY1HZkA1EOmZgY8DUC2R1A?=
 =?us-ascii?Q?ZeggCjxCVRneWO8dPnb4MUCs9PTn6f4BFzuwilS5jqTSBfKSq36MqEFYWnu2?=
 =?us-ascii?Q?hWmX/3tuTOzLijuf6UULY4/MavsDBLWwK/WkxHA7JxEYlEiWlKPNQzYVdB9Y?=
 =?us-ascii?Q?VoBxOQB6QG0e98tHAkT8Xxc5zoc8X9WRIaiZfPLmGG4jf94DlyV+OGQOtskX?=
 =?us-ascii?Q?2/137N6DfFQUri+PTV/xpMsm9CIC+ETd55OnDEEvYBm+b6Z7xaLA+0kFUifz?=
 =?us-ascii?Q?iLrL5AJnKIuTEyUe3zgYQK47T7406h3hR/yL0f6sxIgJSOVrro07n1KsiNXX?=
 =?us-ascii?Q?dQiB0EseYFO/JnTG4Vr+B4+p3/xVXBxWXDYeflEdB7d9vZEYneLveAE/2Q/X?=
 =?us-ascii?Q?+1X1Gen+lnJj5DXSdx2JkXW0rM7gXVmHGA63vrvuzqqGToeZpfCRC2EpG/cw?=
 =?us-ascii?Q?J0/jHHwlf3gvIJqwHcJs1E1OtlePL/6vaiuF8L2G1fX1LhOiN6joauqZaGqm?=
 =?us-ascii?Q?49sm5urpUwqWFhiURtRr3YCL37eZGtLP/hQwpCANclp2vlMbYBMJVcbBHDQT?=
 =?us-ascii?Q?6aoO9t2P/4/P5JOUUsyZX2ciBHsZDoWJJ1FJadZD3G07GyAFi4pGHq3KD361?=
 =?us-ascii?Q?BpeSAaEOYXIgIpArzXaKtaNiCrhfof7jSnOiWNni2WccZTz42F2FNnVwElrT?=
 =?us-ascii?Q?mgnuihzUoJZS3tNRb0b0t350LeiM6yMPtq9OQ2ytN0BL8ukdjWPZDM9cadtG?=
 =?us-ascii?Q?vJFZiuWmQkvjUphkbYXrpcBsZQ9e/7owqvYI9JaU7kS/JqDw5l2ZMOfK1rxs?=
 =?us-ascii?Q?6vF+Bxv7bdD4iZp2wCFi3hTzXiERo77mZS4Cv4F3DnXc4wDo6aHX5l39Xsbc?=
 =?us-ascii?Q?/pjavvhcTezd56OFQ/yp3jjayQ/SwCvliE4FS6pV/OKUDxykzPEeCWZtxjrp?=
 =?us-ascii?Q?kvp3RbxYmzpCUbb8j42Hgg6m6LITgtd0=3D?=
X-Microsoft-Antispam-Message-Info: gDeOIpxORQR+hHyJQJvJS/OIa3kKlg26W/Ji4jviX77vX8O6DLCTFvmSIPYo+gnpFTjGxuZHAm/b6nn2z/GKbJXCAxrg680zZGVHztSr864omUdqM+0hMa551KX/ZbC9YCsP7lB23NZtX1ms3wsY+Khd3uEvO0fCFIvqL6U76xaVZ0PKbbT9KaBj1mV6Obio
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:8K15U9Vf/uZ0DKjT1vszcnh/Fq+qDWQK3ZJ7SjPeofJrLucNi4I7EUBhSQqlFTP+JE/cZpmF6YvXPnzvgYrjEay/hz/MN9shQZ7TSwv6iXEPrZYilIV257TaCDCAthASMGhrJvwM8gBVsvB/ewtTVvsn7kiQ/el+mQagUYpuv9Xmw0qTyt+1OSCz7191PDdfNs2k3ydEvOrpJsDTek4OzffgvdqxPPDP+9hvavN7bONXL3aFMsoi63zD0BkuhGMPJ9u82N6XaQgka2nTKljrk0+WkXt5s1nUbbDoPjsXD5mft4DiUdiEDbXj8Jhcz6CwnTQ5isjzNgI233GKAsa7qr/VYRYBjmVg07NaIVpq4IQ4qPNhvNM3WcKH+KwAde2KJjYJwC7ohLtBC2ETOIT/uX6RrnrF5Y86XzzDSJfZNmCrRhsXWIv4pb5I2gdnSH8F7MakHGC6VNjH8YqUTyxP2w==;5:dmhyXVAnDG1Jh62aOxuCIaG0PidsZmXiG8ScAwAOqA6Zje2RgxXHAdIUMMrDgFIhykeMdpfvvBlAO5lN9ctKIq9apFXfFG79CIIdpvTIkilCPttTlqYIyMfXLFl7l/DpQc97Gxv4OlZo6qMXyAPLJt14Vqk2jIhEvKQO4gTd/dQ=;24:W/y1XqAqjVDN7S9BPc5dPmIq59nPmkLaD+reUjO0tj/7f7NtnsxIKJLBlqIdRa/PhqogJbPigBC6O6vspsmGWRPUzK2c286akDM+Sp2PCWQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:kDHV7W8yzNovhypVmgwBwj/i8cg6MUCB1BvzBXXfTANNW0QOr5RPjXaZo7jb70Tdq3kDDwWODcOscGYkLUsWwAqYcO++9sMeuJ7a8wFTSaHrGjN89dtLHvG1q/YIMeZqHcR8x8F1IHehuWzk53ELTMu6ovx/cLJYDx4aXUvV+unNUIaLYGQnsGfUtZto4SLDkolkFC66lLYnUiqoKxeqpFmOD1cNTukdUimILbNtOttcnYf1HmaQLnkX4CPcjCQt
X-MS-Office365-Filtering-Correlation-Id: 733b0d75-553f-4e6f-6500-08d5b1c67787
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:48.7057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733b0d75-553f-4e6f-6500-08d5b1c67787
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the bridge supplier is unbound, this will bring the bridge consumer
down along with the bridge. Thus, there will no longer linger any
dangling pointers from the bridge consumer (the drm_device) to some
non-existent bridge supplier.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
 include/drm/drm_bridge.h     |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 78d186b6831b..0259f0a3ff27 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 
 #include <drm/drm_bridge.h>
+#include <drm/drm_device.h>
 #include <drm/drm_encoder.h>
 
 #include "drm_crtc_internal.h"
@@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (bridge->dev)
 		return -EBUSY;
 
+	if (encoder->dev->dev != bridge->odev) {
+		bridge->link = device_link_add(encoder->dev->dev,
+					       bridge->odev, 0);
+		if (!bridge->link) {
+			dev_err(bridge->odev, "failed to link bridge to %s\n",
+				dev_name(encoder->dev->dev));
+			return -EINVAL;
+		}
+	}
+
 	bridge->dev = encoder->dev;
 	bridge->encoder = encoder;
 
 	if (bridge->funcs->attach) {
 		ret = bridge->funcs->attach(bridge);
 		if (ret < 0) {
+			if (bridge->link)
+				device_link_del(bridge->link);
+			bridge->link = NULL;
 			bridge->dev = NULL;
 			bridge->encoder = NULL;
 			return ret;
@@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 
+	if (bridge->link)
+		device_link_del(bridge->link);
+	bridge->link = NULL;
+
 	bridge->dev = NULL;
 }
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index b656e505d11e..804189c63a4c 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -261,6 +261,7 @@ struct drm_bridge_timings {
  * @list: to keep track of all added bridges
  * @timings: the timing specification for the bridge, if any (may
  * be NULL)
+ * @link: drm consumer <-> bridge supplier
  * @funcs: control functions
  * @driver_private: pointer to the bridge driver's internal context
  */
@@ -271,6 +272,7 @@ struct drm_bridge {
 	struct drm_bridge *next;
 	struct list_head list;
 	const struct drm_bridge_timings *timings;
+	struct device_link *link;
 
 	const struct drm_bridge_funcs *funcs;
 	void *driver_private;
-- 
2.11.0

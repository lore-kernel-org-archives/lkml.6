Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeEDNwu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:52:50 -0400
Received: from mail-eopbgr20126.outbound.protection.outlook.com ([40.107.2.126]:49947
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751001AbeEDNwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:52:34 -0400
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
Subject: [PATCH v2 00/26] device link, bridge supplier <-> drm device
Date: Fri,  4 May 2018 15:51:46 +0200
Message-Id: <20180504135212.26977-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::25) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:mjQtCTYh5FXbGY0hvmhctH6i+Sbb3ESpbudCOJoTnvLWegNibJ3jk6yU5i1hsPZyuf9bk6IhDlXk0DNkK+76/nuEB3re9gu8o2V+S0jc6CQ8FhMMflVOwhFuPynjMUYu3a6dy0n6g1M1biLxgtP7L2pHB37WpsO+TS12sPDlAm/nbVDRfUugvElf361oVxvYzSurp9VUf0zoMjqRnVnwHMOqV5Tossdm9+cuYsZ1jxZyzQR+yIFXBC7HMVdXTiVL;25:+U67fcFI4sFJNaG++HStc0zc/+Pw6U9zy0yFN9xVMSTdtksNx5O8+KB4T01mh9Ajo9pTYhLbu+9DoaZL2rzuxV+sGZ5B8XFYuB/vi+rRraUEBT/oYwiV5LrOcUmQV1mPEK9/XYzjnmLDJiiRQUfS7xDU46wau4NTEvbwfxRQ9iNfEy4DiKgLPDJX0mit+Q+GUIMrwmGzQW9xQZHJM0qx92o47AWOMEtQ02Zt7rh39fMK7yNtJbvRalK8gS7Z6Hu5lXd0ozGnt5pbb8Bnu5TnGEkSpnsc4fB3/wgkPGYETkALCI60LDw771dM/OJ+8FvuXZTj0K6GdBtyZxHUzj+PcQ==;31:wEEjzl+VcrSEDvbb/Kf1nLC5cxgH32ZnTpuiEQJhJ7V1hD+SbxeYkigvt5KFfRHgu7G2np+95MbK0pE7zeLYIb8+pRhqxwWjcBpfcZyuZdLvQTMq82NFoMUIru3K1C3PlVN8HsNvzzov0TKVM0awJ9cAcnhwKMpgpjs6IF/3yBzNqOUWLPSumw1CcnnafYaudQQok5Znr1DAg6/EUWT3E7JlWSV1P77p4VZc4B+7l+Y=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769E626C38B86C06F95BE31BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:E0CU+KzEmm+AwS1xMqjYQpFSl3eWg9pJuGV+BNMajRpW+vfH0s2Jvz2z961xATdxlb/CGZWOQSbAUBmh0ja71haQGGBXRcG8bHo6h/7J9Y916IhSo+oQTqlG4dfZBTDlGMMbwxC1Cq5/xEJrQGpt9hNWAyubRhbo38wQog2MXHEdljQ8d0paS2i6Yw0iP9KCsZlBVLJT70nfrh3+ozj7yECvyQVcmij8t/5ViOGUlxnICrxF8KJ/3RcfK5TUvcfkP+Rq6iFag8m0s2fYX9dxaw==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(966005)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(39060400002)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(5890100001)(106356001)(478600001)(486006)(36756003)(25786009)(51416003)(476003)(7406005)(6306002)(956004)(105586002)(2616005)(7416002)(66066001)(6512007)(186003)(26005)(47776003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:nG5V3fEuAGcpdkHVBvwdXw4etEaIQ/4W5ogOekG?=
 =?us-ascii?Q?DfoL8+6VALnXAjAy9GsPD8ej3PzoSBSiWzQ9ibwmx6pOj5RvTRyKdbgiJLr5?=
 =?us-ascii?Q?SGDKkDP1QqtNBK6QZxci9zcKpmF5sG1IezDYGqgrqJ4Le+xhdOBkELoU7xDu?=
 =?us-ascii?Q?aXvxnfvF/6ExyP2yZaHlGEJd0lE+y2lfuaJB0Hs7mD80YIlsLNZyBC2he2Jj?=
 =?us-ascii?Q?vLDj72hGvgI6DJ4Ggt04r1Ah0Q2IOc669IoQr6feJyDzt6LVSa/b1SGHOz7O?=
 =?us-ascii?Q?2HvPMPseS/c8jcHTXpFWi3BbvsZ1MTFFVoEqbSyYsq+bOSeSiIW7H59jWf8Y?=
 =?us-ascii?Q?0C/mg6vb6JSI1tbucRAepXExRnMnbxOE3ZNs/kjiIoi82NEwSZCX1ybDAvWq?=
 =?us-ascii?Q?7huv6XANKsR446fF7bWVNFoECxVSX24rkXLP6c54Hncn6rnMuG2QZpS6/t1k?=
 =?us-ascii?Q?dlp8uWd4JEKFDK0G8aK3XiFjeLsjY3WwP3kNLeiUznMU7Iehf3tSyQpMkz7P?=
 =?us-ascii?Q?dzD8oQE0ONHPPE89CtDF8cEq+egXh+Do2EElVw8a+T3iD3v9AfIjb581GHfW?=
 =?us-ascii?Q?Fh0HY+yatL7z4L+/GOkKfotgq5VcXhBsbt1lvQUkkfFJ9IbZseTEdFJd43t7?=
 =?us-ascii?Q?jrtgvm5xawsaGftWYyZipLQ+KiCfxYK5ZZ8N2G1AjpXHrdib1PcUY0FScwv+?=
 =?us-ascii?Q?zbHFwHtDWRleezdU8nprAjCVkrBnE1F00Tt4QDfTcbbiZ6OoaIfQPzO1Ny85?=
 =?us-ascii?Q?k/icAD1XRjj96LaTeiP4mgF1j/azipY0nro5bm7qVdXCZD4X4KbSwZEa9mxD?=
 =?us-ascii?Q?++SOK3cDZd33m/rDKOfiVN3m8ijbHGumy6fmBwZ7G9Jq06pVRepMfffuoMJU?=
 =?us-ascii?Q?ncvzbDwPZ991ZzSh/se89DjxDv/pli7P8ZWl7b43lmMOvMOlj9mg8Lqm6A+a?=
 =?us-ascii?Q?4252/5nidIu14slvQR8FIOH4x+Oe6JgNj1gdJuguNg4J0lSc/xhGdRqVQhIs?=
 =?us-ascii?Q?MVfh00748O3KO89BZ8J0hFM826Yip6pP5w70pJ24/tyMGT0QaGv1+MIRpd0t?=
 =?us-ascii?Q?mmtBCe1k1FRYNYX2VfcNURvstQGO7obPEnVxnqxgLc30G0f+oR0ouKeHN6zf?=
 =?us-ascii?Q?R/zRb7vWCpjMULa6nc1eDYmCD46xqsOqP8FpoHs1K/b47zMRepCKSTB7K3g0?=
 =?us-ascii?Q?wopGic4Zpx2LNwemd14/VcO5iUUfbQkV0lP6fH2LBRBH/HSqH4ZJPIU3spJ5?=
 =?us-ascii?Q?7CHcAzdYlE/tfOAnCfIioZFxa7OGQASZuRwUb+fhglORe51BYSfgRF4s7Bg9?=
 =?us-ascii?Q?g85M+HSL2FOP9cLTXtGRtYb65I3hSH8ppPxYzimVgM5M+tNMtlKJluzvrho3?=
 =?us-ascii?Q?O1lWd8hjwBXZdENmU5Bu6auOSj9I=3D?=
X-Microsoft-Antispam-Message-Info: 1rKsCmHur+xwm9mvq/pCjIy6Oi8k47Y2nnMgGRmR11L1ysxE1ygQLJo+8LMWPSzJM7KBKPG6ocFqmdjtFaikVRwUmlU4OqPBMDWDwa6hY+Ifldn3PPM6aANlAP4uVz4ZXsJTv4pY0eIgifDPdLSCWy+V8PsU9UbfrpSHwsA2jJF50riuk+t/6ILqGIo59BzX
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:jXueg8jvc+D9y0s49IODhTCXmYbfHd70zTLbnqtPtIq+9fausNIxfDjZgRZQkuviPCTl6RhY+Z+SBbiPPKX1mdV44b6le5xXpOblDVsSrcPoxOjPmHl13i8JG7bQk1xnNeOJ2DSqAPoGwRp0TPzGkO4CsTLuQrp3gUzFETE5A/zqPTdgAS+/FeRPuRCY2rPTqnvgg6DuaO6PNAvAkGqreyuz4MMft5SiFRfZfN/BUSkJgUA9WY+Q3F7xvIM3B/G3WcGeSIR32gLAwbzTpRjxTGDn04j3PWkYr9mPfh8la+7RlCF58hxwtOGQXvouddhgCyl1PXSADtNt/yrhE2AM3pYBNh2tZiDwIYGagYMtidXOx2puKRqKQUTYuG2GNiA3w/SrBHiPhRkz3ZYkLkgn6gQYKdLaZ6DN9BSp7aMnX48gRPJyPMq2StihNKHmt9OcRwyTxbEMrkYFQCIK9E8isw==;5:K7FKYAvXN58TG9ZxG270Hqw9O/jpC2djFL04HFNmPRsd2GOpR41QrzTtX9m9JuqpQY0l7hnlWFfVH/YUjzGFf8sbrYRgUfr3rX4RuhFImMv/aOxDtYW2b5NrAymIrYHQduFfuSe0ocLXYm/D/SJhg8s6kyETKg8Sd18wLceBH30=;24:IgnQcpPhW6Vb4+5ktt+ELFOU/Ln/t8Q54pC+1rzVFN1p3BN5jsSYnN946eA06XLtNTml+ggP3psiYZHBZUf42g/Pn/OrTfGiHlFCEGkY6QU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:XCOz2VuEFjaW01J7DG5zvBEzGyto5D6LZDxdntqJL8nuDIbTZh5HuzNjmSzyVfFgC8bWGM9t5jS4UGxfj2McvfvrHmzKkhF085lklPmCoyo5qFzYP3LUoJsrOZZPek3L/SghyY2gi6IeI4XPtvZqVmrgScQ2WtZtXJxNKeFhC2jKxFdYj38n4Zl0WwmtKWcMbsZjqP62xt0QFZ8MAloxpQBs/A8X7eA8JvHWq0w0VjsFK46inDNjJo4kA2qdAqm7
X-MS-Office365-Filtering-Correlation-Id: d25b3d56-6da5-4df9-561e-08d5b1c64679
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:52:26.4052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25b3d56-6da5-4df9-561e-08d5b1c64679
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It was noted by Russel King [1] that bridges (not using components)
might disappear unexpectedly if the owner of the bridge was unbound.
Jyri Sarha had previously noted the same thing with panels [2]. Jyri
came up with using device links to resolve the panel issue, which
was also my (independent) reaction to the note from Russel.

This series builds up to the addition of that link in the last
patch, but in my opinion the other 25 patches do have merit on their
own.

The last patch needs testing, while the others look trivial. Jyri, are
you able to test? That said, I might have missed some subtlety.

Oh and the reason I'm pushing this is of course so that the issue
noted by Russel in [1] is addressed which in turn means that the
tda998x bridge driver can be patched according to that series without
objection (hopefully) and then used from the atmel-hlcdc driver (and
other drivers that are not componentized).

Changes since v1    https://lkml.org/lkml/2018/4/26/1018

- rename .owner to .odev to not get mixed up with the module owner.
- added patches for new recent drivers thc63lvd1024 and cdns-dsi
- fix for problem in the rockchip_lvds driver reported by 0day
- added a WARN in drm_bridge_add if there is no .odev owner device

I did *not*:
- add any ack from Daniel since he suggested "pdev", and I ended up
  with "odev" in the rename since I disliked "pdev" about as much
  as "owner".
- add any port id. The current .of_node (that this series removes)
  does not identify the port, so that problem seems orthogonal
  to me.

Cheers,
Peter

[1] https://lkml.org/lkml/2018/4/23/769
[2] https://www.spinics.net/lists/dri-devel/msg174275.html

Peter Rosin (26):
  drm/bridge: allow optionally specifying an owner .odev device
  drm/bridge: adv7511: provide an owner .odev device
  drm/bridge/analogix: core: specify the owner .odev of the bridge
  drm/bridge: analogix-anx78xx: provide an owner .odev device
  drm/bridge: cdns-dsi: provide an owner .odev device
  drm/bridge: vga-dac: provide an owner .odev device
  drm/bridge: lvds-encoder: provide an owner .odev device
  drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an owner .odev
    device
  drm/bridge: nxp-ptn3460: provide an owner .odev device
  drm/bridge: panel: provide an owner .odev device
  drm/bridge: ps8622: provide an owner .odev device
  drm/bridge: sii902x: provide an owner .odev device
  drm/bridge: sii9234: provide an owner .odev device
  drm/bridge: sii8620: provide an owner .odev device
  drm/bridge: synopsys: provide an owner .odev device for the bridges
  drm/bridge: tc358767: provide an owner .odev device
  drm/bridge: thc63lvd1024: provide an owner .odev device
  drm/bridge: ti-tfp410: provide an owner .odev device
  drm/exynos: mic: provide an owner .odev device for the bridge
  drm/mediatek: hdmi: provide an owner .odev device for the bridge
  drm/msm: specify the owner .odev of the bridges
  drm/rcar-du: lvds: provide an owner .odev device for the bridge
  drm/sti: provide an owner .odev device for the bridges
  drm/bridge: remove the .of_node member
  drm/bridge: require the owner .odev to be filled in on
    drm_bridge_add/attach
  drm/bridge: establish a link between the bridge supplier and consumer

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  2 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.c          |  5 +----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  1 +
 drivers/gpu/drm/bridge/cdns-dsi.c                  |  2 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |  2 +-
 drivers/gpu/drm/bridge/lvds-encoder.c              |  2 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |  2 +-
 drivers/gpu/drm/bridge/panel.c                     |  4 +---
 drivers/gpu/drm/bridge/parade-ps8622.c             |  2 +-
 drivers/gpu/drm/bridge/sii902x.c                   |  2 +-
 drivers/gpu/drm/bridge/sii9234.c                   |  2 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  4 +---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  4 +---
 drivers/gpu/drm/bridge/tc358767.c                  |  2 +-
 drivers/gpu/drm/bridge/thc63lvd1024.c              |  2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
 drivers/gpu/drm/drm_bridge.c                       | 26 +++++++++++++++++++++-
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |  2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  2 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  1 +
 drivers/gpu/drm/msm/edp/edp_bridge.c               |  1 +
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  1 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |  2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |  2 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |  1 +
 drivers/gpu/drm/sti/sti_hdmi.c                     |  1 +
 include/drm/drm_bridge.h                           |  8 +++----
 30 files changed, 57 insertions(+), 36 deletions(-)

-- 
2.11.0

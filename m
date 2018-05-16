Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeEPKPj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:15:39 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:21089
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752289AbeEPKPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
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
Subject: [PATCH v3 00/26] device link, bridge supplier <-> drm device
Date: Wed, 16 May 2018 12:14:44 +0200
Message-Id: <20180516101510.13215-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:WmNZn8+KS3VXo5YMTPTXjIIT1o/T5GMDdDeO3VmBCfAuzeJ3HhU2cu9pOHl25oR1LZsxycMbwv5VgqSD9aDMY3fBQf+0A0bz7WJ3fgKqGsNLliJB6lwfx2LO6XDlaXMEbuvfFIjpYrCBKij7S9PjO2Sfit+aHDeGPRPxMiWy2URsHnOlHw3KfThX/dXLywaiWXpbKL1rZbh76T0KdcN0fJr6AlQQv2Fnk26bWMu7gw+yXqxwExUIbYU2yl1p+ZCT;25:TcBfs/oS7pOd8C9z/yZZ8anbjGArs5EKw9rRjFFlzltxv6mYdXaLNQcwAnA711ecExZGdU8jQ9vzD3zNgVUBMcVxn7PEqLgO5kE6qyJT5KdkRy3OqQ2W/e3wleFqnbY7Kj0yun0kCLZTWd2Eu3XC5YaorOO3klgsD5Wbfsni5BcGmo4la5cB8WVCUZgZ70ByZnB7DzoQcYoxlKPYnD/HAdO5EsCR3UrYvHjvfyQEdqaByUGKk3O0XdyPRJimWmLszZVVljwLqB5tcn+nc+XazP5iKma2S+fqHd5FkF/qT0XyKj7z6HikfmAXMy6DbPDfPIVDGqI7w1Dw1DtWQslyTQ==;31:jHDTkuarbJHmaZc7nZHhBs2X6azanMxVD/NwIlNeXu30XK8Mqr4kcpLwWBe3TSV0EkvM4sb1N7zkK3w6KBWC6N9K3RqO+EVgbQeeffvIF5HXLvDXy2NK6HokgE1CaXbVcIFKphOutdj3sYPg9u1DMVEFRCVcSL8RiUbZqIhIWArNDx1BwfXYD21EhvLEVYQy7OqtnkviqbtVR0u+9XXIDbqu7LcZr7GA0N/5u82/4eg=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27729BBC20C6B8236A3A4A35BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:fL1QAwF8oZ8OUTKxYfBCOAt8tsS600+Da5JdaZ6LGhjxW3+BGac7X698md661mDo1A1XoDXjuDgDimQfi1N+rEFYN1dsDjGaGbt7BMkOV4TeBn/ah4zVpQmXNjhgFx3LYZ0Y/F1+vS0+qaTKo0K7qITc1sqmZ2skdppZU2vn9rn0FapChOHpEsva6c2LMJ6U6oRxo5LyNnrWW/GFtVnQmrtiV+1U7VgpDuj0wMwIOWVMV+u310d0szYHbFid15WB65EC43AWlViKAz0zXLTw9w==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39830400003)(396003)(346002)(376002)(366004)(189003)(199004)(86362001)(7416002)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(7406005)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(966005)(2361001)(7736002)(50226002)(6306002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(66066001)(5660300001)(39060400002)(5890100001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(4326008)(486006)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:nmH79X+bNdRRlyqHRTEQ8SGququrESUZDZ3Z2ax?=
 =?us-ascii?Q?QAkzZO4zqPb3Bjvf6BdnV88+B/39nOqd1roaR5VdOdivqMzpy/0WntYupkti?=
 =?us-ascii?Q?K1fgebva7ZPWjJGLYT46DvDcwGTbEwV26U5SvSx3QhJ2RuQ/1ENyDos/yy+9?=
 =?us-ascii?Q?7s2f274Tj3pJbTfZSU46VMD7aahWhYVjQSx+h053gXLk9all+pvv781pkTYJ?=
 =?us-ascii?Q?jc25yp8MhBlhVmzDsQ1+EhcO5DYAHsELrD24tstj4tW5G1N0uBanDQDczr78?=
 =?us-ascii?Q?dtMHfCu7wOmCqjuekh2zwpH81L35zjUd4CkJ+UrIE9hiIrfVVOktdmNBoWb3?=
 =?us-ascii?Q?bNklIVS9Ey5TmbG5+K90NQftWoZDRblgC2sn81sAKTdm4V+LB+uZs6c85TBu?=
 =?us-ascii?Q?/GMb6znPgqE+UXwBpu2Zb3aTnxSRG9E3SmfWK3mdXWRhS4ndRW9En5wBRD03?=
 =?us-ascii?Q?Jcf+USA0E62O/2ydc6Wifeyw+7s+9B9hqmoHFxtsJRMVH7j2pnlKah7aNKbG?=
 =?us-ascii?Q?NLkD7ycnfyez4vfxkXL2oxN64C+V5NkHp1aHWlhdeeej4vezB8KlrnDT2hCX?=
 =?us-ascii?Q?xi/cCwjMaO0whhYWvGyqwtQUAM52YgSGRJGNE2dCZsSx0XD9QA8sR2IAmft+?=
 =?us-ascii?Q?4ll26Nwb9gZaNvHc+7ZoV35L7IJssnz1J80XdkuHYLAWFOmKKYObQvY/yghb?=
 =?us-ascii?Q?4/N8oAepT8GdhJv8yBY+ecqaiyUaWtm8uiJtGFdMCEBnOZwVyAIoONy/jtuW?=
 =?us-ascii?Q?qm1x5nXr7pJGbrBOxqEVVdpoqevVJVR5HjyaOEwff7Lx6j/B4kVLSZV8OkJ2?=
 =?us-ascii?Q?pZluUCDJyUf+RyFh1OnNm8t8Wk3pCpdThzYJwV3NggqDRiLR/KOjBiJJCBAb?=
 =?us-ascii?Q?duVe5Fmr0UC+XbwwMM6JnPj7aKTeIFQsPi1fE6tpQtBxWAZ7HyPyCX+YDx2z?=
 =?us-ascii?Q?iciDCc2EJRjMlWypSDniwfEEFdpgSB/g4ZTjoFtnOp+Pvjw06KTpGNNCRtPV?=
 =?us-ascii?Q?HGBW/ornemhPes88aBzYe6z+glOFB5w70ARAKsySaKF+Cu0GjfyL3KO7YjbA?=
 =?us-ascii?Q?a5Qd8tt2jNno9JTV1kImFvf6FXmrzd4+RrU8QLfQTKNXZp5Sxste62njEDFe?=
 =?us-ascii?Q?hfO0xKoi4P3MdspKtXGV4YZ0+ode992RJcqGMJ/vdlNfxfoq7GTtf31ivqM3?=
 =?us-ascii?Q?RJECS6rB27BQ8jSBt0ggydGEMmrxMXSeQ4QQDThUa72ACx33wFr3vcZNT4uq?=
 =?us-ascii?Q?AHuRC6lBGaU/4FNp5UBp5Gj3JHI9Rj7KG0XyFpeQ2A0TLu2mhUsUHOb9ANxr?=
 =?us-ascii?Q?56oSV0NSRfzFOlVnr5DWs7pDqP5cyE2bBfvF6owGhhMXSvCnqYsp93QNt7Il?=
 =?us-ascii?Q?6QTzbpcdeX06BPKGHY5sR8jEL3nE=3D?=
X-Microsoft-Antispam-Message-Info: Eo7+xqQr7RDTFCUE2E+jgfuItYsy60679N7OEpmy6Q6f2J2aSbSfEz1kXdG6X6Z878O9vDgsjBDVR45e+Dg5AB/qWRnkYkNx5R3Ab1j5VSP4lz1m08mk89hRvD9tS6WXFKsLqrTkL3QpFNnfa0UrTBZdJvcuMxk3VoVRIENTBdbVO/e0mIUCqtcVks3k5sBG
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:+123/vEE3d+HNmuaAqQ8XTSAX0oaFKA4scpxuhY6Kc/3Q5VGU+ff76z8crYS7V8hjcvfiGPHKzjg7v1GfKBI2+QJBh3jyyq7JTikVwQ3Y1SYYVX1QMw/+FspUBcGJEVKwwrcgP8zlRbhAJgl/X0Uhtl+f1SS8067gDfrojFeMfoKcYS96cEtTRluFHRyDFmCW8DNdI7OpFtUDQTulMmuyDEgDfE8z1FI5yx1zrrBCjSfBPWghjDKD3tIzh67ZKC9J6exYs36hZdD3GHaLUTbU+1XSlA2KCVphekSLULhunFIrGqECION53jMSDp0KWAwCQPUl0qXiXVxuz9A1E71VooQirkRfVPYrzFT+X0KlXFtMMy3bxknUorCY81PPHg9wAXB+uY8FXMgURDg1Ys1ust1HU3Px89p6FyH/Auw1G/lwF0SQS4t5W98kR8zoj5gUf1B9wlu21nirbauY3gjog==;5:nA0e+J7LevmBWraLX0xqbTHK3MW3EQROW2MWfbznhYW5EYVkHesIvui4pSJ3OdtXgJ2SHnD9tVzM7DctsoaiY0wlLQSWr6GLgouufP3JyUVWQIVVb9Abwsw2bsoIcGVNV8iYwj1OjQ0H/lM/RmwCBgPd32goRiDe5zjR23rqp5I=;24:764wRlFIumUn1mV/duPNJXmmrdxfkUSSR5bnz0YuDuoGEbxBek/xT9riJtc3Fm3IH4IEnfRPnBFTSTa3+6/Yg0Tv0fk0Bq0SKOMwBwMohvs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:nGPN0QhIArtgGdSu3X6S/dFAHVEVzvQI/nXx6i1ODaUTRHBo1obo5mWXMzdK7uj16ByWJ0npf+g3wpAx8r/NprrpjSbcsmQHsXNANmzHP+vZ8rcoZQ5OLNA92p0/PhNAn6RonpjrVT4GiRR3MW8Q1Xr8gfzLRdwohAWWEc5TDNt/Pp39qNe7hKPUNmbtoeVgZj/NTeIUKuRD8OlTsDNTC3dSmsp/DcUsqZo+oGuOTP2ki40nm+5S2HMv427g6Z1L
X-MS-Office365-Filtering-Correlation-Id: f555cb2f-01ca-4498-b167-08d5bb15f06e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:22.4569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f555cb2f-01ca-4498-b167-08d5bb15f06e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It was noted by Russell King [1] that bridges (not using components)
might disappear unexpectedly if the owner of the bridge was unbound.
Jyri Sarha had previously noted the same thing with panels [2]. Jyri
came up with using device links to resolve the panel issue, which
was also my (independent) reaction to the note from Russell.

This series builds up to the addition of that link in the last
patch, but in my opinion the other 25 patches do have merit on their
own.

The last patch needs testing, while the others look trivial. Jyri, are
you able to test? That said, I might have missed some subtlety.

Oh, and the reason I'm pushing this is of course so that the issue
noted by Russell in [1] is addressed which in turn means that the
tda998x bridge driver can be patched according to that series without
objection (hopefully) and then used from the atmel-hlcdc driver (and
other drivers that are not componentized).

Changes since v2    https://lkml.org/lkml/2018/5/4/443

- Russell King spells his name this way. Sorry!
- Add review tag from Andrzej Hajda (patches 1, 25 and 26).
- Add ack tag from Daniel Vetter (patches 1, 24, 25 and 26).
- Mention the interaction with the rockchip_lvds driver in the
  commit message for patch 1.
- Change the comment for the new @link member in patch 26, so that a
  symmetric relationchip between cunsumer/supplier isn't implied.

Changes since v1    https://lkml.org/lkml/2018/4/26/1018

- rename .owner to .odev to not get mixed up with the module owner.
- added patches for new recent drivers thc63lvd1024 and cdns-dsi
- fix for problem in the rockchip_lvds driver reported by 0day
- added a WARN in drm_bridge_add if there is no .odev owner device

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

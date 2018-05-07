Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeEGN4N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:56:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52119 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbeEGN4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:56:06 -0400
X-Google-Smtp-Source: AB8JxZoWqzWXC5m0j2r8+IvtUZ/yaSqPxgk7JLHqBoFdNQ2b0Cs6h71miIcNY+pnKnxH64wQd5a1NQ==
Date: Mon, 7 May 2018 15:56:01 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
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
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 00/26] device link, bridge supplier <-> drm device
Message-ID: <20180507135601.GJ12521@phenom.ffwll.local>
Mail-Followup-To: Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
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
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Jyri Sarha <jsarha@ti.com>
References: <20180504135212.26977-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504135212.26977-1-peda@axentia.se>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 03:51:46PM +0200, Peter Rosin wrote:
> Hi!
> 
> It was noted by Russel King [1] that bridges (not using components)
> might disappear unexpectedly if the owner of the bridge was unbound.
> Jyri Sarha had previously noted the same thing with panels [2]. Jyri
> came up with using device links to resolve the panel issue, which
> was also my (independent) reaction to the note from Russel.
> 
> This series builds up to the addition of that link in the last
> patch, but in my opinion the other 25 patches do have merit on their
> own.
> 
> The last patch needs testing, while the others look trivial. Jyri, are
> you able to test? That said, I might have missed some subtlety.
> 
> Oh and the reason I'm pushing this is of course so that the issue
> noted by Russel in [1] is addressed which in turn means that the
> tda998x bridge driver can be patched according to that series without
> objection (hopefully) and then used from the atmel-hlcdc driver (and
> other drivers that are not componentized).
> 
> Changes since v1    https://lkml.org/lkml/2018/4/26/1018
> 
> - rename .owner to .odev to not get mixed up with the module owner.
> - added patches for new recent drivers thc63lvd1024 and cdns-dsi
> - fix for problem in the rockchip_lvds driver reported by 0day
> - added a WARN in drm_bridge_add if there is no .odev owner device
> 
> I did *not*:
> - add any ack from Daniel since he suggested "pdev", and I ended up
>   with "odev" in the rename since I disliked "pdev" about as much
>   as "owner".

As long as it's not owner, I'm fine :-) Ack on the idea still holds.

> - add any port id. The current .of_node (that this series removes)
>   does not identify the port, so that problem seems orthogonal
>   to me.

Hm, from my cursory DT/of code reading last week I thought the port is
used to lookup the right node, but there's no port thing on the target for
a phandle? At least that's how current drm_of_find_panel_or_bridge seems
to work ...
-Daniel
> 
> Cheers,
> Peter
> 
> [1] https://lkml.org/lkml/2018/4/23/769
> [2] https://www.spinics.net/lists/dri-devel/msg174275.html
> 
> Peter Rosin (26):
>   drm/bridge: allow optionally specifying an owner .odev device
>   drm/bridge: adv7511: provide an owner .odev device
>   drm/bridge/analogix: core: specify the owner .odev of the bridge
>   drm/bridge: analogix-anx78xx: provide an owner .odev device
>   drm/bridge: cdns-dsi: provide an owner .odev device
>   drm/bridge: vga-dac: provide an owner .odev device
>   drm/bridge: lvds-encoder: provide an owner .odev device
>   drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an owner .odev
>     device
>   drm/bridge: nxp-ptn3460: provide an owner .odev device
>   drm/bridge: panel: provide an owner .odev device
>   drm/bridge: ps8622: provide an owner .odev device
>   drm/bridge: sii902x: provide an owner .odev device
>   drm/bridge: sii9234: provide an owner .odev device
>   drm/bridge: sii8620: provide an owner .odev device
>   drm/bridge: synopsys: provide an owner .odev device for the bridges
>   drm/bridge: tc358767: provide an owner .odev device
>   drm/bridge: thc63lvd1024: provide an owner .odev device
>   drm/bridge: ti-tfp410: provide an owner .odev device
>   drm/exynos: mic: provide an owner .odev device for the bridge
>   drm/mediatek: hdmi: provide an owner .odev device for the bridge
>   drm/msm: specify the owner .odev of the bridges
>   drm/rcar-du: lvds: provide an owner .odev device for the bridge
>   drm/sti: provide an owner .odev device for the bridges
>   drm/bridge: remove the .of_node member
>   drm/bridge: require the owner .odev to be filled in on
>     drm_bridge_add/attach
>   drm/bridge: establish a link between the bridge supplier and consumer
> 
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  2 +-
>  drivers/gpu/drm/bridge/analogix-anx78xx.c          |  5 +----
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  1 +
>  drivers/gpu/drm/bridge/cdns-dsi.c                  |  2 +-
>  drivers/gpu/drm/bridge/dumb-vga-dac.c              |  2 +-
>  drivers/gpu/drm/bridge/lvds-encoder.c              |  2 +-
>  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  2 +-
>  drivers/gpu/drm/bridge/nxp-ptn3460.c               |  2 +-
>  drivers/gpu/drm/bridge/panel.c                     |  4 +---
>  drivers/gpu/drm/bridge/parade-ps8622.c             |  2 +-
>  drivers/gpu/drm/bridge/sii902x.c                   |  2 +-
>  drivers/gpu/drm/bridge/sii9234.c                   |  2 +-
>  drivers/gpu/drm/bridge/sil-sii8620.c               |  2 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  4 +---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  4 +---
>  drivers/gpu/drm/bridge/tc358767.c                  |  2 +-
>  drivers/gpu/drm/bridge/thc63lvd1024.c              |  2 +-
>  drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
>  drivers/gpu/drm/drm_bridge.c                       | 26 +++++++++++++++++++++-
>  drivers/gpu/drm/exynos/exynos_drm_mic.c            |  2 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi.c                |  2 +-
>  drivers/gpu/drm/msm/dsi/dsi_manager.c              |  1 +
>  drivers/gpu/drm/msm/edp/edp_bridge.c               |  1 +
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  1 +
>  drivers/gpu/drm/rcar-du/rcar_lvds.c                |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_lvds.c           |  2 +-
>  drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
>  drivers/gpu/drm/sti/sti_hda.c                      |  1 +
>  drivers/gpu/drm/sti/sti_hdmi.c                     |  1 +
>  include/drm/drm_bridge.h                           |  8 +++----
>  30 files changed, 57 insertions(+), 36 deletions(-)
> 
> -- 
> 2.11.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

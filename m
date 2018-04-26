Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755561AbeDZKnE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:43:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55796 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754559AbeDZKnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:43:00 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, brodkin@synopsys.com,
        linux@armlinux.org.uk, boris.brezillon@bootlin.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, l.stach@pengutronix.de,
        christian.gmeiner@gmail.com, inki.dae@samsung.com,
        jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        stefan@agner.ch, alison.wang@freescale.com,
        z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
        kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, p.zabel@pengutronix.de, ck.hu@mediatek.com,
        matthias.bgg@gmail.com, robdclark@gmail.com, marex@denx.de,
        bskeggs@redhat.com, tomi.valkeinen@ti.com, eric@anholt.net,
        airlied@redhat.com, kraxel@redhat.com, hjc@rock-chips.com,
        heiko@sntech.de, benjamin.gaignard@linaro.org, vincent.abriou@st.com,
        yannick.fertre@st.com, philippe.cornu@st.com,
        maxime.ripard@bootlin.com, wens@csie.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, noralf@tronnes.org, linus.walleij@linaro.org,
        shawnguo@kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, etnaviv@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] drm/core: Remove drm_dev_unref() and it's uses
Date: Thu, 26 Apr 2018 13:43:09 +0300
Message-ID: <2767328.18DNhHKilX@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180426102819.6985-1-vthakkar1994@gmail.com>
References: <20180426102819.6985-1-vthakkar1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishali,

Thank you for the patch.

On Thursday, 26 April 2018 13:28:19 EEST Vaishali Thakkar wrote:
> It's been a while since we introduced drm_dev{get/put} functions
> to replace reference/unreference in drm subsystem for the
> consistency purpose. So, with this patch, let's just replace
> all current use cases of drm_dev_unref() with drm_dev_put and remove
> the function itself.
> 
> Coccinelle was used for mass-patching.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

I love seeing deprecated functions go.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  4 ++--
>  drivers/gpu/drm/arc/arcpgu_drv.c                   |  4 ++--
>  drivers/gpu/drm/armada/armada_drv.c                |  6 +++---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |  4 ++--
>  drivers/gpu/drm/drm_drv.c                          | 13 -------------
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  4 ++--
>  drivers/gpu/drm/exynos/exynos_drm_drv.c            |  4 ++--
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |  4 ++--
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  4 ++--
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |  8 ++++----
>  drivers/gpu/drm/i915/selftests/huge_pages.c        |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_dmabuf.c   |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_object.c   |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_request.c      |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_vma.c          |  2 +-
>  drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c |  2 +-
>  drivers/gpu/drm/imx/imx-drm-core.c                 |  4 ++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  6 +++---
>  drivers/gpu/drm/msm/msm_drv.c                      |  8 ++++----
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |  4 ++--
>  drivers/gpu/drm/nouveau/nouveau_platform.c         |  2 +-
>  drivers/gpu/drm/omapdrm/omap_drv.c                 |  4 ++--
>  drivers/gpu/drm/pl111/pl111_drv.c                  |  4 ++--
>  drivers/gpu/drm/qxl/qxl_drv.c                      |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |  4 ++--
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c           |  4 ++--
>  drivers/gpu/drm/sti/sti_drv.c                      |  8 ++++----
>  drivers/gpu/drm/stm/drv.c                          |  4 ++--
>  drivers/gpu/drm/sun4i/sun4i_drv.c                  |  4 ++--
>  drivers/gpu/drm/tegra/drm.c                        |  4 ++--
>  drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |  6 +++---
>  drivers/gpu/drm/tve200/tve200_drv.c                |  4 ++--
>  drivers/gpu/drm/udl/udl_drv.c                      |  2 +-
>  drivers/gpu/drm/vc4/vc4_drv.c                      |  4 ++--
>  drivers/gpu/drm/vgem/vgem_drv.c                    |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_drm_bus.c           |  2 +-
>  drivers/gpu/drm/zte/zx_drm_drv.c                   |  4 ++--
>  include/drm/drm_drv.h                              |  1 -
>  41 files changed, 73 insertions(+), 87 deletions(-)

-- 
Regards,

Laurent Pinchart

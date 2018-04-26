Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756167AbeDZM5Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:57:24 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41812 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754516AbeDZM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:57:21 -0400
X-Google-Smtp-Source: AB8JxZruNsL2Da9E4EDngTyAJAo6pjb0xrRdQRMqK0vUZfu/KmCzVlIUM/IcvUGnwQsDVIv6C2TttLQGfsZwjtr61wI=
MIME-Version: 1.0
In-Reply-To: <1556510.Xu6NnhyFGZ@avalon>
References: <20180426102819.6985-1-vthakkar1994@gmail.com> <20180426123615.GA12521@phenom.ffwll.local>
 <1556510.Xu6NnhyFGZ@avalon>
From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Thu, 26 Apr 2018 18:27:18 +0530
Message-ID: <CAK-LDbKxTS-13yC4CQH+fQxTM6_Dw85ftyj7sLHf3yooJwPXOA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/core: Remove drm_dev_unref() and it's uses
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, alexander.deucher@amd.com,
        linux-renesas-soc@vger.kernel.org, alexandre.belloni@bootlin.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        Linus Walleij <linus.walleij@linaro.org>, stefan@agner.ch,
        hjc@rock-chips.com, kraxel@redhat.com,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        nouveau@lists.freedesktop.org,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, David1.Zhou@amd.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        linux-rockchip@lists.infradead.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, linux@armlinux.org.uk,
        krzk@kernel.org, jonathanh@nvidia.com, z.liuxinliang@hisilicon.com,
        maxime.ripard@bootlin.com, kong.kongxinwei@hisilicon.com,
        Kukjin Kim <kgene@kernel.org>, bskeggs@redhat.com,
        linux-arm-msm@vger.kernel.org, CK HU <ck.hu@mediatek.com>,
        airlied@redhat.com, virtualization@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, puck.chen@hisilicon.com,
        intel-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        brodkin@synopsys.com, dri-devel@lists.freedesktop.org,
        rodrigo.vivi@intel.com, Matthias Brugger <matthias.bgg@gmail.com>,
        wen <s@csie.org>, vincent.abriou@st.com,
        linux-arm-kernel@lists.infradead.org, inki.dae@samsung.com,
        amd-gfx@lists.freedesktop.org, alison.wang@freescale.com,
        freedreno@lists.freedesktop.org, sw0312.kim@samsung.com,
        nicolas.ferre@microchip.com, Philippe Cornu <philippe.cornu@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yannick.fertre@st.com, Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        p.zabel@pengutronix.de, Zou Rongrong <zourongrong@gmail.com>,
        linux-mediatek@lists.infradead.org, shawnguo@kernel.org,
        christian.koenig@amd.com, l.stach@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 6:15 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Daniel,
>
> On Thursday, 26 April 2018 15:36:15 EEST Daniel Vetter wrote:
>> On Thu, Apr 26, 2018 at 03:58:19PM +0530, Vaishali Thakkar wrote:
>> > It's been a while since we introduced drm_dev{get/put} functions
>> > to replace reference/unreference in drm subsystem for the
>> > consistency purpose. So, with this patch, let's just replace
>> > all current use cases of drm_dev_unref() with drm_dev_put and remove
>> > the function itself.
>> >
>> > Coccinelle was used for mass-patching.
>> >
>> > Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
>>
>> Thanks for doing this. Unfortunately drm moves pretty fast, so already a
>> conflict when I tried to apply this. Some drivers are also in their own
>> trees, so this might lead to more fun :-/
>>
>> Can you pls split it up per-driver (just the directories under
>> drivers/gpu/drm/ is enough)? Final patch to remove the function might then
>> get stalled a bit ofc.
>
> I requested a single patch instead of splitting it per driver, you might want
> to blame me for that.
>
>> Also can you pls update ./scripts/coccinelle/api/drm-get-put.cocci and
>> remove that spatch hunk in the final patch, since we no longer need it?
>
> How about just rerunning the coccinelle patch when it's time to apply this ?
> There's precedent for performing such automated changes, and it would ensure
> that no driver is left out.

I was planning to send patches to remove all remaining reference/unreference
functions by the weekend [as there aren't much remaining now and I see that
new drivers keeps adding them instead of new API]. So, wanted to delete whole
cocci file after that. I thought of dividing a patch per function because
Laurent requested to send a single patch for all files.

But if we are going to split it per driver under gpu/drm, would it work if per
driver patch contains all function cases? Also, would you be fine with taking a
patch for removal of coccinelle file via your tree? Then I can include that in
the same patchset as well.

Thanks!

>> > ---
>> >
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  4 ++--
>> >  drivers/gpu/drm/arc/arcpgu_drv.c                   |  4 ++--
>> >  drivers/gpu/drm/armada/armada_drv.c                |  6 +++---
>> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |  4 ++--
>> >  drivers/gpu/drm/drm_drv.c                          | 13 -------------
>> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  4 ++--
>> >  drivers/gpu/drm/exynos/exynos_drm_drv.c            |  4 ++--
>> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |  4 ++--
>> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  4 ++--
>> >  drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |  8 ++++----
>> >  drivers/gpu/drm/i915/selftests/huge_pages.c        |  2 +-
>> >  drivers/gpu/drm/i915/selftests/i915_gem_dmabuf.c   |  2 +-
>> >  drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |  2 +-
>> >  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |  2 +-
>> >  drivers/gpu/drm/i915/selftests/i915_gem_object.c   |  2 +-
>> >  drivers/gpu/drm/i915/selftests/i915_request.c      |  2 +-
>> >  drivers/gpu/drm/i915/selftests/i915_vma.c          |  2 +-
>> >  drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c |  2 +-
>> >  drivers/gpu/drm/imx/imx-drm-core.c                 |  4 ++--
>> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  6 +++---
>> >  drivers/gpu/drm/msm/msm_drv.c                      |  8 ++++----
>> >  drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |  4 ++--
>> >  drivers/gpu/drm/nouveau/nouveau_platform.c         |  2 +-
>> >  drivers/gpu/drm/omapdrm/omap_drv.c                 |  4 ++--
>> >  drivers/gpu/drm/pl111/pl111_drv.c                  |  4 ++--
>> >  drivers/gpu/drm/qxl/qxl_drv.c                      |  2 +-
>> >  drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  2 +-
>> >  drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |  4 ++--
>> >  drivers/gpu/drm/shmobile/shmob_drm_drv.c           |  4 ++--
>> >  drivers/gpu/drm/sti/sti_drv.c                      |  8 ++++----
>> >  drivers/gpu/drm/stm/drv.c                          |  4 ++--
>> >  drivers/gpu/drm/sun4i/sun4i_drv.c                  |  4 ++--
>> >  drivers/gpu/drm/tegra/drm.c                        |  4 ++--
>> >  drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |  6 +++---
>> >  drivers/gpu/drm/tve200/tve200_drv.c                |  4 ++--
>> >  drivers/gpu/drm/udl/udl_drv.c                      |  2 +-
>> >  drivers/gpu/drm/vc4/vc4_drv.c                      |  4 ++--
>> >  drivers/gpu/drm/vgem/vgem_drv.c                    |  2 +-
>> >  drivers/gpu/drm/virtio/virtgpu_drm_bus.c           |  2 +-
>> >  drivers/gpu/drm/zte/zx_drm_drv.c                   |  4 ++--
>> >  include/drm/drm_drv.h                              |  1 -
>> >  41 files changed, 73 insertions(+), 87 deletions(-)
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>



-- 
Vaishali
http://vaishalithakkar.in/

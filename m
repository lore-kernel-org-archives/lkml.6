Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756165AbeDZNPH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:15:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48703 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755207AbeDZNPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:15:05 -0400
Date: Thu, 26 Apr 2018 15:14:53 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
        Vaishali Thakkar <vthakkar1994@gmail.com>, alexander.deucher@amd.com,
        linux-renesas-soc@vger.kernel.org, heiko@sntech.de, airlied@linux.ie,
        linus.walleij@linaro.org, stefan@agner.ch, hjc@rock-chips.com,
        kraxel@redhat.com, benjamin.gaignard@linaro.org,
        nouveau@lists.freedesktop.org, marex@denx.de, David1.Zhou@amd.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        linux-rockchip@lists.infradead.org, tomi.valkeinen@ti.com,
        linux@armlinux.org.uk, krzk@kernel.org, jonathanh@nvidia.com,
        z.liuxinliang@hisilicon.com, maxime.ripard@bootlin.com,
        kong.kongxinwei@hisilicon.com, kgene@kernel.org, bskeggs@redhat.com,
        linux-arm-msm@vger.kernel.org, ck.hu@mediatek.com, airlied@redhat.com,
        virtualization@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        puck.chen@hisilicon.com, intel-gfx@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org, brodkin@synopsys.com,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
        matthias.bgg@gmail.com, wens@csie.org, vincent.abriou@st.com,
        linux-arm-kernel@lists.infradead.org, inki.dae@samsung.com,
        amd-gfx@lists.freedesktop.org, alison.wang@freescale.com,
        freedreno@lists.freedesktop.org, sw0312.kim@samsung.com,
        nicolas.ferre@microchip.com, philippe.cornu@st.com,
        linux-kernel@vger.kernel.org, yannick.fertre@st.com,
        kyungmin.park@samsung.com, noralf@tronnes.org, p.zabel@pengutronix.de,
        zourongrong@gmail.com, linux-mediatek@lists.infradead.org,
        shawnguo@kernel.org, christian.koenig@amd.com, l.stach@pengutronix.de
Subject: Re: [Intel-gfx] [PATCH] drm/core: Remove drm_dev_unref() and it's
 uses
Message-ID: <20180426131404.GP4813@piout.net>
References: <20180426102819.6985-1-vthakkar1994@gmail.com>
 <20180426123615.GA12521@phenom.ffwll.local>
 <1556510.Xu6NnhyFGZ@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556510.Xu6NnhyFGZ@avalon>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/04/2018 15:45:44+0300, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Thursday, 26 April 2018 15:36:15 EEST Daniel Vetter wrote:
> > On Thu, Apr 26, 2018 at 03:58:19PM +0530, Vaishali Thakkar wrote:
> > > It's been a while since we introduced drm_dev{get/put} functions
> > > to replace reference/unreference in drm subsystem for the
> > > consistency purpose. So, with this patch, let's just replace
> > > all current use cases of drm_dev_unref() with drm_dev_put and remove
> > > the function itself.
> > > 
> > > Coccinelle was used for mass-patching.
> > > 
> > > Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> > 
> > Thanks for doing this. Unfortunately drm moves pretty fast, so already a
> > conflict when I tried to apply this. Some drivers are also in their own
> > trees, so this might lead to more fun :-/
> > 
> > Can you pls split it up per-driver (just the directories under
> > drivers/gpu/drm/ is enough)? Final patch to remove the function might then
> > get stalled a bit ofc.
> 
> I requested a single patch instead of splitting it per driver, you might want 
> to blame me for that.
> 

Doesn't splitting the change per driver break bisectability unless there
is a guarantee that the change in include/drm/drm_drv.h is applied after
all the driver trees have been merged?


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

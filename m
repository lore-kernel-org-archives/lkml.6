Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755988AbeDZMgg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:36:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51840 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754277AbeDZMgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:36:32 -0400
X-Google-Smtp-Source: AIpwx4/Lxs81833L/xBZzWrqVBJ6iAyQJtc/jfbGuiStUdE+x5yCjT+zh84BODTGe5VAOMR5EpUIZg==
Date: Thu, 26 Apr 2018 14:36:15 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: alexander.deucher@amd.com, linux-renesas-soc@vger.kernel.org,
        alexandre.belloni@bootlin.com, heiko@sntech.de, airlied@linux.ie,
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
        amd-gfx@lists.freedesktop.org, laurent.pinchart@ideasonboard.com,
        alison.wang@freescale.com, freedreno@lists.freedesktop.org,
        sw0312.kim@samsung.com, nicolas.ferre@microchip.com,
        philippe.cornu@st.com, linux-kernel@vger.kernel.org,
        yannick.fertre@st.com, kyungmin.park@samsung.com, noralf@tronnes.org,
        p.zabel@pengutronix.de, zourongrong@gmail.com,
        linux-mediatek@lists.infradead.org, shawnguo@kernel.org,
        christian.koenig@amd.com, l.stach@pengutronix.de
Subject: Re: [Intel-gfx] [PATCH] drm/core: Remove drm_dev_unref() and it's
 uses
Message-ID: <20180426123615.GA12521@phenom.ffwll.local>
Mail-Followup-To: Vaishali Thakkar <vthakkar1994@gmail.com>,
        alexander.deucher@amd.com, linux-renesas-soc@vger.kernel.org,
        alexandre.belloni@bootlin.com, heiko@sntech.de, airlied@linux.ie,
        linus.walleij@linaro.org, stefan@agner.ch, hjc@rock-chips.com,
        kraxel@redhat.com, benjamin.gaignard@linaro.org,
        nouveau@lists.freedesktop.org, marex@denx.de, David1.Zhou@amd.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        linux-rockchip@lists.infradead.org, tomi.valkeinen@ti.com,
        linux@armlinux.org.uk, krzk@kernel.org, jonathanh@nvidia.com,
        z.liuxinliang@hisilicon.com, maxime.ripard@bootlin.com,
        kong.kongxinwei@hisilicon.com, kgene@kernel.org, bskeggs@redhat.com,
        linux-arm-msm@vger.kernel.org, ck.hu@mediatek.com,
        airlied@redhat.com, virtualization@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, puck.chen@hisilicon.com,
        intel-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        brodkin@synopsys.com, dri-devel@lists.freedesktop.org,
        rodrigo.vivi@intel.com, matthias.bgg@gmail.com, wens@csie.org,
        vincent.abriou@st.com, linux-arm-kernel@lists.infradead.org,
        inki.dae@samsung.com, amd-gfx@lists.freedesktop.org,
        laurent.pinchart@ideasonboard.com, alison.wang@freescale.com,
        freedreno@lists.freedesktop.org, sw0312.kim@samsung.com,
        nicolas.ferre@microchip.com, philippe.cornu@st.com,
        linux-kernel@vger.kernel.org, yannick.fertre@st.com,
        kyungmin.park@samsung.com, noralf@tronnes.org,
        p.zabel@pengutronix.de, zourongrong@gmail.com,
        linux-mediatek@lists.infradead.org, shawnguo@kernel.org,
        christian.koenig@amd.com, l.stach@pengutronix.de
References: <20180426102819.6985-1-vthakkar1994@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426102819.6985-1-vthakkar1994@gmail.com>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 03:58:19PM +0530, Vaishali Thakkar wrote:
> It's been a while since we introduced drm_dev{get/put} functions
> to replace reference/unreference in drm subsystem for the
> consistency purpose. So, with this patch, let's just replace
> all current use cases of drm_dev_unref() with drm_dev_put and remove
> the function itself.
> 
> Coccinelle was used for mass-patching.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

Thanks for doing this. Unfortunately drm moves pretty fast, so already a
conflict when I tried to apply this. Some drivers are also in their own
trees, so this might lead to more fun :-/

Can you pls split it up per-driver (just the directories under
drivers/gpu/drm/ is enough)? Final patch to remove the function might then
get stalled a bit ofc.

Also can you pls update ./scripts/coccinelle/api/drm-get-put.cocci and
remove that spatch hunk in the final patch, since we no longer need it?

Thanks, Daniel

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
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 0b19482b36b8..5fb455febeba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -647,7 +647,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  err_pci:
>  	pci_disable_device(pdev);
>  err_free:
> -	drm_dev_unref(dev);
> +	drm_dev_put(dev);
>  	return ret;
>  }
>  
> @@ -657,7 +657,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  
>  	drm_dev_unregister(dev);
> -	drm_dev_unref(dev);
> +	drm_dev_put(dev);
>  	pci_disable_device(pdev);
>  	pci_set_drvdata(pdev, NULL);
>  }
> diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
> index f067de4e1e82..dcb06d4e9135 100644
> --- a/drivers/gpu/drm/arc/arcpgu_drv.c
> +++ b/drivers/gpu/drm/arc/arcpgu_drv.c
> @@ -216,7 +216,7 @@ static int arcpgu_probe(struct platform_device *pdev)
>  	arcpgu_unload(drm);
>  
>  err_unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return ret;
>  }
> @@ -227,7 +227,7 @@ static int arcpgu_remove(struct platform_device *pdev)
>  
>  	drm_dev_unregister(drm);
>  	arcpgu_unload(drm);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> index 4b11b6b52f1d..d1705d298a39 100644
> --- a/drivers/gpu/drm/armada/armada_drv.c
> +++ b/drivers/gpu/drm/armada/armada_drv.c
> @@ -109,7 +109,7 @@ static int armada_drm_bind(struct device *dev)
>  
>  	/*
>  	 * The drm_device structure must be at the start of
> -	 * armada_private for drm_dev_unref() to work correctly.
> +	 * armada_private for drm_dev_put() to work correctly.
>  	 */
>  	BUILD_BUG_ON(offsetof(struct armada_private, drm) != 0);
>  
> @@ -180,7 +180,7 @@ static int armada_drm_bind(struct device *dev)
>  	drm_mode_config_cleanup(&priv->drm);
>  	drm_mm_takedown(&priv->linear);
>  	flush_work(&priv->fb_unref_work);
> -	drm_dev_unref(&priv->drm);
> +	drm_dev_put(&priv->drm);
>  	return ret;
>  }
>  
> @@ -200,7 +200,7 @@ static void armada_drm_unbind(struct device *dev)
>  	drm_mm_takedown(&priv->linear);
>  	flush_work(&priv->fb_unref_work);
>  
> -	drm_dev_unref(&priv->drm);
> +	drm_dev_put(&priv->drm);
>  }
>  
>  static int compare_of(struct device *dev, void *data)
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index c1ea5c36b006..1c8487803a70 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -774,7 +774,7 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
>  	atmel_hlcdc_dc_unload(ddev);
>  
>  err_unref:
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return ret;
>  }
> @@ -785,7 +785,7 @@ static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
>  
>  	drm_dev_unregister(ddev);
>  	atmel_hlcdc_dc_unload(ddev);
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index a1b9338736e3..3dc507b13cf2 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -656,19 +656,6 @@ void drm_dev_put(struct drm_device *dev)
>  }
>  EXPORT_SYMBOL(drm_dev_put);
>  
> -/**
> - * drm_dev_unref - Drop reference of a DRM device
> - * @dev: device to drop reference of or NULL
> - *
> - * This is a compatibility alias for drm_dev_put() and should not be used by new
> - * code.
> - */
> -void drm_dev_unref(struct drm_device *dev)
> -{
> -	drm_dev_put(dev);
> -}
> -EXPORT_SYMBOL(drm_dev_unref);
> -
>  static int create_compat_control_link(struct drm_device *dev)
>  {
>  	struct drm_minor *minor;
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index ab50090d066c..716187a07227 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -613,7 +613,7 @@ static int etnaviv_bind(struct device *dev)
>  out_bind:
>  	kfree(priv);
>  out_unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return ret;
>  }
> @@ -630,7 +630,7 @@ static void etnaviv_unbind(struct device *dev)
>  	drm->dev_private = NULL;
>  	kfree(priv);
>  
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  }
>  
>  static const struct component_master_ops etnaviv_master_ops = {
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> index a518e9c6d6cc..3629e5c93e3a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -411,7 +411,7 @@ static int exynos_drm_bind(struct device *dev)
>  err_free_private:
>  	kfree(private);
>  err_free_drm:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return ret;
>  }
> @@ -435,7 +435,7 @@ static void exynos_drm_unbind(struct device *dev)
>  	drm->dev_private = NULL;
>  	dev_set_drvdata(dev, NULL);
>  
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  }
>  
>  static const struct component_master_ops exynos_drm_ops = {
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> index 80232321a244..664ac9dc1f65 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> @@ -358,7 +358,7 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
>  	return 0;
>  
>  unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  unregister_pix_clk:
>  	clk_unregister(fsl_dev->pix_clk);
>  disable_clk:
> @@ -371,7 +371,7 @@ static int fsl_dcu_drm_remove(struct platform_device *pdev)
>  	struct fsl_dcu_drm_device *fsl_dev = platform_get_drvdata(pdev);
>  
>  	drm_dev_unregister(fsl_dev->drm);
> -	drm_dev_unref(fsl_dev->drm);
> +	drm_dev_put(fsl_dev->drm);
>  	clk_disable_unprepare(fsl_dev->clk);
>  	clk_unregister(fsl_dev->pix_clk);
>  
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index d4f6f1f9df5b..ec878c7e3f75 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -387,7 +387,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>  err_disable:
>  	pci_disable_device(pdev);
>  err_free:
> -	drm_dev_unref(dev);
> +	drm_dev_put(dev);
>  
>  	return ret;
>  }
> @@ -398,7 +398,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
>  
>  	drm_dev_unregister(dev);
>  	hibmc_unload(dev);
> -	drm_dev_unref(dev);
> +	drm_dev_put(dev);
>  }
>  
>  static struct pci_device_id hibmc_pci_table[] = {
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> index ddb0403f1975..e6a62d5a00a3 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> @@ -193,7 +193,7 @@ static int kirin_drm_bind(struct device *dev)
>  
>  	ret = kirin_drm_kms_init(drm_dev);
>  	if (ret)
> -		goto err_drm_dev_unref;
> +		goto err_drm_dev_put;
>  
>  	ret = drm_dev_register(drm_dev, 0);
>  	if (ret)
> @@ -203,8 +203,8 @@ static int kirin_drm_bind(struct device *dev)
>  
>  err_kms_cleanup:
>  	kirin_drm_kms_cleanup(drm_dev);
> -err_drm_dev_unref:
> -	drm_dev_unref(drm_dev);
> +err_drm_dev_put:
> +	drm_dev_put(drm_dev);
>  
>  	return ret;
>  }
> @@ -215,7 +215,7 @@ static void kirin_drm_unbind(struct device *dev)
>  
>  	drm_dev_unregister(drm_dev);
>  	kirin_drm_kms_cleanup(drm_dev);
> -	drm_dev_unref(drm_dev);
> +	drm_dev_put(drm_dev);
>  }
>  
>  static const struct component_master_ops kirin_drm_ops = {
> diff --git a/drivers/gpu/drm/i915/selftests/huge_pages.c b/drivers/gpu/drm/i915/selftests/huge_pages.c
> index 05bbef363fff..22de60920b1a 100644
> --- a/drivers/gpu/drm/i915/selftests/huge_pages.c
> +++ b/drivers/gpu/drm/i915/selftests/huge_pages.c
> @@ -1720,7 +1720,7 @@ int i915_gem_huge_page_mock_selftests(void)
>  
>  	i915_modparams.enable_ppgtt = saved_ppgtt;
>  
> -	drm_dev_unref(&dev_priv->drm);
> +	drm_dev_put(&dev_priv->drm);
>  
>  	return err;
>  }
> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/selftests/i915_gem_dmabuf.c
> index 89dc25a5a53b..a7055b12e53c 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem_dmabuf.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_dmabuf.c
> @@ -389,7 +389,7 @@ int i915_gem_dmabuf_mock_selftests(void)
>  
>  	err = i915_subtests(tests, i915);
>  
> -	drm_dev_unref(&i915->drm);
> +	drm_dev_put(&i915->drm);
>  	return err;
>  }
>  
> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
> index ab9d7bee0aae..7b21e4135aa5 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
> @@ -490,7 +490,7 @@ int i915_gem_evict_mock_selftests(void)
>  	err = i915_subtests(tests, i915);
>  	mutex_unlock(&i915->drm.struct_mutex);
>  
> -	drm_dev_unref(&i915->drm);
> +	drm_dev_put(&i915->drm);
>  	return err;
>  }
>  
> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> index f7dc926f4ef1..1cf4e9af0b65 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> @@ -1646,7 +1646,7 @@ int i915_gem_gtt_mock_selftests(void)
>  	err = i915_subtests(tests, i915);
>  	mutex_unlock(&i915->drm.struct_mutex);
>  
> -	drm_dev_unref(&i915->drm);
> +	drm_dev_put(&i915->drm);
>  	return err;
>  }
>  
> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_object.c b/drivers/gpu/drm/i915/selftests/i915_gem_object.c
> index fbdb2419d418..7066f22ef8f1 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem_object.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_object.c
> @@ -586,7 +586,7 @@ int i915_gem_object_mock_selftests(void)
>  
>  	err = i915_subtests(tests, i915);
>  
> -	drm_dev_unref(&i915->drm);
> +	drm_dev_put(&i915->drm);
>  	return err;
>  }
>  
> diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
> index 94bc2e1898a4..5d069de4a19a 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_request.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_request.c
> @@ -262,7 +262,7 @@ int i915_request_mock_selftests(void)
>  		return -ENOMEM;
>  
>  	err = i915_subtests(tests, i915);
> -	drm_dev_unref(&i915->drm);
> +	drm_dev_put(&i915->drm);
>  
>  	return err;
>  }
> diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
> index eb89e301b602..9fbba5defb3e 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_vma.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
> @@ -734,7 +734,7 @@ int i915_vma_mock_selftests(void)
>  	err = i915_subtests(tests, i915);
>  	mutex_unlock(&i915->drm.struct_mutex);
>  
> -	drm_dev_unref(&i915->drm);
> +	drm_dev_put(&i915->drm);
>  	return err;
>  }
>  
> diff --git a/drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c b/drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c
> index 46580026c7fc..b6c9deeeda7b 100644
> --- a/drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c
> +++ b/drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c
> @@ -463,7 +463,7 @@ int intel_breadcrumbs_mock_selftests(void)
>  		return -ENOMEM;
>  
>  	err = i915_subtests(tests, i915->engine[RCS]);
> -	drm_dev_unref(&i915->drm);
> +	drm_dev_put(&i915->drm);
>  
>  	return err;
>  }
> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
> index 1d053bbefc02..27f54cbee7fb 100644
> --- a/drivers/gpu/drm/imx/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> @@ -307,7 +307,7 @@ static int imx_drm_bind(struct device *dev)
>  err_kms:
>  	drm_mode_config_cleanup(drm);
>  err_unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return ret;
>  }
> @@ -327,7 +327,7 @@ static void imx_drm_unbind(struct device *dev)
>  	component_unbind_all(drm->dev, drm);
>  	dev_set_drvdata(dev, NULL);
>  
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  }
>  
>  static const struct component_master_ops imx_drm_ops = {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index a2ca90fc403c..5d024a154e1a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -341,7 +341,7 @@ static int mtk_drm_bind(struct device *dev)
>  err_deinit:
>  	mtk_drm_kms_deinit(drm);
>  err_free:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  	return ret;
>  }
>  
> @@ -350,7 +350,7 @@ static void mtk_drm_unbind(struct device *dev)
>  	struct mtk_drm_private *private = dev_get_drvdata(dev);
>  
>  	drm_dev_unregister(private->drm);
> -	drm_dev_unref(private->drm);
> +	drm_dev_put(private->drm);
>  	private->drm = NULL;
>  }
>  
> @@ -504,7 +504,7 @@ static int mtk_drm_remove(struct platform_device *pdev)
>  
>  	drm_dev_unregister(drm);
>  	mtk_drm_kms_deinit(drm);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	component_master_del(&pdev->dev, &mtk_drm_ops);
>  	pm_runtime_disable(&pdev->dev);
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 30cd514d8f7c..558a82f828b8 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -260,7 +260,7 @@ static int msm_drm_uninit(struct device *dev)
>  	msm_mdss_destroy(ddev);
>  
>  	ddev->dev_private = NULL;
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	kfree(priv);
>  
> @@ -368,7 +368,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv) {
> -		drm_dev_unref(ddev);
> +		drm_dev_put(ddev);
>  		return -ENOMEM;
>  	}
>  
> @@ -378,7 +378,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>  	ret = msm_mdss_init(ddev);
>  	if (ret) {
>  		kfree(priv);
> -		drm_dev_unref(ddev);
> +		drm_dev_put(ddev);
>  		return ret;
>  	}
>  
> @@ -398,7 +398,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>  	if (ret) {
>  		msm_mdss_destroy(ddev);
>  		kfree(priv);
> -		drm_dev_unref(ddev);
> +		drm_dev_put(ddev);
>  		return ret;
>  	}
>  
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 5cae8db9dcd4..1ca9bafcd4f2 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -403,7 +403,7 @@ static int mxsfb_probe(struct platform_device *pdev)
>  err_unload:
>  	mxsfb_unload(drm);
>  err_free:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return ret;
>  }
> @@ -414,7 +414,7 @@ static int mxsfb_remove(struct platform_device *pdev)
>  
>  	drm_dev_unregister(drm);
>  	mxsfb_unload(drm);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/nouveau/nouveau_platform.c b/drivers/gpu/drm/nouveau/nouveau_platform.c
> index 1ada186fab77..039e23548e08 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_platform.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_platform.c
> @@ -36,7 +36,7 @@ static int nouveau_platform_probe(struct platform_device *pdev)
>  
>  	ret = drm_dev_register(drm, 0);
>  	if (ret < 0) {
> -		drm_dev_unref(drm);
> +		drm_dev_put(drm);
>  		return ret;
>  	}
>  
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index 3632854c2b91..e12cedc15e27 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -598,7 +598,7 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
>  	omap_drm_irq_uninstall(ddev);
>  err_free_drm_dev:
>  	omap_gem_deinit(ddev);
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  err_destroy_wq:
>  	destroy_workqueue(priv->wq);
>  	omap_disconnect_dssdevs();
> @@ -627,7 +627,7 @@ static void omapdrm_cleanup(struct omap_drm_private *priv)
>  	omap_drm_irq_uninstall(ddev);
>  	omap_gem_deinit(ddev);
>  
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	destroy_workqueue(priv->wq);
>  
> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
> index 4621259d5387..6e21308dd6c6 100644
> --- a/drivers/gpu/drm/pl111/pl111_drv.c
> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
> @@ -304,7 +304,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
>  	return 0;
>  
>  dev_unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  	return ret;
>  }
>  
> @@ -318,7 +318,7 @@ static int pl111_amba_remove(struct amba_device *amba_dev)
>  	if (priv->panel)
>  		drm_panel_bridge_remove(priv->bridge);
>  	drm_mode_config_cleanup(drm);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 2445e75cf7ea..86bd42dca09c 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -119,7 +119,7 @@ qxl_pci_remove(struct pci_dev *pdev)
>  
>  	dev->dev_private = NULL;
>  	kfree(qdev);
> -	drm_dev_unref(dev);
> +	drm_dev_put(dev);
>  }
>  
>  static const struct file_operations qxl_fops = {
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> index 3917d839c04c..1adcf80912e1 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -378,7 +378,7 @@ static int rcar_du_remove(struct platform_device *pdev)
>  	drm_kms_helper_poll_fini(ddev);
>  	drm_mode_config_cleanup(ddev);
>  
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index f814d37b1db2..9c846be8fc64 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -184,7 +184,7 @@ static int rockchip_drm_bind(struct device *dev)
>  err_free:
>  	drm_dev->dev_private = NULL;
>  	dev_set_drvdata(dev, NULL);
> -	drm_dev_unref(drm_dev);
> +	drm_dev_put(drm_dev);
>  	return ret;
>  }
>  
> @@ -204,7 +204,7 @@ static void rockchip_drm_unbind(struct device *dev)
>  
>  	drm_dev->dev_private = NULL;
>  	dev_set_drvdata(dev, NULL);
> -	drm_dev_unref(drm_dev);
> +	drm_dev_put(drm_dev);
>  }
>  
>  static const struct file_operations rockchip_drm_driver_fops = {
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> index 592572554eb0..8d1ff596c774 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> @@ -198,7 +198,7 @@ static int shmob_drm_remove(struct platform_device *pdev)
>  	drm_kms_helper_poll_fini(ddev);
>  	drm_mode_config_cleanup(ddev);
>  	drm_irq_uninstall(ddev);
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return 0;
>  }
> @@ -294,7 +294,7 @@ static int shmob_drm_probe(struct platform_device *pdev)
>  	drm_kms_helper_poll_fini(ddev);
>  	drm_mode_config_cleanup(ddev);
>  err_free_drm_dev:
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
> index 55b6967d27e1..e8d6199878ce 100644
> --- a/drivers/gpu/drm/sti/sti_drv.c
> +++ b/drivers/gpu/drm/sti/sti_drv.c
> @@ -242,7 +242,7 @@ static int sti_bind(struct device *dev)
>  
>  	ret = sti_init(ddev);
>  	if (ret)
> -		goto err_drm_dev_unref;
> +		goto err_drm_dev_put;
>  
>  	ret = component_bind_all(ddev->dev, ddev);
>  	if (ret)
> @@ -266,8 +266,8 @@ static int sti_bind(struct device *dev)
>  	drm_mode_config_cleanup(ddev);
>  err_cleanup:
>  	sti_cleanup(ddev);
> -err_drm_dev_unref:
> -	drm_dev_unref(ddev);
> +err_drm_dev_put:
> +	drm_dev_put(ddev);
>  	return ret;
>  }
>  
> @@ -277,7 +277,7 @@ static void sti_unbind(struct device *dev)
>  
>  	drm_dev_unregister(ddev);
>  	sti_cleanup(ddev);
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  }
>  
>  static const struct component_master_ops sti_ops = {
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 9ab00a87f7cc..6ece3acabd56 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -159,7 +159,7 @@ static int stm_drm_platform_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_unref:
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return ret;
>  }
> @@ -172,7 +172,7 @@ static int stm_drm_platform_remove(struct platform_device *pdev)
>  
>  	drm_dev_unregister(ddev);
>  	drv_unload(ddev);
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 50d19605c38f..42c881d5275d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -143,7 +143,7 @@ static int sun4i_drv_bind(struct device *dev)
>  	drm_mode_config_cleanup(drm);
>  	of_reserved_mem_device_release(dev);
>  free_drm:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  	return ret;
>  }
>  
> @@ -156,7 +156,7 @@ static void sun4i_drv_unbind(struct device *dev)
>  	sun4i_framebuffer_free(drm);
>  	drm_mode_config_cleanup(drm);
>  	of_reserved_mem_device_release(dev);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  }
>  
>  static const struct component_master_ops sun4i_drv_master_ops = {
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index 7afe2f635f74..f5119f2bbf5f 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -1210,7 +1210,7 @@ static int host1x_drm_probe(struct host1x_device *dev)
>  	return 0;
>  
>  unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  	return err;
>  }
>  
> @@ -1219,7 +1219,7 @@ static int host1x_drm_remove(struct host1x_device *dev)
>  	struct drm_device *drm = dev_get_drvdata(&dev->dev);
>  
>  	drm_dev_unregister(drm);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
> index 4c6616278c48..ca2b6a8b74c2 100644
> --- a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
> +++ b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
> @@ -135,7 +135,7 @@ static int tinydrm_init(struct device *parent, struct tinydrm_device *tdev,
>  	/*
>  	 * We don't embed drm_device, because that prevent us from using
>  	 * devm_kzalloc() to allocate tinydrm_device in the driver since
> -	 * drm_dev_unref() frees the structure. The devm_ functions provide
> +	 * drm_dev_put() frees the structure. The devm_ functions provide
>  	 * for easy error handling.
>  	 */
>  	drm = drm_dev_alloc(driver, parent);
> @@ -155,7 +155,7 @@ static void tinydrm_fini(struct tinydrm_device *tdev)
>  	drm_mode_config_cleanup(tdev->drm);
>  	mutex_destroy(&tdev->dirty_lock);
>  	tdev->drm->dev_private = NULL;
> -	drm_dev_unref(tdev->drm);
> +	drm_dev_put(tdev->drm);
>  }
>  
>  static void devm_tinydrm_release(void *data)
> @@ -172,7 +172,7 @@ static void devm_tinydrm_release(void *data)
>   *
>   * This function initializes @tdev, the underlying DRM device and it's
>   * mode_config. Resources will be automatically freed on driver detach (devres)
> - * using drm_mode_config_cleanup() and drm_dev_unref().
> + * using drm_mode_config_cleanup() and drm_dev_put().
>   *
>   * Returns:
>   * Zero on success, negative error code on failure.
> diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
> index ac344ddb23bc..e36a78ef68b7 100644
> --- a/drivers/gpu/drm/tve200/tve200_drv.c
> +++ b/drivers/gpu/drm/tve200/tve200_drv.c
> @@ -250,7 +250,7 @@ static int tve200_probe(struct platform_device *pdev)
>  clk_disable:
>  	clk_disable_unprepare(priv->pclk);
>  dev_unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  	return ret;
>  }
>  
> @@ -265,7 +265,7 @@ static int tve200_remove(struct platform_device *pdev)
>  		drm_panel_bridge_remove(priv->bridge);
>  	drm_mode_config_cleanup(drm);
>  	clk_disable_unprepare(priv->pclk);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
> index 3c45a3064726..d5e94eb7a4ca 100644
> --- a/drivers/gpu/drm/udl/udl_drv.c
> +++ b/drivers/gpu/drm/udl/udl_drv.c
> @@ -94,7 +94,7 @@ static int udl_usb_probe(struct usb_interface *interface,
>  	return 0;
>  
>  err_free:
> -	drm_dev_unref(dev);
> +	drm_dev_put(dev);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index 94b99c90425a..259c85fcd32c 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -312,7 +312,7 @@ static int vc4_drm_bind(struct device *dev)
>  	vc4_gem_destroy(drm);
>  	vc4_bo_cache_destroy(drm);
>  dev_unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  	return ret;
>  }
>  
> @@ -327,7 +327,7 @@ static void vc4_drm_unbind(struct device *dev)
>  
>  	drm_mode_config_cleanup(drm);
>  
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  }
>  
>  static const struct component_master_ops vc4_drm_ops = {
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index 2524ff116f00..305f87665499 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -505,7 +505,7 @@ static int __init vgem_init(void)
>  static void __exit vgem_exit(void)
>  {
>  	drm_dev_unregister(&vgem_device->drm);
> -	drm_dev_unref(&vgem_device->drm);
> +	drm_dev_put(&vgem_device->drm);
>  }
>  
>  module_init(vgem_init);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
> index 7df8d0c9026a..094b876f6da6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
> @@ -85,6 +85,6 @@ int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev)
>  	return 0;
>  
>  err_free:
> -	drm_dev_unref(dev);
> +	drm_dev_put(dev);
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_drm_drv.c
> index 6f4205e80378..02ae1caf6e8a 100644
> --- a/drivers/gpu/drm/zte/zx_drm_drv.c
> +++ b/drivers/gpu/drm/zte/zx_drm_drv.c
> @@ -122,7 +122,7 @@ static int zx_drm_bind(struct device *dev)
>  	component_unbind_all(dev, drm);
>  out_unregister:
>  	dev_set_drvdata(dev, NULL);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  	return ret;
>  }
>  
> @@ -136,7 +136,7 @@ static void zx_drm_unbind(struct device *dev)
>  	drm_mode_config_cleanup(drm);
>  	component_unbind_all(dev, drm);
>  	dev_set_drvdata(dev, NULL);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  }
>  
>  static const struct component_master_ops zx_drm_master_ops = {
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index d23dcdd1bd95..c16dd4424b8a 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -622,7 +622,6 @@ void drm_dev_unregister(struct drm_device *dev);
>  
>  void drm_dev_get(struct drm_device *dev);
>  void drm_dev_put(struct drm_device *dev);
> -void drm_dev_unref(struct drm_device *dev);
>  void drm_put_dev(struct drm_device *dev);
>  void drm_dev_unplug(struct drm_device *dev);
>  
> -- 
> 2.14.1
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

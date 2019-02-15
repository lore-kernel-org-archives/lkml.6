Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D75C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FBA21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPzIYL14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404303AbfBOQLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:11:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53908 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388979AbfBOQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:11:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so10499469wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNxq4qw8fJpDPwen7+Osaqk/mYWZsprZeXhN0SnS+rs=;
        b=pPzIYL14I/Kwq4dYUsep264MYHiA0sGTjrDBanrbmJFlEg2wXq7Dfi/q/eSsA9+LjZ
         1+2GuZnegx2VFnTpVNp7lovG1Ke43S0gUcZ6Kg+np3zgDxnp2QmiqichSYffJHvH1mcY
         g9RCErD9vR1Y192H7Qo1+5mXyNyPdaEwUOxdW8rdPR0cs2I2h8ABd8EupDVDLE7ZINmX
         Nb9QpJYvvdi2lFtBW5Air5bxOcn68Fx8WjR3Q/99a8Di0QjWPuhaDa9PzL/Vbe74/YBq
         YCGzw3Iqb3RhLxRZXgMEWIbM+ez9/eWeKdgi2vvPDyQlpjBVOddWZf+KyCB8VXE6z6wp
         WDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNxq4qw8fJpDPwen7+Osaqk/mYWZsprZeXhN0SnS+rs=;
        b=qxj1M/kF/nqxjDIK+WAd4j6o20VsUy6tvptz82m/wnFfg9kFH0rqVJMtKhuKRalmdI
         Xdzlz/F8Mtr/dOEncBZ1a+ZZnBQH9q4pMKBaCtQ6VRuYYGZ3O5vzEeOr5dm0QoV8EY3b
         mgb+CxAjapI7vDx8FasQY5m7D/unBFLvdQ75Y2MhJ0SKzkiHSFc2soVleodEjMNK8gsr
         bE1WZrAWXDbsZjPoROl22yXTu3ubM06awRGbmM0dc7KbjdeKPwG8BzFUWjHnk6mY84LE
         uIc2JhReFiG/ClEq6pAGDNIefTLI0NePSA45NJAWmVGPB1fUdO5DxfyQ4X6kWRooE/N8
         0UuA==
X-Gm-Message-State: AHQUAuZKeA7ZGpZGqAGRn5nhC69gsDtDrOTAztGOoSpV4WLXshUfzR4g
        KmKIJ/hq/YPTeJYaSeO3GXGGo1F28bcK/tjb1Z0=
X-Google-Smtp-Source: AHgI3IZrVtzg/B5HePCRlgBisuEU9rygngA5H4oZr3XrUBdIzAC0V6QHeC2m9qdGCfpgbZM0BrdYys8Gy86lta7XY4Y=
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr6894096wmq.121.1550247106893;
 Fri, 15 Feb 2019 08:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20190215154554.GA27081@embeddedor>
In-Reply-To: <20190215154554.GA27081@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 15 Feb 2019 11:11:34 -0500
Message-ID: <CADnq5_PZDS4aA6p8zA6WvT5Tkh+JZh+YirsycQawEiwPc-x3cg@mail.gmail.com>
Subject: Re: [PATCH] drm: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Ben Skeggs <bskeggs@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:08 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> Warning level 3 was used: -Wimplicit-fallthrough=3
>
> Notice that, in some cases, the code comment is modified
> in accordance with what GCC is expecting to find.
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Can you please split this up per driver?  A comment below as well.

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                   | 1 +
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c                     | 2 ++
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c      | 2 ++
>  drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c      | 2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c        | 2 ++
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 +
>  drivers/gpu/drm/drm_vm.c                                | 4 ++--
>  drivers/gpu/drm/nouveau/nouveau_bo.c                    | 2 +-
>  drivers/gpu/drm/radeon/ci_dpm.c                         | 2 ++
>  drivers/gpu/drm/radeon/evergreen_cs.c                   | 1 +
>  drivers/gpu/drm/radeon/si_dpm.c                         | 2 ++
>  11 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index b8e50a34bdb3..02955e6e9dd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -3236,6 +3236,7 @@ static void gfx_v8_0_tiling_mode_table_init(struct amdgpu_device *adev)
>                 dev_warn(adev->dev,
>                          "Unknown chip type (%d) in function gfx_v8_0_tiling_mode_table_init() falling through to CHIP_CARRIZO\n",
>                          adev->asic_type);
> +               /* fall through */
>
>         case CHIP_CARRIZO:
>                 modearray[0] = (ARRAY_MODE(ARRAY_2D_TILED_THIN1) |
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index da58040fdbdc..41e01a7f57a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -6216,10 +6216,12 @@ static void si_request_link_speed_change_before_state_change(struct amdgpu_devic
>                         si_pi->force_pcie_gen = AMDGPU_PCIE_GEN2;
>                         if (current_link_speed == AMDGPU_PCIE_GEN2)
>                                 break;
> +                       /* fall through */
>                 case AMDGPU_PCIE_GEN2:
>                         if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>                                 break;
>  #endif
> +                       /* fall through */
>                 default:
>                         si_pi->force_pcie_gen = si_get_current_pcie_speed(adev);
>                         break;
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index a1c56f29cfeb..fd5266a58297 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -265,6 +265,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
>                                         && id.enum_id == obj_id.enum_id)
>                                 return &bp->object_info_tbl.v1_4->display_path[i];
>                 }
> +               /* fall through */
>         case OBJECT_TYPE_CONNECTOR:
>         case OBJECT_TYPE_GENERIC:
>                 /* Both Generic and Connector Object ID
> @@ -277,6 +278,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
>                                         && id.enum_id == obj_id.enum_id)
>                                 return &bp->object_info_tbl.v1_4->display_path[i];
>                 }
> +               /* fall through */
>         default:
>                 return NULL;
>         }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> index 85686d917636..a24a2bda8656 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> @@ -479,7 +479,7 @@ static void program_grph_pixel_format(
>         case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
>                 sign = 1;
>                 floating = 1;
> -               /* no break */
> +               /* fall through */
>         case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F: /* shouldn't this get float too? */
>         case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
>                 grph_depth = 3;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index c8f5c00dd1e7..48187acac59e 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -3681,10 +3681,12 @@ static int smu7_request_link_speed_change_before_state_change(
>                         data->force_pcie_gen = PP_PCIEGen2;
>                         if (current_link_speed == PP_PCIEGen2)
>                                 break;
> +                       /* fall through */
>                 case PP_PCIEGen2:
>                         if (0 == amdgpu_acpi_pcie_performance_request(hwmgr->adev, PCIE_PERF_REQ_GEN2, false))
>                                 break;
>  #endif
> +                       /* fall through */
>                 default:
>                         data->force_pcie_gen = smu7_get_current_pcie_speed(hwmgr);
>                         break;
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> index 52abca065764..92de1bbb2e33 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> @@ -2330,6 +2330,7 @@ static uint32_t polaris10_get_offsetof(uint32_t type, uint32_t member)
>                 case DRAM_LOG_BUFF_SIZE:
>                         return offsetof(SMU74_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>                 }
> +               /* fall through */
>         case SMU_Discrete_DpmTable:
>                 switch (member) {
>                 case UvdBootLevel:
> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
> index c3301046dfaa..8987501f53b2 100644
> --- a/drivers/gpu/drm/drm_vm.c
> +++ b/drivers/gpu/drm/drm_vm.c
> @@ -584,8 +584,8 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
>                         vma->vm_ops = &drm_vm_ops;
>                         break;
>                 }
> -               /* fall through to _DRM_FRAME_BUFFER... */
>  #endif
> +               /* fall through - to _DRM_FRAME_BUFFER... */
>         case _DRM_FRAME_BUFFER:
>         case _DRM_REGISTERS:
>                 offset = drm_core_get_reg_ofs(dev);
> @@ -610,7 +610,7 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
>                     vma->vm_end - vma->vm_start, vma->vm_page_prot))
>                         return -EAGAIN;
>                 vma->vm_page_prot = drm_dma_prot(map->type, vma);
> -       /* fall through to _DRM_SHM */
> +               /* fall through - to _DRM_SHM */
>         case _DRM_SHM:
>                 vma->vm_ops = &drm_vm_shm_ops;
>                 vma->vm_private_data = (void *)map;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index 73eff52036d2..a72be71c45b4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -1434,7 +1434,7 @@ nouveau_ttm_io_mem_reserve(struct ttm_bo_device *bdev, struct ttm_mem_reg *reg)
>                 if (drm->client.mem->oclass < NVIF_CLASS_MEM_NV50 || !mem->kind)
>                         /* untiled */
>                         break;
> -               /* fallthrough, tiled memory */
> +               /* fall through - tiled memory */
>         case TTM_PL_VRAM:
>                 reg->bus.offset = reg->start << PAGE_SHIFT;
>                 reg->bus.base = device->func->resource_addr(device, 1);
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
> index a97294ac96d5..a12439266bb0 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -4869,10 +4869,12 @@ static void ci_request_link_speed_change_before_state_change(struct radeon_devic
>                         pi->force_pcie_gen = RADEON_PCIE_GEN2;
>                         if (current_link_speed == RADEON_PCIE_GEN2)
>                                 break;
> +                       /* fall through */
>                 case RADEON_PCIE_GEN2:
>                         if (radeon_acpi_pcie_performance_request(rdev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>                                 break;
>  #endif
> +                       /* fall through */
>                 default:
>                         pi->force_pcie_gen = ci_get_current_pcie_speed(rdev);
>                         break;
> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
> index f471537c852f..fbf346185790 100644
> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> @@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
>                         return -EINVAL;
>                 }
>                 ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
> +               /* fall through */
>         case CB_TARGET_MASK:
>                 track->cb_target_mask = radeon_get_ib_value(p, idx);
>                 track->cb_dirty = true;

This should be a break I think.

Alex

> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
> index 0a785ef0ab66..c9f6cb77e857 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -5762,10 +5762,12 @@ static void si_request_link_speed_change_before_state_change(struct radeon_devic
>                         si_pi->force_pcie_gen = RADEON_PCIE_GEN2;
>                         if (current_link_speed == RADEON_PCIE_GEN2)
>                                 break;
> +                       /* fall through */
>                 case RADEON_PCIE_GEN2:
>                         if (radeon_acpi_pcie_performance_request(rdev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>                                 break;
>  #endif
> +                       /* fall through */
>                 default:
>                         si_pi->force_pcie_gen = si_get_current_pcie_speed(rdev);
>                         break;
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

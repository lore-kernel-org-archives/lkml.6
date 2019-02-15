Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEEBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C47021924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfBOQRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:17:00 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.91]:14383 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbfBOQRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:17:00 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 97A7AA661
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:16:57 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ugAbgKj2V90onugAbghZWP; Fri, 15 Feb 2019 10:16:57 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=40306 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gugAa-002Shp-Kn; Fri, 15 Feb 2019 10:16:56 -0600
Subject: Re: [PATCH] drm: Mark expected switch fall-throughs
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
References: <20190215154554.GA27081@embeddedor>
 <CADnq5_PZDS4aA6p8zA6WvT5Tkh+JZh+YirsycQawEiwPc-x3cg@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <c63b48ff-0aa3-ffe4-2d67-0cce13e344b1@embeddedor.com>
Date:   Fri, 15 Feb 2019 10:16:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_PZDS4aA6p8zA6WvT5Tkh+JZh+YirsycQawEiwPc-x3cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gugAa-002Shp-Kn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.20]:40306
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 24
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/19 10:11 AM, Alex Deucher wrote:
> On Fri, Feb 15, 2019 at 11:08 AM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> Notice that, in some cases, the code comment is modified
>> in accordance with what GCC is expecting to find.
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Can you please split this up per driver?  A comment below as well.
> 

OK. Sure.

>> ---
>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                   | 1 +
>>  drivers/gpu/drm/amd/amdgpu/si_dpm.c                     | 2 ++
>>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c      | 2 ++
>>  drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c      | 2 +-
>>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c        | 2 ++
>>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 +
>>  drivers/gpu/drm/drm_vm.c                                | 4 ++--
>>  drivers/gpu/drm/nouveau/nouveau_bo.c                    | 2 +-
>>  drivers/gpu/drm/radeon/ci_dpm.c                         | 2 ++
>>  drivers/gpu/drm/radeon/evergreen_cs.c                   | 1 +
>>  drivers/gpu/drm/radeon/si_dpm.c                         | 2 ++
>>  11 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index b8e50a34bdb3..02955e6e9dd9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -3236,6 +3236,7 @@ static void gfx_v8_0_tiling_mode_table_init(struct amdgpu_device *adev)
>>                 dev_warn(adev->dev,
>>                          "Unknown chip type (%d) in function gfx_v8_0_tiling_mode_table_init() falling through to CHIP_CARRIZO\n",
>>                          adev->asic_type);
>> +               /* fall through */
>>
>>         case CHIP_CARRIZO:
>>                 modearray[0] = (ARRAY_MODE(ARRAY_2D_TILED_THIN1) |
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
>> index da58040fdbdc..41e01a7f57a4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
>> @@ -6216,10 +6216,12 @@ static void si_request_link_speed_change_before_state_change(struct amdgpu_devic
>>                         si_pi->force_pcie_gen = AMDGPU_PCIE_GEN2;
>>                         if (current_link_speed == AMDGPU_PCIE_GEN2)
>>                                 break;
>> +                       /* fall through */
>>                 case AMDGPU_PCIE_GEN2:
>>                         if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>>                                 break;
>>  #endif
>> +                       /* fall through */
>>                 default:
>>                         si_pi->force_pcie_gen = si_get_current_pcie_speed(adev);
>>                         break;
>> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
>> index a1c56f29cfeb..fd5266a58297 100644
>> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
>> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
>> @@ -265,6 +265,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
>>                                         && id.enum_id == obj_id.enum_id)
>>                                 return &bp->object_info_tbl.v1_4->display_path[i];
>>                 }
>> +               /* fall through */
>>         case OBJECT_TYPE_CONNECTOR:
>>         case OBJECT_TYPE_GENERIC:
>>                 /* Both Generic and Connector Object ID
>> @@ -277,6 +278,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
>>                                         && id.enum_id == obj_id.enum_id)
>>                                 return &bp->object_info_tbl.v1_4->display_path[i];
>>                 }
>> +               /* fall through */
>>         default:
>>                 return NULL;
>>         }
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
>> index 85686d917636..a24a2bda8656 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
>> @@ -479,7 +479,7 @@ static void program_grph_pixel_format(
>>         case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
>>                 sign = 1;
>>                 floating = 1;
>> -               /* no break */
>> +               /* fall through */
>>         case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F: /* shouldn't this get float too? */
>>         case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
>>                 grph_depth = 3;
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> index c8f5c00dd1e7..48187acac59e 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> @@ -3681,10 +3681,12 @@ static int smu7_request_link_speed_change_before_state_change(
>>                         data->force_pcie_gen = PP_PCIEGen2;
>>                         if (current_link_speed == PP_PCIEGen2)
>>                                 break;
>> +                       /* fall through */
>>                 case PP_PCIEGen2:
>>                         if (0 == amdgpu_acpi_pcie_performance_request(hwmgr->adev, PCIE_PERF_REQ_GEN2, false))
>>                                 break;
>>  #endif
>> +                       /* fall through */
>>                 default:
>>                         data->force_pcie_gen = smu7_get_current_pcie_speed(hwmgr);
>>                         break;
>> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
>> index 52abca065764..92de1bbb2e33 100644
>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
>> @@ -2330,6 +2330,7 @@ static uint32_t polaris10_get_offsetof(uint32_t type, uint32_t member)
>>                 case DRAM_LOG_BUFF_SIZE:
>>                         return offsetof(SMU74_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>>                 }
>> +               /* fall through */
>>         case SMU_Discrete_DpmTable:
>>                 switch (member) {
>>                 case UvdBootLevel:
>> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
>> index c3301046dfaa..8987501f53b2 100644
>> --- a/drivers/gpu/drm/drm_vm.c
>> +++ b/drivers/gpu/drm/drm_vm.c
>> @@ -584,8 +584,8 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
>>                         vma->vm_ops = &drm_vm_ops;
>>                         break;
>>                 }
>> -               /* fall through to _DRM_FRAME_BUFFER... */
>>  #endif
>> +               /* fall through - to _DRM_FRAME_BUFFER... */
>>         case _DRM_FRAME_BUFFER:
>>         case _DRM_REGISTERS:
>>                 offset = drm_core_get_reg_ofs(dev);
>> @@ -610,7 +610,7 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
>>                     vma->vm_end - vma->vm_start, vma->vm_page_prot))
>>                         return -EAGAIN;
>>                 vma->vm_page_prot = drm_dma_prot(map->type, vma);
>> -       /* fall through to _DRM_SHM */
>> +               /* fall through - to _DRM_SHM */
>>         case _DRM_SHM:
>>                 vma->vm_ops = &drm_vm_shm_ops;
>>                 vma->vm_private_data = (void *)map;
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
>> index 73eff52036d2..a72be71c45b4 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
>> @@ -1434,7 +1434,7 @@ nouveau_ttm_io_mem_reserve(struct ttm_bo_device *bdev, struct ttm_mem_reg *reg)
>>                 if (drm->client.mem->oclass < NVIF_CLASS_MEM_NV50 || !mem->kind)
>>                         /* untiled */
>>                         break;
>> -               /* fallthrough, tiled memory */
>> +               /* fall through - tiled memory */
>>         case TTM_PL_VRAM:
>>                 reg->bus.offset = reg->start << PAGE_SHIFT;
>>                 reg->bus.base = device->func->resource_addr(device, 1);
>> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
>> index a97294ac96d5..a12439266bb0 100644
>> --- a/drivers/gpu/drm/radeon/ci_dpm.c
>> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
>> @@ -4869,10 +4869,12 @@ static void ci_request_link_speed_change_before_state_change(struct radeon_devic
>>                         pi->force_pcie_gen = RADEON_PCIE_GEN2;
>>                         if (current_link_speed == RADEON_PCIE_GEN2)
>>                                 break;
>> +                       /* fall through */
>>                 case RADEON_PCIE_GEN2:
>>                         if (radeon_acpi_pcie_performance_request(rdev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>>                                 break;
>>  #endif
>> +                       /* fall through */
>>                 default:
>>                         pi->force_pcie_gen = ci_get_current_pcie_speed(rdev);
>>                         break;
>> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
>> index f471537c852f..fbf346185790 100644
>> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
>> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
>> @@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
>>                         return -EINVAL;
>>                 }
>>                 ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
>> +               /* fall through */
>>         case CB_TARGET_MASK:
>>                 track->cb_target_mask = radeon_get_ib_value(p, idx);
>>                 track->cb_dirty = true;
> 
> This should be a break I think.
> 

OK. I'll send this as a separate patch.

Thanks for the feedback.

--
Gustavo

> Alex
> 
>> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
>> index 0a785ef0ab66..c9f6cb77e857 100644
>> --- a/drivers/gpu/drm/radeon/si_dpm.c
>> +++ b/drivers/gpu/drm/radeon/si_dpm.c
>> @@ -5762,10 +5762,12 @@ static void si_request_link_speed_change_before_state_change(struct radeon_devic
>>                         si_pi->force_pcie_gen = RADEON_PCIE_GEN2;
>>                         if (current_link_speed == RADEON_PCIE_GEN2)
>>                                 break;
>> +                       /* fall through */
>>                 case RADEON_PCIE_GEN2:
>>                         if (radeon_acpi_pcie_performance_request(rdev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>>                                 break;
>>  #endif
>> +                       /* fall through */
>>                 default:
>>                         si_pi->force_pcie_gen = si_get_current_pcie_speed(rdev);
>>                         break;
>> --
>> 2.20.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

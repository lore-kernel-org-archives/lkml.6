Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80916C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489F62190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbfBOPp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:45:59 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.107]:14321 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387572AbfBOPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:45:58 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id B74D998BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:45:56 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ufgagUmBviQerufgagjh74; Fri, 15 Feb 2019 09:45:56 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=43702 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gufgZ-002AW3-ER; Fri, 15 Feb 2019 09:45:55 -0600
Date:   Fri, 15 Feb 2019 09:45:54 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Ben Skeggs <bskeggs@redhat.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm: Mark expected switch fall-throughs
Message-ID: <20190215154554.GA27081@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gufgZ-002AW3-ER
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:43702
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in some cases, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                   | 1 +
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                     | 2 ++
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c      | 2 ++
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c      | 2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c        | 2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 +
 drivers/gpu/drm/drm_vm.c                                | 4 ++--
 drivers/gpu/drm/nouveau/nouveau_bo.c                    | 2 +-
 drivers/gpu/drm/radeon/ci_dpm.c                         | 2 ++
 drivers/gpu/drm/radeon/evergreen_cs.c                   | 1 +
 drivers/gpu/drm/radeon/si_dpm.c                         | 2 ++
 11 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index b8e50a34bdb3..02955e6e9dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3236,6 +3236,7 @@ static void gfx_v8_0_tiling_mode_table_init(struct amdgpu_device *adev)
 		dev_warn(adev->dev,
 			 "Unknown chip type (%d) in function gfx_v8_0_tiling_mode_table_init() falling through to CHIP_CARRIZO\n",
 			 adev->asic_type);
+		/* fall through */
 
 	case CHIP_CARRIZO:
 		modearray[0] = (ARRAY_MODE(ARRAY_2D_TILED_THIN1) |
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index da58040fdbdc..41e01a7f57a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -6216,10 +6216,12 @@ static void si_request_link_speed_change_before_state_change(struct amdgpu_devic
 			si_pi->force_pcie_gen = AMDGPU_PCIE_GEN2;
 			if (current_link_speed == AMDGPU_PCIE_GEN2)
 				break;
+			/* fall through */
 		case AMDGPU_PCIE_GEN2:
 			if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
 				break;
 #endif
+			/* fall through */
 		default:
 			si_pi->force_pcie_gen = si_get_current_pcie_speed(adev);
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index a1c56f29cfeb..fd5266a58297 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -265,6 +265,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
 					&& id.enum_id == obj_id.enum_id)
 				return &bp->object_info_tbl.v1_4->display_path[i];
 		}
+		/* fall through */
 	case OBJECT_TYPE_CONNECTOR:
 	case OBJECT_TYPE_GENERIC:
 		/* Both Generic and Connector Object ID
@@ -277,6 +278,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
 					&& id.enum_id == obj_id.enum_id)
 				return &bp->object_info_tbl.v1_4->display_path[i];
 		}
+		/* fall through */
 	default:
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 85686d917636..a24a2bda8656 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -479,7 +479,7 @@ static void program_grph_pixel_format(
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
 		sign = 1;
 		floating = 1;
-		/* no break */
+		/* fall through */
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F: /* shouldn't this get float too? */
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
 		grph_depth = 3;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index c8f5c00dd1e7..48187acac59e 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3681,10 +3681,12 @@ static int smu7_request_link_speed_change_before_state_change(
 			data->force_pcie_gen = PP_PCIEGen2;
 			if (current_link_speed == PP_PCIEGen2)
 				break;
+			/* fall through */
 		case PP_PCIEGen2:
 			if (0 == amdgpu_acpi_pcie_performance_request(hwmgr->adev, PCIE_PERF_REQ_GEN2, false))
 				break;
 #endif
+			/* fall through */
 		default:
 			data->force_pcie_gen = smu7_get_current_pcie_speed(hwmgr);
 			break;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 52abca065764..92de1bbb2e33 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -2330,6 +2330,7 @@ static uint32_t polaris10_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU74_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		/* fall through */
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index c3301046dfaa..8987501f53b2 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -584,8 +584,8 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
 			vma->vm_ops = &drm_vm_ops;
 			break;
 		}
-		/* fall through to _DRM_FRAME_BUFFER... */
 #endif
+		/* fall through - to _DRM_FRAME_BUFFER... */
 	case _DRM_FRAME_BUFFER:
 	case _DRM_REGISTERS:
 		offset = drm_core_get_reg_ofs(dev);
@@ -610,7 +610,7 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
 		    vma->vm_end - vma->vm_start, vma->vm_page_prot))
 			return -EAGAIN;
 		vma->vm_page_prot = drm_dma_prot(map->type, vma);
-	/* fall through to _DRM_SHM */
+		/* fall through - to _DRM_SHM */
 	case _DRM_SHM:
 		vma->vm_ops = &drm_vm_shm_ops;
 		vma->vm_private_data = (void *)map;
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 73eff52036d2..a72be71c45b4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1434,7 +1434,7 @@ nouveau_ttm_io_mem_reserve(struct ttm_bo_device *bdev, struct ttm_mem_reg *reg)
 		if (drm->client.mem->oclass < NVIF_CLASS_MEM_NV50 || !mem->kind)
 			/* untiled */
 			break;
-		/* fallthrough, tiled memory */
+		/* fall through - tiled memory */
 	case TTM_PL_VRAM:
 		reg->bus.offset = reg->start << PAGE_SHIFT;
 		reg->bus.base = device->func->resource_addr(device, 1);
diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index a97294ac96d5..a12439266bb0 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -4869,10 +4869,12 @@ static void ci_request_link_speed_change_before_state_change(struct radeon_devic
 			pi->force_pcie_gen = RADEON_PCIE_GEN2;
 			if (current_link_speed == RADEON_PCIE_GEN2)
 				break;
+			/* fall through */
 		case RADEON_PCIE_GEN2:
 			if (radeon_acpi_pcie_performance_request(rdev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
 				break;
 #endif
+			/* fall through */
 		default:
 			pi->force_pcie_gen = ci_get_current_pcie_speed(rdev);
 			break;
diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index f471537c852f..fbf346185790 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
 			return -EINVAL;
 		}
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
+		/* fall through */
 	case CB_TARGET_MASK:
 		track->cb_target_mask = radeon_get_ib_value(p, idx);
 		track->cb_dirty = true;
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 0a785ef0ab66..c9f6cb77e857 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5762,10 +5762,12 @@ static void si_request_link_speed_change_before_state_change(struct radeon_devic
 			si_pi->force_pcie_gen = RADEON_PCIE_GEN2;
 			if (current_link_speed == RADEON_PCIE_GEN2)
 				break;
+			/* fall through */
 		case RADEON_PCIE_GEN2:
 			if (radeon_acpi_pcie_performance_request(rdev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
 				break;
 #endif
+			/* fall through */
 		default:
 			si_pi->force_pcie_gen = si_get_current_pcie_speed(rdev);
 			break;
-- 
2.20.1


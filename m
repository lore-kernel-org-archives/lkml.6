Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F12ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1696120832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkwn8LSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1696120832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeJYJkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:40:00 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:42744 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYJj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:39:59 -0400
Received: by mail-qt1-f182.google.com with SMTP id j46-v6so7951511qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 18:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=IFPes8NyOWPwQMKKSjEydDjF1v6CjFzddJtzy6Za2t0=;
        b=bkwn8LScBiaSsuZs/yMNwGb4lDLpDtPROV+E+W6zGMUBOhRdcs2MuqhF5FNinFyGPt
         NAjhssyV3+ovZFwCFP2geVKdOl51PuAhnPvGdfsop0sZtBHCve/fdpJ8WuI3B19m/P4N
         EtXDRFmh/8WuYJQW2YmZlr765WpHJBucbrXPM7ibvW9uYTwpC4FfEAs7VZJVFbGA+1um
         eID/BwujNcNkBMNcwV3aadSymH5PgeruVeImts7V7uKsmYFYVDv5ta1sqRbMcBcJhxNi
         eoDpMonwmyv0lVt2zxUezJ0P3iUw1MLXtLFgY79gnQ0Rfwi5XzHDzIDrkZXcdwRb2hTY
         XGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=IFPes8NyOWPwQMKKSjEydDjF1v6CjFzddJtzy6Za2t0=;
        b=OoTFc2eL9Ahva/u09yXlBkJ3qWcZpyava1elxOxn5ZB1db2JsOoX4qtTsKU2hIHabr
         1zDIGaYKsPWc/P6+LFelyu5o3u7uL9bO1J7kkrrS/lbAPoRQsea71IAMyQsNCUl08EQi
         j0dZSioD0TI9TcF73s40taUXhL/9CjEGiKRTM4bFdkU3jeYgmEcub3xgTQfkk4AhVMgT
         X/cmEd4QffgBg7dtCm36mp2qUi+X6sCnMq1ANOybawZlNWolEWLU4NwNmrN7Isz10any
         3mma/769OKyACrbweLwTY0HYpJc/hIa0FR6fVwnThbQqqwQ+lrIjRL+leXjhK0yVc66W
         X+VA==
X-Gm-Message-State: AGRZ1gLKwbvrlern1jP2PfAKiHQ5oRnKwAicvyPRrrTu0Mb6vfezj7ND
        giSNAseppwfZwNIc+Xhm6o2l3m4m/55xncwy4ye+c/Sk
X-Google-Smtp-Source: AJdET5e78aCiBSSmrOrMvFTsCmbP0oQJzO0wLyoSJJfThcLBnh/qzgvdtxjE785ONc98U/TMkw7/tmL/RbbsbWOeJ0k=
X-Received: by 2002:ac8:1701:: with SMTP id w1-v6mr4656814qtj.76.1540429767923;
 Wed, 24 Oct 2018 18:09:27 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 25 Oct 2018 11:09:14 +1000
Message-ID: <CAPM=9tw3SBUaueL2JGTybfkQo3f6qbQ291i3XTW-w32xdKsT-g@mail.gmail.com>
Subject: [git pull] drm pull for 4.20-rc1
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the main drm pull request for 4.20-rc1.

This is going to rebuild more than drm as it adds a new helper to
list.h for doing bulk updates. Seemed like a reasonable addition to
me.

Otherwise the usual merge window stuff lots of i915 and amdgpu, not so
much nouveau, and piles of everything else.

Thanks,
Dave.

Core:
Adds a new list.h helper for doing bulk list updates for TTM.
Don't leak fb address in smem_start to userspace
(comes with EXPORT workaround for people using mali out of tree hacks)
udmabuf device to turn memfd regions into dma-buf
Per-plane blend mode property
ref/unref replacements with get/put
fbdev conflicting framebuffers code cleaned up
host-endian format variants
panel orientation quirk for Acer One 10

bridge:
TI SN65DSI86 chip support

vkms:
GEM support.
Cursor support

amdgpu:
Merge amdkfd and amdgpu into one module
CEC over DP AUX support
Picasso APU support + VCN dynamic powergating
Raven2 APU support
Vega20 enablement + kfd support
ACP powergating improvements
ABGR/XBGR display support
VCN jpeg support
xGMI support
DC i2c/aux cleanup
Ycbcr 4:2:0 support
GPUVM improvements
Powerplay and powerplay endian fixes
Display underflow fixes

vmwgfx:
Move vmwgfx specific TTM code to vmwgfx
Split out vmwgfx buffer/resource validation code
Atomic operation rework

bochs:
use more helpers
format/byteorder improvements

qxl:
use more helpers

i915:
GGTT coherency getparam
Turn off resource streamer API
More Icelake enablement + DMC firmware
Full PPGTT for Ivybridge, Haswell and Valleyview
DDB distribution based on resolution
Limited range DP display support

nouveau:
CEC over DP AUX support
Initial HDMI 2.0 support

virtio-gpu:
vmap support for PRIME objects

tegra:
Initial Tegra194 support
DMA/IOMMU integration fixes

msm:
a6xx perf improvements + clock prefix
GPU preemption optimisations
a6xx devfreq support
cursor support

rockchip:
PX30 support
rgb output interface support

mediatek:
HDMI output support on mt2701 and mt7623

rcar-du:
Interlaced modes on Gen3
LVDS on R8A77980
D3 and E3 SoC support

hisilicon:
misc fixes

mxsfb:
runtime pm support

sun4i:
R40 TCON support
Allwinner A64 support
R40 HDMI support

omapdrm:
Driver rework changing display pipeline ordering to use common code
DMM memory barrier and irq fixes
Errata workarounds

exynos:
out-bridge support for LVDS bridge driver
Samsung 16x16 tiled format support
Plane alpha and pixel blend mode support

tilcdc:
suspend/resume update

mali-dp:
misc updates

drm-next-2018-10-24:
drm pull for 4.20-rc1
The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38=
:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-10-24

for you to fetch changes up to f2bfc71aee75feff33ca659322b72ffeed5a243d:

  Merge tag 'drm-intel-next-fixes-2018-10-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2018-10-19
14:28:11 +1000)

----------------------------------------------------------------
drm pull for 4.20-rc1

----------------------------------------------------------------
A. Wilcox (1):
      drm/amdgpu: use processed values for counting

Akshu Agrawal (1):
      drm/amd/powerplay: Enable/Disable NBPSTATE on On/OFF of UVD

Alex Deucher (38):
      drm/amdgpu/pp: endian fixes for process_pptables_v1_0.c
      drm/amdgpu/pp: endian fixes for processpptables.c
      drm/amdgpu/powerplay: check vrefresh when when changing displays
      drm/amdgpu: add AVFS control to PP_FEATURE_MASK
      drm/amdgpu/powerplay/smu7: enable AVFS control via ppfeaturemask
      drm/amdgpu/powerplay/vega10: enable AVFS control via ppfeaturemask
      Revert "drm/amdgpu: Add nbio support for vega20 (v2)"
      drm/amdgpu: remove experimental flag for vega20
      drm/amdgpu/display: add support for LVDS (v5)
      drm/amdgpu: add missing CHIP_HAINAN in amdgpu_ucode_get_load_type
      drm/amdgpu/gmc9: rework stolen vga memory handling
      drm/amdgpu/gmc9: don't keep stolen memory on Raven
      drm/amdgpu/gmc9: don't keep stolen memory on vega12
      drm/amdgpu/gmc9: don't keep stolen memory on vega20
      drm/amdgpu/gmc: add initial xgmi structure to amdgpu_gmc structure
      drm/amdgpu/gmc9: add a new gfxhub 1.1 helper for xgmi
      drm/amdgpu/gmc9: Adjust GART and AGP location with xgmi offset (v2)
      drm/amdgpu: use IP presence to free uvd and vce handles
      drm/amdgpu: set external rev id for raven2
      drm/amdgpu/soc15: clean up picasso support
      drm/amdgpu: simplify Raven, Raven2, and Picasso handling
      drm/amdgpu/display: return proper error codes in dm
      drm/amdgpu/powerplay: add get_argument callback for vega20
      drm/amdgpu/powerplay: Move vega10_enable_smc_features
      drm/amdgpu/powerplay: add smu smc_table_manager callback for vega12
      drm/amdgpu/powerplay: add smu smc_table_manager callback for vega20
      drm/amdgpu: add new AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK sensor
      drm/amdgpu: implement ENABLED_SMC_FEATURES_MASK sensor for vega10
      drm/amdgpu: implement ENABLED_SMC_FEATURES_MASK sensor for vega12
      drm/amdgpu: implement ENABLED_SMC_FEATURES_MASK sensor for vega20
      drm/amdgpu: print smc feature mask in debugfs amdgpu_pm_info
      drm/amdgpu/soc15: fix warnings in register macro
      drm/amdgpu/vcn: whitespace cleanup
      drm/amdgpu/vega20: make power profile output more consistent
      drm/amdgpu/powerplay: endian fixes for vega10_processpptables.c
      drm/amdgpu/powerplay: endian fixes for vega12_processpptables.c
      drm/amdgpu/powerplay: endian fixes for vega20_processpptables.c
      drm/amdgpu/powerplay: factor out some pptable helpers

Alexandru Gheorghe (12):
      drm/atomic: Add __drm_atomic_helper_plane_reset
      drm: mali-dp: Use __drm_atomic_helper_plane_reset instead of
copying the logic
      drm: atmel-hlcdc: Use __drm_atomic_helper_plane_reset instead of
copying the logic
      drm/imx: Use __drm_atomic_helper_plane_reset instead of copying the l=
ogic
      drm/sun4i: Use __drm_atomic_helper_plane_reset instead of
copying the logic
      drm: rcar-du: Use __drm_atomic_helper_plane_reset instead of
copying the logic
      drm/vc4: Use __drm_atomic_helper_plane_reset instead of copying the l=
ogic
      drm/vmwgfx: Use __drm_atomic_helper_plane_reset instead of
copying the logic
      drm: Clarify DRM_MODE_REFLECT_X/Y documentation
      drm: mali-dp: Call drm_crtc_vblank_reset on device init
      drm/malidp: Fix writeback in NV12
      drm/malidp: Fix smart layer when doing pm_suspend/resume

Alvin lee (2):
      drm/amd/display: Enable Stereo in Dal3
      drm/amd/display: Program vsc_infopacket in commit_planes_for_stream

Amber Lin (4):
      drm/amdgpu: Merge amdkfd into amdgpu
      drm/amdgpu: Remove CONFIG_HSA_AMD_MODULE
      drm/amdgpu: Move KFD parameters to amdgpu (v3)
      drm/amdgpu: Relocate some definitions v2

Anders Roxell (1):
      drm/msm/gpu: fix parameters in function msm_gpu_crashstate_capture

Andrey Grodzovsky (12):
      drm/amdgpu: Fix page fault and kasan warning on pci device remove.
      drm/scheduler: Add job dependency trace.
      drm/amdgpu: Add job pipe sync dependecy trace
      drm/scheduler: Add stopped flag to drm_sched_entity
      drm/amdgpu: Refine gmc9 VM fault print.
      drm/amdgpu: Use drm_dev_unplug in PCI .remove
      drm/amdgpu: Fix SDMA TO after GPU reset v3
      drm/amd/display: Fix pflip IRQ status after gpu reset.
      Revert "drm/amdgpu: remove fence fallback"
      drm/amdgpu: Add warning message for INT SW fallback.
      drm/amdgpu: Deactivate SW interrupt fallback in amdgpu_fence_process =
v2
      drm/amdgpu: Move fence SW fallback warning v3

Andrzej Hajda (4):
      dt-bindings: tc358754: add DT bindings
      drm/bridge: tc358764: Add DSI to LVDS bridge driver
      drm/bridge/tc358764: fix drm helper name
      dt-bindings: exynos_dsim: update of graph bindings

Andrzej Pietrasiewicz (2):
      drm: drm_fourcc: add Samsung 16x16 tile format
      drm/exynos: scaler: Add support for tiled formats

Animesh Manna (1):
      drm/i915/icl: Update FIA supported lane count for hpd.

Anthony Koo (10):
      drm/amd/display: Refactor FreeSync module
      drm/amd/display: add method to check for supported range
      drm/amd/display: Fix bug where refresh rate becomes fixed
      drm/amd/display: Fix bug that causes black screen
      drm/amd/display: Add back code to allow for rounding error
      drm/amd/display: fix LFC tearing at top of screen
      drm/amd/display: refactor vupdate interrupt registration
      drm/amd/display: Correct rounding calcs in mod_freesync_is_valid_rang=
e
      drm/amd/display: add config for sending VSIF
      drm/amd/display: move edp fast boot optimization flag to stream

Anton Vasilyev (2):
      drm: qxl: Fix error handling at qxl_device_init
      drm: qxl: Fix NULL pointer dereference at qxl_alloc_client_monitors_c=
onfig

Anusha Srivatsa (6):
      drm/i915/dsc: Add missing _MMIO() from PPS registers
      drm/i915/icl: Add TBT checks for PLL calculations
      drm/i915/icl: Set TBT IO in Aux transaction
      drm/i915: Do not redefine the has_csr parameter.
      firmware/dmc/icl: load v1.07 on icelake.
      firmware/dmc/icl: Add missing MODULE_FIRMWARE() for Icelake.

Archit Taneja (2):
      dt-bindings: mipi-dsi: Add info about peripherals with non-DSI contro=
l bus
      dt-bindings: mipi-dsi: Add dual-channel DSI related info

Arnd Bergmann (1):
      drm/imx: fix build failure without CONFIG_DRM_FBDEV_EMULATION

Ayan Kumar Halder (4):
      drm/sun4i: Use (struct drm_format_info) fields to determine if a
format is yuv and multi planar or not.
      drm: Use horizontal and vertical chroma subsampling factor while
calculating offsets in the physical address of framebuffer
      drm/omap: Substitute format_is_yuv() with format->is_yuv
      drm/arm/malidp: Implemented the size validation for AFBC framebuffers

Azhar Shaikh (2):
      drm/i915: Fix assert_plane() warning on bootup with external display
      drm/i915/psr: Add PSR mode/revision to debugfs

Bhawanpreet Lakha (3):
      drm/amd/display: Build stream update and plane updates in dm
      drm/amd/display: Add Raven2 definitions in dc
      drm/amd/display: Add DC config flag for Raven2 (v2)

Bibby Hsieh (2):
      drm/mediatek: implement connection from BLS to DPI0
      drm/mediatek: add a error return value when clock driver has been pre=
pared

Boyuan Zhang (6):
      drm/amdgpu: add emit reg write reg wait for vcn jpeg
      drm/amdgpu: add system interrupt register offset header
      drm/amdgpu: add system interrupt mask for jrbc
      drm/amdgpu: enable system interrupt for jrbc
      drm/amdgpu: add emit trap for vcn jpeg
      drm/amdgpu: fix emit frame size and comments for jpeg

Brian Starkey (1):
      drm/fourcc: Add DOC: overview comment

Bruce Wang (7):
      drm/msm/dpu: Remove unneeded checks in dpu_plane.c
      drm/msm/dpu: Clean up plane atomic disable/update
      drm/msm/dpu: Remove unneeded checks in dpu_crtc.c
      drm/msm/dpu: Remove _dpu_crtc_power_enable
      drm/msm/dpu: Change _dpu_crtc_vblank_enable_no_lock to void
      drm/msm/dpu: Make dpu_plane_danger_signal_ctrl void
      drm/msm/dpu: Revise _dpu_plane_get_aspace

Charlene Liu (6):
      drm/amd/display: pass compat_level to hubp
      drm/amd/display: add retimer log for HWQ tuning use.
      drm/amd/display: Fix 3D stereo issues.
      drm/amd/display: add pp_smu NULL pointer check
      drm/amd/display: fix 4K stereo screen flash issue
      drm/amd/display: fix Interlace video timing.

Chen-Yu Tsai (3):
      drm/sun4i: tcon: Pass drm_encoder * into sun4i_tcon0_mode_set_cpu
      drm/sun4i: tcon: Rename Dithering related register macros
      Revert "drm/sun4i: Remove R40 display pipeline compatibles"

Chiawen Huang (4):
      drm/amd/display: add aux transition event log.
      drm/amd/display: clean code for transition event log.
      drm/amd/display: add aux i2c event log.
      drm/amd/display: add query HPD interface.

Chris Wilson (99):
      drm/i915/gtt: Enable full-ppgtt by default everywhere
      drm/i915/gtt: Full ppgtt everywhere, no excuses
      drm/i915: Suppress assertion for i915_ggtt_disable_guc
      drm/i915: Only force GGTT coherency w/a on required chipsets
      drm/i915: Pull unpin map into vma release
      drm/i915: Show stack (by WARN) for hitting forcewake errors
      drm/i915: Skip repeated calls to i915_gem_set_wedged()
      drm/i915: Avoid computing tile_row_size() for untiled objects
      drm/i915: Mark up object tiling-and-stride getters as const
      drm/i915: Protect guc_fini_wq() against module load abort
      drm/i915: Restore sane defaults for KMS on GEM error load
      drm/i915: Don't disable the GPU for older gen on wedging
      drm/i915/selftests: Use a full emulation of a user ppgtt context
      drm/i915/selftests: Exercise resetting in the middle of a wait-on-fen=
ce
      drm/i915: Eliminate use of PAGE_SIZE as a virtual alignment
      drm/i915: Remove superfluous GEN8_LR_CONTEXT_ALIGN
      drm/i915: Drop unneed i915 parameter from intel_ring_pin()
      drm/i915: Downgrade Gen9 Plane WM latency error
      drm/i915: Kick waiters on resetting legacy rings
      drm/i915/selftests: Replace opencoded clflush with drm_clflush_virt_r=
ange
      drm/i915: Interactive RPS mode
      drm/i95: Mark GGTT as incoherent for gen10+
      drm/i915/execlists: Terminate the context image with BB_END
      drm/i915: Drop stray clearing of rps->last_adj
      drm/i915/lpe: Mark LPE audio runtime pm as "no callbacks"
      drm/i915: Unconditionally clear the pm/guc GT IIR upon acking
      drm/i915: Clear all residual RPS events on disabling interrupts
      drm/i915: Stop dropping irq around resets
      drm/i915/selftests: Unconditionally do a chipset flush before
emit_bb_start
      drm/i915: Pull seqno started checks together
      drm/i915: Warn if we hit the timeout for wait-for-idle
      drm/i915: Unmask user interrupts writes into HWSP on snb/ivb/vlv/hsw
      drm/i915: Remove extra waiter kick on legacy resets
      drm/i915: Restore user forcewake domains across suspend
      drm/i915/selftests: Hold rpm for unparking
      dma-buf: Remove requirement for ops->map() from dma_buf_export
      drm/i915: Bump priority of clean up work
      drm/i915: Cleanup gt powerstate from gem
      drm/i915: Restrict gen6_reset_rps_interrupts to gen6+
      drm/i915: Kick waiters on resetting legacy rings
      drm/i915: Disable runtime-pm using lowlevel functions if !HAS_RC6
      drm/i915: Clear stop-engine for a pardoned reset
      drm/i915: Only skip connector output for disable_display
      drm/i915: Remove useless error return from intel_init_mocs_engine()
      drm/i915: Stop holding a ref to the ppgtt from each vma
      drm/i915: Introduce intel_runtime_pm_disable to pair
intel_runtime_pm_enable
      drm/i915/execlists: Include reset depth in traces
      drm/i915/audio: Hook up component bindings even if displays are disab=
led
      drm/i915: Correct CSB probing for engine state dumper
      drm/i915/execlists: Flush tasklet directly from reset-finish
      drm/i915/ringbuffer: Delay after invalidating gen6+ xcs
      drm/i915: Keep physical cursors pinned while in use
      drm/i915/selftests: Add a simple exerciser for suspend/hibernate
      drm/i915: Determine uses-full-ppgtt from context for execbuf
      drm/i915: Do a full device reset after being wedged
      drm/i915: Flag any possible writes for a GTT fault
      drm/i915: Force the slow path after a user-write error
      drm/i915: Early rejection of buffer allocations larger than RAM
      drm/i915: Forcibly flush unwanted requests in drop-caches
      drm/i915: Fix up FORCE_GPU_RELOC (debug) to flush CPU write domains
      drm/i915: Combine cleanup_status_page()
      drm/i915: Use a cached mapping for the physical HWS
      drm/i915: Double check we didn't miss an unclaimed register access
      drm/i915/ringbuffer: Move double invalidate to after pd flush
      drm/i915: Pull intel_uncore_arm_unclaimed_mmio_detection() under
the spinlock
      drm: Suppress user controlled spam for invalid drm_wait_vblank_ioctl
      drm: Remove "protection" around drm_vma_offset_manager_destroy()
      drm/i915: Be defensive and don't assume PSR has any commit to sync ag=
ainst
      drm/i915: Reduce context HW ID lifetime
      drm/i915: Attach the pci match data to the device upon creation
      drm/i915: Move final cleanup of drm_i915_private to i915_driver_destr=
oy
      drm: Reject unknown legacy bpp and depth for drm_mode_addfb ioctl
      drm/i915: Missed interrupt simulation is no more, tell the world
      drm/i915/overlay: Allocate physical registers from stolen
      drm/i915/overlay: Use the ioctl parameters directly
      drm/i915: Nuke struct_mutex from context_setparam
      drm/i915/ringbuffer: Reload PDs harder on byt/bcs
      drm/i915: Reorder execobject[] to insert non-48b objects into the low=
 4G
      drm/i915: Mark up a couple of KMS debug messages as such
      drm/i915: Limit the backpressure for i915_request allocation
      drm/i915: Flush the tasklet when checking for idle
      drm/i915/execlists: Delay updating ring register state after resume
      drm/i915: Check engine->default_state mapping on module load
      drm/i915/execlists: Use coherent writes into the context image
      drm/i915: Include fence-hint for timeout warning
      drm/i915/execlists: Reset CSB pointers on canceling requests (wedging=
)
      drm: Differentiate the lack of an interface from invalid parameter
      drm/i915: Limit number of capture objects
      drm/i915/selftests: Free the batch along the contexts error path
      drm/i915/selftests: Basic stress test for rapid context switching
      drm/i915/guc: Restore preempt-context across S3/S4
      drm/i915/selftests: Live tests emit requests and so require rpm
      drm/i915: Park the GPU on module load
      drm/i915/execlists: Onion unwind for logical_ring_init() failure
      drm: Use default dma_fence hooks where possible for null syncobj
      drm: Fix syncobj handing of schedule() returning 0
      drm/i915: Only reset seqno if actually idle
      drm/i915/selftests: Disable shrinker across mmap-exhaustion
      drm/i915: Large page offsets for pread/pwrite

Christian K=C3=B6nig (105):
      drm/amdgpu: fix VM clearing for the root PD
      drm/amdgpu: fix preamble handling
      drm/scheduler: fix setting the priorty for entities (v2)
      drm/scheduler: bind job earlier to scheduler
      drm/scheduler: Remove entity->rq NULL check
      drm/scheduler: fix last_scheduled handling
      drm/scheduler: change entities rq even earlier
      drm/scheduler: trivial error handling fix
      drm/scheduler: move entity handling into separate file
      drm/scheduler: cleanup entity coding style
      drm/scheduler: rename gpu_scheduler.c to sched_main.c
      drm/amdgpu: use new scheduler load balancing for VMs
      drm/amdgpu: use scheduler load balancing for SDMA CS
      drm/amdgpu: use scheduler load balancing for compute CS
      drm/amdgpu: remove the queue manager
      drm/amdgpu: remove ring lru handling
      drm/amdgpu: move context related stuff to amdgpu_ctx.h
      drm/amdgpu: use entity instead of ring for CS
      drm/amdgpu: fix VM size reporting on Raven
      drm/amdgpu: cleanup HW_IP query
      drm/amdgpu: rework ctx entity creation
      drm/amdgpu: cleanup GPU recovery check a bit (v2)
      drm/amdgpu: validate the VM root PD from the VM code
      drm/amdgpu: cleanup VM handling in the CS a bit
      drm/amdgpu: move setting the GART addr into TTM
      drm/amdgpu: rename gart.robj into gart.bo
      drm/amdgpu: remove gart.table_addr
      drm/amdgpu: add amdgpu_gmc_pd_addr helper
      drm/ttm: add helper structures for bulk moves on lru list
      drm/ttm: revise ttm_bo_move_to_lru_tail to support bulk moves
      drm/amdgpu: add ring soft recovery v4
      drm/amdgpu: implement soft_recovery for GFX7
      drm/amdgpu: implement soft_recovery for GFX8 v2
      drm/amdgpu: implement soft_recovery for GFX9
      drm/amdgpu: amdgpu_ctx_add_fence can't fail
      drm/amdgpu: fix holding mn_lock while allocating memory
      drm/amdgpu: remove extra root PD alignment
      drm/amdgpu: add helper for VM PD/PT allocation parameters v3
      drm/amdgpu: add GMC9 support for PDs/PTs in system memory
      drm/amdgpu: add amdgpu_gmc_get_pde_for_bo helper v2
      drm/amdgpu: enable GTT PD/PT for raven v3
      drm/amdgpu: remove extra newline when printing VM faults
      drm/amdgpu: remove amdgpu_bo_gpu_accessible
      drm/amdgpu: move amdgpu_device_(vram|gtt)_location
      drm/amdgpu: fix amdgpu_gmc_gart_location a little bit
      drm/amdgpu: stop using gart_start as offset for the GTT domain
      drm/amdgpu: distinct between allocated GART space and GMC addr
      drm/amdgpu: use the smaller hole for GART
      drm/amdgpu: put GART away from VRAM v2
      drm/amdgpu: Revert "kmap PDs/PTs in amdgpu_vm_update_directories"
      drm/ttm: fix ttm_bo_bulk_move_helper
      drm/amdgpu: fix "use bulk moves for efficient VM LRU handling" v2
      drm/amdgpu: fix idle state and bulk_moveable flag
      drm/amdgpu: move size calculations to the front of the file again
      drm/amdgpu: separate per VM BOs from normal in the moved state
      drm/amdgpu: fix amdgpu_mn_unlock() in the CS error path
      drm/amdgpu: improve VM state machine documentation v2
      drm/amdgpu: correctly sign extend 48bit addresses v3
      drm/amdgpu: add amdgpu_gmc_agp_location v3
      drm/amdgpu: use the AGP aperture for system memory access v2
      drm/amdgpu: manually map the shadow BOs again
      drm/amdgpu: enable AGP aperture for GMC9 v2
      drm/amdgpu: set bulk_moveable to false when a per VM is released
      drm/amdgpu: fix error handling in amdgpu_cs_user_fence_chunk
      drm/amdgpu: add amdgpu_vm_pt_parent helper
      drm/amdgpu: add amdgpu_vm_update_func
      drm/amdgpu: try allocating VRAM as power of two
      drm/amdgpu: add some VM PD/PT iterators v2
      drm/amdgpu: use leaf iterator for allocating PD/PT
      drm/amdgpu: use dfs iterator to free PDs/PTs
      drm/amdgpu: use the DFS iterator in amdgpu_vm_invalidate_pds v2
      drm/amdgpu: use leaf iterator for filling PTs
      drm/amdgpu: meld together VM fragment and huge page handling
      drm/amdgpu: use the maximum possible fragment size on Vega/Raven
      drm/amdgpu: allow fragment processing for invalid PTEs
      drm/ttm: once more fix ttm_bo_bulk_move_lru_tail
      drm/amdgpu: remove amdgpu_bo_list_entry.robj (v2)
      drm/amdgpu: use a single linked list for amdgpu_vm_bo_base
      drm/amdgpu: fix mask in GART location calculation
      drm/amdgpu: revert "stop using gart_start as offset for the GTT domai=
n"
      drm/amdgpu: add amdgpu_vm_entries_mask v2
      drm/amdgpu: fix parameter documentation for amdgpu_vm_free_pts
      drm/amdgpu: add GDS, GWS and OA debugfs files
      drm/amdgpu: stop crashing on GDS/GWS/OA eviction
      drm/amdgpu: don't allocate zero sized kernel BOs
      drm/amdgpu: drop size check
      drm/amdgpu: remove fence fallback
      drm/amdgpu: stop pipelining VM PDs/PTs moves
      drm/amdgpu: always enable shadow BOs v2
      drm/amdgpu: shadow BOs don't need any alignment
      drm/amdgpu: always recover VRAM during GPU recovery
      drm/amdgpu: fix shadow BO restoring
      drm/amdgpu: fix up GDS/GWS/OA shifting
      drm/amdgpu: initialize GDS/GWS/OA domains even when they are zero siz=
ed
      drm/amdgpu: move reserving GDS/GWS/OA into common code
      drm/amdgpu: drop extra newline in amdgpu_iv trace
      drm/amdgpu: make function pointers mandatory
      drm/amdgpu: cleanup amdgpu_ih.c
      drm/amdgpu: move more interrupt processing into amdgpu_irq.c
      drm/amdgpu: move more defines into amdgpu_irq.h
      drm/amdgpu: fix AGP location with VRAM at 0x0
      drm/amdgpu: fix incorrect use of amdgpu_irq_add_id in si_dma.c
      list: introduce list_bulk_move_tail helper
      drm/sched: add drm_sched_start_timeout helper
      drm/sched: fix timeout handling v2

Christoph Manszewski (3):
      drm/exynos: drm_plane: Correct exynos_drm_plane_reset
      drm/exynos: mixer: Make pixel blend mode configurable
      drm/exynos: mixer: Make plane alpha configurable

Chunming Zhou (5):
      drm: fix syncobj null_fence_enable_signaling
      drm: rename null fence to stub fence in syncobj v2
      drm: expand drm_syncobj_find_fence to support timeline point v2
      drm: expand replace_fence to support timeline point v2
      drm/amdgpu: move cs dependencies front a bit

Colin Ian King (2):
      drm/msm: fix unsigned comparison with less than zero
      drm/amdgpu/powerplay: fix missing break in switch statements

Corentin Labbe (1):
      drm/omap: remove unused header tcm-sita.h

Dan Carpenter (5):
      drm/amdgpu: fix integer overflow test in amdgpu_bo_list_create()
      drm/amd/display: indent an if statement
      drm/virtio: fix bounds check in virtio_gpu_cmd_get_capset()
      udmabuf: fix error code in map_udmabuf()
      drm/amd/amdgpu: Fix debugfs error handling

Daniel Vetter (16):
      drm/i915: Remove unecessary dma_fence_ops
      drm/msm: Remove unecessary dma_fence_ops
      drm/nouveau: Remove unecessary dma_fence_ops
      drm/vgem: Remove unecessary dma_fence_ops
      drm/syncobj: Drop add/remove_callback from driver interface
      drm: Add drm/drm_util.h header file
      drm: Drop drmP.h from drm_connector.c
      drm: drop drmP.h include from drm_plane.c
      drm: drop drmP.h include from drm_crtc.c
      drm/atomic: trim driver interface/docs
      drm: Update todo.rst
      drm: extract drm_atomic_uapi.c
      fbdev: Drop FBINFO_CAN_FORCE_OUTPUT flag
      vt: Remove vc_panic_force_write
      fbdev: Add FBINFO_HIDE_SMEM_START flag
      drm/fb: Stop leaking physical address

Daniele Ceraolo Spurio (1):
      drm/i915/selftests: ring all doorbells in igt_guc_doorbells

Dave Airlie (31):
      Merge tag 'drm-misc-next-2018-09-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'omapdrm-4.20' of git://git.kernel.org/.../tomba/linux
into drm-next
      Merge tag 'drm-intel-next-2018-09-06-2' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2018-09-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-misc-next-2018-09-19' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'du-next-20180914' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge branch 'drm-next-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'du-next-20180925' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge tag 'drm-hisilicon-next-2018-09-26' of
github.com:xin3liang/linux into drm-next
      BackMerge v4.19-rc5 into drm-next
      Merge tag 'drm-misc-next-2018-09-27' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2018-09-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm/tegra/for-4.20-rc1' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge branch 'drm-next-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge branch 'vmwgfx-next' of
git://people.freedesktop.org/~thomash/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2018-10-03' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'omapdrm-4.20-2' of
git://git.kernel.org/.../tomba/linux into drm-next
      Merge tag 'exynos-drm-next-for-v4.20' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      BackMerge v4.19-rc6 into drm-next
      Merge tag 'tilcdc-4.20' of https://github.com/jsarha/linux into drm-n=
ext
      Merge branch 'for-upstream/mali-dp' of
git://linux-arm.org/linux-ld into drm-next
      Merge branch 'for-upstream/mali-dp' of
git://linux-arm.org/linux-ld into drm-next
      Merge tag 'drm-msm-next-2018-10-07' of
git://people.freedesktop.org/~robclark/linux into drm-next
      Merge tag 'drm-msm-fixes-2018-10-09' of
git://people.freedesktop.org/~robclark/linux into drm-next
      Merge branch 'linux-4.20' of git://github.com/skeggsb/linux into drm-=
next
      Merge branch 'mediatek-drm-next-4.20' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-next
      Merge tag 'drm-misc-next-fixes-2018-10-10' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2018-10-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2018-10-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

David Francis (13):
      drm/amd/display: Create new i2c resource
      drm/amd/display: Combine dce80 and dce100 i2c hw functions
      drm/amd/display: Eliminate i2c hw function pointers
      drm/amd/display: Improve spelling, grammar, and formatting of
amdgpu_dm.c comments
      drm/amd/display: Remove redundant i2c structs
      drm/amd/display: Flatten unnecessary i2c functions
      drm/amd/display: Reorder resource_pool to put i2c with aux
      drm/amd/display: Remove call to amdgpu_pm_compute_clocks
      drm/amd: Add ucode DMCU support
      drm/amd: Add PSP DMCU support
      drm/amd: Add DM DMCU support
      drm/amd/display: Add DMCU firmware version
      drm/amdgpu: Add DMCU to firmware query interface

Derek Lai (1):
      drm/amd/display: add disconnect_delay to dc_panel_patch

Dhinakaran Pandiyan (12):
      drm/i915/mst: Do not retrain new links
      drm/i915/mst: Continue state updates even if AUX writes fail.
      drm/i915/psr: Print PSR_STATUS when PSR idle wait times out.
      drm/i915/psr: Add missing check for I915_PSR_DEBUG_IRQ bit
      drm/i915/psr: Mask PSR irq bits when re-enabling interrupts.
      drm/i915: Add a small wrapper to check for CCS modifiers.
      drm/i915: Rename PLANE_CTL_DECOMPRESSION_ENABLE
      drm/i915/psr: Remove wait_for_idle() for PSR2
      drm/i915/psr: Rewrite comments in intel_psr_wait_for_idle()
      drm/i915: Clean up skl_plane_has_planar()
      drm/i915: Do not advertize support for NV12 on ICL yet.
      drm/i915/psr: Enable AUX-A IO power well on ICL for PSR

Dmitry Osipenko (3):
      drm/tegra: dpaux: Use the correct definition for pad modes
      gpu: host1x: Detach Host1x from IOMMU DMA domain on arm32
      drm/tegra: Detach devices from IOMMU DMA domain on arm32

Dmytro Laktyushkin (5):
      drm/amd/display: Add dprefclk value to dce_dccg
      drm/amd/display: fix dml handling of mono8/16 pixel formats
      drm/amd/display: remove dead dc vbios code
      drm/amd/display: remove unused clk_src code
      drm/amd/display: stop using switch for different CS revisions

Emily Deng (11):
      amdgpu: fix multi-process hang issue
      drm/amdgpu: Remove the sriov checking and add firmware checking
      drm/amdgpu: use kiq to do invalidate tlb
      drm/amdgpu/sriov: Only sriov runtime support use kiq
      drm/amdgpu: Don't use kiq in gpu reset
      drm/amdgpu: Need to set moved to true when evict bo
      drm/amdgpu: move PSP init prior to IH in gpu reset
      drm/amdkfd: KFD doesn't support TONGA SRIOV
      drm/amdgpu/sriov: Correct the setting about sdma doorbell offset of V=
ega10
      drm/amdgpu: Limit the max mc address to hole start
      drm/amdgpu: Set the default value about gds vmid0 size

Eric Bernstein (2):
      drm/amd/display: Add DP YCbCr 4:2:0 support
      drm/amd/display: Stereo 3D support in VSC

Eric Huang (1):
      drm/amdkfd: reflect atomic support in IO link properties

Eric Yang (4):
      drm/amd/display: support 48 MHZ refclk off
      drm/amd/display: use link type to decide stream enc acquisition
      drm/amd/display: block DP YCbCr420 modes
      drm/amd/display: clean up encoding checks

Eryk Brol (1):
      drm/amd/display: Add function to fetch clock requirements

Evan Quan (52):
      drm/amdgpu/include: add thm 11.0.2 headers
      drm/amdgpu: update atomfirmware.h
      drm/amd/powerplay: add vega20_inc.h (v2)
      drm/amd/powerplay: add smu11_driver_if.h (v4)
      drm/amd/powerplay: add vega20_ppsmc.h (v2)
      drm/amd/powerplay: add vega20_pptable.h (v2)
      drm/amd/powerplay: add the smu manager for vega20 (v2)
      drm/amd/powerplay: new interfaces for ActivityMonitor table with SMU
      drm/amd/powerplay: add the hw manager for vega20 (v3)
      drm/amd/powerplay: support workload profile query and setup for vega2=
0
      drm/amd/powerplay: init vega20 uvd/vce powergate status on dpm setup
      drm/amd/powerplay: correct force clock level related settings
for vega20 (v2)
      drm/amd/powerplay: export vega20 stable pstate clocks
      drm/amd/powerplay: add vega20 pre_display_config_changed callback
      drm/amd/powerplay: conv the vega20 pstate sclk/mclk into
necessary 10KHz unit
      drm/amd/powerplay: initialize vega20 overdrive settings
      drm/amd/powerplay: new interfaces for overdrive vega20 sclk and mclk
      drm/amd/powerplay: revise vega20 PPSMC_MSG_SetSoftMin/[Max]ByFreq set=
tings
      drm/amd/powerplay: update vega20 clocks threshold settings on
power state adjust
      drm/amdgpu: enable vega20 powerplay support
      drm/amd/powerplay: enable fclk ss by default
      drm/amd/powerplay: remove setting soc floor voltage before sending pp=
table
      drm/amd/powerplay: avoid enabling/disabling uvd/vce dpm twice
      drm/amd/powerplay: correct the argument for PPSMC_MSG_SetUclkFastSwit=
ch
      drm/amd/powerplay: allow slow switch only if NBPState enabled
      drm/amd/powerplay: remove max DCEFCLK limitation
      drm/amd/powerplay: added voltage boot time calibration
      drm/amdgpu: update vega20 sdma golden settings
      drm/amdgpu: added support 2nd UVD instance
      drm/amdgpu: fix sdma doorbell range setting
      drm/amd/powerplay: added vega20 overdrive support V3
      drm/amd/powerplay: correct data type to support under voltage
      drm/amd/powerplay: fix compile warning for wrong data type V2
      drm/amd/powerplay: update smu10_verify_smc_interface() to be
raven2 compatible
      drm/amd/powerplay: round up the Mhz convertion (v2)
      drm/amd/powerplay: disable raven2 force dpm level support (v2)
      drm/amd/powerplay: update OD feature judgement
      drm/amd/powerplay: update OD to take voltage value instead of offset
      drm/amd/powerplay: retrieve the updated clock table after OD
      drm/amd/powerplay/vega20: correct the hwmon interface ppt limit outpu=
t
      drm/amd/powerplay/vega20: tell the correct gfx voltage V2
      drm/amd/powerplay/vega20: enable fan RPM and pwm settings V2
      drm/amdgpu: added vega20 LBPW support v2
      drm/amdgpu: change Raven always on CUs to 4
      drm/amdgpu: added AMD GPU instance counting V2
      drm/amd/powerplay: helper interfaces for MGPU fan boost feature
      drm/amd/powerplay: enable MGPU fan boost feature on Vega20
      drm/amd/powerplay: translate power_profile mode to pplib workload typ=
e
      drm/amd/powerplay: hint when power profile setting is not supported
      drm/amdgpu: update Vega20 SDMA golden setting
      drm/amd/powerplay: added I2C controller configuration
      drm/amd/powerplay: update PPtable with DC BTC and Tvr SocLimit fields

Ezequiel Garcia (3):
      virtio: Add virtio_gpu_object_kunmap()
      virtio: Rework virtio_gpu_object_kmap()
      virtio: Support prime objects vmap/vunmap

Feifei Xu (15):
      drm/amdgpu/include: Add nbio 7.4 header files (v4)
      drm/amdgpu/include: Add sdma0/1 4.2 register headerfiles. (v3)
      drm/amdgpu/include: Add mp 11.0 header files. (v2)
      drm/amdgpu: Add nbio 7.4 support for vega20 (v3)
      drm/amdgpu: Add psp 11.0 support for vega20. (v2)
      drm/amdgpu/gfx9: Update gfx9 golden settings.
      drm/amdgpu/psp: Enlarge PSP TMR SIZE from 3M to 4M.
      drm/amdgpu:change VEGA booting with firmware loaded by PSP
      drm/amdgpu: add raven2 to gpu_info firmware
      drm/amdgpu: add raven2 vcn firmware support
      drm/amdgpu/sdma4: specify raven2 firmware.
      drm/amdgpu/sdma4: Add raven2 golden setting
      drm/amdgpu/gfx9: add support for raven2 gfx firmware
      drm/amdgpu/gfx9: add raven2 golden setting
      drm/amdgpu: Update gc_9_0 golden settings.

Felix Kuehling (6):
      drm/amdgpu: Adjust the VM size based on system memory size v2
      drm/amdgpu: Clean up KFD init and fini
      drm/amdgpu: Fix compute VM BO params after rebase v2
      drm/amdkfd: Report SDMA firmware version in the topology
      drm/amdgpu: remove unnecessary forward declaration
      drm/amdkfd: Fix incorrect use of process->mm

Frank Min (2):
      drm/amdgpu: add vega20 sriov capability detection
      drm/amdgpu: Exclude MM engines for vega20 virtual device

Fredrik Sch=C3=B6n (1):
      drm/i915: Increase LSPCON timeout

Gary Kattan (1):
      drm/amd/display: Fix DAL217 tests modify DTN logs for other tests

Gerd Hoffmann (29):
      drm/cirrus: flip default from 24bpp to 16bpp
      Add udmabuf misc device
      drm/virtio: track virtual output state
      drm/virtio: add virtio_gpu_object_detach() function
      drm/virtio: add iommu support.
      drm: replace DRIVER_PREFER_XBGR_30BPP driver flag with mode_config qu=
irk
      drm: byteorder: add DRM_FORMAT_HOST_*
      drm: do not mask out DRM_FORMAT_BIG_ENDIAN
      drm: fix drm_mode_addfb() on big endian machines.
      drm: refuse ADDFB2 ioctl for broken bigendian drivers
      udmabuf: sort headers, drop uapi/ path prefix
      udmabuf: improve map_udmabuf error handling
      udmabuf: use pgoff_t for pagecount
      udmabuf: constify udmabuf_ops
      udmabuf: constify udmabuf_create args
      udmabuf: add MEMFD_CREATE dependency
      udmabuf: rework limits
      udmabuf: improve udmabuf_create error handling
      udmabuf: use EBADFD in case we didn't got a memfd
      udmabuf: use ENOTTY for invalid ioctls
      udmabuf: drop WARN_ON() check.
      udmabuf: use sizeof(variable) instead of sizeof(type)
      drm/virtio: pass virtio_gpu_object to
virtio_gpu_cmd_transfer_to_host_{2d, 3d}
      drm: move native byte order quirk to new
drm_driver_legacy_fb_format function
      drm: use drm_driver_legacy_fb_format in drm_gem_fbdev_fb_create
      drm/bochs: fix DRM_FORMAT_* handling for big endian machines.
      drm/bochs: support changing byteorder at mode set time
      drm/virtio: fix DRM_FORMAT_* handling
      drm: move quirk_addfb_prefer_xbgr_30bpp handling to
drm_driver_legacy_fb_format too

Giulio Benetti (1):
      drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE checking if panel is use=
d.

Gloria Li (1):
      drm/amd/display: fix PIP bugs on Dal3

Guenter Roeck (1):
      drm/bridge: ti-sn65dsi86: Fix 0-day build error

Gustavo A. R. Silva (4):
      drm/sun4i: tcon-top: Use struct_size() in devm_kzalloc()
      drm/rockchip: Use struct_size() in devm_kzalloc()
      dma-buf/udmabuf: Fix NULL pointer dereference in udmabuf_create
      drm/nouveau/secboot/acr: fix memory leak

Gwan-gyeong Mun (1):
      drm/i915: Fix typo in i915_drm_resume()

Haneen Mohammed (13):
      drm/vkms: Add functions to map/unmap GEM backing storage
      drm/vkms: map/unmap buffers in [prepare/cleanup]_fb hooks
      drm/vkms: Add atomic_helper_check_plane_state
      drm/vkms: subclass CRTC state
      drm/vkms: Subclass plane state
      drm/vkms: Implement CRC debugfs API
      drm/vkms: Release pages_lock before return
      drm/vkms: Fix vmap_count increment position
      drm/vkms: Fix race condition around accessing frame number
      drm/vkms: Add cursor plane support
      drm/vkms: Compute CRC with Cursor Plane
      drm/vkms: Enable/Disable cursor support with module option
      drm/vkms: Add kerneldoc entry

Hans Verkuil (5):
      drm_dp_cec: check that aux has a transfer function
      drm_dp_cec: add note about good MegaChips 2900 CEC support
      drm_dp_mst_topology: fix broken drm_dp_sideband_parse_remote_dpcd_rea=
d()
      drm/nouveau: add DisplayPort CEC-Tunneling-over-AUX support
      drm/amdgpu: add DisplayPort CEC-Tunneling-over-AUX support

Hans de Goede (1):
      drm: panel-orientation-quirks: Add quirk for Acer One 10 (S1003)

Harish Kasiviswanathan (1):
      drm/amdgpu: Enable BAD_OPCODE intr for gfx8

Harry Wentland (2):
      drm/amdgpu: fill in amdgpu_dm_remove_sink_from_freesync_module
      drm/amd/display: Don't force UPDATE_TYPE_FULL if stream_update
has hdr_static_metadata

Hawking Zhang (2):
      drm/amdgpu: update vram_info structure in atomfirmware.h
      drm/amdgpu: fix unknown vram mem type for vega20

Heiko Stuebner (3):
      drm/rockchip: add function to check if endpoint is a subdriver
      drm/rockchip: vop: add rk3188 vop definitions
      drm/rockchip: rgb: add stub functions when rgb encoder is disabled

Hersen Wu (2):
      drm/amd/display: num of sw i2c/aux engines less than num of connector=
s
      drm/amd/display: RV2 DP MST 2nd display within daisy chain not light =
up

Huang Rui (23):
      drm/amdgpu: move gfx definitions into amdgpu_gfx header
      drm/amdgpu: move ih definitions into amdgpu_ih header
      drm/amdgpu: move sdma definitions into amdgpu_sdma header
      drm/amdgpu: move firmware definitions into amdgpu_ucode header
      drm/amdgpu: move psp macro into amdgpu_psp header
      drm/amdgpu: move gem definitions into amdgpu_gem header
      drm/amdgpu: move ring macros into amdgpu_ring header
      drm/amdgpu: remove useless gds switch macro
      drm/amdgpu: move display definitions into amdgpu_display header
      drm/amdgpu: move gmc macros into amdgpu_gmc header
      drm/amdgpu: move vm definitions into amdgpu_vm header
      drm/amdgpu: move missed gfxoff entry into amdgpu_gfx header
      drm/ttm: remove dead codes
      drm/amdgpu: add status checking after fw is loaded
      drm/ttm: add bulk move function on LRU
      drm/amdgpu: use bulk moves for efficient VM LRU handling (v6)
      drm/amdgpu: move PD/PT bos on LRU again
      drm/amdgpu: add ip blocks for picasso (v2)
      drm/amdgpu: add new raven series device
      drm/amdgpu: move get_rev_id at first before load gpu_info firmware
      drm/amdgpu: fix the VM fault while write at the top of the invisible =
vram
      drm/amdgpu: set CG flags for raven2 (v2)
      drm/amdgpu: fix the page fault of raven2

Icenowy Zheng (3):
      dt-bindings: sun4i-drm: add HDMI VCC supply property for sun8i-dw-hdm=
i
      dt-bindings: sun4i-drm: add compatible for R40 HDMI PHY
      drm/sun4i: add support for R40 HDMI PHY

Ilia Mirkin (5):
      drm/nouveau/disp: add a way to configure scrambling/tmds for hdmi 2.0
      drm/nouveau/disp/gm200-: add scdc parameter setter
      drm/nouveau/disp: keep track of high-speed state, program into clock
      drm/nouveau/disp: add support for setting scdc parameters for high mo=
des
      drm/nouveau/disp: take sink support into account for exposing 594mhz

Imre Deak (18):
      drm/i915/icl: Fix power well anonymous union initializers
      drm/i915: Rename intel_power_domains_fini() to
intel_power_domains_fini_hw()
      drm/i915/vlv: Remove redundant power well ID asserts
      drm/i915: Constify power well descriptors
      drm/i915/vlv: Use power well CTL IDX instead of ID
      drm/i915/ddi: Use power well CTL IDX instead of ID
      drm/i915: Remove redundant power well IDs
      drm/i915: Make power well ID names more uniform
      drm/i915: Use existing power well IDs where possible
      drm/i915/icl: Add missing power gate enums
      drm/i915: Fix PM refcounting w/o DMC firmware
      drm/i915: Refactor intel_display_set_init_power() logic
      drm/i915: Verify power domains after enabling them
      drm/i915: Simplify condition to keep DMC active during S0ix
      drm/i915: Don't check power domains state in intel_power_domains_init=
_hw()
      drm/i915/dp_mst: Fix enabling pipe clock for all streams
      drm/i915/bdw: Increase IPS disable timeout to 100ms
      drm/i915/gen9+: Fix initial readout for Y tiled framebuffers

Jacopo Mondi (3):
      drm: rcar-du: Improve non-DPLL clock selection
      drm: rcar-du: Rename and document dpll_ch field
      drm: rcar-du: Write ESCR and OTAR as CRTC registers

Jagan Teki (4):
      dt-bindings: display: Add compatible for A64 DE2 display pipeline
      drm/sun4i: Add support for A64 mixers
      drm/sun4i: Add support for A64 display engine
      dt-bindings: display: Add compatible for A64 HDMI

Jakub Bartmi=C5=84ski (5):
      drm/i915/guc: Avoid wasting memory on incorrect GuC pin bias
      drm/i915/guc: Do not partition WOPCM if GuC is not used
      drm/i915/guc: Move the pin bias value from GuC to GGTT
      drm/i915: Remove unnecessary ggtt_offset_bias from i915_gem_context
      drm/i915: Add a fault injection point to WOPCM init

James Zhu (34):
      drm/amdgpu: Change VCE booting with firmware loaded by PSP
      drm/amdgpu:Add error message when register failed to reach expected v=
alue
      drm/amdgpu:No action when VCN PG state is unchanged
      drm/amdgpu:Use register UVD_SCRATCH9 for VCN ring/ib test
      drm/amdgpu:Add new register offset/mask to support VCN DPG mode
      drm/amdgpu:Add DPG support flag
      drm/amdgpu:Add DPG mode read/write macro
      drm/amdgpu:Add DPG mode support for vcn 1.0
      drm/amdgpu:Add DPG pause state
      drm/amdgpu:Add DPG pause mode support
      drm/amdgpu:Enable DPG mode on PCO
      drm/amdgpu/vcn:Remove unused code
      drm/amdgpu/vcn:fix dpg pause mode hang issue
      drm/amdgpu/vcn:Replace value with defined macro
      drm/amdgpu/vcn:Correct VCN cache window definition
      drm/amdgpu/vcn:Add new register offset/mask for VCN
      drm/amdgpu/vcn:Update latest UVD_MPC register for VCN
      drm/amdgpu/vcn:Update latest spg mode stop for VCN
      drm/amdgpu/vcn:Add ring W/R PTR check for VCN DPG mode stop
      drm/amdgpu/vcn:Reduce unnecessary local variable
      drm/amdgpu/vcn:Update DPG mode VCN memory control
      drm/amdgpu/vcn:Update DPG mode VCN global tiling registers
      drm/amdgpu/vcn:Add DPG mode Register XX check
      drm/amdgpu/vcn:Remove DPG mode unused steps during vcn start
      drm/amdgpu/vcn:Apply new UMC enable for VNC DPG mode start
      drm/amdgpu/vcn:Update SPG mode VCN memory control
      drm/amdgpu/vcn:Update SPG mode VCN global tiling
      drm/amdgpu/vcn:Move SPG mode mc resume after MPC control
      drm/amdgpu/vcn:Add SPG mode Register XX check
      drm/amdgpu/vcn:Remove SPG mode unused steps during vcn start
      drm/amdgpu/vcn:Apply new UMC enable for VNC DPG mode
      drm/amdgpu/vcn:Set VCPU busy after gate power during vcn SPG start
      drm/amdgpu/vcn:Update SPG mode UVD status clear
      drm/amdgpu/vcn:Fix uninitialized symbol error

Jamie Fox (1):
      drm/malidp: Enable MMU prefetch on Mali-DP650

Jan-Marek Glogowski (1):
      drm/i915: Re-apply "Perform link quality check, unconditionally
during long pulse"

Jani Nikula (1):
      drm/i915: set DP Main Stream Attribute for color range on DDI platfor=
ms

Jay Cornwall (1):
      drm/amdkfd: Add wavefront context save state retrieval ioctl

Jernej Skrabec (4):
      drm/sun4i: tcon: Add another way for matching mixers with tcon
      drm/sun4i: tcon: Add support for R40 TCON
      drm/sun4i: Add support for HDMI voltage regulator
      dt-bindings: display: sun4i-drm: Add R40 mixer compatibles

Jeykumar Sankaran (22):
      drm/msm/dpu: remove stale display port programming
      drm/msm/dpu: remove unwanted encoder type mapping
      drm/msm/dpu: use encoder type to identify display type
      drm/msm/dpu: remove debugfs support for misr
      drm/msm/dpu: squash power handle event types
      drm/msm/dpu: remove scalar config definitions
      drm/msm/dpu: remove resource pool manager
      drm/msm/dpu: remove ping pong split topology variables
      drm/msm/dpu: enable master-slave encoders explicitly
      drm/msm/dpu: use kms stored hw mdp block
      drm/msm/dpu: iterate for assigned hw ctl in virtual encoder
      drm/msm/dpu: avoid querying for hw intf before assignment
      drm/msm/dpu: make crtc get_mixer_width helper static
      drm/msm/dpu: move hw resource tracking to crtc state
      drm/msm/dpu: rename hw_ctl to lm_ctl
      drm/msm/dpu: clean up destination scaler residue
      drm/msm/dpu: remove cdm block support from resource manager
      drm/msm/dpu: remove LOCK/CLEAR support in RM
      drm/msm/dpu: remove display H_TILE from encoder
      drm/msm/dpu: remove RM dependency on connector state
      drm/msm/dpu: relax parameter validation in encoders
      drm/msm/dpu: remove RM topology definition

Jia-Ju Bai (3):
      gpu: drm: radeon: cik: Replace mdelay() with msleep() in
cik_pcie_gen3_enable()
      gpu: drm: radeon: si: Replace mdelay() with msleep() in
si_pcie_gen3_enable()
      gpu: drm: radeon: radeon_test: Replace mdelay() with msleep()

Jiandi An (1):
      drm/virtio: add dma sync for dma mapped virtio gpu framebuffer pages

John Garry (3):
      drm/hisilicon: hibmc: Do not carry error code in HiBMC framebuffer po=
inter
      drm/hisilicon: hibmc: Don't overwrite fb helper surface depth
      drm/hisilicon: hibmc: Use HUAWEI PCI vendor ID macro

Jonathan Gray (2):
      drm/amdgpu: correct SPDX identifier in amdgpu_trace_points.c
      drm/radeon: change SPDX identifier to MIT

Jonathan Liu (1):
      drm/sun4i: tcon: Add dithering support for RGB565/RGB666 LCD panels

Joonas Lahtinen (9):
      drm/i915: Update DRIVER_DATE to 20180830
      drm/i915: Update DRIVER_DATE to 20180830
      drm/i915: Update DRIVER_DATE to 20180903
      drm/i915: Update DRIVER_DATE to 20180906
      drm/i915: Update DRIVER_DATE to 20180906
      Merge tag 'gvt-next-2018-09-04' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20180906
      drm/i915: Update DRIVER_DATE to 20180921
      drm/i915: Update DRIVER_DATE to 20180921

Jordan Crouse (8):
      drm/msm/dpu: Remove dpu_mdss_isr when dpu_mdss_destroy is called
      drm/msm/dpu: Remove an unused enum
      drm/msm/a6xx: Rename gmu phandle to qcom,gmu
      drm/msm/a6xx: Fix PDC register overlap
      msm/gpu/a6xx: Force of_dma_configure to setup DMA for GMU
      drm/msm/a6xx: Poll for HFI responses
      drm/msm/a6xx: Add inactive_period for a6xx
      drm/msm/a6xx: Remove CP perfcounter selects from the protected list

Jos=C3=A9 Roberto de Souza (1):
      drm: Return -EOPNOTSUPP in drm_setclientcap() when driver do not
support KMS

Jun Lei (6):
      drm/amd/display: Move PME to function pointer call semantics
      drm/amd/display: implement DPMS DTN test v2
      drm/amd/display: Add driver-side parsing for CM
      drm/amd/display: Add invariant support instrumentation in driver
      drm/amd/display: Add DC build_id to determine build type
      drm/amd/display: fix memory leak in resource pools

Jyoti Yadav (1):
      drm/i915/intel_csr.c Fix DMC FW Loading issue on ICL.

Jyri Sarha (2):
      drm: Add kerneldoc description for "link"-member in struct drm_panel
      drm/omap: dss: Move platform_device_register from core.c to dss.c pro=
be

Ken Chalmers (1):
      drm/amd/display: eliminate long wait between register polls on Maximu=
s

Kenneth Feng (5):
      drm/amdgpu: Add pg support for gfxoff for PCO
      drm/amdgpu: Enable SDMA power gating for PCO
      drm/amdgpu: enable mmhub power gating
      drm/amdgpu: enable vcn powergating for PCO
      drm/amdgpu: enable gfxoff in non-sriov and stutter mode by default

Kieran Bingham (7):
      MAINTAINERS: rcar-du: Add co-maintainer
      drm: rcar-du: Support interlaced video output through vsp1
      drm: rcar-du: Refactor Feature and Quirk definitions
      drm: rcar-du: Add interlaced feature flag
      drm: rcar-du: Update Gen3 output limitations
      drm: rcar-du: Remove packed VYUY support
      drm/atomic: Initialise planes with opaque alpha values

Koji Matsuoka (1):
      drm: rcar-du: Add support for missing pixel formats

Krunoslav Kovac (2):
      drm/amd/display: Handle HDR meta update as fast update
      drm/amd/display: HDR dynamic meta should be treated as stream update

Kuninori Morimoto (3):
      drm: shmobile: convert to SPDX identifiers
      drm: panel-lvds: convert to SPDX identifiers
      drm: rcar-du: Convert to SPDX identifiers

Laurent Pinchart (113):
      drm/omap: dss: Gather OMAP DSS components at probe time
      drm/omap: dss: Handle DPI and SDI port initialization failures
      drm/omap: dss: Remove omapdss_atv_ops get_wss and set_wss operations
      drm/omap: dss: Remove DSS encoders get_timings operation
      drm/omap: dss: Remove unused omapdss_default_get_timings()
      drm/omap: dss: Constify omap_dss_driver operations structure
      drm/omap: displays: Remove videomode from omap_dss_device structure
      drm/omap: dss: Remove omap_dss_device panel fields
      drm/omap: dss: Rename omap_dss_device list field to output_list
      drm/omap: dss: Create global list of all omap_dss_device instances
      drm/omap: dss: Create and use omapdss_device_is_registered()
      drm/omap: dss: Rework output lookup by port node
      drm/omap: dss: Allow looking up any device by port
      drm/omap: dss: Move common device operations to common structure
      drm/omap: dss: Add functions to connect and disconnect devices
      drm/omap: dss: Move debug message and checks to connection handlers
      drm/omap: displays: Don't call disconnect handlers directly
      drm/omap: dss: Move src and dst check and set to connection handlers
      drm/omap: displays: Remove input omap_dss_device from panel data
      drm/omap: dsi: Simplify debugfs implementation
      drm/omap: Move DSI debugfs clocks dump to dsi%u_clks files
      drm/omap: dss: Remove output devices list
      drm/omap: dss: Rename for_each_dss_dev macro to for_each_dss_display
      drm/omap: dss: Make omap_dss_get_next_device() more generic
      drm/omap: dss: Split omapdss_register_display()
      drm/omap: dss: Remove panel devices list
      drm/omap: dss: Move and rename omap_dss_(get|put)_device()
      drm/omap: dss: Store dss_device pointer in omap_dss_device
      drm/omap: dss: Move DSS mgr ops and private data to dss_device
      drm/omap: dss: Modify omapdss_find_output_from_display() to return ch=
annel
      drm/omap: dss: Replace omap_dss_device port number with bitmask
      drm/omap: dss: Extend omapdss_of_find_source_for_first_ep() to sinks
      drm/omap: displays: Don't cast dssdev to panel data unnecessarily
      drm/omap: dss: Cleanup error paths in output init functions
      drm/omap: dss: dsi: Move initialization code from bind to probe
      drm/omap: dss: hdmi4: Move initialization code from bind to probe
      drm/omap: dss: hdmi5: Move initialization code from bind to probe
      drm/omap: dss: venc: Move initialization code from bind to probe
      drm/omap: dss: Acquire next dssdev at probe time
      drm/omap: dss: Add for_each_dss_output() macro
      drm/omap: dss: Add function to retrieve display for an output
      drm/omap: dss: Remove duplicated parameter to dss_mgr_(dis)connect()
      drm/omap: dss: Get regulators at probe time
      drm/omap: Remove unneeded variable assignments in omap_modeset_init
      drm/omap: Create all planes before CRTCs
      drm/omap: Group CRTC, encoder, connector and dssdev in a structure
      drm/omap: Reverse direction of DSS device (dis)connect operations
      drm/omap: dss: Move connection checks to omapdss_device_(dis)connect
      drm/omap: dss: Move display type validation to initialization time
      drm/omap: dss: Merge two disconnection helpers
      drm/omap: Pass pipe pointer to omap_crtc_init()
      drm/omap: Store CRTC lookup by channel table in omap_drm_private
      drm/omap: Remove omap_crtc_output global array
      drm/omap: Remove supported output check in CRTC connect handler
      drm/omap: Set dispc_channel_connect from DSS output connect handlers
      drm/omap: dss: Remove the dss_mgr_(dis)connect() operations
      drm/omap: dss: Remove unused omap_dss_driver operations
      drm/omap: dss: Remove omap_dss_driver .[gs]et_mirror operations
      drm/omap: Remove unnecessary display output sanity checks
      drm/omap: Check omap_dss_device type based on the output_type field
      drm/omap: connector-hdmi: Convert to the GPIO descriptors API
      drm/omap: encoder-tfp410: Convert to the GPIO descriptors API
      drm/omap: panel-nec-nl8048hl11: Convert to the GPIO descriptors API
      drm/omap: panel-sony-acx565akm: Convert to the GPIO descriptors API
      drm/omap: panel-tpo-td028ttec1: Drop unneeded linux/gpio.h header
      drm/omap: panel-tpo-td043mtea1: Convert to the GPIO descriptors API
      drm/omap: Move most omap_dss_driver operations to omap_dss_device_ops
      drm/omap: dss: Add device operations flags
      drm/omap: Don't call .detect() operation recursively
      drm/omap: Don't call HPD registration operations recursively
      drm/omap: Remove unneeded safety checks in the HPD operations
      drm/omap: Merge HPD enable operation with HPD callback registration
      drm/omap: Move HPD disconnection handling to omap_connector
      drm/omap: Don't call EDID read operation recursively
      drm/omap: Get from CRTC to display device directly
      drm/omap: Pass both output and display omap_dss_device to encoder ini=
t
      drm/omap: Don't call HDMI mode and infoframe operations recursively
      drm/omap: Pass both output and display omap_dss_device to connector i=
nit
      drm/omap: Determine connector type directly in omap_connector.c
      drm/omap: dss: hdmi: Rename hdmi_display_(set|check)_timing() functio=
ns
      drm/omap: encoder-tfp410: Don't fix timings in .set_timings() handler
      drm/omap: Make the video_mode pointer to .set_timings() const
      drm/omap: Remove duplicate calls to .set_timings() operation
      drm/omap: Remove unneeded fallback for missing .check_timings()
      drm/omap: Don't store video mode internally for external encoders
      drm/omap: Store bus flags in the omap_dss_device structure
      drm/omap: Don't call .check_timings() operation recursively
      drm/omap: Query timing information from analog TV encoder
      drm/omap: Remove .get_timings() operation from display connectors
      drm/omap: panels: Don't modify fixed timings
      drm/omap: Move bus flag hack to encoder implementation
      drm/omap: Split mode fixup and mode set from encoder enable
      drm/omap: Call dispc timings check operation directly
      drm/omap: dpi: Don't fixup video mode in dpi_set_mode()
      drm/omap: dsi: Fixup video mode in .set_config() operation
      drm/omap: hdmi: Constify video mode and related pointers
      drm/omap: sdi: Fixup video mode in .check_timings() operation
      drm/omap: venc: Fixup video mode in .check_timings() operation
      drm/omap: Store CRTC timings in .set_timings() operation
      drm/omap: Don't call .set_timings() operation recursively
      MAINTAINERS: Update tree location for the Renesas DRM drivers
      drm: rcar-du: Rework clock configuration based on hardware limits
      drm: rcar-du: Update framebuffer pitch and alignment limits for Gen3
      dt-bindings: display: renesas: du: Document r8a77990 bindings
      dt-bindings: display: renesas: lvds: Document r8a77990 bindings
      dt-bindings: display: renesas: lvds: Add EXTAL and DU_DOTCLKIN clocks
      drm: bridge: thc63: Restrict modes based on hardware operating freque=
ncy
      drm: rcar-du: lvds: D3/E3 support
      drm: rcar-du: Perform the initial CRTC setup from rcar_du_crtc_get()
      drm: rcar-du: Use LVDS PLL clock as dot clock when possible
      drm: rcar-du: Enable configurable DPAD0 routing on Gen3
      drm: rcar-du: Cache DSYSR value to ensure known initial value
      drm: rcar-du: Don't use TV sync mode when not supported by the hardwa=
re

Lee, Shawn C (3):
      drm: Add support for device_id based detection.
      drm: Change limited M/N quirk to constant N quirk.
      drm: add LG eDP panel to quirk database

Leo (Sunpeng) Li (2):
      drm/amd/display: Remove redundant non-zero and overflow check
      drm/amd/display: Use non-deprecated vblank handler

Leo Li (5):
      drm/amd/display: Use DRM helper for best_encoder
      drm/amd/display: Drop amdgpu_display_manager.dal member
      drm/amd/display: Drop amdgpu_dm_prev_state struct
      drm/amd/display: Remove mst_hotplug_work
      drm/amd/display: Flatten irq handler data struct

Leonard Crestez (5):
      drm/mxsfb: Move axi clk enable/disable to crtc enable/disable
      drm/mxsfb: Fix initial corrupt frame when activating display
      drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
      drm/mxsfb: Add PM_SLEEP support
      drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm

Likun Gao (15):
      drm/amdgpu/vg20: Change the load type of vega20 to psp (v2)
      drm/amdgpu: add picasso to asic_type enum
      drm/amdgpu: add soc15 support for picasso
      drm/amdgpu: add picasso support for vm
      drm/amd/display/dm: add picasso support
      drm/amdgpu: Add support of powerplay for picasso
      drm/amdgpu: initilize picasso psp firmwares support
      drm/amdgpu: add picasso ucode loading method
      drm/amdgpu: add picasso support for vcn
      drm/amdgpu: add clockgating support for picasso
      drm/amdgpu: add picasso support for gmc
      drm/amdgpu: add picasso support for gfx_v9_0
      drm/amdgpu: add picasso support for sdma_v4
      drm/amdgpu: add picasso for amdgpu kms
      drm/amdgpu: add psp support for raven2

Lionel Landwerlin (3):
      drm/i915: clear error registers after error capture
      drm/i915/perf: simplify configure all context function
      drm/i915/perf: reuse intel_lrc ctx regs macro

Liviu Dudau (2):
      drm/arm/malidp: Validate rotations for compressed/uncompressed
framebuffers for each layer
      drm: malidp: Add the size of the superblocks when calculating
total size for AFBC buffers

Lowry Li (2):
      drm: Add per-plane pixel blend mode property
      drm/mali-dp: Implement plane alpha and pixel blend on malidp

Lucas De Marchi (5):
      drm/i915/icl: move has_resource_streamer to GEN11_FEATURES
      drm/i915: kill resource streamer support
      drm/i915: make PCH_GMBUS* definitions private to gvt
      drm/i915/gvt: use its own define for gpio
      drm/i915: remove confusing GPIO vs PCH_GPIO

Lyude Paul (13):
      drm/print: Fix DRM_DEBUG_DP macro
      drm/amdgpu: Suppress keypresses from ACPI_VIDEO events
      drm/nouveau: Check backlight IDs are >=3D 0, not > 0
      drm/nouveau: Add NV_PRINTK_ONCE and variants
      drm/nouveau: Move backlight device into nouveau_connector
      drm/nouveau/drm/nouveau: s/nouveau_backlight_exit/nouveau_backlight_f=
ini/
      drm/nouveau: Cleanup indenting in nouveau_backlight.c
      drm/nouveau: Refactor nvXX_backlight_init()
      drm/nouveau: Fix potential memory leak in nouveau_drm_load()
      drm/nouveau: Start using new drm_dev initialization helpers
      drm/i915: Don't unset intel_connector->mst_port
      drm/i915: Skip vcpi allocation for MSTB ports that are gone
      drm/i915: Fix intel_dp_mst_best_encoder()

Maarten Lankhorst (2):
      drm/i915: Allow control of PSR at runtime through debugfs, v6
      drm/i915/psr: Add debugfs support to force a downgrade to PSR1 mode.

Maciej Purski (3):
      drm/exynos: rename bridge_node to in_bridge_node
      drm/exynos: move connector creation to attach callback
      drm/exynos: enable out_bridge in exynos_dsi_enable

Madhav Chauhan (1):
      drm/i915/icl: Define T_INIT_MASTER registers

Mahesh Kumar (20):
      drm/i915: ddb_size is of u16 type
      drm/i915/skl: distribute DDB based on panel resolution
      drm: crc: Introduce verify_crc_source callback
      drm: crc: Introduce get_crc_sources callback
      drm/rockchip/crc: Implement verify_crc_source callback
      drm/amdgpu_dm/crc: Implement verify_crc_source callback
      drm/rcar-du/crc: Implement verify_crc_source callback
      drm/i915/crc: implement verify_crc_source callback
      drm/i915/crc: implement get_crc_sources callback
      drm/rcar-du/crc: Implement get_crc_sources callback
      drm/vkms/crc: Implement verify_crc_source callback
      drm/crc: Cleanup crtc_crc_open function
      Revert "drm: crc: Wait for a frame before returning from open()"
      drm/i915/bxt: Decode memory bandwidth and parameters
      drm/i915/skl+: Decode memory bandwidth and parameters
      drm/i915: Implement 16GB dimm wa for latency level-0
      drm/i915/skl+: don't trust IPC value set by BIOS
      drm/i915/kbl+: Enable IPC only for symmetric memory configurations
      drm/i915/icl: create function to identify combophy port
      drm/i915/icl: Fix DDI/TC port clk_off bits

Manasi Navare (6):
      drm/i915/icl: Add remaining registers and bitfields for MG PHY DDI
      drm/i915/icl: Implement voltage swing programming sequence for MG PHY=
 DDI
      drm/i915/icl: Implement HSDIV_RATIO of MG_CLKTOP2_HSCLKCTL_PORT
reg as separate divider value defines
      drm/i915/icl: Get DDI clock for ICL for MG PLL and TBT PLL
      drm/i915/dsc: Fix PPS register definition macros for 2nd VDSC engine
      drm/i915/dp: Link train Fallback on eDP only if fallback link BW
can fit panel's native mode

Marc Zyngier (2):
      drm/rockchip: Allow driver to be shutdown on reboot/kexec
      drm/bridge: analogix_dp: Downgrade "Link Training" messages to dev_db=
g

Marek Szyprowski (1):
      drm/exynos: gsc: Add support for tiled formats

Martin Tsai (1):
      drm/amd/display: correct image viewport calculation

Masahiro Yamada (1):
      drm/bridge/synopsys: remove commented-out flag in Makefile

Masanari Iida (1):
      drm/amdgpu: Fix warnings while make xmldocs

Mathieu Malaterre (1):
      drm/radeon: change function signature to pass full range

Matt Atwood (1):
      drm/dp: add extended receiver capability field present bit

Matthew Auld (3):
      drm/i915/gtt: remove px_page
      drm/i915: don't assume struct page in i915_sg_trim
      drm/i915: pass dev_priv to i915_gem_cleanup_stolen

Mauro Rossi (3):
      drm/amd/display: enable ABGR and XBGR formats (v4)
      drm/amdgpu: enable ABGR and XBGR formats (v2)
      drm/radeon: enable ABGR and XBGR formats (v2)

Maxime Ripard (1):
      drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=3Dm

Michal Wajdeczko (1):
      drm/i915/guc: Update GuC power domain states

Micha=C5=82 Miros=C5=82aw (15):
      fbdev: show fbdev number for debugging
      fbdev: allow apertures =3D=3D NULL in remove_conflicting_framebuffers=
()
      fbdev: add kerneldoc do remove_conflicting_framebuffers()
      fbdev: add remove_conflicting_pci_framebuffers()
      drm/amdgpu: use simpler remove_conflicting_pci_framebuffers()
      drm/cirrus: use simpler remove_conflicting_pci_framebuffers()
      drm/bochs: use simpler remove_conflicting_pci_framebuffers()
      drm/radeon: use simpler remove_conflicting_pci_framebuffers()
      drm/mgag200: use simpler remove_conflicting_pci_framebuffers()
      drm/virtio: use simpler remove_conflicting_pci_framebuffers()
      drm/vc4: use simpler remove_conflicting_framebuffers(NULL)
      drm/sun4i: use simpler remove_conflicting_framebuffers(NULL)
      drm/tegra: kick out simplefb
      fbdev: fix kerneldoc
      drm/fb-helper: document remove*_conflicting_framebuffers()

Micha=C5=82 Winiarski (1):
      drm/i915/kvmgt: Fix compilation error

Michel D=C3=A4nzer (5):
      drm/doc: Adapt GPU scheduler references for renamed C file
      drm/amdgpu: Only retrieve GPU address of GART table after pinning it
      Revert "drm/amdgpu: move PD/PT bos on LRU again"
      drm/ttm: Initialize local lists in ttm_bo_bulk_move_helper
      drm/amdgpu: Initialize fences array entries in amdgpu_sa_bo_next_hole

Mika Kuoppala (3):
      Revert "drm/i915/icl: WaEnableFloatBlendOptimization"
      drm/i915: Expose retry count to per gen reset logic
      drm/i915: Force reset on unready engine

Mikita Lipski (1):
      drm/amd/display: pass the right num of modes added

Murton Liu (1):
      drm/amd/display: HLK Periodic Frame Notification test failed

Nathan Chancellor (3):
      drm/amd/powerplay: Change id parameter type in
pp_atomfwctrl_get_clk_information_by_clkid
      drm/amd/display: Use proper enums in process_channel_reply
      drm/scheduler: Simplify spsc_queue_count check in
drm_sched_entity_select_rq

Nathan Ciobanu (3):
      drm/i915/dp: Limit link training clock recovery loop
      drm/i915/dp: Refactor max_vswing_tries variable
      drm/i915/dp: Improve clock recovery loop limit comment

Nayan Deshmukh (6):
      drm/scheduler: add a list of run queues to the entity
      drm/scheduler: add counter for total jobs in scheduler
      drm/scheduler: add new function to get least loaded sched v2
      drm/scheduler: move idle entities to scheduler with less load v2
      drm/scheduler: avoid redundant shifting of the entity v2
      drm/scheduler: remove timeout work_struct from drm_sched_job (v3)

Neil Armstrong (1):
      drm/fb_helper: Allow leaking fbdev smem_start

Nicholas Kazlauskas (8):
      drm/amd/display: Set DFS bypass flags for dce110
      drm/amd/display: Enable DFS bypass support in DC config
      drm/amd/display: Add support for toggling DFS bypass
      drm/amd/display: Add support for hw_state logging via debugfs
      drm/amd/display: Support reading hw state from debugfs file
      drm/amd/display: Guard against null stream dereference in do flip
      drm/amd/display: Raise dispclk value for dce120 by 15%
      drm/amd/display: Raise dispclk value for dce_update_clocks

Nick Alcock (1):
      drm/radeon: ratelimit bo warnings

Nikola Cornij (4):
      drm/amd/display: Print DPP DTN log info only for enabled pipes
      drm/amd/display: Define registers for dcn10
      drm/amd/display: Refactor FPGA-specific link setup
      drm/amd/display: Add a check-function for virtual signal type

Noralf Tr=C3=B8nnes (9):
      drm/fb-helper: Improve error reporting in setup
      drm/arm/hdlcd: Use drm_fbdev_generic_setup()
      drm/arm/mali: Use drm_fbdev_generic_setup()
      drm/imx: Use drm_fbdev_generic_setup()
      drm/pl111: Use drm_fbdev_generic_setup()
      drm/sti: Use drm_fbdev_generic_setup()
      drm/tve200: Use drm_fbdev_generic_setup()
      drm/vc4: Use drm_fbdev_generic_setup()
      drm/zte: Use drm_fbdev_generic_setup()

Oak Zeng (3):
      drm/amdgpu: Set pasid for compute vm (v2)
      drm/amdkfd: Release an acquired process vm
      drm/amdgpu: Move fault hash table to amdgpu vm

Oleksandr Andrushchenko (1):
      drm: Replace NULL with error value in drm_prime_pages_to_sg

P Raviraj Sitaram (1):
      drm/i915/chv: Update csc coefficient matrix during modeset

Paul Kocialkowski (2):
      drm/sun4i: sun4i: Register quirks with the backend structure
      drm/sun4i: sun4i: Introduce a quirk for lowest plane alpha support

Paul Menzel (2):
      drm/amdgpu: Do not evict VRAM on APUs with disabled HIBERNATE
      drm/radeon: Do not evict VRAM on APUs with disabled HIBERNATE

Paulo Zanoni (14):
      drm/i915/icl: compute the TBT PLL registers
      drm/i915/icl: implement icl_digital_port_connected()
      drm/i915/icl: store the port type for TC ports
      drm/i915/icl: program MG_DP_MODE
      drm/i915/icl: toggle PHY clock gating around link training
      drm/i915/icl: don't set CNL_DDI_CLOCK_REG_ACCESS_ON anymore
      drm/i915: inline skl_copy_ddb_for_pipe() to its only caller
      drm/dp: add missing ')' to I2C nack debug message
      drm/i915/icl: avoid unclaimed PLANE_NV12_BUF_CFG register
      drm/i915/icl: account for context save/restore removed bits
      drm/i915/icl: implement the tc/legacy HPD {dis,}connect flows
      drm/i915: WARN() if we can't lookup_power_well()
      drm/i915: use for_each_power_well in lookup_power_well()
      drm/i915: move lookup_power_well() up

Peter Rosin (8):
      drm/sti: do not remove the drm_bridge that was never added
      drm/atmel-hlcdc: prefer a higher rate clock as pixel-clock base
      drm/atmel-hlcdc: allow selecting a higher pixel-clock than requested
      dt-bindings: display: bridge: lvds-transmitter: add ti, ds90c185
      dt-bindings: display: atmel: optional video-interface of endpoints
      drm/atmel-hlcdc: always iterate over the first 4 output endpoints
      drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
      drm: bridge: document bridge attach/detach imbalance

Peter Ujfalusi (6):
      drm/omap: Allocate drm_device earlier and unref it as last step
      drm/omap: Manage the usable omap_dss_device list within omap_drm_priv=
ate
      drm/omap: Do dss_device (display) ordering in omap_drv.c
      drm/omap: dss: Remove display ordering from dss/display.c
      drm/omap: dmm_tiler: No need to check if irq is valid in omap_dmm_rem=
ove
      drm/omap: dmm_tiler: Fix interrupt request/free sequence during
probe/remove

Peter Wu (6):
      qxl: fix null-pointer crash during suspend
      bochs: use drm_fb_helper_set_suspend_unlocked in suspend/resume
      bochs: convert to drm_fb_helper_fbdev_setup/teardown
      bochs: convert to drm_dev_register
      drm/fb-helper: improve documentation and print warnings
      qxl: refactor to use drm_fb_helper_fbdev_setup

Philip Yang (1):
      drm/amdgpu: remove redundant memset

Pratik Vishwakarma (1):
      drm/amdgpu: skip IB tests for KIQ in general

Rex Zhu (74):
      drm/amd/display: Fix bug use wrong pp interface
      drm/amd/pp: Add ACP PG support in SMU
      drm/amdgpu: Power down acp if board uses AZ (v2)
      drm/amdgpu/acp: Powrgate acp via smu
      drm/amgpu/acp: Implement set_powergating_state for acp
      drm/amd/pp: Implement get_performance_level for legacy dgpu
      drm/amdgpu: Add amdgpu_gfx_off_ctrl function
      drm/amdgpu: Put enable gfx off feature to a delay thread
      drm/amdgpu: Ctrl gfx off via amdgpu_gfx_off_ctrl
      drm/amdgpu: Disable gfx off if VCN is busy
      drm/amd/pp: Delete duplicated interface in hwmgr_func
      drm/amdgpu: Delay 100ms to enable gfx off feature
      drm/amdgpu: Cancel gfx off delay work when driver fini/suspend
      drm/amdgpu: Cancel the delay work when suspend
      drm/amd/pp: OverDrive gfx domain voltage on Tonga
      drm/amdgpu: Refine function name and function args
      drm/amdgpu: Set power ungate state when suspend/fini
      drm/amdgpu: Set clock ungate state when suspend/fini
      drm/amdgpu: Fix compile warning
      drm/amdgpu: Enable/disable gfx PG feature in rlc safe mode
      drm/amdgpu: Remove duplicated power source update
      drm/amdgpu: Fix vce initialize failed on Kaveri/Mullins
      drm/amdgpu: Update power state at the end of smu hw_init.
      drm/amdgpu: Power on uvd block when hw_fini
      drm/amdgpu: Remove dead code in amdgpu_pm.c
      drm/amdgpu: Remove duplicate code in gfx_v8_0.c
      drm/amdgpu: Refine gfx_v8_0_kcq_disable function
      drm/amdgpu: Remove duplicate code in gfx_v9_0.c
      drm/amdgpu: Refine gfx_v9_0_kcq_disable function
      drm/amdgpu: Change kiq initialize/reset sequence on gfx8
      drm/amdgpu: Change kiq ring initialize sequence on gfx9
      drm/amd/dc: Trigger set power state task when display
configuration changes
      drm/amd/pp: Honour DC's clock limits on Rv
      drm/amd/pp: Return error immediately if load firmware failed
      drm/amdgpu: Refine function name
      drm/amdgpu: Halt rlc/cp in rlc_safe_mode
      drm/amdgpu: Remove redundant code in gfx_v8_0.c
      drm/amd/pp: Disable dpm features on smu7/8 when suspend
      drm/amdgpu: Fix comments error in sdma_v4_1_update_power_gating
      drm/amd/pp: Fix fan's RPM setting not work on VI/Vega10
      drm/amd/pp: Avoid divide-by-zero in fan_ctrl_set_fan_speed_rpm
      drm/amd/pp: Expose the smu support for SDMA PG cntl
      drm/amdgpu: Move out power up/down sdma out of smu
      drm/amd/pp: Remove uncessary extra vcn pg cntl in smu
      drm/amd/pp: Remove wrong code in fiji_start_smu
      drm/amdgpu: Refine uvd_v6/7_0_enc_get_destroy_msg
      drm/amdgpu: Add new AMDGPU_PP_SENSOR_MIN/MAX_FAN_RPM sensor
      drm/amd/pp: Implement AMDGPU_PP_SENSOR_MIN/MAX_FAN_RPM
      drm/amdgpu: Add fan RPM setting via sysfs
      drm/amdgpu: Disable sysfs pwm1 if not in manual fan control
      drm/amdgpu: Always enable fan sensors for read
      drm/amdgpu: Drop dead define in amdgpu.h
      drm/amd/pp: Fix memory leak on CI/AI
      drm/amdgpu: Move gfx flag in_suspend to adev
      drm/amd/pp: Refine function iceland_start_smu
      drm/amd/pp: Setup SoftRegsStart before request smu load fw
      drm/amd/pp: Refine smu7/8 request_smu_load_fw callback function
      drm/amdgpu: Remove FW_LOAD_DIRECT type support on VI
      drm/amdgpu: Don't reallocate ucode bo when suspend
      drm/amd/pp: Allocate ucode bo in request_smu_load_fw
      drm/amd/pp: Implement load_firmware interface
      drm/amdgpu: Add fw load in gfx_v8 and sdma_v3
      drm/amdgpu: Change VI gfx/sdma/smu init sequence
      drm/amdgpu: Change SI/CI gfx/sdma/smu init sequence
      drm/amdgpu: Change AI gfx/sdma/smu init sequence
      drm/amdgpu: Refine function amdgpu_device_ip_late_init
      drm/amdgpu: Check late_init status before set cg/pg state
      drm/amdgpu: Split amdgpu_ucode_init/fini_bo into two functions
      drm/amdgpu: Remove amdgpu_ucode_fini_bo
      drm/amdgpu: split ip hw_init into 2 phases
      drm/amdgpu: Load fw between hw_init/resume_phase1 and phase2
      drm/amdgpu: Remove wrong fw loading type warning
      drm/amdgpu: Remove the direct fw loading support for sdma2.4
      drm/amdgpu: Fix typo in amdgpu_vmid_mgr_init

Rob Clark (2):
      drm/msm/rd: fix crash with long process cmdlines
      drm/msm: update generated headers

Rodrigo Vivi (8):
      drm/i915: Remove unused "ret" variable.
      drm/i915: Fix psr sink status report.
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915/cfl: Add a new CFL PCI ID.
      drm/i915: Free write_buf that we allocated with kzalloc.
      drm/i915: introduce dp_to_i915() helper
      drm/i915: Use dp_to_i915 on intel_psr.c
      drm/i915/icl: Fix signal_levels

Roman Li (1):
      drm/amd/display: Fix warning storm on Raven2

Samson Tam (2):
      drm/amd/display: decouple front and backend pgm using dpms_off
as backend enable flag
      drm/amd/display: use proper pipe_ctx index

Sandeep Panda (2):
      dt-bindings: drm/bridge: Document sn65dsi86 bridge bindings
      drm/bridge: add support for sn65dsi86 bridge driver

Sandy Huang (6):
      dt-bindings: display: rockchip: add document for px30 vop
      drm/rockchip: vop: add px30 vop support
      drm/rockchip: fix coding style and incorrect description
      drm/rockchip: vop: fix some register define error for px30
      drm/rockchip: Add support for Rockchip Soc RGB output interface
      drm/rockchip: vop: Add directly output rgb feature for px30

Sean Paul (33):
      drm/bridge/ti-sn65dsi86: Fix implicit declaration to
drm_mode_connector_attach_encoder
      drm/bridge: ti-sn65dsi86: Fixup register names
      drm/bridge: ti-sn65dsi86: Implement AUX channel
      drm/bridge: ti-sn65dsi86: Move panel_prepare() to pre_enable()
      drm/bridge: ti-sn65dsi86: Poll for DP PLL Lock
      drm/bridge: ti-sn65dsi86: Poll for training complete
      drm/panel: Fix sphinx warning
      Merge drm/drm-next into drm-misc-next
      drm/bridge: ti-sn65dsi86: Add mystery delay to enable()
      drm: Describe pixel_blend_mode in drm_plane_state
      MAINTAINERS: Move udl drm driver to drm-misc tree
      MAINTAINERS: Move mxsfb drm driver to drm-misc tree
      Merge drm/drm-next into drm-misc-next
      drm/msm: dsi: Initialize msm_dsi->id to -1
      drm/msm: dsi: Return errors whan dt parsing fails
      drm/msm: Don't fail bind if nothing connected to dsi
      drm/msm: dpu: Allow planes to extend past active display
      drm/msm: dpu: Remove impossible checks
      drm/msm: dpu: Move atomic_check_plane_state() call to atomic_check
      drm/msm: dpu: Consolidate atomic_check functions()
      drm/msm: dpu: Remove dpu_plane_sspp_enabled()
      drm/msm: dpu: Remove dpu_plane_enabled()
      drm/msm: dpu: Make dpu_plane_sspp_atomic_update() void
      drm/msm: dpu: Don't continue after error in atomic_check
      drm/msm: dpu: Clear frame_busy_mask bit after trace
      drm/msm: dpu: Add extra_flush_bits to trigger_flush trace
      drm/msm: dpu: Don't store/deref pointers in trace ringbuffer
      drm/msm: dpu: Don't reset dpu_enc->cur_master on .disable()
      drm/msm: a5xx: Fix improper u64 division
      drm/msm: dpu: Fix memory leak caused by dropped reference
      drm/msm: a5xx: Remove unneeded parens
      drm/msm: a6xx: Fix improper u64 division
      MAINTAINERS: Add Maxime Ripard as drm-misc maintainer

Sergei Shtylyov (3):
      dt-bindings: display: renesas: du: document R8A77980 bindings
      dt-bindings: display: renesas: lvds: document R8A77980 bindings
      drm: rcar-du: lvds: add R8A77980 support

Shaoyun Liu (15):
      drm/amd/include: update the bitfield define for PF_MAX_REGION
      drm/amdgpu : Add psp function interfaces for XGMI support
      drm/amdgpu: Add place holder functions for xgmi topology
interface with psp
      drm/amdgpu : Generate XGMI topology info from driver level
      drm/amd/include: Add get_hive_id interface in kfd2kgd
      drm/amdgpu: get_hive_id from amdgpu side (v2)
      drm/amdkfd: kfd expose the hive_id of the device through its
node properties
      drm/amdkfd: Add new iolink type defines
      drm/amdkfd: Generate xGMI direct iolink
      drm/amdgpu: Doorbell assignment for 8 sdma user queue per engine
      drm/amdkfd: Make the number of SDMA queues variable
      drm/amd: Interface change to support 64 bit page_table_base
      drm/amdgpu: Add vega20 support on kfd probe
      drm/amdkfd: Vega20 bring up on amdkfd side
      drm/amdkfd: Remove the requirement for atomic Ops on vg20

Sharat Masetty (6):
      drm/msm/a6xx: Send the right perf index value to GMU
      drm/msm/a5xx: Skip hardware preemption init if no preemption
      drm/msm: suspend devfreq on init
      drm/msm/a6xx: Add gmu_read64() register read op
      drm/msm: re-factor devfreq code
      drm/msm/a6xx: Add devfreq support for a6xx

Shirish S (2):
      drm/amd/display: Signal hw_done() after waiting for flip_done()
      drm/amdgpu: remove the intterupt handling for the KIQ events

SivapiriyanKumarasamy (6):
      drm/amd/display: Program vline interrupt on FAST update
      drm/amd/display: Program gamut remap as part of stream update
      drm/amd/display: Program csc matrix as part of stream update
      drm/amd/display: Fix memory leak caused by missed dc_sink_release
      drm/amd/display: Add color bit info to freesync infoframe
      drm/amd/display: fix gamma not being applied

Souptick Joarder (9):
      drm/vkms: Use new return type vm_fault_t
      drm/rockchip: Convert drm_atomic_helper_suspend/resume()
      drm: Remove drm_fbdev_cma_set_suspend()
      gpu: drm: virtio: code cleanup
      Document/gpu: Use new vm_fault_t type
      drm/tegra: Convert drm_atomic_helper_suspend/resume()
      gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
      gpu/drm/hisilicon: Convert drm_atomic_helper_suspend/resume()
      drm/tilcdc: Convert drm_atomic_helper_suspend/resume()

Sravanthi Kollukuduru (2):
      drm/msm/dpu: enable cursor plane on dpu
      drm/msm/dpu: fix for cursor blend issue

Stefan Agner (2):
      drm/doc: clarify how to acquire required vblank event reference
      MAINTAINERS: Move fsl-dcu driver to drm-misc tree

Stephen Boyd (1):
      drm/msm/disp/dpu: Use proper define for drm_encoder_init() 'encoder_t=
ype'

Su Sung Chung (3):
      drm/amd/display: program v_update and v_ready with proper field
      drm/amd/display: Calculate swizzle mode using bpp during validation
      drm/amd/display: fix bug of accessing invalid memory

Tao Zhou (3):
      drm/amdgpu: Fix SDMA hang in prt mode v2
      drm/amdgpu: add CP_DEBUG register definition for GC9.0
      drm/amdgpu: fix CPDMA hang in PRT mode

Thierry Reding (6):
      drm/tegra: dc: Do not register DC without primary plane
      drm/tegra: hub: Add Tegra194 support
      drm/tegra: dc: Add Tegra194 support
      drm/tegra: dpaux: Add Tegra194 support
      drm/tegra: sor: Add Tegra194 support
      gpu: host1x: Remove spurious tab

Thomas Hellstrom (19):
      drm/ttm, drm/vmwgfx: Move the lock- and object functionality to
the vmwgfx driver
      drm/vmwgfx: Add a validation module v2
      drm/vmwgfx: Modify the resource validation interface
      drm/vmwgfx: Adapt execbuf to the new validation api
      drm/vmwgfx: Use new validation interface for the modesetting code v2
      drm/vmwgfx: Use a validation context allocator for relocations
and validations
      drm/vmwgfx: Reduce the size of buffer object relocations
      drm/vmwgfx: Replace unconditional mutex unlocked warnings with
lockdep counterpart
      drm/vmwgfx: Remove the resource avail field
      drm/vmwgfx: Remove the user resource destructor check
      drm/vmwgfx: Make the object handles idr-generated
      drm/vmwgfx: Look up objects without taking a reference
      drm/ttm: Export ttm_bo_get_unless_zero()
      drm/vmwgfx: Adapt validation code for reference-free lookups
      drm/vmwgfx: Look up user buffer objects without taking a reference
      drm/vmwgfx: Make buffer object lookups reference-free during validati=
on
      drm/vmwgfx: Don't refcount command-buffer managed resource
lookups during command buffer validation
      drm/vmwgfx: Don't refcount cotable lookups during command buffer
validation
      drm/vmwgfx: Make user resource lookups reference-free during validati=
on

Thomas Zimmermann (23):
      drm/rockchip: Replace drm_dev_unref with drm_dev_put
      drm/tinydrm: Replace drm_dev_unref with drm_dev_put
      drm/vgem: Replace drm_dev_unref with drm_dev_put
      drm/cirrus: Use drm_framebuffer_put to avoid kernel oops in clean-up
      drm/qxl: Replace drm_dev_unref with drm_dev_put
      drm/virtio: Replace drm_dev_unref with drm_dev_put
      drm/gma500: Do not include <drm/drm_global.h>
      drm/bochs: Replace ttm_bo_unref with ttm_bo_put
      drm/cirrus: Replace ttm_bo_unref with ttm_bo_put
      drm/qxl: Replace ttm_bo_unref with ttm_bo_put
      drm/virtio: Replace ttm_bo_reference with ttm_bo_get
      drm/virtio: Replace ttm_bo_unref with ttm_bo_put
      drm/hisilicon: Replace drm_dev_unref with drm_dev_put
      drm/hisilicon: Replace ttm_bo_unref with ttm_bo_put
      drm/udl: Replace drm_dev_unref with drm_dev_put
      drm/tegra: Replace drm_dev_unref with drm_dev_put
      drm/fsl-dcu: Replace drm_dev_unref with drm_dev_put
      drm/omap: Replace drm_gem_object_{un/reference} with put,get function=
s
      drm/omap: Replace drm_gem_object_unreference_unlocked with put functi=
on
      drm/omap: Replace drm_dev_unref with drm_dev_put
      drm/msm: Replace drm_framebuffer_{un/reference} with put, get functio=
ns
      drm/msm: Replace drm_gem_object_{un/reference} with put, get function=
s
      drm/msm: Replace drm_dev_unref with drm_dev_put

Tom St Denis (1):
      drm/amd/amdgpu: Avoid fault when allocating an empty buffer object

Tomi Valkeinen (3):
      drm/omap: fix memory barrier bug in DMM driver
      drm/omap: partial workaround for DRA7xx DMM errata i878
      drm/omap: fix use of freed memory

Tony Cheng (9):
      drm/amd/display: dal 3.1.60
      drm/amd/display: dc 3.1.61
      drm/amd/display: dc 3.1.62
      drm/amd/display: dc 3.1.63
      drm/amd/display: dc 3.1.64
      drm/amd/display: dc 3.1.65
      drm/amd/display: dc 3.1.66
      drm/amd/display: dc 3.1.67
      drm/amd/display: dc 3.1.68

Tvrtko Ursulin (3):
      drm/i915: Explicitly mark Global GTT address spaces
      drm/i915/icl: Fix context RPCS programming
      i915/oa: Simplify updating contexts

Ulrich Hecht (1):
      drm: rcar-du: Add r8a77990 and r8a77995 device support

Vijendar Mukunda (1):
      drm/amd/amdgpu: Enabling Power Gating for Stoney platform

Vijetha Malkai (1):
      drm/amdgpu: Style fixes to PRIME code documentation

Ville Syrj=C3=A4l=C3=A4 (29):
      drm/i915: Fix glk/cnl display w/a #1175
      drm/i915: Fix gtt_view asserts
      drm/i915: Don't pass plane to .check_plane()
      drm/i915: Reject compressed Y/Yf with interlaced modes
      drm/i915: Fix ICL+ HDMI clock readout
      drm/i915: s/tile_offset/aligned_offset/ etc.
      drm/i915: Add .max_stride() plane hook
      drm/i915: Use pipe A primary plane .max_stride() as the global
stride limit
      drm/i915: Rename the plane_state->main/aux to plane_state->color_plan=
e[]
      drm/i915: Store the final plane stride in plane_state
      drm/i915: Store ggtt_view in plane_state
      drm/i915: s/int plane/int color_plane/
      drm/i915: Nuke plane->can_scale/min_downscale
      drm/i915: Extract per-platform plane->check() functions
      drm/i915: Move skl plane fb related checks into a better place
      drm/i915: Move display w/a #1175
      drm/i915: Move chv rotation checks to plane->check()
      drm/i915: Extract intel_cursor_check_surface()
      drm: Introduce per-device driver_features
      drm/i915: Clear DRIVER_ATOMIC on a per-device basis
      drm/amdgpu: Use per-device driver_features to disable atomic
      drm/i915: Replace some PAGE_SIZE with I915_GTT_PAGE_SIZE
      drm/i915: Fix a potential integer overflow with framebuffers
extending past 4 GiB
      drm/i915: Replace some PAGE_SHIFTs with I915_GTT_PAGE_SIZE
      drm/i915: Fix logic fumble in rotation vs. ccs check
      drm/i915/sdvo: Fix multi function encoder stuff
      drm/i915: Check fb stride against plane max stride
      drm/i915: Restore vblank interrupts earlier
      drm/i915: Use the correct crtc when sanitizing plane mapping

Vitaly Prosyak (2):
      drm/amd/display: Use DGAM ROM or RAM
      drm/amd/display: Add check for num of entries in gamma

Wei Yongjun (1):
      drm/vkms: Fix possible memory leak in _vkms_get_crc()

Wen Yang (1):
      drm/amd/display: fix a compile warning

Yintian Tao (2):
      drm/amdgpu: remove fulll access for suspend phase1
      drm/amdgpu: move full access into amdgpu_device_ip_suspend

Yongqiang Sun (1):
      drm/amd/display: WA for DF keeps awake after S0i3.

YueHaibing (6):
      drm/virtio: Remove set but not used variable 'bo'
      drm: Remove set but not used variable 'config'
      drm/omap: remove set but not used variable 'frame_height'
      drm/amdkfd: Remove set but not used variable 'preempt_all_queues'
      drm/amdgpu: remove set but not used variable 'ring' in psp_v11_0_ring=
_stop
      drm/amdgpu: remove set but not used variable 'header'

Zhao Yan (2):
      drm/i915/gvt: add a fastpath for cmd parsing on MI_NOOP
      drm/i915/gvt: only copy the first page for restore inhibit context

Zhenyu Wang (3):
      drm/i915/gvt: make dma map/unmap kvmgt functions as static
      drm/i915/gvt: Fix function comment doc errors
      drm/i915/gvt: Move some MMIO definitions to reg.h

chunhui dai (9):
      drm/mediatek: add refcount for DPI power on/off
      drm/mediatek: move hardware register to node data
      drm/mediatek: adjust EDGE to match clock and data
      drm/mediatek: add clock factor for different IC
      drm/mediatek: convert dpi driver to use drm_of_find_panel_or_bridge
      drm/mediatek: add dpi driver for mt2701 and mt7623
      drm/mediatek: separate hdmi phy to different file
      drm/mediatek: add support for SPDIF audio in HDMI
      drm/mediatek: add hdmi driver for MT2701 and MT7623

hersen wu (1):
      drm/amdgpu/display: dm/amdgpu: make dp phy debugfs for eDP

kbuild test robot (2):
      drm/amdgpu: amdgpu_kiq_reg_write_reg_wait() can be static
      drm/amd/display: fix ptr_ret.cocci warnings

shaoyunl (1):
      drm/amdkfd: Only add bi-directional iolink on GPU with XGMI or
largebar (v2)

zhong jiang (3):
      gpu: do not double put device node in zx_drm_probe
      drm/amd/display: remove redundant null pointer check before kfree
      drm/omap: Use ERR_CAST directly instead of ERR_PTR(PTR_ERR())

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt |    23 +
 .../bindings/display/bridge/lvds-transmitter.txt   |     8 +-
 .../bindings/display/bridge/renesas,lvds.txt       |    14 +-
 .../bindings/display/bridge/ti,sn65dsi86.txt       |    87 +
 .../bindings/display/bridge/toshiba,tc358764.txt   |    35 +
 .../bindings/display/exynos/exynos_dsim.txt        |    25 +-
 .../devicetree/bindings/display/mipi-dsi-bus.txt   |   153 +-
 .../devicetree/bindings/display/renesas,du.txt     |     4 +
 .../bindings/display/rockchip/rockchip-vop.txt     |     3 +
 .../bindings/display/sunxi/sun4i-drm.txt           |    16 +-
 Documentation/gpu/drivers.rst                      |     1 +
 Documentation/gpu/drm-kms.rst                      |    18 +-
 Documentation/gpu/drm-mm.rst                       |     6 +-
 Documentation/gpu/todo.rst                         |    71 +-
 Documentation/gpu/vkms.rst                         |    24 +
 Documentation/ioctl/ioctl-number.txt               |     1 +
 MAINTAINERS                                        |    20 +-
 drivers/dma-buf/Kconfig                            |     9 +
 drivers/dma-buf/Makefile                           |     1 +
 drivers/dma-buf/dma-buf.c                          |     1 -
 drivers/dma-buf/udmabuf.c                          |   293 +
 drivers/gpu/drm/Kconfig                            |    22 +-
 drivers/gpu/drm/Makefile                           |     3 +-
 drivers/gpu/drm/amd/amdgpu/Kconfig                 |     1 +
 drivers/gpu/drm/amd/amdgpu/Makefile                |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   704 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |   207 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    93 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |    16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |    45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h        |     1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   319 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   262 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |    88 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   558 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h        |    15 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |     7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   169 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c       |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h           |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h            |     7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h            |    92 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    74 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |   351 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   215 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |    71 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |   239 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |    54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |    45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h            |    25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   313 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    96 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   273 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c          |    53 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    65 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_queue_mgr.c      |   316 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   123 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c             |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |    44 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |    97 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c   |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   224 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |   109 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |    39 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   196 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  1476 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    84 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |    52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |   119 +
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |     1 +
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |     4 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |    17 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |     9 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    26 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |     9 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    21 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |    21 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |    20 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |    20 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |     5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |    57 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   632 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   570 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |    32 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c           |    53 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h           |    29 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |    28 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |    28 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |    28 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   157 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |     9 +-
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |     4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   259 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h            |     1 -
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c              |     7 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |    18 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   248 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h             |    31 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |     3 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |    15 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |   595 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.h             |    30 +
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |     2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |    68 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |    83 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   140 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |    13 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    47 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |     4 +-
 drivers/gpu/drm/amd/amdgpu/si_enums.h              |    20 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |     9 +-
 drivers/gpu/drm/amd/amdgpu/sid.h                   |    20 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   130 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h                 |     1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |    22 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |     9 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |    14 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |    35 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |    13 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |   558 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |    45 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |    24 +-
 drivers/gpu/drm/amd/amdkfd/Kconfig                 |     2 +-
 drivers/gpu/drm/amd/amdkfd/Makefile                |    53 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |    23 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |    88 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h              |    10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    68 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    95 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c   |     3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |   122 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |     8 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |    23 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |    23 +
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    46 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |     8 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    22 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    48 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |     1 +
 drivers/gpu/drm/amd/display/Kconfig                |     6 +
 drivers/gpu/drm/amd/display/Makefile               |     3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   784 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    41 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |     6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |    20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    86 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h  |     1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    89 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |    37 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |    14 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |  1181 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   312 +-
 .../gpu/drm/amd/display/dc/bios/command_table.c    |     3 +
 .../amd/display/dc/bios/command_table_helper2.c    |     5 +
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |     6 +-
 .../gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c   |     8 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |    24 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   342 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   208 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |    10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |     3 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   287 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |     2 -
 drivers/gpu/drm/amd/display/dc/dc.h                |    15 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |    64 -
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |     9 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |     9 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |     1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    42 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    35 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile        |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |     2 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   441 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.h  |    11 +
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c    |    76 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.h    |     3 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c       |    60 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h       |    38 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |   676 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h    |   301 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c    |   541 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.h    |    57 +
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |    51 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.h  |     6 +
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |    24 +
 .../drm/amd/display/dc/dce100/dce100_resource.c    |    62 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   127 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |    63 +-
 .../drm/amd/display/dc/dce112/dce112_resource.c    |    67 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |    75 +-
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   129 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile      |     2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |    26 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |     3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |    60 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |     4 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |    31 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |     8 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |    99 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |     5 +
 .../display/dc/dcn10/dcn10_hw_sequencer_debug.c    |   561 +
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |    18 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |    34 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   143 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |     2 +
 drivers/gpu/drm/amd/display/dc/dm_event_log.h      |    38 +
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |    92 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h       |    10 +-
 .../drm/amd/display/dc/dml/display_mode_enums.h    |     4 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |     5 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |     5 +
 drivers/gpu/drm/amd/display/dc/i2caux/aux_engine.c |     1 +
 .../display/dc/i2caux/dce110/aux_engine_dce110.c   |    10 +-
 .../gpu/drm/amd/display/dc/i2caux/i2c_hw_engine.c  |     7 +
 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c     |     4 +
 drivers/gpu/drm/amd/display/dc/inc/clock_source.h  |     4 -
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |     8 +-
 drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h     |     6 +-
 .../gpu/drm/amd/display/dc/inc/hw/display_clock.h  |     5 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |     3 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |     4 +-
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |     4 +
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |     4 +
 .../drm/amd/display/include/bios_parser_types.h    |     2 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |     7 +
 drivers/gpu/drm/amd/display/include/dal_types.h    |     3 +
 .../gpu/drm/amd/display/include/logger_interface.h |     6 +-
 drivers/gpu/drm/amd/display/include/logger_types.h |     9 +-
 .../gpu/drm/amd/display/include/set_mode_types.h   |    12 -
 drivers/gpu/drm/amd/display/include/signal_types.h |    10 +
 .../drm/amd/display/modules/color/color_gamma.c    |    21 +-
 .../drm/amd/display/modules/color/color_gamma.h    |     5 +-
 .../drm/amd/display/modules/freesync/freesync.c    |  2024 +-
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |   160 +-
 .../drm/amd/display/modules/inc/mod_info_packet.h  |    40 +
 .../gpu/drm/amd/display/modules/inc/mod_shared.h   |    49 +
 .../drm/amd/display/modules/info_packet/Makefile   |    31 +
 .../amd/display/modules/info_packet/info_packet.c  |   329 +
 drivers/gpu/drm/amd/display/modules/stats/stats.c  |     8 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |     2 +
 .../drm/amd/include/asic_reg/gc/gc_9_0_offset.h    |     2 +
 .../drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h |     4 +-
 .../drm/amd/include/asic_reg/mp/mp_11_0_offset.h   |   358 +
 .../drm/amd/include/asic_reg/mp/mp_11_0_sh_mask.h  |   534 +
 .../amd/include/asic_reg/nbio/nbio_7_4_offset.h    |  4627 ++
 .../amd/include/asic_reg/nbio/nbio_7_4_sh_mask.h   | 48436 +++++++++++++++=
++++
 .../amd/include/asic_reg/sdma0/sdma0_4_2_offset.h  |  1047 +
 .../amd/include/asic_reg/sdma0/sdma0_4_2_sh_mask.h |  2992 ++
 .../amd/include/asic_reg/sdma1/sdma1_4_2_offset.h  |  1039 +
 .../amd/include/asic_reg/sdma1/sdma1_4_2_sh_mask.h |  2948 ++
 .../amd/include/asic_reg/smuio/smuio_9_0_offset.h  |     3 +
 .../amd/include/asic_reg/smuio/smuio_9_0_sh_mask.h |     3 +
 .../amd/include/asic_reg/thm/thm_11_0_2_offset.h   |    49 +
 .../amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h  |    96 +
 .../drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h  |    24 +
 .../drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h |    45 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |   194 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |    49 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |     7 +
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |   114 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |     4 +-
 .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |     2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |    27 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |     3 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h |     2 +-
 .../amd/powerplay/hwmgr/process_pptables_v1_0.c    |   194 +-
 .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  |    30 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |    51 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |    47 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h   |     1 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c |     3 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c   |    63 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c   |    46 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.h   |    12 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |    43 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h |     2 -
 .../gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |     1 +
 .../amd/powerplay/hwmgr/vega10_processpptables.c   |    30 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   |     8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |    14 +-
 .../amd/powerplay/hwmgr/vega12_processpptables.c   |    82 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |  3550 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h |   575 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_inc.h   |    35 +
 .../gpu/drm/amd/powerplay/hwmgr/vega20_powertune.c |    70 +
 .../gpu/drm/amd/powerplay/hwmgr/vega20_powertune.h |    32 +
 .../gpu/drm/amd/powerplay/hwmgr/vega20_pptable.h   |   142 +
 .../amd/powerplay/hwmgr/vega20_processpptables.c   |   961 +
 .../amd/powerplay/hwmgr/vega20_processpptables.h   |    31 +
 .../gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c   |   356 +
 .../gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h   |    71 +
 .../gpu/drm/amd/powerplay/inc/hardwaremanager.h    |     2 +
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |     6 +-
 .../gpu/drm/amd/powerplay/inc/smu11_driver_if.h    |   888 +
 drivers/gpu/drm/amd/powerplay/inc/vega20_ppsmc.h   |   128 +
 drivers/gpu/drm/amd/powerplay/smumgr/Makefile      |     2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |     3 +
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |    15 +-
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  |    26 +-
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |     1 +
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |    34 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |    58 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c |    61 +-
 .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |    12 +
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |    18 +-
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.h   |     4 +
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |    22 +-
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.h   |     4 -
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |   588 +
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.h   |    60 +
 .../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c    |     3 +
 drivers/gpu/drm/arm/hdlcd_drv.c                    |    11 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |    28 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |   141 +-
 drivers/gpu/drm/arm/malidp_drv.h                   |     8 +
 drivers/gpu/drm/arm/malidp_hw.c                    |    58 +-
 drivers/gpu/drm/arm/malidp_hw.h                    |    13 +
 drivers/gpu/drm/arm/malidp_planes.c                |   354 +-
 drivers/gpu/drm/arm/malidp_regs.h                  |    11 +
 drivers/gpu/drm/armada/armada_overlay.c            |     1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |   100 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |     1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |    92 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |     5 +-
 drivers/gpu/drm/bochs/bochs.h                      |    25 +-
 drivers/gpu/drm/bochs/bochs_drv.c                  |    64 +-
 drivers/gpu/drm/bochs/bochs_fbdev.c                |    91 +-
 drivers/gpu/drm/bochs/bochs_hw.c                   |    66 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |    47 +-
 drivers/gpu/drm/bochs/bochs_mm.c                   |    76 +-
 drivers/gpu/drm/bridge/Kconfig                     |    18 +
 drivers/gpu/drm/bridge/Makefile                    |     2 +
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |     4 +-
 drivers/gpu/drm/bridge/synopsys/Makefile           |     2 -
 drivers/gpu/drm/bridge/tc358764.c                  |   499 +
 drivers/gpu/drm/bridge/thc63lvd1024.c              |    18 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   779 +
 drivers/gpu/drm/cirrus/cirrus_drv.c                |    27 +-
 drivers/gpu/drm/cirrus/cirrus_drv.h                |     2 +-
 drivers/gpu/drm/cirrus/cirrus_fbdev.c              |    51 +-
 drivers/gpu/drm/cirrus/cirrus_main.c               |     2 +-
 drivers/gpu/drm/cirrus/cirrus_mode.c               |     4 +-
 drivers/gpu/drm/drm_atomic.c                       |  1506 +-
 drivers/gpu/drm/drm_atomic_helper.c                |    33 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |  1393 +
 drivers/gpu/drm/drm_blend.c                        |   145 +
 drivers/gpu/drm/drm_bridge.c                       |     4 +
 drivers/gpu/drm/drm_bufs.c                         |    32 +-
 drivers/gpu/drm/drm_client.c                       |     2 +-
 drivers/gpu/drm/drm_color_mgmt.c                   |     4 +-
 drivers/gpu/drm/drm_connector.c                    |     8 +-
 drivers/gpu/drm/drm_context.c                      |    16 +-
 drivers/gpu/drm/drm_crtc.c                         |     9 +-
 drivers/gpu/drm/drm_crtc_helper.c                  |     1 +
 drivers/gpu/drm/drm_crtc_internal.h                |    19 +-
 drivers/gpu/drm/drm_debugfs_crc.c                  |    92 +-
 drivers/gpu/drm/drm_dp_cec.c                       |    18 +-
 drivers/gpu/drm/drm_dp_helper.c                    |    20 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |     1 +
 drivers/gpu/drm/drm_drv.c                          |     3 +
 drivers/gpu/drm/drm_encoder.c                      |     2 +-
 drivers/gpu/drm/drm_fb_cma_helper.c                |    26 +-
 drivers/gpu/drm/drm_fb_helper.c                    |    63 +-
 drivers/gpu/drm/drm_fourcc.c                       |    72 +-
 drivers/gpu/drm/drm_framebuffer.c                  |    49 +-
 drivers/gpu/drm/drm_gem.c                          |     6 +-
 drivers/gpu/drm/drm_gem_cma_helper.c               |     4 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |     5 +-
 drivers/gpu/drm/drm_internal.h                     |     5 +
 drivers/gpu/drm/drm_ioctl.c                        |    12 +-
 drivers/gpu/drm/drm_irq.c                          |     4 +-
 drivers/gpu/drm/drm_lease.c                        |     8 +-
 drivers/gpu/drm/drm_lock.c                         |     4 +-
 drivers/gpu/drm/drm_mode_config.c                  |     3 +-
 drivers/gpu/drm/drm_mode_object.c                  |     4 +-
 drivers/gpu/drm/drm_panel.c                        |     2 +
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |    14 +-
 drivers/gpu/drm/drm_pci.c                          |     4 +-
 drivers/gpu/drm/drm_plane.c                        |    23 +-
 drivers/gpu/drm/drm_plane_helper.c                 |     1 +
 drivers/gpu/drm/drm_prime.c                        |     4 +-
 drivers/gpu/drm/drm_property.c                     |     8 +-
 drivers/gpu/drm/drm_scatter.c                      |     8 +-
 drivers/gpu/drm/drm_syncobj.c                      |   132 +-
 drivers/gpu/drm/drm_vblank.c                       |    10 +-
 drivers/gpu/drm/drm_vma_manager.c                  |     3 -
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |     2 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |    26 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.h            |     3 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   107 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |    17 -
 drivers/gpu/drm/exynos/exynos_drm_fbdev.h          |    10 -
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |    46 +-
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |    16 +-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |   137 +-
 drivers/gpu/drm/exynos/exynos_mixer.c              |    56 +-
 drivers/gpu/drm/exynos/regs-mixer.h                |     5 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |     8 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |     1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    26 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |     1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c  |     2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |     2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |     8 +-
 drivers/gpu/drm/i915/Kconfig.debug                 |    12 +
 drivers/gpu/drm/i915/gvt/cfg_space.c               |    12 +
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |    11 +-
 drivers/gpu/drm/i915/gvt/display.c                 |     1 +
 drivers/gpu/drm/i915/gvt/edid.c                    |     9 +
 drivers/gpu/drm/i915/gvt/gtt.c                     |     9 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     |     3 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |    34 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |     4 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |     3 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c            |    13 -
 drivers/gpu/drm/i915/gvt/mmio_context.h            |     3 +
 drivers/gpu/drm/i915/gvt/opregion.c                |     1 -
 drivers/gpu/drm/i915/gvt/page_track.c              |     2 +
 drivers/gpu/drm/i915/gvt/reg.h                     |    18 +
 drivers/gpu/drm/i915/gvt/scheduler.c               |    64 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |    99 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   500 +-
 drivers/gpu/drm/i915/i915_drv.h                    |    97 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   105 +-
 drivers/gpu/drm/i915/i915_gem.h                    |     6 -
 drivers/gpu/drm/i915/i915_gem_clflush.c            |     7 -
 drivers/gpu/drm/i915/i915_gem_context.c            |   252 +-
 drivers/gpu/drm/i915/i915_gem_context.h            |    59 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |    52 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |   102 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h                |    23 +-
 drivers/gpu/drm/i915/i915_gem_object.h             |    10 +-
 drivers/gpu/drm/i915/i915_gem_stolen.c             |     4 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |    20 +-
 drivers/gpu/drm/i915/i915_irq.c                    |    36 +-
 drivers/gpu/drm/i915/i915_pci.c                    |    16 +-
 drivers/gpu/drm/i915/i915_perf.c                   |   178 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   780 +-
 drivers/gpu/drm/i915/i915_request.c                |    23 +-
 drivers/gpu/drm/i915/i915_request.h                |    47 +-
 drivers/gpu/drm/i915/i915_sw_fence.c               |    13 +-
 drivers/gpu/drm/i915/i915_vma.c                    |     5 +-
 drivers/gpu/drm/i915/i915_vma.h                    |    10 +-
 drivers/gpu/drm/i915/intel_atomic_plane.c          |    53 +-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |     6 +-
 drivers/gpu/drm/i915/intel_csr.c                   |    41 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |   261 +-
 drivers/gpu/drm/i915/intel_device_info.h           |     2 +-
 drivers/gpu/drm/i915/intel_display.c               |   970 +-
 drivers/gpu/drm/i915/intel_display.h               |    32 +-
 drivers/gpu/drm/i915/intel_dp.c                    |   541 +-
 drivers/gpu/drm/i915/intel_dp_link_training.c      |    51 +-
 drivers/gpu/drm/i915/intel_dp_mst.c                |    57 +-
 drivers/gpu/drm/i915/intel_dpll_mgr.c              |    62 +-
 drivers/gpu/drm/i915/intel_dpll_mgr.h              |     1 +
 drivers/gpu/drm/i915/intel_drv.h                   |    99 +-
 drivers/gpu/drm/i915/intel_engine_cs.c             |    96 +-
 drivers/gpu/drm/i915/intel_fbc.c                   |     4 +-
 drivers/gpu/drm/i915/intel_fbdev.c                 |     6 +-
 drivers/gpu/drm/i915/intel_guc.c                   |   102 +-
 drivers/gpu/drm/i915/intel_guc.h                   |    12 +-
 drivers/gpu/drm/i915/intel_guc_ads.c               |     2 +-
 drivers/gpu/drm/i915/intel_guc_ct.c                |     7 +-
 drivers/gpu/drm/i915/intel_guc_fwif.h              |     1 +
 drivers/gpu/drm/i915/intel_guc_log.c               |     2 +-
 drivers/gpu/drm/i915/intel_guc_submission.c        |   115 +-
 drivers/gpu/drm/i915/intel_guc_submission.h        |     4 +
 drivers/gpu/drm/i915/intel_hangcheck.c             |     2 +-
 drivers/gpu/drm/i915/intel_hdcp.c                  |     6 +-
 drivers/gpu/drm/i915/intel_hdmi.c                  |    10 +-
 drivers/gpu/drm/i915/intel_huc.c                   |     2 +-
 drivers/gpu/drm/i915/intel_i2c.c                   |    16 +-
 drivers/gpu/drm/i915/intel_lrc.c                   |   216 +-
 drivers/gpu/drm/i915/intel_lrc.h                   |     2 -
 drivers/gpu/drm/i915/intel_lrc_reg.h               |     2 +-
 drivers/gpu/drm/i915/intel_mocs.c                  |    11 +-
 drivers/gpu/drm/i915/intel_mocs.h                  |     2 +-
 drivers/gpu/drm/i915/intel_overlay.c               |   147 +-
 drivers/gpu/drm/i915/intel_pipe_crc.c              |   119 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   120 +-
 drivers/gpu/drm/i915/intel_psr.c                   |   277 +-
 drivers/gpu/drm/i915/intel_ringbuffer.c            |   133 +-
 drivers/gpu/drm/i915/intel_ringbuffer.h            |    41 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |  1005 +-
 drivers/gpu/drm/i915/intel_sdvo.c                  |   101 +-
 drivers/gpu/drm/i915/intel_sprite.c                |   525 +-
 drivers/gpu/drm/i915/intel_uc.c                    |     4 +
 drivers/gpu/drm/i915/intel_uc_fw.c                 |     2 +-
 drivers/gpu/drm/i915/intel_uncore.c                |   130 +-
 drivers/gpu/drm/i915/intel_wopcm.c                 |     6 +
 drivers/gpu/drm/i915/selftests/huge_pages.c        |    13 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c          |   221 +
 .../gpu/drm/i915/selftests/i915_gem_coherency.c    |    40 +-
 drivers/gpu/drm/i915/selftests/i915_gem_context.c  |   202 +
 drivers/gpu/drm/i915/selftests/i915_gem_object.c   |     5 +-
 .../gpu/drm/i915/selftests/i915_live_selftests.h   |     1 +
 drivers/gpu/drm/i915/selftests/i915_request.c      |     8 +
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c     |     8 -
 drivers/gpu/drm/i915/selftests/intel_guc.c         |    42 +
 drivers/gpu/drm/i915/selftests/intel_hangcheck.c   |   101 +-
 drivers/gpu/drm/i915/selftests/intel_lrc.c         |     8 +
 drivers/gpu/drm/i915/selftests/intel_workarounds.c |     5 +
 drivers/gpu/drm/i915/selftests/mock_context.c      |    11 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.c          |     2 +
 drivers/gpu/drm/imx/imx-drm-core.c                 |    21 +-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |     9 +-
 drivers/gpu/drm/mediatek/Makefile                  |     5 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |   131 +-
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h            |     2 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             |    14 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |     2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |     2 +
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |    15 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.h                |     2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c            |   235 +
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h            |    60 +
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c     |   212 +
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c     |   226 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |    21 +-
 drivers/gpu/drm/mgag200/mgag200_main.c             |     9 -
 drivers/gpu/drm/msm/Makefile                       |     1 -
 drivers/gpu/drm/msm/adreno/a2xx.xml.h              |     8 +-
 drivers/gpu/drm/msm/adreno/a3xx.xml.h              |     8 +-
 drivers/gpu/drm/msm/adreno/a4xx.xml.h              |     8 +-
 drivers/gpu/drm/msm/adreno/a5xx.xml.h              |     8 +-
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c          |     4 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |    20 +-
 drivers/gpu/drm/msm/adreno/a5xx_power.c            |     2 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c          |    12 +-
 drivers/gpu/drm/msm/adreno/a6xx.xml.h              |  1413 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   144 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |    21 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h          |    12 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |    38 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |     3 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |   161 +-
 drivers/gpu/drm/msm/adreno/adreno_common.xml.h     |     8 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |     1 +
 drivers/gpu/drm/msm/adreno/adreno_pm4.xml.h        |    26 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   737 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h           |   115 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   257 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |    10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |    23 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |    48 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |   125 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   109 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |    56 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c         |   323 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h         |   139 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |    16 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |     4 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |    29 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |     7 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c          |    29 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h          |     7 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |    39 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c         |    18 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h         |    17 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c        |     3 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h        |    16 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |    45 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |     4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   501 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h          |     4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c   |    15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h   |    14 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   285 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h             |    44 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h          |   116 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |     5 +-
 drivers/gpu/drm/msm/dsi/dsi.c                      |    10 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |     2 +
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |     4 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |     2 +
 drivers/gpu/drm/msm/msm_drv.c                      |     8 +-
 drivers/gpu/drm/msm/msm_drv.h                      |     2 +
 drivers/gpu/drm/msm/msm_fence.c                    |     8 -
 drivers/gpu/drm/msm/msm_gem_submit.c               |     4 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |    49 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |     5 +-
 drivers/gpu/drm/msm/msm_rd.c                       |     6 +-
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 |    53 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |    40 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |    42 +-
 drivers/gpu/drm/nouveau/include/nvif/cl5070.h      |     5 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |   220 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |    71 +-
 drivers/gpu/drm/nouveau/nouveau_connector.h        |    35 +
 drivers/gpu/drm/nouveau/nouveau_display.c          |     2 -
 drivers/gpu/drm/nouveau/nouveau_display.h          |    25 -
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   179 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |    10 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |     1 -
 drivers/gpu/drm/nouveau/nouveau_fence.c            |     1 -
 drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild    |     1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/hdmigm200.c   |    36 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h     |     8 +
 .../gpu/drm/nouveau/nvkm/engine/disp/rootnv50.c    |    10 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgf119.c    |    11 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgm200.c    |     1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgv100.c    |     1 +
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c |     1 +
 .../gpu/drm/omapdrm/displays/connector-analog-tv.c |   139 +-
 drivers/gpu/drm/omapdrm/displays/connector-dvi.c   |   175 +-
 drivers/gpu/drm/omapdrm/displays/connector-hdmi.c  |   277 +-
 drivers/gpu/drm/omapdrm/displays/encoder-opa362.c  |   132 +-
 drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c  |   187 +-
 .../gpu/drm/omapdrm/displays/encoder-tpd12s015.c   |   197 +-
 drivers/gpu/drm/omapdrm/displays/panel-dpi.c       |    88 +-
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    |   247 +-
 .../omapdrm/displays/panel-lgphilips-lb035q02.c    |   103 +-
 .../drm/omapdrm/displays/panel-nec-nl8048hl11.c    |   146 +-
 .../drm/omapdrm/displays/panel-sharp-ls037v7dw01.c |   101 +-
 .../drm/omapdrm/displays/panel-sony-acx565akm.c    |   165 +-
 .../drm/omapdrm/displays/panel-tpo-td028ttec1.c    |   102 +-
 .../drm/omapdrm/displays/panel-tpo-td043mtea1.c    |   192 +-
 drivers/gpu/drm/omapdrm/dss/base.c                 |   217 +-
 drivers/gpu/drm/omapdrm/dss/core.c                 |    26 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |    61 +-
 drivers/gpu/drm/omapdrm/dss/display.c              |   134 +-
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |   192 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |   569 +-
 drivers/gpu/drm/omapdrm/dss/dss-of.c               |    47 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  |    47 +-
 drivers/gpu/drm/omapdrm/dss/dss.h                  |    11 +-
 drivers/gpu/drm/omapdrm/dss/hdmi.h                 |     8 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   351 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   334 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c           |     6 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_wp.c              |     8 +-
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |   306 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |   208 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |   149 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |   291 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |   374 +-
 drivers/gpu/drm/omapdrm/omap_connector.h           |     7 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |   111 +-
 drivers/gpu/drm/omapdrm/omap_crtc.h                |     6 +-
 drivers/gpu/drm/omapdrm/omap_dmm_priv.h            |     7 +
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |   201 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   304 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |    19 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c             |   159 +-
 drivers/gpu/drm/omapdrm/omap_encoder.h             |     6 +-
 drivers/gpu/drm/omapdrm/omap_fb.c                  |     2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |     6 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |     4 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |     2 +-
 drivers/gpu/drm/omapdrm/omap_irq.c                 |     4 +-
 drivers/gpu/drm/omapdrm/tcm-sita.h                 |    93 -
 drivers/gpu/drm/panel/panel-lvds.c                 |     6 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |     6 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |   117 +-
 drivers/gpu/drm/qxl/qxl_draw.c                     |     6 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |    28 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |    32 +-
 drivers/gpu/drm/qxl/qxl_fb.c                       |   197 +-
 drivers/gpu/drm/qxl/qxl_gem.c                      |     2 +-
 drivers/gpu/drm/qxl/qxl_kms.c                      |    80 +-
 drivers/gpu/drm/radeon/atombios_crtc.c             |    25 +
 drivers/gpu/drm/radeon/atombios_i2c.c              |     2 +-
 drivers/gpu/drm/radeon/cik.c                       |     2 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |     2 +-
 drivers/gpu/drm/radeon/mkregtable.c                |     2 +-
 drivers/gpu/drm/radeon/r100_track.h                |     2 +-
 drivers/gpu/drm/radeon/r600_reg.h                  |    31 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |     2 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |    23 +-
 drivers/gpu/drm/radeon/radeon_legacy_tv.c          |     2 +-
 drivers/gpu/drm/radeon/radeon_object.c             |     4 +-
 drivers/gpu/drm/radeon/radeon_test.c               |    10 +-
 drivers/gpu/drm/radeon/radeon_trace.h              |     2 +-
 drivers/gpu/drm/radeon/radeon_trace_points.c       |     2 +-
 drivers/gpu/drm/radeon/si.c                        |     2 +-
 drivers/gpu/drm/rcar-du/Kconfig                    |     1 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |   466 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |    14 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |    85 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |    21 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |     6 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |     6 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.c            |    94 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.h            |     6 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |    99 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.h              |     6 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c            |    12 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.h            |     6 +-
 drivers/gpu/drm/rcar-du/rcar_du_regs.h             |    13 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |    14 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h              |     6 +-
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c             |     6 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |   360 +-
 drivers/gpu/drm/rcar-du/rcar_lvds_regs.h           |    48 +-
 drivers/gpu/drm/rockchip/Kconfig                   |    25 +-
 drivers/gpu/drm/rockchip/Makefile                  |     1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   104 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |     2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    48 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |     1 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |   173 +
 drivers/gpu/drm/rockchip/rockchip_rgb.h            |    33 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   215 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h        |    99 +
 drivers/gpu/drm/scheduler/Makefile                 |     2 +-
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h    |    24 +
 drivers/gpu/drm/scheduler/sched_entity.c           |   524 +
 .../scheduler/{gpu_scheduler.c =3D> sched_main.c}    |   440 +-
 drivers/gpu/drm/shmobile/Kconfig                   |     1 +
 drivers/gpu/drm/shmobile/shmob_drm_backlight.c     |     6 +-
 drivers/gpu/drm/shmobile/shmob_drm_backlight.h     |     6 +-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c          |     6 +-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.h          |     6 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.c           |     6 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.h           |     6 +-
 drivers/gpu/drm/shmobile/shmob_drm_kms.c           |     6 +-
 drivers/gpu/drm/shmobile/shmob_drm_kms.h           |     6 +-
 drivers/gpu/drm/shmobile/shmob_drm_plane.c         |     6 +-
 drivers/gpu/drm/shmobile/shmob_drm_plane.h         |     6 +-
 drivers/gpu/drm/shmobile/shmob_drm_regs.h          |     6 +-
 drivers/gpu/drm/sti/sti_drv.c                      |     8 +-
 drivers/gpu/drm/sti/sti_hda.c                      |     1 -
 drivers/gpu/drm/sti/sti_hdmi.c                     |     1 -
 drivers/gpu/drm/sun4i/sun4i_backend.c              |    81 +-
 drivers/gpu/drm/sun4i/sun4i_backend.h              |     3 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |    20 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                |     4 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   203 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |    27 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |    17 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |     2 +
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |    12 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |    48 +
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c             |     4 +-
 drivers/gpu/drm/tegra/dc.c                         |    73 +
 drivers/gpu/drm/tegra/dc.h                         |     2 +-
 drivers/gpu/drm/tegra/dpaux.c                      |     3 +-
 drivers/gpu/drm/tegra/drm.c                        |    47 +-
 drivers/gpu/drm/tegra/drm.h                        |     4 -
 drivers/gpu/drm/tegra/fb.c                         |    24 +-
 drivers/gpu/drm/tegra/hub.c                        |    19 +-
 drivers/gpu/drm/tegra/hub.h                        |     1 +
 drivers/gpu/drm/tegra/sor.c                        |   110 +
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |    14 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |     3 -
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |     6 +-
 drivers/gpu/drm/ttm/Makefile                       |     4 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |    76 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |     5 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |     3 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |     8 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |    14 +-
 drivers/gpu/drm/udl/udl_drv.c                      |     2 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |     6 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |     2 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |     1 +
 drivers/gpu/drm/vc4/vc4_drv.c                      |    25 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |     4 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |     6 -
 drivers/gpu/drm/vc4/vc4_plane.c                    |     5 +-
 drivers/gpu/drm/vgem/vgem_drv.c                    |     2 +-
 drivers/gpu/drm/vgem/vgem_fence.c                  |    13 -
 drivers/gpu/drm/virtio/virtgpu_display.c           |    12 +-
 drivers/gpu/drm/virtio/virtgpu_drm_bus.c           |    26 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |    30 +-
 drivers/gpu/drm/virtio/virtgpu_fb.c                |    23 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c               |     7 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |     4 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |    19 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |    60 +-
 drivers/gpu/drm/virtio/virtgpu_prime.c             |    11 +-
 drivers/gpu/drm/virtio/virtgpu_ttm.c               |    39 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |    79 +-
 drivers/gpu/drm/vkms/Makefile                      |     2 +-
 drivers/gpu/drm/vkms/vkms_crc.c                    |   262 +
 drivers/gpu/drm/vkms/vkms_crtc.c                   |   114 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |    14 +
 drivers/gpu/drm/vkms/vkms_drv.h                    |    75 +-
 drivers/gpu/drm/vkms/vkms_gem.c                    |    83 +-
 drivers/gpu/drm/vkms/vkms_output.c                 |    19 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |   175 +-
 drivers/gpu/drm/vmwgfx/Makefile                    |     4 +-
 drivers/gpu/drm/{ttm =3D> vmwgfx}/ttm_lock.c         |    15 +-
 .../drm/ttm =3D> drivers/gpu/drm/vmwgfx}/ttm_lock.h  |     0
 drivers/gpu/drm/{ttm =3D> vmwgfx}/ttm_object.c       |    97 +-
 .../ttm =3D> drivers/gpu/drm/vmwgfx}/ttm_object.h    |    31 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |    50 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |     4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c         |     3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c            |    23 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |     2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |     4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   147 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  1288 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |     7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   203 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |    24 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c              |     2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |   124 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h      |     7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |    48 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |    25 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c    |     7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c                 |    11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |    31 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |    20 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |   770 +
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h         |   227 +
 drivers/gpu/drm/xen/xen_drm_front_gem.c            |     2 +-
 drivers/gpu/drm/zte/zx_drm_drv.c                   |    19 +-
 drivers/gpu/host1x/bus.c                           |     2 +-
 drivers/gpu/host1x/dev.c                           |    13 +-
 drivers/staging/vboxvideo/vbox_fb.c                |     3 +-
 drivers/tty/vt/vt.c                                |    12 +-
 drivers/video/fbdev/core/fbcon.c                   |     4 +-
 drivers/video/fbdev/core/fbmem.c                   |    67 +-
 include/drm/drmP.h                                 |     3 -
 include/drm/drm_atomic.h                           |    23 +-
 include/drm/drm_atomic_helper.h                    |     3 +
 include/drm/drm_atomic_uapi.h                      |    58 +
 include/drm/drm_blend.h                            |     6 +
 include/drm/drm_color_mgmt.h                       |     1 +
 include/drm/drm_connector.h                        |     1 +
 include/drm/drm_crtc.h                             |    41 +-
 include/drm/drm_device.h                           |    10 +
 include/drm/drm_dp_helper.h                        |    11 +-
 include/drm/drm_drv.h                              |     9 +-
 include/drm/drm_encoder.h                          |     1 +
 include/drm/drm_fb_cma_helper.h                    |     1 -
 include/drm/drm_fb_helper.h                        |    34 +
 include/drm/drm_fourcc.h                           |    24 +
 include/drm/drm_mode_config.h                      |    15 +
 include/drm/drm_panel.h                            |     1 +
 include/drm/drm_pciids.h                           |     2 +-
 include/drm/drm_plane.h                            |    19 +
 include/drm/drm_print.h                            |     2 +-
 include/drm/drm_property.h                         |     2 +
 include/drm/drm_syncobj.h                          |     9 +-
 include/drm/drm_util.h                             |    32 +
 include/drm/gpu_scheduler.h                        |    48 +-
 include/drm/i915_pciids.h                          |     1 +
 include/drm/ttm/ttm_bo_api.h                       |    34 +-
 include/drm/ttm/ttm_bo_driver.h                    |    28 +
 include/linux/console_struct.h                     |     1 -
 include/linux/fb.h                                 |    11 +-
 include/linux/list.h                               |    23 +
 include/linux/platform_data/shmob_drm.h            |     6 +-
 include/linux/vt_kern.h                            |     7 -
 include/uapi/drm/amdgpu_drm.h                      |     2 +
 include/uapi/drm/drm_fourcc.h                      |    48 +
 include/uapi/drm/drm_mode.h                        |     3 +-
 include/uapi/drm/i915_drm.h                        |    22 +
 include/uapi/linux/kfd_ioctl.h                     |    13 +-
 include/uapi/linux/udmabuf.h                       |    33 +
 tools/testing/selftests/drivers/dma-buf/Makefile   |     5 +
 tools/testing/selftests/drivers/dma-buf/udmabuf.c  |    96 +
 893 files changed, 107777 insertions(+), 25656 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
 create mode 100644
Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
 create mode 100644 Documentation/gpu/vkms.rst
 create mode 100644 drivers/dma-buf/udmabuf.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_queue_mgr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v11_0.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dm_event_log.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_info_packet=
.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_shared.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/info_packet/Makefil=
e
 create mode 100644
drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_offset.=
h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_sh_mask=
.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_sh_m=
ask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_2_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_off=
set.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_inc.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_powertune.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_powertune.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_pptable.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptab=
les.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptab=
les.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/vega20_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.h
 create mode 100644 drivers/gpu/drm/bridge/tc358764.c
 create mode 100644 drivers/gpu/drm/bridge/ti-sn65dsi86.c
 create mode 100644 drivers/gpu/drm/drm_atomic_uapi.c
 create mode 100644 drivers/gpu/drm/i915/selftests/i915_gem.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
 delete mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
 delete mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmigm200.c
 delete mode 100644 drivers/gpu/drm/omapdrm/tcm-sita.h
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.h
 create mode 100644 drivers/gpu/drm/scheduler/sched_entity.c
 rename drivers/gpu/drm/scheduler/{gpu_scheduler.c =3D> sched_main.c} (58%)
 create mode 100644 drivers/gpu/drm/vkms/vkms_crc.c
 rename drivers/gpu/drm/{ttm =3D> vmwgfx}/ttm_lock.c (94%)
 rename {include/drm/ttm =3D> drivers/gpu/drm/vmwgfx}/ttm_lock.h (100%)
 rename drivers/gpu/drm/{ttm =3D> vmwgfx}/ttm_object.c (90%)
 rename {include/drm/ttm =3D> drivers/gpu/drm/vmwgfx}/ttm_object.h (94%)
 create mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
 create mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
 create mode 100644 include/drm/drm_atomic_uapi.h
 create mode 100644 include/drm/drm_util.h
 create mode 100644 include/uapi/linux/udmabuf.h
 create mode 100644 tools/testing/selftests/drivers/dma-buf/Makefile
 create mode 100644 tools/testing/selftests/drivers/dma-buf/udmabuf.c

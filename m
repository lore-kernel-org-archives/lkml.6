Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeC2BQD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:16:03 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34380 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeC2BPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:15:55 -0400
X-Google-Smtp-Source: AIpwx4/zOqVxvHL+HRYZJ+wK7m4n4BbjuA0cDFyHECICdCuErEB4inWZIeGdkbU2kD1M4vE3m1GOhh/VEraoKbOvugw=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 29 Mar 2018 11:15:50 +1000
Message-ID: <CAPM=9tzL1WMgrrR=n3_k0suMRVOCmJVG+Zt5+xtQVSB=d7a=ew@mail.gmail.com>
Subject: [git pull] drm for v4.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2T1GBHs024064

Hi Linus,

This is the main drm pull request for 4.17-rc1.

I'm sending it early because Easter is coming and I'm going to be on
holidays/have relatives staying for most of the next three weeks.
I'll be near email for any emergency but otherwise not too engaged.
I'll likely have two days back before the end of the merge window
to vaccum up any fixes. Cannonlake and Vega12 support are probably the
two major things. This pull lacks nouveau, Ben had some unforseen
leave and a few other blockers so we'll see how things look or maybe
leave it for this merge window.

I'm off to eat my weight in chocolate.

Dave.

core:
Device links to handle sound/gpu pm dependency
Color encoding/range properties
Plane clipping into plane check helper
Backlight helpers
DP TP4 + HBR3 helper support

amdgpu:
Vega12 support
Enable DC by default on all supported GPUs
Powerplay restructuring and cleanup
DC bandwidth calc updates
DC backlight on pre-DCE11
TTM backing store dropping support
SR-IOV fixes
Adding "wattman" like functionality
DC crc support
Improved DC dual-link handling

amdkfd:
GPUVM support for dGPU
KFD events for dGPU
Enable PCIe atomics for dGPUs
HSA process eviction support
Live-lock fixes for process eviction
VM page table allocation fix for large-bar systems

panel:
Raydium RM68200
AUO G104SN02 V2
KEO TX31D200VM0BAA
ARM Versatile panels

i915:
Cannonlake support enabled
AUX-F port support added
Icelake base enabling until internal milestone of forcewake support
Query uAPI interface (used for GPU topology information currently)
Compressed framebuffer support for sprites
kmem cache shrinking when GPU is idle
Avoid boosting GPU when waited item is being processed already
Avoid retraining LSPCON link unnecessarily
Decrease request signaling latency
Deprecation of I915_SET_COLORKEY_NONE
Kerneldoc and compiler warning cleanup for upcoming CI enforcements
Full range ycbcr toggling
HDCP support

i915/gvt:
Big refactor for shadow ppgtt
KBL context save/restore via LRI cmd (Weinan)
Properly unmap dma for guest page (Changbin)

vmwgfx:
Lots of various improvements

etnaviv:
Use the drm gpu scheduler
prep work for GC7000L support

vc4:
fix alpha blending
Expose perf counters to userspace

pl111:
Bandwidth checking/limiting
Versatile panel support

sun4i:
A83T HDMI support
A80 support
YUV plane support
H3/H5 HDMI support

omapdrm:
HPD support for DVI connector
remove lots of static variables

msm:
DSI updates from 10nm / SDM845
fix for race condition with a3xx/a4xx fence completion irq
some refactoring/prep work for eventual a6xx support (ie. when we have
a userspace)
a5xx debugfs enhancements
some mdp5 fixes/cleanups to prepare for eventually merging writeback
support (ie. when we have a userspace)

tegra:
mmap() fixes for fbdev devices
Overlay plane for hw cursor fix
dma-buf cache maintenance support

mali-dp:
YUV->RGB conversion support

rockchip:
rk3399/chromebook fixes and improvements

rcar-du:
LVDS support move to drm bridge
DT bindings for R8A77995
Driver/DT support for R8A77970

tilcdc:
DRM panel support

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-for-v4.17

for you to fetch changes up to 694f54f680f7fd8e9561928fbfc537d9afbc3d79:

  Merge branch 'drm-misc-next-fixes' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2018-03-29
09:25:13 +1000)

----------------------------------------------------------------
main drm pull request for v4.17

----------------------------------------------------------------
Abdiel Janulgue (1):
      drm/i915: Ignore TMDS clock limit for DP++ when EDID override is set

Alex Deucher (66):
      drm/amd/powerplay: export thermal range through temp sysfs
      drm/amdgpu: add new asic callbacks for HDP flush/invalidation
      drm/amdgpu: add HDP asic callbacks for SI
      drm/amdgpu: add HDP asic callbacks for CIK
      drm/amdgpu: add HDP asic callbacks for VI
      drm/amdgpu: add HDP asic callbacks for SOC15 (v2)
      drm/amdgpu: adjust HDP write queue flushing for tlb invalidation
      drm/amdgpu: drop extra tlb invalidation in gpuvm
      drm/amdgpu: only allow scatter/gather display with DC
      drm/amdgpu/powerplay/vega10: fix compute profile name
      drm/amdgpu: drop the drm irq pre/post/un install callbacks
      drm/amdgpu/psp: use a function pointer structure
      drm/amdgpu/soc15: don't abuse IP soft reset for adapter reset
      drm/amdgpu/pm: handle fan properly when card is powered down
      drm/amdgpu/pm: report gpu voltages via hwmon API
      drm/amdgpu/pm: report gpu average power via hwmon API
      drm/amdgpu/pm: use read_sensor API to get temperature
      drm/amdgpu/pp: remove the get_temperature API
      drm/amdgpu/pm: rework the hwmon visibility settings
      drm/amdgpu: remove DC special casing for KB/ML
      drm/amdgpu: set DRIVER_ATOMIC flag early
      drm/amdgpu/dce: fix mask in dce_v*_0_is_in_vblank
      drm/amdgpu: remove unused display_vblank_wait interface
      drm/amd/powerplay: use PP_CAP macro for
disable_mclk_switching_for_frame_lock
      drm/amd/powerplay/vega10: allow mclk switching with no displays
      drm/amd/powerplay/smu7: allow mclk switching with no displays
      drm/amdgpu/cgs: add refresh rate checking to non-DC display code
      drm/amdgpu/powerplay/smu7: drop refresh rate checks for mclk switching
      Revert "drm/radeon/pm: autoswitch power state when in balanced mode"
      drm/amdgpu/powerplay/smu7: use proper dep table for mclk
      drm/amdgpu: fix module parameter descriptions
      drm/amdgpu: used cached pcie gen info for SI (v2)
      drm/radeon: fix KV harvesting
      drm/amdgpu: fix KV harvesting
      drm/amdgpu: save/restore backlight level in legacy dce code
      drm/amdgpu/psp: add a few more fw load type checks
      drm/amdgpu: move firmware loading type setup to common code
      drm/amdgpu: use adev->firmware to determine whether to load the PSP module
      drm/amdgpu/soc15: always load the psp module
      drm/amdgpu: move getting pcie info to common code
      drm/amdgpu/powerplay/vega10: fix memory leak in error path
      drm/amdgpu: remove trailing whitespace from soc15ip.h
      drm/amdgpu/sdma4: use num_instances for clock/powergating config
      drm/amdgpu: add VCN to firmware query interface
      drm/amdgpu: add documentation for amdgpu_device.c
      drm/amdgpu: add gpu_info firmware for vega12
      drm/amdgpu: set asic family and ip blocks for vega12
      drm/amdgpu/psp: initial vega12 support
      drm/amdgpu: specify vega12 uvd firmware
      drm/amdgpu: specify vega12 vce firmware
      drm/amdgpu/virtual_dce: add vega12 support
      drm/amd/display/dm: add vega12 support
      drm/amdgpu: add vega12 to dc support check
      drm/amdgpu/gmc9: add vega12 support (v2)
      drm/amdgpu/mmhub: add clockgating support for vega12
      drm/amdgpu/sdma4: specify vega12 firmware
      drm/amdgpu/sdma4: Add placeholder for vega12 golden settings
      drm/amdgpu/sdma4: add clockgating support for vega12
      drm/amdgpu/gfx9: add support for vega12 firmware
      drm/amdgpu/gfx9: Add placeholder for vega12 golden settings
      drm/amdgpu/gfx9: add gfx config for vega12
      drm/amdgpu/gfx9: add support for vega12
      drm/amdgpu/gfx9: add clockgating support for vega12
      drm/amdgpu/soc15: add support for vega12
      drm/amdgpu: add vega12 pci ids (v2)
      drm/amdgpu: Add an ATPX quirk for hybrid laptop

Amber Lin (1):
      drm/amdgpu: Map all visible VRAM at startup

Andres Rodriguez (2):
      drm/amdgpu: add high priority compute support for gfx9
      drm/amdgpu: bump version for gfx9 high priority compute

Andrew Jiang (1):
      drm/amd/display: Fix check for setting input TF

Andrew Morton (1):
      drm/i915/guc: work around gcc-4.4.4 union initializer issue

Andrey Grodzovsky (9):
      drm/ttm: Allow page allocations w/o triggering OOM..
      drm/amdgpu: Use new TTM flag to avoid OOM triggering.
      drm/amd/display: Remove unsued mutex and spinlock.
      drm/amd/display: Remove timer handler.
      Revert "drm/amdgpu/gfx8: Fix compute ring failure after resetting"
      drm/amd/powerplay: Fix KASAN user after free on driver unload.
      drm/amdgpu: Improve documentation of bo_ptr in amdgpu_bo_create_kernel
      drm/amd/powerplay: Fix NULL pointer deref on driver unbind.
      drm/amdgpu: Fix NULL ptr on driver unload due to init failure.

Andy Shevchenko (3):
      drm/bridge: analogix-anx78xx: Remove duplicate NULL check
      drm/i2c/sil164: Remove duplicate NULL check
      drm/i2c: tda998x: Remove duplicate NULL check

Anthony Koo (3):
      drm/amd/display: provide an interface to query firmware version
      drm/amd/display: Implement stats logging
      drm/amd/display: Add variable refresh rate parameters to DC structures

Anusha Srivatsa (9):
      drm/i915/glk: Disable Guc and HuC on GLK
      drm/i915/dmc: DMC 1.07 for Cannonlake
      drm/i915/icp: Introduce Ice Lake PCH
      drm/i915/icp: Get/set proper Raw clock frequency on ICP
      drm/i915/icp: Add Panel Power Sequencing Support
      drm/i915/icp: Add backlight Support for ICP
      drm/i915/icp: add ICP gmbus and gpio support
      drm/i915/icp: Add the ID for ICL PCH - ICP
      drm: Add DPCD definitions for DP 1.4 FEC feature

Archit Taneja (12):
      drm/msm/dsi: Update generated headers for 10nm PLL/PHY
      drm/msm/dsi: Add skeleton 10nm PHY/PLL code
      drm/msm/dsi: Populate PLL 10nm clock ops
      drm/msm/dsi: Populate the 10nm PHY funcs
      drm/msm/dsi: Use msm_clk_get in dsi_get_config
      drm/msm/dsi: Add SDM845 in dsi_cfg
      drm/msm/dsi: Add byte_intf_clk
      dt-bindings: display: msm/dsi: Remove unused properties
      dt-bindings: display: msm/dsi: Fix the PHY regulator supply props
      dt-bindings: display: msm/dsi: Add compatible for 14nm DSI PHY
      dt-bindings: display: msm/dsi: Add updates for SDM845
      drm/msm/dsi: Get byte_intf_clk only for versions that need it

Arnd Bergmann (9):
      drm: i915: remove timeval users
      drm/amd/display: fix incompatible structure layouts
      drm: fix drm_get_max_iomem type mismatch
      radeon: hide pointless #warning when compile testing
      tinydrm: add backlight dependency
      drm/panel: rm68200: Add backlight dependency
      drm/amdkfd: fix uninitialized variable use
      drm/msm: fix building without debugfs
      drm/vmwgfx: use monotonic event timestamps

Arun Pandey (1):
      drm/amd/display: Define dpp1_set_cursor_position in header

Ayan Halder (2):
      drm: mali-dp: Fix bug on scaling with rotation
      drm/arm/malidp: Disable pixel alpha blending for colors that do
not have alpha

Baruch Siach (2):
      drm: of: simplify component probe code
      drm/panel: lvds: Fix driver description heading

Bas Nieuwenhuizen (1):
      drm/amdgpu: Fix always_valid bos multiple LRU insertions.

Ben Crocker (1):
      drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE

Benjamin Gaignard (1):
      drm/stm: check pitch and size calculations even if !CONFIG_MMU

Benoit Parrot (2):
      drm/omap: dispc: disp_wb_setup to check return code
      drm/omap: Add pclk setting case when channel is DSS_WB

Bhawanpreet Lakha (5):
      drm/amd/display: Use MACROS instead of dm_logger
      drm/amd/display: define DC_LOGGER for logger
      drm/amd/display: Fix takover from VGA mode
      drm/amd/display: Move DTRACE and dml_print defines
      drm/amd/display: Use MACROS instead of dm_logger

Bjorn Andersson (1):
      drm/msm: Trigger fence completion from GPU

Boris Brezillon (1):
      drm/vc4: Expose performance counters to userspace

Brian Norris (4):
      drm/bridge/synopsys: stop clobbering drvdata
      drm/bridge/synopsys: dsi: make dw_mipi_dsi_bridge_mode_set() static
      drm/bridge/synopsys: dsi: use common mipi_dsi_create_packet()
      drm/bridge/synopsys: dsi: handle endianness correctly in
dw_mipi_dsi_write()

C, Ramalingam (2):
      drm/i915: Runtime disable for eDP DRRS
      i915/drrs/debugfs: psr status info addition

Changbin Du (19):
      drm/i915/gvt: Rework shadow graphic memory management code
      drm/i915/gvt: Refine the intel_vgpu_mm reference management
      drm/i915/gvt: Refine ggtt and ppgtt root entry ops
      drm/i915/gvt: Refine ggtt_set_shadow_entry
      drm/i915/gvt: Add verbose gtt shadow logs
      drm/i915/gvt: Rename ggtt related functions to be more specific
      drm/i915/gvt: Factor out intel_vgpu_{get, put}_ppgtt_mm interface
      drm/i915/gvt: Use standard pte bit definition
      drm/i915/gvt: Refine pte shadowing process
      drm/i915/gvt: Rework shadow page management code
      drm/i915/gvt: Rename shadow_page to short name spt
      drm/i915/gvt: Rename mpt api {set, unset}_wp_page to {enable,
disable}_page_track
      drm/i915/gvt: Don't extend page_track to mpt layer
      drm/i915/gvt: Provide generic page_track infrastructure for
write-protected page
      drm/i915/gvt: Manage shadow pages with radix tree
      drm/i915/gvt: Define PTE addr mask with GENMASK_ULL
      drm/i915/gvt: Fix guest vGPU hang caused by very high dma setup overhead
      drm/i915/kvmgt: Add kvmgt debugfs entry nr_cache_entries under vgpu
      drm/i915/kvmgt: Handle kzalloc failure

Charlene Liu (13):
      drm/amd/display: PME sw wa to support waking AZ D3
      drm/amd/display: disablePSR in UpdatePlanes in PassiveLevel
      drm/amd/display: fix backlight not off at resume from S4
      drm/amd/display: disable az_clock_gating for endpoint register access only
      drm/amd/display: dpms off mute az audio endpoint only.
      drm/amd/display: eDP sequence BL off first then DP blank.
      drm/amd/display: BL setting save/restore
      drm/amd/display: wait for T9 after backlight off mainlink blank.
      drm/amd/display: add eDP 1.2+ polling for T7
      drm/amd/display: resume from S3 bypass power down HW block.
      drm/amd/display: enable #PME code path for RV.
      drm/amd/display: boot up/S4 fix mainlink off before BL.
      drm/amd/display: add force_trigger even to static screen control

Chen-Yu Tsai (5):
      drm/sun4i: Add compatible strings for A80 TCONs
      drm/sun4i: Add DT binding for Detail Enhancement Unit in Allwinner A80 SoC
      drm/sun4i: Add support for A80 TCONs
      drm/sun4i: Add compatible strings for the A80 display pipeline
      drm/sun4i: Add driver support for A80 display pipeline

Chris Wilson (140):
      drm/i915/selftests: Tweak igt_ggtt_page to speed it up
      drm/i915/selftests: Allow random array allocation to fail
      drm/i915: Delete defunct i915_gem_request_assign()
      drm/i915/execlists: Clear context-switch interrupt earlier in the reset
      drm/i915/execlists: Record elsp offset during engine setup
      drm/i915/execlists: Tidy enabling execlists
      drm/i915: Hold rpm wakeref for modifying the global seqno
      drm/i915: Assert all signalers we depended on did indeed signal
      drm/i915/execlists: Assert there are no simple cycles in the dependencies
      drm/i915/execlists: Reduce list_for_each_safe+list_safe_reset_next
      drm/i915: Assert we do not try to wait on an invalid seqno
      drm/i915: Pass DMA_ATTR_NO_WARN to dma_map_sg()
      drm/i915: Don't adjust priority on an already signaled fence
      drm/i915/pmu: Initialise our dynamic sysfs attributes for use with lockdep
      drm/i915/pmu: Reconstruct active state on starting busy-stats
      drm/i915: Only defer freeing of fence callback when also using the timer
      drm/i915/fence: Separate timeout mechanism for awaiting on dma-fences
      drm/i915: Lock out execlist tasklet while peeking inside for busy-stats
      drm/i915: Use our singlethreaded wq for freeing objects
      drm/i915/selftests: Test i915_sw_fence/dma_fence interop
      drm/i915: Rewrite some comments around RCU-deferred object free
      drm/i915/selftests: Wait for the dma-fence timeout
      drm/i915: Only attempt to scan the requested number of shrinker slabs
      drm/i915/dp: Fix compilation of intel_dp_hdcp_check_link
      drm/i915: Avoid waitboosting on the active request
      drm/i915: Shrink the request kmem_cache on allocation error
      drm/i915: Protect WC stash allocation against direct reclaim
      drm/i915: Increase render/media power gating hysteresis for gen9+
      drm/i915/execlists: Skip forcewake for ELSP submission
      drm/i915/execlists: Inhibit context save/restore for the fake
preempt context
      drm/i915: Track the number of times we have woken the GPU up
      drm/i915: Shrink the GEM kmem_caches upon idling
      drm/i915/lrc: Clear context restore/save inhibit flags for new contexts
      drm/i915/lrc: Remove superfluous WARN_ON
      drm/i915: Simplify guard logic for setup_scratch_page()
      drm/i915: Assert that we do not try to unsubmit a completed request
      drm/i915: Always run hangcheck while the GPU is busy
      drm/i915: Flush ggtt writes through the old fenced vma before
changing fences
      drm/i915/ppgtt: Pin page directories before allocation
      drm/i915/execlists: Flush GTIIR on clearing CS interrupts during reset
      drm/i915: Remove spurious DRM_ERROR for cancelled interrupts
      drm/i915: Report if an unbannable context is involved in a GPU hang
      drm/i915: Add some newlines to intel_engine_dump() headers
      drm/i915: Always update the no_fbc_reason when disabling
      drm/i915: Show the GPU state when declaring wedged
      drm/i915/execlists: Remove the startup spam
      drm/i915: Remove unbannable context spam from reset
      drm/i915/breadcrumbs: Drop request reference for the signaler thread
      drm/i915/selftests: Flush old resets between engines
      drm/i915/selftests: Use a sacrificial context for hang testing
      drm/i915/execlists: Move the reset bits to a more natural home
      drm/i915: Skip post-reset request emission if the engine is not idle
      drm/i915/breadcrumbs: Ignore unsubmitted signalers
      drm/i915: Skip request serialisation if the timeline is already complete
      drm/i915: Trim the retired request queue after submitting
      drm/i915: Tidy up some error messages around reset failure
      drm/i915/pmu: Fix building without CONFIG_PM
      drm/i915/guc: Allow preempt-client to be NULL
      drm/i915: Move the scheduler feature bits into the purview of the engines
      drm/i915: Only allocate preempt context when required
      drm/i915/perf: Fix compiler warning for string truncation
      drm/i915/perf: Fix compiler warning for string truncation
      drm/i915: Remove superfluous worker wakeups when RPS is already boosted
      drm/i915: Avoid truncation before clamping userspace's priority value
      drm/i915: Mark the device as wedged from the beginning of set-wedged
      drm/i915: Be paranoid and post the writes to stop the rings
      drm/i915: Wait for gen3 reset status to be asserted
      drm/i915: Fix kerneldoc warnings for i915_gpu_error
      drm/i915: Fix kerneldoc warnings for intel_ringbuffer
      drm/i915: Fix kerneldoc warnings for i915_gem_userptr
      drm/i915: Fix kerneldoc warnings for i915_gem_request
      drm/i915: Remove lost comment from i915_gem_context
      drm/i915: Add missing kerneldoc for 'ent' in i915_driver_init_early
      drm/i915: Fix kerneldoc parameter markup
      drm/i915: Fix kerneldoc warnings in i915_gem_execbuffer
      drm/i915: Fix kerneldoc warnings for i915_gem_internal
      drm/i915: Disable unused-but-set compiler warning
      drm/i915: Avoid leaking lpe audio platdev.data
      drm/i915/crt: Silence compiler warning for uninitialised status
      drm/i915: Remove redundant check on execlists interrupt
      drm/i915: Move the final intel_gpu_reset() to after declaring wedged
      drm/i915: Don't wake the device up to check if the engine is asleep
      drm/i915: Hold rpm wakeref for printing the engine's register state
      drm/i915: Replace open-coded memset_p()
      drm/i915/selftests: Report setup errors for igt_partial_tiling
      drm/i915/tv: Cleanup up obsolete comments
      drm/i915/sdvo: Tidy up commentary
      drm/i915/panel: Add missing parameters to kerneldoc
      drm/i915/panel: Split range scaling calculation for readiblity
      drm/i915/crt: Remove obsolete kerneldoc-esque comment
      drm/i915/dvo: Remove incorrect kerneldoc markups
      drm/i915/dvo: Fixup commentary
      drm/i915/lvds: Fixup commentary
      drm/i915: Add missing kerneldoc parameters for huc_ucode_xfer
      drm/i915: Fixup kerneldoc for intel_uc_fw_upload()
      drm/i915/atomic: Fixup kerneldoc
      drm/i915: Fixup kerneldoc
      drm/i915: Fixup kerneldoc for intel_pm.c
      drm/i915: Clean up ancient doc comments for i915_ioc32.c
      drm/i915/gtt: Convert WARN_ON to GEM debugging
      drm/i915: Store gen_mask inside the static device info
      drm/i915: Always define GEN as part of GENx_FEATURES
      drm/i915: Store platform_mask inside the static device info
      drm/i915: Assert that we always complete a submission to guc/execlists
      drm/i915/execlists: Remove too early assert
      drm: Fix kerneldoc warnings for drm_lease
      dma-buf/sw_sync: Fix kerneldoc warnings
      drm: Use idr_init_base(1) when using id==0 for invalid
      drm/i915: Remove WARN_ONCE for failing to pm_runtime_if_in_use
      drm/i915: Track GT interrupt handling using the master iir
      drm/i915: Prune gen8_gt_irq_handler
      drm/i915: Clear the in-use marker on execbuf failure
      drm/i915/: Initialise trans_min for skl_compute_transition_wm()
      drm/i915: Track number of pending freed objects
      drm/mm: Fix caching of leftmost node in the interval tree
      drm/i915: Also check view->type for a normal GGTT view
      drm/i915: Move the policy for placement of the GGTT vma into the caller
      drm/i915/fbdev: Use the PLANE_HAS_FENCE flags from the time of pinning
      drm/i915/fbc: Use PLANE_HAS_FENCE to determine if the plane is fenced
      drm/i915: Rename drm_i915_gem_request to i915_request
      drm/i915/execlists: Remove the ring advancement under preemption
      drm/i915/execlists: Add a GEM_TRACE to show when the context is completed
      drm/i915/execlists: Move the GEM_BUG_ON context matches CSB later
      drm/i915/preemption: Allow preemption between submission ports
      drm/i915: Repeat the GEM_BUG_ON message in the ftrace log
      drm/i915: Don't deref request->ctx inside unlocked print_request()
      drm/i915: Replace open-coded wait-for loop
      drm/i915: Suspend submission tasklets around wedging
      drm/i915/execlists: Move irq state manipulation inside irq disabled region
      drm/i915/execlists: Split spinlock from its irq disabling side-effect
      drm/i915: Unwind vma pinning for intel_pin_and_fence_fb_obj error path
      drm/i915/breadcrumbs: Reduce signaler rbtree to a sorted list
      drm/i915/breadcrumbs: Assert all missed breadcrumbs were signaled
      drm/i915: Stop kicking the signaling thread on seqno wraparound
      drm/i915: Flush waiters on seqno wraparound
      drm/i915: Assert that the request is indeed complete when
signaled from irq
      drm/i915: Wrap engine->schedule in RCU locks for set-wedge protection
      drm/i915: Only call tasklet_kill() on the first prepare_reset
      drm/i915: Specify which engines to reset following semaphore/event lockups
      drm/i915/execlists: Use a locked clear_bit() for synchronisation
with interrupt

Chris Zhong (2):
      Documentation: bindings: add dt documentation for cdn DP controller
      drm/rockchip: cdn-dp: remove the DP phy switch

Christian König (119):
      dma-buf: make returning the exclusive fence optional
      drm: move read_domains and write_domain into i915
      drm/amdgpu: allow framebuffer in GART memory as well
      drm/amdgpu: rename pas_id to pasid
      drm/amdgpu: print the PASID with VM faults on GMC v7
      drm/amdgpu: print the PASID with VM faults on GMC v8
      drm/amdgpu: remove agp_base
      drm/amdgpu: move struct amdgpu_mc into amdgpu_gmc.h
      drm/amdgpu: move struct gart_funcs into amdgpu_gmc.h
      drm/amdgpu: move PD/PT address calculation into backend function
      drm/amdgpu: add amdgpu_pasid_free_delayed v2
      drm/amdgpu: always allocate a PASIDs for each VM v2
      drm/amdgpu: trace allocated PASIDs
      drm/amdgpu: trace the PASID instead of the VM pointer
      drm/amdgpu: forward pasid to backend flush implementations
      drm/amdgpu: wire up emit_wreg for gfx v6
      drm/amdgpu: wire up emit_wreg for gfx v7
      drm/amdgpu: wire up emit_wreg for gfx v8
      drm/amdgpu: wire up emit_wreg for gfx v9
      drm/amdgpu: wire up emit_wreg for SI DMA
      drm/amdgpu: wire up emit_wreg for CIK SDMA
      drm/amdgpu: wire up emit_wreg for SDMA v2.4
      drm/amdgpu: wire up emit_wreg for SDMA v3
      drm/amdgpu: wire up emit_wreg for SDMA v4
      drm/amdgpu: wire up emit_wreg for UVD v6
      drm/amdgpu: wire up emit_wreg for UVD v7
      drm/amdgpu: wire up emit_wreg for VCE v4
      drm/amdgpu: wire up emit_wreg for VCN v1
      drm/amdgpu: add new amdgpu_gmc_emit_flush_gpu_tlb callback
      drm/amdgpu: implement gmc_v6_0_emit_flush_gpu_tlb
      drm/amdgpu: implement gmc_v7_0_emit_flush_gpu_tlb
      drm/amdgpu: implement gmc_v8_0_emit_flush_gpu_tlb
      drm/amdgpu: implement gmc_v9_0_emit_flush_gpu_tlb
      drm/amdgpu: add PASID mapping for GMC v7
      drm/amdgpu: add PASID mapping for GMC v8
      drm/amdgpu: add PASID mapping for GMC v9
      drm/amdgpu: add optional ring to *_hdp callbacks
      drm/amdgpu: fallback to generic HDP operation
      drm/amdgpu: remove now superflous *_hdp operation
      drm/amdgpu: reduce reserved VA size
      drm/amdgpu: apply top reserved VA space to pre Vega10 as well
      drm/amdgpu: consistently use AMDGPU_CSA_VADDR
      drm/amdgpu: move static CSA address to top of address space v2
      drm/amdgpu: fix vcn_v1_0_dec_ring_emit_wreg
      drm/amdgpu: revert "drm/amdgpu: use
AMDGPU_GEM_CREATE_VRAM_CLEARED for VM PD/PTs" v2
      drm/amdgpu: drop root shadow sync
      drm/amdgpu: revert "Add a parameter to amdgpu_bo_create()"
      drm/amdgpu: revert "Add support for filling a buffer with 64 bit value"
      drm/amdgpu: fill only the lower range with ATS entries v2
      drm/amdgpu: limit the VM address space with older VCE FW versions
      drm/amdgpu: fix DW estimation on VI
      drm/amdgpu: add new emit_reg_wait callback
      drm/amdgpu: implement gfx_v9_0_ring_emit_reg_wait
      drm/amdgpu: implement sdma_v4_0_ring_emit_reg_wait
      drm/amdgpu: implement uvd_v7_0_(enc_|)ring_emit_reg_wait v2
      drm/amdgpu: implement vce_v4_0_emit_reg_wait v2
      drm/amdgpu: implement vcn_v1_0_(dec|enc)_ring_emit_reg_wait v2
      drm/amdgpu: move waiting for VM flush into gmc_v9_0_emit_flush_gpu_tlb
      drm/amdgpu: make VMID assignment more fair v2
      drm/amdgpu: split finding idle VMID into separate function
      drm/amdgpu: make VMID owner none atomic v2
      drm/amdgpu: stop checking GPU reset counter during VMID grab
      drm/amdgpu: cleanup and simplify amdgpu_vmid_grab_reserved
      drm/amdgpu: move reusing VMIDs into separate function
      drm/amdgpu: restructure amdgpu_vmid_grab
      drm/amdgpu: cache the fence to wait for a VMID
      drm/amdgpu: release the VM shadow in the error path as well
      drm/amdgpu: clear the shadow fence as well
      drm/amdgpu: sync the VM PD/PT before clearing it
      drm/ttm: add ttm_tt_populate wrapper
      drm/amdgpu: remove extra TT unpopulated check
      drm/radeon: remove extra TT unpopulated check
      drm/amdgpu: fix and cleanup UVD IB generation
      drm/amdgpu: cleanup VCN IB generation
      drm/amdgpu: separate PASID mapping from VM flush v2
      drm/amdgpu: update the PASID mapping only on demand
      drm/amdgpu: implement amdgpu_gem_map_(attach/detach)
      drm/amdgpu: mitigate workaround for i915
      drm/amdgpu: use drm_gem_private_object_init
      drm/radeon: use drm_gem_private_object_init
      drm/ttm: set page mapping during allocation
      drm/amdgpu: use the TTM dummy page instead of allocating one
      drm/ttm: add default implementations for ttm_tt_(un)populate
      drm/virtio: remove ttm_pool_* wrappers
      drm/mgag200: remove ttm_pool_* wrappers
      drm/hisilicon: remove ttm_pool_* wrappers
      drm/ast: remove ttm_pool_* wrappers
      drm/qxl: remove ttm_pool_* wrappers
      drm/cirrus: remove ttm_pool_* wrappers
      drm/bochs: remove the default ttm_tt_populate callbacks
      staging: vboxvideo: remove ttm_pool_* wrappers
      drm/ttm: drop bo->glob
      drm/ttm: drop ttm->glob
      drm/ttm: drop ttm->dummy_read_page
      drm/ttm: drop persistent_swap_storage from ttm_bo_init and co
      drm/ttm: move ttm_tt_create into ttm_tt.c v2
      drm/ttm: cleanup ttm_tt_create
      drm/amdgpu: move some functions into amdgpu_ttm.h
      drm/amdgpu: change amdgpu_ttm_set_active_vram_size
      drm/amdgpu: ignore changes of buffer function status because of GPU resets
      drm/amdgpu: use separate status for buffer funcs availability v2
      drm/prime: fix potential race in drm_gem_map_detach
      drm/prime: make the pages array optional for
drm_prime_sg_to_page_addr_arrays
      drm/amd/pp: fix "Delete the wrapper layer of smu_allocate/free_memory"
      drm/amdgpu: add amdgpu_evict_gtt debugfs entry
      drm/amdgpu: drop gtt->adev
      drm/amdgpu: further mitigate workaround for i915
      drm/ttm: move ttm_tt defines into ttm_tt.h
      drm/ttm: add ttm_sg_tt_init
      drm/amdgpu: stop allocating a page array for prime shared BOs
      drm/ttm: add ttm_bo_pipeline_gutting
      drm/ttm: add bo as parameter to the ttm_tt_create callback
      drm/ttm: move initializing ttm->sg into ttm_tt_init_fields
      drm/amdgpu: drop the backing store when DMA-buf imports are evicted
      drm/amdgpu: initial validate the prime BOs into the CPU domain
      drm/amdgpu: explicit give BO type to amdgpu_bo_create
      drm/amdgpu: fix prime teardown order
      drm/radeon: fix prime teardown order
      drm/amdgpu: fix "mitigate workaround for i915"

Christoph Fritz (1):
      drm/panel: Add support for AUO G104SN02 V2 panel

Christophe JAILLET (3):
      drm/meson: Fix an un-handled error path in 'meson_drv_bind_master()'
      drm/meson: Use drm_dev_put() instead of drm_dev_unref()
      drm/meson: Fix some error handling paths in 'meson_drv_bind_master()'

Chunming Zhou (5):
      drm: add func to get max iomem address v2
      drm/amdgpu: only enable swiotlb alloc when need v2
      drm/radeon: only enable swiotlb path when need v2
      drm/amdgpu: all vram is visible for APU (v2)
      drm/amdgpu: Don't change preferred domian when fallback GTT v5

Clark Zheng (1):
      drm/amd/display: Refine disable VGA

Colin Ian King (5):
      drm/bochs: make structure bochs_bo_driver static
      drm/amd/pp: remove redundant pointer internal_buf
      drm/i915/gvt: fix spelling mistake: "destoried" -> "destroyed"
      drm/amdgpu: fix spelling mistake: "asssert" -> "assert"
      drm/amd/pp: use mlck_table.count for array loop index limit

Colin Xu (1):
      drm/i915/gvt: Remove reduntant printing of untracked mmio

Corentin Labbe (3):
      drm/amd/powerplay: remove unused headers
      drm/amd: remove inclusion of non-existing scheduler directory
      drm/amd: Remove inclusion of non-existing include directories

Dan Carpenter (3):
      drm/mgag200: fix a test in mga_vga_mode_valid()
      drm/amd/powerplay: delete some dead code
      drm: mali-dp: Uninitialized variable in malidp_se_check_scaling()

Daniel Stone (1):
      drm/vc4: Advertise supported modifiers for planes

Daniel Vetter (10):
      drm/arcpgu: remove drm_encoder_slave
      MAINTAINERS: Maarten for drm-misc co-maintainer
      drm/todo: Add idr_init_base todo
      drm/docs: Discourage adding more to kms-properties.csv
      drm/docs: Align layout of optional plane blending properties
      drm/docs: Document "scaling mode" property better
      drm/doc: Polish for drm_mode_parse_command_line_for_connector
      drm/doc: Use new substruct support
      drm/todo: i915 could use device_link_add
      drm/doc: Put all driver docs into a separate chapter

Daniele Ceraolo Spurio (7):
      drm/i915: do not stop engines on sanitize if i915.reset=0
      drm/i915: Fix rsvd2 mask when out-fence is returned
      drm/i915/error: remove unused gen8_engine_sync_index
      drm/i915/error: standardize function style in error capture
      drm/i915/error: capture uc_state after gen_state
      drm/i915/icl: new context descriptor support
      drm/i915/icl: Gen11 forcewake support

Dave Airlie (28):
      Merge tag 'drm-intel-next-2018-02-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2018-02-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'topic/hdcp-2018-02-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm/next/du' of git://linuxtv.org/pinchartl/media
into drm-next
      Merge tag 'drm-misc-next-2018-02-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'tilcdc-4.17' of https://github.com/jsarha/linux into drm-next
      Merge tag 'drm-intel-next-2018-02-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm/next/du' of git://linuxtv.org/pinchartl/media
into drm-next
      Merge branch 'drm-next-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      drm/amd/pp: fix missing CONFIG_ACPI.
      Merge tag 'drm-misc-next-2018-03-09-3' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-amdkfd-next-2018-03-11' of
git://people.freedesktop.org/~gabbayo/linux into drm-next
      Merge tag 'drm-intel-next-2018-03-08' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm-next-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge branch 'for-upstream/mali-dp' of
git://linux-arm.org/linux-ld into drm-next
      Merge tag 'drm/tegra/for-4.17-rc1' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge tag 'drm-msm-next-2018-03-20' of
git://people.freedesktop.org/~robclark/linux into drm-next
      Merge tag 'omapdrm-4.17' of git://git.kernel.org/.../tomba/linux
into drm-next
      Merge tag 'drm-misc-next-2018-03-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next
      Merge branch 'vmwgfx-next' of
git://people.freedesktop.org/~thomash/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2018-03-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm-next-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Backmerge tag 'v4.16-rc7' into drm-next
      Merge tag 'drm-intel-next-fixes-2018-03-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-amdkfd-next-2018-03-27' of
git://people.freedesktop.org/~gabbayo/linux into drm-next
      Merge branch 'drm-misc-next-fixes' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

David Weinehall (1):
      drm/i915: Fix incorrect comment

Deepak Rawat (6):
      drm/vmwgfx: Avoid iterating over display unit if crtc is available
      drm/vmwgfx: Move surface copy cmd to atomic function
      drm/vmwgfx: Remove drm_crtc_arm_vblank_event from atomic flush
      drm/vmwgfx: Move screen object page flip to atomic function
      drm/vmwgfx: Move the stdu vblank event to atomic function
      drm/vmwgfx: Send the correct nonblock option for atomic_commit

Dhinakaran Pandiyan (24):
      drm/i915/psr: Kill psr.source_ok flag.
      drm/i915/psr: CAN_PSR() macro to check for PSR source and sink support.
      drm/i915/psr: Avoid initializing PSR if there is no sink support.
      drm/i915/psr: Don't name status or debug registers like control registers.
      drm/vblank: Data type fixes for 64-bit vblank sequences.
      drm/i915/vblank: Make the vblank counter u64 -> u32 typecast explicit
      drm/i915: Handle 64-bit return from drm_crtc_vblank_count()
      drm/amdgpu: Handle 64-bit return from drm_crtc_vblank_count()
      drm/radeon: Handle 64-bit return from drm_crtc_vblank_count()
      drm/tegra: Handle 64-bit return from drm_crtc_vblank_count()
      drm/atomic: Handle 64-bit return from drm_crtc_vblank_count()
      drm/vblank: Do not update vblank count if interrupts are already disabled.
      drm/vblank: Restoring vblank counts after device PM events.
      drm/i915: Estimate and update missed vblanks.
      drm/doc: Fix documentation for _vblank_restore().
      drm/i915/psr: New power domain for AUX IO.
      drm/i915/frontbuffer: Mark frontbuffer flush and invalidate with
might_sleep()
      drm/i915/psr: Extract PSR DPCD initialization and move it to intel_psr.c
      drm/i915/psr: Check for the specific AUX_FRAME_SYNC cap bit.
      drm/i915/dp: Remove redundant sleep after AUX transaction length check.
      drm/i915/dp: Move comment about hw timeout to the right place.
      drm/i915/psr: Check for power state control capability.
      drm/i915/psr: Update PSR2 resolution check for Cannonlake
      drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.

Dmitry Osipenko (2):
      drm/tegra: plane: Make tegra_plane_get_overlap_index() static
      drm/tegra: dc: Dedicate overlay plane to cursor on older Tegra's

Dmitry Rozhkov (1):
      drm/radeon: use raw buffer printk specifier

Dmytro Laktyushkin (8):
      drm/amd/display: revert to hacking bounding box for pipe split
      drm/amd/display: disable seamless vp adjustment for mirrored surface
      drm/amd/display: Update DCN OPTC registers
      drm/amd/display: add per pipe dppclk
      drm/amd/display: add diags clock programming
      drm/amd/display: fix dcn1 dppclk when min dispclk patch applies
      drm/amd/display: update dce_calcs to latest version
      drm/amd/display: clean up dcn pplib notification call

Duke Du (1):
      drm/amd/display: Update the register GRPH_SWAP_CNTL if surface
pixel format changed.

Emily Deng (4):
      drm/amdgpu: Correct sdma_v4 get_wptr(v2)
      drm/amdgpu: Clean sdma wptr register when only enable wptr polling
      drm/amdgpu: Correct the place of amdgpu_pm_sysfs_fini
      drm/amdgpu: Correct the amdgpu_ucode_fini_bo place for Tonga

Eric Anholt (2):
      drm: Print the pid when debug logging an ioctl error.
      drm/panel: simple: Fix the bus format for the Ontat panel

Eric Bernstein (4):
      drm/amd/display: clean up DCHUBBUB register definition in hwseq
      drm/amd/display: Update dcn10_init_hw for FPGA
      drm/amd/display: Expose is_rgb_cspace function in hw_sequencer
      drm/amd/display: Fix DAL surface change test

Eric Huang (6):
      drm/amdgpu: add an interface of amdgpu_dpm_set_mmhub_powergating_by_smu
      drm/amd/powerplay: implement set_mmhub_powergating_by_smu for Raven
      drm/amd/powerplay: add mmhub powergating by smu in powerplay
      drm/amdgpu: add mmhub powergating set by smu
      drm/amd/powerplay: fix thermal interrupts on vega10
      drm/amd/powerplay: fix power over limit on Fiji

Eric Yang (9):
      drm/amd/display: fix cursor related Pstate hang
      drm/amd/display: remove unused function prototypes
      drm/amd/display: turn off cursor when disconnect plane
      drm/amd/display: Treat bad EDID as no EDID
      drm/amd/display: Add logging for aux DPCD access
      drm/amd/display: fix missing az disable in reset backend
      drm/amd/display: update infoframe after dig fe is turned on
      drm/amd/display: fix check condition for edp power control
      drm/amd/display: early return if not in vga mode in disable_vga

Evan Quan (21):
      drm/amd/powerplay: remove unused parameter of
phm_start_thermal_controller (v2)
      drm/amd/powerplay: removed hwmgr_handle_task unused parameter
and given a better name for other parameter
      drm/amd/powerplay: correct PP_TemperatureRange member type since
negative values are part of the valid range
      drm/amd/powerplay: new cgs interface setting dpm thermal range
      drm/amd/powerplay: new hw manager interface for retrieving
device specific thermal range
      drm/amd/powerplay: export vega10 specific thermal ranges (V2)
      drm/amd/powerplay: export the thermal ranges of VI asics (V2)
      drm/amd/powerplay: export the thermal ranges of Carrizo (V2)
      drm/amd/powerplay: use ffs/fls instead of implementing our own
      drm/amdgpu: initilize vega12 psp firmwares
      drm/amdgpu/soc15: update vega12 cg_flags
      drm/amd/powerplay: add vega12_inc.h
      drm/amd/powerplay: update atomfirmware.h (v2)
      drm/amd/powerplay: add new smu9_driver_if.h for vega12 (v2)
      drm/amd/powerplay: add vega12_ppsmc.h
      drm/amd/powerplay: add vega12_pptable.h
      drm/amd/powerplay: update ppatomfwctl (v2)
      drm/amd/powerplay: add new pp_psm infrastructure for vega12 (v2)
      drm/amd/powerplay: add the smu manager for vega12 (v4)
      drm/amd/powerplay: add the hw manager for vega12 (v4)
      drm/amdgpu: no job timeout setting on compute queues

Fabio Estevam (4):
      drm/rockchip: dsi: Remove unnecessary platform_get_resource() error check
      drm/rockchip: inno_hdmi: Remove unnecessary
platform_get_resource() error check
      drm/etnaviv: etnaviv_sched: Staticize functions when possible
      drm/bridge: dw-hdmi: Remove unused hdmi_enable_overflow_interrupts()

Feifei Xu (6):
      drm/amdgpu/sdma4: Remove unused header file from sdma_v4_0.c
      drm/amd/include: Add ip header files for vega12.
      drm/amdgpu: add vega12 to asic_type enum
      drm/amdgpu: add vega12 ucode loading method
      drm/amdgpu/sdma4: Update vega12 sdma golden setting.
      drm/amd/soc15: Add external_rev_id for vega12.

Felix Kuehling (35):
      drm/amdkfd: Conditionally enable PCIe atomics
      drm/amdkfd: Make sched_policy a per-device setting
      drm/amdkfd: Add dGPU support to the device queue manager
      drm/amdkfd: Add dGPU support to the MQD manager
      drm/amdkfd: Add dGPU support to kernel_queue_init
      drm/amdkfd: Add dGPU device IDs and device info
      drm/amdgpu: Enable KFD initialization on dGPUs
      drm/amdgpu: remove useless BUG_ONs
      drm/amdgpu: Fix header file dependencies
      drm/amdgpu: Fix wrong mask in get_atc_vmid_pasid_mapping_pasid
      drm/amdgpu: Remove unused kfd2kgd interface
      drm/amdgpu: Add KFD eviction fence
      drm/amdgpu: Update kgd2kfd_shared_resources for dGPU support
      drm/amdgpu: add amdgpu_sync_clone
      drm/amdgpu: Add GPUVM memory management functions for KFD
      drm/amdgpu: Add submit IB function for KFD
      drm/amdkfd: Centralize IOMMUv2 code and make it conditional
      drm/amdkfd: Add GPUVM virtual address space to PDD
      drm/amdkfd: Implement KFD process eviction/restore
      uapi: Fix type used in ioctl parameter structures
      drm/amdgpu: Move KFD-specific fields into struct amdgpu_vm
      drm/amdgpu: Fix initial validation of PD BO for KFD VMs
      drm/amdgpu: Add helper to turn an existing VM into a compute VM
      drm/amdgpu: Add kfd2kgd interface to acquire an existing VM
      drm/amdkfd: Create KFD VMs on demand
      drm/amdkfd: Remove limit on number of GPUs
      drm/amdkfd: Aperture setup for dGPUs
      drm/amdkfd: Add per-process IDR for buffer handles
      drm/amdkfd: Allocate CWSR trap handler memory for dGPUs
      drm/amdkfd: Add TC flush on VMID deallocation for Hawaii
      drm/amdkfd: Add ioctls for GPUVM memory management
      drm/amdkfd: Kmap event page for dGPUs
      drm/amdkfd: Add module option for testing large-BAR functionality
      drm/amdgpu: Fix acquiring VM on large-BAR systems
      drm/amdkfd: Use ordered workqueue to restore processes

Fengguang Wu (3):
      drm/i915/pmu: fix noderef.cocci warnings
      drm/amdgpu: fix semicolon.cocci warnings
      drm/msm/hdmi: fix semicolon.cocci warnings

Frank Rowand (5):
      x86: devicetree: fix config option around x86_flattree_get_config()
      of: change overlay apply input data from unflattened to FDT
      of: Documentation: of_overlay_apply() replaced by of_overlay_fdt_apply()
      of: convert unittest overlay devicetree source to sugar syntax
      of: improve reporting invalid overlay target path

Geling Li (1):
      drm/amd/display: Add debug flag for p010_mpo_support

Giulio Benetti (4):
      drm/sun4i: fix HSYNC and VSYNC polarity
      drm/sun4i: move rgb mode_valid from connector to encoder
      drm/sun4i: add lvds mode_valid function
      drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE

Gustavo A. R. Silva (7):
      drm/amdkfd: Use ARRAY_SIZE macro in kfd_build_sysfs_node_entry
      drm/edid: use true and false for boolean values
      drm/i915/selftests: fix inconsistent IS_ERR and PTR_ERR
      drm/amdgpu_gem: fix error handling path in amdgpu_gem_va_update_vm
      drm/vc4_validate: Remove VLA usage
      drm/msm/adreno/a5xx_debugfs: fix potential NULL pointer dereference
      drm/msm/dsi: Fix potential NULL pointer dereference in
msm_dsi_modeset_init

Haixia Shi (1):
      drm/rockchip: support prime import sg table

Haneen Mohammed (2):
      drm/vmwgfx: replace drm_*_unreference with drm_*_put
      drm: remove drm_mode_object_{un/reference} aliases

Hans de Goede (4):
      drm/i915/vlv: Add cdclk workaround for DSI
      drm/i915: Add intel_bios_cleanup() function
      drm/i915: Free memdup-ed DSI VBT data structures on driver_unload
      drm/i915: Fix DSI panels with v1 MIPI sequences without a
DEASSERT sequence v3

Harish Kasiviswanathan (1):
      drm/amdkfd: Remove unaligned memory access

Harry Wentland (32):
      drm/amd/display: Move MAX_TMDS_CLOCK define to header
      drm/amd/display: Remove unnecessary fail labels in create_stream_for_sink
      drm/amd/display: Pass signal directly to enable_tmds_output
      drm/amd/display: Debug print when validate_stream fails
      drm/amd/display: Don't allow dual-link DVI on all ASICs.
      drm/amd/display: Don't block dual-link DVI modes
      drm/amd/display: Debug-print reason for mode validation failure
      drm/amd/display: Log which clocks are unsupported
      drm/amd/display: Make create_stream_for_sink more consistent
      drm/amd/display: Drop dm_connector_update_modes
      drm/amd/display: Enable VM support only on APUs newer than CZ
      drm/amd/display: dc: Remove unused display_mode_vba.c
      drm/amd/display: Call update_stream_signal directly from amdgpu_dm
      drm/amd/display: Fix warning about misaligned code
      drm/amd/display: Adding missing TMZ sh/mask entries for DCN1
SURFACE_CONTROL
      drm/amd/display: Remove unused CFLAGS entry in DML Makefile
      drm/amdgpu: Fix potential uninitialized use of 'idle' in amdgpu_ids.c
      drm/amd/display: Change blackout time to 0 on CZ/ST
      drm/amd/display: Remove unused DCE80 compressor
      drm/amd/display: Re-use DCE100 display_power_gating for DCE80
      drm/amd/display: Make couple functions in DCE80 TG static
      drm/amd/display: Add missing Vega defines to dal_asic_id
      drm/amd/display: Remove unused dm_pp_ interfaces
      drm/amd/display: Remove duplicate dm_pp_power_level enum
      drm/amd/display: Use crtc enable/disable_vblank hooks
      drm/amd/display: Return success when enabling interrupt
      drm/amd/display: Clean up formatting in irq_service_dce110.c
      drm/amd/display: Don't blow up if TG is NULL in dce110_vblank_set
      drm/amd/display: Default HDMI6G support to true. Log VBIOS table error.
      drm/amdgpu: Remove some unused elements from amdgpu_connector struct
      drm/amd/display: Check for HW blocks in HWSS, rather than DC
core for cursor
      amdgpu/dm: Default PRE_VEGA ASIC support to 'y'

Hawking Zhang (11):
      drm/amdgpu: split soc15ip header into ip and ip_offset header
      drm/amdgpu: include new ip and ip offset headers
      drm/amd/pp: include new ip and ip offset headers
      drm/amd/dc: include new ip and ip_offset headers
      drm/amdgpu: retire soc15ip.h
      drm/amdgpu: query vram type from atombios
      drm/amdgpu/nbio6: Correct PCIE_INDEX/DATA pair used for smn
register accessing
      drm/amdgpu: vega12 to smu firmware
      drm/amdgpu/sdma4: add sdma4_0_1 support for vega12 (v3)
      drm/amdgpu/gfx9: add golden setting for vega12 (v3)
      drm/amdgpu/soc15: initialize reg base for vega12

Hersen Wu (3):
      drm/amd/display: VGA black screen from s3 when attached to hook
      drm/amd/display: move MST branch initialize to before link training
      drm/amd/display: Check DCN PState ASSERT failure

Himanshu Jha (1):
      drm/vmwgfx: Use kasprintf

Imre Deak (10):
      drm/i915: Fix using BIT_ULL() vs. BIT() for power domain masks
      drm/i915: Add tracking for CDCLK bypass frequency
      drm/i915: Add display WA #1175 for planes ending close to right
screen edge
      drm/i915: Add WA for planes ending close to left screen edge
      drm/i915/bxt, glk: Increase PCODE timeouts during CDCLK freq changing
      drm/i915/bxt, glk: Avoid long atomic poll during CDCLK change
      drm/i915/snb+: Remove incorrect forcewake check in debugfs/i915_drpc_info
      drm/i915: Don't query PCODE RC6VIDS on platforms not supporting it
      drm/i915/gen9, gen10: Disable FBC on planes with a misaligned Y-offset
      drm/i915: Fix hibernation with ACPI S0 target state

Jagan Teki (1):
      drm/panel: simple: Add support for KEO TX31D200VM0BAA

James Ausmus (1):
      drm/i915/icl: Handle expanded PLANE_CTL_FORMAT field

James Zhu (3):
      drm/amdgpu:Fixed wrong emit frame size for enc
      drm/amdgpu:Correct max uvd handles
      drm/amdgpu:Always save uvd vcpu_bo in VM Mode

Jani Nikula (15):
      drm/i915/bios: add DP max link rate to VBT child device struct
      drm/i915: vbt defs typo fixes
      drm/i915: remove redundant ELD connector type update
      drm/i915/dp: abstract rate array length limiting
      drm/i915/dp: clean up source rate limiting for cnl
      drm/i915/dp: limit DP link rate based on VBT on CNL+
      drm/i915: reduce indent in pch detection
      drm/i915: abstract PCH type detection from PCH id
      drm/i915: abstract virtual PCH id detection
      drm/i915: have virtual PCH detection return a PCH id
      drm/i915: introduce INTEL_PCH_ID() and use it
      drm/i915/audio: fix check for av_enc_map overflow
      drm: add documentation for tv connector state margins
      drm/i915/dp: move link rate arrays where they're used
      drm/i915/icl: do not save DDI A/E sharing bit for ICL

Jeffy Chen (10):
      drm/rockchip: Add device links for master and components
      drm/rockchip: vop: Init vskiplines in scl_vop_cal_scale()
      drm/bridge: analogix: Do not use device's drvdata
      drm/bridge: analogix_dp: Fix connector and encoder cleanup
      drm/rockchip: analogix_dp: Add a sanity check for
rockchip_drm_psr_register()
      drm/rockchip: analogix_dp: reorder psr_unregister call in unbind
      drm/rockchip: dw-mipi-dsi: Fix connector and encoder cleanup.
      drm/rockchip: inno_hdmi: Fix error handling path.
      drm/rockchip: inno_hdmi: reorder clk_disable_unprepare call in unbind
      drm/rockchip: dw_hdmi: Move HDMI vpll clock enable to bind()

Jernej Skrabec (16):
      drm/bridge/synopsys: dw-hdmi: Enable workaround for v1.32a
      drm/bridge/synopsys: dw-hdmi: Export some PHY related functions
      drm/bridge/synopsys: dw-hdmi: don't clobber drvdata
      dt-bindings: display: sun4i-drm: Add A83T HDMI pipeline
      drm/sun4i: Add has_channel_0 TCON quirk
      drm/sun4i: Add support for A83T second TCON
      drm/sun4i: Add support for A83T second DE2 mixer
      drm/sun4i: Implement A83T HDMI driver
      dt-bindings: display: sun4i-drm: Add compatibles for H3 HDMI pipeline
      drm/sun4i: Add support for H3 display engine
      drm/sun4i: Add support for H3 mixer 0
      drm/sun4i: Fix polarity configuration for DW HDMI PHY
      drm/sun4i: Add support for variants to DW HDMI PHY
      drm/sun4i: Move and expand DW HDMI PHY register macros
      drm/sun4i: Add support for H3 HDMI PHY variant
      drm/sun4i: Allow building on arm64

Jerry (Fangzhi) Zuo (5):
      drm/amd/display: Fix topology change issue in MST rehook
      drm/amd/display: Fixed non-native modes not lighting up
      drm/amd/display: Allow passing of syspll id to get_smu_clock_info
      drm/amd/display: Use actual TG instance instead of pipe instance
      drm/amd/display: Add bios firmware info version for VG12

Joe Moriarty (4):
      drm: NULL pointer dereference [null-pointer-deref] (CWE 476) problem
      drm: NULL pointer dereference [null-pointer-deref] (CWE 476) problem
      drm: NULL pointer dereference [null-pointer-deref] (CWE 476) problem
      drm: NULL pointer dereference [null-pointer-deref] (CWE 476) problem

Joe Perches (2):
      drm: Reduce object size of DRM_ERROR and DRM_DEBUG uses
      drm: Reduce object size of DRM_DEV_<LEVEL> uses

John Barberiz (7):
      drm/amd/display: Add temporary delay on disconnect patch
      drm/amd/display: Add temporary delay on disconnect patch
      drm/amd/display: Bypass gamma set if not standard type
      drm/amd/display: Fixed if statement parameters to add a delay on
disconnect
      drm/amd/display: Rearchitecture HDMI HPD
      drm/amd/display: Remove delay on disconnect patch
      drm/amd/display: Add passive dongle support for HPD Rearch

Johnson Lin (1):
      drm/i915: Fix Limited Range Color Handling

Joonas Lahtinen (10):
      Merge drm-next into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20180207
      drm/i915: Update DRIVER_DATE to 20180214
      drm/i915: Update DRIVER_DATE to 20180221
      Merge drm-next into drm-intel-next-queued
      Merge drm-next into drm-intel-next-queued (this time for real)
      drm/i915: Update DRIVER_DATE to 20180305
      Merge tag 'gvt-next-2018-03-08' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20180308
      Merge tag 'gvt-next-fixes-2018-03-20' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Jordan Crouse (5):
      drm/msm/gpu: Set number of clocks to 0 if the list allocation fails
      drm/msm: Pass the correct aperture end to drm_mm_init
      drm/msm/adreno: Rename gpmufw to powerfw
      drm/msm/adreno: Define a list of firmware files to load per target
      drm/msm/adreno: Use generic function to load firmware to a buffer object

José Roberto de Souza (1):
      drm: Add PSR version 3 macro

Julia Lawall (1):
      drm/amd/powerplay: drop unneeded newline

Jyri Sarha (4):
      drm/tilcdc: Add support for drm panels
      drm/tilcdc: tilcdc_panel: Rename device from "panel" to "tilcdc-panel"
      drm/omap: Allow HDMI audio setup even if we do not have video configured
      drm: Add optional COLOR_ENCODING and COLOR_RANGE properties to drm_plane

Kai-Heng Feng (1):
      drm/amdgpu: add new device to use atpx quirk

Kelvin Gardiner (1):
      drm/i915/icl: Set graphics mode register for gen11

Ken Chalmers (5):
      drm/amd/display: Fix Maximus pixel clock programming
      drm/amd/display: Eliminate several Maximus-specific code paths
      drm/amd/display: Remove unused param in DML
      drm/amd/display: WBSCL filter init calculation fixes
      drm/amd/display: Remove duplicate entries from BIOS function table

Kenneth Feng (2):
      drm/amd/powerplay: Remove the SOC floor voltage setting
      drm/amd/powerplay: Return per DPM level clock

Kenneth Graunke (1):
      drm/i915: Whitelist SLICE_COMMON_ECO_CHICKEN1 on Geminilake.

Kieran Bingham (2):
      dt-bindings: display: renesas: du: Document r8a77995 bindings
      dt-bindings: display: renesas: lvds: Document r8a77995 bindings

Krunoslav Kovac (5):
      drm/amd/display: Pass full 3x4 remap matrix for color transform
      drm/amd/display: [RS4][RV] SDR Brightness Boost
      drm/amd/display: Force full update on pixel_format_change
      drm/amd/display: Optimize regamma calculations
      drm/amd/display: use HW hdr mult for brightness boost

Kuninori Morimoto (2):
      drm: rcar-du: Use 1000 to avoid misunderstanding in rcar_du_dpll_divider()
      drm: rcar-du: Calculate DPLLCR to be more small jitter

Laurent Pinchart (56):
      drm: rcar-du: Remove zpos field from rcar_du_vsp_plane_state structure
      drm: rcar-du: Enable VSP compositor by default on Gen3
      drm: rcar-du: lvds: Fix LVDS clock frequency range
      drm: omapdrm: Use kernel integer types
      drm: omapdrm: Use unsigned int type
      drm: omapdrm: connector-analog-tv: Remove tvc_of_match forward declaration
      drm: omapdrm: displays: Remove OF node check in connector drivers
      drm: omapdrm: displays: Remove OF node check in encoder drivers
      drm: omapdrm: displays: Remove OF node check in panel drivers
      drm: omapdrm: displays: Get connector source at connect time
      drm: omapdrm: displays: Get panel source at connect time
      drm: omapdrm: displays: Get encoder source at connect time
      drm: omapdrm: dss: Make omapdss_default_get_timings static
      drm: omapdrm: dss: Don't export functions internal to omapdss-base
      drm: omapdrm: dss: Move initialization code from component bind to probe
      drm: omapdrm: dss: Remove dss_get_hdmi_venc_clk_source() function
      drm: omapdrm: dss: Remove unused functions prototypes
      drm: omapdrm: dsi: Make wait_for_bit_change() return a status
      drm: omapdrm: Split init and cleanup from probe and remove functions
      drm: omapdrm: dss: Expose DSS data in a dss_device structure
      drm: omapdrm: dss: Pass DSS private structure to runtime PM functions
      drm: omapdrm: dss: Pass PLL pointer to dss_ctrl_pll_enable()
      drm: omapdrm: dss: Pass DSS pointer to dss_sdi_*() functions
      drm: omapdrm: dss: Pass DSS pointer to dss_ops operations
      drm: omapdrm: dss: Pass DSS pointer to dss_get_*_clk_source()
      drm: omapdrm: dss: Pass DSS pointer to dss clock functions
      drm: omapdrm: dss: Pass DSS pointer to remaining dss functions
      drm: omapdrm: dss: Allocate the DSS private data structure dynamically
      drm: omapdrm: dss: Support passing private data to debugfs show handlers
      drm: omapdrm: dss: Store the registered plls array in struct dss_device
      drm: omapdrm: dss: Store the debugfs root directory in struct dss_device
      drm: omapdrm: dss: Don't unnecessarily cast to dev to pdev and back
      drm: omapdrm: dsi: Pass the dsi_data pointer to internal functions
      drm: omapdrm: dsi: Combine two commonly used inline functions
      drm: omapdrm: dsi: Use dev pointer directly in dsi_bind() function
      drm: omapdrm: dsi: Store the struct device pointer in struct dsi_data
      drm: omapdrm: dsi: Don't pass channel to dispc init/uninit functions
      drm: omapdrm: dss: Pass omap_dss_device pointer to dss_mgr_*() functions
      drm: omapdrm: dss: Pass omap_drm_private pointer to dss_mgr_ops
      drm: omapdrm: dss: Store DSS device pointer in the omapdrm private data
      drm: omapdrm: dss: Store dispc ops in dss_device structure
      drm: omapdrm: dispc: Pass DISPC pointer to dispc_ops operations
      drm: omapdrm: dispc: Pass DISPC pointer to remaining dispc API functions
      drm: omapdrm: dispc: Allocate the dispc private data structure dynamically
      drm: omapdrm: hdmi4: Allocate the omap_hdmi data structure dynamically
      drm: omapdrm: hdmi5: Allocate the omap_hdmi data structure dynamically
      drm: omapdrm: sdi: Allocate the sdi private data structure dynamically
      drm: omapdrm: venc: Allocate the venc private data structure dynamically
      drm: omapdrm: displays: panel-dsi-cm: Fix field access before set
      Merge tag 'overlay_apply_fdt_v7-for-4.17' of
git://git.kernel.org/.../frowand/linux into drm/next/du
      dt-bindings: display: renesas: Add R-Car LVDS encoder DT bindings
      dt-bindings: display: renesas: Deprecate LVDS support in the DU bindings
      drm: rcar-du: Fix legacy DT to create LVDS encoder nodes
      drm: rcar-du: Convert LVDS encoder code to bridge driver
      drm: arm: malidp: Don't destroy planes manually in error handlers
      drm: arm: malidp: Use drm_atomic_helper_shutdown() to disable
planes on removal

Leo (Sunpeng) Li (23):
      drm/atomic: Fix memleak on ERESTARTSYS during non-blocking commits
      drm/atomic: Fix memleak on ERESTARTSYS during non-blocking commits
      drm/amd/display: Implement interface for CRC on CRTC
      drm/amd/display: Implement CRTC CRC for DCE110
      drm/amd/display: Early return on crc get
      drm/amd/display: Fix unused variable compilation error
      drm/amd/display: Fix multiple definitions of handle_crc_irq
      drm/amd/display: Use hardware max low point when sampling OTF
      drm/amd/display: Add color module's gamma helpers to Linux build
      drm/amd/display: Implement color management
      drm/amd/display: Hookup color management functions
      drm/amd/display: Refactor max color lut entries into a macro.
      drm/amd/display: Expose dither setting functionality to Linux
      drm/amd/display: When enabling CRC, disable dither & enable truncation
      drm/amd/display: Rework DCE transform bit depth reduction programming.
      drm/amd/display: Expose DCE110 CRC functions for DCE8
      drm/amd/display: Skip 2 frames when first reading CRC
      drm/amd/display: Fix increment when sampling OTF in DCE
      drm/amd/display: Use 4096 lut entries
      drm/amd/display: Add regamma lut write mask to SOC base
      drm/amd/display: Fix memleaks when atomic check fails.
      drm/amd/display: Use correct error codes
      drm/amd/display: Convert CTM to 2's complement

Linus Walleij (20):
      drm/bridge: Add bindings for TI THS8134
      drm/bridge: Provide a way to embed timing info in bridges
      drm/bridge: Add timing support to dumb VGA DAC
      drm/pl111: Support handling bridge timings
      drm/bridge: Rename argument from crtc to bridge
      drm/panel: Device tree bindings for ARM Versatile panels
      drm/panel: Add support for ARM Versatile panels
      drm/pl111: Properly detect the ARM PL110 variants
      drm/pl111: Handle the Versatile RGB/BGR565 mode
      drm/pl111: Support variants with broken clock divider
      drm/pl111: Support variants with broken VBLANK
      drm/pl111: Support multiple endpoints on the CLCD
      drm: simple_kms_helper: Add mode_valid() callback support
      drm/panel: Fix ARM Versatile panel clocks
      bridge: Elaborate a bit on dumb VGA bridges in Kconfig
      drm: simple_kms_helper: Fix .mode_valid() documentation
      drm/pl111: Make the default BPP a per-variant variable
      drm/pl111: Handle the RealView variant separately
      drm/bridge: sii902x: Retry status read after DDI I2C
      drm/pl111: Use max memory bandwidth for resolution

Lionel Landwerlin (9):
      Revert "drm/i915: mark all device info struct with __initconst"
      drm/i915/hsw: add missing disabled EUs registers reads
      drm/i915/perf: fix perf stream opening lock
      drm/i915: store all subslice masks
      drm/i915/debugfs: reuse max slice/subslices already stored in sseu
      drm/i915/debugfs: add rcs topology entry
      drm/i915: add rcs topology to error state
      drm/i915: add query uAPI
      drm/i915: expose rcs topology through query uAPI

Liviu Dudau (5):
      drm/mali-dp: Rotated planes need a larger pitch size.
      drm/mali-dp: Align pitch size to be multiple of bus burst read size.
      drm/mali-dp: Don't enable scaling engine for planes that only rotate.
      drm/mali-dp: Fix malidp_atomic_commit_hw_done() for event sending.
      drm: mali-dp: Turn off CRTC vblank when removing module.

Lloyd Atkinson (3):
      drm/msm/dsi: check for failure on retrieving pll in dsi manager
      drm/msm/dsi: correct DSI id bounds check during registration
      drm/msm/dsi: check msm_dsi and dsi pointers before use

Lucas De Marchi (2):
      drm/i915: Apply Display WA #1183 on skl, kbl, and cfl
      drm/i915/cnl: apply Display WA #1178 to fix type C dongles

Lucas Stach (20):
      drm/etnaviv: don't fail to build on arches without PHYS_OFFSET
      drm/etnaviv: add missing major features field to debugfs
      drm/etnaviv: track fences by IDR instead of seqno
      drm/etnaviv: hook up DRM GPU scheduler
      drm/etnaviv: move dependency handling to scheduler
      drm/etnaviv: lock BOs after all other submit work is done
      drm/etnaviv: replace hangcheck with scheduler timeout
      drm/etnaviv: use correct format specifier for size_t
      dt-bindings: etnaviv: add slave interface clock
      drm/etnaviv: remove the need for a gpu-subsystem DT node
      drm/etnaviv: split out and optimize MMU fault dumping
      drm/etnaviv: add support for slave interface clock
      drm/etnaviv: update hardware headers from rnndb
      drm/etnaviv: add more minor features fields
      drm/etnaviv: add hardware database
      drm/etnaviv: add security handling mode enum
      drm/etnaviv: handle security states
      drm/etnaviv: add function to load the initial PTA state
      drm/etnaviv: add PTA handling to MMUv2
      drm/etnaviv: bump HW job limit to 4

Luis de Bethencourt (3):
      drm: amd: Fix trailing semicolons
      drm: Fix trailing semicolon
      drm/msm/mdp5: Fix trailing semicolon

Lukas Wunner (6):
      PCI: Make pci_wakeup_bus() & pci_bus_set_current_state() public
      vga_switcheroo: Update PCI current_state on power change
      vga_switcheroo: Deduplicate power state tracking
      vga_switcheroo: Use device link for HDA controller
      vga_switcheroo: Let HDA autosuspend on mux change
      drm/nouveau: Runtime suspend despite HDA being unbound

Maarten Lankhorst (10):
      Revert "drm/atomic: Fix memleak on ERESTARTSYS during
non-blocking commits"
      drm/i915: Always call to intel_display_set_init_power() in resume_early.
      drm/i915: Do not WARN_ON with small framebuffers.
      drm/atomic: Remove WARN_ON for invalid plane configuration.
      drm/crc: Add support for polling on the data fd.
      drm/i915: Ignore minimum lines for level 0 in skl_compute_plane_wm, v2.
      drm/i915: Release connector iterator on a digital port conflict.
      drm/i915: Check for I915_MODE_FLAG_INHERITED before
drm_atomic_helper_check_modeset
      drm/atomic: Call ww_acquire_done after drm_modeset_lock_all
      drm/i915: Handle changing enable_fbc parameter at runtime better.

Mahesh Kumar (10):
      drm/i915/icl: Don't allocate fixed bypass path blocks for ICL
      drm/i915/icl: Do not fix dbuf block size to 512
      drm/i915/icl: Fail flip if ddb allocated are less than min
display buffer needed
      drm/i915/icl: NV12 y-plane ddb is not in same plane
      drm/i915/icl: Introduce MBus related registers
      drm/i915/icl: Enable both DBuf slices during init
      drm/i915/icl: initialize MBus during display init
      drm/i915/icl: program mbus during pipe enable
      drm/i915/cnl: Fix PORT_TX_DW5/7 register address
      drm/i915/icl: remove port A/E lane sharing limitation.

Manasi Navare (5):
      drm/i915/edp: Do not do link training fallback or prune modes on EDP
      drm/dp: Add HBR3 support in existing DRM DP helpers
      drm/dp: Add definitions for TPS4 bits and macros to check the support
      drm/i915/dp: Fix the order of platforms for setting DP source rates
      drm/i915/dp: Add HBR3 rate (8.1 Gbps) to dp_rates array

Marc Zyngier (3):
      drm/rockchip: Clear all interrupts before requesting the IRQ
      drm/rockchip: Do not use memcpy for MMIO addresses
      drm/rockchip: Don't use spin_lock_irqsave in interrupt context

Marek Szyprowski (2):
      drm/bridge: analogix_dp: Postpone enabling runtime power management
      drm/bridge: analogix_dp: Don't create useless connectors

Markus Elfring (2):
      drm/tilcdc: Delete an error message for a failed memory
allocation in seven functions
      drm/tilcdc: panel: Use common error handling code in of_get_panel_info()

Martin Tsai (2):
      drm/amd/display: Remove return when no EDID read.
      drm/amd/display: add monitor patch for delay after DP receive power up

Matthew Auld (1):
      drm/i915/selftests: add missing gtt shrinker test

Matthias Kaehlcke (9):
      drm/amd/powerplay: Fix enum mismatch
      drm/amd/powerplay: Remove extra pair of parentheses
      drm/amd/display: Remove extra pairs of parentheses in dce_calcs.c
      amdgpu/dc: Fix enum mismatch in calls to program_color_matrix()
      amdgpu/dc/dml: Consolidate redundant CFLAGS
      amdgpu/dc/calcs: Consolidate redundant CFLAGS
      amdgpu/dc/dml: Support clang option for stack alignment
      amdgpu/dc/calcs: Support clang option for stack alignment
      drm/radeon/mkregtable: Delete unused list functions and macros

Mauro Carvalho Chehab (1):
      drm: intel_dpio_phy: fix kernel-doc comments at nested struct

Maxime Ripard (31):
      drm/sun4i: backend: Move line stride setup to buffer setup function
      drm/sun4i: backend: Document the engine operations
      drm/sun4i: backend: Allow a NULL plane pointer to retrieve the format
      drm/sun4i: backend: Add a custom plane state
      drm/sun4i: engine: Add a custom crtc atomic_check
      drm/sun4i: engine: Add a VBLANK quirk callback
      drm/sun4i: engine: Create an atomic_begin callback
      drm/sun4i: Add a driver for the display frontend
      drm/sun4i: backend: Wire in the frontend
      drm/sun4i: backend: Add a custom atomic_check for the frontend
      drm/sun4i: backend: Use runtime_pm variant of atomic_commit_tail
      drm/sun4i: backend: Make sure we don't have a commit pending
      drm/fourcc: Add a alpha field to drm_format_info
      drm/atmel-hlcdc: Use the alpha format field in drm_format_info
      drm/atmel-exynos: Use the alpha format field in drm_format_info
      drm/rockchip: Use the alpha format field in drm_format_info
      drm/vc4: Use the alpha format field in drm_format_info
      drm/sun4i: backend: Fix structure indentation
      drm/sun4i: backend: Fix define typo
      drm/sun4i: framebuffer: Add a custom atomic_check
      drm/sun4i: backend: Move the coord function in the shared part
      drm/sun4i: backend: Set a default zpos in our reset hook
      drm/sun4i: backend: Add support for zpos
      drm/sun4i: backend: Check for the number of alpha planes
      drm/rcar-du: dw-hdmi: Fix compilation
      drm/sun4i: backend: Assign the pipes automatically
      drm/sun4i: Remove the plane description structure
      drm/sun4i: backend: Make zpos configurable
      drm/sun4i: backend: Remove ARGB spoofing
      drm/sun4i: backend: Check that we only have a single YUV plane
      drm/sun4i: backend: Support YUV planes

Meghana Madhyastha (10):
      video: backlight: Add helpers to enable and disable backlight
      video: backlight: Add of_find_backlight helper in backlight.c
      video: backlight: Add devres versions of of_find_backlight
      drm/tinydrm: Convert tinydrm_enable/disable_backlight to
backlight_enable/disable
      drm/tinydrm: Replace tinydrm_of_find_backlight with of_find_backlight
      drm/tinydrm: Call devres version of of_find_backlight
      drm/panel: Use backlight_enable/disable helpers
      drm/omapdrm: Use backlight_enable/disable helpers
      drm/panel: Use of_find_backlight helper
      drm/omapdrm: Use of_find_backlight helper

Michal Srb (2):
      drm/i915/cmdparser: Check reg_table_count before derefencing.
      drm/i915/cmdparser: Do not check past the cmd length.

Michal Wajdeczko (8):
      drm/i915/guc: Redefine guc_log_level modparam values
      drm/i915/guc: Change values for i915_guc_log_control
      drm/i915/guc: Keep GuC log disabled by default
      drm/i915/guc: Don't forget to free GuC error log
      drm/i915/guc: Don't try to create log runtime if there is no log
      drm/i915: Enable inject_load_failure only in DEBUG config
      drm/i915/uc: Introduce intel_uc_suspend|resume
      drm/i915/huc: Mark firmware as failed on auth failure

Michał Winiarski (1):
      drm/i915/guc: Fill preempt context once at init time

Michel Dänzer (3):
      drm/amdgpu/dce6: Use DRM_DEBUG instead of DRM_INFO for HPD IRQ info
      drm/amdgpu/dce: Don't turn off DP sink when disconnected
      drm/radeon: Don't turn off DP sink when disconnected

Michel Thierry (5):
      drm/i915: Use the engine name directly in the error_state file
      drm/i915/lrc: Update reg_state macros to pass checkpatch
      drm/i915: Move LRC register offsets to a header file
      drm/i915: Update missing parts after the rename to i915_request
      drm/i915/icl: Add Indirect Context Offset for Gen11

Mihail Atanassov (1):
      drm: mali-dp: Add YUV->RGB conversion support for video layers

Mika Kahola (1):
      drm/i915: Check for fused or unused pipes

Mika Kuoppala (1):
      drm/i915/icl: Interrupt handling

Mikita Lipski (9):
      drm/amd/display: Prevent master programming in multisync
      drm/amd/display: Remove unnecessary register programming
      drm/amd/display: Set irq state only on existing crtcs
      drm/amdgpu: Add a missing lock for drm_mm_takedown
      drm/amdgpu: Unify the dm resume calls into one
      drm/amd/display: Enable backlight support for pre-DCE11 ASICs
      drm/amdgpu: Use atomic function to disable crtcs with dc enabled
      drm/amdgpu: Disable irq on device before destroying it
      drm/amdgpu - Disable all irqs before disabling all CRTCs

Monk Liu (17):
      drm/amdgpu: fix&cleanups for wb_clear
      drm/amdgpu: skip ECC for SRIOV in gmc late_init
      drm/amdgpu: only flush hotplug work without DC
      drm/amdgpu: cond_exec only for schedule with a job
      drm/amdgpu: change gfx9 ib test to use WB
      drm/amdgpu: move WB_FREE to correct place
      drm/amdgpu: increase gart size to 512MB
      drm/amdgpu: don't use MM idle_work for SRIOV(v2)
      drm/amdgpu: adjust timeout for ib_ring_tests(v2)
      drm/amdgpu: cleanup SA inti and fini(v2)
      drm/amdgpu: disable GFX ring and disable PQ wptr in hw_fini
      drm/amdgpu: stop all rings before doing gpu recover
      drm/amdgpu: cleanups for vram lost handling
      drm/amdgpu: try again kiq access if not in IRQ(v4)
      drm/amdgpu: give warning before sleep in kiq_r/wreg
      drm/amdgpu: implement mmio byte access helper for MB
      drm/amdgpu: refactoring mailbox to fix TDR handshake bugs(v2)

Mustamin B Mustaffa (1):
      drm/i915: Enable VBT based BL control for DP

Neil Armstrong (2):
      drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs
      drm/meson: Add support for DMT modes on HDMI

Nikola Cornij (2):
      drm/amd/display: Define remove_stream_from_ctx resource func
      drm/amd/display: Remove couple of unused OPTC registers

Noralf Trønnes (8):
      drm/ioctl: Remove trailing whitespace
      drm/tinydrm/mi0283qt: Use common include order
      drm/tinydrm/mi0283qt: Remove ili9341.h
      drm/tinydrm/mipi-dbi: Add mipi_dbi_enable_flush()
      drm/tinydrm/mipi-dbi: Add poweron-reset functions
      drm/tinydrm/mi0283qt: Let the display pipe handle power
      drm/tinydrm: Embed the mode in tinydrm_connector
      drm/tinydrm/mipi-dbi: Change reset active time

Oak Zeng (2):
      drm/amdgpu: Move IH clientid defs to separate file
      drm/amdkfd: Populate DRM render device minor

Oded Gabbay (2):
      dma-fence: add comment for WARN_ON in dma_fence_release()
      drm/amdkfd: add missing include of mm.h

Oleksandr Andrushchenko (5):
      drm/simple_kms_helper: Fix NULL pointer dereference with no active CRTC
      drm/simple_kms_helper: Add {enable|disable}_vblank callback support
      drm/mxsfb: Do not use deprecated drm_driver.{enable|disable)_vblank
      drm/tve200: Do not use deprecated drm_driver.{enable|disable)_vblank
      drm/pl111: Do not use deprecated drm_driver.{enable|disable)_vblank

Oscar Mateo (3):
      drm/i915: Stop getting the fault address from RING_FAULT_REG
      drm/i915: Return a default RCS context size
      drm/i915/icl: Correctly initialize the Gen11 engines

Paul McQuade (1):
      drm: dma_bufs: Fixed checkpatch issues

Paulo Zanoni (6):
      drm/i915/gen11: fix the SAGV block time for gen11
      drm/i915/icl: allow the reg_read ioctl to read the RCS TIMESTAMP register
      drm/i915/icl: add ICL support to cnl_set_procmon_ref_values
      drm/i915/icl: add the main CDCLK functions
      drm/i915/icl: implement the display init/uninit sequences
      drm/i915/icl: Add the ICL PCI IDs

Peter Ujfalusi (1):
      drm/omap: Init fbdev emulation only when we have displays

Philippe CORNU (12):
      drm/stm: ltdc: add clut mode support
      drm/stm: ltdc: use crtc_mode_fixup to update adjusted_mode clock
      dt-bindings: display: stm32: correct clock-names in dsi panel example
      drm/stm: dsi: Add 1.31 version support
      drm/stm: ltdc: add non-alpha color formats
      drm/stm: ltdc: remove non-alpha color formats on layer 2 for older hw
      drm/bridge/synopsys: dsi: readl_poll_timeout return value clean up
      dt-bindings: display: panel: Add support for Raydium RM68200 DSI panel
      drm/panel: Add support for Raydium RM68200 panel driver
      dt-bindings/display/panel: otm8009a: Add optional power-supply property
      drm/panel: otm8009a: Add support for the optional power-supply
      drm/panel: otm8009a: Adopt SPDX identifiers

Philippe Cornu (6):
      drm/dsi: Fix improper use of mipi_dsi_device_transfer() return value
      drm/stm: drv: Improve data transfers
      drm/bridge/synopsys: dsi: Add a warning msg on dsi read requests
      drm/bridge/synopsys: dsi: Fix dsi_host_transfer() return value
      drm/bridge/synopsys: dsi: Add read feature
      drm/bridge/synopsys: dsi: Add 1.31 version support

Rafael Antognolli (1):
      drm/i915/cnl: WaPipeControlBefore3DStateSamplePattern

Rafael J. Wysocki (1):
      PCI: Restore config space on runtime resume despite being unbound

Ramalingam C (12):
      drm/i915: Extending HDCP for HSW, BDW and BXT+
      drm/i915: II stage HDCP auth for repeater only
      drm/i915: Start repeater auth on READY/CP_IRQ
      drm/i915: Check for downstream topology errors
      drm/i915: Handle failure from 2nd stage HDCP auth
      drm/i915: Stop encryption for repeater with no sink
      drm/i915: Connector info in HDCP debug msgs
      drm/i915: Retry HDCP bksv read
      drm/i915: Optimize HDCP key load
      drm/i915: Detect panel's hdcp capability
      drm/i915: Reauthenticate HDCP on failure
      drm/i915: fix misalignment in HDCP register def

Rex Zhu (117):
      drm/amd/pp: Add a helper to convert VID to voltage value
      drm/amd/pp: Refine code shorten variable name
      drm/amd/pp: Add memory clock info display on Cz/St
      drm/amd/pp: Export registers for read vddc on VI/Vega10
      drm/amd/pp: Add querying current gfx voltage for CI/VI
      drm/amd/pp: Add querying current gfx voltage for Vega10
      drm/amd/pp: Implement voltage regulator config on CI
      drm/amd/pp: Fix SMIO implementation on CI
      drm/amdgpu: add custom power policy support in sysfs
      drm/amd/pp: Add custom power profile mode support on Vega10
      drm/amd/pp: Store stable Pstate clocks
      drm/amd/pp: Add stable Pstate clk display support in debugfs
      drm/amd/pp: Refine code abbreviate variable name
      drm/amd/pp: Move DPMTABLE_* definitions to common header file
      drm/amd/pp: Add a new pp feature mask bit for OD feature
      drm/amd/pp: Add and initialize OD_dpm_table for CI/VI.
      drm/amd/pp: Add OD driver clock/voltage display on smu7
      drm/amdgpu: Expose more GPU sensor queries
      drm/amdgpu: Bump driver version for sensor pstate clk
      drm/amd/pp: Add hwmgr interface for edit dpm table
      drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs
      drm/amd/pp: Disable OD feature if VBIOS limits
      drm/amd/pp: Disable OD feature on APU/Iceland
      drm/amd/pp: Implement edit_dpm_table on smu7
      drm/amd/pp: Update smu7 dpm table with OD clock/voltage
      drm/amd/pp: Add update_avfs call when set_power_state
      drm/amd/pp: Change activity_target for performance optimization on Polaris
      drm/amd/pp: Delete dead code in powerplay
      drm/amd/pp: Add struct profile_mode_setting for smu7
      drm/amd/pp: Delete unnecessary function argument
      drm/amd/pp: Delete debug info when set power_profile_mode
      drm/amd/pp: Refine pp_dpm_force_clock_level functions
      drm/amd/pp: Enable pp_set_power_profile_mode under manual mode
      drm/amd/pp: Fix sysfs pp_dpm_pcie bug on CI/VI
      drm/amd/pp: Expose set/get_power_limit for DGPU
      drm/amdgpu: Get/set dgpu power cap via hwmon API
      drm/amd/pp: Restore power profile mode in auto dpm level on Vega10
      drm/amd/pp: Fix error handling when smu return failed on Vega10.
      drm/amd/pp: Fix bug that dpm level was not really locked
      drm/amdgpu: Add query vram width in CGS query system info
      drm/amdgpu: Change default value of module parameter
amdgpu_pp_feature_mask
      drm/amd/pp: Add a pp feature mask bit for AutoWattman feature
      drm/amd/pp: Remove duplicated vega10_is_smc_ram_running calls
      drm/amd/pp: Add debug info when smu failed on Vega10
      drm/amd/pp: Remove dead error checking code on Vega10
      drm/amd/pp: Refine code in powerplay for Cz/Vega10
      drm/amd/pp: Cleaning up vega10_enable_dpm_tasks function
      drm/amd/pp: Move common dpm check functions to hardwaremanager.c
      drm/amd/pp: Print more smu failed info on Vega10
      drm/amd/pp: Fix incorrect return value in smu7_check_clk_voltage_valid
      drm/amd/dc: Use forward declaration instand of include header file
      drm/amd/pp: Simplify the create of powerplay instance
      drm/amd/pp: Refine powerplay instance
      drm/amdgpu: Notify sbios device ready before send request
      drm/amd/pp: Use amdgpu acpi helper functions in powerplay
      drm/amd/pp: Remove the wrap functions for acpi in powerplay
      drm/amd/pp: Remove cgs_query_system_info
      drm/amd/pp: Export new smu message for PCC feature on Vega10
      drm/amd/pp: Add PCC feature support on Vega
      drm/amd/pp: Add common interface in smu for update dpm setting
      drm/amd/pp: Add a helper to set field in u32
      drm/amd/pp: Implement update_dpm_settings on Polaris
      drm/amd/pp: Implement update_dpm_settings on Fiji
      drm/amd/pp: Implement update_dpm_settings on Tonga
      drm/amd/pp: Implement update_dpm_settings on CI
      drm/amd/pp: Implement get/set_power_profile_mode on smu7
      drm/amd/pp: Fix sclk in highest two levels when compute on smu7
      drm/amd/pp: Revert gfx/compute profile switch sysfs
      drm/amd/pp: Add auto power profilng switch based on workloads (v2)
      Revert "drm/amd/pp: Add a pp feature mask bit for AutoWattman feature"
      drm/amd/pp: Remove cgs wrapper function for temperature update
      drm/amd/pp: Delete the wrapper layer of smu_allocate/free_memory
      drm/amdgpu: Delete cgs wrapper functions for gpu memory manager
      drm/amd/pp: Drop wrapper functions for upper/lower_32_bits
      drm/amd/pp: Add #ifdef checks for CONFIG_ACPI
      drm/amd/pp: Simplified the avfs btc state on smu7
      drm/amd/pp: Fix memory leak in error path in smumgr
      drm/amd/pp: Clean up header file include
      drm/amd/pp: Delete is_smc_ram_running function on RV
      drm/amd/pp: Remove meanless return value check in RV
      drm/amd/pp: Add rv_read_arg_from_smc to smu backend function table
      drm/amd/pp: Mark internal functions as static in rv_smumgr.c
      drm/amd/pp: Add new smu backend function smc_table_manager
      drm/amd/pp: Add rv_copy_table_from/to_smc to smu backend function table
      drm/amd/pp: Fix function parameter not correct
      drm/amd/pp: Replace rv_* with smu10_*
      drm/amd/pp: Move helper functions to smu_help.c
      drm/amdgpu: Plus NULL function pointer check
      drm/amdgpu: Don't compared ip_block_type with ip_block_index
      drm/amdgpu: Remove wrapper layer of smu ip functions
      drm/amdgpu: Call amdgpu_ucode_fini_bo in amd_powerplay.c
      drm/amd/pp: Delete dead code on cz_clockpowergating.c
      drm/amd/pp: Remove dead header file pp_asicblocks.h
      drm/amd/pp: Mv cz uvd/vce pg/dpm functions to cz_hwmgr.c
      drm/amd/pp: Remove unneeded void * casts in cz_hwmgr.c/cz_smumgr.c
      drm/amd/pp: Replace function/struct name cz_* with smu8_*
      drm/amd/pp: Rename file name cz_* to smu8_*
      drm/amd/pp: Remove the cgs wrapper for notify smu version on APU
      drm/amdgpu: Delete dead code when early init
      drm/amd/pp: Remove dead functions in vega10_smumgr.c
      drm/amd/pp: Mark bunches of functins in vega10_smumgr.c static
      drm/amd/pp: Move functions to smu backend table for vega10
      drm/amd/pp: Clean up header file for Vega10
      drm/amd/pp: Delete get_xclk function in powerplay (v2)
      drm/amd/pp: Remove unneeded void * casts for Vega10
      drm/amdgpu: Fix kernel NULL pointer dereference when amdgpu fini
      drm/amdgpu: Fix kernel NULL pointer dereference in dpm functions
      drm/amd/pp: Fix gfx ring test failed on Fiji without hw avfs support
      drm/amd/pp: Fix unable to handle kernel paging request when set pp table
      drm/amdgpu: Remove wrapper layer of cgs irq handling
      drm/amd/pp: Refine register_thermal_interrupt function
      drm/amd/pp: Add smu irq handlers in sw_init instand of hw_init
      drm/amd/pp: Fix set wrong temperature range on smu7
      drm/amd/pp: Add smu irq handlers for legacy asics
      drm/amd/pp: Clean up powerplay code on Vega12
      drm/amd/pp: Add new asic support in pp_psm.c
      drm/amd/pp: clean header file hwmgr.h

Rob Clark (9):
      drm/msm: add a5xx specific debugfs
      drm/msm: add sudo flag to submit ioctl
      drm/msm: rename mdp->disp
      drm/msm: strip out msm_fence_cb
      drm/msm/dsi: fix direct caller of msm_gem_free_object()
      drm/msm/mdp5: rework CTL START signal handling
      drm/msm/mdp5: print a bit more of the atomic state
      drm/msm/mdp5: add missing LM flush bits
      drm/msm/mdp5: don't pre-reserve LM's if no dual-dsi

Rodrigo Siqueira (7):
      drm/virtio: Add tabs at the start of a line
      drm/virtio: Add blank line after variable declarations
      drm/virtio: Add */ in block comments to separate line
      drm/virtio: Remove return from void function
      drm/virtio: Replace 'unsigned' for 'unsigned int'
      drm/virtio: Remove multiple blank lines
      drm/virtio: Add spaces around operators

Rodrigo Vivi (23):
      drm/i915/cnl: Add Port F definition.
      drm/i915/icl: Add initial Icelake definitions.
      drm/i915/cnp: Ignore VBT request for know invalid DDC pin.
      drm/i915/cnl: Fix aux selection for WA 1178
      drm/i915/cnp: Properly handle VBT ddc pin out of bounds.
      drm/i915/cnl: Add Cannonlake PCI IDs for another SKU.
      drm/i915/cnl: Add AUX-F support
      drm/i915/cnl: Extend Wa 1178 to Aux F.
      drm/i915/cnl: Fix _CNL_PORT_TX_DW2_LN0_F definition.
      drm/i915: Fix DPLCLKA_CFGCR0 bits for Port F.
      drm/i915/cnl: Add right GMBUS pin number for HDMI on Port F.
      drm/i915: For HPD connected port use hpd_pin instead of port.
      drm/i915/cnl: Add HPD support for Port F.
      drm/i915/cnl: Enable DDI-F on Cannonlake.
      drm/i915/cnl: Fix DP max rate for Cannonlake with port F.
      drm/i915/cnl: Sync PCI ID with Spec.
      drm/i915/cnl: Remove alpha_support protection
      drm/i915/psr2: Fix max resolution supported.
      drm/i915/psr: Don't avoid PSR when PSR2 conditions are not met.
      drm/i915/cnl: Add WaRsDisableCoarsePowerGating
      drm/i915/cnl: document WaVFUnitClockGatingDisable
      drm/i915/cnp: Document WaSouthDisplayDisablePWMCGEGating
      drm/i915/cnl: Add Wa_2201832410

Roger He (5):
      drm/ttm: add the missed global memory count update
      drm/ttm: use bit flag to replace allow_reserved_eviction in
ttm_operation_ctx
      drm/ttm: add bit flag TTM_OPT_FLAG_FORCE_ALLOC
      drm/ttm: set TTM_OPT_FLAG_FORCE_ALLOC in ttm_bo_force_list_clean
      drm/ttm: check if free mem space is under the lower limit

Roman Li (7):
      drm/amd/display: make FBC mem alloc dynamic
      drm/amd/display: cleanup after FBC init rework
      drm/amd/display: Fix FBC topology change
      drm/amd/display: Fix null-derefs on non-dcn builds
      drm/amd/display: fix boot-up on vega10
      drm/amd/display: Make FBC work without fbdev emulation
      drm/amd/display: Fix active dongle hotplug

Sagar Arun Kamble (8):
      drm/i915/guc: Add uc_fini_wq in gem_init unwind path
      drm/i915/guc: Grab RPM wakelock while disabling GuC interrupts
      drm/i915/guc: Enable interrupts before resuming GuC during runtime resume
      drm/i915/guc: Fix lockdep due to log relay channel handling
under struct_mutex
      drm/i915/guc: Update name and prototype of i915_guc_log_control
      drm/i915/guc: Fix comments style in intel_guc_log.c
      drm/i915/guc: Fix return from guc_log_relay_file_create
      drm/i915/uc: Make GuC/HuC fw fetch and loading functions/file
structure symmetric

Samson Tam (1):
      drm/amd/display: add support for regkey "LCDFreeSyncDefault"

Samuel Li (15):
      drm: export gem dmabuf_ops for drivers to reuse
      drm: add kernel doc for exported gem dmabuf_ops
      drm/amdgpu: Move to gtt before cpu accesses dma buf.
      drm/amdgpu: rename static functions in amdgpu_display.c
      drm/amdgpu: rename amdgpu_crtc_page_flip_target
      drm/amdgpu: rename amdgpu_crtc_set_config
      drm/amdgpu: rename amdgpu_print_display_setup
      drm/amdgpu: rename amdgpu_ddc_probe
      drm/amdgpu: rename amdgpu_framebuffer_init
      drm/amdgpu: rename amdgpu_user_framebuffer_create
      drm/amdgpu: rename amdgpu_modeset_create_props
      drm/amdgpu: rename amdgpu_update_display_priority
      drm/amdgpu: rename amdgpu_crtc_scaling_mode_fixup
      drm/amdgpu: rename amdgpu_get_crtc_scanoutpos
      drm/amdgpu: rename amdgpu_crtc_idx_to_irq_type

Santha Meena Ramamoorthy (1):
      drm/qxl: Replace drm_gem_object_reference/unreference() with _get/put()

Sean Paul (25):
      drm: Fix link-status kerneldoc line lengths
      drm/i915: Add more control to wait_for routines
      drm: Add Content Protection property
      drm: Add some HDCP related #defines
      drm/i915: Add HDCP framework + base implementation
      drm/i915: Make use of indexed write GMBUS feature
      drm/i915: Add function to output Aksv over GMBUS
      drm/i915: Implement HDCP for HDMI
      drm/i915: Implement HDCP for DisplayPort
      drm/i915: Don't allow HDCP on PORT E/F
      drm/i915: Only disable HDCP when it's active
      drm/panel: panasonic-vvx10f034n00: Fix wuxga_nt_panel_disable()
return value
      Merge airlied/drm-next into drm-misc-next
      drm/panel: panasonic-vvx10f034n00: More return value fixes
      drm/sun4i: Fix build warnings in sunxi_engine.h
      drm/i915: Restore HDCP DRM_INFO when with no downstream
      drm/i915: Downgrade hdcp logs from INFO to DEBUG_KMS
      Merge airlied/drm-next into drm-misc-next
      Merge tag 'topic/backlight_for_lag-2018-01-29' of
git://anongit.freedesktop.org/drm/drm-misc into drm-misc-next
      drm/rockchip: Don't use atomic constructs for psr
      dt-bindings: Clarify timing subnode use as panel-timing
      dt-bindings: Add headings to simple-panel bindings
      drm/panel: simple: Use display_timing for lq123p1jx31
      drm/rockchip: Remove analogix psr worker
      Merge airlied/drm-next into drm-misc-next

Sergei Shtylyov (8):
      drm: rcar-du: lvds: Fix LVDCR1 for R-Car gen3
      drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen2
      drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen3
      drm: rcar-du: lvds: Refactor LVDS startup
      dt-bindings: display: renesas: du: Document R8A77970 bindings
      dt-bindings: display: renesas: lvds: Document R8A77970 bindings
      drm: rcar-du: Add R8A77970 support
      drm: rcar-du: lvds: Add R8A77970 support

Shaoyun Liu (6):
      drm/amdgpu: Enable ip block bit mask print out info by default
      drm/amdgpu: Basic emulation support
      drm/amdgpu: Fix none-powerplay issue when load driver on emulation mode
      drm/amdgpu: Avoid get vram info from atom bios on emulation mode
      drm/amdgpu: Double the timeout count on emulation mode
      drm/amdgpu: Add place holder for soc15 asic init on emulation

Shawn Guo (1):
      dma-buf/sw_sync: fix document of sw_sync_create_fence_data

Shirish S (12):
      drm/amd/display: make dm_dp_aux_transfer return payload bytes
instead of size
      drm/amd/display: check for ipp before calling cursor operations
      drm/amd/display: allocate fbc buffer in AMDGPU_GEM_DOMAIN_GTT
      drm/amd/display: defer modeset check in dm_update_planes_state
      drm/amd/display: validate plane in dce110 for scaling
      drm/amd/display: update plane params before validation
      drm/amd/display: disable CRTCs with NULL FB on their primary plane (V2)
      drm/atomic: Add new reverse iterator over all plane state (V2)
      drm/amd/display: validate plane format on primary plane
      drm/amd/display: Correct the plane enumeration order (v2)
      drm/amd/display: Check msg->size before starting aux transfer
      drm/amd/display: fix dereferencing possible ERR_PTR()

SivapiriyanKumarasamy (4):
      drm/amd/display: Synchronize update plane addr for freesync
      drm/amd/display: Vari-bright looks disabled near end of MM14
      drm/amd/display: Varibright fix bug and review comments
      drm/amd/display: Varibright add null check

Stefan Brüns (1):
      drm/i915: Try EDID bitbanging on HDMI after failed read

Stefan Schake (4):
      drm/vc4: Set premultiplied for alpha formats
      drm/vc4: Check if plane requires background fill
      drm/vc4: Move plane state to header
      drm/vc4: Enable background color fill when necessary

Stefan Wahren (1):
      drm/vc4: Replace long HDMI udelay with usleep_range

Steve Kowalik (1):
      drm/msm: Replace gem_object deprecated functions

Sujaritha Sundaresan (2):
      drm/i915/guc : Decoupling ADS and logs from submission
      drm/i915/guc : GEM_BUG_ON on invoking GuC reset function

Sylwester Nawrocki (1):
      drm/bridge: analogix: Remove unreachable code from analogic_dp_core.c

Tao (1):
      drm/amd/display: Set vsc pack revision when DPCD revision is >= 1.2

Thierry Reding (10):
      drm/pl111: Remove reverse dependency on DRM_DUMB_VGA_DAC
      drm/amdgpu: Remove duplicate setting of ->need_swiotlb
      drm/tegra: gem: Reshuffle declarations
      drm/tegra: gem: Make __tegra_gem_mmap() available more widely
      drm/tegra: fb: Implement ->fb_mmap() callback
      drm/tegra: plane: Support format modifiers
      drm/tegra: fb: Properly support linear modifier
      drm/tegra: hub: Use private object for global state
      drm/tegra: gem: Map pages via the DMA API
      drm/tegra: prime: Implement ->{begin,end}_cpu_access()

Thomas Daniel (1):
      drm/i915/icl: Enhanced execution list support

Thomas Hellstrom (12):
      drm/vmwgfx: Cursor update fixes
      drm/ttm: Clean up kmap_atomic_prot selection code
      drm/ttm: Export the ttm_k[un]map_atomic_prot API.
      drm/vmwgfx: Add a cpu blit utility that can be used for page-backed bos
      drm/vmwgfx: Use the cpu blit utility for framebuffer to screen
target blits
      drm/vmwgfx: Fix multiple command buffer context use
      drm/vmwgfx: Avoid pinning fbdev framebuffers
      drm/vmwgfx: Improve on hibernation
      drm/vmwgfx: Get rid of the device-private suspended member
      drm/vmwgfx: Stricter count of legacy surface device resources
      drm/vmwgfx: Unpin the screen object backup buffer when not used
      drm/vmwgfx: Bump version patchlevel and date

Tom St Denis (18):
      drm/ttm: Fix coding style in ttm_bo.c
      drm/ttm: Add a default BO destructor to simplify code (v2)
      drm/ttm: Change ttm_tt page allocations to return errors
      drm/ttm: Fix coding style in ttm_pool_store()
      drm/ttm: Simplify ttm_dma_find_pool() (v2)
      drm/ttm: Fix coding style in ttm_bo_move_memcpy()
      drm/ttm: Remove unncessary retval from ttm_bo_vm_fault()
      drm/ttm: Simplify ttm_eu_reserve_buffers()
      drm/ttm: Fix coding style in ttm_tt_swapout()
      drm/ttm: Fix coding style in ttm_dma_pool_alloc_new_pages()
      drm/ttm: Simplify ttm_dma_page_put()
      drm/amd/powerplay:  Zero out power data in
AMDGPU_PP_SENSOR_GPU_POWER readout
      drm/amd/amdgpu: Correct VRAM width for APUs with GMC9
      drm/amd/amdgpu: Mask rptr as well in ring debugfs
      drm/amd/amdgpu: re-add missing GC 9.1 and SDMA0 4.1 sh_mask header files
      drm/amdgpu: replace iova debugfs file with iomem (v3)
      drm/amd/amdgpu: Add missing "DDR4" label
      drm/amd/amdgpu: fix offset into page with amdgpu_iomem debugfs file

Tomasz Figa (1):
      drm/rockchip: Get rid of unnecessary struct fields

Tomeu Vizoso (1):
      drm/virtio: Don't return invalid caps on timeout

Tomi Valkeinen (19):
      drm/omap: reorganize locking in mgr_fld_write
      drm/omap: acx565akm:  use __be32 when reading status
      drm/omap: fbdev: use 'screen_buffer' field
      drm/omap: fbdev: avoid double initializer entry
      drm/omap: fix omap_fbdev_free() when omap_fbdev_create() wasn't called
      drm/omap: cleanup fbdev init/free
      drm/omap: add HPD support to connector-dvi
      dt-bindings: display: add HPD gpio to DVI connector
      drm/omap: remove leftover enums
      drm/omap: set WB channel-in in wb_setup()
      drm/omap: fix WBDELAYCOUNT for HDMI
      drm/omap: fix WBDELAYCOUNT with interlace
      drm/omap: fix WB height with interlace
      drm/omap: fix scaling limits for WB
      drm/omap: add writeback funcs to dispc_ops
      drm/omap: fix maximum sizes
      drm/omap: cleanup color space conversion
      drm/omap: fix compile error when debugfs is disabled
      drm/omap: fix compile error when DPI is disabled

Tony Cheng (11):
      drm/amd/display: dal 3.1.28
      drm/amd/display: dal 3.1.29
      drm/amd/display: dal 3.1.30
      drm/amd/display: dal 3.1.31
      drm/amd/display: dal 3.1.32
      drm/amd/display: dal 3.1.33
      drm/amd/display: dal 3.1.34
      drm/amd/display: dal 3.1.35
      drm/amd/display: dal 3.1.36
      drm/amd/display: dal 3.1.37
      drm/amd/display: dal 3.1.38

Tvrtko Ursulin (21):
      drm/i915: Apply headless DMC workaround for CNL
      drm/i915/pmu: Only enumerate available counters in sysfs
      drm/i915/pmu: Use kcalloc instead of kzalloc
      drm/i915/icl: Icelake interrupt register addresses and bits
      drm/i915/icl: Gen11 render context size
      drm/i915: Downgrade incorrect engine constructor usage warnings
to development
      drm/i915: Per-engine scratch VMA is mandatory
      drm/i915/pmu: Fix sysfs exported counter config
      drm/i915/pmu: Fix PMU enable vs execlists tasklet race
      drm/i915/pmu: Fix sleep under atomic in RC6 readout
      drm/i915: Use INTEL_GEN everywhere
      drm/i915: Replace some negative Gen checks
      drm/i915: Fix i915_gem_context.h header
      drm/i915: Handle RC6 counter wrap
      drm/i915: Make global seqno known in i915_gem_request_execute tracepoint
      drm/i915/icl: Show interrupt registers in debugfs
      drm/i915: Move page sizes out of the 8-bit sandwich
      drm/i915/icl: Prepare for more rings
      drm/i915: Wedged engine mask makes more sense in hex
      drm/i915/icl: Ringbuffer interrupt handling
      drm/i915/pmu: Work around compiler warnings on some kernel configs

Ville Syrjälä (96):
      drm/i915: Nuke a pointless unreachable()
      drm/i915: Add the missing Y/Yf modifiers for SKL+ sprites
      drm/i915: Clean up the sprite modifier checks
      drm/i915: Add CCS capability for sprites
      drm/i915: Allow up to 32KB stride on SKL+ "sprites"
      drm/i915: Reject odd pipe source width with double wide/dual link
      drm/i915: Use drm_mode_get_hv_timing() to populate plane clip rectangle
      drm/arm/hdlcd: Use drm_mode_get_hv_timing() to populate plane
clip rectangle
      drm/arm/mali-dp: Use drm_mode_get_hv_timing() to populate plane
clip rectangle
      drm/simple_kms_helper: Use drm_mode_get_hv_timing() to populate
plane clip rectangle
      drm/imx: Use drm_mode_get_hv_timing() to populate plane clip rectangle
      drm/mediatek: Use drm_mode_get_hv_timing() to populate plane
clip rectangle
      drm/meson: Use drm_mode_get_hv_timing() to populate plane clip rectangle
      drm/msm/mdp5: Use drm_mode_get_hv_timing() to populate plane
clip rectangle
      drm/nouveau/kms/nv50: Use drm_mode_get_hv_timing() to populate
plane clip rectangle
      drm/rockchip: Use drm_mode_get_hv_timing() to populate plane
clip rectangle
      drm/tegra/dc: Use drm_mode_get_hv_timing() to populate plane
clip rectangle
      drm/vmwgfx: Use drm_mode_get_hv_timing() to populate plane clip rectangle
      drm/zte: Use drm_mode_get_hv_timing() to populate plane clip rectangle
      drm/i915: Use enum plane_id for frontbuffer tracking
      drm/i915: Implement display w/a #1143
      drm/i915: Add a comment exlaining CCS hsub/vsub
      drm: Warn if plane/crtc/encoder/connector index exceeds our 32bit bitmasks
      drm/modes: Move 3D stereo flag check into drm_mode_validate_basic()
      drm/uapi: Validate the mode flags/type
      drm/uapi: Deprecate DRM_MODE_FLAG_PIXMUX
      drm/uapi: Deprecate DRM_MODE_FLAG_BCAST
      drm/modes: Fix description of DRM_MODE_TYPE_USERDEF
      drm/modes: Kill off the oddball DRM_MODE_TYPE_CRTC_C vs.
DRM_MODE_TYPE_BUILTIN handling
      drm/modes: Kill DRM_MODE_TYPE_CLOCK_CRTC_C define
      drm/uapi: Deprecate nonsense kms mode types
      drm/modes: Provide global mode_valid hook
      drm/i915: Provide a device level .mode_valid() hook
      drm/rcar-du: Use drm_mode_get_hv_timing() to populate plane clip rectangle
      drm/sun4i: Use drm_mode_get_hv_timing() to populate plane clip rectangle
      drm/i915: Deprecate I915_SET_COLORKEY_NONE
      drm/i915: Reject undefined colorkey flags
      drm/i915: Give all ioctl functions an _ioctl suffix
      drm/i915: Assert that we don't overflow frontbuffer tracking bits
      drm/i915: Don't set cursor pipe select bits on g4x+
      drm/i915: Set the primary plane pipe select bits on gen4
      drm/i915: Drop WaDoubleCursorLP3Latency:ivb
      drm/i915: Fail if we can't get a fence for gen2/3 tiled scanout
      drm/i915: Only pin the fence for primary planes (and gen2/3)
      drm/i915: Clean up fbc vs. plane checks
      drm/i915: Require fence only for FBC capable planes
      drm/i915: Extract intel_plane_{pin,unpin}_fb()
      drm/i915: Add a FIXME about FBC vs. fence. 90/270 degree rotation
      drm/i915: Use the correct power domain for aux ch
      drm/i915: Add enum aux_ch and clean up the aux init to use it
      drm/i915: Nuke aux regs from intel_dp
      drm/i915: Collect aux ch vfunc setup into intel_dp_aux_init()
      drm: Check that the plane supports the request format+modifier combo
      drm/i915: Remove the pipe/plane ID checks from skl_check_ccs_aux_surface()
      drm: Include the header with the prototype for
drm_get_panel_orientation_quirk()
      drm/uapi: The ctm matrix uses sign-magnitude representation
      drm/i915: Remove the pointless 1:1 matrix copy
      drm/i915: Rename pipe CSC to use ilk_ prefix
      drm/i915: Don't mangle the CTM on pre-HSW
      drm/i915: Consult aux_ch instead of port in ->get_aux_clock_divider()
      drm/atomic: Include color encoding/range in plane state dump
      drm/i915: Correctly handle limited range YCbCr data on VLV/CHV
      drm/i915: Fix plane YCbCr->RGB conversion for GLK
      drm/i915: Add support for the YCbCr COLOR_ENCODING property
      drm/i915: Change the COLOR_ENCODING prop default value to BT.709
      drm/i915: Add support for the YCbCr COLOR_RANGE property
      drm/i915: s/intel_dp_aux_ch/intel_dp_aux_xfer/
      drm/i915: Keep the AKSV details in intel_dp_hdcp_write_an_aksv()
      drm/i915: Deduplicate the code to fill the aux message header
      drm/armada: Construct a temporary crtc state for plane checks
      drm/armada: Use drm_mode_get_hv_timing() to populate plane clip rectangle
      drm: Don't pass clip to drm_atomic_helper_check_plane_state()
      drm: Don't create properties without names
      drm: Check property/enum name length
      drm/i915: Convert intel_hpd_irq_event() into an encoder hotplug hook
      drm/i915: Reinitialize sink scrambling/TMDS clock ratio on HPD
      drm/i915: Move SST DP link retraining into the ->post_hotplug() hook
      drm/i915: Nuke intel_dp->channel_eq_status
      drm/i915: Track whether the DP link is trained or not
      drm: Reject replacing property enum values
      drm: WARN when trying add enum values to non-enum/bitmask properties
      drm: WARN when trying to add enum value > 63 to a bitmask property
      drm/uapi: Deprecate DRM_MODE_PROP_PENDING
      drm: Make property flags u32
      drm: Reject bad property flag combinations
      drm/nouveau: Replace the iturbt_709 prop with the standard
COLOR_ENCODING prop
      drm: Fix some coding style issues
      Revert "drm: Use a flexible array member for blob property data"
      drm: Remove now pointelss blob->data casts
      drm: Verify gamma/degamma LUT size
      drm: Introduce drm_color_lut_size()
      drm/i915: Remove the blob->data casts
      drm/i915: Use drm_color_lut_size()
      drm: Nuke the useless 'ret' variable from drm_mode_convert_umode()
      drm: Make drm_mode_vrefresh() a bit more accurate
      drm: Fix uabi regression by allowing garbage mode->type from userspace

Vitaly Prosyak (3):
      drm/amd/display: De PQ implementation
      drm/amd/display: Handle HDR use cases.
      drm/amd/display: Fix handling of linear transfer function

Wei Yongjun (3):
      drm/etnaviv: make local symbols static
      drm/panel: ili9322: Make local symbols static
      drm/meson: Fix potential NULL dereference in meson_drv_bind_master()

Weinan Li (4):
      drm/i915/gvt: add define GEN9_MOCS_SIZE
      drm/i915/gvt: add interface to check if context is inhibit
      drm/i915/gvt: init mmio by lri command in vgpu inhibit context
      drm/i915: add schedule out notification of preempted but completed request

Wenjing Liu (1):
      drm/amd/display: Update Link Training Fallback logic

Xingyue Tao (1):
      drm/amd/display: add psr_version to stream

Xiong Zhang (2):
      drm/i915/gvt: Release gvt->lock at the failure of finding page track
      drm/i915/gvt: Return error at the failure of finding page_track

Yakir Yang (1):
      drm/bridge: analogix_dp: detect Sink PSR state after configuring the PSR

Yong Zhao (2):
      drm/amdgpu: Replace kgd_mem with amdgpu_bo for kernel pinned gtt mem
      drm/amdgpu: Update MMHUB power gating register settings

Yongqiang Sun (21):
      drm/amd/display: Use pipe_control_lock instead of tg lock.
      drm/amd/display: disable eDP backlight for extend monitor only
reboot use case.
      drm/amd/display: Disable eDP with a proper sequence.
      drm/amd/display: Move hubp reg access from hwss to hubp module.
      drm/amd/display: Use real BE and FE index to program regs.
      drm/amd/display: Check opplist in pipe ctx not in res pool.
      drm/amd/display: Move dpp reg access from hwss to dpp module.
      drm/amd/display: Move opp reg access from hwss to opp module.
      drm/amd/display: Refactor remove mpcc processing.
      drm/amd/display: Move output_tf to stream_state/update
      drm/amd/display: Add timing generator count to resource pool.
      drm/amd/display: Check hubp in pipe_ctx not in res_pool.
      drm/amd/display: Null check for gamma correction.
      drm/amd/display: Add return value for detect dp.
      drm/amd/display: Add primary tmz_c and meta tmz tmz_c.
      drm/amd/display: Keep eDP stream enabled during boot.
      drm/amd/display: Clear dmps off for eDP when resume.
      drm/amd/display: Remove 300Mhz minimum disp clk limit.
      drm/amd/display: Modified set bandwidth sequence.
      drm/amd/display: Set disp clk in a safe way to avoid over high
dpp clk. (v2)
      drm/amd/display: Fixed dim around 1sec when resume from S3 (v2)

Yue Hin Lau (1):
      drm/amd/display: update cur_clock correctly within set bandwidth

Zhenyu Wang (8):
      drm/i915/gvt: Fix one gvt_vgpu_error() use in dmabuf.c
      drm/i915/gvt: remove gvt max port definition
      drm/i915/gvt: Fix vGPU sched timeslice calculation warning
      drm/i915/gvt: Fix check error of vgpu create failure message
      drm/i915/gvt: Fix check error on fence mmio handler
      drm/i915/gvt: Fix one indent error
      drm/i915/gvt: Fix check error on hws_pga_write() fail message
      drm/i915/gvt: force to set all context control bits from guest

Zhi Wang (2):
      drm/i915/gvt: Invalidate vGPU PPGTT mm objects during a vGPU reset.
      drm/i915/gvt: Update PDPs after a vGPU mm object is pinned.

jan.tuerk@emtrion.com (1):
      dt-bindings: Add vendor prefix for emtrion GmbH

zain wang (6):
      drm/bridge: analogix_dp: Don't power bridge in analogix_dp_bind
      drm/rockchip: analogix_dp: set psr activate/deactivate when
enable/disable bridge
      drm/bridge: analogix_dp: Don't change psr while bridge is disabled
      drm/bridge: analogix_dp: add fast link train for eDP
      drm/rockchip: add mutex vop lock
      drm/bridge: analogix_dp: Only wait for panel ACK on PSR entry

Ørjan Eide (1):
      drm/rockchip: Respect page offset for PRIME mmap calls

 .../bindings/display/bridge/renesas,lvds.txt       |    58 +
 .../bridge/{ti,ths8135.txt => ti,ths813x.txt}      |    13 +-
 .../bindings/display/connector/dvi-connector.txt   |     1 +
 .../bindings/display/etnaviv/etnaviv-drm.txt       |    24 +-
 .../devicetree/bindings/display/msm/dsi.txt        |    26 +-
 .../display/panel/arm,versatile-tft-panel.txt      |    31 +
 .../bindings/display/panel/auo,g104sn02.txt        |    12 +
 .../bindings/display/panel/display-timing.txt      |     5 +
 .../bindings/display/panel/koe,tx31d200vm0baa.txt  |    25 +
 .../bindings/display/panel/orisetech,otm8009a.txt  |     2 +
 .../bindings/display/panel/raydium,rm68200.txt     |    25 +
 .../bindings/display/panel/simple-panel.txt        |     4 +
 .../devicetree/bindings/display/renesas,du.txt     |    35 +-
 .../bindings/display/rockchip/cdn-dp-rockchip.txt  |    74 +
 .../devicetree/bindings/display/st,stm32-ltdc.txt  |     2 +-
 .../bindings/display/sunxi/sun4i-drm.txt           |   104 +-
 .../devicetree/bindings/vendor-prefixes.txt        |     1 +
 Documentation/devicetree/overlay-notes.txt         |     4 +-
 Documentation/gpu/drivers.rst                      |    21 +
 Documentation/gpu/drm-kms.rst                      |     8 +-
 Documentation/gpu/index.rst                        |     9 +-
 Documentation/gpu/kms-properties.csv               |     1 -
 Documentation/gpu/todo.rst                         |    17 +
 MAINTAINERS                                        |    12 +-
 arch/x86/kernel/devicetree.c                       |     2 +-
 drivers/dma-buf/dma-fence.c                        |     1 +
 drivers/dma-buf/reservation.c                      |    31 +-
 drivers/dma-buf/sw_sync.c                          |    10 +-
 drivers/gpu/drm/amd/acp/include/acp_gfx_if.h       |     1 -
 drivers/gpu/drm/amd/amdgpu/Makefile                |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   150 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   160 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    98 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |   179 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |    81 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |    83 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  1577 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |    95 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h   |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c      |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |   550 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   707 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   127 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h        |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |    35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |    23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h           |     3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   112 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    58 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |   412 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |    45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |    53 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   110 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |    78 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   128 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   566 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c      |   290 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c          |   164 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    50 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c             |    62 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |    56 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h           |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c           |    23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |    38 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   303 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |   124 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |    15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h            |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    87 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    95 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   399 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |     6 +-
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |   307 +-
 drivers/gpu/drm/amd/amdgpu/ci_dpm.h                |     7 -
 drivers/gpu/drm/amd/amdgpu/cik.c                   |    42 +-
 drivers/gpu/drm/amd/amdgpu/cik.h                   |     2 +
 drivers/gpu/drm/amd/amdgpu/cik_dpm.h               |     7 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |     4 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    41 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |     4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    80 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |    81 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |    79 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |    81 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |    26 +-
 .../{powerplay/inc/pp_acpi.h => amdgpu/emu_soc.c}  |    15 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |    78 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |    68 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |    86 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   374 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |    28 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   139 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   189 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   216 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   181 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |     4 +-
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |    18 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |    93 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |   200 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h              |     7 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |    17 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |    11 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |    56 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.h             |    20 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |    70 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.h              |    24 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |    44 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |    53 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   107 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |    31 +-
 drivers/gpu/drm/amd/amdgpu/si.h                    |     2 +
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    50 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |    36 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.h                |     3 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |    66 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h                 |     3 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |    30 -
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |    30 -
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |    66 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |   148 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |    56 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |   159 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |     6 +-
 drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c       |     3 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |    46 +-
 drivers/gpu/drm/amd/amdgpu/vi.h                    |     2 +
 drivers/gpu/drm/amd/amdkfd/Kconfig                 |     3 +-
 drivers/gpu/drm/amd/amdkfd/Makefile                |     4 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   535 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |    19 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.c            |     3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   356 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   323 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    14 +
 .../drm/amd/amdkfd/kfd_device_queue_manager_cik.c  |    56 +
 .../drm/amd/amdkfd/kfd_device_queue_manager_vi.c   |    93 +
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |    34 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |    59 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |   357 +
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h             |    78 +
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |     5 +
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |    13 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |     7 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |    44 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |    27 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |    37 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   101 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   664 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |     3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    22 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |     7 +-
 drivers/gpu/drm/amd/display/Kconfig                |     2 +-
 drivers/gpu/drm/amd/display/Makefile               |     5 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |     6 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   296 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    36 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   274 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |   126 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    14 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |    76 -
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    22 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |    33 -
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c |     9 +
 drivers/gpu/drm/amd/display/dc/basics/logger.c     |     3 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |    11 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    14 +-
 .../drm/amd/display/dc/bios/bios_parser_helper.c   |     8 +
 .../drm/amd/display/dc/bios/bios_parser_helper.h   |     1 +
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |    16 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.h   |     2 +-
 .../drm/amd/display/dc/bios/command_table_helper.h |    33 +-
 .../amd/display/dc/bios/command_table_helper2.h    |    30 +-
 .../display/dc/bios/command_table_helper_struct.h  |    66 +
 drivers/gpu/drm/amd/display/dc/calcs/Makefile      |    14 +-
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |   190 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |    78 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   241 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |    35 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   156 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |     7 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   175 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |    26 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    30 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |     3 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    47 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |     3 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    20 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |     4 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    28 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    24 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |    14 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |    35 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    44 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c    |    21 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |     5 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h      |    35 +
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.c     |    14 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |   112 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |    28 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |    15 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |   134 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h |     1 +
 .../amd/display/dc/dce100/dce100_hw_sequencer.c    |     2 +-
 .../amd/display/dc/dce100/dce100_hw_sequencer.h    |     4 +
 .../drm/amd/display/dc/dce100/dce100_resource.c    |    51 +
 .../drm/amd/display/dc/dce110/dce110_compressor.c  |    14 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   366 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.h    |     9 +-
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   |     2 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |    14 +-
 .../display/dc/dce110/dce110_timing_generator.c    |   122 +
 .../display/dc/dce110/dce110_timing_generator.h    |     6 +
 .../display/dc/dce110/dce110_timing_generator_v.c  |    17 +-
 .../drm/amd/display/dc/dce110/dce110_transform_v.c |     5 +-
 .../drm/amd/display/dc/dce112/dce112_compressor.c  |    27 +-
 .../drm/amd/display/dc/dce112/dce112_resource.c    |     8 +-
 .../amd/display/dc/dce120/dce120_hw_sequencer.c    |     3 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |     4 +-
 .../display/dc/dce120/dce120_timing_generator.c    |     3 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile      |     2 +-
 .../drm/amd/display/dc/dce80/dce80_compressor.c    |   834 -
 .../drm/amd/display/dc/dce80/dce80_compressor.h    |    78 -
 .../drm/amd/display/dc/dce80/dce80_hw_sequencer.c  |    38 +-
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |    90 +
 .../amd/display/dc/dce80/dce80_timing_generator.c  |   127 +-
 .../amd/display/dc/dce80/dce80_timing_generator.h  |     6 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |   192 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.h |     5 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |    22 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |    35 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |    56 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |    77 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |     1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |    39 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |    25 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   531 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |     1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h   |     2 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c   |     9 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.h   |    14 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |    14 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |    28 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |    10 +
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |     3 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h       |    31 -
 drivers/gpu/drm/amd/display/dc/dm_services_types.h |    21 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |    26 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |     3 -
 .../drm/amd/display/dc/dml/display_mode_structs.h  |     1 -
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |  6085 ----
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |   598 -
 .../drm/amd/display/dc/dml/display_rq_dlg_calc.c   |  1772 --
 .../drm/amd/display/dc/dml/display_rq_dlg_calc.h   |   148 -
 .../amd/display/dc/dml/display_rq_dlg_helpers.c    |     1 +
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.h  |     3 +-
 .../gpu/drm/amd/display/dc/dml/dml_common_defs.h   |     2 -
 .../gpu/drm/amd/display/dc/dml/dml_inline_defs.h   |     1 +
 .../dc/dml/dml_logger.h}                           |    17 +-
 .../amd/display/dc/gpio/dce120/hw_factory_dce120.c |     3 +-
 .../display/dc/gpio/dce120/hw_translate_dce120.c   |     3 +-
 .../amd/display/dc/gpio/dcn10/hw_factory_dcn10.c   |     3 +-
 .../amd/display/dc/gpio/dcn10/hw_translate_dcn10.c |     3 +-
 drivers/gpu/drm/amd/display/dc/i2caux/aux_engine.c |    33 +-
 .../display/dc/i2caux/dce110/aux_engine_dce110.c   |     4 -
 .../dc/i2caux/dce110/i2c_hw_engine_dce110.c        |     6 +-
 .../amd/display/dc/i2caux/dce120/i2caux_dce120.c   |     3 +-
 .../drm/amd/display/dc/i2caux/dcn10/i2caux_dcn10.c |     3 +-
 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c     |     1 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    35 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |     2 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |     2 +-
 drivers/gpu/drm/amd/display/dc/inc/dce_calcs.h     |     6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |     7 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |    10 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |     3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |     2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |     4 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    45 +
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |     2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/link_hwss.h     |     2 +
 .../amd/display/dc/irq/dce110/irq_service_dce110.c |    73 +-
 .../amd/display/dc/irq/dce120/irq_service_dce120.c |     3 +-
 .../amd/display/dc/irq/dcn10/irq_service_dcn10.c   |     3 +-
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c   |    10 +-
 drivers/gpu/drm/amd/display/dc/os_types.h          |     2 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |     8 +
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |     3 +
 .../drm/amd/display/include/link_service_types.h   |     5 +-
 drivers/gpu/drm/amd/display/include/logger_types.h |    34 +
 drivers/gpu/drm/amd/display/modules/color/Makefile |    31 +
 .../drm/amd/display/modules/color/color_gamma.c    |  1396 +
 .../drm/amd/display/modules/color/color_gamma.h    |    53 +
 .../drm/amd/display/modules/freesync/freesync.c    |   155 +-
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |     9 +
 .../gpu/drm/amd/display/modules/inc/mod_stats.h    |    65 +
 drivers/gpu/drm/amd/display/modules/stats/stats.c  |   334 +
 .../drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h |    14 +
 .../drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h   | 31150 ++++++++++++++++++
 .../drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h  |  7497 +++++
 .../drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h | 31160 +++++++++++++++++++
 .../include/asic_reg/mmhub/mmhub_9_3_0_offset.h    |  1991 ++
 .../include/asic_reg/mmhub/mmhub_9_3_0_sh_mask.h   | 10265 ++++++
 .../amd/include/asic_reg/oss/osssys_4_0_1_offset.h |   337 +
 .../include/asic_reg/oss/osssys_4_0_1_sh_mask.h    |  1249 +
 .../amd/include/asic_reg/sdma0/sdma0_4_1_sh_mask.h |  1658 +
 .../gpu/drm/amd/include/asic_reg/smu/smu_7_1_3_d.h |     1 +
 .../amd/include/asic_reg/smu/smu_7_1_3_sh_mask.h   |     6 +-
 .../amd/include/asic_reg/smuio/smuio_9_0_offset.h  |     3 +
 .../amd/include/asic_reg/smuio/smuio_9_0_sh_mask.h |     3 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |    82 +-
 drivers/gpu/drm/amd/include/cgs_common.h           |   202 +-
 drivers/gpu/drm/amd/include/cgs_linux.h            |   119 -
 drivers/gpu/drm/amd/include/dm_pp_interface.h      |     2 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   103 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |    62 +-
 drivers/gpu/drm/amd/include/soc15_hw_ip.h          |    98 +
 drivers/gpu/drm/amd/include/soc15_ih_clientid.h    |    70 +
 .../amd/include/{soc15ip.h => vega10_ip_offset.h}  |   370 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |   853 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |    10 +-
 .../drm/amd/powerplay/hwmgr/cz_clockpowergating.c  |   209 -
 .../drm/amd/powerplay/hwmgr/cz_clockpowergating.h  |    36 -
 .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |    60 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |   666 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_acpi.c      |   114 -
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       |    53 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |    87 +
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h |    65 +
 .../amd/powerplay/hwmgr/process_pptables_v1_0.c    |     8 +-
 .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  |    14 +-
 .../powerplay/hwmgr/{rv_hwmgr.c => smu10_hwmgr.c}  |   548 +-
 .../powerplay/hwmgr/{rv_hwmgr.h => smu10_hwmgr.h}  |   130 +-
 .../amd/powerplay/hwmgr/{rv_inc.h => smu10_inc.h}  |     4 +-
 .../amd/powerplay/hwmgr/smu7_clockpowergating.c    |    19 +-
 .../amd/powerplay/hwmgr/smu7_clockpowergating.h    |     1 -
 .../drm/amd/powerplay/hwmgr/smu7_dyn_defaults.h    |     2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   918 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h   |    35 +-
 .../gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c   |    17 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c |    10 +-
 .../powerplay/hwmgr/{cz_hwmgr.c => smu8_hwmgr.c}   |  1071 +-
 .../powerplay/hwmgr/{cz_hwmgr.h => smu8_hwmgr.h}   |    82 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c   |   610 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.h   |   189 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |   733 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h |    13 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |    73 +-
 .../amd/powerplay/hwmgr/vega10_processpptables.c   |    21 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   |    42 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h   |     2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |  2090 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |   438 +
 .../{inc/pp_asicblocks.h => hwmgr/vega12_inc.h}    |    32 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega12_powertune.c |  1364 +
 .../gpu/drm/amd/powerplay/hwmgr/vega12_powertune.h |    53 +
 .../gpu/drm/amd/powerplay/hwmgr/vega12_pptable.h   |   109 +
 .../amd/powerplay/hwmgr/vega12_processpptables.c   |   430 +
 .../amd/powerplay/hwmgr/vega12_processpptables.h   |    58 +
 .../gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c   |   324 +
 .../gpu/drm/amd/powerplay/hwmgr/vega12_thermal.h   |    66 +
 drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h  |     2 +-
 .../gpu/drm/amd/powerplay/inc/hardwaremanager.h    |    36 +-
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |   244 +-
 .../gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h    |   412 -
 drivers/gpu/drm/amd/powerplay/inc/power_state.h    |     4 +-
 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h     |    67 -
 drivers/gpu/drm/amd/powerplay/inc/pp_soc15.h       |     6 +-
 .../powerplay/inc/{pp_instance.h => pp_thermal.h}  |    26 +-
 drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h       |     3 +-
 drivers/gpu/drm/amd/powerplay/inc/smu7.h           |    19 +
 drivers/gpu/drm/amd/powerplay/inc/smu7_discrete.h  |     3 +-
 drivers/gpu/drm/amd/powerplay/inc/smu9.h           |     4 +-
 drivers/gpu/drm/amd/powerplay/inc/smumgr.h         |    52 +-
 drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h   |     1 +
 .../drm/amd/powerplay/inc/vega12/smu9_driver_if.h  |   758 +
 drivers/gpu/drm/amd/powerplay/inc/vega12_ppsmc.h   |   123 +
 drivers/gpu/drm/amd/powerplay/smumgr/Makefile      |     5 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |   230 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.h   |     2 -
 drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c   |   871 -
 drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.h   |    98 -
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |   258 +-
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.h |     2 -
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  |    35 +-
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.h  |     1 -
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |   274 +-
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.h    |     1 -
 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c   |   406 -
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |   344 +
 .../smumgr/{rv_smumgr.h => smu10_smumgr.h}         |    26 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |    74 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h |    12 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c |   891 +
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.h |    99 +
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c      |    79 +-
 .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |   199 +-
 .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.h    |     3 -
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |   426 +-
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.h   |    31 +-
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |   561 +
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.h   |    62 +
 drivers/gpu/drm/arc/arcpgu_hdmi.c                  |     3 +-
 drivers/gpu/drm/arc/arcpgu_sim.c                   |    16 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |     6 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |    20 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |    51 +-
 drivers/gpu/drm/arm/malidp_drv.h                   |     2 +-
 drivers/gpu/drm/arm/malidp_hw.c                    |    26 +-
 drivers/gpu/drm/arm/malidp_hw.h                    |    15 +-
 drivers/gpu/drm/arm/malidp_planes.c                |   146 +-
 drivers/gpu/drm/arm/malidp_regs.h                  |    11 +-
 drivers/gpu/drm/armada/armada_crtc.c               |     9 +-
 drivers/gpu/drm/armada/armada_overlay.c            |     9 +-
 drivers/gpu/drm/ast/ast_ttm.c                      |    22 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |    24 +-
 drivers/gpu/drm/bochs/bochs_mm.c                   |    14 +-
 drivers/gpu/drm/bridge/Kconfig                     |     3 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.c          |     3 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |   252 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |    11 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |    38 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |    59 +-
 drivers/gpu/drm/bridge/sii902x.c                   |    20 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |    95 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |   210 +-
 drivers/gpu/drm/cirrus/cirrus_ttm.c                |    22 +-
 drivers/gpu/drm/drm_atomic.c                       |    78 +-
 drivers/gpu/drm/drm_atomic_helper.c                |    14 +-
 drivers/gpu/drm/drm_blend.c                        |    18 +-
 drivers/gpu/drm/drm_bufs.c                         |    16 +-
 drivers/gpu/drm/drm_color_mgmt.c                   |   133 +
 drivers/gpu/drm/drm_connector.c                    |   122 +-
 drivers/gpu/drm/drm_crtc.c                         |    16 +-
 drivers/gpu/drm/drm_crtc_internal.h                |     6 +-
 drivers/gpu/drm/drm_debugfs_crc.c                  |    19 +
 drivers/gpu/drm/drm_dp_helper.c                    |     4 +
 drivers/gpu/drm/drm_dp_mst_topology.c              |    11 +-
 drivers/gpu/drm/drm_drv.c                          |     2 +-
 drivers/gpu/drm/drm_edid.c                         |     9 +-
 drivers/gpu/drm/drm_encoder.c                      |     4 +
 drivers/gpu/drm/drm_fb_helper.c                    |     2 +-
 drivers/gpu/drm/drm_fourcc.c                       |    50 +-
 drivers/gpu/drm/drm_framebuffer.c                  |     5 +-
 drivers/gpu/drm/drm_gem.c                          |     4 +-
 drivers/gpu/drm/drm_ioctl.c                        |     6 +-
 drivers/gpu/drm/drm_lease.c                        |    16 +-
 drivers/gpu/drm/drm_memory.c                       |    13 +
 drivers/gpu/drm/drm_mipi_dsi.c                     |     9 +-
 drivers/gpu/drm/drm_mm.c                           |     9 +-
 drivers/gpu/drm/drm_modes.c                        |   108 +-
 drivers/gpu/drm/drm_modeset_lock.c                 |     1 +
 drivers/gpu/drm/drm_of.c                           |     8 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |     1 +
 drivers/gpu/drm/drm_plane.c                        |    41 +-
 drivers/gpu/drm/drm_plane_helper.c                 |    11 +-
 drivers/gpu/drm/drm_prime.c                        |   193 +-
 drivers/gpu/drm/drm_print.c                        |    65 +-
 drivers/gpu/drm/drm_probe_helper.c                 |     2 +-
 drivers/gpu/drm/drm_property.c                     |   102 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |    48 +-
 drivers/gpu/drm/drm_syncobj.c                      |     2 +-
 drivers/gpu/drm/drm_vblank.c                       |   100 +-
 drivers/gpu/drm/etnaviv/Kconfig                    |     1 +
 drivers/gpu/drm/etnaviv/Makefile                   |     4 +-
 drivers/gpu/drm/etnaviv/common.xml.h               |   281 +-
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c           |    18 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |    52 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              |     8 +-
 drivers/gpu/drm/etnaviv/etnaviv_dump.c             |    21 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.h              |     5 +
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c       |    68 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   406 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              |    54 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c             |    65 +
 drivers/gpu/drm/etnaviv/etnaviv_iommu.c            |     2 +-
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c         |    78 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              |     4 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |   170 +
 drivers/gpu/drm/etnaviv/etnaviv_sched.h            |    35 +
 drivers/gpu/drm/etnaviv/state.xml.h                |   256 +-
 drivers/gpu/drm/etnaviv/state_3d.xml.h             |     5 +
 drivers/gpu/drm/etnaviv/state_blt.xml.h            |    52 +
 drivers/gpu/drm/etnaviv/state_hi.xml.h             |   150 +-
 drivers/gpu/drm/exynos/exynos_dp.c                 |    30 +-
 drivers/gpu/drm/exynos/exynos_mixer.c              |    14 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |    23 +-
 drivers/gpu/drm/i2c/sil164_drv.c                   |     3 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |     3 +-
 drivers/gpu/drm/i915/Makefile                      |     9 +-
 drivers/gpu/drm/i915/dvo_ivch.c                    |    28 +-
 drivers/gpu/drm/i915/gvt/Makefile                  |     2 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |     6 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |  1479 +-
 drivers/gpu/drm/i915/gvt/gtt.h                     |   190 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     |     2 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |    21 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |    47 +-
 drivers/gpu/drm/i915/gvt/hypercall.h               |     9 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |   323 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |     9 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c            |   210 +-
 drivers/gpu/drm/i915/gvt/mmio_context.h            |     5 +
 drivers/gpu/drm/i915/gvt/mpt.h                     |    67 +-
 drivers/gpu/drm/i915/gvt/page_track.c              |   184 +
 drivers/gpu/drm/i915/gvt/page_track.h              |    56 +
 drivers/gpu/drm/i915/gvt/sched_policy.c            |     5 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |    93 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |     2 +-
 drivers/gpu/drm/i915/gvt/trace.h                   |    10 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |     2 +
 drivers/gpu/drm/i915/i915_debugfs.c                |   355 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   320 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   142 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   400 +-
 drivers/gpu/drm/i915/i915_gem.h                    |     7 +-
 drivers/gpu/drm/i915/i915_gem_batch_pool.c         |     2 +-
 drivers/gpu/drm/i915/i915_gem_clflush.c            |     2 +-
 drivers/gpu/drm/i915/i915_gem_context.c            |    67 +-
 drivers/gpu/drm/i915/i915_gem_context.h            |     5 +-
 drivers/gpu/drm/i915/i915_gem_dmabuf.c             |     4 +-
 drivers/gpu/drm/i915/i915_gem_evict.c              |     4 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |    80 +-
 drivers/gpu/drm/i915/i915_gem_fence_reg.c          |    10 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |   152 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h                |     5 +-
 drivers/gpu/drm/i915/i915_gem_internal.c           |     8 +-
 drivers/gpu/drm/i915/i915_gem_object.h             |    17 +-
 drivers/gpu/drm/i915/i915_gem_render_state.c       |     2 +-
 drivers/gpu/drm/i915/i915_gem_render_state.h       |     4 +-
 drivers/gpu/drm/i915/i915_gem_shrinker.c           |     4 +-
 drivers/gpu/drm/i915/i915_gem_stolen.c             |     4 +-
 drivers/gpu/drm/i915/i915_gem_timeline.h           |     4 +-
 drivers/gpu/drm/i915/i915_gem_userptr.c            |    10 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   237 +-
 drivers/gpu/drm/i915/i915_ioc32.c                  |    27 +-
 drivers/gpu/drm/i915/i915_irq.c                    |   425 +-
 drivers/gpu/drm/i915/i915_params.c                 |     5 +-
 drivers/gpu/drm/i915/i915_params.h                 |     2 +-
 drivers/gpu/drm/i915/i915_pci.c                    |   126 +-
 drivers/gpu/drm/i915/i915_perf.c                   |    28 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   328 +-
 drivers/gpu/drm/i915/i915_pmu.h                    |     8 +
 drivers/gpu/drm/i915/i915_query.c                  |   125 +
 drivers/gpu/drm/i915/i915_query.h                  |    15 +
 drivers/gpu/drm/i915/i915_reg.h                    |   378 +-
 .../i915/{i915_gem_request.c => i915_request.c}    |   450 +-
 .../i915/{i915_gem_request.h => i915_request.h}    |   241 +-
 drivers/gpu/drm/i915/i915_sw_fence.c               |    56 +-
 drivers/gpu/drm/i915/i915_syncmap.c                |    16 +-
 drivers/gpu/drm/i915/i915_trace.h                  |   128 +-
 drivers/gpu/drm/i915/i915_vma.c                    |     3 +-
 drivers/gpu/drm/i915/i915_vma.h                    |     2 +-
 drivers/gpu/drm/i915/intel_atomic.c                |     7 +-
 drivers/gpu/drm/i915/intel_atomic_plane.c          |    10 +-
 drivers/gpu/drm/i915/intel_audio.c                 |     2 +-
 drivers/gpu/drm/i915/intel_bios.c                  |    32 +-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |   277 +-
 drivers/gpu/drm/i915/intel_cdclk.c                 |   307 +-
 drivers/gpu/drm/i915/intel_color.c                 |   131 +-
 drivers/gpu/drm/i915/intel_crt.c                   |    20 +-
 drivers/gpu/drm/i915/intel_csr.c                   |     5 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |   326 +-
 drivers/gpu/drm/i915/intel_device_info.c           |   291 +-
 drivers/gpu/drm/i915/intel_device_info.h           |    82 +-
 drivers/gpu/drm/i915/intel_display.c               |   459 +-
 drivers/gpu/drm/i915/intel_display.h               |    16 +
 drivers/gpu/drm/i915/intel_dp.c                    |  1173 +-
 drivers/gpu/drm/i915/intel_dp_link_training.c      |     8 +-
 drivers/gpu/drm/i915/intel_dpio_phy.c              |     2 +-
 drivers/gpu/drm/i915/intel_drv.h                   |   162 +-
 drivers/gpu/drm/i915/intel_dsi.c                   |     5 -
 drivers/gpu/drm/i915/intel_dvo.c                   |    31 +-
 drivers/gpu/drm/i915/intel_engine_cs.c             |   251 +-
 drivers/gpu/drm/i915/intel_fbc.c                   |   146 +-
 drivers/gpu/drm/i915/intel_fbdev.c                 |    13 +-
 drivers/gpu/drm/i915/intel_frontbuffer.c           |     2 +
 drivers/gpu/drm/i915/intel_guc.c                   |    89 +-
 drivers/gpu/drm/i915/intel_guc.h                   |     4 +-
 drivers/gpu/drm/i915/intel_guc_ads.c               |   151 +
 drivers/gpu/drm/i915/intel_guc_ads.h               |    33 +
 drivers/gpu/drm/i915/intel_guc_fw.c                |    10 +-
 drivers/gpu/drm/i915/intel_guc_log.c               |   299 +-
 drivers/gpu/drm/i915/intel_guc_log.h               |    14 +-
 drivers/gpu/drm/i915/intel_guc_submission.c        |   331 +-
 drivers/gpu/drm/i915/intel_hangcheck.c             |     2 +-
 drivers/gpu/drm/i915/intel_hdcp.c                  |   807 +
 drivers/gpu/drm/i915/intel_hdmi.c                  |   297 +-
 drivers/gpu/drm/i915/intel_hotplug.c               |    44 +-
 drivers/gpu/drm/i915/intel_huc.c                   |   181 +-
 drivers/gpu/drm/i915/intel_huc.h                   |     2 +-
 drivers/gpu/drm/i915/intel_huc_fw.c                |   166 +
 drivers/gpu/drm/i915/intel_huc_fw.h                |    15 +
 drivers/gpu/drm/i915/intel_i2c.c                   |    98 +-
 drivers/gpu/drm/i915/intel_lpe_audio.c             |    14 +-
 drivers/gpu/drm/i915/intel_lrc.c                   |   726 +-
 drivers/gpu/drm/i915/intel_lrc.h                   |     4 +
 drivers/gpu/drm/i915/intel_lrc_reg.h               |    68 +
 drivers/gpu/drm/i915/intel_lspcon.c                |     3 +-
 drivers/gpu/drm/i915/intel_lvds.c                  |    44 +-
 drivers/gpu/drm/i915/intel_mocs.c                  |    30 +-
 drivers/gpu/drm/i915/intel_mocs.h                  |     2 +-
 drivers/gpu/drm/i915/intel_modes.c                 |    17 -
 drivers/gpu/drm/i915/intel_overlay.c               |    85 +-
 drivers/gpu/drm/i915/intel_panel.c                 |    20 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   212 +-
 drivers/gpu/drm/i915/intel_psr.c                   |   229 +-
 drivers/gpu/drm/i915/intel_ringbuffer.c            |   226 +-
 drivers/gpu/drm/i915/intel_ringbuffer.h            |   125 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |   210 +-
 drivers/gpu/drm/i915/intel_sdvo.c                  |    97 +-
 drivers/gpu/drm/i915/intel_sprite.c                |   261 +-
 drivers/gpu/drm/i915/intel_tv.c                    |    28 +-
 drivers/gpu/drm/i915/intel_uc.c                    |   139 +-
 drivers/gpu/drm/i915/intel_uc.h                    |     6 +-
 drivers/gpu/drm/i915/intel_uc_fw.c                 |     5 +-
 drivers/gpu/drm/i915/intel_uncore.c                |   208 +-
 drivers/gpu/drm/i915/intel_uncore.h                |    42 +-
 drivers/gpu/drm/i915/intel_vbt_defs.h              |    13 +-
 drivers/gpu/drm/i915/selftests/huge_gem_object.c   |     4 +-
 drivers/gpu/drm/i915/selftests/huge_pages.c        |    14 +-
 .../gpu/drm/i915/selftests/i915_gem_coherency.c    |     8 +-
 drivers/gpu/drm/i915/selftests/i915_gem_context.c  |    12 +-
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |     6 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   118 +-
 drivers/gpu/drm/i915/selftests/i915_gem_object.c   |    24 +-
 .../gpu/drm/i915/selftests/i915_live_selftests.h   |     2 +-
 .../gpu/drm/i915/selftests/i915_mock_selftests.h   |     2 +-
 drivers/gpu/drm/i915/selftests/i915_random.c       |     3 +-
 .../{i915_gem_request.c => i915_request.c}         |   125 +-
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c     |   134 +
 drivers/gpu/drm/i915/selftests/intel_guc.c         |    20 +-
 drivers/gpu/drm/i915/selftests/intel_hangcheck.c   |   222 +-
 drivers/gpu/drm/i915/selftests/intel_uncore.c      |    31 +-
 drivers/gpu/drm/i915/selftests/mock_context.c      |    11 +
 drivers/gpu/drm/i915/selftests/mock_context.h      |     3 +
 drivers/gpu/drm/i915/selftests/mock_engine.c       |    10 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |     8 +-
 drivers/gpu/drm/i915/selftests/mock_request.c      |    10 +-
 drivers/gpu/drm/i915/selftests/mock_request.h      |     8 +-
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  |    13 +-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |     7 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           |     6 +-
 drivers/gpu/drm/meson/meson_drv.c                  |    37 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |    44 +-
 drivers/gpu/drm/meson/meson_plane.c                |     6 +-
 drivers/gpu/drm/meson/meson_vclk.c                 |   219 +-
 drivers/gpu/drm/meson/meson_venc.c                 |   347 +-
 drivers/gpu/drm/meson/meson_venc.h                 |     1 +
 drivers/gpu/drm/mgag200/mgag200_mode.c             |     4 +-
 drivers/gpu/drm/mgag200/mgag200_ttm.c              |    22 +-
 drivers/gpu/drm/msm/Kconfig                        |    20 +
 drivers/gpu/drm/msm/Makefile                       |    50 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |     9 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |     9 +-
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c          |   187 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |    99 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |     4 +
 drivers/gpu/drm/msm/adreno/a5xx_power.c            |    26 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |    52 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    70 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |    14 +-
 drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4.xml.h  |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_crtc.c |     6 +-
 .../drm/msm/{mdp => disp}/mdp4/mdp4_dsi_encoder.c  |     0
 .../drm/msm/{mdp => disp}/mdp4/mdp4_dtv_encoder.c  |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_irq.c  |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_kms.c  |     2 +-
 drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_kms.h  |     2 +-
 .../drm/msm/{mdp => disp}/mdp4/mdp4_lcdc_encoder.c |     0
 .../msm/{mdp => disp}/mdp4/mdp4_lvds_connector.c   |     0
 .../gpu/drm/msm/{mdp => disp}/mdp4/mdp4_lvds_pll.c |     0
 .../gpu/drm/msm/{mdp => disp}/mdp4/mdp4_plane.c    |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5.xml.h  |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_cfg.c  |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_cfg.h  |     0
 .../drm/msm/{mdp => disp}/mdp5/mdp5_cmd_encoder.c  |     4 +-
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_crtc.c |    13 +-
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_ctl.c  |    60 +-
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_ctl.h  |     2 +-
 .../gpu/drm/msm/{mdp => disp}/mdp5/mdp5_encoder.c  |     5 +-
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_irq.c  |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_kms.c  |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_kms.h  |    10 +-
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_mdss.c |     0
 .../gpu/drm/msm/{mdp => disp}/mdp5/mdp5_mixer.c    |     0
 .../gpu/drm/msm/{mdp => disp}/mdp5/mdp5_mixer.h    |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_pipe.c |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_pipe.h |     0
 .../gpu/drm/msm/{mdp => disp}/mdp5/mdp5_plane.c    |    16 +-
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_smp.c  |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_smp.h  |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp_common.xml.h |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp_format.c     |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp_kms.c        |     0
 drivers/gpu/drm/msm/{mdp => disp}/mdp_kms.h        |     0
 drivers/gpu/drm/msm/dsi/dsi.c                      |    25 +-
 drivers/gpu/drm/msm/dsi/dsi.h                      |     1 +
 drivers/gpu/drm/msm/dsi/dsi.xml.h                  |   187 +-
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |    19 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |     1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |    47 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |     6 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |    10 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |     1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c         |   251 +
 drivers/gpu/drm/msm/dsi/pll/dsi_pll.c              |     5 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll.h              |     9 +
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c         |   822 +
 drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c               |     2 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |     5 +-
 drivers/gpu/drm/msm/msm_drv.c                      |     8 +-
 drivers/gpu/drm/msm/msm_drv.h                      |     1 -
 drivers/gpu/drm/msm/msm_fb.c                       |     6 +-
 drivers/gpu/drm/msm/msm_fence.h                    |     2 -
 drivers/gpu/drm/msm/msm_gem.c                      |    13 +-
 drivers/gpu/drm/msm/msm_gem.h                      |     1 +
 drivers/gpu/drm/msm/msm_gem_submit.c               |     9 +
 drivers/gpu/drm/msm/msm_gem_vma.c                  |     4 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |    12 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |     2 +
 drivers/gpu/drm/msm/msm_ringbuffer.c               |     2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |    54 +-
 drivers/gpu/drm/nouveau/dispnv04/overlay.c         |    26 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    12 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |    46 -
 drivers/gpu/drm/nouveau/nouveau_drv.h              |     1 -
 drivers/gpu/drm/nouveau/nouveau_sgdma.c            |     8 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.h              |     5 +-
 drivers/gpu/drm/nouveau/nv50_display.c             |     8 -
 .../gpu/drm/omapdrm/displays/connector-analog-tv.c |    50 +-
 drivers/gpu/drm/omapdrm/displays/connector-dvi.c   |   146 +-
 drivers/gpu/drm/omapdrm/displays/connector-hdmi.c  |    40 +-
 drivers/gpu/drm/omapdrm/displays/encoder-opa362.c  |    40 +-
 drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c  |    39 +-
 .../gpu/drm/omapdrm/displays/encoder-tpd12s015.c   |    69 +-
 drivers/gpu/drm/omapdrm/displays/panel-dpi.c       |    71 +-
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    |    44 +-
 .../omapdrm/displays/panel-lgphilips-lb035q02.c    |    38 +-
 .../drm/omapdrm/displays/panel-nec-nl8048hl11.c    |    42 +-
 .../drm/omapdrm/displays/panel-sharp-ls037v7dw01.c |    38 +-
 .../drm/omapdrm/displays/panel-sony-acx565akm.c    |    41 +-
 .../drm/omapdrm/displays/panel-tpo-td028ttec1.c    |    49 +-
 .../drm/omapdrm/displays/panel-tpo-td043mtea1.c    |    32 +-
 drivers/gpu/drm/omapdrm/dss/base.c                 |    27 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |  2346 +-
 drivers/gpu/drm/omapdrm/dss/display.c              |     5 +-
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |    91 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |  1553 +-
 drivers/gpu/drm/omapdrm/dss/dss-of.c               |     2 -
 drivers/gpu/drm/omapdrm/dss/dss.c                  |   823 +-
 drivers/gpu/drm/omapdrm/dss/dss.h                  |   245 +-
 drivers/gpu/drm/omapdrm/dss/hdmi.h                 |    11 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   406 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c            |     4 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.h           |     4 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   418 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c           |    24 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_phy.c             |     2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_pll.c             |    15 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_wp.c              |     2 +-
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |   213 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |    53 +-
 drivers/gpu/drm/omapdrm/dss/pll.c                  |    44 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |   162 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |   453 +-
 drivers/gpu/drm/omapdrm/dss/video-pll.c            |    19 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |    74 +-
 drivers/gpu/drm/omapdrm/omap_crtc.h                |     4 +-
 drivers/gpu/drm/omapdrm/omap_dmm_priv.h            |    10 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |    46 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.h           |    22 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   122 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |     8 +-
 drivers/gpu/drm/omapdrm/omap_fb.c                  |    18 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |    38 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.h               |     9 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |    41 +-
 drivers/gpu/drm/omapdrm/omap_gem.h                 |    16 +-
 drivers/gpu/drm/omapdrm/omap_irq.c                 |    38 +-
 drivers/gpu/drm/omapdrm/omap_irq.h                 |     2 +-
 drivers/gpu/drm/omapdrm/omap_plane.c               |    16 +-
 drivers/gpu/drm/omapdrm/tcm-sita.c                 |    12 +-
 drivers/gpu/drm/omapdrm/tcm.h                      |     4 +-
 drivers/gpu/drm/panel/Kconfig                      |    19 +
 drivers/gpu/drm/panel/Makefile                     |     2 +
 drivers/gpu/drm/panel/panel-arm-versatile.c        |   377 +
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |     4 +-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |    30 +-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |     6 +-
 drivers/gpu/drm/panel/panel-lvds.c                 |     2 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |    21 +-
 .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   |    16 +-
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      |   448 +
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c    |    38 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |    37 +-
 drivers/gpu/drm/panel/panel-simple.c               |    82 +-
 drivers/gpu/drm/pl111/pl111_display.c              |   115 +-
 drivers/gpu/drm/pl111/pl111_drm.h                  |    13 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |   143 +-
 drivers/gpu/drm/pl111/pl111_versatile.c            |   118 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |     4 +-
 drivers/gpu/drm/qxl/qxl_dumb.c                     |     2 +-
 drivers/gpu/drm/qxl/qxl_fb.c                       |     6 +-
 drivers/gpu/drm/qxl/qxl_gem.c                      |     2 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |     4 +-
 drivers/gpu/drm/qxl/qxl_object.c                   |     8 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |     2 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |    32 +-
 drivers/gpu/drm/radeon/mkregtable.c                |   433 -
 drivers/gpu/drm/radeon/radeon.h                    |     1 +
 drivers/gpu/drm/radeon/radeon_device.c             |     2 +
 drivers/gpu/drm/radeon/radeon_display.c            |     2 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |     4 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |     2 -
 drivers/gpu/drm/radeon/radeon_object.c             |    13 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |    22 +-
 drivers/gpu/drm/rcar-du/Kconfig                    |     9 +-
 drivers/gpu/drm/rcar-du/Makefile                   |    10 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |    51 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |    42 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |     5 -
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |   175 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |    12 -
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |    14 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c          |    93 -
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h          |    24 -
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c          |   272 -
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h          |    64 -
 drivers/gpu/drm/rcar-du/rcar_du_of.c               |   322 +
 drivers/gpu/drm/rcar-du/rcar_du_of.h               |    20 +
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dts    |    76 +
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dts    |    50 +
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dts    |    50 +
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dts    |    50 +
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dts    |    50 +
 drivers/gpu/drm/rcar-du/rcar_du_plane.c            |     8 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h              |     2 -
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c             |    14 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |   540 +
 drivers/gpu/drm/rcar-du/rcar_lvds_regs.h           |     6 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   103 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |     7 -
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             |    11 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |    30 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               |    25 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |    26 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |     2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   125 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h        |     5 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c        |    92 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h        |     4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   109 +-
 drivers/gpu/drm/stm/drv.c                          |    18 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |    53 +-
 drivers/gpu/drm/stm/ltdc.c                         |   118 +-
 drivers/gpu/drm/stm/ltdc.h                         |     1 +
 drivers/gpu/drm/sun4i/Kconfig                      |    11 +-
 drivers/gpu/drm/sun4i/Makefile                     |     8 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   442 +-
 drivers/gpu/drm/sun4i/sun4i_backend.h              |    36 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |    21 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |    38 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h                  |     1 +
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |    24 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c             |   389 +
 drivers/gpu/drm/sun4i/sun4i_frontend.h             |    99 +
 drivers/gpu/drm/sun4i/sun4i_layer.c                |   162 +-
 drivers/gpu/drm/sun4i/sun4i_layer.h                |    12 +
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |    55 +
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |     8 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   105 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |     2 +
 drivers/gpu/drm/sun4i/sun6i_drc.c                  |     1 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |   196 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |   193 +
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |   543 +
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c         |   132 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |    23 +
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |     8 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |     8 +-
 drivers/gpu/drm/sun4i/sunxi_engine.h               |    90 +
 drivers/gpu/drm/tegra/dc.c                         |    84 +-
 drivers/gpu/drm/tegra/dc.h                         |     1 +
 drivers/gpu/drm/tegra/drm.c                        |    36 +-
 drivers/gpu/drm/tegra/drm.h                        |    14 -
 drivers/gpu/drm/tegra/fb.c                         |    25 +-
 drivers/gpu/drm/tegra/gem.c                        |    69 +-
 drivers/gpu/drm/tegra/gem.h                        |     5 +-
 drivers/gpu/drm/tegra/hub.c                        |   125 +-
 drivers/gpu/drm/tegra/hub.h                        |    17 +
 drivers/gpu/drm/tegra/plane.c                      |    28 +-
 drivers/gpu/drm/tilcdc/Kconfig                     |     2 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |     4 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |     4 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |    29 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              |    23 +-
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c             |     8 +-
 drivers/gpu/drm/tinydrm/Kconfig                    |     4 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c     |    95 -
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c        |    34 +-
 drivers/gpu/drm/tinydrm/ili9225.c                  |     6 +-
 drivers/gpu/drm/tinydrm/mi0283qt.c                 |   109 +-
 drivers/gpu/drm/tinydrm/mipi-dbi.c                 |   105 +-
 drivers/gpu/drm/tinydrm/st7586.c                   |    15 +-
 drivers/gpu/drm/tinydrm/st7735r.c                  |    14 +-
 drivers/gpu/drm/ttm/ttm_agp_backend.c              |    10 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   121 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   126 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    35 +-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c             |    20 +-
 drivers/gpu/drm/ttm/ttm_memory.c                   |    93 +
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |    52 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |    46 +-
 drivers/gpu/drm/ttm/ttm_tt.c                       |   180 +-
 drivers/gpu/drm/tve200/tve200_display.c            |    10 +-
 drivers/gpu/drm/tve200/tve200_drm.h                |     2 -
 drivers/gpu/drm/tve200/tve200_drv.c                |     3 -
 drivers/gpu/drm/vc4/Makefile                       |     1 +
 drivers/gpu/drm/vc4/vc4_crtc.c                     |    25 +
 drivers/gpu/drm/vc4/vc4_drv.c                      |    26 +
 drivers/gpu/drm/vc4/vc4_drv.h                      |   128 +
 drivers/gpu/drm/vc4/vc4_gem.c                      |    48 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |     2 +-
 drivers/gpu/drm/vc4/vc4_irq.c                      |    40 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |     1 +
 drivers/gpu/drm/vc4/vc4_perfmon.c                  |   188 +
 drivers/gpu/drm/vc4/vc4_plane.c                    |   125 +-
 drivers/gpu/drm/vc4/vc4_regs.h                     |    36 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                      |    64 +-
 drivers/gpu/drm/vc4/vc4_validate.c                 |     2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |     7 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |     2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |     8 +-
 drivers/gpu/drm/virtio/virtgpu_fb.c                |     6 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c               |     1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |    25 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |     2 +-
 drivers/gpu/drm/virtio/virtgpu_prime.c             |     4 +-
 drivers/gpu/drm/virtio/virtgpu_ttm.c               |    31 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |    13 +-
 drivers/gpu/drm/vmwgfx/Makefile                    |     2 +-
 drivers/gpu/drm/vmwgfx/device_include/svga_reg.h   |    12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |   506 +
 drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c             |    37 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |    59 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_dmabuf.c             |    51 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |    80 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |    64 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |   106 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |     9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c              |     4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   184 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |    21 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |     5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |    13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |    27 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   163 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   280 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |     8 +-
 drivers/gpu/drm/zte/zx_plane.c                     |    15 +-
 drivers/gpu/vga/vga_switcheroo.c                   |   152 +-
 drivers/of/Kconfig                                 |     1 +
 drivers/of/overlay.c                               |   134 +-
 drivers/of/resolver.c                              |     6 -
 drivers/of/unittest-data/Makefile                  |    28 +-
 drivers/of/unittest-data/overlay.dts               |   101 +-
 drivers/of/unittest-data/overlay_0.dts             |    14 +
 drivers/of/unittest-data/overlay_1.dts             |    14 +
 drivers/of/unittest-data/overlay_10.dts            |    27 +
 drivers/of/unittest-data/overlay_11.dts            |    28 +
 drivers/of/unittest-data/overlay_12.dts            |    14 +
 drivers/of/unittest-data/overlay_13.dts            |    14 +
 drivers/of/unittest-data/overlay_15.dts            |    30 +
 drivers/of/unittest-data/overlay_2.dts             |     9 +
 drivers/of/unittest-data/overlay_3.dts             |     9 +
 drivers/of/unittest-data/overlay_4.dts             |    18 +
 drivers/of/unittest-data/overlay_5.dts             |     9 +
 drivers/of/unittest-data/overlay_6.dts             |    10 +
 drivers/of/unittest-data/overlay_7.dts             |    10 +
 drivers/of/unittest-data/overlay_8.dts             |    10 +
 drivers/of/unittest-data/overlay_9.dts             |    10 +
 drivers/of/unittest-data/overlay_bad_phandle.dts   |    23 +-
 drivers/of/unittest-data/overlay_bad_symbol.dts    |    25 +-
 drivers/of/unittest-data/tests-overlay.dtsi        |   217 +-
 drivers/of/unittest.c                              |   300 +-
 drivers/pci/pci-driver.c                           |    17 +-
 drivers/pci/pci.c                                  |     8 +-
 drivers/pci/quirks.c                               |    39 +
 drivers/staging/vboxvideo/vbox_ttm.c               |    23 +-
 drivers/video/backlight/backlight.c                |    73 +
 include/drm/amd_asic_type.h                        |     1 +
 include/drm/bridge/analogix_dp.h                   |    20 +-
 include/drm/bridge/dw_hdmi.h                       |    24 +-
 include/drm/bridge/dw_mipi_dsi.h                   |    17 +-
 include/drm/drm_atomic.h                           |    24 +-
 include/drm/drm_atomic_helper.h                    |     1 -
 include/drm/drm_bridge.h                           |    35 +-
 include/drm/drm_cache.h                            |     2 +
 include/drm/drm_color_mgmt.h                       |    31 +
 include/drm/drm_connector.h                        |    22 +-
 include/drm/drm_dp_helper.h                        |    66 +
 include/drm/drm_fourcc.h                           |     2 +
 include/drm/drm_gem.h                              |    15 -
 include/drm/drm_hdcp.h                             |    41 +
 include/drm/drm_mode_config.h                      |    12 +
 include/drm/drm_mode_object.h                      |    24 -
 include/drm/drm_modes.h                            |    24 +-
 include/drm/drm_plane.h                            |    32 +
 include/drm/drm_plane_helper.h                     |     1 -
 include/drm/drm_prime.h                            |    22 +
 include/drm/drm_print.h                            |   119 +-
 include/drm/drm_property.h                         |    26 +-
 include/drm/drm_simple_kms_helper.h                |    53 +
 include/drm/drm_vblank.h                           |    20 +-
 include/drm/i915_component.h                       |     3 +-
 include/drm/i915_pciids.h                          |    39 +-
 include/drm/tinydrm/ili9341.h                      |    54 -
 include/drm/tinydrm/mipi-dbi.h                     |     5 +-
 include/drm/tinydrm/tinydrm-helpers.h              |     4 -
 include/drm/ttm/ttm_bo_api.h                       |    32 +-
 include/drm/ttm/ttm_bo_driver.h                    |   250 +-
 include/drm/ttm/ttm_memory.h                       |     5 +
 include/drm/ttm/ttm_tt.h                           |   272 +
 include/linux/backlight.h                          |    58 +
 include/linux/of.h                                 |     6 +-
 include/linux/pci.h                                |     2 +
 include/linux/pci_ids.h                            |     1 +
 include/linux/vga_switcheroo.h                     |     6 -
 include/sound/hdaudio.h                            |     3 -
 include/uapi/drm/amdgpu_drm.h                      |     7 +
 include/uapi/drm/drm_mode.h                        |    43 +-
 include/uapi/drm/etnaviv_drm.h                     |     6 +
 include/uapi/drm/i915_drm.h                        |   112 +-
 include/uapi/drm/msm_drm.h                         |     2 +
 include/uapi/drm/vc4_drm.h                         |    76 +
 include/uapi/linux/kfd_ioctl.h                     |   130 +-
 scripts/coccinelle/api/drm-get-put.cocci           |    10 -
 sound/pci/hda/hda_intel.c                          |    35 +-
 sound/pci/hda/hda_intel.h                          |     3 -
 1062 files changed, 144461 insertions(+), 38059 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
 rename Documentation/devicetree/bindings/display/bridge/{ti,ths8135.txt
=> ti,ths813x.txt} (69%)
 create mode 100644
Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/auo,g104sn02.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
 create mode 100644
Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
 create mode 100644 Documentation/gpu/drivers.rst
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c
 rename drivers/gpu/drm/amd/{powerplay/inc/pp_acpi.h => amdgpu/emu_soc.c} (81%)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dce80/dce80_compressor.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dce80/dce80_compressor.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.h
 rename drivers/gpu/drm/amd/{amdgpu/amdgpu_powerplay.h =>
display/dc/dml/dml_logger.h} (80%)
 create mode 100644 drivers/gpu/drm/amd/display/modules/color/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/modules/color/color_gamma.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/color/color_gamma.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/stats/stats.c
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_3_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_3_0_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_1_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_1_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_1_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/include/cgs_linux.h
 create mode 100644 drivers/gpu/drm/amd/include/soc15_hw_ip.h
 create mode 100644 drivers/gpu/drm/amd/include/soc15_ih_clientid.h
 rename drivers/gpu/drm/amd/include/{soc15ip.h => vega10_ip_offset.h} (85%)
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pp_acpi.c
 rename drivers/gpu/drm/amd/powerplay/hwmgr/{rv_hwmgr.c => smu10_hwmgr.c} (55%)
 rename drivers/gpu/drm/amd/powerplay/hwmgr/{rv_hwmgr.h => smu10_hwmgr.h} (67%)
 rename drivers/gpu/drm/amd/powerplay/hwmgr/{rv_inc.h => smu10_inc.h} (97%)
 rename drivers/gpu/drm/amd/powerplay/hwmgr/{cz_hwmgr.c => smu8_hwmgr.c} (58%)
 rename drivers/gpu/drm/amd/powerplay/hwmgr/{cz_hwmgr.h => smu8_hwmgr.h} (79%)
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
 rename drivers/gpu/drm/amd/powerplay/{inc/pp_asicblocks.h =>
hwmgr/vega12_inc.h} (71%)
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_powertune.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_powertune.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_pptable.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_processpptables.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_processpptables.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h
 rename drivers/gpu/drm/amd/powerplay/inc/{pp_instance.h => pp_thermal.h} (76%)
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/vega12/smu9_driver_if.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/vega12_ppsmc.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
 delete mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
 rename drivers/gpu/drm/amd/powerplay/smumgr/{rv_smumgr.h =>
smu10_smumgr.h} (72%)
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.h
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_sched.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_sched.h
 create mode 100644 drivers/gpu/drm/etnaviv/state_blt.xml.h
 create mode 100644 drivers/gpu/drm/i915/gvt/page_track.c
 create mode 100644 drivers/gpu/drm/i915/gvt/page_track.h
 create mode 100644 drivers/gpu/drm/i915/i915_query.c
 create mode 100644 drivers/gpu/drm/i915/i915_query.h
 rename drivers/gpu/drm/i915/{i915_gem_request.c => i915_request.c} (73%)
 rename drivers/gpu/drm/i915/{i915_gem_request.h => i915_request.h} (80%)
 create mode 100644 drivers/gpu/drm/i915/intel_guc_ads.c
 create mode 100644 drivers/gpu/drm/i915/intel_guc_ads.h
 create mode 100644 drivers/gpu/drm/i915/intel_hdcp.c
 create mode 100644 drivers/gpu/drm/i915/intel_huc_fw.c
 create mode 100644 drivers/gpu/drm/i915/intel_huc_fw.h
 create mode 100644 drivers/gpu/drm/i915/intel_lrc_reg.h
 rename drivers/gpu/drm/i915/selftests/{i915_gem_request.c =>
i915_request.c} (87%)
 create mode 100644 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4.xml.h (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_crtc.c (99%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_dsi_encoder.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_dtv_encoder.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_irq.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_kms.c (99%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_kms.h (99%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_lcdc_encoder.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_lvds_connector.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_lvds_pll.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp4/mdp4_plane.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5.xml.h (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_cfg.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_cfg.h (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_cmd_encoder.c (99%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_crtc.c (99%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_ctl.c (94%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_ctl.h (98%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_encoder.c (99%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_irq.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_kms.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_kms.h (96%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_mdss.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_mixer.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_mixer.h (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_pipe.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_pipe.h (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_plane.c (98%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_smp.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp5/mdp5_smp.h (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp_common.xml.h (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp_format.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp_kms.c (100%)
 rename drivers/gpu/drm/msm/{mdp => disp}/mdp_kms.h (100%)
 create mode 100644 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
 create mode 100644 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
 create mode 100644 drivers/gpu/drm/panel/panel-arm-versatile.c
 create mode 100644 drivers/gpu/drm/panel/panel-raydium-rm68200.c
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dts
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dts
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dts
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dts
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dts
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_lvds.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_frontend.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_frontend.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_perfmon.c
 create mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
 create mode 100644 drivers/of/unittest-data/overlay_0.dts
 create mode 100644 drivers/of/unittest-data/overlay_1.dts
 create mode 100644 drivers/of/unittest-data/overlay_10.dts
 create mode 100644 drivers/of/unittest-data/overlay_11.dts
 create mode 100644 drivers/of/unittest-data/overlay_12.dts
 create mode 100644 drivers/of/unittest-data/overlay_13.dts
 create mode 100644 drivers/of/unittest-data/overlay_15.dts
 create mode 100644 drivers/of/unittest-data/overlay_2.dts
 create mode 100644 drivers/of/unittest-data/overlay_3.dts
 create mode 100644 drivers/of/unittest-data/overlay_4.dts
 create mode 100644 drivers/of/unittest-data/overlay_5.dts
 create mode 100644 drivers/of/unittest-data/overlay_6.dts
 create mode 100644 drivers/of/unittest-data/overlay_7.dts
 create mode 100644 drivers/of/unittest-data/overlay_8.dts
 create mode 100644 drivers/of/unittest-data/overlay_9.dts
 create mode 100644 include/drm/drm_hdcp.h
 delete mode 100644 include/drm/tinydrm/ili9341.h
 create mode 100644 include/drm/ttm/ttm_tt.h

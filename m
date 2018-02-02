Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBBAka (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 19:40:30 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:46002 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeBBAkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 19:40:13 -0500
X-Google-Smtp-Source: AH8x226y5iuWYo1G8hE9Kg3d+9yUl0vNRnYnxziwOrrbfU9i2Wvk3uZjps7d+NAtI7/wWcoS3ub5/nB6NbrxNLZMbcg=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 2 Feb 2018 10:40:09 +1000
Message-ID: <CAPM=9tzdZucx_zkMESOfTV5tp9tP+g_tVkCmcQ7R9vYLaXq3Gw@mail.gmail.com>
Subject: [git pull] drm pull for v4.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w120ecMT021563

Hi Linus,

This seems to have been a comparatively quieter merge window, I assume
due to holidays etc. The "biggest" change is AMD header cleanups, which
merge/remove a bunch of them. The AMD gpu scheduler is now being made generic
with the etnaviv driver wanting to reuse the code, hopefully other drivers
can go in the same direction.

Otherwise it's the usual lots of stuff in i915/amdgpu, not so much stuff
elsewhere.

I did a test merge with your tree, i915_display.c has a bunch of trivials,
but just pick the versions from my tree and it should be fine, the only
mildly tricky bit was the asserts which got removed in -next.

Core:
Add .last_close and .output_poll_changed helpers to reduce driver footprints
Fix plane clipping
Improved debug printing support
Add panel orientation property
Update edid derived properties at edid setting
Reduction in fbdev driver footprint
Move amdgpu scheduler into core for other drivers to use.

i915:
Selftest and IGT improvements
Fast boot prep work on IPS, pipe config
HW workarounds for Cannonlake, Geminilake
Cannonlake clock and HDMI2.0 fixes
GPU cache invalidation and context switch improvements
Display planes cleanup
New PMU interface for perf queries
New firmware support for KBL/SKL
Geminilake HW workaround for perforamce
Coffeelake stolem memory improvements
GPU reset robustness work
Cannonlake horizontal plane flipping
GVT work

amdgpu/radeon:
RV and Vega header file cleanups (lots of lines gone!)
TTM operation context support
48-bit GPUVM support for Vega/RV
ECC support for Vega
Resizeable BAR support
Multi-display sync support
Enable swapout for reserved BOs during allocation
S3 fixes on Raven
GPU reset cleanup and fixes
2+1 level GPU page table

amdkfd:
GFX7/8 SDMA user queues support
Hardware scheduling for multiple processes
dGPU prep work

rcar:
Added R8A7743/5 support
System suspend/resume support

sun4i:
Multi-plane support for YUV formats
A83T and LVDS support

msm:
Devfreq support for GPU

tegra:
Prep work for adding Tegra186 support
Tegra186 HDMI support
HDMI2.0 and zpos support by using generic helpers

tilcdc:
Misc fixes

omapdrm:
Support memory bandwidth limits
DSI command mode panel cleanups
DMM error handling

exynos:
drop the old IPP subdriver.

etnaviv:
Occlusion query fixes
Job handling fixes
Prep work for hooking in gpu scheduler

armada:
Move closer to atomic modesetting
Allow disabling primary plane if overlay is full screen

imx:
Format modifier support
Add tile prefetch to PRE
Runtime PM support for PRG

ast:
fix LUT loading

Regards,
Dave.

The following changes since commit a8750ddca918032d6349adbf9a4b6555e7db20da:

  Linux 4.15-rc8 (2018-01-14 15:32:30 -0800)

are available in the git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-for-v4.16

for you to fetch changes up to 24b8ef699e8221d2b7f813adaab13eec053e1507:

  drm/ast: Load lut in crtc_commit (2018-02-01 11:35:46 +1000)

----------------------------------------------------------------
drm/graphics pull request for v4.16-rc1

----------------------------------------------------------------
Aastha Gupta (1):
      drm: virtio: replace reference/unreference with get/put

Alex Deucher (41):
      drm/amd/display: add mod_freesync_user_enable to dm_connector_state
      drm/amdgpu/gfx8: use cached values for raster config in clear state
      drm/amdgpu/gfx7: use cached values for raster config in clear state
      drm/amdgpu/gfx6: use cached values for raster config in clear state
      drm/amdgpu/gmc9: make some ECC messages debug only
      drm/amdgpu: add license to Makefiles
      drm/amdgpu: add license to files where it was missing
      drm/scheduler: add license to the Makefile
      drm/amdgpu: make function names consistent in nbio files
      drm/amdgpu: convert nbio to use callbacks (v2)
      drm/amdgpu: drop the bios scratch reg callbacks from nbio
      drm/amdgpu: drop soc15_init_golden_registers
      drm/amdgpu: remove some old gc 9.x registers
      drm/amdgpu: drop scratch regs save and restore from S3/S4 handling
      drm/amdgpu: drop scratch regs save and restore from GPU reset handling
      drm/amdgpu: drop amdgpu_atombios_scratch_regs_save/restore
      drm/amdgpu: setup the shared and private apertures on gfx9
      drm/amdgpu: move atom functions from amdgpu_device.c
      drm/amdgpu: use consistent naming for static funcs in amdgpu_device.c
      drm/amdgpu: rename amdgpu_suspend to amdgpu_device_ip_suspend
      drm/amdgpu: move debugfs functions to their own file
      drm/amdgpu: rename amdgpu_wb_* functions
      drm/amdgpu: rename amdgpu_program_register_sequence
      drm/amdgpu: rename amdgpu_pci_config_reset
      drm/amdgpu: move amdgpu_doorbell_get_kfd_info to amdgpu_amdkfd.c
      drm/amdgpu: rename amdgpu_*_location functions
      drm/amdgpu: move fw_reserve functions to amdgpu_ttm.c
      drm/amdgpu: rename ip block helper functions
      drm/amdgpu: rename amdgpu_need_post
      drm/amdgpu: move dummy page functions to amdgpu_gart.c
      drm/amdgpu: rename amdgpu_gpu_recover
      drm/amdgpu: move amdgpu_need_backup to amdgpu_object.c
      drm/amdgpu: rename amdgpu_get_pcie_info
      drm/amdgpu: only check mmBIF_IOV_FUNC_IDENTIFIER on tonga/fiji
      drm/amdgpu: use defines for mmBIF_IOV_FUNC_IDENTIFIER fields
      drm/radeon: Add dpm quirk for Jet PRO (v2)
      drm/amdgpu: Add dpm quirk for Jet PRO (v2)
      drm/amdgpu: add atpx quirk handling (v2)
      drm/amdgpu/gfx9: only init the apertures used by KGD (v2)
      drm/amdgpu: only check for ECC on Vega10
      drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)

Amber Lin (1):
      drm/amdkfd: Add perf counters to topology

Andrew F. Davis (2):
      drm: omapdrm: Remove filename from header and fix copyright tag
      drm: omapdrm: Simplify platform registration

Andrew Jiang (14):
      drm/amd/display: Reject PPLib clock values if they are invalid
      drm/amd/display: Don't use dc_link in link_encoder
      drm/amd/display: Report pitch_alignment for DCN
      drm/amd/display: Loosen plane_info and scaling_info checks
      drm/amd/display: Remove legacy unused workaround
      drm/amd/display: Add update flags in to determine surface update type
      drm/amd/display: Rename pitch_alignment to linear_pitch_alignment
      drm/amd/display: Add check update surfaces for stream wrapper
      drm/amd/display: Set full update flag in dcn_validate_bandwidth
      drm/amd/display: Set OPP default values in init_hw
      drm/amd/display: Change optimized_required logic
      drm/amd/display: Add dcc_change surface update flag
      drm/amd/display: Refine update flags usage in update_dchubp_dpp
      drm/amd/display: dal 3.1.27

Andrey Grodzovsky (12):
      drm/amdgpu: Avoid accessing job->entity after the job is scheduled.
      drm/amdgpu: Add SPSC queue to scheduler.
      drm/amdgpu: Fix deadlock during GPU reset.
      drm/amdgpu: Remove job->s_entity to avoid keeping reference to
stale pointer.
      drm/amdgpu: Implement BO size validation V2
      drm/amdgpu: Get rid of dep_sync as a seperate object.
      drm/amdgpu: Fix amdgpu_sync_add_later to preserve  explicit flag.
      drm/amdgpu: Add gpu_recovery parameter
      drm/amdgpu: Simplify amdgpu_lockup_timeout usage.
      Revert "drm/amd/amdgpu: set gtt size according to system memory size only"
      drm/amd/powerplay: Fix smu_table_entry.handle type
      drm/amdgpu: Reenable manual GPU reset from sysfs

Andrey Gusakov (1):
      drm/bridge: tc358767: add copyright lines

Anthony Koo (5):
      drm/amd/display: Add APU cap in dc_caps
      drm/amd/display: DMCU FW loading from PSP
      drm/amd/display: Move hdr_metadata from plane to stream
      drm/amd/display: DMCU and ABM maintenance and refactor
      drm/amd/display: Fix check for whether dmcu fw is running

Anusha Srivatsa (3):
      drm/i915/cnl: Update the DMC version on CNL
      drm/i915/dmc: DMC 1.04 for Kabylake
      drm/i915/skl: DMC firmware for skylake v1.27

Archit Taneja (1):
      drm/msm: Fix NULL deref in adreno_load_gpu

Arnd Bergmann (9):
      drm: via: use ktime_get() instead of do_gettimeofday
      drm/via: use monotonic time for VIA_WAIT_IRQ
      drm/i915: fix intel_backlight_device_register declaration
      drm/i915: hide unused intel_panel_set_backlight function
      drm/msm: fix msm_rd_dump_submit prototype
      drm/msm: avoid false-positive -Wmaybe-uninitialized warning
      drm/tegra: Mark Tegra186 display hub PM functions __maybe_unused
      drm/tegra: Fix non-debugfs builds
      drm/amdgpu: use %pap format string for phys_addr_t

Arun Pandey (1):
      drm/amd/display: Added Opp and Diags Interface for P to I

Arvind Yadav (1):
      drm/sti: Handle return value of platform_get_irq_byname

Ben Goz (1):
      drm/amdkfd: Add AQL Queue Memory flag on topology

Benjamin Gaignard (4):
      drm: sti: remove useless fields from vtg structure
      drm: sti: remove vtg_remove
      gpu: drm: sti: Adopt SPDX identifiers
      gpu: drm: stm: Adopt SPDX identifiers

Bhawanpreet Lakha (1):
      drm/amd/display: Atomic freesync ASSERT fix

Boris Brezillon (1):
      drm/vc4: Fix wrong printk format in vc4_bo_stats_debugfs()

Changbin Du (14):
      drm/i915/gvt: Add basic debugfs infrastructure
      drm/i915/gvt: Add mmio iterator intel_gvt_for_each_tracked_mmio()
      drm/i915/gvt: Add new debugfs tool mmio_diff
      drm/i915/gvt: Reduce rcs mocs switch latency
      drm/i915/gvt: Don't dump partial state in cmd parser
      drm/i915/gvt: Make gvt_vgpu_err use pr_err
      drm/i915/gvt: Emulate PCI expansion ROM base address register
      drm/i915/gvt: Convert macro queue_workload to a function
      drm/i915/gvt: Kick scheduler when new workload queued
      drm/i915/gvt: Refine the ring mmio list definition
      drm/i915/gvt: Select appropriate mmio list at initialization time
      drm/i915/gvt: Remove MMIO barrier in MMIO switch
      drm/i915/gvt: Rename file render.{c, h} to mmio_context.{c, h}
      drm/i915: Do not enable movntdqa optimization in hypervisor guest

Charlene Liu (4):
      drm/amd/display: correct DP is always in full range or bt609
      drm/amd/display: Do post_update_surfaces on new state
      drm/amd/display: fix seq issue: turn on clock before programming afmt.
      drm/amd/display: try to find matching audio inst for enc inst first

Chen-Yu Tsai (1):
      drm/sun4i: use sun4i_tcon_of_table to check if a device node is a TCON

Chris Wilson (166):
      drm/i915: Bump wait-times for the final CS interrupt before parking
      drm/i915: Synchronize irq before parking each engine
      drm/i915: Filter out spurious execlists context-switch interrupts
      drm/i915/execlists: Remove the priority "optimisation"
      drm/i915: Call cond_resched() before repeating i915_gem_evict_something()
      drm/i915/selftests: Don't try to queue a request with zero delay
      drm/i915: Use same test for eviction and submitting kernel context
      Revert "drm/i915/selftests: Convert timers to use timer_setup()"
      drm/i915: Add a hook for making the engines idle (parking) and unparking
      drm/i915/guc: Always enable the breadcrumbs irq
      drm/i915: Include RING_MODE when dumping the engine state
      drm/i915: Add -Wall -Wextra to our build, set warnings to full
      drm/i915: Empty the ring before disabling
      drm/i915: Hold rcu_read_lock when iterating over the radixtree (objects)
      drm/i915: Hold rcu_read_lock when iterating over the radixtree (vma idr)
      drm: Enable pr_debug() for drm_printer
      drm/i915: Replace "cc-option -Wno-foo" with "cc-disable-warning foo"
      drm/i915: Check incoming alignment for unfenced buffers (on i915gm)
      drm/i915: Check that the breadcrumb wasn't disarmed
automatically before parking
      drm/i915: Move parking-while-active warning to intel_engines_park()
      drm/i915: Give more details for the active-when-parking warning
for the engines
      drm/i915: Flush the irq and tasklets before asserting engine is idle
      drm/i915: Set up mocs tables before restarting the engines
      drm/i915: Assert vma->flags are updated correctly during binding
      drm/i915/selftests: Hide dangerous tests
      drm/i915: Lock llist_del_first() vs llist_del_all()
      drm/i915/guc: Assert guc->stage_desc_pool is allocated
      drm/i915: Deconstruct struct sgt_dma initialiser
      drm/selftests/mm: Insert cond_resched() between insert modes
      drm/i915: Silence smatch for cmdparser
      drm/i915: Silence compiler for csr_load_work_fn()
      drm/i915: Simplify onion for bxt_ddi_phy_init()
      drm/i915: Prevent unbounded wm results in g4x_compute_wm()
      drm/i915/selftests: Skip mixed page exhaustion if only small
pages available
      drm/i915/selftests: Take rpm wakeref around GGTT lowlevel tests
      drm/i915/selftests: Take rpm wakeref around partial tiling tests
      drm/i915: Read ilk FDI PLL frequency once during initialisation
      drm/i915: Include intel_engine_is_idle() status in engine pretty-printer
      drm/i915: Idle the GPU before shinking everything
      drm/i915: Prune the reservation shared fence array
      drm/i915: Reorder context-close to avoid calling
i915_vma_close() under RCU
      drm/syncobj: Mark up the fence as an RCU protected pointer
      dma-buf/fence: Sparse wants __rcu on the object itself
      drm/i915: Use trace_printk to provide a death rattle for GEM
      drm/i915: Mark vm_free_page() as a potential sleeper agent
      drm/i915: Mark up i915_vma_unbind() as a potential sleeper
      drm/i915/selftests: Reduce the volume of the timeout message
      drm/i915: Move irqs enabled assertion deeper for mock breadcrumbs
      drm/i915: Restore the wait for idle engine after flushing interrupts
      drm/i915/selftests: Initialise mock_i915->mm.obj_lock
      drm/i915: Force the switch to the i915->kernel_context
      drm/i915: Move GT powersaving init to i915_gem_init()
      drm/i915: Move intel_init_clock_gating() to i915_gem_init()
      drm/i915: Inline intel_modeset_gem_init()
      drm/i915: Mark the context state as dirty/written
      drm/i915: Record the default hw state after reset upon load
      drm/i915: Stop caching the "golden" renderstate
      drm/i915: Kerneldoc typo s/rps/rps_client/
      drm/i915/selftests: Yet another forgotten mock_i915->mm initialiser
      drm/i915: Remove redundant intel_autoenable_gt_powersave()
      drm/i915: Unify SLICE_UNIT_LEVEL_CLKGATE w/a for cnl
      drm/i915: Remove pre-production Broxton register workarounds
      drm/i915: Unconditionally apply the Broxton register workaround set
      drm/i915: Resume GuC before using GEM
      drm/i915/selftests: Always initialise err
      drm/i915/selftests: Markup __iomem for igt_gem_coherency
      drm/i915: Initialise entry in intel_ppat_get() for older compilers
      drm/i915/selftests: Increase size for mock ringbuffer
      drm/i915: Make request's wait-for-space explicit
      drm/i915: Remove pre-production pooled-EU w/a for Broxton
      drm/i915: Clear breadcrumb node when cancelling signaling
      drm/i915: Prevent overflow of execbuf.buffer_count and num_cliprects
      drm/i915/selftests: exercise_ggtt may have nothing to do
      drm/i915: Add might_sleep() check to wait_for()
      drm/i915: Mark the userptr invalidate workqueue as WQ_MEM_RECLAIM
      drm/i915/selftests: Report ENOMEM clearly for an allocation failure
      drm/i915: Add a policy note for removing workarounds
      drm/i915/execlists: Listen to COMPLETE context event not ACTIVE_IDLE
      drm/i915/execlists: Reduce completed event mask to COMPLETE | PREEMPTED
      drm/i915/execlists: Assert that we don't get mixed IDLE_ACTIVE |
COMPLETE events
      drm/i915: Pull the unconditional GPU cache invalidation into
request construction
      drm/i915: Automatic i915_switch_context for legacy
      drm/i915/selftest: Make guc clients static
      drm/i915: Remove i915.enable_execlists module parameter
      drm/i915: Remove obsolete ringbuffer emission for gen8+
      drm/i915: Disable semaphores on Sandybridge
      drm/i915: Move debugfs/i915_semaphore_status to i915_engine_info
      drm/i915: Remove i915.semaphores modparam
      drm/i915/selftests: Declare we allocated the guc clients
      drm/i915/gvt: Cleanup unwanted public symbols
      dma-buf/fence: Fix lock inversion within dma-fence-array
      drm/i915/selftests: Avoid drm_gem_handle_create under struct_mutex
      drm/i915/selftests: Use NOWARN for large allocations
      drm/i915: Remove success dmesg noise for intel_rotate_pages()
      drm/i915: Call i915_gem_init_userptr() before taking struct_mutex
      drm/i915: Save/restore irq state for vlv_residency_raw()
      drm/printer: Add drm_vprintf()
      drm/i915: Unwind incomplete legacy context switches
      drm/i915: Move mi_set_context() into the legacy ringbuffer submission
      drm/i915/pmu: Hide the (unsigned long)ptr cast
      drm/i915/selftests: Hold rpm wakeref for request + ggtt usage
      drm/i915/pmu: Remove conditional HOTPLUG_CPU registration
      drm/i915: Select DEBUG_FS for our test suite
      drm/i915/guc: Advance over port[0] if set and not preempting
      drm/i915/guc: Tidy ELSP port assignment
      drm/i915: Use exponential backoff for wait_for()
      drm/i915/fbdev: Serialise early hotplug events with async fbdev config
      drm/i915: Flush everything on switching to the kernel_context
      drm/i915: Record default HW state in the GPU error state
      drm/i915: Rename shrinker init/cleanup to match driver
initialisation phase
      drm/i915: Update shrinker drm_i915_private naming convention
      drm/i915: Rename i915_gem_timelines_mark_idle
      drm/i915: Enable hotplug polling after registering the outputs
      drm/i915: Skip switch-to-kernel-context on suspend when wedged
      drm/i915: Tidy up signed/unsigned comparison
      drm/i915: Set fake_vma.size as well as fake_vma.node.size for capture
      drm/i915/selftests: Wake the device before executing requests on the GPU
      drm/i915: Sleep and retry a GPU reset if at first we don't succeed
      drm/i915: Remove unsafe i915.enable_rc6
      drm/i915/gvt: Fix out-of-bounds buffer write into opregion->signature[]
      drm/i915: Flush pending GTT writes before unbinding
      drm/i915: Taint (TAINT_WARN) the kernel if the GPU reset fails
      drm/i915: Remove vma from object on destroy, not close
      drm/i915: Track GGTT writes on the vma
      drm/i915: Refactor common list iteration over GGTT vma
      drm/i915/execlists: Cache ELSP register offset
      drm/i915: Drop fb reference on load_detect_pipe failure path
      drm/i915: Use snprintf to avoid line-break when pretty-printing engines
      drm/i915: Make engine state pretty-printer header configurable
      drm/i915: Include engine state on detecting a missed breadcrumb/seqno
      drm/i915: Include the global reset count for intel_engine_dump()
      drm/i915: Add is-wedged flag to intel_engine_dump()
      drm/i915: Remove debugfs/i915_seqno_info
      drm/i915: Stop showing seqno info from debugfs/i915_interrupt_info
      agp/intel: Flush all chipset writes after updating the GGTT
      drm/i915/selftests: Free mock_i915->drm.mode_config
      drm/i915: Stop listening to request resubmission from the signaler kthread
      drm/i915: Only report a wakeup if the waiter was truly asleep
      drm/i915: Print an error message for a reset failure on gen2
      drm/i915: Downgrade misleading "Memory usable" message
      drm/i915: Bump timeout for wait_for_engines()
      drm/i915: Dump the engine state before declaring wedged from
wait_for_engines()
      drm/i915/fence: Use rcu to defer freeing of irq_work
      drm/i915: Don't check #active_requests from i915_gem_wait_for_idle()
      drm/i915: Mark up potential allocation paths within
i915_sw_fence as might_sleep
      drm/i915: Allow fence allocations to fail
      drm/i915: Ratelimit request allocation under oom
      drm/i915: Unwind i915_gem_init() failure
      drm/i915: Show engine state when hangcheck detects a stall
      drm/i915: Allow internal page allocations to fail
      drm/i915/lpe: Remove double-encapsulation of info string
      drm/i915: Skip an engine reset if it recovered before our preparations
      drm/i915: Restore the kernel context after a GPU reset on an idle engine
      drm/i915: Re-enable GGTT earlier after GPU reset
      drm/i915: Show IPEIR and IPEHR in the engine dump
      drm/i915/selftests: Fix up igt_reset_engine
      drm/i915: Add a strong mb to resetting the has-CS-interrupt bit
      drm/i915: Fix indentation for intel_ddi_clk_select
      drm/i915: Show if we consider the engine is idle in the GPU error state
      drm/i915: Remove pointer indirection for hangcheck_state local
      drm/i915: Avoid context dereference inside execlists_submission_tasklet
      drm/i915: Tidy up GEM_TRACE around execlists
      drm/i915: Show FBC worker status in debugfs
      drm/i915/execlists: Show preemption progress in GEM_TRACE
      drm/i915: Assert that the request is on the execution queue
before being removed
      drm/i915: Show HWSP in intel_engine_dump()

Christian Gmeiner (1):
      drm/etnaviv: add sensitive state for occlusion query address

Christian König (87):
      dma-buf: add reservation_object_lock_interruptible()
      dma-buf: keep only not signaled fence in
reservation_object_add_shared_replace v3
      dma-buf: try to replace a signaled fence in
reservation_object_add_shared_inplace
      drm/amdgpu: use the actual placement for pin accounting
      drm/amdgpu: always bind pinned BOs
      drm/amdgpu: fix pin domain compatibility check
      drm/amdgpu: don't wait interruptible while binding GART space
      drm/amdgpu: remove extra parameter from amdgpu_ttm_bind() v2
      drm/amdgpu: fix indentation in amdgpu_display.h
      drm/amdgpu: nuke amdgpu_ttm_is_bound() v2
      drm/amdgpu: move GART recovery into GTT manager v2
      drm/amdgpu: resize VRAM BAR for CPU access v6
      drm/amdgpu: rename amdgpu_ttm_bind to amdgpu_ttm_alloc_gart
      drm/amdgpu: don't use ttm_bo_move_ttm in amdgpu_ttm_bind v2
      drm/ttm: move unlocking out of ttm_bo_cleanup_memtype_use
      drm/ttm: consistently use reservation_object_unlock
      drm/ttm: user reservation object wrappers v2
      drm/ttm: remove ttm_bo_unreserve_ticket
      drm/amdgpu: remove nonsense const u32 cast on ARRAY_SIZE result
      drm/amdgpu: cleanup vm_size handling
      drm/ttm: make unlocking in ttm_bo_cleanup_refs optional v3
      drm/ttm: optimize ttm_mem_evict_first v5
      drm/amdgpu: require a root bus window above 4GB for BAR resize
      drm/ttm: fix ttm_mem_evict_first once more
      drm/ttm: completely rework ttm_bo_delayed_delete
      drm/ttm: cleanup coding style in ttm_bo_api.h
      drm/ttm: cleanup ttm_bo_driver.h
      drm/ttm: remove cur_placement
      drm/amdgpu: always make gart.table_addr 64bit
      drm/amdgpu: remove VRAM size reduction v2
      drm/amdgpu: align GTT start to 4GB v2
      drm/amdgpu: fix VCE buffer placement restrictions v2
      drm/ttm: add operation ctx to ttm_bo_validate v2
      drm/ttm: use an operation ctx for ttm_bo_init_reserved
      drm/ttm: use an operation context for ttm_bo_mem_space v2
      drm/ttm: use the operation context inside TTM
      drm/ttm: add context to driver move callback as well
      drm/ttm: add number of bytes moved to the operation context
      staging: vboxvideo: adapt to new TTM interface
      drm/amdgpu: forward operation context to ttm_bo_mem_space
      drm/amdgpu: use the new TTM bytes moved counter v2
      drm/amdgpu: fix VA hole handling on Vega10 v3
      drm/amdgpu: use dev_dbg instead of dev_err in the VA IOCTL
      drm/amdgpu: expose the VA above the hole to userspace
      drm/amdgpu: fix VM PD addr shift
      drm/amdgpu: fix amdgpu_vm_num_entries
      drm/amdgpu: unify VM size handling of Vega10 with older generation
      drm/amdgpu: choose number of VM levels based on VM size
      drm/amdgpu: allow non pot VM size values
      drm/amdgpu: move validation of the VM size into the VM code
      drm/amdgpu: allow specifying vm_block_size for multi level PDs v2
      drm/ttm: swap consecutive allocated cached pages v3
      drm/amdgpu: fix amdgpu_sync_resv v2
      drm/ttm: swap consecutive allocated pooled pages v4
      drm/amdgpu: cleanup debugfs handling a bit
      drm/amdgpu: add amdgpu_evict_vram debugfs file
      drm/amdgpu: stop joining PDEs
      drm/amdgpu: update one PDE at a time v2
      drm/amdgpu: avoid the modulo in amdgpu_vm_get_entry
      drm/amdgpu: remove last_entry_used from the VM code
      drm/amdgpu: remove keeping the addr of the VM PDs
      drm/amdgpu: batch PDE updates again
      drm/amdgpu: allow get_vm_pde to change flags as well
      drm/ttm: use try_lock in ttm_bo_delayed_delete again
      drm/ttm: cleanup some more resv->lock uses
      drm/ttm: cleanup some old defines
      drm/amdgpu: implement 2+1 PD support for Raven v3
      MAINTAINERS: add separate entry for DRM TTM v2
      drm/amdgpu: fix test for shadow page tables
      drm/amdgpu: separate VMID and PASID handling
      drm/amdgpu: rename vm_id to vmid
      drm/amdgpu: drop client_id from VM
      drm/ttm: drop the spin in delayed delete if the trylock doesn't work
      drm/amdgpu: fix VM faults with per VM BOs
      drm/ttm: specify DMA_ATTR_NO_WARN for huge page pools
      drm/amdgpu: loosen the criteria for huge pages a bit
      drm/amdgpu: minor optimize VM moved handling v2
      drm/amdgpu: update VM PDs after the PTs
      drm/amdgpu: simplify huge page handling
      drm/amdgpu: optimize moved handling only when vm_debug is inactive
      drm/amdgpu: fix 64bit BAR detection
      MAINTAINERS: add David (Chunming) Zhou as additional amdgpu maintainer
      drm/amdgpu: fix amdgpu_vm_pasid_fault_credit
      drm/amdgpu: fix typo in amdgpu_vce_validate_bo
      drm/amdgpu: fix CPU based VM updates
      dma-buf: fix reservation_object_wait_timeout_rcu once more v2
      drm: fix gpu scheduler link order

Chunming Zhou (5):
      drm/amd/scheduler: fix page protection of cb
      drm/amd/scheduler: add WARN_ON for s_fence->parent
      drm/amdgpu: use dep_sync for CS dependency/syncobj
      drm/amdgpu: fix huge page setting for ATS case
      drm/amdgpu: add enumerate for PDB/PTB v3

Colin Ian King (8):
      drm: qxl: remove pr_info message, stops log spamming
      drm/i915/gvt: ensure -ve return value is handled correctly
      drm/i915/gvt: Add missing breaks in switch statement
      drm/i915/gvt: fix off-by-one comparison of ring_id
      drm/amdgpu/virt: remove redundant variable pf2vf_ver
      drm/amd/display: remove unnecessary cast and use kcalloc instead
of kzalloc
      drm/msm: fix spelling mistake: "ringubffer" -> "ringbuffer"
      drm/amd/display: remove redundant null check of array 'data'

Dan Carpenter (2):
      drm/panel: rpi-touchscreen: propagate errors in rpi_touchscreen_i2c_read()
      drm/sun4i: Fix error code in sun4i_tcon_bind()

Daniel Vetter (15):
      drm/TODO: Clarify DRM_DEV_* conversion
      MAINTAINERS: Gustavo as drm-misc co-maintainer
      drm: Update docs for legacy kms state
      drm/atomic-helper: always track connector commits, too
      Merge airlied/drm-next into drm-misc-next
      drm/i915: sync dp link status checks against atomic commmits
      drm/i915: remove stale comment from sanitize_encoder
      drm: More debug info for fb leaks in mode_config_cleanup
      intel/atomic: Stop updating legacy fb parameters
      drm/edid: kerneldoc for is_hdmi2_sink
      drm/print: Unconfuse kerneldoc
      drm/syncobj: some kerneldoc polish
      drm/atomic: document how to handle driver private objects
      drm/doc: Move legacy kms helpers to the very end
      drm/ast: Load lut in crtc_commit

Dave Airlie (30):
      Merge tag 'drm-misc-next-2017-11-30' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2017-11-17-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm/next/du' of git://linuxtv.org/pinchartl/media
into drm-next
      Merge branch 'drm-next-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2017-12-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2017-12-01' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2017-12-14' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      BackMerge tag 'v4.15-rc4' into drm-next
      Merge tag 'drm-intel-next-2017-12-14' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'tilcdc-4.16' of https://github.com/jsarha/linux into drm-next
      Merge tag 'omapdrm-4.16' of git://git.kernel.org/.../tomba/linux
into drm-next
      Merge branch 'drm-next-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2017-12-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2017-12-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-amdkfd-next-2017-12-24' of
git://people.freedesktop.org/~gabbayo/linux into drm-next
      Merge tag 'exynos-drm-next-for-v4.16' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next
      Merge branch 'drm-armada-devel-4.15' of
git://git.armlinux.org.uk/~rmk/linux-arm into drm-next
      Merge tag 'imx-drm-next-2018-01-02' of
git://git.pengutronix.de/git/pza/linux into drm-next
      Merge branch 'drm-next-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2018-01-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-msm-next-2018-01-10' of
git://people.freedesktop.org/~robclark/linux into drm-next
      Merge tag 'drm/tegra/for-4.16-rc1-fixes' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge branch 'drm-next-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      drm/radeon: fill in rb backend map on evergreen/ni.
      BackMerge tag 'v4.15-rc8' into drm-next
      Merge tag 'drm-amdkfd-next-fixes-2018-01-15' of
git://people.freedesktop.org/~gabbayo/linux into drm-next
      Merge branch 'drm-next-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2018-01-18' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-misc-next-fixes-2018-01-31' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

Dave Gordon (1):
      drm/i915/guc: Add a second client, to be used for preemption

Dave Stevenson (3):
      drm/vc4: Add support for DRM_FORMAT_RGB888 and DRM_FORMAT_BGR888
      drm/vc4: Use .pixel_order instead of custom .flip_cbcr
      drm/vc4: Add support for NV21 and NV61.

David Lechner (11):
      dt-bindings: Add vendor prefix for ilitek
      dt-bindings: Add binding for Ilitek ILI9225 display panels
      drm/tinydrm: export mipi_dbi_buf_copy and mipi_dbi_spi_cmd_max_speed
      drm/tinydrm: add driver for ILI9225 panels
      drm: fix tainted kernel caused by drm_panel_orientation_quirks.c
      dt-bindings: Add "vot" vendor prefix
      dt-bindings: update compatible string for ILI9225
      drm/tinydrm: Update ILI9225 compatible string
      dt-bindings: add jianda vendor prefix
      dt-bindings: Add binding for Sitronix ST7735R display panels
      drm/tinydrm: add driver for ST7735R panels

David Panariti (2):
      drm/amdgpu: New header for fields needed to determine state of ECC.
      drm/amdgpu: Add ability to determine and report if board supports ECC.

David Weinehall (1):
      drm/i915: Don't use GEN6_RC_VIDEO_FREQ on gen10+

Dhinakaran Pandiyan (2):
      drm/dp: Bit definition for D3 power state that keeps AUX fully powered
      drm/i915/psr: Fix register name mess up.

Dmitry Osipenko (3):
      drm/tegra: dc: Link DC1 to DC0 on Tegra20
      drm/tegra: gem: Correct iommu_map_sg() error checking
      drm/tegra: Correct timeout in tegra_syncpt_wait

Dmitry Rozhkov (1):
      drm/radeon: fix sparse warning: Should it be static?

Dmytro Laktyushkin (17):
      drm/amd/display: cache pwl params and scl_data to avoid extra programming
      drm/amd/display: fix regamma programming
      drm/amd/display: fix uninitialized variable warning
      drm/amd/display: remove unnecessary waits in dcn10
      drm/amd/display: add warning on long reg_wait
      drm/amd/display: remove dcn10 wait on tg unlock
      drm/amd/display: fix mpo validation failure
      drm/amd/display: fix refclk conversion from khz int to mhz float
      drm/amd/display: Rename output_bpc to opp_input_bpc
      drm/amd/display: set chroma taps to 1 when not scaling
      drm/amd/display: Add dppclk to dcn_bw_clocks
      drm/amd/display: add assert to verify dcn_calc input validity
      drm/amd/display: use clamping rather than truncation for CM fp conversions
      drm/amd/display: clean up dcn soc params
      drm/amd/display: fix rotated surface scaling
      drm/amd/display: fix global sync param retrieval when not pipe splitting
      drm/amd/display: fix 180 full screen pipe split

Emily Deng (1):
      drm/amdgpu: Correct the IB size of bo update mapping.

Eric Anholt (1):
      drm/vc4: Reject HDMI modes with too high of clocks.

Eric Bernstein (14):
      drm/amd/display: Call ipp_program_bias_and_scale only if available
      drm/amd/display: Add OPP DPG blank function
      drm/amd/display: Remove unused OPP functions from interface
      drm/amd/display: Integrating MPC pseudocode
      drm/amd/display: MPC updates
      drm/amd/display: Reset MPCC muxes during init
      drm/amd/display: OPP DPG test pattern
      drm/amd/display: use REG_UPDATE for MPC mux
      drm/amd/display: Move OPP mpc tree initialization to hw_init
      drm/amd/display: Update HUBP
      drm/amd/display: Remove dwbc from pipe_ctx
      drm/amd/display: Clean up DCN cursor code
      drm/amd/display: Put dcn_mi_registers with other structs
      drm/amd/display: Update FMT and OPPBUF functions

Eric Murphy-Zaremba (1):
      drm/amd/display: Add is_tiling_rotated flag to plane_state

Eric Yang (6):
      drm/amd/display: get remote dpcd caps for timing validation
      drm/amd/display: always call set output tf
      drm/amd/display: combine output signal and signal
      drm/amd/display: fix missing pixel clock adjustment for dongle
      drm/amd/display: dal 3.1.26
      drm/amd/display: reprogram surface config on scaling change

Ernst Sjöstrand (5):
      drm/amd/powerplay: Minor fixes in processpptables.c (v2)
      drm/amd/powerplay: Fix missing newlines at end of file
      drm/amd/amdgpu: Fix missing null check in atombios_i2c.c
      drm/amd/powerplay: Fix buffer overflows with mc_reg_address
      drm/amd/powerplay: Followup fixes to mc_reg_address

Evan Quan (2):
      drm/amd/powerplay: describe the PCIE link speed in right GT/s
      drm/amd/powerplay: set pp_num_states as 0 on error situation

Fabio Estevam (3):
      drm/stm: dsi: Remove unnecessary platform_get_resource() error check
      drm/stm: ltdc: Remove unnecessary platform_get_resource() error check
      drm/exynos: decon5433: Remove unnecessary
platform_get_resource() error check

Fabrizio Castro (3):
      dt-bindings: display: rcar-du: Document R8A774[35] DU
      drm: rcar-du: Add R8A7743 support
      drm: rcar-du: Add R8A7745 support

Feifei Xu (24):
      drm/amd/include:cleanup vega10 sdma0/1 header files.
      drm/amd/include:cleanup vega10 hdp header files.
      drm/amd/include:cleanup vega10 mp header files.
      drm/amd/include:cleanup vega10 athub header files.
      drm/amd/include:cleanup vega10 thm header files.
      drm/amd/include: cleanup vega10 umc header files.
      drm/amd/include:cleanup vega10 dce header files.
      drm/amd/include:cleanup vega10 uvd header files.
      drm/amd/include:cleanup vega10 vce header files.
      drm/amd/include:cleanup vega10 gc header files.
      drm/amd/include:cleanup vega10 mmhub header files.
      drm/amd/include:cleanup vega10 nbio header files.
      drm/amd/include:cleanup vega10 nbif header files.
      drm/amd/include:cleanup vega10 smuio header files.
      drm/amd/include:cleanup vega10 osssys header files.
      drm/amd/include:cleanup vega10 header files.
      drm/amd/include:cleanup raven1 sdma header files.
      drm/amd/include:cleanup raven1 dcn header files.
      drm/amd/include:cleanup raven1 gc header files.
      drm/amd/include:cleanup raven1 mmhub header files.
      drm/amd/include:cleanup raven1 mp header files.
      drm/amd/include:cleanup raven1 nbio header files.
      drm/amd/include:cleanup raven1 thm header files.
      drm/amd/include:cleanup raven1 vcn header files.

Felix Kuehling (27):
      drm/amd: Update kgd_kfd interface for resuming SDMA queues
      drm/amdgpu: Add support for resuming SDMA queues w/o HWS
      drm/amdkfd: Use ASIC-specific SDMA MQD type
      drm/amdkfd: Hardware DWORD size is 4 bytes
      drm/amdkfd: Use order_base_2 to get log2 of buffes sizes
      drm/amdkfd: Cleanup qpd.pqm initialization
      drm/amdkfd: Add trap handler for CWSR
      drm/amdkfd: Add CWSR support
      drm/amdkfd: Add support for user-mode trap handlers
      drm/amdgpu: fix get_max_engine_clock_in_mhz
      drm/amdkfd: map multiple processes to HW scheduler
      drm/amdkfd: Fix oversubscription accounting
      drm/amdgpu: Fix definition of KFD_CIK_SDMA_QUEUE_OFFSET
      drm/amdgpu: Add kfd2kgd APIs for dumping HQDs
      drm/amdkfd: Add debugfs support to KFD
      drm/amdkfd: Get reference to lead_thread task struct
      drm/amdkfd: Make kfd_process reference counted
      drm/amdkfd: Use ref count to prevent kfd_process destruction
      drm/amdkfd: Reduce nesting in kfd_create_process_device_data
      drm/amdkfd: Factor PDD destruction out of kfd_process_wq_release
      drm/amdkfd: Group up CRAT related functions
      drm/amdkfd: Turn verbose topology messages into pr_debug
      drm/amdkfd: Simplify counting of memory banks
      drm/amdkfd: Add topology support for CPUs
      drm/amdkfd: Module option to disable CRAT table
      drm/ttm: Don't add swapped BOs to swap-LRU list
      drm/ttm: Don't unreserve swapped BOs that were previously reserved

Flora Cui (3):
      drm/amd: add new interface to query cu info
      drm/amdgpu: add amdgpu interface to query cu info
      drm/amdkfd: Update number of compute unit from KGD

Frank Min (2):
      drm/amdgpu: correct vce4.0 fw config for SRIOV (V2)
      drm/amdgpu: correct vce fw data and stack size

Gabriel Krisman Bertazi (1):
      i915: Reject CCS modifiers for pipe C on Geminilake

Greg Kroah-Hartman (1):
      gpu: gma500: remove unneeded DRIVER_LICENSE #define

Gustavo A. R. Silva (5):
      drm/amd/display/dc/core/dc_resource: use swap macro in rect_swap_helper
      drm/amd/display/dc/dce110/dce110_mem_input_v: use swap macro in
program_size_and_rotation
      drm/fb-helper: Fix potential NULL pointer dereference
      drm/i915/gvt/fb_decoder: Fix out-of-bounds read
      drm/amdkfd: Fix potential NULL pointer dereferences

Gustavo Padovan (1):
      Merge arlied/drm-next into drm-misc-next

H. Nikolaus Schaller (2):
      omapdrm: panel: fix compatible vendor string for td028ttec1
      omapdrm: panel: td028ttec1: replace MODULE_ALIAS by MODULE_DEVICE_TABLE

Haneen Mohammed (2):
      drm: Move debug macros out of drmP.h
      drm/print: Update old comment style

Hans de Goede (14):
      x86/platform/intel/iosf_mbi: Add unlocked PMIC bus access
notifier unregister
      drm/i915: Acquire PUNIT->PMIC bus for intel_uncore_forcewake_reset()
      drm/i915: Fix false-positive assert_rpm_wakelock_held in
i915_pmic_bus_access_notifier v2
      drm/i915: Re-register PMIC bus access notifier on runtime resume
      drm/i915: Call uncore_suspend before platform suspend handlers
      fbcon: Add fbcon_rotate_hint to struct fb_info
      drm: Add panel orientation quirks, v6.
      drm: Add support for a panel-orientation connector property, v6
      drm/fb-helper: Apply panel orientation connector prop to the
primary plane, v6.
      drm/i915: Add "panel orientation" property to the panel connector, v6.
      efifb: Set info->fbcon_rotate_hint based on
drm_get_panel_orientation_quirk
      fbcon: Remove dmi quirk table
      drm: Document that drm_panel_orientation_quirks.c is shared with fbdev
      drm: Fix PANEL_ORIENTATION_QUIRKS breaking the Kconfig DRM menuconfig

Harish Kasiviswanathan (13):
      drm/amd: Add get_local_mem_info to KGD-KFD interface
      drm/amdgpu: Implement get_local_mem_info
      drm/amdkfd: Stop using get_vmem_size KGD-KFD interface
      drm/amdkfd: Remove deprecated get_vmem_size
      drm/amd: Remove get_vmem_size from KGD-KFD interface
      drm/amdkfd: Topology: Fix location_id
      drm/amdkfd: Reorganize CRAT fetching from ACPI
      drm/amdkfd: Decouple CRAT parsing from device list update
      drm/amdkfd: Support enumerating non-GPU devices
      drm/amdkfd: sync IOLINK defines to thunk spec
      drm/amdkfd: Fix sibling_map[] size
      drm/amdkfd: Add topology support for dGPUs
      drm/amdkfd: Ignore ACPI CRAT for non-APU systems

Harry Wentland (36):
      drm/amd/display: Cleanup some fail labels in dcn10_resource
      drm/amd/display: Clean some unneeded defines from ddc_service_types.h
      drm/amd/display: Explicit casting for grph object ids
      drm/amd/display: Move conn_state to header
      amdgpu/dm: Remove fb_location form fill_plane_attributes
      drm/amd/display: Both timing_sync and multisync need stream_count > 1
      drm/amd/display: Bunch of indentation cleanups in color stuff
      drm/amd/display: Fix some more color indentations
      drm/amd/display: Remove extra arr_points element
      drm/amd/display: Bunch more color indentation cleanups
      drm/amd/display: Remove unused register read in program_pwl
      drm/amd/display: A few more color indentation changes
      drm/amd/display: Move dc_stream interface to separate header
      drm/amd/display: Move dc_link interface to separate header
      drm/amd/display: Remove unnecessary dc_stream vtable
      drm/amd/display: Fix Linux after optimize frontend programming
      drm/amd/display: Remove unnecessary dc_link vtable
      drm/amd/display: Remove PSR functions in Linux
      drm/amd/display: Remove plane_res.mi check in dce110_apply_ctx_for_surface
      drm/amd/display: Remove redundant checks in set_default_colors
      drm/amd/display: Fix potential mem leak in DC construct
      drm/amd/display: Add optimized_required flag
      drm/amd/display: Fix access of wrong array element TF format conversion
      drm/amd/display: Clean up os_types.h a bit
      drm/amd/display: Use macro for isnan check
      drm/amd/display: Add disclaimer to BW and DML code provided by HW
      drm/amd/display: Print DC_VER at DC init
      drm/amd/display: Remove redundant NULL check in DCE11 HWSS
      drm/amd/display: Remove grph_object_id.c and move function to bios_parser
      drm/amd/display: Add TODO item to remove vector.c
      drm/amd/display: Print type if we get wrong ObjectID from bios
      drm/amd/display: Remove dead enable_plane function definition and call
      drm/amd/display: Error print when ATOM BIOS implementation is missing
      drm/amd/display: Don't spam debug log on long reg waits
      drm/amd/display: Call validate_fbc should_enable_fbc
      drm/amd/display: Demote error print to debug print when ATOM impl missing

Harsha Sharma (1):
      drm/tinydrm: Replace list_for_each with list_for_each_entry

Hawking Zhang (1):
      drm/amdgpu: switch to use new SOC15 reg read/write macros for soc15 ih

Hersen Wu (1):
      drm/amd/display: send display_count msg so SMU can enter S0i2

Horace Chen (1):
      drm/amdgpu: refine SR-IOV firmware VRAM reservation to protect data

Huang Rui (1):
      drm/amdgpu: disable MMHUB power gating on raven

Hugo Hu (1):
      drm/amd/display: Use the maximum link setting which EDP reported.

Imre Deak (1):
      drm/i915: Avoid PPS HW/SW state mismatch due to rounding

James Ausmus (2):
      drm/i915/glk: Refactor handling of PLANE_COLOR_CTL for GLK+
      drm/i915/cnl: Mask previous DDI - PLL mapping

James Zhu (1):
      drm/amd/amdgpu: Add Polaris version check

Jani Nikula (9):
      drm/i915/edp: read edp display control registers unconditionally
      drm/i915/edp: clean up code and comments around eDP DPCD read
      drm/edid: use macros for ELD offsets and values
      drm/edid: set ELD connector type in drm_edid_to_eld()
      drm/edid: abstract connector ELD clearing
      drm/edid: build ELD in drm_add_edid_modes()
      drm/drivers: drop redundant drm_edid_to_eld() calls
      drm/edid: make drm_edid_to_eld() static
      MAINTAINERS: Remove Jani as drm-misc co-maintainer

Jeff McGee (1):
      drm/i915/guc: Clear terminated attribute bit on GuC preemption context

Jeffy Chen (1):
      drm/rockchip: analogix_dp: Remove unnecessary init code

Jernej Skrabec (27):
      drm/sun4i: Fix format mask in DE2 driver
      drm/sun4i: Rename DE2 RGB format macros
      drm/sun4i: Remove setting alpha mode in DE2 driver
      drm/sun4i: Fix debug message in DE2
      drm/sun4i: Remove setting default values in DE2 driver
      drm/sun4i: Explain color macro in DE2 driver
      drm/sun4i: Set blending mode for all channels (DE2)
      drm/sun4i: Rename some macros in DE2 driver
      drm/sun4i: Rework enabling plane in DE2 driver
      drm/sun4i: Start using layer id in DE2 driver
      drm/sun4i: Add constraints checking to DE2 driver
      drm/sun4i: Use values calculated by atomic check
      drm/sun4i: Move line width setting in DE2
      drm/sun4i: Move channel size related code in DE2
      drm/sun4i: Move interlace related code in DE2
      drm/sun4i: Add multi plane support to DE2 driver
      drm/sun4i: Add support for all HW supported DE2 RGB formats
      drm/sun4i: Reorganize UI layer code in DE2
      drm/sun4i: Add support for DE2 VI planes
      drm/sun4i: Add scaler configuration to DE2 mixers
      drm/sun4i: Add support for HW scaling to DE2
      drm/sun4i: Add CCSC property to DE2 configuration
      drm/sun4i: Add DE2 CSC library
      drm/sun4i: Add DE2 definitions for YUV formats
      drm/sun4i: Expand DE2 scaler lib with YUV support
      drm/sun4i: Wire in DE2 YUV support
      drm/sun4i: Fix uninitialized variables in vi layer

Jerry (Fangzhi) Zuo (1):
      drm/amd/display: Fix rehook MST display not light back on

Jim Qu (2):
      drm/amdgpu: always cancel uvd idle handler in uvd suspend
      drm/amdgpu: restore uvd fence seq in uvd resume

Joe Perches (2):
      drm: amd: Fix line continuation formats
      drm/ttm: Use a static string instead of an array of char *

Joonas Lahtinen (4):
      drm/i915: Disable lazy PPGTT page table optimization for vGPU
      drm/i915: Disable THP until we have a GPU read BW W/A
      x86/early-quirks: Extend Intel graphics stolen memory placement to 64bit
      drm/i915/cnl: Add support for horizontal plane flipping

Jordan Crouse (9):
      drm/msm: gpu: Only sync fences on rings that exist
      drm/msm/adreno: Call dev_pm_opp_put()
      drm/msm/adreno: Remove a useless call to dev_pm_opp_get_freq()
      drm/msm/gpu: Remove unused bus scaling code
      drm/msm/adreno: Cleanup chipid parsing
      drm/msm/adreno: Move clock parsing to adreno_gpu_init()
      drm/msm/adreno: Read the speed bins for a5xx targets
      drm/msm/adreno: a5xx: Explicitly program the CP0 performance counter
      drm/msm: Add devfreq support for the GPU

Junwei Zhang (1):
      drm/amdgpu/gfx9: fix ngg enablement to clear gds reserved memory (v2)

Jyri Sarha (1):
      drm/tilcdc: Remove drm_framebuffer_get() and *_put() calls

Kees Cook (3):
      drm/i915/selftests: Convert timers to use timer_setup()
      drm/vc4: Convert timers to use timer_setup()
      drm: gma500: Convert timers to use timer_setup()

Keith Packard (2):
      drm: Update edid-derived drm_display_info fields at edid property set [v2]
      drm: Check for lessee in DROP_MASTER ioctl

Ken Chalmers (1):
      drm/amd/display: fix dcn10_hubbub_wm_read_state

Kent Russell (2):
      drm/amdkfd: Fix printing pointer cast
      drm/amdgpu: Add support for reporting VRAM usage

Kieran Bingham (2):
      drm: rcar-du: Implement system suspend/resume support
      drm: rcar-du: Remove unused CRTC suspend/resume functions

Krzysztof Kozlowski (2):
      drm/exynos/decon: Move headers from global to local place
      drm/exynos/decon: Add include guard to the Exynos7 header

Laurent Pinchart (12):
      drm: rcar-du: Don't set connector DPMS property
      v4l: vsp1: Start and stop DRM pipeline independently of planes
      drm: rcar-du: Share plane atomic check code between Gen2 and Gen3
      drm: rcar-du: Clip planes to screen boundaries
      drm: omapdrm: dpi: Don't treat GPIO probe deferral as an error
      drm: omapdrm: Pass drm_device to omap_gem_resume()
      drm: omapdrm: Remove unused omap_dss_find_device() function
      drm: omapdrm: dss: Set the DMA coherent mask
      drm: omapdrm: dss: Make dss_dump_clocks() function static
      drm: omapdrm: dpi: Remove dpi_data port_initialized field
      drm: omapdrm: venc: Return error code on OF parsing failure
      drm: omapdrm: Deconstruct the omap_drv.h header.

Leo (Sunpeng) Li (13):
      drm/amd/display: Cleanup code that enables freesync
      drm/amd/display: Only add stream to freesync when modeset required
      drm/amd/display: Fix styling of freesync code in commit_tail
      drm/amd/display: Complete TODO item: use new DRM iterator
      drm/amd/display: Remove dangling planes on dc commit state
      drm/amd/display: Change frontend/backend programming sequence
      drm/amd/display: Early return on stream programming failure
      drm/amd/display: Fix unused variable warning
      drm/amd/display: Fix use before initialize warning
      drm/amd/display: Trigger full update on plane change
      drm/amd/display: Do not program front-end twice
      drm/amd/display: Do DC mode-change check after stream creation
      drm/amd/display: Fix unused variable warnings.

Lepton Wu (2):
      drm/virtio: add create_handle support.
      drm/cirrus: add create_handle support.

Linus Walleij (2):
      drm/panel: Add DT bindings for Ilitek ILI9322
      drm/panel: Add Ilitek ILI9322 driver

Lionel Landwerlin (15):
      drm/i915/perf: fix perf enable/disable ioctls with 32bits userspace
      drm/i915: ensure oa config uuid is null terminated
      drm/i915/perf: complete whitelisting for OA programming on HSW
      drm/i915/perf: add support for Coffeelake GT3
      drm/i915/perf: refactor perf setup
      drm/i915: fix register naming
      drm/i915/perf: enable perf support on CNL
      drm/i915: expose command stream timestamp frequency to userspace
      drm/i915: fix 64bit divide
      drm/i915/perf: replace .reg accesses with i915_mmio_reg_offset
      drm/i915/perf: reuse timestamp frequency from device info
      drm/i915/cnl: only divide up base frequency with crystal source
      drm/i915: make CS frequency read support missing more obvious
      drm/i915: reorder field in gem_request tracepoints
      drm/i915/trace: add hw_id to gem requests trace points

Liviu Dudau (5):
      drm/drm_vma_manager.c: Remove useless goto statement
      drm: Spelling fixes
      dma-buf: Cleanup comments on dma_buf_map_attachment()
      drm/drm_mm.h: Fix the name of the referenced function in comment
      drm: gem_cma_helper.c: Allow importing of contiguous
scatterlists with nents > 1

Logan Gunthorpe (1):
      drm/tilcdc: ensure nonatomic iowrite64 is not used

Lucas De Marchi (4):
      drm/i915: Fix function name in comment
      drm/i915: follow single notation for workaround number
      drm/i915: add platform tag to WA
      x86/gpu: add CFL to early quirks

Lucas Stach (38):
      drm: don't link DP aux i2c adapter to the hardware device node
      drm/prime: skip CPU sync in map/unmap dma_buf
      drm: move amd_gpu_scheduler into common location
      drm/sched: move fence slab handling to module init/exit
      gpu: ipu-v3: prg: switch to runtime PM
      gpu: ipu-v3: pre: add tiled prefetch support
      gpu: ipu-v3: prg: add modifier support
      drm/imx: add FB modifier support
      drm/imx: advertise supported plane format modifiers
      drm/etnaviv: fix GPU vs sync point race
      drm/etnaviv: split obj locks in different classes depending on
the obj type
      drm/etnaviv: add lockdep annotation for userptr object population
      drm/etnaviv: fold __etnaviv_gem_new into caller
      drm/etnaviv: change return type of etnaviv_gem_obj_add to void
      drm/etnaviv: get rid of userptr worker
      drm/etnaviv: remove -EAGAIN handling from submit path
      drm/etnaviv: remove stale TODO in etnaviv_gpu_submit
      drm/etnaviv: don't flush workqueue in etnaviv_gpu_wait_obj_inactive
      drm/etnaviv: remove switch_context member from etnaviv_gpu
      drm/etnaviv: move workqueue to be per GPU
      drm/etnaviv: hold GPU lock while inserting END command
      drm/etnaviv: add lockdep annotations to buffer manipulation functions
      drm/etnaviv: simplify submit_create
      drm/etnaviv: move object fence attachment to gem_submit path
      drm/etnaviv: rename submit fence to out_fence
      drm/etnaviv: attach in fence to submit and move fence wait to fence_sync
      drm/etnaviv: move object unpinning to submit cleanup
      drm/etnaviv: move ww_acquire_ctx out of submit object
      drm/etnaviv: refcount the submit object
      drm/etnaviv: move PMRs to submit object
      drm/etnaviv: move exec_state to submit object
      drm/etnaviv: use submit exec_state for perfmon sampling
      drm/etnaviv: move cmdbuf into submit object
      drm/etnaviv: move GPU active handling to bo pin/unpin
      drm/etnaviv: couple runtime PM management to submit object lifetime
      drm/etnaviv: re-enable perfmon support
      drm/etnaviv: move submit free out of critical section
      drm/etnaviv: use memset32 to init pagetable

Lukas Wunner (1):
      drm/msm/mdp4: Deduplicate bus_find_device() by name matching

Lukasz Majewski (2):
      drm/panel: simple: Add Tianma TM070RVHG71 panel support
      drm/panel: simple: Add Mitsubishi AA070MC01 panel support

Maarten Lankhorst (16):
      drm/i915: Do not rely on wm preservation for ILK watermarks
      drm/i915: Calculate ironlake intermediate watermarks correctly, v2.
      drm/atomic: Try to preserve the crtc enabled state in
drm_atomic_remove_fb, v2.
      drm/i915: Update watermark state correctly in sanitize_watermarks
      drm/i915: Remove bogus ips_enabled check.
      drm/i915: Check boolean options in intel_pipe_config_compare
with its own macro
      drm/i915: Handle adjust better in intel_pipe_config_compare
      drm/i915: Handle locking better in i915_sink_crc.
      drm/i915: Enable FIFO underrun reporting after initial fastset, v4.
      drm/i915: Pass idle crtc_state to intel_dp_sink_crc
      drm/i915: Pass crtc_state to ips toggle functions, v2
      drm/i915: Calculate vlv/chv intermediate watermarks correctly, v3.
      drm/i915: Calculate g4x intermediate watermarks correctly
      drm/i915: Make ips_enabled a property depending on whether IPS
is enabled, v3.
      drm/i915: Enable IPS with only sprite plane visible too, v4.
      drm/framebuffer: Print task that allocated the fb in debug info.

Maciej Purski (1):
      drm/bridge/sii8620: add DVI mode support

Manasi Navare (1):
      drm/i915: Cancel the modeset retry work during modeset cleanup

Marek Szyprowski (2):
      drm/bridge/sii8620: filter unsupported modes
      drm/exynos: ipp: Remove Exynos DRM IPP subsystem

Mark Yao (1):
      MAINTAINERS: change maintainer for Rockchip drm drivers

Markus Elfring (1):
      drm/etnaviv: Improve unlocking of a mutex in etnaviv_iommu_map_gem()

Markus Heiser (1):
      docs: fix, intel_guc_loader.c has been moved to intel_guc_fw.c

Matthew Auld (11):
      drm/i915/selftests: rein in igt_write_huge
      drm/i915/selftests: test descending addresses
      x86/early-quirks: export the stolen region as a resource
      x86/early-quirks: replace the magical increment start values
      drm/i915: nuke the duplicated stolen discovery
      drm/i915: make dsm struct resource centric
      drm/i915: make reserved struct resource centric
      drm/i915: make mappable struct resource centric
      drm/i915: give stolen_usable_size a more suitable home
      drm/i915: prefer resource_size_t for everything stolen
      drm/i915: prefer i915_gem_object_has_pages()

Maxime Ripard (9):
      dt-bindings: display: sun4i-drm: Add LVDS properties
      dt-bindings: display: sun4i-drm: Add A83T pipeline
      drm/sun4i: Force the mixer rate at 150MHz
      drm/sun4i: Create minimal multipliers and dividers
      drm/sun4i: Add LVDS support
      drm/sun4i: Add A83T support
      dt-bindings: panel: lvds: Document power-supply property
      drm/panel: lvds: Add support for the power-supply property
      drm/panel: lvds: Handle the optional regulator case properly

Michal Wajdeczko (29):
      drm/i915/huc: Use helper function while waiting for DMA completion
      drm/i915/guc: Assert ctch->vma is allocated
      drm/i915: Add Guc/HuC firmware details to error state
      drm/i915: Make GuC log part of the uC error state
      drm/i915: Handle error-state modparams in dedicated functions
      drm/i915/guc: Split GuC firmware xfer function into clear steps
      drm/i915/guc: Wait for ucode DMA transfer completion
      drm/i915/guc: Drop legacy workarounds from guc_prepare_xfer
      drm/i915/guc: Simplify programming of GUC_SHIM_CONTROL
      drm/i915/guc: Rename i915_guc_reg.h to intel_guc_reg.h
      drm/i915/guc: Use consistent name for scratch register count
      drm/i915/huc: Move firmware selection to init_early
      drm/i915/guc: Move firmware selection to init_early
      drm/i915/guc: Introduce USES_GUC_xxx helper macros
      drm/i915/uc: Don't fetch GuC firmware if no plan to use GuC
      drm/i915/uc: Don't use -EIO to report missing firmware
      drm/i915/guc: Combine enable_guc_loading|submission modparams
      drm/i915/huc: Load HuC only if requested
      drm/i915: Unifying debugfs return codes for unsupported features
      drm/i915: Add pretty printer for device info flags
      drm/i915: Convert intel_device_info_dump into pretty printer
      drm/i915: Add pretty printer for modparams
      drm/i915: Move some utility functions to i915_util.h
      drm/i915: Move display related definitions to dedicated header
      drm/i915: Move opregion definitions to dedicated intel_opregion.h
      drm/i915: Move intel_device_info definitions to its own header
      drm/i915: Update intel_device_info_runtime_init() parameter
      drm/i915: Add pretty printer for runtime part of intel_device_info
      drm/i915: Dump device info at once

Michał Mirosław (1):
      virtgpu: remove redundant task_comm copying

Michał Winiarski (18):
      drm/i915/guc: Initialize GuC before restarting engines
      drm/i915/guc: Do not use 0 for GuC doorbell cookie
      drm/i915/guc: Extract GuC stage desc pool creation into a helper
      drm/i915/guc: Allocate separate shared data object for GuC communication
      drm/i915/guc: Add preemption action to GuC firmware interface
      drm/i915/guc: Split guc_wq_item_append
      drm/i915: Extract "emit write" part of emit breadcrumb functions
      drm/i915: Add information needed to track engine preempt state
      drm/i915/guc: Keep request->priority for its lifetime
      drm/i915: Rename helpers used for unwinding, use macro for can_preempt
      drm/i915/guc: Preemption! With GuC
      drm/i915/guc: Move shared data allocation away from submission path
      drm/i915/guc: Move GuC workqueue allocations outside of the mutex
      drm/i915/guc: Extract guc_init from guc_init_hw
      drm/i915/guc: Call invalidate after changing the vfunc
      drm/i915/guc: Extract doorbell creation from client allocation
      drm/i915/guc: Extract clients allocation to submission_init
      drm/i915/guc: Extract doorbell verification into a function

Michel Dänzer (14):
      amdgpu/dce: Use actual number of CRTCs and HPDs in set_irq_funcs
      drm/amd/display: Use real number of CRTCs and HPDs in set_irq_funcs
      amdgpu: Remove AMDGPU_{HPD,CRTC_IRQ,PAGEFLIP_IRQ}_LAST
      drm/amd/display: Remove fb_location parameter from get_fb_info
      amdgpu: Don't use DRM_ERROR when failing to allocate a BO
      drm/amdgpu: Downgrade DRM_ERROR to DRM_DEBUG in amdgpu_queue_mgr_map
      drm/amd/display: Fix description of module parameter dc_log
      drm/amd/display: Add dm_logger_append_va API
      drm/amd/display: Don't call dm_log_to_buffer directly in dc_conn_log
      Revert "drm/radeon: adding synchronization for GRBM GFX"
      Revert "drm/radeon: Report doorbell configuration to amdkfd"
      Revert "drm/radeon/cik: Don't touch int of pipes 1-7"
      Revert "drm/radeon: reduce number of free VMIDs and pipes in KV"
      drm/radeon: Remove KFD_CIK_SDMA_QUEUE_OFFSET

Michel Thierry (7):
      drm/i915/cnl: Remove unnecessary check in cnl_setup_private_ppat
      drm/i915/guc: Rename the function that resets the GuC
      drm/i915/guc: Add support for reset engine using GuC commands
      drm/i915: Clear per-engine fault register as early as possible
      drm/i915: There is only one fault register from GEN8 onwards
      drm/i915/selftests: Add a GuC doorbells selftest
      drm/i915/execlists: Delay writing to ELSP until HW has processed
the previous write

Mika Kahola (2):
      drm/i915/cnl: Symmetric scalers for each pipe
      drm/i915: Generalize transcoder looping

Mika Kuoppala (2):
      drm/i915: Use fallback forcewake if primary ack missing
      drm/i915: Print the condition causing GEM_BUG_ON

Mikita Lipski (2):
      drm/amd/display: Adding DCN1 registers
      drm/amd/display: Multi display synchronization logic

Monk Liu (31):
      drm/amdgpu:cleanup force_completion
      drm/amdgpu:add hang_limit for sched(v2)
      drm/amd/scheduler:introduce guilty pointer member
      drm/amdgpu:pass ctx->guilty address to entity init
      drm/amdgpu:skip job for guilty ctx in parser_init
      drm/amdgpu:cleanup job reset routine(v2)
      drm/amdgpu:don't change ctx->reset_couner upon query
      drm/amdgpu:implement ctx query2
      amd/scheduler:imple job skip feature(v3)
      drm/amdgpu:implement new GPU recover(v3)
      drm/amdgpu:cleanup in_sriov_reset and lock_reset
      drm/amdgpu:cleanup ucode_init_bo
      drm/amdgpu/sriov:fix memory leak in psp_load_fw
      drm/amdgpu:fix random missing of FLR NOTIFY
      drm/amdgpu:read VRAMLOST from gim
      drm/amdgpu:fix gpu recover missing skipping(v2)
      drm/amdgpu:cleanup stolen vga memory finish
      drm/amdgpu:cleanup GMC & gart garbage function
      drm/amdgpu:fix NULL pointer access during drv remove
      drm/amdgpu:cleanup unused stack var
      drm/amdgpu:free CSA in unified place
      drm/amdgpu:cleanup firmware.fw_buf alloc/free
      drm/amdgpu:show error message if fail on event4
      drm/amdgpu:fix virtual dce bug
      drm/amdgpu:cancel timer of virtual DCE(v2)
      drm/amdgpu:partially revert 1cfd8e237f0318e330190ac21d63c58ae6a1f66c
      drm/ttm: fix incorrect calculate on shrink_pages
      drm/ttm: max_cpages is in unit of native page
      drm/amdgpu: no need to evict VRAM in device_fini
      drm/amdgpu: no need with INT for fence polling
      drm/amdgpu: fix MAP_QUEUES paramter

Neil Armstrong (4):
      dt-bindings: display: amlogic, meson-vpu: Add optional power
domain property
      dt-bindings: display: amlogic, meson-dw-hdmi: Add optional HDMI
5V regulator
      drm/meson: dw_hdmi: Add support for an optional external 5V regul

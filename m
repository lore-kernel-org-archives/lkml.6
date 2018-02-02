Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755176AbeBBCWc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 21:22:32 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:44864 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754363AbeBBCWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 21:22:24 -0500
X-Google-Smtp-Source: AH8x226Dghfzce6wzIaP35Dd2cpG4f94hOWhK83CkVps6KwK2bdtkXaOFTPaRC7YZ63jrHViXfFHP8E0oTavhHLjSuU=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzZiPJEoOViZh4hdKC=y9iEv8xAU_aCE2SxBqENZNO9_w@mail.gmail.com>
References: <CAPM=9tzdZucx_zkMESOfTV5tp9tP+g_tVkCmcQ7R9vYLaXq3Gw@mail.gmail.com>
 <CA+55aFzZiPJEoOViZh4hdKC=y9iEv8xAU_aCE2SxBqENZNO9_w@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 2 Feb 2018 12:22:18 +1000
Message-ID: <CAPM=9twxZtrNO8r_cQtXrMjkZ1jfvRD_3-dVPXAkLObE99DBFg@mail.gmail.com>
Subject: Re: [git pull] drm pull for v4.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w122Mnif007851

On 2 February 2018 at 11:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Feb 1, 2018 at 4:40 PM, Dave Airlie <airlied@gmail.com> wrote:
>>
>> This seems to have been a comparatively quieter merge window, I assume
>> due to holidays etc.
>
> Hmm. I pulled, and then noticed that there's no diffstat to compare my
> end result with.
>
> Then I was going to at least compare the shortlog, but that is truncated too!
>
> Oh well. The part of the shortlog I can see in your email does match,
> and the end result looks sane, so I'll take it on faith, but I really
> would like to see the real full pull request, not this truncated
> half-thing.

Turned out I was running on wayland instead of X.org and my cut-n-paste from
gedit to firefox got truncated, wierd. I'll go annoy some people, and make sure
it doesn't happen again.

Here's the full pull req:

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

Regards,
Dave.

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
      drm/meson: dw_hdmi: Add support for an optional external 5V regulator
      drm/meson: Add missing VPU init

Nicolas Dechesne (2):
      drm/msm: update adreno firmware path in MODULE_FIRMWARE
      drm/msm: add missing MODULE_FIRMWARE declarations

Noralf Trønnes (53):
      drm/gem: Remove trailing whitespace
      drm/fb-helper: Handle function NULL argument
      drm: Add drm_device->fb_helper pointer
      drm/fb-helper: Add .last_close and .output_poll_changed helpers
      drm/vma-manager: drm_vma_node_start() constify argument
      drm/framebuffer: drm_framebuffer_read_refcount() constify argument
      drm/print: Add drm_printf_indent()
      drm/framebuffer: Add framebuffer debugfs file
      drm/atomic: Use drm_framebuffer_print_info()
      drm/cma-helper: Turn to_drm_gem_cma_obj() into a macro
      drm/cma-helper: Add drm_gem_cma_print_info()
      drm/arc: Use drm_gem_cma_print_info()
      drm/arm/hdlcd: Use drm_gem_cma_print_info()
      drm/tilcdc: Use drm_gem_cma_print_info()
      drm/tinydrm: Use drm_gem_cma_print_info()
      drm/cma-helper: Remove drm_fb_cma_debugfs_show()
      drm/debugfs: Fix framebuffer debugfs file init
      drm/probe-helper: Fix drm_kms_helper_poll_enable() docs
      drm/modeset-helper: Add simple modeset suspend/resume helpers
      drm/arm/mali: Use drm_mode_config_helper_suspend/resume()
      drm/tinydrm: Use drm_mode_config_helper_suspend/resume()
      drm/docs: Add todo entry for simple modeset suspend/resume
      drm/fsl-dcu: Use drm_mode_config_helper_suspend/resume()
      drm/amd/display: Use drm_fb_helper_poll_changed()
      drm/amdgpu: Use drm_fb_helper_lastclose() and _poll_changed()
      drm/radeon: Use drm_fb_helper_lastclose() and _poll_changed()
      drm/armada: Use drm_fb_helper_lastclose() and _poll_changed()
      drm/exynos: Use drm_fb_helper_lastclose() and _poll_changed()
      drm/gma500: Use drm_fb_helper_lastclose() and _poll_changed()
      drm/msm: Use drm_fb_helper_lastclose() and _poll_changed()
      drm/nouveau: Use drm_fb_helper_output_poll_changed()
      drm/omap: Use drm_fb_helper_lastclose() and _poll_changed()
      drm/rockchip: Use drm_fb_helper_lastclose() and _poll_changed()
      drm/tegra: Use drm_fb_helper_lastclose() and _poll_changed()
      drm/gem-fb-helper: drm_gem_fbdev_fb_create() make funcs optional
      drm/cma-helper: Add drm_fb_cma_fbdev_init/fini()
      drm/atmel-hlcdc: Use drm_fb_cma_fbdev_init/fini()
      drm/imx: Use drm_fb_cma_fbdev_init/fini()
      drm/pl111: Use drm_fb_cma_fbdev_init/fini()
      drm/sti: Use drm_fb_cma_fbdev_init/fini()
      drm/stm: Use drm_fb_cma_fbdev_init/fini()
      drm/sun4i: Use drm_fb_cma_fbdev_init/fini()
      drm/tilcdc: Use drm_fb_cma_fbdev_init/fini()
      drm/tve200: Use drm_fb_cma_fbdev_init/fini()
      drm/vc4: Use drm_fb_cma_fbdev_init/fini()
      drm/zte: Use drm_fb_cma_fbdev_init/fini()
      drm/arm/mali: Use drm_fb_cma_fbdev_init/fini()
      drm/tinydrm: Use drm_fb_cma_fbdev_init_with_funcs/fini()
      drm/fb-helper: Set/clear dev->fb_helper in dummy init/fini
      drm/fb-helper: Add drm_fb_helper_fbdev_setup/teardown()
      drm/docs: Add todo entry for drm_fb_helper_fbdev_setup()
      drm/fb-helper: Update DOC with new helpers
      drm/fb-helper: Add drm_fb_helper_defio_init()

Oded Gabbay (1):
      drm/amdkfd: add ull suffix to 64bit defines

Oscar Mateo (1):
      drm/i915: Remove Gen9 WAs with no effect

Pan Bian (1):
      gma500: mmu: unmap the correct address

Pei Zhang (2):
      drm/i915/gvt/kvmgt: fill info for ROM/VGA region
      drm/i915/gvt: refine function emulate_mmio_read/write

Peter Ujfalusi (7):
      dt-bindings: display/ti: Add optional property to set memory
bandwidth limit
      drm/omap: dss: Add support for reporting memory bandwidth limitation
      drm/omap: Filter displays mode based on bandwidth limit
      drm/omap: DMM: Fix DMM_IRQSTAT_ERR_MASK definition
      drm/omap: DMM: In case of error/timeout in wait_status() print the reason
      drm/omap: DMM: Print information if we received an error interrupt
      drm/omap: DMM: Check for DMM readiness after successful transaction commit

Philip Cox (3):
      drm/amdgpu: Implement amdgpu SDMA functions for VI
      drm/amdkfd: Implement amdkfd SDMA functions for VI
      drm/amdkfd: Fixup incorrect info in the CZ CRAT table

Philip Yang (1):
      drm/amdkfd: Add crash protection in debugger register path

Philipp Zabel (2):
      drm/etnaviv: make THERMAL selectable
      gpu: ipu-v3: allow to build with COMPILE_TEST

Philippe CORNU (4):
      drm/stm: dsi: Rename driver name
      drm/stm: checkpatch strict minor updates
      dt-bindings: display: stm32: add a 2nd endpoint
      drm/stm: ltdc: add a 2nd endpoint

Piotr Redlewski (1):
      drm/amd/amdgpu: fix UVD mc offsets

Pixel Ding (2):
      drm/amdgpu: revise retry init to fully cleanup driver
      drm/amdgpu: use polling mem to set SDMA3 wptr for VF

Prakash Kamliya (1):
      drm/msm: fix leak in failed get_pages

Radhakrishna Sripada (1):
      Revert "drm/i915: Display WA #1133 WaFbcSkipSegments:cnl, glk"

Rafael Antognolli (3):
      drm/i915: Implement ReadHitWriteOnlyDisable.
      drm/i915: Implement WaDisableVFclkgate.
      drm/i915: Implement WaDisableEarlyEOT.

Randy Dunlap (1):
      documentation/gpu/i915: fix docs build error after file rename

Ray Strode (2):
      drm/qxl: unref cursor bo when finished with it
      drm/qxl: reapply cursor after resetting primary

Rex Zhu (20):
      drm/amdgpu: move DC and PP shared data structures to dm_pp_interface.h
      drm/amd/powerplay: move functions to amd_pm_funcs table
      drm/amdgpu: move struct amd_powerplay to amdgpu.h
      drm/amdgpu: add header kgd_pp_interface.h
      drm/amdgpu: add new pp function point notify_smu_memory_info
      drm/amd/pp: implement notify_smu_memory_info on Powerplay
      drm/amd/pp: delete an outdated comment in amd_powerplay.c
      drm/amdgpu: delete duplicated code.
      drm/amd/pp: implement dpm_get_sclk/mclk for RV
      drm/amd/pp: reset dpm level when adjust power state
      drm/amd/pp: delete dead code of arbiter overdriver clk
      drm/amd/pp: implement phm_reset_power_profile_state
      drm/amd/pp: delete repeated call of force_dpm_level
      drm/amd/pp: export more smu message on Rv
      drm/amd/pp: Move smu_version to common code
      drm/amd/pp: update smu_version value for CI/VI
      drm/amd/pp: Get and save Rv smu version
      drm/amd/pp: Implement force_dpm_level on Rv
      drm/amd/pp: Get and save CZ/ST smu version
      drm/amd/pp: Implement get_max_high_clocks for CI/VI

Rob Clark (1):
      drm/msm: free kstrdup'd cmdline

Rodrigo Vivi (26):
      drm/i915/cnl: Force DDI_A_4_LANES when needed.
      drm/i915/cnl: Get RC6 working.
      drm/i915/cnl: Allow 2 pixel per clock on Cannonlake.
      drm/i915/cnl: Fix SSEU Device Status.
      drm/i915: Update DRIVER_DATE to 20171109
      drm/i915: Update DRIVER_DATE to 20171109
      Merge airlied/drm-next into drm-intel-next-queued
      drm/i915: Display WA #1185 WaDisableDARBFClkGating:cnl, glk
      drm/i915/cnl: Remove spurious central_freq.
      drm/i915/cnl: Remove useless conversion.
      drm/i915/cnl: Fix, simplify and unify wrpll variable sizes.
      drm/i915/cnl: Fix wrpll math for higher freqs.
      drm/i915/cnl: Don't blindly replace qdiv.
      drm/i915/cnl: Simplify dco_fraction calculation.
      drm/i915/cnl: Extend HDMI 2.0 support to CNL.
      Merge tag 'gvt-next-2017-11-16' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20171117
      drm/i915: Update DRIVER_DATE to 20171201
      Merge tag 'gvt-next-2017-12-05' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      Merge airlied/drm-next into drm-intel-next-queued
      Merge tag 'gvt-next-2017-12-14' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20171214
      drm/i915: Protect DDI port to DPLL map from theoretical race.
      drm/i915/cfl: Adding more Coffee Lake PCI IDs.
      Merge tag 'gvt-next-2017-12-22' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20171222

Roger He (22):
      drm/amd/amdgpu: not allow gtt size exceed 75%*system memory size
      drm/ttm: use NUM_PAGES_TO_ALLOC always
      drm/ttm: add page order in page pool
      drm/ttm: add set_pages_wb for handling page order more than zero
      drm/ttm: add page order support in ttm_pages_put
      drm/ttm: roundup the shrink request to prevent skip huge pool
      drm/amd/amdgpu: set gtt size according to system memory size only
      drm/ttm: init locked again to prevent incorrect unlock
      drm/ttm: add allow_reserved_eviction and resv into ttm_operation_ctx
      drm/amdgpu: set allow_reserved_eviction and resv when bo allocation and cs
      drm/ttm: enable eviction for Per-VM-BO
      drm/ttm: use an ttm operation ctx for ttm_bo_move_xxx
      drm/ttm: call ttm_bo_swapout directly when ttm shrink
      drm/ttm: use an operation ctx for ttm_mem_global_alloc
      drm/ttm: use an operation ctx for ttm_mem_global_alloc_page
      drm/ttm: use an operation ctx for ttm_tt_populate in ttm_bo_driver (v2)
      drm/ttm: use an operation ctx for ttm_tt_bind
      drm/ttm: add new function to check if bo is allowable to evict or swapout
      drm/ttm: enable swapout for reserved BOs during allocation
      drm/ttm: check the return value of register_shrinker
      drm/ttm: only free pages rather than update global memory count together
      drm/ttm: add VADDR_FLAG_UPDATED_COUNT to correctly update
dma_page global count

Roman Li (1):
      drm/amd/display: Fix unbalanced locking in surface apply

Russell King (24):
      drm/armada: remove armada_drm_plane_work_cancel() return value
      drm/armada: add a common frame work allocator
      drm/armada: store plane in armada_plane_work
      drm/armada: add work cancel callback
      drm/armada: wait and cancel any pending frame work at disable
      drm/armada: allow the primary plane to be disabled
      drm/armada: clean up armada_drm_crtc_plane_disable()
      drm/armada: clear plane enable bit when disabling
      drm/armada: move overlay plane work out from under spinlock
      drm/armada: move fb retirement into armada_plane_work
      drm/armada: move event sending into armada_plane_work
      drm/armada: move regs into armada_plane_work
      drm/armada: move writes of LCD_SPU_SRAM_PARA1 under lock
      drm/armada: only enable HSMOOTH if scaling horizontally
      drm/armada: use drm_plane_helper_check_state()
      drm/armada: allow armada_drm_plane_work_queue() to silently fail
      drm/armada: avoid work allocation
      drm/armada: disable planes at next blanking period
      drm/armada: re-organise overlay register update generation
      drm/armada: move overlay plane register update generation
      drm/armada: wait for previous work when moving overlay window
      drm/armada: extract register generation from armada_drm_primary_set()
      drm/armada: implement primary plane update
      drm/armada: expand overlay trace entry

Sagar Arun Kamble (9):
      drm/i915: Update execlists tasklet naming
      drm/i915/guc: Update names of submission related static functions
      drm/i915/guc: Update name and prototype of GuC submission
interface functions
      drm/i915/guc: Rename i915_guc_client struct to intel_guc_client
      drm/i915/guc: Rename i915_guc_submission.c|h to intel_guc_submission.c|h
      drm/i915/guc: Update header guard name of intel_guc_submission.h
      drm/i915/guc: Change default GuC FW for SKL to v9.33
      drm/i915/guc: Change default GuC FW for BXT to v9.29
      drm/i915/guc: Change default GuC FW for KBL to v9.39

Sandy Huang (2):
      dt-bindings: add document for rk3126-vop
      drm/rockchip: vop: add rk3126 vop support

Sean Paul (1):
      drm/rockchip: Fix build warning in analogix_dp-rockchip.c

Sebastian Andrzej Siewior (1):
      drm/i915: properly init lockdep class

Sebastian Reichel (7):
      drm/omap: remove unused function defines
      drm/omap: drop incorrect comment
      drm/omap: add support for physical size hints from display drivers
      drm/omap: panel-dsi-cm: add regulator support
      drm/omap: panel-dsi-cm: add physical size support
      drm/omap: panel-dsi-cm: add external backlight support
      drm/omap: panel-dsi-cm: switch to gpiod

Shaoyun Liu (5):
      drm/amdgpu: Dynamic initialize IP base offset
      drm/amdgpu: Use dynamic IP offset for register access on SOC15
      drm/amdgpu: Avoid use SOC15_REG_OFFSET in static const array
      drm/amdgpu: Change SOC15_REG_OFFSET to use dynamic register offset
      drm/admgpu: Reduce the usage of soc15ip.h

Shirish S (2):
      drm/amd/display: fix static checker warning
      drm/amd/display: remove usage of legacy_cursor_update

Shuo Liu (1):
      drm/i915/gvt: Use dyndbg for gvt debug info

SivapiriyanKumarasamy (2):
      drm/amd/display: Apply VQ adjustments in MPO case
      drm/amd/display: Add transfer function to dc_surface_update

Tan Xiaojun (12):
      drm/ttm: add ttm_bo_io_mem_pfn to check io_mem_pfn
      drm/ast: remove the default io_mem_pfn set
      drm/bochs: remove the default io_mem_pfn set
      drm/cirrus: remove the default io_mem_pfn set
      drm/mgag200: remove the default io_mem_pfn set
      drm/nouveau: remove the default io_mem_pfn set
      drm/qxl: remove the default io_mem_pfn set
      drm/radeon: remove the default io_mem_pfn set
      drm/virtio: remove the default io_mem_pfn set
      drm/vmwgfx: remove the default io_mem_pfn set
      staging: remove the default io_mem_pfn set
      drm/ttm: remove ttm_bo_default_io_mem_pfn

Thierry Reding (47):
      drm/fourcc: Fix fourcc_mod_code() definition
      drm/tegra: Sanitize format modifiers
      gpu: host1x: Rewrite conditional for better readability
      gpu: host1x: Cleanup on initialization failure
      dt-bindings: display: tegra: Update SOR for Tegra186
      drm/tegra: dc: Move register definitions into a table
      drm/tegra: dsi: Move register definitions into a table
      drm/tegra: hdmi: Move register definitions into a table
      drm/tegra: sor: Move register definitions into a table
      drm/tegra: dc: Reshuffle some code
      drm/tegra: dc: Register debugfs in ->late_register()
      drm/tegra: dsi: Register debugfs in ->late_register()
      drm/tegra: hdmi: Register debugfs in ->late_register()
      drm/tegra: sor: Root debugfs files at the connector
      drm/tegra: sor: Register debugfs in ->late_register()
      drm/tegra: Do not wrap lines unnecessarily
      drm/tegra: vic: Properly align arguments
      drm/tegra: dc: Support background color
      drm/tegra: Use atomic commit helpers
      drm/tegra: Remove custom page-flip handler
      drm/tegra: dc: Remove tegra_primary_plane_destroy()
      drm/tegra: dc: Remove duplicate plane funcs
      drm/tegra: dc: Remove tegra_overlay_plane_destroy()
      drm/tegra: dc: Remove duplicate plane funcs
      drm/tegra: dc: Move state definition to header
      drm/tegra: Move common plane code to separate file
      drm/tegra: Add Tegra186 display hub support
      drm/tegra: dc: Add Tegra186 support
      drm/tegra: Support ARGB and ABGR formats
      drm/tegra: sor: Parameterize register offsets
      drm/tegra: sor: Add Tegra186 support
      drm/tegra: sor: Support HDMI 2.0 modes
      drm/tegra: dpaux: Implement runtime PM
      drm/tegra: dpaux: Add Tegra186 support
      drm/tegra: fb: Force alpha formats
      drm/atomic-helper: Make zpos property kerneldoc less misleading
      drm/tegra: dc: Support more formats
      drm/tegra: dc: Use direct offset to plane registers
      drm/tegra: dc: Remove redundant spinlock
      drm/tegra: Implement zpos property
      gpu: host1x: Use IOMMU groups
      drm/tegra: Use IOMMU groups
      drm/tegra: dpaux: Keep reset defaults for hybrid pad parameters
      drm/tegra: dc: Implement legacy blending
      drm/tegra: dc: Restore YUV overlay support
      drm/tegra: dc: Fix possible_crtcs mask for planes
      drm/tegra: dc: Properly cleanup overlay planes

Tina Zhang (10):
      drm/i915: Object w/o backing storage is banned by -ENXIO
      drm/i915: Introduce GEM proxy
      drm/i915/gvt: Add opregion support
      drm/i915/gvt: Add framebuffer decoder support
      vfio: ABI for mdev display dma-buf operation
      drm/i915/gvt: Dmabuf support for GVT-g
      drm/i915/gvt: Handle orphan dmabuf_objs
      drm/i915/gvt: Introduce KBL to dma-buf on Gvt-g
      drm/i915/gvt: Free dmabuf_obj list in intel_vgpu_dmabuf_cleanup
      drm/i915/gvt: Refine dmabuf_obj cleanup process

Tony Cheng (23):
      drm/amd/display: dal 3.1.08
      drm/amd/display: dal 3.1.09
      drm/amd/display: dal 3.1.10
      drm/amd/display: dal 3.1.11
      drm/amd/display: dal 3.1.12
      drm/amd/display: dal 3.1.13
      drm/amd/display: dal 3.1.14
      drm/amd/display: dal 3.1.15
      drm/amd/display: dal 3.1.16
      drm/amd/display: fix plane update prior to stream enablement
      drm/amd/display: remove stream_func vtable
      drm/amd/display: performance profiling instrumentation
      drm/amd/display: dal 3.1.17
      drm/amd/display: dal 3.1.18
      drm/amd/display: dal 3.1.19
      drm/amd/display: dal 3.1.20
      drm/amd/display: dal 3.1.21
      drm/amd/display: dal 3.1.22
      drm/amd/display: dal 3.1.23
      drm/amd/display: Set mpcc_disconnect_pending during MPC reset
      drm/amd/display: dal 3.1.24
      drm/amd/display: really fix time out in init sequence
      drm/amd/display: dal 3.1.25

Tony Lindgren (1):
      drm/omap: panel-dsi-cm: fix driver

Tvrtko Ursulin (21):
      drm/i915: Reject unknown syncobj flags
      drm/i915: Warn in debug builds of incorrect usages of ptr_pack_bits
      drm/i915: Define an engine class enum for the uABI
      drm/i915: Extract intel_get_cagf
      drm/i915/pmu: Expose a PMU interface for perf queries
      drm/i915/pmu: Suspend sampling when GPU is idle
      drm/i915: Wrap context schedule notification
      drm/i915: Engine busy time tracking
      drm/i915/pmu: Wire up engine busy stats to PMU
      drm/i915/pmu: Add interrupt count metric
      drm/i915: Convert intel_rc6_residency_us to ns
      drm/i915/pmu: Add RC6 residency metrics
      drm/i915/pmu: Drop I915_ENGINE_SAMPLE_MAX from uapi headers
      drm/i915/pmu: Clear the previous sample value when parking
      drm/i915/pmu: Only allow running on a single CPU
      drm/i915/pmu: Stop averaging with the previous sample
      drm/i915/pmu: Aggregate all RC6 states into one counter
      drm/i915/pmu: Return -EINVAL when selecting the inactive CPU
      drm/i915: Move engine->needs_cmd_parser to engine->flags
      drm/i915: Consolidate checks for engine stats availability
      drm/i915: Restore GT performance in headless mode with DMC loaded

Valtteri Rantala (1):
      drm/i915/glk: Apply WaProgramL3SqcReg1DefaultForPerf for GLK too

Vasyl Gomonovych (1):
      dma-buf: Fix ifnullfree.cocci warnings

Ville Syrjälä (84):
      drm/i915: Clean up some cdclk switch statements
      drm/i915: Start tracking voltage level in the cdclk state
      drm/i915: Use cdclk_state->voltage on VLV/CHV
      drm/i915: Use cdclk_state->voltage on BDW
      drm/i915: Use cdclk_state->voltage on SKL/KBL/CFL
      drm/i915: Use cdclk_state->voltage on BXT/GLK
      drm/i915: Use cdclk_state->voltage on CNL
      drm/i915: Adjust system agent voltage on CNL if required by DDI ports
      drm/i915: Sanity check cdclk in vlv_set_cdclk()
      drm/i915: Perform a central cdclk state sanity check
      drm/i915: Don't use encoder->type in intel_ddi_set_pipe_settings()
      drm/i915: Pass crtc state to intel_prepare_dp_ddi_buffers()
      drm/i915: Start using output_types for DPLL selection
      drm/i915: Stop using encoder->type in intel_ddi_enable_transcoder_func()
      drm/i915: Fix BXT lane latency optimal setting with MST
      drm/i915: Improve DP downstream HPD handling
      drm/i915: Clean up the mess around hdmi_12bpc_possible()
      drm/i915/vbt: Fix HDMI level shifter and max data rate bitfield sizes
      drm/i915: Parse max HDMI TMDS clock from VBT
      drm/i915: Populate output_types from .get_config()
      drm/i915: Stop frobbing with DDI encoder->type
      drm/i915: Nuke intel_ddi_get_encoder_port()
      drm/i915: Eliminate pll->state usage from bxt_calc_pll_link()
      drm/i915: Pass a crtc state to ddi post_disable from MST code
      drm/i915: Use intel_ddi_get_config() for MST
      drm/i915: Pass around crtc and connector states for audio
      drm/i915: Remove most encoder->type uses from the audio code
      drm: Print the fb dimensions when the src coord check fails
      drm/i915: Move init_clock_gating() back to where it was
      drm/i915: Eliminate some encoder->crtc usage from DP code
      drm/i915: Eliminate some encoder->crtc usage from DSI code
      drm/i915: Eliminate some encoder->crtc usage from SDVO code
      drm/i915: Eliminate some encoder->crtc usage from TV code
      drm/i915: Pass crtc state to DPIO PHY functions
      drm/i915: Eliminate crtc->config usage from CRT code
      drm/i915: Replace dig_port->port with encoder port for BXT DPLL selection
      drm/i915: Nuke intel_digital_port->port
      drm/i915: Clean up PPS code calling conventions
      drm/i915: Clean up DP code local variables and calling conventions
      drm/syncobj: Use proper methods for accessing rcu protected pointers
      dma-buf: Use rcu_assign_pointer() to set rcu protected pointers
      drm: Fix modifiers_property kernel doc
      drm/gem-cma-helper: Fix kerneldocs
      drm: Fix kerneldocs for drm_plane modifiers
      drm/i915: Fix kerneldocs for intel_audio.c
      drm/i915: Check if the stolen memory "reserved" area is enabled or not
      drm/i915: Make the report about a bogus stolen reserved area an error
      drm/i915: Use ELK stolen memory reserved detection for ILK
      drm/i915: Don't sanitize frame start delay if the pipe is off
      drm/i915: Fix init_clock_gating for resume
      drm/vmwgfx: Remove bogus crtc coords vs fb size check
      drm/vmwgfx: Use drm_plane_helper_check_state()
      drm/vmwgfx: Try to fix plane clipping
      drm: Check crtc_state->enable rather than crtc->enabled in
drm_plane_helper_check_state()
      drm: Move drm_plane_helper_check_state() into drm_atomic_helper.c
      drm/i915: Add .get_hw_state() method for planes
      drm/i915: Redo plane sanitation during readout
      drm/i915: s/enum plane/enum i9xx_plane_id/
      drm/i915: Use enum i9xx_plane_id for the .get_fifo_size() hooks
      drm/i915: Cleanup enum pipe/enum plane_id/enum i9xx_plane_id in
initial fb readout
      drm/i915: Nuke ironlake_get_initial_plane_config()
      drm/i915: Switch fbc over to for_each_new_intel_plane_in_state()
      drm/i915: Nuke crtc->plane
      drm/i915: Use plane->get_hw_state() for initial plane fb readout
      drm/i915: Add rudimentary plane state verification
      video/hdmi: Allow "empty" HDMI infoframes
      drm/edid: Allow HDMI infoframe without VIC or S3D
      drm/i915: Don't try indexed reads to alternate slave addresses
      drm/i915: Prevent zero length "index" write
      drm/vblank: Fix vblank timestamp debugs
      drm/i915: Disable DP audio for g4x
      drm/i915: Don't add the "force audio" property to DP connectors
that don't support audio
      drm/i915: Fix has_audio readout for DDI A
      drm/i915: Fix deadlock in i830_disable_pipe()
      drm/i915: Fix vblank timestamp/frame counter jumps on gen2
      drm/i915: Wait for pipe to start on i830 as well
      drm/i915: Pass crtc state to intel_pipe_{enable,disable}()
      drm/i915: Interlaced DP output doesn't work on VLV/CHV
      drm/i915: Disable all planes for load detection, v2.
      drm/i915: Disable DC states around GMBUS on GLK
      drm/i915: No need to power up PG2 for GMBUS on BXT
      drm/i915: Clean up the PNV bit banging vs. GMBUS clock gating w/a
      drm/i915: Disable GMBUS clock gating around GMBUS transfers on gen9+
      drm/i915: Put all non-blocking modesets onto an ordered wq

Vitaly Prosyak (5):
      drm/amd/display: Build unity lut for shaper
      drm/amd/display: Move unity TF type to predefined types
      drm/amd/display: Correct fixed point calculation.
      drm/amd/display: Define BLNDGAM_CONFIG_STATUS
      drm/amd/display: Declare and share color space types for dcn's

Weinan Li (5):
      drm/i915/gvt: update CSB and CSB write pointer in virtual HWSP
      drm/i915/gvt: refine trace_render_mmio
      drm/i915/gvt: optimize for vGPU mmio switch
      drm/i915/gvt: refine mocs save restore policy
      drm/i915/gvt: load host render mocs once in mocs switch

Xiangliang.Yu (1):
      drm/amdgpu/gfx8: Fix compute ring failure after resetting

Xiaolin Zhang (3):
      drm/i915/gvt: Add support for opregion virtualization
      drm/i915/gvt: opregion virtualization for win guest
      drm/i915/gvt: Fix pipe A enable as default for vgpu

Xiong Zhang (3):
      drm/i915/gvt: Limit read hw reg to active vgpu
      drm/i915/gvt: Let each vgpu has separate opregion memory
      drm/i915/gvt: Alloc and Init guest opregion at vgpu creation

Xiongwei Song (1):
      drm/tilcdc: make tilcdc_mode_hvtotal() static

Yintian Tao (1):
      drm/amd/powerplay: fix memory leakage when reload (v2)

Yong Zhao (6):
      drm/amdkfd: Delete a useless parameter from create_queue function pointer
      drm/amdkfd: Return NULL if kfd_lookup_process_by_pasid fails
      drm/amdkfd: Simplify locking during process creation
      drm/amdkfd: Fix memory leaks in kfd topology
      drm/amdkfd: Fix return value 0 when execute_queues_cpsch fails
      drm/amdkfd: don't always call execute_queues_cpsch()

Yongqiang Sun (28):
      drm/amd/display: Move lock to front end program.
      drm/amd/display: Check cursor address before program.
      drm/amd/display: Set cursor position as per address.
      drm/amd/display: Power down front end in init_hw.
      drm/amd/display: Not reset front end when program back end.
      drm/amd/display: Added disconnect dchub.
      drm/amd/display: Enalbe blank data double buffer after mpc disconnected.
      drm/amd/display: Add tg_init interface.
      drm/amd/display: Refactor disable front end pipes.
      drm/amd/display: Modified front end initiail in init_hw
      drm/amd/display: Fixed not set scaler bug.
      drm/amd/display: Apply work around for stutter.
      drm/amd/display: Optimize programming front end
      drm/amd/display: Optimize front end programming.
      drm/amd/display: Move update_plane_addr to apply_ctx_for_surface for dce.
      drm/amd/display: Update dchub and dpp as per update flags.
      drm/amd/display: Only update output transfer function for full type.
      drm/amd/display: Only program watermark for full update.
      drm/amd/display: Remove unnecessary wait mpcc idle.
      drm/amd/display: Fixed read wrong reg to get bot_sel.
      drm/amd/display: Use same wait mpcc idle function.
      drm/amd/display: Implement work around for optc underflow.
      drm/amd/display: Disable plane right after disconnected
      drm/amd/display: fix recout_skip calculation when rotating 180 or 270
      drm/amd/display: Program cursor regs after context swapped.
      drm/amd/display: Cache cursor position.
      drm/amd/display: Move wait for hpd ready out from edp power control.
      drm/amd/display: Add hdr_supported flag

Yue Hin Lau (23):
      drm/amd/display: cleaning up hubp for dcn
      drm/amd/display: create new files for hubbub functions
      drm/amd/display: create new structure for hubbub
      drm/amd/display: fix bug from last commit for hubbub
      drm/amd/display: create new function prototype update_dchub for dcn
      drm/amd/display: function renaming for hubbub
      drm/amd/display: hubbub function flipping true and false
      drm/amd/display: Only update dchub if hubbub is available
      drm/amd/display: call set csc_default if enable adjustment is false
      drm/amd/display: renaming dpp function to follow naming convention
      drm/amd/display: call set_mpc_output_csc from hwsequencer
      drm/amd/display: fix opp header register define
      drm/amd/display: update output csc matrix values
      drm/amd/display: move csc matrix to hw_shared
      drm/amd/display: CNVC pseudocode review follow up
      drm/amd/display: dpp clean up
      drm/amd/display: OPTC cleanup/implementation
      drm/amd/display: remove format_control from set_cursor_attributes
      drm/amd/display: integrating optc pseudocode
      drm/amd/display: hubp refactor
      drm/amd/display: Only blank DCN when we have set_blank implementation
      drm/amd/display: check for null before calling is_blanked
      drm/amd/display: Expose dpp1_set_cursor_attributes

Zhenyu Wang (8):
      MAINTAINERS: Update gvt-linux.git new repo place
      Revert "drm/i915/gvt: Refine broken PPGTT scratch"
      drm/i915/gvt: Don't mark vgpu context as inactive when preempted
      drm/i915/gvt: set max priority for gvt context
      Merge tag 'drm-intel-next-2017-12-14' into gvt-next
      drm/i915/gvt: always use i915_reg_t for MMIO handler definition
      drm/i915/gvt: cleanup usage for typed mmio reg vs. offset
      drm/i915/gvt: move write protect handler out of mmio emulation function

Zhi Wang (28):
      drm/i915/gvt: Make elsp_dwords in the right order
      drm/i915/gvt: Rename intel_vgpu_{init, clean}_gvt_context()
      drm/i915/gvt: Move workload cache init/clean into
intel_vgpu_{setup, clean}_submission()
      drm/i915/gvt: Introduce intel_vgpu_submission
      drm/i915/gvt: Move tlb_handle_pending into intel_vgpu_submission
      drm/i915/gvt: Fix a memory leak in cmd_parser.c
      drm/i915/gvt: Rename reserved ring buffer
      drm/i915/gvt: Move ring scan buffers into intel_vgpu_submission
      drm/i915/gvt: Do not allocate initial ring scan buffer
      drm/i915/gvt: Factor out vGPU workload creation/destroy
      drm/i915/gvt: Factor out prepare_workload()
      drm/i915/gvt: Move common workload preparation into prepare_workload()
      drm/i915/gvt: Move common vGPU workload creation into scheduler.c
      drm/i915/gvt: Remove one extra declaration in scheduler.h
      drm/i915/gvt: Introduce vGPU submission ops
      drm/i915/gvt: Introduce intel_vgpu_reset_submission
      drm/i915/gvt: Move clean_workloads() into scheduler.c
      drm/i915/gvt: Use BIT() to make klockwork happy
      drm/i915/gvt: Refine find_bb_size()
      drm/i915/gvt: Refine shadow batch buffer
      drm/i915/gvt: Factor intel_vgpu_page_track
      drm/i915/gvt: Export intel_gvt_render_mmio_to_ring_id()
      drm/i915/gvt: Use I915_GTT_PAGE_SIZE
      drm/i915/gvt: Let the caller choose if a shadow page should be
put into hash table
      drm/i915/gvt: Fix a bug of unexpectedly clear scratch page table
      drm/i915/gvt: Introduce page table type of current level in GTT
type enumerations
      drm/i915/gvt: Introduce ops->set_present()
      drm/i915/gvt: Refine broken PPGTT scratch

fred gao (6):
      drm/i915/gvt: Change the return type during command scan
      drm/i915/gvt: Add VM healthy check for workload_thread
      drm/i915/gvt: Add VM healthy check for submit_context
      drm/i915/gvt: Move vGPU type related code into gvt file
      drm/i915/gvt: Refactor vGPU type code in kvmgt part
      drm/i915/gvt: Move request alloc to dispatch_workload path only

pding (11):
      drm/amdgpu: change redundant init logs to debug level
      drm/amdgpu: avoid soft lockup when waiting for RLC serdes (v2)
      drm/amdgpu/virt: add function to check MMIO (v2)
      drm/amdgpu/virt: add wait_reset virt ops
      drm/amdgpu/virt: implement wait_reset callbacks for vi/ai
      drm/amdgpu: retry init if it fails due to exclusive mode timeout (v3)
      drm/amdgpu: return error when sriov access requests get timeout
      drm/amdgpu: retry init if exclusive mode request is failed
      drm/amdkfd: initialise kfd inside amdgpu_device_init
      drm/amdgpu: release exclusive mode after hw_init
      drm/amdgpu: bypass FB resizing for SRIOV VF

 .../bindings/display/amlogic,meson-dw-hdmi.txt     |     4 +
 .../bindings/display/amlogic,meson-vpu.txt         |     4 +
 .../devicetree/bindings/display/ilitek,ili9225.txt |    25 +
 .../bindings/display/panel/ilitek,ili9322.txt      |    49 +
 .../display/panel/mitsubishi,aa070mc01.txt         |     7 +
 .../bindings/display/panel/panel-common.txt        |    10 +
 .../bindings/display/panel/panel-lvds.txt          |     1 +
 .../bindings/display/panel/simple-panel.txt        |     2 +-
 .../bindings/display/panel/tianma,tm070rvhg71.txt  |    29 +
 .../{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} |     4 +-
 .../devicetree/bindings/display/renesas,du.txt     |    30 +-
 .../bindings/display/rockchip/rockchip-vop.txt     |     1 +
 .../bindings/display/sitronix,st7735r.txt          |    35 +
 .../devicetree/bindings/display/st,stm32-ltdc.txt  |     6 +-
 .../bindings/display/sunxi/sun4i-drm.txt           |    11 +
 .../display/tegra/nvidia,tegra20-host1x.txt        |    14 +-
 .../devicetree/bindings/display/ti/ti,dra7-dss.txt |     5 +
 .../bindings/display/ti/ti,omap2-dss.txt           |     4 +
 .../bindings/display/ti/ti,omap3-dss.txt           |     4 +
 .../bindings/display/ti/ti,omap4-dss.txt           |     4 +
 .../bindings/display/ti/ti,omap5-dss.txt           |     4 +
 .../devicetree/bindings/vendor-prefixes.txt        |     3 +
 Documentation/gpu/drm-kms-helpers.rst              |    39 +-
 Documentation/gpu/drm-kms.rst                      |    14 +-
 Documentation/gpu/i915.rst                         |     4 +-
 Documentation/gpu/todo.rst                         |    41 +-
 MAINTAINERS                                        |    29 +-
 arch/x86/include/asm/iosf_mbi.h                    |    25 +
 arch/x86/kernel/early-quirks.c                     |    87 +-
 arch/x86/platform/intel/iosf_mbi.c                 |    19 +-
 drivers/base/Kconfig                               |     1 +
 drivers/char/agp/intel-gtt.c                       |    16 +-
 drivers/dma-buf/dma-buf.c                          |     9 +-
 drivers/dma-buf/dma-fence-array.c                  |    14 +-
 drivers/dma-buf/reservation.c                      |    66 +-
 drivers/gpu/drm/Kconfig                            |    10 +
 drivers/gpu/drm/Makefile                           |     2 +
 drivers/gpu/drm/amd/amdgpu/Makefile                |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   227 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   102 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   115 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |   188 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   266 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h       |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |    57 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |     1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    79 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |    82 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   792 +
 .../grph_object_id.c => amdgpu/amdgpu_debugfs.h}   |    73 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  1916 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h        |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |    27 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    67 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    75 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h           |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |    59 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |   459 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |    91 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |    72 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |     7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   107 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |    19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_queue_mgr.c      |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h          |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |    37 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h           |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |    28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   287 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |    45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |    42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   134 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  1024 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    96 +-
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c          |    11 +-
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |    24 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |   212 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |     2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    28 +-
 drivers/gpu/drm/amd/amdgpu/cikd.h                  |     2 +-
 drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h       |     8 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |     2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    36 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |    42 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |    12 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |    12 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |    14 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |    38 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |    54 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   221 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   329 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |    51 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |    35 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |    49 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |    91 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   369 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |     8 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |    63 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |    28 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c              |    64 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |   125 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.h             |    26 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |   159 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.h             |    22 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |    16 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |    20 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |    42 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |   117 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   304 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |   156 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    30 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |    15 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |     2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   278 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h                 |    20 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |    62 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |     6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |     6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |    61 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |   112 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |    10 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |    74 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |    88 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |    67 +-
 drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c       |    56 +
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   186 +-
 drivers/gpu/drm/amd/amdgpu/vid.h                   |     2 +
 drivers/gpu/drm/amd/amdkfd/Makefile                |     4 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm  |  1384 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |    46 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |  1267 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h              |    42 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c            |    14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c           |    75 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    31 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   124 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |     9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |    14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |     7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |     2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |    17 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |     4 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |    48 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   167 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |    59 +-
 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c             |     2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    83 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   267 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    78 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  1061 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |    33 +-
 drivers/gpu/drm/amd/display/TODO                   |     3 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   303 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    12 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |     9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |     7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |    33 +-
 drivers/gpu/drm/amd/display/dc/basics/Makefile     |     2 +-
 drivers/gpu/drm/amd/display/dc/basics/conversion.c |     2 +-
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c |    28 +
 .../gpu/drm/amd/display/dc/basics/log_helpers.c    |    10 +-
 drivers/gpu/drm/amd/display/dc/basics/logger.c     |    22 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |    60 +-
 .../gpu/drm/amd/display/dc/bios/command_table.c    |    21 +
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |    13 +
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |     9 +
 .../gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c   |    17 +-
 .../gpu/drm/amd/display/dc/calcs/dcn_calc_math.c   |    27 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |   148 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   625 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |     4 +
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   145 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   183 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |    19 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |    20 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   151 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    19 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   594 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |    28 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |     7 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    27 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |   207 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   293 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |     6 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |    50 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h       |     8 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c    |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   228 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h      |    15 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |    12 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c       |    33 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |    21 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.h  |     5 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |    34 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |   278 +-
 .../amd/display/dc/dce100/dce100_hw_sequencer.c    |     2 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   373 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.h    |     8 +-
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |    28 +-
 .../amd/display/dc/dce110/dce110_opp_regamma_v.c   |     2 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |     1 +
 .../display/dc/dce110/dce110_timing_generator.c    |   265 +-
 .../display/dc/dce110/dce110_timing_generator.h    |     6 +
 .../amd/display/dc/dce120/dce120_hw_sequencer.c    |     6 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |     8 +-
 .../display/dc/dce120/dce120_timing_generator.c    |     6 +-
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |     2 +
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile      |     5 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |   294 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.h |    10 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |   114 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |   530 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |   221 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  |     8 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |   516 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |   214 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |   116 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |   569 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  2068 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |     1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   529 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h   |    90 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c   |   118 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.h   |   125 +-
 .../{dcn10_timing_generator.c => dcn10_optc.c}     |   439 +-
 .../{dcn10_timing_generator.h => dcn10_optc.h}     |   150 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   133 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h       |     7 +
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |    29 -
 .../drm/amd/display/dc/dml/display_mode_structs.h  |     6 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |   131 +-
 .../drm/amd/display/dc/dml/display_rq_dlg_calc.c   |     9 +
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |     9 +
 .../gpu/drm/amd/display/dc/dml/soc_bounding_box.c  |    10 +
 .../amd/display/dc/gpio/dce120/hw_factory_dce120.c |     6 +-
 .../display/dc/gpio/dce120/hw_translate_dce120.c   |     6 +-
 .../amd/display/dc/gpio/dcn10/hw_factory_dcn10.c   |     6 +-
 .../amd/display/dc/gpio/dcn10/hw_translate_dcn10.c |     6 +-
 .../amd/display/dc/i2caux/dce120/i2caux_dce120.c   |     6 +-
 .../drm/amd/display/dc/i2caux/dcn10/i2caux_dcn10.c |     6 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |     3 +-
 drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h     |     6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h        |    14 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |    21 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |    46 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    19 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |    55 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/ipp.h        |     6 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |     2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |   157 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |    29 +-
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    71 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |     6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |    30 +-
 .../amd/display/dc/irq/dce120/irq_service_dce120.c |     6 +-
 .../amd/display/dc/irq/dcn10/irq_service_dcn10.c   |     6 +-
 drivers/gpu/drm/amd/display/dc/os_types.h          |    14 +-
 .../amd/display/dc/virtual/virtual_link_encoder.c  |     3 +-
 .../drm/amd/display/include/ddc_service_types.h    |    33 -
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |     7 +
 .../gpu/drm/amd/display/include/grph_object_id.h   |    16 +-
 .../gpu/drm/amd/display/include/logger_interface.h |     5 +
 .../drm/amd/display/modules/freesync/freesync.c    |    84 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |   172 -
 .../amd/include/asic_reg/athub/athub_1_0_offset.h  |   453 +
 .../amd/include/asic_reg/athub/athub_1_0_sh_mask.h |  2045 ++
 .../asic_reg/{vega10/DC => dce}/dce_12_0_offset.h  |     0
 .../asic_reg/{vega10/DC => dce}/dce_12_0_sh_mask.h |     0
 .../asic_reg/{raven1/DCN => dcn}/dcn_1_0_offset.h  |     0
 .../asic_reg/{raven1/DCN => dcn}/dcn_1_0_sh_mask.h |     0
 .../asic_reg/{vega10/GC => gc}/gc_9_0_default.h    |     7 -
 .../asic_reg/{vega10/GC => gc}/gc_9_0_offset.h     |    14 -
 .../asic_reg/{vega10/GC => gc}/gc_9_0_sh_mask.h    |    45 -
 .../asic_reg/{raven1/GC => gc}/gc_9_1_offset.h     |    14 -
 .../drm/amd/include/asic_reg/hdp/hdp_4_0_offset.h  |   209 +
 .../drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h |   601 +
 .../{vega10/MMHUB => mmhub}/mmhub_1_0_default.h    |     0
 .../{vega10/MMHUB => mmhub}/mmhub_1_0_offset.h     |     0
 .../{vega10/MMHUB => mmhub}/mmhub_1_0_sh_mask.h    |     0
 .../{raven1/MMHUB => mmhub}/mmhub_9_1_offset.h     |     0
 .../{raven1/MMHUB => mmhub}/mmhub_9_1_sh_mask.h    |     0
 .../asic_reg/{raven1/MP => mp}/mp_10_0_default.h   |     0
 .../asic_reg/{raven1/MP => mp}/mp_10_0_offset.h    |     0
 .../asic_reg/{raven1/MP => mp}/mp_10_0_sh_mask.h   |     0
 .../drm/amd/include/asic_reg/mp/mp_9_0_offset.h    |   375 +
 .../drm/amd/include/asic_reg/mp/mp_9_0_sh_mask.h   |  1463 +
 .../{vega10/NBIF => nbif}/nbif_6_1_offset.h        |     0
 .../{vega10/NBIF => nbif}/nbif_6_1_sh_mask.h       |     0
 .../{vega10/NBIO => nbio}/nbio_6_1_default.h       |     0
 .../{vega10/NBIO => nbio}/nbio_6_1_offset.h        |     0
 .../{vega10/NBIO => nbio}/nbio_6_1_sh_mask.h       |     0
 .../{raven1/NBIO => nbio}/nbio_7_0_default.h       |     0
 .../{raven1/NBIO => nbio}/nbio_7_0_offset.h        |     0
 .../{raven1/NBIO => nbio}/nbio_7_0_sh_mask.h       |     0
 .../{vega10/OSSSYS => oss}/osssys_4_0_offset.h     |     0
 .../{vega10/OSSSYS => oss}/osssys_4_0_sh_mask.h    |     0
 .../include/asic_reg/raven1/DCN/dcn_1_0_default.h  |  7988 -----
 .../include/asic_reg/raven1/GC/gc_9_1_default.h    |  4005 ---
 .../include/asic_reg/raven1/GC/gc_9_1_sh_mask.h    | 31191 -------------------
 .../asic_reg/raven1/MMHUB/mmhub_9_1_default.h      |  1028 -
 .../asic_reg/raven1/SDMA0/sdma0_4_1_sh_mask.h      |  1658 -
 .../include/asic_reg/raven1/VCN/vcn_1_0_default.h  |   202 -
 .../amd/include/asic_reg/sdma0/sdma0_4_0_default.h |   286 +
 .../amd/include/asic_reg/sdma0/sdma0_4_0_offset.h  |   547 +
 .../amd/include/asic_reg/sdma0/sdma0_4_0_sh_mask.h |  1852 ++
 .../{raven1/SDMA0 => sdma0}/sdma0_4_1_default.h    |     0
 .../{raven1/SDMA0 => sdma0}/sdma0_4_1_offset.h     |     0
 .../amd/include/asic_reg/sdma1/sdma1_4_0_default.h |   282 +
 .../amd/include/asic_reg/sdma1/sdma1_4_0_offset.h  |   539 +
 .../amd/include/asic_reg/sdma1/sdma1_4_0_sh_mask.h |  1810 ++
 .../{vega10/SMUIO => smuio}/smuio_9_0_offset.h     |     0
 .../{vega10/SMUIO => smuio}/smuio_9_0_sh_mask.h    |     0
 .../{raven1/THM => thm}/thm_10_0_default.h         |     0
 .../asic_reg/{raven1/THM => thm}/thm_10_0_offset.h |     0
 .../{raven1/THM => thm}/thm_10_0_sh_mask.h         |     0
 .../asic_reg/{vega10/THM => thm}/thm_9_0_default.h |     0
 .../asic_reg/{vega10/THM => thm}/thm_9_0_offset.h  |     0
 .../asic_reg/{vega10/THM => thm}/thm_9_0_sh_mask.h |     0
 .../drm/amd/include/asic_reg/umc/umc_6_0_default.h |    31 +
 .../drm/amd/include/asic_reg/umc/umc_6_0_offset.h  |    52 +
 .../drm/amd/include/asic_reg/umc/umc_6_0_sh_mask.h |    36 +
 .../asic_reg/{vega10/UVD => uvd}/uvd_7_0_offset.h  |     0
 .../asic_reg/{vega10/UVD => uvd}/uvd_7_0_sh_mask.h |     0
 .../asic_reg/{vega10/VCE => vce}/vce_4_0_default.h |     0
 .../asic_reg/{vega10/VCE => vce}/vce_4_0_offset.h  |     0
 .../asic_reg/{vega10/VCE => vce}/vce_4_0_sh_mask.h |     0
 .../asic_reg/{raven1/VCN => vcn}/vcn_1_0_offset.h  |     0
 .../asic_reg/{raven1/VCN => vcn}/vcn_1_0_sh_mask.h |     0
 .../asic_reg/vega10/ATHUB/athub_1_0_default.h      |   241 -
 .../asic_reg/vega10/ATHUB/athub_1_0_offset.h       |   453 -
 .../asic_reg/vega10/ATHUB/athub_1_0_sh_mask.h      |  2045 --
 .../include/asic_reg/vega10/DC/dce_12_0_default.h  |  9868 ------
 .../include/asic_reg/vega10/HDP/hdp_4_0_default.h  |   117 -
 .../include/asic_reg/vega10/HDP/hdp_4_0_offset.h   |   209 -
 .../include/asic_reg/vega10/HDP/hdp_4_0_sh_mask.h  |   601 -
 .../include/asic_reg/vega10/MP/mp_9_0_default.h    |   342 -
 .../amd/include/asic_reg/vega10/MP/mp_9_0_offset.h |   375 -
 .../include/asic_reg/vega10/MP/mp_9_0_sh_mask.h    |  1463 -
 .../asic_reg/vega10/NBIF/nbif_6_1_default.h        |  1271 -
 .../asic_reg/vega10/OSSSYS/osssys_4_0_default.h    |   176 -
 .../asic_reg/vega10/SDMA0/sdma0_4_0_default.h      |   286 -
 .../asic_reg/vega10/SDMA0/sdma0_4_0_offset.h       |   547 -
 .../asic_reg/vega10/SDMA0/sdma0_4_0_sh_mask.h      |  1852 --
 .../asic_reg/vega10/SDMA1/sdma1_4_0_default.h      |   282 -
 .../asic_reg/vega10/SDMA1/sdma1_4_0_offset.h       |   539 -
 .../asic_reg/vega10/SDMA1/sdma1_4_0_sh_mask.h      |  1810 --
 .../asic_reg/vega10/SMUIO/smuio_9_0_default.h      |   100 -
 .../include/asic_reg/vega10/UVD/uvd_7_0_default.h  |   127 -
 drivers/gpu/drm/amd/include/dm_pp_interface.h      |   144 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |    52 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   294 +
 .../amd/include/{asic_reg/vega10 => }/soc15ip.h    |     0
 .../include/{asic_reg/vega10 => }/vega10_enum.h    |     0
 drivers/gpu/drm/amd/include/vi_structs.h           |     2 +
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |   170 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     |    29 +-
 .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |    33 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |     1 +
 .../gpu/drm/amd/powerplay/hwmgr/pp_overdriver.h    |     2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       |     4 +
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |     2 +-
 .../amd/powerplay/hwmgr/process_pptables_v1_0.c    |     6 +-
 .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  |     6 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c     |   182 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.h     |    15 +
 drivers/gpu/drm/amd/powerplay/hwmgr/rv_inc.h       |    18 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |    61 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |    81 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h |     1 -
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_inc.h   |    23 +-
 drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h  |   275 +-
 .../gpu/drm/amd/powerplay/inc/hardwaremanager.h    |     1 +
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |    35 +-
 drivers/gpu/drm/amd/powerplay/inc/pp_soc15.h       |     2 +-
 drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h       |     7 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |    24 +-
 drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c   |    13 +
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |     5 +-
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  |    28 +-
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |     5 +-
 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c   |     8 +
 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h   |     2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |     8 +-
 .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |    15 +-
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |     6 +-
 drivers/gpu/drm/amd/scheduler/gpu_scheduler.h      |   185 -
 drivers/gpu/drm/arc/arcpgu_drv.c                   |     2 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |     8 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |     2 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |    63 +-
 drivers/gpu/drm/arm/malidp_drv.h                   |     2 -
 drivers/gpu/drm/arm/malidp_planes.c                |     3 +-
 drivers/gpu/drm/armada/armada_crtc.c               |   395 +-
 drivers/gpu/drm/armada/armada_crtc.h               |    24 +-
 drivers/gpu/drm/armada/armada_drm.h                |     1 -
 drivers/gpu/drm/armada/armada_drv.c                |     8 +-
 drivers/gpu/drm/armada/armada_fb.c                 |    11 +-
 drivers/gpu/drm/armada/armada_fbdev.c              |     8 -
 drivers/gpu/drm/armada/armada_overlay.c            |   282 +-
 drivers/gpu/drm/armada/armada_trace.h              |    24 +-
 drivers/gpu/drm/ast/ast_mode.c                     |     1 +
 drivers/gpu/drm/ast/ast_ttm.c                      |    15 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |    26 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |     2 +-
 drivers/gpu/drm/bochs/bochs_mm.c                   |     7 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.c          |     2 -
 drivers/gpu/drm/bridge/sil-sii8620.c               |    53 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |     6 +-
 drivers/gpu/drm/bridge/tc358767.c                  |     2 +
 drivers/gpu/drm/cirrus/cirrus_main.c               |     9 +
 drivers/gpu/drm/cirrus/cirrus_ttm.c                |    12 +-
 drivers/gpu/drm/drm_atomic.c                       |    70 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   112 +-
 drivers/gpu/drm/drm_auth.c                         |     6 +
 drivers/gpu/drm/drm_blend.c                        |     8 +-
 drivers/gpu/drm/drm_connector.c                    |    73 +
 drivers/gpu/drm/drm_debugfs.c                      |     8 +
 drivers/gpu/drm/drm_dp_helper.c                    |     1 -
 drivers/gpu/drm/drm_drv.c                          |    47 -
 drivers/gpu/drm/drm_edid.c                         |   110 +-
 drivers/gpu/drm/drm_fb_cma_helper.c                |   156 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   352 +-
 drivers/gpu/drm/drm_framebuffer.c                  |    89 +-
 drivers/gpu/drm/drm_gem.c                          |    21 +-
 drivers/gpu/drm/drm_gem_cma_helper.c               |    53 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |     6 +-
 drivers/gpu/drm/drm_internal.h                     |     7 +
 drivers/gpu/drm/drm_mm.c                           |     2 +-
 drivers/gpu/drm/drm_mode_config.c                  |     3 +
 drivers/gpu/drm/drm_modeset_helper.c               |    76 +
 .../drm/drm_panel_orientation_quirks.c}            |   104 +-
 drivers/gpu/drm/drm_plane_helper.c                 |   111 +-
 drivers/gpu/drm/drm_prime.c                        |     8 +-
 drivers/gpu/drm/drm_print.c                        |    54 +-
 drivers/gpu/drm/drm_probe_helper.c                 |     3 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |     9 +-
 drivers/gpu/drm/drm_syncobj.c                      |    56 +-
 drivers/gpu/drm/drm_vblank.c                       |    12 +-
 drivers/gpu/drm/drm_vma_manager.c                  |    15 +-
 drivers/gpu/drm/etnaviv/Kconfig                    |     9 +
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c           |    40 +-
 drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c       |     1 +
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c           |    29 +-
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.h           |    18 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |    22 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              |    14 +-
 drivers/gpu/drm/etnaviv/etnaviv_dump.c             |    23 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |   197 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.h              |    22 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |     7 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c       |   199 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   215 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              |    11 +-
 drivers/gpu/drm/etnaviv/etnaviv_iommu.c            |     5 +-
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c         |     2 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              |    14 +-
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c          |     4 +-
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.h          |     2 +-
 drivers/gpu/drm/exynos/Kconfig                     |    11 +-
 drivers/gpu/drm/exynos/Makefile                    |     1 -
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |     8 +-
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         |     2 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |    20 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.h            |     2 -
 drivers/gpu/drm/exynos/exynos_drm_fb.c             |     2 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |    18 -
 drivers/gpu/drm/exynos/exynos_drm_fbdev.h          |     2 -
 drivers/gpu/drm/exynos/exynos_drm_ipp.c            |  1806 --
 drivers/gpu/drm/exynos/exynos_drm_ipp.h            |   252 -
 drivers/gpu/drm/exynos/exynos_hdmi.c               |     3 +-
 .../gpu/drm/exynos/regs-decon5433.h                |     6 +-
 .../gpu/drm/exynos/regs-decon7.h                   |     8 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |    25 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h          |     1 -
 drivers/gpu/drm/gma500/framebuffer.c               |     9 +-
 drivers/gpu/drm/gma500/mmu.c                       |     2 +-
 drivers/gpu/drm/gma500/psb_drv.c                   |    17 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |     1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |    11 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |     1 -
 drivers/gpu/drm/i915/Kconfig.debug                 |    29 +
 drivers/gpu/drm/i915/Makefile                      |    32 +-
 drivers/gpu/drm/i915/gvt/Makefile                  |     3 +-
 drivers/gpu/drm/i915/gvt/cfg_space.c               |     3 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   264 +-
 drivers/gpu/drm/i915/gvt/debug.h                   |    24 +-
 drivers/gpu/drm/i915/gvt/debugfs.c                 |   212 +
 drivers/gpu/drm/i915/gvt/display.c                 |    80 +-
 drivers/gpu/drm/i915/gvt/display.h                 |     2 +
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |   537 +
 drivers/gpu/drm/i915/gvt/dmabuf.h                  |    67 +
 drivers/gpu/drm/i915/gvt/edid.c                    |    22 +-
 drivers/gpu/drm/i915/gvt/execlist.c                |   498 +-
 drivers/gpu/drm/i915/gvt/execlist.h                |     8 +-
 drivers/gpu/drm/i915/gvt/fb_decoder.c              |   514 +
 drivers/gpu/drm/i915/gvt/fb_decoder.h              |   169 +
 drivers/gpu/drm/i915/gvt/firmware.c                |    26 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |   298 +-
 drivers/gpu/drm/i915/gvt/gtt.h                     |    45 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     |   153 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |   127 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   842 +-
 drivers/gpu/drm/i915/gvt/hypercall.h               |     3 +
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |   301 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |    89 +-
 drivers/gpu/drm/i915/gvt/mmio.h                    |     9 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c            |   412 +
 .../gpu/drm/i915/gvt/{render.h => mmio_context.h}  |     9 +
 drivers/gpu/drm/i915/gvt/mpt.h                     |    79 +-
 drivers/gpu/drm/i915/gvt/opregion.c                |   360 +-
 drivers/gpu/drm/i915/gvt/reg.h                     |     6 +-
 drivers/gpu/drm/i915/gvt/render.c                  |   405 -
 drivers/gpu/drm/i915/gvt/sched_policy.c            |     5 +
 drivers/gpu/drm/i915/gvt/sched_policy.h            |     2 +
 drivers/gpu/drm/i915/gvt/scheduler.c               |   670 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |    35 +-
 drivers/gpu/drm/i915/gvt/trace.h                   |    15 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |    73 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             |    20 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |   438 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   182 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   643 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   538 +-
 drivers/gpu/drm/i915/i915_gem.h                    |    12 +-
 drivers/gpu/drm/i915/i915_gem_clflush.c            |     2 +-
 drivers/gpu/drm/i915/i915_gem_context.c            |   368 +-
 drivers/gpu/drm/i915/i915_gem_context.h            |     4 +-
 drivers/gpu/drm/i915/i915_gem_evict.c              |     4 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |    85 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |   192 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h                |    19 +-
 drivers/gpu/drm/i915/i915_gem_internal.c           |     4 +-
 drivers/gpu/drm/i915/i915_gem_object.h             |    13 +-
 drivers/gpu/drm/i915/i915_gem_render_state.c       |   139 +-
 drivers/gpu/drm/i915/i915_gem_render_state.h       |     4 +-
 drivers/gpu/drm/i915/i915_gem_request.c            |    68 +-
 drivers/gpu/drm/i915/i915_gem_request.h            |     2 +
 drivers/gpu/drm/i915/i915_gem_shrinker.c           |   138 +-
 drivers/gpu/drm/i915/i915_gem_stolen.c             |   323 +-
 drivers/gpu/drm/i915/i915_gem_tiling.c             |    19 +-
 drivers/gpu/drm/i915/i915_gem_timeline.c           |    11 +-
 drivers/gpu/drm/i915/i915_gem_timeline.h           |     2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   195 +-
 drivers/gpu/drm/i915/i915_irq.c                    |    14 +-
 drivers/gpu/drm/i915/i915_memcpy.c                 |     7 +-
 drivers/gpu/drm/i915/i915_oa_bdw.c                 |     4 +-
 drivers/gpu/drm/i915/i915_oa_bxt.c                 |     4 +-
 drivers/gpu/drm/i915/i915_oa_cflgt2.c              |     4 +-
 drivers/gpu/drm/i915/i915_oa_cflgt3.c              |   109 +
 drivers/gpu/drm/i915/i915_oa_cflgt3.h              |    34 +
 drivers/gpu/drm/i915/i915_oa_chv.c                 |     4 +-
 drivers/gpu/drm/i915/i915_oa_cnl.c                 |   121 +
 drivers/gpu/drm/i915/i915_oa_cnl.h                 |    34 +
 drivers/gpu/drm/i915/i915_oa_glk.c                 |     4 +-
 drivers/gpu/drm/i915/i915_oa_hsw.c                 |     4 +-
 drivers/gpu/drm/i915/i915_oa_kblgt2.c              |     4 +-
 drivers/gpu/drm/i915/i915_oa_kblgt3.c              |     4 +-
 drivers/gpu/drm/i915/i915_oa_sklgt2.c              |     4 +-
 drivers/gpu/drm/i915/i915_oa_sklgt3.c              |     4 +-
 drivers/gpu/drm/i915/i915_oa_sklgt4.c              |     4 +-
 drivers/gpu/drm/i915/i915_params.c                 |    59 +-
 drivers/gpu/drm/i915/i915_params.h                 |    14 +-
 drivers/gpu/drm/i915/i915_pci.c                    |     4 +
 drivers/gpu/drm/i915/i915_perf.c                   |   153 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   865 +
 drivers/gpu/drm/i915/i915_pmu.h                    |   111 +
 drivers/gpu/drm/i915/i915_reg.h                    |    93 +-
 drivers/gpu/drm/i915/i915_selftest.h               |     2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c               |     3 +
 drivers/gpu/drm/i915/i915_sysfs.c                  |    33 +-
 drivers/gpu/drm/i915/i915_trace.h                  |    40 +-
 drivers/gpu/drm/i915/i915_utils.h                  |    22 +-
 drivers/gpu/drm/i915/i915_vma.c                    |    40 +-
 drivers/gpu/drm/i915/i915_vma.h                    |    35 +-
 drivers/gpu/drm/i915/intel_audio.c                 |   202 +-
 drivers/gpu/drm/i915/intel_bios.c                  |    24 +
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |   105 +-
 drivers/gpu/drm/i915/intel_cdclk.c                 |   393 +-
 drivers/gpu/drm/i915/intel_color.c                 |     4 +-
 drivers/gpu/drm/i915/intel_crt.c                   |    46 +-
 drivers/gpu/drm/i915/intel_csr.c                   |    13 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |   347 +-
 drivers/gpu/drm/i915/intel_device_info.c           |   200 +-
 drivers/gpu/drm/i915/intel_device_info.h           |   183 +
 drivers/gpu/drm/i915/intel_display.c               |  1278 +-
 drivers/gpu/drm/i915/intel_display.h               |   321 +
 drivers/gpu/drm/i915/intel_dp.c                    |   594 +-
 drivers/gpu/drm/i915/intel_dp_mst.c                |    79 +-
 drivers/gpu/drm/i915/intel_dpio_phy.c              |   122 +-
 drivers/gpu/drm/i915/intel_dpll_mgr.c              |   107 +-
 drivers/gpu/drm/i915/intel_drv.h                   |    82 +-
 drivers/gpu/drm/i915/intel_dsi.c                   |    47 +-
 drivers/gpu/drm/i915/intel_dvo.c                   |     2 +
 drivers/gpu/drm/i915/intel_engine_cs.c             |   475 +-
 drivers/gpu/drm/i915/intel_fbc.c                   |    48 +-
 drivers/gpu/drm/i915/intel_fbdev.c                 |     3 +-
 drivers/gpu/drm/i915/intel_guc.c                   |   152 +-
 drivers/gpu/drm/i915/intel_guc.h                   |    21 +-
 drivers/gpu/drm/i915/intel_guc_ct.c                |     1 +
 drivers/gpu/drm/i915/intel_guc_fw.c                |   245 +-
 drivers/gpu/drm/i915/intel_guc_fw.h                |     2 +-
 drivers/gpu/drm/i915/intel_guc_fwif.h              |    40 +
 drivers/gpu/drm/i915/intel_guc_log.c               |    29 +-
 .../drm/i915/{i915_guc_reg.h => intel_guc_reg.h}   |    14 +-
 ...915_guc_submission.c => intel_guc_submission.c} |   751 +-
 ...915_guc_submission.h => intel_guc_submission.h} |    17 +-
 drivers/gpu/drm/i915/intel_gvt.c                   |     7 +-
 drivers/gpu/drm/i915/intel_hangcheck.c             |    61 +-
 drivers/gpu/drm/i915/intel_hdmi.c                  |   114 +-
 drivers/gpu/drm/i915/intel_huc.c                   |    83 +-
 drivers/gpu/drm/i915/intel_huc.h                   |     6 +-
 drivers/gpu/drm/i915/intel_i2c.c                   |    61 +-
 drivers/gpu/drm/i915/intel_lrc.c                   |   283 +-
 drivers/gpu/drm/i915/intel_lrc.h                   |     5 -
 drivers/gpu/drm/i915/intel_lvds.c                  |     2 +
 drivers/gpu/drm/i915/intel_modes.c                 |     1 -
 drivers/gpu/drm/i915/intel_opregion.c              |     6 +-
 drivers/gpu/drm/i915/intel_opregion.h              |   106 +
 drivers/gpu/drm/i915/intel_overlay.c               |     4 +-
 drivers/gpu/drm/i915/intel_panel.c                 |    88 +-
 drivers/gpu/drm/i915/intel_pipe_crc.c              |     6 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   437 +-
 drivers/gpu/drm/i915/intel_psr.c                   |     4 +-
 drivers/gpu/drm/i915/intel_ringbuffer.c            |   747 +-
 drivers/gpu/drm/i915/intel_ringbuffer.h            |   263 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |    10 +-
 drivers/gpu/drm/i915/intel_sdvo.c                  |     6 +-
 drivers/gpu/drm/i915/intel_sprite.c                |    96 +-
 drivers/gpu/drm/i915/intel_tv.c                    |     6 +-
 drivers/gpu/drm/i915/intel_uc.c                    |   267 +-
 drivers/gpu/drm/i915/intel_uc.h                    |    23 +
 drivers/gpu/drm/i915/intel_uc_fw.c                 |     6 +-
 drivers/gpu/drm/i915/intel_uc_fw.h                 |     7 +-
 drivers/gpu/drm/i915/intel_uncore.c                |   172 +-
 drivers/gpu/drm/i915/intel_vbt_defs.h              |     8 +-
 drivers/gpu/drm/i915/selftests/huge_pages.c        |   181 +-
 .../gpu/drm/i915/selftests/i915_gem_coherency.c    |    16 +-
 drivers/gpu/drm/i915/selftests/i915_gem_context.c  |    33 +-
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |     2 +
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |    52 +-
 drivers/gpu/drm/i915/selftests/i915_gem_object.c   |     2 +
 drivers/gpu/drm/i915/selftests/i915_gem_request.c  |    22 +-
 drivers/gpu/drm/i915/selftests/i915_gem_timeline.c |     2 +-
 .../gpu/drm/i915/selftests/i915_live_selftests.h   |     1 +
 drivers/gpu/drm/i915/selftests/i915_random.c       |     2 +-
 drivers/gpu/drm/i915/selftests/i915_syncmap.c      |     6 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |     2 +-
 drivers/gpu/drm/i915/selftests/intel_guc.c         |   353 +
 drivers/gpu/drm/i915/selftests/intel_hangcheck.c   |   331 +-
 drivers/gpu/drm/i915/selftests/intel_uncore.c      |    11 +-
 drivers/gpu/drm/i915/selftests/mock_engine.c       |    41 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |    14 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.c          |     4 +-
 drivers/gpu/drm/imx/imx-drm-core.c                 |    34 +-
 drivers/gpu/drm/imx/imx-drm.h                      |     1 -
 drivers/gpu/drm/imx/ipuv3-plane.c                  |   110 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           |     8 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |     4 +-
 drivers/gpu/drm/meson/meson_drv.c                  |     9 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |    13 +
 drivers/gpu/drm/meson/meson_plane.c                |     8 +-
 drivers/gpu/drm/meson/meson_registers.h            |     4 +
 drivers/gpu/drm/mgag200/mgag200_ttm.c              |    15 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |    38 +
 drivers/gpu/drm/msm/adreno/a5xx_power.c            |     8 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   140 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    85 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |     4 -
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.h            |     7 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c          |    19 +-
 drivers/gpu/drm/msm/msm_drv.c                      |    18 +-
 drivers/gpu/drm/msm/msm_drv.h                      |     3 +-
 drivers/gpu/drm/msm/msm_gem.c                      |    14 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   112 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |    14 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    51 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |     3 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |     8 -
 drivers/gpu/drm/nouveau/nouveau_fbcon.h            |     2 -
 drivers/gpu/drm/nouveau/nouveau_gem.c              |     2 +-
 drivers/gpu/drm/nouveau/nouveau_vga.c              |     3 +-
 drivers/gpu/drm/nouveau/nv50_display.c             |    28 +-
 .../gpu/drm/omapdrm/displays/connector-analog-tv.c |     2 +-
 drivers/gpu/drm/omapdrm/displays/connector-dvi.c   |     2 +-
 drivers/gpu/drm/omapdrm/displays/connector-hdmi.c  |     2 +-
 drivers/gpu/drm/omapdrm/displays/encoder-opa362.c  |     2 +-
 drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c  |     5 +-
 .../gpu/drm/omapdrm/displays/encoder-tpd12s015.c   |     2 +-
 drivers/gpu/drm/omapdrm/displays/panel-dpi.c       |     2 +-
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    |   291 +-
 .../omapdrm/displays/panel-lgphilips-lb035q02.c    |     2 +-
 .../drm/omapdrm/displays/panel-nec-nl8048hl11.c    |     2 +-
 .../drm/omapdrm/displays/panel-sharp-ls037v7dw01.c |     2 +-
 .../drm/omapdrm/displays/panel-tpo-td028ttec1.c    |    13 +-
 drivers/gpu/drm/omapdrm/dss/base.c                 |    15 +
 drivers/gpu/drm/omapdrm/dss/core.c                 |    55 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |    27 +-
 drivers/gpu/drm/omapdrm/dss/dispc.h                |     5 +-
 drivers/gpu/drm/omapdrm/dss/dispc_coefs.c          |     4 +-
 drivers/gpu/drm/omapdrm/dss/display.c              |    16 -
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |     8 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |    14 +-
 drivers/gpu/drm/omapdrm/dss/dss-of.c               |     2 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  |    25 +-
 drivers/gpu/drm/omapdrm/dss/dss.h                  |    38 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |    13 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c           |     3 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |    14 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c           |     3 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_phy.c             |     2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_pll.c             |     2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_wp.c              |     2 +-
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c    |     2 +-
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |    12 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |     2 +-
 drivers/gpu/drm/omapdrm/dss/pll.c                  |     2 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |     2 -
 drivers/gpu/drm/omapdrm/dss/venc.c                 |    18 +-
 drivers/gpu/drm/omapdrm/dss/video-pll.c            |    20 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |    10 +-
 drivers/gpu/drm/omapdrm/omap_connector.h           |    37 +
 drivers/gpu/drm/omapdrm/omap_crtc.c                |    41 +-
 drivers/gpu/drm/omapdrm/omap_crtc.h                |    43 +
 drivers/gpu/drm/omapdrm/omap_debugfs.c             |     4 +-
 drivers/gpu/drm/omapdrm/omap_dmm_priv.h            |    14 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |    25 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.h           |     1 -
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    45 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |   140 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c             |     4 +-
 drivers/gpu/drm/omapdrm/omap_encoder.h             |    33 +
 drivers/gpu/drm/omapdrm/omap_fb.c                  |     4 +-
 drivers/gpu/drm/omapdrm/omap_fb.h                  |    46 +
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |     7 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.h               |    39 +
 drivers/gpu/drm/omapdrm/omap_gem.c                 |    11 +-
 drivers/gpu/drm/omapdrm/omap_gem.h                 |    99 +
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |     4 +-
 drivers/gpu/drm/omapdrm/omap_irq.c                 |     4 +-
 drivers/gpu/drm/omapdrm/omap_irq.h                 |    39 +
 drivers/gpu/drm/omapdrm/omap_plane.c               |     4 +-
 drivers/gpu/drm/omapdrm/omap_plane.h               |    37 +
 drivers/gpu/drm/omapdrm/tcm-sita.c                 |     4 +-
 drivers/gpu/drm/omapdrm/tcm-sita.h                 |     4 +-
 drivers/gpu/drm/omapdrm/tcm.h                      |     2 -
 drivers/gpu/drm/panel/Kconfig                      |     8 +
 drivers/gpu/drm/panel/Makefile                     |     1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |   962 +
 drivers/gpu/drm/panel/panel-lvds.c                 |    30 +
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |     2 +-
 drivers/gpu/drm/panel/panel-simple.c               |    62 +
 drivers/gpu/drm/pl111/pl111_drm.h                  |     1 -
 drivers/gpu/drm/pl111/pl111_drv.c                  |    16 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |    63 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |     2 +
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |     4 +-
 drivers/gpu/drm/qxl/qxl_object.c                   |     6 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |     6 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |    21 +-
 drivers/gpu/drm/radeon/cik.c                       |   114 +-
 drivers/gpu/drm/radeon/cik_reg.h                   |     2 -
 drivers/gpu/drm/radeon/evergreen.c                 |     1 +
 drivers/gpu/drm/radeon/ni.c                        |     1 +
 drivers/gpu/drm/radeon/radeon.h                    |     6 -
 drivers/gpu/drm/radeon/radeon_connectors.c         |     1 -
 drivers/gpu/drm/radeon/radeon_device.c             |    32 -
 drivers/gpu/drm/radeon/radeon_display.c            |     9 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |     3 +-
 drivers/gpu/drm/radeon/radeon_fb.c                 |    22 -
 drivers/gpu/drm/radeon/radeon_gem.c                |     3 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |     5 +-
 drivers/gpu/drm/radeon/radeon_mn.c                 |     3 +-
 drivers/gpu/drm/radeon/radeon_mode.h               |     3 -
 drivers/gpu/drm/radeon/radeon_object.c             |    14 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |    46 +-
 drivers/gpu/drm/radeon/radeon_vm.c                 |     3 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |     5 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |    38 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |    62 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |     1 +
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c          |     4 -
 drivers/gpu/drm/rcar-du/rcar_du_plane.c            |    75 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.h            |     4 +
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |    64 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |    28 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |     4 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               |     1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |     9 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |     9 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |     6 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |    30 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h        |     6 +
 drivers/gpu/drm/scheduler/Makefile                 |    26 +
 .../gpu/drm/{amd => }/scheduler/gpu_scheduler.c    |   396 +-
 drivers/gpu/drm/{amd => }/scheduler/sched_fence.c  |   122 +-
 drivers/gpu/drm/selftests/test-drm_mm.c            |     5 +
 drivers/gpu/drm/sti/Kconfig                        |     1 +
 drivers/gpu/drm/sti/sti_awg_utils.c                |     2 +-
 drivers/gpu/drm/sti/sti_awg_utils.h                |     2 +-
 drivers/gpu/drm/sti/sti_compositor.c               |     2 +-
 drivers/gpu/drm/sti/sti_compositor.h               |     2 +-
 drivers/gpu/drm/sti/sti_crtc.c                     |     2 +-
 drivers/gpu/drm/sti/sti_crtc.h                     |     2 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |     2 +-
 drivers/gpu/drm/sti/sti_cursor.h                   |     2 +-
 drivers/gpu/drm/sti/sti_drv.c                      |    29 +-
 drivers/gpu/drm/sti/sti_drv.h                      |     3 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |     2 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |     2 +-
 drivers/gpu/drm/sti/sti_gdp.h                      |     2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |     2 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |    12 +-
 drivers/gpu/drm/sti/sti_hdmi.h                     |     2 +-
 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c         |     2 +-
 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.h         |     2 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |     2 +-
 drivers/gpu/drm/sti/sti_hqvdp_lut.h                |     2 +-
 drivers/gpu/drm/sti/sti_mixer.c                    |     2 +-
 drivers/gpu/drm/sti/sti_mixer.h                    |     2 +-
 drivers/gpu/drm/sti/sti_plane.c                    |     2 +-
 drivers/gpu/drm/sti/sti_plane.h                    |     2 +-
 drivers/gpu/drm/sti/sti_tvout.c                    |     2 +-
 drivers/gpu/drm/sti/sti_vid.c                      |     2 +-
 drivers/gpu/drm/sti/sti_vid.h                      |     2 +-
 drivers/gpu/drm/sti/sti_vtg.c                      |    40 +-
 drivers/gpu/drm/sti/sti_vtg.h                      |     2 +-
 drivers/gpu/drm/stm/drv.c                          |    41 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |    14 +-
 drivers/gpu/drm/stm/ltdc.c                         |    75 +-
 drivers/gpu/drm/stm/ltdc.h                         |     4 +-
 drivers/gpu/drm/sun4i/Makefile                     |     5 +-
 drivers/gpu/drm/sun4i/sun4i_dotclock.c             |    10 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |    23 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h                  |     2 -
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |    18 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.h          |     2 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |   177 +
 drivers/gpu/drm/sun4i/sun4i_lvds.h                 |    12 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   248 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |    33 +
 drivers/gpu/drm/sun4i/sun8i_csc.c                  |    93 +
 drivers/gpu/drm/sun4i/sun8i_csc.h                  |    36 +
 drivers/gpu/drm/sun4i/sun8i_layer.c                |   134 -
 drivers/gpu/drm/sun4i/sun8i_layer.h                |    36 -
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |   517 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |   126 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |   349 +
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h             |    63 +
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c            |   172 +
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h            |    49 +
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |   390 +
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h             |    51 +
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c            |   971 +
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h            |    58 +
 drivers/gpu/drm/tegra/Makefile                     |     2 +
 drivers/gpu/drm/tegra/dc.c                         |  1930 +-
 drivers/gpu/drm/tegra/dc.h                         |   289 +-
 drivers/gpu/drm/tegra/dpaux.c                      |   120 +-
 drivers/gpu/drm/tegra/drm.c                        |   177 +-
 drivers/gpu/drm/tegra/drm.h                        |    30 +-
 drivers/gpu/drm/tegra/dsi.c                        |   228 +-
 drivers/gpu/drm/tegra/fb.c                         |    50 +-
 drivers/gpu/drm/tegra/gem.c                        |    15 +-
 drivers/gpu/drm/tegra/hdmi.c                       |   504 +-
 drivers/gpu/drm/tegra/hub.c                        |   806 +
 drivers/gpu/drm/tegra/hub.h                        |    81 +
 drivers/gpu/drm/tegra/output.c                     |    25 +-
 drivers/gpu/drm/tegra/plane.c                      |   383 +
 drivers/gpu/drm/tegra/plane.h                      |    70 +
 drivers/gpu/drm/tegra/sor.c                        |  1117 +-
 drivers/gpu/drm/tegra/sor.h                        |    16 +
 drivers/gpu/drm/tegra/vic.c                        |    20 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |    51 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |    28 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |     2 -
 drivers/gpu/drm/tilcdc/tilcdc_regs.h               |     2 +-
 drivers/gpu/drm/tinydrm/Kconfig                    |    20 +
 drivers/gpu/drm/tinydrm/Makefile                   |     2 +
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |   104 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c     |     4 +-
 drivers/gpu/drm/tinydrm/ili9225.c                  |   469 +
 drivers/gpu/drm/tinydrm/mi0283qt.c                 |    10 +-
 drivers/gpu/drm/tinydrm/mipi-dbi.c                 |    32 +-
 drivers/gpu/drm/tinydrm/st7586.c                   |     3 +-
 drivers/gpu/drm/tinydrm/st7735r.c                  |   215 +
 drivers/gpu/drm/ttm/ttm_agp_backend.c              |     4 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   341 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    23 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    29 +-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c             |     8 +-
 drivers/gpu/drm/ttm/ttm_memory.c                   |    37 +-
 drivers/gpu/drm/ttm/ttm_object.c                   |    13 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |    36 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |    99 +-
 drivers/gpu/drm/ttm/ttm_tt.c                       |     5 +-
 drivers/gpu/drm/tve200/tve200_drm.h                |     1 -
 drivers/gpu/drm/tve200/tve200_drv.c                |    16 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |    13 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |     2 -
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |    16 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |    18 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |    38 +-
 drivers/gpu/drm/via/via_drv.h                      |     4 +-
 drivers/gpu/drm/via/via_irq.c                      |    27 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |    12 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |    13 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |     6 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |     6 +-
 drivers/gpu/drm/virtio/virtgpu_ttm.c               |    13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c            |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c             |    17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c            |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |     9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_dmabuf.c             |    21 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |     9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |    40 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |    13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |    21 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c    |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c                 |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |    12 +-
 drivers/gpu/drm/zte/zx_drm_drv.c                   |    48 +-
 drivers/gpu/drm/zte/zx_hdmi.c                      |     1 +
 drivers/gpu/drm/zte/zx_plane.c                     |    15 +-
 drivers/gpu/host1x/bus.c                           |    11 +-
 drivers/gpu/host1x/dev.c                           |    36 +-
 drivers/gpu/host1x/dev.h                           |     1 +
 drivers/gpu/ipu-v3/Kconfig                         |     4 +-
 drivers/gpu/ipu-v3/ipu-cpmem.c                     |     1 +
 drivers/gpu/ipu-v3/ipu-ic.c                        |     1 +
 drivers/gpu/ipu-v3/ipu-pre.c                       |    29 +-
 drivers/gpu/ipu-v3/ipu-prg.c                       |    84 +-
 drivers/gpu/ipu-v3/ipu-prv.h                       |     4 +-
 drivers/media/platform/vsp1/vsp1_drm.c             |    37 +-
 drivers/staging/vboxvideo/vbox_ttm.c               |    23 +-
 drivers/video/fbdev/Kconfig                        |     1 +
 drivers/video/fbdev/core/Makefile                  |     3 -
 drivers/video/fbdev/core/fbcon.c                   |    22 +-
 drivers/video/fbdev/core/fbcon.h                   |     6 -
 drivers/video/fbdev/core/fbsysfs.c                 |     1 +
 drivers/video/fbdev/efifb.c                        |    21 +-
 .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |    12 +-
 drivers/video/hdmi.c                               |    51 +-
 include/drm/drmP.h                                 |   197 +-
 include/drm/drm_atomic.h                           |    32 +
 include/drm/drm_atomic_helper.h                    |     7 +
 include/drm/drm_connector.h                        |    54 +-
 include/drm/drm_device.h                           |     9 +
 include/drm/drm_dp_helper.h                        |     1 +
 include/drm/drm_drv.h                              |    22 +-
 include/drm/drm_edid.h                             |     2 +-
 include/drm/drm_encoder.h                          |     6 +-
 include/drm/drm_fb_cma_helper.h                    |    13 +-
 include/drm/drm_fb_helper.h                        |    57 +
 include/drm/drm_framebuffer.h                      |     8 +-
 include/drm/drm_gem_cma_helper.h                   |    16 +-
 include/drm/drm_mm.h                               |     2 +-
 include/drm/drm_mode_config.h                      |    27 +-
 include/drm/drm_modeset_helper.h                   |     3 +
 include/drm/drm_modeset_helper_vtables.h           |     3 -
 include/drm/drm_plane.h                            |    14 +-
 include/drm/drm_plane_helper.h                     |     5 -
 include/drm/drm_print.h                            |   219 +
 include/drm/drm_syncobj.h                          |    36 +-
 include/drm/drm_utils.h                            |    15 +
 include/drm/drm_vma_manager.h                      |     2 +-
 include/drm/gpu_scheduler.h                        |   173 +
 .../drm/gpu_scheduler_trace.h                      |    21 +-
 include/drm/i915_drm.h                             |     3 +
 include/drm/i915_pciids.h                          |    32 +-
 include/drm/intel-gtt.h                            |     3 +-
 include/drm/spsc_queue.h                           |   122 +
 include/drm/tinydrm/mipi-dbi.h                     |     4 +-
 include/drm/tinydrm/tinydrm.h                      |     8 +-
 include/drm/ttm/ttm_bo_api.h                       |   169 +-
 include/drm/ttm/ttm_bo_driver.h                    |   157 +-
 include/drm/ttm/ttm_memory.h                       |    75 +-
 include/drm/ttm/ttm_page_alloc.h                   |    11 +-
 include/linux/dma-fence-array.h                    |     3 +
 include/linux/dma-fence.h                          |     2 +-
 include/linux/fb.h                                 |     5 +
 include/linux/reservation.h                        |    23 +
 include/uapi/drm/amdgpu_drm.h                      |    12 +
 include/uapi/drm/drm_fourcc.h                      |    38 +-
 include/uapi/drm/exynos_drm.h                      |   192 +-
 include/uapi/drm/i915_drm.h                        |    77 +
 include/uapi/linux/kfd_ioctl.h                     |    15 +-
 include/uapi/linux/vfio.h                          |    62 +
 include/video/imx-ipu-v3.h                         |     2 +-
 1020 files changed, 57726 insertions(+), 97126 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9225.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/ilitek,ili9322.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/mitsubishi,aa070mc01.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/tianma,tm070rvhg71.txt
 rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt
=> tpo,td028ttec1.txt} (84%)
 create mode 100644
Documentation/devicetree/bindings/display/sitronix,st7735r.txt
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
 rename drivers/gpu/drm/amd/{display/dc/basics/grph_object_id.c =>
amdgpu/amdgpu_debugfs.h} (50%)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_crat.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_link.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_stream.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
 rename drivers/gpu/drm/amd/display/dc/dcn10/{dcn10_timing_generator.c
=> dcn10_optc.c} (72%)
 rename drivers/gpu/drm/amd/display/dc/dcn10/{dcn10_timing_generator.h
=> dcn10_optc.h} (76%)
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/athub/athub_1_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/athub/athub_1_0_sh_mask.h
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/DC =>
dce}/dce_12_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/DC =>
dce}/dce_12_0_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/DCN =>
dcn}/dcn_1_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/DCN =>
dcn}/dcn_1_0_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/GC =>
gc}/gc_9_0_default.h (99%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/GC =>
gc}/gc_9_0_offset.h (99%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/GC =>
gc}/gc_9_0_sh_mask.h (99%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/GC =>
gc}/gc_9_1_offset.h (99%)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/MMHUB =>
mmhub}/mmhub_1_0_default.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/MMHUB =>
mmhub}/mmhub_1_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/MMHUB =>
mmhub}/mmhub_1_0_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/MMHUB =>
mmhub}/mmhub_9_1_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/MMHUB =>
mmhub}/mmhub_9_1_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/MP =>
mp}/mp_10_0_default.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/MP =>
mp}/mp_10_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/MP =>
mp}/mp_10_0_sh_mask.h (100%)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_9_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_9_0_sh_mask.h
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/NBIF =>
nbif}/nbif_6_1_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/NBIF =>
nbif}/nbif_6_1_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/NBIO =>
nbio}/nbio_6_1_default.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/NBIO =>
nbio}/nbio_6_1_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/NBIO =>
nbio}/nbio_6_1_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/NBIO =>
nbio}/nbio_7_0_default.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/NBIO =>
nbio}/nbio_7_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/NBIO =>
nbio}/nbio_7_0_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/OSSSYS =>
oss}/osssys_4_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/OSSSYS =>
oss}/osssys_4_0_sh_mask.h (100%)
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/raven1/DCN/dcn_1_0_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/raven1/GC/gc_9_1_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/raven1/GC/gc_9_1_sh_mask.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/raven1/MMHUB/mmhub_9_1_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/raven1/SDMA0/sdma0_4_1_sh_mask.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/raven1/VCN/vcn_1_0_default.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_default.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_sh_mask.h
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/SDMA0 =>
sdma0}/sdma0_4_1_default.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/SDMA0 =>
sdma0}/sdma0_4_1_offset.h (100%)
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_default.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_sh_mask.h
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/SMUIO =>
smuio}/smuio_9_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/SMUIO =>
smuio}/smuio_9_0_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/THM =>
thm}/thm_10_0_default.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/THM =>
thm}/thm_10_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/THM =>
thm}/thm_10_0_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/THM =>
thm}/thm_9_0_default.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/THM =>
thm}/thm_9_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/THM =>
thm}/thm_9_0_sh_mask.h (100%)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_sh_mask.h
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/UVD =>
uvd}/uvd_7_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/UVD =>
uvd}/uvd_7_0_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/VCE =>
vce}/vce_4_0_default.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/VCE =>
vce}/vce_4_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{vega10/VCE =>
vce}/vce_4_0_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/VCN =>
vcn}/vcn_1_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{raven1/VCN =>
vcn}/vcn_1_0_sh_mask.h (100%)
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/ATHUB/athub_1_0_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/ATHUB/athub_1_0_offset.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/ATHUB/athub_1_0_sh_mask.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/DC/dce_12_0_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/HDP/hdp_4_0_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/HDP/hdp_4_0_offset.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/HDP/hdp_4_0_sh_mask.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/MP/mp_9_0_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/MP/mp_9_0_offset.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/MP/mp_9_0_sh_mask.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/NBIF/nbif_6_1_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/OSSSYS/osssys_4_0_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/SDMA0/sdma0_4_0_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/SDMA0/sdma0_4_0_offset.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/SDMA0/sdma0_4_0_sh_mask.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/SDMA1/sdma1_4_0_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/SDMA1/sdma1_4_0_offset.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/SDMA1/sdma1_4_0_sh_mask.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/SMUIO/smuio_9_0_default.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/vega10/UVD/uvd_7_0_default.h
 create mode 100644 drivers/gpu/drm/amd/include/kgd_pp_interface.h
 rename drivers/gpu/drm/amd/include/{asic_reg/vega10 => }/soc15ip.h (100%)
 rename drivers/gpu/drm/amd/include/{asic_reg/vega10 => }/vega10_enum.h (100%)
 delete mode 100644 drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
 rename drivers/{video/fbdev/core/fbcon_dmi_quirks.c =>
gpu/drm/drm_panel_orientation_quirks.c} (50%)
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_ipp.c
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_ipp.h
 rename include/video/exynos5433_decon.h =>
drivers/gpu/drm/exynos/regs-decon5433.h (98%)
 rename include/video/exynos7_decon.h =>
drivers/gpu/drm/exynos/regs-decon7.h (99%)
 create mode 100644 drivers/gpu/drm/i915/gvt/debugfs.c
 create mode 100644 drivers/gpu/drm/i915/gvt/dmabuf.c
 create mode 100644 drivers/gpu/drm/i915/gvt/dmabuf.h
 create mode 100644 drivers/gpu/drm/i915/gvt/fb_decoder.c
 create mode 100644 drivers/gpu/drm/i915/gvt/fb_decoder.h
 create mode 100644 drivers/gpu/drm/i915/gvt/mmio_context.c
 rename drivers/gpu/drm/i915/gvt/{render.h => mmio_context.h} (91%)
 delete mode 100644 drivers/gpu/drm/i915/gvt/render.c
 create mode 100644 drivers/gpu/drm/i915/i915_oa_cflgt3.c
 create mode 100644 drivers/gpu/drm/i915/i915_oa_cflgt3.h
 create mode 100644 drivers/gpu/drm/i915/i915_oa_cnl.c
 create mode 100644 drivers/gpu/drm/i915/i915_oa_cnl.h
 create mode 100644 drivers/gpu/drm/i915/i915_pmu.c
 create mode 100644 drivers/gpu/drm/i915/i915_pmu.h
 create mode 100644 drivers/gpu/drm/i915/intel_device_info.h
 create mode 100644 drivers/gpu/drm/i915/intel_display.h
 rename drivers/gpu/drm/i915/{i915_guc_reg.h => intel_guc_reg.h} (92%)
 rename drivers/gpu/drm/i915/{i915_guc_submission.c =>
intel_guc_submission.c} (63%)
 rename drivers/gpu/drm/i915/{i915_guc_submission.h =>
intel_guc_submission.h} (85%)
 create mode 100644 drivers/gpu/drm/i915/intel_opregion.h
 create mode 100644 drivers/gpu/drm/i915/selftests/intel_guc.c
 create mode 100644 drivers/gpu/drm/omapdrm/omap_connector.h
 create mode 100644 drivers/gpu/drm/omapdrm/omap_crtc.h
 create mode 100644 drivers/gpu/drm/omapdrm/omap_encoder.h
 create mode 100644 drivers/gpu/drm/omapdrm/omap_fb.h
 create mode 100644 drivers/gpu/drm/omapdrm/omap_fbdev.h
 create mode 100644 drivers/gpu/drm/omapdrm/omap_gem.h
 create mode 100644 drivers/gpu/drm/omapdrm/omap_irq.h
 create mode 100644 drivers/gpu/drm/omapdrm/omap_plane.h
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9322.c
 create mode 100644 drivers/gpu/drm/scheduler/Makefile
 rename drivers/gpu/drm/{amd => }/scheduler/gpu_scheduler.c (55%)
 rename drivers/gpu/drm/{amd => }/scheduler/sched_fence.c (58%)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_csc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_csc.h
 delete mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.c
 delete mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_vi_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_vi_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
 create mode 100644 drivers/gpu/drm/tegra/hub.c
 create mode 100644 drivers/gpu/drm/tegra/hub.h
 create mode 100644 drivers/gpu/drm/tegra/plane.c
 create mode 100644 drivers/gpu/drm/tegra/plane.h
 create mode 100644 drivers/gpu/drm/tinydrm/ili9225.c
 create mode 100644 drivers/gpu/drm/tinydrm/st7735r.c
 create mode 100644 include/drm/drm_utils.h
 create mode 100644 include/drm/gpu_scheduler.h
 rename drivers/gpu/drm/amd/scheduler/gpu_sched_trace.h =>
include/drm/gpu_scheduler_trace.h (84%)
 create mode 100644 include/drm/spsc_queue.h

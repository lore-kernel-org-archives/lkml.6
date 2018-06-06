Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFLdRLYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFD42607C7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeFFDub (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Tue, 5 Jun 2018 23:50:31 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:38028 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeFFDuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 23:50:25 -0400
X-Google-Smtp-Source: ADUXVKJF4yHjKyHwFf7YNr+Wmr3+zZ5KmNuqPtNUa8WcPh9hYxth5XniDNByD7qVqqvfTR67hN3huZOR1CQWpcM4/YU=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 6 Jun 2018 13:50:20 +1000
Message-ID: <CAPM=9twnxQsdgF6Rwn7bm=3rnk5+Qyab7pRDk9QuLq0o+f3CTQ@mail.gmail.com>
Subject: [git pull] drm for v4.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the main drm pull request for v4.18-rc1.

First up I've moved the drm tree to a new location on freedesktop.org. The =
main
reason was to explore using Daniel's maintainer tools (dim-tools) to manage
pull requests and possibly open the drm to having co-maintainers at the top
level in the future. If there are any issues in the pull formatting or with=
 the
hopefully correctly signed tag, let me know.

This location also might change again as there is an fd.o migration to
using gitlab
based hosting for git trees, need to talk to fd.o admins about what might h=
appen
there.

I've got one outstanding msm pull request, Rob was off sick and got delayed=
,
I'll give it a proper once over and I'll send it on separately if it's not =
too
onerous, but for now I thought I'd dequeue what's been in my tree for
the week or two.

This starts to support NVIDIA volta hardware with nouveau, and adds amdgpu
support for the GPU in the Kabylake-G (the intel + radeon single package ch=
ip),
along with some initial Intel icelake enabling.

Thanks,
Dave.

New Drivers:
v3d - driver for broadcom V3D V3.x+ hardware
xen-front - XEN PV display frontend

core:
Handle zpos normalization in the core
Stop looking at legacy pointers in atomic paths
Improved scheduler documentation
Improved aspect ratio validation
Aspect ratio support for 64:27 and 256:135
Drop unused control node code.

i915:
Icelake (ICL) enabling
GuC/HuC refactoring
PSR/PSR2 enabling and fixes
DPLL management refactoring
DP MST fixes
NV12 enabling
HDCP improvements
GEM/Execlist/reset improvements
GVT improvements
Stolen memory first 4k fix

amdgpu:
Vega 20 support
VEGAM support (Kabylake-G)
preOS scanout buffer reservation
power management gfxoff support for raven
SR-IOV fixes
Vega10 power profiles and clock voltage control
Scatter/gather display support on CZ/ST

amdkfd:
GFX9 dGPU support
Userptr memory mapping

nouveau:
major refactoring for Volta GV100 support

tda998x:
HDMI i2c CEC support

etnaviv:
Removed unsued logging code
License text cleanups
MMU handling improvements
Timeout fence fix for 50 days uptime

tegra:
IOMMU support in gr2d/gr3d drivers
zpos support

vc4:
syncobj support
CTM, plane alpha and async cursor support

analogix_dp:
HPD and aux chan fixes

sun4i:
MIPI DSI support

tilcdc:
Clock dividier fixes for OMAP-l138 LCDK board

rcar-du:
R8A77965 support
dma-buf fences fixes
hardware indexed crtc/du group handling
Generic zplane property support

atmel-hclcdc:
Generic zplane property support

mediatek:
use generic video mode function

exynos:
S5PV210 FIMD variant support
IPP v2 framework
More HW overlays support

The following changes since commit 76ef6b28ea4f81c3d511866a9b31392caa833126=
:

  drm: set FMODE_UNSIGNED_OFFSET for drm files (2018-05-15 14:46:04 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-06-06-1

for you to fetch changes up to 568cf2e6aa0c762f14d2d0d481a006f93c63ab7a:

  Merge tag 'drm-amdkfd-next-2018-05-28' of
git://people.freedesktop.org/~gabbayo/linux into drm-next (2018-05-30
11:12:22 +1000)

----------------------------------------------------------------
drm for v4.18-rc1

----------------------------------------------------------------
Abhay Kumar (1):
      drm/i915/audio: set minimum CD clock to twice the BCLK

Alex Deucher (45):
      drm/amdgpu/sdma4: use a helper for SDMA_OP_POLL_REGMEM
      drm/amdgpu: add documentation on hwmon interfaces exposed (v3)
      drm/amdgpu: add asic need_full_reset callback
      drm/amdgpu/si: implement asic need_full_reset callback
      drm/amdgpu/cik: implement asic need_full_reset callback
      drm/amdgpu/vi: implement asic need_full_reset callback
      drm/amdgpu/soc15: implement asic need_full_reset callback
      drm/amdgpu: use new asic need_full_reset callback
      drm/amdgpu/gfx9: cache DB_DEBUG2 and make it available to userspace
      drm/amdgpu/powerplay: fix smu7_get_memory_type for fiji
      drm/amdgpu/powerplay: rename smu7_upload_mc_firmware
      drm/amdgpu: add emit_reg_write_reg_wait ring callback
      drm/amdgpu/gfx9: add emit_reg_write_reg_wait ring callback (v2)
      drm/amdgpu/sdma4: add emit_reg_write_reg_wait ring callback (v2)
      drm/amdgpu/uvd7: add emit_reg_write_reg_wait ring callback
      drm/amdgpu/vce4: add emit_reg_write_reg_wait ring callback
      drm/amdgpu/vcn1: add emit_reg_write_reg_wait ring callback
      drm/amdgpu/gmc9: use amdgpu_ring_emit_reg_write_reg_wait in gpu tlb f=
lush
      drm/amdgpu/gmc: steal the appropriate amount of vram for fw hand-over=
 (v3)
      drm/amdgpu: print the vbios version in the debugfs firmware info
      drm/amdgpu/pm: document power_dpm_force_performance_level
      drm/amdgpu/pm: document power_dpm_state
      drm/amdgpu/pm: document pp_table
      drm/amdgpu/pm: document pp_dpm_sclk pp_dpm_mclk pp_dpm_pcie (v2)
      drm/amdgpu/pm: document pp_power_profile_mode
      drm/amdgpu/pm: document pp_od_clk_voltage
      drm/amdgpu/powerplay: actually return the power with the new query
      drm/amdgpu: Add VEGAM support to the legacy DCE 11 module
      drm/amdgpu/gmc9: remove unused register defs
      drm/amdgpu/atomfirmware: add new gfx_info data table v2.4 (v2)
      drm/amdgpu/atomfirmware: add parser for gfx_info table
      drm/amdgpu: Use vbios table for gpu info on vega20
      drm/amdgpu: add df 3.6 headers
      drm/amdgpu: flag Vega20 as experimental
      drm/amdgpu/display: remove VEGAM config option
      drm/amdgpu/display: remove VEGA20 config option
      drm/amdgpu/display: fix vega12/20 handling in dal_asic_id.h
      drm/amdgpu: count fences from all uvd instances in idle handler
      drm/amdgpu: Take uvd encode rings into account in idle work (v2)
      drm/amdgpu: Take vcn encode rings into account in idle work
      drm/amdgpu: add new DF 1.7 register defs
      drm/amdgpu: add new DF callback for ECC setup
      drm/amdgpu: add a df 1.7 implementation of enable_ecc_force_par_wr_rm=
w
      drm/amdgpu/gmc9: disable partial wr rmw if ECC is not enabled
      drm/amdgpu/pp: remove duplicate assignment

Andrey Grodzovsky (5):
      drm/amdgpu: Free VGA stolen memory as soon as possible.
      drm/amdgpu: Switch to interruptable wait to recover from ring hang.
      drm/amdgpu: Skip drm_sched_entity related ops for KIQ ring.
      drm/scheduler: Remove obsolete spinlock.
      Remove calls to suspend/resume atomic helpers from
amdgpu_device_gpu_recover. (v2)

Andrzej Hajda (2):
      drm/exynos/dsi: remove mode_set callback
      drm/exynos/dsi: mask frame-done interrupt

Andrzej Pietrasiewicz (1):
      drm/exynos: Add driver for Exynos Scaler module

Andy Shevchenko (4):
      i915: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      drm/dp/mst: Fix off-by-one typo when dump payload table
      i915: Convert to use match_string() helper
      drm: panel-orientation-quirks: Convert to use match_string() helper

Ankit Nautiyal (3):
      drm: Add DRM client cap for aspect-ratio
      drm: Handle aspect ratio info in legacy modeset path
      drm: Expose modes with aspect ratio, only if requested

Anthony Koo (26):
      drm/amd/display: Couple bug fixes in stats module
      drm/amd/display: Rename encoder_info_packet to dc_info_packet
      drm/amd/display: Only program MSA_TIMING_PARAM if it changed
      drm/amd/display: Program v_total_min/max after v_total_cntl
      drm/amd/display: Add vmax/min_sel prints to dcn10_log_hw_state
      drm/amd/display: csc updates require FULL update
      drm/amd/display: Updated HDR Static Metadata to directly take
info packet raw
      drm/amd/display: Get rid of unused input_tf
      drm/amd/display: Remove unused fields
      drm/amd/display: Do not use os types
      drm/amd/display: csc_transform to dc_csc_transform
      drm/amd/display: Refactor color module
      drm/amd/display: move color_transfer_func to color mod
      drm/amd/display: Fix structure initialization of hdmi_info_packet
      drm/amd/display: Have DC manage its own allocation of gamma
      drm/amd/display: Do not create memory allocation if stats not enabled
      drm/amd/display: fix issue related to infopacket was not transmitted
      drm/amd/display: add some DTN logs for input and output tf
      drm/amd/display: update dtn logging and goldens
      drm/amd/display: Cleanup unused SetPlaneConfig
      drm/amd/display: Make DisplayStats work with just DC DisplayStats min=
or
      drm/amd/display: Fix up dm logging functionality
      drm/amd/display: use macro for logs
      drm/amd/display: Add fullscreen transitions to log
      drm/amd/display: fix bug with index check
      drm/amd/display: fix memory leaks

Anusha Srivatsa (1):
      drm/i915/firmware: Correct URL for firmware

Arnd Bergmann (2):
      drm/nouveau: nouveau: use larger buffer in nvif_vmm_map
      drm/amdgpu: fix 32-bit build warning

Arushi Singhal (3):
      gpu: drm/lease:: Use list_{next/prev}_entry instead of list_entry
      gpu: drm: nouveau: Use list_{next/prev}_entry instead of list_entry
      drm/nouveau/clk: Use list_for_each_entry_from_reverse

Ben Goz (1):
      drm/amdkfd: Locking PM mutex while allocating IB buffer

Ben Skeggs (159):
      drm/nouveau/core: define FAULT subdev
      drm/nouveau/mc/gp100-: route fault buffer interrupts to FAULT
      drm/nouveau/fault: add infrastructure to support fault buffers
      drm/nouveau/fault/gp100: implement replayable fault buffer initialisa=
tion
      drm/nouveau/fb/gf100-: bump size of mmu debug buffers to match
big page size
      drm/nouveau/fb/gm200-: fix overwriting of big page setting
      drm/nouveau/disp/nv50-: delay subunit construction until oneinit
      drm/nouveau/disp/nv50-: fetch mask of available heads during oneinit
      drm/nouveau/disp/nv50-: fetch mask of available dacs during oneinit
      drm/nouveau/disp/nv50-: fetch mask of available sors during oneinit
      drm/nouveau/disp/nv50-: fetch mask of available piors during oneinit
      drm/nouveau/disp/nv50-: initialise from the engine, rather than
the user object
      drm/nouveau/disp/nv50-: replace user object with engine pointer
in channels
      drm/nouveau/disp/nv50-: simplify definition of overlay channels
      drm/nouveau/disp/nv50-: simplify definition of overlay immediate chan=
nels
      drm/nouveau/disp/nv50-: simplify definition of base channels
      drm/nouveau/disp/nv50-: simplify definition of cursor channels
      drm/nouveau/disp/nv50-: simplify definiton of core channels
      drm/nouveau/disp/nv50-: merge handling of pio and dma channels
      drm/nouveau/disp/nv50-: add channel interfaces to determine the user =
area
      drm/nouveau/disp/nv50-: add channel interfaces to control error inter=
rupts
      drm/nouveau/disp/nv50-: pass nvkm_memory objects for channel push buf=
fers
      drm/nouveau/device: implement a generic method to query
device-specific properties
      drm/nouveau/device: support querying available engines of a specific =
type
      drm/nouveau/fifo: support channel count query
      drm/nouveau/fifo/gk104-: accept engine contexts for CE3 and up
      drm/nouveau/fifo/gk104-: allow fault recovery code to be called
by other subdevs
      drm/nouveau/fifo/gk104-: support querying engines available on
each runlist
      drm/nouveau/fifo/gk104-: require explicit runlist selection for
channel allocation
      drm/nouveau/fifo/gk104-: simplify definition of channel classes
      drm/nouveau/fifo/gk104-: add interfaces to support different
runlist layouts
      drm/nouveau/fifo/gk104-: poll for runlist update completion
      drm/nouveau/fifo/gk110-: support writing channel group runlist entrie=
s
      drm/nouveau/fifo/gk208-: write pbdma timeout regs during initialisati=
on
      drm/nouveau/fifo/gm107-: write instance address in channel runlist en=
try
      drm/nouveau/fifo/gp100-: force individual channels into a channel gro=
up
      drm/nouveau/gr/gf100-: virtualise init_gpc_mmu + apply fixes from tra=
ces
      drm/nouveau/gr/gf100-: support firmware-provided sw_nonctx everywhere
      drm/nouveau/gr/gf100-: virtualise r405a14
      drm/nouveau/gr/gf100-: support clkgate_pack everywhere
      drm/nouveau/gr/gf100-: virtualise init_bios
      drm/nouveau/gr/gf100-: virtualise init_vsc_stream_master
      drm/nouveau/gr/gf100-: virtualise init_zcull
      drm/nouveau/gr/gf100-: virtualise init_num_active_ltcs
      drm/nouveau/gr/gf100-: virtualise init_rop_active_fbps
      drm/nouveau/gr/gf100-: implement another chunk of bios-provided init
      drm/nouveau/gr/gf100-: virtualise init_swdx_pes_mask
      drm/nouveau/gr/gf100: write 0x400124 during init
      drm/nouveau/gr/gf100-: virtualise init_fecs_exceptions + apply
fixes from traces
      drm/nouveau/gr/gf100-: virtualise init_ds_hww_esr_2
      drm/nouveau/gr/gf100-: virtualise init_40601c
      drm/nouveau/gr/gf100-: virtualise init_sked_hww_esr
      drm/nouveau/gr/gf100-: virtualise init_419cc0 + apply fixes from trac=
es
      drm/nouveau/gr/gf100-: virtualise init_419eb4 + apply fixes from trac=
es
      drm/nouveau/gr/gf100-: virtualise init_419c9c + apply fixes from trac=
es
      drm/nouveau/gr/gf100-: virtualise init_ppc_exceptions
      drm/nouveau/gr/gf100-: virtualise init_tex_hww_esr
      drm/nouveau/gr/gf100-: virtualise init_504430
      drm/nouveau/gr/gf100-: virtualise init_shader_exceptions
      drm/nouveau/gr/gf100-: apply be exception fixes from traces
      drm/nouveau/gr/gf100-: virtualise init_400054
      drm/nouveau/gr/gf100-: delete duplicated init code
      drm/nouveau/gr/gf100-: support firmware-provided sw_ctx everywhere
      drm/nouveau/gr/gf100-: virtualise patch_ltc, noting missing init
      drm/nouveau/gr/gf100-: virtualise sm_id/tpc_nr
      drm/nouveau/gr/gf100-: virtualise tpc_per_gpc
      drm/nouveau/gr/gf100-: virtualise r4060a8 + apply fixes from traces
      drm/nouveau/gr/gf100-: virtualise rop_mapping
      drm/nouveau/gr/gf100-: virtualise alpha_beta_tables + improve algorit=
hms
      drm/nouveau/gr/gf100-gf119: modify max_ways_evict where required
      drm/nouveau/gr/gf100-: virtualise dist_skip_table + improve algorithm
      drm/nouveau/gr/gf100-: virtualise r406500
      drm/nouveau/gr/gf100-: virtualise gpc_tpc_nr
      drm/nouveau/gr/gf100-: virtualise r419f78 + apply fixes from traces
      drm/nouveau/gr/gf100-: virtualise tpc_mask + apply fixes from traces
      drm/nouveau/gr/gf100-: support firmware-provided bundle/method everyw=
here
      drm/nouveau/gr/gf100-gf119: update 419cb8 where required
      drm/nouveau/gr/gf100-: note missing 418800 modifications
      drm/nouveau/gr/gf100-: update 419eb0 where required
      drm/nouveau/gr/gf100-: virtualise r419e00
      drm/nouveau/gr/gf100-: virtualise r418e94
      drm/nouveau/gr/gf100-: update 419a3c where required
      drm/nouveau/gr/gf100-: update r408840 where required
      drm/nouveau/gr/gf100-: delete duplicated grctx init code
      drm/nouveau/gr/gf100-: add missing reset sequence before golden
context init
      drm/nouveau/gr/gf100-: virtualise trap_mp
      drm/nouveau/gr/gf100-: port tile mapping calculations from NVGPU
      drm/nouveau/gr/gf100-: port zcull tile mapping calculations from NVGP=
U
      drm/nouveau/gr/gf100-: calculate and use sm mapping table
      drm/nouveau/gr/gf100-: swap bundle and pagepool
      drm/nouveau/gr/gf100-gm10x: update register lists
      drm/nouveau/gr/gp100-: fix pagepool setup
      drm/nouveau/gr/gp100-: fix attrib cb setup
      drm/nouveau/gr/gp100-: use correct registers for zbc colour/depth set=
up
      drm/nouveau/gr/gp102-: setup stencil zbc
      drm/nouveau/gem: lookup VMAs for buffers referenced by pushbuf ioctl
      drm/nouveau/gem: attach fences to VMAs to track GPU usage
      drm/nouveau/gem: tie deferred unmapping of buffers to VMA fence compl=
etion
      drm/nouveau: remove fence wait code from deferred client work handler
      drm/nouveau: no need to create ctxdma for push buffers on fermi and u=
p
      drm/nouveau/drm/nv50-: remove allocation of sw class
      drm/nouveau/kms: move display class instantiation to library
      drm/nouveau/kms/nv50-: move code underneath dispnv50/
      drm/nouveau/kms/nv50-: fix i2c-over-aux on anx9805
      drm/nouveau/kms/nv50-: move fb ctxdma tracking into windows
      drm/nouveau/kms/nv50-: modify overlay allocation so the code can be s=
plit
      drm/nouveau/kms/nv50-: modify cursor allocation so the code can be sp=
lit
      drm/nouveau/kms/nv50-: modify base allocation so the code can be spli=
t
      drm/nouveau/kms/nv50: modify core allocation so the code can be split
      drm/nouveau/kms/nv50-: abstract head interfaces so the code can be sp=
lit
      drm/nouveau/kms/nv50: handle SetControlOutputResource from head
      drm/nouveau/kms/nv50: abstract OR interfaces so the code can be split
      drm/nouveau/kms/nv50-: split each resource type into their own
source files
      drm/nouveau/kms/nv50-: split core implementation by hardware class
      drm/nouveau/kms/nv50-: split base implementation by hardware class
      drm/nouveau/kms/nv50-: allow specification of valid heads for a windo=
w
      drm/nouveau/kms/nv50-: unify set/clr masks
      drm/nouveau/kms/nv50-: move drm format->hw conversion into common cod=
e
      drm/nouveau/kms/nv50-: extend window image data for stereo/planar for=
mats
      drm/nouveau/kms/nv50-: determine MST support from DP Info Table
      drm/nouveau/kms/nv50-: simplify tracking of channel interlocks
      drm/nouveau/kms/nv50-: decouple window state changes, and update
method submisssion
      drm/nouveau/kms/nv50-: simplify swap interval handling
      drm/nouveau/kms/nv50-: store window visibility in state
      drm/nouveau/kms/nv50-: plane updates don't always require image_set()
      drm/nouveau/kms/nv50-: handle degamma LUT from window channels
      drm/nouveau/kms/nv50-: separate blocklinear vs linear pitch
      drm/nouveau/kms/gk104-: support additional cursor sizes
      drm/nouveau/kms/gk104-: add support for [XA]2R10G10B10 formats
      drm/nouveau/kms/nv50-: initial overlay support
      drm/nouveau/core: increase maximum number of copy engines to 9
      drm/nouveau/core: recognise gv100
      drm/nouveau/pci/gv100: initial support
      drm/nouveau/bios/gv100: initial support
      drm/nouveau/bios/pll: limits table 5.0
      drm/nouveau/devinit/gv100: initial support
      drm/nouveau/top/gv100: initial support
      drm/nouveau/ibus/gv100: initial support
      drm/nouveau/gpio/gv100: initial support
      drm/nouveau/i2c/gv100: initial support
      drm/nouveau/fuse/gv100: initial support
      drm/nouveau/mc/gv100: initial support
      drm/nouveau/bus/gv100: initial support
      drm/nouveau/tmr/gv100: initial support
      drm/nouveau/imem/gv100: initial support
      drm/nouveau/fb/gv100: initial support
      drm/nouveau/ltc/gv100: initial support
      drm/nouveau/mmu/gv100: initial support
      drm/nouveau/bar/gv100: initial support
      drm/nouveau/fault/gv100: initial support
      drm/nouveau/pmu/gv100: initial support
      drm/nouveau/therm/gv100: initial support
      drm/nouveau/dma/gv100: initial support
      drm/nouveau/disp/gv100: initial support
      drm/nouveau/kms/gv100: initial support
      drm/nouveau/fifo/gv100: initial support
      drm/nouveau/ce/gv100: initial support
      drm/nouveau/gr/gv100: initial support
      drm/nouveau/gr/gf100-: insert some WFIs during gr init

Bhawanpreet Lakha (3):
      drm/amd/display: Add debug prints for bandwidth calculations
      drm/amd/display: Correct print types in DC_LOGS
      drm/amd/display: Add Dynamic debug prints

Boris Brezillon (3):
      drm/atomic: Add sanity checks to drm_atomic_helper_async_commit()
      drm/bridge: Add Cadence DSI driver
      dt-bindings: drm/bridge: Document Cadence DSI bridge bindings

Chandra Konduru (6):
      drm/i915: Set scaler mode for NV12
      drm/i915: Update format_is_yuv() to include NV12
      drm/i915: Upscale scaler max scale for NV12
      drm/i915: Add NV12 support to intel_framebuffer_init
      drm/i915: Add NV12 as supported format for primary plane
      drm/i915: Add NV12 as supported format for sprite plane

Changbin Du (1):
      drm/i915/gvt: Remove disable_warn_untrack and print untracked
mmio with debug level

Charlene Liu (4):
      drm/amd/display: add delay between panel pwr off to on.
      drm/amd/display: HDMI has no sound after Panel power off/on
      drm/amd/display: add cursor TTU CRQ related
      drm/amd/display: underflow/blankscreen recovery

Chris Wilson (105):
      drm/i915: Only prune fences after wait-for-all
      drm/i915: Kick the rps worker when changing the boost frequency
      drm/i915: Index the ring frequency table by HW frequency range
      drm/i915: Push irq_shift from gen8_cs_irq_handler() to caller
      drm/i915: Finish the wait-for-wedge by retiring all the inflight requ=
ests
      drm/i915: Update ring position from request on retiring
      drm/i915: Include ring->emit in debugging
      drm/i915: Wrap engine->schedule in RCU locks for set-wedge protection
      drm/i915: Only call tasklet_kill() on the first prepare_reset
      drm/i915: Remove the impedance mismatch around
intel_engine_enable_signaling
      drm/i915: Remove variable length arrays from sseu debugfs printers
      drm/i915: Warn against variable length arrays
      drm/i915: Use sseu size for determining eu_regs[]
      drm/i915: Show GEM_TRACE when detecting a failed GPU idle
      drm/i915: Check rq->timeline before deference
      drm/i915: Trace GEM steps between submit and wedging
      drm/i915: Stop engines when declaring the machine wedged
      drm/i915/stolen: Switch from DEBUG_KMS to DEBUG_DRIVER
      drm/i915/stolen: Checkpatch cleansing
      drm/i915/stolen: Deduce base of reserved portion as top-size on vlv
      drm/i915: Prefer memset64() when filling the iomap
      drm/i915: Trim error mask to known engines
      drm/i915: Specify which engines to reset following semaphore/event lo=
ckups
      drm/i915: Add control flags to i915_handle_error()
      drm/i915/execlists: Use a locked clear_bit() for synchronisation
with interrupt
      drm/i915: Fix tracing of submit seqno
      drm/i915: Remove local timeline var from submit/unsubmit
      drm/i915/selftests: Include the trace as a debug aide
      drm/i915/selftests: Stress resets-vs-request-priority
      drm/i915: Use full serialisation around engine->irq_posted
      drm/i915: Flush pending interrupt following a GPU reset
      drm/i915: Actually flush interrupts on reset not just wedging
      drm/i915/execlists: Clear user-active flag on preemption completion
      drm/i915: Include submission tasklet state in engine dump
      drm/i915/execlists: Avoid kicking the submission too early for
rescheduling
      drm/i915/execlists: Reset ring registers on rebinding contexts
      drm/i915: Include the HW breadcrumb whenever we trace the global_seqn=
o
      drm/i915: Avoid sleeping inside per-engine reset
      drm/i915: Only warn for might_sleep() before a slow wait_for_register
      drm/i915/execlists: Track begin/end of execlists submission sequences
      drm/i915: Store preemption capability in engine->flags
      drm/i915/selftests: Add basic sanitychecks for execlists
      drm/i915: Only call finish_reset after a prepare_reset
      drm/i915/selftests: Avoid repeatedly harming the same innocent contex=
t
      drm/i915/selftests: Rename wait_for_hang() to wait_until_running()
      drm/i915: Split out parking from the idle worker for reuse
      drm/i915: Treat i915_reset_engine() as guilty until proven innocent
      drm/i915: Pass the set of guilty engines to i915_reset()
      drm/i915/psr: Chase psr.enabled only under the psr.lock
      drm/i915: Don't fiddle with rps/rc6 across GPU reset
      drm/i915/guc: Replace %phn with %ph
      drm/i915/execlists: Set queue priority from secondary port
      drm/i915: Check whitelist registers across resets
      drm/i915: Call i915_perf_fini() on init_hw error unwind
      drm/i915: Move the priotree struct to its own headers
      drm/i915: Rename priotree to sched
      drm/i915: Pack params to engine->schedule() into a struct
      drm/i915: Build request info on stack before printk
      drm/i915: Don't dump umpteen thousand requests
      drm/i915: Skip printing global offsets for per-engine scratch pages
      drm/i915/breadcrumbs: Keep the fake irq armed across reset
      drm/i915: Use memset64() to align the ring with MI_NOOP
      drm/i915: Remove obsolete min/max freq setters from debugfs
      drm/i915: Compile out engine debug for release
      drm/i915/selftests: Wait for idle between idle resets as well
      drm/i915/lrc: Scrub the GPU state of the guilty hanging request
      drm/i915: Stop tracking timeline->inflight_seqnos
      drm/i915: Wrap engine->context_pin() and engine->context_unpin()
      drm/i915: Retire requests along rings
      drm/i915: Only track live rings for retiring
      drm/i915/execlists: Don't trigger preemption if complete
      drm/i915/selftests: Fix error checking for wait_var_timeout
      drm/i915: Show ring->start for the ELSP context/request queue
      drm/i915/guc: Assert we have the doorbell before setting it up
      drm/i915: Move timeline from GTT to ring
      drm/i915: Split i915_gem_timeline into individual timelines
      drm/i915/execlists: Emit i915_trace_request_out for preemption
      drm/i915: Silence debugging DRM_ERROR for failing to suspend vlv
powerwells
      drm/i915: Reset the hangcheck timestamp before repeating a seqno
      drm/i915: Mark the hangcheck as idle when unparking the engines
      drm/i915: Lazily unbind vma on close
      drm/i915: Keep one request in our ring_list
      drm/i915/execlists: Drop preemption arbitrations points along the rin=
g
      drm/i915/gtt: Tidy up duplicate branches in gen8_gmch_probe()
      drm/i915: Remove assertion of active_rings must be non-empty if
active_requests
      drm/i915/selftests: Skip the execlists tests on !execlists machines
      drm/i915: Don't request a bug report for unsafe module parameters
      drm/i915/execlists: Drop unused parameter to lookup_priolist()
      drm/i915/execlists: Cache the priolist when rescheduling
      drm/i915/selftests: Refactor common flush_test()
      drm/i915/selftests: Flush GPU activity before completing live_context=
s
      drm/i915/selftests: Return to kernel context after each test
      drm/i915: Flush submission tasklet after bumping priority
      drm/i915: Disable tasklet scheduling across initial scheduling
      drm/i915: Remove unused i915_flip tracepoints
      drm/i915: Annotate timeline lock nesting
      drm/i915/selftests: Create mock_engine() under struct_mutex
      drm/i915/selftests: Only switch to kernel context when locked
      drm/i915/execlists: Make submission tasklet hardirq safe
      drm/i915/guc: Make submission tasklet hardirq safe
      drm/i915/execlists: Use rmb() to order CSB reads
      Revert "drm/i915/cnl: Use mmio access to context status buffer"
      drm/i915/oa: Check that OA is disabled before unpinning
      drm/i915/execlists: Relax CSB force-mmio for VT-d
      drm/i915: Mark up nested spinlocks

Christian K=C3=B6nig (18):
      drm/amdgpu: use ctx bytes_moved
      drm/amdgpu: fix and cleanup cpu visible VRAM handling
      drm/ttm: keep a reference to transfer pipelined BOs
      drm/amdgpu: revert "add new bo flag that indicates BOs don't
need fallback (v2)"
      drm/amdgpu: revert "Don't change preferred domian when fallback GTT v=
6"
      drm/amdgpu: re-validate per VM BOs if required v2
      drm/amdgpu: limit reg_write_reg_wait workaround to SRIOV v2
      drm/amdgpu: print DMA-buf status in debugfs
      drm/amdgpu: add HDP flush dummy for UVD 6/7
      drm/amdgpu: drop printing the BO offset in the gem debugfs (v2)
      drm/amdgpu: print the BO flags in the gem debugfs entry
      drm/amdgpu: remove unused member
      drm/amdgpu: rework VM state machine lock handling v2
      drm/amdgpu: cleanup amdgpu_vm_validate_pt_bos v2
      drm/amdgpu: further optimize amdgpu_vm_handle_moved
      drm/amdgpu: kmap PDs/PTs in amdgpu_vm_update_directories
      drm/amdgpu: consistenly use VM moved flag
      drm/amdgpu: move VM BOs on LRU again

Chunming Zhou (9):
      drm/amdgpu: Don't change preferred domian when fallback GTT v6
      drm/amdgpu: add new bo flag that indicates BOs don't need fallback (v=
2)
      drm/amdgpu: add amdgpu_bo_param
      drm/amdgpu: use amdgpu_bo_param for amdgpu_bo_create v2
      drm/amdgpu: set preferred_domain independent of fallback handling
      drm/amdgpu: handle domain mask checking v2
      drm/amdgpu: fix list not initialized
      drm/amdgpu: abstract bo_base init function
      drm/amdgpu: invalidate parent bo when shadow bo was invalidated

Colin Ian King (6):
      drm/amd/pp: Fix spelling mistake: "suppported" -> "supported"
      drm/amd/display: fix spelling mistake: "Usupported" -> "Unsupported"
      gpu: drm: sti: fix spelling mistake: "initialze" -> "initialize"
      drm/i915/selftests: fix spelling mistake: "parmaters" -> "parameters"
      drm/amd/powerplay: fix spelling mistake: "contruct" -> "construct"
      drm/amd/display: clean up assignment of amdgpu_crtc

Dan Carpenter (6):
      drm/amdkfd: Integer overflows in ioctl
      drm/xen-front: checking for NULL instead of IS_ERR
      drm/xen-front: fix xen_drm_front_shbuf_alloc() error handling
      drm/xen-front: Fix loop timeout
      drm/amd/pp: missing curly braces in smu7_enable_sclk_mclk_dpm()
      drm/exynos: fimc: signedness bug in fimc_setup_clocks()

Daniel Stone (9):
      drm: Reshuffle getfb error returns
      drm/radeon: Move GEM BO to drm_framebuffer
      drm/radeon: radeon_framebuffer -> drm_framebuffer
      drm/amdgpu: Move GEM BO to drm_framebuffer
      drm/tegra: Remove duplicate framebuffer num_planes
      drm/tegra: Move GEM BOs to drm_framebuffer
      drm/tegra: tegra_fb -> drm_framebuffer
      drm/tegra: Move fbdev unmap special case
      drm/tegra: Use drm_gem_fb_destroy

Daniel Vetter (30):
      drm/i915: Select STACKDEPOT for DRM_I915_DEBUG
      drm/gem: Document that handle_create must be the last step
      drm/tinydrm: Use gem_free_object_unlocked
      staging/vboxvideo: Use gem_free_object_unlocked
      drm/rockchip: fixup comment for gem_free_object_unlocked
      drm/udl: Get rid of dev->struct_mutex usage
      drm/i915: Remove skl dc6 enable/disable functions
      drm/i915: Enable edp psr error interrupts on hsw
      drm/vmwgfx: Remove no-op prepare/cleanup_fb callbacks
      drm: Move simple_display_pipe prepare_fb helper into gem fb helpers
      drm/tve200: Use simple_display_pipe prepare_fb helper
      drm/pl111: Use simple_display_pipe prepare_fb helper
      drm/mxsfb: Use simple_display_pipe prepare_fb helper
      drm/atomic: better doc for implicit vs explicit fencing
      drm/xen-front: use simple display pipe prepare_fb helper
      drm: Don't EXPORT drm_add/reset_display_info
      drm/todo: Fallout from v3d review
      dma-fence: Some kerneldoc polish for dma-fence.h
      drm: Drop DRM_CONTROL_ALLOW from ioctls
      drm/i915: Drop DRM_CONTROL_ALLOW
      drm/vmwgfx: Drop DRM_CONTROL_ALLOW
      dma-fence: remove fill_driver_data callback
      dma-fence: Make ->enable_signaling optional
      dma-fence: Allow wait_any_timeout for all fences
      dma-fence: Make ->wait callback optional
      drm: Remove unecessary dma_fence_ops
      drm/qxl: Remove unecessary dma_fence_ops
      Revert 190c462d5be19ba622a82f5fd0625087c870a1e6..bf3012ada1b2222e770d=
e5c35c1bb16f73b3a01d"
      drm/msm: Don't setup control node debugfs files
      drm: remove all control node code

Daniele Ceraolo Spurio (4):
      drm/i915: store all mmio bases in intel_engines
      drm/i915: add a selftest for the mmio_bases table
      drm/i915: use engine->irq_keep_mask when resetting irqs
      drm/i915: move gen8 irq shifts to intel_lrc.c

Dave Airlie (20):
      Merge tag 'drm-misc-next-2018-04-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2018-04-13' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'tilcdc-4.18' of https://github.com/jsarha/linux into drm-n=
ext
      drm/virtio: add define for second capset to the virgl code.
      Merge branch 'drm/du/next' of git://linuxtv.org/pinchartl/media
into drm-next
      Merge branch 'mediatek-drm-next-4.18' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-next
      Merge tag 'exynos-drm-next-for-v4.18' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge tag 'drm-amdkfd-next-2018-05-14' of
git://people.freedesktop.org/~gabbayo/linux into drm-next
      Merge tag 'drm-misc-next-2018-05-15' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2018-05-14' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm-next-4.18' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge drm-fixes-for-v4.17-rc6-urgent into drm-next
      Merge branch 'linux-4.18' of git://github.com/skeggsb/linux into drm-=
next
      Merge branch 'drm-tda998x-devel' of
git://git.armlinux.org.uk/~rmk/linux-arm into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next
      Merge tag 'drm-fsl-dcu-fixes-for-v4.18' of
http://git.agner.ch/git/linux-drm-fsl-dcu into drm-next
      Merge tag 'drm/tegra/for-4.18-rc1' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge branch 'drm-next-4.18' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'exynos-drm-next-for-v4.18-v2' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge tag 'drm-amdkfd-next-2018-05-28' of
git://people.freedesktop.org/~gabbayo/linux into drm-next

David Francis (1):
      drm/amd/display: Remove use of division operator for long longs

David Lechner (1):
      drm/tilcdc: Fix setting clock divider for omap-l138

Dhinakaran Pandiyan (11):
      drm/i915/frontbuffer: Pull frontbuffer_flush out of gem_obj_pin_to_di=
splay
      drm/i915/frontbuffer: HW tracking for cursor moves to fix PSR lags.
      drm/i915/psr: Remove PSR active flag from debugfs
      drm/i915/psr: Comment to clarify SRD_DEBUG is called PSR_MASK SKL+
      drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.
      drm/i915/psr: Move PSR aux setup to it's own function.
      drm/i915/psr: Remove open-coded PSR AUX transactions for SKL+
      drm/i915/icl: HPD pin for port F
      drm/i915/psr: Control PSR interrupts via debugfs
      drm/i915/psr: Timestamps for PSR entry and exit interrupts.
      drm/i915/psr: Check if VBT says PSR can be enabled.

Dirk Hohndel (1):
      Add SPDX idenitifier and clarify license

Dmitry Osipenko (7):
      drm/tegra: dc: Balance IOMMU group refcounting
      drm/tegra: gr2d: Add IOMMU support
      drm/tegra: gr3d: Add IOMMU support
      drm/tegra: dc: Enable plane scaling filters
      drm/tegra: plane: Implement zpos plane property for older Tegras
      drm/tegra: dc: Rename supports_blending to has_legacy_blending
      gpu: host1x: Fix dma_free_wc() argument in the error path

Dmytro Laktyushkin (17):
      drm/amd/display: fix Polaris 12 bw bounding box
      drm/amd/display: add mpc to dtn log
      drm/amd/display: align dtn logs and add mpc idle bit print
      drm/amd/display: hide inconsistent mpcc programming from dtn log
      drm/amd/display: Update scaler v_active data if interlaced
      drm/amd/display: fix segfault on insufficient TG during validation
      drm/amd/display: change dml init to use default structs
      drm/amd/display: add rq/dlg/ttu to dtn log
      drm/amd/display: add calculated clock logging to DTN
      drm/amd/display: compact the rq/dlg/ttu log
      drm/amd/display: get rid of 32.32 unsigned fixed point
      drm/amd/display: inline more of fixed point code
      drm/amd/display: add fixed point fractional bit truncation function
      drm/amd/display: truncate scaling ratios and inits to 19 bit precisio=
n
      drm/amd/display: fix 31_32_fixpt shift functions
      drm/amd/display: fix a 32 bit shift meant to be 64 warning
      drm/amd/display: update dml to allow sync with DV

Douglas Anderson (4):
      drm/bridge: analogix_dp: Reorder plat_data->power_off to happen soone=
r
      drm/bridge: analogix_dp: Properly log AUX CH errors
      drm/bridge: analogix_dp: Properly disable aux chan retries on rockchi=
p
      drm/bridge: analogix_dp: Split the platform-specific poweron in two p=
arts

Emil Goode (1):
      gpu: host1x: Fix compiler errors by converting to dma_addr_t

Emily Deng (4):
      drm/gpu-sched: fix force APP kill hang(v4)
      drm/amdgpu: For sriov reset, move IB test into exclusive mode
      drm/amdgpu/sriov: Need to set in_gpu_reset flag to back after gpu res=
et
      drm/sched: add rcu_barrier after entity fini

Emre Ucan (1):
      drm: rcar-du: Track dma-buf fences

Eric Anholt (9):
      drm/sched: Extend the documentation.
      drm/vc4: Add some missing HVS register definitions.
      drm: Make the prime vmap/vunmap hooks optional.
      drm/vc4: Skip ULPS latching when we're in that ULPS state already.
      drm/panel: Enable DSI transactions on the RPi panel.
      drm/vc4: Add a pad field to align drm_vc4_submit_cl to 64 bits.
      dt-bindings: Add a new binding for Broadcom V3D 3.x and newer GPUs.
      drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+
      drm: Fix render node numbering regression from control node removal.

Eric Bernstein (10):
      drm/amd/display: Change wb_h/vratio to double
      drm/amd/display: Add num_active_wb to DML
      drm/amd/display: Refactor stream encoder for HW review
      drm/amd/display: Make DCN stream encoder shareable
      drm/amd/display: Move dp_pixel_encoding_type to stream_encoder includ=
e
      drm/amd/display: Move DCC support functions into dchubbub
      drm/amd/display: Make program_output_csc HWSS interface function
      drm/amd/display: Refactor otg_blank sequence
      drm/amd/display: Update HW sequencer initialization
      drm/amd/display: DCN1 link encoder

Eric Huang (7):
      drm/amd/powerplay: add smu75 header files
      drm/amd: add a new struct in atombios.h
      drm/amd/powerplay: update ppatomctrl.c (v2)
      drm/amd/powerplay: update process pptables
      drm/amd/powerplay: add smumgr support for VEGAM (v2)
      drm/amd/powerplay: add specific changes for VEGAM in smu7_hwmgr.c
      drm/powerplay: Add powertune table for VEGAM

Eric Yang (4):
      drm/amd/display: Only update mpc blend config if not full update
      drm/amd/display: Set all update flags when we have full update
      drm/amd/display: fix link bw calculation for 422 and 420 encoding
      drm/amd/display: dal 3.1.42

Evan Quan (6):
      drm/amdgpu: add MP1 and THM hw ip base reg offset
      drm/amd/pp: use soc15 common macros instead of vega10 specific
      drm/amd/pp: fix the wrong readout engine clock in deep sleep
      drm/amd/powerplay: new framework to honour DAL clock limits
      drm/amd/powerplay: add a framework for perfroming pre display
configuration change settings
      drm/amd/powerplay: update vega20 cg flags (v2)

Ezequiel Garcia (1):
      dma-buf: Remove unneeded stubs around sync_debug interfaces

Fabio Estevam (2):
      drm: dw-hdmi-i2s: Remove owner assignment from platform_driver
      MAINTAINERS: drm: fsl-dcu: Update to Alison's NXP email address

Feifei Xu (37):
      drm/amdgpu/gfx9: Update golden setting for gfx9_0.
      drm/amdgpu: Drop the unused header files in soc15.c.
      drm/amdgpu: Fix hardcoded base offset of vram pages
      drm/amd: Add vega20_ip_offset.h headerfile for vega20. (v2)
      drm/amdgpu: Add vega20 to asic_type enum.
      drm/amdgpu: Add gpu_info firmware for vega20. (v2)
      drm/amdgpu: set asic family for vega20.
      drm/amdgpu: Add smu firmware support for vega20
      drm/amdgpu/powerplay: Add initial vega20 support v2
      drm/amdgpu/psp: Add initial psp support for vega20
      drm/amdgpu: Add vega20 ucode loading method
      drm/amdgpu: Specify vega20 uvd firmware
      drm/amdgpu: Specify vega20 vce firmware
      drm/amdgpu/virtual_dce: Add vega20 support
      drm/amdgpu/gmc9: Add vega20 support
      drm/amdgpu/mmhub: Add clockgating support for vega20
      drm/amdgpu/sdma4: Specify vega20 firmware
      drm/amdgpu/sdma4: Add vega20 golden settings (v3)
      drm/amdgpu/sdma4: Add clockgating support for vega20
      drm/amdgpu/gfx9: Add support for vega20 firmware
      drm/amdgpu/gfx9: Add vega20 golden settings (v3)
      drm/amdgpu/gfx9: Add gfx config for vega20. (v4)
      drm/amdgpu/gfx9: Add support for vega20
      drm/amdgpu/gfx9: Add clockgatting support for vega20
      drm/amdgpu/soc15:Add vega20 soc15_common_early_init support
      drm/amdgpu/soc15: Set common clockgating for vega20.
      drm/amdgpu/soc15: dynamic initialize ip offset for vega20
      drm/amdgpu/soc15: Add ip blocks for vega20 (v2)
      drm/amdgpu: Add nbio support for vega20 (v2)
      drm/amd/display/dm: Add vega20 support
      drm/amdgpu: Add vega20 to dc support check (v2)
      drm/amd/display: Remove COMBO_DISPLAY_PLL0 from Vega20
      drm/amdgpu: Set vega20 load_type to AMDGPU_FW_LOAD_DIRECT.
      drm/amdgpu: Disable ip modules that are not ready yet
      drm/amdgpu/df: implement df v3_6 callback functions (v2)
      drm/amdgpu: Switch to use df_v3_6_funcs for vega20 (v2)
      drm/amdgpu: Add vega20 pci ids

Felix Kuehling (29):
      drm/amdgpu: Add MMU notifier type for KFD userptr
      drm/amdgpu: Enable amdgpu_ttm_tt_get_user_pages in worker threads
      drm/amdgpu: Avoid reclaim while holding locks taken in MMU notifier
      drm/amdkfd: GFP_NOIO while holding locks taken in MMU notifier
      drm/amdkfd: Add quiesce_mm and resume_mm to kgd2kfd_calls
      drm/amdgpu: Add userptr support for KFD
      drm/amdgpu: Remove unused interface from kfd2kgd interface
      drm/amd: Update GFXv9 SDMA MQD structure
      drm/amdgpu: Add GFXv9 TLB invalidation packet definition
      drm/amdgpu: Add GFXv9 kfd2kgd interface functions
      drm/amdgpu: Add doorbell routing info to kgd2kfd_shared_resources
      drm/amdkfd: Make doorbell size ASIC-dependent
      drm/amdkfd: Implement doorbell allocation for SOC15
      drm/amdkfd: Move packet writer functions into ASIC-specific file
      drm/amdkfd: Add GFXv9 PM4 packet writer functions
      drm/amdkfd: Add GFXv9 MQD manager
      drm/amdkfd: Add GFXv9 device queue manager
      drm/amdkfd: Add SOC15 interrupt processing support
      drm/amdkfd: Fix goto usage
      drm/amdkfd: Fix kernel queue rollback_packet
      drm/amdkfd: Add 64-bit doorbell and wptr support to kernel queue
      drm/amdkfd: Remove limit on number of GPUs (follow-up)
      drm/amdkfd: Support flat memory apertures for GFXv9
      drm/amdkfd: Add GFXv9 CWSR trap handler
      drm/amdkfd: Add Vega10 topology and device info
      drm/amdkfd: Remove redundant include of amd-iommu.h
      drm/amdkfd: Fix signal handling performance again
      drm/amdkfd: Remove initialization of cp_hqd_ib_control on CIK
      drm/amdkfd: Add sanity checks in IRQ handlers

Flora Cui (1):
      drm/amdgpu: init gfx9 aperture settings

Florent Flament (1):
      drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log

Gaurav K Singh (2):
      drm/i915/audio: Fix audio enumeration issue on BXT
      drm/i915/audio: Fix audio detection issue on GLK

Gerd Hoffmann (4):
      qxl: remove qxl_io_log()
      qxl: move qxl_send_monitors_config()
      qxl: hook monitors_config updates into crtc, not encoder.
      qxl: drop dummy functions

Gomonovych, Vasyl (1):
      drm/mediatek: Use ERR_CAST instead of ERR_PTR(PTR_ERR())

Gustavo A. R. Silva (4):
      drm/i915/gvt/scheduler: Remove unnecessary NULL checks in sr_oa_regs
      drm/i915/gvt: Mark expected switch fall-through in handle_g2v_notific=
ation
      drm/i915/selftests: Fix uninitialized variable
      drm/nouveau/secboot: remove VLA usage

Gustavo Padovan (1):
      drm/vc4: update cursors asynchronously through atomic

Haneen Mohammed (1):
      drm: Remove drm_property_{un/reference}_blob aliases

Hans de Goede (3):
      drm/i915: Do NOT skip the first 4k of stolen memory for
pre-allocated buffers v2
      drm: panel-orientation-quirks: Add quirk for Lenovo Ideapad Mixx 310
      drm: panel-orientation-quirks: Add quirk for Lenovo Ideapad Mixx 320

Harish Kasiviswanathan (1):
      drm/amdkfd: Clean up KFD_MMAP_ offset handling

Harry Wentland (22):
      drm/amdgpu: Add CM_TEST_DEBUG regs for DCN
      drm/amd/display: Don't read EDID in atomic_check
      drm/amd/display: Move commit_planes_to_stream to amdgpu_dm
      drm/amd/display: Don't access legacy properties
      drm/amd/display: Only register backlight device if embedded
panel connected
      drm/amd/display: Don't register backlight on connector_destroy
      drm/amd/display: Set ignore_msa_timing_param
      drm/amd/display: Fix potential access beyond end of array in CM
      drm/amd/display: Implement dm_get_timestamp
      drm/amd/display: Fix 64-bit division in hwss_edp_power_control
      drm/amd/display: Remove PRE_VEGA flag
      drm/amd/display: Don't spam debug messages
      Revert "drm/amd/display: fix dereferencing possible ERR_PTR()"
      Revert "drm/amd/display: disable CRTCs with NULL FB on their
primary plane (V2)"
      drm/amd/display: Don't program bypass on linear regamma LUT
      drm/amd/display: Use HBR2 if eDP monitor it doesn't advertise link ra=
te
      drm/amd/display: Disallow enabling CRTC without primary plane with FB
      drm/amd/display: Use int for calculating vline start
      drm/amd/display: Couple formatting fixes
      drm/amd/display: Add VG12 ASIC IDs
      drm/amd/display: Add get_firmware_info_v3_2 for VG12
      drm/amd/display: Don't return ddc result and read_bytes in same
return value

Hawking Zhang (4):
      drm/amdgpu: add df v1_7 header files
      drm/amdgpu: add df callback functions structure
      drm/amdgpu/df: implement df v1_7 callback functions
      drm/amdgpu: switch to use df callback functions

Hersen Wu (2):
      drm/amd/display: Non-HDMI DP active dongle should not support
YUV pixel format
      drm/amd/display: DP link validation bug for YUV422

Huang Rui (21):
      drm/amdgpu: fix null pointer panic with direct fw loading on gpu rese=
t
      drm/amdgpu: update psp gfx if header
      drm/amdgpu: add new rlc firmware header format v2.1
      drm/amdgpu: add save restore list cntl gpm and srm firmware support
      drm/amdgpu: enter rlc safe mode before set cgpg
      drm/amdgpu: cleanup init power gating function
      drm/amdgpu: revise init_rlc_save_restore_list behavior to
support latest register_list_format/register_restore table
      drm/amdgpu: add setting powergating method for gfx9
      drm/amd/powerplay: send CGPG smc message if PG is enabled for raven
      drm/amdgpu: move PP_FEATURE_MASK to amd_shared header
      drm/amdgpu: add gfxoff feature mask
      drm/amdgpu: set gfxoff disabled by default
      drm/amd/powerplay: add gfx off control function
      drm/amd/powerplay: enable/disable gfxoff through smu
      drm/amdgpu: use pp_feature member to store the mask
      drm/amdgpu: clear gfxoff feature mask if the asic is not raven
      drm/amd/powerplay: add control gfxoff enabling in late init
      drm/amdgpu: it should disable gfxoff when system is going to suspend
      drm/amdgpu: fix to disable powergating in hw_fini
      drm/amdgpu: set CGPG if gfxoff is enabled for raven
      drm/amd/powerplay: use the flag to decide whether send gfxoff smc mes=
sage

Ian W MORRISON (1):
      drm/i915/glk: Add MODULE_FIRMWARE for Geminilake

Ilia Mirkin (1):
      drm/nouveau: fix temp/pwm visibility, skip hwmon when no sensors exis=
t

Imre Deak (4):
      drm/i915: Fix hibernation with ACPI S0 target state
      drm/i915/gen9_lp: Increase DDI PHY0 power well enabling timeout
      drm/i915: Enable display WA#1183 from its correct spot
      drm/i915: Add documentation to gen9_set_dc_state()

Inki Dae (3):
      Merge tag 'exynos-drm-fixes-for-v4.17-rc5' of
git://git.kernel.org/.../daeinki/drm-exynos into exynos-drm-next
      Merge tag 'exynos-drm-next-for-v4.18' of
git://git.kernel.org/.../daeinki/drm-exynos into exynos-drm-next
      drm/exynos: scaler: fix static checker warning

Jackie Li (5):
      drm/i915/guc: Rename guc_ggtt_offset to intel_guc_ggtt_offset
      drm/i915: Implement dynamic GuC WOPCM offset and size calculation
      drm/i915: Add support to return CNL specific reserved WOPCM size
      drm/i915: Add HuC firmware size related restriction for Gen9 and CNL =
A0
      drm/i915/guc: Check the locking status of GuC WOPCM registers

Jacopo Mondi (2):
      dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
      drm: bridge: Add thc63lvd1024 LVDS decoder driver

James Ausmus (1):
      drm/i915/icl: Don't set pipe CSC/Gamma in PLANE_COLOR_CTL

James Zhu (10):
      drm/amdgpu: Added support for MV packet
      drm/amd/include/vg20: adjust VCE_BASE to reuse vce 4.0 header files
      drm/amdgpu/vg20:Restruct uvd to support multiple uvds
      drm/amdgpu/vg20:Restruct uvd.inst to support multiple instances
      drm/amdgpu/vg20:increase 3 rings for AMDGPU_MAX_RINGS
      drm/amdgpu/vg20:Enable the 2nd instance for uvd
      drm/amdgpu/vg20:Add IH client ID for the 2nd UVD
      drm/amdgpu/vg20:Enable the 2nd instance IRQ for uvd 7.2
      drm/amdgpu/vg20:Enable 2nd instance queue maping for uvd 7.2
      drm/amdgpu/vg20:Enable UVD/VCE for Vega20

Jani Nikula (22):
      drm/i915/icl: do not save DDI A/E sharing bit for ICL
      drm: prefer inline over __inline__
      drm: remove old documentation comment cruft from drmP.h
      drm: make drm_core_check_feature() bool that it is
      drm/i915/bios: remove duplicated code
      drm/i915/bios: filter out invalid DDC pins from VBT child devices
      drm/i915/bios: reduce the scope of some local variables in
parse_ddi_port()
      drm/i915: Update DRIVER_DATE to 20180413
      drm/i915/dsi: improve dphy param limits logging
      Merge tag 'gvt-next-2018-04-23' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: prefer INTEL_GEN() over INTEL_INFO()->gen
      drm/i915/dp: remove stale comment about bw constants
      drm/i915/dp: move link_bw and rate_select debugging where used
      drm/i915/dp: abstract dp link config computation from the rest
      drm/i915/dp: move eDP VBT bpp clamping code to intel_dp_compute_bpp()
      drm/i915/dp: group link config limits in a struct
      drm/i915/dp: abstract link config selection
      drm/i915/dp: fix compliance test adjustments
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915: add support for specifying DMC firmware override by module =
param
      Merge tag 'gvt-next-2018-05-14' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20180514

Jay Cornwall (2):
      drm/amdkfd: Reduce priority of context-saving waves before spin-wait
      drm/amdkfd: Use volatile MTYPE in default/alternate apertures

Jerry (Fangzhi) Zuo (8):
      drm/amd/display: Implement VEGAM device IDs in DC
      drm/amd/display: Implement VEGAM device IDs in DM
      drm/amd/display: Update MST edid property every time
      drm/amd/display: Check dc_sink every time in MST hotplug
      drm/amd: Add BIOS smu_info v3_3 required struct def.
      drm/amd/display: Add Vega20 config. support
      drm/amd/display: Add BIOS smu_info v3_3 support for Vega20
      drm/amd/display: Add harvest IP support for Vega20

Jia-Ju Bai (1):
      gpu: drm: bridge: adv7511: Replace mdelay with usleep_range in
adv7511_probe

John Keeping (1):
      drm/rockchip: fix VOP vblank race

Jos=C3=A9 Roberto de Souza (13):
      drm: Add DP PSR2 sink enable bit
      drm: Add DP last received PSR SDP VSC register and bits
      drm/i915/psr: Nuke aux frame sync
      drm/i915/psr: Tie PSR2 support to Y coordinate requirement
      drm/i915/psr/cnl: Enable Y-coordinate support in source
      drm/i915/psr: Do not override PSR2 sink support
      drm/i915/psr: Use PSR2 macro for PSR2
      drm/i915/psr: Cache sink synchronization latency
      drm/i915/psr: Set DPCD PSR2 enable bit when needed
      drm/i915/fbdev: Enable late fbdev initial configuration
      drm/i915/psr/skl+: Print information about what caused a PSR exit
      drm/i915/debugfs: Print sink PSR status
      drm/i915/psr/cnl: Set y-coordinate as valid in SDP

Julian Parkin (3):
      drm/amd/display: drop dc_validate_guaranteed
      drm/amd/display: Add assert that chroma pitch is non zero
      drm/amd/display: reprogram infoframe during apply_ctx_to_hw

Jun Lei (3):
      drm/amd/display: remove unused enum
      drm/amd/display: Fill calcs date from stream src/dst if available
      drm/amd/display: constify a few dc_surface_update fields

Junwei Zhang (6):
      drm/amdgpu: simplify bo_va list when vm bo update (v2)
      drm/amdgpu: bo could be null when access in vm bo update
      drm/amd/powerplay: add PME smu message for raven
      drm/ttm: remove priority hard code when initializing ttm bo
      drm/amdgpu: set ttm bo priority before initialization
      drm/amdgpu: fix null pointer for bo unmap trace function

Kelvin Gardiner (2):
      drm/i915/icl: Update subslice define for ICL 11
      drm/i915/icl: Added ICL 11 slice, subslice and EU fuse detection

Kenneth Feng (5):
      amd/powerplay: implement the vega12_force_clock_level interface
      drm/amd/powerplay: Get more than 8 level gfxclk states
      drm/amd/powerplay: initialzie the dpm intial enabled state
      drm/amd/powerplay: header file interface to SMU update
      drm/amd/powerplay: add registry key to disable ACG

Kevin Rogovin (3):
      drm/i915: Narration overview on GEM
      drm/i915: Add link to documentation in i915_gem_execbuffer.c
      drm/i915: Describe the bottom of stack in processing a batchbuffer

Kieran Bingham (11):
      dt-bindings: adv7511: Extend bindings to allow specifying slave
map addresses
      drm: adv7511: Add support for i2c_new_secondary_device
      drm: rcar-du: of: Include header to define prototypes
      drm: rcar-du: Use NULL for table initialisation
      dt-bindings: display: renesas: du: Increase indent in output table
      dt-bindings: display: renesas: du: Document the r8a77965 bindings
      drm: rcar-du: Use the correct naming for ODPM fields in DEFR6
      dt-bindings: display: renesas: Add R-Car M3-N HDMI TX DT bindings
      drm: rcar-du: Split CRTC handling to support hardware indexing
      drm: rcar-du: Allow DU groups to work with hardware indexing
      drm: rcar-du: Add R8A77965 support

Kristian H. Kristensen (1):
      drm/rockchip: Disable blending for win0

Krunoslav Kovac (1):
      drm/amd/display: Add user_regamma to color module

Laura Abbott (1):
      drm/amdkfd: Remove vla

Laurent Pinchart (3):
      drm: rcar-du: Zero-out sg_tables when duplicating plane state
      drm: rcar-du: Fix rcar_du_of_init() stub
      drm: rcar-du: Fix build failure

Leo (Sunpeng) Li (3):
      drm/amd/display: Fix dim display on DCE11
      drm/amd/display: Fix memleak on input transfer function
      drm/amd/display: Fix regamma not affecting full-intensity color value=
s

Leo Liu (26):
      drm/amdgpu: add VEGAM ASIC type
      drm/amdgpu: bypass GPU info firmware load for VEGAM
      drm/amdgpu: set VEGAM to ASIC family and ip blocks
      drm/amdgpu: specify VEGAM ucode SMU load method
      drm/amdgpu: add VEGAM SMU firmware support
      drm/amdgpu/virtual_dce: add VEGAM support
      drm/amdgpu: add VEGAM dc support check
      drm/amdgpu: skip VEGAM MC firmware load
      drm/amdgpu: add VEGAM GMC golden settings
      drm/amdgpu: initialize VEGAM GMC (v2)
      drm/amdgpu: add VEGAM SDMA firmware support
      drm/amdgpu: add VEGAM SDMA golden settings
      drm/amdgpu: add VEGAM GFX firmware support
      drm/amdgpu: add VEGAM GFX golden settings
      drm/amdgpu: initialize VEGAM GFX
      drm/amdgpu: add VEGAM UVD firmware support
      drm/amdgpu: add VEGAM UVD encode support
      drm/amdgpu: add VEGAM VCE firmware support
      drm/amdgpu: add VEGAM to VCE harvest config
      drm/amdgpu: add VEGAM support to vi
      drm/amdgpu: add VEGAM pci ids
      drm/amdgpu: fix insert nop for VCN decode ring
      drm/amdgpu: fix insert nop for UVD7 ring
      drm/amdgpu: fix insert nop for UVD6 ring
      drm/amdgpu: fix insert nop for UVD5 ring
      drm/amdgpu: fix insert nop for UVD4.2 ring

Lin Huang (6):
      drm/bridge: analogix_dp: Move enable video into config_video()
      drm/bridge: analogix_dp: Check AUX_EN status when doing AUX transfer
      drm/bridge: analogix_dp: Ensure edp is disabled when shutting
down the panel
      drm/bridge: analogix_dp: Extend hpd check time to 100ms
      drm/bridge: analogix_dp: Check dpcd write/read status
      drm/bridge: analogix_dp: Reset aux channel if an error occurred

Linus Walleij (3):
      drm/pl111: Support the Versatile Express
      drm/pl111: Enable device-specific assigned memory
      drm/pl111: Fix module probe bug

Lionel Landwerlin (6):
      drm/i915/perf: enable perf support on ICL
      drm/i915/perf: check the value of PROP_SAMPLE_OA uapi parameter
      drm/i915/perf: simplify OA unit enabling on gen7
      drm/i915/perf: remove empty line
      drm/i915: rename PPGTT/GGTT fields OA registers
      drm/i915/perf: add more debug message on perf open & configs

Luc Van Oostenryck (18):
      drm/ast: fix mode_valid's return type
      drm/bridge: adv7511: fix mode_valid's return type
      drm/hisilicon: fix mode_valid's return type
      drm/mgag200: fix mode_valid's return type
      drm/udl: fix mode_valid's return type
      drm/bochs: fix mode_valid's return type
      drm/bridge: tc358767: fix mode_valid's return type
      drm/gma500: fix mode_valid's return type
      drm/gma500: fix psb_intel_lvds_mode_valid()'s return type
      drm/qxl: fix mode_valid's return type
      drm/i2c: tda998x: fix mode_valid's return type
      drm/virtio: fix mode_valid's return type
      drm/amdgpu: fix amdgpu_atpx_get_client_id()'s return type
      drm/radeon: fix radeon_atpx_get_client_id()'s return type
      drm/radeon: fix mode_valid's return type
      drm/admgpu: fix mode_valid's return type
      drm/nouveau: fix mode_valid's return type
      drm/nouveau: fix nouveau_dsm_get_client_id()'s return type

Lucas De Marchi (8):
      drm/i915: Reword warning for missing cases
      drm/i915: move dpll_info to header
      drm/i915: add dpll_info inside intel_shared_dpll
      drm/i915: use funcs from intel_shared_dpll.info
      drm/i915: use name from intel_shared_dpll.info
      drm/i915: use id from intel_shared_dpll.info
      drm/i915: use flags from dpll_info embedded in intel_shared_dpll
      drm/i915: reorder dpll_info members

Lucas Stach (6):
      drm/etnaviv: remove cycling through MMU address space
      drm/etnaviv: remove register logging
      drm/etnaviv: switch MMU page tables to writecombine memory
      drm/etnaviv: mmuv2: allocate 2nd level page tables on demand
      drm/etnaviv: mmuv2: support 40 bit phys address
      drm/etnaviv: replace license text with SPDX tags

Lyude Paul (3):
      drm/i915: Remove unused DP_LINK_CHECK_TIMEOUT
      drm/i915/dp: Send DPCD ON for MST before phy_up
      drm/atomic: Print debug message on atomic check failure

Maarten Lankhorst (14):
      drm/i915: Handle pipe CRC around enabling/disabling pipe.
      drm/i915: Change use get_new_plane_state instead of existing plane st=
ate
      drm/i915: Remove get_existing_crtc_state
      drm/i915: Remove last references to drm_atomic_get_existing* macros
      drm/i915: Add debugfs file to clear FIFO underruns.
      Merge tag 'mmio-clk-config' of
https://git.kernel.org/.../broonie/regmap into drm-misc-next
      drm/rect: Round above 1 << 16 upwards to correct scale
calculation functions.
      drm/rect: Handle rounding errors in drm_rect_clip_scaled, v3.
      drm/i915: Do not adjust scale when out of bounds, v2.
      drm/selftests: Rename the Kconfig option to CONFIG_DRM_DEBUG_SELFTEST
      drm/selftests: Add drm helper selftest
      drm/i915: Enable display workaround 827 for all planes, v2.
      drm/i915: Add skl_check_nv12_surface for NV12
      Merge remote-tracking branch 'drm/drm-next' into drm-misc-next

Mahesh Kumar (14):
      drm/i915/cnl; Add macro to get PORT_TX register
      drm/i915/cnl: Kill _MMIO_PORT6 macro
      drm/i915/skl+: rename skl_wm_values struct to skl_ddb_values
      drm/i915/skl+: refactor WM calculation for NV12
      drm/i915/skl+: add NV12 in skl_format_to_fourcc
      drm/i915/skl+: support verification of DDB HW state for NV12
      drm/i915/skl+: NV12 related changes for WM
      drm/i915/skl+: pass skl_wm_level struct to wm compute func
      drm/i915/skl+: make sure higher latency level has higher wm value
      drm/i915/skl+: nv12 workaround disable WM level 1-7
      drm/i915/skl: split skl_compute_ddb function
      drm/i915/icl: track dbuf slice-2 status
      drm/i915/icl: Enable 2nd DBuf slice only when needed
      drm/i915/icl: update ddb entry start/end mask during hw ddb readout

Manasi Navare (7):
      drm/i915/icl: Add register definitions for Combo PHY vswing sequences=
.
      drm/i915/icl: Add Combo PHY DDI Buffer translation tables for Icelake=
.
      drm/i915/icl: Add register defs for voltage swing sequences for MG PH=
Y DDI
      drm/i915/icl: Add Voltage swing table for MG PHY DDI Buffer
      drm/dp: Rename the edp_sdp_header as dp_sdp_header
      drm/i915/icl: Implement voltage swing programming sequence for
Combo PHY DDI
      drm/i915/icl: Fix the DP Max Voltage for ICL

Marek Ol=C5=A1=C3=A1k (1):
      drm/amdgpu: optionally do a writeback but don't invalidate TC
for IB fences

Marek Szyprowski (8):
      drm/exynos: ipp: Add IPP v2 framework
      drm/exynos: rotator: Convert driver to IPP v2 core API
      drm/exynos: gsc: Convert driver to IPP v2 core API
      drm/exynos: fimc: Convert driver to IPP v2 core API
      dt-bindings: exynos5433-decon: add more required clocks
      drm/exynos: decon: Add support for hardware windows no 4 and 5
      drm/exynos: Fix error value in exynos_drm_crtc_get_by_type()
      drm/exynos: Fix default value for zpos plane property

Mark Yao (1):
      drm/rockchip: pre dither down when output bpc is 8bit

Martin Tsai (2):
      drm/amd/display: correct the condition in setting cursor not
visible beyond left edge
      drm/amd/display: to synchronize the hubp and dpp programming in
cursor control

Mathieu Malaterre (1):
      drm/radeon: Change the default to PCI on PowerPC

Matt Atwood (3):
      drm/i915/kbl: Add KBL GT2 sku
      drm/dp: Add DP_DPCD_REV_XX to drm_dp_helper
      drm/dp: Correctly mask DP_TRAINING_AUX_RD_INTERVAL values for DP 1.4

Matthew Auld (3):
      drm/i915/userptr: reject zero user_size
      drm/i915: don't leak the pin_map on error
      drm/i915/selftests: scrub 64K

Matthias Kaehlcke (1):
      drm/i915: Disable some extra clang warnings

Maxime Ripard (9):
      drm/sun4i: tcon: Add TRI finish interrupt for vblank
      dt-bindings: display: Add Allwinner MIPI-DSI bindings
      drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
      drm/sun4i: Tie the DSI controller in the TCON
      drm/blend: Add a generic alpha property
      drm/atmel-hclcdc: Convert to the new generic alpha property
      drm/rcar-du: Convert to the new generic alpha property
      drm/sun4i: Add support for plane alpha
      drm/docs: Remove the rcar alpha from the csv file

Michal Wajdeczko (29):
      drm/i915/guc: Move GuC notification handling to separate function
      drm/i915: Include i915_reg.h in intel_ringbuffer.h
      drm/i915: Change parameters order in i915_gem_batch_pool_init
      drm/i915: Make header i915_pmu.h more robust
      drm/i915: Move i915_gpu_error into its own header
      drm/i915/uc: Sanitize uC options early
      drm/i915/uc: Sanitize uC together with GEM
      drm/i915: Split GPU commands definitions into separate header
      drm/i915/guc: Update syntax of GuC log functions
      drm/i915/guc: Fix build break on config without DEBUG_FS
      drm/i915/huc: Check HuC status in dedicated function
      drm/i915/guc: Unify naming of private GuC action functions
      drm/i915/guc: Drop union guc_log_control
      drm/i915/guc: Move enable/disable msg functions to GuC header
      drm/i915/guc: Handle GuC log flush event in dedicated function
      drm/i915/guc: Unify parameters of public CT functions
      drm/i915: Reorder early initialization
      drm/i915/uc: Fetch uC firmware in init_early
      drm/i915/guc: Add documentation for MMIO based communication
      drm/i915/guc: Add support for data reporting in GuC responses
      drm/i915/guc: Prepare send() function to accept bigger response
      drm/i915/guc: Implement response handling in send_mmio()
      drm/i915/guc: Make event handler a virtual function
      drm/i915/guc: Prepare to handle messages from CT RECV buffer
      drm/i915/guc: Use better name for helper wait function
      drm/i915/guc: Implement response handling in send_ct()
      drm/i915/guc: Prepare to process incoming requests from CT
      drm/i915/guc: Handle default action received over CT
      drm/i915/guc: Trace messages from CT while in debug

Micha=C5=82 Winiarski (15):
      drm/i915/guc: Tidy guc_log_control
      drm/i915/guc: Create common entry points for log register/unregister
      drm/i915/guc: Keep GuC interrupts enabled when using GuC
      drm/i915/guc: Log runtime should consist of both mapping and relay
      drm/i915/guc: Merge log relay file and channel creation
      drm/i915/guc: Flush directly in log unregister
      drm/i915/guc: Split relay control and GuC log level
      drm/i915/guc: Move check for fast memcpy_wc to relay creation
      drm/i915/guc: Get rid of GuC log runtime
      drm/i915/guc: Always print log stats in i915_guc_info when using GuC
      drm/i915/guc: Don't print out relay statistics when relay is disabled
      drm/i915/guc: Allow user to control default GuC logging
      drm/i915/guc: Default to non-verbose GuC logging
      drm/i915/guc: Demote GuC error messages
      drm/i915/guc: Don't try to enable GuC logging when we're not using Gu=
C

Michel D=C3=A4nzer (2):
      drm/amd/display: Use kvzalloc for potentially large allocations
      drm/ttm: Use GFP_TRANSHUGE_LIGHT for allocating huge pages

Michel Thierry (3):
      drm/i915/guc: enable guc interrupts unconditionally in uc_resume
      drm/i915/icl: Add reset control register changes
      drm/i915/gen9: Add WaClearHIZ_WM_CHICKEN3 for bxt and glk

Mika Kuoppala (7):
      drm/i915: Avoid setting ring freq on invalid rps freqs
      drm/i915/icl: Use hw engine class, instance to find irq handler
      drm/i915/cnl: Use mmio access to context status buffer
      drm/i915: Use ktime on wait_for
      drm/i915: Add compiler barrier to wait_for
      drm/i915: Print error state times relative to capture
      drm/i915/gtt: Trust the uncached store to flush wcb

Mikita Lipski (10):
      drm/amd/display: Don't call amdgpu_dm_display_resume as it doesn't ex=
ist
      drm/amd/display: Adding stutter entry wm to dce bw struct
      drm/amd/display: Implementing new bandwidth registers for DCE120
      drm/amd/display: Separate mem input constuctors for dce 112 and 120
      drm/amd/pp: Adding set_watermarks_for_clocks_ranges for SMU10
      drm/amd/pp: Adding a function to store cc6 data in SMU10
      drm/amd/display: Fix deadlock when flushing irq
      drm/amd/display: Unify dm resume sequence into a single call
      drm/amd/powerplay: Add notify PWE function to SMU10
      drm/amd/display: Clear connector's edid pointer

Nabendu Maiti (1):
      drm/i915/icl: Added 5k source scaling support for Gen11 platform

Nayan Deshmukh (4):
      drm/scheduler: fix param documentation
      drm/scheduler: move the tracepoints file from the include directory
      drm/scheduler: remove unused parameter
      drm/scheduler: fix function name prefix in comments

Nico Sneck (1):
      drm/radeon: add PX quirk for Asus K73TK

Nicolai H=C3=A4hnle (1):
      drm/amdgpu: set COMPUTE_PGM_RSRC1 for SGPR/VGPR clearing shaders

Nikola Cornij (4):
      drm/amd/display: Update ASIC header files
      drm/amd/display: Rename feature-specific register address init macro
      drm/amd/display: Log DTN only after the atomic commit in Diag
      drm/amd/display: Clear underflow status for debug purposes

Noralf Tr=C3=B8nnes (1):
      drm: Use srcu to protect drm_device.unplugged

Oak Zeng (1):
      drm/amdkfd: Dump HQD of HIQ

Oded Gabbay (1):
      drm/amdgpu: conditionally compile amdgpu's amdkfd files

Oleksandr Andrushchenko (3):
      drm/xen-front: Add support for Xen PV display frontend
      MAINTAINERS: Add drm/xen-front maintainer entry
      drm/xen-front: Remove CMA support

Oliver O'Halloran (1):
      drm/sti: Depend on OF rather than selecting it

Oscar Mateo (22):
      drm/i915/icl: Check for fused-off VDBOX and VEBOX instances
      drm/i915/icl: Enable the extra video decode and enhancement
boxes for Icelake 11
      drm/i915/icl: Handle RPS interrupts correctly for Gen11
      drm/i915/icl: Deal with GT INT DW correctly
      drm/i915/icl: Enable RC6 and RPS in Gen11
      drm/i915: Move a bunch of workaround-related code to its own file
      drm/i915: Split out functions for different kinds of workarounds
      drm/i915/selftests: Handle a potential failure of intel_ring_begin
      drm/i915/icl: Correctly clear lost ctx-switch interrupts across
reset for Gen11
      drm/i915/icl: Introduce initial Icelake Workarounds
      drm/i915/icl: Enable Sampler DFR
      drm/i915/icl: WaGAPZPriorityScheme
      drm/i915/icl: WaL3BankAddressHashing
      drm/i915/icl: WaModifyGamTlbPartitioning
      drm/i915/icl: WaDisableCleanEvicts
      drm/i915/icl: WaCL2SFHalfMaxAlloc
      drm/i915/icl: WaDisCtxReload
      drm/i915/icl: Wa_1405779004
      drm/i915/icl: Wa_1406680159
      drm/i915/icl: Wa_1604302699
      drm/i915/icl: Wa_1406838659
      drm/i915/icl: WaForwardProgressSoftReset

Paulo Zanoni (7):
      drm/i915: protect macro parameters in SWING_SEL_{UPP,LO}WER
      drm/i915/gen11: add support for reading the timestamp frequency
      drm/i915/icl: add definitions for the ICL PLL registers
      drm/i915/icl: add basic support for the ICL clocks
      drm/i915/icl: compute the combo PHY (DPLL) HDMI registers
      drm/i915/icl: compute the combo PHY (DPLL) DP registers
      drm/i915/icl: compute the MG PLL registers

Pawe=C5=82 Chmiel (1):
      drm/exynos: Allow DRM_EXYNOS on s5pv210.

Peter Rosin (1):
      drm/bridge: adv7511: fix spelling of driver name in Kconfig

Peter Ujfalusi (6):
      drm: Add drm_mode_config->normalize_zpos boolean
      drm/exynos: Let core take care of normalizing the zpos
      drm/tegra: Let core take care of normalizing the zpos
      drm/sti: Let core take care of normalizing the zpos
      drm: rcar-du: Let core take care of normalizing the zpos
      drm/omap: Use normalized zpos for plane placement

Philip Yang (1):
      drm/amdkfd: use %px to print user space address instead of %p

Philippe CORNU (8):
      drm/stm: move enable/disable_vblank to crtc
      drm/stm: ltdc: add user update info in plane print state
      drm/stm: ltdc: fix warning in ltdc_crtc_update_clut()
      drm/bridge/synopsys: dsi: Adopt SPDX identifiers
      drm/bridge/synopsys: dsi: use adjusted_mode in mode_set
      drm/stm: ltdc: fix deferred endpoint management
      drm/stm: ltdc: add mode_valid()
      drm/stm: ltdc: fix warnings in ltdc_plane_create()

Piorkowski, Piotr (1):
      drm/i915/guc: Remove GUC_CTL_DEVICE_INFO parameter

Piotr Pi=C3=B3rkowski (1):
      drm/i915/guc: Fix null pointer dereference when GuC FW is not availab=
le

Pixel Ding (3):
      drm/scheduler: always put last_sched fence in entity_fini
      drm/scheduler: move last_sched fence updating prior to job popping (v=
2)
      drm/scheduler: don't update last scheduled fence in TDR

Radhakrishna Sripada (1):
      drm/i915: Fix memory leak in intel_hdcp auth

Ramalingam C (3):
      drm/i915: Read HDCP R0 thrice in case of mismatch
      drm/i915: Read Vprime thrice incase of mismatch
      drm/i915: Check hdcp key loadability

Rex Zhu (55):
      drm/amd/pp: Remove useless fw load error handler on Polaris
      drm/amd/pp: Add hwmgr_sw_init/fini functioins
      drm/amd/pp: Lock pm_funcs when set pp table
      drm/amd/pp: Save vf state in pp context
      drm/amd/pp: Use release_firmware directly in powerplay
      drm/amdgpu: Use dpm_enabled as dpm state flag
      drm/amd/pp: Use gfx rlc funcs directly in powerplay
      drm/amdgpu: Get pci resource directly through adev
      drm/amd/dc: Use atombios api directly in DC
      drm/amd/pp: Use atombios api directly in powerplay (v2)
      drm/amdgpu: Set pm_display_cfg in non-dc mode
      drm/amd/pp: Not call cgs interface to get display info
      drm/amdgpu: Delete some cgs functions
      drm/amdgpu: remove duplicate cg/pg wrapper functions
      drm/amd/display: Disentangle dc.h include from amdgpu.h
      drm/amd/pp: Refine pp_atomfwctrl_get_vbios_bootup_values
      drm/amd/pp: Move same macro definitions to hwmgr.h
      drm/amd/pp: Remove unnecessary forward declaration
      drm/amdgpu: Add APU support in vi_set_uvd_clocks
      drm/amdgpu: Add APU support in vi_set_vce_clocks
      drm/amd/pp: Remove dead function in smu7_smumgr.c
      drm/amd/pp: Remove useless smu7 running state check
      Revert "drm/amd/powerply: fix power reading on Fiji"
      drm/amd/pp: Refine get_gpu_power for VI
      drm/amd/pp: Remove struct pp_gpu_power
      drm/amd/pp: Clear smu response register before send smu message
      drm/amd/pp: Move common code to smu_helper.c
      drm/amdgpu: Reserved vram for smu to save debug info.
      drm/amd/pp: Remove dead interface
      drm/amd/pp: Fix bug voltage can't be OD separately on VI
      drm/amd/pp: Fix NULL point check error in
smu_set_watermarks_for_clocks_ranges
      drm/amd/pp: Change pstate_clk frequency unit to 10KHz on Rv
      drm/amd/pp: Use dynamic gfx_clk rather than hardcoded values
      drm/amd/pp: Refine the OD state checking code in smu7
      drm/amd/pp: Change voltage/clk range for OD feature on VI
      drm/amd/pp: Print out voltage/clock range in sysfs
      drm/amd/pp: Add OVERDRIVE support on Vega10 (v2)
      drm/amd/pp: Skip fan attributes if fan not present
      drm/amdgpu: Fix display corruption on CI with dpm enabled
      drm/amd/pp: Refine the output of pp_power_profile_mode on VI
      drm/amd/pp: Implement force_clock_level for RV
      drm/amd/pp: Fix performance drop on Fiji
      drm/amd/pp: Workaround flickering issue on RV
      drm/amd/pp: Fix build warning in vegam
      drm/amd/pp: Fix static checker warning
      drm/amd/pp: fix a couple locking issues
      drm/amdgpu: skip CG for VCN when late_init/fini
      drm/amd/pp: Add smu support for VCN powergating on RV
      drm/amdgpu: Add CG/PG flags for VCN
      drm/amdgpu: Add SOC15_WAIT_ON_RREG macro define
      drm/amdgpu: Add static CG control for VCN on RV
      drm/amdgpu: Enable VCN CG by default on RV
      drm/amdgpu: Add VCN static PG support on RV
      drm/amdgpu: Enable VCN static PG by default on RV
      drm/amdgpu: Add runtime VCN PG support

Rodrigo Vivi (5):
      drm/i915/psr: Display WA 0884 applied broadly for more HW tracking.
      drm/i915/psr: Use more PSR HW tracking.
      drm/i915: Move CUR SURFLIVE definition to a better place.
      Merge airlied/drm-next into drm-intel-next-queued
      drm/i915: Adjust eDP's logical vco in a reliable place.

Roman Li (4):
      drm/amd/display: add assert in enable FBC
      drm/amd/display: Fix FBC text console corruption
      drm/amd/display: fix brightness level after resume from suspend
      drm/amd: Add dce-12.1 gpio aux registers (v2)

Russell King (8):
      drm/i2c: tda998x: move mutex/waitqueue/timer/work init early
      drm/i2c: tda998x: fix error cleanup paths
      drm/i2c: tda998x: move CEC device initialisation later
      drm/i2c: tda998x: always disable and clear interrupts at probe
      drm/i2c: tda9950: add CEC driver
      drm/i2c: tda998x: add CEC support
      dt-bindings: tda998x: add the calibration gpio
      drm/etnaviv: correct timeout calculation

Samson Tam (1):
      drm/amd/display: don't create new dc_sink if nothing changed at detec=
tion

Samuel Li (4):
      drm: add parameter explanation for some gem dmabuf_ops
      drm/amdgpu: Rename amdgpu_display_framebuffer_domains()
      drm/amdgpu: Remove VRAM from shared bo domains.
      drm/amdgpu: Enable scatter gather display support

Satendra Singh Thakur (2):
      drm/mediatek: Using the function drm_display_mode_to_videomode
      drm/atomic: Handling the case when setting old crtc for plane

Sean Paul (1):
      Merge airlied/drm-next into drm-misc-next

Shaoyun Liu (2):
      drm/amdkfd: Remove queue node when destroy queue failed
      drm/amdgpu: Update GFX info structure to match what vega20 used

Shashank Sharma (2):
      drm: Add aspect ratio parsing in DRM layer
      drm: Add and handle new aspect ratios in DRM layer

Shirish S (4):
      drm/amd/display: remove dummy is_blanked() to optimise boot time
      drm/amdgpu: defer test IBs on the rings at boot (V3)
      drm/amd/display: disable FBC on underlay pipe
      drm/amd/display: remove need of modeset flag for overlay planes (V2)

SivapiriyanKumarasamy (1):
      drm/amd/display: Add vline IRQ programming for DCN

Souptick Joarder (3):
      gpu: drm: exynos: Change return type to vm_fault_t
      gpu: drm: qxl: Adding new typedef vm_fault_t
      drm/tegra: Adding new typedef vm_fault_t

Stefan Schake (9):
      drm/vc4: Expose gamma as atomic property
      drm/vc4: Move CRTC state to header
      drm/vc4: Add support for plane alpha
      drm/vc4: Add CTM support
      drm/vc4: Add CTM registers to debugfs
      drm/vc4: Syncobj import support
      drm/vc4: Export fence through syncobj
      drm/vc4: Enable syncobj support
      drm/tegra: hub: Use state directly

Stephen Rothwell (1):
      drm/amdgpu: include pagemap.h for release_pages()

Tarun (1):
      drm/i915: Remove redundant check for negative timeout while
doing an atomic pipe update

Thierry Reding (21):
      drm/tegra: dc: Free syncpoint on errors
      drm/tegra: gr2d: Properly clean up resources
      drm/tegra: gr3d: Properly clean up resources
      drm/tegra: Refactor IOMMU attach/detach
      drm/tegra: Fix order of teardown in IOMMU case
      drm/tegra: Acquire a reference to the IOVA cache
      gpu: host1x: Acquire a reference to the IOVA cache
      gpu: host1x: Remove wait check support
      gpu: host1x: Store pointer to client in jobs
      gpu: host1x: Cleanup loop variable usage
      gpu: host1x: Drop unnecessary host1x argument
      gpu: host1x: Rename relocarray -> relocs for consistency
      gpu: host1x: Use not explicitly sized types
      drm/tegra: Use proper arguments for DRM_TEGRA_CLOSE_CHANNEL IOCTL
      drm/tegra: gem: Fill in missing export info
      drm/tegra: dc: Support rotation property
      drm/tegra: Track client version
      drm/tegra: gr2d: Track interface version
      drm/tegra: gr3d: Track interface version
      drm/tegra: vic: Track interface version
      drm/tegra: Add kerneldoc for UAPI

Tom Callaway (1):
      drm/tinydrm/mi0283qt: Always set rotation value

Tom St Denis (3):
      drm/amd/amdgpu: vcn10 Add callback for emit_reg_write_reg_wait
      drm/amd/amdgpu: Add some documentation to the debugfs entries
      drm/amd/amdgpu:  Code comments for the amdgpu_ttm.c driver. (v2)

Tom Stellard (1):
      drm/amdgpu: Use dev_info() to report amdkfd is not supported for this=
 ASIC

Tomasz Figa (6):
      drm/rockchip: analogix_dp: Do not call Analogix code before bind
      drm/rockchip: psr: Avoid redundant calls to .set() callback
      drm/rockchip: psr: Sanitize semantics of allow/inhibit API
      drm/rockchip: Disallow PSR for the whole atomic commit
      drm/rockchip: psr: Remove flush by CRTC
      drm/exynos: fimd: Add support for S5PV210 FIMD variant

Tomasz Lis (1):
      drm/i915/icl: Add configuring MOCS in new Icelake engines

Tony Cheng (4):
      drm/amd/display: dal 3.1.39
      drm/amd/display: dal 3.1.40
      drm/amd/display: dal 3.1.43
      drm/amd/display: dal 3.1.44

Tvrtko Ursulin (7):
      drm/i915/pmu: Work around compiler warnings on some kernel configs
      drm/i915: Skip logging impossible slices
      drm/i915: Enclose for_each_engine_masked macro arguments in parenthes=
es
      drm/i915/execlists: Log fence context & seqno throughout GEM_TRACE
      drm/i915/pmu: Inspect runtime PM state more carefully while estimatin=
g RC6
      drm/i915: Use seqlock in engine stats
      drm/i915: Include priority and completed status in request
in/out tracepoints

Vaishali Thakkar (1):
      drm/vc4: make function vc4_allocate_bin_bo static

Vidya Srinivas (3):
      drm/i915: Display WA 827
      drm/i915: Enable YUV to RGB for Gen10 in Plane Ctrl Reg
      drm/i915: Enable Display WA 0528

Ville Syrj=C3=A4l=C3=A4 (29):
      drm/i915: Don't initialize plane_to_crtc_mapping[] on SKL+
      drm/i915: Kill the remaining CHV HBR2 leftovers
      drm/i915: Don't spew errors when resetting HDMI scrambling/bit
clock ratio fails
      drm/scdc-helper: Convert errors into debug messages
      drm/simple-kms-helper: Plumb plane state to the enable hook
      drm/tinydrm: Make fb_dirty into a lower level hook
      drm/atomic-helper: Drop plane->fb references only for
drm_atomic_helper_shutdown()
      drm: Clear crtc->primary->crtc when disabling the crtc via setcrtc()
      drm/atomic-helper: WARN if legacy plane fb pointers are bogus
when committing duplicated state
      drm: Add local 'plane' variable for primary/cursor planes
      drm: Adjust whitespace for legibility
      drm: Make the fb refcount handover less magic
      drm: Use plane->state->fb over plane->fb
      drm/i915: Stop consulting plane->fb
      drm/sti: Stop consulting plane->fb
      drm/vmwgfx: Stop consulting plane->fb
      drm/zte: Stop consulting plane->crtc
      drm/i915: Restore planes after load detection
      drm/i915: Make force_load_detect effective even w/ DMI quirks/hotplug
      drm/i915: Protect PIPE_CONF_CHECK macros with do {} while(0)
      drm/i915: Enable edp psr error interrupts on bdw+
      drm: Don't pass the index to drm_property_add_enum()
      drm/rect: Fix drm_rect_rotation_inv() docs
      drm/i915: Correctly populate user mode h/vdisplay with pipe src
size during readout
      drm/modes: Introduce drm_mode_match()
      drm/edid: Use drm_mode_match_no_clocks_no_stereo() for consistentcy
      drm/edid: Fix cea mode aspect ratio handling
      drm/edid: Don't send bogus aspect ratios in AVI infoframes
      video/hdmi: Reject illegal picture aspect ratios

Vitaly Prosyak (1):
      drm/amd/display: Add dc_lut_mode enum

Weinan Li (1):
      Revert "drm/i915/gvt: set max priority for gvt context"

Wolfram Sang (1):
      gpu: drm: vc4: simplify getting .drvdata

Xiaojie Yuan (1):
      drm/amdgpu/uvd7: add emit_reg_write_reg_wait ring callback

Xidong Wang (1):
      drm/i915: Do no use kfree() to free a kmem_cache_alloc() return value

Xingyue Tao (4):
      drm/amd/display: Add double buffer machanism to ICSC
      drm/amd/display: Add double buffer machanism to OCSC
      drm/amd/display: Add dc cap to restrict VSR downscaling src size
      drm/amd/display: Only limit VSR downscaling when actually downscaling

Yaodong Li (1):
      drm/i915: Use correct reST syntax for WOPCM and GuC kernel-doc diagra=
ms

Yong Zhao (3):
      drm/amdkfd: Separate trap handler assembly code and its hex values
      drm/amdkfd: Fix CP soft hang on APUs
      drm/amdgpu: Add support to change mtype for 2nd part of gart BOs on G=
FX9

Yongqiang Sun (6):
      drm/amd/display: Retry when read dpcd caps failed.
      drm/amd/display: Change disable backlight ramp change threshold
from 0 to maximum value.
      drm/amd/display: dal 3.1.41
      drm/amd/display: Check lid state to determine fast boot optimization.
      drm/amd/display: Check SCRATCH reg to determine S3 resume.
      drm/amd/display: Use dig enable to determine fast boot optimization.

Yue Hin Lau (2):
      drm/amd/display: add missing colorspace for set black color
      drm/amd/display: disable mpo if brightness adjusted

Zhao Yan (4):
      drm/i915/gvt: scan non-privileged batch buffer for debug purpose
      drm/i915/gvt: let NOPID be the default value of force_to_nonpriv regi=
sters
      drm/i915/gvt: do not return error on handling force_to_nonpriv regist=
ers
      drm/i915/gvt: let force_to_nonpriv cmd handler only valid for LRI cmd

Zhi Wang (1):
      Merge branch 'drm-intel-next-queued' into gvt-next

Zhipeng Gong (2):
      drm/i915/gvt: Use real time to do timer check
      drm/i915/gvt: Update time slice more frequently

os=C3=A9 Roberto de Souza (1):
      drm/i915/psr: Prevent PSR exit when a non-pipe related register is wr=
itten

welu (2):
      drm/amdkfd: Try to enable atomics for all GPUs
      drm/amdgpu: change pp_dpm clk/mclk/pcie input format.

zain wang (11):
      drm/bridge: analogix_dp: Don't use fast link training when panel
just powered up
      drm/bridge: analogix_dp: Retry bridge enable when it failed
      drm/bridge: analogix_dp: Wait for HPD signal before configuring link
      drm/bridge: analogix_dp: Set PD_INC_BG first when powering up edp phy
      drm/bridge: analogix_dp: Fix incorrect usage of enhanced mode
      drm/bridge: analogix_dp: Fix AUX_PD bit for Rockchip
      drm/rockchip: Restore psr->state when enable/disable psr failed
      drm/bridge: analogix_dp: Don't use ANALOGIX_DP_PLL_CTL to control pll
      drm/bridge: analogix_dp: Fix timeout of video streamclk config
      drm/bridge: analogix_dp: Fix incorrect operations with register
ANALOGIX_DP_FUNC_EN_1
      drm/bridge: analogix_dp: Move fast link training detect to set_bridge

 .../bindings/display/bridge/adi,adv7511.txt        |   18 +-
 .../bindings/display/bridge/cdns,dsi.txt           |  133 +
 .../bindings/display/bridge/renesas,dw-hdmi.txt    |    1 +
 .../devicetree/bindings/display/bridge/tda998x.txt |    3 +
 .../bindings/display/bridge/thine,thc63lvd1024.txt |   60 +
 .../bindings/display/exynos/exynos5433-decon.txt   |    9 +-
 .../devicetree/bindings/display/renesas,du.txt     |   28 +-
 .../bindings/display/sunxi/sun6i-dsi.txt           |   93 +
 .../devicetree/bindings/gpu/brcm,bcm-v3d.txt       |   28 +
 .../devicetree/bindings/gpu/samsung-scaler.txt     |   27 +
 Documentation/gpu/drivers.rst                      |    2 +
 Documentation/gpu/i915.rst                         |  141 +-
 Documentation/gpu/kms-properties.csv               |    1 -
 Documentation/gpu/todo.rst                         |   18 +
 Documentation/gpu/xen-front.rst                    |   31 +
 MAINTAINERS                                        |   21 +-
 drivers/dma-buf/sync_debug.h                       |   10 -
 drivers/gpu/drm/Kconfig                            |   13 +-
 drivers/gpu/drm/Makefile                           |    4 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   87 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   10 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |   10 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 1043 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  584 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |   44 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h   |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c      |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |  247 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   81 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  195 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  121 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h        |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c            |   20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   50 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   70 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c             |  111 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h             |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  120 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   38 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  365 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c          |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_queue_mgr.c      |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   21 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c           |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  496 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |   54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |   22 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  292 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h            |   19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |   11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  273 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   15 +-
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |    4 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |    7 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |   17 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |   30 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |   17 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |   17 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |   10 +-
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c               |  120 +
 .../disp/basegk104.c =3D> amd/amdgpu/df_v1_7.h}      |   30 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |  116 +
 .../disp/basegk110.c =3D> amd/amdgpu/df_v3_6.h}      |   30 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  102 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  344 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   25 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   25 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   33 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  146 +-
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |    4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |   18 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   67 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |    9 +
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |    3 +
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |   12 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   96 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |    7 +
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |    2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  125 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h                 |    1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |   15 +
 drivers/gpu/drm/amd/amdgpu/soc15d.h                |    6 +
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |   46 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |   40 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |  112 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              | 1073 ++---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |    7 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  188 +-
 drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c       |   53 +
 drivers/gpu/drm/amd/amdgpu/vi.c                    |  130 +-
 drivers/gpu/drm/amd/amdkfd/Makefile                |   10 +-
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |   20 +-
 drivers/gpu/drm/amd/amdkfd/cik_regs.h              |    3 +-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |  560 +++
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm  |  274 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  | 1214 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   52 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   11 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  131 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  114 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    2 +
 .../drm/amd/amdkfd/kfd_device_queue_manager_v9.c   |   84 +
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |   65 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |  119 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |   92 +
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c         |    8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |   39 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h      |    7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c  |    9 +
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c   |  340 ++
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c   |  319 ++
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |    7 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |    3 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  443 ++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |  392 +-
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h    |  583 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  112 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   50 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   22 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |    8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    6 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |    1 +
 drivers/gpu/drm/amd/amdkfd/soc15_int.h             |   47 +
 drivers/gpu/drm/amd/display/Kconfig                |    8 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  226 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   15 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    5 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |   13 +-
 drivers/gpu/drm/amd/display/dc/basics/Makefile     |    2 +-
 drivers/gpu/drm/amd/display/dc/basics/conversion.c |   28 +-
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c |  376 +-
 drivers/gpu/drm/amd/display/dc/basics/fixpt32_32.c |  161 -
 .../gpu/drm/amd/display/dc/basics/log_helpers.c    |    1 -
 drivers/gpu/drm/amd/display/dc/basics/logger.c     |    3 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    3 +
 .../gpu/drm/amd/display/dc/bios/command_table.c    |   22 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |   26 +-
 .../drm/amd/display/dc/bios/command_table_helper.c |    1 +
 .../amd/display/dc/bios/command_table_helper2.c    |    1 +
 .../gpu/drm/amd/display/dc/calcs/calcs_logger.h    |  579 +++
 .../gpu/drm/amd/display/dc/calcs/custom_float.c    |   46 +-
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |  256 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |   82 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  112 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |   38 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   24 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  170 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   30 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |    2 -
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  345 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   24 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |    8 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   46 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |    2 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |   59 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    5 +
 drivers/gpu/drm/amd/display/dc/dc_link.h           |    9 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   28 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   17 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |    9 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   73 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c    |   33 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.c     |    3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c       |    6 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |    6 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.h  |    2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |  103 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h |   17 +
 .../gpu/drm/amd/display/dc/dce/dce_scl_filters.c   |   48 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |   76 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |   26 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |   33 -
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  200 +-
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |    1 +
 .../drm/amd/display/dc/dce110/dce110_resource.c    |   33 -
 .../display/dc/dce110/dce110_timing_generator.c    |   16 +-
 .../display/dc/dce110/dce110_timing_generator_v.c  |    7 -
 .../drm/amd/display/dc/dce110/dce110_transform_v.c |    8 +-
 .../drm/amd/display/dc/dce112/dce112_resource.c    |   35 +-
 .../drm/amd/display/dc/dce112/dce112_resource.h    |    5 -
 .../drm/amd/display/dc/dce120/dce120_resource.c    |   50 +-
 .../display/dc/dce120/dce120_timing_generator.c    |   12 +-
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   49 -
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile      |    2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |   98 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |   43 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |   76 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |   96 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  |   38 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |  229 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |   14 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |  215 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |   82 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  435 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |    2 +
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  | 1362 ++++++
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |  330 ++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   24 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h   |    5 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |  104 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |   26 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  349 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    | 1490 +++++++
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |  524 +++
 drivers/gpu/drm/amd/display/dc/dm_services.h       |    8 +-
 .../drm/amd/display/dc/dml/display_mode_enums.h    |   13 +
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |  138 +-
 .../drm/amd/display/dc/dml/display_mode_structs.h  |  969 +++--
 .../gpu/drm/amd/display/dc/dml/dml_inline_defs.h   |   10 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |    1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |    1 +
 .../dc/i2caux/dce110/i2c_hw_engine_dce110.c        |    2 +-
 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c     |    1 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    6 +-
 drivers/gpu/drm/amd/display/dc/inc/dce_calcs.h     |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |   64 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |   18 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |   10 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/ipp.h        |    2 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h  |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |   17 +
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |   36 +-
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |   22 +-
 drivers/gpu/drm/amd/display/dc/inc/reg_helper.h    |   56 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |    4 -
 drivers/gpu/drm/amd/display/dc/irq_types.h         |    9 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |   11 +-
 drivers/gpu/drm/amd/display/include/dal_types.h    |    1 +
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |  272 +-
 drivers/gpu/drm/amd/display/include/fixed32_32.h   |  129 -
 .../gpu/drm/amd/display/include/logger_interface.h |    9 +
 drivers/gpu/drm/amd/display/include/logger_types.h |   66 +-
 .../drm/amd/display/modules/color/color_gamma.c    |  692 ++-
 .../drm/amd/display/modules/color/color_gamma.h    |   48 +-
 .../gpu/drm/amd/display/modules/inc/mod_stats.h    |    4 +
 drivers/gpu/drm/amd/display/modules/stats/stats.c  |  254 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |   23 +-
 .../drm/amd/include/asic_reg/dce/dce_12_0_offset.h |   12 +
 .../amd/include/asic_reg/dce/dce_12_0_sh_mask.h    |  152 +
 .../drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h  |   19 +-
 .../drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h |    8 +
 .../drm/amd/include/asic_reg/df/df_1_7_default.h   |   26 +
 .../drm/amd/include/asic_reg/df/df_1_7_offset.h    |   37 +
 .../drm/amd/include/asic_reg/df/df_1_7_sh_mask.h   |   52 +
 .../drm/amd/include/asic_reg/df/df_3_6_default.h   |   26 +
 .../drm/amd/include/asic_reg/df/df_3_6_offset.h    |   33 +
 .../drm/amd/include/asic_reg/df/df_3_6_sh_mask.h   |   48 +
 drivers/gpu/drm/amd/include/atombios.h             |    7 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |   35 +
 drivers/gpu/drm/amd/include/cgs_common.h           |  170 -
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   26 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   13 +-
 drivers/gpu/drm/amd/include/soc15_ih_clientid.h    |    1 +
 drivers/gpu/drm/amd/include/v9_structs.h           |   48 +-
 drivers/gpu/drm/amd/include/vega20_ip_offset.h     | 1051 +++++
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |  489 +--
 .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |   41 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |   91 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       |   11 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c   |  222 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.h   |   15 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |   99 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h |    2 +
 .../amd/powerplay/hwmgr/process_pptables_v1_0.c    |   39 +-
 .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  |    4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |  208 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h  |    3 +-
 .../amd/powerplay/hwmgr/smu7_clockpowergating.c    |   16 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  330 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h   |    2 +
 .../gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c   |  229 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c   |   37 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c   |   98 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.h   |   27 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  951 ++--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h |   26 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |  121 +-
 .../amd/powerplay/hwmgr/vega10_processpptables.c   |    2 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   |  107 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |   95 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |    2 +-
 .../amd/powerplay/hwmgr/vega12_processpptables.c   |    7 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c   |   37 +-
 .../gpu/drm/amd/powerplay/inc/hardwaremanager.h    |    9 +-
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |   35 +-
 drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h       |    4 +-
 drivers/gpu/drm/amd/powerplay/inc/smu75.h          |  760 ++++
 drivers/gpu/drm/amd/powerplay/inc/smu75_discrete.h |  886 ++++
 drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h   |    1 +
 drivers/gpu/drm/amd/powerplay/smumgr/Makefile      |    2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |   12 +-
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |   24 +-
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  |    9 +-
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |   25 +-
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |   39 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |   46 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h |    1 -
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c      |    2 +
 .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |   19 +-
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |   52 +-
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |   56 +-
 .../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c    | 2383 ++++++++++
 .../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.h    |   75 +
 drivers/gpu/drm/ast/ast_mode.c                     |    2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   13 -
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |   89 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |    2 +-
 drivers/gpu/drm/bridge/Kconfig                     |   16 +
 drivers/gpu/drm/bridge/Makefile                    |    2 +
 drivers/gpu/drm/bridge/adv7511/Kconfig             |    2 +-
 drivers/gpu/drm/bridge/adv7511/adv7511.h           |    6 +
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   46 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  331 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |    5 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |  236 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h  |    7 +
 drivers/gpu/drm/bridge/cdns-dsi.c                  | 1623 +++++++
 .../gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c    |    1 -
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |   18 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    2 +-
 drivers/gpu/drm/bridge/thc63lvd1024.c              |  206 +
 drivers/gpu/drm/drm_atomic.c                       |   26 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  109 +-
 drivers/gpu/drm/drm_blend.c                        |   39 +
 drivers/gpu/drm/drm_connector.c                    |   50 +-
 drivers/gpu/drm/drm_crtc.c                         |   54 +-
 drivers/gpu/drm/drm_crtc_internal.h                |    2 +
 drivers/gpu/drm/drm_dp_helper.c                    |   22 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |    9 +-
 drivers/gpu/drm/drm_drv.c                          |   64 +-
 drivers/gpu/drm/drm_edid.c                         |   43 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   12 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   33 +-
 drivers/gpu/drm/drm_gem.c                          |    9 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |   19 +
 drivers/gpu/drm/drm_ioc32.c                        |    4 +-
 drivers/gpu/drm/drm_ioctl.c                        |   85 +-
 drivers/gpu/drm/drm_lease.c                        |    2 +-
 drivers/gpu/drm/drm_modes.c                        |  179 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   29 +-
 drivers/gpu/drm/drm_plane.c                        |   54 +-
 drivers/gpu/drm/drm_prime.c                        |   21 +-
 drivers/gpu/drm/drm_property.c                     |   27 +-
 drivers/gpu/drm/drm_rect.c                         |   74 +-
 drivers/gpu/drm/drm_scdc_helper.c                  |   10 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |    4 +-
 drivers/gpu/drm/drm_sysfs.c                        |    4 +-
 drivers/gpu/drm/etnaviv/Kconfig                    |    8 -
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c           |   16 +-
 drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c       |   15 +-
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c           |   15 +-
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.h           |   13 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |   68 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              |   45 +-
 drivers/gpu/drm/etnaviv/etnaviv_dump.c             |   15 +-
 drivers/gpu/drm/etnaviv/etnaviv_dump.h             |   16 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |   15 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.h              |   15 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |   16 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   19 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              |   19 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c             |   13 +-
 drivers/gpu/drm/etnaviv/etnaviv_iommu.c            |   49 +-
 drivers/gpu/drm/etnaviv/etnaviv_iommu.h            |   15 +-
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c         |  143 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              |   31 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.h              |   16 +-
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c          |   13 +-
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.h          |   13 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |   13 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.h            |   13 +-
 drivers/gpu/drm/exynos/Kconfig                     |   18 +-
 drivers/gpu/drm/exynos/Makefile                    |    2 +
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   21 +-
 drivers/gpu/drm/exynos/exynos_dp.c                 |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   55 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.h            |   11 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   46 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.c             |    4 +-
 drivers/gpu/drm/exynos/exynos_drm_fimc.c           | 1080 ++---
 drivers/gpu/drm/exynos/exynos_drm_fimc.h           |   23 -
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |    8 +
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |   21 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.h            |    3 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            | 1075 ++---
 drivers/gpu/drm/exynos/exynos_drm_gsc.h            |   24 -
 drivers/gpu/drm/exynos/exynos_drm_ipp.c            |  916 ++++
 drivers/gpu/drm/exynos/exynos_drm_ipp.h            |  175 +
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |    9 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |  758 +---
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |  694 +++
 drivers/gpu/drm/exynos/regs-scaler.h               |  426 ++
 drivers/gpu/drm/gma500/cdv_device.c                |    4 +-
 drivers/gpu/drm/gma500/cdv_intel_crt.c             |    2 +-
 drivers/gpu/drm/gma500/cdv_intel_dp.c              |    2 +-
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c            |    2 +-
 drivers/gpu/drm/gma500/cdv_intel_lvds.c            |    2 +-
 drivers/gpu/drm/gma500/mdfld_dsi_output.c          |    2 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi.c             |    2 +-
 drivers/gpu/drm/gma500/psb_intel_drv.h             |    2 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |    2 +-
 drivers/gpu/drm/gma500/psb_intel_sdvo.c            |    4 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    2 +-
 drivers/gpu/drm/i2c/Kconfig                        |    6 +
 drivers/gpu/drm/i2c/Makefile                       |    1 +
 drivers/gpu/drm/i2c/tda9950.c                      |  509 +++
 drivers/gpu/drm/i2c/tda998x_drv.c                  |  244 +-
 drivers/gpu/drm/i915/Kconfig.debug                 |   15 +-
 drivers/gpu/drm/i915/Makefile                      |   20 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   81 +-
 drivers/gpu/drm/i915/gvt/debugfs.c                 |   72 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |    2 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   35 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |    2 -
 drivers/gpu/drm/i915/gvt/mmio_context.c            |    2 +-
 drivers/gpu/drm/i915/gvt/sched_policy.c            |   31 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |   89 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |    1 +
 drivers/gpu/drm/i915/gvt/trace.h                   |   24 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |  566 +--
 drivers/gpu/drm/i915/i915_drv.c                    |   89 +-
 drivers/gpu/drm/i915/i915_drv.h                    |  424 +-
 drivers/gpu/drm/i915/i915_gem.c                    |  394 +-
 drivers/gpu/drm/i915/i915_gem.h                    |   13 +
 drivers/gpu/drm/i915/i915_gem_batch_pool.c         |   30 +-
 drivers/gpu/drm/i915/i915_gem_batch_pool.h         |   29 +-
 drivers/gpu/drm/i915/i915_gem_context.c            |   62 +-
 drivers/gpu/drm/i915/i915_gem_context.h            |   43 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |   32 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |   70 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h                |    5 +-
 drivers/gpu/drm/i915/i915_gem_stolen.c             |  178 +-
 drivers/gpu/drm/i915/i915_gem_timeline.c           |  154 -
 drivers/gpu/drm/i915/i915_gem_userptr.c            |    3 +
 drivers/gpu/drm/i915/i915_gpu_error.c              |   66 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |  366 ++
 drivers/gpu/drm/i915/i915_irq.c                    |  410 +-
 drivers/gpu/drm/i915/i915_oa_icl.c                 |  118 +
 drivers/gpu/drm/i915/i915_oa_icl.h                 |   34 +
 drivers/gpu/drm/i915/i915_params.c                 |    3 +
 drivers/gpu/drm/i915/i915_params.h                 |    3 +-
 drivers/gpu/drm/i915/i915_pci.c                    |    1 +
 drivers/gpu/drm/i915/i915_perf.c                   |   96 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   27 +-
 drivers/gpu/drm/i915/i915_pmu.h                    |   30 +-
 drivers/gpu/drm/i915/i915_reg.h                    |  882 ++--
 drivers/gpu/drm/i915/i915_request.c                |  438 +-
 drivers/gpu/drm/i915/i915_request.h                |   49 +-
 drivers/gpu/drm/i915/i915_scheduler.h              |   72 +
 drivers/gpu/drm/i915/i915_timeline.c               |  105 +
 .../i915/{i915_gem_timeline.h =3D> i915_timeline.h}  |   71 +-
 drivers/gpu/drm/i915/i915_trace.h                  |  129 +-
 drivers/gpu/drm/i915/i915_utils.h                  |   10 +-
 drivers/gpu/drm/i915/i915_vma.c                    |   73 +-
 drivers/gpu/drm/i915/i915_vma.h                    |    6 +
 drivers/gpu/drm/i915/intel_atomic.c                |   19 +-
 drivers/gpu/drm/i915/intel_atomic_plane.c          |    7 +-
 drivers/gpu/drm/i915/intel_bios.c                  |   18 +-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |   52 +-
 drivers/gpu/drm/i915/intel_crt.c                   |    8 +-
 drivers/gpu/drm/i915/intel_csr.c                   |    9 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |  451 +-
 drivers/gpu/drm/i915/intel_device_info.c           |  169 +-
 drivers/gpu/drm/i915/intel_device_info.h           |    4 +-
 drivers/gpu/drm/i915/intel_display.c               |  472 +-
 drivers/gpu/drm/i915/intel_display.h               |    4 +
 drivers/gpu/drm/i915/intel_dp.c                    |  298 +-
 drivers/gpu/drm/i915/intel_dp_link_training.c      |    5 +
 drivers/gpu/drm/i915/intel_dp_mst.c                |    8 +-
 drivers/gpu/drm/i915/intel_dpio_phy.c              |   11 +-
 drivers/gpu/drm/i915/intel_dpll_mgr.c              |  909 +++-
 drivers/gpu/drm/i915/intel_dpll_mgr.h              |   97 +-
 drivers/gpu/drm/i915/intel_drv.h                   |   84 +-
 drivers/gpu/drm/i915/intel_dsi_vbt.c               |   34 +-
 drivers/gpu/drm/i915/intel_engine_cs.c             |  933 +---
 drivers/gpu/drm/i915/intel_fbc.c                   |   28 +
 drivers/gpu/drm/i915/intel_fbdev.c                 |    7 +-
 drivers/gpu/drm/i915/intel_frontbuffer.c           |    2 +-
 drivers/gpu/drm/i915/intel_gpu_commands.h          |  274 ++
 drivers/gpu/drm/i915/intel_guc.c                   |  231 +-
 drivers/gpu/drm/i915/intel_guc.h                   |   82 +-
 drivers/gpu/drm/i915/intel_guc_ads.c               |    9 +-
 drivers/gpu/drm/i915/intel_guc_ct.c                |  545 ++-
 drivers/gpu/drm/i915/intel_guc_ct.h                |   18 +-
 drivers/gpu/drm/i915/intel_guc_fw.c                |    7 +-
 drivers/gpu/drm/i915/intel_guc_fwif.h              |  162 +-
 drivers/gpu/drm/i915/intel_guc_log.c               |  544 +--
 drivers/gpu/drm/i915/intel_guc_log.h               |   59 +-
 drivers/gpu/drm/i915/intel_guc_reg.h               |   14 +-
 drivers/gpu/drm/i915/intel_guc_submission.c        |  114 +-
 drivers/gpu/drm/i915/intel_hangcheck.c             |   16 +-
 drivers/gpu/drm/i915/intel_hdcp.c                  |  185 +-
 drivers/gpu/drm/i915/intel_hdmi.c                  |   40 +-
 drivers/gpu/drm/i915/intel_hotplug.c               |    3 +
 drivers/gpu/drm/i915/intel_huc.c                   |   30 +-
 drivers/gpu/drm/i915/intel_huc.h                   |    7 +
 drivers/gpu/drm/i915/intel_huc_fw.c                |    8 +-
 drivers/gpu/drm/i915/intel_lrc.c                   |  539 ++-
 drivers/gpu/drm/i915/intel_lrc.h                   |    2 +-
 drivers/gpu/drm/i915/intel_mocs.c                  |    5 +-
 drivers/gpu/drm/i915/intel_overlay.c               |    1 +
 drivers/gpu/drm/i915/intel_pipe_crc.c              |   75 +-
 drivers/gpu/drm/i915/intel_pm.c                    |  578 ++-
 drivers/gpu/drm/i915/intel_psr.c                   |  444 +-
 drivers/gpu/drm/i915/intel_ringbuffer.c            |   78 +-
 drivers/gpu/drm/i915/intel_ringbuffer.h            |   71 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |  101 +-
 drivers/gpu/drm/i915/intel_sdvo.c                  |    5 +-
 drivers/gpu/drm/i915/intel_sprite.c                |  178 +-
 drivers/gpu/drm/i915/intel_uc.c                    |  132 +-
 drivers/gpu/drm/i915/intel_uc.h                    |    5 +-
 drivers/gpu/drm/i915/intel_uc_fw.c                 |   13 +-
 drivers/gpu/drm/i915/intel_uc_fw.h                 |   24 +-
 drivers/gpu/drm/i915/intel_uncore.c                |  175 +-
 drivers/gpu/drm/i915/intel_uncore.h                |    1 +
 drivers/gpu/drm/i915/intel_wopcm.c                 |  275 ++
 drivers/gpu/drm/i915/intel_wopcm.h                 |   31 +
 drivers/gpu/drm/i915/intel_workarounds.c           |  949 ++++
 drivers/gpu/drm/i915/intel_workarounds.h           |   17 +
 drivers/gpu/drm/i915/selftests/huge_pages.c        |    5 +-
 drivers/gpu/drm/i915/selftests/i915_gem_context.c  |    3 +
 .../gpu/drm/i915/selftests/i915_live_selftests.h   |    2 +
 .../gpu/drm/i915/selftests/i915_mock_selftests.h   |    1 +
 .../{i915_gem_timeline.c =3D> i915_timeline.c}       |   94 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |    2 +-
 drivers/gpu/drm/i915/selftests/igt_flush_test.c    |   70 +
 drivers/gpu/drm/i915/selftests/igt_flush_test.h    |   14 +
 drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c |    5 +-
 drivers/gpu/drm/i915/selftests/intel_engine_cs.c   |   58 +
 drivers/gpu/drm/i915/selftests/intel_hangcheck.c   |  414 +-
 drivers/gpu/drm/i915/selftests/intel_lrc.c         |  459 ++
 drivers/gpu/drm/i915/selftests/intel_workarounds.c |  291 ++
 drivers/gpu/drm/i915/selftests/mock_engine.c       |   67 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |   21 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.c          |    1 -
 drivers/gpu/drm/i915/selftests/mock_timeline.c     |   45 +-
 drivers/gpu/drm/i915/selftests/mock_timeline.h     |   28 +-
 drivers/gpu/drm/mediatek/Kconfig                   |    1 +
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |   60 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |    2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   14 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |    2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |    1 -
 drivers/gpu/drm/msm/msm_debugfs.c                  |    3 -
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |   11 +-
 drivers/gpu/drm/nouveau/Kbuild                     |    8 +-
 drivers/gpu/drm/nouveau/dispnv50/Kbuild            |   51 +
 drivers/gpu/drm/nouveau/dispnv50/atom.h            |  222 +
 drivers/gpu/drm/nouveau/dispnv50/base.c            |   53 +
 drivers/gpu/drm/nouveau/dispnv50/base.h            |   31 +
 drivers/gpu/drm/nouveau/dispnv50/base507c.c        |  286 ++
 drivers/gpu/drm/nouveau/dispnv50/base827c.c        |   71 +
 drivers/gpu/drm/nouveau/dispnv50/base907c.c        |  110 +
 drivers/gpu/drm/nouveau/dispnv50/base917c.c        |   48 +
 drivers/gpu/drm/nouveau/dispnv50/core.c            |   70 +
 drivers/gpu/drm/nouveau/dispnv50/core.h            |   50 +
 drivers/gpu/drm/nouveau/dispnv50/core507d.c        |  115 +
 drivers/gpu/drm/nouveau/dispnv50/core827d.c        |   41 +
 .../disp/basegt215.c =3D> dispnv50/core907d.c}       |   34 +-
 .../disp/basegt200.c =3D> dispnv50/core917d.c}       |   34 +-
 drivers/gpu/drm/nouveau/dispnv50/corec37d.c        |  110 +
 drivers/gpu/drm/nouveau/dispnv50/curs.c            |   52 +
 drivers/gpu/drm/nouveau/dispnv50/curs.h            |   14 +
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c        |  145 +
 .../fifo/gpfifogk110.c =3D> dispnv50/curs907a.c}     |   22 +-
 drivers/gpu/drm/nouveau/dispnv50/cursc37a.c        |   50 +
 drivers/gpu/drm/nouveau/dispnv50/dac507d.c         |   44 +
 .../engine/disp/cursgt215.c =3D> dispnv50/dac907d.c} |   30 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            | 2238 ++++++++++
 drivers/gpu/drm/nouveau/dispnv50/disp.h            |   89 +
 drivers/gpu/drm/nouveau/dispnv50/head.c            |  511 +++
 drivers/gpu/drm/nouveau/dispnv50/head.h            |   78 +
 drivers/gpu/drm/nouveau/dispnv50/head507d.c        |  325 ++
 drivers/gpu/drm/nouveau/dispnv50/head827d.c        |  124 +
 drivers/gpu/drm/nouveau/dispnv50/head907d.c        |  284 ++
 drivers/gpu/drm/nouveau/dispnv50/head917d.c        |  100 +
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c        |  212 +
 drivers/gpu/drm/nouveau/dispnv50/lut.c             |   95 +
 drivers/gpu/drm/nouveau/dispnv50/lut.h             |   15 +
 drivers/gpu/drm/nouveau/dispnv50/oimm.c            |   51 +
 drivers/gpu/drm/nouveau/dispnv50/oimm.h            |    8 +
 drivers/gpu/drm/nouveau/dispnv50/oimm507b.c        |   52 +
 drivers/gpu/drm/nouveau/dispnv50/ovly.c            |   57 +
 drivers/gpu/drm/nouveau/dispnv50/ovly.h            |   30 +
 drivers/gpu/drm/nouveau/dispnv50/ovly507e.c        |  217 +
 drivers/gpu/drm/nouveau/dispnv50/ovly827e.c        |  107 +
 drivers/gpu/drm/nouveau/dispnv50/ovly907e.c        |   70 +
 drivers/gpu/drm/nouveau/dispnv50/ovly917e.c        |   45 +
 drivers/gpu/drm/nouveau/dispnv50/pior507d.c        |   44 +
 drivers/gpu/drm/nouveau/dispnv50/sor507d.c         |   44 +
 .../engine/disp/coregt200.c =3D> dispnv50/sor907d.c} |   31 +-
 .../engine/disp/cursgk104.c =3D> dispnv50/sorc37d.c} |   30 +-
 drivers/gpu/drm/nouveau/dispnv50/wimm.c            |   47 +
 drivers/gpu/drm/nouveau/dispnv50/wimm.h            |    8 +
 drivers/gpu/drm/nouveau/dispnv50/wimmc37b.c        |   86 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |  641 +++
 drivers/gpu/drm/nouveau/dispnv50/wndw.h            |   96 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c        |  278 ++
 drivers/gpu/drm/nouveau/include/nvif/cl0080.h      |   47 +
 drivers/gpu/drm/nouveau/include/nvif/cla06f.h      |   18 +-
 drivers/gpu/drm/nouveau/include/nvif/class.h       |   14 +
 drivers/gpu/drm/nouveau/include/nvif/clc37b.h      |   11 +
 drivers/gpu/drm/nouveau/include/nvif/clc37e.h      |   13 +
 drivers/gpu/drm/nouveau/include/nvif/device.h      |    9 +-
 drivers/gpu/drm/nouveau/include/nvif/disp.h        |   12 +
 drivers/gpu/drm/nouveau/include/nvif/fifo.h        |   18 +
 drivers/gpu/drm/nouveau/include/nvif/mem.h         |    2 +
 drivers/gpu/drm/nouveau/include/nvif/mmu.h         |    1 +
 drivers/gpu/drm/nouveau/include/nvif/object.h      |   16 +
 drivers/gpu/drm/nouveau/include/nvif/user.h        |   19 +
 drivers/gpu/drm/nouveau/include/nvkm/core/device.h |   13 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/engine.h |    1 +
 drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h |    2 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/ce.h   |    1 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h |    1 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/dma.h  |    1 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/fifo.h |    3 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/gr.h   |    2 +
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/dp.h  |    4 +
 .../gpu/drm/nouveau/include/nvkm/subdev/devinit.h  |    1 +
 .../gpu/drm/nouveau/include/nvkm/subdev/fault.h    |   33 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h   |    1 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/ltc.h  |    3 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/mmu.h  |    1 +
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |   36 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |    2 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    2 +
 drivers/gpu/drm/nouveau/nouveau_chan.c             |   39 +-
 drivers/gpu/drm/nouveau/nouveau_chan.h             |    1 +
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   16 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |   39 +-
 drivers/gpu/drm/nouveau/nouveau_display.h          |    3 +-
 drivers/gpu/drm/nouveau/nouveau_dma.c              |   15 +-
 drivers/gpu/drm/nouveau/nouveau_dma.h              |    6 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   90 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |    6 +
 drivers/gpu/drm/nouveau/nouveau_encoder.h          |    3 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |   11 +-
 drivers/gpu/drm/nouveau/nouveau_fence.h            |    2 -
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   50 +-
 drivers/gpu/drm/nouveau/nouveau_hwmon.c            |   16 +-
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |    1 +
 drivers/gpu/drm/nouveau/nouveau_vmm.h              |    2 +
 drivers/gpu/drm/nouveau/nv04_fence.c               |    2 -
 drivers/gpu/drm/nouveau/nv10_fence.c               |    2 -
 drivers/gpu/drm/nouveau/nv17_fence.c               |    2 -
 drivers/gpu/drm/nouveau/nv50_display.c             | 4558 ----------------=
----
 drivers/gpu/drm/nouveau/nv50_display.h             |    1 -
 drivers/gpu/drm/nouveau/nv50_fence.c               |    2 -
 drivers/gpu/drm/nouveau/nv84_fence.c               |   11 +-
 drivers/gpu/drm/nouveau/nvif/Kbuild                |    6 +
 drivers/gpu/drm/nouveau/nvif/device.c              |    5 +
 .../inc/pp_soc15.h =3D> nouveau/nvif/disp.c}         |   62 +-
 drivers/gpu/drm/nouveau/nvif/fifo.c                |   99 +
 drivers/gpu/drm/nouveau/nvif/mem.c                 |   13 +
 drivers/gpu/drm/nouveau/nvif/mmu.c                 |   11 +
 drivers/gpu/drm/nouveau/nvif/user.c                |   64 +
 .../engine/fifo/gpfifogp100.c =3D> nvif/userc361.c}  |   21 +-
 drivers/gpu/drm/nouveau/nvif/vmm.c                 |    2 +-
 drivers/gpu/drm/nouveau/nvkm/core/engine.c         |   15 +
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c         |   12 +
 drivers/gpu/drm/nouveau/nvkm/engine/ce/Kbuild      |    1 +
 .../nvkm/engine/{disp/cursg84.c =3D> ce/gv100.c}     |   29 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |   73 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h  |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c  |   74 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild    |   30 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c    |   23 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/baseg84.c |   26 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/basegf119.c   |   24 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/basegp102.c   |   22 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/basenv50.c    |   42 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/changf119.c   |   13 +
 .../{fifo/gpfifogm200.c =3D> disp/changv100.c}       |   24 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/channv50.c    |  146 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/channv50.h    |  190 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/coreg84.c |   24 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/coreg94.c |   24 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/coregf119.c   |   47 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/coregk104.c   |   24 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/coregk110.c   |   38 -
 .../gpu/drm/nouveau/nvkm/engine/disp/coregm107.c   |   38 -
 .../gpu/drm/nouveau/nvkm/engine/disp/coregm200.c   |   38 -
 .../gpu/drm/nouveau/nvkm/engine/disp/coregp100.c   |   38 -
 .../gpu/drm/nouveau/nvkm/engine/disp/coregp102.c   |   34 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/coregt215.c   |   38 -
 .../gpu/drm/nouveau/nvkm/engine/disp/coregv100.c   |  204 +
 .../gpu/drm/nouveau/nvkm/engine/disp/corenv50.c    |   61 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/cursgf119.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/cursgp102.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/cursgv100.c   |   81 +
 .../gpu/drm/nouveau/nvkm/engine/disp/cursnv50.c    |   36 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/dacgf119.c    |   11 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dacnv50.c |   11 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/dmacgf119.c   |   40 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/dmacgp102.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/dmacgv100.c   |   77 +
 .../gpu/drm/nouveau/nvkm/engine/disp/dmacnv50.c    |  179 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/dmacnv50.h    |  102 -
 drivers/gpu/drm/nouveau/nvkm/engine/disp/g84.c     |   12 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c     |   12 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gf119.c   |   91 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gk104.c   |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gk110.c   |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gm107.c   |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gm200.c   |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gp100.c   |    8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gp102.c   |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gt200.c   |   12 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gt215.c   |   12 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c   |  427 ++
 .../gpu/drm/nouveau/nvkm/engine/disp/hdmigv100.c   |   85 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h    |    8 +
 .../gpu/drm/nouveau/nvkm/engine/disp/headgf119.c   |   13 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/headgv100.c   |  105 +
 .../gpu/drm/nouveau/nvkm/engine/disp/headnv50.c    |    7 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h     |   24 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/mcp77.c   |   12 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/mcp89.c   |   12 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c    |  207 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.h    |   50 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/oimmgf119.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/oimmgk104.c   |   37 -
 .../gpu/drm/nouveau/nvkm/engine/disp/oimmgp102.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/oimmgt215.c   |   37 -
 .../gpu/drm/nouveau/nvkm/engine/disp/oimmnv50.c    |   36 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ovlyg84.c |   26 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/ovlygf119.c   |   24 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/ovlygk104.c   |   24 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/ovlygp102.c   |   22 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/ovlygt200.c   |   24 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/ovlygt215.c   |   38 -
 .../gpu/drm/nouveau/nvkm/engine/disp/ovlynv50.c    |   42 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/piocgf119.c   |   13 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/piocnv50.c    |    6 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/piornv50.c    |   11 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h    |    3 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/rootg84.c |   19 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/rootg94.c |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgf119.c   |  101 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgk104.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgk110.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgm107.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgm200.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgp100.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgp102.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgt200.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgt215.c   |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgv100.c   |   52 +
 .../gpu/drm/nouveau/nvkm/engine/disp/rootnv50.c    |  175 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootnv50.h    |   22 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/sorg84.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/sorg94.c  |   10 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgf119.c    |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgk104.c    |    2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgm107.c    |    2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgm200.c    |    8 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgt215.c    |    2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgv100.c    |  120 +
 .../gpu/drm/nouveau/nvkm/engine/disp/sormcp77.c    |    2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sormcp89.c    |    2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/sornv50.c |   19 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c   |   82 +
 .../gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c   |  184 +
 drivers/gpu/drm/nouveau/nvkm/engine/dma/Kbuild     |    2 +
 .../nvkm/engine/{disp/oimmg84.c =3D> dma/gv100.c}    |   27 +-
 drivers/gpu/drm/nouveau/nvkm/engine/dma/user.h     |    2 +
 .../gpu/drm/nouveau/nvkm/engine/dma/usergv100.c    |  119 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/Kbuild    |    7 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c    |   46 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.h    |   11 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/changk104.h   |   20 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c   |  373 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.h   |   57 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk110.c   |   28 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk208.c   |   20 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk20a.c   |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gm107.c   |   27 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gm200.c   |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gm20b.c   |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gp100.c   |   11 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gp10b.c   |   11 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/gpfifogk104.c |  155 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/gpfifogv100.c |  225 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c   |  306 ++
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h    |    7 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/user.h    |    6 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/usergv100.c   |   45 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/Kbuild      |    4 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.c  |  423 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |   79 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf104.c  |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf108.c  |   17 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf110.c  |   15 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf117.c  |  114 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf119.c  |   15 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c  |  190 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c  |   28 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c |   14 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c  |   20 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk20a.c  |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c  |   93 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm200.c  |  120 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm20b.c  |   22 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgp100.c  |  100 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgp102.c  |   42 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgp104.c  |   48 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgp107.c  |   11 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgv100.c  |  215 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c     |  417 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h     |  109 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf104.c     |   14 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c     |   21 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf110.c     |   14 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf117.c     |   42 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf119.c     |   14 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.c     |  143 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c     |   31 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110b.c    |   17 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk208.c     |   16 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c     |   37 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gm107.c     |  178 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gm200.c     |  175 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gm20b.c     |    5 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp100.c     |  180 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp102.c     |   77 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp104.c     |   66 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp107.c     |   21 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp10b.c     |   27 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gv100.c     |  120 +
 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c     |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/Kbuild         |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c      |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c     |   19 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowramin.c |    5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c     |   10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/Kbuild |    1 +
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c    |    2 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gv100.c    |   79 +
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.h |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/Kbuild   |    3 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c   |  179 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gp100.c  |   69 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gv100.c  |  206 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/priv.h   |   34 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild      |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.c     |    4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm200.c     |    2 -
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp100.c     |    4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gv100.c     |   46 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/Kbuild     |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/base.c     |   10 +
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp100.c    |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp102.c    |   51 +
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/priv.h     |    5 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/gp100.c     |   20 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/gp10b.c     |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/priv.h      |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/Kbuild     |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gv100.c    |   43 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h      |    3 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgv100.c |   87 +
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gp108.c    |   21 +
 .../nvkm/subdev/secboot/ls_ucode_msgqueue.c        |    7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c    |    3 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    3 +
 drivers/gpu/drm/omapdrm/omap_plane.c               |    2 +-
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |   14 +-
 drivers/gpu/drm/pl111/Makefile                     |    1 +
 drivers/gpu/drm/pl111/pl111_display.c              |   11 +-
 drivers/gpu/drm/pl111/pl111_drm.h                  |    1 +
 drivers/gpu/drm/pl111/pl111_drv.c                  |   34 +-
 drivers/gpu/drm/pl111/pl111_versatile.c            |   56 +-
 drivers/gpu/drm/pl111/pl111_vexpress.c             |  134 +
 drivers/gpu/drm/pl111/pl111_vexpress.h             |   29 +
 drivers/gpu/drm/qxl/qxl_cmd.c                      |   36 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |  278 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |    3 -
 drivers/gpu/drm/qxl/qxl_fb.c                       |    2 -
 drivers/gpu/drm/qxl/qxl_irq.c                      |    3 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |    8 +-
 drivers/gpu/drm/radeon/atombios_crtc.c             |   32 +-
 drivers/gpu/drm/radeon/radeon_atpx_handler.c       |    2 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |   10 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    6 +-
 drivers/gpu/drm/radeon/radeon_display.c            |   53 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |    5 +
 drivers/gpu/drm/radeon/radeon_fb.c                 |   20 +-
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c        |   20 +-
 drivers/gpu/drm/radeon/radeon_mode.h               |    8 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |   26 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |    3 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |   51 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |    5 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.c            |   16 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.h            |    2 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |   41 +-
 drivers/gpu/drm/rcar-du/rcar_du_of.c               |    1 +
 drivers/gpu/drm/rcar-du/rcar_du_of.h               |    2 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c            |   15 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.h            |    2 -
 drivers/gpu/drm/rcar-du/rcar_du_regs.h             |   16 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |   51 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h              |    3 -
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   37 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |    1 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |   61 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |    4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c        |  158 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h        |    7 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   28 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |    1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |    1 +
 drivers/gpu/drm/scheduler/gpu_scheduler.c          |   91 +-
 .../gpu/drm/scheduler}/gpu_scheduler_trace.h       |    2 +-
 drivers/gpu/drm/scheduler/sched_fence.c            |    8 +-
 drivers/gpu/drm/selftests/Makefile                 |    2 +-
 drivers/gpu/drm/selftests/drm_helper_selftests.h   |    9 +
 drivers/gpu/drm/selftests/test-drm-helper.c        |  247 ++
 drivers/gpu/drm/sti/Kconfig                        |    3 +-
 drivers/gpu/drm/sti/sti_crtc.c                     |    2 +-
 drivers/gpu/drm/sti/sti_drv.c                      |   24 +-
 drivers/gpu/drm/sti/sti_plane.c                    |    9 +-
 drivers/gpu/drm/stm/drv.c                          |    2 -
 drivers/gpu/drm/stm/ltdc.c                         |   88 +-
 drivers/gpu/drm/stm/ltdc.h                         |   10 +-
 drivers/gpu/drm/sun4i/Kconfig                      |   10 +
 drivers/gpu/drm/sun4i/Makefile                     |    4 +
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   16 +-
 drivers/gpu/drm/sun4i/sun4i_backend.h              |    3 +
 drivers/gpu/drm/sun4i/sun4i_layer.c                |    2 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   86 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   46 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c            |  292 ++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             | 1107 +++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h             |   63 +
 drivers/gpu/drm/tegra/dc.c                         |  300 +-
 drivers/gpu/drm/tegra/dc.h                         |   11 +-
 drivers/gpu/drm/tegra/drm.c                        |  154 +-
 drivers/gpu/drm/tegra/drm.h                        |   13 +-
 drivers/gpu/drm/tegra/fb.c                         |   99 +-
 drivers/gpu/drm/tegra/gem.c                        |   20 +-
 drivers/gpu/drm/tegra/gr2d.c                       |   57 +-
 drivers/gpu/drm/tegra/gr3d.c                       |   60 +-
 drivers/gpu/drm/tegra/hub.c                        |    2 +-
 drivers/gpu/drm/tegra/plane.c                      |  194 +-
 drivers/gpu/drm/tegra/plane.h                      |   15 +-
 drivers/gpu/drm/tegra/vic.c                        |    5 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |    2 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |    2 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c     |   30 +
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c        |   22 +-
 drivers/gpu/drm/tinydrm/ili9225.c                  |   28 +-
 drivers/gpu/drm/tinydrm/mi0283qt.c                 |   49 +-
 drivers/gpu/drm/tinydrm/mipi-dbi.c                 |   30 +-
 drivers/gpu/drm/tinydrm/repaper.c                  |   33 +-
 drivers/gpu/drm/tinydrm/st7586.c                   |   28 +-
 drivers/gpu/drm/tinydrm/st7735r.c                  |    7 +-
 drivers/gpu/drm/ttm/ttm_agp_backend.c              |    1 +
 drivers/gpu/drm/ttm/ttm_bo.c                       |    2 +-
 drivers/gpu/drm/ttm/ttm_bo_manager.c               |    1 +
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   51 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    1 +
 drivers/gpu/drm/ttm/ttm_execbuf_util.c             |    1 +
 drivers/gpu/drm/ttm/ttm_lock.c                     |    1 +
 drivers/gpu/drm/ttm/ttm_memory.c                   |    1 +
 drivers/gpu/drm/ttm/ttm_module.c                   |    1 +
 drivers/gpu/drm/ttm/ttm_object.c                   |    1 +
 drivers/gpu/drm/ttm/ttm_tt.c                       |    1 +
 drivers/gpu/drm/tve200/tve200_display.c            |   11 +-
 drivers/gpu/drm/udl/udl_connector.c                |    2 +-
 drivers/gpu/drm/udl/udl_dmabuf.c                   |    5 +-
 drivers/gpu/drm/udl/udl_drv.c                      |    2 +-
 drivers/gpu/drm/udl/udl_drv.h                      |    2 +
 drivers/gpu/drm/udl/udl_gem.c                      |    5 +-
 drivers/gpu/drm/udl/udl_main.c                     |    2 +
 drivers/gpu/drm/v3d/Kconfig                        |    9 +
 drivers/gpu/drm/v3d/Makefile                       |   18 +
 drivers/gpu/drm/v3d/v3d_bo.c                       |  389 ++
 drivers/gpu/drm/v3d/v3d_debugfs.c                  |  191 +
 drivers/gpu/drm/v3d/v3d_drv.c                      |  371 ++
 drivers/gpu/drm/v3d/v3d_drv.h                      |  294 ++
 drivers/gpu/drm/v3d/v3d_fence.c                    |   58 +
 drivers/gpu/drm/v3d/v3d_gem.c                      |  668 +++
 drivers/gpu/drm/v3d/v3d_irq.c                      |  206 +
 drivers/gpu/drm/v3d/v3d_mmu.c                      |  122 +
 drivers/gpu/drm/v3d/v3d_regs.h                     |  295 ++
 drivers/gpu/drm/v3d/v3d_sched.c                    |  228 +
 drivers/gpu/drm/v3d/v3d_trace.h                    |   82 +
 drivers/gpu/drm/v3d/v3d_trace_points.c             |    9 +
 drivers/gpu/drm/vc4/vc4_crtc.c                     |   75 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |    9 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |   38 +
 drivers/gpu/drm/vc4/vc4_dsi.c                      |    5 +
 drivers/gpu/drm/vc4/vc4_gem.c                      |   57 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |    4 +
 drivers/gpu/drm/vc4/vc4_kms.c                      |  224 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |  152 +-
 drivers/gpu/drm/vc4/vc4_regs.h                     |   97 +
 drivers/gpu/drm/vc4/vc4_v3d.c                      |    3 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |    8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |    6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |   35 -
 drivers/gpu/drm/xen/Kconfig                        |   17 +
 drivers/gpu/drm/xen/Makefile                       |   11 +
 drivers/gpu/drm/xen/xen_drm_front.c                |  840 ++++
 drivers/gpu/drm/xen/xen_drm_front.h                |  158 +
 drivers/gpu/drm/xen/xen_drm_front_cfg.c            |   77 +
 drivers/gpu/drm/xen/xen_drm_front_cfg.h            |   37 +
 drivers/gpu/drm/xen/xen_drm_front_conn.c           |  115 +
 drivers/gpu/drm/xen/xen_drm_front_conn.h           |   27 +
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c        |  387 ++
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.h        |   81 +
 drivers/gpu/drm/xen/xen_drm_front_gem.c            |  308 ++
 drivers/gpu/drm/xen/xen_drm_front_gem.h            |   40 +
 drivers/gpu/drm/xen/xen_drm_front_kms.c            |  366 ++
 drivers/gpu/drm/xen/xen_drm_front_kms.h            |   26 +
 drivers/gpu/drm/xen/xen_drm_front_shbuf.c          |  414 ++
 drivers/gpu/drm/xen/xen_drm_front_shbuf.h          |   64 +
 drivers/gpu/drm/zte/zx_plane.c                     |    2 +-
 drivers/gpu/drm/zte/zx_vou.c                       |    5 +-
 drivers/gpu/drm/zte/zx_vou.h                       |    3 +-
 drivers/gpu/host1x/cdma.c                          |    6 +-
 drivers/gpu/host1x/cdma.h                          |    4 +-
 drivers/gpu/host1x/debug.c                         |    2 +-
 drivers/gpu/host1x/dev.c                           |   11 +-
 drivers/gpu/host1x/dev.h                           |    8 -
 drivers/gpu/host1x/hw/channel_hw.c                 |    5 +-
 drivers/gpu/host1x/hw/syncpt_hw.c                  |   11 -
 drivers/gpu/host1x/intr.c                          |   16 +-
 drivers/gpu/host1x/intr.h                          |    8 +-
 drivers/gpu/host1x/job.c                           |  147 +-
 drivers/gpu/host1x/job.h                           |    4 +-
 drivers/gpu/host1x/syncpt.c                        |   10 +-
 drivers/gpu/host1x/syncpt.h                        |    3 -
 drivers/staging/vboxvideo/vbox_drv.c               |    2 +-
 drivers/video/hdmi.c                               |    3 +
 include/drm/amd_asic_type.h                        |    2 +
 include/drm/bridge/analogix_dp.h                   |    3 +-
 include/drm/drmP.h                                 |   28 +-
 include/drm/drm_blend.h                            |    3 +
 include/drm/drm_device.h                           |   10 +-
 include/drm/drm_dp_helper.h                        |   24 +-
 include/drm/drm_drv.h                              |   15 +-
 include/drm/drm_edid.h                             |    2 -
 include/drm/drm_file.h                             |   23 +-
 include/drm/drm_gem_framebuffer_helper.h           |    3 +
 include/drm/drm_ioctl.h                            |    7 -
 include/drm/drm_legacy.h                           |    4 +-
 include/drm/drm_mode_config.h                      |    8 +
 include/drm/drm_modes.h                            |   22 +
 include/drm/drm_modeset_helper_vtables.h           |    5 +-
 include/drm/drm_plane.h                            |   21 +-
 include/drm/drm_property.h                         |   28 +-
 include/drm/drm_rect.h                             |    3 +-
 include/drm/drm_simple_kms_helper.h                |    6 +-
 include/drm/gpu_scheduler.h                        |   56 +-
 include/drm/i915_pciids.h                          |    1 +
 include/drm/tinydrm/mipi-dbi.h                     |    4 +-
 include/drm/tinydrm/tinydrm-helpers.h              |    5 +
 include/drm/tinydrm/tinydrm.h                      |    8 +-
 include/linux/dma-fence.h                          |  236 +-
 include/linux/host1x.h                             |   24 +-
 include/linux/platform_data/tda9950.h              |   16 +
 include/trace/events/host1x.h                      |   16 +-
 include/uapi/drm/amdgpu_drm.h                      |   20 +
 include/uapi/drm/drm.h                             |    7 +
 include/uapi/drm/drm_mode.h                        |    6 +
 include/uapi/drm/exynos_drm.h                      |  240 ++
 include/uapi/drm/tegra_drm.h                       |  492 ++-
 include/uapi/drm/v3d_drm.h                         |  194 +
 include/uapi/drm/vc4_drm.h                         |   13 +-
 include/uapi/linux/virtio_gpu.h                    |    1 +
 scripts/coccinelle/api/drm-get-put.cocci           |   10 -
 1111 files changed, 72656 insertions(+), 26340 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
 create mode 100644
Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
 create mode 100644
Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.tx=
t
 create mode 100644 Documentation/gpu/xen-front.rst
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v1_7.c
 rename drivers/gpu/drm/{nouveau/nvkm/engine/disp/basegk104.c =3D>
amd/amdgpu/df_v1_7.h} (71%)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v3_6.c
 rename drivers/gpu/drm/{nouveau/nvkm/engine/disp/basegk110.c =3D>
amd/amdgpu/df_v3_6.h} (71%)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.=
c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/soc15_int.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/basics/fixpt32_32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder=
.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder=
.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encod=
er.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encod=
er.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
 delete mode 100644 drivers/gpu/drm/amd/display/include/fixed32_32.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_1_7_default.=
h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_1_7_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_1_7_sh_mask.=
h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_default.=
h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.=
h
 create mode 100644 drivers/gpu/drm/amd/include/vega20_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu75.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu75_discrete.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.h
 create mode 100644 drivers/gpu/drm/bridge/cdns-dsi.c
 create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_fimc.h
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_gsc.h
 create mode 100644 drivers/gpu/drm/exynos/exynos_drm_ipp.c
 create mode 100644 drivers/gpu/drm/exynos/exynos_drm_ipp.h
 create mode 100644 drivers/gpu/drm/exynos/exynos_drm_scaler.c
 create mode 100644 drivers/gpu/drm/exynos/regs-scaler.h
 create mode 100644 drivers/gpu/drm/i2c/tda9950.c
 delete mode 100644 drivers/gpu/drm/i915/i915_gem_timeline.c
 create mode 100644 drivers/gpu/drm/i915/i915_gpu_error.h
 create mode 100644 drivers/gpu/drm/i915/i915_oa_icl.c
 create mode 100644 drivers/gpu/drm/i915/i915_oa_icl.h
 create mode 100644 drivers/gpu/drm/i915/i915_scheduler.h
 create mode 100644 drivers/gpu/drm/i915/i915_timeline.c
 rename drivers/gpu/drm/i915/{i915_gem_timeline.h =3D> i915_timeline.h} (68=
%)
 create mode 100644 drivers/gpu/drm/i915/intel_gpu_commands.h
 create mode 100644 drivers/gpu/drm/i915/intel_wopcm.c
 create mode 100644 drivers/gpu/drm/i915/intel_wopcm.h
 create mode 100644 drivers/gpu/drm/i915/intel_workarounds.c
 create mode 100644 drivers/gpu/drm/i915/intel_workarounds.h
 rename drivers/gpu/drm/i915/selftests/{i915_gem_timeline.c =3D>
i915_timeline.c} (70%)
 create mode 100644 drivers/gpu/drm/i915/selftests/igt_flush_test.c
 create mode 100644 drivers/gpu/drm/i915/selftests/igt_flush_test.h
 create mode 100644 drivers/gpu/drm/i915/selftests/intel_engine_cs.c
 create mode 100644 drivers/gpu/drm/i915/selftests/intel_lrc.c
 create mode 100644 drivers/gpu/drm/i915/selftests/intel_workarounds.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/Kbuild
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/atom.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/base.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/base.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/base507c.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/base827c.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/base907c.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/base917c.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/core.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/core.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/core507d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/core827d.c
 rename drivers/gpu/drm/nouveau/{nvkm/engine/disp/basegt215.c =3D>
dispnv50/core907d.c} (71%)
 rename drivers/gpu/drm/nouveau/{nvkm/engine/disp/basegt200.c =3D>
dispnv50/core917d.c} (71%)
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/corec37d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/curs.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/curs.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/curs507a.c
 rename drivers/gpu/drm/nouveau/{nvkm/engine/fifo/gpfifogk110.c =3D>
dispnv50/curs907a.c} (79%)
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/cursc37a.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/dac507d.c
 rename drivers/gpu/drm/nouveau/{nvkm/engine/disp/cursgt215.c =3D>
dispnv50/dac907d.c} (74%)
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/disp.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/disp.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/head.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/head.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/head507d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/head827d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/head907d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/head917d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/headc37d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/lut.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/lut.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/oimm.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/oimm.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/oimm507b.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/ovly.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/ovly.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/ovly507e.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/ovly827e.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/ovly907e.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/ovly917e.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/pior507d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/sor507d.c
 rename drivers/gpu/drm/nouveau/{nvkm/engine/disp/coregt200.c =3D>
dispnv50/sor907d.c} (74%)
 rename drivers/gpu/drm/nouveau/{nvkm/engine/disp/cursgk104.c =3D>
dispnv50/sorc37d.c} (74%)
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/wimm.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/wimm.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/wimmc37b.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/wndw.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/wndw.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c
 create mode 100644 drivers/gpu/drm/nouveau/include/nvif/clc37b.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvif/clc37e.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvif/disp.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvif/fifo.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvif/user.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvkm/subdev/fault.h
 delete mode 100644 drivers/gpu/drm/nouveau/nv50_display.c
 rename drivers/gpu/drm/{amd/powerplay/inc/pp_soc15.h =3D>
nouveau/nvif/disp.c} (57%)
 create mode 100644 drivers/gpu/drm/nouveau/nvif/fifo.c
 create mode 100644 drivers/gpu/drm/nouveau/nvif/user.c
 rename drivers/gpu/drm/nouveau/{nvkm/engine/fifo/gpfifogp100.c =3D>
nvif/userc361.c} (79%)
 rename drivers/gpu/drm/nouveau/nvkm/engine/{disp/cursg84.c =3D> ce/gv100.c=
} (76%)
 rename drivers/gpu/drm/nouveau/nvkm/engine/{fifo/gpfifogm200.c =3D>
disp/changv100.c} (79%)
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/coregk110.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/coregm107.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/coregm200.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/coregp100.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/coregt215.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/cursgv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/dmacgv100.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/dmacnv50.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmigv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/headgv100.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/oimmgk104.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/oimmgt215.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/ovlygt215.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/rootgv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/sorgv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
 rename drivers/gpu/drm/nouveau/nvkm/engine/{disp/oimmg84.c =3D>
dma/gv100.c} (76%)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/dma/usergv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gpfifogv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/fifo/user.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/fifo/usergv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgp104.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp104.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/gr/gv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fault/Kbuild
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gp100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fault/priv.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp102.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gv100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgv100.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_vexpress.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_vexpress.h
 rename {include/drm =3D> drivers/gpu/drm/scheduler}/gpu_scheduler_trace.h =
(97%)
 create mode 100644 drivers/gpu/drm/selftests/drm_helper_selftests.h
 create mode 100644 drivers/gpu/drm/selftests/test-drm-helper.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
 create mode 100644 drivers/gpu/drm/v3d/Kconfig
 create mode 100644 drivers/gpu/drm/v3d/Makefile
 create mode 100644 drivers/gpu/drm/v3d/v3d_bo.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_debugfs.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_drv.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_drv.h
 create mode 100644 drivers/gpu/drm/v3d/v3d_fence.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_gem.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_irq.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_mmu.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_regs.h
 create mode 100644 drivers/gpu/drm/v3d/v3d_sched.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_trace.h
 create mode 100644 drivers/gpu/drm/v3d/v3d_trace_points.c
 create mode 100644 drivers/gpu/drm/xen/Kconfig
 create mode 100644 drivers/gpu/drm/xen/Makefile
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_cfg.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_cfg.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_conn.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_conn.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_evtchnl.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_kms.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_kms.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.h
 create mode 100644 include/linux/platform_data/tda9950.h
 create mode 100644 include/uapi/drm/v3d_drm.h

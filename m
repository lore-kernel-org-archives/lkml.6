Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A6C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 02:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3629420835
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 02:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0TMz7Br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3629420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeHOFnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 01:43:40 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:45139 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeHOFnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 01:43:40 -0400
Received: by mail-qk0-f179.google.com with SMTP id c192-v6so14854466qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=icEElgZagFdq25YzXzsRIfGsTNPlZHspDKhaTqG+SrQ=;
        b=Q0TMz7BracCKEIH/kQEimMPTrt2a57ry4i0b9zlgjrNZiXOME1VvvmmWTgGyNZkRH2
         ieo0hnFPSZUcYq259LeVOtoj4B+96dMmY7xzbNIwL5kGycAo1rILRUqq+YwCc+479SlN
         UjdtkS+ClMouQmTZu4v90PMsxehVg8L/Ik4hmBfBOVROdxa5YmnbmKTSxG4sPX6Hf590
         Do0d3xi082WKGyYHhSqy4JjMllSQhUfNRRzODXaY0CNIylZOCiXtlzN/ajbRCEtkH7jY
         E3mVo3BJTqdWGvbMJaoFKRn5SLZgLKht+nLioWY0zZC6QpYM79m4rMkHs7/61fuHZlt3
         anSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=icEElgZagFdq25YzXzsRIfGsTNPlZHspDKhaTqG+SrQ=;
        b=eD/RKeT4J0V8txViM9aO1WwLF4XxL2JAUa9V0FCK8InwFnGGGwF8frUW4kte8O7Bd3
         vHj3T5FLRT+snKGcSh2dzVFk18QcduEHU7vqI9j1g5/7ZY/a0TdoenyGRG1yCmQmEhrN
         AYHpWu7RSXneIjwgFG9Pro+W4vQikaa3QuLrqtkxtKMBLgRujlWjjrlLz6C2O+WYAH7d
         R72xrK8l4CaBS7/ekOmYAGtcJ9mucJnnEeUnAeHJf8G4KGLrnygEzXx8jfggdIHHzyPk
         n4nr+qS7/6VW+QuhFwINDIhlyY3R37QQvEdqnWryy1hOE7NVUXY0HkeRut46FSwS8PgH
         lcjA==
X-Gm-Message-State: AOUpUlH9WpCXwa7Oa5QHWg+hGELKDacpr9a2FI5bItpGW0thN1BukJAp
        P0fG6ZKiHuT3abiSdXlxNIc0RQQI60Ds38asJGE=
X-Google-Smtp-Source: AA+uWPxVerwk3vlsBWC9Y1Q8/BtaDc29oPZFnfB9EREXY3sMvFC9z7w4zbxHFzAEUbOLVzY8n6vEXclzv2qFP8SgYGc=
X-Received: by 2002:a37:6454:: with SMTP id y81-v6mr22642977qkb.56.1534301604361;
 Tue, 14 Aug 2018 19:53:24 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 15 Aug 2018 12:53:11 +1000
Message-ID: <CAPM=9txqtcX42eSYjkyJLL8mmzomXRRHi7iWmW=BYgk=CAagZg@mail.gmail.com>
Subject: [git pull] drm for 4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the main drm pull request for 4.19.

Rob has some new hardware support for new qualcomm hw that I'll send along
separately. This has the display part of it, the remaining pull is for the
acceleration engine.

This also contains a wound-wait/wait-die mutex rework, Peter has acked it
for merging via my tree.

Otherwise mostly the usual level of activity.

Dave.

New driver: vkms - virtual kms driver to testing.

core:
    Wound-wait/wait-die mutex rework
    Add writeback connector type
    Add "content type" property for HDMI
    Move GEM bo to drm_framebuffer
    Initial gpu scheduler documentation
    GPU scheduler fixes for dying processes
    Console deferred fbcon takeover support
    Displayport support for CEC tunneling over AUX

panel:
    otm8009a panel driver fixes
    Innolux TV123WAM panel driver
    Ilitek ILI9881c panel driver
    Rocktech RK070ER9427 LCD
    EDT ETM0700G0EDH6 and EDT ETM0700G0BDH6
    DLC DLC0700YZG-1
    BOE HV070WSA-100
        newhaven, nhd-4.3-480272ef-atxl LCD
        Innolux G070Y2-L01 (Christoph Fritz)
        DataImage SCF0700C48GGU18 (Michal Vok=C3=A1=C4=8D)
        Sharp LQ035Q7DB03 (Vladimir Zapolskiy)
        p079zca: Refactor to support multiple panels

tinydrm:
    ILI9341 display panel

i915:
    Icelake:
        Display enablement
        DSI support
        IRQ support
        Powerwell support
    GPU reset fixes and improvements
    Full ppgtt support refactoring
    PSR fixes and improvements
    Execlist improvments
    GuC related fixes

amdgpu:
    Initial amdgpu documentation
    JPEG engine support on VCN
    CIK uses powerplay by default
    Move to using core PCIE functionality for gens/lanes
    DC/Powerplay interface rework
    Stutter mode support for RV
    Vega12 Powerplay updates
    GFXOFF fixes
    GPUVM fault debugging
    Vega12 GFXOFF
    DC improvements
    DC i2c/aux changes
    UVD 7.2 fixes
    Powerplay fixes for Polaris12, CZ/ST
    command submission bo_list fixes

amdkfd:
    Raven support
    Power management fixes

udl:
    Cleanups and fixes

nouveau:
    misc fixes and cleanups.

msm:
    DPU1 support display controller in sdm845
    GPU coredump support.

vmwgfx:
    Atomic modesetting validation fixes
    Support for multisample surfaces

armada:
    Atomic modesetting support completed.

exynos:
    IPPv2 fixes
    Move g2d to component framework
    Suspend/resume support cleanups
    Driver cleanups

imx:
    CSI configuration improvements
    Driver cleanups
    Use atomic suspend/resume helpers
    ipu-v3 V4L2 XRGB32/XBGR32 support

pl111:
    Add Nomadik LCDC variant

v3d:
    GPU scheduler jobs management

sun4i:
    R40 display engine support
    TCON TOP driver

mediatek:
    MT2712 SoC support

rockchip:
    vop fixes

omapdrm:
    Workaround for DRA7 errata i932
    Fix mm_list locking

mali-dp:
    Writeback implementation
        PM improvements
    Internal error reporting debugfs

tilcdc:
    Single fix for deferred probing

hdlcd:
    Teardown fixes

tda998x:
    Converted to a bridge driver.

etnaviv:
    Misc fixes


drm-next-2018-08-15:
drm pull for 4.19-rc1
The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70=
:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-08-15

for you to fetch changes up to 557ce95051c8eff67af48612ab350d8408aa0541:

  Merge branch 'drm-next-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2018-08-10
11:43:02 +1000)

----------------------------------------------------------------
drm pull for 4.19-rc1

----------------------------------------------------------------
Abhinav Kumar (2):
      drm/msm/dsi: set encoder mode for DRM bridge explicitly
      drm/msm: higher values of pclk can exceed 32 bits when
multiplied by a factor

Alex Deucher (37):
      drm/amdgpu: Fix uvd firmware version information for vega20 (v2)
      drm/amdgpu/display: drop DRM_AMD_DC_FBC kconfig option
      drm/amdgpu/display: enable CONFIG_DRM_AMD_DC_DCN1_0 by default
      drm/amdgpu/pp: switch the default dpm implementation for CI
      drm/doc: Add amdgpu hwmon/power documentation (v2)
      Revert "drm/amdgpu: avoid sleep while executing atombios table (V2)"
      drm/amdgpu: fix swapped emit_ib_size in vce3
      drm/amdgpu/pm: fix display count in non-DC path
      drm/amdgpu/pp: add missing byte swapping in process_pptables_v1_0.c
      drm/amdgpu/pp: fix endian swapping in atomctrl_get_voltage_range
      drm/amdgpu/pp: fix copy paste typo in smu7_init_dpm_defaults
      drm/amdgpu/pp: fix copy paste typo in
smu7_get_pp_table_entry_callback_func_v1
      drm/amdgpu/sdma: simplify sdma instance setup
      drm/amdgpu/vce: simplify vce instance setup
      drm/amdgpu: update uvd_v6_0_ring_vm_funcs to use new nop packet
      drm/amdgpu: switch firmware path for CIK parts (v2)
      drm/amdgpu: switch firmware path for SI parts
      PCI: Export pcie_get_speed_cap and pcie_get_width_cap
      drm/amdgpu: update amd_pcie.h to include gen4 speeds
      drm/amdgpu: use pcie functions for link width and speed
      drm/radeon: use pcie functions for link width
      drm: drop drm_pcie_get_speed_cap_mask and drm_pcie_get_max_link_width
      drm/amdgpu/vi: fix mixed up state in smu clockgating setup
      drm/amdgpu/pp/smu7: use a local variable for toc indexing
      drm/amdgpu/pp/smu7: drop unused values in smu data structure
      drm/amdgpu/pp/smu7: remove local mc_addr variable
      drm/amdgpu/pp/smu7: cache smu firmware toc
      drm/amdgpu/pp: remove dead vega12 code
      drm/amdgpu/pp: split out common smumgr smu9 code
      drm/amdgpu/pp: switch smu callback type for get_argument()
      drm/amdgpu/powerplay: use irq source defines for smu7 sources
      drm/amdgpu/apci: don't call sbios request function if it's not suppor=
ted
      drm/amdgpu/acpi: skip backlight events for DC
      drm/amdgpu: split ip suspend into 2 phases
      drm/amdgpu: rework suspend and resume to deal with atomic changes
      drm/amdgpu/gmc9: clarify GPUVM fault error message
      drm/amdgpu: implement harvesting support for UVD 7.2 (v3)

Alexandru Gheorghe (5):
      drm/atomic: Set current atomic state in drm_private_state
      drm: mali-dp: Add debugfs file for reporting internal errors
      drm: writeback: Fix doc that says connector should be disconnected
      drm: mali-dp: Report writeback connector as connected
      drm: mali-dp: Set encoder possible_clones

Alvin lee (2):
      drm/amd/display: create sink_id in dc_sink structure to
idenitify all sinks
      drm/amd/display: read DP sink and DP branch hardware and
firmware revision from DPCD

Andrey Grodzovsky (18):
      drm/scheduler: Avoid using wait_event_killable for dying process (V4)
      drm/amdgpu: move amdgpu_ctx_mgr_entity_fini to f_ops flush hook (V4)
      drm/amdgpu: Update function level documentation for GPUVM v3
      drm/amdgpu: Consolidate visible vs. real vram check v2.
      drm/amdgpu: Update function level documentation for GPUVM.
      drm/amdgpu: Polish SQ IH.
      drm/amdgpu: Add parsing SQ_EDC_INFO to SQ IH v3.
      drm/scheduler: Rename cleanup functions v2.
      drm/amdgpu: Rename entity cleanup finctions.
      drm/amdgpu: Add support for logging process info in amdgpu_vm.
      drm/amdgpu: Present amdgpu_task_info in VM_FAULTS.
      drm/amdgpu: Verify root PD is mapped into kernel address space (v4)
      drm/amd: Add interrupt source definitions for VI v3.
      drm/amd: Use newly added interrupt source defs for VI v3.
      drm/amd: Add interrupt source definitions for SOC15 v3.
      drm/amd: Use newly added interrupt source defs for SOC15.
      drm/amdgpu: Allow to create BO lists in CS ioctl v3
      drm/amdgpu: Fix warning in dma_fence_is_later on resume from S3.

Andrzej Hajda (2):
      dt-bindings: display: Add DT bindings for BOE HV070WSA-100 panel
      drm/panel: simple: Add support for BOE HV070WSA-100 panel to simple-p=
anel

Anthony Koo (5):
      drm/amd/display: Prefix event prints with =3D=3DEvent=3D=3D
      drm/amd/display: add DPCD read for Sink ieee OUI
      drm/amd/display: Refactor audio programming
      drm/amd/display: Disable stats by default
      drm/amd/display: Prevent PSR from being enabled if initialization fai=
ls

Anusha Srivatsa (7):
      drm/i915/icl: Add Icelake PCH detection
      drm/i915/guc: Remove USES_GUC_SUBMISSION for ads programming
      drm/i915/icp: Add Interrupt Support
      drm/i915/icl: Add VIDEO_DIP registers
      i915/dp/dsc: Add DSC PPS register definitions
      i915/dp/dsc: Add Rate Control Buffer Threshold Registers
      i915/dp/dsc: Add Rate Control Range Parameter Registers

Aric Cyr (1):
      drm/amd/display: Default log masks should include all connectivity ev=
ents

Arkadiusz Hiler (1):
      drm/i915/icl: Calculate link clock using the new registers

Arnd Bergmann (9):
      drm/sun4i: mark PM functions as __maybe_unused
      i915: remove timespec_to_jiffies_timeout
      amdgpu: display: use modern ktime accessors
      drm: vkms: select DRM_KMS_HELPER
      drm/admkfd use modern ktime accessors
      drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=3Dm
      drm/tinydrm: add backlight dependency for ili9341
      drm/msm/gpu: avoid deprecated do_gettimeofday
      drm/msm: mark PM functions as __maybe_unused

Ayan Kumar Halder (10):
      drm/arm/malidp: Modified the prototype of malidp irq de-initializers
      drm/arm/malidp: Split malidp interrupt initialization functions.
      drm/arm/malidp: Enable/disable interrupts in runtime pm
      drm/arm/malidp: Set the output_depth register in modeset
      drm/arm/malidp: Added the late system pm functions
      drm/arm/malidp: Add modifier definitions for describing Arm
Framebuffer Compression (AFBC).
      drm/fourcc: Add is_yuv field to drm_format_info to denote if the
format is yuv
      drm/i915: Substitute intel_format_is_yuv() with format->is_yuv
      drm/rockchip: Substitute is_yuv_support() with format->is_yuv
      drm/sun4i: Substitute sun4i_backend_format_is_yuv() with format->is_y=
uv

Bas Nieuwenhuizen (1):
      drm/ttm: Merge hugepage attr changes in ttm_dma_page_put. (v2)

Ben Skeggs (6):
      drm/nouveau/gr/gv100: handle multiple SM-per-TPC for shader exception=
s
      drm/nouveau/fault/gv100: fix fault buffer initialisation
      drm/nouveau/core: ERR_PTR vs NULL bug in nvkm_engine_info()
      drm/nouveau/disp/nv50-gp10x: fix coverity warning
      drm/nouveau/kms/nv50-: remove duplicate assignment
      drm/nouveau/kms/nv50-: allocate push buffers in vidmem on pascal

Benjamin Gaignard (1):
      drm: print plane state normalized zpos value

Bhawanpreet Lakha (3):
      drm/amd/display: Decouple aux from i2c
      drm/amd/display: Retry link training again
      drm/amd/display: flatten aux_engine and engine

Boris Brezillon (13):
      drm/writeback: Fix the "overview" section of the doc
      drm/atomic: Avoid connector to writeback_connector casts
      drm/connector: Pass a drm_connector_state to ->atomic_commit()
      drm/connector: Make ->atomic_commit() optional
      drm/vc4: Use wait_for_flip_done() instead of wait_for_vblanks()
      drm/crtc: Add a generic infrastructure to fake VBLANK events
      drm/atomic: Call fake_vblank() from the generic commit_tail() helpers
      drm/vc4: Call drm_atomic_helper_fake_vblank() in the commit path
      drm/vc4: Add support for the transposer block
      drm/panel: Make of_drm_find_panel() return an ERR_PTR() instead of NU=
LL
      drm/panel: Let of_drm_find_panel() return -ENODEV when the panel
is disabled
      drm/of: Make drm_of_find_panel_or_bridge() fail when the device
is disabled
      drm/vc4: Support the case where the DSI device is disabled

Boyuan Zhang (18):
      drm/amdgpu: define vcn jpeg ring
      drm/amdgpu: add vcn jpeg ring
      drm/amdgpu: add jpeg packet defines to soc15d.h
      drm/amdgpu: add more jpeg register offset headers
      drm/amdgpu: implement jpeg ring functions
      drm/amdgpu: set jpeg ring functions
      drm/amdgpu: add vcn jpeg irq support
      drm/amdgpu: initialize vcn jpeg ring
      drm/amdgpu: implement patch for fixing a known bug
      drm/amdgpu: define and add extra dword for jpeg ring
      drm/amdgpu: add patch to jpeg ring
      drm/amdgpu: add vcn jpeg sw finish
      drm/amdgpu: add vcn jpeg ring test
      drm/amdgpu: add vcn jpeg ib test
      drm/amdgpu: enable vcn jpeg ib test
      uapi/drm: add AMDGPU_HW_IP_VCN_JPEG for jpeg CS
      drm/amdgpu: add AMDGPU_HW_IP_VCN_JPEG to info query
      drm/amdgpu: add AMDGPU_HW_IP_VCN_JPEG to queue mgr

Brian Starkey (4):
      drm: Add writeback connector type
      drm: writeback: Add out-fences for writeback connectors
      drm: mali-dp: Add RGB writeback formats for DP550/DP650
      drm: mali-dp: Add writeback connector

CK Hu (1):
      drm/mediatek: Split line to not over 80 characters

Carsten Behling (1):
      drm/msm/mdp5: negative x/y in cursor move

Chandan Uddaraju (2):
      drm/msm/dsi: adjust dsi timing for dual dsi mode
      drm/msm/dsi: Use one connector for dual DSI mode

Changbin Du (15):
      drm/i915: Add new vGPU cap info bit VGT_CAPS_HUGE_GTT
      drm/i915/gvt: Add new 64K entry type
      drm/i915/gvt: Add PTE IPS bit operations
      drm/i915/gvt: Handle MMIO GEN8_GAMW_ECO_DEV_RW_IA for 64K GTT
      drm/i915/gvt: Detect 64K gtt entry by IPS bit of PDE
      drm/i915/gvt: Add software PTE flag to mark special 64K splited entry
      drm/i915/gvt: Add GTT clear_pse operation
      drm/i915/gvt: Split ppgtt_alloc_spt into two parts
      drm/i915/gvt: Make PTE iterator 64K entry aware
      drm/i915/gvt: Add 64K huge gtt support
      drm/i915/kvmgt: Support setting dma map for huge pages
      drm/i915/gvt: Add 2M huge gtt support
      drm/i915/gvt: Handle special sequence on PDE IPS bit
      drm/i915/gvt: Fix error handling in ppgtt_populate_spt_by_guest_entry
      drm/i915: Enable platform support for vGPU huge gtt pages

Charlene Liu (9):
      drm/amd/display: Clean up submit_channel_request
      drm/amd/display: Define dp_alt_mode
      drm/amd/display: add valid regoffset and NULL pointer check
      drm/amd/display: Move common GPIO registers into a common define
      drm/amd/display: Define couple extra DCN registers
      drm/amd/display: add missing mask for dcn
      drm/amd/display: set default GPIO_ID_HPD
      drm/amd/display: introduce concept of send_reset_length for i2c engin=
es
      drm/amd/display: add DalEnableHDMI20 key support

Chris Wilson (199):
      drm/i915: Shrink search list for active timelines
      drm/i915: Remove tasklet flush before disable
      drm/i915: Only sync tasklets once for recursive reset preparation
      drm/i915/execlists: Refactor out complete_preempt_context()
      drm/i915: Move engine reset prepare/finish to backends
      drm/i915: Split execlists/guc reset preparations
      drm/i915/execlists: Split out CSB processing
      drm/i915/execlists: Flush pending preemption events during reset
      drm/i915: Stop parking the signaler around reset
      drm/i915/gvt: Use offsetofend() rather than offsetof + sizeof
      drm/i915/execlists: HWACK checking superseded checking port[0].count
      drm/i915: Nul-terminate legacy debug string
      drm/i915: Remove unused enable_cmd_parser modparam
      drm/i915: Move request->ctx aside
      drm/i915: Move fiddling with engine->last_retired_context
      drm/i915: Store a pointer to intel_context in i915_request
      drm/i915: Pull the context->pin_count dec into the common
intel_context_unpin
      drm/i915/lvds: Move acpi lid notification registration to
registration phase
      drm/i915: Speed up idle detection by kicking the tasklets
      drm/i915: Make intel_engine_dump irqsafe
      drm/i915/execlists: Handle copying default context state for atomic r=
eset
      drm/i915: Allow init_breadcrumbs to be used from irq context
      drm/i915/selftests: Wait longer for the old active request
      drm/i915/query: Protect tainted function pointer lookup
      drm/i915/gtt: Allow pagedirectory allocations to fail
      drm/i915/query: nospec expects no more than an unsigned long
      drm/i915/selftests: Pin the mock kernel context
      drm/mm: Reject over-sized allocation requests early
      drm/mm: Add a search-by-address variant to only inspect a single hole
      drm/i915: Limit searching for PIN_HIGH
      drm/i915: Pin the ring high
      drm/i915: Look for an active kernel context before switching
      drm/i915: Flush the ring stop bit after clearing RING_HEAD in reset
      drm/i915/execlists: Wait for ELSP submission on restart
      drm/i915: Prepare GEM for suspend earlier
      drm/i915: Remove stale asserts from i915_gem_find_active_request()
      drm/i915: Switch to kernel context before idling at runtime
      drm/i915: "Race-to-idle" after switching to the kernel context
      drm/i915: After reset on sanitization, reset the engine backends
      drm/i915: Only sanitize GEM from late suspend
      drm/i915: Assert we idle in the kernel context
      drm/i915: Check intel_contexts to avoid one extra pointer chase
      drm/i915/gtt: Avoid calling non-existent allocate_va_range
      drm/i915/gtt: Don't restore the non-existent PDE for GGTT
      drm/i915: Flush all writes before suspend
      drm/i915: Apply the full CPU domain markup before freezing
      drm/i915/gtt: Remove obsolete switch_mm hooks for gen8+
      drm/i915/ringbuffer: Make context pin/unpin symmetric
      drm/i915/gtt: Teach restore-gtt to walk the ggtt vma list not
the object list
      drm/i915/vma: Move the bind_count vs pin_count assertion to a helper
      drm/i915: Swap magics and use SZ_1M
      drm/i915/error: Fixup inactive/active counting
      drm/i915/gtt: Rename i915_hw_ppgtt base member
      drm/i915: Mark i915.inject_load_failure as being hit
      drm/i915/gtt: Fix typo in fill_px() macro
      drm/i915: Use GEM suspend when aborting initialisation
      drm/i915: Change i915_gem_fault() to return vm_fault_t
      drm/i915: Prepare for non-object vma
      drm/i915: Decouple vma vfuncs from vm
      drm/i915/gtt: Push allocation to hw ppgtt constructor
      drm/i915: Mark the GPU as wedged without error on fault injection
      drm/i915/gtt: Fix unwind length passed to gen6_ppgtt_clear_range
      drm/i915/gtt: Remove redundant hsw_mm_switch()
      drm/i915/gtt: Remove vgpu check for gen6
      drm/i915/gtt: Reorder aliasing_ppgtt fini
      drm/i915: Squash GEM load failure message (again)
      drm/i915: Refactor unsettting obj->mm.pages
      drm/i915: Apply batch location restrictions before pinning
      drm/i915/ringbuffer: Brute force context restore
      drm/i915/ringbuffer: Fix context restore upon reset
      drm/i915: Wrap around the tail offset before setting ring->tail
      drm/i915/execlists: Avoid putting the error pointer
      drm/i915/gtt: Invalidate GGTT caches after writing the gen6 page
directories
      drm/i915/ringbuffer: Serialize load of PD_DIR
      drm/i915/gtt: Subclass gen6_hw_ppgtt
      drm/i915/gtt: Onionify error handling for gen6_ppgtt_create
      drm/i915/gtt: Make gen6 page directories evictable
      drm/i915: Make closing request flush mandatory
      drm/i915: Move GEM sanitize from resume_early to resume
      drm/i915: Dump the ringbuffer of the active request for debugging
      drm/i915: Make the hexdump row offset visually distinct
      drm/i915: Show CCID in engine dumps
      drm/i915/gtt: Only keep gen6 page directories pinned while active
      drm/i915/selftests: Initialise request to silence a compiler
      drm/i915/execlists: Push the tasklet kick after reset to reset_finish
      drm/i915: Declare the driver wedged if hangcheck makes no progress
      drm/i915/gtt: Lazily allocate page directories for gen7
      drm/i915/gtt: Free unused page tables on unbind the context
      drm/i915/gtt: Cache the PTE encoding of the scratch page
      drm/i915/gtt: Reduce a pair of runtime asserts
      drm/i915: Keep the ctx workarounds tightly packed
      drm/i915: Be irqsafe inside reset
      drm/i915/execlists: Reset the CSB head tracking on reset/sanitization
      drm/i915: Fix fallout of fake reset along resume
      drm/i915: Only show debug for state changes when banning
      drm/i915/execlists: Pull the w/a LRI emission into a helper
      drm/i915/selftests: Avoid ERR_PTR dereference
      drm/i915/selftests: Remove unused dmabuf->kmap routines, fix the buil=
d
      drm/i915: Disable bh around call to tasklet
      drm/i915: Ignore applying the self-relocation BIAS if no relocations
      drm/i915: Redefine EINVAL for debugging
      drm/i915: Defer modeset cleanup to a secondary task
      drm/i915/execlists: Check for ce->state before destroy
      drm/i915: Context objects can never be active when freed
      drm/i915: Wait for engines to idle before retiring
      drm/i915: Show vma allocator stack when in doubt
      drm/i915: Reduce spinlock hold time during notify_ring() interrupt
      drm/i915: Only trigger missed-seqno checking next to boundary
      drm/i915: Move the irq_counter inside the spinlock
      drm/i915: Only signal from interrupt when requested
      drm/i915: Drop posting reads to flush master interrupts
      drm/i915/execlists: Pull submit after dequeue under timeline lock
      drm/i915/execlists: Pull CSB reset under the timeline.lock
      drm/i915/execlists: Process one CSB update at a time
      drm/i915/execlists: Unify CSB access pointers
      drm/i915/execlists: Reset CSB write pointer after reset
      drm/i915/execlists: Stop storing the CSB read pointer in the mmio reg=
ister
      drm/i915/execlists: Trust the CSB
      drm/i915/execlists: Direct submission of new requests (avoid
tasklet/ksoftirqd)
      drm/i915/selftests: Mark up write into scratch vma
      drm/i915/selftests: Attach the fence to the object when making busy
      drm/i915: Try GGTT mmapping whole object as partial
      drm/i915/selftests: Release the struct_mutex to free the objects
      drm/i915/selftests: Drop struct_mutex around lowlevel pggtt allocatio=
n
      drm/i915/gtt: Pull global wc page stash under its own locking
      drm/i915: Remove defunct i915->vm_list
      drm/i915/selftests: Use full release for local ppgtt allocation
      drm/i915/selftests: Replace open-coded i915_address_space_init()
      drm/i915/selftests: Fixup recursive MI_BB_START for gen3
      drm/i915/selftests: Detect unknown swizzling correctly
      drm/i915/selftests: Fail hangcheck testing if the GPU is wedged
      drm/i915: Squelch very verbose error logging
      drm/i915/selftests: Destroy partial tiling vma after use
      drm/i915/selftests: Skip using the GPU if wedged
      drm/i915/selftests: Skip making an object busy if the GPU is wedged
      drm/i915/selftests: Skip all request selftests when wedged
      drm/i915/selftests: Skip workaround tests when wedged
      drm/i915/selftests: Skip live eviction tests when wedged
      drm/i915/selftests: Skip huge pages live tests if wedged
      drm/i915/selftests: Skip over live context testing when wedged
      drm/i915: Record logical context support in driver caps
      drm/i915/selftests: Skip live context execution test without
logical contexts
      drm/i915/selftests: Skip live_execlists if the GPU is terminally wedg=
ed
      drm/i915: Flush the WCB following a WC write
      drm/i915/gtt: Suppress warnings for dma_map_page
      drm/i915/gtt: Control cache domain of dma_map_page() directly
      drm/i915/selftests: Limit live_gtt allocation test to fit within RAM
      drm/i915/selftests: Replace magic 1<<22 with MI_USE_GGTT/MI_MEM_VIRTU=
AL
      drm/i915/selftests: Fixup missing MI_MEM_VIRTUAL for live_hangcheck
      drm/i915: Refactor export_fence() after i915_vma_move_to_active()
      drm/i915: Export i915_request_skip()
      drm/i915: Start returning an error from i915_vma_move_to_active()
      drm/i915: Move i915_vma_move_to_active() to i915_vma.c
      drm/i915: Track vma activity per fence.context, not per engine
      drm/i915: Track the last-active inside the i915_vma
      drm/i915/selftests: Provide full mb() around clflush
      drm/i915/selftests: Avoid warning if runtime pm is disabled
      drm/i915: Replace nested subclassing with explicit subclasses
      drm/i915/selftests: Magic numbers for old Y-tiling
      drm/i915: Provide a timeout to i915_gem_wait_for_idle()
      drm/i915: Provide a timeout to i915_gem_wait_for_idle() on setup
      drm/i915/selftests: Replace wait-on-timeout with explicit timeout
      drm/i915/selftests: Prevent background reaping of active objects
      drm/i915: Remove function details from device error messages
      drm/i915/selftests: Constrain mock_gtt tests to fit within RAM
      drm/i915/selftests: Filter out both physical address swizzles
      drm/i915: Only reset hangcheck at the start of an activity cycle
      drm/i915: Tidy i915_gem_suspend()
      drm/i915: Flush the residual parking on emergency shutdown
      drm/i915: Cleanup modesetting on load-error path
      drm/i915: Unwind HW init after GVT setup failure
      drm/i915: Introduce i915_address_space.mutex
      drm/i915/selftests: Add a safety net to live_workarounds
      drm/i915/execlists: Switch to rb_root_cached
      drm/i915: Silence warning for no vlv powercontext
      drm/i915/guc: Skip cleaning up the doorbells on error-before-allocate
      drm/i915/guc: Protect against NULL client dereference in error path
      drm/i915/gtt: Disable read-only support under GVT
      drm/i915: Prevent writing into a read-only object via a GGTT mmap
      drm/i915: Reject attempted pwrites into a read-only object
      drm/i915/userptr: Enable read-only support on gen8+
      drm/i915/guc: Protect against no desc-pool on premature shutdown
      drm/i915/selftests: Include the start of each subtest in the GEM trac=
e
      drm/i915: Do not short-circuit tasklets during reset
      drm/i915/execlists: Drop clear_gtiir() on GPU reset
      drm/i915/selftests: Downgrade igt_timeout message
      drm/i915: Remove pci private pointer after destroying the device priv=
ate
      drm/i915/execlists: Disable submission tasklet upon wedging
      drm/i915/execlists: Always clear preempt status on cancelling all
      drm/i915/selftests: Force a preemption hang
      drm/i915/selftests: Exercise reset to break stuck GTT eviction
      drm/i915/selftests: Free the backing store between iterations
      drm/i915: Flush chipset caches after GGTT writes
      drm/i915: Always retire residual requests before suspend
      drm/i915/guc: Keep guc submission permanently engaged
      drm/i915: Handle recursive shrinker for vma->last_active allocation
      drm/i915/execlists: Move the assertion we have the rpm wakeref down
      drm/i915: Interactive RPS mode
      drm/i915/lpe: Mark LPE audio runtime pm as "no callbacks"

Christian K=C3=B6nig (44):
      drm/amdgpu: allocate shared fence slot in VA IOCTL
      drm/amdgpu: rename rmn to amn in the MMU notifier code (v2)
      drm/amdgpu: fix documentation of amdgpu_mn.c v2
      dma_buf: remove device parameter from attach callback v2
      dma-buf: remove kmap_atomic interface
      staging: android: ion: fix ion_dma_buf_attach signatur
      drm/omap: remove now unused functions
      drm/omap: remove now unused functions
      drm/amdgpu: band aid validating VM PTs
      drm/amd/display: fix invalid function table override
      drm/amd/display: make function tables const
      drm/amdgpu: fix TTM move entity init order
      drm/amdgpu: cleanup job header
      drm/amdgpu: remove fence context from the job
      drm/amdgpu: remove ring parameter from amdgpu_job_submit
      drm/amdgpu: remove job->ring
      drm/amdgpu: add amdgpu_job_submit_direct helper
      drm/amdgpu: remove job->adev (v2)
      drm/amdgpu: minor cleanup in amdgpu_job.c
      drm/amdgpu: allow for more flexible priority handling
      drm/amdgpu: change ring priority after pushing the job (v2)
      drm/amdgpu: remove superflous UVD encode entity
      drm/amdgpu: clean up UVD instance handling v2
      drm/amdgpu: clean up coding style a bit
      drm/amdgpu: expose only the first UVD instance for now
      MAINTAINERS: add new TTM maintainers
      MAINTAINERS: Add separate section for DC
      MAINTAINERS: add entry for AMD PP code
      drm/amdgpu: consistenly name amdgpu_bo_ functions
      drm/amdgpu: reduce the number of placements for a BO
      drm/amdgpu: add support for inplace IB patching for MM engines v2
      drm/amdgpu: patch the IBs for the second UVD instance v2
      drm/amdgpu: add proper error handling to amdgpu_bo_list_get
      drm/amdgpu: fix total size calculation
      drm/amdgpu: return error if both BOs and bo_list handle is given
      drm/amdgpu: add new amdgpu_vm_bo_trace_cs() function v2
      drm/amdgpu: move bo_list defines to amdgpu_bo_list.h
      drm/amdgpu: always recreate bo_list
      drm/amdgpu: nuke amdgpu_bo_list_free
      drm/amdgpu: add bo_list iterators
      drm/amdgpu: allocate the bo_list array after the list
      drm/amdgpu: create an empty bo_list if no handle is provided
      drm/scheduler: only kill entity if last user is killed v2
      drm/scheduler: stop setting rq to NULL

Christoph Fritz (1):
      drm/panel: simple: Add support for Innolux G070Y2-L01

Chunming Zhou (1):
      drm/amdgpu: update ib_start/size_alignment same as windows used

Clint Taylor (1):
      drm/i915/glk: Add Quirk for GLK NUC HDMI port issues.

Colin Ian King (6):
      drm/xen-front: fix spelling mistake: "conector" -> "connector"
      drm/i915/dp: fix spelling mistakes: "seqeuncer" and "seqeuencer"
      drm/i915/psr: fix copy-paste error with setting of tp2_wakeup_time_us
      drm/panel: ili9881c: Fix missing assignment to error return ret
      drm/amdgpu: fix spelling mistake "successed" -> "succeeded"
      drm/amd/display: add missing void parameter to dc_create_transfer_fun=
c

Colin Xu (15):
      drm/i915/gvt: Use vgpu_lock to protect per vgpu access
      drm/i915/gvt: Use sched_lock to protect gvt scheduler logic.
      drm/i915/gvt: Add D_BXT device type define for BXT.
      drm/i915/gvt: Add MEDIA_POOL_STATE for BXT.
      drm/i915/gvt: Enable device info initialization for BXT.
      drm/i915/gvt: Enable gtt initialization for BXT.
      drm/i915/gvt: Enable irq initialization for BXT.
      drm/i915/gvt: Enable mmio context init and switch for BXT.
      drm/i915/gvt: Enable cmd_parser support for BXT.
      drm/i915/gvt: Enable force wake support for BXT.
      drm/i915/gvt: Enable virtual display support for BXT.
      drm/i915/gvt: Enable dma_buf support for BXT.
      drm/i915/gvt: Add mmio handler for for BXT.
      drm/i915: Enable KVMGT for BXT.
      drm/i915/gvt: Handle EDP_PSR_IMR and EDP_PSR_IIR for BXT.

Dan Carpenter (7):
      drm/v3d: Checking for NULL vs IS_ERR()
      drm/i810: off by one in i810_dma_vertex()
      drm/vgem: off by one in vgem_gem_fault()
      drm/savage: off by one in savage_bci_cmdbuf()
      drm/amd/display: off by one in find_irq_source_info()
      drm/panel: type promotion bug in s6e8aa0_read_mtp_id()
      drm/nouveau/hwmon: potential uninitialized variables

Daniel Mack (2):
      drm/msm: call drm_atomic_helper_suspend() and drm_atomic_helper_resum=
e()
      drm/msm/adreno: Add power management functions for system sleep

Daniel Stone (19):
      drm/cirrus: Place GEM BOs in drm_framebuffer
      drm/cirrus: cirrus_framebuffer -> drm_framebuffer
      drm/virtio: Place GEM BOs in drm_framebuffer
      drm/armada: Move GEM BO to drm_framebuffer
      drm/gma500: Move GEM BO to drm_framebuffer
      drm/msm: Move GEM BOs to drm_framebuffer
      drm/mtk: Remove impossible internal error
      drm/mtk: Move GEM BO to drm_framebuffer
      drm/mtk: mtk_drm_fb -> drm_framebuffer
      drm/rockchip: Place GEM BOs in drm_framebuffer
      drm/rockchip: rockchip_drm_fb -> drm_framebuffer
      drm/i915: Use intel_fb_obj() everywhere
      drm/i915: Move GEM BO inside drm_framebuffer
      drm/omap: Move GEM BO to drm_framebuffer
      drm/omap: Move buffer pitch/offset to drm_framebuffer
      drm/gma500: Fix Medfield for drm_framebuffer move
      drm/mtk: Remove impossible internal error
      drm/mtk: Move GEM BO to drm_framebuffer
      drm/mtk: mtk_drm_fb -> drm_framebuffer

Daniel Vetter (29):
      drm/fb-helper: Fix typo on kerneldoc
      drm/gem-fb-helper: Always do implicit sync
      drm/vc4: Always obey implicit sync
      drm/omap: gem: Fix mm_list locking
      drm/omap: gem: Switch to gem_free_object_unlocked()
      dma-fence: remove fill_driver_data callback
      dma-fence: Make ->enable_signaling optional
      dma-fence: Allow wait_any_timeout for all fences
      drm: Fix hdmi connector content type property docs
      dma-fence: Make ->wait callback optional
      drm/amdgpu: Remove unecessary dma_fence_ops
      drm: Remove unecessary dma_fence_ops
      drm/etnaviv: Remove unecessary dma_fence_ops
      drm/qxl: Remove unecessary dma_fence_ops
      drm/vc4: Remove unecessary dma_fence_ops
      drm/virtio: Remove unecessary dma_fence_ops
      dma-fence: Polish kernel-doc for dma-fence.c
      drm: move drv test macros out of drmP.h
      drm/doc: switch drm_connector_state to inline comments
      drm/doc: polish for sturct drm_connector
      drm: drop _mode_ from update_edit_property()
      drm: drop _mode_ from drm_mode_connector_attach_encoder
      drm: drop _mode_ from remaining connector functions
      drm: Switch drm_plane_state to inline kerneldoc style
      drm: switch drm_plane to inline comments
      drm/doc: move struct drm_crtc to in-line comments
      drm/doc: Group the fb gem helpers better
      drm/doc: Include drm_of.c helpers
      drm/doc: use inline kerneldoc style for drm_crtc_state

Darren Powell (2):
      drm/amd: Remove errors from sphinx documentation
      drm/amd: Add sphinx documentation for amd_ip_funcs

Dave Airlie (39):
      Merge tag 'drm-intel-next-2018-06-06' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2018-06-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-2018-06-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2018-06-27' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge v4.18-rc3 into drm-next
      Merge tag 'omapdrm-4.19' of git://git.kernel.org/.../tomba/linux
into drm-next
      Merge branch 'vmwgfx-next' of
git://people.freedesktop.org/~thomash/linux into drm-next
      Merge tag 'drm-misc-next-2018-07-04' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge commit 'refs/for-upstream/mali-dp' of
git://linux-arm.org/linux-ld into drm-next
      Merge tag 'tilcdc-4.19' of https://github.com/jsarha/linux into drm-n=
ext
      Merge branch 'drm-next-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'vmwgfx-next-4.19-2' of
git://people.freedesktop.org/~thomash/linux into drm-next
      Merge tag 'vmwgfx-next-4.19-3' of
git://people.freedesktop.org/~thomash/linux into drm-next
      Merge tag 'drm-misc-next-2018-07-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'mediatek-drm-next-4.19' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-next
      Merge tag 'drm-intel-next-2018-07-09' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'linux-4.19' of git://github.com/skeggsb/linux into drm-=
next
      Merge tag 'drm-misc-next-2018-07-18' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2018-07-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm-next-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'imx-drm-next-2018-07-20' of
git://git.pengutronix.de/git/pza/linux into drm-next
      Merge branch 'for-upstream/malidp-fixes' of
git://linux-arm.org/linux-ld into drm-next
      Merge tag 'exynos-drm-next-for-v4.19' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge branch 'drm-next-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-amdkfd-next-2018-07-28' of
git://people.freedesktop.org/~gabbayo/linux into drm-next
      BackMerge v4.18-rc7 into drm-next
      Merge branch 'drm-udl-next' of
git://people.freedesktop.org/~airlied/linux into drm-next
      Merge tag 'drm-msm-next-2018-07-30' of
git://people.freedesktop.org/~robclark/linux into drm-next
      Merge branch 'drm-armada-devel' of
git://git.armlinux.org.uk/~rmk/linux-arm into drm-next
      Merge branch 'for-upstream/hdlcd' of
git://linux-arm.org/linux-ld into drm-next
      Merge branch 'drm-tda998x-devel' of
git://git.armlinux.org.uk/~rmk/linux-arm into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next
      Merge branch 'drm-next-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2018-08-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2018-08-06' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'imx-drm-next-2018-08-03' of
git://git.pengutronix.de/git/pza/linux into drm-next
      Merge tag 'imx-drm-fixes-2018-08-03' of
git://git.pengutronix.de/git/pza/linux into drm-next
      Merge branch 'drm-next-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-next

Dave Stevenson (1):
      drm/vc4: Add support for SAND modifier.

David Francis (8):
      drm/amd/display: Add front end for dp debugfs files
      drm/amd/display: Add CRC support for DCN
      drm/amd/display: Expose couple OPTC functions through header
      drm/amd/display: On dce100, set clocks to 0 on suspend
      drm/amd/display: Implement backlight_ops.get_brightness
      drm/amd/display: Read back max backlight value at boot
      drm/amd/display: Destroy aux_engines only once
      drm/amd/display: Implement custom degamma lut on dcn

David Herrmann (1):
      drm: provide management functions for drm_file

David Lechner (4):
      MAINTAINERS: fix path to ilitek, ili9225 device tree bindings
      dt-bindings: Add vendor prefix for Adafruit
      dt-bindings: new binding for Ilitek ILI9341 display panels
      drm/tinydrm: new driver for ILI9341 display panels

David Panariti (3):
      drm/amdgpu: Added ISR for CP ECC/EDC interrupt v2.
      drm/amdgpu: Add interrupt SQ source struct to amdgpu_gfx struct v2.
      drm/amdgpu: Add plumbing for handling SQ EDC/ECC interrupts v2.

Deepak Rawat (13):
      drm/vmwgfx: Perform topology validation during atomic modeset.
      drm/vmwgfx: Use modeset display memory validation for layout ioctl
      drm/vmwgfx: Perform memory validations only when need full modeset.
      drm/vmwgfx: Remove primary memory validation against mode while
creating fb
      drm/vmwgfx: Use a mutex to protect gui positioning in vmw_display_uni=
t
      drm/vmwgfx: Add gui_x/y to vmw_connector_state
      drm/vmwgfx: Update the device headers
      drm/vmwgfx: Add SM4_1 flag
      drm/vmwgfx: Add support for SVGA3dCmdDefineGBSurface_v3
      drm/vmwgfx: Support for SVGA3dSurfaceAllFlags in vmwgfx
      drm/vmwgfx: Add new ioctl for GB surface create and reference
      drm/vmwgfx: Add support for multisampling
      drm/vmwgfx: Expose SM4_1 param to user space

Dhinakaran Pandiyan (16):
      drm/i915/psr: Nuke PSR support for VLV and CHV
      drm/i915/psr: Avoid DPCD reads when panel does not support PSR
      drm/i915/psr: Check for SET_POWER_CAPABLE bit at PSR init time.
      drm/i915/psr: Avoid unnecessary DPCD read of DP_PSR_CAPS
      drm/i915/psr: Fall back to max. synchronization latency if DPCD read =
fails
      drm/i915/psr: Fix ALPM cap check for PSR2
      drm/i915/psr: Set idle frame count based on sink synchronization late=
ncy
      drm/i915/icl: Extend AUX F interrupts to ICL
      drm/i915/icl: GSE interrupt moves from DE_MISC to GU_MISC
      drm/i915/icl: Support for TC North Display interrupts
      drm/i915/icl: Handle hotplug interrupts for DP over TBT
      drm/i915/psr: Fix warning in intel_psr_activate()
      drm/i915/psr: Fix race in intel_psr_work()
      drm/i915/psr: Warn for erroneous enabling of both PSR1 and PSR2.
      drm/i915: Remove unnecessary check for unsupported modifiers for NV12
      drm/i915/psr: Split sink status into a separate debugfs node

Dirk Hohndel (VMware) (7):
      drm: add SPDX idenitifier and clarify license
      drm: add SPDX identifier and clarify license
      drm/noveau: add SPDX identifier and clarify license
      drm/vmwgfx: add SPDX idenitifier and clarify license
      drm/vmwgfx: add SPDX idenitifier and clarify license
      drm/amd: add SPDX identifier and clarify license
      drm/radeon: add SPDX identifier and clarify license

Dmytro Laktyushkin (35):
      drm/amd/display: upgrade scaler math
      drm/amd/display: add dentist frequency to resource pool
      drm/amd/display: replace clocks_value struct with dc_clocks
      drm/amd/display: redesign dce/dcn clock voltage update request
      drm/amd/display: rename display clock block to dccg
      drm/amd/display: move clock programming from set_bandwidth to dccg
      drm/amd/display: remove invalid assert when no max_pixel_clk is found
      drm/amd/display: get rid of cur_clks from dcn_bw_output
      drm/amd/display: move dcn1 dispclk programming to dccg
      drm/amd/display: clean up dccg divider calc and dcn constructor
      drm/amd/display: rename dce_disp_clk to dccg
      drm/amd/display: clean up set_bandwidth usage
      drm/amd/display: remove unnecessary pplib volage requests that
are asserting
      drm/amd/display: fix dccg dcn1 ifdef
      drm/amd/display: fix pplib voltage request
      drm/amd/display: add CHG_DONE mash/sh defines for dentist
      drm/amd/display: change dentist DID enum values to uppercase
      drm/amd/display: add safe_to_lower support to dcn wm programming
      drm/amd/display: clean rq/dlg/ttu reg structs before calculations
      drm/amd/display: move dml defaults to respective dcn resource files
      drm/amd/display: fix dcn1 watermark range reporting
      drm/amd/display: remove dcn1 watermark sets b, c and d
      drm/amd/display: separate out wm change request dcn workaround
      drm/amd/display: move dcn watermark programming to set_bandwidth
      drm/amd/display: remove soc_bounding_box.c
      drm/amd/display: dcc always on for bw calculations on raven
      drm/amd/display: remove dentist_vco_freq from resource_pool
      drm/amd/display: drop unused register defines
      drm/amd/display: add additional info for cursor position programming
      drm/amd/display: add dcn cursor hotsport rotation and mirror support
      drm/amd/display: add max scl ratio to soc bounding box
      drm/amd/display: update dml to match DV dml
      drm/amd/display: properly turn autocal off
      drm/amd/display: add vbios table check for enabling dp ss
      drm/amd/display: program display clock on cache match

Dominique Martinet (1):
      drm/i915/tv: fix strncpy truncation warning

Eames Trinh (1):
      drm: gma500: Changed __attribute__((packed)) to __packed

Emily Deng (2):
      drm/amdgpu: Correct the ndw of bo update mapping.
      drm/amdgpu/sriov: give 8s for recover vram under RUNTIME

Enrico Scholz (1):
      gpu: ipu-v3: csi: pass back mbus_code_to_bus_cfg error codes

Eric Anholt (12):
      drm: Trust format_mod_supported() when it OKs a plane modifier.
      drm/vc4: Add missing formats to vc4_format_mod_supported().
      drm/bridge: Move the struct drm_bridge member kerneldoc inline.
      drm/v3d: Take a lock across GPU scheduler job creation and queuing.
      drm/v3d: Remove the bad signaled() implementation.
      drm: Consider drivers setting DRIVER_ATOMIC as atomic.
      drm/v3d: Define the fourcc modifier for the Broadcom UIF format.
      drm/vc4: Make DSI call into the bridge after the DSI link is enabled.
      drm/v3d: Delay the scheduler timeout if we're still making progress.
      drm/v3d: Remove unnecessary dma_fence_ops.
      drm/v3d: Add missing v3d documentation structure.
      drm/v3d: Fix a grammar nit in the scheduler docs.

Eric Bernstein (9):
      drm/amd/display: pass pipe_ctx straight to blank_pixel_data
      drm/amd/display: Add function to get optc active size
      drm/amd/display: DP YCbCr 4:2:0 support
      drm/amd/display: Stream encoder update
      drm/amd/display: Allow DP register double buffer
      drm/amd/display: Add num_opp to resource_caps
      drm/amd/display: Separate HUBP surface size and rotation/mirror
programming
      drm/amd/display: Add Azalia registers to HW sequencer
      drm/amd/display: Expose bunch of functions from dcn10_hw_sequencer

Eric Huang (1):
      Revert "drm/amd/powerplay: fix performance drop on Vega10"

Eric Yang (1):
      drm/amd/display: support access ddc for mst branch

Evan Quan (27):
      drm/amd/powerplay: correct vega12 bootup values settings
      drm/amd/powerplay: smc_dpm_info structure change
      drm/amd/powerplay: drop the acg fix
      drm/amd/powerplay: revise default dpm tables setup
      drm/amd/powerplay: retrieve all clock ranges on startup
      drm/amd/powerplay: revise clock level setup
      drm/amd/powerplay: initialize uvd/vce powergate status v4
      drm/amd/powerplay: correct smc display config for multi monitor
      drm/amd/powerplay: drop unnecessary uclk hard min setting
      drm/amd/powerplay: correct vega12 max num of dpm level
      drm/amd/powerplay: apply clocks adjust rules on power state change
      drm/amd/powerplay: set vega12 pre display configurations
      drm/amd/powerplay: correct vega12 thermal support as true
      drm/amd/powerplay: cosmetic fix
      drm/amdgpu: pin the csb buffer on hw init v2
      drm/amdgpu: init CSIB regardless of rlc version and pg status
      drm/amdgpu: correct rlc save restore list initialization for v2_1
      drm/amdgpu: drop mmRLC_PG_CNTL clear v2
      drm/amdgpu: no touch for the reserved bit of RLC_CGTT_MGCG_OVERRIDE
      drm/amdgpu: reduce the idle period that RLC has to wait before
request CGCG
      drm/amd/powerplay: add vega12 SMU gfxoff support v3
      drm/amd/powerplay: no need to mask workable gfxoff feature for vega12
      drm/amd/powerplay: convert the sclk/mclk into Mhz for comparation
      drm/amd/powerplay: fixed uninitialized value
      drm/amd/powerplay: slow UCLK switch when multiple displays not in syn=
c
      drm/amd/powerplay: correct the argument for PPSMC_MSG_SetUclkFastSwit=
ch
      drm/amd/powerplay: allow slow switch only if NBPState enabled v2

Fatemeh Darbehani (1):
      drm/amd/display: Return out_link_loss from interrupt handler

Feifei Xu (1):
      drm/amdgpu/gfx9: Update golden settings for vg10.

Felix Kuehling (6):
      drm/amdkfd: Reliably prevent reclaim-FS while holding DQM lock
      drm/amdkfd: Stop using GFP_NOIO explicitly
      drm/amd: Add CU-masking ioctl definition to kfd_ioctl.h
      drm/amdkfd: Add CU-masking ioctl to KFD
      drm/amdgpu: Add kfd2kgd.set_compute_idle interface
      drm/amdkfd: Call kfd2kgd.set_compute_idle

Flora Cui (1):
      drm/amdgpu: remove duplicated codes

Gerd Hoffmann (1):
      dma-buf: make map_atomic and map function pointers optional

Gloria Li (1):
      drm/amd/display: add HDR visual confirm

Gustavo A. R. Silva (9):
      drm/amd/display: fix type of variable
      drm/gma500: Fix potential NULL pointer dereference
      drm/gma500: Fix compile warning
      drm/i915: Mark expected switch fall-throughs
      drm/amd/display/dc/dce: Fix multiple potential integer overflows
      drm/ttm: use swap macro in ttm_bo_handle_move_mem
      drm/pl111: Use 64-bit arithmetic instead of 32-bit
      drm/msm: Replace PTR_RET with PTR_ERR_OR_ZERO
      drm/amdgpu/pm: Fix potential Spectre v1

Gustavo Padovan (4):
      Merge drm-upstream/drm-next into drm-misc-next
      Merge tag 'ib-fbdev-drm-v4.19-deferred-console-takeover' of
https://github.com/bzolnier/linux into drm-misc-next
      Merge tag 'ib-fbdev-drm-v4.19-deferred-console-takeover-fixup'
of https://github.com/bzolnier/linux into drm-misc-next
      Merge drm-upstream/drm-next into drm-misc-next

Haneen Mohammed (2):
      drm: Add checks for atomic_[duplicate/destroy]_state with atomic driv=
ers
      drm/vkms: Introduce basic VKMS driver

Hang Yuan (1):
      drm/i915/gvt: declare gvt as i915's soft dependency

Hans Verkuil (4):
      drm: add support for DisplayPort CEC-Tunneling-over-AUX
      drm-kms-helpers.rst: document the DP CEC helpers
      drm/i915: add DisplayPort CEC-Tunneling-over-AUX support
      drm_dp_cec.c: fix formatting typo: %pdH -> %phD

Hans de Goede (4):
      printk: Export is_console_locked
      fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
      console/fbcon: Add support for deferred console takeover
      console: dummycon: export dummycon_[un]register_output_notifier

Harry Wentland (19):
      drm/amdgpu: Add BRACKET_LAYOUT_ENUMs to ObjectID.h
      drm/amd/display: Move i2c and aux structs into dc_ddc_types.h
      Revert "drm/amd/display: Fix indentation in dcn10 resource constructo=
r"
      drm/amd/display: Make function pointer structs const
      drm/amd/pp: Send khz clock values to DC for smu7/8
      Revert "drm/amd/display: Don't return ddc result and read_bytes
in same return value"
      Revert "drm/amd/display: make dm_dp_aux_transfer return payload
bytes instead of size"
      drm/amd/display: Serialize is_dp_sink_present
      drm/amd/display: Break out function to simply read aux reply
      drm/amd/display: Return aux replies directly to DRM
      drm/amd/display: dal 3.1.56
      drm/amd/display: Fix some checkpatch.pl errors and warnings in
dc_link_dp.c
      drm/amd/display: Drop unused backlight functions in DM
      drm/amd/display: Honor pplib stutter mask for all ASICs in DC
      drm/amd/display: DC 3.1.58
      drm/amd/display: DC 3.1.59
      drm/amd: Add missing fields in atom_integrated_system_info_v1_11
      drm/amd/display: Report non-DP display as disconnected without EDID
      drm/amd/display: Only require EDID read for HDMI and DVI

Heiko Stuebner (1):
      drm/rockchip: vop: split out core clock enablement into separate func=
tions

Hersen Wu (10):
      drm/amd/display: AUX will exit when HPD LOW detected
      drm/amd/display: Fix indentation in dcn10 resource constructor
      drm/amd/display: Linux Set/Read link rate and lane count through debu=
gfs
      drm/amd/display: set-read link rate and lane count through debugfs
      drm/amd/display: hook dp test pattern through debugfs
      drm/amd/display: Linux set/read lane settings through debugfs
      drm/amd/display: Linux hook test pattern through debufs
      drm/amd/display: dp debugfs allow link rate lane count greater
than dp rx reported caps
      drm/amd/display: Fix DP HBR2 Eye Diagram Pattern on Carrizo
      drm/amd/display: display connected to dp-1 does not light up

Huang Rui (9):
      drm/amdgpu: fix the wrong type of gem object creation
      drm/amdgpu: simplify the bo reference on amdgpu_bo_update
      drm/ttm: add ttm_set_memory header (v2)
      drm/ttm: clean up non-x86 definitions on ttm_page_alloc_dma
      drm/ttm: clean up non-x86 definitions on ttm_page_alloc
      drm/amdgpu: clean up the superfluous space and align the comment
text for amdgpu_ttm
      drm/ttm: fix missed conversion of set_pages_array_uc
      drm/ttm: Add ttm_set_pages_wc and ttm_set_pages_uc helper
      drm/ttm: clean up non-x86 definitions on ttm_tt

Hugo Hu (3):
      drm/amd/display: Correct calculation of duration time.
      drm/amd/display: Patch for extend time to panel poweron.
      drm/amd/display: Initialize data structure for DalMpVisualConfirm.

Imre Deak (11):
      drm/i915/skl: Add warn about unsupported CDCLK rates
      drm/i915/ddi: s/crtc->config/old_crtc_state in haswell_crtc_disable()
      drm/i915/ddi: Push pipe clock enabling to encoders
      drm/i915/ddi: Check transcoder instead of port when setting HDMI info=
frame
      drm/i915/ddi: Set HDMI infoframes with pipe clocks enabled
      drm/i915/ddi: Removed unused var from hsw_write_infoframe()
      drm/i915/icl: Fix MG PLL setup when refclk is 38.4MHz
      drm/i915/icl: Do read-modify-write as needed during MG PLL programmin=
g
      drm/i915/ddi: Get AUX power domain for DP main link too
      drm/i915/icl: Add power well support
      drm/i915/ddi: Simplify get_encoder_power_domains()

Inki Dae (2):
      drm/bridge: sil_sii8620: do not have a dependency of RC_CORE
      Merge tag 'exynos-drm-fixes-for-v4.18-rc4' of
git://git.kernel.org/.../daeinki/drm-exynos into exynos-drm-next

Jagan Teki (1):
      drm/panel: simple: Add support for Rocktech RK070ER9427 LCD panel

James Ausmus (1):
      drm/i915/icl: DP_AUX_E is valid on ICL+

James Zhu (1):
      drm/amdgpu/vg20:support new UVD FW version naming convention

Jan Luebbe (1):
      gpu: ipu-v3: csi: support RGB565 on parallel bus

Jan Tuerk (3):
      dt-bindings: display: Document the EDT et* displays in one file.
      drm/panel: Add support for the EDT ETM0700G0BDH6
      drm/panel: Add support for the EDT ETM0700G0EDH6

Jani Nikula (20):
      Revert "drm/i915/edp: Allow alternate fixed mode for eDP if available=
."
      drm/i915: fix guest virtual PCH detection on non-PCH systems
      drm/i915: clean up virtual PCH special case handling
      drm/i915: be more strict about HAS_PCH_NOP() usage
      drm/i915: fix PCH_NOP setting for non-PCH platforms
      drm/i915/perf: make oa format tables const
      drm/i915/opregion: move acpi notifier to dev_priv
      drm/i915/dsm: remove unnecessary dsm priv structure
      drm/i915/vbt: switch to kernel unsigned int types
      drm/i915/hdmi: switch to kernel unsigned int types
      drm/i915/uncore: switch to kernel unsigned int types
      drm/i915/dvo: switch to kernel unsigned int types
      drm/i915/backlight: switch to kernel unsigned int types
      drm/i915/audio: switch to kernel unsigned int types
      drm/i915/lspcon: switch to kernel unsigned int types
      drm/i915/audio: constify ELD pointers
      drm/i915: abstract and document register picking macros
      drm/i915/dsi: rename the current DSI files based on first platform
      drm/i915/dsi: use vlv and bxt prefixes for the global DSI functions
      drm/i915/dsi: update some of the platform based checks

Jay Cornwall (1):
      drm/amdkfd: Fix race between scheduler and context restore

Jernej Skrabec (30):
      dt-bindings: display: sunxi-drm: Add TCON TOP description
      drm/sun4i: Add TCON TOP driver
      drm/sun4i: Fix releasing node when enumerating enpoints
      drm/sun4i: Split out code for enumerating endpoints in output port
      drm/sun4i: Add support for traversing graph with TCON TOP
      drm/sun4i: Don't skip TCONs if they don't have channel 0
      drm/sun4i: tcon: Generalize engine search algorithm
      drm/sun4i: Don't check for LVDS and RGB when TCON has only ch1
      drm/sun4i: Don't check for panel or bridge on TV TCONs
      drm/sun4i: Add support for R40 mixers
      dt-bindings: display: sun4i-drm: Add description of A64 HDMI PHY
      drm/sun4i: Enable DW HDMI PHY clock
      drm/sun4i: Don't change clock bits in DW HDMI PHY driver
      drm/sun4i: DW HDMI PHY: Add support for second PLL
      drm/sun4i: Add support for second clock parent to DW HDMI PHY clk dri=
ver
      drm/sun4i: Add support for A64 HDMI PHY
      drm: of: Export and rename drm_crtc_port_mask()
      drm/sun4i: DW HDMI: Expand algorithm for possible crtcs
      dt-bindings: display: sun4i-drm: Add R40 display engine compatible
      drm/sun4i: Add R40 display engine compatible
      drm/sun4i: tcon-top: Cleanup clock handling
      drm/sun4i: tcon: Release node when traversing of graph
      dt-bindings: display: sun4i-drm: Add R40 TV TCON description
      drm/sun4i: DW HDMI: Release nodes if error happens during CRTC search
      drm/sun4i: mixer: Order includes alphabetically
      drm/sun4i: tcon-top: Add helpers for mux switching
      drm/sun4i: tcon-top: Remove mux configuration at probe time
      dt-bindings: display: sun4i-drm: Fix order of DW HDMI PHY compatibles
      drm/sun4i: mixer: Read id from DT
      drm/sun4i: Implement zpos for DE2

Jerry (Fangzhi) Zuo (2):
      drm/amd/display: Add YCbCr420 only support for HDMI 4K@60
      drm/amd/display: Fix Vega10 black screen after mode change

Jeykumar Sankaran (10):
      drm: add msm compressed format modifiers
      drm/msm: enable zpos normalization
      drm/msm: #define MDP version numbers
      drm/msm: Use labels for unwinding in the error path
      drm/msm: #define MAX_<OBJECT> in msm_drv.h
      drm/msm: Add .commit() callback to msm_kms functions
      drm/msm: Add pm_suspend/resume callbacks to msm_kms
      drm/msm: Add SDM845 DPU support
      dt-bindings: msm/dsi: Add mdp transfer time to msm dsi binding
      dt-bindings: msm/disp: Add bindings for Snapdragon 845 DPU

Jia-Ju Bai (1):
      gpu: drm: amdgpu: Replace mdelay with msleep in cik_pcie_gen3_enable(=
)

John Stultz (1):
      drm: kirin: Remove useless "Scale not support" error message

Jon Bloomfield (2):
      drm/i915/gtt: Add read only pages to gen8_pte_encode
      drm/i915/gtt: Read-only pages for insert_entries on bdw+

Jordan Crouse (19):
      drm/msm/gpu: Increase the pm runtime autosuspend for 5xx
      include: Move ascii85 functions from i915 to linux/ascii85.h
      drm: drm_printer: Add printer for devcoredump
      drm: Add drm_puts() to complement drm_printf()
      drm: Add a -puts() function for the seq_file printer
      drm: Add puts callback for the coredump printer
      drm/msm/gpu: Capture the state of the GPU
      drm/msm/gpu: Convert the GPU show function to use the GPU state
      drm/msm/gpu: Rearrange the code that collects the task during a hang
      drm/msm/gpu: Capture the GPU state on a GPU hang
      drm/msm/adreno: Convert the show/crash file format
      drm/msm/adreno: Add ringbuffer data to the GPU state
      drm/msm/adreno: Add a5xx specific registers for the GPU state
      drm/msm/gpu: Add the buffer objects from the submit to the crash dump
      drm/msm/disp/dpu: Remove unused code from drm_encoder.c
      drm/msm/disp/dpu: Remove unused code from drm_crtc.c
      drm/msm/disp/dpu: Remove dpu_kms_utils
      drm/msm/disp/dpu: Remove unused functions from dpu_formats.c
      drm/msm/disp/dpu: Mark a handful of functions as static

Jos=C3=A9 Roberto de Souza (8):
      drm/i915/icl: Disable pipe CSC and gamma in cursor plane
      drm/i915/whl: Introducing Whiskey Lake platform
      drm/i915/aml: Introducing Amber Lake platform
      drm/i915/psr: Remove intel_crtc_state parameter from disable_source()
      drm/i915/psr: Begin to handle PSR/PSR2 errors set by sink
      drm/i915/psr: Handle PSR errors
      drm/i915/psr: Avoid PSR exit max time timeout
      drm/i915/psr: Enable CRC check in the static frame on the sink side

Julia Lawall (1):
      drm/rockchip: lvds: add missing of_node_put

Jun Lei (2):
      drm/amd/display: add new dc debug structure to track debug data
      drm/amd/display: separate dc_debug into dc_debug_options and dc_debug=
 data

Junwei Zhang (7):
      drm/amdgpu: remove unused parameter for va update
      drm/amdgpu: correct GART location info
      drm/amdgpu: separate gpu address from bo pin
      drm/amdgpu: allocate gart memory when it's required (v3)
      drm/amdgpu: fix kmap error handling for bo creations
      drm/scheduler: add NULL pointer check for run queue (v2)
      drm/amdgpu: correct evict flag for bo move

Jyri Sarha (2):
      drm/panel: Remove drm_panel_detach() calls from all panel drivers
      drm/panel: Add device_link from panel device to DRM device

J=C3=A9r=C3=B4me Glisse (1):
      drm/nouveau/mmu/gp10b: remove ghost file

Karol Herbst (2):
      drm/nouveau/bios/vpstate: There are some fermi vbios with no
boost or tdp entry
      drm/nouveau/debugfs: Wake up GPU before doing any reclocking

Kees Cook (4):
      drm/sun4i: Remove VLA usage
      drm/amd/display: Use 2-factor allocator calls
      drm/nouveau/secboot/acr: Remove VLA usage
      drm/amdgpu/pm: Remove VLA usage

Ken Chalmers (1):
      drm/amd/display: Fix new stream count check in dc_add_stream_to_ctx

Kenneth Graunke (1):
      drm/i915: Enable provoking vertex fix on Gen9 systems.

Krunoslav Kovac (8):
      drm/amd/display: Dynamic HDR metadata mem buffer
      drm/amd/display: Add use_dynamic_meta flag to stream_state
      drm/amd/display: Drop duplicate
dc_stream_set_static_screen_events definition
      drm/amd/display: Make it more clear when info frames affect DP or HDM=
I
      drm/amd/display: Convert quotes to Ascii quotes
      drm/amd/display: Implement cursor multiplier
      drm/amd/display: Refactor SDR cursor boosting in HDR mode
      drm/amd/display: Null ptr check for set_sdr_white_level

Krzysztof Kozlowski (1):
      drm/exynos/mixer: Remove unused local variable priv

Lan Xiao (1):
      drm/amdkfd: fix zero reading of VMID and PASID for Hawaii

Laura Abbott (2):
      drm/gma500: Remove VLA
      drm/i2c: tda998x: Remove VLA usage

Laurent Pinchart (6):
      drm/omap: gem: Rename GEM function with omap_gem_* prefix
      drm/omap: gem: Merge __omap_gem_get_pages() and omap_gem_attach_pages=
()
      drm/omap: gem: Don't take struct_mutex to get GEM object mmap offset
      drm/omap: gem: Replace struct_mutex usage with omap_obj private lock
      drm: arm: hdlcd: Don't destroy plane manually in hdlcd_setup_crtc()
      drm: arm: hdlcd: Use drm_atomic_helper_shutdown() to disable
planes on removal

Leo (Sunpeng) Li (4):
      drm/amd/display: Fix compile error on older GCC versions
      drm/amd/display: Right shift AUX reply value sooner than later
      drm/amd/display: Read AUX channel even if only status byte is returne=
d
      drm/amd/display: Use requested HDMI aspect ratio

Leo Liu (3):
      drm/amdgpu: Take VCN jpeg ring into account in idle work handler
      drm/amdgpu: move cache window setup after power and clock resume
      drm/amdgpu: get VCN start to process in the dpm disabled case

Leonard Crestez (2):
      drm/imx: Remove last traces of struct imx_drm_crtc
      drm/imx: Remove unused field imx_drm_device.pipes

Lin Huang (5):
      drm/rockchip: cnd-dp: adjust spdif register setting
      drm/panel: p079zca: Refactor panel driver to support multiple panels
      drm/panel: p079zca: Add variable unprepare_delay properties
      dt-bindings: Add Innolux P097PFG panel bindings
      drm/panel: p079zca: Support Innolux P097PFG panel

Linus Walleij (1):
      drm/pl111: Support Nomadik LCDC variant

Lionel Landwerlin (2):
      drm/i915: drop one bit on the hw_id when using guc
      drm/i915/perf: fix ctx_id read with GuC & ICL

Liviu Dudau (6):
      drm: writeback: Add client capability for exposing writeback connecto=
rs
      drm: mali-dp: Add support for writeback on DP550/DP650
      drm/mali-dp: Add writeback support for DP500.
      drm/mali-dp: Add RGB writeback formats for DP500.
      drm/mali-dp: Improve writeback handling for DP500.
      drm/arm/hdlcd: Reject atomic commits that disable only the plane

Lubosz Sarnecki (1):
      drm/edid: Quirk Vive Pro VR headset non-desktop.

Lucas De Marchi (2):
      drm/i915: document PCH_NOP
      drm/i915: remove check for aux irq

Lucas Stach (4):
      drm/panel: simple: AUO P320HVN03 uses SPWG data ordering
      drm/etnaviv: protect sched job submission with fence mutex
      drm/etnaviv: fix crash in GPU suspend when init failed due to
buffer placement
      drm/scheduler: fix timeout worker setup for out of order job completi=
ons

Lukasz Majewski (1):
      display: panel: Add AUO g070vvn01 display support (800x480)

Lyude Paul (7):
      drm/amdgpu: Make struct amdgpu_atif private to amdgpu_acpi.c
      drm/amdgpu: s/disp_detetion_ports/disp_detection_ports/
      drm/amdgpu: Add amdgpu_atpx_get_dhandle()
      drm/amdgpu: Dynamically probe for ATIF handle (v2)
      drm/nouveau: Fix runtime PM leak in drm_open()
      drm/dp_helper: Add DP aux channel tracing
      drm/connector: Fix typo in drm_connector_list_iter_next()

Maarten Lankhorst (5):
      drm/i915: Call intel_opregion_notify_encoder in
intel_sanitize_encoder, v2.
      drm/i915: Block enabling FBC until flips have been completed
      drm/i915: Remove delayed FBC activation.
      drm/i915: Remove support for legacy debugfs crc interface
      drm/crc: Only report a single overflow when a CRC fd is opened

Madhav Chauhan (7):
      drm/i915/icl: Define register for DSI PLL
      drm/i915/icl: Program DSI Escape clock Divider
      drm/i915/icl: Define DSI mode ctl register
      drm/i915/icl: Enable DSI IO power
      drm/i915/icl: Define PORT_CL_DW_10 register
      drm/i915/icl: Power down unused DSI lanes
      drm/i915/icl: Define AUX lane registers for Port A/B

Mahesh Kumar (3):
      drm/i915/icl: fix icl_unmap/map_plls_to_ports
      drm/i915/icl: Don't update enabled dbuf slices struct until updated i=
n hw
      drm/i915/icl: fix gmbus gpio pin mapping

Manasi Navare (5):
      drm/i915/icl: Add register definition for DFLEXDPMLE
      drm/i915/icl: Get DDI clock for ICL based on PLLs.
      drm/i915/icl: Add DDI HDMI level selection for ICL
      drm/i915/icl: Add allowed DP rates for Icelake
      drm/i915/dp: Add support for HBR3 and TPS4 during link training

Marek Szyprowski (6):
      drm/exynos: g2d: Convert to driver component API
      drm/exynos: gem: Simplify access to exynos GEM objects
      drm/exynos: Use common exynos_drm_gem_get()/put() functions for GEM l=
ookup
      drm/exynos: Drop useless check from exynos_drm_{suspend,resume}
      drm/exynos: Suspend/resume display pipeline as early/late as possible
      drm/exynos: Ensure suspended runtime PM state during system suspend

Mario Kleiner (1):
      drm/nouveau/kms/nv50-: Allow vblank_disable_immediate

Masahiro Yamada (1):
      drm/sched: remove unneeded -Iinclude/drm compiler flag

Maxime Ripard (4):
      drm/vc4: plane: Expand the lower bits by repeating the higher bits
      dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
      drm/panel: Add Ilitek ILI9881c panel driver
      drm/sun4i: tcon-top: Fix return type warning

Michael Grzeschik (1):
      gpu: ipu-csi: add rgb/bgr888 24bit support to mbus_code_to_bus_cfg

Michal Vok=C3=A1=C4=8D (2):
      dt-bindings: Add DataImage, Inc. vendor prefix
      drm/panel: simple: Add support for DataImage SCF0700C48GGU18

Michal Wajdeczko (8):
      drm/i915/uc: Trivial s/dev_priv/i915 in intel_uc.c
      drm/i915/guc: Don't read SOFT_SCRATCH(15) on MMIO error
      drm/i915: Move i915_gem_fini to i915_gem.c
      drm/i915: Correctly handle error path in i915_gem_init_hw
      drm/i915/guc: Don't leak stage descriptor pool on init failure
      drm/i915/guc: Use intel_guc_init_misc to hide GuC internals
      drm/i915/uc: Fetch GuC/HuC firmwares from guc/huc specific init
      drm/i915/guc: Print CTL params passed to Guc

Micha=C5=82 Winiarski (4):
      drm/i915: Tidy error handling in i915_gem_init_hw
      drm/i915/selftests: Fixup GuC FW negative test
      drm/i915/guc: Disable rpm wakeref asserts in GuC irq handler
      drm/i915/kvmgt: Fix compilation error

Michel D=C3=A4nzer (18):
      drm/doc: Add a label for the PRIME Buffer Sharing chapter
      drm/doc: Add initial amdgpu driver documentation
      drm/amdgpu: Add documentation for PRIME related code
      drm/amdgpu: Hook up documentation about memory domains
      drm/amdgpu: Fix-ups for amdgpu_object.c documentation
      drm/amdgpu: Hook up amdgpu_object.c documentation
      drm/amdgpu: Restore :internal: for amdgpu_vm.c documentation
      drm/amdgpu: Use gmc_vram_full_visible in vram_mgr_bo_invisible_size
      drm/amdgpu: Add AMDGPU_GPU_PAGES_IN_CPU_PAGE define
      drm/amdgpu: Remove amdgpu_gem_map_attach target_dev documentation
      drm/amdgpu: Reserve VM root shared fence slot for command submission =
(v3)
      drm/amdgpu: Keep track of amount of pinned CPU visible VRAM
      drm/amdgpu: Make pin_size values atomic
      drm/amdgpu: Warn and update pin_size values when destroying a pinned =
BO
      dma-buf: Move BUG_ON from _add_shared_fence to _add_shared_inplace
      drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86
      drm/amdgpu: Fix RLC safe mode test in gfx_v9_0_enter_rlc_safe_mode
      drm/amdgpu: Don't warn on destroying a pinned BO

Michel Thierry (2):
      drm/i915/perf: use the lrc_desc to get the ctx hw id in gen8-10
      drm/i915/perf: fix gen11 engine class shift

Mika Kuoppala (4):
      drm/i915: Cancel reset preparations on failed resets
      drm/i915: Add WaKBLVECSSemaphoreWaitPoll
      drm/i915: Fix context ban and hang accounting for client
      Revert "drm/i915/icl: WaEnableFloatBlendOptimization"

Mikita Lipski (19):
      drm/amd/display: Drop to fail-safe mode if edid is bad
      drm/amd/display: Write TEST_EDID_CHECKSUM_WRITE for EDID tests
      drm/amd/display: Do not skip FBC init in failsafe mode
      drm/amd/display: Adding dm-pp clocks getting by voltage
      drm/amd/display: Apply clock for voltage request
      drm/amd/display: Adding Get static clocks for dm_pp interface
      drm/amd/display: Introduce pp-smu raven functions
      drm/amd/display: Use local structs instead of struct pointers
      drm/amd/display: Add clock types to applying clk for voltage
      drm/amd/display: Enable PPLib calls from DC on linux
      drm/amd/display: Add dmpp clks types for conversion
      drm/amd/display: Convert 10kHz clks from PPLib into kHz
      drm/amd/display: Moving powerplay functions to a separate class
      drm/amd/display: adding ycbcr420 pixel encoding for hdmi
      drm/amd/display: add a check for display depth validity
      drm/amd/display: add pp to dc powerlevel enum translator
      drm/amd/display: Remove unnecessary warning
      drm/amd/display: Don't share clk source between DP and HDMI
      drm/amd/display: update clk for various HDMI color depths

Mikulas Patocka (7):
      udl-kms: change down_interruptible to down
      udl-kms: handle allocation failure
      udl-kms: fix crash due to uninitialized memory
      udl-kms: avoid division
      udl-kms: avoid prefetch
      udl-kms: use spin_lock_irq instead of spin_lock_irqsave
      udl-kms: dont spam the syslog with debug messages

Moses Reuben (1):
      drm/amdkfd: send SIGSEGV to process upon KFD_EVENT_TYPE_MEMORY

Nayan Deshmukh (7):
      drm/scheduler: add documentation
      drm/doc: add a chapter for gpu scheduler
      drm/scheduler: add a pointer to scheduler in the rq
      drm/scheduler: modify args of drm_sched_entity_init
      drm/scheduler: modify API to avoid redundancy
      drm/scheduler: remove sched field from the entity
      drm/scheduler: fix param documentation

Neha Bhende (2):
      drm/vmwgfx: Add CAP2 support in vmwgfx
      drm/vmwgfx: Add support for SVGA3dCmdIntraSurfaceCopy command

Neil Armstrong (1):
      drm/meson: Make DMT timings parameters and pixel clock generic

Nicholas Kazlauskas (3):
      drm/amd/display: Convert remaining loggers off dc_logger
      drm/amd/display: Use calculated disp_clk_khz value for dce110
      drm/amd/display: Add NULL check for enabling dp ss

Nick Desaulniers (1):
      drm/nouveau/nvif: remove const attribute from nvif_mclass

Nickey Yang (2):
      dt-bindings: Add vendor prefix for kingdisplay
      dt-bindings: Add KINGDISPLAY KD097D04 panel bindings

Nicolai H=C3=A4hnle (1):
      drm/amdgpu: fix user fence write race condition

Nicolas Chauvet (1):
      drm/nouveau/secboot/tegra: Enable gp20b/gp10b firmware tag when relev=
ant

Nikola Cornij (2):
      drm/amd/display: Optimize DP_SINK_STATUS_ESI range read on HPD
      drm/amd/display: Add hook for MST root branch info

Noralf Tr=C3=B8nnes (15):
      drm/file: Don't set master on in-kernel clients
      drm: Make ioctls available for in-kernel clients
      drm: Begin an API for in-kernel clients
      drm/fb-helper: Add generic fbdev emulation .fb_probe function
      drm/pl111: Set .gem_prime_vmap and .gem_prime_mmap
      drm/cma-helper: Use the generic fbdev emulation
      drm/debugfs: Add internal client debugfs file
      drm/fb-helper: Finish the generic fbdev emulation
      drm/tinydrm: Use drm_fbdev_generic_setup()
      drm/cma-helper: Remove drm_fb_cma_fbdev_init_with_funcs()
      drm/tinydrm: Fix doc build warnings
      drm/client: Fix: drm_client_new: Don't require DRM to be registered
      drm/client: Fix double free in error path
      drm/arm/hdlcd: Use drm_mode_config_helper_suspend/resume()
      drm/arm/hdlcd: Use drm_fb_cma_fbdev_init/fini()

Oleksandr Andrushchenko (1):
      drm/xen-front: fix pointer casts

Ondrej Zary (1):
      drm/i915: Disable LVDS on Radiant P845

Oscar Mateo (6):
      drm/i915/icl: Read the correct Gen11 interrupt registers
      drm/i915/icl: WaDisableImprovedTdlClkGating
      drm/i915/icl: WaEnableStateCacheRedirectToCS
      drm/i915/icl: Wa_2006665173
      drm/i915/icl: WaEnableFloatBlendOptimization
      drm/i915/icl: Wa_1406463099

Paul Kocialkowski (1):
      drm/sun4i: sun8i: Avoid clearing blending order at each atomic commit

Paulo Zanoni (12):
      drm/i915: enable the pipe/transcoder/planes later on HSW+
      drm/i915/icl: introduce tc_port
      drm/i915/icl: add icelake_get_ddi_pll()
      drm/i915/icl: unconditionally init DDI for every port
      drm/i915/icl: start adding the TBT pll
      drm/i915/icl: implement DVFS for ICL
      drm/i915/icl: update VBT's child_device_config flags2 field
      drm/i915/i915_reg.h: fix the checkpatch SPACING issues
      drm/i915/i915_reg.h: fix the checkpatch SPACE_BEFORE_TAB issues
      drm/i915/i915_reg.h: fix the checkpatch MACRO_ARG_PRECEDENCE issues
      x86/gpu: reserve ICL's graphics stolen memory
      drm/i915: use the ICL stolen memory

Peter Rosin (3):
      drm/rockchip: lvds: avoid duplicating drm_bridge_attach
      drm/i2c: tda998x: find the drm_device via the drm_connector
      drm/i2c: tda998x: split tda998x_encoder_dpms into enable/disable

Peter Ujfalusi (1):
      drm: Add support for extracting sync signal drive edge from videomode

Peter Ziljstra (1):
      locking: WW mutex cleanup

Philipp Zabel (6):
      dt-bindings: Add vendor prefix for DLC Display Co., Ltd.
      drm/panel: simple: Add DLC DLC0700YZG-1 panel
      gpu: ipu-v3: Allow negative offsets for interlaced scanning
      gpu: ipu-v3: add support for XRGB32 and XBGR32 V4L2 pixel formats
      gpu: ipu-v3: default to id 0 on missing OF alias
      drm/etnaviv: mmuv2: use memset32 to init scratch page

Philippe CORNU (4):
      drm/panel: otm8009a: Fix backlight updates
      drm/panel: otm8009a: Fix glitches by moving backlight enable to
otm8009a_enable()
      drm/panel: otm8009a: No message if probe success
      drm/panel: otm8009a: Use new backlight API

Philippe Cornu (2):
      drm: clarify adjusted_mode documentation for bridges
      drm/bridge: spelling and coding style minor fixes

Piotr Piorkowski (6):
      drm/i915/guc: Refactoring preparation of the GUC_CTL_DEBUG parameter
      drm/i915/guc: Refactoring preparation of the GUC_CTL_FEATURE paramete=
r
      drm/i915/guc: Refactoring preparation of the GUC_CTL_LOG_PARAMS param=
eter
      drm/i915/guc: Refactoring preparation of the GUC_CTL_CTXINFO paramete=
r
      drm/i915/guc: Move defines with size of GuC logs to intel_guc_log.h
      drm/i915/guc: Add support for define guc_log_size in megabytes.

Piotr Pi=C3=B3rkowski (1):
      drm/i915/guc: Don't store runtime GuC log level in modparam

Radhakrishna Sripada (3):
      drm/i915/icl: Map VBT DDC Pin to BSpec DDC Pin
      drm/i915/audio: Add 810 MHz clock entries to dp_aud_n_m table
      drm/i915/icl: Add 10-bit support for hdmi

Rajesh Yadav (3):
      drm/msm/dsi: initialize postdiv_lock before use for 10nm pll
      drm/msm/mdp5: subclass msm_mdss for mdp5
      drm/msm: rework vblank event handling in dpu_crtc

Ramalingam C (2):
      drm/i915/gmbus: Increase the Bytes per Rd/Wr Op
      drm/i915/gmbus: Enable burst read

Rex Zhu (33):
      drm/amd/pp: Add S3 support for OD feature
      drm/amd/pp: Make sure clock_voltage_limit_table on dc is valid
      drm/amd/pp: Remove SAMU support in powerplay
      drm/amdgpu: Use real power source in powerplay instand of hardcode
      drm/amd/pp: Implement update_smc_table for CI.
      drm/amdgpu: Get real power source to initizlize ac_power
      drm/amdgpu: Rename set_mmhub_powergating_by_smu to powergate_mmhub
      drm/amd/pp: Rename enable_per_cu_power_gating to powergate_gfx
      drm/amd/pp: Unify powergate_uvd/vce/mmhub to set_powergating_by_smu
      drm/amd/pp: Add gfx pg support in smu through set_powergating_by_smu
      drm/amd/pp: Add powergate_gfx backend function on Raven
      drm/amdgpu: Add gfx_off support in smu through pp_set_powergating_by_=
smu
      drm/amdgpu: Split set_pg_state into separate function
      drm/amdgpu: Move CG/PG setting out of delay worker thread
      drm/amd/display: Fix a typo in wm_min_memg_clk_in_khz
      drm/amd/pp: Convert clock unit to KHz as defined
      drm/amd/pp: Memory Latency is always 25us on Vega10
      drm/amd/pp: Refine the interface exported to display
      drm/amd/pp: Remove duplicate code in vega12_hwmgr.c
      drm/amd/pp: Export notify_smu_enable_pwe to display
      drm/amd/display: Refine the implementation of dm_pp_get_funcs_rv
      drm/amd/display: Fix copy error when set memory clocks
      drm/amd/pp: Remove the same struct define in powerplay
      drm/amdgpu: Add CLK IP base offset
      drm/amd/pp: Convert 10KHz to KHz as variable name
      drm/amd/pp: Read vbios vddc limit before use them
      drm/amd/pp: Update clk with od setting when set power state
      drm/amd/pp: Set Max clock level to display by default
      drm/amd/display: Convert 10kHz clks from PPLib into kHz
      drm/amd/pp/Polaris12: Fix a chunk of registers missed to program
      drm/amd/pp: Delete unused temp variables
      drm/amd/pp: Convert voltage unit in mV*4 to mV on CZ/ST
      drm/amdgpu: fix a reversed condition

Reza Amini (1):
      drm/amd/display: Prefix TIMING_STANDARD entries with DC_

Rob Clark (1):
      drm/msm/mdp5: fix missing CTL flush

Rodrigo Siqueira (8):
      drm/vkms: Add mode_config initialization
      drm/vkms: Add basic CRTC initialization
      drm/vkms: Add extra information about vkms
      drm/vkms: Add dumb operations
      drm/vkms: Add connectors helpers
      drm/vkms: Add vblank events simulated by hrtimers
      drm/vkms: Add framebuffer and plane helpers
      drm/vkms: Fix connector leak at the module removal

Rodrigo Vivi (14):
      drm/i915: Update DRIVER_DATE to 20180530
      drm/i915: Update DRIVER_DATE to 20180606
      drm/i915/psr: Kill delays when activating psr back.
      Merge tag 'gvt-next-2018-06-19' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20180620
      drm/i915/psr: Kill useless function pointers.
      drm/i915: Update DRIVER_DATE to 20180709
      Merge tag 'gvt-next-2018-07-11' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915/psr: Remove useless function calls.
      drm/i915/psr: Remove few mod parameters option.
      drm/i915: Update DRIVER_DATE to 20180712
      drm/i915: Kill sink_crc for good
      drm/i915: Update DRIVER_DATE to 20180719
      drm/i915: Fix psr sink status report.

Roman Li (1):
      drm/amd/display: fix potential infinite loop in fbc path

Russell King (46):
      drm: add missing ctx argument to plane transitional helpers
      drm/armada: clean up armada_drm_crtc_page_flip()
      drm/armada: add rectangle helpers
      drm/armada: move mode set vblank handling and disable/enable
      drm/armada: use core of primary update_plane for mode set
      drm/armada: merge armada_drm_gra_plane_regs() into only caller
      drm/armada: reset all atomic state during driver initialisation
      drm/armada: convert primary plane to atomic state
      drm/armada: convert page_flip to use primary plane atomic_update()
      drm/armada: convert overlay plane to atomic state
      drm/armada: remove temporary crtc state
      drm/armada: use old_state for update tracking in atomic_update()
      drm/armada: move primary plane to separate file
      drm/armada: move plane works to overlay
      drm/armada: move CBSH properties into overlay plane state
      drm/armada: move colorkey properties into overlay plane state
      drm/armada: remove crtc YUV colourspace properties
      drm/armada: add plane colorspace properties
      drm/armada: move armada_drm_mode_config_funcs to armada_drv.c
      drm/armada: pass plane state into armada_drm_plane_calc_addrs()
      drm/armada: provide pitches from armada_drm_plane_calc_addrs()
      drm/armada: push interlace calculation into armada_drm_plane_calc()
      drm/armada: move sync signal polarity to mode_set_nofb() method
      drm/armada: update debug in armada_drm_crtc_mode_set_nofb()
      drm/armada: clean up SPU_ADV_REG
      drm/armada: handle atomic modeset crtc events
      drm/armada: push responsibility for clock management to backend
      drm/armada: unhook dpms state from armada_drm_crtc_update()
      drm/armada: implement atomic_enable()/atomic_disable() methods
      drm/armada: enable atomic modeset support
      drm/armada: switch legacy modeset to atomic modeset
      drm/armada: switch primary plane to atomic modeset
      drm/armada: switch overlay plane to atomic modeset
      drm/armada: update planes after the dumb frame is complete
      drm/armada: update primary framebuffer parameters on mode change
      drm/armada: remove unnecessary armada_ovl_plane structure
      drm/armada: remove unnecessary armada_plane structure
      drm/armada: remove obsolete fb unreferencing kfifo and workqueue
      drm/i2c: tda998x: move tda998x_set_config() into tda998x_create()
      drm/i2c: tda998x: convert to bridge driver
      drm/i2c: tda998x: allocate tda998x_priv inside tda998x_create()
      drm/i2c: tda998x: cleanup from previous changes
      drm/i2c: tda998x: register bridge outside of component helper
      drm/i2c: tda998x: move mode_valid() to bridge
      drm/i2c: tda998x: get rid of private fill_modes function
      drm/i2c: tda998x: correct PLL divider calculation

Samson Tam (1):
      drm/amd/display: get board layout for edid emulation

Samuel Li (2):
      drm/amdgpu: add kernel doc for amdgpu_object.c
      drm/amdgpu: add kernel doc for memory domains.

Sandy Huang (2):
      drm/rockchip: vop: fix irq disabled after vop driver probed
      drm/rockchip: vop: fixup linebuffer mode calc error

Sean Paul (6):
      drm: Fix kerneldoc for DRM_MODE_PROP_IMMUTABLE
      drm/msm: Move wait_for_vblanks into mdp complete_commit() hooks
      drm/msm: Clean up dangling atomic_wq
      drm/msm: dpu: Use 'vsync' instead of 'vsync_clk' in cmdmode encoder
      drm/msm: dpu: Use clock-names instead of assigned-clock-names
      drm/msm: dsi: Handle dual-channel for 6G as well

Shaoyun Liu (13):
      drm/amd: Add gpu reset interfaces between amdgpu and amdkfd
      drm/amd: Add kfd ioctl defines for hw_exception event
      drm/amdkfd: Add gpu reset interface and place holder
      drm/amdgpu: Call KFD reset handlers during GPU reset
      drm/amdkfd: Implement GPU reset handlers in KFD
      drm/amdgpu: Enable the gpu reset from KFD
      drm/amdkfd: Implement hang detection in KFD and call amdgpu
      drm/amdgpu: Don't use shadow BO for compute context
      drm/amdgpu: Check NULL pointer for job before reset job's ring
      drm/amdkfd: Fix kernel queue 64 bit doorbell offset calculation
      drm/amdgpu: Avoid invalidate tlbs when gpu is on reset
      drm/amdgpu: Avoid destroy hqd when GPU is on reset
      drm/amdkfd: Add debugfs interface to trigger HWS hang

Shirish S (5):
      drm/amdgpu: avoid sleep while executing atombios table (V2)
      drm/amdgpu: change gfx8 ib test to use WB
      drm/amdgpu: lock and unlock console only for amdgpu_fbdev_set_suspend=
 [V5]
      drm/amdgpu: use drm_fb helper for console_(un)lock
      drm/amdgpu: move the amdgpu_fbdev_set_suspend() further up

Sibi Sankar (3):
      drm/msm/dsi: add dsi host helper functions support
      drm/msm/dsi: add implementation for helper functions
      drm/msm/dsi: replace version checks with helper functions

Sinclair Yeh (1):
      drm/vmwgfx: Fix atomic mode set check

Sjoerd Simons (1):
      drm/tilcdc: Defer probe if there are no connectors

Slava Abramov (2):
      drm/amdgpu: fix typo in amdgpu_mn.c comments
      drm/amdgpu: update documentation for amdgpu_irq.c v3

Sonny Jiang (2):
      drm/amdgpu: update documentation for amdgpu_drv.c
      drm/amdgpu: remove internal/unused kernel module parameters

Souptick Joarder (11):
      gpu: drm: udl: Adding new typedef vm_fault_t
      gpu: drm: vgem: Change return type to vm_fault_t
      gpu: drm: drm_vm: Adding new typedef vm_fault_t
      gpu: drm: radeon: Adding new typedef vm_fault_t
      gpu: drm: ttm: Adding new return type vm_fault_t
      gpu: drm: vc4: Adding new typedef vm_fault_t
      gpu: drm: omapdrm: Adding new typedef vm_fault_t
      drm/v3d: use new return type vm_fault_t in v3d_gem_fault
      drm/armada: Adding new typedef vm_fault_t
      drm/imx: Convert drm_atomic_helper_suspend/resume()
      drm/etnaviv: change return type to vm_fault_t

Stanislav Lisovskiy (2):
      drm: content-type property for HDMI connector
      i915: content-type property for HDMI connector

Stefan Agner (3):
      drm/panel: simple: Fix data type in KEO TX31D200VM0BAA timings
      drm/amdgpu: Use correct enum to set powergating state
      drm/amd/display: don't initialize result

Steve Longerbeam (1):
      gpu: ipu-v3: Fix U/V offset macros for planar 4:2:0

Tarun Vyas (3):
      drm/i915/psr: Lockless version of psr_wait_for_idle
      drm/i915: Wait for PSR exit before checking for vblank evasion
      drm/i915: Use crtc_state->has_psr instead of CAN_PSR for pipe update

Thierry Reding (4):
      drm/bridge: cdns: Mark runtime PM operations as maybe unused
      drm/panel: p079zca: Use of_device_get_match_data()
      ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()
      drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping

Thomas Hellstrom (10):
      locking: Implement an algorithm choice for Wound-Wait mutexes
      drm: Change deadlock-avoidance algorithm for the modeset locks.
      drm/vmwgfx: Replace vmw_dma_buffer with vmw_buffer_object
      drm/vmwgfx: Move buffer object related code to vmwgfx_bo.c
      drm/vmwgfx: Optimize the buffer object swap_notify callback somewhat.
      drm/vmwgfx: Use blocking buffer object reserves when evicting resourc=
es
      drm/vmwgfx: Improve on host message error messages
      drm/vmwgfx: Reorganize the fence wait loop
      drm/vmwgfx: Fix host message module function declarations
      drm/vmwgfx: Remove an obsolete __le32 conversion

Thomas Zimmermann (24):
      drm/gma500: Replace drm_gem_object_unreference_unlocked with put func=
tion
      drm/i915: Replace drm_connector_{un/reference} with put,get functions
      drm/i915: Replace drm_gem_object_{un/reference} with {put,get} functi=
ons
      drm/i915: Replace __drm_gem_object_unreference with __drm_gem_object_=
put
      drm/i915: Replace drm_gem_object_unreference_unlocked with put functi=
on
      drm/i915: Replace drm_dev_unref with drm_dev_put
      drm/amd: Replace drm_dev_unref with drm_dev_put
      drm/ttm: Introduce ttm_bo_get() and ttm_bo_put() for ref counting
      drm/ttm: Replace ttm_bo_reference() with ttm_bo_get()
      drm/ttm: Replace ttm_bo_unref() with ttm_bo_put()
      drm/stm: Replace drm_dev_unref with drm_dev_put
      drm/sti: Replace drm_dev_unref with drm_dev_put
      drm/nouveau: Replace drm_framebuffer_{un/reference} with put,
get functions
      drm/nouveau: Replace drm_gem_object_unreference_unlocked with put fun=
ction
      drm/nouveau: Replace drm_dev_unref with drm_dev_put
      drm/imx: Replace drm_dev_unref with drm_dev_put
      drm/sun4i: Replace drm_dev_unref with drm_dev_put
      drm/vc4: Replace drm_dev_unref with drm_dev_put
      drm/pl111: Replace drm_dev_unref with drm_dev_put
      drm/armada: Replace drm_dev_unref with drm_dev_put
      drm/amdgpu: Replace ttm_bo_reference with ttm_bo_get
      drm/amdgpu: Replace ttm_bo_unref with ttm_bo_put
      drm/radeon: Replace ttm_bo_reference with ttm_bo_get
      drm/radeon: Replace ttm_bo_unref with ttm_bo_put

Tina Zhang (1):
      drm/i915/gvt: Deliver guest cursor hotspot info

Tom St Denis (1):
      drm/amd/amdgpu: Add a GPU_LOAD entry to sysfs (v3)

Tomi Valkeinen (2):
      drm/omap: fix email address
      drm/panel: simple: Add newhaven, nhd-4.3-480272ef-atxl LCD

Tony Cheng (19):
      drm/amd/display: dal 3.1.45
      drm/amd/display: dal 3.1.46
      drm/amd/display: dal 3.1.47
      drm/amd/display: dal 3.1.48
      drm/amd/display: dal 3.1.49
      drm/amd/display: dal 3.1.50
      drm/amd/display: dal 3.1.51
      drm/amd/display: dal 3.1.52
      drm/amd/display: Allow option to use worst-case watermark
      drm/amd/display: Add avoid_vbios_exec_table debug bit
      drm/amd/display: fix bug where we are creating bogus i2c aux
      drm/amd/display: generic indirect register access
      drm/amd/display: fix incorrect check for atom table size
      drm/amd/display: dal 3.1.53
      drm/amd/display: Expose configure_encoder for link_encoder
      drm/amd/display: dal 3.1.54
      drm/amd/display: dal 3.1.55
      drm/amd/display: Move address tracking out of HUBP
      drm/amd/display: allow diags to skip initial link training

Tvrtko Ursulin (6):
      drm/i915: Include i915_scheduler.h from i915_gem_context.h
      drm/i915: Forward declare struct intel_context
      drm/i915/trace: Describe engines as class:instance pairs
      drm/i915/trace: Remove engine out of the context sandwich
      drm/i915/trace: Context field needs to be 64-bit wide
      drm/i915/pmu: Do not assume fixed hrtimer period

Vandita Kulkarni (1):
      drm/i915: Enable hw workaround to bypass alpha

Vathsala Nagaraju (3):
      drm/i915/psr: vbt change for psr
      drm/i915/psr: Adds psrwake options for all platforms
      drm/i915/psr: Add psr1 live status

Venkateswara Rao Mandela (1):
      drm/omap: Implement workaround for DRA7 errata ID:i932

Ville Syrj=C3=A4l=C3=A4 (103):
      drm/i915: Clean up ADPA pipe select bits
      drm/i915: Clean up LVDS pipe select bits
      drm/i915: Clean up SDVO pipe select bits
      drm/i915: Clean up TV pipe select bits
      drm/i915: Clean up DVO pipe select bits
      drm/i915: Use intel_ddi_dp_voltage_max() for HSW/BDW too
      drm/i915: Use the same vswing->max_preemph mapping on HSW/BDW as on S=
KL+
      drm/i915: Check for IVB instead of gen7 when we think about IVB CPU e=
DP
      drm/i915: Rename SNB/IVB CPU eDP signal level funcs
      drm/i915: Rename the remaining gen4 references to g4x in the DP code
      drm/i915: Replace vbt edp.support with int_lvds_support
      drm/i915: Eliminate the unused dev_priv->vbt.lvds_vbt
      drm/i915: Move intel_ddi_get_crtc_new_encoder() out from ddi code
      drm/i915: Parametrize TRANS_DP_PORT_SEL
      drm/i915: Nuke intel_trans_dp_port_sel()
      drm/i915: Clean up DP pipe select bits
      drm/i915: Allow eDP on port C in theory
      drm/i915: Implement the missing bits of assert_panel_unlocked()
      drm/i915: WARN if power sequencer is not connected to the LVDS
port on pre-ilk
      drm/edid: Fix up edid_cea_modes[] formatting
      drm/i915: Initialize panel_pipe to INVALID_PIPE
      drm/i915: Try to suppress more spurious PCH underruns on ILK-IVB
      drm/i915: Consult VBT "LVDS config" bits to determine whether
internal LVDS is present
      drm/arc: Stop consulting plane->fb
      drm/msm: Stop consulting plane->fb/crtc
      drm/sti: Stop consulting plane->crtc
      drm/atmel-hlcdc: Stop consulting plane->crtc
      drm: Add local 'plane' variable for tmp->primary
      drm/omapdrm: Nuke omap_framebuffer_get_next_connector()
      drm/atmel-hlcdc: Stop using plane->fb
      drm/i915: Simplify ilk-ivb underrun suppression
      drm/i915: Promote .format_mod_supported() to the lead role
      drm/i915: Have plane->get_hw_state() return the current pipe
      drm/i915: Clean up cursor defines
      drm/i915: Disable trickle feed for SNB/IVB cursors
      drm/i915: s/plane/i9xx_plane/
      drm/i915: Fix tabs vs. spaces in sprite code
      drm/i915: Remove bogus NV12 PLANE_COLOR_CTL setup
      drm/i915: Configure SKL+ scaler initial phase correctly
      drm/i915: Fix sprite destination colorkeying on SKL+
      drm/vmwgfx: Stop using plane->fb in vmw_kms_atomic_check_modeset()
      drm/vmwgfx: Stop using plane->fb in vmw_kms_helper_dirty()
      drm/vmwgfx: Stop using plane->fb in vmw_kms_update_implicit_fb()
      drm/vmwgfx: Stop updating plane->fb
      drm/vmwgfx: Stop using plane->fb in atomic_enable()
      drm/vmwgfx: Stop messing about with plane->fb/old_fb/crtc
      drm/amdgpu/dc: Stop updating plane->fb
      drm/i915: Stop updating plane->fb/crtc
      drm/exynos: Stop updating plane->crtc
      drm/msm: Stop updating plane->fb/crtc
      drm/virtio: Stop updating plane->crtc
      drm/vc4: Stop updating plane->fb/crtc
      drm: Stop updating plane->crtc/fb/old_fb on atomic drivers
      drm/i915: Allow DBLSCAN user modes with eDP/LVDS/DSI
      drm/i915: Fix PIPESTAT irq ack on i965/g4x
      drm/i915: Disallow interlaced modes on g4x DP outputs
      drm/i915: Turn off g4x DP port in .post_disable()
      drm/i915: s/IS_G4X && !IS_GM45/IS_G45/
      drm/atomic: Improve debug messages
      drm: Print bad user modes
      drm/i915: Print prop name/id when rejecting it
      drm/i915: Nuke the cursor size defines
      drm/i915: Check timings against hardware maximums
      drm/i915: Enforce max hdisplay/hblank_start limits on HSW/BDW FDI
      drm: Document mode_config.max_width/height as the max fb dimensions
      drm/rockchip: Use drm_crtc_mask()
      drm/atomic-helper: Use old/new state in
drm_atomic_helper_commit_planes_on_crtc()
      drm: Add drm_plane_mask()
      drm: Use drm_crtc_mask()
      drm: Add drm_encoder_mask()
      drm: Add drm_connector_mask()
      drm/i915: Use drm_plane_mask() & co.
      drm/imx: Use drm_plane_mask()
      drm/sun4i: Use drm_crtc_mask()
      drm/vc4: Use drm_crtc_mask()
      drm/vmwgfx: Use drm_plane_mask() & co.
      drm/i915: Fix hotplug irq ack on i965/g4x
      drm/i915: Fix pre-ILK error interrupt ack
      drm/i915: Unmask and enable master error interrupt on gen2/3
      drm/fb-helper: Eliminate the .best_encoder() usage
      drm/i915: Nuke intel_mst_best_encoder()
      drm: Add drm_connector_for_each_possible_encoder()
      drm/amdgpu: Use drm_connector_for_each_possible_encoder()
      drm/nouveau: Use drm_connector_for_each_possible_encoder()
      drm/radeon: Use drm_connector_for_each_possible_encoder()
      drm: Add drm_connector_has_possible_encoder()
      drm/msm: Use drm_connector_has_possible_encoder()
      drm/tilcdc: Use drm_connector_has_possible_encoder()
      drm/i915: Remove pointless if-else from sdvo code
      drm/atomic-helper: Use bitwise or for filling a bitmask
      drm: Extract __setplane_check()
      drm: Introduce __setplane_atomic()
      drm: Skip __drm_mode_set_config_internal() on atomic drivers
      drm/i915: Introduce for_each_intel_dp()
      drm/i915: Introduce intel_encoder_is_dig_port()
      drm/i915: Rewrite mst suspend/resume in terms of encoders
      drm/i915: Nuke dev_priv->irq_port[]
      drm/i915: s/int i/enum hpd_pin pin/
      drm/i915: Pass hpd_pin to long_pulse_detect()
      drm/i915: Print the long_mask alongside the pin_mask
      drm/i915: Nuke the LVDS lid notifier
      drm/i915: Assume eDP is always connected
      drm/i915: Remove intel_panel_detect()

Vitaly Prosyak (3):
      drm/amd/display: HLG support
      drm/amd/display: Add new transfer type HWPWL
      drm/amd/display: Add headers for hardcoded 1d luts.

Vladimir Zapolskiy (1):
      drm/panel: simple: Add Sharp LQ035Q7DB03 panel support

Wei Lu (1):
      drm/amdkfd: Fix error codes in kfd_get_process

Wei Yongjun (1):
      drm/sun4i: DW HDMI: Make symbol sun8i_dw_hdmi_pltfm_driver static

Wesley Chalmers (2):
      drm/amd/display: Temporarily remove Chroma logs
      drm/amd/display: fix use of uninitialized memory

Xinyun Liu (3):
      drm/i915/gvt: Avoid dereference a potential null pointer
      drm/i915/gvt: removed unnecessary boundary check
      drm/i915/gvt: use array to avoid potential buffer overflow

Yannick Fertre (2):
      drm/stm: ltdc: filter mode pixel clock vs pad constraint
      drm/stm: ltdc: rework reset sequence

Yasir Al Shekerchi (1):
      drm/amd/display: Added documentation for some DC interface functions

Yong Zhao (10):
      drm/amdkfd: Introduce KFD module parameter halt_if_hws_hang
      drm/amdkfd: Use module parameters noretry as the internal variable na=
me
      drm/amdkfd: Replace mqd with mqd_mgr as the variable name for mqd_man=
ager
      drm/amdkfd: Clean up reference of radeon
      drm/amdkfd: Consolidate duplicate memory banks info in topology
      drm/amdkfd: Make SDMA engine number an ASIC-dependent variable
      drm/amdkfd: Avoid flooding dmesg on Raven due to IOMMU issues
      drm/amdkfd: Workaround to accommodate Raven too many PPR issue
      drm/amdkfd: Optimize out some duplicated code in kfd_signal_iommu_eve=
nt()
      drm/amdkfd: Enable Raven for KFD

Yongqiang Sun (3):
      drm/amd/display: Use tg count for opp init.
      drm/amd/display: Check scaling ration not viewports params.
      drm/amd/display: expose dcn10_aux_initialize in header

Yue Hin Lau (1):
      drm/amd/display: Add NULL check for local sink in edp_power_control

Yunwei Zhang (3):
      drm/i915/cnl: Implement WaProgramMgsrForCorrectSliceSpecificMmioReads
      drm/i915/icl: Enable WaProgramMgsrForCorrectSliceSpecificMmioReads
      drm/i915: Implement WaProgramMgsrForL3BankSpecificMmioReads

Zheng, XueLai(Eric) (1):
      drm/amd/display: support ACrYCb2101010

Zhenyu Wang (2):
      drm/i915/gvt: Fix crash after request->hw_context change
      Merge tag 'drm-intel-next-2018-06-06' into gvt-next

abdoulaye berthe (1):
      drm/amd/display: DP Compliance 400.1.1 failure

kbuild test robot (3):
      drm/vkms: vkms_driver can be static
      drm/amd/pp: fix semicolon.cocci warnings
      drm/nouveau/kms/nv50-: fix drm-get-put.cocci warnings

rex zhu (7):
      drm/amd/display: Drop unnecessary header file
      drm/amd/display: Fix dm-pp clks type convert error
      drm/amdgpu: Add stutter mode ctrl in module parameter
      drm/amd/display: Ctrl stutter mode through module parameter
      drm/amd/pp: Switch the tolerable latency for display
      drm/amd/display: Notify powerplay the min_dcef clock
      drm/amd/display: Notify powerplay the display controller id

shaoyunl (2):
      drm/amdgpu: save vm fault information for amdkfd
      drm/amdkfd: Handle VM faults in KFD

spanda@codeaurora.org (2):
      dt-bindings: drm/panel: Document Innolux TV123WAM panel bindings
      drm/panel: simple: Add Innolux TV123WAM panel driver support

stu.hsieh@mediatek.com (29):
      drm/mediatek: update dt-bindings for mt2712
      drm/mediatek: support maximum 64 mutex mod
      drm/mediatek: add ddp component AAL1
      drm/mediatek: add ddp component OD1
      drm/mediatek: add ddp component PWM1
      drm/mediatek: add ddp component PWM2
      drm/mediatek: add component DPI1
      drm/mediatek: add component DSI2
      drm/mediatek: add component DSI3
      drm/mediatek: add the DSI1 for component init condition
      drm/mediatek: add connection from OD1 to RDMA1
      drm/mediatek: Update the definition of connection from RDMA1 to DPI0
      drm/mediatek: add connection from RDMA0 to DPI0
      drm/mediatek: add connection from RDMA0 to DSI2
      drm/mediatek: add connection from RDMA0 to DSI3
      drm/mediatek: add connection from RDMA1 to DPI1
      drm/mediatek: add connection from RDMA1 to DSI1
      drm/mediatek: add connection from RDMA1 to DSI2
      drm/mediatek: add connection from RDMA1 to DSI3
      drm/mediatek: add connection from RDMA2 to DPI0
      drm/mediatek: add connection from RDMA2 to DPI1
      drm/mediatek: add connection from RDMA2 to DSI1
      drm/mediatek: add connection from RDMA2 to DSI2
      drm/mediatek: add connection from RDMA2 to DSI3
      drm/mediatek: add DPI1 support for mutex
      drm/mediatek: add DSI2 support for mutex
      drm/mediatek: add DSI3 support for mutex
      drm/mediatek: add third ddp path
      drm/mediatek: Add support for mediatek SOC MT2712

vikrant mhaske (1):
      drm/amd/display: DPP CM ICSC AYCRCB8888 format support

vkorjani (1):
      drm: Add support for pps and compression mode command packet

zhong jiang (1):
      drm/msm/dpu: fix mismatch in function argument.

 .../devicetree/bindings/display/brcm,bcm-vc4.txt   |    6 +
 .../devicetree/bindings/display/ilitek,ili9341.txt |   27 +
 .../bindings/display/mediatek/mediatek,disp.txt    |    2 +-
 .../devicetree/bindings/display/msm/dpu.txt        |  131 +
 .../devicetree/bindings/display/msm/dsi.txt        |   16 +
 .../bindings/display/panel/auo,g070vvn01.txt       |   29 +
 .../bindings/display/panel/boe,hv070wsa-100.txt    |   28 +
 .../display/panel/dataimage,scf0700c48ggu18.txt    |    8 +
 .../bindings/display/panel/dlc,dlc0700yzg-1.txt    |   13 +
 .../bindings/display/panel/edt,et-series.txt       |   39 +
 .../bindings/display/panel/edt,et070080dh6.txt     |   10 -
 .../bindings/display/panel/edt,etm0700g0dh6.txt    |   10 -
 .../bindings/display/panel/ilitek,ili9881c.txt     |   20 +
 .../bindings/display/panel/innolux,g070y2-l01.txt  |   12 +
 .../bindings/display/panel/innolux,p097pfg.txt     |   24 +
 .../bindings/display/panel/innolux,tv123wam.txt    |   20 +
 .../display/panel/kingdisplay,kd097d04.txt         |   22 +
 ...0dhu.txt =3D> newhaven,nhd-4.3-480272ef-atxl.txt} |    4 +-
 .../display/panel/rocktech,rk070er9427.txt         |   25 +
 .../bindings/display/panel/sharp,lq035q7db03.txt   |   12 +
 .../bindings/display/sunxi/sun4i-drm.txt           |   64 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    4 +
 Documentation/driver-api/dma-buf.rst               |    6 +
 Documentation/fb/fbcon.txt                         |    7 +
 Documentation/gpu/amdgpu.rst                       |  129 +
 Documentation/gpu/drivers.rst                      |    1 +
 Documentation/gpu/drm-client.rst                   |   12 +
 Documentation/gpu/drm-kms-helpers.rst              |   26 +-
 Documentation/gpu/drm-kms.rst                      |   28 +-
 Documentation/gpu/drm-mm.rst                       |   20 +
 Documentation/gpu/index.rst                        |    1 +
 Documentation/gpu/kms-properties.csv               |    1 +
 Documentation/gpu/msm-crash-dump.rst               |   96 +
 Documentation/gpu/v3d.rst                          |   28 +
 Documentation/locking/ww-mutex-design.txt          |   65 +-
 MAINTAINERS                                        |   19 +-
 arch/arm/mm/dma-mapping.c                          |   12 +-
 arch/x86/kernel/early-quirks.c                     |   18 +
 drivers/dma-buf/dma-buf.c                          |   56 +-
 drivers/dma-buf/dma-fence-array.c                  |    1 -
 drivers/dma-buf/dma-fence.c                        |  167 +-
 drivers/dma-buf/reservation.c                      |    8 +-
 drivers/dma-buf/sw_sync.c                          |    1 -
 drivers/gpu/drm/Kconfig                            |   21 +
 drivers/gpu/drm/Makefile                           |    4 +-
 drivers/gpu/drm/amd/amdgpu/ObjectID.h              |    8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  103 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   55 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   47 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   27 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |    9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |    8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c      |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |  267 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h        |   85 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   85 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  259 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  400 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c            |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  266 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c       |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h           |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |    5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  202 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |   79 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |   74 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   87 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c             |  207 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  418 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  219 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c          |  127 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_queue_mgr.c      |   29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c           |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  185 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  211 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h            |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   37 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  143 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  396 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |   22 +-
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |   40 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |   10 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |   36 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |   16 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |   16 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |   10 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |   10 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |   20 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   56 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   72 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  299 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  124 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   48 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   47 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   17 +-
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |   17 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |   18 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |   20 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   30 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |   29 +-
 drivers/gpu/drm/amd/amdgpu/soc15d.h                |   23 +
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |   42 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |  126 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |   10 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |   23 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |   18 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  467 ++-
 drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c       |    1 +
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   12 +-
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |   54 +-
 drivers/gpu/drm/amd/amdkfd/cik_int.h               |    7 +-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |  458 +--
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm  |   18 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  |   16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   69 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   57 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c            |    1 -
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.h            |   37 +
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c           |   48 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  122 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  283 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |   32 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager_v9.c   |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |    9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  118 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.h            |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |   22 +-
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c         |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |   18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h      |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |   16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |   41 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |    4 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |   29 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   31 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   29 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |   26 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   40 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    2 +
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   43 +-
 drivers/gpu/drm/amd/display/Kconfig                |   17 -
 drivers/gpu/drm/amd/display/TODO                   |    8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |    4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  104 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   42 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  722 ++++
 .../amdgpu_dm/amdgpu_dm_debugfs.h}                 |   18 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   49 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  104 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |  562 +++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  330 --
 drivers/gpu/drm/amd/display/dc/Makefile            |    2 +-
 drivers/gpu/drm/amd/display/dc/basics/Makefile     |    2 +-
 .../gpu/drm/amd/display/dc/basics/log_helpers.c    |   69 +-
 drivers/gpu/drm/amd/display/dc/basics/logger.c     |  405 --
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |  196 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  220 +-
 .../gpu/drm/amd/display/dc/bios/command_table.c    |   18 +
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |   46 +-
 .../amd/display/dc/bios/command_table_helper2.c    |    2 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile      |    2 +-
 .../gpu/drm/amd/display/dc/calcs/calcs_logger.h    |    9 +-
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |    6 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |  215 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  110 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |   26 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  174 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |  117 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  133 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  462 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |    4 +
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   25 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |   13 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   61 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |    4 +
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h      |   61 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |    5 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |   51 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   51 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |   24 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   15 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   24 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile        |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |  937 +++++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |  111 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   16 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.h  |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c    |  724 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.h    |   89 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   44 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |   12 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |   11 +
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |    6 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |   25 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |    2 +-
 .../amd/display/dc/dce100/dce100_hw_sequencer.c    |   45 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |   60 +-
 .../drm/amd/display/dc/dce110/dce110_compressor.c  |    6 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  427 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.h    |   13 +
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |    2 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |  102 +-
 .../drm/amd/display/dc/dce110/dce110_transform_v.c |    2 +-
 .../drm/amd/display/dc/dce112/dce112_resource.c    |  102 +-
 .../amd/display/dc/dce120/dce120_hw_sequencer.c    |   10 +
 .../drm/amd/display/dc/dce120/dce120_resource.c    |   65 +-
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   75 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |   23 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |   14 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  |   19 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |  362 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |    6 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |   59 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |   13 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  518 +--
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |    7 +
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |   21 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |   15 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |  100 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |   64 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  126 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |   88 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |   11 +
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |    6 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h       |    5 +-
 drivers/gpu/drm/amd/display/dc/dm_services_types.h |    6 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |    3 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |   63 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |    1 -
 .../drm/amd/display/dc/dml/display_mode_structs.h  |    6 +-
 .../gpu/drm/amd/display/dc/dml/soc_bounding_box.c  |   79 -
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/ddc_regs.h     |    7 +-
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |    1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |    4 +-
 drivers/gpu/drm/amd/display/dc/i2caux/Makefile     |    2 +-
 drivers/gpu/drm/amd/display/dc/i2caux/aux_engine.c |   31 +-
 drivers/gpu/drm/amd/display/dc/i2caux/aux_engine.h |   47 +-
 .../amd/display/dc/i2caux/dce100/i2caux_dce100.c   |    1 +
 .../display/dc/i2caux/dce110/aux_engine_dce110.c   |  159 +-
 .../dc/i2caux/dce110/i2c_hw_engine_dce110.c        |   26 +-
 .../dc/i2caux/dce110/i2c_hw_engine_dce110.h        |    8 +
 .../amd/display/dc/i2caux/dce110/i2caux_dce110.c   |   24 +-
 .../amd/display/dc/i2caux/dce110/i2caux_dce110.h   |    1 +
 .../amd/display/dc/i2caux/dce112/i2caux_dce112.c   |    1 +
 .../amd/display/dc/i2caux/dce120/i2caux_dce120.c   |    1 +
 .../drm/amd/display/dc/i2caux/dcn10/i2caux_dcn10.c |    1 +
 drivers/gpu/drm/amd/display/dc/i2caux/engine.h     |   19 +-
 drivers/gpu/drm/amd/display/dc/i2caux/i2c_engine.h |    2 +
 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c     |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   15 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |   22 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h     |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h |  180 +
 .../gpu/drm/amd/display/dc/inc/hw/display_clock.h  |   43 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |    3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h  |    2 +-
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    3 +
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |   20 +-
 drivers/gpu/drm/amd/display/dc/inc/reg_helper.h    |   46 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |    1 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |    2 +-
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/os_types.h          |    2 +-
 .../drm/amd/display/include/ddc_service_types.h    |    3 +-
 drivers/gpu/drm/amd/display/include/dpcd_defs.h    |    3 +
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |    7 +
 .../amd/display/include/grph_object_ctrl_defs.h    |    2 +
 .../gpu/drm/amd/display/include/grph_object_defs.h |   46 +
 .../gpu/drm/amd/display/include/grph_object_id.h   |   16 +
 .../gpu/drm/amd/display/include/logger_interface.h |  136 +-
 drivers/gpu/drm/amd/display/include/logger_types.h |   59 -
 .../drm/amd/display/modules/color/color_gamma.c    |  147 +-
 .../gpu/drm/amd/display/modules/color/luts_1d.h    |   51 +
 drivers/gpu/drm/amd/display/modules/stats/stats.c  |    4 +-
 drivers/gpu/drm/amd/include/amd_pcie.h             |    2 +
 drivers/gpu/drm/amd/include/amd_shared.h           |   46 +-
 .../drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h  |   20 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |   15 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h      |   37 +-
 .../drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_9_0.h  |   55 +
 .../drm/amd/include/ivsrcid/ivsrcid_vislands30.h   |   98 +
 .../amd/include/ivsrcid/sdma0/irqsrcs_sdma0_4_0.h  |   50 +
 .../amd/include/ivsrcid/sdma1/irqsrcs_sdma1_4_0.h  |   50 +
 .../ivsrcid/smuio/irqsrcs_smuio_9_0.h}             |   11 +-
 .../drm/amd/include/ivsrcid/thm/irqsrcs_thm_9_0.h  |   33 +
 .../drm/amd/include/ivsrcid/uvd/irqsrcs_uvd_7_0.h  |   34 +
 .../drm/amd/include/ivsrcid/vce/irqsrcs_vce_4_0.h  |   34 +
 .../drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h  |   34 +
 .../drm/amd/include/ivsrcid/vmc/irqsrcs_vmc_1_0.h  |   37 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   40 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   15 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |  109 +-
 .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |    4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |    8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c   |    8 +-
 .../amd/powerplay/hwmgr/process_pptables_v1_0.c    |    8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |   12 +-
 .../amd/powerplay/hwmgr/smu7_clockpowergating.c    |   56 +-
 .../amd/powerplay/hwmgr/smu7_clockpowergating.h    |    3 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  155 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h   |    1 -
 .../gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c   |   43 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c   |   11 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c   |   57 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.h   |    2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  179 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h |    1 -
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 1133 +++---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |   13 +
 .../amd/powerplay/hwmgr/vega12_processpptables.c   |    6 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c   |    8 +-
 .../gpu/drm/amd/powerplay/inc/hardwaremanager.h    |    2 +-
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |   11 +-
 drivers/gpu/drm/amd/powerplay/inc/smumgr.h         |    4 +-
 .../drm/amd/powerplay/inc/vega12/smu9_driver_if.h  |   18 +-
 drivers/gpu/drm/amd/powerplay/smumgr/Makefile      |    2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |  119 +-
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |   74 -
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  |   10 -
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |  108 +-
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |    2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |  101 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h |    3 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c |    4 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c |  150 +
 drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h |   32 +
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c      |    2 +-
 .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |   80 -
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |  168 +-
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |  220 +-
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.h   |    1 -
 .../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c    |   85 -
 drivers/gpu/drm/arc/arcpgu_crtc.c                  |    5 +-
 drivers/gpu/drm/arc/arcpgu_sim.c                   |    2 +-
 drivers/gpu/drm/arm/Makefile                       |    1 +
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |   35 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |   76 +-
 drivers/gpu/drm/arm/hdlcd_drv.h                    |    2 -
 drivers/gpu/drm/arm/malidp_crtc.c                  |   10 +
 drivers/gpu/drm/arm/malidp_drv.c                   |  187 +-
 drivers/gpu/drm/arm/malidp_drv.h                   |   26 +
 drivers/gpu/drm/arm/malidp_hw.c                    |  297 +-
 drivers/gpu/drm/arm/malidp_hw.h                    |   40 +-
 drivers/gpu/drm/arm/malidp_mw.c                    |  250 ++
 drivers/gpu/drm/arm/malidp_mw.h                    |   14 +
 drivers/gpu/drm/arm/malidp_regs.h                  |   24 +-
 drivers/gpu/drm/armada/Makefile                    |    2 +-
 drivers/gpu/drm/armada/armada_510.c                |   24 +-
 drivers/gpu/drm/armada/armada_crtc.c               | 1008 +----
 drivers/gpu/drm/armada/armada_crtc.h               |   56 +-
 drivers/gpu/drm/armada/armada_drm.h                |   14 +-
 drivers/gpu/drm/armada/armada_drv.c                |   54 +-
 drivers/gpu/drm/armada/armada_fb.c                 |   30 +-
 drivers/gpu/drm/armada/armada_fb.h                 |    6 +-
 drivers/gpu/drm/armada/armada_fbdev.c              |    4 +-
 drivers/gpu/drm/armada/armada_gem.c                |   17 +-
 drivers/gpu/drm/armada/armada_hw.h                 |   15 +
 drivers/gpu/drm/armada/armada_overlay.c            |  665 ++--
 drivers/gpu/drm/armada/armada_plane.c              |  289 ++
 drivers/gpu/drm/armada/armada_plane.h              |   15 +
 drivers/gpu/drm/ast/ast_mode.c                     |    6 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |    1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |   19 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |    2 +-
 drivers/gpu/drm/bridge/Kconfig                     |    4 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |    4 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.c          |    8 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    6 +-
 drivers/gpu/drm/bridge/cdns-dsi.c                  |    6 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |    4 +-
 drivers/gpu/drm/bridge/lvds-encoder.c              |    4 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |    4 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |    4 +-
 drivers/gpu/drm/bridge/panel.c                     |    2 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |    2 +-
 drivers/gpu/drm/bridge/sii902x.c                   |    4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |    4 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    4 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |    4 +-
 drivers/gpu/drm/cirrus/cirrus_drv.h                |   10 +-
 drivers/gpu/drm/cirrus/cirrus_fbdev.c              |   20 +-
 drivers/gpu/drm/cirrus/cirrus_main.c               |   43 +-
 drivers/gpu/drm/cirrus/cirrus_mode.c               |   14 +-
 drivers/gpu/drm/drm_atomic.c                       |  408 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  114 +-
 drivers/gpu/drm/drm_client.c                       |  406 ++
 drivers/gpu/drm/drm_connector.c                    |  219 +-
 drivers/gpu/drm/drm_crtc.c                         |   53 +-
 drivers/gpu/drm/drm_crtc_internal.h                |   28 +-
 drivers/gpu/drm/drm_debugfs.c                      |   11 +-
 drivers/gpu/drm/drm_debugfs_crc.c                  |    9 +-
 drivers/gpu/drm/drm_dp_cec.c                       |  428 ++
 drivers/gpu/drm/drm_dp_helper.c                    |   33 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |    4 +-
 drivers/gpu/drm/drm_drv.c                          |   23 +-
 drivers/gpu/drm/drm_dumb_buffers.c                 |   29 +-
 drivers/gpu/drm/drm_edid.c                         |  279 +-
 drivers/gpu/drm/drm_fb_cma_helper.c                |  355 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  359 +-
 drivers/gpu/drm/drm_file.c                         |  306 +-
 drivers/gpu/drm/drm_fourcc.c                       |   42 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   49 +-
 drivers/gpu/drm/drm_gem.c                          |    9 +
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |    2 +-
 drivers/gpu/drm/drm_global.c                       |    2 +-
 drivers/gpu/drm/drm_internal.h                     |    2 +
 drivers/gpu/drm/drm_ioctl.c                        |   13 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |    2 +
 drivers/gpu/drm/drm_mm.c                           |   91 +-
 drivers/gpu/drm/drm_mode_config.c                  |    5 +
 drivers/gpu/drm/drm_mode_object.c                  |    3 +-
 drivers/gpu/drm/drm_modes.c                        |   23 +-
 drivers/gpu/drm/drm_of.c                           |   27 +-
 drivers/gpu/drm/drm_panel.c                        |   27 +-
 drivers/gpu/drm/drm_pci.c                          |   58 -
 drivers/gpu/drm/drm_plane.c                        |  169 +-
 drivers/gpu/drm/drm_plane_helper.c                 |   12 +-
 drivers/gpu/drm/drm_prime.c                        |   34 +-
 drivers/gpu/drm/drm_print.c                        |  111 +
 drivers/gpu/drm/drm_probe_helper.c                 |   19 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |    6 +-
 drivers/gpu/drm/drm_syncobj.c                      |    1 -
 drivers/gpu/drm/drm_vm.c                           |   10 +-
 drivers/gpu/drm/drm_vma_manager.c                  |    1 +
 drivers/gpu/drm/drm_writeback.c                    |  353 ++
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |   11 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              |    3 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |   37 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c       |    4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   10 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              |    2 +-
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c         |    9 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |   28 +-
 drivers/gpu/drm/exynos/Makefile                    |    2 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |    2 +
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         |    2 +
 drivers/gpu/drm/exynos/exynos_dp.c                 |    9 +-
 drivers/gpu/drm/exynos/exynos_drm_core.c           |  119 -
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |    6 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   29 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.h            |   47 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |    7 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.c             |   10 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |    2 +
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |  300 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.h            |   11 +
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |   58 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.h            |   24 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.c            |   10 +-
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |    2 +
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |    2 -
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |    4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    6 +-
 drivers/gpu/drm/exynos/exynos_mixer.c              |    4 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |    7 +-
 drivers/gpu/drm/gma500/accel_2d.c                  |    2 +-
 drivers/gpu/drm/gma500/cdv_intel_dp.c              |    2 +-
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c            |    2 +-
 drivers/gpu/drm/gma500/framebuffer.c               |   62 +-
 drivers/gpu/drm/gma500/framebuffer.h               |    1 -
 drivers/gpu/drm/gma500/gem.c                       |    2 +-
 drivers/gpu/drm/gma500/gma_display.c               |   20 +-
 drivers/gpu/drm/gma500/gtt.h                       |    2 +
 drivers/gpu/drm/gma500/intel_bios.h                |   38 +-
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c             |    2 +-
 drivers/gpu/drm/gma500/mdfld_intel_display.c       |    3 +-
 drivers/gpu/drm/gma500/oaktrail_crtc.c             |    3 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi.c             |    2 +-
 drivers/gpu/drm/gma500/oaktrail_lvds.c             |    2 +-
 drivers/gpu/drm/gma500/psb_intel_modes.c           |    2 +-
 drivers/gpu/drm/gma500/psb_intel_sdvo.c            |   13 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |    1 -
 drivers/gpu/drm/i2c/tda998x_drv.c                  |  387 +-
 drivers/gpu/drm/i810/i810_dma.c                    |    2 +-
 drivers/gpu/drm/i915/Kconfig.debug                 |   12 +
 drivers/gpu/drm/i915/Makefile                      |    7 +-
 drivers/gpu/drm/i915/dvo_ch7017.c                  |   20 +-
 drivers/gpu/drm/i915/dvo_ch7xxx.c                  |   22 +-
 drivers/gpu/drm/i915/dvo_ivch.c                    |   26 +-
 drivers/gpu/drm/i915/dvo_ns2501.c                  |   44 +-
 drivers/gpu/drm/i915/dvo_sil164.c                  |   10 +-
 drivers/gpu/drm/i915/dvo_tfp410.c                  |   16 +-
 drivers/gpu/drm/i915/gvt/aperture_gm.c             |    2 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   43 +-
 drivers/gpu/drm/i915/gvt/display.c                 |   62 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |   26 +-
 drivers/gpu/drm/i915/gvt/edid.c                    |   20 +-
 drivers/gpu/drm/i915/gvt/execlist.h                |   13 +-
 drivers/gpu/drm/i915/gvt/fb_decoder.c              |   27 +-
 drivers/gpu/drm/i915/gvt/firmware.c                |    2 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |  434 ++-
 drivers/gpu/drm/i915/gvt/gtt.h                     |    9 +
 drivers/gpu/drm/i915/gvt/gvt.c                     |   31 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |   20 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |  438 ++-
 drivers/gpu/drm/i915/gvt/hypercall.h               |    2 +-
 drivers/gpu/drm/i915/gvt/interrupt.c               |   17 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |  130 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |   12 +-
 drivers/gpu/drm/i915/gvt/mmio.h                    |   11 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c            |   22 +-
 drivers/gpu/drm/i915/gvt/mmio_context.h            |    2 +-
 drivers/gpu/drm/i915/gvt/mpt.h                     |    7 +-
 drivers/gpu/drm/i915/gvt/page_track.c              |    5 +-
 drivers/gpu/drm/i915/gvt/sched_policy.c            |   36 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |  208 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |    1 -
 drivers/gpu/drm/i915/gvt/vgpu.c                    |   57 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |  374 +-
 drivers/gpu/drm/i915/i915_drv.c                    |  177 +-
 drivers/gpu/drm/i915/i915_drv.h                    |  127 +-
 drivers/gpu/drm/i915/i915_gem.c                    |  593 +--
 drivers/gpu/drm/i915/i915_gem.h                    |   21 +
 drivers/gpu/drm/i915/i915_gem_context.c            |  174 +-
 drivers/gpu/drm/i915/i915_gem_context.h            |   28 +-
 drivers/gpu/drm/i915/i915_gem_dmabuf.c             |   11 -
 drivers/gpu/drm/i915/i915_gem_evict.c              |    3 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |  115 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                | 1282 +++---
 drivers/gpu/drm/i915/i915_gem_gtt.h                |   85 +-
 drivers/gpu/drm/i915/i915_gem_object.h             |   27 +-
 drivers/gpu/drm/i915/i915_gem_render_state.c       |    4 +-
 drivers/gpu/drm/i915/i915_gem_shrinker.c           |   25 +-
 drivers/gpu/drm/i915/i915_gem_stolen.c             |   45 +-
 drivers/gpu/drm/i915/i915_gem_userptr.c            |   18 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   92 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |    4 +-
 drivers/gpu/drm/i915/i915_irq.c                    |  648 +++-
 drivers/gpu/drm/i915/i915_params.c                 |    9 +-
 drivers/gpu/drm/i915/i915_params.h                 |    2 -
 drivers/gpu/drm/i915/i915_pci.c                    |   20 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  144 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   67 +-
 drivers/gpu/drm/i915/i915_pmu.h                    |    8 +
 drivers/gpu/drm/i915/i915_pvinfo.h                 |    6 +-
 drivers/gpu/drm/i915/i915_reg.h                    | 4088 ++++++++++++----=
----
 drivers/gpu/drm/i915/i915_request.c                |  100 +-
 drivers/gpu/drm/i915/i915_request.h                |   14 +-
 drivers/gpu/drm/i915/i915_selftest.h               |    2 +-
 drivers/gpu/drm/i915/i915_timeline.h               |    2 +
 drivers/gpu/drm/i915/i915_trace.h                  |  148 +-
 drivers/gpu/drm/i915/i915_vgpu.c                   |    8 +-
 drivers/gpu/drm/i915/i915_vgpu.h                   |    6 +
 drivers/gpu/drm/i915/i915_vma.c                    |  385 +-
 drivers/gpu/drm/i915/i915_vma.h                    |   53 +-
 drivers/gpu/drm/i915/icl_dsi.c                     |  127 +
 drivers/gpu/drm/i915/intel_acpi.c                  |   27 +-
 drivers/gpu/drm/i915/intel_atomic.c                |    7 +-
 drivers/gpu/drm/i915/intel_atomic_plane.c          |   18 +-
 drivers/gpu/drm/i915/intel_audio.c                 |   48 +-
 drivers/gpu/drm/i915/intel_bios.c                  |  129 +-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |   16 +-
 drivers/gpu/drm/i915/intel_cdclk.c                 |   61 +-
 drivers/gpu/drm/i915/intel_crt.c                   |   55 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |  178 +-
 drivers/gpu/drm/i915/intel_device_info.c           |    2 +
 drivers/gpu/drm/i915/intel_device_info.h           |    1 +
 drivers/gpu/drm/i915/intel_display.c               |  782 ++--
 drivers/gpu/drm/i915/intel_display.h               |   26 +-
 drivers/gpu/drm/i915/intel_dp.c                    |  531 +--
 drivers/gpu/drm/i915/intel_dp_aux_backlight.c      |   12 +-
 drivers/gpu/drm/i915/intel_dp_link_training.c      |   39 +-
 drivers/gpu/drm/i915/intel_dp_mst.c                |   17 +-
 drivers/gpu/drm/i915/intel_dpll_mgr.c              |  205 +-
 drivers/gpu/drm/i915/intel_dpll_mgr.h              |   18 +-
 drivers/gpu/drm/i915/intel_drv.h                   |   99 +-
 drivers/gpu/drm/i915/intel_dsi.h                   |   34 +-
 drivers/gpu/drm/i915/intel_dsi_vbt.c               |    2 +-
 drivers/gpu/drm/i915/intel_dvo.c                   |   15 +-
 drivers/gpu/drm/i915/intel_engine_cs.c             |  288 +-
 drivers/gpu/drm/i915/intel_fbc.c                   |  129 +-
 drivers/gpu/drm/i915/intel_fbdev.c                 |    9 +-
 drivers/gpu/drm/i915/intel_frontbuffer.c           |    2 -
 drivers/gpu/drm/i915/intel_guc.c                   |  160 +-
 drivers/gpu/drm/i915/intel_guc.h                   |    5 +-
 drivers/gpu/drm/i915/intel_guc_fwif.h              |   20 +-
 drivers/gpu/drm/i915/intel_guc_log.c               |   70 +-
 drivers/gpu/drm/i915/intel_guc_log.h               |   26 +-
 drivers/gpu/drm/i915/intel_guc_submission.c        |  138 +-
 drivers/gpu/drm/i915/intel_gvt.c                   |    5 +
 drivers/gpu/drm/i915/intel_hangcheck.c             |   17 +-
 drivers/gpu/drm/i915/intel_hdmi.c                  |  140 +-
 drivers/gpu/drm/i915/intel_hotplug.c               |  118 +-
 drivers/gpu/drm/i915/intel_huc.c                   |    8 +
 drivers/gpu/drm/i915/intel_huc.h                   |    6 +
 drivers/gpu/drm/i915/intel_i2c.c                   |   84 +-
 drivers/gpu/drm/i915/intel_lpe_audio.c             |    4 +-
 drivers/gpu/drm/i915/intel_lrc.c                   |  979 ++---
 drivers/gpu/drm/i915/intel_lrc.h                   |    7 +-
 drivers/gpu/drm/i915/intel_lspcon.c                |    2 +-
 drivers/gpu/drm/i915/intel_lvds.c                  |  204 +-
 drivers/gpu/drm/i915/intel_modes.c                 |    2 +-
 drivers/gpu/drm/i915/intel_opregion.c              |   31 +-
 drivers/gpu/drm/i915/intel_opregion.h              |    1 +
 drivers/gpu/drm/i915/intel_panel.c                 |   28 +-
 drivers/gpu/drm/i915/intel_pipe_crc.c              |  445 ---
 drivers/gpu/drm/i915/intel_pm.c                    |  109 +-
 drivers/gpu/drm/i915/intel_psr.c                   |  631 ++-
 drivers/gpu/drm/i915/intel_ringbuffer.c            |  405 +-
 drivers/gpu/drm/i915/intel_ringbuffer.h            |  139 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |  333 +-
 drivers/gpu/drm/i915/intel_sdvo.c                  |   49 +-
 drivers/gpu/drm/i915/intel_sprite.c                |  311 +-
 drivers/gpu/drm/i915/intel_tv.c                    |   23 +-
 drivers/gpu/drm/i915/intel_uc.c                    |  165 +-
 drivers/gpu/drm/i915/intel_uncore.c                |   28 +-
 drivers/gpu/drm/i915/intel_uncore.h                |   22 +-
 drivers/gpu/drm/i915/intel_vbt_defs.h              |   14 +-
 drivers/gpu/drm/i915/intel_workarounds.c           |  167 +-
 drivers/gpu/drm/i915/selftests/huge_pages.c        |   82 +-
 .../gpu/drm/i915/selftests/i915_gem_coherency.c    |   47 +-
 drivers/gpu/drm/i915/selftests/i915_gem_context.c  |  301 +-
 drivers/gpu/drm/i915/selftests/i915_gem_dmabuf.c   |    2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |   39 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |  174 +-
 drivers/gpu/drm/i915/selftests/i915_gem_object.c   |   62 +-
 .../gpu/drm/i915/selftests/i915_mock_selftests.h   |    1 +
 drivers/gpu/drm/i915/selftests/i915_request.c      |   34 +-
 drivers/gpu/drm/i915/selftests/i915_selftest.c     |    2 +
 drivers/gpu/drm/i915/selftests/i915_vma.c          |   33 +-
 drivers/gpu/drm/i915/selftests/igt_flush_test.c    |   55 +-
 drivers/gpu/drm/i915/selftests/igt_wedge_me.h      |   58 +
 drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c |    2 +-
 drivers/gpu/drm/i915/selftests/intel_guc.c         |   10 +-
 drivers/gpu/drm/i915/selftests/intel_hangcheck.c   |  260 +-
 drivers/gpu/drm/i915/selftests/intel_lrc.c         |  133 +-
 drivers/gpu/drm/i915/selftests/intel_workarounds.c |   24 +-
 drivers/gpu/drm/i915/selftests/mock_context.c      |    7 +
 drivers/gpu/drm/i915/selftests/mock_dmabuf.c       |   14 -
 drivers/gpu/drm/i915/selftests/mock_engine.c       |   49 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |   20 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.c          |   65 +-
 drivers/gpu/drm/i915/{intel_dsi.c =3D> vlv_dsi.c}    |  117 +-
 .../drm/i915/{intel_dsi_pll.c =3D> vlv_dsi_pll.c}    |   98 +-
 drivers/gpu/drm/imx/imx-drm-core.c                 |   47 +-
 drivers/gpu/drm/imx/imx-drm.h                      |    1 -
 drivers/gpu/drm/imx/imx-ldb.c                      |    5 +-
 drivers/gpu/drm/imx/imx-tve.c                      |    4 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |    3 +-
 drivers/gpu/drm/imx/parallel-display.c             |    4 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |    3 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             |  235 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |   15 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |   10 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  102 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |    5 +-
 drivers/gpu/drm/mediatek/mtk_drm_fb.c              |   76 +-
 drivers/gpu/drm/mediatek/mtk_drm_fb.h              |    1 -
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           |    7 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |    4 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |   22 +-
 drivers/gpu/drm/meson/meson_vclk.c                 |  656 ++--
 drivers/gpu/drm/meson/meson_vclk.h                 |    4 +
 drivers/gpu/drm/meson/meson_venc.c                 |  378 +-
 drivers/gpu/drm/meson/meson_venc.h                 |    3 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |    2 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |    4 +-
 drivers/gpu/drm/msm/Kconfig                        |    1 +
 drivers/gpu/drm/msm/Makefile                       |   31 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |   30 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |   22 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |  242 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   14 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  187 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c       |  479 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h       |  153 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |  637 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h      |  133 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           | 2138 ++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h           |  423 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c            | 2393 ++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.h            |  103 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 2498 ++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |  177 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |  430 ++
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |  905 +++++
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  922 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        | 1173 ++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h        |   88 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_blk.c         |  155 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_blk.h         |   53 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  511 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  804 ++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h  |  168 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c         |  323 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h         |  139 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  540 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  218 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  | 1183 ++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |  257 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |  349 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  128 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c          |  261 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h          |  122 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |  465 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |  250 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h    |  136 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |  753 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h        |  424 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c         |  398 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h         |  202 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c        |  368 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h        |  348 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.c        |  275 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.h        |  128 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h           |   56 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c        |  203 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.h        |   57 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_irq.c            |   66 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_irq.h            |   59 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 1345 +++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |  290 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |  245 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          | 1963 ++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h          |  175 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c   |  249 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h   |  225 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             | 1079 ++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h             |  199 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h          | 1007 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           |  384 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h           |   94 +
 drivers/gpu/drm/msm/disp/dpu1/msm_media_info.h     | 1376 +++++++
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |    3 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |    2 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c  |    4 +-
 .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    |    7 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |    4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   52 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c       |   12 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |    2 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c          |  154 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |    6 +-
 drivers/gpu/drm/msm/dsi/dsi.c                      |    3 +
 drivers/gpu/drm/msm/dsi/dsi.h                      |   23 +-
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |   56 +-
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |   12 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  431 ++-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  135 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c         |    2 +
 drivers/gpu/drm/msm/edp/edp_connector.c            |    4 +-
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c          |    4 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |    7 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |   93 +-
 drivers/gpu/drm/msm/msm_drv.c                      |  230 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   97 +-
 drivers/gpu/drm/msm/msm_fb.c                       |   54 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |  145 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |   68 +-
 drivers/gpu/drm/msm/msm_kms.h                      |   29 +-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c            |    2 +-
 drivers/gpu/drm/nouveau/dispnv04/dac.c             |    2 +-
 drivers/gpu/drm/nouveau/dispnv04/dfp.c             |    2 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |    2 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |    2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   46 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |    1 -
 drivers/gpu/drm/nouveau/include/nvif/object.h      |    2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |    2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   31 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |    4 +
 drivers/gpu/drm/nouveau/nouveau_display.c          |    8 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |    6 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |    2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   14 +-
 drivers/gpu/drm/nouveau/nouveau_hwmon.c            |   12 +-
 drivers/gpu/drm/nouveau/nouveau_platform.c         |    2 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |    3 +-
 drivers/gpu/drm/nouveau/nvkm/core/engine.c         |    3 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |   13 +
 .../gpu/drm/nouveau/nvkm/engine/disp/changf119.c   |    2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/channv50.c    |    4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gv100.c     |   21 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/vpstate.c |   10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c   |   10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gv100.c  |   21 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/priv.h   |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gp10b.     |    0
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c |   25 +-
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c |   16 +-
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gm20b.c    |    2 +
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gp10b.c    |    2 +
 .../drm/omapdrm/displays/panel-sony-acx565akm.c    |    2 +-
 .../drm/omapdrm/displays/panel-tpo-td028ttec1.c    |    2 +-
 drivers/gpu/drm/omapdrm/dss/core.c                 |    4 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |    2 +-
 drivers/gpu/drm/omapdrm/dss/display.c              |    2 +-
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |    2 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |    2 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  |    2 +-
 drivers/gpu/drm/omapdrm/dss/dss.h                  |    5 +-
 drivers/gpu/drm/omapdrm/dss/pll.c                  |   73 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |    2 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |    2 +-
 drivers/gpu/drm/omapdrm/dss/video-pll.c            |    1 +
 drivers/gpu/drm/omapdrm/omap_connector.c           |    4 +-
 drivers/gpu/drm/omapdrm/omap_debugfs.c             |    9 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    6 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |    2 +-
 drivers/gpu/drm/omapdrm/omap_fb.c                  |  109 +-
 drivers/gpu/drm/omapdrm/omap_fb.h                  |    2 -
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |    8 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |  286 +-
 drivers/gpu/drm/omapdrm/omap_gem.h                 |    3 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |   19 -
 drivers/gpu/drm/panel/Kconfig                      |    9 +
 drivers/gpu/drm/panel/Makefile                     |    1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |  503 +++
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |  352 +-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |    1 -
 drivers/gpu/drm/panel/panel-lvds.c                 |    1 -
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |   58 +-
 .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   |    1 -
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |    2 +-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        |    1 -
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c    |    1 -
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |    1 -
 drivers/gpu/drm/panel/panel-simple.c               |  298 +-
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |    1 -
 drivers/gpu/drm/pl111/Makefile                     |    1 +
 drivers/gpu/drm/pl111/pl111_display.c              |   56 +-
 drivers/gpu/drm/pl111/pl111_drm.h                  |    5 +
 drivers/gpu/drm/pl111/pl111_drv.c                  |   61 +-
 drivers/gpu/drm/pl111/pl111_nomadik.c              |   36 +
 drivers/gpu/drm/pl111/pl111_nomadik.h              |   18 +
 drivers/gpu/drm/qxl/qxl_display.c                  |    2 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |    7 -
 drivers/gpu/drm/radeon/ci_dpm.c                    |   20 +-
 drivers/gpu/drm/radeon/cik.c                       |   22 +-
 drivers/gpu/drm/radeon/r600_dpm.c                  |    4 +-
 drivers/gpu/drm/radeon/radeon.h                    |    4 +
 drivers/gpu/drm/radeon/radeon_connectors.c         |   94 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |    6 +-
 drivers/gpu/drm/radeon/radeon_encoders.c           |    2 +-
 drivers/gpu/drm/radeon/radeon_object.c             |    7 +-
 drivers/gpu/drm/radeon/radeon_test.c               |    1 +
 drivers/gpu/drm/radeon/radeon_ttm.c                |    8 +-
 drivers/gpu/drm/radeon/si.c                        |   22 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |   20 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |    6 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |    4 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |   16 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             |    4 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               |    4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |   86 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.h         |    3 -
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   99 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   23 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |    8 +-
 drivers/gpu/drm/savage/savage_state.c              |    2 +-
 drivers/gpu/drm/scheduler/Makefile                 |    1 -
 drivers/gpu/drm/scheduler/gpu_scheduler.c          |  386 +-
 drivers/gpu/drm/scheduler/sched_fence.c            |   13 +-
 drivers/gpu/drm/selftests/drm_mm_selftests.h       |    2 +
 drivers/gpu/drm/selftests/test-drm_mm.c            |   71 +
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c          |    2 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |    2 +-
 drivers/gpu/drm/sti/sti_drv.c                      |    8 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |    6 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |    8 +-
 drivers/gpu/drm/sti/sti_hda.c                      |    2 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |    4 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |    2 +-
 drivers/gpu/drm/stm/drv.c                          |   10 +-
 drivers/gpu/drm/stm/ltdc.c                         |   21 +-
 drivers/gpu/drm/stm/ltdc.h                         |    1 +
 drivers/gpu/drm/sun4i/Kconfig                      |    7 +
 drivers/gpu/drm/sun4i/Makefile                     |    1 +
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   12 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |    2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  127 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |    4 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |    4 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |    4 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   67 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |    2 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |  117 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |   44 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |    8 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |   54 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c         |   90 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |   81 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |    4 +
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c             |  274 ++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h             |   44 +
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |   61 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |   61 +-
 drivers/gpu/drm/tegra/dsi.c                        |    5 +-
 drivers/gpu/drm/tegra/gem.c                        |   14 -
 drivers/gpu/drm/tegra/hdmi.c                       |    2 +-
 drivers/gpu/drm/tegra/output.c                     |    6 +-
 drivers/gpu/drm/tegra/rgb.c                        |    2 +-
 drivers/gpu/drm/tegra/sor.c                        |    2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |    2 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |    9 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              |    2 +-
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c             |    4 +-
 drivers/gpu/drm/tinydrm/Kconfig                    |   11 +
 drivers/gpu/drm/tinydrm/Makefile                   |    1 +
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |    3 +-
 drivers/gpu/drm/tinydrm/ili9225.c                  |    1 -
 drivers/gpu/drm/tinydrm/ili9341.c                  |  232 ++
 drivers/gpu/drm/tinydrm/mi0283qt.c                 |    1 -
 drivers/gpu/drm/tinydrm/mipi-dbi.c                 |    2 +
 drivers/gpu/drm/tinydrm/st7586.c                   |    1 -
 drivers/gpu/drm/tinydrm/st7735r.c                  |    1 -
 drivers/gpu/drm/ttm/ttm_bo.c                       |   17 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   11 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |   63 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |   62 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |   59 +-
 drivers/gpu/drm/ttm/ttm_tt.c                       |   25 +-
 drivers/gpu/drm/udl/udl_connector.c                |    4 +-
 drivers/gpu/drm/udl/udl_dmabuf.c                   |   18 -
 drivers/gpu/drm/udl/udl_drv.h                      |    5 +-
 drivers/gpu/drm/udl/udl_fb.c                       |   23 +-
 drivers/gpu/drm/udl/udl_gem.c                      |   15 +-
 drivers/gpu/drm/udl/udl_main.c                     |   45 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |    7 +-
 drivers/gpu/drm/udl/udl_transfer.c                 |   46 +-
 drivers/gpu/drm/v3d/v3d_bo.c                       |   28 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |   11 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |   11 +-
 drivers/gpu/drm/v3d/v3d_fence.c                    |   17 -
 drivers/gpu/drm/v3d/v3d_gem.c                      |   13 +-
 drivers/gpu/drm/v3d/v3d_irq.c                      |    3 -
 drivers/gpu/drm/v3d/v3d_regs.h                     |    1 +
 drivers/gpu/drm/v3d/v3d_sched.c                    |   26 +-
 drivers/gpu/drm/vc4/Makefile                       |    1 +
 drivers/gpu/drm/vc4/vc4_bo.c                       |    2 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |  147 +-
 drivers/gpu/drm/vc4/vc4_debugfs.c                  |    1 +
 drivers/gpu/drm/vc4/vc4_drv.c                      |    9 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |   10 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   57 +-
 drivers/gpu/drm/vc4/vc4_fence.c                    |    8 -
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |    4 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |   11 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |   98 +-
 drivers/gpu/drm/vc4/vc4_regs.h                     |    6 +
 drivers/gpu/drm/vc4/vc4_txp.c                      |  477 +++
 drivers/gpu/drm/vc4/vc4_vec.c                      |    2 +-
 drivers/gpu/drm/vgem/vgem_drv.c                    |    7 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |   34 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |    1 -
 drivers/gpu/drm/virtio/virtgpu_fb.c                |    8 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c             |    7 -
 drivers/gpu/drm/virtio/virtgpu_plane.c             |    4 +-
 drivers/gpu/drm/vkms/Makefile                      |    3 +
 drivers/gpu/drm/vkms/vkms_crtc.c                   |  130 +
 drivers/gpu/drm/vkms/vkms_drv.c                    |  156 +
 drivers/gpu/drm/vkms/vkms_drv.h                    |   78 +
 drivers/gpu/drm/vkms/vkms_gem.c                    |  179 +
 drivers/gpu/drm/vkms/vkms_output.c                 |  111 +
 drivers/gpu/drm/vkms/vkms_plane.c                  |   57 +
 drivers/gpu/drm/vmwgfx/Kconfig                     |    1 +
 drivers/gpu/drm/vmwgfx/Makefile                    |    4 +-
 .../gpu/drm/vmwgfx/device_include/svga3d_caps.h    |    3 +-
 drivers/gpu/drm/vmwgfx/device_include/svga3d_cmd.h |  233 +-
 .../gpu/drm/vmwgfx/device_include/svga3d_devcaps.h |   86 +-
 drivers/gpu/drm/vmwgfx/device_include/svga3d_dx.h  |  300 +-
 .../gpu/drm/vmwgfx/device_include/svga3d_limits.h  |    7 +-
 drivers/gpu/drm/vmwgfx/device_include/svga3d_reg.h |    3 +-
 .../drm/vmwgfx/device_include/svga3d_surfacedefs.h | 1094 +++---
 .../gpu/drm/vmwgfx/device_include/svga3d_types.h   |  334 +-
 .../gpu/drm/vmwgfx/device_include/svga_escape.h    |    3 +-
 .../gpu/drm/vmwgfx/device_include/svga_overlay.h   |    3 +-
 drivers/gpu/drm/vmwgfx/device_include/svga_reg.h   |  211 +-
 drivers/gpu/drm/vmwgfx/device_include/svga_types.h |    6 +-
 .../drm/vmwgfx/device_include/vmware_pack_begin.h  |   25 +-
 .../drm/vmwgfx/device_include/vmware_pack_end.h    |   25 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c            |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.h            |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |    3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 | 1123 ++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c         |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c            |   18 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |   18 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_dmabuf.c             |  376 --
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   72 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  186 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  122 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |   41 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |   42 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.h              |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c               |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c                |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c      |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c              |   29 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_irq.c                |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  604 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   80 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |   16 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_marker.c             |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |   10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |   18 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h                |   35 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |   28 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c              |   18 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_reg.h                |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |  709 +---
 drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h      |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  146 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |   30 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c    |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c                 |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_so.h                 |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  109 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |  553 ++-
 .../{vmwgfx_buffer.c =3D> vmwgfx_ttm_buffer.c}       |   10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c           |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_va.c                 |    4 +-
 drivers/gpu/drm/xen/xen_drm_front.c                |    2 +-
 drivers/gpu/drm/xen/xen_drm_front.h                |    4 +-
 drivers/gpu/drm/xen/xen_drm_front_shbuf.c          |    2 +-
 drivers/gpu/drm/zte/zx_hdmi.c                      |    4 +-
 drivers/gpu/drm/zte/zx_plane.c                     |    2 +-
 drivers/gpu/drm/zte/zx_tvenc.c                     |    2 +-
 drivers/gpu/drm/zte/zx_vga.c                       |    4 +-
 drivers/gpu/ipu-v3/ipu-common.c                    |    6 +
 drivers/gpu/ipu-v3/ipu-cpmem.c                     |   29 +-
 drivers/gpu/ipu-v3/ipu-csi.c                       |   34 +-
 drivers/gpu/ipu-v3/ipu-image-convert.c             |    6 +
 .../media/common/videobuf2/videobuf2-dma-contig.c  |    3 +-
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  |    3 +-
 drivers/media/common/videobuf2/videobuf2-vmalloc.c |    3 +-
 drivers/pci/pci.c                                  |    2 +
 drivers/staging/android/ion/ion.c                  |    6 +-
 drivers/staging/vboxvideo/vbox_mode.c              |    4 +-
 drivers/tee/tee_shm.c                              |    6 -
 drivers/video/console/Kconfig                      |   11 +
 drivers/video/console/dummycon.c                   |   69 +-
 drivers/video/fbdev/core/fbcon.c                   |   83 +
 include/drm/drmP.h                                 |   18 -
 include/drm/drm_atomic.h                           |   14 +-
 include/drm/drm_atomic_helper.h                    |    1 +
 include/drm/drm_bridge.h                           |   48 +-
 include/drm/drm_client.h                           |  139 +
 include/drm/drm_connector.h                        |  279 +-
 include/drm/drm_crtc.h                             |  276 +-
 include/drm/drm_debugfs_crc.h                      |    3 +-
 include/drm/drm_device.h                           |   21 +
 include/drm/drm_dp_helper.h                        |   56 +
 include/drm/drm_drv.h                              |   29 +
 include/drm/drm_encoder.h                          |   16 +-
 include/drm/drm_fb_cma_helper.h                    |    6 -
 include/drm/drm_fb_helper.h                        |   38 +
 include/drm/drm_file.h                             |    7 +
 include/drm/drm_fourcc.h                           |    2 +
 include/drm/drm_mm.h                               |   34 +-
 include/drm/drm_mode_config.h                      |   36 +-
 include/drm/drm_modes.h                            |    2 +-
 include/drm/drm_modeset_helper_vtables.h           |   17 +-
 include/drm/drm_of.h                               |    8 +
 include/drm/drm_panel.h                            |    3 +-
 include/drm/drm_pci.h                              |    7 -
 include/drm/drm_plane.h                            |  197 +-
 include/drm/drm_plane_helper.h                     |    6 +-
 include/drm/drm_prime.h                            |    6 +-
 include/drm/drm_print.h                            |   77 +
 include/drm/drm_property.h                         |    4 +-
 include/drm/drm_vma_manager.h                      |    1 +
 include/drm/drm_writeback.h                        |  136 +
 include/drm/gpu_scheduler.h                        |  174 +-
 include/drm/i915_drm.h                             |    4 +-
 include/drm/i915_pciids.h                          |   37 +-
 include/drm/tinydrm/tinydrm.h                      |   23 +-
 include/drm/ttm/ttm_bo_api.h                       |   25 +-
 include/drm/ttm/ttm_set_memory.h                   |  150 +
 include/dt-bindings/clock/sun8i-tcon-top.h         |   11 +
 include/linux/ascii85.h                            |   38 +
 include/linux/console.h                            |    5 +
 include/linux/dma-buf.h                            |   21 +-
 include/linux/dma-fence.h                          |   32 +-
 include/linux/pci.h                                |    3 +
 include/linux/ww_mutex.h                           |   45 +-
 include/uapi/drm/amdgpu_drm.h                      |   27 +-
 include/uapi/drm/drm.h                             |    9 +
 include/uapi/drm/drm_fourcc.h                      |  176 +
 include/uapi/drm/drm_mode.h                        |    8 +
 include/uapi/drm/vmwgfx_drm.h                      |  166 +-
 include/uapi/linux/kfd_ioctl.h                     |   33 +-
 include/video/mipi_display.h                       |    3 +
 kernel/locking/locktorture.c                       |    2 +-
 kernel/locking/mutex.c                             |  345 +-
 kernel/locking/test-ww_mutex.c                     |    2 +-
 kernel/printk/printk.c                             |    1 +
 lib/locking-selftest.c                             |    2 +-
 1125 files changed, 77636 insertions(+), 25180 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/ilitek,ili934=
1.txt
 create mode 100644 Documentation/devicetree/bindings/display/msm/dpu.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/auo,g070vvn01.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/dataimage,scf0700c48ggu18.t=
xt
 create mode 100644
Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/edt,et-series.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/innolux,g070y2-l01.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/innolux,tv123wam.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt
 rename Documentation/devicetree/bindings/display/panel/{edt,et057090dhu.tx=
t
=3D> newhaven,nhd-4.3-480272ef-atxl.txt} (55%)
 create mode 100644
Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sharp,lq035q7db03.txt
 create mode 100644 Documentation/gpu/amdgpu.rst
 create mode 100644 Documentation/gpu/drm-client.rst
 create mode 100644 Documentation/gpu/msm-crash-dump.rst
 create mode 100644 Documentation/gpu/v3d.rst
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs=
.c
 rename drivers/gpu/drm/amd/{powerplay/inc/pp_power_source.h =3D>
display/amdgpu_dm/amdgpu_dm_debugfs.h} (81%)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.=
c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/basics/logger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/soc_bounding_box.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/color/luts_1d.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_9_0=
.h
 create mode 100644
drivers/gpu/drm/amd/include/ivsrcid/sdma0/irqsrcs_sdma0_4_0.h
 create mode 100644
drivers/gpu/drm/amd/include/ivsrcid/sdma1/irqsrcs_sdma1_4_0.h
 rename drivers/gpu/drm/amd/{display/dc/dml/soc_bounding_box.h =3D>
include/ivsrcid/smuio/irqsrcs_smuio_9_0.h} (75%)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/thm/irqsrcs_thm_9_0=
.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/uvd/irqsrcs_uvd_7_0=
.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/vce/irqsrcs_vce_4_0=
.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0=
.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/vmc/irqsrcs_vmc_1_0=
.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h
 create mode 100644 drivers/gpu/drm/arm/malidp_mw.c
 create mode 100644 drivers/gpu/drm/arm/malidp_mw.h
 create mode 100644 drivers/gpu/drm/armada/armada_plane.c
 create mode 100644 drivers/gpu/drm/armada/armada_plane.h
 create mode 100644 drivers/gpu/drm/drm_client.c
 create mode 100644 drivers/gpu/drm/drm_dp_cec.c
 create mode 100644 drivers/gpu/drm/drm_writeback.c
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_core.c
 create mode 100644 drivers/gpu/drm/i915/icl_dsi.c
 create mode 100644 drivers/gpu/drm/i915/selftests/igt_wedge_me.h
 rename drivers/gpu/drm/i915/{intel_dsi.c =3D> vlv_dsi.c} (96%)
 rename drivers/gpu/drm/i915/{intel_dsi_pll.c =3D> vlv_dsi_pll.c} (84%)
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_blk.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_blk.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_irq.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_irq.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/msm_media_info.h
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gp10b.
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_nomadik.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_nomadik.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.h
 create mode 100644 drivers/gpu/drm/tinydrm/ili9341.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_txp.c
 create mode 100644 drivers/gpu/drm/vkms/Makefile
 create mode 100644 drivers/gpu/drm/vkms/vkms_crtc.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_drv.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_drv.h
 create mode 100644 drivers/gpu/drm/vkms/vkms_gem.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_output.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_plane.c
 create mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
 delete mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_dmabuf.c
 rename drivers/gpu/drm/vmwgfx/{vmwgfx_buffer.c =3D> vmwgfx_ttm_buffer.c} (=
99%)
 create mode 100644 include/drm/drm_client.h
 create mode 100644 include/drm/drm_writeback.h
 create mode 100644 include/drm/ttm/ttm_set_memory.h
 create mode 100644 include/dt-bindings/clock/sun8i-tcon-top.h
 create mode 100644 include/linux/ascii85.h

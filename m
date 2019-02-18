Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA26C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C19721901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497543;
	bh=+E26zDShrL/aJ2Mt3QBHAilq6gJtwoN3A60RFa21YhA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aWbMHe3Mh34vQxEBpxl5miFkOajN2dOLgC6mop3fC7w17DPNInQqF61BdQFqs+R7v
	 MqUgdvnpUeWFFS4IU4LRRAFJSSrhqwapwpxjuxeDCalYGa1OeoWnK8fnvmKYikP+9C
	 cAt74WgQ49UD8/d1gimEasXIDD4LNWjyBI2WHznk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfBRNpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731370AbfBRNpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B9A2217F5;
        Mon, 18 Feb 2019 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497539;
        bh=+E26zDShrL/aJ2Mt3QBHAilq6gJtwoN3A60RFa21YhA=;
        h=From:To:Cc:Subject:Date:From;
        b=jUwvEOlQmIUimfFqZhEqG+pEzMnTBgCuAAQddoi4Kn7BGv+GY0oEUF41zekxGUQ2H
         iP3vNw7DjxH8mge7FXRPVlz4Z6CfMcEhipwYwyj/PME9zOgeU44ZbJEaG4knVBjlKQ
         cBYUTeFYEah1Qp0RgzD9eZ7DLZdvOkPRGSIwW+aY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.20 00/92] 4.20.11-stable review
Date:   Mon, 18 Feb 2019 14:42:03 +0100
Message-Id: <20190218133454.668268457@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.11-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.20.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.20.11-rc1
X-KernelTest-Deadline: 2019-02-20T13:35+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.20.11 release.
There are 92 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 20 13:34:25 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.11-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.20.11-rc1

Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
    drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set

Lyude Paul <lyude@redhat.com>
    drm/i915: Block fbdev HPD processing during suspend

Eric Anholt <eric@anholt.net>
    drm/sched: Always trace the dependencies we wait on, to fix a race.

Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
    drm/vkms: Fix license inconsistent

Matthew Wilcox <willy@infradead.org>
    drm: Use array_size() when creating lease

Nikos Tsironis <ntsironis@arrikto.com>
    dm thin: fix bug where bio that overwrites thin block ignores FUA

Mikulas Patocka <mpatocka@redhat.com>
    dm crypt: don't overallocate the integrity tag space

Scott Mayhew <smayhew@redhat.com>
    sunrpc: fix 4 more call sites that were using stack memory with a scatterlist

Borislav Petkov <bp@suse.de>
    x86/a.out: Clear the dump structure initially

Nate Dailey <nate.dailey@stratus.com>
    md/raid1: don't clear bitmap bits on interrupted recovery.

Gilad Ben-Yossef <gilad@benyossef.com>
    crypto: ccree - fix resume race condition on init

Eric W. Biederman <ebiederm@xmission.com>
    signal: Restore the stop PTRACE_EVENT_EXIT

James Bottomley <James.Bottomley@HansenPartnership.com>
    scsi: sd: fix entropy gathering for most rotational disks

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()

Hedi Berriche <hedi.berriche@hpe.com>
    x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Andreas Ziegler <andreas.ziegler@fau.de>
    tracing: probeevent: Correctly update remaining space in dynamic area

Harald Freudenberger <freude@linux.ibm.com>
    s390/zcrypt: fix specification exception on z196 during ap probe

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/suspend: fix stack setup in swsusp_arch_suspend

Meelis Roos <mroos@linux.ee>
    alpha: Fix Eiger NR_IRQS to 128

Sergei Trofimovich <slyfox@gentoo.org>
    alpha: fix page fault handling for r16-r18 targets

Sandeep Patil <sspatil@android.com>
    mm: proc: smaps_rollup: fix pss_locked calculation

Dave Chinner <dchinner@redhat.com>
    Revert "mm: slowly shrink slabs with a relatively small number of objects"

Dave Chinner <dchinner@redhat.com>
    Revert "mm: don't reclaim inodes with many attached pages"

J. Bruce Fields <bfields@redhat.com>
    Revert "nfsd4: return default lease period"

Matti Kurkela <Matti.Kurkela@iki.fi>
    Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Jonathan Bakker <xc-racer2@live.ca>
    Input: bma150 - register input device after setting private data

Zachary Hays <zhays@lexmark.com>
    mmc: block: handle complete_work on separate workqueue

Chen-Yu Tsai <wens@csie.org>
    mmc: sunxi: Filter out unsupported modes declared in the device tree

Chen-Yu Tsai <wens@csie.org>
    mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default

Xiaoyao Li <xiaoyao.li@linux.intel.com>
    kvm: vmx: Fix entry number check for add_atomic_switch_msr()

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/kvm/nVMX: read from MSR_IA32_VMX_PROCBASED_CTLS2 only when it is available

Stefan O'Rear <sorear2@gmail.com>
    riscv: Add pte bit to distinguish swap from invalid

Bob Tracy <rct@frus.com>
    tools uapi: fix Alpha support

Russell King <rmk+kernel@armlinux.org.uk>
    ASoC: hdmi-codec: fix oops on re-probe

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Revert capture stream behavior change in blocking mode

Manuel Reinhardt <manuel.rhdt@gmail.com>
    ALSA: usb-audio: Fix implicit fb endpoint setup by quirk

Jurica Vukadin <jurica.vukadin@rt-rk.com>
    ALSA: hda - Add quirk for HP EliteBook 840 G5

Jiri Olsa <jolsa@redhat.com>
    perf/x86: Add check_period PMU callback

Ingo Molnar <mingo@kernel.org>
    perf/core: Fix impossible ring-buffer sizes warning

Tony Lindgren <tony@atomide.com>
    ARM: OMAP5+: Fix inverted nirq pin interrupts with irq_set_type

Dmitry Voytik <voytikd@gmail.com>
    arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-rock64

Mauro Ciancio <mauro@acadeu.com>
    Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G"

Anson Huang <anson.huang@nxp.com>
    gpio: mxc: move gpio noirq suspend/resume to syscore phase

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix mounts if the client is low on credits

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not assume one credit for async responses

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix credit calculations in compound mid callback

David Rientjes <rientjes@google.com>
    kvm: sev: Fail KVM_SEV_INIT if already initialized

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix error paths in writeback code

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Move credit processing to mid callbacks for SMB3

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix credits calculation for cancelled requests

Ross Lagerwall <ross.lagerwall@citrix.com>
    cifs: Limit memory used by lock request calls to a page

Ilia Mirkin <imirkin@alum.mit.edu>
    drm/nouveau/falcon: avoid touching registers if engine is off

Takashi Iwai <tiwai@suse.de>
    drm/nouveau: Don't disable polling in fallback mode

Nicholas Mc Guire <hofrat@osadl.org>
    gpio: pl061: handle failed allocations

Guo Ren <ren_guo@c-sky.com>
    csky: fixup compile error with CPU 810.

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: kirkwood: Fix polarity of GPIO fan lines

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: da850-lcdk: Correct the sound card name

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: da850-lcdk: Correct the audio codec regulators

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: da850-evm: Correct the sound card name

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: da850-evm: Correct the audio codec regulators

Christian König <christian.koenig@amd.com>
    drm/amdgpu: disable system memory page tables for now

Jim Qu <Jim.Qu@amd.com>
    drm/amdgpu: set WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang

Tao Zhou <tao.zhou1@amd.com>
    drm/amdgpu: fix CPDMA hang in PRT mode for VEGA20

James Dingwall <james@dingwall.me.uk>
    nvme: introduce NVME_QUIRK_IGNORE_DEV_SUBNQN

Keith Busch <keith.busch@intel.com>
    nvme: pad fake subsys NQN vid and ssvid with zeros

Hannes Reinecke <hare@suse.de>
    nvme-multipath: zero out ANA log buffer

Hongbo Yao <yaohongbo@huawei.com>
    nvme-pci: fix out of bounds access in nvme_cqe_pending

Liviu Dudau <liviu@dudau.co.uk>
    nvme-pci: use the same attributes when freeing host_mem_desc_bufs.

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: fix output H/V syncs

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: reject modes which require too much BW

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: fix single lane configuration

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: add defines for DP1_SRCCTRL & PHY_2LANE

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: add bus flags

Evan Quan <evan.quan@amd.com>
    drm/amd/powerplay: avoid possible buffer overflow

Guo Ren <ren_guo@c-sky.com>
    irqchip/csky: fixup handle_irq_perbit break irq

Guo Ren <ren_guo@c-sky.com>
    csky: fixup compile error with pte_alloc

Guo Ren <ren_guo@c-sky.com>
    csky: fixup CACHEV1 store instruction fast retire

Guo Ren <ren_guo@c-sky.com>
    csky: fixup relocation error with 807 & 860

Sudeep Holla <sudeep.holla@arm.com>
    cpufreq: check if policy is inactive early in __cpufreq_get()

David Abdurachmanov <david.abdurachmanov@gmail.com>
    riscv: fix trace_sys_exit hook

Aurelien Jarno <aurelien@aurel32.net>
    tools uapi: fix RISC-V 64-bit support

Biju Das <biju.das@bp.renesas.com>
    soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B}

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf test shell: Use a fallback to get the pathname in vfs_getname

Jin Yao <yao.jin@linux.intel.com>
    perf report: Fix wrong iteration count in --branch-history

Jin Yao <yao.jin@linux.intel.com>
    perf stat: Fix endless wait for child process

Chao Fan <fanc.fnst@cn.fujitsu.com>
    ACPI: NUMA: Use correct type for printing addresses on i386-PAE

Emily Deng <Emily.Deng@amd.com>
    drm/amdgpu/sriov:Correct pfvf exchange logic

Jianchao Wang <jianchao.w.wang@oracle.com>
    blk-mq: fix a hung issue when fsync

Adrian Bunk <bunk@kernel.org>
    eeprom: at24: add support for 24c2048

Adrian Bunk <bunk@kernel.org>
    dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string


-------------

Diffstat:

 Documentation/devicetree/bindings/eeprom/at24.txt  |  1 +
 Makefile                                           |  4 +-
 arch/alpha/include/asm/irq.h                       |  6 +-
 arch/alpha/mm/fault.c                              |  2 +-
 arch/arm/boot/dts/da850-evm.dts                    | 31 +++++++--
 arch/arm/boot/dts/da850-lcdk.dts                   | 38 ++++++++++-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |  4 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |  9 ++-
 arch/arm/boot/dts/omap5-cm-t54.dts                 | 12 +++-
 arch/arm/mach-integrator/impd1.c                   |  6 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               | 36 +++++++++-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  2 +
 arch/csky/include/asm/io.h                         | 25 +++++++
 arch/csky/include/asm/pgalloc.h                    | 43 +++++-------
 arch/csky/kernel/module.c                          | 38 ++++++-----
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  4 +-
 arch/riscv/include/asm/pgtable-bits.h              |  6 ++
 arch/riscv/include/asm/pgtable.h                   |  8 +--
 arch/riscv/kernel/ptrace.c                         |  2 +-
 arch/s390/kernel/swsusp.S                          |  4 +-
 arch/x86/events/core.c                             | 14 ++++
 arch/x86/events/intel/core.c                       |  9 +++
 arch/x86/events/perf_event.h                       | 16 ++++-
 arch/x86/ia32/ia32_aout.c                          |  6 +-
 arch/x86/include/asm/uv/bios.h                     |  8 ++-
 arch/x86/kvm/svm.c                                 |  3 +
 arch/x86/kvm/vmx.c                                 | 11 ++--
 arch/x86/platform/uv/bios_uv.c                     | 23 ++++++-
 block/blk-flush.c                                  |  2 +-
 drivers/acpi/numa.c                                |  6 +-
 drivers/cpufreq/cpufreq.c                          | 12 ++--
 drivers/crypto/ccree/cc_driver.c                   |  7 +-
 drivers/crypto/ccree/cc_pm.c                       | 13 ++--
 drivers/crypto/ccree/cc_pm.h                       |  3 +
 drivers/firmware/efi/runtime-wrappers.c            |  7 ++
 drivers/gpio/gpio-mxc.c                            | 41 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  3 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 10 +--
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  3 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 14 ++++
 drivers/gpu/drm/bridge/tc358767.c                  | 45 ++++++++++---
 drivers/gpu/drm/drm_lease.c                        |  3 +-
 drivers/gpu/drm/i915/i915_gem.c                    | 12 +++-
 drivers/gpu/drm/i915/intel_drv.h                   | 10 +++
 drivers/gpu/drm/i915/intel_fbdev.c                 | 33 +++++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c       |  7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c   |  7 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |  7 +-
 drivers/gpu/drm/vkms/vkms_crc.c                    |  3 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |  8 +--
 drivers/gpu/drm/vkms/vkms_drv.c                    |  7 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |  2 +
 drivers/gpu/drm/vkms/vkms_gem.c                    |  8 +--
 drivers/gpu/drm/vkms/vkms_output.c                 |  8 +--
 drivers/gpu/drm/vkms/vkms_plane.c                  |  8 +--
 drivers/input/misc/bma150.c                        |  9 +--
 drivers/input/mouse/elan_i2c_core.c                |  2 +-
 drivers/input/mouse/elantech.c                     |  9 +++
 drivers/irqchip/irq-csky-apb-intc.c                | 77 ++++++++++++----------
 drivers/md/dm-crypt.c                              |  2 +-
 drivers/md/dm-thin.c                               | 55 ++++++++++++++--
 drivers/md/raid1.c                                 | 28 +++++---
 drivers/misc/eeprom/Kconfig                        |  2 +-
 drivers/misc/eeprom/at24.c                         |  3 +
 drivers/mmc/core/block.c                           | 10 ++-
 drivers/mmc/host/sunxi-mmc.c                       | 26 +++++++-
 drivers/nvme/host/core.c                           | 18 ++---
 drivers/nvme/host/multipath.c                      |  2 +
 drivers/nvme/host/nvme.h                           |  5 ++
 drivers/nvme/host/pci.c                            | 16 +++--
 drivers/s390/crypto/ap_bus.c                       |  3 +-
 drivers/scsi/sd.c                                  | 12 +++-
 drivers/soc/renesas/r8a774c0-sysc.c                | 23 ++-----
 fs/cifs/cifsglob.h                                 | 20 ++++++
 fs/cifs/cifssmb.c                                  |  7 +-
 fs/cifs/file.c                                     | 37 +++++++++--
 fs/cifs/inode.c                                    | 10 +++
 fs/cifs/smb2file.c                                 |  4 ++
 fs/cifs/smb2inode.c                                | 17 +++++
 fs/cifs/smb2ops.c                                  |  6 +-
 fs/cifs/smb2pdu.c                                  | 15 +++--
 fs/cifs/transport.c                                | 58 ++++++++++++----
 fs/inode.c                                         |  7 +-
 fs/nfsd/nfsctl.c                                   |  4 +-
 fs/proc/task_mmu.c                                 | 22 ++++---
 include/linux/mmc/card.h                           |  1 +
 include/linux/perf_event.h                         |  5 ++
 kernel/events/core.c                               | 16 +++++
 kernel/events/ring_buffer.c                        |  2 +-
 kernel/signal.c                                    |  7 +-
 kernel/trace/trace_probe_tmpl.h                    |  6 +-
 mm/vmscan.c                                        | 10 ---
 net/sunrpc/auth_gss/gss_krb5_seqnum.c              | 49 ++++++++++----
 sound/core/pcm_lib.c                               | 20 ++----
 sound/pci/hda/patch_conexant.c                     |  1 +
 sound/soc/codecs/hdmi-codec.c                      |  4 +-
 sound/usb/pcm.c                                    |  9 ++-
 tools/arch/riscv/include/uapi/asm/bitsperlong.h    | 25 +++++++
 tools/include/uapi/asm/bitsperlong.h               |  4 ++
 tools/perf/builtin-stat.c                          |  3 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |  3 +-
 tools/perf/util/callchain.c                        | 32 +++++----
 tools/perf/util/callchain.h                        |  1 +
 tools/perf/util/machine.c                          |  2 +-
 106 files changed, 991 insertions(+), 388 deletions(-)



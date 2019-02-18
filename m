Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD48FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693AF20838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500913;
	bh=lrKzK4fELkQLBeJypVa0b264MMRXWfvwhmZr6HGzm1E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=E5EsGuc+4Txpww+ymQhMUA6uTZPYmZIhRjok8KbeTP4G1MOXVs3jC/dQ6putiv/DN
	 wQNe6Ruxm0wA+Urakzy86cRw51kKfweL1T53oSvoNByV5mlNkNNdc7xSs1O5g0Av0z
	 nXfP9jAHunoCmv23NvmI/5v2tvpRDisIwxQrB4DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfBRNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732021AbfBRNum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:50:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAADD21901;
        Mon, 18 Feb 2019 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497841;
        bh=lrKzK4fELkQLBeJypVa0b264MMRXWfvwhmZr6HGzm1E=;
        h=From:To:Cc:Subject:Date:From;
        b=YhE4LqYsa1EUwg86wyeqrk8BGAMmUR6V/DXCdtowZHqu53P1PNc0lj2H/EqwzDPcW
         V3XO6fGVnzmRXiptgdjJ4wQGIN+UeO9bs0g/yVL8rFk500jejApnlYlJDhJLK8PUec
         7iRPyCZZu6YZAMbseswvOML1k5WRMpAwD3wUKyDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/85] 4.19.24-stable review
Date:   Mon, 18 Feb 2019 14:42:26 +0100
Message-Id: <20190218133459.758004711@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.24-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.24-rc1
X-KernelTest-Deadline: 2019-02-20T13:35+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.24 release.
There are 85 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 20 13:34:30 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.24-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.24-rc1

Sandeep Patil <sspatil@android.com>
    mm: proc: smaps_rollup: fix pss_locked calculation

Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
    drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set

Lyude Paul <lyude@redhat.com>
    drm/i915: Block fbdev HPD processing during suspend

Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
    drm/vkms: Fix license inconsistent

Matthew Wilcox <willy@infradead.org>
    drm: Use array_size() when creating lease

Nikos Tsironis <ntsironis@arrikto.com>
    dm thin: fix bug where bio that overwrites thin block ignores FUA

Mikulas Patocka <mpatocka@redhat.com>
    dm crypt: don't overallocate the integrity tag space

Borislav Petkov <bp@suse.de>
    x86/a.out: Clear the dump structure initially

Nate Dailey <nate.dailey@stratus.com>
    md/raid1: don't clear bitmap bits on interrupted recovery.

Eric W. Biederman <ebiederm@xmission.com>
    signal: Restore the stop PTRACE_EVENT_EXIT

James Bottomley <James.Bottomley@HansenPartnership.com>
    scsi: sd: fix entropy gathering for most rotational disks

Hedi Berriche <hedi.berriche@hpe.com>
    x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Andreas Ziegler <andreas.ziegler@fau.de>
    tracing/uprobes: Fix output for multiple string arguments

Harald Freudenberger <freude@linux.ibm.com>
    s390/zcrypt: fix specification exception on z196 during ap probe

Meelis Roos <mroos@linux.ee>
    alpha: Fix Eiger NR_IRQS to 128

Sergei Trofimovich <slyfox@gentoo.org>
    alpha: fix page fault handling for r16-r18 targets

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

Mauro Ciancio <mauro@acadeu.com>
    Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G"

Anson Huang <anson.huang@nxp.com>
    gpio: mxc: move gpio noirq suspend/resume to syscore phase

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not assume one credit for async responses

David Rientjes <rientjes@google.com>
    kvm: sev: Fail KVM_SEV_INIT if already initialized

Ross Lagerwall <ross.lagerwall@citrix.com>
    cifs: Limit memory used by lock request calls to a page

Ilia Mirkin <imirkin@alum.mit.edu>
    drm/nouveau/falcon: avoid touching registers if engine is off

Takashi Iwai <tiwai@suse.de>
    drm/nouveau: Don't disable polling in fallback mode

Nicholas Mc Guire <hofrat@osadl.org>
    gpio: pl061: handle failed allocations

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

Jim Qu <Jim.Qu@amd.com>
    drm/amdgpu: set WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang

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

Sudeep Holla <sudeep.holla@arm.com>
    cpufreq: check if policy is inactive early in __cpufreq_get()

David Abdurachmanov <david.abdurachmanov@gmail.com>
    riscv: fix trace_sys_exit hook

Aurelien Jarno <aurelien@aurel32.net>
    tools uapi: fix RISC-V 64-bit support

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf test shell: Use a fallback to get the pathname in vfs_getname

Jin Yao <yao.jin@linux.intel.com>
    perf report: Fix wrong iteration count in --branch-history

Chao Fan <fanc.fnst@cn.fujitsu.com>
    ACPI: NUMA: Use correct type for printing addresses on i386-PAE

Emily Deng <Emily.Deng@amd.com>
    drm/amdgpu/sriov:Correct pfvf exchange logic

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: fix the cockup in the previous patch

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: ensure that processor vtables is not lost after boot

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: per-CPU vtables to work around big.Little systems

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: add PROC_VTABLE and PROC_TABLE macros

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: clean up per-processor check_bugs method call

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: split out processor lookup

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: make lookup_processor_type() non-__init

Julien Thierry <julien.thierry@arm.com>
    ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc

Julien Thierry <julien.thierry@arm.com>
    ARM: 8797/1: spectre-v1.1: harden __copy_to_user

Julien Thierry <julien.thierry@arm.com>
    ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization

Julien Thierry <julien.thierry@arm.com>
    ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()

Julien Thierry <julien.thierry@arm.com>
    ARM: 8794/1: uaccess: Prevent speculative use of the current addr_limit

Julien Thierry <julien.thierry@arm.com>
    ARM: 8793/1: signal: replace __put_user_error with __put_user

Julien Thierry <julien.thierry@arm.com>
    ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()

Julien Thierry <julien.thierry@arm.com>
    ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state

Julien Thierry <julien.thierry@arm.com>
    ARM: 8790/1: signal: always use __copy_to_user to save iwmmxt context

Julien Thierry <julien.thierry@arm.com>
    ARM: 8789/1: signal: copy registers using __copy_to_user()

Jianchao Wang <jianchao.w.wang@oracle.com>
    blk-mq: fix a hung issue when fsync

Adrian Bunk <bunk@kernel.org>
    eeprom: at24: add support for 24c2048

Adrian Bunk <bunk@kernel.org>
    dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string


-------------

Diffstat:

 Documentation/devicetree/bindings/eeprom/at24.txt |  1 +
 Makefile                                          |  4 +-
 arch/alpha/include/asm/irq.h                      |  6 +-
 arch/alpha/mm/fault.c                             |  2 +-
 arch/arm/boot/dts/da850-evm.dts                   | 31 +++++++--
 arch/arm/boot/dts/da850-lcdk.dts                  | 38 ++++++++++-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi             |  4 +-
 arch/arm/boot/dts/omap5-board-common.dtsi         |  9 ++-
 arch/arm/boot/dts/omap5-cm-t54.dts                | 12 +++-
 arch/arm/include/asm/assembler.h                  | 11 ++++
 arch/arm/include/asm/cputype.h                    |  1 +
 arch/arm/include/asm/proc-fns.h                   | 61 +++++++++++++----
 arch/arm/include/asm/thread_info.h                |  4 +-
 arch/arm/include/asm/uaccess.h                    | 49 ++++++++++++--
 arch/arm/kernel/bugs.c                            |  4 +-
 arch/arm/kernel/head-common.S                     |  6 +-
 arch/arm/kernel/setup.c                           | 40 +++++++-----
 arch/arm/kernel/signal.c                          | 80 +++++++++++++----------
 arch/arm/kernel/smp.c                             | 31 +++++++++
 arch/arm/kernel/sys_oabi-compat.c                 |  8 ++-
 arch/arm/lib/copy_from_user.S                     |  6 +-
 arch/arm/lib/copy_to_user.S                       |  6 +-
 arch/arm/lib/uaccess_with_memcpy.c                |  3 +-
 arch/arm/mach-integrator/impd1.c                  |  6 +-
 arch/arm/mach-omap2/omap-wakeupgen.c              | 36 +++++++++-
 arch/arm/mm/proc-macros.S                         | 10 +++
 arch/arm/mm/proc-v7-bugs.c                        | 17 +----
 arch/arm/vfp/vfpmodule.c                          | 20 +++---
 arch/riscv/include/asm/pgtable-bits.h             |  6 ++
 arch/riscv/include/asm/pgtable.h                  |  8 +--
 arch/riscv/kernel/ptrace.c                        |  2 +-
 arch/x86/events/core.c                            | 14 ++++
 arch/x86/events/intel/core.c                      |  9 +++
 arch/x86/events/perf_event.h                      | 16 ++++-
 arch/x86/ia32/ia32_aout.c                         |  6 +-
 arch/x86/include/asm/uv/bios.h                    |  8 ++-
 arch/x86/kvm/svm.c                                |  3 +
 arch/x86/kvm/vmx.c                                | 11 ++--
 arch/x86/platform/uv/bios_uv.c                    | 23 ++++++-
 block/blk-flush.c                                 |  2 +-
 drivers/acpi/numa.c                               |  6 +-
 drivers/cpufreq/cpufreq.c                         | 12 ++--
 drivers/firmware/efi/runtime-wrappers.c           |  7 ++
 drivers/gpio/gpio-mxc.c                           | 41 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  8 +--
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  3 +-
 drivers/gpu/drm/bridge/tc358767.c                 | 45 ++++++++++---
 drivers/gpu/drm/drm_lease.c                       |  3 +-
 drivers/gpu/drm/i915/i915_gem.c                   | 12 +++-
 drivers/gpu/drm/i915/intel_drv.h                  | 10 +++
 drivers/gpu/drm/i915/intel_fbdev.c                | 33 +++++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c      |  7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c  |  7 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                  |  8 +--
 drivers/gpu/drm/vkms/vkms_drv.c                   |  7 +-
 drivers/gpu/drm/vkms/vkms_drv.h                   |  2 +
 drivers/gpu/drm/vkms/vkms_gem.c                   |  8 +--
 drivers/gpu/drm/vkms/vkms_output.c                |  8 +--
 drivers/gpu/drm/vkms/vkms_plane.c                 |  8 +--
 drivers/input/misc/bma150.c                       |  9 +--
 drivers/input/mouse/elan_i2c_core.c               |  2 +-
 drivers/input/mouse/elantech.c                    |  9 +++
 drivers/md/dm-crypt.c                             |  2 +-
 drivers/md/dm-thin.c                              | 55 ++++++++++++++--
 drivers/md/raid1.c                                | 28 +++++---
 drivers/misc/eeprom/Kconfig                       |  2 +-
 drivers/misc/eeprom/at24.c                        |  3 +
 drivers/mmc/core/block.c                          | 10 ++-
 drivers/mmc/host/sunxi-mmc.c                      | 15 +++++
 drivers/nvme/host/core.c                          |  2 +-
 drivers/nvme/host/multipath.c                     |  2 +
 drivers/nvme/host/pci.c                           | 14 ++--
 drivers/s390/crypto/ap_bus.c                      |  3 +-
 drivers/scsi/sd.c                                 | 12 +++-
 fs/cifs/file.c                                    |  8 +++
 fs/cifs/smb2file.c                                |  4 ++
 fs/cifs/smb2pdu.c                                 | 15 +++--
 fs/inode.c                                        |  7 +-
 fs/nfsd/nfsctl.c                                  |  4 +-
 fs/proc/task_mmu.c                                | 22 ++++---
 include/linux/mmc/card.h                          |  1 +
 include/linux/perf_event.h                        |  5 ++
 kernel/events/core.c                              | 16 +++++
 kernel/events/ring_buffer.c                       |  2 +-
 kernel/signal.c                                   |  7 +-
 kernel/trace/trace_uprobe.c                       |  9 ++-
 mm/vmscan.c                                       | 10 ---
 sound/pci/hda/patch_conexant.c                    |  1 +
 sound/soc/codecs/hdmi-codec.c                     |  4 +-
 sound/usb/pcm.c                                   |  9 ++-
 tools/arch/riscv/include/uapi/asm/bitsperlong.h   | 25 +++++++
 tools/include/uapi/asm/bitsperlong.h              |  4 ++
 tools/perf/tests/shell/lib/probe_vfs_getname.sh   |  3 +-
 tools/perf/util/callchain.c                       | 32 +++++----
 tools/perf/util/callchain.h                       |  1 +
 tools/perf/util/machine.c                         |  2 +-
 97 files changed, 893 insertions(+), 317 deletions(-)



Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtTsyYDiD/047aE6CTK1agR2VWRfNB5UcMno3U6J3Cyn/lGKbq7GHSXpl8miFHinJHTNNIh
ARC-Seal: i=1; a=rsa-sha256; t=1521214213; cv=none;
        d=google.com; s=arc-20160816;
        b=0q5TQIZwyn6i7RBmKZ/Afofv/TvyufltfCF+8IA1RFO9bi1IzJ2CTyf8A2k9LiTrXJ
         vR6HKZrYGLLVkxpPGfCZ3SyMsryHg955URQzliqmPAfUxfXQyrI7uUU6YNpvK03taTgs
         5eS1uYih6181qTYXM1vM2CM+api2btvV5F4If1lDHf2/svcb5R+SMEWfnk/QseWbV6fn
         gxYlgWwB75MJFpjVblM+Lw5LKYaPka58v9n1NWh4XoIRTbOlwGlkbBINun3MiewCyNxC
         IO9SACWlH1yHuvcDu0vzJXbT/ZQwMJhuyJTjDqAds1xmprNUb3poyhs6TBx4rZJbLKTf
         Usfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=13b0vhh3up72VRztCIzuRF3Iam5kO0SiVL7ENFriPto=;
        b=uMwV667U4fVcrakJrGSbEYMapn721ZwWHq9RoBAaj+Ps8UVzzHG3STBoTggR258hkj
         oS4/6UnVctsmtlqR11OmMs3K61ttOrGT+jD5CPjB8ZfaeQfoJEvwg1vKj8aJLige553R
         kggl9NasowYeptn1beL9DZmd7hZG5iCNWfkfpaVDu7HiutxXSuC9kLIDLP5b/CCWa/gU
         XrC+5Dy244gOwem6h2N6F53+U7/oN/l9Bdp0/4xh5f1Ipc+DjsnqHbWyit9PHGzUscyw
         soj6NYbgxRIfTcbpiNbBRd8wIR4DIXe2tWNE05LVpSvBBtIIIlfz5QmsfYzZQqOCdZID
         pQyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.9 00/86] 4.9.88-stable review
Date: Fri, 16 Mar 2018 16:22:23 +0100
Message-Id: <20180316152317.167709497@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.88-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.88-rc1
X-KernelTest-Deadline: 2018-03-18T15:23+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108715713522943?=
X-GMAIL-MSGID: =?utf-8?q?1595108715713522943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.88 release.
There are 86 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 18 15:22:47 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.88-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.88-rc1

Koen Vandeputte <koen.vandeputte@ncentric.com>
    PCI: dwc: Fix enumeration end when reaching root subordinate

Greentime Hu <green.hu@gmail.com>
    earlycon: add reg-offset to physical address before mapping

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    serial: core: mark port as initialized in autoconfig

Nikola Ciprich <nikola.ciprich@linuxbox.cz>
    serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Xinyong <xinyong.fang@linux.alibaba.com>
    usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()

Pete Zaitcev <zaitcev@kotori.zaitcev.us>
    usb: usbmon: Read text within supplied buffer size

Danilo Krummrich <danilokrummrich@dk-develop.de>
    usb: quirks: add control message delay for 1b1c:1b20

Colin Ian King <colin.king@canonical.com>
    usbip: vudc: fix null pointer dereference on udc->lock

Teijo Kinnunen <teijo.kinnunen@code-q.fi>
    USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h

Joel Fernandes <joelaf@google.com>
    staging: android: ashmem: Fix lockdep issue during llseek

Frank Mori Hess <fmh6jj@gmail.com>
    staging: comedi: fix comedi_nsamples_left.

Oliver Neukum <oneukum@suse.com>
    uas: fix comparison for error code

Jonas Danielsson <jonas@orbital-systems.com>
    tty/serial: atmel: add new version check for usart

Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
    serial: sh-sci: prevent lockup on full TTY buffers

Hans de Goede <hdegoede@redhat.com>
    ASoC: rt5651: Fix regcache sync errors on resume

Fabio Estevam <fabio.estevam@nxp.com>
    ASoC: sgtl5000: Fix suspend/resume

H.J. Lu <hjl.tools@gmail.com>
    x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/module: Detect and skip invalid relocations

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Fix unstable write completion

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Fix an incorrect type in struct nfs_direct_req

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport

Clay McClure <clay@daemons.net>
    ubi: Fix race condition between ubi volume creation and udev

Tahsin Erdogan <tahsin@google.com>
    ext4: inplace xattr block update fails to deduplicate blocks

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: pack percpu counter allocations

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: pass xt_counters struct to counter allocator

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: pass xt_counters struct instead of packet counter

Florian Westphal <fw@strlen.de>
    netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt

Florian Westphal <fw@strlen.de>
    netfilter: bridge: ebt_among: add missing match size checks

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets

Eric Dumazet <edumazet@google.com>
    netfilter: IDLETIMER: be syzkaller friendly

Paolo Abeni <pabeni@redhat.com>
    netfilter: nat: cope with negative port range

Paolo Abeni <pabeni@redhat.com>
    netfilter: x_tables: fix missing timer initialization in xt_LED

Florian Westphal <fw@strlen.de>
    netfilter: add back stackpointer size checks

Philipp Zabel <p.zabel@pengutronix.de>
    tc358743: fix register i2c_rd/wr function fix

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: tca8418_keypad - remove double read of key event register

Arnd Bergmann <arnd@arndb.de>
    ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: Remove legacy NMI sourcing.

Arnd Bergmann <arnd@arndb.de>
    watchdog: hpwdt: fix unused variable warning

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: Check source of NMI

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: SMBIOS check

Peter Zijlstra <peterz@infradead.org>
    x86/paravirt, objtool: Annotate indirect calls

Ingo Molnar <mingo@kernel.org>
    x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP

Peter Zijlstra <peterz@infradead.org>
    x86/boot, objtool: Annotate indirect jump in secondary_startup_64()

Peter Zijlstra <peterz@infradead.org>
    x86/speculation, objtool: Annotate indirect calls/jumps for objtool

David Woodhouse <dwmw@amazon.co.uk>
    x86/retpoline: Support retpoline builds with Clang

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Use IBRS if available before calling into firmware

David Woodhouse <dwmw@amazon.co.uk>
    Revert "x86/retpoline: Simplify vmexit_fill_RSB()"

Dan Williams <dan.j.williams@intel.com>
    nospec: Include <asm/barrier.h> dependency

Dan Williams <dan.j.williams@intel.com>
    nospec: Kill array_index_nospec_mask_check()

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP ProBook 640 G2

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP EliteBook 820 G3

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: More protection for concurrent write and ioctl races

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Don't allow resizing pool in use

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda/realtek - Make dock sound work on ThinkPad L570

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520

Benjamin Berg <bberg@redhat.com>
    ALSA: hda/realtek: Limit mic boost on T480

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/spectre_v2: Don't check microcode versions when running under hypervisors

Adrian Hunter <adrian.hunter@intel.com>
    perf tools: Fix trigger class trigger_on()

Seunghun Han <kkamagui@gmail.com>
    x86/MCE: Serialize sysfs changes

Michael Lyle <mlyle@lyle.org>
    bcache: don't attach backing with duplicate UUID

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix crashes in duplicate cache device register

Sergey Gorenko <sergeygo@mellanox.com>
    IB/mlx5: Fix incorrect size of klms in the memory region

James Hogan <jhogan@kernel.org>
    kbuild: Handle builtin dtb file names containing hyphens

David Hildenbrand <david@redhat.com>
    KVM: s390: fix memory overwrites when not using SCA entries

Tiwei Bie <tiwei.bie@intel.com>
    virtio_ring: fix num_free handling in error case

Ross Zwisler <ross.zwisler@linux.intel.com>
    loop: Fix lost writes caused by missing flag

Zhang Bo <zbsdta@126.com>
    Input: matrix_keypad - fix race when disabling interrupts

Colin Ian King <colin.king@canonical.com>
    MIPS: OCTEON: irq: Check for null return on kzalloc allocation

Colin Ian King <colin.king@canonical.com>
    MIPS: ath25: Check for kzalloc allocation failure

Justin Chen <justinpopo6@gmail.com>
    MIPS: BMIPS: Do not mask IPIs during suspend

James Zhu <James.Zhu@amd.com>
    drm/amdgpu:Always save uvd vcpu_bo in VM Mode

James Zhu <James.Zhu@amd.com>
    drm/amdgpu:Correct max uvd handles

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: fix KV harvesting

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: fix KV harvesting

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Notify sbios device ready before send request

Lukas Wunner <lukas@wunner.de>
    drm/amdgpu: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm/radeon: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm/nouveau: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm: Allow determining if current task is output poll worker

Lukas Wunner <lukas@wunner.de>
    workqueue: Allow retrieval of current task's work struct

Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
    drm/i915: Always call to intel_display_set_init_power() in resume_early.

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS

Stefan Brüns <stefan.bruens@rwth-aachen.de>
    drm/i915: Try EDID bitbanging on HDMI after failed read

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Fix integer overflow while resizing CQ

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check that user doesn't overflow QP state

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Limit possible option size


-------------

Diffstat:

 Makefile                                       |   4 +-
 arch/arm/mach-omap2/omap-secure.c              |   2 +
 arch/mips/ath25/board.c                        |   2 +
 arch/mips/cavium-octeon/octeon-irq.c           |   2 +
 arch/mips/kernel/smp-bmips.c                   |   8 +-
 arch/s390/kvm/kvm-s390.c                       |   1 +
 arch/x86/Makefile                              |   5 +-
 arch/x86/entry/entry_32.S                      |   3 +-
 arch/x86/entry/entry_64.S                      |   3 +-
 arch/x86/include/asm/apm.h                     |   6 +
 arch/x86/include/asm/asm-prototypes.h          |   3 -
 arch/x86/include/asm/cpufeatures.h             |   1 +
 arch/x86/include/asm/efi.h                     |  17 +-
 arch/x86/include/asm/nospec-branch.h           | 138 ++++++-
 arch/x86/include/asm/paravirt.h                |  16 +-
 arch/x86/include/asm/paravirt_types.h          |   5 +-
 arch/x86/kernel/cpu/bugs.c                     |  12 +-
 arch/x86/kernel/cpu/intel.c                    |   7 +
 arch/x86/kernel/cpu/mcheck/mce.c               |  22 +-
 arch/x86/kernel/head_64.S                      |   2 +
 arch/x86/kernel/machine_kexec_64.c             |   1 +
 arch/x86/kernel/module.c                       |  14 +
 arch/x86/lib/Makefile                          |   1 -
 arch/x86/lib/retpoline.S                       |  56 ---
 arch/x86/tools/relocs.c                        |   3 +
 drivers/block/loop.c                           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |  58 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c        |  13 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          |  30 +-
 drivers/gpu/drm/drm_probe_helper.c             |  20 +
 drivers/gpu/drm/i915/i915_drv.c                |   2 +
 drivers/gpu/drm/i915/intel_hdmi.c              |  14 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c    |  18 +-
 drivers/gpu/drm/radeon/cik.c                   |  31 +-
 drivers/gpu/drm/radeon/radeon_connectors.c     |  74 ++--
 drivers/infiniband/core/ucma.c                 |   6 +
 drivers/infiniband/hw/mlx5/cq.c                |   7 +-
 drivers/infiniband/hw/mlx5/mr.c                |   2 +-
 drivers/input/keyboard/matrix_keypad.c         |   4 +-
 drivers/input/keyboard/tca8418_keypad.c        |   2 -
 drivers/md/bcache/super.c                      |  27 +-
 drivers/media/i2c/tc358743.c                   |   2 +-
 drivers/mtd/ubi/vmt.c                          |  15 +-
 drivers/pci/host/pcie-designware.c             |   2 +-
 drivers/scsi/qla2xxx/qla_init.c                |   1 +
 drivers/scsi/qla2xxx/qla_target.c              |   2 +-
 drivers/staging/android/ashmem.c               |  15 +-
 drivers/staging/comedi/drivers.c               |   3 +-
 drivers/tty/serial/8250/8250_pci.c             |  11 +
 drivers/tty/serial/atmel_serial.c              |   1 +
 drivers/tty/serial/earlycon.c                  |   3 +-
 drivers/tty/serial/serial_core.c               |   2 +
 drivers/tty/serial/sh-sci.c                    |   2 +
 drivers/usb/core/message.c                     |   4 +
 drivers/usb/core/quirks.c                      |   3 +-
 drivers/usb/gadget/function/f_fs.c             |   1 -
 drivers/usb/mon/mon_text.c                     | 126 +++---
 drivers/usb/storage/uas.c                      |   2 +-
 drivers/usb/storage/unusual_devs.h             |   7 +
 drivers/usb/usbip/vudc_sysfs.c                 |   8 +-
 drivers/virtio/virtio_ring.c                   |   2 -
 drivers/watchdog/hpwdt.c                       | 507 +------------------------
 fs/ext4/xattr.c                                |   3 +-
 fs/nfs/direct.c                                |   2 +-
 fs/nfs/write.c                                 |  83 ++--
 include/drm/drm_crtc_helper.h                  |   1 +
 include/linux/compiler-clang.h                 |   5 +
 include/linux/compiler-gcc.h                   |   4 +
 include/linux/init.h                           |   8 +-
 include/linux/netfilter/x_tables.h             |  38 +-
 include/linux/nospec.h                         |  23 +-
 include/linux/usb/quirks.h                     |   3 +
 include/linux/workqueue.h                      |   1 +
 kernel/workqueue.c                             |  16 +
 net/bridge/netfilter/ebt_among.c               |  21 +-
 net/bridge/netfilter/ebtables.c                |  13 +-
 net/ipv4/netfilter/arp_tables.c                |  20 +-
 net/ipv4/netfilter/ip_tables.c                 |  23 +-
 net/ipv6/netfilter/ip6_tables.c                |  21 +-
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c       |   4 +
 net/netfilter/nf_nat_proto_common.c            |   7 +-
 net/netfilter/x_tables.c                       |  55 +++
 net/netfilter/xt_IDLETIMER.c                   |   9 +-
 net/netfilter/xt_LED.c                         |  12 +-
 scripts/Makefile.lib                           |   8 +-
 sound/core/seq/seq_clientmgr.c                 |  21 +-
 sound/core/seq/seq_fifo.c                      |   2 +-
 sound/core/seq/seq_memory.c                    |  14 +-
 sound/core/seq/seq_memory.h                    |   3 +-
 sound/pci/hda/patch_conexant.c                 |   2 +
 sound/pci/hda/patch_realtek.c                  |  18 +
 sound/soc/codecs/rt5651.c                      |   1 +
 sound/soc/codecs/sgtl5000.c                    |  11 +
 tools/perf/util/trigger.h                      |   9 +-
 95 files changed, 876 insertions(+), 951 deletions(-)

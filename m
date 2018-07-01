Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C937C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2E825B65
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2E825B65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbeGASrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:47:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbeGAQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:11:40 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E090BACD;
        Sun,  1 Jul 2018 16:11:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/85] 3.18.114-stable review
Date:   Sun,  1 Jul 2018 18:01:18 +0200
Message-Id: <20180701153122.365061142@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.114-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.114-rc1
X-KernelTest-Deadline: 2018-07-03T15:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.114 release.
There are 85 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Jul  3 15:31:04 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.114-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.114-rc1

Mike Snitzer <snitzer@redhat.com>
    dm thin: handle running out of data space vs concurrent discard

Keith Busch <keith.busch@intel.com>
    block: Fix transfer when chunk sectors exceeds max

Jan Kara <jack@suse.cz>
    udf: Detect incorrect directory size

Boris Ostrovsky <boris.ostrovsky@oracle.com>
    xen: Remove unnecessary BUG_ON from __unbind_from_irq()

Kees Cook <keescook@chromium.org>
    video: uvesafb: Fix integer overflow in allocation

Scott Mayhew <smayhew@redhat.com>
    nfsd: restrict rd_maxcount to svc_max_payload in nfsd_encode_readdir

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: dvb_frontend: fix locking issues at dvb_frontend_get_event()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    media: cx231xx: Add support for AverMedia DVD EZMaker 7

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: v4l2-compat-ioctl32: prevent go past max size

Johan Hovold <johan@kernel.org>
    backlight: tps65217_bl: Fix Device Tree node lookup

Johan Hovold <johan@kernel.org>
    backlight: max8925_bl: Fix Device Tree node lookup

Johan Hovold <johan@kernel.org>
    backlight: as3711_bl: Fix Device Tree node lookup

Silvio Cesare <silvio.cesare@gmail.com>
    UBIFS: Fix potential integer overflow in allocation

Himanshu Madhani <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix setting lower transfer speed if GPSC fails

Geert Uytterhoeven <geert@linux-m68k.org>
    time: Make sure jiffies_to_msecs() preserves non-zero time periods

Huacai Chen <chenhc@lemote.com>
    MIPS: io: Add barrier after register read in inX()

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume

Tokunori Ikegami <ikegami@allied-telesis.co.jp>
    MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum

Joakim Tjernlund <joakim.tjernlund@infinera.com>
    mtd: cfi_cmdset_0002: Avoid walking all chips when unlocking.

Joakim Tjernlund <joakim.tjernlund@infinera.com>
    mtd: cfi_cmdset_0002: Fix unlocking requests crossing a chip boudary

Joakim Tjernlund <joakim.tjernlund@infinera.com>
    mtd: cfi_cmdset_0002: fix SEGV unlocking multiple chips

Joakim Tjernlund <joakim.tjernlund@infinera.com>
    mtd: cfi_cmdset_0002: Use right chip in do_ppb_xxlock()

Tokunori Ikegami <ikegami@allied-telesis.co.jp>
    mtd: cfi_cmdset_0002: Change write buffer to check correct value

David Rivshin <DRivshin@allworx.com>
    ARM: 8764/1: kgdb: fix NUMREGBYTES so that gdb_regs[] is the correct size

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/fadump: Unregister fadump on kexec down path.

Michael Neuling <mikey@neuling.org>
    powerpc/ptrace: Fix enforcement of DAWR constraints

Michael Neuling <mikey@neuling.org>
    powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_DEBUGREG

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/mm/hash: Add missing isync prior to kernel stack SLB switch

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fuse: don't keep dead fuse_conn at fuse_fill_super().

Miklos Szeredi <mszeredi@redhat.com>
    fuse: atomic_o_trunc should truncate pagecache

Corey Minyard <cminyard@mvista.com>
    ipmi:bt: Set the timeout before doing a capabilities check

Mikulas Patocka <mpatocka@redhat.com>
    branch-check: fix long->int truncation when profiling branches

Matthias Schiffer <mschiffer@universe-factory.net>
    mips: ftrace: fix static function graph tracing

Alexander Sverdlin <alexander.sverdlin@gmail.com>
    ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup

Alexander Sverdlin <alexander.sverdlin@gmail.com>
    ASoC: cirrus: i2s: Fix LRCLK configuration

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it

Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
    usb: do not reset if a low-speed or full-speed device timed out

Eric W. Biederman <ebiederm@xmission.com>
    signal/xtensa: Consistenly use SIGBUS in do_unaligned_user

Michael Schmitz <schmitzmic@gmail.com>
    m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    fs/binfmt_misc.c: do not allow offset overflow

Stefan Potyra <Stefan.Potyra@elektrobit.com>
    w1: mxc_w1: Enable clock before calling clk_get_rate() on it

Hans de Goede <hdegoede@redhat.com>
    libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk

Dan Carpenter <dan.carpenter@oracle.com>
    libata: zpodd: small read overflow in eject_tray()

Colin Ian King <colin.king@canonical.com>
    libata: zpodd: make arrays cdb static, reduces object code size

Bo Chen <chenbo@pdx.edu>
    ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: Don't use inode pages for device replace

Jan Kara <jack@suse.cz>
    ext4: fix fencepost error in check for inode count overflow during resize

Lukas Czerner <lczerner@redhat.com>
    ext4: update mtime in ext4_punch_hole even if no blocks are released

Eric Dumazet <edumazet@google.com>
    tcp: do not overshoot window_clamp in tcp_rcv_space_adjust()

Łukasz Stelmach <l.stelmach@samsung.com>
    ARM: 8753/1: decompressor: add a missing parameter to the addruart macro

Helge Deller <deller@gmx.de>
    parisc: Move setup_profiling_timer() out of init section

Sekhar Nori <nsekhar@ti.com>
    ARM: davinci: board-dm646x-evm: set VPIF capture card name

Peter Rosin <peda@axentia.se>
    i2c: viperboard: return message count on master_xfer success

Peter Rosin <peda@axentia.se>
    i2c: pmcmsp: fix error return from master_xfer

Peter Rosin <peda@axentia.se>
    i2c: pmcmsp: return message count on master_xfer success

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: keystone: fix platform_domain_notifier array overrun

Daniel Glöckner <dg@emlix.com>
    usb: musb: fix remote wakeup racing with suspend

Mathieu Malaterre <malat@debian.org>
    agp: uninorth: make two functions static

Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
    can: dev: increase bus-off message severity

Mathieu Malaterre <malat@debian.org>
    driver core: add __printf verification to __ata_ehi_pushv_desc

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/omap: fix possible NULL ref issue in tiler_reserve_2d

Ilan Peer <ilan.peer@intel.com>
    mac80211: Adjust SAE authentication timeout

Peter Zijlstra <peterz@infradead.org>
    kthread, sched/wait: Fix kthread_parkme() wait-loop

Helge Deller <deller@gmx.de>
    parisc: drivers.c: Fix section mismatches

Jim Gill <jgill@vmware.com>
    scsi: vmw-pvscsi: return DID_BUS_BUSY for adapter-initated aborts

Arnd Bergmann <arnd@arndb.de>
    hexagon: export csum_partial_copy_nocheck

Arnd Bergmann <arnd@arndb.de>
    hexagon: add memset_io() helper

Sekhar Nori <nsekhar@ti.com>
    ARM: davinci: board-dm355-evm: fix broken networking

John Fastabend <john.fastabend@gmail.com>
    bpf: fix uninitialized variable in bpf tools

jacek.tomaka@poczta.fm <jacek.tomaka@poczta.fm>
    x86/cpu/intel: Add missing TLB cpuid values

Dag Moxnes <dag.moxnes@oracle.com>
    rds: ib: Fix missing call to rds_ib_dev_put in rds_ib_setup_qp

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add a testcase for multiple actions on trigger

Mark Rutland <mark.rutland@arm.com>
    arm64: ptrace: remove addr_limit manipulation

Jingju Hou <Jingju.Hou@synaptics.com>
    net: phy: marvell: clear wol event before setting it

Colin Ian King <colin.king@canonical.com>
    scsi: isci: Fix infinite loop in while loop

Baolin Wang <baolin.wang@linaro.org>
    parisc: time: Convert read_persistent_clock() to read_persistent_clock64()

Ben Hutchings <ben.hutchings@codethink.co.uk>
    drm/msm: Fix possible null dereference on failure of get_pages()

Chris Leech <cleech@redhat.com>
    scsi: iscsi: respond to netlink with unicast when appropriate

Chengguang Xu <cgxu519@gmx.com>
    isofs: fix potential memory leak in mount option parsing

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/smsgiucv: disable SMSG on module unload

Sinan Kaya <okaya@codeaurora.org>
    MIPS: io: Add barrier after register read in readX()

Amir Goldstein <amir73il@gmail.com>
    fsnotify: fix ignore mask logic in send_to_group()

Kevin Easton <kevin@guarana.org>
    af_key: Always verify length of provided sadb_key

Jiri Olsa <jolsa@kernel.org>
    tools build: Fix Makefile(s) to properly invoke tools build

Jiri Olsa <jolsa@kernel.org>
    tools build: No need to make libapi for perf explicitly


-------------

Diffstat:

 Makefile                                           |  9 ++---
 arch/arm/boot/compressed/head.S                    | 16 ++++----
 arch/arm/include/asm/kgdb.h                        |  2 +-
 arch/arm/mach-davinci/board-dm355-evm.c            |  6 +++
 arch/arm/mach-davinci/board-dm646x-evm.c           |  3 +-
 arch/arm/mach-keystone/pm_domain.c                 |  1 +
 arch/arm64/kernel/ptrace.c                         |  6 ---
 arch/hexagon/include/asm/io.h                      |  6 +++
 arch/hexagon/lib/checksum.c                        |  1 +
 arch/m68k/mm/kmap.c                                |  3 +-
 arch/mips/bcm47xx/setup.c                          |  6 +++
 arch/mips/include/asm/io.h                         |  4 ++
 arch/mips/include/asm/mipsregs.h                   |  3 ++
 arch/mips/kernel/mcount.S                          | 27 ++++++-------
 arch/parisc/kernel/drivers.c                       |  7 ++--
 arch/parisc/kernel/smp.c                           |  3 +-
 arch/parisc/kernel/time.c                          |  2 +-
 arch/powerpc/kernel/entry_64.S                     |  1 +
 arch/powerpc/kernel/fadump.c                       |  3 ++
 arch/powerpc/kernel/hw_breakpoint.c                |  4 +-
 arch/powerpc/kernel/ptrace.c                       |  1 +
 arch/x86/kernel/cpu/intel.c                        |  3 ++
 arch/xtensa/kernel/traps.c                         |  2 +-
 drivers/ata/libata-core.c                          |  3 --
 drivers/ata/libata-eh.c                            |  4 +-
 drivers/ata/libata-zpodd.c                         |  4 +-
 drivers/char/agp/uninorth-agp.c                    |  4 +-
 drivers/char/ipmi/ipmi_bt_sm.c                     |  3 +-
 drivers/gpu/drm/msm/msm_gem.c                      | 20 +++++-----
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |  6 ++-
 drivers/i2c/busses/i2c-pmcmsp.c                    |  4 +-
 drivers/i2c/busses/i2c-viperboard.c                |  2 +-
 drivers/md/dm-thin.c                               | 11 +++++-
 drivers/media/dvb-core/dvb_frontend.c              | 23 +++++++----
 drivers/media/usb/cx231xx/cx231xx-cards.c          |  3 ++
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |  2 +-
 drivers/mtd/chips/cfi_cmdset_0002.c                | 21 +++++-----
 drivers/net/can/dev.c                              |  2 +-
 drivers/net/phy/marvell.c                          |  9 +++++
 drivers/pci/hotplug/pciehp.h                       |  2 +-
 drivers/pci/hotplug/pciehp_core.c                  |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   | 13 ++++++-
 drivers/s390/net/smsgiucv.c                        |  2 +-
 drivers/scsi/isci/port_config.c                    |  3 +-
 drivers/scsi/qla2xxx/qla_init.c                    |  3 +-
 drivers/scsi/scsi_transport_iscsi.c                | 29 ++++++++------
 drivers/scsi/vmw_pvscsi.c                          |  2 +-
 drivers/usb/core/hub.c                             |  4 +-
 drivers/usb/musb/musb_host.c                       |  5 ++-
 drivers/usb/musb/musb_host.h                       |  7 +++-
 drivers/usb/musb/musb_virthub.c                    | 25 +++++++-----
 drivers/video/backlight/as3711_bl.c                | 33 +++++++++++-----
 drivers/video/backlight/max8925_bl.c               |  4 +-
 drivers/video/backlight/tps65217_bl.c              |  4 +-
 drivers/video/fbdev/uvesafb.c                      |  3 +-
 drivers/w1/masters/mxc_w1.c                        | 20 ++++++----
 drivers/xen/events/events_base.c                   |  2 -
 fs/binfmt_misc.c                                   | 12 ++++--
 fs/btrfs/scrub.c                                   |  2 +-
 fs/ext4/inode.c                                    | 36 ++++++++---------
 fs/ext4/resize.c                                   |  2 +-
 fs/fuse/dir.c                                      | 13 ++++++-
 fs/fuse/inode.c                                    |  1 +
 fs/isofs/inode.c                                   |  3 ++
 fs/nfsd/nfs4xdr.c                                  |  5 ++-
 fs/notify/fsnotify.c                               | 25 ++++++------
 fs/ubifs/journal.c                                 |  2 +-
 fs/udf/directory.c                                 |  3 ++
 include/linux/blkdev.h                             |  4 +-
 include/linux/compiler.h                           |  2 +-
 kernel/kthread.c                                   |  7 ++--
 kernel/time/time.c                                 |  6 ++-
 net/ipv4/tcp_input.c                               |  2 +-
 net/key/af_key.c                                   | 45 +++++++++++++++++-----
 net/mac80211/mlme.c                                | 25 ++++++++----
 net/rds/ib_cm.c                                    |  3 +-
 sound/pci/hda/hda_controller.c                     |  4 +-
 sound/soc/cirrus/edb93xx.c                         |  2 +-
 sound/soc/cirrus/ep93xx-i2s.c                      | 26 +++++++------
 sound/soc/cirrus/snappercl15.c                     |  2 +-
 sound/soc/soc-dapm.c                               |  2 +
 tools/Makefile                                     | 20 +++++++---
 tools/net/bpf_dbg.c                                |  7 +++-
 .../inter-event/trigger-multi-actions-accept.tc    | 44 +++++++++++++++++++++
 84 files changed, 472 insertions(+), 236 deletions(-)



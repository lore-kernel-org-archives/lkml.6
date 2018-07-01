Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A920CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4975C250B5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4975C250B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeGAQQx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:16:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeGAQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:16:46 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4BAFA92B;
        Sun,  1 Jul 2018 16:16:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/105] 4.4.139-stable review
Date:   Sun,  1 Jul 2018 18:01:10 +0200
Message-Id: <20180701153149.382300170@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.139-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.139-rc1
X-KernelTest-Deadline: 2018-07-03T15:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.139 release.
There are 105 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Jul  3 15:31:30 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.139-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.139-rc1

Szymon Janc <szymon.janc@codecoup.pl>
    Bluetooth: Fix connection if directed advertising and privacy is used

Bjørn Mork <bjorn@mork.no>
    cdc_ncm: avoid padding beyond end of skb

Mike Snitzer <snitzer@redhat.com>
    dm thin: handle running out of data space vs concurrent discard

Keith Busch <keith.busch@intel.com>
    block: Fix transfer when chunk sectors exceeds max

Maxime Chevallier <maxime.chevallier@bootlin.com>
    spi: Fix scatterlist elements size in spi_map_buf

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix unexpected cow in run_delalloc_nocow

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Add a quirk for FSC ESPRIMO U9210

??? <kt.liao@emc.com.tw>
    Input: elantech - fix V4 report decoding for module with middle key

Aaron Ma <aaron.ma@canonical.com>
    Input: elantech - enable middle button of touchpads on ThinkPad P52

Ben Hutchings <ben.hutchings@codethink.co.uk>
    Input: elan_i2c_smbus - fix more potential stack buffer overflows

Jan Kara <jack@suse.cz>
    udf: Detect incorrect directory size

Boris Ostrovsky <boris.ostrovsky@oracle.com>
    xen: Remove unnecessary BUG_ON from __unbind_from_irq()

Alexandr Savca <alexandr.savca@saltedge.com>
    Input: elan_i2c - add ELAN0618 (Lenovo v330 15IKB) ACPI ID

Kees Cook <keescook@chromium.org>
    video: uvesafb: Fix integer overflow in allocation

Dave Wysochanski <dwysocha@redhat.com>
    NFSv4: Fix possible 1-byte stack overflow in nfs_idmap_read_and_verify_message

Scott Mayhew <smayhew@redhat.com>
    nfsd: restrict rd_maxcount to svc_max_payload in nfsd_encode_readdir

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: dvb_frontend: fix locking issues at dvb_frontend_get_event()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    media: cx231xx: Add support for AverMedia DVD EZMaker 7

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: v4l2-compat-ioctl32: prevent go past max size

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix packet decoding of CYC packets

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix "Unexpected indirect branch" error

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix MTC timing after overflow

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix decoding to accept CBR between FUP and corresponding TIP

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING

Adrian Hunter <adrian.hunter@intel.com>
    perf tools: Fix symbol and object code resolution for vdso32 and vdsox32

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    mfd: intel-lpss: Program REMAP register in PIO mode

Johan Hovold <johan@kernel.org>
    backlight: tps65217_bl: Fix Device Tree node lookup

Johan Hovold <johan@kernel.org>
    backlight: max8925_bl: Fix Device Tree node lookup

Johan Hovold <johan@kernel.org>
    backlight: as3711_bl: Fix Device Tree node lookup

Florian Westphal <fw@strlen.de>
    xfrm: skip policies marked as dead while rehashing

Tobias Brunner <tobias@strongswan.org>
    xfrm: Ignore socket policies when rebuilding hash tables

Silvio Cesare <silvio.cesare@gmail.com>
    UBIFS: Fix potential integer overflow in allocation

Richard Weinberger <richard@nod.at>
    ubi: fastmap: Cancel work upon detach

NeilBrown <neilb@suse.com>
    md: fix two problems with setting the "re-add" device state.

Robert Elliott <elliott@hpe.com>
    linvdimm, pmem: Preserve read-only setting for pmem devices

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing REC trigger trace on enqueue without ERP thread

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing REC trigger trace for all objects in ERP_FAILED

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing REC trigger trace on terminate_rport_io for ERP_FAILED

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing REC trigger trace on terminate_rport_io early return

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix misleading REC trigger trace where erp_action setup failed

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing SCSI trace for retry of abort / scsi_eh TMF

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing SCSI trace for result of eh_host_reset_handler

Himanshu Madhani <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix setting lower transfer speed if GPSC fails

Martin Kelly <mkelly@xevo.com>
    iio:buffer: make length types match kfifo types

Omar Sandoval <osandov@fb.com>
    Btrfs: fix clone vs chattr NODATASUM race

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

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx4: Discard unknown SQP work requests

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/qib: Fix DMA api warning with debug kernel

Stefan M Schaeckeler <sschaeck@cisco.com>
    of: unittest: for strings, account for trailing \0 in property length field

David Rivshin <DRivshin@allworx.com>
    ARM: 8764/1: kgdb: fix NUMREGBYTES so that gdb_regs[] is the correct size

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/fadump: Unregister fadump on kexec down path.

Gautham R. Shenoy <ego@linux.vnet.ibm.com>
    cpuidle: powernv: Fix promotion from snooze if next state disabled

Michael Neuling <mikey@neuling.org>
    powerpc/ptrace: Fix enforcement of DAWR constraints

Michael Neuling <mikey@neuling.org>
    powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_DEBUGREG

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/mm/hash: Add missing isync prior to kernel stack SLB switch

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix control dir setup and teardown

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fuse: don't keep dead fuse_conn at fuse_fill_super().

Miklos Szeredi <mszeredi@redhat.com>
    fuse: atomic_o_trunc should truncate pagecache

Amit Pundir <amit.pundir@linaro.org>
    Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw loader

Corey Minyard <cminyard@mvista.com>
    ipmi:bt: Set the timeout before doing a capabilities check

Mikulas Patocka <mpatocka@redhat.com>
    branch-check: fix long->int truncation when profiling branches

Matthias Schiffer <mschiffer@universe-factory.net>
    mips: ftrace: fix static function graph tracing

Geert Uytterhoeven <geert+renesas@glider.be>
    lib/vsprintf: Remove atomic-unsafe support for %pCr

Alexander Sverdlin <alexander.sverdlin@gmail.com>
    ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup

Alexander Sverdlin <alexander.sverdlin@gmail.com>
    ASoC: cirrus: i2s: Fix LRCLK configuration

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it

Ingo Flaschberger <ingo.flaschberger@gmail.com>
    1wire: family module autoload fails because of upper/lower case mismatch.

Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
    usb: do not reset if a low-speed or full-speed device timed out

Eric W. Biederman <ebiederm@xmission.com>
    signal/xtensa: Consistenly use SIGBUS in do_unaligned_user

Daniel Wagner <daniel.wagner@siemens.com>
    serial: sh-sci: Use spin_{try}lock_irqsave instead of open coding version

Michael Schmitz <schmitzmic@gmail.com>
    m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()

Dan Williams <dan.j.williams@intel.com>
    x86/spectre_v1: Disable compiler optimizations over array_index_mask_nospec()

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

Tao Wang <kevin.wangtao@hisilicon.com>
    cpufreq: Fix new policy initialization during limits updates via sysfs

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP ProBook 640 G4

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP EliteBook 830 G5

Bo Chen <chenbo@pdx.edu>
    ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: Don't use inode pages for device replace

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    driver core: Don't ignore class_dir_create_and_add() failure.

Jan Kara <jack@suse.cz>
    ext4: fix fencepost error in check for inode count overflow during resize

Lukas Czerner <lczerner@redhat.com>
    ext4: update mtime in ext4_punch_hole even if no blocks are released

Frank van der Linden <fllinden@amazon.com>
    tcp: verify the checksum of the first data segment in a new connection

Xiangning Yu <yuxiangning@gmail.com>
    bonding: re-evaluate force_primary when the primary slave name changes

Daniel Glöckner <dg@emlix.com>
    usb: musb: fix remote wakeup racing with suspend

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: make raid6 rebuild retry more

Eric Dumazet <edumazet@google.com>
    tcp: do not overshoot window_clamp in tcp_rcv_space_adjust()

Sasha Levin <Alexander.Levin@microsoft.com>
    Revert "Btrfs: fix scrub to repair raid6 corruption"

Finn Thain <fthain@telegraphics.com.au>
    net/sonic: Use dma_mapping_error()

Josh Hill <josh@joshuajhill.com>
    net: qmi_wwan: Add Netgear Aircard 779S

Ivan Bornyakov <brnkv.i1@gmail.com>
    atm: zatm: fix memcmp casting

Julian Anastasov <ja@ssi.bg>
    ipvs: fix buffer overflow with sync daemon and service

Paolo Abeni <pabeni@redhat.com>
    netfilter: ebtables: handle string from userspace with care

Eric Dumazet <edumazet@google.com>
    xfrm6: avoid potential infinite loop in _decode_session6()


-------------

Diffstat:

 Documentation/printk-formats.txt                   |   3 +-
 Makefile                                           |   4 +-
 arch/arm/include/asm/kgdb.h                        |   2 +-
 arch/m68k/mm/kmap.c                                |   3 +-
 arch/mips/bcm47xx/setup.c                          |   6 +
 arch/mips/include/asm/io.h                         |   2 +
 arch/mips/include/asm/mipsregs.h                   |   3 +
 arch/mips/kernel/mcount.S                          |  27 ++---
 arch/powerpc/kernel/entry_64.S                     |   1 +
 arch/powerpc/kernel/fadump.c                       |   3 +
 arch/powerpc/kernel/hw_breakpoint.c                |   4 +-
 arch/powerpc/kernel/ptrace.c                       |   1 +
 arch/x86/include/asm/barrier.h                     |   2 +-
 arch/xtensa/kernel/traps.c                         |   2 +-
 drivers/ata/libata-core.c                          |   3 -
 drivers/ata/libata-zpodd.c                         |   4 +-
 drivers/atm/zatm.c                                 |   4 +-
 drivers/base/core.c                                |  14 ++-
 drivers/bluetooth/hci_qca.c                        |   6 +
 drivers/char/ipmi/ipmi_bt_sm.c                     |   3 +-
 drivers/cpufreq/cpufreq.c                          |   2 +
 drivers/cpuidle/cpuidle-powernv.c                  |  32 +++++-
 drivers/iio/buffer/kfifo_buf.c                     |   4 +-
 drivers/infiniband/hw/mlx4/mad.c                   |   1 -
 drivers/infiniband/hw/qib/qib.h                    |   3 +-
 drivers/infiniband/hw/qib/qib_file_ops.c           |  10 +-
 drivers/infiniband/hw/qib/qib_user_pages.c         |  20 ++--
 drivers/input/mouse/elan_i2c.h                     |   2 +
 drivers/input/mouse/elan_i2c_core.c                |   3 +-
 drivers/input/mouse/elan_i2c_smbus.c               |  10 +-
 drivers/input/mouse/elantech.c                     |  11 +-
 drivers/md/dm-thin.c                               |  11 +-
 drivers/md/md.c                                    |   4 +-
 drivers/media/dvb-core/dvb_frontend.c              |  23 ++--
 drivers/media/usb/cx231xx/cx231xx-cards.c          |   3 +
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |   2 +-
 drivers/mfd/intel-lpss.c                           |   4 +-
 drivers/mtd/chips/cfi_cmdset_0002.c                |  21 ++--
 drivers/mtd/ubi/build.c                            |   3 +
 drivers/mtd/ubi/wl.c                               |   4 +-
 drivers/net/bonding/bond_options.c                 |   1 +
 drivers/net/ethernet/natsemi/sonic.c               |   2 +-
 drivers/net/usb/cdc_ncm.c                          |   4 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/nvdimm/bus.c                               |  14 ++-
 drivers/of/unittest.c                              |   8 +-
 drivers/pci/hotplug/pciehp.h                       |   2 +-
 drivers/pci/hotplug/pciehp_core.c                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  13 ++-
 drivers/s390/scsi/zfcp_dbf.c                       |  40 +++++++
 drivers/s390/scsi/zfcp_erp.c                       | 123 ++++++++++++++++-----
 drivers/s390/scsi/zfcp_ext.h                       |   5 +
 drivers/s390/scsi/zfcp_scsi.c                      |  18 ++-
 drivers/scsi/qla2xxx/qla_init.c                    |   3 +-
 drivers/spi/spi.c                                  |  10 +-
 drivers/tty/serial/sh-sci.c                        |   8 +-
 drivers/usb/core/hub.c                             |   4 +-
 drivers/usb/musb/musb_host.c                       |   5 +-
 drivers/usb/musb/musb_host.h                       |   7 +-
 drivers/usb/musb/musb_virthub.c                    |  25 +++--
 drivers/video/backlight/as3711_bl.c                |  33 ++++--
 drivers/video/backlight/max8925_bl.c               |   4 +-
 drivers/video/backlight/tps65217_bl.c              |   4 +-
 drivers/video/fbdev/uvesafb.c                      |   3 +-
 drivers/w1/masters/mxc_w1.c                        |  20 ++--
 drivers/w1/w1.c                                    |   2 +-
 drivers/xen/events/events_base.c                   |   2 -
 fs/binfmt_misc.c                                   |  12 +-
 fs/btrfs/inode.c                                   |  33 +++++-
 fs/btrfs/ioctl.c                                   |  12 +-
 fs/btrfs/scrub.c                                   |   2 +-
 fs/ext4/inode.c                                    |  36 +++---
 fs/ext4/resize.c                                   |   2 +-
 fs/fuse/control.c                                  |  13 ++-
 fs/fuse/dir.c                                      |  13 ++-
 fs/fuse/inode.c                                    |   1 +
 fs/nfs/nfs4idmap.c                                 |   5 +-
 fs/nfsd/nfs4xdr.c                                  |   5 +-
 fs/ubifs/journal.c                                 |   2 +-
 fs/udf/directory.c                                 |   3 +
 include/linux/blkdev.h                             |   4 +-
 include/linux/compiler.h                           |   2 +-
 include/linux/iio/buffer.h                         |   6 +-
 include/net/bluetooth/hci_core.h                   |   2 +-
 kernel/time/time.c                                 |   6 +-
 lib/vsprintf.c                                     |   3 -
 net/bluetooth/hci_conn.c                           |  27 +++--
 net/bluetooth/hci_event.c                          |  15 ++-
 net/bridge/netfilter/ebtables.c                    |   3 +-
 net/ipv4/tcp_input.c                               |   2 +-
 net/ipv4/tcp_ipv4.c                                |   4 +
 net/ipv6/tcp_ipv6.c                                |   4 +
 net/ipv6/xfrm6_policy.c                            |   2 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  21 +++-
 net/xfrm/xfrm_policy.c                             |   5 +
 sound/pci/hda/hda_controller.c                     |   4 +-
 sound/pci/hda/patch_conexant.c                     |   2 +
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/cirrus/edb93xx.c                         |   2 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |  26 +++--
 sound/soc/cirrus/snappercl15.c                     |   2 +-
 sound/soc/soc-dapm.c                               |   2 +
 tools/perf/util/dso.c                              |   2 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  23 +++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   9 ++
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |   2 +-
 tools/perf/util/intel-pt.c                         |   5 +
 107 files changed, 685 insertions(+), 273 deletions(-)



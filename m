Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E4AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD8D208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD8D208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeIXRjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:39:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50440 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeIXRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:39:51 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11450106D;
        Mon, 24 Sep 2018 11:38:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 000/105] 3.18.123-stable review
Date:   Mon, 24 Sep 2018 13:32:46 +0200
Message-Id: <20180924113113.268650190@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.123-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.123-rc1
X-KernelTest-Deadline: 2018-09-26T11:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.123 release.
There are 105 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Sep 26 11:30:30 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.123-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.123-rc1

Johan Hovold <johan@kernel.org>
    USB: serial: ti_usb_3410_5052: fix array underflow in completion handler

Bart Van Assche <bart.vanassche@wdc.com>
    IB/nes: Fix a compiler warning

Dan Carpenter <dan.carpenter@oracle.com>
    drm/panel: type promotion bug in s6e8aa0_read_mtp_id()

Timo Wischer <twischer@de.adit-jv.com>
    ALSA: pcm: Fix snd_interval_refine first/last with open min/max

Zhouyang Jia <jiazhouyang09@gmail.com>
    rtc: bq4802: add error handling for devm_ioremap

Julia Lawall <Julia.Lawall@lip6.fr>
    parport: sunbpp: fix error return code

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: check of_iomap and fix missing of_node_put

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: handle of_iomap and fix missing of_node_put

Paul Burton <paul.burton@mips.com>
    MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads

Jann Horn <jannh@google.com>
    mtdchar: fix overflows in adjustment of `count`

Ronny Chevalier <ronny.chevalier@hp.com>
    audit: fix use-after-free in audit_add_watch

Maciej W. Rozycki <macro@mips.com>
    binfmt_elf: Respect error return from `regset->active'

Dan Carpenter <dan.carpenter@oracle.com>
    CIFS: fix wrapping bugs in num_entries()

Dan Carpenter <dan.carpenter@oracle.com>
    cifs: prevent integer overflow in nxt_dir_entry()

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()

Ben Hutchings <ben.hutchings@codethink.co.uk>
    USB: yurex: Fix buffer over-read in yurex_write()

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: misc: uss720: Fix two sleep-in-atomic-context bugs

Johan Hovold <johan@kernel.org>
    USB: serial: io_ti: fix array underflow in completion handler

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_frame()

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: Avoid use-after-free by flushing endpoints early in usb_set_interface()

Tim Anderson <tsa@biglakesoftware.com>
    USB: Add quirk to support DJI CineSSD

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: Don't die twice if PCI xhci host is not responding in resume

K. Y. Srinivasan <kys@microsoft.com>
    Tools: hv: Fix a bug in the key delete code

Aaron Knister <aaron.s.knister@nasa.gov>
    IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler

Juergen Gross <jgross@suse.com>
    xen/netfront: fix waiting for xenbus state change

Bin Yang <bin.yang@intel.com>
    pstore: Fix incorrect persistent ram buffer mapping

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Protect cma dev list with lock

Randy Dunlap <rdunlap@infradead.org>
    platform/x86: toshiba_acpi: Fix defined but not used build warnings

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: reset layer2 attribute on layer switch

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix race in used-buffer accounting

Manikanta Pubbisetty <mpubbise@codeaurora.org>
    mac80211: restrict delayed tailroom needed decrement

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: opal_put_chars partial write fix

Sandipan Das <sandipan@linux.ibm.com>
    perf powerpc: Fix callchain ip filtering

Fredrik Noring <noring@nocrew.org>
    fbdev: Distinguish between interlaced and progressive modes

Sandipan Das <sandipan@linux.ibm.com>
    perf powerpc: Fix callchain ip filtering when return address is in a register

Randy Dunlap <rdunlap@infradead.org>
    fbdev/via: fix defined but not used warning

Anton Vasilyev <vasilyev@ispras.ru>
    video: goldfishfb: fix memory leak on driver remove

Dan Carpenter <dan.carpenter@oracle.com>
    fbdev: omapfb: off by one in omapfb_register_client()

Randy Dunlap <rdunlap@infradead.org>
    mtd/maps: fix solutionengine.c printk format warnings

Felix Fietkau <nbd@nbd.name>
    MIPS: ath79: fix system restart

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Special-case rindex for gfs2_grow

YueHaibing <yuehaibing@huawei.com>
    xfrm: fix 'passing zero to ERR_PTR()' warning

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Fix multiple definitions in AU0828_DEVICE() macro

Takashi Iwai <tiwai@suse.de>
    ALSA: msnd: Fix the default sample sizes

Linus Torvalds <torvalds@linux-foundation.org>
    mm: get rid of vmacache_flush_all() entirely

Eric Dumazet <edumazet@google.com>
    netfilter: x_tables: avoid stack-out-of-bounds read in xt_copy_counters_from_user

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix use-after-free in xhci_free_virt_device

Paul Burton <paul.burton@imgtec.com>
    MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize

Zumeng Chen <zumeng.chen@gmail.com>
    mfd: ti_am335x_tscadc: Fix struct clk memory leak

Mauricio Faria de Oliveira <mfo@canonical.com>
    partitions/aix: fix usage of uninitialized lv_info and lvname structures

Mauricio Faria de Oliveira <mfo@canonical.com>
    partitions/aix: append null character to print data from disk

Petr Machata <petrm@mellanox.com>
    net: dcb: For wild-card lookups, use priority -1, not 0

Yelena Krivosheev <yelena@marvell.com>
    net: mvneta: fix mtu change on port without link

Anton Vasilyev <vasilyev@ispras.ru>
    gpio: ml-ioh: Fix buffer underwrite on probe error path

Joerg Roedel <jroedel@suse.de>
    x86/mm: Remove in_nmi() warning from vmalloc_fault()

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: hidp: Fix handling of strncpy for hid->name information

Anton Vasilyev <vasilyev@ispras.ru>
    scsi: 3ware: fix return 0 on the error path of probe

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    ata: libahci: Correct setting of DEVSLP register

Paul Burton <paul.burton@mips.com>
    MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath10k: prevent active scans on potential unusable channels

Finn Thain <fthain@telegraphics.com.au>
    macintosh/via-pmu: Add missing mmio accessors

Anton Vasilyev <vasilyev@ispras.ru>
    tty: rocket: Fix possible buffer overwrite on register_PCI

Dan Carpenter <dan.carpenter@oracle.com>
    uio: potential double frees if __uio_register_device() fails

BingJing Chang <bingjingc@synology.com>
    md/raid5: fix data corruption of replacements after originals dropped

Mike Christie <mchristi@redhat.com>
    scsi: target: fix __transport_register_session locking

Johan Hedberg <johan.hedberg@intel.com>
    Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV

Daniel Micay <danielmicay@gmail.com>
    staging/rts5208: Fix read overflow in memcpy

Jia-Ju Bai <baijiaju1990@163.com>
    staging: rt5208: Fix a sleep-in-atomic bug in xd_copy_page

Vegard Nossum <vegard.nossum@oracle.com>
    kthread: fix boot hang (regression) on MIPS/OpenRISC

Vegard Nossum <vegard.nossum@oracle.com>
    kthread: Fix use-after-free if kthread fork fails

Ritesh Harjani <riteshh@codeaurora.org>
    cfq: Give a chance for arming slice idle timer in case of group_idle

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    i2c: xiic: Make the start and the byte count write atomic

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ASoC: wm8994: Fix missing break in switch

Chas Williams <chas3@att.com>
    Fixes: Commit 86af955d02bb ("mm: numa: avoid waiting on freed migrated pages")

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: do not call enic_change_mtu in enic_probe

Tyler Hicks <tyhicks@canonical.com>
    irda: Only insert new objects into the global database via setsockopt

Tyler Hicks <tyhicks@canonical.com>
    irda: Fix memory leak caused by repeated binds of irda socket

Randy Dunlap <rdunlap@infradead.org>
    kbuild: make missing $DEPMOD a Warning instead of an Error

Joel Fernandes (Google) <joel@joelfernandes.org>
    debugobjects: Make stack check warning more informative

Qu Wenruo <wqu@suse.com>
    btrfs: Don't remove block group that still has pinned down bytes

Qu Wenruo <wqu@suse.com>
    btrfs: relocation: Only remove reloc rb_trees if reloc control has been initialized

Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
    btrfs: replace: Reset on-disk dev stats value after replace

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.

Steve French <stfrench@microsoft.com>
    SMB3: Number of requests sent should be displayed for SMB3 not just CIFS

Steve French <stfrench@microsoft.com>
    smb3: fix reset of bytes read and written stats

Breno Leitao <leitao@debian.org>
    selftests/powerpc: Kill child processes on SIGINT

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: ni_mio_common: fix subdevice flags for PFI subdevice

John Pittman <jpittman@redhat.com>
    dm kcopyd: avoid softlockup in run_complete_job

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    PCI: mvebu: Fix I/O space end address calculation

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: aic94xx: fix an error code in aic94xx_init()

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging offline processing due to canceled worker

Dan Carpenter <dan.carpenter@oracle.com>
    powerpc: Fix size calculation using resource_size()

Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
    net/9p: fix error path of p9_virtio_probe

Aleh Filipovich <aleh@vaolix.com>
    platform/x86: asus-nb-wmi: Add keymap entry for lid flip action on UX360

Guenter Roeck <linux@roeck-us.net>
    mfd: sm501: Set coherent_dma_mask when creating subdevices

Tan Hu <tan.hu@zte.com.cn>
    ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()

Andrey Ryabinin <aryabinin@virtuozzo.com>
    mm/fadvise.c: fix signed overflow UBSAN complaint

Randy Dunlap <rdunlap@infradead.org>
    scripts: modpost: check memory allocation results

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
    fat: validate ->i_start before using

Arnd Bergmann <arnd@arndb.de>
    reiserfs: change j_timestamp type to time64_t

Jann Horn <jannh@google.com>
    fork: don't copy inconsistent signal handler state to child

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfs: prevent crash on exit from failed search

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    hfsplus: don't return 0 when fill_super() failed

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: check if SMB2 PDU size has been padded and suppress the warning


-------------

Diffstat:

 Makefile                                          |  4 +--
 arch/arm/mach-hisi/hotplug.c                      | 33 ++++++++++++------
 arch/mips/ath79/setup.c                           |  1 +
 arch/mips/include/asm/io.h                        |  8 ++---
 arch/mips/include/asm/mach-ath79/ath79.h          |  1 +
 arch/mips/kernel/process.c                        |  1 -
 arch/mips/loongson/common/cs5536/cs5536_ohci.c    |  2 +-
 arch/mips/mm/c-r4k.c                              |  6 ++--
 arch/openrisc/kernel/process.c                    |  2 --
 arch/powerpc/platforms/powernv/opal.c             |  2 +-
 arch/powerpc/platforms/pseries/ras.c              |  2 +-
 arch/powerpc/sysdev/mpic_msgr.c                   |  2 +-
 arch/x86/mm/fault.c                               |  2 --
 block/cfq-iosched.c                               |  3 +-
 block/partitions/aix.c                            | 13 ++++---
 drivers/ata/libahci.c                             |  2 ++
 drivers/bluetooth/Kconfig                         |  1 +
 drivers/gpio/gpio-ml-ioh.c                        |  3 +-
 drivers/gpu/drm/panel/panel-s6e8aa0.c             |  2 +-
 drivers/i2c/busses/i2c-xiic.c                     |  4 +++
 drivers/infiniband/core/cma.c                     | 12 ++++---
 drivers/infiniband/hw/nes/nes.h                   |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c           |  2 ++
 drivers/macintosh/via-pmu.c                       |  9 ++---
 drivers/md/dm-kcopyd.c                            |  2 ++
 drivers/md/raid5.c                                |  6 ++++
 drivers/mfd/sm501.c                               |  1 +
 drivers/mfd/ti_am335x_tscadc.c                    |  3 +-
 drivers/mtd/maps/solutionengine.c                 |  6 ++--
 drivers/mtd/mtdchar.c                             | 10 ++++--
 drivers/net/ethernet/cisco/enic/enic_main.c       |  2 +-
 drivers/net/ethernet/marvell/mvneta.c             |  1 -
 drivers/net/wireless/ath/ath10k/mac.c             |  7 ++++
 drivers/net/xen-netfront.c                        | 24 ++++++-------
 drivers/parport/parport_sunbpp.c                  |  8 +++--
 drivers/pci/host/pci-mvebu.c                      |  2 +-
 drivers/platform/x86/asus-nb-wmi.c                |  1 +
 drivers/platform/x86/toshiba_acpi.c               |  3 +-
 drivers/rtc/rtc-bq4802.c                          |  4 +++
 drivers/s390/block/dasd_eckd.c                    |  7 ++--
 drivers/s390/net/qeth_core_main.c                 |  3 +-
 drivers/s390/net/qeth_core_sys.c                  |  1 +
 drivers/scsi/3w-9xxx.c                            |  6 +++-
 drivers/scsi/3w-sas.c                             |  3 ++
 drivers/scsi/3w-xxxx.c                            |  2 ++
 drivers/scsi/aic94xx/aic94xx_init.c               |  4 ++-
 drivers/staging/comedi/drivers/ni_mio_common.c    |  3 +-
 drivers/staging/rts5208/rtsx_scsi.c               |  2 +-
 drivers/staging/rts5208/xd.c                      |  2 +-
 drivers/target/target_core_transport.c            |  5 +--
 drivers/tty/rocket.c                              |  2 +-
 drivers/uio/uio.c                                 |  3 +-
 drivers/usb/class/cdc-wdm.c                       |  2 +-
 drivers/usb/core/hcd-pci.c                        |  2 --
 drivers/usb/core/message.c                        | 11 ++++++
 drivers/usb/core/quirks.c                         |  3 ++
 drivers/usb/host/u132-hcd.c                       |  2 +-
 drivers/usb/host/xhci.c                           |  3 ++
 drivers/usb/misc/uss720.c                         |  4 +--
 drivers/usb/misc/yurex.c                          |  5 +--
 drivers/usb/serial/io_ti.h                        |  2 +-
 drivers/usb/serial/ti_usb_3410_5052.h             |  2 +-
 drivers/usb/storage/scsiglue.c                    |  9 +++++
 drivers/usb/storage/unusual_devs.h                |  7 ++++
 drivers/video/fbdev/core/modedb.c                 | 41 +++++++++++++++++------
 drivers/video/fbdev/goldfishfb.c                  |  1 +
 drivers/video/fbdev/omap/omapfb_main.c            |  2 +-
 drivers/video/fbdev/via/viafbdev.c                |  3 +-
 fs/binfmt_elf.c                                   |  2 +-
 fs/btrfs/dev-replace.c                            |  6 ++++
 fs/btrfs/extent-tree.c                            |  2 +-
 fs/btrfs/relocation.c                             | 23 +++++++------
 fs/cifs/cifs_debug.c                              |  8 +++++
 fs/cifs/readdir.c                                 | 11 ++++--
 fs/cifs/smb2misc.c                                |  7 ++++
 fs/cifs/smb2pdu.c                                 | 27 +++++++++------
 fs/f2fs/super.c                                   | 21 ++++++++++--
 fs/fat/cache.c                                    | 19 +++++++----
 fs/fat/fat.h                                      |  5 +++
 fs/fat/fatent.c                                   |  6 ++--
 fs/gfs2/bmap.c                                    |  2 +-
 fs/hfs/brec.c                                     |  7 ++--
 fs/hfsplus/super.c                                |  4 ++-
 fs/pstore/ram_core.c                              | 17 ++++++++--
 fs/reiserfs/reiserfs.h                            |  2 +-
 include/linux/mm_types.h                          |  2 +-
 include/linux/sched.h                             |  2 +-
 include/linux/vmacache.h                          |  5 ---
 kernel/audit_watch.c                              | 12 ++++++-
 kernel/fork.c                                     | 19 ++++++++---
 lib/debugobjects.c                                |  7 ++--
 mm/debug.c                                        |  4 +--
 mm/fadvise.c                                      |  8 +++--
 mm/huge_memory.c                                  |  2 +-
 mm/vmacache.c                                     | 36 --------------------
 net/9p/trans_virtio.c                             |  3 +-
 net/bluetooth/hidp/core.c                         |  2 +-
 net/dcb/dcbnl.c                                   | 11 +++---
 net/irda/af_irda.c                                | 13 ++++++-
 net/mac80211/cfg.c                                |  2 +-
 net/mac80211/key.c                                | 24 ++++++++-----
 net/netfilter/ipvs/ip_vs_core.c                   | 15 ++++++---
 net/netfilter/x_tables.c                          |  4 +--
 net/xfrm/xfrm_policy.c                            |  5 ++-
 scripts/depmod.sh                                 |  4 +--
 scripts/mod/modpost.c                             |  8 ++---
 sound/core/pcm_lib.c                              | 14 +++++---
 sound/isa/msnd/msnd_pinnacle.c                    |  4 +--
 sound/soc/codecs/wm8994.c                         |  1 +
 sound/usb/quirks-table.h                          |  3 +-
 tools/hv/hv_kvp_daemon.c                          |  2 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 10 ++++--
 tools/testing/selftests/powerpc/harness.c         | 18 ++++++----
 113 files changed, 491 insertions(+), 259 deletions(-)



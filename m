Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ADA2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39ADA2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeIRENF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:13:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeIRENE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:13:04 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BCE79CA1;
        Mon, 17 Sep 2018 22:43:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/56] 4.4.157-stable review
Date:   Tue, 18 Sep 2018 00:41:33 +0200
Message-Id: <20180917213827.913122591@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.157-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.157-rc1
X-KernelTest-Deadline: 2018-09-19T21:38+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.157 release.
There are 56 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Sep 19 21:38:11 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.157-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.157-rc1

Linus Torvalds <torvalds@linux-foundation.org>
    mm: get rid of vmacache_flush_all() entirely

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+

Ian Kent <raven@themaw.net>
    autofs: fix autofs_sbi() does not check super block type

Wei Yongjun <weiyongjun1@huawei.com>
    mtd: ubi: wl: Fix error return code in ubi_wl_init()

Ondrej Mosnacek <omosnace@redhat.com>
    crypto: vmx - Fix sleep-in-atomic bugs

Peter Chen <peter.chen@nxp.com>
    ethernet: ti: davinci_emac: add missing of_node_put after calling of_parse_phandle

Johan Hovold <johan@kernel.org>
    net: ethernet: ti: cpsw: fix mdio device reference leak

David Rivshin <drivshin@allworx.com>
    drivers: net: cpsw: fix parsing of phy-handle DT property in dual_emac config

Eric Dumazet <edumazet@google.com>
    netfilter: x_tables: avoid stack-out-of-bounds read in xt_copy_counters_from_user

Nadav Amit <namit@vmware.com>
    vmw_balloon: include asm/io.h

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix use-after-free in xhci_free_virt_device

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Do not ignore net namespace for unbound cm_id

Paul Burton <paul.burton@imgtec.com>
    MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize

Zumeng Chen <zumeng.chen@gmail.com>
    mfd: ti_am335x_tscadc: Fix struct clk memory leak

Geert Uytterhoeven <geert+renesas@glider.be>
    iommu/ipmmu-vmsa: Fix allocation in atomic context

Mauricio Faria de Oliveira <mfo@canonical.com>
    partitions/aix: fix usage of uninitialized lv_info and lvname structures

Mauricio Faria de Oliveira <mfo@canonical.com>
    partitions/aix: append null character to print data from disk

Nick Dyer <nick.dyer@itdev.co.uk>
    Input: atmel_mxt_ts - only use first T9 instance

Petr Machata <petrm@mellanox.com>
    net: dcb: For wild-card lookups, use priority -1, not 0

Nicholas Mc Guire <hofrat@osadl.org>
    MIPS: Octeon: add missing of_node_put()

Yelena Krivosheev <yelena@marvell.com>
    net: mvneta: fix mtu change on port without link

Anton Vasilyev <vasilyev@ispras.ru>
    gpio: ml-ioh: Fix buffer underwrite on probe error path

Joerg Roedel <jroedel@suse.de>
    x86/mm: Remove in_nmi() warning from vmalloc_fault()

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: hidp: Fix handling of strncpy for hid->name information

Surabhi Vishnoi <svishnoi@codeaurora.org>
    ath10k: disable bundle mgmt tx completion event support

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

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.0 fix client reference leak in callback

Christophe Leroy <christophe.leroy@c-s.fr>
    perf tools: Allow overriding MAX_NR_CPUS at compile time

Yunlong Song <yunlong.song@huawei.com>
    f2fs: do not set free of current section

Anton Vasilyev <vasilyev@ispras.ru>
    tty: rocket: Fix possible buffer overwrite on register_PCI

Dan Carpenter <dan.carpenter@oracle.com>
    uio: potential double frees if __uio_register_device() fails

Anton Vasilyev <vasilyev@ispras.ru>
    misc: ti-st: Fix memory leak in the error path of probe()

BingJing Chang <bingjingc@synology.com>
    md/raid5: fix data corruption of replacements after originals dropped

Mike Christie <mchristi@redhat.com>
    scsi: target: fix __transport_register_session locking

Dmitry Osipenko <digetx@gmail.com>
    gpio: tegra: Move driver registration to subsys_init level

Johan Hedberg <johan.hedberg@intel.com>
    Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV

Florian Fainelli <f.fainelli@gmail.com>
    ethtool: Remove trailing semicolon for static inline

Dan Carpenter <dan.carpenter@oracle.com>
    misc: mic: SCIF Fix scif_get_new_port() error handling

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: [plat-axs*]: Enable SWAP

Prateek Sood <prsood@codeaurora.org>
    locking/osq_lock: Fix osq_lock queue corruption

Michal Hocko <mhocko@kernel.org>
    selinux: use GFP_NOWAIT in the AVC kmem_caches

Prateek Sood <prsood@codeaurora.org>
    locking/rwsem-xadd: Fix missed wakeup due to reordering of load

Tejun Heo <tj@kernel.org>
    block,blkcg: use __GFP_NOWARN for best-effort allocations in blkcg

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

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Fix cancel_work_sync() stall from jackpoll work

Felipe Balbi <felipe.balbi@linux.intel.com>
    i2c: i801: fix DNV's SMBCTRL register offset

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    i2c: xiic: Make the start and the byte count write atomic


-------------

Diffstat:

 Makefile                                  |  4 +--
 arch/arc/configs/axs101_defconfig         |  1 -
 arch/arc/configs/axs103_defconfig         |  1 -
 arch/arc/configs/axs103_smp_defconfig     |  1 -
 arch/mips/cavium-octeon/octeon-platform.c |  2 ++
 arch/mips/include/asm/io.h                |  8 +++---
 arch/mips/kernel/process.c                |  1 -
 arch/mips/mm/c-r4k.c                      |  6 ++--
 arch/openrisc/kernel/process.c            |  2 --
 arch/x86/include/asm/processor.h          |  4 ++-
 arch/x86/kernel/cpu/bugs.c                | 47 +++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/common.c              |  2 ++
 arch/x86/mm/fault.c                       |  2 --
 block/blk-cgroup.c                        |  9 +++---
 block/cfq-iosched.c                       |  6 ++--
 block/partitions/aix.c                    | 13 ++++++---
 drivers/ata/libahci.c                     |  2 ++
 drivers/bluetooth/Kconfig                 |  1 +
 drivers/crypto/vmx/aes_cbc.c              | 30 +++++++++-----------
 drivers/gpio/gpio-ml-ioh.c                |  3 +-
 drivers/gpio/gpio-tegra.c                 |  2 +-
 drivers/i2c/busses/i2c-i801.c             |  7 ++++-
 drivers/i2c/busses/i2c-xiic.c             |  4 +++
 drivers/infiniband/core/cma.c             | 13 +++++++--
 drivers/input/touchscreen/atmel_mxt_ts.c  |  7 +++--
 drivers/iommu/ipmmu-vmsa.c                |  9 +++---
 drivers/macintosh/via-pmu.c               |  9 +++---
 drivers/md/raid5.c                        |  6 ++++
 drivers/mfd/ti_am335x_tscadc.c            |  3 +-
 drivers/misc/mic/scif/scif_api.c          | 20 ++++++-------
 drivers/misc/ti-st/st_kim.c               |  4 +--
 drivers/misc/vmw_balloon.c                |  1 +
 drivers/mtd/ubi/wl.c                      |  8 ++++--
 drivers/net/ethernet/marvell/mvneta.c     |  1 -
 drivers/net/ethernet/ti/cpsw.c            | 14 ++++-----
 drivers/net/ethernet/ti/cpsw.h            |  1 +
 drivers/net/ethernet/ti/davinci_emac.c    |  1 +
 drivers/net/wireless/ath/ath10k/mac.c     |  7 +++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |  5 ++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h |  5 ++++
 drivers/scsi/3w-9xxx.c                    |  6 +++-
 drivers/scsi/3w-sas.c                     |  3 ++
 drivers/scsi/3w-xxxx.c                    |  2 ++
 drivers/staging/rts5208/rtsx_scsi.c       |  2 +-
 drivers/staging/rts5208/xd.c              |  2 +-
 drivers/target/target_core_transport.c    |  5 ++--
 drivers/tty/rocket.c                      |  2 +-
 drivers/uio/uio.c                         |  3 +-
 drivers/usb/host/xhci.c                   |  3 ++
 fs/autofs4/autofs_i.h                     |  4 ++-
 fs/autofs4/inode.c                        |  1 -
 fs/f2fs/segment.h                         |  3 ++
 fs/f2fs/super.c                           | 21 ++++++++++++--
 fs/nfs/callback_xdr.c                     | 11 ++++++--
 include/linux/mm_types.h                  |  2 +-
 include/linux/sched.h                     |  2 +-
 include/linux/vm_event_item.h             |  1 -
 include/linux/vmacache.h                  |  5 ----
 include/uapi/linux/ethtool.h              |  4 +--
 kernel/fork.c                             | 17 +++++++----
 kernel/locking/osq_lock.c                 | 13 +++++++++
 kernel/locking/rwsem-xadd.c               | 27 ++++++++++++++++++
 mm/debug.c                                |  4 +--
 mm/vmacache.c                             | 38 -------------------------
 net/bluetooth/hidp/core.c                 |  2 +-
 net/dcb/dcbnl.c                           | 11 +++++---
 net/netfilter/x_tables.c                  |  4 +--
 security/selinux/avc.c                    | 14 ++++-----
 sound/pci/hda/hda_codec.c                 |  3 +-
 tools/perf/perf.h                         |  2 ++
 70 files changed, 312 insertions(+), 177 deletions(-)



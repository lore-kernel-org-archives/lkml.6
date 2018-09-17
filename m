Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2ABECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071BF2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071BF2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeIRE3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:29:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeIRE3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:29:44 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 969B6C03;
        Mon, 17 Sep 2018 23:00:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/126] 4.14.71-stable review
Date:   Tue, 18 Sep 2018 00:40:48 +0200
Message-Id: <20180917211703.481236999@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.71-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.71-rc1
X-KernelTest-Deadline: 2018-09-19T21:17+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.71 release.
There are 126 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Sep 19 21:16:12 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.71-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.71-rc1

Linus Torvalds <torvalds@linux-foundation.org>
    mm: get rid of vmacache_flush_all() entirely

Ian Kent <raven@themaw.net>
    autofs: fix autofs_sbi() does not check super block type

Jason Wang <jasowang@redhat.com>
    tuntap: fix use after free during release

Jason Wang <jasowang@redhat.com>
    tun: fix use after free for ptr_ring

Wei Yongjun <weiyongjun1@huawei.com>
    mtd: ubi: wl: Fix error return code in ubi_wl_init()

Taehee Yoo <ap420073@gmail.com>
    ip: frags: fix crash in ip_do_fragment()

Peter Oskolkov <posk@google.com>
    ip: process in-order fragments efficiently

Peter Oskolkov <posk@google.com>
    ip: add helpers to process in-order fragments faster.

Dan Carpenter <dan.carpenter@oracle.com>
    ipv4: frags: precedence bug in ip_expire()

Eric Dumazet <edumazet@google.com>
    net: sk_buff rbnode reorg

Eric Dumazet <edumazet@google.com>
    net: add rb_to_skb() and other rb tree helpers

Eric Dumazet <edumazet@google.com>
    net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends

Florian Westphal <fw@strlen.de>
    ipv6: defrag: drop non-last frags smaller than min mtu

Peter Oskolkov <posk@google.com>
    net: modify skb_rbtree_purge to return the truesize of all purged skbs.

Eric Dumazet <edumazet@google.com>
    net: speed up skb_rbtree_purge()

Peter Oskolkov <posk@google.com>
    ip: discard IPv4 datagrams with overlapping segments.

Eric Dumazet <edumazet@google.com>
    inet: frags: fix ip6frag_low_thresh boundary

Eric Dumazet <edumazet@google.com>
    inet: frags: get rid of ipfrag_skb_cb/FRAG_CB

Eric Dumazet <edumazet@google.com>
    inet: frags: reorganize struct netns_frags

Eric Dumazet <edumazet@google.com>
    rhashtable: reorganize struct rhashtable layout

Eric Dumazet <edumazet@google.com>
    ipv6: frags: rewrite ip6_expire_frag_queue()

Eric Dumazet <edumazet@google.com>
    inet: frags: do not clone skb in ip_expire()

Eric Dumazet <edumazet@google.com>
    inet: frags: break the 2GB limit for frags storage

Eric Dumazet <edumazet@google.com>
    inet: frags: remove inet_frag_maybe_warn_overflow()

Eric Dumazet <edumazet@google.com>
    inet: frags: get rif of inet_frag_evicting()

Eric Dumazet <edumazet@google.com>
    inet: frags: remove some helpers

Eric Dumazet <edumazet@google.com>
    inet: frags: use rhashtables for reassembly units

Eric Dumazet <edumazet@google.com>
    rhashtable: add schedule points

Eric Dumazet <edumazet@google.com>
    ipv6: export ip6 fragments sysctl to unprivileged users

Eric Dumazet <edumazet@google.com>
    inet: frags: refactor lowpan_net_frag_init()

Eric Dumazet <edumazet@google.com>
    inet: frags: refactor ipv6_frag_init()

Kees Cook <keescook@chromium.org>
    inet: frags: Convert timers to use timer_setup()

Eric Dumazet <edumazet@google.com>
    inet: frags: refactor ipfrag_init()

Eric Dumazet <edumazet@google.com>
    inet: frags: add a pointer to struct netns_frags

Eric Dumazet <edumazet@google.com>
    inet: frags: change inet_frags_init_net() return value

Jani Nikula <jani.nikula@intel.com>
    drm/i915: set DP Main Stream Attribute for color range on DDI platforms

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Do not ignore net namespace for unbound cm_id

Paul Burton <paul.burton@mips.com>
    MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Fix a potential layoutget/layoutrecall deadlock

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize

Zumeng Chen <zumeng.chen@gmail.com>
    mfd: ti_am335x_tscadc: Fix struct clk memory leak

Geert Uytterhoeven <geert+renesas@glider.be>
    iommu/ipmmu-vmsa: Fix allocation in atomic context

Dan Carpenter <dan.carpenter@oracle.com>
    f2fs: Fix uninitialized return in f2fs_ioc_shutdown()

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to wait on page writeback before updating page

Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
    media: helene: fix xtal frequency setting at power on

Mauricio Faria de Oliveira <mfo@canonical.com>
    partitions/aix: fix usage of uninitialized lv_info and lvname structures

Mauricio Faria de Oliveira <mfo@canonical.com>
    partitions/aix: append null character to print data from disk

Sylwester Nawrocki <s.nawrocki@samsung.com>
    media: s5p-mfc: Fix buffer look up in s5p_mfc_handle_frame_{new, copy_time} functions

Nick Dyer <nick.dyer@itdev.co.uk>
    Input: atmel_mxt_ts - only use first T9 instance

John Pittman <jpittman@redhat.com>
    dm cache: only allow a single io_mode cache feature to be requested

Petr Machata <petrm@mellanox.com>
    net: dcb: For wild-card lookups, use priority -1, not 0

Nicholas Mc Guire <hofrat@osadl.org>
    MIPS: generic: fix missing of_node_put()

Nicholas Mc Guire <hofrat@osadl.org>
    MIPS: Octeon: add missing of_node_put()

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with reserved blkaddr of inline inode

Peter Rosin <peda@axentia.se>
    tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Linus Walleij <linus.walleij@linaro.org>
    tpm_tis_spi: Pass the SPI IRQ down to the driver

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to skip GC if type in SSA and SIT is inconsistent

Jinbum Park <jinb.park7@gmail.com>
    pktcdvd: Fix possible Spectre-v1 for pkt_devs

Chao Yu <yuchao0@huawei.com>
    f2fs: try grabbing node page lock aggressively in sync scenario

Yelena Krivosheev <yelena@marvell.com>
    net: mvneta: fix mtu change on port without link

Daniel Kurtz <djkurtz@chromium.org>
    pinctrl/amd: only handle irq if it is pending and unmasked

Anton Vasilyev <vasilyev@ispras.ru>
    gpio: ml-ioh: Fix buffer underwrite on probe error path

Dan Carpenter <dan.carpenter@oracle.com>
    pinctrl: imx: off by one in imx_pinconf_group_dbg_show()

Joerg Roedel <jroedel@suse.de>
    x86/mm: Remove in_nmi() warning from vmalloc_fault()

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: hidp: Fix handling of strncpy for hid->name information

Surabhi Vishnoi <svishnoi@codeaurora.org>
    ath10k: disable bundle mgmt tx completion event support

Huaisheng Ye <yehs1@lenovo.com>
    tools/testing/nvdimm: kaddr and pfn can be NULL to ->direct_access()

Anton Vasilyev <vasilyev@ispras.ru>
    scsi: 3ware: fix return 0 on the error path of probe

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    ata: libahci: Correct setting of DEVSLP register

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    ata: libahci: Allow reconfigure of DEVSLP register

Paul Burton <paul.burton@mips.com>
    MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    rpmsg: core: add support to power domains for devices

Loic Poulain <loic.poulain@linaro.org>
    wlcore: Set rx_status boottime_ns field on rx

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath10k: prevent active scans on potential unusable channels

Felix Fietkau <nbd@nbd.name>
    ath9k_hw: fix channel maximum power level test

Felix Fietkau <nbd@nbd.name>
    ath9k: report tx status on EOSP

Finn Thain <fthain@telegraphics.com.au>
    macintosh/via-pmu: Add missing mmio accessors

Kan Liang <kan.liang@linux.intel.com>
    perf evlist: Fix error out while applying initial delay and LBR

Jiri Olsa <jolsa@kernel.org>
    perf c2c report: Fix crash for empty browser

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.0 fix client reference leak in callback

Christophe Leroy <christophe.leroy@c-s.fr>
    perf tools: Allow overriding MAX_NR_CPUS at compile time

Randy Dunlap <rdunlap@infradead.org>
    f2fs: fix defined but not used build warnings

Yunlong Song <yunlong.song@huawei.com>
    f2fs: do not set free of current section

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to active page in lru list for read path

Anton Vasilyev <vasilyev@ispras.ru>
    tty: rocket: Fix possible buffer overwrite on register_PCI

Michael Kelley <mikelley@microsoft.com>
    Drivers: hv: vmbus: Cleanup synic memory free path

Anton Vasilyev <vasilyev@ispras.ru>
    firmware: vpd: Fix section enabled flag on vpd_section_destroy

Dan Carpenter <dan.carpenter@oracle.com>
    uio: potential double frees if __uio_register_device() fails

Anton Vasilyev <vasilyev@ispras.ru>
    misc: ti-st: Fix memory leak in the error path of probe()

Philipp Zabel <p.zabel@pengutronix.de>
    gpu: ipu-v3: default to id 0 on missing OF alias

Todor Tomov <todor.tomov@linaro.org>
    media: camss: csid: Configure data type and decode format properly

Gaurav Kohli <gkohli@codeaurora.org>
    timers: Clear timer_base::must_forward_clk with timer_base::lock held

BingJing Chang <bingjingc@synology.com>
    md/raid5: fix data corruption of replacements after originals dropped

Mike Christie <mchristi@redhat.com>
    scsi: target: fix __transport_register_session locking

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix updating tags depth

Arun Parameswaran <arun.parameswaran@broadcom.com>
    net: phy: Fix the register offsets in Broadcom iProc mdio mux driver

Anton Vasilyev <vasilyev@ispras.ru>
    media: dw2102: Fix memleak on sequence of probes

Anton Vasilyev <vasilyev@ispras.ru>
    media: davinci: vpif_display: Mix memory leak on probe error path

Roman Gushchin <guro@fb.com>
    selftests/bpf: fix a typo in map in map test

Reza Arbab <arbab@linux.ibm.com>
    powerpc/powernv: Fix concurrency issue with npu->mmio_atsd_usage

Dmitry Osipenko <digetx@gmail.com>
    gpio: tegra: Move driver registration to subsys_init level

Johan Hedberg <johan.hedberg@intel.com>
    Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV

Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
    i2c: aspeed: Add an explicit type casting for *get_clk_reg_val

Florian Fainelli <f.fainelli@gmail.com>
    ethtool: Remove trailing semicolon for static inline

Dan Carpenter <dan.carpenter@oracle.com>
    misc: mic: SCIF Fix scif_get_new_port() error handling

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: [plat-axs*]: Enable SWAP

Tomas Winkler <tomas.winkler@intel.com>
    tpm: separate cmd_ready/go_idle from runtime_pm

Arnd Bergmann <arnd@arndb.de>
    crypto: aes-generic - fix aes-generic regression on powerpc

Gustavo A. R. Silva <gustavo@embeddedor.com>
    switchtec: Fix Spectre v1 vulnerability

Filippo Sironi <sironi@amazon.de>
    x86/microcode: Update the new microcode revision unconditionally

Prarit Bhargava <prarit@redhat.com>
    x86/microcode: Make sure boot_cpu_data.microcode is up-to-date

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Prevent state corruption on error rollback

Neeraj Upadhyay <neeraju@codeaurora.org>
    cpu/hotplug: Adjust misplaced smb() in cpuhp_thread_fun()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Fix cancel_work_sync() stall from jackpoll work

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: VMX: Do not allow reexecute_instruction() when skipping MMIO instr

Pierre Morel <pmorel@linux.ibm.com>
    KVM: s390: vsie: copy wrapping keys to right place

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix data corruption when deduplicating between different files

Steve French <stfrench@microsoft.com>
    smb3: check for and properly advertise directory lease support

Steve French <stfrench@microsoft.com>
    SMB3: Backup intent flag missing for directory opens with backupuid mounts

Paul Burton <paul.burton@mips.com>
    MIPS: VDSO: Match data page cache colouring when D$ aliases

Minchan Kim <minchan@kernel.org>
    android: binder: fix the race mmap and alloc_new_buf_locked

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    block: bfq: swap puts in bfqg_and_blkg_put

Jens Axboe <axboe@kernel.dk>
    nbd: don't allow invalid blocksize settings

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Correct MDS diag and nvmet configuration

Felipe Balbi <felipe.balbi@linux.intel.com>
    i2c: i801: fix DNV's SMBCTRL register offset

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    i2c: xiic: Make the start and the byte count write atomic


-------------

Diffstat:

 Documentation/networking/ip-sysctl.txt             |  13 +-
 Makefile                                           |   4 +-
 arch/arc/configs/axs101_defconfig                  |   1 -
 arch/arc/configs/axs103_defconfig                  |   1 -
 arch/arc/configs/axs103_smp_defconfig              |   1 -
 arch/mips/cavium-octeon/octeon-platform.c          |   2 +
 arch/mips/generic/init.c                           |   1 +
 arch/mips/include/asm/io.h                         |   8 +-
 arch/mips/kernel/vdso.c                            |  20 +
 arch/mips/mm/c-r4k.c                               |   6 +-
 arch/powerpc/platforms/powernv/npu-dma.c           |   5 +-
 arch/s390/kvm/vsie.c                               |   3 +-
 arch/x86/kernel/cpu/microcode/amd.c                |  24 +-
 arch/x86/kernel/cpu/microcode/intel.c              |  17 +-
 arch/x86/kvm/vmx.c                                 |   4 +-
 arch/x86/mm/fault.c                                |   2 -
 block/bfq-cgroup.c                                 |   4 +-
 block/blk-mq-tag.c                                 |   8 +-
 block/partitions/aix.c                             |  13 +-
 crypto/Makefile                                    |   2 +-
 drivers/android/binder_alloc.c                     |  42 +-
 drivers/ata/libahci.c                              |  20 +-
 drivers/block/nbd.c                                |   3 +
 drivers/block/pktcdvd.c                            |   4 +-
 drivers/bluetooth/Kconfig                          |   1 +
 drivers/char/tpm/tpm-interface.c                   |  50 +-
 drivers/char/tpm/tpm.h                             |  12 +-
 drivers/char/tpm/tpm2-space.c                      |  16 +-
 drivers/char/tpm/tpm_crb.c                         | 101 +---
 drivers/char/tpm/tpm_i2c_infineon.c                |   8 +-
 drivers/char/tpm/tpm_tis_spi.c                     |   9 +-
 drivers/firmware/google/vpd.c                      |   5 +-
 drivers/gpio/gpio-ml-ioh.c                         |   3 +-
 drivers/gpio/gpio-tegra.c                          |   2 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   1 +
 drivers/gpu/drm/i915/intel_ddi.c                   |   4 +
 drivers/gpu/ipu-v3/ipu-common.c                    |   2 +
 drivers/hv/hv.c                                    |  14 +-
 drivers/i2c/busses/i2c-aspeed.c                    |   2 +-
 drivers/i2c/busses/i2c-i801.c                      |   7 +-
 drivers/i2c/busses/i2c-xiic.c                      |   4 +
 drivers/infiniband/core/cma.c                      |  13 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |   7 +-
 drivers/iommu/ipmmu-vmsa.c                         |   9 +-
 drivers/macintosh/via-pmu.c                        |   9 +-
 drivers/md/dm-cache-target.c                       |  19 +-
 drivers/md/raid5.c                                 |   6 +
 drivers/media/dvb-frontends/helene.c               |   5 +-
 drivers/media/platform/davinci/vpif_display.c      |  24 +-
 .../media/platform/qcom/camss-8x16/camss-csid.c    |  16 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c           |  23 +-
 drivers/media/usb/dvb-usb/dw2102.c                 |  19 +-
 drivers/mfd/ti_am335x_tscadc.c                     |   3 +-
 drivers/misc/mic/scif/scif_api.c                   |  20 +-
 drivers/misc/ti-st/st_kim.c                        |   4 +-
 drivers/mtd/ubi/wl.c                               |   8 +-
 drivers/net/ethernet/marvell/mvneta.c              |   1 -
 drivers/net/phy/mdio-mux-bcm-iproc.c               |  20 +-
 drivers/net/tun.c                                  |  21 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   7 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |   5 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |   5 +
 drivers/net/wireless/ath/ath9k/hw.c                |   7 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   3 +-
 drivers/net/wireless/ti/wlcore/rx.c                |   8 +-
 drivers/pci/switch/switchtec.c                     |   4 +
 drivers/pinctrl/freescale/pinctrl-imx.c            |   2 +-
 drivers/pinctrl/pinctrl-amd.c                      |   3 +-
 drivers/rpmsg/rpmsg_core.c                         |   7 +
 drivers/scsi/3w-9xxx.c                             |   6 +-
 drivers/scsi/3w-sas.c                              |   3 +
 drivers/scsi/3w-xxxx.c                             |   2 +
 drivers/scsi/lpfc/lpfc.h                           |   2 +-
 drivers/target/target_core_transport.c             |   5 +-
 drivers/tty/rocket.c                               |   2 +-
 drivers/uio/uio.c                                  |   3 +-
 fs/autofs4/autofs_i.h                              |   4 +-
 fs/autofs4/inode.c                                 |   1 -
 fs/btrfs/ioctl.c                                   |  19 +
 fs/cifs/inode.c                                    |   2 +
 fs/cifs/smb2ops.c                                  |  35 +-
 fs/cifs/smb2pdu.c                                  |   3 +
 fs/f2fs/f2fs.h                                     |   7 +-
 fs/f2fs/file.c                                     |   2 +-
 fs/f2fs/gc.c                                       |   8 +-
 fs/f2fs/inline.c                                   |  22 +
 fs/f2fs/node.c                                     |   4 +-
 fs/f2fs/segment.h                                  |   3 +
 fs/f2fs/super.c                                    |  21 +-
 fs/f2fs/sysfs.c                                    |  10 +-
 fs/nfs/callback_proc.c                             |   4 +-
 fs/nfs/callback_xdr.c                              |  11 +-
 include/linux/mm_types.h                           |   2 +-
 include/linux/mm_types_task.h                      |   2 +-
 include/linux/rhashtable.h                         |   8 +-
 include/linux/skbuff.h                             |  50 +-
 include/linux/tpm.h                                |   2 +
 include/linux/vm_event_item.h                      |   1 -
 include/linux/vmacache.h                           |   5 -
 include/net/inet_frag.h                            | 135 +++--
 include/net/ip.h                                   |   1 -
 include/net/ipv6.h                                 |  26 +-
 include/uapi/linux/ethtool.h                       |   4 +-
 include/uapi/linux/snmp.h                          |   1 +
 kernel/cpu.c                                       |  11 +-
 kernel/time/timer.c                                |  29 +-
 lib/rhashtable.c                                   |   2 +
 mm/debug.c                                         |   4 +-
 mm/vmacache.c                                      |  38 --
 net/bluetooth/hidp/core.c                          |   2 +-
 net/core/skbuff.c                                  |  31 +-
 net/dcb/dcbnl.c                                    |  11 +-
 net/ieee802154/6lowpan/6lowpan_i.h                 |  26 +-
 net/ieee802154/6lowpan/reassembly.c                | 153 +++---
 net/ipv4/inet_fragment.c                           | 378 +++-----------
 net/ipv4/ip_fragment.c                             | 578 ++++++++++++---------
 net/ipv4/proc.c                                    |   7 +-
 net/ipv4/tcp_fastopen.c                            |   8 +-
 net/ipv4/tcp_input.c                               |  33 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            | 105 ++--
 net/ipv6/proc.c                                    |   5 +-
 net/ipv6/reassembly.c                              | 217 ++++----
 net/sched/sch_netem.c                              |  14 +-
 sound/pci/hda/hda_codec.c                          |   3 +-
 tools/perf/builtin-c2c.c                           |   3 +
 tools/perf/perf.h                                  |   2 +
 tools/perf/util/evsel.c                            |  14 +
 tools/testing/nvdimm/pmem-dax.c                    |  12 +-
 tools/testing/selftests/bpf/test_verifier.c        |   6 +-
 129 files changed, 1473 insertions(+), 1362 deletions(-)



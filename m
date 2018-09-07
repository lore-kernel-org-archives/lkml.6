Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1042C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A08320645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A08320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbeIHCJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:09:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbeIHCJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:09:36 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD2CAEF6;
        Fri,  7 Sep 2018 21:26:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/89] 4.14.69-stable review
Date:   Fri,  7 Sep 2018 23:08:54 +0200
Message-Id: <20180907210852.341064285@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.69-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.69-rc1
X-KernelTest-Deadline: 2018-09-09T21:09+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.69 release.
There are 89 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Sep  9 21:08:28 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.69-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.69-rc1

James Morse <james.morse@arm.com>
    arm64: mm: always enable CONFIG_HOLES_IN_ZONE

Jeremy Cline <jcline@redhat.com>
    fs/quota: Fix spectre gadget in do_quotactl

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam/qi - fix error path in xts setkey

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam/jr - fix descriptor DMA unmapping

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam - fix DMA mapping direction for RSA forms 2 & 3

Ondrej Mosnacek <omosnace@redhat.com>
    crypto: vmx - Fix sleep-in-atomic bugs

Adrian Hunter <adrian.hunter@intel.com>
    perf auxtrace: Fix queue resize

Eddie.Horng <eddie.horng@mediatek.com>
    cap_inode_getsecurity: use d_find_any_alias() instead of d_find_alias()

Shan Hai <shan.hai@oracle.com>
    bcache: release dc->writeback_lock properly in bch_writeback_thread()

Vishal Verma <vishal.l.verma@intel.com>
    libnvdimm: fix ars_status output length calculation

Christian Brauner <christian@brauner.io>
    getxattr: use correct xattr length

Mikulas Patocka <mpatocka@redhat.com>
    udlfb: set optimal write delay

Mikulas Patocka <mpatocka@redhat.com>
    fb: fix lost console when the user unplugs a USB adapter

Vignesh R <vigneshr@ti.com>
    pwm: tiehrpwm: Fix disabling of output of PWMs

Vignesh R <vigneshr@ti.com>
    pwm: tiehrpwm: Don't use emulation mode bits to control PWM output

Richard Weinberger <richard@nod.at>
    ubifs: Fix synced_i_size calculation for xattr inodes

Richard Weinberger <richard@nod.at>
    ubifs: xattr: Don't operate on deleted inodes

Richard Weinberger <richard@nod.at>
    ubifs: Check data node size before truncate

Richard Weinberger <richard@nod.at>
    Revert "UBIFS: Fix potential integer overflow in allocation"

Richard Weinberger <richard@nod.at>
    ubifs: Fix memory leak in lprobs self-check

Jann Horn <jannh@google.com>
    userns: move user access out of the mutex

Jann Horn <jannh@google.com>
    sys: don't hold uts_sem while accessing userspace memory

Jacob Pan <jacob.jun.pan@linux.intel.com>
    iommu/vt-d: Fix dev iotlb pfsid use

Jacob Pan <jacob.jun.pan@linux.intel.com>
    iommu/vt-d: Add definitions for PFSID

Peter Zijlstra <peterz@infradead.org>
    mm/tlb: Remove tlb_remove_table() non-concurrent condition

Jon Hunter <jonathanh@nvidia.com>
    ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Trond Myklebust <trondmy@gmail.com>
    NFSv4: Fix a sleep in atomic context in nfs4_callback_sequence()

Trond Myklebust <trondmy@gmail.com>
    NFSv4: Fix locking in pnfs_generic_recover_commit_reqs

Bill Baker <Bill.Baker@Oracle.com>
    NFSv4 client live hangs after live data migration recovery

Dan Carpenter <dan.carpenter@oracle.com>
    pnfs/blocklayout: off by one in bl_map_stripe()

Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    block, bfq: return nbytes and not zero from struct cftype .write() method

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: increase ranges in ___invalidate_{i,d}cache_all

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: limit offsets in __loop_cache_{all,page}

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S: Fix guest DMA when guest partially backed by THP pages

Paolo Bonzini <pbonzini@redhat.com>
    KVM: VMX: fixes for vmentry_l1d_flush module parameter

zhangyi (F) <yi.zhang@huawei.com>
    PM / sleep: wakeup: Fix build error caused by missing SRCU support

Henry Willard <henry.willard@oracle.com>
    cpufreq: governor: Avoid accessing invalid governor_data

Peter Kalauskas <peskal@google.com>
    drivers/block/zram/zram_drv.c: fix bug storing backing_dev

Amir Goldstein <amir73il@gmail.com>
    ovl: fix wrong use of impure dir cache in ovl_iterate()

Rafael David Tinoco <rafael.tinoco@linaro.org>
    mfd: hi655x: Fix regmap area declared size for hi655x

Steven Rostedt (VMware) <rostedt@goodmis.org>
    uprobes: Use synchronize_rcu() not synchronize_sched()

Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
    livepatch: Validate module/old func name length

Steven Rostedt (VMware) <rostedt@goodmis.org>
    printk/tracing: Do not trace printk_nmi_enter()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing/blktrace: Fix to allow setting same value

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Do not call start/stop() functions when tracing_on does not change

Johan Hovold <johan@kernel.org>
    rtc: omap: fix potential crash on power off

Nadav Amit <namit@vmware.com>
    vmw_balloon: fix VMCI use when balloon built into kernel

Nadav Amit <namit@vmware.com>
    vmw_balloon: VMCI_DOORBELL_SET does not check status

Nadav Amit <namit@vmware.com>
    vmw_balloon: do not use 2MB without batching

Nadav Amit <namit@vmware.com>
    vmw_balloon: fix inflation of 64-bit GFNs

Chanwoo Choi <cw00.choi@samsung.com>
    extcon: Release locking when sending the notification of connector state

Lars-Peter Clausen <lars@metafoo.de>
    iio: ad9523: Fix return value for ad952x_store()

Lars-Peter Clausen <lars@metafoo.de>
    iio: ad9523: Fix displayed phase

Gustavo A. R. Silva <gustavo@embeddedor.com>
    iio: sca3000: Fix missing return in switch

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Reset the channel callback in vmbus_onoffer_rescind()

Tycho Andersen <tycho@tycho.ws>
    uart: fix race between uart_put_char() and uart_shutdown()

Mikulas Patocka <mpatocka@redhat.com>
    dm crypt: don't decrease device limits

Ilya Dryomov <idryomov@gmail.com>
    dm cache metadata: set dirty on all cache blocks after a crash

Mike Snitzer <snitzer@redhat.com>
    dm cache metadata: save in-core policy_hint_size to on-disk superblock

Hou Tao <houtao1@huawei.com>
    dm thin: stop no_space_timeout worker when switching to write-mode

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: change 'suspending' variable from bool to int

Tomas Bortoli <tomasbortoli@gmail.com>
    net/9p/trans_fd.c: fix race-condition by flushing workqueue before the kfree()

Tomas Bortoli <tomasbortoli@gmail.com>
    net/9p/client.c: version pointer uninitialized

jiangyiwen <jiangyiwen@huawei.com>
    9p/virtio: fix off-by-one error in sg list bounds check

piaojun <piaojun@huawei.com>
    fs/9p/xattr.c: catch the error of p9_client_clunk when setting xattr failed

Tomas Bortoli <tomasbortoli@gmail.com>
    9p: fix multiple NULL-pointer-dereferences

Bart Van Assche <bart.vanassche@wdc.com>
    RDMA/rxe: Set wqe->status correctly if an unexpected response is received

Bart Van Assche <bart.vanassche@wdc.com>
    ib_srpt: Fix a use-after-free in srpt_close_ch()

Vaibhav Jain <vaibhav@linux.ibm.com>
    cxl: Fix wrong comparison in cxl_adapter_context_get()

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    powerpc/powernv/pci: Work around races in PCI bridge enabling

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.

Hari Bathini <hbathini@linux.ibm.com>
    powerpc/fadump: handle crash memory ranges array index overflow

Yannik Sembritzki <yannik@sembritzki.me>
    Fix kexec forbidding kernels signed with keys in the secondary keyring to boot

Yannik Sembritzki <yannik@sembritzki.me>
    Replace magic for trusting the secondary keyring with #define

Gustavo A. R. Silva <gustavo@embeddedor.com>
    mailbox: xgene-slimpro: Fix potential NULL pointer dereference

Javier Martinez Canillas <javierm@redhat.com>
    media: Revert "[media] tvp5150: fix pad format frame height"

Daniel Mack <daniel@zonque.org>
    libertas: fix suspend and resume for SDIO connected cards

Matthew Auld <matthew.auld@intel.com>
    drm/i915/userptr: reject zero user_size

Ming Lei <ming.lei@redhat.com>
    block: really disable runtime-pm for blk-mq

xiao jin <jin.xiao@intel.com>
    block: blk_init_allocated_queue() set q->fq as NULL in the fail case

Markus Stockhausen <stockhausen@collogia.de>
    readahead: stricter check for bdi io_pages

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    mmc: renesas_sdhi_internal_dmac: fix #define RST_RESERVED_BITS

Janek Kotas <jank@cadence.com>
    spi: cadence: Change usleep_range() to udelay(), for atomic context

Krzysztof Kozlowski <krzk@kernel.org>
    spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe

Mika Westerberg <mika.westerberg@linux.intel.com>
    spi: pxa2xx: Add support for Intel Ice Lake

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    spi: davinci: fix a NULL pointer dereference

Chirantan Ekbote <chirantan@chromium.org>
    9p/net: Fix zero-copy path in the 9p virtio transport

Alexander Aring <aring@mojatatu.com>
    net: mac802154: tx: expand tailroom if necessary

Alexander Aring <aring@mojatatu.com>
    net: 6lowpan: fix reserved space for single frames


-------------

Diffstat:

 Makefile                                        |  4 +-
 arch/alpha/kernel/osf_sys.c                     | 51 +++++++------
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |  1 +
 arch/arm64/Kconfig                              |  1 -
 arch/powerpc/include/asm/fadump.h               |  3 -
 arch/powerpc/kernel/fadump.c                    | 91 +++++++++++++++++++----
 arch/powerpc/mm/mmu_context_iommu.c             | 17 +++--
 arch/powerpc/platforms/powernv/pci-ioda.c       | 37 ++++++++++
 arch/powerpc/platforms/pseries/ras.c            |  2 +-
 arch/sparc/kernel/sys_sparc_32.c                | 22 +++---
 arch/sparc/kernel/sys_sparc_64.c                | 20 +++---
 arch/x86/kernel/kexec-bzimage64.c               |  2 +-
 arch/x86/kvm/vmx.c                              | 26 ++++---
 arch/xtensa/include/asm/cacheasm.h              | 69 +++++++++++-------
 block/bfq-cgroup.c                              |  3 +-
 block/blk-core.c                                |  7 +-
 certs/system_keyring.c                          |  3 +-
 crypto/asymmetric_keys/pkcs7_key_type.c         |  2 +-
 drivers/block/zram/zram_drv.c                   |  7 +-
 drivers/cpufreq/cpufreq_governor.c              | 12 +++-
 drivers/crypto/caam/caamalg_qi.c                |  6 +-
 drivers/crypto/caam/caampkc.c                   | 20 +++---
 drivers/crypto/caam/jr.c                        |  3 +-
 drivers/crypto/vmx/aes_cbc.c                    | 30 ++++----
 drivers/crypto/vmx/aes_xts.c                    | 21 ++++--
 drivers/extcon/extcon.c                         |  3 +-
 drivers/gpu/drm/i915/i915_gem_userptr.c         |  3 +
 drivers/hv/channel.c                            | 40 ++++++-----
 drivers/hv/channel_mgmt.c                       |  6 ++
 drivers/iio/accel/sca3000.c                     |  1 +
 drivers/iio/frequency/ad9523.c                  |  4 +-
 drivers/infiniband/sw/rxe/rxe_comp.c            |  1 +
 drivers/infiniband/ulp/srpt/ib_srpt.c           |  3 +-
 drivers/iommu/dmar.c                            |  6 +-
 drivers/iommu/intel-iommu.c                     | 18 ++++-
 drivers/mailbox/mailbox-xgene-slimpro.c         |  6 +-
 drivers/md/bcache/writeback.c                   |  4 +-
 drivers/md/dm-cache-metadata.c                  | 13 ++--
 drivers/md/dm-crypt.c                           | 10 +--
 drivers/md/dm-integrity.c                       |  6 +-
 drivers/md/dm-thin.c                            |  2 +
 drivers/media/i2c/tvp5150.c                     |  2 +-
 drivers/mfd/hi655x-pmic.c                       |  2 +-
 drivers/misc/cxl/main.c                         |  2 +-
 drivers/misc/vmw_balloon.c                      | 67 ++++++++++-------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c   |  2 +-
 drivers/net/wireless/marvell/libertas/dev.h     |  1 +
 drivers/net/wireless/marvell/libertas/if_sdio.c | 30 ++++++--
 drivers/nvdimm/bus.c                            |  4 +-
 drivers/pwm/pwm-tiehrpwm.c                      | 14 +---
 drivers/rtc/rtc-omap.c                          | 14 ++--
 drivers/spi/spi-cadence.c                       |  2 +-
 drivers/spi/spi-davinci.c                       |  2 +-
 drivers/spi/spi-fsl-dspi.c                      | 24 +++----
 drivers/spi/spi-pxa2xx.c                        |  4 ++
 drivers/tty/serial/serial_core.c                | 17 +++--
 drivers/video/fbdev/core/fbmem.c                | 38 ++++++++--
 fs/9p/xattr.c                                   |  6 +-
 fs/nfs/blocklayout/dev.c                        |  2 +-
 fs/nfs/callback_proc.c                          | 14 ++--
 fs/nfs/nfs4proc.c                               |  9 ++-
 fs/nfs/pnfs_nfs.c                               | 16 ++---
 fs/overlayfs/readdir.c                          | 19 ++++-
 fs/quota/quota.c                                |  2 +
 fs/ubifs/journal.c                              | 21 ++++--
 fs/ubifs/lprops.c                               |  8 +--
 fs/ubifs/xattr.c                                | 24 +++++++
 fs/xattr.c                                      |  2 +-
 include/linux/hyperv.h                          |  2 +
 include/linux/intel-iommu.h                     |  8 ++-
 include/linux/sunrpc/clnt.h                     |  1 +
 include/linux/verification.h                    |  6 ++
 include/video/udlfb.h                           |  2 +-
 kernel/livepatch/core.c                         |  6 ++
 kernel/power/Kconfig                            |  1 +
 kernel/printk/printk_safe.c                     |  4 +-
 kernel/sys.c                                    | 95 ++++++++++++-------------
 kernel/trace/blktrace.c                         |  4 ++
 kernel/trace/trace.c                            |  4 +-
 kernel/trace/trace_uprobe.c                     |  2 +-
 kernel/user_namespace.c                         | 24 +++----
 kernel/utsname_sysctl.c                         | 41 ++++++-----
 mm/memory.c                                     |  9 ---
 mm/readahead.c                                  | 12 +++-
 net/9p/client.c                                 |  2 +-
 net/9p/trans_fd.c                               |  7 +-
 net/9p/trans_rdma.c                             |  3 +
 net/9p/trans_virtio.c                           | 13 +++-
 net/9p/trans_xen.c                              |  3 +
 net/ieee802154/6lowpan/tx.c                     | 21 +++++-
 net/mac802154/tx.c                              | 15 +++-
 net/sunrpc/clnt.c                               | 28 +++++---
 security/commoncap.c                            |  2 +-
 tools/perf/util/auxtrace.c                      |  3 +
 94 files changed, 831 insertions(+), 421 deletions(-)



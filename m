Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1567C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F5420854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F5420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbeIMSqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:46:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIMSqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:46:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91C18CF3;
        Thu, 13 Sep 2018 13:36:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/78] 4.9.127-stable review
Date:   Thu, 13 Sep 2018 15:30:47 +0200
Message-Id: <20180913131805.732342940@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.127-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.127-rc1
X-KernelTest-Deadline: 2018-09-15T13:18+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.127 release.
There are 78 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Sep 15 13:17:41 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.127-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.127-rc1

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Handle mismatched cache type

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Fix mismatched cache line size detection

Ethan Lien <ethanlien@synology.com>
    btrfs: use correct compare function of dirty_metadata_bytes

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ASoC: wm8994: Fix missing break in switch

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/lib: use expoline for all bcr instructions

Tomas Winkler <tomas.winkler@intel.com>
    mei: me: allow runtime pm for platform with D0i3

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    sch_tbf: fix two null pointer dereferences on init failure

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    sch_netem: avoid null pointer deref on init failure

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    sch_hhf: fix null pointer dereference on init failure

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    sch_multiq: fix double free on init failure

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    sch_htb: fix crash on init failure

Chas Williams <chas3@att.com>
    Fixes: Commit 2aa6d036b716 ("mm: numa: avoid waiting on freed migrated pages")

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: do not call enic_change_mtu in enic_probe

Fabio Estevam <fabio.estevam@nxp.com>
    Revert "ARM: imx_v6_v7_defconfig: Select ULPI support"

Tyler Hicks <tyhicks@canonical.com>
    irda: Only insert new objects into the global database via setsockopt

Tyler Hicks <tyhicks@canonical.com>
    irda: Fix memory leak caused by repeated binds of irda socket

Randy Dunlap <rdunlap@infradead.org>
    kbuild: make missing $DEPMOD a Warning instead of an Error

Juergen Gross <jgross@suse.com>
    x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear

Joel Fernandes (Google) <joel@joelfernandes.org>
    debugobjects: Make stack check warning more informative

Eric Dumazet <edumazet@google.com>
    tcp: Revert "tcp: tcp_probe: use spin_lock_bh()"

Kai-Heng Feng <kai.heng.feng@canonical.com>
    drm/edid: Add 6 bpc quirk for SDC panel in Lenovo B50-80

Marc Zyngier <marc.zyngier@arm.com>
    ARM: rockchip: Force CONFIG_PM on Rockchip systems

Marc Zyngier <marc.zyngier@arm.com>
    arm64: rockchip: Force CONFIG_PM on Rockchip systems

Qu Wenruo <wqu@suse.com>
    btrfs: Don't remove block group that still has pinned down bytes

Qu Wenruo <wqu@suse.com>
    btrfs: relocation: Only remove reloc rb_trees if reloc control has been initialized

Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
    btrfs: replace: Reset on-disk dev stats value after replace

Levin Du <djw@t-chip.com.cn>
    clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.

Steve French <stfrench@microsoft.com>
    SMB3: Number of requests sent should be displayed for SMB3 not just CIFS

Steve French <stfrench@microsoft.com>
    smb3: fix reset of bytes read and written stats

YueHaibing <yuehaibing@huawei.com>
    RDS: IB: fix 'passing zero to ERR_PTR()' warning

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

Hans de Goede <hdegoede@redhat.com>
    ACPI / scan: Initialize status to ACPI_STA_DEFAULT

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix panic for failed online processing

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging offline processing due to canceled worker

Greg Edwards <gedwards@ddn.com>
    block: bvec_nr_vecs() returns value for wrong slab

Sandipan Das <sandipan@linux.ibm.com>
    perf probe powerpc: Fix trace event post-processing

Dan Carpenter <dan.carpenter@oracle.com>
    powerpc: Fix size calculation using resource_size()

Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
    net/9p: fix error path of p9_virtio_probe

Tomas Bortoli <tomasbortoli@gmail.com>
    net/9p/trans_fd.c: fix race by holding the lock

Jonas Gorski <jonas.gorski@gmail.com>
    irqchip/bcm7038-l1: Hide cpu offline callback when building for !SMP

Gal Pressman <pressmangal@gmail.com>
    RDMA/hns: Fix usage of bitmap allocation functions return values

Aleh Filipovich <aleh@vaolix.com>
    platform/x86: asus-nb-wmi: Add keymap entry for lid flip action on UX360

Guenter Roeck <linux@roeck-us.net>
    mfd: sm501: Set coherent_dma_mask when creating subdevices

Tan Hu <tan.hu@zte.com.cn>
    ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()

Philipp Rudo <prudo@linux.ibm.com>
    s390/kdump: Fix memleak in nt_vmcoreinfo

Randy Dunlap <rdunlap@infradead.org>
    platform/x86: intel_punit_ipc: fix build errors

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs/dcache.c: fix kmemcheck splat at take_dentry_name_snapshot()

Andrey Ryabinin <aryabinin@virtuozzo.com>
    mm/fadvise.c: fix signed overflow UBSAN complaint

Suzuki K Poulose <suzuki.poulose@arm.com>
    virtio: pci-legacy: Validate queue pfn

Randy Dunlap <rdunlap@infradead.org>
    scripts: modpost: check memory allocation results

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
    fat: validate ->i_start before using

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfsplus: fix NULL dereference in hfsplus_lookup()

Arnd Bergmann <arnd@arndb.de>
    reiserfs: change j_timestamp type to time64_t

Jann Horn <jannh@google.com>
    fork: don't copy inconsistent signal handler state to child

Laura Abbott <labbott@redhat.com>
    sunrpc: Don't use stack buffer with scatterlist

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfs: prevent crash on exit from failed search

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    hfsplus: don't return 0 when fill_super() failed

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: check if SMB2 PDU size has been padded and suppress the warning

Vlad Buslov <vladbu@mellanox.com>
    net: sched: action_ife: take reference to meta module

Cong Wang <xiyou.wangcong@gmail.com>
    act_ife: fix a potential deadlock

Cong Wang <xiyou.wangcong@gmail.com>
    act_ife: move tcfa_lock down to where necessary

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: ignore devices that are not PCI

Jason Wang <jasowang@redhat.com>
    vhost: correctly check the iova range when waking virtqueue

Xin Long <lucien.xin@gmail.com>
    sctp: hold transport before accessing its asoc in sctp_transport_get_next

Alexey Kodanev <alexey.kodanev@oracle.com>
    vti6: remove !skb->ignore_df check from vti6_xmit()

Florian Westphal <fw@strlen.de>
    tcp: do not restart timewait timer on rst reception

Anthony Wong <anthony.wong@ubuntu.com>
    r8169: add support for NCube 8168 network card

Manish Chopra <manish.chopra@cavium.com>
    qlge: Fix netdev features configuration.

Kees Cook <keescook@chromium.org>
    net: sched: Fix memory exposure from short TCA_U32_SEL

Doug Berger <opendmb@gmail.com>
    net: bcmgenet: use MAC link status for fixed phy

Eric Dumazet <edumazet@google.com>
    ipv4: tcp: send zero IPID for RST and ACK sent in SYN-RECV and TIME-WAIT state

Cong Wang <xiyou.wangcong@gmail.com>
    act_ife: fix a potential use-after-free

Michal Hocko <mhocko@suse.cz>
    x86/speculation/l1tf: Fix up pte->pfn conversion for PAE


-------------

Diffstat:

 Makefile                                       |  4 +-
 arch/arm/configs/imx_v6_v7_defconfig           |  2 -
 arch/arm/mach-rockchip/Kconfig                 |  1 +
 arch/arm64/Kconfig.platforms                   |  1 +
 arch/arm64/include/asm/cachetype.h             |  5 ++
 arch/arm64/include/asm/cpucaps.h               |  3 +-
 arch/arm64/kernel/cpu_errata.c                 | 24 ++++++--
 arch/arm64/kernel/cpufeature.c                 |  4 +-
 arch/powerpc/platforms/pseries/ras.c           |  2 +-
 arch/powerpc/sysdev/mpic_msgr.c                |  2 +-
 arch/s390/kernel/crash_dump.c                  | 17 ++++--
 arch/s390/lib/mem.S                            |  9 ++-
 arch/x86/include/asm/pgtable-3level.h          |  7 +--
 arch/x86/include/asm/pgtable.h                 |  2 +-
 block/bio.c                                    |  2 +-
 drivers/acpi/scan.c                            |  5 +-
 drivers/clk/rockchip/clk-rk3399.c              |  1 +
 drivers/gpu/drm/drm_edid.c                     |  3 +
 drivers/infiniband/hw/hns/hns_roce_pd.c        |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c        |  5 +-
 drivers/irqchip/irq-bcm7038-l1.c               |  4 ++
 drivers/md/dm-kcopyd.c                         |  2 +
 drivers/mfd/sm501.c                            |  1 +
 drivers/misc/mei/pci-me.c                      |  5 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  3 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c   | 10 +++-
 drivers/net/ethernet/cisco/enic/enic_main.c    |  2 +-
 drivers/net/ethernet/qlogic/qlge/qlge_main.c   | 23 +++-----
 drivers/net/ethernet/realtek/r8169.c           |  1 +
 drivers/net/hyperv/netvsc_drv.c                |  5 ++
 drivers/pci/host/pci-mvebu.c                   |  2 +-
 drivers/platform/x86/asus-nb-wmi.c             |  1 +
 drivers/platform/x86/intel_punit_ipc.c         |  1 +
 drivers/s390/block/dasd_eckd.c                 | 10 +++-
 drivers/scsi/aic94xx/aic94xx_init.c            |  4 +-
 drivers/staging/comedi/drivers/ni_mio_common.c |  3 +-
 drivers/vhost/vhost.c                          |  2 +-
 drivers/virtio/virtio_pci_legacy.c             | 14 ++++-
 fs/btrfs/dev-replace.c                         |  6 ++
 fs/btrfs/disk-io.c                             | 10 ++--
 fs/btrfs/extent-tree.c                         |  2 +-
 fs/btrfs/relocation.c                          | 23 ++++----
 fs/cifs/cifs_debug.c                           |  8 +++
 fs/cifs/smb2misc.c                             |  7 +++
 fs/cifs/smb2pdu.c                              |  2 +-
 fs/dcache.c                                    |  3 +-
 fs/fat/cache.c                                 | 19 ++++---
 fs/fat/fat.h                                   |  5 ++
 fs/fat/fatent.c                                |  6 +-
 fs/hfs/brec.c                                  |  7 ++-
 fs/hfsplus/dir.c                               |  4 +-
 fs/hfsplus/super.c                             |  4 +-
 fs/reiserfs/reiserfs.h                         |  2 +-
 include/linux/pci_ids.h                        |  2 +
 kernel/fork.c                                  |  2 +
 lib/debugobjects.c                             |  7 ++-
 mm/fadvise.c                                   |  8 ++-
 mm/huge_memory.c                               |  2 +-
 net/9p/trans_fd.c                              | 10 ++--
 net/9p/trans_virtio.c                          |  3 +-
 net/ipv4/tcp_ipv4.c                            |  6 ++
 net/ipv4/tcp_minisocks.c                       |  3 +-
 net/ipv4/tcp_probe.c                           |  4 +-
 net/ipv6/ip6_vti.c                             |  2 +-
 net/irda/af_irda.c                             | 13 ++++-
 net/netfilter/ipvs/ip_vs_core.c                | 15 +++--
 net/rds/ib_frmr.c                              |  1 +
 net/sched/act_ife.c                            | 79 +++++++++++++++-----------
 net/sched/cls_u32.c                            |  8 ++-
 net/sched/sch_hhf.c                            |  3 +
 net/sched/sch_htb.c                            |  5 +-
 net/sched/sch_multiq.c                         |  9 +--
 net/sched/sch_netem.c                          |  4 +-
 net/sched/sch_tbf.c                            |  5 +-
 net/sctp/proc.c                                |  4 --
 net/sctp/socket.c                              | 22 ++++---
 net/sunrpc/auth_gss/gss_krb5_crypto.c          | 12 +++-
 scripts/depmod.sh                              |  4 +-
 scripts/mod/modpost.c                          |  8 +--
 sound/soc/codecs/wm8994.c                      |  1 +
 tools/perf/arch/powerpc/util/sym-handling.c    |  4 +-
 tools/testing/selftests/powerpc/harness.c      | 18 ++++--
 82 files changed, 376 insertions(+), 190 deletions(-)



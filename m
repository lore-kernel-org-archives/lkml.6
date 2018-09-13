Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84380C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA7920854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA7920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeIMSwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:52:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60178 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeIMSwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:52:00 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9276ED10;
        Thu, 13 Sep 2018 13:42:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/115] 4.14.70-stable review
Date:   Thu, 13 Sep 2018 15:30:20 +0200
Message-Id: <20180913131823.327472833@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.70-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.70-rc1
X-KernelTest-Deadline: 2018-09-15T13:18+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.70 release.
There are 115 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Sep 15 13:17:48 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.70-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.70-rc1

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Handle mismatched cache type

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Fix mismatched cache line size detection

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ASoC: wm8994: Fix missing break in switch

Arnd Bergmann <arnd@arndb.de>
    arm64: cpu_errata: include required headers

Arnd Bergmann <arnd@arndb.de>
    x86: kvm: avoid unused variable warning

Junaid Shahid <junaids@google.com>
    kvm: x86: Set highest physical address bits in non-present/reserved SPTEs

Fabio Estevam <fabio.estevam@nxp.com>
    Revert "ARM: imx_v6_v7_defconfig: Select ULPI support"

Tyler Hicks <tyhicks@canonical.com>
    irda: Only insert new objects into the global database via setsockopt

Tyler Hicks <tyhicks@canonical.com>
    irda: Fix memory leak caused by repeated binds of irda socket

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/lib: use expoline for all bcr instructions

Randy Dunlap <rdunlap@infradead.org>
    kbuild: make missing $DEPMOD a Warning instead of an Error

Fredrik Schön <fredrikschon@gmail.com>
    drm/i915: Increase LSPCON timeout

Juergen Gross <jgross@suse.com>
    x86/xen: don't write ptes directly in 32-bit PV guests

Juergen Gross <jgross@suse.com>
    x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear

Roger Quadros <rogerq@ti.com>
    usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init during suspend/resume

Dave Young <dyoung@redhat.com>
    HID: add quirk for another PIXART OEM mouse used by HP

Jan H. Schönherr <jschoenh@amazon.de>
    mm: Fix devm_memremap_pages() collision handling

Javier González <javier@cnexlabs.com>
    lightnvm: pblk: free padded entries in write buffer

Luca Abeni <luca.abeni@santannapisa.it>
    sched/deadline: Fix switching to -deadline

Joel Fernandes (Google) <joel@joelfernandes.org>
    debugobjects: Make stack check warning more informative

Randy Dunlap <rdunlap@infradead.org>
    uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name

Likun Gao <Likun.Gao@amd.com>
    drm/amdgpu:add VCN booting with firmware loaded by PSP

Likun Gao <Likun.Gao@amd.com>
    drm/amdgpu:add VCN support in PSP driver

Likun Gao <Likun.Gao@amd.com>
    drm/amdgpu:add new firmware id for VCN

James Zhu <jzhums@gmail.com>
    drm/amdgpu:add tmr mc address into amdgpu_firmware_info

James Zhu <jzhums@gmail.com>
    drm/amdgpu: update tmr mc address

Kai-Heng Feng <kai.heng.feng@canonical.com>
    drm/edid: Add 6 bpc quirk for SDC panel in Lenovo B50-80

Rex Zhu <rex.zhu@amd.com>
    drm/amd/pp/Polaris12: Fix a chunk of registers missed to program

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Fix RLC safe mode test in gfx_v9_0_enter_rlc_safe_mode

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/lpe: Mark LPE audio runtime pm as "no callbacks"

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

Qu Wenruo <wqu@suse.com>
    btrfs: Exit gracefully when chunk map cannot be inserted to the tree

Jim Mattson <jmattson@google.com>
    kvm: nVMX: Fix fault vector for VMX operation at CPL > 0

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: vmx: track host_state.loaded using a loaded_vmcs pointer

Levin Du <djw@t-chip.com.cn>
    clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Make rfi_flush_fallback a little more robust

Randy Dunlap <rdunlap@infradead.org>
    powerpc/platforms/85xx: fix t1042rdb_diu.c build errors & warning

Steve French <stfrench@microsoft.com>
    SMB3: Number of requests sent should be displayed for SMB3 not just CIFS

Steve French <stfrench@microsoft.com>
    smb3: fix reset of bytes read and written stats

Bart Van Assche <bart.vanassche@wdc.com>
    cfq: Suppress compiler warnings about comparisons

YueHaibing <yuehaibing@huawei.com>
    RDS: IB: fix 'passing zero to ERR_PTR()' warning

Breno Leitao <leitao@debian.org>
    selftests/powerpc: Kill child processes on SIGINT

Ralf Goebel <ralf.goebel@imago-technologies.com>
    iommu/omap: Fix cache flushes on L2 table entries

Matthias Kaehlcke <mka@chromium.org>
    ASoC: rt5677: Fix initialization of rt5677_of_match.data

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: ni_mio_common: fix subdevice flags for PFI subdevice

John Pittman <jpittman@redhat.com>
    dm kcopyd: avoid softlockup in run_complete_job

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    PCI: mvebu: Fix I/O space end address calculation

Roger Pau Monne <roger.pau@citrix.com>
    xen/balloon: fix balloon initialization for PVH Dom0

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: do not use WARN() in input_alloc_absinfo()

Wei Yongjun <weiyongjun1@huawei.com>
    NFSv4: Fix error handling in nfs4_sp4_select_mode()

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

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/uaccess: Enable get_user(u64, *p) on 32-bit

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to clear PG_checked flag in set_page_dirty()

Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
    net/9p: fix error path of p9_virtio_probe

Tomas Bortoli <tomasbortoli@gmail.com>
    net/9p/trans_fd.c: fix race by holding the lock

Jonas Gorski <jonas.gorski@gmail.com>
    irqchip/bcm7038-l1: Hide cpu offline callback when building for !SMP

Benno Evers <bevers@mesosphere.com>
    perf tools: Check for null when copying nsinfo.

Jian Shen <shenjian15@huawei.com>
    net: hns3: Fix for phy link issue when using marvell phy driver

Xi Wang <wangxi11@huawei.com>
    net: hns3: Fix for command format parsing error in hclge_is_all_function_id_zero

Gal Pressman <pressmangal@gmail.com>
    RDMA/hns: Fix usage of bitmap allocation functions return values

Daniel Borkmann <daniel@iogearbox.net>
    tcp, ulp: add alias for all ulp modules

Florian Westphal <fw@strlen.de>
    netfilter: fix memory leaks on netlink_dump_start error

Aleh Filipovich <aleh@vaolix.com>
    platform/x86: asus-nb-wmi: Add keymap entry for lid flip action on UX360

Guenter Roeck <linux@roeck-us.net>
    mfd: sm501: Set coherent_dma_mask when creating subdevices

Tan Hu <tan.hu@zte.com.cn>
    ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()

Philipp Rudo <prudo@linux.ibm.com>
    s390/kdump: Fix memleak in nt_vmcoreinfo

Florian Westphal <fw@strlen.de>
    netfilter: ip6t_rpfilter: set F_IFACE for linklocal addresses

Randy Dunlap <rdunlap@infradead.org>
    platform/x86: intel_punit_ipc: fix build errors

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs/dcache.c: fix kmemcheck splat at take_dentry_name_snapshot()

Andrey Ryabinin <aryabinin@virtuozzo.com>
    mm/fadvise.c: fix signed overflow UBSAN complaint

Jerome Brunet <jbrunet@baylibre.com>
    pwm: meson: Fix mux clock names

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Invalid NUMA node information can cause a divide by zero

Arnd Bergmann <arnd@arndb.de>
    x86/mce: Add notifier_block forward declaration

Suzuki K Poulose <suzuki.poulose@arm.com>
    virtio: pci-legacy: Validate queue pfn

Randy Dunlap <rdunlap@infradead.org>
    scripts: modpost: check memory allocation results

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
    fat: validate ->i_start before using

James Morse <james.morse@arm.com>
    fs/proc/kcore.c: use __pa_symbol() for KCORE_TEXT list entries

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

Dexuan Cui <decui@microsoft.com>
    hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: ignore devices that are not PCI

Jason Wang <jasowang@redhat.com>
    vhost: correctly check the iova range when waking virtqueue

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_switchdev: Do not leak RIFs when removing bridge

Xin Long <lucien.xin@gmail.com>
    sctp: hold transport before accessing its asoc in sctp_transport_get_next

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: wait for posted reconfigs when disabling the device

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: fix a missing rhashtable_walk_exit()

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_pedit: fix dump of extended layered op

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

Anssi Hannula <anssi.hannula@bitwise.fi>
    net: macb: do not disable MDIO bus at open/close time

Doug Berger <opendmb@gmail.com>
    net: bcmgenet: use MAC link status for fixed phy

Eric Dumazet <edumazet@google.com>
    ipv4: tcp: send zero IPID for RST and ACK sent in SYN-RECV and TIME-WAIT state

Cong Wang <xiyou.wangcong@gmail.com>
    act_ife: fix a potential use-after-free


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/configs/imx_v6_v7_defconfig               |  2 -
 arch/arm/mach-rockchip/Kconfig                     |  1 +
 arch/arm64/Kconfig.platforms                       |  1 +
 arch/arm64/include/asm/cache.h                     |  5 ++
 arch/arm64/include/asm/cpucaps.h                   |  3 +-
 arch/arm64/kernel/cpu_errata.c                     | 25 +++++--
 arch/arm64/kernel/cpufeature.c                     |  4 +-
 arch/powerpc/include/asm/uaccess.h                 | 13 +++-
 arch/powerpc/kernel/exceptions-64s.S               |  6 ++
 arch/powerpc/platforms/85xx/t1042rdb_diu.c         |  4 ++
 arch/powerpc/platforms/pseries/ras.c               |  2 +-
 arch/powerpc/sysdev/mpic_msgr.c                    |  2 +-
 arch/s390/kernel/crash_dump.c                      | 17 +++--
 arch/s390/lib/mem.S                                | 12 ++--
 arch/x86/include/asm/mce.h                         |  1 +
 arch/x86/include/asm/pgtable-3level.h              |  7 +-
 arch/x86/kvm/mmu.c                                 | 43 ++++++++++--
 arch/x86/kvm/vmx.c                                 | 26 ++++---
 arch/x86/kvm/x86.c                                 | 12 ++--
 arch/x86/xen/mmu_pv.c                              |  7 +-
 block/bio.c                                        |  2 +-
 block/cfq-iosched.c                                | 22 +++---
 drivers/acpi/scan.c                                |  5 +-
 drivers/clk/rockchip/clk-rk3399.c                  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            | 17 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |  3 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              | 40 ++++++++---
 .../gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c   | 43 ++++++++++++
 drivers/gpu/drm/drm_edid.c                         |  3 +
 drivers/gpu/drm/i915/intel_lpe_audio.c             |  4 +-
 drivers/gpu/drm/i915/intel_lspcon.c                |  2 +-
 drivers/hid/hid-ids.h                              |  1 +
 drivers/hid/usbhid/hid-quirks.c                    |  1 +
 drivers/infiniband/hw/hfi1/affinity.c              | 24 ++++++-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  5 +-
 drivers/input/input.c                              | 16 +++--
 drivers/iommu/omap-iommu.c                         |  4 +-
 drivers/irqchip/irq-bcm7038-l1.c                   |  4 ++
 drivers/lightnvm/pblk-core.c                       |  1 -
 drivers/lightnvm/pblk-write.c                      |  7 +-
 drivers/md/dm-kcopyd.c                             |  2 +
 drivers/mfd/sm501.c                                |  1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |  3 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       | 10 ++-
 drivers/net/ethernet/cadence/macb_main.c           |  9 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  2 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |  2 +
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  | 11 +++
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 20 ++++++
 .../net/ethernet/netronome/nfp/nfp_net_common.c    | 48 +++++++++----
 drivers/net/ethernet/qlogic/qlge/qlge_main.c       | 23 +++----
 drivers/net/ethernet/realtek/r8169.c               |  1 +
 drivers/net/hyperv/netvsc_drv.c                    | 16 ++++-
 drivers/pci/host/pci-mvebu.c                       |  2 +-
 drivers/platform/x86/asus-nb-wmi.c                 |  1 +
 drivers/platform/x86/intel_punit_ipc.c             |  1 +
 drivers/pwm/pwm-meson.c                            |  3 +-
 drivers/s390/block/dasd_eckd.c                     | 10 ++-
 drivers/scsi/aic94xx/aic94xx_init.c                |  4 +-
 drivers/staging/comedi/drivers/ni_mio_common.c     |  3 +-
 drivers/staging/irda/net/af_irda.c                 | 13 +++-
 drivers/usb/dwc3/core.c                            | 47 ++++++++++---
 drivers/usb/dwc3/core.h                            |  5 ++
 drivers/vhost/vhost.c                              |  2 +-
 drivers/virtio/virtio_pci_legacy.c                 | 14 +++-
 drivers/xen/xen-balloon.c                          |  2 +-
 fs/btrfs/dev-replace.c                             |  6 ++
 fs/btrfs/extent-tree.c                             |  2 +-
 fs/btrfs/relocation.c                              | 23 ++++---
 fs/btrfs/volumes.c                                 |  8 ++-
 fs/cifs/cifs_debug.c                               |  8 +++
 fs/cifs/smb2misc.c                                 |  7 ++
 fs/cifs/smb2pdu.c                                  |  2 +-
 fs/dcache.c                                        |  3 +-
 fs/f2fs/data.c                                     |  4 ++
 fs/fat/cache.c                                     | 19 ++++--
 fs/fat/fat.h                                       |  5 ++
 fs/fat/fatent.c                                    |  6 +-
 fs/hfs/brec.c                                      |  7 +-
 fs/hfsplus/dir.c                                   |  4 +-
 fs/hfsplus/super.c                                 |  4 +-
 fs/nfs/nfs4proc.c                                  |  2 +-
 fs/proc/kcore.c                                    |  4 +-
 fs/reiserfs/reiserfs.h                             |  2 +-
 include/linux/pci_ids.h                            |  2 +
 include/net/tcp.h                                  |  4 ++
 include/uapi/linux/keyctl.h                        |  2 +-
 kernel/fork.c                                      |  2 +
 kernel/memremap.c                                  | 11 +--
 kernel/sched/deadline.c                            | 11 ++-
 lib/debugobjects.c                                 |  7 +-
 mm/fadvise.c                                       |  8 ++-
 net/9p/trans_fd.c                                  | 10 +--
 net/9p/trans_virtio.c                              |  3 +-
 net/ipv4/tcp_ipv4.c                                |  6 ++
 net/ipv4/tcp_minisocks.c                           |  3 +-
 net/ipv4/tcp_ulp.c                                 |  2 +-
 net/ipv6/ip6_vti.c                                 |  2 +-
 net/ipv6/netfilter/ip6t_rpfilter.c                 | 12 +++-
 net/netfilter/ipvs/ip_vs_core.c                    | 15 ++--
 net/netfilter/nf_conntrack_netlink.c               | 26 ++++---
 net/netfilter/nfnetlink_acct.c                     | 29 ++++----
 net/rds/ib_frmr.c                                  |  1 +
 net/sched/act_ife.c                                | 79 ++++++++++++----------
 net/sched/act_pedit.c                              | 18 +++--
 net/sched/cls_u32.c                                |  8 ++-
 net/sctp/proc.c                                    |  4 --
 net/sctp/socket.c                                  | 22 ++++--
 net/sunrpc/auth_gss/gss_krb5_crypto.c              | 12 +++-
 net/tipc/socket.c                                  |  2 +
 net/tls/tls_main.c                                 |  1 +
 scripts/depmod.sh                                  |  4 +-
 scripts/mod/modpost.c                              |  8 +--
 security/keys/dh.c                                 |  2 +-
 sound/soc/codecs/rt5677.c                          |  2 +-
 sound/soc/codecs/wm8994.c                          |  1 +
 tools/perf/arch/powerpc/util/sym-handling.c        |  4 +-
 tools/perf/util/namespaces.c                       |  3 +
 tools/testing/selftests/powerpc/harness.c          | 18 +++--
 125 files changed, 812 insertions(+), 320 deletions(-)



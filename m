Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0006C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975A020854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975A020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbeIMTCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:02:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33532 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbeIMTCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:02:16 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79794CE7;
        Thu, 13 Sep 2018 13:52:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 000/197] 4.18.8-stable review
Date:   Thu, 13 Sep 2018 15:29:09 +0200
Message-Id: <20180913131841.568116777@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.8-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.8-rc1
X-KernelTest-Deadline: 2018-09-15T13:18+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.8 release.
There are 197 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Sep 15 13:17:57 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.8-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.8-rc1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ASoC: wm8994: Fix missing break in switch

Robert Munteanu <rombert@apache.org>
    HID: redragon: fix num lock and caps lock LEDs

Arnd Bergmann <arnd@arndb.de>
    x86: kvm: avoid unused variable warning

Junaid Shahid <junaids@google.com>
    kvm: x86: Set highest physical address bits in non-present/reserved SPTEs

Randy Dunlap <rdunlap@infradead.org>
    kbuild: make missing $DEPMOD a Warning instead of an Error

Juergen Gross <jgross@suse.com>
    x86/xen: don't write ptes directly in 32-bit PV guests

Juergen Gross <jgross@suse.com>
    x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear

Joel Fernandes (Google) <joel@joelfernandes.org>
    debugobjects: Make stack check warning more informative

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Don't warn on destroying a pinned BO

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Warn and update pin_size values when destroying a pinned BO

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Make pin_size values atomic

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Keep track of amount of pinned CPU visible VRAM

Chuanhua Lei <chuanhua.lei@linux.intel.com>
    x86/tsc: Prevent result truncation on 32bit

Jani Nikula <jani.nikula@intel.com>
    drm/i915: set DP Main Stream Attribute for color range on DDI platforms

Nadav Amit <namit@vmware.com>
    mm: respect arch_dup_mmap() return value

Randy Dunlap <rdunlap@infradead.org>
    uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name

Jan-Marek Glogowski <glogow@fbihome.de>
    drm/i915: Re-apply "Perform link quality check, unconditionally during long pulse"

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix incorrect use of drm_file->pid

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix incorrect use of fcheck

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

Mikita Lipski <mikita.lipski@amd.com>
    drm/amd/display: Check if clock source in use before disabling

Mikita Lipski <mikita.lipski@amd.com>
    drm/amd/display: Pass connector id when executing VBIOS CT

Sandy Huang <hjc@rock-chips.com>
    drm/rockchip: vop: fix irq disabled after vop driver probed

Heiko Stuebner <heiko@sntech.de>
    drm/rockchip: vop: split out core clock enablement into separate functions

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/rockchip: lvds: add missing of_node_put

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Report non-DP display as disconnected without EDID

Leo (Sunpeng) Li <sunpeng.li@amd.com>
    drm/amd/display: Use requested HDMI aspect ratio

Mikita Lipski <mikita.lipski@amd.com>
    drm/amd/display: update clk for various HDMI color depths

Mikita Lipski <mikita.lipski@amd.com>
    drm/amd/display: Don't share clk source between DP and HDMI

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/amd/display: fix type of variable

Kai-Heng Feng <kai.heng.feng@canonical.com>
    drm/edid: Add 6 bpc quirk for SDC panel in Lenovo B50-80

Lubosz Sarnecki <lubosz.sarnecki@collabora.com>
    drm/edid: Quirk Vive Pro VR headset non-desktop.

Rex Zhu <rex.zhu@amd.com>
    drm/amd/pp/Polaris12: Fix a chunk of registers missed to program

Evan Quan <evan.quan@amd.com>
    drm/amd/powerplay: fixed uninitialized value

Rex Zhu <rex.zhu@amd.com>
    drm/amd/pp: Convert voltage unit in mV*4 to mV on CZ/ST

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Fix RLC safe mode test in gfx_v9_0_enter_rlc_safe_mode

Rex Zhu <rex.zhu@amd.com>
    drm/amdgpu: fix a reversed condition

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: update uvd_v6_0_ring_vm_funcs to use new nop packet

Rodrigo Vivi <rodrigo.vivi@intel.com>
    drm/i915: Free write_buf that we allocated with kzalloc.

Fredrik Schön <fredrikschon@gmail.com>
    drm/i915: Increase LSPCON timeout

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Nuke the LVDS lid notifier

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/lpe: Mark LPE audio runtime pm as "no callbacks"

David Sterba <dsterba@suse.com>
    btrfs: fix mount and ioctl device scan ioctl race

David Sterba <dsterba@suse.com>
    btrfs: reorder initialization before the mount locks uuid_mutex

David Sterba <dsterba@suse.com>
    btrfs: lift uuid_mutex to callers of btrfs_parse_early_options

David Sterba <dsterba@suse.com>
    btrfs: lift uuid_mutex to callers of btrfs_scan_one_device

Anand Jain <anand.jain@oracle.com>
    btrfs: use device_list_mutex when removing stale devices

Anand Jain <anand.jain@oracle.com>
    btrfs: rename local devices for fs_devices in btrfs_free_stale_devices(

Anand Jain <anand.jain@oracle.com>
    btrfs: extend locked section when adding a new device in device_list_add

Anand Jain <anand.jain@oracle.com>
    btrfs: do btrfs_free_stale_devices outside of device_list_add

Marc Zyngier <marc.zyngier@arm.com>
    ARM: rockchip: Force CONFIG_PM on Rockchip systems

Marc Zyngier <marc.zyngier@arm.com>
    arm64: rockchip: Force CONFIG_PM on Rockchip systems

Bart Van Assche <bart.vanassche@wdc.com>
    btrfs: Fix a C compliance issue

Qu Wenruo <wqu@suse.com>
    btrfs: Don't remove block group that still has pinned down bytes

David Sterba <dsterba@suse.com>
    btrfs: lift uuid_mutex to callers of btrfs_open_devices

Qu Wenruo <wqu@suse.com>
    btrfs: check-integrity: Fix NULL pointer dereference for degraded mount

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Detect invalid and empty essential trees

Qu Wenruo <wqu@suse.com>
    btrfs: relocation: Only remove reloc rb_trees if reloc control has been initialized

Anand Jain <anand.jain@oracle.com>
    btrfs: fix in-memory value of total_devices after seed device deletion

Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
    btrfs: replace: Reset on-disk dev stats value after replace

Qu Wenruo <wqu@suse.com>
    btrfs: Exit gracefully when chunk map cannot be inserted to the tree

Lucas Stach <l.stach@pengutronix.de>
    drm/etnaviv: fix crash in GPU suspend when init failed due to buffer placement

Jim Mattson <jmattson@google.com>
    kvm: nVMX: Fix fault vector for VMX operation at CPL > 0

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: vmx: track host_state.loaded using a loaded_vmcs pointer

David Francis <David.Francis@amd.com>
    drm/amd/display: Read back max backlight value at boot

Levin Du <djw@t-chip.com.cn>
    clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.

Masahiro Yamada <yamada.masahiro@socionext.com>
    um: fix parallel building with O= option

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Make rfi_flush_fallback a little more robust

Randy Dunlap <rdunlap@infradead.org>
    powerpc/platforms/85xx: fix t1042rdb_diu.c build errors & warning

Steve French <stfrench@microsoft.com>
    smb3: if server does not support posix do not allow posix mount option

Steve French <stfrench@microsoft.com>
    SMB3: Number of requests sent should be displayed for SMB3 not just CIFS

Aurelien Aptel <aaptel@suse.com>
    CIFS: fix memory leak and remove dead code

Steve French <stfrench@microsoft.com>
    smb3: fix reset of bytes read and written stats

Bart Van Assche <bart.vanassche@wdc.com>
    cfq: Suppress compiler warnings about comparisons

YueHaibing <yuehaibing@huawei.com>
    RDS: IB: fix 'passing zero to ERR_PTR()' warning

nixiaoming <nixiaoming@huawei.com>
    selinux: cleanup dentry and inodes on error in selinuxfs

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

Jianchao Wang <jianchao.w.wang@oracle.com>
    blk-mq: count the hctx as active before allocating tag

Hans de Goede <hdegoede@redhat.com>
    ACPI / scan: Initialize status to ACPI_STA_DEFAULT

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix panic for failed online processing

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging offline processing due to canceled worker

Winnie Chang <winnie.chang@cypress.com>
    brcmfmac: fix brcmf_wiphy_wowl_params() NULL pointer dereference

Greg Edwards <gedwards@ddn.com>
    block: bvec_nr_vecs() returns value for wrong slab

Sandipan Das <sandipan@linux.ibm.com>
    perf probe powerpc: Fix trace event post-processing

Dan Carpenter <dan.carpenter@oracle.com>
    powerpc: Fix size calculation using resource_size()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/uaccess: Enable get_user(u64, *p) on 32-bit

Yonghong Song <yhs@fb.com>
    bpf: fix bpffs non-array map seq_show issue

Anton Vasilyev <vasilyev@ispras.ru>
    pinctrl: axp209: Fix NULL pointer dereference after allocation

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to clear PG_checked flag in set_page_dirty()

Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
    net/9p: fix error path of p9_virtio_probe

Tomas Bortoli <tomasbortoli@gmail.com>
    net/9p/trans_fd.c: fix race by holding the lock

Jonas Gorski <jonas.gorski@gmail.com>
    irqchip/bcm7038-l1: Hide cpu offline callback when building for !SMP

Dan Carpenter <dan.carpenter@oracle.com>
    irqchip/stm32: Fix init error handling

Palmer Dabbelt <palmer@sifive.com>
    RISC-V: Use KBUILD_CFLAGS instead of KCFLAGS when building the vDSO

Chao Yu <yuchao0@huawei.com>
    f2fs: fix avoid race between truncate and background GC

Chao Yu <yuchao0@huawei.com>
    f2fs: avoid race between zero_range and background GC

Benno Evers <bevers@mesosphere.com>
    perf tools: Check for null when copying nsinfo.

Denis Efremov <efremov@linux.com>
    coccicheck: return proper error code on fail

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Guard against null crtc in CRC IRQ

Myron Stowe <myron.stowe@redhat.com>
    PCI: Match Root Port's MPS to endpoint's MPSS as necessary

Jian Shen <shenjian15@huawei.com>
    net: hns3: Fix for phy link issue when using marvell phy driver

Jens Axboe <axboe@kernel.dk>
    block: don't warn for flush on read-only device

Xi Wang <wangxi11@huawei.com>
    net: hns3: Fix for command format parsing error in hclge_is_all_function_id_zero

Kim Phillips <kim.phillips@arm.com>
    perf arm spe: Fix uninitialized record error variable

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: ACPICA: add status check for acpi_hw_read before assigning return value

Gal Pressman <pressmangal@gmail.com>
    RDMA/hns: Fix usage of bitmap allocation functions return values

Richard Weinberger <richard@nod.at>
    ubi: Initialize Fastmap checkmapping correctly

Daniel Borkmann <daniel@iogearbox.net>
    tcp, ulp: add alias for all ulp modules

Florian Westphal <fw@strlen.de>
    netfilter: fix memory leaks on netlink_dump_start error

Aleh Filipovich <aleh@vaolix.com>
    platform/x86: asus-nb-wmi: Add keymap entry for lid flip action on UX360

Michal Hocko <mhocko@suse.com>
    netfilter: x_tables: do not fail xt_alloc_table_info too easilly

Guenter Roeck <linux@roeck-us.net>
    mfd: sm501: Set coherent_dma_mask when creating subdevices

Tan Hu <tan.hu@zte.com.cn>
    ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()

Philipp Rudo <prudo@linux.ibm.com>
    s390/kdump: Fix memleak in nt_vmcoreinfo

Florian Westphal <fw@strlen.de>
    netfilter: ip6t_rpfilter: set F_IFACE for linklocal addresses

Jesper Dangaard Brouer <brouer@redhat.com>
    samples/bpf: all XDP samples should unload xdp/bpf prog on SIGTERM

Daniel Borkmann <daniel@iogearbox.net>
    bpf, sockmap: fix leakage of smap_psock_map_entry

Tariq Toukan <tariqt@mellanox.com>
    net/xdp: Fix suspicious RCU usage warning

Daniel Borkmann <daniel@iogearbox.net>
    bpf, sockmap: fix sock_map_ctx_update_elem race with exist/noexist

Daniel Borkmann <daniel@iogearbox.net>
    tcp, ulp: fix leftover icsk_ulp_ops preventing sock from reattach

Daniel Borkmann <daniel@iogearbox.net>
    bpf, sockmap: fix map elem deletion race with smap_stop_sock

Randy Dunlap <rdunlap@infradead.org>
    platform/x86: intel_punit_ipc: fix build errors

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs/dcache.c: fix kmemcheck splat at take_dentry_name_snapshot()

Mike Rapoport <rppt@linux.vnet.ibm.com>
    mm: make DEFERRED_STRUCT_PAGE_INIT explicitly depend on SPARSEMEM

Andrey Ryabinin <aryabinin@virtuozzo.com>
    mm/fadvise.c: fix signed overflow UBSAN complaint

Srikar Dronamraju <srikar@linux.vnet.ibm.com>
    powerpc/topology: Get topology for shared processors at boot

Jerome Brunet <jbrunet@baylibre.com>
    pwm: meson: Fix mux clock names

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Invalid NUMA node information can cause a divide by zero

Hans de Goede <hdegoede@redhat.com>
    i2c: core: ACPI: Make acpi_gsb_i2c_read_bytes() check i2c_transfer return value

Arnd Bergmann <arnd@arndb.de>
    x86/mce: Add notifier_block forward declaration

Suzuki K Poulose <suzuki.poulose@arm.com>
    virtio: pci-legacy: Validate queue pfn

Dan Carpenter <dan.carpenter@oracle.com>
    apparmor: fix an error code in __aa_create_ns()

Randy Dunlap <rdunlap@infradead.org>
    scripts: modpost: check memory allocation results

Johannes Berg <johannes.berg@intel.com>
    workqueue: re-add lockdep dependencies for flushing

Johannes Berg <johannes.berg@intel.com>
    workqueue: skip lockdep wq dependency in cancel_work_sync()

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
    fat: validate ->i_start before using

James Morse <james.morse@arm.com>
    fs/proc/kcore.c: use __pa_symbol() for KCORE_TEXT list entries

Marc Zyngier <marc.zyngier@arm.com>
    iommu/rockchip: Move irq request past pm_runtime_enable

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfsplus: fix NULL dereference in hfsplus_lookup()

Marc Zyngier <marc.zyngier@arm.com>
    iommu/rockchip: Handle errors returned from PM framework

Arnd Bergmann <arnd@arndb.de>
    reiserfs: change j_timestamp type to time64_t

Arnd Bergmann <arnd@arndb.de>
    fs/proc/vmcore.c: hide vmcoredd_mmap_dumps() for nommu builds

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

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    ip6_vti: fix a null pointer deference when destroy vti6 tunnel

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    ip6_vti: fix creating fallback tunnel device for vti6

Jerome Brunet <jbrunet@baylibre.com>
    Revert "net: stmmac: Do not keep rearming the coalesce timer in stmmac_xmit"

Azat Khuzhin <a3at.mail@gmail.com>
    r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5: Fix SQ offset in QPs with small RQ

David Ahern <dsahern@gmail.com>
    net/ipv6: Put lwtstate when destroying fib6_info

David Ahern <dsahern@gmail.com>
    net/ipv6: Only update MTU metric if it set

Hangbin Liu <liuhangbin@gmail.com>
    net/ipv6: init ip6 anycast rt->dst.input as ip6_input

Alexey Kodanev <alexey.kodanev@oracle.com>
    ipv6: don't get lwtstate twice in ip6_rt_copy_init()

Ahmad Fatoum <a.fatoum@pengutronix.de>
    net: macb: Fix regression breaking non-MDIO fixed-link PHYs

Xin Long <lucien.xin@gmail.com>
    erspan: set erspan_ver to 1 by default when adding an erspan dev

Xin Long <lucien.xin@gmail.com>
    sctp: remove useless start_fail from sctp_ht_iter in proc

Haiqing Bai <Haiqing.Bai@windriver.com>
    tipc: fix the big/little endian issue in tipc_dest

Dexuan Cui <decui@microsoft.com>
    hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: fix a missing rhashtable_walk_exit()

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_pedit: fix dump of extended layered op

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Do not adjust max_cp_rings by the ones used by RDMA.

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Clean up unused functions.

Vlad Buslov <vladbu@mellanox.com>
    net: sched: action_ife: take reference to meta module

Cong Wang <xiyou.wangcong@gmail.com>
    act_ife: fix a potential deadlock

Cong Wang <xiyou.wangcong@gmail.com>
    act_ife: move tcfa_lock down to where necessary

Alexey Kodanev <alexey.kodanev@oracle.com>
    vti6: remove !skb->ignore_df check from vti6_xmit()

Florian Westphal <fw@strlen.de>
    tcp: do not restart timewait timer on rst reception

Anthony Wong <anthony.wong@ubuntu.com>
    r8169: add support for NCube 8168 network card

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8152: disable RX aggregation on new Dell TB16 dock

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

 Makefile                                           |   4 +-
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/powerpc/include/asm/topology.h                |   5 +
 arch/powerpc/include/asm/uaccess.h                 |  13 +-
 arch/powerpc/kernel/exceptions-64s.S               |   6 +
 arch/powerpc/kernel/smp.c                          |   5 +
 arch/powerpc/mm/numa.c                             |  20 +--
 arch/powerpc/platforms/85xx/t1042rdb_diu.c         |   4 +
 arch/powerpc/platforms/pseries/ras.c               |   2 +-
 arch/powerpc/sysdev/mpic_msgr.c                    |   2 +-
 arch/riscv/kernel/vdso/Makefile                    |   4 +-
 arch/s390/kernel/crash_dump.c                      |  17 ++-
 arch/um/Makefile                                   |   3 +-
 arch/x86/include/asm/mce.h                         |   1 +
 arch/x86/include/asm/pgtable-3level.h              |   7 +-
 arch/x86/kernel/tsc.c                              |   4 +-
 arch/x86/kvm/mmu.c                                 |  43 ++++++-
 arch/x86/kvm/vmx.c                                 |  26 ++--
 arch/x86/kvm/x86.c                                 |  12 +-
 arch/x86/xen/mmu_pv.c                              |   7 +-
 block/bio.c                                        |   2 +-
 block/blk-core.c                                   |   4 +-
 block/blk-mq-tag.c                                 |   3 +
 block/blk-mq.c                                     |   8 +-
 block/cfq-iosched.c                                |  22 ++--
 drivers/acpi/acpica/hwregs.c                       |   9 +-
 drivers/acpi/scan.c                                |   5 +-
 drivers/clk/rockchip/clk-rk3399.c                  |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  23 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  38 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |  21 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  17 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |  20 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |   3 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  40 ++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  10 +-
 .../gpu/drm/amd/display/dc/bios/command_table.c    |  18 +++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  11 ++
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  68 ++++++++---
 drivers/gpu/drm/amd/display/dc/dc.h                |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |   4 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |   2 +-
 .../drm/amd/display/dc/dce110/dce110_compressor.c  |   2 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   4 +-
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   3 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |   5 +
 .../gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c   |  43 +++++++
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c   |   5 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |   2 +-
 drivers/gpu/drm/drm_edid.c                         |   6 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   1 +
 drivers/gpu/drm/i915/i915_drv.c                    |  10 --
 drivers/gpu/drm/i915/i915_drv.h                    |   8 --
 drivers/gpu/drm/i915/i915_reg.h                    |   1 +
 drivers/gpu/drm/i915/intel_ddi.c                   |   4 +
 drivers/gpu/drm/i915/intel_dp.c                    |  33 ++---
 drivers/gpu/drm/i915/intel_hdmi.c                  |   8 +-
 drivers/gpu/drm/i915/intel_lpe_audio.c             |   4 +-
 drivers/gpu/drm/i915/intel_lspcon.c                |   2 +-
 drivers/gpu/drm/i915/intel_lvds.c                  | 136 +--------------------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  69 +++++++----
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |   4 +-
 drivers/hid/hid-redragon.c                         |  26 +---
 drivers/i2c/i2c-core-acpi.c                        |   8 +-
 drivers/infiniband/hw/hfi1/affinity.c              |  24 +++-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |   2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   5 +-
 drivers/input/input.c                              |  16 ++-
 drivers/iommu/omap-iommu.c                         |   4 +-
 drivers/iommu/rockchip-iommu.c                     |  45 ++++---
 drivers/irqchip/irq-bcm7038-l1.c                   |   4 +
 drivers/irqchip/irq-stm32-exti.c                   |  25 ++--
 drivers/md/dm-kcopyd.c                             |   2 +
 drivers/mfd/sm501.c                                |   1 +
 drivers/mtd/ubi/vtbl.c                             |  20 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |   7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |  20 ---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |   1 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |   3 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  10 +-
 drivers/net/ethernet/cadence/macb_main.c           |  36 ++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/wq.c       |   5 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   2 +
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  11 ++
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  20 +++
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  48 +++++---
 drivers/net/ethernet/qlogic/qlge/qlge_main.c       |  23 ++--
 drivers/net/ethernet/realtek/r8169.c               |   7 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   5 +-
 drivers/net/hyperv/netvsc_drv.c                    |  16 ++-
 drivers/net/usb/r8152.c                            |   4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   8 +-
 drivers/pci/controller/pci-mvebu.c                 |   2 +-
 drivers/pci/probe.c                                |  12 +-
 drivers/pinctrl/pinctrl-axp209.c                   |  26 +++-
 drivers/platform/x86/asus-nb-wmi.c                 |   1 +
 drivers/platform/x86/intel_punit_ipc.c             |   1 +
 drivers/pwm/pwm-meson.c                            |   3 +-
 drivers/s390/block/dasd_eckd.c                     |  10 +-
 drivers/scsi/aic94xx/aic94xx_init.c                |   4 +-
 drivers/staging/comedi/drivers/ni_mio_common.c     |   3 +-
 drivers/vhost/vhost.c                              |   2 +-
 drivers/virtio/virtio_pci_legacy.c                 |  14 ++-
 drivers/xen/xen-balloon.c                          |   2 +-
 fs/btrfs/check-integrity.c                         |   7 +-
 fs/btrfs/dev-replace.c                             |   6 +
 fs/btrfs/extent-tree.c                             |   2 +-
 fs/btrfs/relocation.c                              |  23 ++--
 fs/btrfs/super.c                                   |  44 ++++---
 fs/btrfs/tree-checker.c                            |  15 ++-
 fs/btrfs/volumes.c                                 |  94 ++++++++------
 fs/cifs/cifs_debug.c                               |   8 ++
 fs/cifs/connect.c                                  |   8 +-
 fs/cifs/smb2misc.c                                 |   7 ++
 fs/cifs/smb2pdu.c                                  | 103 ++++++++--------
 fs/dcache.c                                        |   3 +-
 fs/f2fs/data.c                                     |   8 ++
 fs/f2fs/file.c                                     |  48 +++++---
 fs/fat/cache.c                                     |  19 +--
 fs/fat/fat.h                                       |   5 +
 fs/fat/fatent.c                                    |   6 +-
 fs/hfs/brec.c                                      |   7 +-
 fs/hfsplus/dir.c                                   |   4 +-
 fs/hfsplus/super.c                                 |   4 +-
 fs/nfs/nfs4proc.c                                  |   2 +-
 fs/proc/kcore.c                                    |   4 +-
 fs/proc/vmcore.c                                   |   2 +
 fs/reiserfs/reiserfs.h                             |   2 +-
 include/linux/pci_ids.h                            |   2 +
 include/net/tcp.h                                  |   4 +
 include/uapi/linux/keyctl.h                        |   2 +-
 kernel/bpf/inode.c                                 |   8 +-
 kernel/bpf/sockmap.c                               | 120 ++++++++++--------
 kernel/fork.c                                      |   5 +-
 kernel/workqueue.c                                 |  45 ++++---
 lib/debugobjects.c                                 |   7 +-
 mm/Kconfig                                         |   2 +-
 mm/fadvise.c                                       |   8 +-
 net/9p/trans_fd.c                                  |  10 +-
 net/9p/trans_virtio.c                              |   3 +-
 net/core/xdp.c                                     |  14 +--
 net/ipv4/ip_gre.c                                  |   3 +
 net/ipv4/tcp_ipv4.c                                |   6 +
 net/ipv4/tcp_minisocks.c                           |   3 +-
 net/ipv4/tcp_ulp.c                                 |   4 +-
 net/ipv6/ip6_fib.c                                 |   7 +-
 net/ipv6/ip6_gre.c                                 |   1 +
 net/ipv6/ip6_vti.c                                 |   7 +-
 net/ipv6/netfilter/ip6t_rpfilter.c                 |  12 +-
 net/ipv6/route.c                                   |   3 +-
 net/netfilter/ipvs/ip_vs_core.c                    |  15 ++-
 net/netfilter/nf_conntrack_netlink.c               |  26 ++--
 net/netfilter/nfnetlink_acct.c                     |  29 ++---
 net/netfilter/x_tables.c                           |   7 +-
 net/rds/ib_frmr.c                                  |   1 +
 net/sched/act_ife.c                                |  78 +++++++-----
 net/sched/act_pedit.c                              |  18 ++-
 net/sched/cls_u32.c                                |  10 +-
 net/sctp/proc.c                                    |   8 --
 net/sctp/socket.c                                  |  22 ++--
 net/sunrpc/auth_gss/gss_krb5_crypto.c              |  12 +-
 net/tipc/name_table.c                              |  10 +-
 net/tipc/name_table.h                              |   9 +-
 net/tipc/socket.c                                  |   2 +
 net/tls/tls_main.c                                 |   1 +
 samples/bpf/xdp_redirect_cpu_user.c                |   3 +-
 samples/bpf/xdp_rxq_info_user.c                    |   3 +-
 scripts/coccicheck                                 |   5 +-
 scripts/depmod.sh                                  |   4 +-
 scripts/mod/modpost.c                              |   8 +-
 security/apparmor/policy_ns.c                      |   2 +-
 security/keys/dh.c                                 |   2 +-
 security/selinux/selinuxfs.c                       |  33 +++--
 sound/soc/codecs/rt5677.c                          |   2 +-
 sound/soc/codecs/wm8994.c                          |   1 +
 tools/perf/arch/arm64/util/arm-spe.c               |   1 +
 tools/perf/arch/powerpc/util/sym-handling.c        |   4 +-
 tools/perf/util/namespaces.c                       |   3 +
 tools/testing/selftests/powerpc/harness.c          |  18 ++-
 194 files changed, 1498 insertions(+), 954 deletions(-)



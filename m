Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F114ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083D920854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083D920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbeGWN1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:27:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45220 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387882AbeGWN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:27:21 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E8A0EBE1;
        Mon, 23 Jul 2018 12:26:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.17 00/63] 4.17.10-stable review
Date:   Mon, 23 Jul 2018 14:24:06 +0200
Message-Id: <20180723122446.351334162@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.17.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.17.10-rc1
X-KernelTest-Deadline: 2018-07-25T12:24+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.17.10 release.
There are 63 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jul 25 12:24:28 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.10-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.17.10-rc1

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix perceived dead host due to runtime suspend race with event handler

Al Viro <viro@zeniv.linux.org.uk>
    cxl_getfile(): fix double-iput() on alloc_file() failures

Al Viro <viro@zeniv.linux.org.uk>
    drm_mode_create_lease_ioctl(): fix open-coded filp_clone_open()

Al Viro <viro@ZenIV.linux.org.uk>
    alpha: fix osf_wait4() breakage

Alexander Couzens <lynxis@fe80.eu>
    net: usb: asix: replace mii_nway_restart in resume path

Sabrina Dubroca <sd@queasysnail.net>
    ipv6: make DAD fail with enhanced DAD when nonce length differs

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Fix CRC forwarding check for SYSTEMPORT Lite

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx4_en: Don't reuse RX page when XDP is set

Igor Russkikh <igor.russkikh@aquantia.com>
    net: aquantia: vlan unicast address list correct handling

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix napi reschedule while receive completion is busy

Xin Long <lucien.xin@gmail.com>
    sctp: fix the issue that pathmtu may be set lower than MINSEGMENT

Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
    sctp: introduce sctp_dst_mtu

Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
    net: ip6_gre: get ipv6hdr after skb_cow_head()

Sanjeev Bansal <sanjeevb.bansal@broadcom.com>
    tg3: Add higher cpu clock for 5762.

Jacob Keller <jacob.e.keller@intel.com>
    sch_fq_codel: zero q->flows_cnt when fq_codel_init fails

Taehee Yoo <ap420073@gmail.com>
    rhashtable: add restart routine in rhashtable_free_and_destroy()

Matevz Vucnik <vucnikm@gmail.com>
    qmi_wwan: add support for Quectel EG91

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ptp: fix missing break in switch

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: fix flag masking in __set_phy_supported

David Ahern <dsahern@gmail.com>
    net/ipv6: Do not allow device only routes via the multipath API

David Ahern <dsahern@gmail.com>
    net/ipv4: Set oif in fib_compute_spec_dst

Stefano Brivio <sbrivio@redhat.com>
    skbuff: Unconditionally copy pfmemalloc in __skb_clone()

Stefano Brivio <sbrivio@redhat.com>
    net: Don't copy pfmemalloc flag in __copy_skb_header()

Lorenzo Colitti <lorenzo@google.com>
    net: diag: Don't double-free TCP_NEW_SYN_RECV sockets in tcp_abort

Davidlohr Bueso <dave@stgolabs.net>
    lib/rhashtable: consider param->min_size when setting initial table size

Arnd Bergmann <arnd@arndb.de>
    ipv6: ila: select CONFIG_DST_CACHE

Colin Ian King <colin.king@canonical.com>
    ipv6: fix useless rol32 call on hash

Tyler Hicks <tyhicks@canonical.com>
    ipv4: Return EINVAL when ping_group_range sysctl doesn't map to user ns

Toke Høiland-Jørgensen <toke@toke.dk>
    gen_stats: Fix netlink stats dumping in the presence of padding

Lyude Paul <lyude@redhat.com>
    drm/nouveau: Avoid looping through fake MST connectors

Lyude Paul <lyude@redhat.com>
    drm/nouveau: Use drm_connector_list_iter_* for iterating connectors

Lyude Paul <lyude@redhat.com>
    drm/nouveau: Remove bogus crtc check in pmops_runtime_idle

Alex Deucher <alexander.deucher@amd.com>
    Revert "drm/amd/display: Don't return ddc result and read_bytes in same return value"

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix hotplug irq ack on i965/g4x

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Reserve VM root shared fence slot for command submission (v3)

Gautham R. Shenoy <ego@linux.vnet.ibm.com>
    powerpc/powernv: Fix save/restore of SPRG3 on entry/exit from stop (idle)

Isaac J. Manjarres <isaacm@codeaurora.org>
    stop_machine: Disable preemption when waking two stopper threads

Alexey Kardashevskiy <aik@ozlabs.ru>
    vfio/spapr: Use IOMMU pageshift rather than pagesize

Gustavo A. R. Silva <gustavo@embeddedor.com>
    vfio/pci: Fix potential Spectre v1

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: intel_pstate: Register when ACPI PCCH is present

Hugh Dickins <hughd@google.com>
    mm/huge_memory.c: fix data loss when splitting a file pmd

Jing Xia <jing.xia.mail@gmail.com>
    mm: memcg: fix use after free in mem_cgroup_iter()

Vineet Gupta <vgupta@synopsys.com>
    ARC: mm: allow mprotect to make stack mappings executable

Alexey Brodkin <Alexey.Brodkin@synopsys.com>
    ARC: configs: Remove CONFIG_INITRAMFS_SOURCE from defconfigs

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: Fix CONFIG_SWAP

Vineet Gupta <vgupta@synopsys.com>
    ARCv2: [plat-hsdk]: Save accl reg pair by default

Po-Hsu Lin <po-hsu.lin@canonical.com>
    ALSA: hda: add mute led support for HP ProBook 455 G5

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Yet another Clevo P950 quirk entry

YOKOTA Hiroshi <yokota.hgml@gmail.com>
    ALSA: hda/realtek - Add Panasonic CF-SZ6 headset jack quirk

Takashi Iwai <tiwai@suse.de>
    ALSA: rawmidi: Change resized buffers atomically

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
    fat: fix memory allocation failure handling of match_strdup()

Dewet Thibaut <thibaut.dewet@nokia.com>
    x86/MCE: Remove min interval polling limitation

Hugh Dickins <hughd@google.com>
    x86/events/intel/ds: Fix bts_interrupt_threshold alignment

Ville Syrjälä <ville.syrjala@linux.intel.com>
    x86/apm: Don't access __preempt_count with zeroed fs

Radim Krčmář <rkrcmar@redhat.com>
    x86/kvmclock: set pvti_cpu0_va after enabling kvmclock

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/kvm/vmx: don't read current->thread.{fs,gs}base of legacy tasks

Liran Alon <liran.alon@oracle.com>
    KVM: VMX: Mark VMXArea with revision_id of physical CPU even when eVMCS enabled

Paolo Bonzini <pbonzini@redhat.com>
    KVM: irqfd: fix race between EPOLLHUP and irq_bypass_register_consumer

Lan Tianyu <tianyu.lan@intel.com>
    KVM/Eventfd: Avoid crash when assign and deassign specific eventfd in parallel.

Chuck Anderson <chuck.anderson@oracle.com>
    scsi: qla2xxx: Fix NULL pointer dereference for fcport search

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix kernel crash due to late workqueue allocation

Quinn Tran <quin.tran@cavium.com>
    scsi: qla2xxx: Fix inconsistent DMA mem alloc/free

Damien Le Moal <damien.lemoal@wdc.com>
    scsi: sd_zbc: Fix variable type and bogus comment


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/alpha/kernel/osf_sys.c                        |  5 +--
 arch/arc/Kconfig                                   |  2 +-
 arch/arc/configs/axs101_defconfig                  |  1 -
 arch/arc/configs/axs103_defconfig                  |  1 -
 arch/arc/configs/axs103_smp_defconfig              |  1 -
 arch/arc/configs/haps_hs_defconfig                 |  1 -
 arch/arc/configs/haps_hs_smp_defconfig             |  1 -
 arch/arc/configs/hsdk_defconfig                    |  1 -
 arch/arc/configs/nsim_700_defconfig                |  1 -
 arch/arc/configs/nsim_hs_defconfig                 |  1 -
 arch/arc/configs/nsim_hs_smp_defconfig             |  1 -
 arch/arc/configs/nsimosci_defconfig                |  1 -
 arch/arc/configs/nsimosci_hs_defconfig             |  1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig         |  1 -
 arch/arc/include/asm/page.h                        |  2 +-
 arch/arc/include/asm/pgtable.h                     |  2 +-
 arch/arc/plat-hsdk/Kconfig                         |  2 +
 arch/powerpc/kernel/idle_book3s.S                  |  2 +
 arch/x86/events/intel/ds.c                         |  8 ++--
 arch/x86/include/asm/apm.h                         |  6 ---
 arch/x86/kernel/apm_32.c                           |  5 +++
 arch/x86/kernel/cpu/mcheck/mce.c                   |  3 --
 arch/x86/kernel/kvmclock.c                         | 11 +++--
 arch/x86/kvm/vmx.c                                 | 52 ++++++++++++++++------
 drivers/cpufreq/intel_pstate.c                     | 17 ++++++-
 drivers/cpufreq/pcc-cpufreq.c                      |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  4 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 20 ++++-----
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  | 10 ++---
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |  5 +--
 drivers/gpu/drm/drm_lease.c                        | 16 +------
 drivers/gpu/drm/i915/i915_irq.c                    | 32 ++++++++++++-
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |  6 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  9 +++-
 drivers/gpu/drm/nouveau/nouveau_connector.h        | 36 +++++++++++++--
 drivers/gpu/drm/nouveau/nouveau_display.c          | 10 ++++-
 drivers/gpu/drm/nouveau/nouveau_drm.c              | 11 -----
 drivers/misc/cxl/api.c                             |  8 ++--
 drivers/net/ethernet/aquantia/atlantic/aq_cfg.h    |  2 -
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |  4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c   | 11 +----
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    | 47 ++++++++++---------
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h    |  2 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c  |  2 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |  4 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |  4 +-
 drivers/net/ethernet/broadcom/bcmsysport.h         |  3 +-
 drivers/net/ethernet/broadcom/tg3.c                |  9 ++++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |  8 +++-
 drivers/net/hyperv/netvsc.c                        | 17 ++++---
 drivers/net/phy/phy_device.c                       |  7 +--
 drivers/net/usb/asix_devices.c                     |  4 +-
 drivers/net/usb/qmi_wwan.c                         |  1 +
 drivers/ptp/ptp_chardev.c                          |  1 +
 drivers/scsi/qla2xxx/qla_def.h                     |  2 +
 drivers/scsi/qla2xxx/qla_gs.c                      | 40 +++++++++++------
 drivers/scsi/qla2xxx/qla_init.c                    | 14 +++---
 drivers/scsi/qla2xxx/qla_os.c                      |  4 +-
 drivers/scsi/sd_zbc.c                              |  5 ++-
 drivers/usb/host/xhci.c                            | 40 +++++++++++++++--
 drivers/usb/host/xhci.h                            |  4 ++
 drivers/vfio/pci/vfio_pci.c                        |  4 ++
 drivers/vfio/vfio_iommu_spapr_tce.c                |  8 ++--
 fs/fat/inode.c                                     | 20 ++++++---
 fs/internal.h                                      |  1 -
 include/linux/fs.h                                 |  1 +
 include/linux/sched/task.h                         |  2 +-
 include/linux/skbuff.h                             | 10 ++---
 include/net/ipv6.h                                 |  2 +-
 include/net/sctp/sctp.h                            |  9 +++-
 kernel/stop_machine.c                              |  6 ++-
 lib/rhashtable.c                                   | 25 ++++++++---
 mm/huge_memory.c                                   |  2 +
 mm/memcontrol.c                                    |  2 +-
 net/core/gen_stats.c                               | 16 ++++++-
 net/core/skbuff.c                                  |  1 +
 net/ipv4/fib_frontend.c                            |  1 +
 net/ipv4/sysctl_net_ipv4.c                         |  5 ++-
 net/ipv4/tcp.c                                     |  3 +-
 net/ipv6/Kconfig                                   |  1 +
 net/ipv6/ip6_gre.c                                 |  3 +-
 net/ipv6/ndisc.c                                   |  2 +-
 net/ipv6/route.c                                   |  7 +++
 net/sched/sch_fq_codel.c                           | 25 ++++++++---
 net/sctp/associola.c                               |  6 +--
 net/sctp/transport.c                               |  8 ++--
 sound/core/rawmidi.c                               | 20 ++++++---
 sound/pci/hda/patch_conexant.c                     |  1 +
 sound/pci/hda/patch_realtek.c                      |  2 +
 virt/kvm/eventfd.c                                 | 17 ++++---
 91 files changed, 485 insertions(+), 264 deletions(-)



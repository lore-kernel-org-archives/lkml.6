Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsBsN89BTZG+8o4nfDJtFtKZLSfYTHKE5tEz4u4riF7RFCSvFVdzlVuv+80aeHrDhJlPQ/G
ARC-Seal: i=1; a=rsa-sha256; t=1520451893; cv=none;
        d=google.com; s=arc-20160816;
        b=OqiFmwdgXAwAFCZO5trTLl4DA3+X1rnrBWIYrRDTseqZJJXnEYdGMLq09NbTnOAjEA
         fBEo5Hv+STOsulUMkXU46QzjJTH4NW0AkIMBS22cyQskUbc6DrKlglkTtvpp/N/zwblk
         g0vfS23o7xzU6OeizO7pw3gxdTIZFBWaN+YilU9lxZAVPu7rYpmUy7go9WID9HOlj5lV
         txzNS0wVSGNZy4X0eF1rZtNOHr6Sw9SaaZixTNQOYxXibwaTLXi0WAvUptfwIQd13CEU
         nqpN/Bqu1PXTIGYYQ6Se8xMkliLy/1+0/ddkd+Sx3eW0qhykg9skXhXNUYPWjpFbagg0
         ngEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rn7m6hOfRGr5/pdlZh/8y4Cq/tOiTsrLs+iaw9r9EmA=;
        b=t/DcKaecnVKjTiNtWWx3MR8sz+GRdtIibZESPqKOgC9nXMLwkrj1Ef6vb9zF9Sl4J1
         XP2WYJJHeLThJoGTdrczkp/JofunDmUHWmrpejzCsQedcvmO/JvBA0yAx9aD2g9vW5gf
         VPuFN/0mtjxusEg+Zjis2Ubi06OLiTA1Iz6qN2bou32uUQ1yRRW4BuTk4aArqIEoGZ/I
         9SG1iO0BR/L2aYKc1fQDyP+SiYUDdXnsKz9+hBNg4T7twxVC/KXKzWfkb0Aorgo72Dh8
         khfagCr1dYjBLm2SOwHpRg2cJeBr2NVXsOdyPr5fre4+kKE7fcHxh+RNGjjqOrSCuC5D
         bFig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.14 000/110] 4.14.25-stable review
Date: Wed,  7 Mar 2018 11:37:43 -0800
Message-Id: <20180307191039.748351103@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.25-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.25-rc1
X-KernelTest-Deadline: 2018-03-09T19:10+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309365480057936?=
X-GMAIL-MSGID: =?utf-8?q?1594309365480057936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.25 release.
There are 110 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Mar  9 19:10:03 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.25-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.25-rc1

Sagi Grimberg <sagi@grimberg.me>
    nvme-rdma: don't suppress send completions

NeilBrown <neilb@suse.com>
    md: only allow remove_and_add_spares when no sync_thread running.

Adam Ford <aford173@gmail.com>
    ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux

Adam Ford <aford173@gmail.com>
    ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux

Kai Heng Feng <kai.heng.feng@canonical.com>
    ACPI / bus: Parse tables as term_list for Dell XPS 9570 and Precision M5530

Eric Biggers <ebiggers@google.com>
    KVM/x86: remove WARN_ON() for when vm_munmap() fails

Tianyu Lan <lantianyu1986@gmail.com>
    KVM/x86: Fix wrong macro references of X86_CR0_PG_BIT and X86_CR4_PAE_BIT in kvm_valid_sregs()

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    PCI/ASPM: Deal with missing root ports in link state handling

Radim Krčmář <rkrcmar@redhat.com>
    KVM: x86: fix vcpu initialization with userspace lapic

Paolo Bonzini <pbonzini@redhat.com>
    KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the RDMSR path as unlikely()

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: move LAPIC initialization after VMCS creation

Paolo Bonzini <pbonzini@redhat.com>
    KVM/x86: Remove indirect MSR op calls from SPEC_CTRL

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: mmu: Fix overlap between public and private memslots

Wanpeng Li <wanpengli@tencent.com>
    KVM: X86: Fix SMRAM accessing even if VM is shutdown

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: extend usage of RET_MMIO_PF_* constants

Arnd Bergmann <arnd@arndb.de>
    ARM: kvm: fix building with gcc-8

Ulf Magnusson <ulfalizer@gmail.com>
    ARM: mvebu: Fix broken PL310_ERRATA_753970 selects

Daniel Schultz <d.schultz@phytec.de>
    ARM: dts: rockchip: Remove 1.8 GHz operation point from phycore som

Arnd Bergmann <arnd@arndb.de>
    ARM: orion: fix orion_ge00_switch_board_info initialization

Jan Beulich <JBeulich@suse.com>
    x86/mm: Fix {pmd,pud}_{set,clear}_flags()

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    nospec: Allow index argument to have const-qualified type

David Hildenbrand <david@redhat.com>
    KVM: s390: consider epoch index on TOD clock syncs

David Hildenbrand <david@redhat.com>
    KVM: s390: consider epoch index on hotplugged CPUs

David Hildenbrand <david@redhat.com>
    KVM: s390: provide only a single function for setting the tod (fix SCK)

David Hildenbrand <david@redhat.com>
    KVM: s390: take care of clock-comparator sign control

Anna Karbownik <anna.karbownik@intel.com>
    EDAC, sb_edac: Fix out of bound writes during DIMM configuration on KNL

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: m88ds3103: don't call a non-initalized function

Ming Lei <ming.lei@redhat.com>
    blk-mq: don't call io sched's .requeue_request when requeueing rq to ->dispatch

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix IPA command submission race

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix IP address lookup for L3 devices

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    Revert "s390/qeth: fix using of ref counter for rxip addresses"

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix double-free on IP add/remove race

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix IP removal on offline cards

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix overestimated count of buffer elements

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix SETIP command handling

Ursula Braun <ubraun@linux.vnet.ibm.com>
    s390/qeth: fix underestimated count of buffer elements

Jason Wang <jasowang@redhat.com>
    virtio-net: disable NAPI only when enabled during XDP set

Jason Wang <jasowang@redhat.com>
    tuntap: disable preemption during XDP processing

Jason Wang <jasowang@redhat.com>
    tuntap: correctly add the missing XDP flush

Soheil Hassas Yeganeh <soheil@google.com>
    tcp: purge write queue upon RST

Jason A. Donenfeld <Jason@zx2c4.com>
    netlink: put module reference if dump start fails

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_router: Do not unconditionally clear route offload indication

Paolo Abeni <pabeni@redhat.com>
    cls_u32: fix use after free in u32_destroy_key()

Tom Lendacky <thomas.lendacky@amd.com>
    amd-xgbe: Restore PCI interrupt enablement setting on resume

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx5e: Verify inline header size do not exceed SKB linear size

Ido Schimmel <idosch@mellanox.com>
    bridge: Fix VLAN reference count problem

Alexey Kodanev <alexey.kodanev@oracle.com>
    sctp: fix dst refcnt leak in sctp_v6_get_dst()

David Ahern <dsahern@gmail.com>
    net: ipv4: Set addr_type in hash_keys for forwarded case

Jiri Pirko <jiri@mellanox.com>
    mlxsw: spectrum_router: Fix error path in mlxsw_sp_vr_create

Yuchung Cheng <ycheng@google.com>
    tcp: revert F-RTO extension to detect more spurious timeouts

Yuchung Cheng <ycheng@google.com>
    tcp: revert F-RTO middle-box workaround

Xin Long <lucien.xin@gmail.com>
    sctp: do not pr_err for the duplicated node in transport rhlist

Ivan Vecera <ivecera@redhat.com>
    net/sched: cls_u32: fix cls_u32 on filter replace

Eric Dumazet <edumazet@google.com>
    net_sched: gen_estimator: fix broken estimators based on percpu stats

Inbar Karmy <inbark@mellanox.com>
    net/mlx5e: Fix loopback self test when GRO is off

Tonghao Zhang <xiangxia.m.yue@gmail.com>
    doc: Change the min default value of tcp_wmem/tcp_rmem.

Eric Dumazet <edumazet@google.com>
    tcp_bbr: better deal with suboptimal GSO

David Howells <dhowells@redhat.com>
    rxrpc: Fix send in rxrpc_send_data_packet()

Ilya Lesokhin <ilyal@mellanox.com>
    tcp: Honor the eor bit in tcp_mtu_probe

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: fix phy_start to consider PHY_IGNORE_INTERRUPT

Gal Pressman <galp@mellanox.com>
    net/mlx5e: Specify numa node when allocating drop rq

Shalom Toledo <shalomt@mellanox.com>
    mlxsw: spectrum_switchdev: Check success of FDB add operation

Tommi Rantala <tommi.t.rantala@nokia.com>
    sctp: fix dst refcnt leak in sctp_v4_get_dst

Gal Pressman <galp@mellanox.com>
    net/mlx5e: Fix TCP checksum in LRO buffers

Alexey Kodanev <alexey.kodanev@oracle.com>
    udplite: fix partial checksum initialization

Alexey Kodanev <alexey.kodanev@oracle.com>
    sctp: verify size of a new chunk in _sctp_make_chunk()

Guillaume Nault <g.nault@alphalink.fr>
    ppp: prevent unregistered channels from connecting to PPP units

Roman Kapl <code@rkapl.cz>
    net: sched: report if filter is too large to dump

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    netlink: ensure to loop over all netns in genlmsg_multicast_allns()

Sabrina Dubroca <sd@queasysnail.net>
    net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Jakub Kicinski <jakub.kicinski@netronome.com>
    net: fix race on decreasing number of TX queues

Grygorii Strashko <grygorii.strashko@ti.com>
    net: ethernet: ti: cpsw: fix net watchdog timeout

Wolfram Sang <wsa+renesas@sang-engineering.com>
    net: amd-xgbe: fix comparison to bitshift when dealing with a mask

Arnd Bergmann <arnd@arndb.de>
    ipv6 sit: work around bogus gcc-8 -Wrestrict warning

Denis Du <dudenis2000@yahoo.ca>
    hdlc_ppp: carrier detect ok, don't turn off negotiation

Stefano Brivio <sbrivio@redhat.com>
    fib_semantics: Don't match route with mismatching tclassid

Xin Long <lucien.xin@gmail.com>
    bridge: check brport attr show in brport_show

Thomas Gleixner <tglx@linutronix.de>
    x86/cpu_entry_area: Sync cpu_entry_area to initial_page_table

Sebastian Panceac <sebastian@resin.io>
    x86/platform/intel-mid: Handle Intel Edison reboot correctly

Juergen Gross <jgross@suse.com>
    x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend

Jan Kara <jack@suse.cz>
    direct-io: Fix sleep in atomic due to sync AIO

Dan Williams <dan.j.williams@intel.com>
    dax: fix vma_is_fsdax() helper

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

Dan Williams <dan.j.williams@intel.com>
    vfio: disable filesystem-dax page pinning

Ming Lei <ming.lei@redhat.com>
    block: kyber: fix domain token leak during requeue

Jiufei Xue <jiufei.xue@linux.alibaba.com>
    block: fix the count of PGPGOUT for WRITE_SAME

Anand Jain <anand.jain@oracle.com>
    btrfs: use proper endianness accessors for super_copy

John David Anglin <dave.anglin@bell.net>
    parisc: Fix ordering of cache and TLB flushes

Helge Deller <deller@gmx.de>
    parisc: Reduce irq overhead when run in qemu

Helge Deller <deller@gmx.de>
    parisc: Use cr16 interval timers unconditionally on qemu

Lingutla Chandrasekhar <clingutla@codeaurora.org>
    timers: Forward timer base before migrating timers

Shawn Lin <shawn.lin@rock-chips.com>
    mmc: dw_mmc: Fix out-of-bounds access for slot's caps

Shawn Lin <shawn.lin@rock-chips.com>
    mmc: dw_mmc: Factor out dw_mci_init_slot_caps

Shawn Lin <shawn.lin@rock-chips.com>
    mmc: dw_mmc: Avoid accessing registers in runtime suspended state

Geert Uytterhoeven <geert+renesas@glider.be>
    mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci-pci: Fix S0i3 for Intel BYT-based controllers

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Fix pincfg at resume on Lenovo T470 dock

Hans de Goede <hdegoede@redhat.com>
    ALSA: hda: Add a power_save blacklist

Takashi Iwai <tiwai@suse.de>
    ALSA: x86: Fix missing spinlock and mutex initializations

Richard Fitzgerald <rf@opensource.cirrus.com>
    ALSA: control: Fix memory corruption risk in snd_ctl_elem_read

Erik Veijola <erik.veijola@gmail.com>
    ALSA: usb-audio: Add a quirck for B&W PX headphones

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm_tis_spi: Use DMA-safe memory for SPI transfers

Arnd Bergmann <arnd@arndb.de>
    tpm: constify transmit data pointers

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_tis: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus

Emil Tantilov <emil.s.tantilov@intel.com>
    ixgbe: fix crash in build_skb Rx code path

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: btusb: Use DMI matching for QCA reset_resume quirking


-------------

Diffstat:

 Documentation/networking/ip-sysctl.txt             |   4 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |   9 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   8 ++
 arch/arm/boot/dts/rk3288-phycore-som.dtsi          |  20 ----
 arch/arm/kvm/hyp/Makefile                          |   5 +
 arch/arm/kvm/hyp/banked-sr.c                       |   4 +
 arch/arm/mach-mvebu/Kconfig                        |   4 +-
 arch/arm/plat-orion/common.c                       |  23 ++--
 arch/parisc/include/asm/cacheflush.h               |   1 +
 arch/parisc/include/asm/processor.h                |   2 +
 arch/parisc/kernel/cache.c                         |  57 +++++-----
 arch/parisc/kernel/pacache.S                       |  22 ++++
 arch/parisc/kernel/time.c                          |  11 +-
 arch/s390/kvm/interrupt.c                          |  25 ++++-
 arch/s390/kvm/kvm-s390.c                           |  79 +++++++------
 arch/s390/kvm/kvm-s390.h                           |   5 +-
 arch/s390/kvm/priv.c                               |   9 +-
 arch/x86/include/asm/pgtable.h                     |   8 +-
 arch/x86/include/asm/pgtable_32.h                  |   1 +
 arch/x86/include/asm/pgtable_64.h                  |   1 +
 arch/x86/include/asm/pgtable_types.h               |  10 ++
 arch/x86/kernel/setup.c                            |  17 +--
 arch/x86/kernel/setup_percpu.c                     |  17 +--
 arch/x86/kvm/lapic.c                               |  11 +-
 arch/x86/kvm/mmu.c                                 |  97 ++++++++--------
 arch/x86/kvm/paging_tmpl.h                         |  18 +--
 arch/x86/kvm/svm.c                                 |   9 +-
 arch/x86/kvm/vmx.c                                 |   9 +-
 arch/x86/kvm/x86.c                                 |  12 +-
 arch/x86/mm/cpu_entry_area.c                       |   6 +
 arch/x86/mm/init_32.c                              |  15 +++
 arch/x86/platform/intel-mid/intel-mid.c            |   2 +-
 arch/x86/xen/suspend.c                             |  16 +++
 block/blk-core.c                                   |   2 +-
 block/blk-mq.c                                     |   4 +-
 block/kyber-iosched.c                              |   1 +
 drivers/acpi/bus.c                                 |  38 +++++--
 drivers/bluetooth/btusb.c                          |  25 ++++-
 drivers/char/tpm/st33zp24/st33zp24.c               |   4 +-
 drivers/char/tpm/tpm-interface.c                   |   4 +
 drivers/char/tpm/tpm2-cmd.c                        |   4 +
 drivers/char/tpm/tpm_i2c_infineon.c                |   5 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c                 |   8 +-
 drivers/char/tpm/tpm_tis.c                         |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |   9 +-
 drivers/char/tpm/tpm_tis_core.h                    |   4 +-
 drivers/char/tpm/tpm_tis_spi.c                     |  48 ++++----
 drivers/cpufreq/s3c24xx-cpufreq.c                  |   8 +-
 drivers/edac/sb_edac.c                             |   2 +-
 drivers/md/md.c                                    |   4 +
 drivers/media/dvb-frontends/m88ds3103.c            |   7 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   1 +
 drivers/mmc/host/dw_mmc-k3.c                       |   4 +
 drivers/mmc/host/dw_mmc-rockchip.c                 |   1 +
 drivers/mmc/host/dw_mmc-zx.c                       |   1 +
 drivers/mmc/host/dw_mmc.c                          |  84 +++++++++-----
 drivers/mmc/host/dw_mmc.h                          |   2 +
 drivers/mmc/host/sdhci-pci-core.c                  |  35 +++++-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   8 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  49 +++++---
 .../net/ethernet/mellanox/mlx5/core/en_selftest.c  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  22 ++--
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  29 ++++-
 drivers/net/ethernet/ti/cpsw.c                     |  16 ++-
 drivers/net/phy/phy.c                              |   2 +-
 drivers/net/ppp/ppp_generic.c                      |   9 ++
 drivers/net/tun.c                                  |   7 ++
 drivers/net/virtio_net.c                           |   8 +-
 drivers/net/wan/hdlc_ppp.c                         |   5 +-
 drivers/nvme/host/rdma.c                           |  54 +++------
 drivers/pci/pcie/aspm.c                            |   8 +-
 drivers/s390/net/qeth_core.h                       |   7 +-
 drivers/s390/net/qeth_core_main.c                  |  43 +++----
 drivers/s390/net/qeth_l3.h                         |  34 +++++-
 drivers/s390/net/qeth_l3_main.c                    | 123 +++++++++------------
 drivers/vfio/vfio_iommu_type1.c                    |  18 ++-
 fs/btrfs/sysfs.c                                   |   8 +-
 fs/btrfs/transaction.c                             |  20 ++--
 fs/direct-io.c                                     |   3 +-
 include/linux/fs.h                                 |   2 +-
 include/linux/nospec.h                             |   3 +-
 include/net/udplite.h                              |   1 +
 kernel/time/timer.c                                |   6 +
 net/bridge/br_sysfs_if.c                           |   3 +
 net/bridge/br_vlan.c                               |   2 +
 net/core/dev.c                                     |  11 +-
 net/core/gen_estimator.c                           |   1 +
 net/ipv4/fib_semantics.c                           |   5 +
 net/ipv4/route.c                                   |  10 +-
 net/ipv4/tcp_input.c                               |  24 ++--
 net/ipv4/tcp_output.c                              |  33 +++++-
 net/ipv4/udp.c                                     |   5 +
 net/ipv6/ip6_checksum.c                            |   5 +
 net/ipv6/sit.c                                     |   2 +-
 net/netlink/af_netlink.c                           |   4 +-
 net/netlink/genetlink.c                            |  12 +-
 net/rxrpc/output.c                                 |   2 +-
 net/sched/cls_api.c                                |   7 +-
 net/sched/cls_u32.c                                |  24 ++--
 net/sctp/input.c                                   |   5 +-
 net/sctp/ipv6.c                                    |  10 +-
 net/sctp/protocol.c                                |  10 +-
 net/sctp/sm_make_chunk.c                           |   7 +-
 sound/core/control.c                               |   2 +-
 sound/pci/hda/hda_intel.c                          |  38 ++++++-
 sound/pci/hda/patch_realtek.c                      |   3 +-
 sound/usb/quirks-table.h                           |  47 ++++++++
 sound/x86/intel_hdmi_audio.c                       |   2 +
 virt/kvm/kvm_main.c                                |   3 +-
 114 files changed, 1065 insertions(+), 564 deletions(-)

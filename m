Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbeDAWB0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 18:01:26 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:52940 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeDAWBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 18:01:23 -0400
X-Google-Smtp-Source: AIpwx49fvVv+7lpLrcpxLpeYih7OBEb+ImFxAFFl0JIkPpbX3p9yZ2opA+FawcgbbAI9EdhblYlyvP2XiOlyknfsM5s=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Apr 2018 15:01:21 -0700
X-Google-Sender-Auth: ch6eJrybf9iB1rCbEUqt8aMIBME
Message-ID: <CA+55aFyxn0bu5jOAJvO_63GHaGMkJ0uA=bVBm2T3HVX9SimZzw@mail.gmail.com>
Subject: Linux 4.16
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w31M1Wxc004817

So the take from final week of the 4.16 release looks a lot like rc7,
in that about half of it is networking. If it wasn't for that, it
would all be very small and calm.

We had a number of fixes and cleanups elsewhere, but none of it made
me go "uhhuh, better let this soak for another week". And davem didn't
think the networking was a reason to delay the release, so I'm  not.

End result: 4.16 is out, and the merge window for 4.17 is open and
I'll start doing pull requests tomorrow.

Outside of networking, most of the last week was various arch fixlets
(powerpc, arm, x86, arm64), some driver fixes (mainly scsi and rdma)
and misc other noise (documentation, vm, perf).

The appended shortlog gives an overview of the details (again, this is
only the small stuff in the last week, if you want the full 4.16
changelog you'd better get the git tree and filter by your area of
interest).

                    Linus

---

Alexander Potapenko (1):
      netlink: make sure nladdr has correct size in netlink_connect()

Alexey Dobriyan (1):
      x86/alternatives: Fixup alternative_call_2

Andrei Otcheretianski (2):
      iwlwifi: mvm: Increase session protection time after CS
      iwlwifi: mvm: Move unused phy's to a default channel

Andrew Banman (1):
      x86/platform/uv/BAU: Add APIC idt entry

Aneesh Kumar K.V (3):
      powerpc/mm/radix: Remove unused code
      powerpc/mm/radix: Move the functions that does the actual tlbie closer
      powerpc/mm: Fixup tlbie vs store ordering issue on POWER9

Arnd Bergmann (1):
      ARM: 8747/1: make CONFIG_DEBUG_WX depend on MMU

Avraham Stern (3):
      iwlwifi: mvm: clear tx queue id when unreserving aggregation queue
      iwlwifi: mvm: make sure internal station has a valid id
      iwlwifi: mvm: fix array out of bounds reference

Bartosz Golaszewski (1):
      ARM: davinci: fix the GPIO lookup for omapl138-hawk

Beni Lev (1):
      iwlwifi: mvm: Correctly set IGTK for AP

Benjamin Herrenschmidt (2):
      powerpc/mm: Add tracking of the number of coprocessors using a context
      powerpc/mm: Workaround Nest MMU bug with TLB invalidations

Boris Brezillon (1):
      mtd: nand: atmel: Fix get_sectorsize() function

Brian King (1):
      scsi: ibmvfc: Avoid unnecessary port relogin

Chien Tin Tung (1):
      RDMA/ucma: Correct option size check using optlen

Colin Ian King (2):
      RDMA/hns: ensure for-loop actually iterates and free's buffers
      atm: iphase: fix spelling mistake: "Receiverd" -> "Received"

Cong Wang (1):
      llc: properly handle dev_queue_xmit() return value

Craig Dillabaugh (1):
      net sched actions: fix dumping which requires several messages
to user space

Dan Carpenter (1):
      ALSA: pcm: potential uninitialized return values

Dave Watson (1):
      strparser: Fix sign of err codes

David Ahern (2):
      vrf: Fix use after free and double free in vrf_finish_output
      net/ipv6: Fix route leaking between VRFs

David Lebrun (1):
      ipv6: sr: fix seg6 encap performances with TSO enabled

David S. Miller (1):
      ip_tunnel: Resolve ipsec merge conflict properly.

Douglas Anderson (1):
      arm64: dts: rockchip: Fix rk3399-gru-* s2r (pinctrl hogs, wifi reset)

Emmanuel Grumbach (1):
      iwlwifi: mvm: set the correct tid when we flush the MCAST sta

Eran Ben Elisha (1):
      net/mlx4_en: Fix mixed PFC and Global pause user control requests

Eric Dumazet (2):
      ipv6: fix possible deadlock in rt6_age_examine_exception()
      net: fix possible out-of-bound read in skb_network_protocol()

Fabio Estevam (1):
      ARM: 8746/1: vfp: Go back to clearing vfp_current_hw_state[]

Felix Kuehling (2):
      drm/amdkfd: Fix scratch memory with HWS enabled
      drm/amdkfd: Deallocate SDMA queues correctly

Florian Westphal (3):
      netfilter: nf_tables: meter: pick a set backend that supports updates
      netfilter: nf_tables: permit second nat hook if colliding hook
is going away
      netfilter: nf_tables: add missing netlink attrs to policies

Giuseppe Lippolis (1):
      net-usb: add qmi_wwan if on lte modem wistron neweb d18q1

Gregory CLEMENT (1):
      mailmap: Update email address for Gregory CLEMENT

Hans Wippel (1):
      net/ipv4: disable SMC TCP option with SYN Cookies

Heiko Stuebner (1):
      Revert "arm64: dts: rockchip: add usb3-phy otg-port support for rk3399"

Heiner Kallweit (1):
      r8169: fix setting driver_data after register_netdev

Honglei Wang (1):
      mm/memcontrol.c: fix parameter description mismatch

Jakub Kicinski (2):
      tools: bpftool: don't use hex numbers in JSON output
      nfp: bpf: fix check of program max insn count

Jan Kiszka (1):
      builddeb: Fix header package regarding dtc source links

Jason Gunthorpe (2):
      kbuild: rpm-pkg: Support GNU tar >= 1.29
      RDMA/rdma_cm: Fix use after free race with process_one_req

Jason Wang (3):
      vhost_net: add missing lock nesting notation
      vhost: correctly remove wait queue during poll failure
      vhost: validate log when IOTLB is enabled

Jianbo Liu (2):
      net/mlx5e: Don't override vport admin link state in switchdev mode
      net/mlx5e: Fix memory usage issues in offloading TC flows

Jianchao Wang (1):
      scsi: iscsi_tcp: set BDI_CAP_STABLE_WRITES when data digest enabled

Jinbum Park (1):
      ARM: 8748/1: mm: Define vdso_start, vdso_end as array

Joel Stanley (1):
      ARM: dts: aspeed: Add default memory node

Johannes Berg (1):
      iwlwifi: mvm: fix error checking for multi/broadcast sta

John Fastabend (1):
      net: sched, fix OOO packets with pfifo_fast

Jon Hunter (1):
      MAINTAINERS: Update Tegra IOMMU maintainer

Josh Poimboeuf (1):
      objtool: Add Clang support

Kalderon, Michal (3):
      RDMA/qedr: fix QP's ack timeout configuration
      RDMA/qedr: Fix rc initialization on CNQ allocation failure
      RDMA/qedr: Fix QP state initialization race

Leon Romanovsky (3):
      RDMA/restrack: Move restrack_clean to be symmetrical to restrack_init
      RDMA/ucma: Check that device is connected prior to access it
      RDMA/ucma: Check that device exists prior to accessing it

Leonard Crestez (1):
      ARM: dts: imx7d-sdb: Fix regulator-usb-otg2-vbus node name

Linus Lüssing (2):
      batman-adv: fix multicast-via-unicast transmission with AP isolation
      batman-adv: fix packet loss for broadcasted DHCP packets to a server

Linus Torvalds (2):
      perf/hwbp: Simplify the perf-hwbp code, fix documentation
      Linux 4.16

Linus Walleij (2):
      ARM: ux500: Fix PMU IRQ regression
      mtd: jedec_probe: Fix crash in jedec_read_mfr()

Luca Coelho (1):
      iwlwifi: add shared clock PHY config flag for some devices

Maninder Singh (1):
      mm/page_owner: fix recursion bug after changing skip entries

Manish Chopra (2):
      qede: Fix barrier usage after tx doorbell write.
      qede: Do not drop rx-checksum invalidated packets.

Mark Bloch (1):
      IB/mlx5: Don't clean uninitialized UMR resources

Martin K. Petersen (1):
      scsi: sd: Remember that READ CAPACITY(16) succeeded

Masahiro Yamada (1):
      netfilter: nf_nat_snmp_basic: add correct dependency to Makefile

Maxime Ripard (1):
      MAINTAINERS: update email address for Maxime Ripard

Michael Ellerman (1):
      powerpc/64s: Fix NULL AT_BASE_PLATFORM when using DT CPU features

Mike Kravetz (1):
      ipc/shm.c: add split function to shm_vm_ops

Mike Snitzer (2):
      dm mpath: fix support for loading scsi_dh modules during table load
      dm: fix dropped return code from dm_get_bdev_for_ioctl

Ming Lei (5):
      scsi: hpsa: fix selection of reply queue
      scsi: megaraid_sas: fix selection of reply queue
      scsi: core: introduce force_blk_mq
      scsi: virtio_scsi: fix IO hang caused by automatic irq vector affinity
      scsi: virtio_scsi: unify scsi_host_template

Moshe Shemesh (2):
      net/mlx5e: Verify coalescing parameters in range
      net/mlx4_core: Fix memory leak while delete slave's resources

Nicholas Piggin (2):
      powerpc/64s: Fix lost pending interrupt due to race causing lost
update to irq_happened
      powerpc/64s: Fix i-side SLB miss bad address handler saving
nonvolatile GPRs

Nicolas Pitre (2):
      kbuild: make scripts/adjust_autoksyms.sh robust against timestamp races
      ARM: 8750/1: deflate_xip_data.sh: minor fixes

Nobutaka Okabe (1):
      ALSA: usb-audio: Add native DSD support for TEAC UD-301

Or Gerlitz (3):
      net/mlx5e: Use 32 bits to store VF representor SQ number
      net/mlx5: Make eswitch support to depend on switchdev
      net/mlx5e: Avoid using the ipv6 stub in the TC offload neigh update path

Pablo Neira Ayuso (2):
      netfilter: nf_tables: cache device name in flowtable object
      netfilter: nf_tables: do not hold reference on netdevice from
preparation phase

Paolo Abeni (2):
      netfilter: drop template ct when conntrack is skipped.
      ipv6: the entire IPv6 header chain must fit the first fragment

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Fix duplication of host SLB entries

Pawel Dembicki (1):
      net: qmi_wwan: add BroadMobi BM806U 2020:2033

Petr Machata (3):
      ip_tunnel: Emit events for post-register MTU changes
      mlxsw: spectrum_router: Move mlxsw_sp_rif_ipip_lb_op()
      mlxsw: spectrum_router: Handle MTU change of GRE netdevs

Philipp Rossak (2):
      ARM: dts: sun6i: a31s: bpi-m2: improve pmic properties
      ARM: dts: sun6i: a31s: bpi-m2: add missing regulators

Pierre-Yves MORDRET (1):
      i2c: i2c-stm32f7: fix no check on returned setup

Rafał Miłecki (1):
      brcmfmac: drop Inter-Access Point Protocol packets by default

Raghuram Chary J (2):
      lan78xx: Set ASD in MAC_CR when EEE is enabled.
      lan78xx: Crash in lan78xx_writ_reg (Workqueue: events
lan78xx_deferred_multicast_write)

Richard Weinberger (2):
    lib: vsprintf: Implement %pCOW
    printk: Use %pCOW for kmsg

Rob Herring (1):
      ARM: dts: rockchip: Add missing #sound-dai-cells on rk3288

Roi Dayan (1):
      net/mlx5e: Fix traffic being dropped on VF representor

Roland Dreier (1):
      RDMA/ucma: Introduce safer rdma_addr_size() variants

Russell King (2):
      MAINTAINERS: correct rmk's email address
      MAINTAINERS: demote ARM port to "odd fixes"

Sanjeev Gupta (1):
      Documentation/isdn: check and fix dead links ...

Sean Christopherson (1):
      KVM: nVMX: sync vmcs02 segment regs prior to vmx_set_cr0

Sean Wang (2):
      net: dsa: mt7530: remove redundant MODULE_ALIAS entries
      net: dsa: mt7530: fix module autoloading for OF platform drivers

Shahar Klein (1):
      net/mlx5e: Sync netdev vxlan ports at open

Shakeel Butt (1):
      mm, slab: memcg_link the SLAB's kmem_cache

Stefan Agner (2):
      kbuild: set no-integrated-as before incl. arch Makefile
      drm/tegra: dc: Use correct format array for Tegra124

Stefan Roese (1):
      ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()

Stefan Wahren (1):
      brcmfmac: Fix check for ISO3166 code

Stefano Brivio (6):
      vti4: Don't count header length twice on tunnel setup
      ip_tunnel: Clamp MTU to bounds on new link
      vti4: Don't override MTU passed on link creation via IFLA_MTU
      vti6: Properly adjust vti6 MTU from MTU of lower device
      vti6: Keep set MTU on link creation or change, validate it
      vti6: Fix dev->max_mtu setting

Steffen Klassert (1):
      xfrm: Fix transport mode skb control buffer usage.

Stephane Eranian (1):
      perf/x86/intel: Fix linear IP of PEBS real_ip on Haswell and later CPUs

Stephen Hemminger (1):
      hv_netvsc: enable multicast if necessary

Steven J. Hill (1):
      mm/vmstat.c: fix vmstat_update() preemption BUG

Subash Abhinov Kasiviswanathan (1):
      netfilter: nf_socket: Fix out of bounds access in nf_sk_lookup_slow_v{4,6}

Sven Wegener (1):
      x86/purgatory: Avoid creating stray .<pid>.d files, remove -MD
from KBUILD_CFLAGS

Taehee Yoo (1):
      xfrm: fix rcu_read_unlock usage in xfrm_local_error

Tal Gilboa (1):
      net/dim: Fix int overflow

Tony Lindgren (2):
      ARM: OMAP: Fix dmtimer init for omap1
      ARM: OMAP: Fix SRAM W+X mapping

Torsten Hilbrich (1):
      net/usb/qmi_wwan.c: Add USB id for lt4120 modem

Toshiaki Makita (2):
      net: Fix untag for vlan packets without ethernet header
      vlan: Fix vlan insertion for packets without ethernet header

Ursula Braun (1):
      net/smc: use announced length in sock_recvmsg()

Vinayak Menon (1):
      mm/kmemleak.c: wait for scan completion before disabling free

Wanpeng Li (1):
      KVM: x86: Fix pv tlb flush dependencies

Wei Yongjun (1):
      drm/tegra: dc: Using NULL instead of plain integer

Xin Long (4):
      bonding: fix the err path for dev hwaddr sync in bond_enslave
      bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave
      bonding: process the err returned by dev_set_allmulti properly
in bond_enslave
      team: move dev_mc_sync after master_upper_dev_link in team_port_add

Yan, Zheng (1):
      ceph: only dirty ITER_IOVEC pages for direct read

Yelena Krivosheev (1):
      net: mvneta: fix enable of all initialized RXQs

mike.travis@hpe.com (1):
      x86/platform/UV: Fix critical UV MMR address error

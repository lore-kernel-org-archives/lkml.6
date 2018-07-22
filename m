Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C996CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB2720875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB2720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbeGVOsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:48:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbeGVOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:48:41 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7125BAE0;
        Sun, 22 Jul 2018 13:51:55 +0000 (UTC)
Date:   Sun, 22 Jul 2018 15:51:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.57
Message-ID: <20180722135153.GA22504@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.57 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt            |   17 +
 Makefile                                                   |    2=20
 arch/arm/include/asm/kvm_host.h                            |   12=20
 arch/arm/include/asm/kvm_mmu.h                             |   12=20
 arch/arm64/Kconfig                                         |    9=20
 arch/arm64/include/asm/alternative.h                       |   43 ++-
 arch/arm64/include/asm/assembler.h                         |    8=20
 arch/arm64/include/asm/cpucaps.h                           |    3=20
 arch/arm64/include/asm/cpufeature.h                        |   22 +
 arch/arm64/include/asm/kvm_asm.h                           |   41 ++
 arch/arm64/include/asm/kvm_host.h                          |   43 +++
 arch/arm64/include/asm/kvm_mmu.h                           |   44 +++
 arch/arm64/include/asm/percpu.h                            |   11=20
 arch/arm64/include/asm/thread_info.h                       |    1=20
 arch/arm64/kernel/Makefile                                 |    1=20
 arch/arm64/kernel/alternative.c                            |   52 ++-
 arch/arm64/kernel/asm-offsets.c                            |    2=20
 arch/arm64/kernel/cpu_errata.c                             |  180 ++++++++=
+++++
 arch/arm64/kernel/cpufeature.c                             |   17 +
 arch/arm64/kernel/entry.S                                  |   30 ++
 arch/arm64/kernel/hibernate.c                              |   11=20
 arch/arm64/kernel/ssbd.c                                   |  108 +++++++
 arch/arm64/kernel/suspend.c                                |    8=20
 arch/arm64/kvm/hyp-init.S                                  |    4=20
 arch/arm64/kvm/hyp/entry.S                                 |   12=20
 arch/arm64/kvm/hyp/hyp-entry.S                             |   62 +++-
 arch/arm64/kvm/hyp/switch.c                                |   64 +++-
 arch/arm64/kvm/hyp/sysreg-sr.c                             |   21 -
 arch/arm64/kvm/reset.c                                     |    4=20
 arch/arm64/mm/proc.S                                       |    8=20
 arch/x86/include/asm/asm.h                                 |   59 ++++
 arch/x86/include/asm/irqflags.h                            |    2=20
 arch/x86/kernel/Makefile                                   |    1=20
 arch/x86/kernel/irqflags.S                                 |   26 +
 block/blk-core.c                                           |    9=20
 crypto/af_alg.c                                            |    4=20
 drivers/atm/zatm.c                                         |    2=20
 drivers/cpufreq/cppc_cpufreq.c                             |   46 +++
 drivers/crypto/amcc/crypto4xx_core.c                       |   23 -
 drivers/media/rc/rc-main.c                                 |    4=20
 drivers/mtd/nand/denali_dt.c                               |    6=20
 drivers/net/ethernet/atheros/alx/main.c                    |    8=20
 drivers/net/ethernet/broadcom/bcm63xx_enet.c               |   34 +-
 drivers/net/ethernet/cadence/macb_ptp.c                    |    5=20
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c            |    2=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c              |   24 +
 drivers/net/ethernet/marvell/mvneta.c                      |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c              |    8=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          |   12=20
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c           |    8=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h          |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c          |    3=20
 drivers/net/ethernet/mellanox/mlx5/core/fw.c               |    5=20
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c         |    9=20
 drivers/net/ethernet/mellanox/mlx5/core/port.c             |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c            |    7=20
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c                 |    8=20
 drivers/net/ethernet/qlogic/qed/qed_dev.c                  |    2=20
 drivers/net/ethernet/qlogic/qed/qed_main.c                 |    8=20
 drivers/net/ethernet/qlogic/qed/qed_sriov.c                |   19 +
 drivers/net/ethernet/qlogic/qede/qede_ptp.c                |   10=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |   10=20
 drivers/net/ethernet/sun/sungem.c                          |   22 -
 drivers/net/geneve.c                                       |    2=20
 drivers/net/hyperv/hyperv_net.h                            |    2=20
 drivers/net/hyperv/netvsc.c                                |   37 ++
 drivers/net/hyperv/netvsc_drv.c                            |   17 +
 drivers/net/hyperv/rndis_filter.c                          |   61 ----
 drivers/net/ipvlan/ipvlan_main.c                           |    3=20
 drivers/net/usb/lan78xx.c                                  |    5=20
 drivers/net/usb/qmi_wwan.c                                 |    1=20
 drivers/net/usb/r8152.c                                    |    3=20
 drivers/net/vxlan.c                                        |    4=20
 drivers/net/wireless/realtek/rtlwifi/base.c                |   17 -
 drivers/net/wireless/realtek/rtlwifi/base.h                |    2=20
 drivers/net/wireless/realtek/rtlwifi/core.c                |    3=20
 drivers/net/wireless/realtek/rtlwifi/pci.c                 |    2=20
 drivers/net/wireless/realtek/rtlwifi/ps.c                  |    4=20
 drivers/net/wireless/realtek/rtlwifi/usb.c                 |    2=20
 drivers/pci/dwc/pci-exynos.c                               |    3=20
 drivers/pci/host/pci-hyperv.c                              |    8=20
 drivers/usb/host/xhci-hub.c                                |    2=20
 drivers/vhost/net.c                                        |    3=20
 fs/autofs4/dev-ioctl.c                                     |   22 -
 fs/btrfs/tree-log.c                                        |  137 ++++++++-
 fs/ocfs2/aops.c                                            |   26 +
 fs/ocfs2/cluster/nodemanager.c                             |   63 +++-
 fs/reiserfs/prints.c                                       |  141 +++++---=
--
 include/linux/arm-smccc.h                                  |   10=20
 include/linux/atmdev.h                                     |   15 +
 include/linux/backing-dev-defs.h                           |    2=20
 include/linux/compiler-gcc.h                               |   29 +-
 include/linux/mlx5/mlx5_ifc.h                              |    2=20
 include/linux/netdevice.h                                  |   20 +
 include/linux/string.h                                     |    2=20
 kernel/time/clocksource.c                                  |    2=20
 mm/backing-dev.c                                           |   20 -
 net/8021q/vlan.c                                           |    2=20
 net/atm/br2684.c                                           |    3=20
 net/atm/clip.c                                             |    3=20
 net/atm/common.c                                           |    3=20
 net/atm/lec.c                                              |    3=20
 net/atm/mpc.c                                              |    3=20
 net/atm/pppoatm.c                                          |    3=20
 net/atm/raw.c                                              |    4=20
 net/bridge/netfilter/ebtables.c                            |   13=20
 net/dccp/ccids/ccid3.c                                     |   16 -
 net/dns_resolver/dns_key.c                                 |   28 +-
 net/ipv4/fou.c                                             |    4=20
 net/ipv4/gre_offload.c                                     |    2=20
 net/ipv4/inet_hashtables.c                                 |    4=20
 net/ipv4/sysctl_net_ipv4.c                                 |   18 -
 net/ipv4/tcp_input.c                                       |    9=20
 net/ipv4/udp_offload.c                                     |    2=20
 net/ipv6/inet6_hashtables.c                                |    4=20
 net/ipv6/netfilter/nf_conntrack_reasm.c                    |    2=20
 net/ipv6/seg6_hmac.c                                       |    2=20
 net/nfc/llcp_commands.c                                    |    9=20
 net/nsh/nsh.c                                              |    2=20
 net/packet/af_packet.c                                     |   16 -
 net/rds/loop.c                                             |    1=20
 net/rds/rds.h                                              |    5=20
 net/rds/recv.c                                             |    5=20
 net/sched/sch_blackhole.c                                  |    2=20
 net/strparser/strparser.c                                  |   17 -
 net/sunrpc/xprtrdma/verbs.c                                |   13=20
 net/tls/tls_sw.c                                           |    2=20
 net/vmw_vsock/virtio_transport.c                           |    2=20
 virt/kvm/arm/arm.c                                         |   22 -
 virt/kvm/arm/hyp/vgic-v2-sr.c                              |    2=20
 virt/kvm/arm/psci.c                                        |   18 +
 133 files changed, 1697 insertions(+), 471 deletions(-)

Alan Jenkins (1):
      block: do not use interruptible wait anywhere

Aleksander Morgado (1):
      qmi_wwan: add support for the Dell Wireless 5821e module

Alex Vesker (2):
      net/mlx5: Fix command interface race in polling mode
      net/mlx5: Fix incorrect raw command length parsing

Antoine Tenart (1):
      net: mvneta: fix the Rx desc DMA address in the Rx path

Bhadram Varka (1):
      stmmac: fix DMA channel hang in half-duplex mode

Christian Lamparter (2):
      crypto: crypto4xx - remove bad list_del
      crypto: crypto4xx - fix crypto4xx_build_pdr, crypto4xx_build_sdr leak

Christoffer Dall (1):
      KVM: arm64: Avoid storing the vcpu pointer on the stack

Chuck Lever (1):
      xprtrdma: Fix corner cases when handling device removal

Claudio Imbrenda (1):
      VSOCK: fix loopback on big-endian systems

Dave Watson (1):
      tls: Stricter error checking in zerocopy sendmsg path

David Ahern (1):
      net/tcp: Fix socket lookups with SO_BINDTODEVICE

David Woodhouse (1):
      atm: Preserve value of skb->truesize when accounting to vcc

Dexuan Cui (1):
      PCI: hv: Disable/enable IRQs rather than BH in hv_compose_msi_msg()

Doron Roberts-Kedes (1):
      strparser: Remove early eaten to fix full tcp receive buffer stall

Eli Cohen (1):
      net/mlx5: Fix required capability for manipulating MPFS

Eric Biggers (3):
      ipv6: sr: fix passing wrong flags to crypto_alloc_shash()
      reiserfs: fix buffer overflow with long warning messages
      KEYS: DNS: fix parsing multiple options

Eric Dumazet (4):
      net: dccp: avoid crash in ccid3_hc_rx_send_feedback()
      net: dccp: switch rx_tstamp_last_feedback to monotonic clock
      net/packet: fix use-after-free
      net: sungem: fix rx checksum support

Filipe Manana (1):
      Btrfs: fix duplicate extents after fsync of file with prealloc extents

Florian Westphal (2):
      netfilter: ebtables: reject non-bridge targets
      netfilter: ipv6: nf_defrag: drop skb dst before queueing

Greg Kroah-Hartman (1):
      Linux 4.14.57

Gustavo A. R. Silva (2):
      atm: zatm: Fix potential Spectre v1
      net: cxgb3_main: fix potential Spectre v1

H. Peter Anvin (1):
      x86/asm: Add _ASM_ARG* constants for argument registers to <asm/asm.h>

Harini Katakam (1):
      net: macb: Fix ptp time adjustment for large negative delta

Ilpo J=E4rvinen (1):
      tcp: prevent bogus FRTO undos with non-SACK flows

Jaehoon Chung (1):
      PCI: exynos: Fix a potential init_clk_resources NULL pointer derefere=
nce

James Morse (5):
      KVM: arm64: Store vcpu on the stack during __guest_enter()
      KVM: arm/arm64: Convert kvm_host_cpu_state to a static per-cpu alloca=
tion
      KVM: arm64: Change hyp_panic()s dependency on tpidr_el2
      arm64: alternatives: use tpidr_el2 on VHE hosts
      KVM: arm64: Stop save/restoring host tpidr_el1 on VHE

Jan Kara (1):
      bdi: Fix another oops in wb_workfn()

Jason Wang (1):
      vhost_net: validate sock before trying to put its fd

Jesper Dangaard Brouer (1):
      ixgbe: split XDP_TX tail and XDP_REDIRECT map flushing

Jiri Slaby (1):
      r8152: napi hangup fix after disconnect

Jonas Gorski (2):
      bcm63xx_enet: correct clock usage
      bcm63xx_enet: do not write to random DMA channel on BCM6345

Konstantin Khlebnikov (1):
      net_sched: blackhole: tell upper qdisc about dropped packets

Marc Zyngier (16):
      arm64: alternatives: Add dynamic patching feature
      KVM: arm/arm64: Do not use kern_hyp_va() with kvm_vgic_global_state
      arm/arm64: smccc: Add SMCCC-specific return codes
      arm64: Call ARCH_WORKAROUND_2 on transitions between EL0 and EL1
      arm64: Add per-cpu infrastructure to call ARCH_WORKAROUND_2
      arm64: Add ARCH_WORKAROUND_2 probing
      arm64: Add 'ssbd' command-line option
      arm64: ssbd: Add global mitigation state accessor
      arm64: ssbd: Skip apply_ssbd if not using dynamic mitigation
      arm64: ssbd: Restore mitigation status on CPU resume
      arm64: ssbd: Introduce thread flag to control userspace mitigation
      arm64: ssbd: Add prctl interface for per-thread mitigation
      arm64: KVM: Add HYP per-cpu accessors
      arm64: KVM: Add ARCH_WORKAROUND_2 support for guests
      arm64: KVM: Handle guest's ARCH_WORKAROUND_2 requests
      arm64: KVM: Add ARCH_WORKAROUND_2 discovery through ARCH_FEATURES_FUN=
C_ID

Masahiro Yamada (1):
      mtd: rawnand: denali_dt: set clk_x_rate to 200 MHz unconditionally

Mathias Nyman (1):
      xhci: Fix USB3 NULL pointer dereference at logical disconnect.

Nick Desaulniers (2):
      compiler-gcc.h: Add __attribute__((gnu_inline)) to all inline declara=
tions
      x86/paravirt: Make native_save_fl() extern inline

Or Gerlitz (3):
      net/mlx5e: Avoid dealing with vport representors if not being e-switc=
h manager
      net/mlx5e: Don't attempt to dereference the ppriv struct if not being=
 eswitch manager
      net/mlx5: E-Switch, Avoid setup attempt if not being e-switch manager

Peter Zijlstra (1):
      clocksource: Initialize cs->wd_list

Ping-Ke Shih (2):
      rtlwifi: Fix kernel Oops "Fw download fail!!"
      rtlwifi: rtl8821ae: fix firmware is not ready to run

Prashanth Prakash (1):
      cpufreq / CPPC: Set platform specific transition_delay_us

Sabrina Dubroca (2):
      alx: take rtnl before calling __alx_open from resume
      net: fix use-after-free in GRO with ESP

Santosh Shilimkar (1):
      rds: avoid unenecessary cong_update in loop transport

Sean Young (1):
      media: rc: oops in ir_timer_keyup after device unplug

Shay Agroskin (1):
      net/mlx5: Fix wrong size allocation for QoS ETC TC regitster

Stefan Wahren (1):
      net: lan78xx: Fix race in tx pending skb size calculation

Stephan Mueller (1):
      crypto: af_alg - Initialize sg_num_bytes in error code path

Stephen Hemminger (1):
      hv_netvsc: split sub-channel setup into async and sync

Sudarsana Reddy Kalluru (4):
      qede: Adverstise software timestamp caps when PHC is not available.
      qed: Fix setting of incorrect eswitch mode.
      qed: Fix use of incorrect size in memcpy call.
      qed: Limit msix vectors in kdump kernel to the minimum required count.

Tejun Heo (1):
      string: drop __must_check from strscpy() and restore strscpy() usages=
 in cgroup

Tetsuo Handa (1):
      net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.

Tomas Bortoli (1):
      autofs: fix slab out of bounds read in getname_kernel()

Willem de Bruijn (1):
      nsh: set mac len based on inner packet

Xin Long (1):
      ipvlan: fix IFLA_MTU ignored on NEWLINK

Yuchung Cheng (1):
      tcp: fix Fast Open key endianness

alex chen (2):
      ocfs2: subsystem.su_mutex is required while accessing the item->ci_pa=
rent
      ocfs2: ip_alloc_sem should be taken in ocfs2_get_block()


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltUi/kACgkQONu9yGCS
aT6kgg/9HzzzpUXmq/JV4TsBXyhL0qYLsWuq8dr84G2VcMPqi1JoGzBqkbSP3ST5
vHWo6nkotZYpugmLLr+PeDXzBMPqnuPmBaB6KdORYNbSbWjQvFVeaU3BgV7hqOER
kd422EPLMIJ8OoYlnEYoU6CeL6YGEX1jmWvpl+L9yia5B88UyWpcaVwVcHe1z4Uk
aTasxOtE7fq8+CGnl69ofrYa7YqWEne246KCEgobeayg1VW4RoH3mXV/H07rdweS
zfCB9PEhfihRDUNUj4/lzrht9zyVY605iAx5z2bia/TYcdazFab3HZ88UlBRiss0
GG1W1fFa47rsDADaXBwGS7eUj1zYPmfrw2JsFImokvRL5C9+8xSAIo+LVpbsfLS7
x5nHNaOHXr9l9nC4lWW/HFB56sJHWyu/BiWYtoRYL5BOY8WaWtijwH63Vntd/Hln
zG6GL7znvXyTsHAuyS9JKemMS9M2H9Sl8z91fhvjOz+9nSpVRjmd4pRSAdro1XAN
TasQoaJJAv7XrYqhsNmbv/rFyROejMFfSvms1R39lGxafJfdUGIWs0r/0+9x2F9o
yNp7cNjwEbSMwldyppk6xhhy6ar4nMA56ZEngMOtx3YlBe3pg+nwyuwBaEPostV6
UL4StDoNnKVFGDGhZKWf/3FXjFs+Wdly/+QJRru6FjB6P6/wGrs=
=rClq
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

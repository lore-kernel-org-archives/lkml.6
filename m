Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E288EECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8505420875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8505420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbeGVOtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:49:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51608 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbeGVOtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:49:06 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C0DCA95;
        Sun, 22 Jul 2018 13:52:19 +0000 (UTC)
Date:   Sun, 22 Jul 2018 15:52:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.9
Message-ID: <20180722135217.GA32469@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.9 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt            |   17 +
 Makefile                                                   |    2=20
 arch/arm/include/asm/kvm_host.h                            |   12=20
 arch/arm/include/asm/kvm_mmu.h                             |    5=20
 arch/arm/net/bpf_jit_32.c                                  |    2=20
 arch/arm64/Kconfig                                         |    9=20
 arch/arm64/include/asm/cpucaps.h                           |    3=20
 arch/arm64/include/asm/cpufeature.h                        |   22 +
 arch/arm64/include/asm/kvm_asm.h                           |   30 ++
 arch/arm64/include/asm/kvm_host.h                          |   26 +
 arch/arm64/include/asm/kvm_mmu.h                           |   24 +
 arch/arm64/include/asm/thread_info.h                       |    1=20
 arch/arm64/kernel/Makefile                                 |    1=20
 arch/arm64/kernel/asm-offsets.c                            |    1=20
 arch/arm64/kernel/cpu_errata.c                             |  180 ++++++++=
+++++
 arch/arm64/kernel/entry.S                                  |   30 ++
 arch/arm64/kernel/hibernate.c                              |   11=20
 arch/arm64/kernel/ssbd.c                                   |  110 +++++++
 arch/arm64/kernel/suspend.c                                |    8=20
 arch/arm64/kvm/hyp/hyp-entry.S                             |   38 ++
 arch/arm64/kvm/hyp/switch.c                                |   42 +++
 arch/arm64/kvm/reset.c                                     |    4=20
 arch/x86/include/asm/asm.h                                 |   59 ++++
 arch/x86/include/asm/irqflags.h                            |    2=20
 arch/x86/kernel/Makefile                                   |    1=20
 arch/x86/kernel/irqflags.S                                 |   26 +
 arch/x86/kvm/Kconfig                                       |    2=20
 block/blk-core.c                                           |    4=20
 block/blk-merge.c                                          |   10=20
 crypto/af_alg.c                                            |    4=20
 drivers/atm/zatm.c                                         |    2=20
 drivers/infiniband/hw/mlx5/main.c                          |    2=20
 drivers/net/ethernet/atheros/alx/main.c                    |    8=20
 drivers/net/ethernet/cadence/macb_main.c                   |    2=20
 drivers/net/ethernet/cadence/macb_ptp.c                    |    5=20
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c            |    2=20
 drivers/net/ethernet/cisco/enic/enic_main.c                |    9=20
 drivers/net/ethernet/huawei/hinic/hinic_rx.c               |    1=20
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                |   24 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c              |   24 +
 drivers/net/ethernet/marvell/mvneta.c                      |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c              |    8=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          |   12=20
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c           |    8=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c          |    3=20
 drivers/net/ethernet/mellanox/mlx5/core/fw.c               |    5=20
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c         |    9=20
 drivers/net/ethernet/mellanox/mlx5/core/port.c             |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c            |    7=20
 drivers/net/ethernet/netronome/nfp/bpf/main.c              |    3=20
 drivers/net/ethernet/netronome/nfp/flower/match.c          |   14 +
 drivers/net/ethernet/netronome/nfp/flower/offload.c        |   11=20
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c                 |    8=20
 drivers/net/ethernet/qlogic/qed/qed_dev.c                  |    2=20
 drivers/net/ethernet/qlogic/qed/qed_main.c                 |    8=20
 drivers/net/ethernet/qlogic/qed/qed_sriov.c                |   19 +
 drivers/net/ethernet/qlogic/qede/qede_ptp.c                |   10=20
 drivers/net/ethernet/sfc/farch.c                           |    1=20
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
 drivers/net/virtio_net.c                                   |   30 +-
 drivers/net/vxlan.c                                        |    4=20
 drivers/net/wireless/realtek/rtlwifi/base.c                |   17 -
 drivers/net/wireless/realtek/rtlwifi/base.h                |    2=20
 drivers/net/wireless/realtek/rtlwifi/core.c                |    3=20
 drivers/net/wireless/realtek/rtlwifi/pci.c                 |    2=20
 drivers/net/wireless/realtek/rtlwifi/ps.c                  |    4=20
 drivers/net/wireless/realtek/rtlwifi/usb.c                 |    2=20
 drivers/net/xen-netfront.c                                 |   11=20
 drivers/pci/host/pci-hyperv.c                              |    8=20
 drivers/pinctrl/mediatek/pinctrl-mt7622.c                  |   25 +
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c                      |   12=20
 drivers/s390/net/qeth_core.h                               |   11=20
 drivers/s390/net/qeth_core_main.c                          |   24 +
 drivers/s390/net/qeth_l2_main.c                            |   19 -
 drivers/vhost/net.c                                        |    3=20
 fs/autofs4/dev-ioctl.c                                     |   22 -
 fs/reiserfs/prints.c                                       |  141 +++++---=
--
 include/linux/arm-smccc.h                                  |   10=20
 include/linux/atmdev.h                                     |   15 +
 include/linux/backing-dev-defs.h                           |    2=20
 include/linux/blk_types.h                                  |    2=20
 include/linux/compiler-gcc.h                               |   29 +-
 include/linux/filter.h                                     |   42 ---
 include/linux/mlx5/eswitch.h                               |    2=20
 include/linux/mlx5/mlx5_ifc.h                              |    2=20
 include/linux/netdevice.h                                  |   20 +
 include/net/pkt_cls.h                                      |    5=20
 kernel/bpf/core.c                                          |   25 +
 kernel/bpf/sockmap.c                                       |   63 +++-
 kernel/bpf/syscall.c                                       |    4=20
 kernel/bpf/verifier.c                                      |   11=20
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
 net/core/dev_ioctl.c                                       |   11=20
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
 net/netfilter/ipvs/ip_vs_lblc.c                            |    1=20
 net/netfilter/ipvs/ip_vs_lblcr.c                           |    1=20
 net/nfc/llcp_commands.c                                    |    9=20
 net/nsh/nsh.c                                              |    2=20
 net/packet/af_packet.c                                     |   16 -
 net/rds/loop.c                                             |    1=20
 net/rds/rds.h                                              |    5=20
 net/rds/recv.c                                             |    5=20
 net/sched/act_ife.c                                        |   12=20
 net/sched/sch_blackhole.c                                  |    2=20
 net/strparser/strparser.c                                  |   17 -
 net/tls/tls_sw.c                                           |    2=20
 net/vmw_vsock/virtio_transport.c                           |    2=20
 virt/kvm/arm/arm.c                                         |    4=20
 virt/kvm/arm/psci.c                                        |   18 +
 140 files changed, 1447 insertions(+), 449 deletions(-)

Aleksander Morgado (1):
      qmi_wwan: add support for the Dell Wireless 5821e module

Alex Vesker (2):
      net/mlx5: Fix command interface race in polling mode
      net/mlx5: Fix incorrect raw command length parsing

Alexandre Belloni (1):
      net: macb: initialize bp->queues[0].bp for at91rm9200

Antoine Tenart (1):
      net: mvneta: fix the Rx desc DMA address in the Rx path

Bert Kenward (1):
      sfc: correctly initialise filter rwsem for farch

Bhadram Varka (1):
      stmmac: fix DMA channel hang in half-duplex mode

Claudio Imbrenda (1):
      VSOCK: fix loopback on big-endian systems

Cong Wang (3):
      net: use dev_change_tx_queue_len() for SIOCSIFTXQLEN
      ipvs: initialize tbl->entries after allocation
      ipvs: initialize tbl->entries in ip_vs_lblc_init_svc()

Daniel Borkmann (4):
      bpf: reject any prog that failed read-only lock
      bpf: don't leave partial mangled prog in jit_subprogs error path
      bpf, arm32: fix to use bpf_jit_binary_lock_ro api
      bpf: undo prog rejection on read-only lock failure

Dave Watson (1):
      tls: Stricter error checking in zerocopy sendmsg path

David Ahern (1):
      net/tcp: Fix socket lookups with SO_BINDTODEVICE

David Woodhouse (1):
      atm: Preserve value of skb->truesize when accounting to vcc

Davide Caratti (2):
      net/sched: act_ife: fix recursive lock and idr leak
      net/sched: act_ife: preserve the action control in case of error

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

Eric Dumazet (5):
      net: dccp: avoid crash in ccid3_hc_rx_send_feedback()
      net: dccp: switch rx_tstamp_last_feedback to monotonic clock
      net/packet: fix use-after-free
      net: sungem: fix rx checksum support
      bpf: enforce correct alignment for instructions

Florian Westphal (2):
      netfilter: ebtables: reject non-bridge targets
      netfilter: ipv6: nf_defrag: drop skb dst before queueing

Govindarajulu Varadarajan (1):
      enic: do not overwrite error code

Greg Kroah-Hartman (1):
      Linux 4.17.9

Gustavo A. R. Silva (2):
      atm: zatm: Fix potential Spectre v1
      net: cxgb3_main: fix potential Spectre v1

H. Peter Anvin (1):
      x86/asm: Add _ASM_ARG* constants for argument registers to <asm/asm.h>

Harini Katakam (1):
      net: macb: Fix ptp time adjustment for large negative delta

Ilpo J=E4rvinen (1):
      tcp: prevent bogus FRTO undos with non-SACK flows

Jan Kara (1):
      bdi: Fix another oops in wb_workfn()

Janakarajan Natarajan (1):
      x86/kvm/Kconfig: Ensure CRYPTO_DEV_CCP_DD state at minimum matches KV=
M_AMD

Jason Wang (1):
      vhost_net: validate sock before trying to put its fd

Jens Axboe (1):
      block: don't use blocking queue entered for recursive bio submits

Jesper Dangaard Brouer (3):
      ixgbe: split XDP_TX tail and XDP_REDIRECT map flushing
      i40e: split XDP_TX tail and XDP_REDIRECT map flushing
      virtio_net: split XDP_TX kick and XDP_REDIRECT map flushing

Jiri Slaby (1):
      r8152: napi hangup fix after disconnect

John Fastabend (2):
      bpf: sockmap, fix crash when ipv6 sock is added
      bpf: sockmap, consume_skb in close path

John Hurley (1):
      nfp: reject binding to shared blocks

Julian Wiedmann (3):
      s390/qeth: don't clobber buffer on async TX completion
      Revert "s390/qeth: use Read device to query hypervisor for MAC"
      s390/qeth: fix race when setting MAC address

Konstantin Khlebnikov (1):
      net_sched: blackhole: tell upper qdisc about dropped packets

Marc Zyngier (14):
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

Nick Desaulniers (2):
      compiler-gcc.h: Add __attribute__((gnu_inline)) to all inline declara=
tions
      x86/paravirt: Make native_save_fl() extern inline

Niklas S=F6derlund (1):
      pinctrl: sh-pfc: r8a77970: remove SH_PFC_PIN_CFG_DRIVE_STRENGTH flag

Or Gerlitz (4):
      net/mlx5e: Avoid dealing with vport representors if not being e-switc=
h manager
      net/mlx5e: Don't attempt to dereference the ppriv struct if not being=
 eswitch manager
      net/mlx5: E-Switch, Avoid setup attempt if not being e-switch manager
      IB/mlx5: Avoid dealing with vport representors if not being e-switch =
manager

Pieter Jansen van Vuuren (1):
      nfp: flower: fix mpls ether type detection

Ping-Ke Shih (2):
      rtlwifi: Fix kernel Oops "Fw download fail!!"
      rtlwifi: rtl8821ae: fix firmware is not ready to run

Ross Lagerwall (2):
      xen-netfront: Fix mismatched rtnl_unlock
      xen-netfront: Update features after registering netdev

Sabrina Dubroca (2):
      alx: take rtnl before calling __alx_open from resume
      net: fix use-after-free in GRO with ESP

Santosh Shilimkar (1):
      rds: avoid unenecessary cong_update in loop transport

Sean Wang (3):
      pinctrl: mt7622: fix error path on failing at groups building
      pinctrl: mt7622: stop using the deprecated pinctrl_add_gpio_range
      pinctrl: mt7622: fix a kernel panic when gpio-hog is being applied

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

Tetsuo Handa (1):
      net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.

Tomas Bortoli (1):
      autofs: fix slab out of bounds read in getname_kernel()

Vasily Gorbik (1):
      s390/qeth: avoid using is_multicast_ether_addr_64bits on (u8 *)[6]

Wei Yongjun (1):
      hinic: reset irq affinity before freeing irq

Willem de Bruijn (1):
      nsh: set mac len based on inner packet

Xin Long (1):
      ipvlan: fix IFLA_MTU ignored on NEWLINK

Yuchung Cheng (1):
      tcp: fix Fast Open key endianness


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltUjBEACgkQONu9yGCS
aT7NjxAAkZNxqaHo3CfBKA/M1QowBdoxqzgp5tDOYCEw3k0dadWA2uMrJe3Jqmh9
iaZbfF2m8K7UAGMTsQoE1IRtqX4Oc+5B/6lYpuiHmVWLo7WxkCspdASdDTOoQjlo
IfKqNi6K5opJVv3M8hQM16i+Tyy24nM1TXqhp7KgXkFsAK25nix8zYZf60831Yoz
1Z9NWmIKcf6d4ZlvEoA4as02f1KO5i5K4CuPnGMUyklA5PKK+o4GFl7TUYGBH/HF
/dOu2FzRkTKqnG5NrB2vzZtJrkqWb0JtxGqk4dAab9k+7uW1DDnIbDpzEfbqLgnr
5Mhv1fxO1fht6jq72+HBedWttzTv3tjbgZzo89Fg8uXm2LerVtWSMbkmCWmu07kC
329xNWSez+7q/2L8yNLxGP/qhuXZVqveVtFZGcFCbkbczvo2TkHb0NwE5XhyZOdE
vcCGi9xxnFTzs2aW5RrAMYbop+Q8YY8dFvHkysCXAeTPBGVeT9iwhWRE+W0USRCR
lQeZzm7wuj3fQhVy4N/e37nRG/rQoo0Tk7J8b66qjRmtzd65+D+R1kMEYTZvof8f
ZRuzJhtgZUklXC1Cc0T70keDZ9UmMGBM8soX8YizNGBiO9RV+znznViXk2BGgxsc
1enH1yvAQInFo3khdgrtdzWlZyio02IOIzxSlxjINvRXzWEjvB8=
=EUZB
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeEKVAY convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:00:24 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:50848 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEKVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:00:21 -0400
Date: Fri, 11 May 2018 17:00:18 -0400 (EDT)
Message-Id: <20180511.170018.656888133931954275.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Verify lengths of keys provided by the user is AF_KEY, from
   Kevin Easton.

2) Add device ID for BCM89610 PHY.  Thanks to Bhadram Varka.

3) Add Spectre guards to some ATM code, courtesy of Gustavo
   A. R. Silva.

4) Fix infinite loop in NSH protocol code.  To Eric Dumazet
   we are most grateful for this fix.

5) Line up /proc/net/netlink headers properly.  This fix from YU Bo,
   we do appreciate.

6) Use after free in TLS code.  Once again we are blessed by the
   honorable Eric Dumazet with this fix.

7) Fix regression in TLS code causing stalls on partial TLS records.
   This fix is bestowed upon us by Andrew Tomt.

8) Deal with too small MTUs properly in LLC code, another great gift
   from Eric Dumazet.

9) Handle cached route flushing properly wrt. MTU locking in ipv4,
   to Hangbin Liu we give thanks for this.

10) Fix regression in SO_BINDTODEVIC handling wrt. UDP socket demux.
    Paolo Abeni, he gave us this.

11) Range check coalescing parameters in mlx4 driver, thank you
    Moshe Shemesh.

12) Some ipv6 ICMP error handling fixes in rxrpc, from our good
    brother David Howells.

13) Fix kexec on mlx5 by freeing IRQs in shutdown path.  Daniel
    Juergens, you're the best!

14) Don't send bonding RLB updates to invalid MAC addresses.
    Debabrata Benerjee saved us!

15) Uh oh, we were leaking in udp_sendmsg and ping_v4_sendmsg.  The
    ship is now water tight, thanks to Andrey Ignatov.

16) IPSEC memory leak in ixgbe from Colin Ian King, man we've got
    holes everywhere!

17) Fix error path in tcf_proto_create, Jiri Pirko what would we
    do without you!

Please pull, thanks a lot!

The following changes since commit 1504269814263c9676b4605a6a91e14dc6ceac21:

  Merge tag 'linux-kselftest-4.17-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2018-05-03 19:26:51 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to a52956dfc503f8cc5cfe6454959b7049fddb4413:

  net sched actions: fix refcnt leak in skbmod (2018-05-11 16:37:03 -0400)

----------------------------------------------------------------
Adi Nissim (1):
      net/mlx5: E-Switch, Include VF RDMA stats in vport statistics

Alexander Aring (1):
      net: ieee802154: 6lowpan: fix frag reassembly

Anders Roxell (1):
      selftests: net: use TEST_PROGS_EXTENDED

Andre Tomt (1):
      net/tls: Fix connection stall on partial tls record

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix PHY interrupts by parameterising PHY base address

Andrey Ignatov (1):
      ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg

Antoine Tenart (1):
      net: phy: sfp: fix the BR,min computation

Bhadram Varka (1):
      net: phy: broadcom: add support for BCM89610 PHY

Christophe JAILLET (2):
      net/mlx4_en: Fix an error handling path in 'mlx4_en_init_netdev()'
      mlxsw: core: Fix an error handling path in 'mlxsw_core_bus_device_register()'

Colin Ian King (5):
      firestream: fix spelling mistake: "reseverd" -> "reserved"
      sctp: fix spelling mistake: "max_retans" -> "max_retrans"
      net/9p: fix spelling mistake: "suspsend" -> "suspend"
      qed: fix spelling mistake: "taskelt" -> "tasklet"
      ixgbe: fix memory leak on ipsec allocation

Daniel Borkmann (1):
      bpf: use array_index_nospec in find_prog_type

Daniel Jurgens (1):
      net/mlx5: Free IRQs in shutdown path

David Howells (5):
      rxrpc: Fix missing start of call timeout
      rxrpc: Fix error reception on AF_INET6 sockets
      rxrpc: Fix the min security level for kernel calls
      rxrpc: Add a tracepoint to log ICMP/ICMP6 and error messages
      rxrpc: Trace UDP transmission failure

David S. Miller (13):
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge branch 'Aquantia-various-patches-2018-05'
      Merge branch 'ieee802154-for-davem-2018-05-08' of git://git.kernel.org/.../sschmidt/wpan
      Merge tag 'linux-can-fixes-for-4.17-20180508' of ssh://gitolite.kernel.org/.../mkl/linux-can
      Merge branch 'qed-rdma-fixes'
      Merge tag 'mac80211-for-davem-2018-05-09' of git://git.kernel.org/.../jberg/mac80211
      Merge tag 'linux-can-fixes-for-4.17-20180510' of ssh://gitolite.kernel.org/.../mkl/linux-can
      Merge branch 'bonding-bug-fixes-and-regressions'
      Merge tag 'mlx5-fixes-2018-05-10' of git://git.kernel.org/.../saeed/linux
      Merge tag 'rxrpc-fixes-20180510' of git://git.kernel.org/.../dhowells/linux-fs
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/net-queue

Davide Caratti (1):
      tc-testing: fix tdc tests for 'bpf' action

Debabrata Banerjee (2):
      bonding: do not allow rlb updates to invalid mac
      bonding: send learning packets for vlans on slave

Emil Tantilov (1):
      ixgbe: return error on unsupported SFP module when resetting

Eric Dumazet (4):
      nsh: fix infinite loop
      tls: fix use after free in tls_sk_proto_close
      llc: better deal with too small mtu
      tipc: fix one byte leak in tipc_sk_set_orig_addr()

Ganesh Goudar (2):
      cxgb4: zero the HMA memory
      cxgb4: copy mbox log size to PF0-3 adap instances

Geert Uytterhoeven (1):
      dt-bindings: can: rcar_can: Fix R8A7796 SoC name

Georg Hofmann (1):
      trivial: fix inconsistent help texts

Gustavo A. R. Silva (3):
      ieee802154: mcr20a: Fix memory leak in mcr20a_probe
      atm: zatm: Fix potential Spectre v1
      net: atm: Fix potential Spectre v1

Hangbin Liu (1):
      ipv4: reset fnhe_mtu_locked after cache route flushed

Hans de Goede (3):
      Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"
      Bluetooth: btusb: Only check needs_reset_resume DMI table for QCA rome chipsets
      Bluetooth: btusb: Add Dell XPS 13 9360 to btusb_needs_reset_resume_table

Heiner Kallweit (1):
      r8169: fix powering up RTL8168h

Igor Russkikh (2):
      net: aquantia: driver should correctly declare vlan_features bits
      net: aquantia: Limit number of vectors to actually allocated irqs

Ilan Peer (2):
      mac80211: Fix condition validating WMM IE
      mac80211: Adjust SAE authentication timeout

Jakob Unterwurzacher (1):
      can: dev: increase bus-off message severity

Jeff Shaw (1):
      ice: Set rq_last_status when cleaning rq

Jia-Ju Bai (1):
      net: ieee802154: atusb: Replace GFP_ATOMIC with GFP_KERNEL in atusb_probe

Jimmy Assarsson (1):
      can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()

Jiri Pirko (1):
      net: sched: fix error path in tcf_proto_create() when modules are not configured

Johan Hovold (1):
      rfkill: gpio: fix memory leak in probe error path

Johannes Berg (1):
      cfg80211: limit wiphy names to 128 bytes

Kevin Easton (1):
      af_key: Always verify length of provided sadb_key

Luc Van Oostenryck (1):
      ixgbevf: fix ixgbevf_xmit_frame()'s return type

Lukas Wunner (2):
      can: hi311x: Acquire SPI lock on ->do_get_berr_counter
      can: hi311x: Work around TX complete interrupt erratum

Mark Rutland (1):
      bpf: fix possible spectre-v1 in find_and_alloc_map()

Michael Chan (1):
      tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().

Michal Kalderon (2):
      qed: Fix l2 initializations over iWARP personality
      qede: Fix gfp flags sent to rdma event node allocation

Mohammed Gamal (1):
      hv_netvsc: Fix net device attach on older Windows hosts

Moritz Fischer (2):
      net: nixge: Fix error path for obtaining mac address
      net: nixge: Address compiler warnings about signedness

Moshe Shemesh (1):
      net/mlx4_en: Verify coalescing parameters are in range

Paolo Abeni (1):
      udp: fix SO_BINDTODEVICE

Pieter Jansen van Vuuren (1):
      nfp: flower: remove headroom from max MTU calculation

Randy Dunlap (1):
      mac80211: fix kernel-doc "bad line" warning

Rob Taglang (1):
      net: ethernet: sun: niu set correct packet size in skb

Roi Dayan (1):
      net/mlx5e: Err if asked to offload TC match on frag being first

Roman Mashak (2):
      net sched actions: fix invalid pointer dereferencing if skbedit flags missing
      net sched actions: fix refcnt leak in skbmod

Sara Sharon (1):
      mac80211: use timeout from the AddBA response instead of the request

Sergei Shtylyov (2):
      DT: net: can: rcar_canfd: document R8A77970 bindings
      DT: net: can: rcar_canfd: document R8A77980 bindings

Srinivas Dasari (1):
      nl80211: Free connkeys on external authentication failure

Stefan Schmidt (1):
      net: ieee802154: mcr20a: do not leak resources on error path

Stefano Brivio (2):
      vti6: Change minimum MTU to IPV4_MIN_MTU, vti6 can carry IPv4 too
      openvswitch: Don't swap table in nlattr_set() after OVS_ATTR_NESTED is found

Steffen Klassert (2):
      xfrm: Fix warning in xfrm6_tunnel_net_exit.
      MAINTAINERS: Update the 3c59x network driver entry

Stephen Hemminger (1):
      hv_netvsc: set master device

Sun Lianwen (1):
      net/9p: correct some comment errors in 9p file system code

Uwe Kleine-König (2):
      can: flexcan: fix endianess detection
      arm: dts: imx[35]*: declare flexcan devices to be compatible to imx25's flexcan

Wolfram Sang (1):
      net: flow_dissector: fix typo 'can by' to 'can be'

Xin Long (2):
      sctp: delay the authentication for the duplicated cookie-echo chunk
      sctp: remove sctp_chunk_put from fail_mark err path in sctp_ulpevent_make_rcvmsg

YU Bo (1):
      net/netlink: make sure the headers line up actual value output

Ying Xue (1):
      tipc: eliminate KMSAN uninit-value in strcmp complaint

YueHaibing (1):
      mac80211_hwsim: fix a possible memory leak in hwsim_new_radio_nl()

weiyongjun (A) (1):
      cfg80211: fix possible memory leak in regdb_query_country()

 Documentation/devicetree/bindings/net/can/rcar_canfd.txt     |  4 ++-
 MAINTAINERS                                                  |  4 +--
 arch/arm/boot/dts/imx35.dtsi                                 |  4 +--
 arch/arm/boot/dts/imx53.dtsi                                 |  4 +--
 drivers/atm/firestream.c                                     |  2 +-
 drivers/atm/zatm.c                                           |  3 +++
 drivers/bluetooth/btusb.c                                    | 19 +++++++++++---
 drivers/net/bonding/bond_alb.c                               | 15 ++++++-----
 drivers/net/bonding/bond_main.c                              |  2 ++
 drivers/net/can/dev.c                                        |  2 +-
 drivers/net/can/flexcan.c                                    | 26 ++++++++++---------
 drivers/net/can/spi/hi311x.c                                 | 11 +++++---
 drivers/net/can/usb/kvaser_usb.c                             |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                             | 26 +++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h                             |  1 +
 drivers/net/dsa/mv88e6xxx/global2.c                          |  2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c              |  3 +++
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h              |  1 +
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c         | 20 +++++++-------
 drivers/net/ethernet/broadcom/tg3.c                          |  9 ++++---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c              |  7 +++--
 drivers/net/ethernet/intel/ice/ice_controlq.c                |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c               |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                |  3 +++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c            |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c              | 16 ++++++++++++
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c               |  8 +-----
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h                 |  7 +++--
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c              |  4 +++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c                 | 28 ++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c            | 11 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/main.c               |  8 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h          |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/core.c                   |  4 +--
 drivers/net/ethernet/netronome/nfp/flower/main.c             | 19 --------------
 drivers/net/ethernet/ni/nixge.c                              | 10 ++++---
 drivers/net/ethernet/qlogic/qed/qed_l2.c                     |  6 ++---
 drivers/net/ethernet/qlogic/qed/qed_main.c                   |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_rdma.c                 |  2 +-
 drivers/net/ethernet/realtek/r8169.c                         |  3 +++
 drivers/net/ethernet/sun/niu.c                               |  5 ++--
 drivers/net/hyperv/netvsc_drv.c                              |  3 ++-
 drivers/net/hyperv/rndis_filter.c                            |  2 +-
 drivers/net/ieee802154/atusb.c                               |  2 +-
 drivers/net/ieee802154/mcr20a.c                              | 15 +++++++----
 drivers/net/phy/broadcom.c                                   | 10 +++++++
 drivers/net/phy/sfp-bus.c                                    |  2 +-
 drivers/net/wireless/mac80211_hwsim.c                        |  1 +
 include/linux/brcmphy.h                                      |  1 +
 include/net/bonding.h                                        |  1 +
 include/net/flow_dissector.h                                 |  2 +-
 include/net/mac80211.h                                       |  2 +-
 include/net/xfrm.h                                           |  1 +
 include/trace/events/rxrpc.h                                 | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/nl80211.h                                 |  2 ++
 kernel/bpf/syscall.c                                         | 19 ++++++++++----
 net/9p/trans_common.c                                        |  2 +-
 net/9p/trans_fd.c                                            |  4 +--
 net/9p/trans_rdma.c                                          |  4 +--
 net/9p/trans_virtio.c                                        |  5 ++--
 net/9p/trans_xen.c                                           |  2 +-
 net/atm/lec.c                                                |  9 +++++--
 net/ieee802154/6lowpan/6lowpan_i.h                           |  4 +--
 net/ieee802154/6lowpan/reassembly.c                          | 14 +++++-----
 net/ipv4/ping.c                                              |  7 +++--
 net/ipv4/route.c                                             |  1 +
 net/ipv4/udp.c                                               | 11 +++++---
 net/ipv6/Kconfig                                             |  9 +++----
 net/ipv6/ip6_vti.c                                           |  4 +--
 net/ipv6/udp.c                                               |  4 +--
 net/ipv6/xfrm6_tunnel.c                                      |  3 +++
 net/key/af_key.c                                             | 45 +++++++++++++++++++++++++-------
 net/llc/af_llc.c                                             |  3 +++
 net/mac80211/agg-tx.c                                        |  4 +++
 net/mac80211/mlme.c                                          | 27 +++++++++++++------
 net/mac80211/tx.c                                            |  3 ++-
 net/netlink/af_netlink.c                                     |  6 ++---
 net/nsh/nsh.c                                                |  4 +++
 net/openvswitch/flow_netlink.c                               |  9 +++----
 net/rfkill/rfkill-gpio.c                                     |  7 ++++-
 net/rxrpc/af_rxrpc.c                                         |  2 +-
 net/rxrpc/ar-internal.h                                      |  1 +
 net/rxrpc/conn_event.c                                       | 11 +++++---
 net/rxrpc/input.c                                            |  2 +-
 net/rxrpc/local_event.c                                      |  3 ++-
 net/rxrpc/local_object.c                                     | 57 +++++++++++++++++++++++++++++-----------
 net/rxrpc/output.c                                           | 34 ++++++++++++++++++++++--
 net/rxrpc/peer_event.c                                       | 46 ++++++++++++++++-----------------
 net/rxrpc/rxkad.c                                            |  6 +++--
 net/rxrpc/sendmsg.c                                          | 10 +++++++
 net/sched/act_skbedit.c                                      |  3 ++-
 net/sched/act_skbmod.c                                       |  5 +++-
 net/sched/cls_api.c                                          |  2 +-
 net/sctp/associola.c                                         | 30 ++++++++++++++++++++-
 net/sctp/sm_make_chunk.c                                     |  2 +-
 net/sctp/sm_statefuns.c                                      | 86 +++++++++++++++++++++++++++++++++----------------------------
 net/sctp/ulpevent.c                                          |  1 -
 net/tipc/node.c                                              | 15 +++++++++--
 net/tipc/socket.c                                            |  3 ++-
 net/tls/tls_main.c                                           | 12 ++++-----
 net/wireless/core.c                                          |  3 +++
 net/wireless/nl80211.c                                       |  1 +
 net/wireless/reg.c                                           |  1 +
 net/xfrm/xfrm_state.c                                        |  6 +++++
 tools/testing/selftests/net/Makefile                         |  2 +-
 tools/testing/selftests/tc-testing/tc-tests/actions/bpf.json | 11 +++++---
 106 files changed, 714 insertions(+), 291 deletions(-)

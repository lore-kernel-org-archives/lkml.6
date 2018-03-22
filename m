Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeCVUcg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:32:36 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60722 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeCVUcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:32:33 -0400
Date: Thu, 22 Mar 2018 16:32:30 -0400 (EDT)
Message-Id: <20180322.163230.605780439066018263.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MKWgtc028613


1) Always validate XFRM esn replay attribute, from Florian Westphal.

2) Fix RCU read lock imbalance in xfrm_get_tos(), from Xin Long.

3) Don't try to get firmware dump if not loaded in iwlwifi, from
   Shaul Triebitz.

4) Fix BPF helpers to deal with SCTP GSO SKBs properly, from Daniel
   Axtens.

5) Fix some interrupt handling issues in e1000e driver, from Benjamin
   Poitier.

6) Use strlcpy() in several ethtool get_strings methods, from Florian
   Fainelli.

7) Fix rhlist dup insertion, from Paul Blakey.

8) Fix SKB leak in netem packet scheduler, from Alexey Kodanev.

9) Fix driver unload crash when link is up in smsc911x, from Jeremy
   Linton.

10) Purge out invalid socket types in l2tp_tunnel_create(), from
    Eric Dumazet.

11) Need to purge the write queue when TCP connections are aborted,
    otherwise userspace using MSG_ZEROCOPY can't close the fd.
    From Soheil Hassas Yeganeh.

12) Fix double free in error path of team driver, from Arkadi
    Sharshevsky.

13) Filter fixes for hv_netvsc driver, from Stephen Hemminger.

14) Fix non-linear packet access in ipv6 ndisc code, from Lorenzo
    Bianconi.

15) Properly filter out unsupported feature flags in macvlan driver,
    from Shannon Nelson.

16) Don't request loading the diag module for a protocol if the
    protocol itself is not even registered.  From Xin Long.

17) If datagram connect fails in ipv6, make sure the socket state
    is consistent afterwards.  From Paolo Abeni.

18) Use after free in qed driver, from Dan Carpenter.

19) If received ipv4 PMTU is less than the min pmtu, lock the mtu
    in the entry.  From Sabrina Dubroca.

20) Fix sleep in atomic in tg3 driver, from Jonathan Toppins.

21) Fix vlan in vlan untagging in some situations, from Toshiaki
    Makita.

22) Fix double SKB free in genlmsg_mcast().  From Nicolas Dichtel.

23) Fix NULL derefs in error paths of tcf_*_init(), from Davide
    Caratti.

24) Unbalanced PM runtime calls in FEC driver, from Florian Fainelli.

25) Memory leak in gemini driver, from Igor Pylypiv.

26) IDR leaks in error paths of tcf_*_init() functions, from Davide
    Caratti.

27) Need to use GFP_ATOMIC in seg6_build_state(), from David Lebrun.

28) Missing dev_put() in error path of macsec_newlink(), from
    Dan Carpenter.

Please pull, thanks a lot!

The following changes since commit ce380619fab99036f5e745c7a865b21c59f005f6:

  Merge tag 'please-pull-ia64_misc' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2018-03-05 20:31:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 5dcd8400884cc4a043a6d4617e042489e5d566a9:

  macsec: missing dev_put() on error in macsec_newlink() (2018-03-22 14:30:36 -0400)

----------------------------------------------------------------
Alexander Potapenko (1):
      vhost_net: initialize rx_ring in vhost_net_open()

Alexey Kodanev (2):
      sch_netem: fix skb leak in netem_enqueue()
      dccp: check sk for closed state in dccp_sendmsg()

Andrei Otcheretianski (1):
      iwlwifi: mvm: Fix channel switch for count 0 and 1

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix binding documentation for MDIO busses

Andrew Zaborowski (1):
      mac80211_hwsim: Set wmediumd for new radios

Andri Yngvason (3):
      can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
      can: cc770: Fix queue stall & dropped RTR reply
      can: cc770: Fix use after free in cc770_tx_interrupt()

Arend Van Spriel (2):
      brcmfmac: add possibility to obtain firmware error
      brcmfmac: fix P2P_DEVICE ethernet address generation

Arkadi Sharshevsky (2):
      team: Fix double free in error path
      devlink: Remove redundant free on error path

Arvind Yadav (1):
      net/iucv: Free memory obtained by kzalloc

Ben Caradoc-Davies (1):
      mac80211: add ieee80211_hw flag for QoS NDP support

Benjamin Poirier (7):
      e1000e: Remove Other from EIAC
      Partial revert "e1000e: Avoid receiver overrun interrupt bursts"
      e1000e: Fix queue interrupt re-raising in Other interrupt
      e1000e: Avoid missed interrupts following ICR read
      e1000e: Fix check_for_link return value with autoneg off
      Revert "e1000e: Separate signaling for link check/link up"
      e1000e: Fix link check race condition

Bich HEMON (1):
      can: m_can: select pinctrl state in each suspend/resume function

Brad Mouring (1):
      net: phy: Tell caller result of phy_change()

Camelia Groza (3):
      dpaa_eth: remove duplicate initialization
      dpaa_eth: increment the RX dropped counter when needed
      dpaa_eth: remove duplicate increment of the tx_errors counter

Cathy Zhou (1):
      sunvnet: does not support GSO for sctp

Chenbo Feng (1):
      bpf: skip unnecessary capability check

Christophe JAILLET (1):
      net: ethernet: arc: Fix a potential memory leak if an optional regulator is deferred

Colin Ian King (2):
      bnx2x: fix spelling mistake: "registeration" -> "registration"
      qede: fix spelling mistake: "registeration" -> "registration"

Dan Carpenter (2):
      qed: Use after free in qed_rdma_free()
      macsec: missing dev_put() on error in macsec_newlink()

Daniel Axtens (3):
      bpf: fix bpf_skb_adjust_net/bpf_skb_proto_xlat to deal with gso sctp skbs
      docs: segmentation-offloads.txt: Correct TCP gso_types
      net: use skb_is_gso_sctp() instead of open-coding

Daniel Borkmann (2):
      bpf, x64: increase number of passes
      kbuild: disable clang's default use of -fmerge-all-constants

David Ahern (2):
      net: Only honor ifindex in IP_PKTINFO if non-0
      net/ipv6: Handle onlink flag with multipath routes

David Lebrun (2):
      ipv6: sr: fix scheduling in RCU when creating seg6 lwtunnel state
      ipv6: sr: fix NULL pointer dereference when setting encap source address

David S. Miller (32):
      Merge branch 'net-Use-strlcpy-for-ethtool-get_strings'
      Merge branch 'rhltable-dups'
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth
      Merge branch '1GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge git://git.kernel.org/.../bpf/bpf
      Merge tag 'wireless-drivers-for-davem-2018-03-08' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge branch 'hv_netvsc-fix-multicast-flags-and-sync'
      Merge branch 'vhost_net-ptr_ring-fixes'
      Merge branch 'mlxsw-ACL-and-mirroring-fixes'
      Merge branch 'erspan-fixes'
      Merge branch 'bnxt_en-Bug-fixes'
      Merge tag 'linux-can-fixes-for-4.16-20180312' of ssh://gitolite.kernel.org/.../mkl/linux-can
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'l2tp-fix-races-with-ipv4-mapped-ipv6-addresses'
      Merge branch '1GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge branch 'DPAA-Ethernet-fixes'
      Merge tag 'linux-can-fixes-for-4.16-20180314' of ssh://gitolite.kernel.org/.../mkl/linux-can
      Merge branch 'vlan-untag-and-insert-fixes'
      Merge branch 'qed-iWARP-related-fixes'
      Merge branch 'tcf_foo_init-NULL-deref'
      Merge branch 'phy-relax-error-checking'
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth
      Merge tag 'linux-can-fixes-for-4.16-20180319' of ssh://gitolite.kernel.org/.../mkl/linux-can
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'net-sched-action-idr-leak'
      Merge tag 'batadv-net-for-davem-20180319' of git://git.open-mesh.org/linux-merge
      Merge branch 'net-phy-Add-general-dummy-stubs-for-MMD-register-access'
      Merge branch 's390-qeth-fixes'
      Merge branch 'aquantia-fixes'
      Merge branch 'hv_netvsc-fix-races-during-shutdown-and-changes'
      Merge tag 'mac80211-for-davem-2018-03-21' of git://git.kernel.org/.../jberg/mac80211

Davide Caratti (12):
      net/sched: fix NULL dereference in the error path of tcf_vlan_init()
      net/sched: fix NULL dereference in the error path of tcf_csum_init()
      net/sched: fix NULL dereference in the error path of tunnel_key_init()
      net/sched: fix NULL dereference in the error path of tcf_sample_init()
      net/sched: fix NULL dereference on the error path of tcf_skbmod_init()
      net/sched: fix idr leak on the error path of tcf_bpf_init()
      net/sched: fix idr leak in the error path of tcf_simp_init()
      net/sched: fix idr leak in the error path of tcf_act_police_init()
      net/sched: fix idr leak in the error path of tcp_pedit_init()
      net/sched: fix idr leak in the error path of __tcf_ipt_init()
      net/sched: fix idr leak in the error path of tcf_vlan_init()
      net/sched: fix idr leak in the error path of tcf_skbmod_init()

Denis Kirjanov (1):
      fsl/fman: avoid sleeping in atomic context while adding an address

Eddie Wai (1):
      bnxt_en: Fix vnic accounting in the bnxt_check_rings() path.

Emmanuel Grumbach (1):
      iwlwifi: pcie: don't warn if we use all the transmit pointers

Eric Dumazet (5):
      net: usbnet: fix potential deadlock on 32bit hosts
      l2tp: do not accept arbitrary sockets
      ieee802154: 6lowpan: fix possible NULL deref in lowpan_device_event()
      net: use skb_to_full_sk() in skb_update_prio()
      net: sched: fix uses after free

Florian Fainelli (8):
      net: dsa: b53: Use strlcpy() for ethtool::get_strings
      net: phy: marvell: Use strlcpy() for ethtool::get_strings
      net: phy: micrel: Use strlcpy() for ethtool::get_strings
      net: phy: broadcom: Use strlcpy() for ethtool::get_strings
      net: dsa: Fix dsa_is_user_port() test inversion
      net: systemport: Rewrite __bcm_sysport_tx_reclaim()
      net: fec: Fix unbalanced PM runtime calls
      net: dsa: Fix functional dsa-loop dependency on FIXED_PHY

Florian Westphal (4):
      xfrm_user: uncoditionally validate esn replay attribute struct
      netfilter: ebtables: fix erroneous reject of last rule
      netfilter: x_tables: add and use xt_check_proc_name
      netfilter: bridge: ebt_among: add more missing match size checks

Ganesh Goudar (2):
      cxgb4: copy adap index to PF0-3 adapter instances
      cxgb4: do not set needs_free_netdev for mgmt dev's

Geert Uytterhoeven (1):
      dt-bindings: net: renesas-ravb: Make stream buffer optional

Greg Hackmann (1):
      net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()

Grygorii Strashko (2):
      sysfs: symlink: export sysfs_create_link_nowarn()
      net: phy: relax error checking when creating sysfs link netdev->phydev

Guillaume Nault (1):
      ppp: avoid loop in xmit recursion detection code

Haim Dreyfuss (1):
      iwlwifi: Cancel and set MARKER_CMD timer during suspend-resume

Hans de Goede (3):
      Bluetooth: btusb: Remove Yoga 920 from the btusb_needs_reset_resume_table
      Revert "Bluetooth: hci_bcm: Streamline runtime PM code"
      Bluetooth: hci_bcm: Set pulsed_host_wake flag in sleep parameters

Hemanth Puranik (1):
      net: qcom/emac: Use proper free methods during TX

Ido Schimmel (1):
      mlxsw: spectrum_buffers: Set a minimum quota for CPU port traffic

Igor Pylypiv (2):
      vmxnet3: remove unused flag "rxcsum" from struct vmxnet3_adapter
      net: gemini: fix memory leak

Igor Russkikh (7):
      net: aquantia: Fix hardware reset when SPI may rarely hangup
      net: aquantia: Fix a regression with reset on old firmware
      net: aquantia: Change inefficient wait loop on fw data reads
      net: aquantia: Add tx clean budget and valid budget handling logic
      net: aquantia: Allow live mac address changes
      net: aquantia: Implement pci shutdown callback
      net: aquantia: driver version bump

Ilan Peer (2):
      iwlwifi: mvm: Direct multicast frames to the correct station
      iwlwifi: mvm: Correctly set the tid for mcast queue

Jason Wang (2):
      vhost_net: keep private_data and rx_ring synced
      vhost_net: examine pointer types during un-producing

Jeremy Linton (1):
      net: smsc911x: Fix unload crash when link is up

Jiri Benc (1):
      tools: bpftool: fix compilation with older headers

Jiri Pirko (1):
      mlxsw: spectrum: Fix gact_ok offloading

Johannes Berg (1):
      ath9k_htc: use non-QoS NDP for AP probing

Jonathan Toppins (1):
      tg3: prevent scheduling while atomic splat

Julian Wiedmann (4):
      s390/qeth: free netdevice when removing a card
      s390/qeth: when thread completes, wake up all waiters
      s390/qeth: lock read device while queueing next buffer
      s390/qeth: on channel error, reject further cmd requests

Kai-Heng Feng (1):
      Bluetooth: btusb: Add Dell OptiPlex 3060 to btusb_needs_reset_resume_table

Kalle Valo (2):
      Merge tag 'iwlwifi-for-kalle-2018-02-16-2' of git://git.kernel.org/.../iwlwifi/iwlwifi-fixes
      Merge tag 'iwlwifi-for-kalle-2018-03-02' of git://git.kernel.org/.../iwlwifi/iwlwifi-fixes

Kevin Hao (3):
      net: phy: Add general dummy stubs for MMD register access
      net: phy: realtek: Use the dummy stubs for MMD register access for rtl8211b
      net: phy: micrel: Use the general dummy stubs for MMD register access

Kirill Tkhai (1):
      net: Fix hlist corruptions in inet_evict_bucket()

Kunihiko Hayashi (1):
      net: ethernet: ave: enable Rx drop interrupt

Larry Finger (1):
      rtlwifi: rtl8723be: Fix loss of signal

Linus Lüssing (1):
      batman-adv: Fix multicast packet loss with a single WANT_ALL_IPV4/6 flag

Lorenzo Bianconi (1):
      ipv6: fix access to non-linear packet in ndisc_fill_redirect_hdr_option()

Madalin Bucur (2):
      soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
      dpaa_eth: fix error in dpaa_remove()

Marek Vasut (2):
      can: ifi: Check core revision upon probe
      can: ifi: Repair the error handling

Masami Hiramatsu (1):
      error-injection: Fix to prohibit jump optimization

Matthias Brugger (1):
      net: hns: Fix ethtool private flags

Matthias Schiffer (2):
      batman-adv: update data pointers after skb_cow()
      batman-adv: fix header size check in batadv_dbg_arp()

Michael Chan (4):
      bnxt_en: Refactor the functions to reserve hardware rings.
      bnxt_en: Pass complete VLAN TCI to the stack.
      bnxt_en: Fix regressions when setting up MQPRIO TX rings.
      bnxt_en: Check valid VNIC ID in bnxt_hwrm_vnic_set_tpa().

Michal Kalderon (4):
      qed: Free RoCE ILT Memory on rmmod qedr
      qed: Fix MPA unalign flow in case header is split across two packets.
      qed: Fix non TCP packets should be dropped on iWARP ll2 connection
      qede: Fix qedr link update

Naftali Goldstein (1):
      iwlwifi: mvm: always init rs with 20mhz bandwidth rates

Nicolas Dichtel (1):
      netlink: avoid a double skb free in genlmsg_mcast()

Pablo Neira Ayuso (2):
      netfilter: nft_set_hash: skip fixed hash if timeout is specified
      netfilter: nf_tables: release flowtable hooks

Paolo Abeni (2):
      net: ipv6: keep sk status consistent after datagram connect failure
      l2tp: fix races with ipv4-mapped ipv6 addresses

Paul Blakey (2):
      rhashtable: Fix rhlist duplicates insertion
      test_rhashtable: add test case for rhltable with duplicate objects

Paul Moore (1):
      net: don't unnecessarily load kernel modules in dev_ioctl()

Petr Machata (1):
      mlxsw: spectrum: Prevent duplicate mirrors

Pierre-Yves Kerbrat (1):
      e1000e: allocate ring descriptors with dma_zalloc_coherent

Randy Dunlap (1):
      ethernet: natsemi: correct spelling

Roman Mashak (1):
      net sched actions: return explicit error when tunnel_key mode is not specified

Ronak Doshi (2):
      vmxnet3: avoid xmit reset due to a race in vmxnet3
      vmxnet3: use correct flag to indicate LRO feature

SZ Lin (林上智) (1):
      net: ethernet: ti: cpsw: add check for in-band mode setting with RGMII PHY interface

Sabrina Dubroca (1):
      ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route.min_pmtu

Sara Sharon (5):
      iwlwifi: mvm: fix security bug in PN checking
      iwlwifi: mvm: fix IBSS for devices that support station type API
      iwlwifi: mvm: fix TX of CCMP 256
      iwlwifi: mvm: fix assert 0x2B00 on older FWs
      iwlwifi: mvm: fix "failed to remove key" message

Shannon Nelson (1):
      macvlan: filter out unsupported feature flags

Shaul Triebitz (2):
      iwlwifi: align timestamp cancel with timestamp start
      iwlwifi: avoid collecting firmware dump if not loaded

Soheil Hassas Yeganeh (1):
      tcp: purge write queue upon aborting the connection

Sriharsha Basavapatna (1):
      bnxt_en: Remove unwanted ovs-offload messages in some conditions

Stefano Brivio (2):
      ipv6: Reflect MTU changes on PMTU of exceptions for MTU-less routes
      ipv6: old_dport should be a __be16 in __ip6_datagram_connect()

Steffen Klassert (4):
      xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems
      xfrm: Fix policy hold queue after flowcache removal.
      xfrm: Fix infinite loop in xfrm_get_dst_nexthop with transport mode.
      xfrm: Fix ESN sequence number handling for IPsec GSO packets.

Stephane Grosjean (2):
      can: peak/pcie_fd: fix echo_skb is occupied! bug
      can: peak/pcie_fd: remove useless code when interface starts

Stephen Hemminger (8):
      hv_netvsc: fix filter flags
      hv_netvsc: avoid repeated updates of packet filter
      hv_netvsc: fix locking for rx_mode
      hv_netvsc: fix locking during VF setup
      hv_netvsc: disable NAPI before channel close
      hv_netvsc: use RCU to fix concurrent rx and queue changes
      hv_netvsc: change GPAD teardown order on older versions
      hv_netvsc: common detach logic

Sven Eckelmann (2):
      batman-adv: Add missing include for EPOLL* constants
      batman-adv: Fix skbuff rcsum on packet reroute

Szymon Janc (1):
      Bluetooth: Fix missing encryption refresh on Security Request

Takashi Iwai (1):
      Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174

Thadeu Lima de Souza Cascardo (1):
      test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on other arches

Tom Herbert (1):
      kcm: lock lower socket in kcm_attach

Toshiaki Makita (2):
      net: Fix vlan untag for bridge and vlan_dev with reorder_hdr off
      vlan: Fix out of order vlan headers with reorder header off

Ulf Magnusson (1):
      iwlwifi: fix malformed CONFIG_IWLWIFI_PCIE_RTPM default

Ursula Braun (1):
      net/smc: simplify wait when closing listen socket

Venkat Duvvuru (2):
      bnxt_en: Return standard Linux error codes for hwrm flow cmds.
      bnxt_en: close & open NIC, only when the interface is in running state.

Vinicius Costa Gomes (1):
      skbuff: Fix not waking applications when errors are enqueued

William Tu (3):
      ip6gre: add erspan v2 to tunnel lookup
      ip6erspan: improve error handling for erspan version number.
      ip6erspan: make sure enough headroom at xmit.

Wolfram Sang (1):
      can: m_can: change comparison to bitshift when dealing with a mask

Xin Long (3):
      xfrm: reuse uncached_list to track xdsts
      xfrm: do not call rcu_read_unlock when afinfo is NULL in xfrm_get_tos
      sock_diag: request _diag module only when the family or proto has been registered

Yonghong Song (1):
      trace/bpf: remove helper bpf_perf_prog_read_value from tracepoint type programs

Yossi Kuperman (1):
      xfrm: Verify MAC header exists before overwriting eth_hdr(skb)->h_proto

zhangliping (1):
      openvswitch: meter: fix the incorrect calculation of max delta_t

 Documentation/devicetree/bindings/net/dsa/marvell.txt        |  48 ++++++-------
 Documentation/devicetree/bindings/net/renesas,ravb.txt       |   6 +-
 Documentation/networking/segmentation-offloads.txt           |  18 +++--
 Makefile                                                     |   9 +++
 arch/x86/net/bpf_jit_comp.c                                  |   3 +-
 drivers/bluetooth/btusb.c                                    |   8 +--
 drivers/bluetooth/hci_bcm.c                                  |  13 ++--
 drivers/net/can/cc770/cc770.c                                | 100 ++++++++++++++++-----------
 drivers/net/can/cc770/cc770.h                                |   2 +
 drivers/net/can/ifi_canfd/ifi_canfd.c                        |  75 +++++++++++++--------
 drivers/net/can/m_can/m_can.c                                |   7 +-
 drivers/net/can/peak_canfd/peak_canfd.c                      |  25 +++----
 drivers/net/can/peak_canfd/peak_pciefd_main.c                |   8 ++-
 drivers/net/dsa/Makefile                                     |   5 +-
 drivers/net/dsa/b53/b53_common.c                             |   4 +-
 drivers/net/ethernet/8390/Kconfig                            |   2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_cfg.h              |   2 +
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c              |  22 ++++++
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h              |   1 +
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c         |  15 +++++
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c             |   7 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h             |   2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c              |  11 ++-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c |  66 ++++++++++++------
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h |   1 +
 drivers/net/ethernet/aquantia/atlantic/ver.h                 |   2 +-
 drivers/net/ethernet/arc/emac_rockchip.c                     |   6 +-
 drivers/net/ethernet/broadcom/bcmsysport.c                   |  33 +++++----
 drivers/net/ethernet/broadcom/bcmsysport.h                   |   2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c             |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                    | 180 ++++++++++++++++++++++++++-----------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                    |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c                 |  33 ++++++---
 drivers/net/ethernet/broadcom/tg3.c                          |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c              |   3 +-
 drivers/net/ethernet/cortina/gemini.c                        |   1 +
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c               |   8 +--
 drivers/net/ethernet/freescale/fec_main.c                    |   2 +
 drivers/net/ethernet/freescale/fman/fman_dtsec.c             |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c           |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c            |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c            |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c             |   4 +-
 drivers/net/ethernet/intel/e1000e/defines.h                  |  21 +++++-
 drivers/net/ethernet/intel/e1000e/ich8lan.c                  |  42 ++++++------
 drivers/net/ethernet/intel/e1000e/mac.c                      |  25 +++----
 drivers/net/ethernet/intel/e1000e/netdev.c                   |  37 ++++------
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c  |  11 +++
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.h  |   1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c               |  28 ++++++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h               |   4 ++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c           |   5 ++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c       |  12 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c        |   2 +-
 drivers/net/ethernet/natsemi/Kconfig                         |   6 +-
 drivers/net/ethernet/natsemi/Makefile                        |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                    |   5 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c                  |  17 ++++-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c                   |   1 +
 drivers/net/ethernet/qlogic/qede/qede_main.c                 |   8 +--
 drivers/net/ethernet/qlogic/qede/qede_ptp.c                  |   2 +-
 drivers/net/ethernet/qualcomm/emac/emac-mac.c                |  23 ++++---
 drivers/net/ethernet/smsc/smsc911x.c                         |   4 +-
 drivers/net/ethernet/socionext/sni_ave.c                     |   2 +-
 drivers/net/ethernet/sun/sunvnet.c                           |   2 +-
 drivers/net/ethernet/ti/cpsw.c                               |   3 +-
 drivers/net/hyperv/hyperv_net.h                              |   2 +-
 drivers/net/hyperv/netvsc.c                                  |  52 +++++++--------
 drivers/net/hyperv/netvsc_drv.c                              | 293 ++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
 drivers/net/hyperv/rndis_filter.c                            |  68 +++++++++----------
 drivers/net/macsec.c                                         |   5 +-
 drivers/net/macvlan.c                                        |   2 +-
 drivers/net/phy/bcm-phy-lib.c                                |   4 +-
 drivers/net/phy/marvell.c                                    |   4 +-
 drivers/net/phy/micrel.c                                     |  27 ++------
 drivers/net/phy/phy.c                                        | 145 ++++++++++++++++++++--------------------
 drivers/net/phy/phy_device.c                                 |  32 +++++++--
 drivers/net/phy/realtek.c                                    |   2 +
 drivers/net/ppp/ppp_generic.c                                |  26 ++++----
 drivers/net/team/team.c                                      |   4 +-
 drivers/net/tun.c                                            |   3 +-
 drivers/net/usb/usbnet.c                                     |  10 +--
 drivers/net/vmxnet3/vmxnet3_drv.c                            |  16 +++--
 drivers/net/vmxnet3/vmxnet3_int.h                            |   7 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c                |   1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h      |   2 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c   |  10 +++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c      |   3 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c       |  24 +++----
 drivers/net/wireless/intel/iwlwifi/Kconfig                   |   1 -
 drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h       |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                  |  13 +++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h                  |   3 +
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.h              |  18 +++++
 drivers/net/wireless/intel/iwlwifi/fw/init.c                 |  12 +++-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h              |   7 ++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                  |   8 +++
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c             |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c            |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c            |  49 +++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                 |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                 |  10 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                  |  28 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                |  39 +++++------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                 |  33 ++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c          |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                  |  13 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c            |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c                 |   2 +-
 drivers/net/wireless/mac80211_hwsim.c                        |   1 +
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c          |   3 +-
 drivers/s390/net/qeth_core_main.c                            |  21 ++++--
 drivers/s390/net/qeth_l2_main.c                              |   2 +-
 drivers/s390/net/qeth_l3_main.c                              |   2 +-
 drivers/soc/fsl/qbman/qman.c                                 |  28 ++------
 drivers/vhost/net.c                                          |   8 ++-
 fs/sysfs/symlink.c                                           |   1 +
 include/linux/cgroup-defs.h                                  |   4 +-
 include/linux/if_tun.h                                       |   4 ++
 include/linux/if_vlan.h                                      |  66 +++++++++++++++---
 include/linux/net.h                                          |   1 +
 include/linux/netfilter/x_tables.h                           |   2 +
 include/linux/phy.h                                          |   5 +-
 include/linux/rhashtable.h                                   |   4 +-
 include/linux/skbuff.h                                       |  22 ++++++
 include/linux/u64_stats_sync.h                               |  22 ++++++
 include/net/ip.h                                             |  11 ++-
 include/net/ip6_route.h                                      |   3 +
 include/net/ip_fib.h                                         |   1 +
 include/net/mac80211.h                                       |   4 ++
 include/net/route.h                                          |   6 +-
 include/net/sch_generic.h                                    |  19 ++++++
 include/net/sock.h                                           |   1 +
 include/uapi/linux/if_ether.h                                |   1 +
 kernel/bpf/syscall.c                                         |   2 +-
 kernel/fail_function.c                                       |  10 +++
 kernel/trace/bpf_trace.c                                     |  68 +++++++++++--------
 lib/rhashtable.c                                             |   4 +-
 lib/test_bpf.c                                               |   2 +-
 lib/test_rhashtable.c                                        | 134 +++++++++++++++++++++++++++++++++++++
 net/8021q/vlan_core.c                                        |   4 +-
 net/batman-adv/distributed-arp-table.c                       |   2 +-
 net/batman-adv/icmp_socket.c                                 |   1 +
 net/batman-adv/log.c                                         |   1 +
 net/batman-adv/multicast.c                                   |   4 +-
 net/batman-adv/routing.c                                     |  25 ++++---
 net/bluetooth/smp.c                                          |   8 ++-
 net/bridge/netfilter/ebt_among.c                             |  34 ++++++++++
 net/bridge/netfilter/ebtables.c                              |   6 +-
 net/core/dev.c                                               |  22 ++++--
 net/core/dev_ioctl.c                                         |   7 +-
 net/core/devlink.c                                           |  16 ++---
 net/core/filter.c                                            |  60 ++++++++++++-----
 net/core/skbuff.c                                            |  11 +--
 net/core/sock.c                                              |  21 ++++++
 net/core/sock_diag.c                                         |  12 ++--
 net/dccp/proto.c                                             |   5 ++
 net/dsa/legacy.c                                             |   2 +-
 net/ieee802154/6lowpan/core.c                                |  12 ++--
 net/ipv4/inet_diag.c                                         |   3 +-
 net/ipv4/inet_fragment.c                                     |   3 +
 net/ipv4/ip_sockglue.c                                       |   6 +-
 net/ipv4/route.c                                             |  47 ++++++++-----
 net/ipv4/tcp.c                                               |   1 +
 net/ipv4/tcp_timer.c                                         |   1 +
 net/ipv4/xfrm4_mode_tunnel.c                                 |   3 +-
 net/ipv4/xfrm4_policy.c                                      |   5 +-
 net/ipv6/datagram.c                                          |  21 ++++--
 net/ipv6/ip6_gre.c                                           |   8 ++-
 net/ipv6/ndisc.c                                             |   3 +-
 net/ipv6/route.c                                             |  76 ++++++++++++---------
 net/ipv6/seg6_iptunnel.c                                     |   7 +-
 net/ipv6/xfrm6_mode_tunnel.c                                 |   3 +-
 net/ipv6/xfrm6_policy.c                                      |   5 ++
 net/iucv/af_iucv.c                                           |   4 +-
 net/kcm/kcmsock.c                                            |  33 ++++++---
 net/l2tp/l2tp_core.c                                         |  46 +++++++------
 net/l2tp/l2tp_core.h                                         |   3 -
 net/mac80211/debugfs.c                                       |   1 +
 net/mac80211/mlme.c                                          |   3 +-
 net/netfilter/nf_tables_api.c                                |   1 +
 net/netfilter/nft_set_hash.c                                 |   2 +-
 net/netfilter/x_tables.c                                     |  30 +++++++++
 net/netfilter/xt_hashlimit.c                                 |  16 +++--
 net/netfilter/xt_recent.c                                    |   6 +-
 net/netlink/genetlink.c                                      |   2 +-
 net/openvswitch/meter.c                                      |  12 +++-
 net/sched/act_bpf.c                                          |   2 +-
 net/sched/act_csum.c                                         |   5 +-
 net/sched/act_ipt.c                                          |   9 ++-
 net/sched/act_pedit.c                                        |   2 +-
 net/sched/act_police.c                                       |   2 +-
 net/sched/act_sample.c                                       |   3 +-
 net/sched/act_simple.c                                       |   2 +-
 net/sched/act_skbmod.c                                       |   5 +-
 net/sched/act_tunnel_key.c                                   |  10 +--
 net/sched/act_vlan.c                                         |   5 +-
 net/sched/sch_generic.c                                      |  22 +++---
 net/sched/sch_netem.c                                        |   2 +-
 net/sctp/input.c                                             |   8 +--
 net/sctp/inqueue.c                                           |   2 +-
 net/sctp/offload.c                                           |   2 +-
 net/smc/af_smc.c                                             |   4 --
 net/smc/smc_close.c                                          |  25 +------
 net/socket.c                                                 |   5 ++
 net/xfrm/xfrm_ipcomp.c                                       |   2 +-
 net/xfrm/xfrm_policy.c                                       |  13 ++--
 net/xfrm/xfrm_replay.c                                       |   2 +-
 net/xfrm/xfrm_state.c                                        |   5 ++
 net/xfrm/xfrm_user.c                                         |  21 +++---
 tools/bpf/bpftool/common.c                                   |   4 ++
 211 files changed, 2086 insertions(+), 1152 deletions(-)

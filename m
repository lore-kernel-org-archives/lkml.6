Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A654C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B32C2080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfBHKmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:42:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:58496 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHKmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:42:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CA527147CF567;
        Fri,  8 Feb 2019 02:42:11 -0800 (PST)
Date:   Fri, 08 Feb 2019 02:42:09 -0800 (PST)
Message-Id: <20190208.024209.1128027461809213325.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Feb 2019 02:42:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ To the actual mailing lists this time... ]

This pull request is dedicated to the upcoming snowpocalypse parts 2
and 3 in the Pacific Northwest:

1) Drop profiles are broken because some drivers use dev_kfree_skb*
   instead of dev_consume_skb*, from Yang Wei.

2) Fix IWLWIFI kconfig deps, from Luca Coelho.

3) Fix percpu maps updating in bpftool, from Paolo Abeni.

4) Missing station release in batman-adv, from Felix Fietkau.

5) Fix some networking compat ioctl bugs, from Johannes Berg.

6) ucc_geth must reset the BQL queue state when stopping the device,
   from Mathias Thore.

7) Several XDP bug fixes in virtio_net from Toshiaki Makita.

8) TSO packets must be sent always on queue 0 in stmmac, from
   Jose Abreu.

9) Fix socket refcounting bug in RDS, from Eric Dumazet.

10) Handle sparse cpu allocations in bpf selftests, from Martynas
    Pumputis.

11) Make sure mgmt frames have enough tailroom in mac80211, from Felix
    Feitkau.

12) Use safe list walking in sctp_sendmsg() asoc list traversal, from
    Greg Kroah-Hartman.

13) Make DCCP's ccid_hc_[rt]x_parse_options always check for NULL ccid,
    from Eric Dumazet.

14) Need to reload WoL password into bcmsysport device after deep sleeps,
    from Florian Fainelli.

15) Remove filter from mask before freeing in cls_flower, from Petr
    Machata.

16) Missing release and use after free in error paths of s390 qeth
    code, from Julian Wiedmann.

17) Fix lockdep false positive in dsa code, from Marc Zyngier.

18) Fix counting of ATU violations in mv88e6xxx, from Andrew Lunn.

19) Fix EQ firmware assert in qed driver, from Manish Chopra.

20) Don't default Caivum PTP to Y in kconfig, from Bjorn Helgaas.

Please pull, thanks a lot!

The following changes since commit 62967898789dc1f09a06e59fa85ae2c5ca4dc2da:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2019-01-29 17:11:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to 39841cc1cbb69344539c98a1fa9d858ed124c7ba:

  net: dsa: b53: Fix for failure when irq is not defined in dt (2019-02-07 18:18:37 -0800)

----------------------------------------------------------------
Alexei Starovoitov (4):
      Merge branch 'typedef-func_proto'
      bpf: run bpf programs with preemption disabled
      bpf: fix lockdep false positive in percpu_freelist
      bpf: fix potential deadlock in bpf_prog_register

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix counting of ATU violations

Arun Parameswaran (1):
      net: dsa: b53: Fix for failure when irq is not defined in dt

Bart Van Assche (1):
      lib/test_rhashtable: Make test_insert_dup() allocate its hash table dynamically

Bjorn Helgaas (1):
      net: Don't default Cavium PTP driver to 'y'

Brian Norris (1):
      ath10k: correct bus type for WCN3990

Colin Ian King (1):
      ieee802154: mcr20a: fix indentation, remove tabs

Dan Carpenter (2):
      skge: potential memory corruption in skge_get_regs()
      net: dsa: Fix NULL checking in dsa_slave_set_eee()

Daniel Borkmann (3):
      bpf, doc: add reviewers to maintainers entry
      ipvlan, l3mdev: fix broken l3s mode wrt local routes
      Merge branch 'bpf-lockdep-fixes'

David S. Miller (17):
      Merge branch 'net-various-compat-ioctl-fixes'
      Merge branch 'erspan-always-reports-output-key-to-userspace'
      Merge branch 'virtio_net-Fix-problems-around-XDP-tx-and-napi_tx'
      Merge branch 'stmmac-fixes'
      Merge branch 'ieee802154-for-davem-2019-01-31' of git://git.kernel.org/.../sschmidt/wpan
      Merge tag 'mac80211-for-davem-2019-02-01' of git://git.kernel.org/.../jberg/mac80211
      Merge tag 'batadv-net-for-davem-20190201' of git://git.open-mesh.org/linux-merge
      Merge branch 'smc-fixes'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'vsock-virtio-hot-unplug'
      Merge branch 'smc-fixes'
      Merge tag 'wireless-drivers-for-davem-2019-02-04' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge branch 's390-qeth-fixes'
      Merge git://git.kernel.org/.../pablo/nf
      Merge tag 'mlx5-fixes-2019-02-05' of git://git.kernel.org/.../saeed/linux
      Merge branch 'qed-Bug-fixes'
      Merge branch 'ipv6-fixes'

Eli Cooper (1):
      netfilter: ipv6: Don't preserve original oif for loopback address

Eric Dumazet (4):
      rds: fix refcount bug in rds_sock_addref
      dccp: fool proof ccid_hc_[rt]x_parse_options()
      mISDN: fix a race in dev_expire_timer()
      rxrpc: bad unlock balance in rxrpc_recvmsg

Felix Fietkau (2):
      batman-adv: release station info tidstats
      mac80211: ensure that mgmt tx skbs have tailroom for encryption

Florian Fainelli (1):
      net: systemport: Fix WoL with password after deep sleep

Florian Westphal (2):
      selftests: netfilter: add simple masq/redirect test cases
      netfilter: nft_compat: don't use refcount_inc on newly allocated entry

George Amanakis (1):
      tun: move the call to tun_set_real_num_queues

Govindarajulu Varadarajan (1):
      enic: fix checksum validation for IPv6

Greg Kroah-Hartman (1):
      sctp: walk the list of asoc safely

Guy Shattah (1):
      net/mlx5e: Use the inner headers to determine tc/pedit offload limitation on decap flows

Hangbin Liu (2):
      geneve: should not call rt6_lookup() when ipv6 was disabled
      sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()

Hans Wippel (1):
      net/smc: allow 16 byte pnetids in netlink policy

Jacob Wen (2):
      l2tp: fix reading optional fields of L2TPv3
      l2tp: copy 4 more bytes to linear part if necessary

Jakub Kicinski (1):
      tools: bpftool: fix crash with un-owned prog arrays

Jakub Sitnicki (1):
      sk_msg: Always cancel strp work before freeing the psock

Jiri Olsa (1):
      bpftool: Fix prog dump by tag

Johannes Berg (5):
      Revert "socket: fix struct ifreq size in compat ioctl"
      Revert "kill dev_ifsioc()"
      net: socket: fix SIOCGIFNAME in compat
      net: socket: make bond ioctls go through compat_ifreq_ioctl()
      cfg80211: call disconnect_wk when AP stops

Jose Abreu (3):
      net: stmmac: Fallback to Platform Data clock in Watchdog conversion
      net: stmmac: Send TSO packets always from Queue 0
      net: stmmac: Disable EEE mode earlier in XMIT callback

Julian Wiedmann (4):
      s390/qeth: release cmd buffer in error paths
      s390/qeth: fix use-after-free in error path
      s390/qeth: cancel close_dev work before removing a card
      s390/qeth: conclude all event processing before offlining a card

Karsten Graul (7):
      net/smc: prevent races between smc_lgr_terminate() and smc_conn_free()
      net/smc: don't wait for send buffer space when data was already sent
      net/smc: recvmsg and splice_read should return 0 after shutdown
      net/smc: do not wait under send_lock
      net/smc: call smc_cdc_msg_send() under send_lock
      net/smc: use device link provided in qp_context
      net/smc: fix use of variable in cleared area

Lorenzo Bianconi (3):
      net: ip_gre: always reports o_key to userspace
      net: ip6_gre: always reports o_key to userspace
      mt76x0: eeprom: fix chan_vs_power map in mt76x0_get_power_info

Luca Coelho (1):
      iwlwifi: make IWLWIFI depend on CFG80211

Manish Chopra (2):
      qed: Fix EQ full firmware assert.
      qed*: Advance drivers version to 8.37.0.20

Marc Zyngier (1):
      net: dsa: Fix lockdep false positive splat

Martin KaFai Lau (1):
      bpf: Fix syscall's stackmap lookup potential deadlock

Martynas Pumputis (2):
      bpf, selftests: fix handling of sparse CPU allocations
      netfilter: nf_nat: skip nat clash resolution for same-origin entries

Mathias Thore (1):
      ucc_geth: Reset BQL queue when stopping device

Michael Chan (1):
      bnxt_en: Disable interrupts when allocating CP rings or NQs.

Naresh Kamboju (1):
      selftests: netfilter: fix config fragment CONFIG_NF_TABLES_INET

Or Gerlitz (1):
      net/mlx5e: Properly set steering match levels for offloaded TC decap rules

Pablo Neira Ayuso (1):
      netfilter: nf_tables: unbind set in rule from commit path

Paolo Abeni (1):
      bpftool: fix percpu maps updating

Petr Machata (1):
      net: cls_flower: Remove filter from mask before freeing it

Raed Salem (1):
      net/mlx5e: FPGA, fix Innova IPsec TX offload data path performance

Rahul Verma (1):
      qed: Change verbosity for coalescing message.

Rundong Ge (1):
      net: dsa: slave: Don't propagate flag changes on down slave interfaces

Russell King (2):
      Revert "net: phy: marvell: avoid pause mode on SGMII-to-Copper for 88e151x"
      MAINTAINERS: add maintainer for SFF/SFP/SFP+ support

Sebastian Andrzej Siewior (1):
      net: dp83640: expire old TX-skb

Siva Rebbagondla (1):
      MAINTAINERS: add entry for redpine wireless driver

Stefano Garzarella (2):
      vsock/virtio: fix kernel panic after device hot-unplug
      vsock/virtio: reset connected sockets on device removal

Sudarsana Reddy Kalluru (3):
      qed: Assign UFP TC value to vlan priority in UFP mode.
      qed: Consider TX tcs while deriving the max num_queues for PF.
      qede: Fix system crash on configuring channels.

Sven Eckelmann (2):
      batman-adv: Avoid WARN on net_device without parent in netns
      batman-adv: Force mac header to start of data on xmit

Tonghao Zhang (2):
      net/mlx5e: Update hw flows when encap source mac changed
      net/mlx5e: Don't overwrite pedit action when multiple pedit used

Toshiaki Makita (8):
      virtio_net: Don't enable NAPI when interface is down
      virtio_net: Don't call free_old_xmit_skbs for xdp_frames
      virtio_net: Fix not restoring real_num_rx_queues
      virtio_net: Fix out of bounds access of sq
      virtio_net: Don't process redirected XDP frames when XDP is disabled
      virtio_net: Use xdp_return_frame to free xdp_frames on destroying vqs
      virtio_net: Differentiate sk_buff and xdp_frame on freeing
      virtio_net: Account for tx bytes and packets on sending xdp_frames

Ulf Hansson (1):
      wlcore: sdio: Fixup power on/off sequence

Ursula Braun (5):
      net/smc: fix another sizeof to int comparison
      net/smc: preallocated memory for rdma work requests
      net/smc: fix sender_free computation
      net/smc: delete rkey first before switching to unused
      net/smc: correct state change for peer closing

Xin Long (1):
      sctp: check and update stream->out_curr when allocating stream_out

Yafang Shao (1):
      bpf: sock recvbuff must be limited by rmem_max in bpf_setsockopt()

Yang Wei (10):
      net: defxx: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: tulip: de2104x: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: dscc4: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: smsc: epic100: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: fec_mpc52xx: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: fsl_ucc_hdlc: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: sun: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: tehuti: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: via-velocity: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: broadcom: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles

Yohei Kanemaru (1):
      ipv6: sr: clear IP6CB(skb) on SRH ip4ip6 encapsulation

Yonghong Song (2):
      bpf: btf: allow typedef func_proto
      tools/bpf: fix test_btf for typedef func_proto case

 MAINTAINERS                                                |  21 +++
 drivers/isdn/mISDN/timerdev.c                              |   2 +-
 drivers/net/dsa/b53/b53_srab.c                             |   3 -
 drivers/net/dsa/mv88e6xxx/global1_atu.c                    |  21 +--
 drivers/net/ethernet/broadcom/bcmsysport.c                 |  25 ++-
 drivers/net/ethernet/broadcom/bcmsysport.h                 |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                  |   8 +-
 drivers/net/ethernet/broadcom/sb1250-mac.c                 |   2 +-
 drivers/net/ethernet/cavium/Kconfig                        |   1 -
 drivers/net/ethernet/cisco/enic/enic_main.c                |   3 +-
 drivers/net/ethernet/dec/tulip/de2104x.c                   |   2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c               |   2 +-
 drivers/net/ethernet/freescale/ucc_geth.c                  |   2 +
 drivers/net/ethernet/marvell/skge.c                        |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c        |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.h        |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c           |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.h           |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c            |  52 ++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c            |   6 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h          |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |  17 ++-
 drivers/net/ethernet/qlogic/qed/qed.h                      |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c                   |   8 +-
 drivers/net/ethernet/qlogic/qed/qed_sp.h                   |   1 +
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c          |   3 +
 drivers/net/ethernet/qlogic/qed/qed_spq.c                  |  15 +-
 drivers/net/ethernet/qlogic/qede/qede.h                    |   5 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c                 |  13 ++
 drivers/net/ethernet/qlogic/qede/qede_main.c               |   3 +
 drivers/net/ethernet/smsc/epic100.c                        |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c       |  14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |  17 ++-
 drivers/net/ethernet/sun/cassini.c                         |   2 +-
 drivers/net/ethernet/sun/sunbmac.c                         |   2 +-
 drivers/net/ethernet/sun/sunhme.c                          |   2 +-
 drivers/net/ethernet/tehuti/tehuti.c                       |   2 +-
 drivers/net/ethernet/via/via-velocity.c                    |   2 +-
 drivers/net/fddi/defxx.c                                   |   2 +-
 drivers/net/geneve.c                                       |  10 +-
 drivers/net/ieee802154/mcr20a.c                            |   6 +-
 drivers/net/ipvlan/ipvlan_main.c                           |   6 +-
 drivers/net/phy/dp83640.c                                  |  13 +-
 drivers/net/phy/marvell.c                                  |  16 --
 drivers/net/tun.c                                          |   3 +-
 drivers/net/virtio_net.c                                   | 171 +++++++++++++++------
 drivers/net/wan/dscc4.c                                    |   2 +-
 drivers/net/wan/fsl_ucc_hdlc.c                             |   2 +-
 drivers/net/wireless/ath/ath10k/core.c                     |   2 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig                 |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c         |  40 +++--
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.h         |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c            |  10 +-
 drivers/net/wireless/ti/wlcore/sdio.c                      |  15 +-
 drivers/s390/net/qeth_core.h                               |   3 +-
 drivers/s390/net/qeth_core_main.c                          |  31 ++--
 drivers/s390/net/qeth_l2_main.c                            |   8 +-
 drivers/s390/net/qeth_l3_main.c                            |   3 +
 include/linux/filter.h                                     |  21 ++-
 include/linux/netdevice.h                                  |   8 +
 include/linux/stmmac.h                                     |   1 +
 include/net/l3mdev.h                                       |   3 +-
 include/net/netfilter/nf_tables.h                          |  17 ++-
 kernel/bpf/btf.c                                           |   3 +-
 kernel/bpf/cgroup.c                                        |   2 +-
 kernel/bpf/hashtab.c                                       |   4 +-
 kernel/bpf/percpu_freelist.c                               |  41 +++--
 kernel/bpf/percpu_freelist.h                               |   4 +
 kernel/bpf/syscall.c                                       |  12 +-
 kernel/trace/bpf_trace.c                                   |  14 +-
 lib/test_rhashtable.c                                      |  23 ++-
 net/batman-adv/bat_v_elp.c                                 |   3 +
 net/batman-adv/hard-interface.c                            |   5 +-
 net/batman-adv/soft-interface.c                            |   2 +
 net/core/filter.c                                          |   2 +
 net/core/skmsg.c                                           |   3 +-
 net/dccp/ccid.h                                            |   4 +-
 net/dsa/master.c                                           |   4 +
 net/dsa/slave.c                                            |  17 ++-
 net/ipv4/ip_gre.c                                          |   7 +-
 net/ipv6/ip6_gre.c                                         |   7 +-
 net/ipv6/netfilter.c                                       |   4 +-
 net/ipv6/seg6_iptunnel.c                                   |   2 +
 net/ipv6/sit.c                                             |   3 +-
 net/l2tp/l2tp_core.c                                       |   9 +-
 net/l2tp/l2tp_core.h                                       |  20 +++
 net/l2tp/l2tp_ip.c                                         |   3 +
 net/l2tp/l2tp_ip6.c                                        |   3 +
 net/mac80211/tx.c                                          |  12 +-
 net/netfilter/nf_conntrack_core.c                          |  16 ++
 net/netfilter/nf_tables_api.c                              |  85 +++++------
 net/netfilter/nft_compat.c                                 |  62 +++-----
 net/netfilter/nft_dynset.c                                 |  18 +--
 net/netfilter/nft_immediate.c                              |   6 +-
 net/netfilter/nft_lookup.c                                 |  18 +--
 net/netfilter/nft_objref.c                                 |  18 +--
 net/rds/bind.c                                             |   6 +-
 net/rxrpc/recvmsg.c                                        |   3 +-
 net/sched/cls_flower.c                                     |   6 +-
 net/sctp/socket.c                                          |   4 +-
 net/sctp/stream.c                                          |  20 +++
 net/smc/af_smc.c                                           |  11 +-
 net/smc/smc_cdc.c                                          |  21 ++-
 net/smc/smc_cdc.h                                          |  34 ++++-
 net/smc/smc_clc.c                                          |   2 +-
 net/smc/smc_close.c                                        |   9 +-
 net/smc/smc_core.c                                         |   6 +-
 net/smc/smc_core.h                                         |  20 +++
 net/smc/smc_ib.c                                           |   6 +-
 net/smc/smc_llc.c                                          |   3 +-
 net/smc/smc_pnet.c                                         |   2 +-
 net/smc/smc_tx.c                                           |  64 ++++----
 net/smc/smc_wr.c                                           |  46 +++++-
 net/smc/smc_wr.h                                           |   1 +
 net/socket.c                                               |  82 +++++++---
 net/vmw_vsock/virtio_transport.c                           |  29 +++-
 net/wireless/ap.c                                          |   2 +
 net/wireless/core.h                                        |   2 +
 net/wireless/sme.c                                         |   2 +-
 tools/bpf/bpftool/common.c                                 |   6 +-
 tools/bpf/bpftool/map.c                                    |  33 ++--
 tools/bpf/bpftool/prog.c                                   |   5 +-
 tools/testing/selftests/bpf/bpf_util.h                     |  30 ++--
 tools/testing/selftests/bpf/test_btf.c                     |   9 +-
 tools/testing/selftests/netfilter/Makefile                 |   2 +-
 tools/testing/selftests/netfilter/config                   |   2 +-
 tools/testing/selftests/netfilter/nft_nat.sh               | 762 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 127 files changed, 1802 insertions(+), 544 deletions(-)
 create mode 100755 tools/testing/selftests/netfilter/nft_nat.sh

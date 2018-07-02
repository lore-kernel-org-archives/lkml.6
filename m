Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BE4C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE193251FE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE193251FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeGBND5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:03:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49952 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeGBNDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:03:51 -0400
Received: from localhost (unknown [59.29.86.96])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9C0B813EABC13;
        Mon,  2 Jul 2018 06:03:49 -0700 (PDT)
Date:   Mon, 02 Jul 2018 22:03:48 +0900 (KST)
Message-Id: <20180702.220348.527254946062449999.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 02 Jul 2018 06:03:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Verify netlink attributes properly in nf_queue, from Eric Dumazet.

2) Need to bump memory lock rlimit for test_sockmap bpf test, from
   Yonghong Song.

3) Fix VLAN handling in lan78xx driver, from Dave Stevenson.

4) Fix uninitialized read in nf_log, from Jann Horn.

5) Fix raw command length parsing in mlx5, from Alex Vesker.

6) Cleanup loopback RDS connections upon netns deletion, from Sowmini
   Varadhan.

7) Fix regressions in FIB rule matching during create, from Jason
   A. Donenfeld and Roopa Prabhu.

8) Fix mpls ether type detection in nfp, from Pieter Jansen van
   Vuuren.

9) More bpfilter build fixes/adjustments from Masahiro Yamada.

10) Fix XDP_{TX,REDIRECT} flushing in various drivers, from Jesper
    Dangaard Brouer.

11) fib_tests.sh file permissions were broken, from Shuah Khan.

12) Make sure BH/preemption is disabled in data path of mac80211,
    from Denis Kenzior.

13) Don't ignore nla_parse_nested() return values in nl80211,
    from Johannes berg.

14) Properly account sock objects ot kmemcg, from Shakeel Butt.

15) Adjustments to setting bpf program permissions to read-only,
    from Daniel Borkmann.

16) TCP Fast Open key endianness was broken, it always took on
    the host endiannness.  Whoops.  Explicitly make it little
    endian.  From Yuching Cheng.

17) Fix prefix route setting for link local addresses in ipv6,
    from David Ahern.

18) Potential Spectre v1 in zatm driver, from Gustavo A. R. Silva.

19) Various bpf sockmap fixes, from John Fastabend.

20) Use after free for GRO with ESP, from Sabrina Dubroca.

21) Passing bogus flags to crypto_alloc_shash() in ipv6 SR code,
    from Eric Biggers.

Please pull, thanks a lot!

The following changes since commit 6f0d349d922ba44e4348a17a78ea51b7135965b1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-06-25 15:58:17 +0800)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to e48e097996439cd73f36c89b98ba4175d84c9be6:

  Merge branch 'qed-fixes' (2018-07-02 20:41:31 +0900)

----------------------------------------------------------------
Alex Vesker (2):
      net/mlx5: Fix incorrect raw command length parsing
      net/mlx5: Fix command interface race in polling mode

Alexandre Belloni (1):
      net: macb: initialize bp->queues[0].bp for at91rm9200

Alexei Starovoitov (1):
      Merge branch 'bpf-fixes'

Anders Roxell (1):
      selftests: bpf: add missing NET_SCHED to config

Bert Kenward (1):
      sfc: correctly initialise filter rwsem for farch

Bob Copeland (1):
      nl80211: relax ht operation checks for mesh

Chengguang Xu (1):
      nfp: cast sizeof() to int when comparing with error code

Cong Wang (1):
      net: use dev_change_tx_queue_len() for SIOCSIFTXQLEN

Dan Carpenter (2):
      atm: iphase: fix a 64 bit bug
      cnic: tidy up a size calculation

Dan Murphy (1):
      net: phy: DP83TC811: Fix disabling interrupts

Daniel Borkmann (5):
      Merge branch 'bpf-bpftool-fixes'
      bpf, arm32: fix to use bpf_jit_binary_lock_ro api
      bpf, s390: fix potential memleak when later bpf_jit_prog fails
      bpf: undo prog rejection on read-only lock failure
      Merge branch 'bpf-sockmap-fixes'

Dave Stevenson (4):
      net: lan78xx: Allow for VLAN headers in timeout calcs
      net: lan78xx: Add support for VLAN filtering.
      net: lan78xx: Add support for VLAN tag stripping.
      net: lan78xx: Use s/w csum check on VLANs without tag stripping

David Ahern (2):
      bpf: Change bpf_fib_lookup to return lookup status
      net/ipv6: Fix updates to prefix route

David S. Miller (10):
      Merge branch 'lan78xx-minor-fixes'
      Merge branch 'nfp-MPLS-and-shared-blocks-TC-offload-fixes'
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'xdp-flush'
      Merge tag 'mlx5-fixes-2018-06-26' of git://git.kernel.org/.../saeed/linux
      Merge tag 'mac80211-for-davem-2018-06-29' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'DPAA-fixes'
      Merge branch 's390-qeth-fixes'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'qed-fixes'

Denis Kenzior (1):
      mac80211: disable BHs/preemption in ieee80211_tx_control_port()

Doron Roberts-Kedes (1):
      strparser: Remove early eaten to fix full tcp receive buffer stall

Eli Cohen (2):
      net/mlx5: E-Switch, Disallow vlan/spoofcheck setup if not being esw manager
      net/mlx5: Fix required capability for manipulating MPFS

Eric Biggers (1):
      ipv6: sr: fix passing wrong flags to crypto_alloc_shash()

Eric Dumazet (3):
      netfilter: nf_queue: augment nfqa_cfg_policy
      netfilter: ipv6: nf_defrag: reduce struct net memory waste
      tcp: add one more quick ack after after ECN events

Florian Westphal (1):
      netfilter: nf_conncount: fix garbage collection confirm race

Gao Feng (1):
      netfilter: nf_ct_helper: Fix possible panic after nf_conntrack_helper_unregister

Gustavo A. R. Silva (1):
      atm: zatm: Fix potential Spectre v1

Hangbin Liu (1):
      ipvlan: call dev_change_flags when ipvlan mode is reset

Ilpo Järvinen (1):
      tcp: prevent bogus FRTO undos with non-SACK flows

Jakub Kicinski (3):
      tools: bpftool: remove duplicated error message on prog load
      tools: bpftool: remember to close the libbpf object after prog load
      nfp: bpf: don't stop offload if replace failed

Jann Horn (2):
      netfilter: nf_log: fix uninit read in nf_log_proc_dostring
      netfilter: nf_log: don't hold nf_log_mutex during user access

Jason A. Donenfeld (1):
      fib_rules: match rules based on suppress_* properties too

Jeffrin Jose T (3):
      selftests: bpf: notification about privilege required to run test_kmod.sh testing script
      selftests: bpf: notification about privilege required to run test_lirc_mode2.sh testing script
      selftests: bpf: notification about privilege required to run test_lwt_seg6local.sh testing script

Jesper Dangaard Brouer (3):
      ixgbe: split XDP_TX tail and XDP_REDIRECT map flushing
      i40e: split XDP_TX tail and XDP_REDIRECT map flushing
      virtio_net: split XDP_TX kick and XDP_REDIRECT map flushing

Jiri Slaby (1):
      r8152: napi hangup fix after disconnect

Johannes Berg (1):
      nl80211: check nla_parse_nested() return values

John Fastabend (4):
      bpf: sockmap, fix crash when ipv6 sock is added
      bpf: sockmap, fix smap_list_map_remove when psock is in many maps
      bpf: sockhash fix omitted bucket lock in sock_close
      bpf: sockhash, add release routine

John Hurley (1):
      nfp: reject binding to shared blocks

Jose Abreu (1):
      net: stmmac: Set DMA buffer size in HW

Julian Wiedmann (4):
      Revert "s390/qeth: use Read device to query hypervisor for MAC"
      s390/qeth: fix race when setting MAC address
      s390/qeth: don't clobber buffer on async TX completion
      s390/qeth: consistently re-enable device features

Kleber Sacilotto de Souza (1):
      test_bpf: flag tests that cannot be jited on s390

Madalin Bucur (2):
      fsl/fman: fix parser reporting bad checksum on short frames
      dpaa_eth: DPAA SGT needs to be 256B

Masahiro Yamada (2):
      bpfilter: check compiler capability in Kconfig
      bpfilter: include bpfilter_umh in assembly instead of using objcopy

Michal Hocko (1):
      net: cleanup gfp mask in alloc_skb_with_frags

Or Gerlitz (4):
      net/mlx5e: Don't attempt to dereference the ppriv struct if not being eswitch manager
      net/mlx5: E-Switch, Avoid setup attempt if not being e-switch manager
      net/mlx5e: Avoid dealing with vport representors if not being e-switch manager
      IB/mlx5: Avoid dealing with vport representors if not being e-switch manager

Pieter Jansen van Vuuren (1):
      nfp: flower: fix mpls ether type detection

Roopa Prabhu (1):
      net: fib_rules: bring back rule_exists to match rule during add

Sabrina Dubroca (2):
      alx: take rtnl before calling __alx_open from resume
      net: fix use-after-free in GRO with ESP

Sean Young (1):
      bpf: fix attach type BPF_LIRC_MODE2 dependency wrt CONFIG_CGROUP_BPF

Shakeel Butt (1):
      net, mm: account sock objects to kmemcg

Shay Agroskin (1):
      net/mlx5: Fix wrong size allocation for QoS ETC TC regitster

Shuah Khan (1):
      selftests/net: Fix permissions for fib_tests.sh

Sowmini Varadhan (1):
      rds: clean up loopback rds_connections on netns deletion

Stephen Hemminger (1):
      hv_netvsc: split sub-channel setup into async and sync

Sudarsana Reddy Kalluru (5):
      bnx2x: Fix receiving tx-timeout in error or recovery state.
      qed: Limit msix vectors in kdump kernel to the minimum required count.
      qed: Fix setting of incorrect eswitch mode.
      qed: Fix use of incorrect size in memcpy call.
      qede: Adverstise software timestamp caps when PHC is not available.

Ursula Braun (1):
      net/smc: rebuild nonblocking connect

Vasily Gorbik (1):
      s390/qeth: avoid using is_multicast_ether_addr_64bits on (u8 *)[6]

Wei Yongjun (1):
      hinic: reset irq affinity before freeing irq

Yonghong Song (1):
      tools/bpf: fix test_sockmap failure

Yuchung Cheng (1):
      tcp: fix Fast Open key endianness

 Makefile                                                   |   5 --
 arch/arm/net/bpf_jit_32.c                                  |   2 +-
 arch/s390/net/bpf_jit_comp.c                               |   1 +
 drivers/atm/iphase.c                                       |   2 +-
 drivers/atm/zatm.c                                         |   2 +
 drivers/infiniband/hw/mlx5/main.c                          |   2 +-
 drivers/media/rc/bpf-lirc.c                                |  14 +----
 drivers/net/ethernet/atheros/alx/main.c                    |   8 ++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h                |   1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c            |   6 +++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c           |   6 +++
 drivers/net/ethernet/broadcom/cnic.c                       |   2 +-
 drivers/net/ethernet/cadence/macb_main.c                   |   2 +
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c             |  15 +++---
 drivers/net/ethernet/freescale/fman/fman_port.c            |   8 +++
 drivers/net/ethernet/huawei/hinic/hinic_rx.c               |   1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                |  24 +++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c              |  24 +++++----
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c              |   8 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          |  12 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c           |   8 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          |  12 ++---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c          |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c               |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c         |   9 ++--
 drivers/net/ethernet/mellanox/mlx5/core/port.c             |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c            |   7 ++-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c            |   2 -
 drivers/net/ethernet/netronome/nfp/bpf/main.c              |   9 ++--
 drivers/net/ethernet/netronome/nfp/flower/match.c          |  14 +++++
 drivers/net/ethernet/netronome/nfp/flower/offload.c        |  11 ++++
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.c      |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c                 |   8 +--
 drivers/net/ethernet/qlogic/qed/qed_dev.c                  |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c                 |   8 +++
 drivers/net/ethernet/qlogic/qed/qed_sriov.c                |  19 ++++++-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c                |  10 +++-
 drivers/net/ethernet/sfc/farch.c                           |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c           |  12 +++++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h           |   2 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h                 |   3 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |   2 +
 drivers/net/geneve.c                                       |   2 +-
 drivers/net/hyperv/hyperv_net.h                            |   2 +-
 drivers/net/hyperv/netvsc.c                                |  37 ++++++++++++-
 drivers/net/hyperv/netvsc_drv.c                            |  17 +++++-
 drivers/net/hyperv/rndis_filter.c                          |  61 +++++----------------
 drivers/net/ipvlan/ipvlan_main.c                           |  36 ++++++++++---
 drivers/net/phy/dp83tc811.c                                |   2 +-
 drivers/net/usb/lan78xx.c                                  |  37 +++++++++++--
 drivers/net/usb/r8152.c                                    |   3 +-
 drivers/net/virtio_net.c                                   |  30 +++++++----
 drivers/net/vxlan.c                                        |   4 +-
 drivers/s390/net/qeth_core.h                               |  13 ++++-
 drivers/s390/net/qeth_core_main.c                          |  47 +++++++++-------
 drivers/s390/net/qeth_l2_main.c                            |  24 +++++----
 drivers/s390/net/qeth_l3_main.c                            |   3 +-
 include/linux/bpf-cgroup.h                                 |  26 +++++++++
 include/linux/bpf.h                                        |   8 +++
 include/linux/bpf_lirc.h                                   |   5 +-
 include/linux/filter.h                                     |  56 +++----------------
 include/linux/mlx5/eswitch.h                               |   2 +
 include/linux/mlx5/mlx5_ifc.h                              |   2 +-
 include/linux/netdevice.h                                  |  20 +++++++
 include/net/net_namespace.h                                |   1 +
 include/net/netns/ipv6.h                                   |   1 -
 include/net/pkt_cls.h                                      |   5 ++
 include/uapi/linux/bpf.h                                   |  28 ++++++++--
 kernel/bpf/cgroup.c                                        |  54 +++++++++++++++++++
 kernel/bpf/core.c                                          |  30 +----------
 kernel/bpf/sockmap.c                                       | 254 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 kernel/bpf/syscall.c                                       |  99 ++++++++--------------------------
 lib/test_bpf.c                                             |  20 +++++++
 net/8021q/vlan.c                                           |   2 +-
 net/Makefile                                               |   4 --
 net/bpfilter/Kconfig                                       |   2 +-
 net/bpfilter/Makefile                                      |  17 +-----
 net/bpfilter/bpfilter_kern.c                               |  11 ++--
 net/bpfilter/bpfilter_umh_blob.S                           |   7 +++
 net/core/dev_ioctl.c                                       |  11 +---
 net/core/fib_rules.c                                       |  80 +++++++++++++++++++++++++++-
 net/core/filter.c                                          |  86 +++++++++++++++++++-----------
 net/core/skbuff.c                                          |   3 +-
 net/core/sock.c                                            |   7 ++-
 net/ipv4/fou.c                                             |   4 +-
 net/ipv4/gre_offload.c                                     |   2 +-
 net/ipv4/sysctl_net_ipv4.c                                 |  18 +++++--
 net/ipv4/tcp_input.c                                       |  13 ++++-
 net/ipv4/udp_offload.c                                     |   2 +-
 net/ipv6/addrconf.c                                        |   9 ++--
 net/ipv6/netfilter/nf_conntrack_reasm.c                    |   6 +--
 net/ipv6/seg6_hmac.c                                       |   2 +-
 net/mac80211/tx.c                                          |   2 +
 net/netfilter/nf_conncount.c                               |  52 ++++++++++++++++--
 net/netfilter/nf_conntrack_helper.c                        |   5 ++
 net/netfilter/nf_log.c                                     |  13 +++--
 net/netfilter/nfnetlink_queue.c                            |   3 ++
 net/rds/connection.c                                       |  11 +++-
 net/rds/loop.c                                             |  56 +++++++++++++++++++
 net/rds/loop.h                                             |   2 +
 net/smc/af_smc.c                                           |  91 +++++++++++++++++++++----------
 net/smc/smc.h                                              |   8 +++
 net/strparser/strparser.c                                  |  17 +-----
 net/wireless/nl80211.c                                     |  35 +++++-------
 samples/bpf/xdp_fwd_kern.c                                 |   8 +--
 scripts/cc-can-link.sh                                     |   2 +-
 tools/bpf/bpftool/prog.c                                   |  12 +++--
 tools/testing/selftests/bpf/config                         |   1 +
 tools/testing/selftests/bpf/test_kmod.sh                   |   9 ++++
 tools/testing/selftests/bpf/test_lirc_mode2.sh             |   9 ++++
 tools/testing/selftests/bpf/test_lwt_seg6local.sh          |   9 ++++
 tools/testing/selftests/bpf/test_sockmap.c                 |   6 ---
 tools/testing/selftests/net/fib_tests.sh                   |   0
 114 files changed, 1249 insertions(+), 619 deletions(-)
 create mode 100644 net/bpfilter/bpfilter_umh_blob.S
 mode change 100644 => 100755 tools/testing/selftests/net/fib_tests.sh

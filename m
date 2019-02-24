Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2851AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C252085B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfBXC5N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 21:57:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45206 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBXC5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 21:57:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8DF8114BF990F;
        Sat, 23 Feb 2019 18:57:11 -0800 (PST)
Date:   Sat, 23 Feb 2019 18:57:10 -0800 (PST)
Message-Id: <20190223.185710.866316846403242352.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 Feb 2019 18:57:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hopefully the last pull request for this release.  Fingers crossed:

1) Only refcount ESP stats on full sockets, from Martin Willi.

2) Missing barriers in AF_UNIX, from Al Viro.

3) RCU protection fixes in ipv6 route code, from Paolo Abeni.

4) Avoid false positives in untrusted GSO validation, from Willem de
   Bruijn.

5) Forwarded mesh packets in mac80211 need more tailroom allocated,
   from Felix Fietkau.

6) Use operstate consistently for linkup in team driver, from George
   Wilkie.

7) Tunderx bug fixes from Vadim Lomovtsev.  Mostly races between VF and
   PF code paths.

8) Purge ipv6 exceptions during netdevice removal, from Paolo Abeni.

9) nfp eBPF code gen fixes from Jiong Wang.

10) bnxt_en firmware timeout fix from Michael Chan.

11) Use after free in udp/udpv6 error handlers, from Paolo Abeni.

12) Fix a race in x25_bind triggerable by syzbot, from Eric Dumazet.

Please pull, thanks a lot!

The following changes since commit 40e196a906d969fd10d885c692d2674b3d657006:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2019-02-19 16:13:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 4c8e0459b585e2a7b367545be3e102737f1e489f:

  net: phy: realtek: Dummy IRQ calls for RTL8366RB (2019-02-23 18:45:28 -0800)

----------------------------------------------------------------
Al Viro (1):
      missing barriers in some of unix_sock ->addr and ->path accesses

Alban Crequy (1):
      bpf, lpm: fix lookup bug in map_delete_elem

Arnd Bergmann (1):
      phonet: fix building with clang

Björn Töpel (2):
      Revert "xsk: simplify AF_XDP socket teardown"
      i40e: fix XDP_REDIRECT/XDP xmit ring cleanup race

Cong Wang (1):
      xfrm: destroy xfrm_state synchronously on net exit path

Daniel Borkmann (3):
      ipvlan: disallow userns cap_net_admin to change global mode/flags
      Merge branch 'bpf-nfp-codegen-fixes'
      bpf, doc: add bpf list as secondary entry to maintainers file

David Chen (1):
      r8152: Fix an error on RTL8153-BD MAC Address Passthrough support

David S. Miller (10):
      Merge branch 'ipv6-route-rcu'
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge branch 'tipc-improvement-for-wait-and-wakeup'
      Merge branch 'report-erspan-version-field-just-for-erspan-tunnels'
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge branch 'nic-thunderx-fix-communication-races-between-VF-PF'
      Merge tag 'mac80211-for-davem-2019-02-22' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'bnxt_en-firmware-message-delay-fixes'
      Merge branch 'udp-a-few-fixes'
      Merge git://git.kernel.org/.../bpf/bpf

Eric Dumazet (2):
      net/x25: fix a race in x25_bind()
      tcp: repaired skbs must init their tso_segs

Felix Fietkau (1):
      mac80211: allocate tailroom for forwarded mesh packets

Florian Fainelli (1):
      Documentation: networking: switchdev: Update port parent ID section

George Wilkie (1):
      team: use operstate consistently for linkup

Hangbin Liu (2):
      net: vrf: remove MTU limits for vrf device
      Revert "bridge: do not add port to router list when receives query with source 0.0.0.0"

Hauke Mehrtens (1):
      net: dsa: Remove documentation for port_fdb_prepare

Jan Sokolowski (1):
      ixgbe: don't do any AF_XDP zero-copy transmit if netif is not OK

Jann Horn (2):
      MAINTAINERS: mark CAIF as orphan
      net: socket: add check for negative optlen in compat setsockopt

Jeff Kirsher (1):
      ixgbe: fix older devices that do not support IXGBE_MRQC_L3L4TXSWEN

Jiong Wang (2):
      nfp: bpf: fix code-gen bug on BPF_ALU | BPF_XOR | BPF_K
      nfp: bpf: fix ALU32 high bits clearance bug

Kalash Nainwal (1):
      net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255

Li RongQing (1):
      mac80211_hwsim: propagate genlmsg_reply return code

Linus Walleij (1):
      net: phy: realtek: Dummy IRQ calls for RTL8366RB

Lorenzo Bianconi (3):
      net: ip_gre: do not report erspan_ver for gre or gretap
      net: ip6_gre: do not report erspan_ver for ip6gre or ip6gretap
      net: ip6_gre: fix possible NULL pointer dereference in ip6erspan_set_version

Maciej Kwiecien (1):
      sctp: don't compare hb_timer expire date before starting it

Magnus Karlsson (2):
      i40e: fix potential RX buffer starvation for AF_XDP
      ixgbe: fix potential RX buffer starvation for AF_XDP

Mao Wenan (1):
      net: set static variable an initial value in atl2_probe()

Martin Willi (1):
      esp: Skip TX bytes accounting when sending from a request socket

Maxime Chevallier (1):
      net: phy: marvell10g: Fix Multi-G advertisement to only advertise 10G

Michael Chan (2):
      bnxt_en: Fix typo in firmware message timeout logic.
      bnxt_en: Wait longer for the firmware message response to complete.

Michal Soltys (1):
      bonding: fix PACKET_ORIGDEV regression

Paolo Abeni (7):
      ipv6: route: enforce RCU protection in rt6_update_exception_stamp_rt()
      ipv6: route: enforce RCU protection in ip6_route_check_nh_onlink()
      ipv6: route: purge exception on removal
      udpv6: add the required annotation to mib type
      fou6: fix proto error handler argument type
      udpv6: fix possible user after free in error handler
      udp: fix possible user after free in error handler

Russell King (2):
      net: dsa: fix unintended change of bridge interface STP state
      net: marvell: mvneta: fix DMA debug warning

Sean Tranchetti (1):
      af_key: unconditionally clone on broadcast

Stanislav Fomichev (1):
      bpf/test_run: fix unkillable BPF_PROG_TEST_RUN

Thadeu Lima de Souza Cascardo (1):
      selftests: fib_tests: sleep after changing carrier. again.

Tobias Brunner (1):
      xfrm: Fix inbound traffic via XFRM interfaces across network namespaces

Toke Høiland-Jørgensen (1):
      mac80211: Change default tx_sk_pacing_shift to 7

Tung Nguyen (2):
      tipc: improve function tipc_wait_for_cond()
      tipc: improve function tipc_wait_for_rcvmsg()

Ursula Braun (1):
      net/smc: fix smc_poll in SMC_INIT state

Vadim Lomovtsev (8):
      net: thunderx: correct typo in macro name
      net: thunderx: replace global nicvf_rx_mode_wq work queue for all VFs to private for each of them.
      net: thunderx: make CFG_DONE message to run through generic send-ack sequence
      net: thunderx: add nicvf_send_msg_to_pf result check for set_rx_mode_task
      net: thunderx: rework xcast message structure to make it fit into 64 bit
      net: thunderx: add mutex to protect mailbox from concurrent calls for same VF
      net: thunderx: move link state polling function to VF
      net: thunderx: remove link change polling code and info from nicpf

Willem de Bruijn (1):
      net: avoid false positives in untrusted gso validation

YueHaibing (1):
      mdio_bus: Fix use-after-free on device_register fails

 Documentation/networking/dsa/dsa.txt              |  10 ++-----
 Documentation/networking/switchdev.txt            |  10 +++----
 MAINTAINERS                                       |  17 +++++++++--
 drivers/net/bonding/bond_main.c                   |  35 +++++++++-------------
 drivers/net/ethernet/atheros/atlx/atl2.c          |   4 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |   4 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |   2 +-
 drivers/net/ethernet/cavium/thunder/nic.h         |  14 +++++----
 drivers/net/ethernet/cavium/thunder/nic_main.c    | 149 +++++++++++++++++++++++++++++----------------------------------------------------------------
 drivers/net/ethernet/cavium/thunder/nicvf_main.c  | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c |   2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       |  27 +++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |   4 ++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c        |   5 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  19 ++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c      |  15 ++++++++--
 drivers/net/ethernet/marvell/mvneta.c             |   2 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c      |  17 ++++-------
 drivers/net/ipvlan/ipvlan_main.c                  |   4 +++
 drivers/net/phy/marvell10g.c                      |   6 +++-
 drivers/net/phy/mdio_bus.c                        |   1 -
 drivers/net/phy/realtek.c                         |   7 +++++
 drivers/net/team/team.c                           |   4 +--
 drivers/net/usb/r8152.c                           |   2 +-
 drivers/net/vrf.c                                 |   3 ++
 drivers/net/wireless/mac80211_hwsim.c             |   2 +-
 include/linux/phy.h                               |   8 +++++
 include/linux/virtio_net.h                        |  14 +++++++--
 include/net/phonet/pep.h                          |   5 ++--
 include/net/xfrm.h                                |  12 ++++++--
 kernel/bpf/lpm_trie.c                             |   1 +
 net/bpf/test_run.c                                |  45 +++++++++++++++-------------
 net/bridge/br_multicast.c                         |   9 +-----
 net/compat.c                                      |   6 +++-
 net/dsa/port.c                                    |   7 +++--
 net/ipv4/esp4.c                                   |   2 +-
 net/ipv4/ip_gre.c                                 |  33 +++++++++++----------
 net/ipv4/tcp_output.c                             |   1 +
 net/ipv4/udp.c                                    |   6 ++--
 net/ipv6/esp6.c                                   |   2 +-
 net/ipv6/fou6.c                                   |   2 +-
 net/ipv6/ip6_gre.c                                |  39 +++++++++++++------------
 net/ipv6/route.c                                  |  32 +++++++++++++++-----
 net/ipv6/udp.c                                    |  12 ++++----
 net/ipv6/xfrm6_tunnel.c                           |   2 +-
 net/key/af_key.c                                  |  42 ++++++++++----------------
 net/mac80211/main.c                               |   4 +--
 net/mac80211/rx.c                                 |   7 ++++-
 net/phonet/pep.c                                  |  32 ++++++++++----------
 net/sctp/transport.c                              |   3 +-
 net/smc/smc.h                                     |   6 ++--
 net/tipc/socket.c                                 |  11 +++----
 net/unix/af_unix.c                                |  57 +++++++++++++++++++++---------------
 net/unix/diag.c                                   |   3 +-
 net/x25/af_x25.c                                  |  13 +++++----
 net/xdp/xsk.c                                     |  16 +++++++++-
 net/xfrm/xfrm_interface.c                         |   4 +--
 net/xfrm/xfrm_policy.c                            |   4 ++-
 net/xfrm/xfrm_state.c                             |  30 ++++++++++++-------
 net/xfrm/xfrm_user.c                              |   2 +-
 security/lsm_audit.c                              |  10 ++++---
 tools/testing/selftests/bpf/test_lpm_map.c        |  10 +++++++
 tools/testing/selftests/net/fib_tests.sh          |   1 +
 64 files changed, 568 insertions(+), 420 deletions(-)

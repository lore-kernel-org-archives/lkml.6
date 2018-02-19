Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeBSTr0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:47:26 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:35470 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbeBSTrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:47:24 -0500
Date: Mon, 19 Feb 2018 14:47:23 -0500 (EST)
Message-Id: <20180219.144723.1181317370751838442.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Prevent index integer overflow in ptr_ring, from Jason Wang.

2) Program mvpp2 multicast filter properly, from Mikulas Patocka.

3) The bridge brport attribute file is write only and doesn't have
   a ->show() method, don't blindly invoke it.  From Xin Long.

4) Inverted mask used in genphy_setup_forced(), from Ingo van Lil.

5) Fix multiple definition issue with if_ether.h UAPI header, from
   Hauke Mehrtens.

6) Fix GFP_KERNEL usage in atomic in RDS protocol code, from Sowmini
   Varadhan.

7) Revert XDP redirect support from thunderx driver, it is not
   implemented properly.  From Jesper Dangaard Brouer.

8) Fix missing RTNL protection across some tipc operations, from
   Ying Xue.

9) Return the correct IV bytes in the TLS getsockopt code, from
   Boris Pismenny.

10) Take tclassid into consideration properly when doing FIB rule
    matching.  From Stefano Brivio.

11) cxgb4 device needs more PCI VPD quirks, from Casey Leedom.

12) TUN driver doesn't align frags properly, and we can end up doing
    unaligned atomics on misaligned metadata.  From Eric Dumazet.

13) Fix various crashes found using DEBUG_PREEMPT in rmnet driver,
    from Subash Abhinov Kasiviswanathan.

Please pull, thanks a lot!

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 506b0a395f26e52b3f18827e0de1be051acb77ab:

  tg3: APE heartbeat changes (2018-02-19 14:16:52 -0500)

----------------------------------------------------------------
Alexey Kodanev (1):
      udplite: fix partial checksum initialization

Boris Pismenny (3):
      tls: retrun the correct IV in getsockopt
      tls: reset the crypto info if copy_from_user fails
      tls: getsockopt return record sequence number

Casey Leedom (1):
      PCI/cxgb4: Extend T3 PCI quirk to T4+ devices

Daniel Axtens (3):
      docs: segmentation-offloads.txt: update for UFO depreciation
      docs: segmentation-offloads.txt: Fix ref to SKB_GSO_TUNNEL_REMCSUM
      docs: segmentation-offloads.txt: add SCTP info

David Howells (1):
      rxrpc: Work around usercopy check

David S. Miller (6):
      Merge branch 'net-sched-couple-of-fixes'
      Merge branch 'ibmvnic-leaks'
      Merge branch 'tipc-locking-fixes'
      Merge branch 'net-segmentation-offload-doc-fixes'
      skbuff: Fix comment mis-spelling.
      Merge branch 'qualcomm-rmnet-Fix-issues-with-CONFIG_DEBUG_PREEMPT-enabled'

Eric Dumazet (1):
      tun: fix tun_napi_alloc_frags() frag allocator

Ganesh Goudar (1):
      cxgb4: free up resources of pf 0-3

Geert Uytterhoeven (2):
      ravb: Remove obsolete explicit clock handling for WoL
      sh_eth: Remove obsolete explicit clock handling for WoL

Hauke Mehrtens (1):
      uapi/if_ether.h: move __UAPI_DEF_ETHHDR libc define

Ido Schimmel (1):
      mlxsw: spectrum_router: Do not unconditionally clear route offload indication

Ilya Lesokhin (1):
      tcp: Honor the eor bit in tcp_mtu_probe

Ingo van Lil (1):
      net: phy: fix wrong mask to phy_modify()

Jakub Kicinski (1):
      net: fix race on decreasing number of TX queues

Jan Glauber (1):
      net: cavium: fix NULL pointer dereference in cavium_ptp_put

Jason Wang (1):
      ptr_ring: prevent integer overflow when calculating size

Jesper Dangaard Brouer (1):
      Revert "net: thunderx: Add support for xdp redirect"

Jiri Pirko (3):
      mlxsw: spectrum_router: Fix error path in mlxsw_sp_vr_create
      net: sched: don't set q pointer for shared blocks
      net: sched: fix tc_u_common lookup

Kees Cook (1):
      NFC: llcp: Limit size of SDP URI

Mika Westerberg (2):
      net: thunderbolt: Tear down connection properly on suspend
      net: thunderbolt: Run disconnect flow asynchronously when logout is received

Mikulas Patocka (1):
      mvpp2: fix multicast address filter

Paolo Abeni (1):
      dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Prashant Sreedharan (1):
      tg3: APE heartbeat changes

Rahul Lakkireddy (1):
      cxgb4: fix trailing zero in CIM LA dump

Sowmini Varadhan (1):
      rds: do not call ->conn_alloc with GFP_KERNEL

Stefano Brivio (1):
      fib_semantics: Don't match route with mismatching tclassid

Subash Abhinov Kasiviswanathan (3):
      net: qualcomm: rmnet: Fix crash on real dev unregistration
      net: qualcomm: rmnet: Fix warning seen with 64 bit stats
      net: qualcomm: rmnet: Fix possible null dereference in command processing

Thomas Falcon (5):
      ibmvnic: Wait until reset is complete to set carrier on
      ibmvnic: Fix login buffer memory leaks
      ibmvnic: Fix NAPI structures memory leak
      ibmvnic: Free RX socket buffer in case of adapter error
      ibmvnic: Clean RX pool buffers during device close

Tobias Klauser (1):
      net: af_unix: fix typo in UNIX_SKB_FRAGS_SZ comment

Xin Long (6):
      bridge: check brport attr show in brport_show
      sctp: do not pr_err for the duplicated node in transport rhlist
      sctp: add SCTP_CID_I_DATA and SCTP_CID_I_FWD_TSN conversion in sctp_cname
      sctp: remove the useless check in sctp_renege_events
      sctp: fix some copy-paste errors for file comments
      sctp: remove the left unnecessary check for chunk in sctp_renege_events

Ying Xue (7):
      tipc: Refactor __tipc_nl_compat_doit
      tipc: Introduce __tipc_nl_bearer_disable
      tipc: Introduce __tipc_nl_bearer_enable
      tipc: Introduce __tipc_nl_bearer_set
      tipc: Introduce __tipc_nl_media_set
      tipc: Introduce __tipc_nl_net_set
      tipc: Fix missing RTNL lock protection during setting link properties

 Documentation/networking/segmentation-offloads.txt      |  38 ++++++++++++++++++++++++++----
 drivers/net/ethernet/broadcom/tg3.c                     |  35 ++++++++++++++++++---------
 drivers/net/ethernet/broadcom/tg3.h                     |   5 ++++
 drivers/net/ethernet/cavium/common/cavium_ptp.c         |   2 ++
 drivers/net/ethernet/cavium/thunder/nicvf_main.c        | 110 ++++++++++++++++++++-----------------------------------------------------------------
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c      |  11 ++++-----
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h      |   4 ----
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c          |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c        |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c         |  25 ++++++++++----------
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c              |  10 --------
 drivers/net/ethernet/ibm/ibmvnic.c                      |  54 +++++++++++++++++++++++++++++++++++++++---
 drivers/net/ethernet/marvell/mvpp2.c                    |  11 ++++++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c   |  35 ++++++++++++++++-----------
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c      |  68 +++++++++++-----------------------------------------
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c |   5 ++++
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c         |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c                |   6 -----
 drivers/net/ethernet/renesas/sh_eth.c                   |  18 +++-----------
 drivers/net/phy/phy_device.c                            |   2 +-
 drivers/net/thunderbolt.c                               |  19 +++++++++++----
 drivers/net/tun.c                                       |  16 +++++--------
 drivers/pci/quirks.c                                    |  39 +++++++++++++++++-------------
 include/linux/ptr_ring.h                                |   2 +-
 include/linux/skbuff.h                                  |   2 +-
 include/net/udplite.h                                   |   1 +
 include/uapi/linux/if_ether.h                           |   6 ++++-
 include/uapi/linux/libc-compat.h                        |   6 -----
 net/bridge/br_sysfs_if.c                                |   3 +++
 net/core/dev.c                                          |  11 +++++++--
 net/decnet/af_decnet.c                                  |  62 +++++++++++++++++++++++++-----------------------
 net/ipv4/fib_semantics.c                                |   5 ++++
 net/ipv4/tcp_output.c                                   |  25 ++++++++++++++++++++
 net/ipv4/udp.c                                          |   5 ++++
 net/ipv6/ip6_checksum.c                                 |   5 ++++
 net/nfc/llcp_commands.c                                 |   4 ++++
 net/nfc/netlink.c                                       |   3 ++-
 net/rds/connection.c                                    |   2 +-
 net/rxrpc/recvmsg.c                                     |   5 ++--
 net/sched/cls_api.c                                     |  26 ++++++++++----------
 net/sched/cls_u32.c                                     |  24 +++++++++++++++----
 net/sctp/debug.c                                        |   6 +++++
 net/sctp/input.c                                        |   5 +---
 net/sctp/stream.c                                       |   2 +-
 net/sctp/stream_interleave.c                            |  16 +++++--------
 net/tipc/bearer.c                                       |  82 +++++++++++++++++++++++++++++++++++++++------------------------
 net/tipc/bearer.h                                       |   4 ++++
 net/tipc/net.c                                          |  15 +++++++++---
 net/tipc/net.h                                          |   1 +
 net/tipc/netlink_compat.c                               |  43 +++++++++++++++++----------------
 net/tls/tls_main.c                                      |   7 ++++--
 net/unix/af_unix.c                                      |   2 +-
 52 files changed, 504 insertions(+), 395 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeFBXj3 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 19:39:29 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44622 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeFBXj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 19:39:27 -0400
Date: Sat, 02 Jun 2018 19:39:23 -0400 (EDT)
Message-Id: <20180602.193923.1752404501296246599.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Infinite loop in _decode_session6(), from Eric Dumazet.

2) Pass correct argument to nla_strlcpy() in netfilter, also
   from Eric Dumazet.

3) Out of bounds memory access in ipv6 srh code, from Mathieu
   Xhonneux.

4) NULL deref in XDP_REDIRECT handling of tun driver, from
   Toshiaki Makita.

5) Incorrect idr release in cls_flower, from Paul Blakey.

6) Probe error handling fix in davinci_emac, from Dan Carpenter.

7) Memory leak in XPS configuration, from Alexander Duyck.

8) Use after free with cloned sockets in kcm, from Kirill Tkhai.

9) MTU handling fixes fo ip_tunnel and ip6_tunnel, from Nicolas
   Dichtel.

10) Fix UAPI hole in bpf data structure for 32-bit compat
    applications, from Daniel Borkmann.

Please pull, thanks a lot!

The following changes since commit bc2dbc5420e82560e650f8531ceca597441ca171:

  Merge branch 'akpm' (patches from Andrew) (2018-05-25 20:24:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to cd075ce4679ca7797734c4f6c5aa23878c8e2208:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2018-06-02 08:07:52 -0400)

----------------------------------------------------------------
Alexander Duyck (1):
      net-sysfs: Fix memory leak in XPS configuration

Ard Biesheuvel (1):
      net: netsec: reduce DMA mask to 40 bits

Damien Thébault (1):
      net: dsa: b53: Add BCM5389 support

Dan Carpenter (1):
      net: ethernet: davinci_emac: fix error handling in probe()

Daniel Borkmann (1):
      bpf: fix uapi hole for 32 bit compat applications

Daniele Palmas (1):
      net: usb: cdc_mbim: add flag FLAG_SEND_ZLP

David S. Miller (5):
      Merge git://git.kernel.org/.../pablo/nf
      Merge tag 'wireless-drivers-for-davem-2018-05-30' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge branch 'tunnel-mtus'
      Merge git://git.kernel.org/.../bpf/bpf

Eric Dumazet (2):
      xfrm6: avoid potential infinite loop in _decode_session6()
      netfilter: provide correct argument to nla_strlcpy()

Finn Thain (1):
      net/sonic: Use dma_mapping_error()

Hao Wei Tee (1):
      iwlwifi: pcie: compare with number of IRQs requested for, not number of CPUs

Ivan Bornyakov (1):
      atm: zatm: fix memcmp casting

Jason Wang (1):
      vhost_net: flush batched heads before trying to busy polling

Josh Hill (1):
      net: qmi_wwan: Add Netgear Aircard 779S

Julian Anastasov (1):
      ipvs: fix buffer overflow with sync daemon and service

Kirill Tkhai (1):
      kcm: Fix use-after-free caused by clonned sockets

Mathieu Xhonneux (1):
      ipv6: sr: fix memory OOB access in seg6_do_srh_encap/inline

Nicolas Dichtel (2):
      ip_tunnel: restore binding to ifaces with a large mtu
      ip6_tunnel: remove magic mtu value 0xFFF8

Ondøej Hlavatý (1):
      ixgbe: fix parsing of TC actions for HW offload

Pablo Neira Ayuso (2):
      netfilter: nft_limit: fix packet ratelimiting
      netfilter: nf_tables: disable preemption in nft_update_chain_stats()

Paolo Abeni (1):
      netfilter: ebtables: handle string from userspace with care

Paul Blakey (1):
      cls_flower: Fix incorrect idr release when failing to modify rule

Petr Machata (1):
      mlxsw: spectrum: Forbid creation of VLAN 1 over port/LAG

Samuel Mendoza-Jonas (1):
      net/ncsi: Fix array size in dumpit handler

Stanislaw Gruszka (1):
      Revert "rt2800: use TXOP_BACKOFF for probe frames"

Steffen Klassert (1):
      xfrm Fix potential error pointer dereference in xfrm_bundle_create.

Suresh Reddy (1):
      be2net: Fix error detection logic for BE3

Taehee Yoo (4):
      netfilter: nf_tables: fix NULL pointer dereference on nft_ct_helper_obj_dump()
      netfilter: nft_meta: fix wrong value dereference in nft_meta_set_eval
      netfilter: nf_tables: fix NULL-ptr in nf_tables_dump_obj()
      netfilter: nf_tables: increase nft_counters_enabled in nft_chain_stats_replace()

Toshiaki Makita (1):
      tun: Fix NULL pointer dereference in XDP redirect

 Documentation/devicetree/bindings/net/dsa/b53.txt |  1 +
 drivers/atm/zatm.c                                |  4 ++--
 drivers/net/dsa/b53/b53_common.c                  | 13 +++++++++++++
 drivers/net/dsa/b53/b53_mdio.c                    |  5 ++++-
 drivers/net/dsa/b53/b53_priv.h                    |  1 +
 drivers/net/ethernet/emulex/benet/be_main.c       |  4 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  9 ++++-----
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c    |  5 +++++
 drivers/net/ethernet/natsemi/sonic.c              |  2 +-
 drivers/net/ethernet/socionext/netsec.c           |  4 ++--
 drivers/net/ethernet/ti/davinci_emac.c            | 22 ++++++++++++----------
 drivers/net/tun.c                                 | 15 +++++++++------
 drivers/net/usb/cdc_mbim.c                        |  2 +-
 drivers/net/usb/qmi_wwan.c                        |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c   | 10 +++++-----
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c  |  7 +++----
 drivers/vhost/net.c                               | 37 ++++++++++++++++++++++++-------------
 include/uapi/linux/bpf.h                          |  2 ++
 net/bridge/netfilter/ebtables.c                   |  3 ++-
 net/core/net-sysfs.c                              |  6 +++---
 net/ipv4/ip_tunnel.c                              |  8 ++++----
 net/ipv6/ip6_tunnel.c                             | 11 ++++++++---
 net/ipv6/seg6_iptunnel.c                          |  4 ++--
 net/ipv6/sit.c                                    |  5 +++--
 net/ipv6/xfrm6_policy.c                           |  2 +-
 net/kcm/kcmsock.c                                 |  2 +-
 net/ncsi/ncsi-netlink.c                           |  2 +-
 net/netfilter/ipvs/ip_vs_ctl.c                    | 21 +++++++++++++++------
 net/netfilter/nf_tables_api.c                     |  8 +++++---
 net/netfilter/nf_tables_core.c                    |  4 ++--
 net/netfilter/nfnetlink_acct.c                    |  2 +-
 net/netfilter/nfnetlink_cthelper.c                |  4 ++--
 net/netfilter/nft_ct.c                            | 20 ++++++++++++--------
 net/netfilter/nft_limit.c                         | 38 ++++++++++++++++++++++++--------------
 net/netfilter/nft_meta.c                          | 14 ++++++++------
 net/sched/cls_flower.c                            |  2 +-
 net/xfrm/xfrm_policy.c                            |  5 ++---
 tools/include/uapi/linux/bpf.h                    |  2 ++
 38 files changed, 192 insertions(+), 115 deletions(-)

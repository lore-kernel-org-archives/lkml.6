Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F437C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 21:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6DA20675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 21:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfAMVdu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 16:33:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57838 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfAMVdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 16:33:49 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C7D7213408136;
        Sun, 13 Jan 2019 13:33:48 -0800 (PST)
Date:   Sun, 13 Jan 2019 13:33:46 -0800 (PST)
Message-Id: <20190113.133346.873105268319400703.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 13 Jan 2019 13:33:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix regression in multi-SKB responses to RTM_GETADDR, from Arthur
   Gautier.

2) Fix ipv6 frag parsing in openvswitch, from Yi-Hung Wei.

3) Unbounded recursion in ipv4 and ipv6 GUE tunnels, from Stefano
   Brivio.

4) Use after free in hns driver, from Yonglong Liu.

5) icmp6_send() needs to handle the case of NULL skb, from Eric
   Dumazet.

6) Missing rcu read lock in __inet6_bind() when operating on mapped
   addresses, from David Ahern.

7) Memory leak in tipc-nl_compat_publ_dump(), from Gustavo
   A. R. Silva.

8) Fix PHY vs r8169 module loading ordering issues, from Heiner
   Kallweit.

9) Fix bridge vlan memory leak, from Ido Schimmel.

10) Dev refcount leak in AF_PACKET, from Jason Gunthorpe.

11) Infoleak in ipv6_local_error(), flow label isn't completely
    initialized.  From Eric Dumazet.

12) Handle mv88e6390 errata, from Andrew Lunn.

13) Making vhost/vsock CID hashing consistent, from Zha Bin.

14) Fix lack of UMH cleanup when it unexpectedly exits, from Taehee
    Yoo.

15) Bridge forwarding must clear skb->tstamp, from Paolo Abeni.

Please pull, thanks a lot!

The following changes since commit 96d4f267e40f9509e8a66e2b39e8b95655617693:

  Remove 'type' argument from access_ok() function (2019-01-03 18:57:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to 2f960bd0564081ff85d2eea54890b0d2356934f8:

  Merge branch 'bnxt_en-Bug-fixes-for-57500-chips' (2019-01-12 10:51:39 -0800)

----------------------------------------------------------------
Alexei Starovoitov (3):
      Merge branch 'udpv6_sendmsg-addr_any-fix'
      Merge branch 'reject-ptr-scalar-mix'
      Merge branch 'bpf-doc-updates'

Anders Roxell (1):
      selftests: bpf: install files tcp_(server|client)*.py

Andrew Lunn (1):
      net: dsa: mv88x6xxx: mv88e6390 errata

Andrey Ignatov (2):
      bpf: Fix [::] -> [::1] rewrite in sys_sendmsg
      selftests/bpf: Test [::] -> [::1] rewrite in sys_sendmsg in test_sock_addr

Arthur Gautier (1):
      netlink: fixup regression in RTM_GETADDR

Bjørn Mork (1):
      cdc_ether: trivial whitespace readability fix

Bryan Whitehead (1):
      lan743x: Remove phy_read from link status change function

Christophe JAILLET (1):
      octeontx2-af: Fix a resource leak in an error handling path in 'cgx_probe()'

Claudiu Beznea (1):
      net: macb: remove unnecessary code

Colin Ian King (2):
      net: cxgb3: fix various indentation issues
      net: cxgb4: fix various indentation issues

Cong Wang (1):
      smc: move unhash as early as possible in smc_release()

Daniel Borkmann (5):
      bpf: fix sanitation of alu op with pointer / scalar type from different paths
      bpf: add various test cases for alu op on mixed dst register types
      bpf, doc: update design qa to reflect kern_version requirement
      bpf, doc: add note for libbpf's stand-alone build
      Merge branch 'bpf-fix-bitfield-printing'

Daniele Palmas (1):
      qmi_wwan: add MTU default to qmap network interface

David Ahern (2):
      ipv6: Consider sk_bound_dev_if when binding a socket to a v4 mapped address
      ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses

David Rientjes (1):
      net, skbuff: do not prefer skb allocation fails early

David S. Miller (9):
      Merge branch 'qed-fixes'
      Merge branch 'GUE-error-recursion'
      Merge branch 'hns-fixes'
      Merge ra.kernel.org:/.../bpf/bpf
      Merge branch 'mlxsw-fixes'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'stmmac-fixes'
      Merge branch 'bpfilter-fixes'
      Merge branch 'bnxt_en-Bug-fixes-for-57500-chips'

Denis Bolotin (2):
      qed: Fix qed_chain_set_prod() for PBL chains with non power of 2 page count
      qed: Fix qed_ll2_post_rx_buffer_notify_fw() by adding a write memory barrier

Eric Dumazet (2):
      ipv6: make icmp6_send() robust against null skb->dev
      ipv6: fix kernel-infoleak in ipv6_local_error()

Eugene Syromiatnikov (2):
      ptp: check that rsv field is zero in struct ptp_sys_offset_extended
      ptp: uapi: change _IOW to IOWR in PTP_SYS_OFFSET_EXTENDED definition

Gustavo A. R. Silva (2):
      tipc: fix memory leak in tipc_nl_compat_publ_dump
      mISDN: hfcsusb: Use struct_size() in kzalloc()

Heiner Kallweit (3):
      r8169: don't try to read counters if chip is in a PCI power-save state
      r8169: load Realtek PHY driver module before r8169
      net: ethernet: mediatek: fix warning in phy_start_aneg

Ido Schimmel (8):
      mlxsw: spectrum: Add VXLAN dependency for spectrum
      mlxsw: spectrum_switchdev: Avoid returning errors in commit phase
      mlxsw: spectrum_nve: Replace error code with EINVAL
      selftests: mlxsw: Add a test case for VLAN addition error flow
      net: bridge: Fix VLANs memory leak
      selftests: forwarding: Fix test for different devices
      mlxsw: spectrum_switchdev: Set PVID correctly during VLAN deletion
      selftests: forwarding: Add a test for VLAN deletion

Ioana Ciornei (1):
      samples: bpf: user proper argument index

Jacob Wen (1):
      rds: use DIV_ROUND_UP instead of ceil

Jason Gunthorpe (2):
      phy: ti: Fix compilation failures without REGMAP
      packet: Do not leak dev refcounts on error exit

Jeff Kirsher (1):
      ixgbe: fix Kconfig when driver is not a module

Jia-Ju Bai (1):
      isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

JianJhen Chen (1):
      net: bridge: fix a bug on using a neighbour cache entry without checking its state

Jiri Pirko (1):
      mlxsw: spectrum: Disable lag port TX before removing it

Jose Abreu (5):
      net: stmmac: Fix PCI module removal leak
      net: stmmac: dwxgmac2: Only clear interrupts that are active
      net: stmmac: Check if CBS is supported before configuring
      net: stmmac: Fix the logic of checking if RX Watchdog must be enabled
      net: stmmac: Prevent RX starvation in stmmac_napi_poll()

Kai-Heng Feng (1):
      r8169: Add support for new Realtek Ethernet

Konstantin Khlebnikov (1):
      net/core/neighbour: tell kmemleak about hash tables

Linus Walleij (2):
      net: dsa: microchip: Drop unused GPIO includes
      net: dsa: mt7530: Drop unused GPIO include

Michael Chan (2):
      bnxt_en: Fix ring checking logic on 57500 chips.
      bnxt_en: Fix context memory allocation.

Nir Dotan (2):
      mlxsw: spectrum_acl: Add cleanup after C-TCAM update error condition
      mlxsw: spectrum_acl: Remove ASSERT_RTNL()s in module removal flow

Oliver Hartkopp (1):
      can: gw: ensure DLC boundaries after CAN frame modification

Paolo Abeni (1):
      net: clear skb->tstamp in bridge forwarding path

Peter Oskolkov (1):
      selftests: net: fix/improve ip_defrag selftest

Song Liu (1):
      bpf: fix panic in stack_map_get_build_id() on i386 and arm32

Stanislav Fomichev (3):
      selftests/bpf: fix incorrect users of create_and_get_cgroup
      tun: publish tfile after it's fully initialized
      selftests/bpf: add missing executables to .gitignore

Stefano Brivio (2):
      fou: Prevent unbounded recursion in GUE error handler also with UDP-Lite
      fou6: Prevent unbounded recursion in GUE error handler

Stephen Warren (2):
      net/mlx4: Get rid of page operation after dma_alloc_coherent
      net/mlx4: replace pci_{,un}map_sg with dma_{,un}map_sg

Taehee Yoo (4):
      umh: add exit routine for UMH process
      net: bpfilter: use cleanup callback to release umh_info
      net: bpfilter: restart bpfilter_umh when error occurred
      net: bpfilter: disallow to remove bpfilter module while being used

Wen Yang (1):
      soc/fsl/qe: fix err handling of ucc_of_parse_tdm

Willem de Bruijn (2):
      ip: on queued skb use skb_header_pointer instead of pskb_may_pull
      bonding: update nest level on unlink

Yi-Hung Wei (1):
      openvswitch: Fix IPv6 later frags parsing

Yonghong Song (3):
      bpf: fix bpffs bitfield pretty print
      tools/bpf: test btf bitfield with >=256 struct member offset
      tools/bpf: fix bpftool map dump with bitfields

Yonglong Liu (2):
      net: hns: Fix WARNING when hns modules installed
      net: hns: Fix use after free identified by SLUB debug

Yuchung Cheng (2):
      bpf: correctly set initial window on active Fast Open sender
      tcp: change txhash on SYN-data timeout

Zha Bin (1):
      vhost/vsock: fix vhost vsock cid hashing inconsistent

 Documentation/bpf/bpf_design_QA.rst                         |  11 ++++----
 drivers/isdn/hardware/mISDN/hfcsusb.c                       |   3 +--
 drivers/isdn/i4l/isdn_tty.c                                 |   6 ++++-
 drivers/net/bonding/bond_main.c                             |   3 +++
 drivers/net/dsa/microchip/ksz_common.c                      |   2 --
 drivers/net/dsa/mt7530.c                                    |   1 -
 drivers/net/dsa/mv88e6xxx/chip.c                            | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h                            |   5 ++++
 drivers/net/dsa/mv88e6xxx/port.h                            |  10 ++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                   |  12 ++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h               |   5 ++--
 drivers/net/ethernet/cadence/macb_main.c                    |   8 ++----
 drivers/net/ethernet/chelsio/cxgb3/sge.c                    |  12 +++++----
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c                  |   6 ++---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c              |   8 +++---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c              |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                  |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c           |   6 ++---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c               |  17 +++++--------
 drivers/net/ethernet/intel/Kconfig                          |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c             |   4 ++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                 |  16 ------------
 drivers/net/ethernet/mellanox/mlx4/icm.c                    | 101 ++++++++++++++++++++++++++++++++++++++++++------------------------------
 drivers/net/ethernet/mellanox/mlx4/icm.h                    |  22 +++++++++++++---
 drivers/net/ethernet/mellanox/mlxsw/Kconfig                 |   1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c              |   7 +++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c    |  10 +++++++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c      |   2 --
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c          |   4 +--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c    |  23 ++++++++---------
 drivers/net/ethernet/microchip/lan743x_main.c               |  11 +++-----
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                   |   4 +++
 drivers/net/ethernet/realtek/r8169.c                        |   9 +++++--
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c          |   6 ++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c           |  51 +++++++++++++++++++------------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c            |  10 ++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c             |   2 ++
 drivers/net/tun.c                                           |  11 +++++---
 drivers/net/usb/cdc_ether.c                                 |  26 ++++++++-----------
 drivers/net/usb/qmi_wwan.c                                  |   1 +
 drivers/net/wan/fsl_ucc_hdlc.c                              |  62 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/phy/ti/Kconfig                                      |   1 +
 drivers/ptp/ptp_chardev.c                                   |   3 ++-
 drivers/soc/fsl/qe/qe_tdm.c                                 |  55 ---------------------------------------
 drivers/vhost/vsock.c                                       |   2 +-
 include/linux/bpf_verifier.h                                |   1 +
 include/linux/bpfilter.h                                    |  15 ++++++++---
 include/linux/qed/qed_chain.h                               |  31 ++++++++++++++++++++++
 include/linux/sched.h                                       |   9 +++++++
 include/linux/umh.h                                         |   2 ++
 include/uapi/linux/ptp_clock.h                              |   2 +-
 kernel/bpf/btf.c                                            |  12 ++++-----
 kernel/bpf/stackmap.c                                       |   3 ++-
 kernel/bpf/verifier.c                                       |  61 ++++++++++++++++++++++++++++++++++----------
 kernel/exit.c                                               |   1 +
 kernel/umh.c                                                |  33 ++++++++++++++++++++++--
 net/bpfilter/bpfilter_kern.c                                |  76 +++++++++++++++++++++++++++++-------------------------
 net/bpfilter/bpfilter_umh_blob.S                            |   2 +-
 net/bridge/br_forward.c                                     |   1 +
 net/bridge/br_netfilter_hooks.c                             |   2 +-
 net/bridge/br_private.h                                     |   1 +
 net/bridge/br_vlan.c                                        |  26 +++++++++----------
 net/can/gw.c                                                |  30 +++++++++++++++++++---
 net/core/filter.c                                           |   2 +-
 net/core/neighbour.c                                        |  13 +++++++---
 net/core/skbuff.c                                           |   7 +----
 net/ipv4/bpfilter/sockopt.c                                 |  58 ++++++++++++++++++++++++++++++++++--------
 net/ipv4/devinet.c                                          |   2 +-
 net/ipv4/fou.c                                              |   3 ++-
 net/ipv4/ip_sockglue.c                                      |  12 ++++-----
 net/ipv4/tcp_timer.c                                        |   2 +-
 net/ipv6/addrconf.c                                         |   2 +-
 net/ipv6/af_inet6.c                                         |  14 +++++++++-
 net/ipv6/datagram.c                                         |  11 ++++----
 net/ipv6/fou6.c                                             |   8 ++++++
 net/ipv6/icmp.c                                             |   8 ++++--
 net/ipv6/udp.c                                              |   8 +++---
 net/openvswitch/flow.c                                      |   8 +++---
 net/packet/af_packet.c                                      |   4 +--
 net/rds/ib_send.c                                           |   4 +--
 net/rds/message.c                                           |   4 +--
 net/rds/rds.h                                               |   4 ---
 net/rds/send.c                                              |   2 +-
 net/smc/af_smc.c                                            |   4 ++-
 net/tipc/netlink_compat.c                                   |   4 ++-
 samples/bpf/test_cgrp2_attach2.c                            |  14 +++++-----
 samples/bpf/test_current_task_under_cgroup_user.c           |   2 +-
 samples/bpf/xdp1_user.c                                     |   2 +-
 tools/bpf/bpftool/btf_dumper.c                              |  13 +++++-----
 tools/lib/bpf/.gitignore                                    |   1 +
 tools/lib/bpf/README.rst                                    |  14 ++++++++++
 tools/testing/selftests/bpf/.gitignore                      |   1 +
 tools/testing/selftests/bpf/Makefile                        |   4 ++-
 tools/testing/selftests/bpf/cgroup_helpers.c                |   6 ++---
 tools/testing/selftests/bpf/test_btf.c                      |  29 +++++++++++++++------
 tools/testing/selftests/bpf/test_cgroup_storage.c           |   2 +-
 tools/testing/selftests/bpf/test_dev_cgroup.c               |   2 +-
 tools/testing/selftests/bpf/test_netcnt.c                   |   2 +-
 tools/testing/selftests/bpf/test_skb_cgroup_id_user.c       |   2 +-
 tools/testing/selftests/bpf/test_sock.c                     |   2 +-
 tools/testing/selftests/bpf/test_sock_addr.c                |  55 ++++++++++++++++++++++++++++++++++++---
 tools/testing/selftests/bpf/test_socket_cookie.c            |   2 +-
 tools/testing/selftests/bpf/test_tcpbpf_user.c              |   2 +-
 tools/testing/selftests/bpf/test_tcpnotify_user.c           |   2 +-
 tools/testing/selftests/bpf/test_verifier.c                 | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/drivers/net/mlxsw/vxlan.sh          |  18 +++++++++++++
 tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh |  15 ++++++++++-
 tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh   |   2 +-
 tools/testing/selftests/net/ip_defrag.c                     |  96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 tools/testing/selftests/net/ip_defrag.sh                    |   9 ++++++-
 110 files changed, 1149 insertions(+), 438 deletions(-)

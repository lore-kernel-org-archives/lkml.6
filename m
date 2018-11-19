Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34812C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB8120823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB8120823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeKSNez convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:34:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60428 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeKSNez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 08:34:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8F6C714719783;
        Sun, 18 Nov 2018 19:12:43 -0800 (PST)
Date:   Sun, 18 Nov 2018 19:12:42 -0800 (PST)
Message-Id: <20181118.191242.1498284515936666603.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 18 Nov 2018 19:12:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix some potentially uninitialized variables and use-after-free in
   kvaser_usb can drier, from Jimmy Assarsson.

2) Fix leaks in qed driver, from Denis Bolotin.

3) Socket leak in l2tp, from Xin Long.

4) RSS context allocation fix in bnxt_en from Michael Chan.

5) Fix cxgb4 build errors, from Ganesh Goudar.

6) Route leaks in ipv6 when removing exceptions, from Xin Long.

7) Memory leak in IDR allocation handling of act_pedit, from Davide
   Caratti.

8) Use-after-free of bridge vlan stats, from Nikolay Aleksandrov.

9) When MTU is locked, do not force DF bit on ipv4 tunnels.  From
   Sabrina Dubroca.

10) When NAPI cached skb is reused, we must set it to the proper
    initial state which includes skb->pkt_type.  From Eric Dumazet.

11) Lockdep and non-linear SKB handling fix in tipc from Jon Maloy.

12) Set RX queue properly in various tuntap receive paths, from
    Matthew Cover.

Please pull, thanks a lot!

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to 8ebebcba559a1bfbaec7bbda64feb9870b9c58da:

  tuntap: fix multiqueue rx (2018-11-18 19:05:43 -0800)

----------------------------------------------------------------
Alexander Stein (1):
      can: flexcan: Always use last mailbox for TX

Andrew Morton (1):
      drivers/net/ethernet/qlogic/qed/qed_rdma.h: fix typo

Aya Levin (1):
      net/mlx4: Fix UBSAN warning of signed integer overflow

Brenda J. Butler (1):
      tc-testing: tdc.py: Guard against lack of returncode in executed command

Christophe JAILLET (1):
      net: lantiq: Fix returned value in case of error in 'xrx200_probe()'

David Ahern (1):
      ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF

David Howells (1):
      rxrpc: Fix life check

David S. Miller (7):
      Merge tag 'linux-can-fixes-for-4.20-20181109' of ssh://gitolite.kernel.org/.../mkl/linux-can
      Merge branch 'qed-Miscellaneous-bug-fixes'
      Merge branch 'bnxt_en-Bug-fixes'
      Merge branch 'mlx4-fixes'
      Merge tag 'batadv-net-for-davem-20181114' of git://git.open-mesh.org/linux-merge
      Revert "net: phy: mdio-gpio: Fix working over slow can_sleep GPIOs"
      Merge branch 'tdc-fixes'

Davide Caratti (1):
      net/sched: act_pedit: fix memory leak when IDR allocation fails

Denis Bolotin (3):
      qed: Fix PTT leak in qed_drain()
      qed: Fix overriding offload_tc by protocols without APP TLV
      qed: Fix reading wrong value in loop condition

Eric Dumazet (2):
      net_sched: sch_fq: ensure maxrate fq parameter applies to EDT flows
      net-gro: reset skb->pkt_type in napi_reuse_skb()

Eugeniu Rosca (1):
      dt-bindings: can: rcar_can: document r8a77965 support

Fabrizio Castro (2):
      can: rcar_can: Fix erroneous registration
      dt-bindings: can: rcar_can: Add r8a774a1 support

Ganesh Goudar (1):
      cxgb4: fix thermal zone build error

Jack Morgenstein (1):
      net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command

Jimmy Assarsson (2):
      can: kvaser_usb: Fix potential uninitialized variable use
      can: kvaser_usb: Fix accessing freed memory in kvaser_usb_start_xmit()

Jon Maloy (2):
      tipc: fix lockdep warning when reinitilaizing sockets
      tipc: don't assume linear buffer when reading ancillary data

Lucas Bates (1):
      tc-testing: tdc.py: ignore errors when decoding stdout/stderr

Lukas Wunner (1):
      can: hi311x: Use level-triggered interrupt

Marc Kleine-Budde (5):
      can: flexcan: remove not needed struct flexcan_priv::tx_mb and struct flexcan_priv::tx_mb_idx
      can: dev: can_get_echo_skb(): factor out non sending code to __can_get_echo_skb()
      can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_frame to access frame length
      can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::echo_skb is accessed out of bounds
      can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb

Martin Schiller (2):
      net: phy: mdio-gpio: Fix working over slow can_sleep GPIOs
      net: phy: mdio-gpio: Fix working over slow can_sleep GPIOs

Matthew Cover (1):
      tuntap: fix multiqueue rx

Maxime Chevallier (1):
      net: mvneta: Don't advertise 2.5G modes

Michael Chan (5):
      bnxt_en: Fix RSS context allocation.
      bnxt_en: Fix rx_l4_csum_errors counter on 57500 devices.
      bnxt_en: Disable RDMA support on the 57500 chips.
      bnxt_en: Workaround occasional TX timeout on 57500 A0.
      bnxt_en: Add software "missed_irqs" counter.

Michal Kalderon (1):
      qed: Fix rdma_info structure allocation

Nikolay Aleksandrov (1):
      net: bridge: fix vlan stats use-after-free on destruction

Oleksij Rempel (4):
      can: rx-offload: introduce can_rx_offload_get_echo_skb() and can_rx_offload_queue_sorted() functions
      can: flexcan: handle tx-complete CAN frames via rx-offload infrastructure
      can: rx-offload: rename can_rx_offload_irq_queue_err_skb() to can_rx_offload_queue_tail()
      can: flexcan: use can_rx_offload_queue_sorted() for flexcan_irq_bus_*()

Oliver Hartkopp (1):
      can: raw: check for CAN FD capable netdev in raw_sendmsg()

Pankaj Bansal (1):
      can: flexcan: Unlock the MB unconditionally

Sabrina Dubroca (1):
      ip_tunnel: don't force DF when MTU is locked

Slavomir Kaslev (1):
      socket: do a generic_file_splice_read when proto_ops has no splice_read

Sudarsana Reddy Kalluru (1):
      bnx2x: Assign unique DMAE channel number for FW DMAE transactions.

Sven Eckelmann (2):
      batman-adv: Use explicit tvlv padding for ELP packets
      batman-adv: Expand merged fragment buffer for full packet

Tariq Toukan (1):
      net/mlx4_core: Fix uninitialized variable compilation warning

Thor Thayer (1):
      MAINTAINERS: Replace Vince Bridgers as Altera TSE maintainer

Toke Høiland-Jørgensen (1):
      MAINTAINERS: Add entry for CAKE qdisc

Ursula Braun (1):
      s390/ism: clear dmbe_mask bit before SMC IRQ handling

Vasundhara Volam (1):
      bnxt_en: Fix filling time in bnxt_fill_coredump_record()

Xin Long (2):
      l2tp: fix a sock refcnt leak in l2tp_tunnel_register
      ipv6: fix a dst leak when removing its exception

YueHaibing (2):
      can: ucan: remove set but not used variable 'udev'
      can: ucan: remove duplicated include from ucan.c

 Documentation/devicetree/bindings/net/can/holt_hi311x.txt |   2 +-
 Documentation/devicetree/bindings/net/can/rcar_can.txt    |  28 ++++++++++++++---------
 Documentation/networking/rxrpc.txt                        |  17 +++++++++-----
 MAINTAINERS                                               |   8 ++++++-
 drivers/net/can/dev.c                                     |  48 ++++++++++++++++++++++++++++-----------
 drivers/net/can/flexcan.c                                 | 108 +++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------
 drivers/net/can/rcar/rcar_can.c                           |   5 ++++-
 drivers/net/can/rx-offload.c                              |  51 ++++++++++++++++++++++++++++++++++++++++--
 drivers/net/can/spi/hi311x.c                              |   2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c          |   4 ++--
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c         |  10 ++++-----
 drivers/net/can/usb/ucan.c                                |   7 ------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h               |   7 ++++++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c            |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                 |  70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                 |   4 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c         |   9 +++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c             |   3 +++
 drivers/net/ethernet/chelsio/Kconfig                      |   1 -
 drivers/net/ethernet/chelsio/cxgb4/Makefile               |   4 +---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c           |   4 ++--
 drivers/net/ethernet/lantiq_xrx200.c                      |   5 +++--
 drivers/net/ethernet/marvell/mvneta.c                     |  12 +++-------
 drivers/net/ethernet/mellanox/mlx4/alloc.c                |   2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h                 |   4 ++--
 drivers/net/ethernet/mellanox/mlx4/mr.c                   |   1 +
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c                |  14 ++++++------
 drivers/net/ethernet/qlogic/qed/qed_dev.c                 |  15 +++++++++----
 drivers/net/ethernet/qlogic/qed/qed_int.c                 |   2 ++
 drivers/net/ethernet/qlogic/qed/qed_main.c                |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c                |  50 ++++++++++++++++++++++++-----------------
 drivers/net/ethernet/qlogic/qed/qed_rdma.h                |   5 +++++
 drivers/net/phy/mdio-gpio.c                               |  10 ++++-----
 drivers/net/tun.c                                         |   7 +++++-
 drivers/s390/net/ism_drv.c                                |   2 +-
 fs/afs/rxrpc.c                                            |  11 ++++++++-
 include/linux/can/dev.h                                   |   1 +
 include/linux/can/rx-offload.h                            |   7 +++++-
 include/net/af_rxrpc.h                                    |   3 ++-
 include/trace/events/rxrpc.h                              |   2 ++
 net/batman-adv/bat_v_elp.c                                |   6 +++--
 net/batman-adv/fragmentation.c                            |   2 +-
 net/bridge/br_private.h                                   |   7 ++++++
 net/bridge/br_vlan.c                                      |   3 ++-
 net/can/raw.c                                             |  15 +++++++------
 net/core/dev.c                                            |   4 ++++
 net/ipv4/ip_tunnel_core.c                                 |   2 +-
 net/ipv6/route.c                                          |  14 +++++++-----
 net/l2tp/l2tp_core.c                                      |   9 ++++----
 net/rxrpc/af_rxrpc.c                                      |  27 ++++++++++++++++++----
 net/sched/act_pedit.c                                     |   3 ++-
 net/sched/sch_fq.c                                        |  31 +++++++++++++++----------
 net/socket.c                                              |   2 +-
 net/tipc/discover.c                                       |  19 ++++++++--------
 net/tipc/net.c                                            |  45 ++++++++++++++++++++++++++++++-------
 net/tipc/net.h                                            |   2 +-
 net/tipc/socket.c                                         |  15 +++++++++----
 tools/testing/selftests/tc-testing/tdc.py                 |  18 ++++++++++-----
 58 files changed, 539 insertions(+), 233 deletions(-)

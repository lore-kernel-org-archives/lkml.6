Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F211C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1014B2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfAYT63 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:58:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46230 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfAYT63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:58:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A130A1411E123;
        Fri, 25 Jan 2019 11:58:28 -0800 (PST)
Date:   Fri, 25 Jan 2019 11:58:27 -0800 (PST)
Message-Id: <20190125.115827.1407196401514719611.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 25 Jan 2019 11:58:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Count ttl-dropped frames properly in mac80211, from Bob Copeland.

2) Integer overflow in ktime handling of bcm can code, from Oliver
   Hartkopp.

3) Fix RX desc handling wrt. hw checksumming in ravb, from Simon
   Horman.

4) Various hash key fixes in hv_netvsc, from Haiyang Zhang.

5) Use after free in ax25, from Eric Dumazet.

6) Several fixes to the SSN support in SCTP, from Xin Long.

7) Do not process frames after a NAPI reschedule in ibmveth, from
   Thomas Falcon.

8) Fix NLA_POLICY_NESTED arguments, from Johannes Berg.

Please pull, thanks a lot!

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to 517952756ed3027a9b776e331985320a829b9f62:

  Merge tag 'mac80211-for-davem-2019-01-25' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211 (2019-01-25 10:59:36 -0800)

----------------------------------------------------------------
Adrian Vladu (1):
      hv_netvsc: fix typos in code comments

Andrew Lunn (1):
      net: phy: Fixup GPLv2+ SPDX tags based on license text

Atsushi Nemoto (1):
      net: altera_tse: fix connect_local_phy error path

Aya Levin (1):
      net/mlx4_core: Add masking for a few queries on HCA caps

Balaji Pothunoori (1):
      mac80211: don't initiate TDLS connection if station is not associated to AP

Bob Copeland (1):
      mac80211: fix miscounting of ttl-dropped frames

Chaitanya Tata (2):
      cfg80211: reg: remove warn_on for a normal case
      cfg80211: extend range deviation for DMG

David S. Miller (5):
      Merge branch 'qed-Error-recovery-process'
      Merge branch 'mlx4_core-fixes'
      Merge tag 'linux-can-fixes-for-5.0-20190122' of git://git.kernel.org/.../mkl/linux-can
      Merge tag 'hyperv-fixes-signed' of git://git.kernel.org/.../hyperv/linux
      Merge tag 'mac80211-for-davem-2019-01-25' of git://git.kernel.org/.../jberg/mac80211

Edward Cree (1):
      sfc: suppress duplicate nvmem partition types in efx_ef10_mtd_probe

Eric Dumazet (1):
      ax25: fix possible use-after-free

Haiyang Zhang (3):
      hv_netvsc: Fix ethtool change hash key error
      hv_netvsc: Refactor assignments of struct netvsc_device_info
      hv_netvsc: Fix hash key value reset after other ops

Jack Morgenstein (1):
      net/mlx4_core: Fix error handling when initializing CQ bufs in the driver

Jakub Kicinski (1):
      net/ipv6: don't return positive numbers when nothing was dumped

Johannes Berg (2):
      mac80211_hwsim: check that n_limits makes sense
      nl80211: fix NLA_POLICY_NESTED() arguments

Lorenzo Bianconi (1):
      net: ip_gre: use erspan key field for tunnel lookup

Lubomir Rintel (1):
      net/ipv6: lower the level of "link is not ready" messages

Maciej ¯enczykowski (1):
      net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP

Manfred Schlaegl (1):
      can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb by removing it

Mathieu Malaterre (1):
      mac80211: Add attribute aligned(2) to struct 'action'

Oliver Hartkopp (1):
      can: bcm: check timer values before ktime conversion

Simon Horman (1):
      ravb: expand rx descriptor data to accommodate hw checksum

Stefan Agner (1):
      net: fec: get regulator optional

Sudarsana Reddy Kalluru (1):
      MAINTAINERS: Update cavium networking drivers

Thomas Falcon (1):
      ibmveth: Do not process frames after calling napi_reschedule

Thomas Gleixner (1):
      net: sun: cassini: Cleanup license conflict

Tomer Tayar (3):
      qed: Revise load sequence to avoid PCI errors
      qed: Add infrastructure for error detection and recovery
      qede: Error recovery process

Uwe Kleine-König (1):
      can: flexcan: fix NULL pointer exception during bringup

Wei Yongjun (1):
      virt_wifi: fix error return code in virt_wifi_newlink()

Xin Long (4):
      sctp: improve the events for sctp stream reset
      sctp: improve the events for sctp stream adding
      sctp: set chunk transport correctly when it's a new asoc
      sctp: set flow sport from saddr only when it's 0

Yangbo Lu (1):
      net: dpaa2: improve PTP Kconfig option

YueHaibing (1):
      can: flexcan: fix 'passing zero to ERR_PTR()' warning

Zhang Run (1):
      net: usb: asix: ax88772_bind return error when hw_reset fail

wenxu (1):
      ip_tunnel: Make none-tunnel-dst tunnel port work with lwtunnel

 MAINTAINERS                                    |  42 ++++++-------
 drivers/net/can/dev.c                          |  27 ++++-----
 drivers/net/can/flexcan.c                      |   4 +-
 drivers/net/ethernet/altera/altera_tse_main.c  |   4 +-
 drivers/net/ethernet/freescale/dpaa2/Kconfig   |   5 +-
 drivers/net/ethernet/freescale/fec_main.c      |   2 +-
 drivers/net/ethernet/ibm/ibmveth.c             |   2 -
 drivers/net/ethernet/mellanox/mlx4/cq.c        |   6 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c        |  75 ++++++++++++++---------
 drivers/net/ethernet/qlogic/qed/qed.h          |   5 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c      | 158 ++++++++++++++++++++++++++++-------------------
 drivers/net/ethernet/qlogic/qed/qed_dev_api.h  |  12 ++++
 drivers/net/ethernet/qlogic/qed/qed_hsi.h      |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_hw.c       |  11 ++++
 drivers/net/ethernet/qlogic/qed/qed_int.c      | 126 +++++++++++++++++++-------------------
 drivers/net/ethernet/qlogic/qed/qed_int.h      |   3 +
 drivers/net/ethernet/qlogic/qed/qed_main.c     |  30 +++++++++
 drivers/net/ethernet/qlogic/qed/qed_mcp.c      | 115 +++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_mcp.h      |  42 +++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h |   2 +
 drivers/net/ethernet/qlogic/qed/qed_spq.c      |  22 +++++++
 drivers/net/ethernet/qlogic/qed/qed_sriov.c    |   9 ++-
 drivers/net/ethernet/qlogic/qede/qede.h        |   3 +
 drivers/net/ethernet/qlogic/qede/qede_main.c   | 300 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 drivers/net/ethernet/qlogic/qede/qede_rdma.c   |  64 +++++++++++++------
 drivers/net/ethernet/renesas/ravb_main.c       |  12 ++--
 drivers/net/ethernet/sfc/ef10.c                |  29 ++++++---
 drivers/net/ethernet/sun/cassini.c             |  15 +----
 drivers/net/ethernet/sun/cassini.h             |  15 +----
 drivers/net/hyperv/hyperv_net.h                |  12 ++--
 drivers/net/hyperv/netvsc.c                    |   4 +-
 drivers/net/hyperv/netvsc_drv.c                | 145 ++++++++++++++++++++++++++++----------------
 drivers/net/hyperv/rndis_filter.c              |  36 ++++++++---
 drivers/net/phy/asix.c                         |   8 +--
 drivers/net/phy/mdio-hisi-femac.c              |  16 +----
 drivers/net/phy/rockchip.c                     |   9 +--
 drivers/net/usb/asix_devices.c                 |   9 ++-
 drivers/net/wireless/mac80211_hwsim.c          |   5 ++
 drivers/net/wireless/virt_wifi.c               |   4 +-
 include/linux/if_arp.h                         |   1 +
 include/linux/qed/qed_if.h                     |  20 ++++++
 include/linux/qed/qede_rdma.h                  |  21 +++++--
 include/net/ax25.h                             |  12 ++++
 net/ax25/ax25_ip.c                             |   4 +-
 net/ax25/ax25_route.c                          |  19 +++---
 net/can/bcm.c                                  |  27 +++++++++
 net/ipv4/gre_demux.c                           |  17 ++++++
 net/ipv4/ip_gre.c                              |   9 ---
 net/ipv4/ip_tunnel.c                           |   8 ++-
 net/ipv6/addrconf.c                            |   6 +-
 net/ipv6/ip6_gre.c                             |   4 --
 net/mac80211/cfg.c                             |   4 ++
 net/mac80211/rx.c                              |   6 +-
 net/sctp/ipv6.c                                |   3 +-
 net/sctp/protocol.c                            |   3 +-
 net/sctp/sm_make_chunk.c                       |  11 +++-
 net/sctp/stream.c                              |  58 ++++++++----------
 net/wireless/nl80211.c                         |   2 +-
 net/wireless/reg.c                             |  13 ++--
 59 files changed, 1148 insertions(+), 490 deletions(-)


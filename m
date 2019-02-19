Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3050421736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfBSWd2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:33:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41780 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfBSWd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:33:28 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C2161086DDF2;
        Tue, 19 Feb 2019 14:33:27 -0800 (PST)
Date:   Tue, 19 Feb 2019 14:33:26 -0800 (PST)
Message-Id: <20190219.143326.1810127131443236789.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Feb 2019 14:33:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix suspend and resume in mt76x0u USB driver, from Stanislaw Gruszka.

2) Missing memory barriers in xsk, from Magnus Karlsson.

3) rhashtable fixes in mac80211 from Herbert Xu.

4) 32-bit MIPS eBPF JIT fixes from Paul Burton.

5) Fix for_each_netdev_feature() on big endian, from Hauke Mehrtens.

6) GSO validation fixes from Willem de Bruijn.

7) Endianness fix for dwmac4 timestamp handling, from Alexandre
   Torgue.

8) More strict checks in tcp_v4_err(), from Eric Dumazet.

9) af_alg_release should NULL out the sk after the sock_put(),
   from Mao Wenan.

10) Missing unlock in mac80211 mesh error path, from Wei Yongjun.

11) Missing device put in hns driver, from Salil Mehta.

Please pull, thanks a lot!

The following changes since commit 24f0a48743a256bdec1bcb80708bc309da4aa261:

  Merge tag 'for-linus-20190215' of git://git.kernel.dk/linux-block (2019-02-15 09:12:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 1765f5dcd00963e33f1b8a4e0f34061fbc0e2f7f:

  sky2: Increase D3 delay again (2019-02-19 14:16:41 -0800)

----------------------------------------------------------------
Alexander Duyck (2):
      mm: Use fixed constant in page_frag_alloc instead of size + 1
      net: Do not allocate page fragments that are not skb aligned

Alexandre Torgue (1):
      net: stmmac: handle endianness in dwmac4_get_timestamp

Alexei Starovoitov (1):
      bpf: fix lockdep false positive in stackmap

Alexey Khoroshilov (1):
      net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_probe()

Andrea Claudi (1):
      ipvs: fix warning on unused variable

Beniamino Galvani (1):
      qmi_wwan: apply SET_DTR quirk to Sierra WP7607

Björn Töpel (1):
      xsk: do not remove umem from netdevice on fall-back to copy-mode

Colin Ian King (1):
      net/mlx4_en: fix spelling mistake: "quiting" -> "quitting"

David Chen (1):
      r8152: Add support for MAC address pass through on RTL8153-BD

David S. Miller (9):
      Merge tag 'mac80211-for-davem-2019-02-15' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'net-dsa-b53-VLAN-and-L2-fixes'
      net: Add header for usage of fls64()
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'tcp-fix-possible-crash-in-tcp_v4_err'
      Merge branch 'netdev-page_frag_alloc-fixes'
      Merge branch 'qed-iWARP'
      Merge tag 'wireless-drivers-for-davem-2019-02-18' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge git://git.kernel.org/.../pablo/nf

Davidlohr Bueso (1):
      xsk: share the mmap_sem for page pinning

Eric Dumazet (2):
      tcp: clear icsk_backoff in tcp_write_queue_purge()
      tcp: tcp_v4_err() should be more careful

Florian Fainelli (5):
      net: dsa: b53: Fix default VLAN ID
      net: dsa: b53: Properly account for VLAN filtering
      net: systemport: Fix reception of BPDUs
      net: dsa: bcm_sf2: Do not assume DSA master supports WoL
      net: dsa: b53: Do not program CPU port's PVID

Hauke Mehrtens (1):
      net: Fix for_each_netdev_feature on Big endian

Herbert Xu (2):
      mac80211: Use linked list instead of rhashtable walk for mesh tables
      mac80211: Free mpath object when rhashtable insertion fails

Jason Wang (1):
      vhost: correctly check the return value of translate_desc() in log_used()

Jose Abreu (1):
      net: stmmac: Fix a race in EEE enable callback

Kai-Heng Feng (1):
      sky2: Increase D3 delay again

Lorenzo Bianconi (1):
      net: ip6_gre: initialize erspan_ver just for erspan tunnels

Magnus Karlsson (1):
      xsk: add missing smp_rmb() in xsk_mmap

Mao Wenan (1):
      net: crypto set sk to NULL when af_alg_release.

Martin KaFai Lau (1):
      bpf: Fix narrow load on a bpf_sock returned from sk_lookup()

Michal Kalderon (2):
      qed: Fix iWARP buffer size provided for syn packet processing.
      qed: Fix iWARP syn packet mac address validation.

Murali Karicheri (1):
      net: netcp: Fix ethss driver probe issue

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fix flush after rule deletion in the same batch

Paul Burton (2):
      MIPS: eBPF: Always return sign extended 32b values
      MIPS: eBPF: Remove REG_32BIT_ZERO_EX

Paul Kocialkowski (1):
      net: phy: xgmiitorgmii: Support generic PHY status read

Petr Machata (1):
      mlxsw: __mlxsw_sp_port_headroom_set(): Fix a use of local variable

Petr Vorel (1):
      doc: Mention MSG_ZEROCOPY implementation for UDP

Rakesh Pillai (1):
      mac80211: Restore vif beacon interval if start ap fails

Salil Mehta (1):
      net: hns: Fixes the missing put_device in positive leg for roce reset

Stanislaw Gruszka (1):
      mt76x0u: fix suspend/resume

Wei Yongjun (1):
      mac80211: mesh: fix missing unlock on error in table_path_del()

Willem de Bruijn (2):
      bpf: only adjust gso_size on bytestream protocols
      net: validate untrusted gso packets without csum offload

 Documentation/networking/msg_zerocopy.rst            |   2 +-
 arch/mips/net/ebpf_jit.c                             |  24 +++++++-------
 crypto/af_alg.c                                      |   4 ++-
 drivers/net/dsa/b53/b53_common.c                     |  90 ++++++++++++++++++++++++++++++++++++++++-----------
 drivers/net/dsa/b53/b53_priv.h                       |   3 ++
 drivers/net/dsa/bcm_sf2.c                            |  10 +++---
 drivers/net/ethernet/broadcom/bcmsysport.c           |   4 +++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c   |   3 ++
 drivers/net/ethernet/marvell/mv643xx_eth.c           |   7 +++-
 drivers/net/ethernet/marvell/sky2.c                  |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c       |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c       |  12 ++++---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c          |  21 ++++++++----
 drivers/net/ethernet/qlogic/qed/qed_iwarp.h          |   1 -
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   |   9 ++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c |  22 +++++++------
 drivers/net/ethernet/ti/netcp_core.c                 |   2 +-
 drivers/net/phy/xilinx_gmii2rgmii.c                  |   5 ++-
 drivers/net/usb/qmi_wwan.c                           |   4 +--
 drivers/net/usb/r8152.c                              |   5 +--
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      |  46 ++++++++++++++++----------
 drivers/vhost/vhost.c                                |   2 +-
 include/linux/netdev_features.h                      |  24 ++++++++++++--
 include/linux/skbuff.h                               |   8 ++++-
 include/linux/virtio_net.h                           |   9 ++++++
 kernel/bpf/stackmap.c                                |   8 ++++-
 kernel/bpf/verifier.c                                |  11 ++++---
 mm/page_alloc.c                                      |   8 ++---
 net/core/dev.c                                       |   4 +--
 net/core/filter.c                                    |  12 +++----
 net/core/skbuff.c                                    |   4 +++
 net/ipv4/tcp.c                                       |   2 +-
 net/ipv4/tcp_ipv4.c                                  |   5 ++-
 net/ipv6/ip6_gre.c                                   |  34 ++++++++++++--------
 net/mac80211/cfg.c                                   |   6 +++-
 net/mac80211/mesh.h                                  |   6 ++++
 net/mac80211/mesh_pathtbl.c                          | 157 +++++++++++++++++++++++++++--------------------------------------------------------------
 net/netfilter/ipvs/ip_vs_ctl.c                       |   3 +-
 net/netfilter/nf_tables_api.c                        |   3 ++
 net/xdp/xdp_umem.c                                   |  11 ++++---
 net/xdp/xsk.c                                        |   4 +++
 41 files changed, 355 insertions(+), 244 deletions(-)

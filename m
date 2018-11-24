Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CADC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 06:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46922082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 06:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46922082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeKXRqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 12:46:20 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43360 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeKXRqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 12:46:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E2FB14EAF1E8;
        Fri, 23 Nov 2018 22:58:58 -0800 (PST)
Date:   Fri, 23 Nov 2018 22:58:55 -0800 (PST)
Message-Id: <20181123.225855.1255285872548250801.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Nov 2018 22:58:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Need to take mutex in ath9k_add_interface(), from Dan Carpenter.

2) Fix mt76 build without CONFIG_LEDS_CLASS, from Arnd Bergmann.

3) Fix socket wmem accounting in SCTP, from Xin Long.

4) Fix failed resume crash in ena driver, from Arthur Kiyanovski.

5) qed driver passes bytes instead of bits into second arg
   of bitmap_weight().  From Denis Bolotin.

6) Fix reset deadlock in ibmvnic, from Juliet Kim.

7) skb_scrube_packet() needs to scrub the fwd marks too,
   from Petr Machata.

8) Make sure older TCP stacks see enough dup ACKs, and
   avoid doing SACK compression during this period, from
   Eric Dumazet.

9) Add atomicity to SMC protocol cursor handling, from Ursula Braun.

10) Don't leave dangling error pointer if bpf_prog_add() fails in
    thunderx driver, from Lorenzo Bianconi.  Also, when we unmap
    TSO headers, set sq->tso_hdrs to NULL.

11) Fix race condition over state variables in act_police, from
    Davide Caratti.

12) Disable guest csum in the presence of XDP in virtio_net, from
    Jason Wang.

Please pull, thanks a lot!

The following changes since commit f2ce1065e767fc7da106a5f5381d1e8f842dc6f4:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-11-19 09:24:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 07093b76476903f820d83d56c3040e656fb4d9e3:

  net: gemini: Fix copy/paste error (2018-11-23 22:35:38 -0800)

----------------------------------------------------------------
Andreas Fiedler (1):
      net: gemini: Fix copy/paste error

Arnd Bergmann (1):
      mt76: fix building without CONFIG_LEDS_CLASS

Arthur Kiyanovski (3):
      net: ena: fix crash during failed resume from hibernation
      net: ena: fix crash during ena_remove()
      net: ena: update driver version from 2.0.1 to 2.0.2

Brian Norris (1):
      ath10k: don't assume 'vif' is non-NULL in flush()

Dan Carpenter (1):
      ath9k: Fix a locking bug in ath9k_add_interface()

David S. Miller (6):
      Merge branch 'ena-hibernation-and-rmmod-bug-fixes'
      Merge branch 'qed-Fix-Queue-Manager-getters'
      Merge tag 'mlx5-fixes-2018-11-19' of git://git.kernel.org/.../saeed/linux
      Merge tag 'wireless-drivers-for-davem-2018-11-20' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge branch 'smc-fixes'
      Merge branch 'ibmvnic-Fix-queue-and-buffer-accounting-errors'

Davide Caratti (2):
      net/sched: act_police: fix race condition on state variables
      net/sched: act_police: add missing spinlock initialization

Denis Bolotin (2):
      qed: Fix bitmap_weight() check
      qed: Fix QM getters to always return a valid pq

Denis Drozdov (1):
      net/mlx5e: IPoIB, Reset QP after channels are closed

Emmanuel Grumbach (2):
      iwlwifi: mvm: support sta_statistics() even on older firmware
      iwlwifi: mvm: fix regulatory domain update when the firmware starts

Eric Dumazet (1):
      tcp: defer SACK compression after DupThresh

Fabio Estevam (1):
      dt-bindings: dsa: Fix typo in "probed"

Hangbin Liu (2):
      net/ipv6: re-do dad when interface has IFF_NOARP flag change
      team: no need to do team_notify_peers or team_mcast_rejoin when disabling port

Hans Wippel (2):
      net/smc: abort CLC connection in smc_release
      net/smc: add SMC-D shutdown signal

Heiner Kallweit (2):
      MAINTAINERS: Add myself as third phylib maintainer
      MAINTAINERS: add myself as co-maintainer for r8169

Jason Wang (2):
      virtio-net: disable guest csum during XDP set
      virtio-net: fail XDP set if guest csum is negotiated

John Stultz (1):
      wlcore: Fixup "Add support for optional wakeirq"

Juliet Kim (1):
      net/ibmnvic: Fix deadlock problem in reset

Kalle Valo (1):
      Merge tag 'iwlwifi-for-kalle-2018-11-15' of git://git.kernel.org/.../iwlwifi/iwlwifi-next

Karsten Graul (1):
      net/smc: use queue pair number when matching link group

Lorenzo Bianconi (3):
      mt76: fix uninitialized mutex access setting rts threshold
      net: thunderx: set xdp_prog to NULL if bpf_prog_add fails
      net: thunderx: set tso_hdrs pointer to NULL in nicvf_free_snd_queue

Luca Coelho (1):
      iwlwifi: mvm: don't use SAR Geo if basic SAR is not used

Matt Chen (1):
      iwlwifi: fix wrong WGDS_WIFI_DATA_SIZE

Moshe Shemesh (1):
      net/mlx5e: RX, verify received packet size in Linear Striding RQ

Or Gerlitz (3):
      net/mlx5e: Don't match on vlan non-existence if ethertype is wildcarded
      net/mlx5e: Claim TC hw offloads support only under a proper build config
      net/mlx5e: Always use the match level enum when parsing TC rule match

Paolo Abeni (1):
      net: don't keep lonely packets forever in the gro hash

Petr Machata (1):
      net: skb_scrub_packet(): Scrub offload_fwd_mark

Quentin Schulz (1):
      net: phy: mscc: fix deadlock in vsc85xx_default_config

Raed Salem (1):
      net/mlx5: IPSec, Fix the SA context hash key

Rafa©© Mi©©ecki (2):
      brcmutil: really fix decoding channel info for 160 MHz bandwidth
      brcmfmac: fix reporting support for 160 MHz channels

Roi Dayan (1):
      net/mlx5e: Apply the correct check for supporting TC esw rules split

Shahar S Matityahu (1):
      iwlwifi: fix D3 debug data buffer memory leak

Shay Agroskin (4):
      net/mlx5e: Fix a bug in turning off FEC policy in unsupported speeds
      net/mlx5e: Fix wrong field name in FEC related functions
      net/mlx5e: Removed unnecessary warnings in FEC caps query
      net/mlx5e: Fix failing ethtool query on FEC query error

Siva Reddy Kallam (1):
      tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control paths

Stephen Mallon (1):
      tcp: Fix SOF_TIMESTAMPING_RX_HARDWARE to use the latest timestamp during TCP coalescing

Tal Gilboa (1):
      net/dim: Update DIM start sample after each DIM iteration

Thomas Falcon (2):
      ibmvnic: Fix RX queue buffer cleanup
      ibmvnic: Update driver queues after change in ring size support

Ursula Braun (2):
      net/smc: atomic SMCD cursor handling
      net/smc: use after free fix in smc_wr_tx_put_slot()

Valentine Fatiev (1):
      net/mlx5e: Fix selftest for small MTUs

Vincent Chen (1):
      net: faraday: ftmac100: remove netif_running(netdev) check before disabling interrupts

Willem de Bruijn (1):
      packet: copy user buffers before orphan or clone

Xin Long (4):
      sctp: count sk_wmem_alloc by skb truesize in sctp_packet_transmit
      sctp: not allow to set asoc prsctp_enable by sockopt
      Revert "sctp: remove sctp_transport_pmtu_check"
      sctp: not increase stream's incnt before sending addstrm_in request

Yangtao Li (1):
      net: amd: add missing of_node_put()

Yuval Avnery (1):
      net/mlx5e: Adjust to max number of channles when re-attaching

 Documentation/devicetree/bindings/net/dsa/dsa.txt           |  2 +-
 MAINTAINERS                                                 |  2 ++
 drivers/net/ethernet/amazon/ena/ena_netdev.c                | 23 +++++++++++------------
 drivers/net/ethernet/amazon/ena/ena_netdev.h                |  2 +-
 drivers/net/ethernet/amd/sunlance.c                         |  4 +++-
 drivers/net/ethernet/broadcom/tg3.c                         | 18 ++++++++++++++++--
 drivers/net/ethernet/cavium/thunder/nicvf_main.c            |  9 +++++++--
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c          |  4 +++-
 drivers/net/ethernet/cortina/gemini.c                       |  2 +-
 drivers/net/ethernet/faraday/ftmac100.c                     |  7 +++----
 drivers/net/ethernet/ibm/ibmvnic.c                          | 72 +++++++++++++++++++++++++++++++-----------------------------------------
 drivers/net/ethernet/ibm/ibmvnic.h                          |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h                |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c           | 36 +++++++++++++++---------------------
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c    |  4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c        |  3 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c           | 37 +++++++++++++++++++++++++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c             |  6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c       | 26 ++++++++++----------------
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c          |  3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h          |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c             | 69 +++++++++++++++++++++++++++++++++++----------------------------------
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c        | 10 ++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c       |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c                   | 29 ++++++++++++++++++++++++-----
 drivers/net/phy/mscc.c                                      | 14 +++++---------
 drivers/net/team/team.c                                     |  2 --
 drivers/net/virtio_net.c                                    | 13 +++++--------
 drivers/net/wireless/ath/ath10k/mac.c                       |  2 +-
 drivers/net/wireless/ath/ath9k/main.c                       |  3 +--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |  3 ++-
 drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c      |  3 +++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h                |  4 +++-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h             |  6 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                 | 38 +++++++++++++++++++++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c           | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c                |  5 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                |  2 ++
 drivers/net/wireless/mediatek/mt76/Kconfig                  |  6 ++++++
 drivers/net/wireless/mediatek/mt76/mac80211.c               |  8 +++++---
 drivers/net/wireless/mediatek/mt76/mt76x02.h                |  1 -
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c        |  6 ++++--
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c        |  4 ++--
 drivers/net/wireless/ti/wlcore/sdio.c                       | 17 +++++++++++------
 include/linux/net_dim.h                                     |  2 ++
 include/linux/skbuff.h                                      | 18 +++++++++++++++++-
 include/linux/tcp.h                                         |  1 +
 include/net/sctp/sctp.h                                     | 12 ++++++++++++
 net/core/dev.c                                              |  7 +++++--
 net/core/skbuff.c                                           |  5 +++++
 net/ipv4/tcp_input.c                                        | 15 +++++++++++++--
 net/ipv4/tcp_output.c                                       |  6 +++---
 net/ipv4/tcp_timer.c                                        |  2 +-
 net/ipv6/addrconf.c                                         | 19 +++++++++++++------
 net/packet/af_packet.c                                      |  4 ++--
 net/sched/act_police.c                                      | 36 ++++++++++++++++++++++--------------
 net/sctp/output.c                                           | 24 ++++--------------------
 net/sctp/socket.c                                           | 26 +++++---------------------
 net/sctp/stream.c                                           |  1 -
 net/smc/af_smc.c                                            | 11 +++++++----
 net/smc/smc_cdc.c                                           | 26 +++++++++++++++-----------
 net/smc/smc_cdc.h                                           | 60 +++++++++++++++++++++++++++++++++++++++++++++---------------
 net/smc/smc_core.c                                          | 20 ++++++++++++++------
 net/smc/smc_core.h                                          |  5 +++--
 net/smc/smc_ism.c                                           | 43 ++++++++++++++++++++++++++++++++-----------
 net/smc/smc_ism.h                                           |  1 +
 net/smc/smc_wr.c                                            |  4 +++-
 67 files changed, 537 insertions(+), 335 deletions(-)

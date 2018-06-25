Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A35BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109F12553B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109F12553B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeFYHqB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:46:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54234 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeFYHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:46:00 -0400
Received: from localhost (unknown [211.231.11.194])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2336B136D8226;
        Mon, 25 Jun 2018 00:45:58 -0700 (PDT)
Date:   Mon, 25 Jun 2018 16:45:57 +0900 (KST)
Message-Id: <20180625.164557.200926270412915979.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Jun 2018 00:46:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix netpoll OOPS in r8169, from Ville Syrjälä.

2) Fix bpf instruction alignment on powerpc et al., from
   Eric Dumazet.

3) Don't ignore IFLA_MTU attribute when creating new ipvlan
   links.  From Xin Long.

4) Fix use after free in AF_PACKET, from Eric Dumazet.

5) Mis-matched RTNL unlock in xen-netfront, from Ross
   Lagerwall.

6) Fix VSOCK loopback on big-endian, from Claudio Imbrenda.

7) Missing RX buffer offset correction when computing DMA
   addresses in mvneta driver, from Antoine Tenart.

8) Fix crashes in DCCP's ccid3_hc_rx_send_feedback, from Eric
   Dumazet.

Please pull, thanks a lot!

The following changes since commit 1abd8a8f39cd9a2925149000056494523c85643a:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2018-06-21 07:22:30 +0900)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 829eb05365ff06e8adc23f2541597d0cc3c18348:

  sfc: make function efx_rps_hash_bucket static (2018-06-24 23:08:25 +0900)

----------------------------------------------------------------
Aleksander Morgado (1):
      qmi_wwan: add support for the Dell Wireless 5821e module

Anders Roxell (2):
      selftests: net: add config fragments
      selftests: net: add tcp_inq to gitignore

Antoine Tenart (3):
      net: mscc: fix the injection header
      net: mvneta: fix the Rx desc DMA address in the Rx path
      net: mscc: make sparse happy

Bartosz Golaszewski (1):
      net: davinci_emac: match the mdio device against its compatible if possible

Claudio Imbrenda (1):
      VSOCK: fix loopback on big-endian systems

Colin Ian King (2):
      net: ethernet: ti: davinci_cpdma: make function cpdma_desc_pool_create static
      sfc: make function efx_rps_hash_bucket static

Cong Wang (1):
      net_sched: remove a bogus warning in hfsc

David S. Miller (2):
      Merge branch 'xen-netfront-fixes'
      Merge branch 'dccp-fixes-around-rx_tstamp_last_feedback'

Eric Dumazet (4):
      bpf: enforce correct alignment for instructions
      net/packet: fix use-after-free
      net: dccp: avoid crash in ccid3_hc_rx_send_feedback()
      net: dccp: switch rx_tstamp_last_feedback to monotonic clock

Ganesh Goudar (1):
      cxgb4: when disabling dcb set txq dcb priority to 0

Geert Uytterhoeven (2):
      MAINTAINERS: Add file patterns for dsa device tree bindings
      net: Remove depends on HAS_DMA in case of platform dependency

Hangbin Liu (1):
      ipv6: mcast: fix unsolicited report interval after receiving querys

Harini Katakam (1):
      net: macb: Fix ptp time adjustment for large negative delta

Jason Wang (1):
      vhost_net: validate sock before trying to put its fd

Marcelo Ricardo Leitner (1):
      sctp: fix erroneous inc of snmp SctpFragUsrMsgs

Matteo Croce (1):
      bpfilter: fix user mode helper cross compilation

Paolo Abeni (1):
      cls_flower: fix use after free in flower S/W path

Ross Lagerwall (2):
      xen-netfront: Fix mismatched rtnl_unlock
      xen-netfront: Update features after registering netdev

Tobin C. Harding (4):
      Documentation: e100: Use correct heading adornment
      Documentation: e1000: Use correct heading adornment
      Documentation: e100: Fix docs build error
      Documentation: e1000: Fix docs build error

Vakul Garg (2):
      strparser: Don't schedule in workqueue in paused state
      strparser: Corrected typo in documentation.

Ville Syrjälä (1):
      r8169: Fix netpoll oops

Xin Long (1):
      ipvlan: fix IFLA_MTU ignored on NEWLINK

 Documentation/networking/e100.rst               | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
 Documentation/networking/e1000.rst              |  76 +++++++++++++++++++++++++++++++++---------------------------------
 Documentation/networking/strparser.txt          |   2 +-
 MAINTAINERS                                     |   1 +
 drivers/net/ethernet/amd/Kconfig                |   2 +-
 drivers/net/ethernet/apm/xgene-v2/Kconfig       |   1 -
 drivers/net/ethernet/apm/xgene/Kconfig          |   1 -
 drivers/net/ethernet/arc/Kconfig                |   6 ++++--
 drivers/net/ethernet/broadcom/Kconfig           |   2 --
 drivers/net/ethernet/cadence/macb_ptp.c         |   5 +----
 drivers/net/ethernet/calxeda/Kconfig            |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |   2 +-
 drivers/net/ethernet/hisilicon/Kconfig          |   2 +-
 drivers/net/ethernet/marvell/Kconfig            |   8 +++----
 drivers/net/ethernet/marvell/mvneta.c           |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/Kconfig     |   2 +-
 drivers/net/ethernet/mscc/ocelot.c              |  11 +++++-----
 drivers/net/ethernet/realtek/r8169.c            |   2 +-
 drivers/net/ethernet/renesas/Kconfig            |   2 --
 drivers/net/ethernet/sfc/efx.c                  |   1 +
 drivers/net/ethernet/ti/davinci_cpdma.c         |   2 +-
 drivers/net/ethernet/ti/davinci_emac.c          |   4 ++++
 drivers/net/ipvlan/ipvlan_main.c                |   3 ++-
 drivers/net/usb/qmi_wwan.c                      |   1 +
 drivers/net/wireless/broadcom/brcm80211/Kconfig |   1 -
 drivers/net/wireless/quantenna/qtnfmac/Kconfig  |   2 +-
 drivers/net/xen-netfront.c                      |  11 +++++-----
 drivers/vhost/net.c                             |   3 ++-
 include/linux/filter.h                          |   4 +++-
 net/bpfilter/Makefile                           |   2 +-
 net/dccp/ccids/ccid3.c                          |  16 +++++++-------
 net/ipv6/mcast.c                                |   9 +++++---
 net/packet/af_packet.c                          |  16 +++++++-------
 net/sched/cls_flower.c                          |  21 +++++++++++++++----
 net/sched/sch_hfsc.c                            |   4 ++--
 net/sctp/chunk.c                                |   4 +++-
 net/strparser/strparser.c                       |   5 +----
 net/vmw_vsock/virtio_transport.c                |   2 +-
 tools/testing/selftests/net/.gitignore          |   1 +
 tools/testing/selftests/net/config              |   2 ++
 40 files changed, 190 insertions(+), 165 deletions(-)

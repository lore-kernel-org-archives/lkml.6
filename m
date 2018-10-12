Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C60BC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0350D2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0350D2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJLJgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 05:36:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37954 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJLJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 05:36:20 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 08BB312DE581E;
        Thu, 11 Oct 2018 19:06:17 -0700 (PDT)
Date:   Thu, 11 Oct 2018 19:06:15 -0700 (PDT)
Message-Id: <20181011.190615.78309421924776793.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Oct 2018 19:06:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) RXRPC receive path fixes from David Howells.

2) Re-export __skb_recv_udp(), from Jiri Kosina.

3) Fix refcounting in u32 classificer, from Al Viro.

4) Userspace netlink ABI fixes from Eugene Syromiatnikov.

5) Don't double iounmap on rmmod in ena driver, from Arthur
   Kiyanovski.

6) Fix devlink string attribute handling, we must pull a copy
   into a kernel buffer if the lifetime extends past the netlink
   request.  From Moshe Shemesh.

7) Fix hangs in RDS, from Ka-Cheong Poon.

8) Fix recursive locking lockdep warnings in tipc, from Ying Xue.

9) Clear RX irq correctly in socionext, from Ilias Apalodimas.

10) bcm_sf2 fixes from Florian Fainelli.

Please pull, thanks a lot!

The following changes since commit c1d84a1b42ef70d8ae601df9cadedc7ed4f1beb1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-10-06 02:11:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 6b9bab550cac108d86c731c207e3e74ea10eb638:

  Merge branch 'net-dsa-bcm_sf2-Couple-of-fixes' (2018-10-11 15:20:00 -0700)

----------------------------------------------------------------
Al Viro (1):
      net: sched: cls_u32: fix hnode refcounting

Arthur Kiyanovski (4):
      net: ena: fix warning in rmmod caused by double iounmap
      net: ena: fix rare bug when failed restart/resume is followed by driver removal
      net: ena: fix NULL dereference due to untimely napi initialization
      net: ena: fix auto casting to boolean

David Howells (10):
      rxrpc: Fix some missed refs to init_net
      rxrpc: Fix the data_ready handler
      rxrpc: Use the UDP encap_rcv hook
      rxrpc: Don't need to take the RCU read lock in the packet receiver
      rxrpc: Don't check RXRPC_CALL_TX_LAST after calling rxrpc_rotate_tx_window()
      rxrpc: Carry call state out of locked section in rxrpc_rotate_tx_window()
      rxrpc: Only take the rwind and mtu values from latest ACK
      rxrpc: Fix connection-level abort handling
      rxrpc: Fix the rxrpc_tx_packet trace line
      rxrpc: Fix the packet reception routine

David S. Miller (7):
      Merge branch 'net-smc-userspace-breakage-fixes'
      Merge branch 'ena-fixes'
      Merge branch 'devlink-param-type-string-fixes'
      Merge tag 'rxrpc-fixes-20181008' of git://git.kernel.org/.../dhowells/linux-fs
      Merge branch 'net-ipv4-fixes-for-PMTU-when-link-MTU-changes'
      Merge branch 'net-explicitly-requires-bash-when-needed'
      Merge branch 'net-dsa-bcm_sf2-Couple-of-fixes'

Eric Dumazet (1):
      net: make skb_partial_csum_set() more robust against overflows

Eugene Syromiatnikov (2):
      net/smc: use __aligned_u64 for 64-bit smc_diag fields
      net/smc: retain old name for diag_mode field

Florian Fainelli (2):
      net: dsa: bcm_sf2: Fix unbind ordering
      net: dsa: bcm_sf2: Call setup during switch resume

Giacinto Cifelli (1):
      qmi_wwan: Added support for Gemalto's Cinterion ALASxx WWAN interface

Ilias Apalodimas (1):
      net: socionext: clear rx irq correctly

Jiri Kosina (1):
      udp: Unbreak modules that rely on external __skb_recv_udp() availability

Jon Maloy (1):
      tipc: set link tolerance correctly in broadcast link

Ka-Cheong Poon (1):
      rds: RDS (tcp) hangs on sendto() to unresponding address

Maciej S. Szmigiero (1):
      r8169: set RX_MULTI_EN bit in RxConfig for 8168F-family chips

Mike Rapoport (1):
      net/ipv6: stop leaking percpu memory in fib6 info

Moshe Shemesh (4):
      devlink: Fix param set handling for string type
      devlink: Fix param cmode driverinit for string type
      devlink: Add helper function for safely copy string param
      net/mlx4_core: Fix warnings during boot on driverinit param set failures

Paolo Abeni (2):
      selftests: rtnetlink.sh explicitly requires bash.
      selftests: udpgso_bench.sh explicitly requires bash

Parthasarathy Bhuvaragan (1):
      tipc: queue socket protocol error messages into socket receive buffer

Sabrina Dubroca (2):
      net: ipv4: update fnhe_pmtu when first hop's MTU changes
      net: ipv4: don't let PMTU updates increase route MTU

Sebastian Andrzej Siewior (1):
      net: phy: sfp: remove sfp_mutex's definition

Ying Xue (1):
      tipc: eliminate possible recursive locking detected by LOCKDEP

 drivers/net/dsa/bcm_sf2.c                     |  14 ++-----
 drivers/net/ethernet/amazon/ena/ena_eth_com.c |   8 ++--
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  22 +++++-----
 drivers/net/ethernet/mellanox/mlx4/main.c     |  43 +++++++------------
 drivers/net/ethernet/realtek/r8169.c          |   4 +-
 drivers/net/ethernet/socionext/netsec.c       |   5 ++-
 drivers/net/phy/sfp.c                         |   2 -
 drivers/net/usb/qmi_wwan.c                    |   1 +
 include/linux/netdevice.h                     |   7 ++++
 include/net/devlink.h                         |  12 +++++-
 include/net/ip_fib.h                          |   1 +
 include/trace/events/rxrpc.h                  |   1 +
 include/uapi/linux/smc_diag.h                 |  25 ++++++-----
 include/uapi/linux/udp.h                      |   1 +
 net/core/dev.c                                |  28 ++++++++++++-
 net/core/devlink.c                            |  43 ++++++++++++++++---
 net/core/skbuff.c                             |  12 +++---
 net/ipv4/fib_frontend.c                       |  12 ++++--
 net/ipv4/fib_semantics.c                      |  50 ++++++++++++++++++++++
 net/ipv4/route.c                              |   7 ++--
 net/ipv4/udp.c                                |   2 +-
 net/ipv6/ip6_fib.c                            |   2 +
 net/rds/send.c                                |  13 ++++--
 net/rxrpc/ar-internal.h                       |  23 +++++-----
 net/rxrpc/call_accept.c                       |  27 ++++++++----
 net/rxrpc/call_object.c                       |   5 ++-
 net/rxrpc/conn_client.c                       |  10 +++--
 net/rxrpc/conn_event.c                        |  26 +++++++-----
 net/rxrpc/input.c                             | 253 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------
 net/rxrpc/local_object.c                      |  30 ++++++++++---
 net/rxrpc/peer_event.c                        |   5 +++
 net/rxrpc/peer_object.c                       |  29 ++++++++-----
 net/sched/cls_u32.c                           |  10 ++---
 net/tipc/link.c                               |  27 ++++++++----
 net/tipc/socket.c                             |  14 ++++++-
 tools/testing/selftests/net/rtnetlink.sh      |   2 +-
 tools/testing/selftests/net/udpgso_bench.sh   |   2 +-
 37 files changed, 493 insertions(+), 285 deletions(-)

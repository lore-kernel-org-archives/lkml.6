Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B335C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150BC20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150BC20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeFTMf5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:35:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33086 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFTMfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:35:55 -0400
Received: from localhost (unknown [61.102.160.122])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B58BE14690197;
        Wed, 20 Jun 2018 05:35:51 -0700 (PDT)
Date:   Wed, 20 Jun 2018 21:35:40 +0900 (KST)
Message-Id: <20180620.213540.214945910722071226.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Jun 2018 05:35:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix crash on bpf_prog_load() errors, from Daniel Borkmann.

2) Fix ATM VCC memory accounting, from David Woodhouse.

3) fib6_info objects need RCU freeing, from Eric Dumazet.

4) Fix SO_BINDTODEVICE handling for TCP sockets, from David Ahern.

5) Fix clobbered error code in enic_open() failure path, from
   Govindarajulu Varadarajan.

6) Propagate dev_get_valid_name() error returns properly, from
   Li RongQing.

7) Fix suspend/resume in davinci_emac driver, from Bartosz
   Golaszewski.

8) Various act_ife fixes (recursive locking, IDR leaks, etc.)
   from Davide Caratti.

9) Fix buggy checksum handling in sungem driver, from Eric
   Dumazet.

Please pull, thanks a lot!

The following changes since commit 35773c93817c5f2df264d013978e7551056a063a:

  Merge branch 'afs-proc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2018-06-16 16:32:04 +0900)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 9887cba19978a5f288100ef90a37684cc8d5e0a6:

  ip: limit use of gso_size to udp (2018-06-20 14:41:04 +0900)

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'bpf-fixes'

Anders Roxell (1):
      selftests: bpf: config: add config fragments

Arnd Bergmann (1):
      ptp: replace getnstimeofday64() with ktime_get_real_ts64()

Bartosz Golaszewski (1):
      net: ethernet: fix suspend/resume in davinci_emac

Bhadram Varka (1):
      stmmac: fix DMA channel hang in half-duplex mode

Björn Töpel (1):
      xsk: re-add queue id check for XDP_SKB path

Daniel Borkmann (4):
      Merge branch 'bpf-misc-fixes'
      bpf: fix panic in prog load calls cleanup
      bpf: reject any prog that failed read-only lock
      bpf, xdp, i40e: fix i40e_build_skb skb reserve and truesize

Daniel Lezcano (1):
      net/usb/drivers: Remove useless hrtimer_active check

David Ahern (1):
      net/tcp: Fix socket lookups with SO_BINDTODEVICE

David S. Miller (4):
      Merge git://git.kernel.org/.../bpf/bpf
      bluetooth: hci_nokia: Don't include linux/unaligned/le_struct.h directly.
      Merge branch 'qed-fixes'
      Merge branch 'NCSI-silence-warning-messages'

David Woodhouse (1):
      atm: Preserve value of skb->truesize when accounting to vcc

Davide Caratti (2):
      net/sched: act_ife: fix recursive lock and idr leak
      net/sched: act_ife: preserve the action control in case of error

Dinh Nguyen (1):
      net: stmmac: socfpga: add additional ocp reset line for Stratix10

Eric Dumazet (2):
      net/ipv6: respect rcu grace period before freeing fib6_info
      net: sungem: fix rx checksum support

Govindarajulu Varadarajan (2):
      enic: initialize enic->rfs_h.lock in enic_probe
      enic: do not overwrite error code

Jakub Kicinski (2):
      tools: bpftool: improve accuracy of load time
      selftests/bpf: test offloads even with BPF programs present

Jian Wang (1):
      bpf, selftest: check tunnel type more accurately

Joel Stanley (4):
      net/ncsi: Silence debug messages
      net/ncsi: Drop no more channels message
      net/ncsi: Use netdev_dbg for debug messages
      MAINTAINERS: Add Sam as the maintainer for NCSI

Konstantin Khlebnikov (1):
      net_sched: blackhole: tell upper qdisc about dropped packets

Li RongQing (1):
      net: propagate dev_get_valid_name return code

Liran Alon (1):
      net: net_failover: fix typo in net_failover_slave_register()

Matteo Croce (2):
      bpfilter: fix build error
      bpfilter: ignore binary files

Stefan Agner (1):
      net: hamradio: use eth_broadcast_addr

Sudarsana Reddy Kalluru (3):
      qed: Fix possible memory leak in Rx error path handling.
      qed: Add sanity check for SIMD fastpath handler.
      qed: Do not advertise DCBX_LLD_MANAGED capability.

Toshiaki Makita (1):
      xdp: Fix handling of devmap in generic XDP

Willem de Bruijn (1):
      ip: limit use of gso_size to udp

William Tu (1):
      bpf, selftests: delete xfrm tunnel when test exits.

Xin Long (1):
      ipvlan: use ETH_MAX_MTU as max mtu

Yonghong Song (1):
      tools/bpftool: fix a bug in bpftool perf

 MAINTAINERS                                         |  5 +++++
 drivers/bluetooth/hci_nokia.c                       |  2 +-
 drivers/net/ethernet/cisco/enic/enic_clsf.c         |  3 +--
 drivers/net/ethernet/cisco/enic/enic_main.c         | 12 ++++++------
 drivers/net/ethernet/faraday/ftgmac100.c            |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c         |  7 +++----
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c          | 11 ++++-------
 drivers/net/ethernet/qlogic/qed/qed_ll2.c           | 11 +++++++++--
 drivers/net/ethernet/qlogic/qed/qed_main.c          | 12 ++++++++++--
 drivers/net/ethernet/stmicro/stmmac/Kconfig         |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 18 ++++++++++++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 10 ++++++++++
 drivers/net/ethernet/sun/sungem.c                   | 22 ++++++++++++----------
 drivers/net/ethernet/ti/davinci_emac.c              | 15 +++++++++++++--
 drivers/net/hamradio/bpqether.c                     |  8 ++------
 drivers/net/ipvlan/ipvlan_main.c                    |  1 +
 drivers/net/net_failover.c                          |  2 +-
 drivers/net/usb/cdc_ncm.c                           |  3 +--
 drivers/ptp/ptp_chardev.c                           |  4 ++--
 drivers/ptp/ptp_qoriq.c                             |  2 +-
 include/linux/atmdev.h                              | 15 +++++++++++++++
 include/linux/bpf.h                                 | 12 ++++++++++++
 include/linux/filter.h                              | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 include/net/ip6_fib.h                               |  5 +++--
 kernel/bpf/core.c                                   | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 kernel/bpf/devmap.c                                 | 14 ++++++++++++++
 kernel/bpf/syscall.c                                | 12 +++---------
 net/atm/br2684.c                                    |  3 +--
 net/atm/clip.c                                      |  3 +--
 net/atm/common.c                                    |  3 +--
 net/atm/lec.c                                       |  3 +--
 net/atm/mpc.c                                       |  3 +--
 net/atm/pppoatm.c                                   |  3 +--
 net/atm/raw.c                                       |  4 ++--
 net/bpfilter/.gitignore                             |  1 +
 net/bpfilter/Makefile                               |  6 ++++--
 net/core/dev.c                                      |  4 ++--
 net/core/filter.c                                   | 21 ++++-----------------
 net/ipv4/inet_hashtables.c                          |  4 ++--
 net/ipv4/ip_output.c                                |  3 ++-
 net/ipv6/inet6_hashtables.c                         |  4 ++--
 net/ipv6/ip6_fib.c                                  |  5 +++--
 net/ipv6/ip6_output.c                               |  3 ++-
 net/ncsi/ncsi-aen.c                                 | 10 +++++-----
 net/ncsi/ncsi-manage.c                              | 49 ++++++++++++++++++++++---------------------------
 net/sched/act_ife.c                                 | 12 +++++-------
 net/sched/sch_blackhole.c                           |  2 +-
 net/xdp/xsk.c                                       |  3 +++
 tools/bpf/bpftool/perf.c                            |  5 +++--
 tools/bpf/bpftool/prog.c                            |  4 +++-
 tools/testing/selftests/bpf/config                  | 10 ++++++++++
 tools/testing/selftests/bpf/test_offload.py         | 12 ++++++++++--
 tools/testing/selftests/bpf/test_tunnel.sh          | 26 ++++++++++++++------------
 53 files changed, 371 insertions(+), 195 deletions(-)
 create mode 100644 net/bpfilter/.gitignore

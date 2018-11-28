Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF33C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E07206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E07206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbeK2HaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:30:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38022 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbeK2HaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:30:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1603B14E05BF6;
        Wed, 28 Nov 2018 12:27:11 -0800 (PST)
Date:   Wed, 28 Nov 2018 12:27:08 -0800 (PST)
Message-Id: <20181128.122708.2022033340862777357.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Nov 2018 12:27:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) ARM64 JIT fixes for subprog handling from Daniel Borkmann.

2) Various sparc64 JIT bug fixes (fused branch convergance, frame
   pointer usage detection logic, PSEODU call argument handling).

3) Fix to use BH locking in nf_conncount, from Taehee Yoo.

4) Fix race of TX skb freeing in ipheth driver, from Bernd Eckstein.

5) Handle return value of TX NAPI completion properly in lan743x
   driver, from Bryan Whitehead.

6) MAC filter deletion in i40e driver clears wrong state bit,
   from Lihong Yang.

7) Fix use after free in rionet driver, from Pan Bian.

Please pull, thanks!

The following changes since commit d146194f31c96f9b260c5a1cf1592d2e7f82a2e2:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2018-11-24 09:42:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to d78a5ebd8b18d3809fd9d6bbaeb64d78a332204f:

  Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue (2018-11-28 11:33:35 -0800)

----------------------------------------------------------------
Alexei Starovoitov (2):
      bpf: fix integer overflow in queue_stack_map
      Merge branch 'arm64-jit-fixes'

Alin Nastac (1):
      netfilter: ipv6: Preserve link scope traffic original oif

Andrey Ignatov (1):
      bpf: Fix IPv6 dport byte order in bpf_sk_lookup_udp

Bernd Eckstein (1):
      usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Bryan Whitehead (2):
      lan743x: fix return value for lan743x_tx_napi_poll
      lan743x: Enable driver to work with LAN7431

Colin Ian King (3):
      firestream: fix spelling mistake: "Inititing" -> "Initializing"
      qed: fix spelling mistake "attnetion" -> "attention"
      net: via: via-velocity: fix spelling mistake "alignement" -> "alignment"

Daniel Borkmann (3):
      bpf, ppc64: generalize fetching subprog into bpf_jit_get_func_addr
      bpf, arm64: fix getting subprog addr from aux for calls
      bpf, doc: add entries of who looks over which jits

David Miller (3):
      sparc: Fix JIT fused branch convergance.
      sparc: Correct ctx->saw_frame_pointer logic.
      sparc: Adjust bpf JIT prologue for PSEUDO calls.

David S. Miller (4):
      Merge git://git.kernel.org/.../bpf/bpf
      Merge git://git.kernel.org/.../bpf/bpf
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch '1GbE' of git://git.kernel.org/.../jkirsher/net-queue

Edward Cree (1):
      bpf: fix off-by-one error in adjust_subprog_starts

Eric Dumazet (1):
      tcp: address problems caused by EDT misshaps

Florian Westphal (5):
      netfilter: nf_tables: don't skip inactive chains during update
      selftests: add script to stress-test nft packet path vs. control plane
      netfilter: nf_tables: don't use position attribute on rule replacement
      netfilter: nf_tables: fix use-after-free when deleting compat expressions
      netfilter: nfnetlink_cttimeout: fetch timeouts for udplite and gre, too

Heiner Kallweit (1):
      net: phy: add workaround for issue where PHY driver doesn't bind to the device

Jakub Kicinski (1):
      tools: bpftool: fix potential NULL pointer dereference in do_load

Jan Sokolowski (1):
      i40e: fix kerneldoc for xsk methods

Jon Maloy (1):
      tipc: fix lockdep warning during node delete

Josh Elsasser (1):
      ixgbe: recognize 1000BaseLX SFP modules as 1Gbps

Julian Wiedmann (1):
      s390/qeth: fix length check in SNMP processing

Li Zhijian (1):
      kselftests/bpf: use ping6 as the default ipv6 ping binary when it exists

Lihong Yang (1):
      i40e: Fix deletion of MAC filters

Lorenzo Bianconi (1):
      net: thunderx: fix NULL pointer dereference in nic_remove

Martynas Pumputis (1):
      bpf: fix check of allowed specifiers in bpf_trace_printk

Pan Bian (2):
      rapidio/rionet: do not free skb before reading its length
      net: hisilicon: remove unexpected free_netdev

Quentin Monnet (4):
      tools: bpftool: prevent infinite loop in get_fdinfo()
      tools: bpftool: fix plain output and doc for --bpffs option
      tools: bpftool: pass an argument to silence open_obj_pinned()
      tools: bpftool: update references to other man pages in documentation

Roman Gushchin (1):
      bpf: allocate local storage buffers using GFP_ATOMIC

Taehee Yoo (9):
      netfilter: nf_conncount: use spin_lock_bh instead of spin_lock
      netfilter: nf_conncount: fix list_del corruption in conn_free
      netfilter: nf_conncount: fix unexpected permanent node of list.
      netfilter: xt_RATEEST: remove netns exit routine
      netfilter: xt_hashlimit: fix a possible memory leak in htable_create()
      netfilter: add missing error handling code for register functions
      netfilter: nat: fix double register in masquerade modules
      netfilter: nf_conncount: remove wrong condition check routine
      netfilter: nf_tables: deactivate expressions in rule replecement routine

Willem de Bruijn (1):
      net: always initialize pagedlen

Xin Long (2):
      ipvs: call ip_vs_dst_notifier earlier than ipv6_dev_notf
      sctp: increase sk_wmem_alloc when head->truesize is increased

Yonghong Song (1):
      tools/bpftool: copy a few net uapi headers to tools directory

Yunjian Wang (1):
      igb: fix uninitialized variables

 MAINTAINERS                                           |  63 +++++++++++-
 arch/arm64/net/bpf_jit_comp.c                         |  26 +++--
 arch/powerpc/net/bpf_jit_comp64.c                     |  57 +++++++----
 arch/sparc/net/bpf_jit_comp_64.c                      |  97 ++++++++++++------
 drivers/atm/firestream.c                              |   4 +-
 drivers/net/ethernet/cavium/thunder/nic_main.c        |   3 +
 drivers/net/ethernet/hisilicon/hip04_eth.c            |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c           |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c            |  14 +--
 drivers/net/ethernet/intel/igb/e1000_i210.c           |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c         |   4 +-
 drivers/net/ethernet/microchip/lan743x_main.c         |  11 ++-
 drivers/net/ethernet/microchip/lan743x_main.h         |   1 +
 drivers/net/ethernet/qlogic/qed/qed_debug.c           |   2 +-
 drivers/net/ethernet/via/via-velocity.c               |   2 +-
 drivers/net/phy/phy_device.c                          |   8 ++
 drivers/net/rionet.c                                  |   2 +-
 drivers/net/usb/ipheth.c                              |  10 +-
 drivers/s390/net/qeth_core_main.c                     |  27 +++--
 include/linux/filter.h                                |   4 +
 include/linux/netfilter/nf_conntrack_proto_gre.h      |  13 +++
 include/net/netfilter/ipv4/nf_nat_masquerade.h        |   2 +-
 include/net/netfilter/ipv6/nf_nat_masquerade.h        |   2 +-
 kernel/bpf/core.c                                     |  34 +++++++
 kernel/bpf/local_storage.c                            |   3 +-
 kernel/bpf/queue_stack_maps.c                         |  16 +--
 kernel/bpf/verifier.c                                 |   2 +-
 kernel/trace/bpf_trace.c                              |   8 +-
 net/core/filter.c                                     |   5 +-
 net/ipv4/ip_output.c                                  |   3 +-
 net/ipv4/netfilter/ipt_MASQUERADE.c                   |   7 +-
 net/ipv4/netfilter/nf_nat_masquerade_ipv4.c           |  38 ++++++--
 net/ipv4/netfilter/nft_masq_ipv4.c                    |   4 +-
 net/ipv4/tcp_input.c                                  |  16 +--
 net/ipv4/tcp_timer.c                                  |  10 +-
 net/ipv6/ip6_output.c                                 |   3 +-
 net/ipv6/netfilter.c                                  |   3 +-
 net/ipv6/netfilter/ip6t_MASQUERADE.c                  |   8 +-
 net/ipv6/netfilter/nf_nat_masquerade_ipv6.c           |  49 +++++++---
 net/ipv6/netfilter/nft_masq_ipv6.c                    |   4 +-
 net/netfilter/ipvs/ip_vs_ctl.c                        |   3 +
 net/netfilter/nf_conncount.c                          |  44 ++++++---
 net/netfilter/nf_conntrack_proto_gre.c                |  14 +--
 net/netfilter/nf_tables_api.c                         |  46 ++++-----
 net/netfilter/nfnetlink_cttimeout.c                   |  15 ++-
 net/netfilter/nft_compat.c                            |   3 +-
 net/netfilter/nft_flow_offload.c                      |   5 +-
 net/netfilter/xt_RATEEST.c                            |  10 --
 net/netfilter/xt_hashlimit.c                          |   9 +-
 net/sctp/output.c                                     |   1 +
 net/tipc/node.c                                       |   7 +-
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst    |   8 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst       |   8 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst       |   8 +-
 tools/bpf/bpftool/Documentation/bpftool-perf.rst      |   8 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst      |  11 ++-
 tools/bpf/bpftool/Documentation/bpftool.rst           |   9 +-
 tools/bpf/bpftool/common.c                            |  17 ++--
 tools/bpf/bpftool/main.h                              |   2 +-
 tools/bpf/bpftool/prog.c                              |  13 ++-
 tools/include/uapi/linux/pkt_cls.h                    | 612 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/tc_act/tc_bpf.h              |  37 +++++++
 tools/testing/selftests/Makefile                      |   1 +
 tools/testing/selftests/bpf/test_netcnt.c             |   5 +-
 tools/testing/selftests/bpf/test_verifier.c           |  19 ++++
 tools/testing/selftests/netfilter/Makefile            |   6 ++
 tools/testing/selftests/netfilter/config              |   2 +
 tools/testing/selftests/netfilter/nft_trans_stress.sh |  78 +++++++++++++++
 68 files changed, 1312 insertions(+), 261 deletions(-)
 create mode 100644 tools/include/uapi/linux/pkt_cls.h
 create mode 100644 tools/include/uapi/linux/tc_act/tc_bpf.h
 create mode 100644 tools/testing/selftests/netfilter/Makefile
 create mode 100644 tools/testing/selftests/netfilter/config
 create mode 100755 tools/testing/selftests/netfilter/nft_trans_stress.sh

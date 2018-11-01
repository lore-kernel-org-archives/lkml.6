Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF64C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0913520657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0913520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeKAKov convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:44:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57816 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKAKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:44:51 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7CD5514711CC8;
        Wed, 31 Oct 2018 18:44:03 -0700 (PDT)
Date:   Wed, 31 Oct 2018 18:44:02 -0700 (PDT)
Message-Id: <20181031.184402.2213867913967695313.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 31 Oct 2018 18:44:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) BPF verifier fixes from Daniel Borkmann.

2) HNS driver fixes from Huazhong Tan.

3) FDB only works for ethernet devices, reject attempts to install FDB
   rules for others.  From Ido Schimmel.

4) Fix spectre V1 in vhost, from Jason Wang.

5) Don't pass on-stack object to irq_set_affinity_hint() in mvpp2 driver,
   from Marc Zyngier.

6) Fix mlx5e checksum handling when RXFCS is enabled, from Eric Dumazet.

Please pull, thanks a lot!

The following changes since commit 4b42745211af552f170f38a1b97f4a112b5da6b2:

  Merge tag 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-10-29 15:37:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 46ebe2834ba5b541f28ee72e556a3fed42c47570:

  openvswitch: Fix push/pop ethernet validation (2018-10-31 18:37:16 -0700)

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'verifier-fixes'

Andrey Ignatov (1):
      libbpf: Fix compile error in libbpf_attach_type_by_name

Bo YU (2):
      net: add an identifier name for 'struct sock *'
      net: drop a space before tabs

Colin Ian King (1):
      net: hns3: fix spelling mistake "intrerrupt" -> "interrupt"

Daniel Borkmann (4):
      bpf: fix partial copy of map_ptr when dst is scalar
      bpf: don't set id on after map lookup with ptr_to_map_val return
      bpf: add various test cases to test_verifier
      bpf: test make sure to run unpriv test cases in test_verifier

David S. Miller (5):
      Merge branch 'mlxsw-Couple-of-fixes'
      Merge branch 'hns3-fixes'
      Merge branch 'mlxsw-Enable-minimum-shaper-on-MC-TCs'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/net-queue

Eric Dumazet (2):
      net/mlx4_en: add a missing <net/ip.h> include
      net/mlx5e: fix csum adjustments caused by RXFCS

Hangbin Liu (1):
      ipv4/igmp: fix v1/v2 switchback timeout based on rfc3376, 8.12

Huazhong Tan (11):
      net: hns3: add error handler for hns3_nic_init_vector_data()
      net: hns3: bugfix for buffer not free problem during resetting
      net: hns3: bugfix for reporting unknown vector0 interrupt repeatly problem
      net: hns3: bugfix for the initialization of command queue's spin lock
      net: hns3: remove unnecessary queue reset in the hns3_uninit_all_ring()
      net: hns3: bugfix for is_valid_csq_clean_head()
      net: hns3: bugfix for hclge_mdio_write and hclge_mdio_read
      net: hns3: fix incorrect return value/type of some functions
      net: hns3: bugfix for handling mailbox while the command queue reinitialized
      net: hns3: bugfix for rtnl_lock's range in the hclge_reset()
      net: hns3: bugfix for rtnl_lock's range in the hclgevf_reset()

Ido Schimmel (1):
      rtnetlink: Disallow FDB configuration for non-Ethernet device

Jacob Keller (3):
      fm10k: ensure completer aborts are marked as non-fatal after a resume
      fm10k: add missing device IDs to the upstream driver
      fm10k: bump driver version to match out-of-tree release

Jaime Caamaño Ruiz (1):
      openvswitch: Fix push/pop ethernet validation

Jason Wang (1):
      vhost: Fix Spectre V1 vulnerability

Jeff Kirsher (1):
      ixgbe/ixgbevf: fix XFRM_ALGO dependency

John Fastabend (1):
      bpf: tcp_bpf_recvmsg should return EAGAIN when nonblocking and no data

Li Zhijian (1):
      kselftests/bpf: use ping6 as the default ipv6 ping binary if it exists

Lorenzo Colitti (1):
      Documentation: ip-sysctl.txt: Document tcp_fwmark_accept

Marc Zyngier (1):
      net: mvpp2: Fix affinity hint allocation

Miroslav Lichvar (1):
      igb: shorten maximum PHC timecounter update interval

Mitch Williams (1):
      i40e: Update status codes

Nathan Chancellor (1):
      hinic: Fix l4_type parameter in hinic_task_set_tunnel_l4

Ngai-Mint Kwan (1):
      fm10k: fix SM mailbox full condition

Niklas Cassel (1):
      net: stmmac: Fix stmmac_mdio_reset() when building stmmac as modules

Petr Machata (5):
      mlxsw: spectrum_switchdev: Don't ignore deletions of learned MACs
      mlxsw: reg: QEEC: Add minimum shaper fields
      mlxsw: spectrum: Set minimum shaper on MC TCs
      selftests: mlxsw: qos_mc_aware: Tweak for min shaper
      selftests: mlxsw: qos_mc_aware: Add a test for UC awareness

Radoslaw Tyl (1):
      ixgbe: fix MAC anti-spoofing filter after VFLR

Shalom Toledo (1):
      mlxsw: core: Fix devlink unregister flow

Tobias Jungel (1):
      bonding: fix length of actor system

Xin Long (2):
      sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer
      sctp: check policy more carefully when getting pr status

Yonghong Song (1):
      tools/bpf: add unlimited rlimit for flow_dissector_load

 Documentation/networking/ip-sysctl.txt                    |  11 ++++
 drivers/net/bonding/bond_netlink.c                        |   3 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               |   6 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           | 117 +++++++++++++++++++++++++++----------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h           |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c    |  26 +++++----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c    |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |  42 ++++++-------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h   |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c    |   6 ++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c   |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |  19 +++---
 drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c           |   2 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h           |   2 +-
 drivers/net/ethernet/intel/Kconfig                        |  18 ++++++
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c              |  51 +++++++++-------
 drivers/net/ethernet/intel/fm10k/fm10k_main.c             |   2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c              |   2 +
 drivers/net/ethernet/intel/fm10k/fm10k_type.h             |   2 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c        |   2 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c                  |   8 ++-
 drivers/net/ethernet/intel/ixgbe/Makefile                 |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h                  |   8 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c             |   6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c            |   4 +-
 drivers/net/ethernet/intel/ixgbevf/Makefile               |   2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h              |   4 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c         |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h                |   1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c           |  18 ++++--
 drivers/net/ethernet/mellanox/mlx4/en_rx.c                |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c           |  45 +++-----------
 drivers/net/ethernet/mellanox/mlxsw/core.c                |  24 +++++---
 drivers/net/ethernet/mellanox/mlxsw/reg.h                 |  22 ++++++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c            |  25 ++++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c  |   2 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c         |   2 +-
 drivers/vhost/vhost.c                                     |   2 +
 include/linux/avf/virtchnl.h                              |  12 +++-
 include/linux/bpf_verifier.h                              |   3 +
 include/linux/inetdevice.h                                |   4 +-
 include/net/af_unix.h                                     |   4 +-
 kernel/bpf/verifier.c                                     |  21 ++++---
 net/core/rtnetlink.c                                      |  10 ++++
 net/ipv4/igmp.c                                           |  53 +++++++++++------
 net/ipv4/tcp_bpf.c                                        |   1 +
 net/openvswitch/flow_netlink.c                            |   4 +-
 net/sctp/associola.c                                      |  10 +++-
 net/sctp/socket.c                                         |   8 ++-
 net/xfrm/Kconfig                                          |   1 -
 tools/lib/bpf/libbpf.c                                    |  13 +++--
 tools/testing/selftests/bpf/flow_dissector_load.c         |   2 +
 tools/testing/selftests/bpf/test_skb_cgroup_id.sh         |   3 +-
 tools/testing/selftests/bpf/test_sock_addr.sh             |   3 +-
 tools/testing/selftests/bpf/test_verifier.c               | 321 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh |  95 ++++++++++++++++++++++--------
 56 files changed, 793 insertions(+), 274 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeECUVG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:21:06 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52220 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeECUVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:21:04 -0400
Date: Thu, 03 May 2018 16:21:02 -0400 (EDT)
Message-Id: <20180503.162102.1453572100096038864.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w43KLDhd024826


1) Various sockmap fixes from John Fastabend (pinned map handling, blocking
   in recvmsg, double page put, error handling during redirect failures, etc.)

2) Fix dead code handling in x86-64 JIT, from Gianluca Borello.

3) Missing device put in RDS IB code, from Dag Moxnes.

4) Don't process fast open during repair mode in TCP< from Yuchung
   Cheng.

5) Move address/port comparison fixes in SCTP, from Xin Long.

6) Handle add a bond slave's master into a bridge properly, from
   Hangbin Liu.

7) IPv6 multipath code can operate on unitialized memory due to an
   assumption that the icmp header is in the linear SKB area.  Fix
   from Eric Dumazet.

8) Don't invoke do_tcp_sendpages() recursively via TLS, from Dave
   Watson.

9) Fix memory leaks in x86-64 JIT, from Daniel Borkmann.

10) RDS leaks kernel memory to userspace, from Eric Dumazet.

11) DCCP can invoke a tasklet on a freed socket, take a refcount.
    Also from Eric Dumazet.

Please pull, thanks a lot!

The following changes since commit 3be4aaf4e2d3eb95cce7835e8df797ae65ae5ac1:

  Merge branch 'userns-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2018-04-24 17:58:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to a8d7aa17bbc970971ccdf71988ea19230ab368b1:

  dccp: fix tasklet usage (2018-05-03 15:14:57 -0400)

----------------------------------------------------------------
Alexandre Belloni (1):
      net: phy: allow scanning busses with missing phys

Alexei Starovoitov (2):
      Merge branch 'x86-bpf-jit-fixes'
      Merge branch 'bpf-sockmap-fixes'

Anders Roxell (1):
      selftests: net: add in_netns.sh TEST_GEN_PROGS_EXTENDED

Arend Van Spriel (1):
      brcmfmac: fix firmware request processing if nvram load fails

Bjørn Mork (1):
      qmi_wwan: do not steal interfaces from class drivers

Chris Mi (1):
      net/mlx5: Properly deal with flow counters when deleting rules

Colin Ian King (6):
      net: systemport: fix spelling mistake: "asymetric" -> "asymmetric"
      qed: fix spelling mistake: "checksumed" -> "checksummed"
      net: ethernet: ucc: fix spelling mistake: "tx-late-collsion" -> "tx-late-collision"
      net/mlx4: fix spelling mistake: "failedi" -> "failed"
      net/mlx5e: fix spelling mistake: "loobpack" -> "loopback"
      qed: fix spelling mistake: "offloded" -> "offloaded"

Dag Moxnes (1):
      rds: ib: Fix missing call to rds_ib_dev_put in rds_ib_setup_qp

Daniel Borkmann (3):
      Merge branch 'bpf-sockmap-fixes'
      bpf, x64: fix memleak when not converging after image
      bpf, x64: fix memleak when not converging on calls

Dave Watson (1):
      net/tls: Don't recursively call push_record during tls_write_space callbacks

David S. Miller (7):
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'mvpp2-fixes'
      Merge tag 'wireless-drivers-for-davem-2018-04-26' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge tag 'mlx5-fixes-2018-04-25' of git://git.kernel.org/.../saeed/linux
      Merge branch 'sfc-more-ARFS-fixes'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'smc-fixes'

Edward Cree (2):
      sfc: Use filter index rather than ID for rps_flow_id table
      sfc: fix ARFS expiry check on EF10

Eric Dumazet (6):
      ipv6: fix uninit-value in ip6_multipath_l3_keys()
      tcp: fix TCP_REPAIR_QUEUE bound checking
      net_sched: fq: take care of throttled flows before reuse
      rds: do not leak kernel memory to user land
      tcp: restore autocorking
      dccp: fix tasklet usage

Florian Fainelli (1):
      net: systemport: Correclty disambiguate driver instances

Gianluca Borello (1):
      bpf, x64: fix JIT emission for dead code

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode

Haim Dreyfuss (1):
      iwlwifi: mvm: query regdb for wmm rule if needed

Hangbin Liu (1):
      bridge: check iface upper dev when setting master via ioctl

Huy Nguyen (1):
      net/mlx5e: DCBNL fix min inline header size for dscp

Ido Schimmel (2):
      mlxsw: spectrum_switchdev: Do not remove mrouter port from MDB's ports list
      ipv6: Revert "ipv6: Allow non-gateway ECMP for IPv6"

Ingo Molnar (1):
      8139too: Use disable_irq_nosync() in rtl8139_poll_controller()

Israel Rukshin (1):
      net/mlx5: Fix mlx5_get_vector_affinity function

Jakub Kicinski (1):
      nfp: don't depend on eth_tbl being available

Jianbo Liu (1):
      net/mlx5e: Allow offloading ipv4 header re-write for icmp

John Fastabend (10):
      bpf: Document sockmap '-target bpf' requirement for PROG_TYPE_SK_MSG
      bpf: sockmap sample use clang flag, -target bpf
      bpf: sockmap, map_release does not hold refcnt for pinned maps
      bpf: sockmap, sk_wait_event needed to handle blocking cases
      bpf: sockmap, fix double page_put on ENOMEM error in redirect path
      bpf: fix for lex/yacc build error with gcc-5
      bpf: fix uninitialized variable in bpf tools
      bpf: sockmap, fix scatterlist update on error path in send with apply
      bpf: sockmap, zero sg_size on error when buffer is released
      bpf: sockmap, fix error handling in redirect failures

John Hurley (1):
      nfp: flower: set tunnel ttl value to net default

Jon Maloy (1):
      tipc: fix bug in function tipc_nl_node_dump_monitor

Julian Anastasov (1):
      ipv4: fix fnhe usage by non-cached routes

Karsten Graul (2):
      net/smc: call consolidation
      net/smc: handle unregistered buffers

Lance Richardson (1):
      net: support compat 64-bit time in {s,g}etsockopt

Luca Coelho (1):
      iwlwifi: mvm: fix old scan version sizes

Marcelo Ricardo Leitner (1):
      MAINTAINERS: add myself as SCTP co-maintainer

Maxime Chevallier (2):
      net: mvpp2: Fix clk error path in mvpp2_probe
      net: mvpp2: Fix clock resource by adding missing mg_core_clk

Michael S. Tsirkin (2):
      vhost: make msg padding explicit
      Revert "vhost: make msg padding explicit"

Neal Cardwell (1):
      tcp_bbr: fix to zero idle_restart only upon S/ACKed data

Ping-Ke Shih (1):
      rtlwifi: cleanup 8723be ant_sel definition

Roman Gushchin (1):
      bpf: disable and restore preemption in __BPF_PROG_RUN_ARRAY

SZ Lin (林上智) (1):
      NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2

Shahar Klein (1):
      net/mlx5e: Fix traffic between VF and representor

Song Liu (1):
      bpf: minor fix to selftest test_stacktrace_build_id()

Stefan Raspl (1):
      smc: fix sendpage() call

Talat Batheesh (1):
      net/mlx5: Avoid cleaning flow steering table twice during error flow

Tariq Toukan (1):
      net/mlx5e: TX, Use correct counter in dma_map error flow

Thomas Winter (1):
      ipv6: Allow non-gateway ECMP for IPv6

Ursula Braun (2):
      net/smc: keep clcsock reference in smc_tcp_listen_work()
      net/smc: restrict non-blocking connect finish

Vivien Didelot (1):
      MAINTAINERS: add davem in NETWORKING DRIVERS

Wenwen Wang (1):
      ethtool: fix a potential missing-check bug

William Tu (1):
      bpf: clear the ip_tunnel_info.

Xin Long (5):
      sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
      sctp: clear the new asoc's stream outcnt in sctp_stream_update
      sctp: init active key for the new asoc in dupcook_a and dupcook_b
      sctp: use the old asoc when making the cookie-ack chunk in dupcook_d
      sctp: fix the issue that the cookie-ack with auth can't get processed

Yuchung Cheng (1):
      tcp: ignore Fast Open on repair mode

 Documentation/bpf/bpf_devel_QA.txt                            |  10 +++++++-
 MAINTAINERS                                                   |   2 ++
 arch/x86/net/bpf_jit_comp.c                                   |  18 +++++++++++---
 drivers/infiniband/hw/mlx5/main.c                             |   2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c                    |  18 ++++++++++----
 drivers/net/ethernet/freescale/ucc_geth_ethtool.c             |   2 +-
 drivers/net/ethernet/marvell/mvpp2.c                          |  30 ++++++++++++++++------
 drivers/net/ethernet/mellanox/mlx4/main.c                     |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c            |   8 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c              |   5 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c               |   3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c               |  20 +++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c             |  26 +++++++++++--------
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c      |  12 ++++-----
 drivers/net/ethernet/netronome/nfp/flower/action.c            |  10 ++++++--
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h              |   5 +++-
 drivers/net/ethernet/netronome/nfp/flower/main.c              |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_app_nic.c              |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.h                 |   4 ++-
 drivers/net/ethernet/netronome/nfp/nfp_net_main.c             |  31 +++++++++++++----------
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                     |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_roce.c                    |   2 +-
 drivers/net/ethernet/realtek/8139too.c                        |   2 +-
 drivers/net/ethernet/sfc/ef10.c                               |   5 ++--
 drivers/net/ethernet/sfc/rx.c                                 |   2 ++
 drivers/net/ethernet/ti/cpsw.c                                |   2 ++
 drivers/net/phy/phy_device.c                                  |  11 ++++++++-
 drivers/net/usb/qmi_wwan.c                                    |  13 ++++++++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c   |  36 +++++++++++++++------------
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h              |  13 ++++------
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c            | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h            |   6 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c             |   3 ++-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c |  15 -----------
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c           |  11 ++++++---
 drivers/net/wireless/realtek/rtlwifi/wifi.h                   |   5 ++++
 include/linux/bpf.h                                           |   4 ++-
 include/linux/mlx5/driver.h                                   |  12 +++------
 include/net/tls.h                                             |   1 +
 kernel/bpf/arraymap.c                                         |   3 ++-
 kernel/bpf/sockmap.c                                          |  99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 kernel/bpf/syscall.c                                          |   4 +--
 net/bridge/br_if.c                                            |   4 +--
 net/compat.c                                                  |   6 +++--
 net/core/ethtool.c                                            |   5 ++++
 net/core/filter.c                                             |   1 +
 net/dccp/ccids/ccid2.c                                        |  14 +++++++++--
 net/dccp/timer.c                                              |   2 +-
 net/ipv4/route.c                                              | 118 +++++++++++++++++++++++++++++++++++++++------------------------------------------------
 net/ipv4/tcp.c                                                |   7 +++---
 net/ipv4/tcp_bbr.c                                            |   4 ++-
 net/ipv6/route.c                                              |   7 +++++-
 net/rds/ib_cm.c                                               |   3 ++-
 net/rds/recv.c                                                |   1 +
 net/sched/sch_fq.c                                            |  37 ++++++++++++++++++---------
 net/sctp/inqueue.c                                            |   2 +-
 net/sctp/ipv6.c                                               |   3 +++
 net/sctp/sm_statefuns.c                                       |   8 +++++-
 net/sctp/stream.c                                             |   2 ++
 net/smc/af_smc.c                                              |  61 ++++++++++++++++++++++-----------------------
 net/smc/smc_core.c                                            |  22 ++++++++++++++---
 net/smc/smc_core.h                                            |   3 ++-
 net/tipc/node.c                                               |   2 +-
 net/tls/tls_main.c                                            |   7 ++++++
 samples/sockmap/Makefile                                      |   7 ++++--
 tools/bpf/Makefile                                            |   2 ++
 tools/bpf/bpf_dbg.c                                           |   7 ++++--
 tools/testing/selftests/bpf/test_progs.c                      |   4 +--
 tools/testing/selftests/net/Makefile                          |   3 ++-
 70 files changed, 602 insertions(+), 316 deletions(-)

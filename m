Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeBIT6A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:58:00 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:49684 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBIT56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:57:58 -0500
Date: Fri, 09 Feb 2018 14:57:50 -0500 (EST)
Message-Id: <20180209.145750.2016161866752403432.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Make allocations less aggressive in x_tables, from Minchal Hocko.

2) Fix netfilter flowtable Kconfig deps, from Pablo Neira Ayuso.

3) Fix connection loss problems in rtlwifi, from Larry Finger.

4) Correct DRAM dump length for some chips in ath10k driver,
   from Yu Wang.

5) Fix ABORT handling in rxrpc, from David Howells.

6) Add SPDX tags to Sun networking drivers, from Shannon Nelson.

7) Some ipv6 onlink handling fixes, from David Ahern.

8) Netem packet scheduler interval calcualtion fix from Md. Islam.

9) Don't put crypto buffers on-stack in rxrpc, from David Howells.

10) Fix handling of error non-delivery status in netlink multicast
    delivery over multiple namespaces, from Nicolas Dichtel.

11) Missing xdp flush in tuntap driver, from Jason Wang.

12) Synchonize RDS protocol netns/module teardown with rds object
    management, from Sowini Varadhan.

13) Add nospec annotations to mpls, from Dan Williams.

14) Fix SKB truesize handling in TIPC, from Hoang Le.

15) Interrupt masking fixes in stammc from Niklas Cassel.

16) Don't allow ptr_ring objects to be sized outside of kmalloc's
    limits, from Jason Wang.

17) Don't allow SCTP chunks to be built which will have a length
    exceeding the chunk header's 16-bit length field, from Alexey
    Kodanev.

Please pull, thanks a lot!

The following changes since commit a2e5790d841658485d642196dbb0927303d6c22f:

  Merge branch 'akpm' (patches from Andrew) (2018-02-06 22:15:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 2fa56a494484f19e06bf4f3464b2155a92beafac:

  ibmvnic: Remove skb->protocol checks in ibmvnic_xmit (2018-02-09 14:47:00 -0500)

----------------------------------------------------------------
Alexey Kodanev (1):
      sctp: verify size of a new chunk in _sctp_make_chunk()

Amritha Nambiar (1):
      i40e: Fix the number of queues available to be mapped for use

Christian Brauner (1):
      rtnetlink: require unique netns identifier

Christophe JAILLET (1):
      cxgb4: Fix error handling path in 'init_one()'

Cong Wang (2):
      netfilter: xt_cgroup: initialize info->priv in cgroup_mt_check_v1()
      netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert

Dan Williams (1):
      mpls, nospec: Sanitize array index in mpls_label_ok()

Daniel Borkmann (4):
      Merge branch 'bpf-sockmap-fixes'
      Merge branch 'bpf-misc-nfp-bpftool-doc-fixes'
      Merge branch 'bpf-libbpf-relo-fix-and-tests'
      bpf: fix rlimit in reuseport net selftest

David Ahern (2):
      net/ipv6: Handle reject routes with onlink flag
      net/ipv6: onlink nexthop checks should default to main table

David Howells (2):
      rxrpc: Fix received abort handling
      rxrpc: Don't put crypto buffers on the stack

David S. Miller (6):
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'nfp-fix-disabling-TC-offloads-in-flower-max-TSO-segs-and-module-version'
      Merge tag 'wireless-drivers-next-for-davem-2018-02-08' of git://git.kernel.org/.../kvalo/wireless-drivers-next
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'stmmac-irq-fixes-cleanups'
      Merge branch 's390-qeth-fixes'

Dean Nelson (1):
      net: thunder: change q_len's type to handle max ring size

Felix Fietkau (5):
      mt76: implement AP_LINK_PS
      mt76: implement processing of BlockAckReq frames
      mt76: avoid re-queueing A-MPDU rx reorder work if no frames are pending
      mt76: do not set status->aggr for NULL data frames
      netfilter: nf_flow_offload: fix use-after-free and a resource leak

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: fix net watchdog timeout

Gustavo A. R. Silva (1):
      atm: he: use 64-bit arithmetic instead of 32-bit

Heiner Kallweit (1):
      net: phy: fix phy_start to consider PHY_IGNORE_INTERRUPT

Hoang Le (1):
      tipc: fix skb truesize/datasize ratio control

Ivan Vecera (1):
      net/sched: cls_u32: fix cls_u32 on filter replace

Jakub Kicinski (6):
      nfp: bpf: fix immed relocation for larger offsets
      nfp: bpf: require ETH table
      nfp: don't advertise hw-tc-offload on non-port netdevs
      nfp: forbid disabling hw-tc-offload on representors while offload active
      nfp: limit the number of TSO segments
      nfp: populate MODULE_VERSION

Jason Wang (3):
      tuntap: add missing xdp flush
      ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE
      ptr_ring: try vmalloc() when kmalloc() fails

Jesper Dangaard Brouer (5):
      bpf: Sync kernel ABI header with tooling header for bpf_common.h
      tools/libbpf: improve the pr_debug statements to contain section numbers
      selftests/bpf: add test program for loading BPF ELF files
      selftests/bpf: add selftest that use test_libbpf_open
      tools/libbpf: handle issues with bpf ELF objects containing .eh_frames

John Allen (2):
      ibmvnic: Fix rx queue cleanup for non-fatal resets
      ibmvnic: Remove skb->protocol checks in ibmvnic_xmit

John Fastabend (3):
      net: add a UID to use for ULP socket assignment
      bpf: sockmap, add sock close() hook to remove socks
      bpf: sockmap, fix leaking maps with attached but not detached progs

Julian Wiedmann (1):
      s390/qeth: fix SETIP command handling

Kalle Valo (2):
      Merge git://git.kernel.org/.../kvalo/wireless-drivers.git
      Merge ath-current from git://git.kernel.org/.../kvalo/ath.git

Kees Cook (1):
      net: Whitelist the skbuff_head_cache "cb" field

Larry Finger (1):
      rtlwifi: rtl8821ae: Fix connection lost problem correctly

Mathieu Malaterre (1):
      net: Extra '_get' in declaration of arch_get_platform_mac_address

Md. Islam (1):
      sch_netem: Bug fixing in calculating Netem interval

Michal Hocko (1):
      netfilter: x_tables: make allocation less aggressive

Naresh Kamboju (1):
      selftests: bpf: test_kmod.sh: check the module path before insmod

Nathan Fontenot (1):
      ibmvnic: queue reset when CRQ gets closed during reset

Nicolas Dichtel (1):
      netlink: ensure to loop over all netns in genlmsg_multicast_allns()

Niklas Cassel (3):
      net: stmmac: discard disabled flags in interrupt status register
      net: stmmac: rename GMAC_INT_DEFAULT_MASK for dwmac4
      net: stmmac: remove redundant enable of PMT irq

Oleksij Rempel (1):
      ath9k_htc: add Altai WA1011N-GU

Pablo Neira Ayuso (5):
      netfilter: flowtable infrastructure depends on NETFILTER_INGRESS
      netfilter: nft_flow_offload: wait for garbage collector to run after cleanup
      netfilter: nft_flow_offload: no need to flush entries on module removal
      netfilter: nft_flow_offload: move flowtable cleanup routines to nf_flow_table
      netfilter: nf_tables: fix flowtable free

Quentin Monnet (5):
      libbpf: complete list of strings for guessing program type
      tools: bpftool: exit doc Makefile early if rst2man is not available
      tools: bpftool: make syntax for program map update explicit in man page
      tools: bpftool: add bash completion for `bpftool prog load`
      tools: bpftool: add bash completion for cgroup commands

Ryan Hsu (1):
      Revert "ath10k: add sanity check to ie_len before parsing fw/board ie"

Shannon Nelson (1):
      sun: Add SPDX license tags to Sun network drivers

Song Liu (1):
      tcp: tracepoint: only call trace_tcp_send_reset with full socket

Sowmini Varadhan (1):
      rds: tcp: use rds_destroy_pending() to synchronize netns/module teardown and rds connection/workq management

Subash Abhinov Kasiviswanathan (1):
      netfilter: ipv6: nf_defrag: Kill frag queue on RFC2460 failure

Sven Joachim (1):
      ssb: Do not disable PCI host on non-Mips

Taehee Yoo (1):
      netfilter: remove useless prototype

Thomas Falcon (2):
      ibmvnic: Ensure that buffers are NULL after free
      ibmvnic: Reset long term map ID counter

Tobias Schramm (2):
      PCI: Add Ubiquiti Networks vendor ID
      ath10k: add support for Ubiquiti rebranded QCA988X v2

Ursula Braun (1):
      s390/qeth: fix underestimated count of buffer elements

Wojciech Dubowik (1):
      ath9k: Fix get channel default noise floor

Yonghong Song (2):
      bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y
      tools/bpf: fix batch-mode test failure of test_xdp_redirect.sh

Yu Wang (2):
      ath10k: correct the length of DRAM dump for QCA6174 hw3.x/QCA9377 hw1.1
      ath10k: fix kernel panic issue during pci probe

 drivers/atm/he.c                                     |   8 +--
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h   |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c      |   2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                   |  20 ++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c          |  27 +++++-----
 drivers/net/ethernet/netronome/nfp/bpf/main.c        |  21 +++++---
 drivers/net/ethernet/netronome/nfp/flower/offload.c  |   4 ++
 drivers/net/ethernet/netronome/nfp/nfp_app.h         |   9 ----
 drivers/net/ethernet/netronome/nfp/nfp_asm.c         |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c        |   1 +
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c  |  11 ++--
 drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h    |   5 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c    |   1 +
 drivers/net/ethernet/netronome/nfp/nfp_port.c        |  18 +++++++
 drivers/net/ethernet/netronome/nfp/nfp_port.h        |   6 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c |   2 -
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h         |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    |  13 ++---
 drivers/net/ethernet/sun/Kconfig                     |   1 +
 drivers/net/ethernet/sun/cassini.c                   |   1 +
 drivers/net/ethernet/sun/cassini.h                   |   1 +
 drivers/net/ethernet/sun/ldmvsw.c                    |   1 +
 drivers/net/ethernet/sun/niu.c                       |   1 +
 drivers/net/ethernet/sun/sunbmac.c                   |   1 +
 drivers/net/ethernet/sun/sungem.c                    |   1 +
 drivers/net/ethernet/sun/sunhme.c                    |   1 +
 drivers/net/ethernet/sun/sunqe.c                     |   1 +
 drivers/net/ethernet/sun/sunvnet.c                   |   1 +
 drivers/net/ethernet/sun/sunvnet_common.c            |   1 +
 drivers/net/ethernet/ti/cpsw.c                       |  16 +++++-
 drivers/net/phy/phy.c                                |   2 +-
 drivers/net/tun.c                                    |  15 ++++++
 drivers/net/wireless/ath/ath10k/core.c               |  43 ++++++++++++---
 drivers/net/wireless/ath/ath10k/coredump.c           |   3 +-
 drivers/net/wireless/ath/ath10k/debug.c              |  12 ++++-
 drivers/net/wireless/ath/ath10k/hw.h                 |   1 +
 drivers/net/wireless/ath/ath10k/pci.c                |   6 +++
 drivers/net/wireless/ath/ath9k/calib.c               |   2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c             |   1 +
 drivers/net/wireless/mediatek/mt76/agg-rx.c          |  40 +++++++++++++-
 drivers/net/wireless/mediatek/mt76/mac80211.c        |  52 +++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h            |  10 ++++
 drivers/net/wireless/mediatek/mt76/mt76x2.h          |   2 +
 drivers/net/wireless/mediatek/mt76/mt76x2_init.c     |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x2_mac.c      |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_main.c     |  28 +++++-----
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c  |   5 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h          |   1 +
 drivers/s390/net/qeth_core.h                         |   7 ++-
 drivers/s390/net/qeth_core_main.c                    |  14 ++---
 drivers/ssb/Kconfig                                  |   2 +-
 include/linux/etherdevice.h                          |   2 +-
 include/linux/pci_ids.h                              |   2 +
 include/linux/ptr_ring.h                             |  15 ++++--
 include/net/netfilter/nf_conntrack.h                 |   5 --
 include/net/netfilter/nf_flow_table.h                |   6 ++-
 include/net/tcp.h                                    |   8 +++
 kernel/bpf/sockmap.c                                 | 187 +++++++++++++++++++++++++++++++++++++++-------------------------
 lib/test_bpf.c                                       |  31 +++++++++--
 net/core/rtnetlink.c                                 |  48 +++++++++++++++++
 net/core/skbuff.c                                    |   4 +-
 net/ipv4/netfilter/Kconfig                           |   3 +-
 net/ipv4/netfilter/nf_flow_table_ipv4.c              |   1 +
 net/ipv4/tcp_ipv4.c                                  |   3 +-
 net/ipv4/tcp_ulp.c                                   |  59 ++++++++++++++++++--
 net/ipv6/netfilter/Kconfig                           |   3 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c              |   1 +
 net/ipv6/netfilter/nf_flow_table_ipv6.c              |   1 +
 net/ipv6/route.c                                     |   8 +--
 net/ipv6/tcp_ipv6.c                                  |   3 +-
 net/mpls/af_mpls.c                                   |  24 +++++----
 net/netfilter/Kconfig                                |   8 +--
 net/netfilter/nf_flow_table.c                        |  76 +++++++++++++++++---------
 net/netfilter/nf_flow_table_inet.c                   |   1 +
 net/netfilter/nf_tables_api.c                        |  17 +++---
 net/netfilter/nft_flow_offload.c                     |  24 +--------
 net/netfilter/x_tables.c                             |   7 ++-
 net/netfilter/xt_RATEEST.c                           |  22 ++++++--
 net/netfilter/xt_cgroup.c                            |   1 +
 net/netlink/genetlink.c                              |  12 ++++-
 net/rds/cong.c                                       |   2 +-
 net/rds/connection.c                                 |  15 +++---
 net/rds/ib.c                                         |  17 ++++++
 net/rds/ib_cm.c                                      |   1 +
 net/rds/rds.h                                        |   7 +++
 net/rds/send.c                                       |  10 ++--
 net/rds/tcp.c                                        |  42 ++++++++++-----
 net/rds/tcp_connect.c                                |   2 +-
 net/rds/tcp_recv.c                                   |   2 +-
 net/rds/tcp_send.c                                   |   2 +-
 net/rds/threads.c                                    |   6 +--
 net/rxrpc/conn_client.c                              |   3 +-
 net/rxrpc/conn_event.c                               |   1 +
 net/rxrpc/conn_object.c                              |  16 ++++--
 net/rxrpc/rxkad.c                                    |  92 +++++++++++++++++--------------
 net/sched/cls_u32.c                                  |   3 +-
 net/sched/sch_netem.c                                |   2 +-
 net/sctp/sm_make_chunk.c                             |   7 ++-
 net/tipc/msg.c                                       |   4 +-
 net/tls/tls_main.c                                   |   2 +
 tools/bpf/bpftool/Documentation/Makefile             |   5 ++
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst   |   4 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst      |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool            |  72 ++++++++++++++++++++++---
 tools/include/uapi/linux/bpf_common.h                |   7 +--
 tools/lib/bpf/libbpf.c                               |  56 ++++++++++++++-----
 tools/testing/selftests/bpf/Makefile                 |  12 ++++-
 tools/testing/selftests/bpf/test_kmod.sh             |  18 +++++--
 tools/testing/selftests/bpf/test_libbpf.sh           |  49 +++++++++++++++++
 tools/testing/selftests/bpf/test_libbpf_open.c       | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_xdp_meta.sh         |   1 +
 tools/testing/selftests/bpf/test_xdp_redirect.sh     |   2 +
 tools/testing/selftests/net/reuseport_bpf.c          |  21 +++++++-
 113 files changed, 1253 insertions(+), 395 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/test_libbpf.sh
 create mode 100644 tools/testing/selftests/bpf/test_libbpf_open.c

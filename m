Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030274AbeEYU61 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:58:27 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37824 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968275AbeEYU6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:58:25 -0400
Date: Fri, 25 May 2018 16:58:24 -0400 (EDT)
Message-Id: <20180525.165824.370684431802552402.davem@davemloft.net>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4PKwW4K020919


Let's begin the holiday weekend with some networking fixes:

1) Whoops need to restrict cfg80211 wiphy names even more to 64
   bytes.  From Eric Biggers.

2) Fix flags being ignored when using kernel_connect() with SCTP, from
   Xin Long.

3) Use after free in DCCP, from Alexey Kodanev.

4) Need to check rhltable_init() return value in ipmr code, from
   Eric Dumazet.

5) XDP handling fixes in virtio_net from Jason Wang.

6) Missing RTA_TABLE in rtm_ipv4_policy[], from Roopa Prabhu.

7) Need to use IRQ disabling spinlocks in mlx4_qp_lookup(), from Jack
   Morgenstein.

8) Prevent out-of-bounds speculation using indexes in BPF, from Daniel
   Borkmann.

9) Fix regression added by AF_PACKET link layer cure, from Willem
   de Bruijn.

10) Correct ENIC dma mask, from Govindarajulu Varadarajan.

11) Missing config options for PMTU tests, from Stefano Brivio.

Please pull, thanks a lot.

The following changes since commit 6741c4bb389da103c0d79ad1961884628900bfe6:

  Merge tag 'mips_fixes_4.17_2' of git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips (2018-05-21 08:58:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to eb110410b9f6477726026669f3f0c0567e8241e6:

  ibmvnic: Fix partial success login retries (2018-05-25 16:32:48 -0400)

----------------------------------------------------------------
Alexey Kodanev (1):
      dccp: don't free ccid2_hc_tx_sock struct in dccp_disconnect()

Anders Roxell (2):
      selftests: bpf: config: enable NET_SCH_INGRESS for xdp_meta.sh
      selftests: net: reuseport_bpf_numa: don't fail if no numa support

Andrew Zaborowski (1):
      mac80211_hwsim: Fix radio dump for radio idx 0

Bo Chen (1):
      pcnet32: add an error handling path in pcnet32_probe_pci()

Bob Copeland (1):
      mac80211: mesh: fix premature update of rc stats

Colin Ian King (2):
      batman-adv: don't pass a NULL hard_iface to batadv_hardif_put
      net/mlx4: fix spelling mistake: "Inrerface" -> "Interface" and rephrase message

Daniel Borkmann (1):
      bpf: properly enforce index mask to prevent out-of-bounds speculation

David S. Miller (6):
      Merge tag 'mac80211-for-davem-2018-05-23' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'virtio_net-mergeable-XDP'
      Merge tag 'wireless-drivers-for-davem-2018-05-22' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge tag 'mlx5-fixes-2018-05-24' of git://git.kernel.org/.../saeed/linux
      Merge tag 'batadv-net-for-davem-20180524' of git://git.open-mesh.org/linux-merge
      Merge git://git.kernel.org/.../bpf/bpf

Dedy Lansky (1):
      nl80211: fix nlmsg allocation in cfg80211_ft_event

Eran Ben Elisha (1):
      net/mlx5e: When RXFCS is set, add FCS data into checksum calculation

Eric Biggers (2):
      cfg80211: further limit wiphy names to 64 bytes
      ppp: remove the PPPIOCDETACH ioctl

Eric Dumazet (1):
      ipmr: properly check rhltable_init() return value

Fabio Estevam (2):
      net: fec: ptp: Switch to SPDX identifier
      net: fec: Add a SPDX identifier

Florian Fainelli (2):
      net: phy: broadcom: Fix auxiliary control register reads
      net: phy: broadcom: Fix bcm_write_exp()

Govindarajulu Varadarajan (1):
      enic: set DMA mask to 47 bit

Haim Dreyfuss (1):
      cfg80211: fix NULL pointer derference when querying regdb

Jack Morgenstein (1):
      net/mlx4: Fix irq-unsafe spinlock usage

Jason Wang (6):
      virtio-net: correctly redirect linearized packet
      virtio-net: correctly transmit XDP buff after linearizing
      virtio-net: correctly check num_buf during err path
      virtio-net: fix leaking page for gso packet during mergeable XDP
      tuntap: correctly set SOCKWQ_ASYNC_NOSPACE
      vhost: synchronize IOTLB message with dev cleanup

Kalle Valo (3):
      MAINTAINERS: update Kalle's email address
      MAINTAINERS: change Kalle as ath.ko maintainer
      MAINTAINERS: change Kalle as wcn36xx maintainer

Linus Lüssing (1):
      batman-adv: Fix TT sync flags for intermediate TT responses

Marek Lindner (1):
      batman-adv: prevent TT request storms by not sending inconsistent TT TLVLs

Nathan Fontenot (1):
      ibmvnic: Only do H_EOI for mobility events

Or Gerlitz (1):
      net : sched: cls_api: deal with egdev path only if needed

Qing Huang (1):
      mlx4_core: allocate ICM memory in page size chunks

Rafał Miłecki (3):
      bcma: fix buffer size caused crash in bcma_core_mips_print_irq()
      Revert "ssb: Prevent build of PCI host features in module"
      ssb: make SSB_PCICORE_HOSTMODE depend on SSB = y

Roopa Prabhu (1):
      net: ipv4: add missing RTA_TABLE to rtm_ipv4_policy

Shahed Shaikh (1):
      qed: Fix mask for physical address in ILT entry

Stefano Brivio (1):
      selftests/net: Add missing config options for PMTU tests

Sven Eckelmann (1):
      batman-adv: Avoid race in TT TVLV allocator helper

Thomas Falcon (1):
      ibmvnic: Fix partial success login retries

Wenwen Wang (1):
      isdn: eicon: fix a missing-check bug

Willem de Bruijn (2):
      packet: fix reserve calculation
      ipv4: remove warning in ip_recv_error

Xin Long (1):
      sctp: fix the issue that flags are ignored when using kernel_connect

Yossi Kuperman (1):
      net/mlx5: IPSec, Fix a race between concurrent sandbox QP commands

 Documentation/networking/ppp_generic.txt             |  6 ------
 MAINTAINERS                                          |  8 ++++----
 drivers/bcma/driver_mips.c                           |  2 +-
 drivers/isdn/hardware/eicon/diva.c                   | 22 +++++++++++++++-------
 drivers/isdn/hardware/eicon/diva.h                   |  5 +++--
 drivers/isdn/hardware/eicon/divasmain.c              | 18 +++++++++++-------
 drivers/net/ethernet/amd/pcnet32.c                   | 10 +++++++---
 drivers/net/ethernet/cisco/enic/enic_main.c          |  8 ++++----
 drivers/net/ethernet/freescale/fec_main.c            |  1 +
 drivers/net/ethernet/freescale/fec_ptp.c             | 14 +-------------
 drivers/net/ethernet/ibm/ibmvnic.c                   | 22 +++++++++++++++-------
 drivers/net/ethernet/mellanox/mlx4/icm.c             | 16 +++++++++-------
 drivers/net/ethernet/mellanox/mlx4/intf.c            |  2 +-
 drivers/net/ethernet/mellanox/mlx4/qp.c              |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c | 12 +++++-------
 drivers/net/ethernet/qlogic/qed/qed_cxt.c            |  2 +-
 drivers/net/phy/bcm-cygnus.c                         |  6 +++---
 drivers/net/phy/bcm-phy-lib.c                        |  2 +-
 drivers/net/phy/bcm-phy-lib.h                        |  7 +++++++
 drivers/net/phy/bcm7xxx.c                            |  4 ++--
 drivers/net/ppp/ppp_generic.c                        | 27 +++++----------------------
 drivers/net/tun.c                                    | 19 +++++++++++++++----
 drivers/net/virtio_net.c                             | 21 ++++++++++-----------
 drivers/net/wireless/mac80211_hwsim.c                |  4 ++--
 drivers/ssb/Kconfig                                  |  4 ++--
 drivers/vhost/vhost.c                                |  3 +++
 include/linux/bpf_verifier.h                         |  2 +-
 include/net/sctp/sctp.h                              |  2 ++
 include/uapi/linux/nl80211.h                         |  2 +-
 include/uapi/linux/ppp-ioctl.h                       |  2 +-
 kernel/bpf/verifier.c                                | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 net/batman-adv/multicast.c                           |  2 +-
 net/batman-adv/translation-table.c                   | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 net/dccp/proto.c                                     |  2 --
 net/ipv4/fib_frontend.c                              |  1 +
 net/ipv4/ip_sockglue.c                               |  2 --
 net/ipv4/ipmr_base.c                                 |  5 ++++-
 net/mac80211/mesh_plink.c                            |  8 ++++----
 net/packet/af_packet.c                               |  2 +-
 net/sched/cls_api.c                                  |  2 +-
 net/sctp/ipv6.c                                      |  2 +-
 net/sctp/protocol.c                                  |  2 +-
 net/sctp/socket.c                                    | 51 +++++++++++++++++++++++++++++++++++----------------
 net/wireless/nl80211.c                               |  3 ++-
 net/wireless/reg.c                                   |  3 +++
 tools/testing/selftests/bpf/config                   |  2 ++
 tools/testing/selftests/net/config                   |  5 +++++
 tools/testing/selftests/net/reuseport_bpf_numa.c     |  4 +++-
 49 files changed, 372 insertions(+), 193 deletions(-)

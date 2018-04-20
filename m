Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754035AbeDTBR1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 21:17:27 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37588 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753703AbeDTBRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 21:17:25 -0400
Date: Thu, 19 Apr 2018 21:17:23 -0400 (EDT)
Message-Id: <20180419.211723.381614705810543855.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Unbalanced refcounting in TIPC, from Jon Maloy.

2) Only allow TCP_MD5SIG to be set on sockets in close or
   listen state.  Once the connection is established it makes
   no sense to change this.  From Eric Dumazet.

3) Missing attribute validation in neigh_dump_table(), also from Eric
   Dumazet.

4) Fix address comparisons in SCTP, from Xin Long.

5) Neigh proxy table clearing can deadlock, from Wolfgang
   Bumiller.

6) Fix tunnel refcounting in l2tp, from Guillaume Nault.

7) Fix double list insert in team driver, from Paolo Abeni.

8) af_vsock.ko module was accidently made unremovable, from
   Stefan Hajnoczi.

9) Fix reference to freed llc_sap object in llc stack, from
   Cong Wang.

10) Don't assume netdevice struct is DMA'able memory in virtio_net
    driver, from Michael S. Tsirkin.

Please pull, thanks a lot!

The following changes since commit 5d1365940a68dd57b031b6e3c07d7d451cd69daf:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-04-12 11:09:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 1255fcb2a655f05e02f3a74675a6d6525f187afd:

  net/smc: fix shutdown in state SMC_LISTEN (2018-04-19 16:38:39 -0400)

----------------------------------------------------------------
Anders Roxell (1):
      selftests: net: add in_netns.sh to TEST_PROGS

Bert Kenward (1):
      sfc: check RSS is active for filter insert

Bjørn Mork (1):
      tun: fix vlan packet truncation

Colin Ian King (2):
      net: caif: fix spelling mistake "UKNOWN" -> "UNKNOWN"
      atm: iphase: fix spelling mistake: "Tansmit" -> "Transmit"

Cong Wang (1):
      llc: hold llc_sap before release_sock()

Dan Carpenter (1):
      Revert "macsec: missing dev_put() on error in macsec_newlink()"

David S. Miller (6):
      Merge branch 'ibmvnic-Fix-parameter-change-request-handling'
      Merge branch 'nfp-improve-signal-handing-on-FW-waits-and-flower-control-message-Jakub Kicinski says:
      Merge branch 'l2tp-remove-unsafe-calls-to-l2tp_tunnel_find_nth'
      Merge branch 'sfc-ARFS-fixes'
      Merge branch 'tipc-Better-check-user-provided-attributes'
      Merge branch 'virtio-ctrl-buffer-fixes'

Doron Roberts-Kedes (1):
      strparser: Fix incorrect strp->need_bytes value.

Edward Cree (3):
      sfc: insert ARFS filters with replace_equal=true
      sfc: pass the correctly bogus filter_id to rps_may_expire_flow()
      sfc: limit ARFS workitems in flight per channel

Eric Biggers (1):
      KEYS: DNS: limit the length of option strings

Eric Dumazet (5):
      tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets
      net: validate attribute sizes in neigh_dump_table()
      net: af_packet: fix race in PACKET_{R|T}X_RING
      tipc: add policy for TIPC_NLA_NET_ADDR
      tipc: fix possible crash in __tipc_nl_net_set()

Gao Feng (1):
      net: Fix one possible memleak in ip_setup_cork

Guillaume Nault (3):
      l2tp: hold reference on tunnels in netlink dumps
      l2tp: hold reference on tunnels printed in pppol2tp proc file
      l2tp: hold reference on tunnels printed in l2tp/tunnels debugfs file

Jakub Kicinski (2):
      nfp: ignore signals when communicating with management FW
      nfp: print a message when mutex wait is interrupted

Jason Wang (1):
      virtio-net: add missing virtqueue kick when flushing packets

Jon Maloy (3):
      tipc: fix unbalanced reference counter
      tipc: fix missing initializer in tipc_sendmsg()
      tipc: fix use-after-free in tipc_nametbl_stop

Jonathan Corbet (1):
      MAINTAINERS: Direct networking documentation changes to netdev

Jose Abreu (1):
      net: stmmac: Disable ACS Feature for GMAC >= 4

Kees Cook (2):
      ibmvnic: Define vnic_login_client_data name field as unsized array
      net/tls: Remove VLA usage

Laura Abbott (1):
      mISDN: Remove VLAs

Maxime Chevallier (2):
      net: mvpp2: Fix TCAM filter reserved range
      net: mvpp2: Fix DMA address mask size

Michael S. Tsirkin (3):
      virtio_net: split out ctrl buffer
      virtio_net: fix adding vids on big-endian
      virtio_net: sparse annotation fix

Nathan Fontenot (2):
      ibmvnic: Handle all login error conditions
      ibmvnic: Do not notify peers on parameter change resets

Nicolas Dechesne (1):
      net: qrtr: add MODULE_ALIAS_NETPROTO macro

Olivier Gayot (1):
      docs: ip-sysctl.txt: fix name of some ipv6 variables

Paolo Abeni (1):
      team: avoid adding twice the same option to the event list

Pawel Dembicki (1):
      net: qmi_wwan: add Wistron Neweb D19Q1

Pieter Jansen van Vuuren (2):
      nfp: flower: move route ack control messages out of the workqueue
      nfp: flower: split and limit cmsg skb lists

Raghuram Chary J (1):
      lan78xx: PHY DSP registers initialization to address EEE link drop issues with long cables

Randy Dunlap (1):
      textsearch: fix kernel-doc warnings and add kernel-api section

Richard Cochran (1):
      net: dsa: mv88e6xxx: Fix receive time stamp race condition.

Ronak Doshi (1):
      vmxnet3: fix incorrect dereference when rxvlan is disabled

Soheil Hassas Yeganeh (1):
      tcp: clear tp->packets_out when purging write queue

Stefan Hajnoczi (1):
      VSOCK: make af_vsock.ko removable again

Subash Abhinov Kasiviswanathan (1):
      net: qualcomm: rmnet: Fix warning seen with fill_info

Thomas Falcon (1):
      ibmvnic: Clear pending interrupt after device reset

Toshiaki Makita (1):
      vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi

Tung Nguyen (1):
      tipc: fix infinite loop when dumping link monitor summary

Ursula Braun (1):
      net/smc: fix shutdown in state SMC_LISTEN

Vasundhara Volam (1):
      bnxt_en: Fix memory fault in bnxt_ethtool_init()

Wang Sheng-Hui (1):
      filter.txt: update 'tools/net/' to 'tools/bpf/'

Wolfgang Bumiller (1):
      net: fix deadlock while clearing neighbor proxy table

Xin Long (1):
      sctp: do not check port in sctp_inet6_cmp_addr

dann frazier (1):
      net: hns: Avoid action name truncation

sunlianwen (1):
      net: change the comment of dev_mc_init

 Documentation/core-api/kernel-api.rst                  |  13 ++++++
 Documentation/networking/filter.txt                    |   6 +--
 Documentation/networking/ip-sysctl.txt                 |   8 ++--
 MAINTAINERS                                            |   1 +
 drivers/atm/iphase.c                                   |   4 +-
 drivers/isdn/mISDN/dsp_hwec.c                          |   8 ++--
 drivers/isdn/mISDN/l1oip_core.c                        |  14 ++++--
 drivers/net/dsa/mv88e6xxx/hwtstamp.c                   |  12 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c      |  49 +++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt_nvm_defs.h     |   2 -
 drivers/net/ethernet/hisilicon/hns/hnae.h              |   2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                     |  85 +++++++++++++++++++++-------------
 drivers/net/ethernet/ibm/ibmvnic.h                     |   1 -
 drivers/net/ethernet/marvell/mvpp2.c                   |  14 +++---
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c       |  44 +++++++++++++++---
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h       |   2 +
 drivers/net/ethernet/netronome/nfp/flower/main.c       |   6 ++-
 drivers/net/ethernet/netronome/nfp/flower/main.h       |   8 +++-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_mutex.c |   5 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c   |   3 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c     |  11 +++--
 drivers/net/ethernet/sfc/ef10.c                        |   7 ++-
 drivers/net/ethernet/sfc/farch.c                       |   2 +-
 drivers/net/ethernet/sfc/net_driver.h                  |  25 ++++++++++
 drivers/net/ethernet/sfc/rx.c                          |  60 ++++++++++++------------
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h           |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c      |   7 ---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c      |   7 ++-
 drivers/net/macsec.c                                   |   5 +-
 drivers/net/phy/microchip.c                            | 178 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/team/team.c                                |  19 ++++++++
 drivers/net/tun.c                                      |   7 +--
 drivers/net/usb/qmi_wwan.c                             |   1 +
 drivers/net/virtio_net.c                               |  79 +++++++++++++++++++-------------
 drivers/net/vmxnet3/vmxnet3_drv.c                      |  17 +++++--
 drivers/net/vmxnet3/vmxnet3_int.h                      |   4 +-
 include/linux/if_vlan.h                                |   7 ++-
 include/linux/microchipphy.h                           |   8 ++++
 include/linux/textsearch.h                             |   4 +-
 lib/textsearch.c                                       |  40 +++++++++-------
 net/caif/chnl_net.c                                    |   2 +-
 net/core/dev.c                                         |   2 +-
 net/core/dev_addr_lists.c                              |   2 +-
 net/core/neighbour.c                                   |  40 ++++++++++------
 net/dns_resolver/dns_key.c                             |  12 ++---
 net/ipv4/ip_output.c                                   |   8 ++--
 net/ipv4/tcp.c                                         |   8 ++--
 net/l2tp/l2tp_core.c                                   |  40 ++++++++--------
 net/l2tp/l2tp_core.h                                   |   3 +-
 net/l2tp/l2tp_debugfs.c                                |  15 +++++-
 net/l2tp/l2tp_netlink.c                                |  11 +++--
 net/l2tp/l2tp_ppp.c                                    |  24 +++++++---
 net/llc/af_llc.c                                       |   7 +++
 net/packet/af_packet.c                                 |  23 ++++++----
 net/qrtr/qrtr.c                                        |   1 +
 net/sctp/ipv6.c                                        |  60 ++++++++++++------------
 net/smc/af_smc.c                                       |  10 ++--
 net/strparser/strparser.c                              |   7 ++-
 net/tipc/monitor.c                                     |   2 +-
 net/tipc/name_table.c                                  |  34 ++++++++------
 net/tipc/name_table.h                                  |   2 +-
 net/tipc/net.c                                         |   2 +
 net/tipc/netlink.c                                     |   5 +-
 net/tipc/node.c                                        |  11 ++---
 net/tipc/socket.c                                      |   4 +-
 net/tipc/subscr.c                                      |   5 +-
 net/tls/tls_sw.c                                       |  10 +++-
 net/vmw_vsock/af_vsock.c                               |   6 +++
 tools/testing/selftests/net/Makefile                   |   2 +-
 69 files changed, 786 insertions(+), 349 deletions(-)

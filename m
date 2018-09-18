Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC38BECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF832083A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF832083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeIRIbI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:31:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRIbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:31:08 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7A87E100A4B75;
        Mon, 17 Sep 2018 20:00:41 -0700 (PDT)
Date:   Mon, 17 Sep 2018 20:00:40 -0700 (PDT)
Message-Id: <20180917.200040.1595079540584326114.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 20:00:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Various fixes, all over the place:

1) OOB data generation fix in bluetooth, from Matias Karhumaa.

2) BPF BTF boundary calculation fix, from Martin KaFai Lau.

3) Don't bug on excessive frags, to be compatible in situations mixing
   older and newer kernels on each end.  From Juergen Gross.

4) Scheduling in RCU fix in hv_netvsc, from Stephen Hemminger.

5) Zero keying information in TLS layer before freeing copies
   of them, from Sabrina Dubroca.

6) Fix NULL deref in act_sample, from Davide Caratti.

7) Orphan SKB before GRO in veth to prevent crashes with XDP,
   from Toshiaki Makita.

8) Fix use after free in ip6_xmit, from Eric Dumazet.

9) Fix VF mac address regression in bnxt_en, from Micahel Chan.

10) Fix MSG_PEEK behavior in TLS layer, from Daniel Borkmann.

11) Programming adjustments to r8169 which fix not being to enter deep
    sleep states on some machines, from Kai-Heng Feng and Hans de
    Goede.

12) Fix DST_NOCOUNT flag handling for ipv6 routes, from Peter
    Oskolkov.

Please pull, thanks a lot!

The following changes since commit 7428b2e5d0b195f2a5e40f91d2b41a8503fcfe68:

  Merge tag 'drm-fixes-2018-09-12' of git://anongit.freedesktop.org/drm/drm (2018-09-12 17:36:47 -1000)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 30bfd93062814d6767e452a8f5ddcd97f7e38c7e:

  net/ipv6: do not copy dst flags on rt init (2018-09-17 19:42:14 -0700)

----------------------------------------------------------------
Alexei Starovoitov (1):
      bpf/verifier: disallow pointer subtraction

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix ATU Miss Violation

Antoine Tenart (1):
      net: mvpp2: let phylink manage the carrier state

Bjørn Mork (1):
      qmi_wwan: set DTR for modems in forced USB2 mode

Colin Ian King (1):
      net: hp100: fix always-true check for link up state

Cong Wang (1):
      net_sched: notify filter deletion when deleting a chain

Corentin Labbe (1):
      net: ethernet: ti: add missing GENERIC_ALLOCATOR dependency

Daniel Borkmann (1):
      tls: fix currently broken MSG_PEEK behavior

David S. Miller (7):
      Merge branch 'tls-don-t-leave-keys-in-kernel-memory'
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth
      Merge branch 'udp-add-missing-check-on-edumx-rx-path'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'hv_netvsc-associate-VF-and-PV-device-by-serial-number'
      Revert "kcm: remove any offset before parsing messages"
      Merge branch 'r8169-clk-fixes'

Davide Caratti (1):
      net/sched: act_sample: fix NULL dereference in the data path

Dominique Martinet (1):
      kcm: remove any offset before parsing messages

Eric Dumazet (1):
      ipv6: fix possible use-after-free in ip6_xmit()

Guillaume Nault (1):
      pppoe: fix reception of frames with no mac header

Hans de Goede (3):
      clk: x86: add "ether_clk" alias for Bay Trail / Cherry Trail
      r8169: Get and enable optional ether_clk clock
      clk: x86: Stop marking clocks as CLK_IS_CRITICAL

Hermes Zhang (1):
      Bluetooth: hci_ldisc: Free rw_semaphore on close

Johan Hedberg (1):
      Bluetooth: SMP: Fix trying to use non-existent local OOB data

Johannes Berg (1):
      socket: fix struct ifreq size in compat ioctl

Jongsung Kim (1):
      stmmac: fix valid numbers of unicast filter entries

Juergen Gross (1):
      xen/netfront: don't bug in case of too many frags

Kai-Heng Feng (2):
      r8169: Align ASPM/CLKREQ setting function with vendor driver
      r8169: enable ASPM on RTL8106E

Martin KaFai Lau (1):
      bpf: btf: Fix end boundary calculation for type section

Matias Karhumaa (1):
      Bluetooth: Use correct tfm to generate OOB data

Michael Chan (1):
      bnxt_en: Fix VF mac address regression.

Nicolas Ferre (2):
      net: macb: disable scatter-gather for macb on sama5d3
      ARM: dts: at91: add new compatibility string for macb on sama5d3

Paolo Abeni (2):
      udp4: fix IP_CMSG_CHECKSUM for connected sockets
      udp6: add missing checks on edumux packet processing

Peter Oskolkov (1):
      net/ipv6: do not copy dst flags on rt init

Roopa Prabhu (1):
      net: rtnl_configure_link: fix dev flags changes arg to __dev_notify_flags

Sabrina Dubroca (3):
      tls: don't copy the key out of tls12_crypto_info_aes_gcm_128
      tls: zero the crypto information from tls_context before freeing
      tls: clear key material from kernel memory when do_tls_setsockopt_conf fails

Stephen Hemminger (3):
      hv_netvsc: fix schedule in RCU context
      PCI: hv: support reporting serial number as slot information
      hv_netvsc: pair VF based on serial number

Toke Høiland-Jørgensen (1):
      gso_segment: Reset skb->mac_len after modifying network header

Toshiaki Makita (1):
      veth: Orphan skb before GRO

Tushar Dave (1):
      bpf: use __GFP_COMP while allocating page

Vasily Khoruzhick (1):
      neighbour: confirm neigh entries when ARP packet is received

Willy Tarreau (1):
      net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT

Xin Long (1):
      ipv6: use rt6_info members when dst is set in rt6_fill_node

zhong jiang (1):
      net: ethernet: Fix a unused function warning.

 Documentation/devicetree/bindings/net/macb.txt        |  1 +
 arch/arm/boot/dts/sama5d3_emac.dtsi                   |  2 +-
 drivers/bluetooth/hci_ldisc.c                         |  2 ++
 drivers/clk/x86/clk-pmc-atom.c                        | 18 +++++++++++-------
 drivers/net/appletalk/ipddp.c                         |  8 ++++++--
 drivers/net/dsa/mv88e6xxx/global1.h                   |  2 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c               |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c             |  9 +++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c       |  9 +++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h       |  2 +-
 drivers/net/ethernet/cadence/macb_main.c              |  8 ++++++++
 drivers/net/ethernet/hp/hp100.c                       |  2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c       | 21 ++++++---------------
 drivers/net/ethernet/microchip/lan743x_main.c         |  6 +++---
 drivers/net/ethernet/realtek/r8169.c                  | 40 +++++++++++++++++++++++++++++++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  5 ++---
 drivers/net/ethernet/ti/Kconfig                       |  1 +
 drivers/net/hyperv/netvsc.c                           |  3 +++
 drivers/net/hyperv/netvsc_drv.c                       | 67 ++++++++++++++++++++++++++++++++++++-------------------------------
 drivers/net/ppp/pppoe.c                               |  3 +++
 drivers/net/usb/qmi_wwan.c                            | 14 +++++++-------
 drivers/net/veth.c                                    |  4 ++--
 drivers/net/xen-netfront.c                            |  8 +++++++-
 drivers/pci/controller/pci-hyperv.c                   | 37 +++++++++++++++++++++++++++++++++++++
 include/net/tls.h                                     | 19 +++++++++----------
 kernel/bpf/btf.c                                      |  2 +-
 kernel/bpf/verifier.c                                 |  2 +-
 net/bluetooth/smp.c                                   | 16 +++++++++++++---
 net/core/filter.c                                     |  3 ++-
 net/core/neighbour.c                                  | 13 ++++++++-----
 net/core/rtnetlink.c                                  |  2 +-
 net/ipv4/af_inet.c                                    |  1 +
 net/ipv4/udp.c                                        | 49 ++++++++++++++++++++++++++-----------------------
 net/ipv6/ip6_offload.c                                |  1 +
 net/ipv6/ip6_output.c                                 |  6 ++----
 net/ipv6/route.c                                      | 44 ++++++++++++++++++++++++++++++--------------
 net/ipv6/udp.c                                        | 65 +++++++++++++++++++++++++++++++++++++----------------------------
 net/sched/act_sample.c                                |  2 +-
 net/sched/cls_api.c                                   |  2 ++
 net/socket.c                                          | 22 ++++++++++++++--------
 net/tls/tls_device.c                                  |  6 +++---
 net/tls/tls_device_fallback.c                         |  2 +-
 net/tls/tls_main.c                                    | 22 ++++++++++++++++------
 net/tls/tls_sw.c                                      | 21 +++++++++++++--------
 tools/testing/selftests/net/tls.c                     | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 45 files changed, 422 insertions(+), 201 deletions(-)

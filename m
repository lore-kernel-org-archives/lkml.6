Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CYJzB373G1sLBgAAmS7hNA
	; Sat, 09 Jun 2018 15:52:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D05F9608C1; Sat,  9 Jun 2018 15:52:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vv2x33PH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1AC8B606FA;
	Sat,  9 Jun 2018 15:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AC8B606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeFIPwB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932136AbeFIPbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:31:42 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 673B420896;
        Sat,  9 Jun 2018 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558302;
        bh=znBoMNbbZxaAw446y4sWkS9rSCGqV/UdNOh/8FUlBGY=;
        h=From:To:Cc:Subject:Date:From;
        b=vv2x33PHdAuvwkWryS3TAJ5mcwkv3khtIzP/3Sey3REScdGpJWfPRwm7U2lvH3u02
         Zvz3u6TuInEgNG08pQVUy9tdn8dPQ4irEBdcSnrV05Yp1fnvVWB85l++M7KujPZWNJ
         V5mUJlRjftFNiWW+EVN4WhDar5ZhM6vzyUIzlZT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 00/48] 4.16.15-stable review
Date: Sat,  9 Jun 2018 17:29:12 +0200
Message-Id: <20180609145947.679103414@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.15-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.15-rc1
X-KernelTest-Deadline: 2018-06-11T14:59+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.16.15 release.
There are 48 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Jun 11 14:59:28 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.15-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.15-rc1

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Do not wait forever on a device that has disappeared

Jason Wang <jasowang@redhat.com>
    vhost_net: flush batched heads before trying to busy polling

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    net: netsec: reduce DMA mask to 40 bits

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    ip_tunnel: restore binding to ifaces with a large mtu

Jason Wang <jasowang@redhat.com>
    virtio-net: correctly redirect linearized packet

Or Gerlitz <ogerlitz@mellanox.com>
    net : sched: cls_api: deal with egdev path only if needed

Arun Parameswaran <arun.parameswaran@broadcom.com>
    net: dsa: b53: Fix for brcm tag issue in Cygnus SoC

Jason Wang <jasowang@redhat.com>
    virtio-net: correctly check num_buf during err path

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    tun: Fix NULL pointer dereference in XDP redirect

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx5e: When RXFCS is set, add FCS data into checksum calculation

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4: Fix irq-unsafe spinlock usage

Jason Wang <jasowang@redhat.com>
    virtio-net: fix leaking page for gso packet during mergeable XDP

Jason Wang <jasowang@redhat.com>
    virtio-net: correctly transmit XDP buff after linearizing

Alexander Duyck <alexander.h.duyck@intel.com>
    net-sysfs: Fix memory leak in XPS configuration

Florian Fainelli <f.fainelli@gmail.com>
    net: phy: broadcom: Fix auxiliary control register reads

Mathieu Xhonneux <m.xhonneux@gmail.com>
    ipv6: sr: fix memory OOB access in seg6_do_srh_encap/inline

Stephen Suryaputra <ssuryaextr@gmail.com>
    vrf: check the original netdevice for generating redirect

Jason Wang <jasowang@redhat.com>
    vhost: synchronize IOTLB message with dev cleanup

Dan Carpenter <dan.carpenter@oracle.com>
    team: use netdev_features_t instead of u32

Xin Long <lucien.xin@gmail.com>
    sctp: not allow transport timeout value less than HZ/5 for hb_timer

Eric Dumazet <edumazet@google.com>
    rtnetlink: validate attributes in do_setlink()

Shahed Shaikh <shahed.shaikh@cavium.com>
    qed: Fix mask for physical address in ILT entry

Willem de Bruijn <willemb@google.com>
    packet: fix reserve calculation

Daniele Palmas <dnlplm@gmail.com>
    net: usb: cdc_mbim: add flag FLAG_SEND_ZLP

Florian Fainelli <f.fainelli@gmail.com>
    net: phy: broadcom: Fix bcm_write_exp()

Eric Dumazet <edumazet@google.com>
    net/packet: refine check for priv area size

Eric Dumazet <edumazet@google.com>
    net: metrics: add proper netlink validation

Roopa Prabhu <roopa@cumulusnetworks.com>
    net: ipv4: add missing RTA_TABLE to rtm_ipv4_policy

Dan Carpenter <dan.carpenter@oracle.com>
    net: ethernet: davinci_emac: fix error handling in probe()

Cong Wang <xiyou.wangcong@gmail.com>
    netdev-FAQ: clarify DaveM's position for stable backports

Petr Machata <petrm@mellanox.com>
    mlxsw: spectrum: Forbid creation of VLAN 1 over port/LAG

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: fix refcount leakage on PPPoL2TP sockets

Kirill Tkhai <ktkhai@virtuozzo.com>
    kcm: Fix use-after-free caused by clonned sockets

Wenwen Wang <wang6495@umn.edu>
    isdn: eicon: fix a missing-check bug

Michal Kubecek <mkubecek@suse.cz>
    ipv6: omit traffic class when calculating flow hash

Willem de Bruijn <willemb@google.com>
    ipv4: remove warning in ip_recv_error

Eric Dumazet <edumazet@google.com>
    ipmr: properly check rhltable_init() return value

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    ip6_tunnel: remove magic mtu value 0xFFF8

Sabrina Dubroca <sd@queasysnail.net>
    ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succeeds

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: set DMA mask to 47 bit

Alexey Kodanev <alexey.kodanev@oracle.com>
    dccp: don't free ccid2_hc_tx_sock struct in dccp_disconnect()

Paul Blakey <paulb@mellanox.com>
    cls_flower: Fix incorrect idr release when failing to modify rule

Julia Lawall <Julia.Lawall@lip6.fr>
    bnx2x: use the right constant

Suresh Reddy <suresh.reddy@broadcom.com>
    be2net: Fix error detection logic for BE3

Nathan Chancellor <natechancellor@gmail.com>
    kconfig: Avoid format overflow warning from GCC 8.1

Jason A. Donenfeld <Jason@zx2c4.com>
    netfilter: nf_flow_table: attach dst to skbs

Linus Torvalds <torvalds@linux-foundation.org>
    mmap: relax file size limit for regular files

Linus Torvalds <torvalds@linux-foundation.org>
    mmap: introduce sane default mmap limits


-------------

Diffstat:

 Documentation/networking/netdev-FAQ.txt          |  9 +++++
 Makefile                                         |  4 +--
 drivers/isdn/hardware/eicon/diva.c               | 22 ++++++++----
 drivers/isdn/hardware/eicon/diva.h               |  5 +--
 drivers/isdn/hardware/eicon/divasmain.c          | 18 ++++++----
 drivers/net/dsa/b53/b53_common.c                 | 15 +++++++-
 drivers/net/dsa/b53/b53_priv.h                   |  2 ++
 drivers/net/dsa/b53/b53_srab.c                   |  4 +--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c |  2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c      |  8 ++---
 drivers/net/ethernet/emulex/benet/be_main.c      |  4 ++-
 drivers/net/ethernet/mellanox/mlx4/qp.c          |  4 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c  | 42 ++++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c   |  5 +++
 drivers/net/ethernet/qlogic/qed/qed_cxt.c        |  2 +-
 drivers/net/ethernet/socionext/netsec.c          |  4 +--
 drivers/net/ethernet/ti/davinci_emac.c           | 22 ++++++------
 drivers/net/phy/bcm-cygnus.c                     |  6 ++--
 drivers/net/phy/bcm-phy-lib.c                    |  2 +-
 drivers/net/phy/bcm-phy-lib.h                    |  7 ++++
 drivers/net/phy/bcm7xxx.c                        |  4 +--
 drivers/net/team/team.c                          |  3 +-
 drivers/net/tun.c                                | 15 ++++----
 drivers/net/usb/cdc_mbim.c                       |  2 +-
 drivers/net/virtio_net.c                         | 21 ++++++-----
 drivers/pci/host/pci-hyperv.c                    | 46 +++++++++++++++++-------
 drivers/vhost/net.c                              | 37 ++++++++++++-------
 drivers/vhost/vhost.c                            |  3 ++
 include/net/ipv6.h                               |  5 +++
 mm/mmap.c                                        | 32 +++++++++++++++++
 net/core/flow_dissector.c                        |  2 +-
 net/core/net-sysfs.c                             |  6 ++--
 net/core/rtnetlink.c                             |  8 ++---
 net/dccp/proto.c                                 |  2 --
 net/ipv4/fib_frontend.c                          |  1 +
 net/ipv4/fib_semantics.c                         |  4 +++
 net/ipv4/ip_sockglue.c                           |  2 --
 net/ipv4/ip_tunnel.c                             |  8 ++---
 net/ipv4/ipmr.c                                  |  7 +++-
 net/ipv4/netfilter/nf_flow_table_ipv4.c          |  5 +--
 net/ipv6/ip6_output.c                            |  3 +-
 net/ipv6/ip6_tunnel.c                            | 11 ++++--
 net/ipv6/ip6mr.c                                 |  3 +-
 net/ipv6/ndisc.c                                 |  6 ++++
 net/ipv6/netfilter/nf_flow_table_ipv6.c          |  1 +
 net/ipv6/route.c                                 |  2 +-
 net/ipv6/seg6_iptunnel.c                         |  4 +--
 net/ipv6/sit.c                                   |  5 +--
 net/kcm/kcmsock.c                                |  2 +-
 net/l2tp/l2tp_ppp.c                              | 35 +++++++++---------
 net/packet/af_packet.c                           |  4 +--
 net/sched/cls_api.c                              |  2 +-
 net/sched/cls_flower.c                           |  2 +-
 net/sctp/transport.c                             |  2 +-
 scripts/kconfig/confdata.c                       |  2 +-
 55 files changed, 338 insertions(+), 146 deletions(-)

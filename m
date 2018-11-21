Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7908C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6C1214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="onHFuLNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6C1214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbeKVFmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730172AbeKVFmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29357206BB;
        Wed, 21 Nov 2018 19:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827207;
        bh=IG6+8tdUYO4dIuHyGIcmjoYb6yxnmvFuv2yqN04OOVc=;
        h=From:To:Cc:Subject:Date:From;
        b=onHFuLNGmumtNotcpTW5LRSqhma39ZNm4//+aG9JZCMoSvzIyBBqpOm0Ub3DVPzUF
         OXCHrO/70727888AR78zjveY6bDACLDOtO9/01cVJN4GpFqKQV7nZhSpLTPw9/2PLa
         0mx+YqOfhhuXbMYdjUm8FyEsZ3mkJZot+fe4+Ow8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/42] 4.19.4-stable review
Date:   Wed, 21 Nov 2018 20:05:36 +0100
Message-Id: <20181121183147.869199006@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.4-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.4-rc1
X-KernelTest-Deadline: 2018-11-23T18:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.4 release.
There are 42 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Nov 23 18:31:31 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.4-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.4-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation"

Frieder Schrempf <frieder.schrempf@kontron.de>
    usbnet: smsc95xx: disable carrier check while suspending

David Howells <dhowells@redhat.com>
    rxrpc: Fix lockup due to no error backoff after ack transmit error

Stefan Wahren <stefan.wahren@i2se.com>
    net: smsc95xx: Fix MTU range

Shalom Toledo <shalomt@mellanox.com>
    mlxsw: spectrum: Fix IP2ME CPU policer configuration

Xin Long <lucien.xin@gmail.com>
    sctp: not increase stream's incnt before sending addstrm_in request

Martin Schiller <ms@dev.tdt.de>
    net: phy: mdio-gpio: Fix working over slow can_sleep GPIOs

Xin Long <lucien.xin@gmail.com>
    sctp: fix strchange_flags name for Stream Change Event

Tristram Ha <Tristram.Ha@microchip.com>
    net: dsa: microchip: initialize mutex before use

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    net: qualcomm: rmnet: Fix incorrect assignment of real_dev

Xin Long <lucien.xin@gmail.com>
    sctp: define SCTP_SS_DEFAULT for Stream schedulers

Holger Hoffstätte <holger@applied-asynchrony.com>
    net: phy: realtek: fix RTL8201F sysfs name

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Fix clearing of stats counters

Denis Drozdov <denisd@mellanox.com>
    net/mlx5e: IPoIB, Reset QP after channels are closed

Raed Salem <raeds@mellanox.com>
    net/mlx5: IPSec, Fix the SA context hash key

Xin Long <lucien.xin@gmail.com>
    l2tp: fix a sock refcnt leak in l2tp_tunnel_register

Eric Dumazet <edumazet@google.com>
    inet: frags: better deal with smp races

Shay Agroskin <shayag@mellanox.com>
    net/mlx5e: Removed unnecessary warnings in FEC caps query

Valentine Fatiev <valentinef@mellanox.com>
    net/mlx5e: Fix selftest for small MTUs

Or Gerlitz <ogerlitz@mellanox.com>
    net/mlx5e: Always use the match level enum when parsing TC rule match

Xin Long <lucien.xin@gmail.com>
    Revert "sctp: remove sctp_transport_pmtu_check"

Moshe Shemesh <moshe@mellanox.com>
    net/mlx5e: RX, verify received packet size in Linear Striding RQ

Yuval Avnery <yuvalav@mellanox.com>
    net/mlx5e: Adjust to max number of channles when re-attaching

Or Gerlitz <ogerlitz@mellanox.com>
    net/mlx5e: Claim TC hw offloads support only under a proper build config

Or Gerlitz <ogerlitz@mellanox.com>
    net/mlx5e: Don't match on vlan non-existence if ethertype is wildcarded

Jon Maloy <donmalo99@gmail.com>
    tipc: fix link re-establish failure

Jakub Kicinski <jakub.kicinski@netronome.com>
    net: sched: cls_flower: validate nested enc_opts_policy to avoid warning

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_pedit: fix memory leak when IDR allocation fails

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Protect stop from timeout

Matthew Cover <werekraken@gmail.com>
    tuntap: fix multiqueue rx

Jon Maloy <donmalo99@gmail.com>
    tipc: fix lockdep warning when reinitilaizing sockets

Jon Maloy <donmalo99@gmail.com>
    tipc: don't assume linear buffer when reading ancillary data

Siva Reddy Kallam <siva.kallam@broadcom.com>
    tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control paths

Stephen Mallon <stephen.mallon@sydney.edu.au>
    tcp: Fix SOF_TIMESTAMPING_RX_HARDWARE to use the latest timestamp during TCP coalescing

Xin Long <lucien.xin@gmail.com>
    sctp: not allow to set asoc prsctp_enable by sockopt

Eric Dumazet <edumazet@google.com>
    net-gro: reset skb->pkt_type in napi_reuse_skb()

Doug Berger <opendmb@gmail.com>
    net: bcmgenet: protect stop from timeout

David Ahern <dsahern@gmail.com>
    ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF

Xin Long <lucien.xin@gmail.com>
    ipv6: fix a dst leak when removing its exception

Sabrina Dubroca <sd@queasysnail.net>
    ip_tunnel: don't force DF when MTU is locked

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    ibmvnic: fix accelerated VLAN handling

배석진 <soukjin.bae@samsung.com>
    flow_dissector: do not dissect l4 ports for fragments


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/x86/kernel/cpu/bugs.c                         | 57 ++----------------
 drivers/net/dsa/microchip/ksz_common.c             | 10 ++--
 drivers/net/dsa/mv88e6xxx/global1.c                |  2 +
 drivers/net/ethernet/broadcom/bcmsysport.c         | 15 +++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 13 +++--
 drivers/net/ethernet/broadcom/tg3.c                | 18 +++++-
 drivers/net/ethernet/ibm/ibmvnic.c                 |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c  |  4 +-
 .../ethernet/mellanox/mlx5/core/en/port_buffer.c   |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 37 ++++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  6 ++
 .../net/ethernet/mellanox/mlx5/core/en_selftest.c  | 26 ++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  3 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 67 +++++++++++-----------
 .../net/ethernet/mellanox/mlx5/core/fpga/ipsec.c   | 10 +++-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  1 -
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c    |  6 +-
 drivers/net/phy/mdio-gpio.c                        | 10 ++--
 drivers/net/phy/realtek.c                          |  2 +-
 drivers/net/tun.c                                  |  6 +-
 drivers/net/usb/smsc95xx.c                         |  9 +++
 include/net/sctp/sctp.h                            | 12 ++++
 include/uapi/linux/sctp.h                          |  3 +
 kernel/cpu.c                                       | 11 +---
 net/core/dev.c                                     |  4 ++
 net/core/flow_dissector.c                          |  4 +-
 net/ipv4/inet_fragment.c                           | 29 +++++-----
 net/ipv4/ip_tunnel_core.c                          |  2 +-
 net/ipv4/tcp_input.c                               |  1 +
 net/ipv6/route.c                                   | 14 +++--
 net/l2tp/l2tp_core.c                               |  9 ++-
 net/rxrpc/ar-internal.h                            |  1 +
 net/rxrpc/call_event.c                             | 18 ++++--
 net/rxrpc/output.c                                 | 35 +++++++++--
 net/sched/act_pedit.c                              |  3 +-
 net/sched/cls_flower.c                             | 14 ++++-
 net/sctp/output.c                                  |  3 +
 net/sctp/outqueue.c                                |  2 +-
 net/sctp/socket.c                                  | 26 ++-------
 net/sctp/stream.c                                  |  1 -
 net/tipc/discover.c                                | 19 +++---
 net/tipc/link.c                                    | 11 ++--
 net/tipc/net.c                                     | 45 ++++++++++++---
 net/tipc/net.h                                     |  2 +-
 net/tipc/socket.c                                  | 15 +++--
 49 files changed, 356 insertions(+), 245 deletions(-)



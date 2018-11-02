Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66573C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9BC20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/IXLJmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9BC20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeKCDoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbeKCDoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:44:38 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0217D2081B;
        Fri,  2 Nov 2018 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183787;
        bh=DJcgG2VGNE3eK8cB3oWLw9iQb90rLGWbYv/h/49pTak=;
        h=From:To:Cc:Subject:Date:From;
        b=h/IXLJmR5d8znpHyNpCoBdzeLZVkVjFXQBbCj1+KchrbKbHrm2MjiH6WXnhu+SP+X
         +kmSbwW6/AzGPMiWN7KUlue0G8/g10FkhpiblvClDoo89kx/ciwoIT3VosJxbse1V9
         +Iw66/5Ax0L87n91y1/XV3JAaQ7UFJ7HyNs2gDKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/24] 4.19.1-stable review
Date:   Fri,  2 Nov 2018 19:34:33 +0100
Message-Id: <20181102182839.725385066@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.1-rc1
X-KernelTest-Deadline: 2018-11-04T18:28+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.1 release.
There are 24 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Nov  4 18:28:10 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.1-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.1-rc1

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: remove ipv6 zero address check in mcast queries

David S. Miller <davem@davemloft.net>
    sparc64: Wire up compat getpeername and getsockname.

David Miller <davem@redhat.com>
    sparc64: Make corrupted user stacks more debuggable.

David S. Miller <davem@davemloft.net>
    sparc64: Export __node_distance.

Xin Long <lucien.xin@gmail.com>
    sctp: check policy more carefully when getting pr status

Ivan Vecera <ivecera@redhat.com>
    Revert "be2net: remove desc field from be_eq_obj"

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix broken Wake-on-LAN from S5 (poweroff)

David S. Miller <davem@davemloft.net>
    net: Properly unlink GRO packets on overflow.

Cong Wang <xiyou.wangcong@gmail.com>
    net: drop skb on failure in ip_check_defrag()

Shalom Toledo <shalomt@mellanox.com>
    mlxsw: core: Fix devlink unregister flow

Petr Machata <petrm@mellanox.com>
    mlxsw: spectrum_switchdev: Don't ignore deletions of learned MACs

Karsten Graul <kgraul@linux.ibm.com>
    net/smc: fix smc_buf_unuse to use the lgr pointer

David Ahern <dsahern@gmail.com>
    net/ipv6: Allow onlink routes to have a device mismatch if it is the default route

Jaime Caamaño Ruiz <jcaamano@suse.com>
    openvswitch: Fix push/pop ethernet validation

Tobias Jungel <tobias.jungel@gmail.com>
    bonding: fix length of actor system

Jason Wang <jasowang@redhat.com>
    vhost: Fix Spectre V1 vulnerability

Ido Schimmel <idosch@mellanox.com>
    rtnetlink: Disallow FDB configuration for non-Ethernet device

Karsten Graul <kgraul@linux.ibm.com>
    Revert "net: simplify sock_poll_wait"

Sean Tranchetti <stranche@codeaurora.org>
    net: udp: fix handling of CHECKSUM_COMPLETE packets

Niklas Cassel <niklas.cassel@linaro.org>
    net: stmmac: Fix stmmac_mdio_reset() when building stmmac as modules

Jakub Kicinski <jakub.kicinski@netronome.com>
    net: sched: gred: pass the right attribute to gred_change_table_def()

Eric Dumazet <edumazet@google.com>
    net/mlx5e: fix csum adjustments caused by RXFCS

Stefano Brivio <sbrivio@redhat.com>
    ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers are called

Hangbin Liu <liuhangbin@gmail.com>
    bridge: do not add port to router list when receives query with source 0.0.0.0


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/sparc/include/asm/switch_to_64.h              |  3 +-
 arch/sparc/kernel/process_64.c                     | 25 +++++++++---
 arch/sparc/kernel/rtrap_64.S                       |  1 +
 arch/sparc/kernel/signal32.c                       | 12 +++++-
 arch/sparc/kernel/signal_64.c                      |  6 ++-
 arch/sparc/kernel/systbls_64.S                     |  4 +-
 arch/sparc/mm/init_64.c                            |  1 +
 crypto/af_alg.c                                    |  2 +-
 drivers/net/bonding/bond_netlink.c                 |  3 +-
 drivers/net/ethernet/emulex/benet/be.h             |  1 +
 drivers/net/ethernet/emulex/benet/be_main.c        |  6 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 45 +++++-----------------
 drivers/net/ethernet/mellanox/mlxsw/core.c         | 24 ++++++++----
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  2 -
 drivers/net/ethernet/realtek/r8169.c               |  9 ++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  2 +-
 drivers/vhost/vhost.c                              |  2 +
 include/net/sock.h                                 | 12 ++++--
 net/atm/common.c                                   |  2 +-
 net/bridge/br_multicast.c                          |  9 ++++-
 net/caif/caif_socket.c                             |  2 +-
 net/core/datagram.c                                |  7 ++--
 net/core/dev.c                                     |  1 +
 net/core/rtnetlink.c                               | 10 +++++
 net/dccp/proto.c                                   |  2 +-
 net/ipv4/ip_fragment.c                             | 12 ++++--
 net/ipv4/tcp.c                                     |  2 +-
 net/ipv4/udp.c                                     | 20 +++++++++-
 net/ipv6/ip6_checksum.c                            | 20 +++++++++-
 net/ipv6/ndisc.c                                   |  3 +-
 net/ipv6/route.c                                   |  2 +
 net/iucv/af_iucv.c                                 |  2 +-
 net/nfc/llcp_sock.c                                |  2 +-
 net/openvswitch/flow_netlink.c                     |  4 +-
 net/rxrpc/af_rxrpc.c                               |  2 +-
 net/sched/sch_gred.c                               |  2 +-
 net/sctp/socket.c                                  |  8 ++--
 net/smc/af_smc.c                                   |  2 +-
 net/smc/smc_core.c                                 | 25 ++++++------
 net/tipc/socket.c                                  |  2 +-
 net/unix/af_unix.c                                 |  4 +-
 tools/testing/selftests/net/fib-onlink-tests.sh    | 14 +++----
 43 files changed, 200 insertions(+), 123 deletions(-)



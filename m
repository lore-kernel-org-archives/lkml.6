Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1351814-1522346530-2-15664975310551016815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522346527; b=qMtk3TDMbAxGmIGaQFkiNFc83tN7+EYOhLxPzbIDT25olpHsDa
    qfaHIy5hjSDqA8irUNkqSP2b8huVGf7v5JsoPkFRCEH8OlTvLodO9ljunBtcvY+y
    JJ1v4jXmQwlSJdYWm61y0NBdMJ3DKV6kWvkhh1Y4EMNLa78bTRHT4kvXfnEBXNWF
    XOL5yFHh8VBjS4wjr/n9rbCvXZU7htMNbiS+fniNrYRvXa39sJ9M2bztED678cXH
    +rZsvhVQdoaTUTX9qwgQne2WylGcfdjo/9BXiNKLMONYm7Jn8RaX3XdzQFbxaUAM
    7kWwY3w8/nruvrPBIVBSOwrxLrQ7Z3ypTO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1522346527; bh=kpZNi71nsP0zH8avdqe1ekqu+Ixjdb
    FnhQ9ICro8lXA=; b=q5AXnXGIrrSnusg41kDaGv4GvKQ74VvUBIHD9K0pVoXypT
    f4nXqW6+tv2rR/i9FttGe3UIbPa34aN8lFKhor48Ji5LsI8o3iyCkXc05nZUwsNJ
    QRvtbwBrvk0FaOIR+gi0BN+/EhMF4x3u2A390iQ2Z0XcBqn4QHznOhn00OibgMym
    FLDAeofPGizoVc90MI/MqOdBFkZ5Kprv08C4RgDAkAmLnk/aZpCM8tmt5mVmGCuF
    0dVVj9qPyPpvDg4xQDsxrquC5fIIQ1zRHL7ITMYkv6oHXrBm8TgEH6RKCTIiyoI+
    pXvRIq2+oGRxQGcOWtx9k62VRpY8Z25o4Qjxf9Lg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDCCvXobTM8vHu8FhgWaAiT31DEGXJCVqH2VA8zFGL3W9pORnAKgOX4kux/LGGjhNBO4PzqV7Fn5/iKUYqzzB74fbWSG8HVkQxEm12wWTdVY/6Nq+0Cy
    5hOblgs9hO10uYgXnEhX/lNXAgdJLB9BSvXu/TE83R9s3TndYIsKjVT91ewSNn6uKRsOwKQ2QSl6ie9Qk/A9O7qUaumb5wZtFacgwjuaSGSReM1Z1ABvJzPL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7x_52gkKHtEA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=CbDCq_QkAAAA:8
    a=QyXUC8HyAAAA:8 a=zAyngx5bAAAA:8 a=pGLkceISAAAA:8 a=4YC7WVefAAAA:8
    a=dZ7Af3Q_AAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
    a=8AirrxEcAAAA:8 a=VnNF1IyMAAAA:8 a=TYBLyS7eAAAA:8 a=h-jsSio6AAAA:8
    a=A7XncKjpAAAA:8 a=gVGD3344AAAA:8 a=sozttTNsAAAA:8 a=zuLzuavZAAAA:8
    a=m4iFhG78oJmVCtkTbQgA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=1qrBK16LubpBFNPVNq2M:22 a=4LA4qAFo6bo561LpWNDU:22
    a=tPzOKt3quolVTVSLigK1:22 a=xnyMoErWsJe9py2mg6Iw:22 a=ST-jHhOKWsTCqRlWije3:22
    a=zvYvwCWiE4KgVXXeO06c:22 a=cKCw3X4OOXbpJNOXdmIM:22 a=R9rPLQDAdC6-Ub70kJmZ:22
    a=xQEvYfgLW3QvObN0DhJi:22 a=aeg5Gbbo78KNqacMgKqU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeC2SCE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:02:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58026 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeC2SCA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:02:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.15 00/47] 4.15.15-stable review
Date: Thu, 29 Mar 2018 19:59:41 +0200
Message-Id: <20180329175729.225211114@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.15-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.15-rc1
X-KernelTest-Deadline: 2018-03-31T17:57+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.15 release.
There are 47 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Mar 31 17:57:05 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.15-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.15-rc1

Arkadi Sharshevsky <arkadis@mellanox.com>
    team: Fix double free in error path

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    skbuff: Fix not waking applications when errors are enqueued

Michal Kalderon <Michal.Kalderon@cavium.com>
    qede: Fix qedr link update

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Rewrite __bcm_sysport_tx_reclaim()

David Ahern <dsahern@gmail.com>
    net: Only honor ifindex in IP_PKTINFO if non-0

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    netlink: avoid a double skb free in genlmsg_mcast()

Arvind Yadav <arvind.yadav.cs@gmail.com>
    net/iucv: Free memory obtained by kzalloc

Florian Fainelli <f.fainelli@gmail.com>
    net: fec: Fix unbalanced PM runtime calls

SZ Lin (林上智) <sz.lin@moxa.com>
    net: ethernet: ti: cpsw: add check for in-band mode setting with RGMII PHY interface

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net: ethernet: arc: Fix a potential memory leak if an optional regulator is deferred

Eric Dumazet <edumazet@google.com>
    l2tp: do not accept arbitrary sockets

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ipv6: fix access to non-linear packet in ndisc_fill_redirect_hdr_option()

Alexey Kodanev <alexey.kodanev@oracle.com>
    dccp: check sk for closed state in dccp_sendmsg()

Camelia Groza <camelia.groza@nxp.com>
    dpaa_eth: remove duplicate increment of the tx_errors counter

Camelia Groza <camelia.groza@nxp.com>
    dpaa_eth: increment the RX dropped counter when needed

Camelia Groza <camelia.groza@nxp.com>
    dpaa_eth: remove duplicate initialization

Madalin Bucur <madalin.bucur@nxp.com>
    dpaa_eth: fix error in dpaa_remove()

Madalin Bucur <madalin.bucur@nxp.com>
    soc/fsl/qbman: fix issue in qman_delete_cgr_safe()

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: on channel error, reject further cmd requests

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: lock read device while queueing next buffer

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: when thread completes, wake up all waiters

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: free netdevice when removing a card

Kirill Tkhai <ktkhai@virtuozzo.com>
    net: Fix hlist corruptions in inet_evict_bucket()

Eric Dumazet <edumazet@google.com>
    net: use skb_to_full_sk() in skb_update_prio()

Eric Dumazet <edumazet@google.com>
    ieee802154: 6lowpan: fix possible NULL deref in lowpan_device_event()

Alexey Kodanev <alexey.kodanev@oracle.com>
    sch_netem: fix skb leak in netem_enqueue()

Tom Herbert <tom@quantonium.net>
    kcm: lock lower socket in kcm_attach

Paul Blakey <paulb@mellanox.com>
    test_rhashtable: add test case for rhltable with duplicate objects

Paul Blakey <paulb@mellanox.com>
    rhashtable: Fix rhlist duplicates insertion

Guillaume Nault <g.nault@alphalink.fr>
    ppp: avoid loop in xmit recursion detection code

Roman Mashak <mrv@mojatatu.com>
    net sched actions: return explicit error when tunnel_key mode is not specified

Stefano Brivio <sbrivio@redhat.com>
    ipv6: Reflect MTU changes on PMTU of exceptions for MTU-less routes

Brad Mouring <brad.mouring@ni.com>
    net: phy: Tell caller result of phy_change()

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_buffers: Set a minimum quota for CPU port traffic

David Lebrun <dlebrun@google.com>
    ipv6: sr: fix scheduling in RCU when creating seg6 lwtunnel state

David Lebrun <dlebrun@google.com>
    ipv6: sr: fix NULL pointer dereference when setting encap source address

Stefano Brivio <sbrivio@redhat.com>
    ipv6: old_dport should be a __be16 in __ip6_datagram_connect()

Paolo Abeni <pabeni@redhat.com>
    net: ipv6: keep sk status consistent after datagram connect failure

Shannon Nelson <shannon.nelson@oracle.com>
    macvlan: filter out unsupported feature flags

Arkadi Sharshevsky <arkadis@mellanox.com>
    devlink: Remove redundant free on error path

Grygorii Strashko <grygorii.strashko@ti.com>
    net: phy: relax error checking when creating sysfs link netdev->phydev

Grygorii Strashko <grygorii.strashko@ti.com>
    sysfs: symlink: export sysfs_create_link_nowarn()

Michal Kalderon <Michal.Kalderon@cavium.com>
    qed: Fix non TCP packets should be dropped on iWARP ll2 connection

Soheil Hassas Yeganeh <soheil@google.com>
    tcp: purge write queue upon aborting the connection

Michal Kalderon <Michal.Kalderon@cavium.com>
    qed: Fix MPA unalign flow in case header is split across two packets.

zhangliping <zhangliping02@baidu.com>
    openvswitch: meter: fix the incorrect calculation of max delta_t

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: Fix dsa_is_user_port() test inversion


-------------

Diffstat:

 Makefile                                           |   4 +-
 drivers/net/ethernet/arc/emac_rockchip.c           |   6 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |  33 ++--
 drivers/net/ethernet/broadcom/bcmsysport.h         |   2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   8 +-
 drivers/net/ethernet/freescale/fec_main.c          |   2 +
 .../net/ethernet/mellanox/mlxsw/spectrum_buffers.c |  12 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c        |  17 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c       |   4 +-
 drivers/net/ethernet/ti/cpsw.c                     |   3 +-
 drivers/net/macvlan.c                              |   2 +-
 drivers/net/phy/phy.c                              | 173 ++++++++++-----------
 drivers/net/phy/phy_device.c                       |  15 +-
 drivers/net/ppp/ppp_generic.c                      |  26 ++--
 drivers/net/team/team.c                            |   4 +-
 drivers/s390/net/qeth_core_main.c                  |  21 ++-
 drivers/s390/net/qeth_l2_main.c                    |   2 +-
 drivers/s390/net/qeth_l3_main.c                    |   2 +-
 drivers/soc/fsl/qbman/qman.c                       |  28 +---
 fs/sysfs/symlink.c                                 |   1 +
 include/linux/cgroup-defs.h                        |   4 +-
 include/linux/phy.h                                |   1 -
 include/linux/rhashtable.h                         |   4 +-
 include/net/sch_generic.h                          |  19 +++
 lib/rhashtable.c                                   |   4 +-
 lib/test_rhashtable.c                              | 134 ++++++++++++++++
 net/core/dev.c                                     |  22 ++-
 net/core/devlink.c                                 |  16 +-
 net/core/skbuff.c                                  |   2 +-
 net/dccp/proto.c                                   |   5 +
 net/dsa/legacy.c                                   |   2 +-
 net/ieee802154/6lowpan/core.c                      |  12 +-
 net/ipv4/inet_fragment.c                           |   3 +
 net/ipv4/ip_sockglue.c                             |   6 +-
 net/ipv4/tcp.c                                     |   1 +
 net/ipv4/tcp_timer.c                               |   1 +
 net/ipv6/datagram.c                                |  21 ++-
 net/ipv6/ndisc.c                                   |   3 +-
 net/ipv6/route.c                                   |  71 +++++----
 net/ipv6/seg6_iptunnel.c                           |   7 +-
 net/iucv/af_iucv.c                                 |   4 +-
 net/kcm/kcmsock.c                                  |  33 ++--
 net/l2tp/l2tp_core.c                               |   8 +-
 net/netlink/genetlink.c                            |   2 +-
 net/openvswitch/meter.c                            |  12 +-
 net/sched/act_tunnel_key.c                         |   1 +
 net/sched/sch_netem.c                              |   2 +-
 47 files changed, 501 insertions(+), 264 deletions(-)

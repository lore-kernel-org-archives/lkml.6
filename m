Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4978bzvJ4anwCJGg/K4LWRY038u79OvVXKlIXry9dTH9vA9OkU/n4/cKyE0GMPrsNiM87Rp
ARC-Seal: i=1; a=rsa-sha256; t=1522346701; cv=none;
        d=google.com; s=arc-20160816;
        b=xGKLFA+k2mA3ZZzov0ClMzAEWpxZCf45kcJ4UM/3m6YeUgdyoGF/M/f3dMnfSo4jCV
         WDktwVmHquePzBBbT63Gh3bNRrMI8rRc8eml7wI/GHAgS/6KUQjaBwNsp6UNTLhdLTaF
         bFArJanj8fMaDfrsSUCj4bhajVITlOAqnlnw/lGd5kO5rH0LxoKtSk+iHnolWV5UzG/C
         l8wdW0gRc6Iupvg5aTVHupQw4FSSxl95Cchap9rRxUgI6KyJin2/zuzC+z/rcnV2+phv
         oOi2TUaSMIQwHqyevSbR5fjGCBwYBPZmm0HtaLWgM6PyMSilEiWjaw4UomZ+fiiC700u
         xKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5KnjS4bnfuYR3AP1Eg0DdFKbOnbx0WYOgEMYNgnMKXc=;
        b=uj6AmjG2rHyUrU+BllZP9n/11LbGn1VCkSXUc49pcd702ONhZR9mmkRTqFpRWt6DRt
         g/xndOBou6TsLfmmgbBm/aA34hMdNFunxU36TSbt8afWUtt4Yt30e5eGDY27TzXJo+nS
         hj0NBU+eadVowLsA+iJl2D9QD43MnA6cFg83WUFgMacRcc95CziS5riUh7h835Ztxo2f
         /sqrPUFjy+Dfpg4LXgIvpZSzU3qnO9S9dkxixsUg358iVqtLxdjTW3oXd0BqgTnwsEiq
         UHTFNVUwUxQwSlqUsIFDiiSrYOqt4zWYzibIt2IIvImWO9yQn7BKT+U3uvTe7RL5Wyi5
         4tuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.14 00/43] 4.14.32-stable review
Date: Thu, 29 Mar 2018 19:59:55 +0200
Message-Id: <20180329175730.190353692@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.32-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.32-rc1
X-KernelTest-Deadline: 2018-03-31T17:57+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296215155327589?=
X-GMAIL-MSGID: =?utf-8?q?1596296215155327589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.32 release.
There are 43 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Mar 31 17:57:12 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.32-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.32-rc1

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: on channel error, reject further cmd requests

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: lock read device while queueing next buffer

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: when thread completes, wake up all waiters

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: free netdevice when removing a card

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
    rhashtable: Fix rhlist duplicates insertion

Guillaume Nault <g.nault@alphalink.fr>
    ppp: avoid loop in xmit recursion detection code

Roman Mashak <mrv@mojatatu.com>
    net sched actions: return explicit error when tunnel_key mode is not specified

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

Soheil Hassas Yeganeh <soheil@google.com>
    tcp: reset sk_send_head in tcp_write_queue_purge


-------------

Diffstat:

 Makefile                                           |   4 +-
 drivers/net/ethernet/arc/emac_rockchip.c           |   6 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |  33 ++--
 drivers/net/ethernet/broadcom/bcmsysport.h         |   2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   8 +-
 drivers/net/ethernet/freescale/fec_main.c          |   2 +
 .../net/ethernet/mellanox/mlxsw/spectrum_buffers.c |  12 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c        |  15 ++
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
 include/net/tcp.h                                  |  11 +-
 lib/rhashtable.c                                   |   4 +-
 net/core/dev.c                                     |  22 ++-
 net/core/devlink.c                                 |  16 +-
 net/core/skbuff.c                                  |   2 +-
 net/dccp/proto.c                                   |   5 +
 net/ieee802154/6lowpan/core.c                      |  12 +-
 net/ipv4/inet_fragment.c                           |   3 +
 net/ipv4/ip_sockglue.c                             |   6 +-
 net/ipv4/tcp.c                                     |   1 +
 net/ipv4/tcp_timer.c                               |   1 +
 net/ipv6/datagram.c                                |  21 ++-
 net/ipv6/ndisc.c                                   |   3 +-
 net/ipv6/seg6_iptunnel.c                           |   7 +-
 net/iucv/af_iucv.c                                 |   4 +-
 net/kcm/kcmsock.c                                  |  33 ++--
 net/l2tp/l2tp_core.c                               |   8 +-
 net/netlink/genetlink.c                            |   2 +-
 net/sched/act_tunnel_key.c                         |   1 +
 net/sched/sch_netem.c                              |   2 +-
 44 files changed, 320 insertions(+), 235 deletions(-)

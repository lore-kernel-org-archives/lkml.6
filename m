Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx484fWjOey8aY7oYrn4M2iIhI8JglD52ZFHutQcs8NV0kt2Se0a4j7O1mN6T47tpSyk2uH+U
ARC-Seal: i=1; a=rsa-sha256; t=1522346850; cv=none;
        d=google.com; s=arc-20160816;
        b=cOhib4sJI7KTdy3E4ntGTaXmbW7B7SHrJEkiEl5fAxahEthnkVLg25PQIxuZGgvYd2
         2+tH4f4Z5xAe5D/9PV5droE645D2HtkbZA46qWZ1cqj53mQ6b7YDp1Du7PxDDSpCqV+H
         O/zWsE/yt1eRyRuEiAgaE46Y326h2pdSVn9bFuwNHUOsBEifgdfHNrGoTM5ThFKZ0AYq
         9rOrbH7D3vxe8qnWgdxo2EnG6CKBzo9yuebbpO2DEBc0KAnBW37yPSnktIAbyuPNdmmR
         Eu6GlA7CkLT+wcbyKpd9nXnvk9Cg5eEUoKT6cJZ0gNm7wST3J6hkRr2CxjXdx3jjfNPN
         bvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EN2Fo40R3DheZRl7WU1QYaFTBbsBrRpoyISFD11q4gg=;
        b=B5oKsERZPVr8f9e7FM+SJDjGFIoJukD2wM/3gxlfwsSGtr4j7RXj32hfO60GZ0/XF4
         qS5ttzS0oDWjm+gAFW46MoM2fCrGz13O0iCDUjMDfQ+MztBulGM4tjlTnFRmIt1/6u5N
         UY8WrSZhsMIGuuQZzvYt/oozuPYETqKmpU9E+6D/fg5Eu73blX5R00uyPfEFxO+23EWJ
         pIRsea1iiKcoWu2qw9XHVViXWGGnsBcThT+BRdqk5eo7nVOp7tSgYe1gKY5t1AwA8fCl
         Lshv/ux+gaTWIWaY3cVBSQPepo90RmfCppmTkgYOlFOze8gRYrFHA098MYIB92gFaWok
         jSWg==
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
Subject: [PATCH 4.9 00/28] 4.9.92-stable review
Date: Thu, 29 Mar 2018 20:00:19 +0200
Message-Id: <20180329175733.447823703@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.92-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.92-rc1
X-KernelTest-Deadline: 2018-03-31T17:57+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296370676575757?=
X-GMAIL-MSGID: =?utf-8?q?1596296370676575757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.92 release.
There are 28 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Mar 31 17:57:18 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.92-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.92-rc1

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns: Fix a skb used after free bug

Tom Herbert <tom@quantonium.net>
    kcm: lock lower socket in kcm_attach

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Rewrite __bcm_sysport_tx_reclaim()

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: on channel error, reject further cmd requests

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: lock read device while queueing next buffer

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: when thread completes, wake up all waiters

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: free netdevice when removing a card

Madalin Bucur <madalin.bucur@nxp.com>
    soc/fsl/qbman: fix issue in qman_delete_cgr_safe()

Arkadi Sharshevsky <arkadis@mellanox.com>
    team: Fix double free in error path

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    skbuff: Fix not waking applications when errors are enqueued

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

Paul Blakey <paulb@mellanox.com>
    rhashtable: Fix rhlist duplicates insertion

Guillaume Nault <g.nault@alphalink.fr>
    ppp: avoid loop in xmit recursion detection code

Roman Mashak <mrv@mojatatu.com>
    net sched actions: return explicit error when tunnel_key mode is not specified

Marc Zyngier <marc.zyngier@arm.com>
    genirq: Track whether the trigger type has been set

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: don't return bogus Sg_requests


-------------

Diffstat:

 Makefile                                      |  4 ++--
 drivers/net/ethernet/arc/emac_rockchip.c      |  6 +++--
 drivers/net/ethernet/broadcom/bcmsysport.c    | 33 ++++++++++++---------------
 drivers/net/ethernet/broadcom/bcmsysport.h    |  2 +-
 drivers/net/ethernet/freescale/fec_main.c     |  2 ++
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 22 ++++++++----------
 drivers/net/ethernet/hisilicon/hns/hns_enet.h |  6 ++---
 drivers/net/ethernet/ti/cpsw.c                |  3 ++-
 drivers/net/ppp/ppp_generic.c                 | 26 +++++++++++----------
 drivers/net/team/team.c                       |  4 ++--
 drivers/s390/net/qeth_core_main.c             | 21 ++++++++++++-----
 drivers/s390/net/qeth_l2_main.c               |  2 +-
 drivers/s390/net/qeth_l3_main.c               |  2 +-
 drivers/scsi/sg.c                             |  5 ++--
 drivers/soc/fsl/qbman/qman.c                  | 28 ++++-------------------
 include/linux/cgroup-defs.h                   |  4 ++--
 include/linux/irq.h                           | 11 ++++++++-
 include/linux/rhashtable.h                    |  4 +++-
 include/net/sch_generic.h                     | 19 +++++++++++++++
 kernel/irq/manage.c                           | 13 ++++++++++-
 lib/rhashtable.c                              |  4 +++-
 net/core/dev.c                                | 22 ++++++++++++------
 net/core/skbuff.c                             |  2 +-
 net/dccp/proto.c                              |  5 ++++
 net/ieee802154/6lowpan/core.c                 | 12 ++++++----
 net/ipv4/inet_fragment.c                      |  3 +++
 net/ipv4/ip_sockglue.c                        |  6 +++--
 net/ipv6/ndisc.c                              |  3 ++-
 net/iucv/af_iucv.c                            |  4 +++-
 net/kcm/kcmsock.c                             | 33 +++++++++++++++++++--------
 net/l2tp/l2tp_core.c                          |  8 +++++--
 net/netlink/genetlink.c                       |  2 +-
 net/sched/act_tunnel_key.c                    |  1 +
 net/sched/sch_netem.c                         |  2 +-
 34 files changed, 202 insertions(+), 122 deletions(-)

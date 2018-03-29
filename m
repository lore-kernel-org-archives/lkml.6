Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+BE6/I3C0C/kJWyZHxJALaO0yloKoq4/ueNNPwFBwys38tRroGWCEzqdU0YziwYSIcm8Hs
ARC-Seal: i=1; a=rsa-sha256; t=1522346887; cv=none;
        d=google.com; s=arc-20160816;
        b=C+4HLltzx3hXp0Wci6//zQYH4dYotVUdMZ7KRdCfFYUuN5fKD31G09mFU3/kXiYYy2
         xHq2TXcdvoFuKmYWLiaiuVKiQhtnTKof+R0MOr4HPKYyd9HOWvoZLEPOZIfyxonfckXH
         Nhd8BkmQMbybNO/43n/1wwE+tTM9ez957VURfVkoAY9F36xmQuaWEuRFA9yAbCgXPTMs
         CqI5e2SEeFzWRJiio4bflebWPo5RzP1s8jD90dcElR7w6Sdl6Z/9pPIqp2CBGURIMMIg
         5NBcWDWxuM/XYrUxP7h4gdizPuadQBdR5MinkM4gviZ7LHMeMx4GVYBMqbSXqHbNUfLQ
         usxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j+utV04sKDIZdimEi/bhQecdxaCrxoFusjMrvn8ftso=;
        b=IRAUx3RajWSOOmyVFOWDBFLnvS6PD+BdP70ZRuVbfE4WT9TF1zsUr6kCohL+HJJ4ug
         BasiWx9ZMWEe9WNkPuvdFjp7hDM0VC2bwoHPz20tVuI5a4giA+ET5xOm+ucPRGd22suE
         RXn52uXwgT687PXLqMTP2aCYmsaW1XUSfvnE44BtCkMIEH+at/My16OdcskcfkLUhw48
         EcjVo/b3ctTzvV5Y2x/1QHTa/Byp1RI1kuademN5Q7CUKcCX285RQrsR/F3XbawWfFus
         XPCw+XO9eQ7jHm4ptB8fbdrLpRpa0L5ZEvuq/UeYGDSIXSd8kLWGfkT1OhbVH+fanr6F
         0zgA==
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
Subject: [PATCH 4.4 00/20] 4.4.126-stable review
Date: Thu, 29 Mar 2018 20:00:36 +0200
Message-Id: <20180329175741.886181131@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.126-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.126-rc1
X-KernelTest-Deadline: 2018-03-31T17:57+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296410346468938?=
X-GMAIL-MSGID: =?utf-8?q?1596296410346468938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.126 release.
There are 20 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Mar 31 17:57:30 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.126-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.126-rc1

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Rewrite __bcm_sysport_tx_reclaim()

Florian Fainelli <f.fainelli@gmail.com>
    net: fec: Fix unbalanced PM runtime calls

Eric Dumazet <edumazet@google.com>
    ieee802154: 6lowpan: fix possible NULL deref in lowpan_device_event()

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: on channel error, reject further cmd requests

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: lock read device while queueing next buffer

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: when thread completes, wake up all waiters

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: free netdevice when removing a card

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

Marc Zyngier <marc.zyngier@arm.com>
    genirq: Track whether the trigger type has been set

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: don't return bogus Sg_requests


-------------

Diffstat:

 Makefile                                   |  4 ++--
 drivers/net/ethernet/arc/emac_rockchip.c   |  6 ++++--
 drivers/net/ethernet/broadcom/bcmsysport.c | 33 ++++++++++++++----------------
 drivers/net/ethernet/broadcom/bcmsysport.h |  2 +-
 drivers/net/ethernet/freescale/fec_main.c  |  2 ++
 drivers/net/ethernet/ti/cpsw.c             |  3 ++-
 drivers/net/team/team.c                    |  4 ++--
 drivers/s390/net/qeth_core_main.c          | 21 +++++++++++++------
 drivers/s390/net/qeth_l2_main.c            |  2 +-
 drivers/s390/net/qeth_l3_main.c            |  2 +-
 drivers/scsi/sg.c                          |  5 +++--
 include/linux/irq.h                        | 11 +++++++++-
 kernel/irq/manage.c                        | 13 +++++++++++-
 net/core/skbuff.c                          |  2 +-
 net/dccp/proto.c                           |  5 +++++
 net/ieee802154/6lowpan/core.c              | 12 +++++++----
 net/ipv4/inet_fragment.c                   |  3 +++
 net/ipv4/ip_sockglue.c                     |  6 ++++--
 net/ipv6/ndisc.c                           |  3 ++-
 net/iucv/af_iucv.c                         |  4 +++-
 net/l2tp/l2tp_core.c                       |  8 ++++++--
 net/netlink/genetlink.c                    |  2 +-
 22 files changed, 103 insertions(+), 50 deletions(-)

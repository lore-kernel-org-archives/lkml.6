Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184055-2-10850453512650475087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184055; b=wM4gdp0DgwyMGIvvljuC0G1O+1XtaKeENW/n3unfV4OrgpO
    dVJH1NMvYPVFk4Eq2Kx8ZuLv5zi2zQcohBGPlh9cvUEmWVHNbB42ciUXAW8ogggh
    zwhlkwDOXsNiPMoxnimiiEfFHvcNk4nTB4IKp3IFJpnKoaZmh3lF6HF9uqRDxNRt
    dUZapthzlHO30sqxTUViUeDvThpjxjYrBnb+3vf8ee8h0+D1HMSe9GSyMjjk/Ugi
    30P58ouC9CPy4V4OiI97BkzDVXm0Ajdw0veBzFUtRSJB1dLBCY3oJBr4QUduVK/Y
    RrDduw1G2NeZrMpmJkdHPUmCtN9ZHAmBmkH5+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518184055; bh=8WNDGz62Ca4s6a23CV/T6EPluN
    nY0XYfZvsK1I7GNO0=; b=h5xrflNp6O6Rnpw6lryAWcTTnoG132HWWIODJnWfCL
    FUV6Vv2F2Ij6iMFhJ58jfdY8v6qZeontJ5zeNIBY5jKEVKS9oWOMrRlfjb0z3RE9
    diCOe0N2gcehNXNkjUREB4yKiESF+MSq+ISCP95vBUWdwvgbR7lfTHMCpsnatm4o
    v7qwsZB9j7XH7Q1/C6r0atAPLxgfjWbeXOZGVUTY2/YbzS5av1Wm6tw5pW4ruKst
    Mpl1BW0P5N2DWjdk1QrAIxoeZPcghitYzLNWktcafoyOkM32I3p0dkTB2Wv/eial
    hFRBkrIDC2twXk3c1JQ2K0a5wlAwT7mZOchTbJsI8t8A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeBINrR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:47:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53652 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeBINrP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:47:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.15 00/23] 4.15.3-stable review
Date: Fri,  9 Feb 2018 14:39:58 +0100
Message-Id: <20180209133938.366024920@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.3-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.3-rc1
X-KernelTest-Deadline: 2018-02-11T13:39+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.3 release.
There are 23 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb 11 13:39:20 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.3-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.3-rc1

Robert Baronescu <robert.baronescu@nxp.com>
    crypto: tcrypt - fix S/G table for test_aead_speed()

Masahiro Yamada <yamada.masahiro@socionext.com>
    gpio: uniphier: fix mismatch between license text and MODULE_LICENSE

Jesse Chan <jc@linux.com>
    media: tegra-cec: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    media: mtk-vcodec: add missing MODULE_LICENSE/DESCRIPTION

Jiri Pirko <jiri@mellanox.com>
    net: sched: fix use-after-free in tcf_block_put_ext

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: get rid of rcu_barrier() in tcf_block_put_ext()

Eric Dumazet <edumazet@google.com>
    soreuseport: fix mem leak in reuseport_add_sock()

Martin KaFai Lau <kafai@fb.com>
    ipv6: Fix SO_REUSEPORT UDP socket with implicit sk_ipv6only

Paolo Abeni <pabeni@redhat.com>
    cls_u32: add missing RCU annotation.

Neal Cardwell <ncardwell@google.com>
    tcp_bbr: fix pacing_gain to always be unity when using lt_bw

Jiri Pirko <jiri@mellanox.com>
    rocker: fix possible null pointer dereference in rocker_router_fib_event_work

David Ahern <dsahern@gmail.com>
    net: ipv6: send unsolicited NA after DAD

Roman Gushchin <guro@fb.com>
    Revert "defer call to mem_cgroup_sk_alloc()"

Wei Wang <weiwan@google.com>
    ipv6: change route cache aging logic

Eric Dumazet <edumazet@google.com>
    ipv6: addrconf: break critical section in addrconf_verify_rtnl()

Jason Wang <jasowang@redhat.com>
    vhost_net: stop device during reset owner

Li RongQing <lirongqing@baidu.com>
    tcp: release sk_frag.page in tcp_disconnect

Chunhao Lin <hau@realtek.com>
    r8169: fix RTL8168EP take too long to complete driver initialization.

Kristian Evensen <kristian.evensen@gmail.com>
    qmi_wwan: Add support for Quectel EP06

Junxiao Bi <junxiao.bi@oracle.com>
    qlcnic: fix deadlock bug

Eric Dumazet <edumazet@google.com>
    net: igmp: add a missing rcu locking section

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    ip6mr: fix stale iterator


-------------

Diffstat:

 Makefile                                           |  4 +--
 crypto/tcrypt.c                                    |  6 ++--
 drivers/gpio/gpio-uniphier.c                       |  2 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_util.c    |  3 ++
 drivers/media/platform/soc_camera/soc_scale_crop.c |  4 +++
 drivers/media/platform/tegra-cec/tegra_cec.c       |  5 +++
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    | 18 +++++-----
 drivers/net/ethernet/realtek/r8169.c               |  4 +--
 drivers/net/ethernet/rocker/rocker_main.c          | 18 +++++-----
 drivers/net/usb/qmi_wwan.c                         |  1 +
 drivers/vhost/net.c                                |  1 +
 include/net/sch_generic.h                          |  1 -
 mm/memcontrol.c                                    | 14 ++++++++
 net/core/sock.c                                    |  5 +--
 net/core/sock_reuseport.c                          | 35 ++++++++++---------
 net/ipv4/igmp.c                                    |  4 +++
 net/ipv4/inet_connection_sock.c                    |  1 -
 net/ipv4/tcp.c                                     |  6 ++++
 net/ipv4/tcp_bbr.c                                 |  6 ++--
 net/ipv6/addrconf.c                                | 32 +++++++++++++++---
 net/ipv6/af_inet6.c                                | 11 +++---
 net/ipv6/ip6mr.c                                   |  1 +
 net/ipv6/ndisc.c                                   |  5 +++
 net/ipv6/route.c                                   | 20 ++++++-----
 net/sched/cls_api.c                                | 39 ++++++++--------------
 net/sched/cls_u32.c                                | 12 ++++---
 26 files changed, 163 insertions(+), 95 deletions(-)

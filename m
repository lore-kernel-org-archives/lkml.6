Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82457C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D2620700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760588;
	bh=1ma0lphpT2J3uEaLgguqgvkCLqji2p4FmmxAre/MsIs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vF+bo2KQaax0EOronJnpQrQOoMTH3+UJLdyuO+/JHRPE/LwnL8Q3DqGYZ7SWZIR5K
	 vBPjcvVBKMHiIuN+iUF06dQEVnETv41qVf8T4e90VPoOw2zSOcReQirSqoteC0lLt6
	 JtJXrwGyOnVu1Y4FYjonWBhVmEwTQLVfIsODiM4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfBUOtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:32936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbfBUOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:39:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F032080D;
        Thu, 21 Feb 2019 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759947;
        bh=1ma0lphpT2J3uEaLgguqgvkCLqji2p4FmmxAre/MsIs=;
        h=From:To:Cc:Subject:Date:From;
        b=tIkZ61JujWl3F+ZjGcBI9wUdn3SWgO8EkiUAM680MlUHOrzifZUC9TatFFqTR9fMr
         sonxvN6Mk84FFQte13UPMa34Xk51LsP3zXBbhVdhszjYMaYsGNKxOboRxiWuLbz1cm
         JSpjaubc0nEBqVbXSa9EUm23NraSnqFAVqEWgZ1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/20] 4.9.160-stable review
Date:   Thu, 21 Feb 2019 15:35:38 +0100
Message-Id: <20190221125242.153179182@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.160-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.160-rc1
X-KernelTest-Deadline: 2019-02-23T12:52+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.160 release.
There are 20 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Feb 23 12:52:16 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.160-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.160-rc1

Eric Dumazet <edumazet@google.com>
    ax25: fix possible use-after-free

Eric Dumazet <edumazet@google.com>
    mISDN: fix a race in dev_expire_timer()

Eric Dumazet <edumazet@google.com>
    net/x25: do not hold the cpu too long in x25_new_lci()

Qu Wenruo <quwenruo@cn.fujitsu.com>
    btrfs: Remove false alert when fiemap range is smaller than on-disk extent

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: ipv4: use a dedicated counter for icmp_v4 redirect packets

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Fix a race in EEE enable callback

Eric Dumazet <edumazet@google.com>
    vxlan: test dev->flags & IFF_UP before calling netif_rx()

Eric Dumazet <edumazet@google.com>
    tcp: clear icsk_backoff in tcp_write_queue_purge()

Alexander Duyck <alexander.h.duyck@linux.intel.com>
    net: Do not allocate page fragments that are not skb aligned

Eric Dumazet <edumazet@google.com>
    tcp: tcp_v4_err() should be more careful

David S. Miller <davem@davemloft.net>
    net: Add header for usage of fls64()

Jason Wang <jasowang@redhat.com>
    vhost: correctly check the return value of translate_desc() in log_used()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Increase D3 delay again

Willem de Bruijn <willemb@google.com>
    net: validate untrusted gso packets without csum offload

Alexandre Torgue <alexandre.torgue@st.com>
    net: stmmac: handle endianness in dwmac4_get_timestamp

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    net: phy: xgmiitorgmii: Support generic PHY status read

Hauke Mehrtens <hauke.mehrtens@intel.com>
    net: Fix for_each_netdev_feature on Big endian

Wei Yongjun <weiyongjun1@huawei.com>
    hwmon: (lm80) Fix missing unlock on error in set_fan_div()

Paolo Abeni <pabeni@redhat.com>
    vsock: cope with memory allocation failure at socket creation time

Zhiqiang Liu <liuzhiqiang26@huawei.com>
    net: fix IPv6 prefix route residue


-------------

Diffstat:

 Makefile                                           |  4 ++--
 drivers/hwmon/lm80.c                               |  4 +++-
 drivers/isdn/mISDN/timerdev.c                      |  2 +-
 drivers/net/ethernet/marvell/sky2.c                |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |  9 ++++---
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 22 +++++++++--------
 drivers/net/phy/xilinx_gmii2rgmii.c                |  5 +++-
 drivers/net/vxlan.c                                | 13 ++++++++--
 drivers/vhost/vhost.c                              |  2 +-
 fs/btrfs/extent_io.c                               | 28 ++++++++++------------
 include/linux/netdev_features.h                    | 24 +++++++++++++++++--
 include/linux/skbuff.h                             |  2 +-
 include/linux/virtio_net.h                         |  9 +++++++
 include/net/ax25.h                                 | 12 ++++++++++
 include/net/inetpeer.h                             |  1 +
 include/net/tcp.h                                  |  1 +
 net/ax25/ax25_ip.c                                 |  4 ++--
 net/ax25/ax25_route.c                              | 19 +++++++--------
 net/core/dev.c                                     |  4 ++--
 net/core/skbuff.c                                  |  4 ++++
 net/ipv4/inetpeer.c                                |  1 +
 net/ipv4/route.c                                   |  7 ++++--
 net/ipv4/tcp.c                                     |  1 -
 net/ipv4/tcp_ipv4.c                                |  7 +++---
 net/ipv6/addrconf.c                                |  3 ++-
 net/vmw_vsock/vmci_transport.c                     |  4 ++++
 net/x25/af_x25.c                                   |  6 ++---
 27 files changed, 133 insertions(+), 67 deletions(-)



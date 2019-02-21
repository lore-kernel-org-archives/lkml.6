Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849DF2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759907;
	bh=VzbbT2MZtnB6DdJHTIklq/swVuoA++3i8TeuZArd02s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=heH3Lug53MygqvH4AQiOH1+4lSJHvSZEm+U5xe9E1H/inVVGo7XK7h8n/zqnoSjxf
	 QurEQbhqiC2w2QPVp0OZj88X/LQWUV7nRLHEZ8VVOQdoe5jd5tWEZEaGaMpcpPnjiw
	 019HwblM69U8cygo92fh8kDfUxlhi5UnCtHTwrNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfBUOiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:38:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbfBUOiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:38:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 106DB2075C;
        Thu, 21 Feb 2019 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759901;
        bh=VzbbT2MZtnB6DdJHTIklq/swVuoA++3i8TeuZArd02s=;
        h=From:To:Cc:Subject:Date:From;
        b=Rw0lXlrxLz+46AHeEip2+BRuSpFx0je7H2R9g+ISiG8MJ0D9ifQdSUA++iHFWfq5F
         orMRnWhL44GUSnRh2ntxD8mjJqhSnO6uha5EESPm5S+ZYxR/ZeMCzwDbwXaYSMjQl7
         etpQPt5vuG1K6LAUNbQL3vSMFXkpQCqdgfa6Xyb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/20] 4.4.176-stable review
Date:   Thu, 21 Feb 2019 15:35:30 +0100
Message-Id: <20190221141946.772985220@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.176-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.176-rc1
X-KernelTest-Deadline: 2019-02-23T14:19+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.176 release.
There are 20 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Feb 23 14:19:37 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.176-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.176-rc1

Joerg Roedel <jroedel@suse.de>
    KVM: VMX: Fix x2apic check in vmx_msr_bitmap_mode()

Eric Dumazet <edumazet@google.com>
    ax25: fix possible use-after-free

Eric Dumazet <edumazet@google.com>
    mISDN: fix a race in dev_expire_timer()

Eric Dumazet <edumazet@google.com>
    net/x25: do not hold the cpu too long in x25_new_lci()

Arnd Bergmann <arnd@arndb.de>
    mfd: as3722: Mark PM functions as __maybe_unused

Jon Hunter <jonathanh@nvidia.com>
    mfd: as3722: Handle interrupts on suspend

Jann Horn <jannh@google.com>
    kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

chenzefeng (A) <chenzefeng2@huawei.com>
    x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32

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

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Increase D3 delay again

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

 Makefile                                           |  4 +--
 arch/x86/kernel/livepatch.c                        |  1 +
 arch/x86/kvm/vmx.c                                 |  4 ++-
 drivers/hwmon/lm80.c                               |  4 ++-
 drivers/isdn/mISDN/timerdev.c                      |  2 +-
 drivers/mfd/as3722.c                               | 30 ++++++++++++++++++++++
 drivers/net/ethernet/marvell/sky2.c                |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 22 ++++++++--------
 drivers/net/vxlan.c                                | 13 ++++++++--
 include/linux/netdev_features.h                    | 24 +++++++++++++++--
 include/net/ax25.h                                 | 12 +++++++++
 include/net/inetpeer.h                             |  1 +
 include/net/tcp.h                                  |  1 +
 net/ax25/ax25_ip.c                                 |  4 +--
 net/ax25/ax25_route.c                              | 19 ++++++--------
 net/core/dev.c                                     |  4 +--
 net/core/skbuff.c                                  |  4 +++
 net/ipv4/inetpeer.c                                |  1 +
 net/ipv4/route.c                                   |  7 +++--
 net/ipv4/tcp.c                                     |  1 -
 net/ipv4/tcp_ipv4.c                                |  7 ++---
 net/ipv6/addrconf.c                                |  3 ++-
 net/vmw_vsock/vmci_transport.c                     |  4 +++
 net/x25/af_x25.c                                   |  6 ++---
 virt/kvm/kvm_main.c                                |  3 ++-
 25 files changed, 136 insertions(+), 47 deletions(-)



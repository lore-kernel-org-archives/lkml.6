Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB71C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE6220700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760687;
	bh=VC5Zc2BYcaeiXFAyyCfnEvRZZdPJMu9jBk0lEhrosOQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j42VaCH7kHRncLHir0HJIRbdokW6svS8hxdXEQeka+NNpQcu+rHV9qgSY6CnSPM09
	 3w5F7WE53mCBVlj6UqLz0DNp0w3R0ZtuaeSiYsTRCyUy1nKyhz+odscd3vGjuKZLek
	 4NrFWroqytb+5tzhRUdBCdQTpj3VRNxbOY/Fgr7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfBUOhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:37:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfBUOhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:37:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF1120838;
        Thu, 21 Feb 2019 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759838;
        bh=VC5Zc2BYcaeiXFAyyCfnEvRZZdPJMu9jBk0lEhrosOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=yGsTnMU00lxPh0U6StcX0Ua+Zv+AfbO4+TjdDFnMfqgf/7xXz3RaUpPwEoa20kXl9
         64I/Zy8omHxfHA/V5Hhg024doNcOoBl2nqRpbpDP/PVREvkPBZ4tgIEGDfLJbNN4x1
         M+HbN4TwJh8J072yvETtA1xxriHLs5+t/r0XEdHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/13] 3.18.136-stable review
Date:   Thu, 21 Feb 2019 15:35:31 +0100
Message-Id: <20190221125240.091472334@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.136-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.136-rc1
X-KernelTest-Deadline: 2019-02-23T12:52+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.136 release.
There are 13 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Feb 23 12:52:12 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.136-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.136-rc1

Eric Dumazet <edumazet@google.com>
    ax25: fix possible use-after-free

Eric Dumazet <edumazet@google.com>
    mISDN: fix a race in dev_expire_timer()

Eric Dumazet <edumazet@google.com>
    net/x25: do not hold the cpu too long in x25_new_lci()

Jann Horn <jannh@google.com>
    kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

Wei Yongjun <weiyongjun1@huawei.com>
    hwmon: (lm80) Fix missing unlock on error in set_fan_div()

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: ipv4: use a dedicated counter for icmp_v4 redirect packets

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Fix a race in EEE enable callback

Paolo Abeni <pabeni@redhat.com>
    vsock: cope with memory allocation failure at socket creation time

Eric Dumazet <edumazet@google.com>
    vxlan: test dev->flags & IFF_UP before calling netif_rx()

Eric Dumazet <edumazet@google.com>
    tcp: clear icsk_backoff in tcp_write_queue_purge()

Eric Dumazet <edumazet@google.com>
    tcp: tcp_v4_err() should be more careful

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Increase D3 delay again

Zhiqiang Liu <liuzhiqiang26@huawei.com>
    net: fix IPv6 prefix route residue


-------------

Diffstat:

 Makefile                                           |  4 ++--
 drivers/hwmon/lm80.c                               |  4 +++-
 drivers/isdn/mISDN/timerdev.c                      |  2 +-
 drivers/net/ethernet/marvell/sky2.c                |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 22 ++++++++++++----------
 drivers/net/vxlan.c                                | 13 +++++++++++--
 include/net/ax25.h                                 | 12 ++++++++++++
 include/net/inetpeer.h                             |  1 +
 include/net/tcp.h                                  |  1 +
 net/ax25/ax25_ip.c                                 |  4 ++--
 net/ax25/ax25_route.c                              | 19 ++++++++-----------
 net/ipv4/inetpeer.c                                |  1 +
 net/ipv4/route.c                                   |  7 +++++--
 net/ipv4/tcp.c                                     |  1 -
 net/ipv4/tcp_ipv4.c                                |  7 ++++---
 net/ipv6/addrconf.c                                |  3 ++-
 net/vmw_vsock/vmci_transport.c                     |  4 ++++
 net/x25/af_x25.c                                   |  6 ++----
 virt/kvm/kvm_main.c                                |  3 ++-
 19 files changed, 74 insertions(+), 42 deletions(-)



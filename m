Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B83C10F07
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658AC20684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550917289;
	bh=/Cg3vGy7IlOJPpGe0a5nA7nIij0OJ1DVR7RLN5tpHFE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=YWjfgJo9tMY9uDoCuL6RYWOXbKKhyrtwTbDaXuoCyaHt0j/XjSwZ4taLTDX7W9Ma1
	 SlWhHAKiu1Op0dE83/L2KBy/KG3q+7NvXcV3AAvuaml2OsjjhXXpiNF6WMoOiPHW4B
	 zA2zkorhZ+19JL0iSbSETWwqsDForf3TbNNIgvBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfBWKV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:21:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbfBWKV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:21:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4E620684;
        Sat, 23 Feb 2019 10:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550917286;
        bh=/Cg3vGy7IlOJPpGe0a5nA7nIij0OJ1DVR7RLN5tpHFE=;
        h=Date:From:To:Cc:Subject:From;
        b=CINfiQkOAutZmJn3pPrail+g3EysP+at8+qXEbx7RfBjcdraAQ+53+CqOcOJrWdC+
         U7mgzzePdckFzMX+ZLfWrQ9ji8f4rbK+j5qpcfKMkiDUDiMhN8mZGW50MwARMn/G+P
         0KkS9E8bu65NYIUBHat8ngwqi9O2rHXOVZ2O2tJw=
Date:   Sat, 23 Feb 2019 11:21:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.176
Message-ID: <20190223102124.GA14477@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.4.176 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 -
 arch/x86/kernel/livepatch.c                          |    1 
 arch/x86/kvm/vmx.c                                   |    4 +-
 drivers/hwmon/lm80.c                                 |    4 +-
 drivers/isdn/mISDN/timerdev.c                        |    2 -
 drivers/mfd/as3722.c                                 |   30 +++++++++++++++++++
 drivers/net/ethernet/marvell/sky2.c                  |    2 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c |   22 +++++++------
 drivers/net/vxlan.c                                  |   13 ++++++--
 include/linux/netdev_features.h                      |   24 +++++++++++++--
 include/net/ax25.h                                   |   12 +++++++
 include/net/inetpeer.h                               |    1 
 include/net/tcp.h                                    |    1 
 net/ax25/ax25_ip.c                                   |    4 +-
 net/ax25/ax25_route.c                                |   19 +++++-------
 net/core/dev.c                                       |    4 +-
 net/core/skbuff.c                                    |    4 ++
 net/ipv4/inetpeer.c                                  |    1 
 net/ipv4/route.c                                     |    7 +++-
 net/ipv4/tcp.c                                       |    1 
 net/ipv4/tcp_ipv4.c                                  |    7 ++--
 net/ipv6/addrconf.c                                  |    3 +
 net/vmw_vsock/vmci_transport.c                       |    4 ++
 net/x25/af_x25.c                                     |    6 +--
 virt/kvm/kvm_main.c                                  |    3 +
 25 files changed, 135 insertions(+), 46 deletions(-)

Alexander Duyck (1):
      net: Do not allocate page fragments that are not skb aligned

Arnd Bergmann (1):
      mfd: as3722: Mark PM functions as __maybe_unused

David S. Miller (1):
      net: Add header for usage of fls64()

Eric Dumazet (6):
      tcp: tcp_v4_err() should be more careful
      tcp: clear icsk_backoff in tcp_write_queue_purge()
      vxlan: test dev->flags & IFF_UP before calling netif_rx()
      net/x25: do not hold the cpu too long in x25_new_lci()
      mISDN: fix a race in dev_expire_timer()
      ax25: fix possible use-after-free

Greg Kroah-Hartman (1):
      Linux 4.4.176

Hauke Mehrtens (1):
      net: Fix for_each_netdev_feature on Big endian

Jann Horn (1):
      kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

Joerg Roedel (1):
      KVM: VMX: Fix x2apic check in vmx_msr_bitmap_mode()

Jon Hunter (1):
      mfd: as3722: Handle interrupts on suspend

Jose Abreu (1):
      net: stmmac: Fix a race in EEE enable callback

Kai-Heng Feng (1):
      sky2: Increase D3 delay again

Lorenzo Bianconi (1):
      net: ipv4: use a dedicated counter for icmp_v4 redirect packets

Paolo Abeni (1):
      vsock: cope with memory allocation failure at socket creation time

Wei Yongjun (1):
      hwmon: (lm80) Fix missing unlock on error in set_fan_div()

Zhiqiang Liu (1):
      net: fix IPv6 prefix route residue

chenzefeng (A) (1):
      x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32


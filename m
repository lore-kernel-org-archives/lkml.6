Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ECEC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FC6213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDqpeZ8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FC6213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeJKXKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:10:33 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D50D21480;
        Thu, 11 Oct 2018 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272568;
        bh=Vpul6Xk+m4EkHvB7j8orAJDzG9vzOQbBPfoXB3k7eP0=;
        h=From:To:Cc:Subject:Date:From;
        b=oDqpeZ8LxmMT343BhMS3NrKvKrgoGdY6RLzMWugT7lLNgqO7k9VSQK0RF3H8Oyp0+
         PvQQKB+tTyZEp0qOvlkG/dASrcjOyPhCgStCXcnIyd5XAX9AM2Kx1DFRY5A7WXmPer
         FjBpB3KdLHjmOHcY2gd5hw+3dFA8YFX5s/tX8qNU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/27] 4.4.161-stable review
Date:   Thu, 11 Oct 2018 17:34:47 +0200
Message-Id: <20181011152534.014964888@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.161-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.161-rc1
X-KernelTest-Deadline: 2018-10-13T15:25+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.161 release.
There are 27 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Oct 13 15:25:23 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.161-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.161-rc1

Gao Feng <gfree.wind@vip.163.com>
    ebtables: arpreply: Add the standard target sanity check

Zhi Chen <zhichen@codeaurora.org>
    ath10k: fix scan crash due to incorrect length calculation

Eric Dumazet <edumazet@google.com>
    tcp: add tcp_ooo_try_coalesce() helper

Eric Dumazet <edumazet@google.com>
    tcp: call tcp_drop() from tcp_data_queue_ofo()

Eric Dumazet <edumazet@google.com>
    tcp: free batches of packets in tcp_prune_ofo_queue()

Eric Dumazet <edumazet@google.com>
    tcp: fix a stale ooo_last_skb after a replace

Yaogong Wang <wygivan@google.com>
    tcp: use an RB tree for ooo receive queue

Eric Dumazet <edumazet@google.com>
    tcp: increment sk_drops for dropped rx packets

Richard Weinberger <richard@nod.at>
    ubifs: Check for name being NULL while mounting

Cong Wang <xiyou.wangcong@gmail.com>
    ucma: fix a use-after-free in ucma_resolve_ip()

Vineet Gupta <vgupta@synopsys.com>
    ARC: clone syscall to setp r25 as thread pointer

Michal Suchanek <msuchanek@suse.de>
    powerpc/fadump: Return error when fadump registration fails

Carl Huang <cjhuang@codeaurora.org>
    ath10k: fix use-after-free in ath10k_wmi_cmd_send_nowait

Prateek Sood <prsood@codeaurora.org>
    cgroup: Fix deadlock in cpu hotplug path

Theodore Ts'o <tytso@mit.edu>
    ext4: always verify the magic number in xattr blocks

Theodore Ts'o <tytso@mit.edu>
    ext4: add corruption check in ext4_xattr_set_entry()

Guenter Roeck <linux@roeck-us.net>
    of: unittest: Disable interrupt node tests for old world MAC systems

Johan Hovold <johan@kernel.org>
    USB: serial: simple: add Motorola Tetra MTP6550 id

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Add missing CAS workaround for Intel Sunrise Point xHCI

Mike Snitzer <snitzer@redhat.com>
    dm cache: fix resize crash if user doesn't reload cache table

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM / core: Clear the direct_complete flag on errors

Felix Fietkau <nbd@nbd.name>
    mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Daniel Drake <drake@endlessm.com>
    PCI: Reprogram bridge prefetch registers on resume

Andy Lutomirski <luto@kernel.org>
    x86/vdso: Fix vDSO syscall fallback asm constraint regression

Andy Lutomirski <luto@kernel.org>
    x86/vdso: Fix asm constraints on vDSO syscall fallbacks

Tomi Valkeinen <tomi.valkeinen@ti.com>
    fbdev/omapfb: fix omapfb_memory_read infoleak

Jann Horn <jannh@google.com>
    mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly


-------------

Diffstat:

 Makefile                                        |   4 +-
 arch/arc/kernel/process.c                       |  20 ++
 arch/powerpc/kernel/fadump.c                    |  23 +-
 arch/x86/entry/vdso/vclock_gettime.c            |  26 +-
 drivers/base/power/main.c                       |   5 +-
 drivers/infiniband/core/ucma.c                  |   2 +
 drivers/md/dm-cache-target.c                    |   9 +-
 drivers/net/wireless/ath/ath10k/trace.h         |  12 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c       |   8 +-
 drivers/net/wireless/ath/ath10k/wmi.c           |   2 +-
 drivers/of/unittest.c                           |  28 +-
 drivers/pci/pci.c                               |  27 +-
 drivers/usb/host/xhci-pci.c                     |   2 +
 drivers/usb/serial/usb-serial-simple.c          |   3 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |   5 +-
 fs/ext4/xattr.c                                 |  28 +-
 fs/ubifs/super.c                                |   3 +
 include/linux/netfilter_bridge/ebtables.h       |   5 +
 include/linux/skbuff.h                          |   8 +
 include/linux/tcp.h                             |   7 +-
 include/net/sock.h                              |   7 +
 include/net/tcp.h                               |   2 +-
 kernel/cgroup.c                                 |   6 +-
 mm/vmstat.c                                     |   3 +
 net/bridge/netfilter/ebt_arpreply.c             |   3 +
 net/core/skbuff.c                               |  19 ++
 net/ipv4/tcp.c                                  |   4 +-
 net/ipv4/tcp_input.c                            | 417 +++++++++++++++---------
 net/ipv4/tcp_ipv4.c                             |   3 +-
 net/ipv4/tcp_minisocks.c                        |   1 -
 net/ipv6/tcp_ipv6.c                             |   1 +
 net/mac80211/cfg.c                              |   2 +-
 32 files changed, 453 insertions(+), 242 deletions(-)



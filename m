Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CA8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEE720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEE720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389481AbeGWNcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:32:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46420 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388697AbeGWNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:32:13 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8CCCEC03;
        Mon, 23 Jul 2018 12:31:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/28] 4.9.115-stable review
Date:   Mon, 23 Jul 2018 14:25:00 +0200
Message-Id: <20180723122425.241418073@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.115-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.115-rc1
X-KernelTest-Deadline: 2018-07-25T12:24+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.115 release.
There are 28 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jul 25 12:24:13 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.115-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.115-rc1

Alan Jenkins <alan.christopher.jenkins@gmail.com>
    block: do not use interruptible wait anywhere

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Return -ENOBUFS when no pages are available

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix perceived dead host due to runtime suspend race with event handler

Stefano Brivio <sbrivio@redhat.com>
    skbuff: Unconditionally copy pfmemalloc in __skb_clone()

Stefano Brivio <sbrivio@redhat.com>
    net: Don't copy pfmemalloc flag in __copy_skb_header()

Alexander Couzens <lynxis@fe80.eu>
    net: usb: asix: replace mii_nway_restart in resume path

Sanjeev Bansal <sanjeevb.bansal@broadcom.com>
    tg3: Add higher cpu clock for 5762.

Matevz Vucnik <vucnikm@gmail.com>
    qmi_wwan: add support for Quectel EG91

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ptp: fix missing break in switch

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: fix flag masking in __set_phy_supported

David Ahern <dsahern@gmail.com>
    net/ipv4: Set oif in fib_compute_spec_dst

Lorenzo Colitti <lorenzo@google.com>
    net: diag: Don't double-free TCP_NEW_SYN_RECV sockets in tcp_abort

Davidlohr Bueso <dave@stgolabs.net>
    lib/rhashtable: consider param->min_size when setting initial table size

Colin Ian King <colin.king@canonical.com>
    ipv6: fix useless rol32 call on hash

Tyler Hicks <tyhicks@canonical.com>
    ipv4: Return EINVAL when ping_group_range sysctl doesn't map to user ns

Toke Høiland-Jørgensen <toke@toke.dk>
    gen_stats: Fix netlink stats dumping in the presence of padding

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix hotplug irq ack on i965/g4x

Gustavo A. R. Silva <gustavo@embeddedor.com>
    vfio/pci: Fix potential Spectre v1

Hugh Dickins <hughd@google.com>
    mm/huge_memory.c: fix data loss when splitting a file pmd

Jing Xia <jing.xia.mail@gmail.com>
    mm: memcg: fix use after free in mem_cgroup_iter()

Alexey Brodkin <Alexey.Brodkin@synopsys.com>
    ARC: configs: Remove CONFIG_INITRAMFS_SOURCE from defconfigs

Vineet Gupta <vgupta@synopsys.com>
    ARC: mm: allow mprotect to make stack mappings executable

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: Fix CONFIG_SWAP

Takashi Iwai <tiwai@suse.de>
    ALSA: rawmidi: Change resized buffers atomically

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
    fat: fix memory allocation failure handling of match_strdup()

Dewet Thibaut <thibaut.dewet@nokia.com>
    x86/MCE: Remove min interval polling limitation

Ville Syrjälä <ville.syrjala@linux.intel.com>
    x86/apm: Don't access __preempt_count with zeroed fs

Lan Tianyu <tianyu.lan@intel.com>
    KVM/Eventfd: Avoid crash when assign and deassign specific eventfd in parallel.


-------------

Diffstat:

 Makefile                                   |  4 +--
 arch/arc/configs/axs101_defconfig          |  1 -
 arch/arc/configs/axs103_defconfig          |  1 -
 arch/arc/configs/axs103_smp_defconfig      |  1 -
 arch/arc/configs/nsim_700_defconfig        |  1 -
 arch/arc/configs/nsim_hs_defconfig         |  1 -
 arch/arc/configs/nsim_hs_smp_defconfig     |  1 -
 arch/arc/configs/nsimosci_defconfig        |  1 -
 arch/arc/configs/nsimosci_hs_defconfig     |  1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig |  1 -
 arch/arc/include/asm/page.h                |  2 +-
 arch/arc/include/asm/pgtable.h             |  2 +-
 arch/x86/include/asm/apm.h                 |  6 -----
 arch/x86/kernel/apm_32.c                   |  5 ++++
 arch/x86/kernel/cpu/mcheck/mce.c           |  3 ---
 block/blk-core.c                           |  9 +++----
 drivers/gpu/drm/i915/i915_irq.c            | 32 ++++++++++++++++++++++--
 drivers/net/ethernet/broadcom/tg3.c        |  9 +++++++
 drivers/net/phy/phy_device.c               |  7 ++----
 drivers/net/usb/asix_devices.c             |  4 ++-
 drivers/net/usb/qmi_wwan.c                 |  1 +
 drivers/ptp/ptp_chardev.c                  |  1 +
 drivers/usb/host/xhci.c                    | 40 +++++++++++++++++++++++++++---
 drivers/usb/host/xhci.h                    |  4 +++
 drivers/vfio/pci/vfio_pci.c                |  4 +++
 fs/fat/inode.c                             | 20 +++++++++------
 include/linux/skbuff.h                     | 10 ++++----
 include/net/ipv6.h                         |  2 +-
 lib/rhashtable.c                           | 17 ++++++++-----
 mm/huge_memory.c                           |  2 ++
 mm/memcontrol.c                            |  2 +-
 net/core/gen_stats.c                       | 16 ++++++++++--
 net/core/skbuff.c                          |  1 +
 net/ipv4/fib_frontend.c                    |  1 +
 net/ipv4/sysctl_net_ipv4.c                 |  5 ++--
 net/ipv4/tcp.c                             |  3 +--
 net/sunrpc/xprtrdma/rpc_rdma.c             |  2 +-
 sound/core/rawmidi.c                       | 20 ++++++++++-----
 virt/kvm/eventfd.c                         |  6 ++++-
 39 files changed, 176 insertions(+), 73 deletions(-)



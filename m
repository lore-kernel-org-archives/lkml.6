Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ACBC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD97F217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD97F217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbeHDLGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:06:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49014 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeHDLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:06:08 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01BB2BB3;
        Sat,  4 Aug 2018 09:06:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/32] 4.9.118-stable review
Date:   Sat,  4 Aug 2018 11:00:50 +0200
Message-Id: <20180804082649.908295462@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.118-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.118-rc1
X-KernelTest-Deadline: 2018-08-06T08:26+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.118 release.
There are 32 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Aug  6 08:26:35 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.118-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.118-rc1

Tony Battersby <tonyb@cybernetics.com>
    scsi: sg: fix minor memory leak in error path

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Reset ->{x, y}_scaling[1] when dealing with uniplanar formats

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: padlock-aes - Fix Nano workaround data corruption

Roman Kagan <rkagan@virtuozzo.com>
    kvm: x86: vmx: fix vpid leak

Jiang Biao <jiang.biao2@zte.com.cn>
    virtio_balloon: fix another race between migration and ballooning

Jeremy Cline <jcline@redhat.com>
    net: socket: fix potential spectre v1 gadget in socketcall

Anton Vasilyev <vasilyev@ispras.ru>
    can: ems_usb: Fix memory leak on ems_usb_disconnect()

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: more metadata hardenings

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: more metadata hardening

Jose Abreu <Jose.Abreu@synopsys.com>
    net: stmmac: Fix WoL for PCI-based setups

Jeremy Cline <jcline@redhat.com>
    netlink: Fix spectre v1 gadget in netlink_create()

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: Do not suspend/resume closed slave_dev

Eric Dumazet <edumazet@google.com>
    ipv4: frags: handle possible skb truesize change

Eric Dumazet <edumazet@google.com>
    inet: frag: enforce memory limits earlier

Eric Dumazet <edumazet@google.com>
    bonding: avoid lockdep confusion in bond_get_stats()

Boqun Feng <boqun.feng@gmail.com>
    sched/wait: Remove the lockless swait_active() check in swake_up*()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: intel: Read back TX buffer state

Eric Dumazet <edumazet@google.com>
    tcp: add one more quick ack after after ECN events

Yousuk Seung <ysseung@google.com>
    tcp: refactor tcp_ecn_check_ce to remove sk type cast

Eric Dumazet <edumazet@google.com>
    tcp: do not aggressively quick ack after ECN events

Eric Dumazet <edumazet@google.com>
    tcp: add max_quickacks param to tcp_incr_quickack and tcp_enter_quickack_mode

Eric Dumazet <edumazet@google.com>
    tcp: do not force quickack when receiving out-of-order packets

Dmitry Safonov <dima@arista.com>
    netlink: Don't shift with UB on nlk->ngroups

Dmitry Safonov <dima@arista.com>
    netlink: Do not subscribe to non-existent groups

Xiao Liang <xiliang@redhat.com>
    xen-netfront: wait xenbus state change when load module manually

Neal Cardwell <ncardwell@google.com>
    tcp_bbr: fix bw probing to raise in-flight data for very small BDPs

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    NET: stmmac: align DMA stuff to largest cache line length

Anton Vasilyev <vasilyev@ispras.ru>
    net: mdio-mux: bcm-iproc: fix wrong getter and setter pair

Stefan Wahren <stefan.wahren@i2se.com>
    net: lan78xx: fix rx handling before first packet is send

tangpengpeng <tangpengpeng@higon.com>
    net: fix amd-xgbe flow-control issue

Gal Pressman <pressmangal@gmail.com>
    net: ena: Fix use of uninitialized DMA address bits field

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ipv4: remove BUG_ON() from fib_compute_spec_dst


-------------

Diffstat:

 Makefile                                          |  4 +-
 arch/x86/kvm/vmx.c                                |  7 ++--
 drivers/crypto/padlock-aes.c                      |  8 +++-
 drivers/gpu/drm/vc4/vc4_plane.c                   |  3 ++
 drivers/net/bonding/bond_main.c                   | 14 ++++++-
 drivers/net/can/usb/ems_usb.c                     |  1 +
 drivers/net/ethernet/amazon/ena/ena_com.c         |  1 +
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c         |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c  | 40 ++++++++++++++++++-
 drivers/net/phy/mdio-mux-bcm-iproc.c              |  2 +-
 drivers/net/usb/lan78xx.c                         |  2 +
 drivers/net/xen-netfront.c                        |  6 +++
 drivers/pinctrl/intel/pinctrl-intel.c             |  7 +++-
 drivers/scsi/sg.c                                 |  1 +
 drivers/virtio/virtio_balloon.c                   |  2 +
 fs/squashfs/block.c                               |  2 +
 fs/squashfs/fragment.c                            | 13 ++++--
 fs/squashfs/squashfs_fs_sb.h                      |  1 +
 fs/squashfs/super.c                               |  5 ++-
 include/net/tcp.h                                 |  2 +-
 kernel/sched/swait.c                              |  6 ---
 net/dsa/slave.c                                   |  6 +++
 net/ipv4/fib_frontend.c                           |  4 +-
 net/ipv4/inet_fragment.c                          | 10 ++---
 net/ipv4/ip_fragment.c                            |  5 +++
 net/ipv4/tcp_bbr.c                                |  4 ++
 net/ipv4/tcp_dctcp.c                              |  4 +-
 net/ipv4/tcp_input.c                              | 48 ++++++++++++-----------
 net/netlink/af_netlink.c                          |  7 ++++
 net/socket.c                                      |  2 +
 31 files changed, 161 insertions(+), 62 deletions(-)



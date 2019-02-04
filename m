Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8310AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4184F207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278587;
	bh=B1ePIU5M8GzV/OBT9vN0DJj5dzvOXAu6OStQGSvdwQI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jDKt1ihh2UnSuE0zfqeJnhAOweY2a4RdNy69Xfjk5RX4dV124YjV7eXRWoEE3IMfJ
	 aJ5x8Yfe5VQgA+39ekF1/UMVXZIZlfQ/xjRHJ4NJKYzADHXXb7so/fysKSwYIa6JiV
	 fZTSAWde4Mh+ousugBzSRU9lZXDfwu/pM+mMOUWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfBDKkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbfBDKkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D222070C;
        Mon,  4 Feb 2019 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276823;
        bh=B1ePIU5M8GzV/OBT9vN0DJj5dzvOXAu6OStQGSvdwQI=;
        h=From:To:Cc:Subject:Date:From;
        b=zCj7AV0Wq6QxVCb9PvXTF6Lz/dmmJ9SI/2gv2q2HBIQb2z6uBTIZKRYQin80MzLhW
         0qKY5jgrrVq5GNzB8oyknRauBG0jYRSm7cdadLy+Tt7xID9sSIgXeUWJxMIPs/BlVl
         u0fX8Ws6PaIa1k7W5xyqL9zPNzDU9bwb5FuLflFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/65] 4.4.173-stable review
Date:   Mon,  4 Feb 2019 11:35:53 +0100
Message-Id: <20190204103610.583715954@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.173-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.173-rc1
X-KernelTest-Deadline: 2019-02-06T10:36+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.173 release.
There are 65 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb  6 10:35:30 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.173-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.173-rc1

Dan Carpenter <dan.carpenter@oracle.com>
    ipv4: frags: precedence bug in ip_expire()

Taehee Yoo <ap420073@gmail.com>
    ip: frags: fix crash in ip_do_fragment()

Michal Kubecek <mkubecek@suse.cz>
    net: ipv4: do not handle duplicate fragments as overlapping

Peter Oskolkov <posk@google.com>
    ip: process in-order fragments efficiently

Peter Oskolkov <posk@google.com>
    ip: add helpers to process in-order fragments faster.

Florian Westphal <fw@strlen.de>
    ipv6: defrag: drop non-last frags smaller than min mtu

Peter Oskolkov <posk@google.com>
    ip: use rb trees for IP frag queue.

Eric Dumazet <edumazet@google.com>
    inet: frags: get rif of inet_frag_evicting()

Peter Oskolkov <posk@google.com>
    net: modify skb_rbtree_purge to return the truesize of all purged skbs.

Peter Oskolkov <posk@google.com>
    ip: discard IPv4 datagrams with overlapping segments.

Dave Chinner <dchinner@redhat.com>
    fs: don't scan the inode cache before SB_BORN is set

David Hildenbrand <david@redhat.com>
    mm: migrate: don't rely on __PageMovable() of newpage after unlocking it

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    drivers: core: Remove glue dirs from sysfs earlier

Paulo Alcantara <paulo@paulo.ac>
    cifs: Always resolve hostname before reconnecting

Shakeel Butt <shakeelb@google.com>
    mm, oom: fix use-after-free in oom_kill_process

Andrei Vagin <avagin@gmail.com>
    kernel/exit.c: release ptraced tasks before zap_pid_ns_processes

Stefan Wahren <stefan.wahren@i2se.com>
    mmc: sdhci-iproc: handle mmc_of_parse() errors during probe

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Revert "Fix loop in gfs2_rbm_find"

James Morse <james.morse@arm.com>
    arm64: hyp-stub: Forbid kprobing of the hyp-stub

Koen Vandeputte <koen.vandeputte@ncentric.com>
    ARM: cns3xxx: Fix writing to wrong PCI config registers after alignment

Waiman Long <longman@redhat.com>
    fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache_sb()

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not count -ENODATA as failure for query directory

Jacob Wen <jian.w.wen@oracle.com>
    l2tp: fix reading optional fields of L2TPv3

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    l2tp: remove l2specific_len dependency in l2tp_core

Mathias Thore <mathias.thore@infinera.com>
    ucc_geth: Reset BQL queue when stopping device

Bernard Pidoux <f6bvp@free.fr>
    net/rose: fix NULL ax25_cb kernel panic

Cong Wang <xiyou.wangcong@gmail.com>
    netrom: switch to sock timer API

Aya Levin <ayal@mellanox.com>
    net/mlx4_core: Add masking for a few queries on HCA caps

Jacob Wen <jian.w.wen@oracle.com>
    l2tp: copy 4 more bytes to linear part if necessary

David Ahern <dsahern@gmail.com>
    ipv6: Consider sk_bound_dev_if when binding a socket to an address

Jimmy Durand Wesolowski <jdw@amazon.de>
    fs: add the fsnotify call to vfs_iter_write

David Hildenbrand <david@redhat.com>
    s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "loop: Fold __loop_release into loop_release"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "loop: Get rid of loop_index_mutex"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()"

Pan Bian <bianpan2016@163.com>
    f2fs: read page index before freeing

Shaokun Zhang <zhangshaokun@hisilicon.com>
    arm64: mm: remove page_mapping check in __sync_icache_dcache

Marc Zyngier <marc.zyngier@arm.com>
    irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

Milian Wolff <milian.wolff@kdab.com>
    perf unwind: Take pgoff into account when reporting elf to libdwfl

Martin Vuille <jpmv27@aim.com>
    perf unwind: Unwind with libdw doesn't take symfs into account

Nicolas Pitre <nicolas.pitre@linaro.org>
    vt: invoke notifier on screen size change

Oliver Hartkopp <socketcan@hartkopp.net>
    can: bcm: check timer values before ktime conversion

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb by removing it

Daniel Drake <drake@endlessm.com>
    x86/kaslr: Fix incorrect i8254 outb() parameters

Alexander Popov <alex.popov@linux.com>
    KVM: x86: Fix single-step debugging

Tom Panfil <tom@steelseries.com>
    Input: xpad - add support for SteelSeries Stratus Duo

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix possible hang during async MTU reads and writes

Paul Fulghum <paulkf@microgate.com>
    tty/n_hdlc: fix __might_sleep warning

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: Handle problem if line discipline does not have receive_buf

Michael Straube <straube.linux@gmail.com>
    staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    char/mwave: fix potential Spectre v1 vulnerability

Gerald Schaefer <gerald.schaefer@de.ibm.com>
    s390/smp: fix CPU hotplug deadlock with CPU rescan

Christian Borntraeger <borntraeger@de.ibm.com>
    s390/early: improve machine detection

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: perf: map generic branches to correct hardware condition

Kangjie Lu <kjlu@umn.edu>
    ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

Charles Yeh <charlesyeh522@gmail.com>
    USB: serial: pl2303: add new PID to support PL2303TB

Max Schulze <max.schulze@posteo.de>
    USB: serial: simple: add Motorola Tetra TPG2200 device id

Vijay Viswanath <vviswana@codeaurora.org>
    mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS

Yunjian Wang <wangyunjian@huawei.com>
    net: bridge: Fix ethernet header pointer before check skb forwardable

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: refetch skb protocol for each filter

Ido Schimmel <idosch@mellanox.com>
    net: ipv4: Fix memory leak in network namespace dismantle

Ross Lagerwall <ross.lagerwall@citrix.com>
    openvswitch: Avoid OOB read when parsing flow nlattrs

Ross Lagerwall <ross.lagerwall@citrix.com>
    net: Fix usage of pskb_trim_rcsum


-------------

Diffstat:

 Makefile                                     |   4 +-
 arch/arc/include/asm/perf_event.h            |   3 +-
 arch/arm/mach-cns3xxx/pcie.c                 |   2 +-
 arch/arm64/kernel/hyp-stub.S                 |   2 +
 arch/arm64/mm/flush.c                        |   4 -
 arch/s390/kernel/early.c                     |   4 +-
 arch/s390/kernel/setup.c                     |   2 +
 arch/s390/kernel/smp.c                       |  12 +-
 arch/x86/boot/compressed/aslr.c              |   4 +-
 arch/x86/kvm/x86.c                           |   3 +-
 drivers/base/core.c                          |   2 +
 drivers/block/loop.c                         |  47 +--
 drivers/char/mwave/mwavedd.c                 |   7 +
 drivers/input/joystick/xpad.c                |   3 +
 drivers/irqchip/irq-gic-v3-its.c             |  25 +-
 drivers/mmc/host/Kconfig                     |   1 +
 drivers/mmc/host/sdhci-iproc.c               |   5 +-
 drivers/net/can/dev.c                        |  27 +-
 drivers/net/ethernet/freescale/ucc_geth.c    |   2 +
 drivers/net/ethernet/mellanox/mlx4/fw.c      |  75 +++--
 drivers/net/ppp/pppoe.c                      |   1 +
 drivers/platform/x86/asus-nb-wmi.c           |   3 +-
 drivers/s390/char/sclp_config.c              |   2 +
 drivers/staging/rtl8188eu/os_dep/usb_intf.c  |   1 +
 drivers/tty/n_hdlc.c                         |   1 +
 drivers/tty/tty_io.c                         |   3 +-
 drivers/tty/vt/vt.c                          |   1 +
 drivers/usb/serial/pl2303.c                  |   1 +
 drivers/usb/serial/pl2303.h                  |   2 +
 drivers/usb/serial/usb-serial-simple.c       |   3 +-
 fs/cifs/connect.c                            |  53 ++++
 fs/cifs/smb2ops.c                            |   6 +-
 fs/cifs/smb2pdu.c                            |   4 +-
 fs/dcache.c                                  |   6 +-
 fs/f2fs/node.c                               |   4 +-
 fs/gfs2/rgrp.c                               |   2 +-
 fs/read_write.c                              |   4 +-
 fs/super.c                                   |  30 +-
 include/linux/kobject.h                      |  17 ++
 include/linux/skbuff.h                       |   5 +-
 include/net/inet_frag.h                      |  12 +-
 include/net/ip_fib.h                         |   2 +-
 include/uapi/linux/snmp.h                    |   1 +
 kernel/exit.c                                |  12 +-
 mm/migrate.c                                 |   7 +-
 mm/oom_kill.c                                |   8 +
 net/bridge/br_forward.c                      |   7 +-
 net/bridge/br_netfilter_ipv6.c               |   1 +
 net/bridge/netfilter/nft_reject_bridge.c     |   1 +
 net/can/bcm.c                                |  27 ++
 net/core/skbuff.c                            |   6 +-
 net/ipv4/fib_frontend.c                      |   4 +-
 net/ipv4/fib_trie.c                          |  14 +-
 net/ipv4/inet_fragment.c                     |  16 +-
 net/ipv4/ip_fragment.c                       | 410 ++++++++++++++++-----------
 net/ipv4/ip_input.c                          |   1 +
 net/ipv4/proc.c                              |   1 +
 net/ipv6/af_inet6.c                          |   3 +
 net/ipv6/netfilter/nf_conntrack_reasm.c      |   6 +
 net/ipv6/reassembly.c                        |   9 +-
 net/l2tp/l2tp_core.c                         |  43 +--
 net/l2tp/l2tp_core.h                         |  31 ++
 net/l2tp/l2tp_ip.c                           |   3 +
 net/l2tp/l2tp_ip6.c                          |   3 +
 net/netrom/nr_timer.c                        |  20 +-
 net/openvswitch/flow_netlink.c               |   2 +-
 net/rose/rose_route.c                        |   5 +
 net/sched/sch_api.c                          |   3 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |   8 +-
 tools/perf/util/unwind-libdw.c               |   4 +-
 70 files changed, 706 insertions(+), 347 deletions(-)



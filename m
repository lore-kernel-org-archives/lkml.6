Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668C8C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AF1217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277125;
	bh=2GMHefr+RD3OEguT2G1HNtE0PEKeCFt3bN2YkoVKRo0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1NEE0rQuTncygerjtSlXH/jKk6p+1PxnytEwvMGXlgY47/wpBOS65Djd4b7Goel3h
	 eIuARjlWI/jCprh/xFgvqUkqh1llvmw2zWzsm8PKhfU5RI7wSRk4EbrmX5YdVEUIp7
	 nIG/+CC1v7WkI9qmsTZPZt+T0kukpI18Au4s/vKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfBDKpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbfBDKpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:45:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FFF92070C;
        Mon,  4 Feb 2019 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277118;
        bh=2GMHefr+RD3OEguT2G1HNtE0PEKeCFt3bN2YkoVKRo0=;
        h=From:To:Cc:Subject:Date:From;
        b=CN6NVGZuQha1lsaQekBmWip8UJkeC3HUPOyR1Ikm+itjdeW2d8YqLtMwBNZtSflye
         O2GlKN9HWQ7uTHywqtZGDdAJtp1BbZr1InZMX3io/GytCkPYzUloNXBQaYNxITcqh+
         A9Zm4tDUDj9xuzYU5XDllnhhP38QzVUhI+91eFCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/46] 4.14.98-stable review
Date:   Mon,  4 Feb 2019 11:36:31 +0100
Message-Id: <20190204103608.651205056@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.98-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.98-rc1
X-KernelTest-Deadline: 2019-02-06T10:36+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.98 release.
There are 46 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb  6 10:35:31 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.98-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.98-rc1

Amir Goldstein <amir73il@gmail.com>
    fanotify: fix handling of events on child sub-directory

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    drivers: core: Remove glue dirs from sysfs earlier

Paulo Alcantara <paulo@paulo.ac>
    cifs: Always resolve hostname before reconnecting

Alexei Naberezhnov <anaberezhnov@fb.com>
    md/raid5: fix 'out of memory' during raid cache recovery

David Hildenbrand <david@redhat.com>
    mm: migrate: don't rely on __PageMovable() of newpage after unlocking it

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    mm: hwpoison: use do_send_sig_info() instead of force_sig()

Shakeel Butt <shakeelb@google.com>
    mm, oom: fix use-after-free in oom_kill_process

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    oom, oom_reaper: do not enqueue same task twice

Andrei Vagin <avagin@gmail.com>
    kernel/exit.c: release ptraced tasks before zap_pid_ns_processes

Stefan Wahren <stefan.wahren@i2se.com>
    mmc: sdhci-iproc: handle mmc_of_parse() errors during probe

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Remove overly conservative VM_EXEC flag check

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed hp_pin no value

Lukas Wunner <lukas@wunner.de>
    mmc: bcm2835: Fix DMA channel leak on probe error

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Revert "Fix loop in gfs2_rbm_find"

Roger Quadros <rogerq@ti.com>
    gpio: pcf857x: Fix interrupts on multiple instances

Axel Lin <axel.lin@ingics.com>
    gpio: altera-a10sr: Set proper output level for direction_output

James Morse <james.morse@arm.com>
    arm64: hibernate: Clean the __hyp_text to PoC after resume

James Morse <james.morse@arm.com>
    arm64: hyp-stub: Forbid kprobing of the hyp-stub

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: kaslr: ensure randomized quantities are clean also when kaslr is off

Koen Vandeputte <koen.vandeputte@ncentric.com>
    ARM: cns3xxx: Fix writing to wrong PCI config registers after alignment

Trond Myklebust <trondmy@gmail.com>
    NFS: Fix up return value on fatal errors in nfs_page_async_flush()

Kees Cook <keescook@chromium.org>
    selftests/seccomp: Enhance per-arch ptrace syscall skip tests

Gerald Schaefer <gerald.schaefer@de.ibm.com>
    iommu/vt-d: Fix memory leak in intel_iommu_put_resv_regions()

Waiman Long <longman@redhat.com>
    fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache_sb()

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not count -ENODATA as failure for query directory

Daniel Borkmann <daniel@iogearbox.net>
    ipvlan, l3mdev: fix broken l3s mode wrt local routes

Jacob Wen <jian.w.wen@oracle.com>
    l2tp: fix reading optional fields of L2TPv3

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    l2tp: remove l2specific_len dependency in l2tp_core

Xin Long <lucien.xin@gmail.com>
    sctp: improve the events for sctp stream reset

Xin Long <lucien.xin@gmail.com>
    sctp: improve the events for sctp stream adding

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Fix not restoring real_num_rx_queues

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Don't call free_old_xmit_skbs for xdp_frames

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Don't enable NAPI when interface is down

Bodong Wang <bodong@mellanox.com>
    Revert "net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager"

Aya Levin <ayal@mellanox.com>
    net/mlx5e: Allow MAC invalidation while spoofchk is ON

Mathias Thore <mathias.thore@infinera.com>
    ucc_geth: Reset BQL queue when stopping device

Josh Elsasser <jelsasser@appneta.com>
    net: set default network namespace in init_dummy_netdev()

Bernard Pidoux <f6bvp@free.fr>
    net/rose: fix NULL ax25_cb kernel panic

Cong Wang <xiyou.wangcong@gmail.com>
    netrom: switch to sock timer API

Aya Levin <ayal@mellanox.com>
    net/mlx4_core: Add masking for a few queries on HCA caps

Jacob Wen <jian.w.wen@oracle.com>
    l2tp: copy 4 more bytes to linear part if necessary

Yohei Kanemaru <yohei.kanemaru@gmail.com>
    ipv6: sr: clear IP6CB(skb) on SRH ip4ip6 encapsulation

David Ahern <dsahern@gmail.com>
    ipv6: Consider sk_bound_dev_if when binding a socket to an address

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Fix "net: ipv4: do not handle duplicate fragments as overlapping"


-------------

Diffstat:

 Makefile                                          |  4 +-
 arch/arm/mach-cns3xxx/pcie.c                      |  2 +-
 arch/arm64/kernel/hibernate.c                     |  4 +-
 arch/arm64/kernel/hyp-stub.S                      |  2 +
 arch/arm64/kernel/kaslr.c                         |  1 +
 drivers/base/core.c                               |  2 +
 drivers/gpio/gpio-altera-a10sr.c                  |  4 +-
 drivers/gpio/gpio-pcf857x.c                       | 26 ++++----
 drivers/infiniband/hw/hfi1/file_ops.c             |  2 +-
 drivers/iommu/intel-iommu.c                       |  2 +-
 drivers/md/raid5-cache.c                          | 33 ++++++----
 drivers/md/raid5.c                                |  8 ++-
 drivers/mmc/host/bcm2835.c                        |  2 +
 drivers/mmc/host/sdhci-iproc.c                    |  5 +-
 drivers/net/ethernet/freescale/ucc_geth.c         |  2 +
 drivers/net/ethernet/mellanox/mlx4/fw.c           | 75 +++++++++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 22 +++----
 drivers/net/ipvlan/ipvlan_main.c                  |  6 +-
 drivers/net/virtio_net.c                          | 55 ++++++++++------
 drivers/platform/x86/asus-nb-wmi.c                |  3 +-
 fs/cifs/connect.c                                 | 53 +++++++++++++++
 fs/cifs/smb2pdu.c                                 |  4 +-
 fs/dcache.c                                       |  6 +-
 fs/gfs2/rgrp.c                                    |  2 +-
 fs/nfs/write.c                                    |  9 +--
 fs/notify/fsnotify.c                              |  8 ++-
 include/linux/kobject.h                           | 17 +++++
 include/linux/netdevice.h                         |  8 +++
 include/linux/sched/coredump.h                    |  1 +
 include/net/l3mdev.h                              |  3 +-
 kernel/exit.c                                     | 12 +++-
 mm/memory-failure.c                               |  3 +-
 mm/migrate.c                                      |  7 +-
 mm/oom_kill.c                                     | 12 +++-
 net/core/dev.c                                    |  3 +
 net/ipv4/ip_fragment.c                            |  2 +-
 net/ipv6/af_inet6.c                               |  3 +
 net/ipv6/seg6_iptunnel.c                          |  2 +
 net/l2tp/l2tp_core.c                              | 43 +++++++------
 net/l2tp/l2tp_core.h                              | 31 +++++++++
 net/l2tp/l2tp_ip.c                                |  3 +
 net/l2tp/l2tp_ip6.c                               |  3 +
 net/netrom/nr_timer.c                             | 20 +++---
 net/rose/rose_route.c                             |  5 ++
 net/sctp/stream.c                                 | 62 ++++++++----------
 sound/pci/hda/patch_realtek.c                     | 78 +++++++++++++----------
 tools/testing/selftests/seccomp/seccomp_bpf.c     | 72 ++++++++++++++++-----
 47 files changed, 494 insertions(+), 238 deletions(-)



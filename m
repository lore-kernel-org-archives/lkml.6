Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D3C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740A52176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276975;
	bh=blQjEfFiUsi0v/+mACtita/nVa3sXx4+aJVCEQOW0F0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RhUICI2c1/j4S52XNAZWBZlDYP9xIROHGK1FfoPuRtNOsR7Gwi7t3Hdcst1xfIYfT
	 yMu83oEQzN0ApGGcnvYM0tfpxg4oKKJPwNUYsjsLra2aQ/CdoRjz+KpBJ6DPipir3q
	 c63v/iaPhQxO5SGSDwxjbYru4a0rQmilo0iqzhmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfBDKmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730610AbfBDKms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:42:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C58C2070C;
        Mon,  4 Feb 2019 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276968;
        bh=blQjEfFiUsi0v/+mACtita/nVa3sXx4+aJVCEQOW0F0=;
        h=From:To:Cc:Subject:Date:From;
        b=QOrBFvcl/qaNtlpebRKXAvO05e9AfP2Y9plcabJE129OaEEwlHa/qicrfpUM8PrP8
         d9509fkE5scvWxpMsOhVIOaBavPTJRVykMpQVobG2mtPiRmph8/r4gxd8HHU7WAXWa
         S0XL/8gSAAT2j7PQBI0PCjdtg+PvjrpZW5UPzZZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/30] 4.9.155-stable review
Date:   Mon,  4 Feb 2019 11:36:38 +0100
Message-Id: <20190204103605.271746870@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.155-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.155-rc1
X-KernelTest-Deadline: 2019-02-06T10:36+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.155 release.
There are 30 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb  6 10:35:37 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.155-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.155-rc1

Amir Goldstein <amir73il@gmail.com>
    fanotify: fix handling of events on child sub-directory

Dave Chinner <dchinner@redhat.com>
    fs: don't scan the inode cache before SB_BORN is set

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    drivers: core: Remove glue dirs from sysfs earlier

Paulo Alcantara <paulo@paulo.ac>
    cifs: Always resolve hostname before reconnecting

David Hildenbrand <david@redhat.com>
    mm: migrate: don't rely on __PageMovable() of newpage after unlocking it

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    mm: hwpoison: use do_send_sig_info() instead of force_sig()

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
    arm64: hibernate: Clean the __hyp_text to PoC after resume

James Morse <james.morse@arm.com>
    arm64: hyp-stub: Forbid kprobing of the hyp-stub

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: kaslr: ensure randomized quantities are clean also when kaslr is off

Koen Vandeputte <koen.vandeputte@ncentric.com>
    ARM: cns3xxx: Fix writing to wrong PCI config registers after alignment

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

Aya Levin <ayal@mellanox.com>
    net/mlx5e: Allow MAC invalidation while spoofchk is ON

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
 drivers/mmc/host/sdhci-iproc.c                    |  5 +-
 drivers/net/ethernet/freescale/ucc_geth.c         |  2 +
 drivers/net/ethernet/mellanox/mlx4/fw.c           | 75 ++++++++++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 19 ++----
 drivers/net/ipvlan/ipvlan_main.c                  |  6 +-
 drivers/platform/x86/asus-nb-wmi.c                |  3 +-
 fs/cifs/connect.c                                 | 53 ++++++++++++++++
 fs/cifs/smb2pdu.c                                 |  4 +-
 fs/dcache.c                                       |  6 +-
 fs/gfs2/rgrp.c                                    |  2 +-
 fs/notify/fsnotify.c                              |  8 ++-
 fs/read_write.c                                   |  4 +-
 fs/super.c                                        | 30 +++++++--
 include/linux/kobject.h                           | 17 +++++
 include/linux/netdevice.h                         |  8 +++
 include/net/l3mdev.h                              |  3 +-
 kernel/exit.c                                     | 12 +++-
 mm/memory-failure.c                               |  3 +-
 mm/migrate.c                                      |  7 ++-
 mm/oom_kill.c                                     |  8 +++
 net/ipv4/ip_fragment.c                            |  2 +-
 net/ipv6/af_inet6.c                               |  3 +
 net/l2tp/l2tp_core.c                              | 43 ++++++-------
 net/l2tp/l2tp_core.h                              | 31 ++++++++++
 net/l2tp/l2tp_ip.c                                |  3 +
 net/l2tp/l2tp_ip6.c                               |  3 +
 net/netrom/nr_timer.c                             | 20 +++---
 net/rose/rose_route.c                             |  5 ++
 34 files changed, 293 insertions(+), 107 deletions(-)



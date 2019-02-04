Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E188C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A03214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276684;
	bh=9QUujzjULV4NUNAe4pO3ciEgTWmVPc8yRlr1Kz4SoJI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MusHB/4pdJcWgVgzU2hXpzO4OOwxa7RNozmQPQIYukJdY0z7Zn0lY0NT73KjFKabT
	 94UFzvSlXv6WH3voS0qbj2fBOpGyCwcwtXzX3Hq3/QCv8NcCYVIw066JkCtPwsJ96s
	 DG8zArXRAvLbcDCgAJnmhbp7Zw5PI69sIYd/tMxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfBDKiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:38:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbfBDKiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:38:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C552070C;
        Mon,  4 Feb 2019 10:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276679;
        bh=9QUujzjULV4NUNAe4pO3ciEgTWmVPc8yRlr1Kz4SoJI=;
        h=From:To:Cc:Subject:Date:From;
        b=mnPE9ZJDVlFr5OUf76yVDmGiJQRs43uXNmFpf8T37dxuV5eZbsj6HmxqbWiHPjeao
         EO3MR8EqA8rNKs7n1MFNREB7QDuEwT0yuRMsATHjQsTOIjwG5rkSzjzvcba/NqIbf6
         pNMA0/Rx70KvFSI3iYKmq6PvgyBf5AzW7r4DNnHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/31] 3.18.134-stable review
Date:   Mon,  4 Feb 2019 11:36:15 +0100
Message-Id: <20190204103557.903263774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.134-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.134-rc1
X-KernelTest-Deadline: 2019-02-06T10:36+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.134 release.
There are 31 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb  6 10:35:28 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.134-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.134-rc1

David Hildenbrand <david@redhat.com>
    mm: migrate: don't rely on __PageMovable() of newpage after unlocking it

Shakeel Butt <shakeelb@google.com>
    mm, oom: fix use-after-free in oom_kill_process

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Revert "Fix loop in gfs2_rbm_find"

James Morse <james.morse@arm.com>
    arm64: hyp-stub: Forbid kprobing of the hyp-stub

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

Jacob Wen <jian.w.wen@oracle.com>
    l2tp: copy 4 more bytes to linear part if necessary

David Ahern <dsahern@gmail.com>
    ipv6: Consider sk_bound_dev_if when binding a socket to an address

Pan Bian <bianpan2016@163.com>
    f2fs: read page index before freeing

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

Gerald Schaefer <gerald.schaefer@de.ibm.com>
    s390/smp: fix CPU hotplug deadlock with CPU rescan

Charles Yeh <charlesyeh522@gmail.com>
    USB: serial: pl2303: add new PID to support PL2303TB

Max Schulze <max.schulze@posteo.de>
    USB: serial: simple: add Motorola Tetra TPG2200 device id

Ross Lagerwall <ross.lagerwall@citrix.com>
    openvswitch: Avoid OOB read when parsing flow nlattrs


-------------

Diffstat:

 Makefile                                    |  4 +--
 arch/arm64/kernel/hyp-stub.S                |  2 ++
 arch/s390/kernel/smp.c                      |  4 +++
 arch/x86/boot/compressed/aslr.c             |  4 +--
 drivers/input/joystick/xpad.c               |  3 ++
 drivers/net/can/dev.c                       | 27 +++++++++---------
 drivers/net/ethernet/freescale/ucc_geth.c   |  2 ++
 drivers/platform/x86/asus-nb-wmi.c          |  3 +-
 drivers/s390/char/sclp_config.c             |  2 ++
 drivers/staging/rtl8188eu/os_dep/usb_intf.c |  1 +
 drivers/tty/n_hdlc.c                        |  1 +
 drivers/tty/tty_io.c                        |  3 +-
 drivers/tty/vt/vt.c                         |  1 +
 drivers/usb/serial/pl2303.c                 |  1 +
 drivers/usb/serial/pl2303.h                 |  2 ++
 drivers/usb/serial/usb-serial-simple.c      |  3 +-
 fs/cifs/smb2ops.c                           |  6 ++--
 fs/cifs/smb2pdu.c                           |  4 +--
 fs/dcache.c                                 |  6 +---
 fs/f2fs/node.c                              |  4 ++-
 fs/gfs2/rgrp.c                              |  2 +-
 mm/migrate.c                                |  7 +++--
 mm/oom_kill.c                               |  8 ++++++
 net/can/bcm.c                               | 27 ++++++++++++++++++
 net/ipv6/af_inet6.c                         |  3 ++
 net/l2tp/l2tp_core.c                        | 43 +++++++++++++++--------------
 net/l2tp/l2tp_core.h                        | 31 +++++++++++++++++++++
 net/l2tp/l2tp_ip.c                          |  3 ++
 net/l2tp/l2tp_ip6.c                         |  3 ++
 net/netrom/nr_timer.c                       | 20 +++++++-------
 net/openvswitch/flow_netlink.c              |  2 +-
 net/rose/rose_route.c                       |  5 ++++
 tools/perf/util/unwind-libdw.c              |  4 +--
 33 files changed, 171 insertions(+), 70 deletions(-)



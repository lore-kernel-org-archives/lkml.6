Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B1A69C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BF3208BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu7dY/XB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BF3208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935126AbeFLQy6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933429AbeFLQyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:54:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C916F208B7;
        Tue, 12 Jun 2018 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822491;
        bh=CPE0x7cn771YjV9oCFtC1xRA1Aco1iGIZBax9dsWtKM=;
        h=From:To:Cc:Subject:Date:From;
        b=Hu7dY/XBUzNLc7bSGJq9ttoI+41nf8cVe8bz+qPkMoaXigkeLlzIV4j+X6V5uwwh+
         z1IJsUFqzx8xKXRkzP0/t0SD0/3CFwr8tfXDAF/4ydA9UEZqbmQCT+LsUCAdSLhDDz
         iHtg5HHea/a/zH0VEm/Yn1FRGoUSj/2SA7DesiJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/21] 3.18.113-stable review
Date:   Tue, 12 Jun 2018 18:51:57 +0200
Message-Id: <20180612164825.401145490@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.113-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.113-rc1
X-KernelTest-Deadline: 2018-06-14T16:48+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.113 release.
There are 21 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jun 14 16:48:15 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.113-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.113-rc1

Eric Dumazet <edumazet@google.com>
    rtnetlink: validate attributes in do_setlink()

Dan Carpenter <dan.carpenter@oracle.com>
    team: use netdev_features_t instead of u32

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4: Fix irq-unsafe spinlock usage

Daniele Palmas <dnlplm@gmail.com>
    net: usb: cdc_mbim: add flag FLAG_SEND_ZLP

Eric Dumazet <edumazet@google.com>
    net/packet: refine check for priv area size

Wenwen Wang <wang6495@umn.edu>
    isdn: eicon: fix a missing-check bug

Sabrina Dubroca <sd@queasysnail.net>
    ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succeeds

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: set DMA mask to 47 bit

Alexey Kodanev <alexey.kodanev@oracle.com>
    dccp: don't free ccid2_hc_tx_sock struct in dccp_disconnect()

Julia Lawall <Julia.Lawall@lip6.fr>
    bnx2x: use the right constant

Dave Airlie <airlied@redhat.com>
    drm: set FMODE_UNSIGNED_OFFSET for drm files

Linus Torvalds <torvalds@linux-foundation.org>
    mmap: relax file size limit for regular files

Linus Torvalds <torvalds@linux-foundation.org>
    mmap: introduce sane default mmap limits

Hugh Dickins <hughd@google.com>
    mm: fix the NULL mapping case in __isolate_lru_page()

Al Viro <viro@zeniv.linux.org.uk>
    fix io_destroy()/aio_complete() race

Ondrej Zary <linux@rainbow-software.org>
    drm/i915: Disable LVDS on Radiant P845

Maciej W. Rozycki <macro@mips.com>
    MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs

Eric Dumazet <edumazet@google.com>
    tcp: avoid integer overflows in tcp_rcv_space_adjust()

Eric Biggers <ebiggers@google.com>
    cfg80211: further limit wiphy names to 64 bytes

Sachin Grover <sgrover@codeaurora.org>
    selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix crash when freeing instances with event triggers


-------------

Diffstat:

 Makefile                                         |  4 +--
 arch/mips/kernel/ptrace.c                        |  2 +-
 arch/mips/kernel/ptrace32.c                      |  2 +-
 drivers/gpu/drm/drm_fops.c                       |  1 +
 drivers/gpu/drm/i915/intel_lvds.c                |  8 ++++++
 drivers/isdn/hardware/eicon/diva.c               | 22 ++++++++++------
 drivers/isdn/hardware/eicon/diva.h               |  5 ++--
 drivers/isdn/hardware/eicon/divasmain.c          | 18 +++++++------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c |  2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c      |  8 +++---
 drivers/net/ethernet/mellanox/mlx4/qp.c          |  4 +--
 drivers/net/team/team.c                          |  3 ++-
 drivers/net/usb/cdc_mbim.c                       |  2 +-
 fs/aio.c                                         |  3 +--
 include/linux/tcp.h                              |  2 +-
 include/uapi/linux/nl80211.h                     |  2 +-
 kernel/trace/trace_events_trigger.c              |  5 ++--
 mm/mmap.c                                        | 32 ++++++++++++++++++++++++
 mm/vmscan.c                                      |  2 +-
 net/core/rtnetlink.c                             |  8 +++---
 net/dccp/proto.c                                 |  2 --
 net/ipv4/tcp_input.c                             | 10 +++++---
 net/ipv6/ip6mr.c                                 |  3 ++-
 net/packet/af_packet.c                           |  2 +-
 security/selinux/ss/services.c                   |  2 +-
 25 files changed, 105 insertions(+), 49 deletions(-)



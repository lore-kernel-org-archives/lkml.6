Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AD1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B4B2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B4B2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbeGTNOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:14:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34874 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeGTNOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:14:40 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A3A0BBD;
        Fri, 20 Jul 2018 12:26:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/29] 3.18.116-stable review
Date:   Fri, 20 Jul 2018 14:10:55 +0200
Message-Id: <20180720115158.974693829@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.116-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.116-rc1
X-KernelTest-Deadline: 2018-07-22T11:52+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.116 release.
There are 29 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jul 22 11:51:47 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.116-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.116-rc1

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.

Santosh Shilimkar <santosh.shilimkar@oracle.com>
    rds: avoid unenecessary cong_update in loop transport

Eric Biggers <ebiggers@google.com>
    KEYS: DNS: fix parsing multiple options

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: reject non-bridge targets

Alex Vesker <valex@mellanox.com>
    net/mlx5: Fix command interface race in polling mode

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    net_sched: blackhole: tell upper qdisc about dropped packets

Jason Wang <jasowang@redhat.com>
    vhost_net: validate sock before trying to put its fd

Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
    tcp: prevent bogus FRTO undos with non-SACK flows

Yuchung Cheng <ycheng@google.com>
    tcp: fix Fast Open key endianness

Eric Dumazet <edumazet@google.com>
    net: sungem: fix rx checksum support

Alex Vesker <valex@mellanox.com>
    net/mlx5: Fix incorrect raw command length parsing

Eric Dumazet <edumazet@google.com>
    net: dccp: switch rx_tstamp_last_feedback to monotonic clock

Eric Dumazet <edumazet@google.com>
    net: dccp: avoid crash in ccid3_hc_rx_send_feedback()

Christian Lamparter <chunkeey@googlemail.com>
    crypto: crypto4xx - fix crypto4xx_build_pdr, crypto4xx_build_sdr leak

Christian Lamparter <chunkeey@googlemail.com>
    crypto: crypto4xx - remove bad list_del

Jonas Gorski <jonas.gorski@gmail.com>
    bcm63xx_enet: do not write to random DMA channel on BCM6345

Jonas Gorski <jonas.gorski@gmail.com>
    bcm63xx_enet: correct clock usage

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    loop: remember whether sysfs_create_group() was done

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucm: Mark UCM interface as BROKEN

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    PM / hibernate: Fix oops at snapshot_write()

Theodore Ts'o <tytso@mit.edu>
    loop: add recursion validation to LOOP_CHANGE_FD

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: initialise match/target check parameter struct

Linus Torvalds <torvalds@linux-foundation.org>
    Fix up non-directory creation in SGID directories

Dan Carpenter <dan.carpenter@oracle.com>
    xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Nico Sneck <snecknico@gmail.com>
    usb: quirks: add delay quirks for Corsair Strafe

Johan Hovold <johan@kernel.org>
    USB: serial: mos7840: fix status-register error handling

Jann Horn <jannh@google.com>
    USB: yurex: fix out-of-bounds uaccess in read handler

Johan Hovold <johan@kernel.org>
    USB: serial: keyspan_pda: fix modem-status error handling

Jann Horn <jannh@google.com>
    ibmasm: don't write out of bounds in read handler


-------------

Diffstat:

 Makefile                                      |  4 +-
 drivers/block/loop.c                          | 79 +++++++++++++++------------
 drivers/block/loop.h                          |  1 +
 drivers/crypto/amcc/crypto4xx_core.c          | 23 ++++----
 drivers/infiniband/Kconfig                    | 12 ++++
 drivers/infiniband/core/Makefile              |  4 +-
 drivers/misc/ibmasm/ibmasmfs.c                | 27 +--------
 drivers/net/ethernet/broadcom/bcm63xx_enet.c  | 34 +++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  8 +--
 drivers/net/ethernet/sun/sungem.c             | 22 ++++----
 drivers/usb/core/quirks.c                     |  4 ++
 drivers/usb/host/xhci-mem.c                   |  2 +-
 drivers/usb/misc/yurex.c                      | 23 ++------
 drivers/usb/serial/keyspan_pda.c              |  4 +-
 drivers/usb/serial/mos7840.c                  |  3 +
 drivers/vhost/net.c                           |  3 +-
 fs/inode.c                                    |  6 ++
 kernel/power/user.c                           |  5 ++
 net/bridge/netfilter/ebtables.c               | 15 +++++
 net/dccp/ccids/ccid3.c                        | 16 +++---
 net/dns_resolver/dns_key.c                    | 28 ++++++----
 net/ipv4/netfilter/ip_tables.c                |  1 +
 net/ipv4/sysctl_net_ipv4.c                    | 18 ++++--
 net/ipv4/tcp_input.c                          |  9 +++
 net/ipv6/netfilter/ip6_tables.c               |  1 +
 net/nfc/llcp_commands.c                       |  9 ++-
 net/rds/loop.c                                |  1 +
 net/rds/rds.h                                 |  5 ++
 net/rds/recv.c                                |  5 ++
 net/sched/sch_blackhole.c                     |  2 +-
 30 files changed, 228 insertions(+), 146 deletions(-)



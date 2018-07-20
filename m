Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D672AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975F620854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975F620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbeGTNQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:16:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731850AbeGTNP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:15:59 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA361BB6;
        Fri, 20 Jul 2018 12:27:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/31] 4.4.143-stable review
Date:   Fri, 20 Jul 2018 14:13:30 +0200
Message-Id: <20180720121340.158484922@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.143-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.143-rc1
X-KernelTest-Deadline: 2018-07-22T12:13+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.143 release.
There are 31 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jul 22 12:13:28 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.143-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.143-rc1

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.

Santosh Shilimkar <santosh.shilimkar@oracle.com>
    rds: avoid unenecessary cong_update in loop transport

Eric Biggers <ebiggers@google.com>
    KEYS: DNS: fix parsing multiple options

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: reject non-bridge targets

Paul Burton <paul.burton@mips.com>
    MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()

Paul Burton <paul.burton@mips.com>
    MIPS: Call dump_stack() from show_regs()

Ping-Ke Shih <pkshih@realtek.com>
    rtlwifi: rtl8821ae: fix firmware is not ready to run

Gustavo A. R. Silva <gustavo@embeddedor.com>
    net: cxgb3_main: fix potential Spectre v1

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

Jiri Slaby <jslaby@suse.cz>
    r8152: napi hangup fix after disconnect

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Limit msix vectors in kdump kernel to the minimum required count.

Eric Dumazet <edumazet@google.com>
    net: sungem: fix rx checksum support

Alex Vesker <valex@mellanox.com>
    net/mlx5: Fix incorrect raw command length parsing

Eric Dumazet <edumazet@google.com>
    net: dccp: switch rx_tstamp_last_feedback to monotonic clock

Eric Dumazet <edumazet@google.com>
    net: dccp: avoid crash in ccid3_hc_rx_send_feedback()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    atm: zatm: Fix potential Spectre v1

Christian Lamparter <chunkeey@googlemail.com>
    crypto: crypto4xx - fix crypto4xx_build_pdr, crypto4xx_build_sdr leak

Christian Lamparter <chunkeey@googlemail.com>
    crypto: crypto4xx - remove bad list_del

Jonas Gorski <jonas.gorski@gmail.com>
    bcm63xx_enet: do not write to random DMA channel on BCM6345

Jonas Gorski <jonas.gorski@gmail.com>
    bcm63xx_enet: correct clock usage

alex chen <alex.chen@huawei.com>
    ocfs2: subsystem.su_mutex is required while accessing the item->ci_parent

David S. Miller <davem@davemloft.net>
    Revert "sit: reload iphdr in ipip6_rcv"

H. Peter Anvin <hpa@linux.intel.com>
    x86/asm: Add _ASM_ARG* constants for argument registers to <asm/asm.h>

Nick Desaulniers <ndesaulniers@google.com>
    compiler-gcc.h: Add __attribute__((gnu_inline)) to all inline declarations

David Rientjes <rientjes@google.com>
    compiler, clang: always inline when CONFIG_OPTIMIZE_INLINING is disabled

Linus Torvalds <torvalds@linux-foundation.org>
    compiler, clang: properly override 'inline' for clang

David Rientjes <rientjes@google.com>
    compiler, clang: suppress warning for unused static inline functions


-------------

Diffstat:

 Makefile                                        |  4 +-
 arch/mips/kernel/process.c                      | 31 +++++++++++-
 arch/mips/kernel/traps.c                        |  1 +
 arch/x86/include/asm/asm.h                      | 59 +++++++++++++++++++++++
 drivers/atm/zatm.c                              |  2 +
 drivers/crypto/amcc/crypto4xx_core.c            | 23 +++++----
 drivers/net/ethernet/broadcom/bcm63xx_enet.c    | 34 +++++++++----
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c |  2 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c   |  8 ++--
 drivers/net/ethernet/qlogic/qed/qed_main.c      |  9 ++++
 drivers/net/ethernet/sun/sungem.c               | 22 +++++----
 drivers/net/usb/r8152.c                         |  3 +-
 drivers/net/wireless/realtek/rtlwifi/core.c     |  1 -
 drivers/vhost/net.c                             |  3 +-
 fs/ocfs2/cluster/nodemanager.c                  | 63 +++++++++++++++++++++----
 include/linux/compiler-gcc.h                    | 35 ++++++++++----
 net/bridge/netfilter/ebtables.c                 | 13 +++++
 net/dccp/ccids/ccid3.c                          | 16 ++++---
 net/dns_resolver/dns_key.c                      | 28 ++++++-----
 net/ipv4/sysctl_net_ipv4.c                      | 18 +++++--
 net/ipv4/tcp_input.c                            |  9 ++++
 net/ipv6/sit.c                                  |  1 -
 net/nfc/llcp_commands.c                         |  9 ++--
 net/rds/loop.c                                  |  1 +
 net/rds/rds.h                                   |  5 ++
 net/rds/recv.c                                  |  5 ++
 net/sched/sch_blackhole.c                       |  2 +-
 27 files changed, 320 insertions(+), 87 deletions(-)



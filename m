Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E81ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3418B20858
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3418B20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbeGTNSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:18:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbeGTNSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:18:42 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5D5ABBB6;
        Fri, 20 Jul 2018 12:29:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/66] 4.9.114-stable review
Date:   Fri, 20 Jul 2018 14:13:17 +0200
Message-Id: <20180720121407.228772286@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.114-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.114-rc1
X-KernelTest-Deadline: 2018-07-22T12:14+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.114 release.
There are 66 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jul 22 12:13:47 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.114-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.114-rc1

Tejun Heo <tj@kernel.org>
    string: drop __must_check from strscpy() and restore strscpy() usages in cgroup

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Add ARCH_WORKAROUND_2 discovery through ARCH_FEATURES_FUNC_ID

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Handle guest's ARCH_WORKAROUND_2 requests

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Add ARCH_WORKAROUND_2 support for guests

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Add HYP per-cpu accessors

Marc Zyngier <marc.zyngier@arm.com>
    arm64: ssbd: Add prctl interface for per-thread mitigation

Marc Zyngier <marc.zyngier@arm.com>
    arm64: ssbd: Introduce thread flag to control userspace mitigation

Marc Zyngier <marc.zyngier@arm.com>
    arm64: ssbd: Restore mitigation status on CPU resume

Marc Zyngier <marc.zyngier@arm.com>
    arm64: ssbd: Skip apply_ssbd if not using dynamic mitigation

Marc Zyngier <marc.zyngier@arm.com>
    arm64: ssbd: Add global mitigation state accessor

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Add 'ssbd' command-line option

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Add ARCH_WORKAROUND_2 probing

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Add per-cpu infrastructure to call ARCH_WORKAROUND_2

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Call ARCH_WORKAROUND_2 on transitions between EL0 and EL1

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: smccc: Add SMCCC-specific return codes

Christoffer Dall <christoffer.dall@linaro.org>
    KVM: arm64: Avoid storing the vcpu pointer on the stack

Marc Zyngier <marc.zyngier@arm.com>
    KVM: arm/arm64: Do not use kern_hyp_va() with kvm_vgic_global_state

Marc Zyngier <marc.zyngier@arm.com>
    arm64: alternatives: Add dynamic patching feature

James Morse <james.morse@arm.com>
    KVM: arm64: Stop save/restoring host tpidr_el1 on VHE

James Morse <james.morse@arm.com>
    arm64: alternatives: use tpidr_el2 on VHE hosts

James Morse <james.morse@arm.com>
    KVM: arm64: Change hyp_panic()s dependency on tpidr_el2

James Morse <james.morse@arm.com>
    KVM: arm/arm64: Convert kvm_host_cpu_state to a static per-cpu allocation

James Morse <james.morse@arm.com>
    KVM: arm64: Store vcpu on the stack during __guest_enter()

Mark Rutland <mark.rutland@arm.com>
    arm64: assembler: introduce ldr_this_cpu

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.

Santosh Shilimkar <santosh.shilimkar@oracle.com>
    rds: avoid unenecessary cong_update in loop transport

Florian Westphal <fw@strlen.de>
    netfilter: ipv6: nf_defrag: drop skb dst before queueing

Eric Biggers <ebiggers@google.com>
    KEYS: DNS: fix parsing multiple options

Eric Biggers <ebiggers@google.com>
    reiserfs: fix buffer overflow with long warning messages

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: reject non-bridge targets

Stefan Wahren <stefan.wahren@i2se.com>
    net: lan78xx: Fix race in tx pending skb size calculation

Ping-Ke Shih <pkshih@realtek.com>
    rtlwifi: rtl8821ae: fix firmware is not ready to run

Gustavo A. R. Silva <gustavo@embeddedor.com>
    net: cxgb3_main: fix potential Spectre v1

Alex Vesker <valex@mellanox.com>
    net/mlx5: Fix command interface race in polling mode

Eric Dumazet <edumazet@google.com>
    net/packet: fix use-after-free

Jason Wang <jasowang@redhat.com>
    vhost_net: validate sock before trying to put its fd

Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
    tcp: prevent bogus FRTO undos with non-SACK flows

Yuchung Cheng <ycheng@google.com>
    tcp: fix Fast Open key endianness

Jiri Slaby <jslaby@suse.cz>
    r8152: napi hangup fix after disconnect

Aleksander Morgado <aleksander@aleksander.es>
    qmi_wwan: add support for the Dell Wireless 5821e module

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Limit msix vectors in kdump kernel to the minimum required count.

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Fix use of incorrect size in memcpy call.

Eric Dumazet <edumazet@google.com>
    net: sungem: fix rx checksum support

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    net_sched: blackhole: tell upper qdisc about dropped packets

Shay Agroskin <shayag@mellanox.com>
    net/mlx5: Fix wrong size allocation for QoS ETC TC regitster

Alex Vesker <valex@mellanox.com>
    net/mlx5: Fix incorrect raw command length parsing

Eric Dumazet <edumazet@google.com>
    net: dccp: switch rx_tstamp_last_feedback to monotonic clock

Eric Dumazet <edumazet@google.com>
    net: dccp: avoid crash in ccid3_hc_rx_send_feedback()

Xin Long <lucien.xin@gmail.com>
    ipvlan: fix IFLA_MTU ignored on NEWLINK

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

Jonas Gorski <jonas.gorski@gmail.com>
    spi/bcm63xx: fix typo in bcm63xx_spi_max_length breaking compilation

Jonas Gorski <jonas.gorski@gmail.com>
    spi/bcm63xx: make spi subsystem aware of message size limits

Heiner Kallweit <hkallweit1@gmail.com>
    mtd: m25p80: consider max message size in m25p80_read

alex chen <alex.chen@huawei.com>
    ocfs2: ip_alloc_sem should be taken in ocfs2_get_block()

alex chen <alex.chen@huawei.com>
    ocfs2: subsystem.su_mutex is required while accessing the item->ci_parent

Nick Desaulniers <ndesaulniers@google.com>
    x86/paravirt: Make native_save_fl() extern inline

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

Paul Burton <paul.burton@mips.com>
    MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()


-------------

Diffstat:

 Documentation/kernel-parameters.txt             |  17 +++
 Makefile                                        |   4 +-
 arch/arm/include/asm/kvm_host.h                 |  12 ++
 arch/arm/include/asm/kvm_mmu.h                  |  12 ++
 arch/arm/kvm/arm.c                              |  24 ++--
 arch/arm/kvm/psci.c                             |  18 ++-
 arch/arm64/Kconfig                              |   9 ++
 arch/arm64/include/asm/alternative.h            |  43 +++++-
 arch/arm64/include/asm/assembler.h              |  27 +++-
 arch/arm64/include/asm/cpucaps.h                |   3 +-
 arch/arm64/include/asm/cpufeature.h             |  22 +++
 arch/arm64/include/asm/kvm_asm.h                |  41 ++++++
 arch/arm64/include/asm/kvm_host.h               |  43 ++++++
 arch/arm64/include/asm/kvm_mmu.h                |  44 ++++++
 arch/arm64/include/asm/percpu.h                 |  12 +-
 arch/arm64/include/asm/thread_info.h            |   1 +
 arch/arm64/kernel/Makefile                      |   1 +
 arch/arm64/kernel/alternative.c                 |  54 ++++---
 arch/arm64/kernel/asm-offsets.c                 |   2 +
 arch/arm64/kernel/cpu_errata.c                  | 180 ++++++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c                  |  17 +++
 arch/arm64/kernel/entry.S                       |  32 ++++-
 arch/arm64/kernel/hibernate.c                   |  11 ++
 arch/arm64/kernel/ssbd.c                        | 108 ++++++++++++++
 arch/arm64/kernel/suspend.c                     |   8 ++
 arch/arm64/kvm/hyp-init.S                       |   4 +
 arch/arm64/kvm/hyp/entry.S                      |  12 +-
 arch/arm64/kvm/hyp/hyp-entry.S                  |  62 ++++++--
 arch/arm64/kvm/hyp/switch.c                     |  64 +++++++--
 arch/arm64/kvm/hyp/sysreg-sr.c                  |  21 +--
 arch/arm64/kvm/reset.c                          |   4 +
 arch/mips/kernel/process.c                      |  45 ++++--
 arch/x86/include/asm/asm.h                      |  59 ++++++++
 arch/x86/include/asm/irqflags.h                 |   2 +-
 arch/x86/kernel/Makefile                        |   1 +
 arch/x86/kernel/irqflags.S                      |  26 ++++
 drivers/atm/zatm.c                              |   2 +
 drivers/crypto/amcc/crypto4xx_core.c            |  23 ++-
 drivers/mtd/devices/m25p80.c                    |   3 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c    |  34 +++--
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c   |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c  |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c      |   8 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c      |   9 ++
 drivers/net/ethernet/sun/sungem.c               |  22 +--
 drivers/net/ipvlan/ipvlan_main.c                |   3 +-
 drivers/net/usb/lan78xx.c                       |   5 +-
 drivers/net/usb/qmi_wwan.c                      |   1 +
 drivers/net/usb/r8152.c                         |   3 +-
 drivers/net/wireless/realtek/rtlwifi/core.c     |   1 -
 drivers/spi/spi-bcm63xx.c                       |   9 ++
 drivers/vhost/net.c                             |   3 +-
 fs/ocfs2/aops.c                                 |  26 ++--
 fs/ocfs2/cluster/nodemanager.c                  |  63 +++++++--
 fs/reiserfs/prints.c                            | 141 +++++++++++--------
 include/linux/arm-smccc.h                       |  10 ++
 include/linux/compiler-gcc.h                    |  35 +++--
 include/linux/string.h                          |   2 +-
 net/bridge/netfilter/ebtables.c                 |  13 ++
 net/dccp/ccids/ccid3.c                          |  16 ++-
 net/dns_resolver/dns_key.c                      |  28 ++--
 net/ipv4/sysctl_net_ipv4.c                      |  18 ++-
 net/ipv4/tcp_input.c                            |   9 ++
 net/ipv6/netfilter/nf_conntrack_reasm.c         |   2 +
 net/nfc/llcp_commands.c                         |   9 +-
 net/packet/af_packet.c                          |  14 +-
 net/rds/loop.c                                  |   1 +
 net/rds/rds.h                                   |   5 +
 net/rds/recv.c                                  |   5 +
 net/sched/sch_blackhole.c                       |   2 +-
 virt/kvm/arm/hyp/vgic-v2-sr.c                   |   2 +-
 72 files changed, 1315 insertions(+), 271 deletions(-)



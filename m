Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B01C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E73921582
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnNjxc31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E73921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbeKVFqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388840AbeKVFqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:46:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697E2206BB;
        Wed, 21 Nov 2018 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827449;
        bh=xot9d5D/JVwQjvSVMB73W5W70MCUxY4dQrS+GLKhCj8=;
        h=From:To:Cc:Subject:Date:From;
        b=UnNjxc31lpkflLw0mmMV+QLWjiAR+icgXxLvpoc+nEZZyH3hFgNLCLzsF6kMxjNjU
         21hfN8jCZsqElnCfuDv1oIt8sRyLA44hHdHdvJJkgIPp+hR99JKQJ6ABVvWFw3o2+U
         vrBSTpSAZJHHIJm7GX+qR7FdFPYGWJgyQ+Cf4Lco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/59] 4.9.139-stable review
Date:   Wed, 21 Nov 2018 20:06:15 +0100
Message-Id: <20181121183508.262873520@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.139-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.139-rc1
X-KernelTest-Deadline: 2018-11-23T18:35+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.139 release.
There are 59 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Nov 23 18:34:55 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.139-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.139-rc1

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v1: mitigate user accesses

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v1: use get_user() for __get_user()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: use __inttype() in get_user()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: oabi-compat: copy semops using __copy_from_user()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: vfp: use __copy_from_user() when restoring VFP state

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: signal: copy registers using __copy_from_user()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v1: fix syscall entry

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v1: add array_index_mask_nospec() implementation

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v1: add speculation barrier (csdb) macros

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: KVM: report support for SMCCC_ARCH_WORKAROUND_1

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: KVM: invalidate icache on guest exit for Brahma B15

Marc Zyngier <marc.zyngier@arm.com>
    ARM: KVM: invalidate icache on guest exit for Cortex-A15

Marc Zyngier <marc.zyngier@arm.com>
    ARM: KVM: invalidate BTB on guest exit for Cortex-A12/A17

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: warn about incorrect context switching functions

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: add firmware based hardening

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: harden user aborts in kernel space

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: add Cortex A8 and A15 validation of the IBE bit

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: harden branch predictor on context switches

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre: add Kconfig symbol for CPUs vulnerable to Spectre

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: bugs: add support for per-processor bug checking

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: bugs: hook processor bug checking into SMP and suspend paths

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: bugs: prepare processor bug infrastructure

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: add more CPU part numbers for Cortex and Brahma B15 CPUs

Mark Rutland <mark.rutland@arm.com>
    arm64: uaccess: suppress spurious clang warning

Arnd Bergmann <arnd@arndb.de>
    Kbuild: use -fshort-wchar globally

Matthias Kaehlcke <mka@chromium.org>
    x86/build: Use cc-option to validate stack alignment parameter

Matthias Kaehlcke <mka@chromium.org>
    x86/build: Fix stack alignment for CLang

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/libstub/arm64: Set -fpie when building the EFI stub

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/libstub: Preserve .debug sections after absolute relocation check

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/libstub/arm64: Force 'hidden' visibility for section markers

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/libstub/arm64: Use hidden attribute for struct screen_info reference

Michael Davidson <md@google.com>
    x86/boot: #undef memcpy() et al in string.c

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: arm64/sha - avoid non-standard inline asm tricks

Matthias Kaehlcke <mka@chromium.org>
    kbuild: clang: Disable 'address-of-packed-member' warning

Matthias Kaehlcke <mka@chromium.org>
    x86/build: Specify stack alignment for clang

Matthias Kaehlcke <mka@chromium.org>
    x86/build: Use __cc-option for boot code compiler options

Matthias Kaehlcke <mka@chromium.org>
    kbuild: Add __cc-option macro

Michael Davidson <md@google.com>
    crypto, x86: aesni - fix token pasting for clang

Matthias Kaehlcke <mka@chromium.org>
    x86/kbuild: Use cc-option to enable -falign-{jumps/loops}

Arnd Bergmann <arnd@arndb.de>
    modules: mark __inittest/__exittest as __maybe_unused

Vinícius Tinti <viniciustinti@gmail.com>
    kbuild: Add support to generate LLVM assembly files

Behan Webster <behanw@converseincode.com>
    kbuild: use -Oz instead of -Os when using clang

Mark Charlebois <charlebm@gmail.com>
    kbuild, LLVMLinux: Add -Werror to cc-option to support clang

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: drop -Wno-unknown-warning-option from clang options

Jeroen Hofstee <jeroen@myspectrum.nl>
    kbuild: fix asm-offset generation to work with clang

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: consolidate redundant sed script ASM offset generation

Matthias Kaehlcke <mka@chromium.org>
    kbuild: Consolidate header generation from ASM offset information

Michael Davidson <md@google.com>
    kbuild: clang: add -no-integrated-as to KBUILD_[AC]FLAGS

Behan Webster <behanw@converseincode.com>
    kbuild: Add better clang cross build support

David Ahern <dsahern@gmail.com>
    ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF

Eric Dumazet <edumazet@google.com>
    inet: frags: better deal with smp races

Frieder Schrempf <frieder.schrempf@kontron.de>
    usbnet: smsc95xx: disable carrier check while suspending

Siva Reddy Kallam <siva.kallam@broadcom.com>
    tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control paths

Xin Long <lucien.xin@gmail.com>
    sctp: not allow to set asoc prsctp_enable by sockopt

Eric Dumazet <edumazet@google.com>
    net-gro: reset skb->pkt_type in napi_reuse_skb()

Sabrina Dubroca <sd@queasysnail.net>
    ip_tunnel: don't force DF when MTU is locked

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    ibmvnic: fix accelerated VLAN handling

배석진 <soukjin.bae@samsung.com>
    flow_dissector: do not dissect l4 ports for fragments


-------------

Diffstat:

 .gitignore                                |   1 +
 Kbuild                                    |  25 -----
 Makefile                                  |  29 +++--
 arch/arm/include/asm/assembler.h          |  12 +++
 arch/arm/include/asm/barrier.h            |  32 ++++++
 arch/arm/include/asm/bugs.h               |   6 +-
 arch/arm/include/asm/cp15.h               |   3 +
 arch/arm/include/asm/cputype.h            |   8 ++
 arch/arm/include/asm/kvm_asm.h            |   2 -
 arch/arm/include/asm/kvm_host.h           |  14 ++-
 arch/arm/include/asm/kvm_mmu.h            |  23 +++-
 arch/arm/include/asm/proc-fns.h           |   4 +
 arch/arm/include/asm/system_misc.h        |  15 +++
 arch/arm/include/asm/thread_info.h        |   4 +-
 arch/arm/include/asm/uaccess.h            |  26 +++--
 arch/arm/kernel/Makefile                  |   1 +
 arch/arm/kernel/bugs.c                    |  18 ++++
 arch/arm/kernel/entry-common.S            |  18 ++--
 arch/arm/kernel/entry-header.S            |  25 +++++
 arch/arm/kernel/signal.c                  |  55 +++++-----
 arch/arm/kernel/smp.c                     |   4 +
 arch/arm/kernel/suspend.c                 |   2 +
 arch/arm/kernel/sys_oabi-compat.c         |   8 +-
 arch/arm/kvm/hyp/hyp-entry.S              | 112 ++++++++++++++++++-
 arch/arm/lib/copy_from_user.S             |   9 ++
 arch/arm/mm/Kconfig                       |  23 ++++
 arch/arm/mm/Makefile                      |   2 +-
 arch/arm/mm/fault.c                       |   3 +
 arch/arm/mm/proc-macros.S                 |   3 +-
 arch/arm/mm/proc-v7-2level.S              |   6 --
 arch/arm/mm/proc-v7-bugs.c                | 174 ++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7.S                     | 154 ++++++++++++++++++++------
 arch/arm/vfp/vfpmodule.c                  |  17 ++-
 arch/arm64/crypto/sha1-ce-core.S          |   6 +-
 arch/arm64/crypto/sha1-ce-glue.c          |  11 +-
 arch/arm64/crypto/sha2-ce-core.S          |   6 +-
 arch/arm64/crypto/sha2-ce-glue.c          |  13 +--
 arch/arm64/include/asm/efi.h              |   3 +
 arch/arm64/include/asm/uaccess.h          |   4 +-
 arch/ia64/kernel/Makefile                 |  26 +----
 arch/x86/Makefile                         |  39 +++++--
 arch/x86/boot/string.c                    |   9 ++
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S   |   7 +-
 drivers/firmware/efi/libstub/Makefile     |  26 +++--
 drivers/firmware/efi/libstub/arm64-stub.c |  10 +-
 drivers/net/ethernet/broadcom/tg3.c       |  18 +++-
 drivers/net/ethernet/ibm/ibmvnic.c        |   2 +-
 drivers/net/usb/smsc95xx.c                |   7 ++
 drivers/xen/Makefile                      |   3 -
 include/linux/kbuild.h                    |   6 +-
 include/linux/module.h                    |   4 +-
 net/core/dev.c                            |   4 +
 net/core/flow_dissector.c                 |   4 +-
 net/ipv4/inet_fragment.c                  |  28 ++---
 net/ipv4/ip_tunnel_core.c                 |   2 +-
 net/ipv6/route.c                          |   7 +-
 net/sctp/socket.c                         |  26 +----
 scripts/Kbuild.include                    |  18 +++-
 scripts/Makefile.build                    |   8 ++
 scripts/Makefile.extrawarn                |   1 -
 scripts/Makefile.host                     |   6 --
 scripts/Makefile.lib                      |  31 ++++++
 scripts/mod/Makefile                      |  28 +----
 63 files changed, 903 insertions(+), 298 deletions(-)



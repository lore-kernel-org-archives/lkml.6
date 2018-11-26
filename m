Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED635C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1F121104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDyzTsDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1F121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKZVrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeKZVrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F3972089F;
        Mon, 26 Nov 2018 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229632;
        bh=3B4Z36jJVoniM0rN4NACa8ojNBjD8k0xcKHGcYpRB+s=;
        h=From:To:Cc:Subject:Date:From;
        b=iDyzTsDwblHlIGar8YZdXZDjywXFvZONgcyIG/nzudHkMiJJLJMEDYboxtfgaPGzj
         WYqAGudx3NOOAY5lMavxbnBhe9eQeJyPXMKr4zmCNJhuRrPELBA4klgOA14024Wsnt
         dna9VjwmAT7P2xB9Hdm/F5RXEcMax2BgeI4ODZDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/70] 4.4.165-stable review
Date:   Mon, 26 Nov 2018 11:50:15 +0100
Message-Id: <20181126105046.722096341@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.165-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.165-rc1
X-KernelTest-Deadline: 2018-11-28T10:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.165 release.
There are 70 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Nov 28 10:50:16 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.165-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.165-rc1

Eric Biggers <ebiggers@google.com>
    HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges

Al Viro <viro@zeniv.linux.org.uk>
    new helper: uaccess_kernel()

Hans de Goede <hdegoede@redhat.com>
    ACPI / platform: Add SMB0001 HID to forbidden_id_list

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drivers/misc/sgi-gru: fix Spectre v1 vulnerability

Mattias Jacobsson <2pi@mok.nu>
    USB: misc: appledisplay: add 20" Apple Cinema Display

Nathan Chancellor <natechancellor@gmail.com>
    misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data

Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
    usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB

Kai-Heng Feng <kai.heng.feng@canonical.com>
    USB: quirks: Add no-lpm quirk for Raydium touchscreens

Maarten Jacobs <maarten256@outlook.com>
    usb: cdc-acm: add entry for Hiro (Conexant) modem

Dan Carpenter <dan.carpenter@oracle.com>
    uio: Fix an Oops on load

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: v4l: event: Add subscription to list before calling "add" operation

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV"

Hans Verkuil <hverkuil@xs4all.nl>
    Revert "media: videobuf2-core: don't call memop 'finish' when queueing"

Lu Fengqi <lufq.fnst@cn.fujitsu.com>
    btrfs: fix pinned underflow after transaction aborted

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Put bitmap buffers in put_super

YueHaibing <yuehaibing@huawei.com>
    SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer()

Minchan Kim <minchan@kernel.org>
    zram: close udev startup race condition as default groups

Vignesh R <vigneshr@ti.com>
    i2c: omap: Enable for ARCH_K3

Jeremy Linton <jeremy.linton@arm.com>
    lib/raid6: Fix arm64 test build

Geert Uytterhoeven <geert@linux-m68k.org>
    hwmon: (ibmpowernv) Remove bogus __init annotations

Taehee Yoo <ap420073@gmail.com>
    netfilter: xt_IDLETIMER: add sysfs filename checking routine

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
    netfilter: ipset: Correct rcu_dereference() call in ip_set_put_comment()

Justin M. Forbes <jforbes@fedoraproject.org>
    s390/mm: Fix ERROR: "__node_distance" undefined!

Eric Westbrook <eric@westbrook.io>
    netfilter: ipset: actually allow allowable CIDR 0 in hash:net,port,net

Vasily Gorbik <gor@linux.ibm.com>
    s390/vdso: add missing FORCE to build targets

Nathan Chancellor <natechancellor@gmail.com>
    arm64: percpu: Initialize ret in the default case

Paul Gortmaker <paul.gortmaker@windriver.com>
    platform/x86: acerhdf: Add BIOS entry for Gateway LT31 v1.3307

Marek Szyprowski <m.szyprowski@samsung.com>
    clk: samsung: exynos5420: Enable PERIS clocks for suspend

Chengguang Xu <cgxu519@gmx.com>
    fs/exofs: fix potential memory leak in mount option parsing

Richard Weinberger <richard@nod.at>
    um: Give start_idle_thread() a return code

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfsplus: prevent btree data loss on root split

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfs: prevent btree data loss on root split

Jann Horn <jannh@google.com>
    reiserfs: propagate errors from fill_with_dentries() properly

Matthias Kaehlcke <mka@chromium.org>
    x86/build: Use cc-option to validate stack alignment parameter

Matthias Kaehlcke <mka@chromium.org>
    x86/build: Fix stack alignment for CLang

Michael Davidson <md@google.com>
    x86/boot: #undef memcpy() et al in string.c

Matthias Kaehlcke <mka@chromium.org>
    x86/build: Specify stack alignment for clang

Matthias Kaehlcke <mka@chromium.org>
    x86/build: Use __cc-option for boot code compiler options

Matthias Kaehlcke <mka@chromium.org>
    kbuild: Add __cc-option macro

Matthias Kaehlcke <mka@chromium.org>
    x86/mm/kaslr: Use the _ASM_MUL macro for multiplication to work around Clang incompatibility

Michael Davidson <md@google.com>
    crypto, x86: aesni - fix token pasting for clang

Matthias Kaehlcke <mka@chromium.org>
    x86/kbuild: Use cc-option to enable -falign-{jumps/loops}

Matthias Kaehlcke <mka@chromium.org>
    arm64: Disable asm-operand-width warning for clang

Stefan Agner <stefan@agner.ch>
    kbuild: allow to use GCC toolchain not in Clang search path

Stefan Agner <stefan@agner.ch>
    kbuild: set no-integrated-as before incl. arch Makefile

Sodagudi Prasad <psodagud@codeaurora.org>
    kbuild: clang: disable unused variable warnings only when constant

Nick Desaulniers <nick.desaulniers@gmail.com>
    kbuild: clang: remove crufty HOSTCFLAGS

David Lin <dtwlin@google.com>
    kbuild: clang: fix build failures with sparse check

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: move cc-option and cc-disable-warning after incl. arch Makefile

Chris Fries <cfries@google.com>
    kbuild: Set KBUILD_CFLAGS before incl. arch Makefile

Nick Desaulniers <ndesaulniers@google.com>
    kbuild: fix linker feature test macros when cross compiling with Clang

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/libstub/arm64: Set -fpie when building the EFI stub

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/libstub/arm64: Force 'hidden' visibility for section markers

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: arm64/sha - avoid non-standard inline asm tricks

Matthias Kaehlcke <mka@chromium.org>
    kbuild: clang: Disable 'address-of-packed-member' warning

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

Siva Reddy Kallam <siva.kallam@broadcom.com>
    tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control paths

Eric Dumazet <edumazet@google.com>
    net-gro: reset skb->pkt_type in napi_reuse_skb()

Sabrina Dubroca <sd@queasysnail.net>
    ip_tunnel: don't force DF when MTU is locked

배석진 <soukjin.bae@samsung.com>
    flow_dissector: do not dissect l4 ports for fragments


-------------

Diffstat:

 .gitignore                                     |  1 +
 Kbuild                                         | 25 ---------------
 Makefile                                       | 41 ++++++++++++++++--------
 arch/arm64/Makefile                            |  4 +++
 arch/arm64/crypto/sha1-ce-core.S               |  6 ++--
 arch/arm64/crypto/sha1-ce-glue.c               | 11 ++-----
 arch/arm64/crypto/sha2-ce-core.S               |  6 ++--
 arch/arm64/crypto/sha2-ce-glue.c               | 13 +++-----
 arch/arm64/include/asm/percpu.h                |  3 ++
 arch/ia64/kernel/Makefile                      | 26 ++--------------
 arch/s390/kernel/vdso32/Makefile               |  6 ++--
 arch/s390/kernel/vdso64/Makefile               |  6 ++--
 arch/s390/numa/numa.c                          |  1 +
 arch/um/os-Linux/skas/process.c                |  5 +++
 arch/x86/Makefile                              | 39 +++++++++++++++++------
 arch/x86/boot/compressed/aslr.c                |  3 +-
 arch/x86/boot/string.c                         |  9 ++++++
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S        |  7 ++---
 arch/x86/include/asm/asm.h                     |  1 +
 drivers/acpi/acpi_platform.c                   |  1 +
 drivers/block/zram/zram_drv.c                  | 26 ++++------------
 drivers/bluetooth/Kconfig                      |  1 -
 drivers/clk/samsung/clk-exynos5420.c           |  1 +
 drivers/firmware/efi/libstub/Makefile          |  2 +-
 drivers/firmware/efi/libstub/arm64-stub.c      | 10 +++++-
 drivers/hid/uhid.c                             | 13 ++++++++
 drivers/hwmon/ibmpowernv.c                     |  7 ++---
 drivers/i2c/busses/Kconfig                     |  2 +-
 drivers/media/v4l2-core/v4l2-event.c           | 43 ++++++++++++++------------
 drivers/media/v4l2-core/videobuf2-core.c       |  9 ++----
 drivers/misc/atmel-ssc.c                       |  2 +-
 drivers/misc/sgi-gru/grukdump.c                |  4 +++
 drivers/net/ethernet/broadcom/tg3.c            | 18 +++++++++--
 drivers/platform/x86/acerhdf.c                 |  1 +
 drivers/uio/uio.c                              |  7 +++--
 drivers/usb/class/cdc-acm.c                    |  3 ++
 drivers/usb/core/quirks.c                      |  8 +++++
 drivers/usb/misc/appledisplay.c                |  1 +
 fs/btrfs/disk-io.c                             | 19 +++++++++---
 fs/exofs/super.c                               |  5 ++-
 fs/gfs2/rgrp.c                                 |  3 +-
 fs/hfs/brec.c                                  |  4 +++
 fs/hfsplus/brec.c                              |  4 +++
 fs/reiserfs/xattr.c                            |  7 +++++
 include/linux/kbuild.h                         |  6 ++--
 include/linux/module.h                         |  4 +--
 include/linux/netfilter/ipset/ip_set_comment.h |  4 +--
 include/linux/uaccess.h                        |  3 ++
 lib/raid6/test/Makefile                        |  4 +--
 net/core/dev.c                                 |  4 +++
 net/core/flow_dissector.c                      |  4 +--
 net/ipv4/ip_tunnel_core.c                      |  2 +-
 net/ipv6/route.c                               |  8 +++--
 net/netfilter/ipset/ip_set_hash_netportnet.c   |  8 ++---
 net/netfilter/xt_IDLETIMER.c                   | 20 ++++++++++++
 net/sunrpc/xdr.c                               |  2 +-
 scripts/Kbuild.include                         | 18 +++++++----
 scripts/Makefile.build                         |  8 +++++
 scripts/Makefile.extrawarn                     |  1 -
 scripts/Makefile.lib                           | 31 +++++++++++++++++++
 scripts/mod/Makefile                           | 28 ++---------------
 61 files changed, 349 insertions(+), 220 deletions(-)



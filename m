Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA72C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2782147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2782147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeHPVnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:43:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeHPVnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:43:05 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7D2E6CB7;
        Thu, 16 Aug 2018 18:42:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/13] 4.4.149-stable review
Date:   Thu, 16 Aug 2018 20:41:47 +0200
Message-Id: <20180816171628.554317013@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.149-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.149-rc1
X-KernelTest-Deadline: 2018-08-18T17:16+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.149 release.
There are 13 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Aug 18 17:16:16 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.149-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.149-rc1

Toshi Kani <toshi.kani@hpe.com>
    x86/mm: Add TLB purge to free pmd/pte page interfaces

Chintan Pandya <cpandya@codeaurora.org>
    ioremap: Update pgtable free interfaces with addr

Mark Salyzyn <salyzyn@android.com>
    Bluetooth: hidp: buffer overflow in hidp_process_report

Thierry Escande <thierry.escande@collabora.com>
    ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization

Eric Biggers <ebiggers@google.com>
    crypto: ablkcipher - fix crash flushing dcache in error path

Eric Biggers <ebiggers@google.com>
    crypto: blkcipher - fix crash flushing dcache in error path

Eric Biggers <ebiggers@google.com>
    crypto: vmac - separate tfm and request context

Eric Biggers <ebiggers@google.com>
    crypto: vmac - require a block cipher with 128-bit block size

Randy Dunlap <rdunlap@infradead.org>
    kbuild: verify that $DEPMOD is installed

Liwei Song <liwei.song@windriver.com>
    i2c: ismt: fix wrong device address when unmap the data buffer

Andrey Konovalov <andreyknvl@google.com>
    kasan: don't emit builtin calls when sanitization is off

Takashi Iwai <tiwai@suse.de>
    tcp: Fix missing range_truesize enlargement in the backport

Toshi Kani <toshi.kani@hpe.com>
    x86/mm: Disable ioremap free page handling on x86-PAE


-------------

Diffstat:

 Documentation/Changes                        |  17 +-
 Makefile                                     |   7 +-
 arch/arm64/mm/mmu.c                          |   4 +-
 arch/x86/mm/pgtable.c                        |  61 +++-
 crypto/ablkcipher.c                          |  57 ++--
 crypto/blkcipher.c                           |  54 ++--
 crypto/vmac.c                                | 412 ++++++++++++---------------
 drivers/i2c/busses/i2c-ismt.c                |   2 +-
 include/asm-generic/pgtable.h                |   8 +-
 include/crypto/vmac.h                        |  63 ----
 lib/ioremap.c                                |   4 +-
 net/bluetooth/hidp/core.c                    |   4 +-
 net/ipv4/tcp_input.c                         |   1 +
 scripts/Makefile.kasan                       |   3 +
 scripts/Makefile.lib                         |   2 +-
 scripts/depmod.sh                            |   8 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |  45 ++-
 17 files changed, 354 insertions(+), 398 deletions(-)



Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6AFC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22A521479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22A521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbeHPVpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:45:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56624 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbeHPVpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:45:04 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EADF6CC4;
        Thu, 16 Aug 2018 18:44:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/15] 4.9.121-stable review
Date:   Thu, 16 Aug 2018 20:41:53 +0200
Message-Id: <20180816171625.340082081@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.121-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.121-rc1
X-KernelTest-Deadline: 2018-08-18T17:16+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.121 release.
There are 15 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Aug 18 17:16:11 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.121-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.121-rc1

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

Eric Biggers <ebiggers@google.com>
    crypto: x86/sha256-mb - fix digest copy in sha256_mb_mgr_get_comp_job_avx2()

Randy Dunlap <rdunlap@infradead.org>
    kbuild: verify that $DEPMOD is installed

Liwei Song <liwei.song@windriver.com>
    i2c: ismt: fix wrong device address when unmap the data buffer

Andrey Konovalov <andreyknvl@google.com>
    kasan: don't emit builtin calls when sanitization is off

Toshi Kani <toshi.kani@hpe.com>
    x86/mm: Disable ioremap free page handling on x86-PAE

Guenter Roeck <linux@roeck-us.net>
    x86: i8259: Add missing include file

Guenter Roeck <linux@roeck-us.net>
    x86/l1tf: Fix build error seen if CONFIG_KVM_INTEL is disabled


-------------

Diffstat:

 Documentation/Changes                              |  19 +-
 Makefile                                           |   7 +-
 arch/arm64/mm/mmu.c                                |   4 +-
 .../crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S    |   2 +-
 arch/x86/include/asm/i8259.h                       |   1 +
 arch/x86/kernel/cpu/bugs.c                         |   3 +-
 arch/x86/mm/pgtable.c                              |  61 ++-
 crypto/ablkcipher.c                                |  57 ++-
 crypto/blkcipher.c                                 |  54 ++-
 crypto/vmac.c                                      | 412 +++++++++------------
 drivers/i2c/busses/i2c-ismt.c                      |   2 +-
 include/asm-generic/pgtable.h                      |   8 +-
 include/crypto/vmac.h                              |  63 ----
 lib/ioremap.c                                      |   4 +-
 net/bluetooth/hidp/core.c                          |   4 +-
 scripts/Makefile.kasan                             |   3 +
 scripts/Makefile.lib                               |   2 +-
 scripts/depmod.sh                                  |   8 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |  45 ++-
 19 files changed, 357 insertions(+), 402 deletions(-)



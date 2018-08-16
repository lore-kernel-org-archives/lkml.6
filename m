Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4B421473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4B421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeHPVmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:42:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeHPVmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:42:05 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B827DCC4;
        Thu, 16 Aug 2018 18:41:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/15] 3.18.119-stable review
Date:   Thu, 16 Aug 2018 20:41:37 +0200
Message-Id: <20180816171633.546734046@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.119-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.119-rc1
X-KernelTest-Deadline: 2018-08-18T17:16+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.119 release.
There are 15 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Aug 18 17:16:20 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.119-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.119-rc1

Mark Salyzyn <salyzyn@android.com>
    Bluetooth: hidp: buffer overflow in hidp_process_report

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

Andrey Ryabinin <a.ryabinin@samsung.com>
    mm: slub: fix format mismatches in slab_err() callers

Erick Reyes <erickreyes@google.com>
    ALSA: info: Check for integer overflow in snd_info_entry_write()

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Fix %p uses in error messages

Oleksij Rempel <o.rempel@pengutronix.de>
    ARM: dts: imx6sx: fix irq for pcie bridge

Al Viro <viro@zeniv.linux.org.uk>
    fix __legitimize_mnt()/mntput() race

Al Viro <viro@zeniv.linux.org.uk>
    fix mntput/mntput race

Al Viro <viro@zeniv.linux.org.uk>
    root dentries need RCU-delayed freeing

Juergen Gross <jgross@suse.com>
    xen/netfront: don't cache skb_shinfo()


-------------

Diffstat:

 Documentation/Changes          |  17 +-
 Makefile                       |   4 +-
 arch/arm/boot/dts/imx6sx.dtsi  |   2 +-
 arch/x86/kernel/kprobes/core.c |   4 +-
 crypto/ablkcipher.c            |  57 +++---
 crypto/blkcipher.c             |  54 +++---
 crypto/vmac.c                  | 412 ++++++++++++++++++-----------------------
 drivers/i2c/busses/i2c-ismt.c  |   2 +-
 drivers/net/xen-netfront.c     |   8 +-
 fs/dcache.c                    |   6 +-
 fs/namespace.c                 |  28 ++-
 include/crypto/vmac.h          |  63 -------
 mm/slub.c                      |   6 +-
 net/bluetooth/hidp/core.c      |   4 +-
 scripts/depmod.sh              |   8 +-
 sound/core/info.c              |   4 +-
 16 files changed, 297 insertions(+), 382 deletions(-)



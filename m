Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E5A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E5A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbeIHC21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:28:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58184 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbeIHC20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:26 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 066421027;
        Fri,  7 Sep 2018 21:45:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/29] 3.18.122-stable review
Date:   Fri,  7 Sep 2018 23:10:21 +0200
Message-Id: <20180907210909.523240901@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.122-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.122-rc1
X-KernelTest-Deadline: 2018-09-09T21:09+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.122 release.
There are 29 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Sep  9 21:08:52 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.122-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.122-rc1

Shan Hai <shan.hai@oracle.com>
    bcache: release dc->writeback_lock properly in bch_writeback_thread()

Christian Brauner <christian@brauner.io>
    getxattr: use correct xattr length

Mikulas Patocka <mpatocka@redhat.com>
    udlfb: set optimal write delay

Mikulas Patocka <mpatocka@redhat.com>
    fb: fix lost console when the user unplugs a USB adapter

Vignesh R <vigneshr@ti.com>
    pwm: tiehrpwm: Fix disabling of output of PWMs

Richard Weinberger <richard@nod.at>
    ubifs: Fix synced_i_size calculation for xattr inodes

Richard Weinberger <richard@nod.at>
    Revert "UBIFS: Fix potential integer overflow in allocation"

Richard Weinberger <richard@nod.at>
    ubifs: Fix memory leak in lprobs self-check

Jann Horn <jannh@google.com>
    userns: move user access out of the mutex

Eric W. Biederman <ebiederm@xmission.com>
    userns; Correct the comment in map_write

Jann Horn <jannh@google.com>
    sys: don't hold uts_sem while accessing userspace memory

Al Viro <viro@zeniv.linux.org.uk>
    osf_getdomainname(): use copy_to_user()

Peter Zijlstra <peterz@infradead.org>
    mm/tlb: Remove tlb_remove_table() non-concurrent condition

Jon Hunter <jonathanh@nvidia.com>
    ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Dan Carpenter <dan.carpenter@oracle.com>
    pnfs/blocklayout: off by one in bl_map_stripe()

Tomas Bortoli <tomasbortoli@gmail.com>
    9p: fix multiple NULL-pointer-dereferences

Steven Rostedt (VMware) <rostedt@goodmis.org>
    uprobes: Use synchronize_rcu() not synchronize_sched()

Snild Dolkow <snild@sony.com>
    kthread, tracing: Don't expose half-written comm when creating kthreads

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing/blktrace: Fix to allow setting same value

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Do not call start/stop() functions when tracing_on does not change

Lars-Peter Clausen <lars@metafoo.de>
    iio: ad9523: Fix return value for ad952x_store()

Lars-Peter Clausen <lars@metafoo.de>
    iio: ad9523: Fix displayed phase

Mike Snitzer <snitzer@redhat.com>
    dm cache metadata: save in-core policy_hint_size to on-disk superblock

Tomas Bortoli <tomasbortoli@gmail.com>
    net/9p/trans_fd.c: fix race-condition by flushing workqueue before the kfree()

Tomas Bortoli <tomasbortoli@gmail.com>
    net/9p/client.c: version pointer uninitialized

jiangyiwen <jiangyiwen@huawei.com>
    9p/virtio: fix off-by-one error in sg list bounds check

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.

Hari Bathini <hbathini@linux.ibm.com>
    powerpc/fadump: handle crash memory ranges array index overflow

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    spi: davinci: fix a NULL pointer dereference


-------------

Diffstat:

 Makefile                              |  4 +-
 arch/alpha/kernel/osf_sys.c           | 64 +++++++++++------------
 arch/arm/boot/dts/tegra30-cardhu.dtsi |  1 +
 arch/powerpc/include/asm/fadump.h     |  3 --
 arch/powerpc/kernel/fadump.c          | 91 +++++++++++++++++++++++++++------
 arch/powerpc/platforms/pseries/ras.c  |  2 +-
 arch/sparc/kernel/sys_sparc_32.c      | 22 ++++----
 arch/sparc/kernel/sys_sparc_64.c      | 20 +++++---
 drivers/iio/frequency/ad9523.c        |  4 +-
 drivers/md/bcache/writeback.c         |  4 +-
 drivers/md/dm-cache-metadata.c        |  3 +-
 drivers/pwm/pwm-tiehrpwm.c            |  2 +
 drivers/spi/spi-davinci.c             |  2 +-
 drivers/video/fbdev/core/fbmem.c      | 38 +++++++++++---
 fs/nfs/blocklayout/dev.c              |  2 +-
 fs/ubifs/journal.c                    |  7 ++-
 fs/ubifs/lprops.c                     |  8 +--
 fs/xattr.c                            |  2 +-
 include/video/udlfb.h                 |  2 +-
 kernel/kthread.c                      |  8 ++-
 kernel/sys.c                          | 95 +++++++++++++++++------------------
 kernel/trace/blktrace.c               |  4 ++
 kernel/trace/trace.c                  |  4 +-
 kernel/trace/trace_uprobe.c           |  2 +-
 kernel/user_namespace.c               | 22 ++++----
 kernel/utsname_sysctl.c               | 41 +++++++++------
 mm/memory.c                           |  9 ----
 net/9p/client.c                       |  2 +-
 net/9p/trans_fd.c                     |  7 ++-
 net/9p/trans_rdma.c                   |  3 ++
 net/9p/trans_virtio.c                 |  6 ++-
 31 files changed, 299 insertions(+), 185 deletions(-)



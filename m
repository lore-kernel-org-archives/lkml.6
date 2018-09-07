Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757FDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B9D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B9D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeIHCYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbeIHCYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:41 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49592FEF;
        Fri,  7 Sep 2018 21:41:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/47] 4.4.155-stable review
Date:   Fri,  7 Sep 2018 23:09:56 +0200
Message-Id: <20180907210904.607934824@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.155-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.155-rc1
X-KernelTest-Deadline: 2018-09-09T21:09+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.155 release.
There are 47 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Sep  9 21:08:44 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.155-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.155-rc1

Dave Airlie <airlied@redhat.com>
    drm/drivers: add support for using the arch wc mapping API.

Dave Airlie <airlied@redhat.com>
    x86/io: add interface to reserve io memtype for a resource range. (v1.1)

Jeremy Cline <jcline@redhat.com>
    fs/quota: Fix spectre gadget in do_quotactl

Adrian Hunter <adrian.hunter@intel.com>
    perf auxtrace: Fix queue resize

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
    ubifs: Check data node size before truncate

Richard Weinberger <richard@nod.at>
    Revert "UBIFS: Fix potential integer overflow in allocation"

Richard Weinberger <richard@nod.at>
    ubifs: Fix memory leak in lprobs self-check

Jann Horn <jannh@google.com>
    userns: move user access out of the mutex

Jann Horn <jannh@google.com>
    sys: don't hold uts_sem while accessing userspace memory

Al Viro <viro@zeniv.linux.org.uk>
    osf_getdomainname(): use copy_to_user()

Jacob Pan <jacob.jun.pan@linux.intel.com>
    iommu/vt-d: Fix dev iotlb pfsid use

Jacob Pan <jacob.jun.pan@linux.intel.com>
    iommu/vt-d: Add definitions for PFSID

Peter Zijlstra <peterz@infradead.org>
    mm/tlb: Remove tlb_remove_table() non-concurrent condition

Jon Hunter <jonathanh@nvidia.com>
    ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Dan Carpenter <dan.carpenter@oracle.com>
    pnfs/blocklayout: off by one in bl_map_stripe()

zhangyi (F) <yi.zhang@huawei.com>
    PM / sleep: wakeup: Fix build error caused by missing SRCU support

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

Nadav Amit <namit@vmware.com>
    vmw_balloon: fix VMCI use when balloon built into kernel

Nadav Amit <namit@vmware.com>
    vmw_balloon: VMCI_DOORBELL_SET does not check status

Nadav Amit <namit@vmware.com>
    vmw_balloon: do not use 2MB without batching

Nadav Amit <namit@vmware.com>
    vmw_balloon: fix inflation of 64-bit GFNs

Lars-Peter Clausen <lars@metafoo.de>
    iio: ad9523: Fix return value for ad952x_store()

Lars-Peter Clausen <lars@metafoo.de>
    iio: ad9523: Fix displayed phase

Mike Snitzer <snitzer@redhat.com>
    dm cache metadata: save in-core policy_hint_size to on-disk superblock

Jiri Slaby <jslaby@suse.cz>
    x86/mm/pat: Fix L1TF stable backport for CPA, 2nd call

Tomas Bortoli <tomasbortoli@gmail.com>
    net/9p/trans_fd.c: fix race-condition by flushing workqueue before the kfree()

Tomas Bortoli <tomasbortoli@gmail.com>
    net/9p/client.c: version pointer uninitialized

jiangyiwen <jiangyiwen@huawei.com>
    9p/virtio: fix off-by-one error in sg list bounds check

piaojun <piaojun@huawei.com>
    fs/9p/xattr.c: catch the error of p9_client_clunk when setting xattr failed

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.

Hari Bathini <hbathini@linux.ibm.com>
    powerpc/fadump: handle crash memory ranges array index overflow

Matthew Auld <matthew.auld@intel.com>
    drm/i915/userptr: reject zero user_size

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    spi: davinci: fix a NULL pointer dereference

Ben Hutchings <ben.hutchings@codethink.co.uk>
    net: lan78xx: Fix misplaced tasklet_schedule() call

Chirantan Ekbote <chirantan@chromium.org>
    9p/net: Fix zero-copy path in the 9p virtio transport

Alexander Aring <aring@mojatatu.com>
    net: mac802154: tx: expand tailroom if necessary

Alexander Aring <aring@mojatatu.com>
    net: 6lowpan: fix reserved space for single frames


-------------

Diffstat:

 Makefile                                   |  4 +-
 arch/alpha/kernel/osf_sys.c                | 64 +++++++++-----------
 arch/arm/boot/dts/tegra30-cardhu.dtsi      |  1 +
 arch/powerpc/include/asm/fadump.h          |  3 -
 arch/powerpc/kernel/fadump.c               | 91 +++++++++++++++++++++++-----
 arch/powerpc/platforms/pseries/ras.c       |  2 +-
 arch/sparc/kernel/sys_sparc_32.c           | 22 ++++---
 arch/sparc/kernel/sys_sparc_64.c           | 20 ++++---
 arch/x86/include/asm/io.h                  |  6 ++
 arch/x86/mm/pageattr.c                     |  2 +-
 arch/x86/mm/pat.c                          | 14 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  5 ++
 drivers/gpu/drm/ast/ast_ttm.c              |  6 ++
 drivers/gpu/drm/cirrus/cirrus_ttm.c        |  7 +++
 drivers/gpu/drm/i915/i915_gem_userptr.c    |  3 +
 drivers/gpu/drm/mgag200/mgag200_ttm.c      |  7 +++
 drivers/gpu/drm/nouveau/nouveau_ttm.c      |  8 +++
 drivers/gpu/drm/radeon/radeon_object.c     |  5 ++
 drivers/iio/frequency/ad9523.c             |  4 +-
 drivers/iommu/dmar.c                       |  6 +-
 drivers/iommu/intel-iommu.c                | 18 +++++-
 drivers/md/bcache/writeback.c              |  4 +-
 drivers/md/dm-cache-metadata.c             |  3 +-
 drivers/misc/vmw_balloon.c                 | 67 +++++++++++++--------
 drivers/net/usb/lan78xx.c                  |  4 +-
 drivers/pwm/pwm-tiehrpwm.c                 |  2 +
 drivers/spi/spi-davinci.c                  |  2 +-
 drivers/video/fbdev/core/fbmem.c           | 38 ++++++++++--
 fs/9p/xattr.c                              |  6 +-
 fs/nfs/blocklayout/dev.c                   |  2 +-
 fs/quota/quota.c                           |  2 +
 fs/ubifs/journal.c                         | 18 +++++-
 fs/ubifs/lprops.c                          |  8 +--
 fs/xattr.c                                 |  2 +-
 include/linux/intel-iommu.h                |  8 ++-
 include/linux/io.h                         | 22 +++++++
 include/video/udlfb.h                      |  2 +-
 kernel/kthread.c                           |  8 ++-
 kernel/power/Kconfig                       |  1 +
 kernel/sys.c                               | 95 ++++++++++++++----------------
 kernel/trace/blktrace.c                    |  4 ++
 kernel/trace/trace.c                       |  4 +-
 kernel/trace/trace_uprobe.c                |  2 +-
 kernel/user_namespace.c                    | 22 ++++---
 kernel/utsname_sysctl.c                    | 41 ++++++++-----
 mm/memory.c                                |  9 ---
 net/9p/client.c                            |  2 +-
 net/9p/trans_fd.c                          |  7 ++-
 net/9p/trans_rdma.c                        |  3 +
 net/9p/trans_virtio.c                      | 13 +++-
 net/ieee802154/6lowpan/tx.c                | 21 ++++++-
 net/mac802154/tx.c                         | 15 ++++-
 tools/perf/util/auxtrace.c                 |  3 +
 53 files changed, 510 insertions(+), 228 deletions(-)



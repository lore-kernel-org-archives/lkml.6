Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFA1C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B453221480
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xOmgX6PS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B453221480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbeJKXO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731177AbeJKXO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:14:26 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799462085B;
        Thu, 11 Oct 2018 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272800;
        bh=kPMI/BKK3zavNJDS8+NznLW7a+KTDolGbMfrn4FEb4w=;
        h=From:To:Cc:Subject:Date:From;
        b=xOmgX6PS09hr39tX+bA2zQNHdq9a1Dtq3k/xgom1fZDhKVpkTH/o/8TZfjaiTwPDq
         rncHw91YGoRpnT55IhK2vu9k8up1rzu52B8tuIbGYaNIBDBgIDOVV+lrDeSV9IKZWa
         Xd48f7G30k0GnLoypRJYKoypptIWlX9zjzXticQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/45] 4.14.76-stable review
Date:   Thu, 11 Oct 2018 17:39:27 +0200
Message-Id: <20181011152508.885515042@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.76-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.76-rc1
X-KernelTest-Deadline: 2018-10-13T15:25+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.76 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Oct 13 15:24:53 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.76-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.76-rc1

Zhi Chen <zhichen@codeaurora.org>
    ath10k: fix scan crash due to incorrect length calculation

Jan Stancek <jstancek@redhat.com>
    virtio_balloon: fix increment of vb->num_pfns in fill_balloon()

Michael S. Tsirkin <mst@redhat.com>
    virtio_balloon: fix deadlock on OOM

Ka-Cheong Poon <ka-cheong.poon@oracle.com>
    rds: rds_ib_recv_alloc_cache() should call alloc_percpu_gfp() instead

Richard Weinberger <richard@nod.at>
    ubifs: Check for name being NULL while mounting

Cong Wang <xiyou.wangcong@gmail.com>
    ucma: fix a use-after-free in ucma_resolve_ip()

Chao Yu <yuchao0@huawei.com>
    f2fs: fix invalid memory access

Jiri Olsa <jolsa@kernel.org>
    perf utils: Move is_directory() to path.h

Harsh Jain <harsh@chelsio.com>
    crypto: chelsio - Fix memory corruption in DMA Mapped buffers.

Vineet Gupta <vgupta@synopsys.com>
    ARC: clone syscall to setp r25 as thread pointer

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/lib: fix book3s/32 boot failure due to code patching

Michael Neuling <mikey@neuling.org>
    powerpc: Avoid code patching freed init sections

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/lib/code-patching: refactor patch_instruction()

James Smart <jsmart2021@gmail.com>
    nvme_fc: fix ctrl create failures racing with workq items

Yu Wang <yyuwang@codeaurora.org>
    ath10k: fix kernel panic issue during pci probe

Carl Huang <cjhuang@codeaurora.org>
    ath10k: fix use-after-free in ath10k_wmi_cmd_send_nowait

Prateek Sood <prsood@codeaurora.org>
    cgroup/cpuset: remove circular dependency deadlock

Jiri Olsa <jolsa@kernel.org>
    perf tools: Fix python extension build for gcc 8

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf annotate: Use asprintf when formatting objdump command line

Guenter Roeck <linux@roeck-us.net>
    of: unittest: Disable interrupt node tests for old world MAC systems

Dmitry Safonov <dima@arista.com>
    tty: Drop tty->count on tty_reopen() failure

Romain Izard <romain.izard.pro@gmail.com>
    usb: cdc_acm: Do not leak URB buffers

Johan Hovold <johan@kernel.org>
    USB: serial: simple: add Motorola Tetra MTP6550 id

Chunfeng Yun <chunfeng.yun@mediatek.com>
    usb: xhci-mtk: resume USB3 roothub first

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Add missing CAS workaround for Intel Sunrise Point xHCI

Mike Snitzer <snitzer@redhat.com>
    dm cache: fix resize crash if user doesn't reload cache table

Joe Thornber <ejt@redhat.com>
    dm cache metadata: ignore hints array being too small during resize

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM / core: Clear the direct_complete flag on errors

Felix Fietkau <nbd@nbd.name>
    mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Daniel Drake <drake@endlessm.com>
    PCI: Reprogram bridge prefetch registers on resume

Andy Lutomirski <luto@kernel.org>
    x86/vdso: Fix vDSO syscall fallback asm constraint regression

Andy Lutomirski <luto@kernel.org>
    x86/vdso: Only enable vDSO retpolines when enabled and supported

Andy Lutomirski <luto@kernel.org>
    selftests/x86: Add clock_gettime() tests to test_vdso

Andy Lutomirski <luto@kernel.org>
    x86/vdso: Fix asm constraints on vDSO syscall fallbacks

Jason Ekstrand <jason@jlekstrand.net>
    drm/syncobj: Don't leak fences when WAIT_FOR_SUBMIT is set

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Fix vce work queue was not cancelled when suspend

Jan Beulich <JBeulich@suse.com>
    xen-netback: fix input validation in xenvif_set_hash_mapping()

Tomi Valkeinen <tomi.valkeinen@ti.com>
    fbdev/omapfb: fix omapfb_memory_read infoleak

Alexandre Belloni <alexandre.belloni@bootlin.com>
    clocksource/drivers/timer-atmel-pit: Properly handle error cases

Ilya Dryomov <idryomov@gmail.com>
    blk-mq: I/O and timer unplugs are inverted in blktrace

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: fix L1TF's MMIO GFN calculation

Jann Horn <jannh@google.com>
    mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm, thp: fix mlocking THP page with migration enabled

Mike Kravetz <mike.kravetz@oracle.com>
    mm: migration: fix migration of huge PMD shared pages

Reinette Chatre <reinette.chatre@intel.com>
    perf/core: Add sanity check to deal with pinned event failure


-------------

Diffstat:

 Makefile                                        |   4 +-
 arch/arc/kernel/process.c                       |  20 +++
 arch/powerpc/include/asm/setup.h                |   1 +
 arch/powerpc/lib/code-patching.c                |  44 +++---
 arch/powerpc/mm/mem.c                           |   2 +
 arch/x86/entry/vdso/Makefile                    |  16 ++-
 arch/x86/entry/vdso/vclock_gettime.c            |  26 ++--
 arch/x86/kvm/mmu.c                              |  24 +++-
 block/blk-mq.c                                  |   4 +-
 drivers/base/power/main.c                       |   5 +-
 drivers/clocksource/timer-atmel-pit.c           |  20 ++-
 drivers/crypto/chelsio/chcr_algo.c              |  41 ++++--
 drivers/crypto/chelsio/chcr_crypto.h            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         |   4 +-
 drivers/gpu/drm/drm_syncobj.c                   |   5 +
 drivers/infiniband/core/ucma.c                  |   2 +
 drivers/md/dm-cache-metadata.c                  |   4 +-
 drivers/md/dm-cache-target.c                    |   9 +-
 drivers/net/wireless/ath/ath10k/debug.c         |  12 +-
 drivers/net/wireless/ath/ath10k/trace.h         |  12 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c       |   8 +-
 drivers/net/wireless/ath/ath10k/wmi.c           |   2 +-
 drivers/net/xen-netback/hash.c                  |  12 +-
 drivers/nvme/host/fc.c                          |   4 +
 drivers/of/unittest.c                           |  26 ++--
 drivers/pci/pci.c                               |  27 ++--
 drivers/tty/tty_io.c                            |  11 +-
 drivers/usb/class/cdc-acm.c                     |   6 +
 drivers/usb/host/xhci-mtk.c                     |   4 +-
 drivers/usb/host/xhci-pci.c                     |   2 +
 drivers/usb/serial/usb-serial-simple.c          |   3 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |   5 +-
 drivers/virtio/virtio_balloon.c                 |  23 +++-
 fs/f2fs/checkpoint.c                            |   9 +-
 fs/ubifs/super.c                                |   3 +
 include/linux/balloon_compaction.h              |  35 ++++-
 include/linux/hugetlb.h                         |  14 ++
 include/linux/mm.h                              |   6 +
 kernel/cgroup/cpuset.c                          |  53 ++++----
 kernel/events/core.c                            |   6 +
 mm/balloon_compaction.c                         |  28 +++-
 mm/huge_memory.c                                |   2 +-
 mm/hugetlb.c                                    |  37 ++++-
 mm/migrate.c                                    |   3 +
 mm/rmap.c                                       |  42 +++++-
 mm/vmstat.c                                     |   3 +
 net/mac80211/cfg.c                              |   2 +-
 net/rds/ib.h                                    |   2 +-
 net/rds/ib_cm.c                                 |   2 +-
 net/rds/ib_recv.c                               |  10 +-
 tools/perf/builtin-script.c                     |  14 +-
 tools/perf/util/annotate.c                      |  17 ++-
 tools/perf/util/path.c                          |  14 ++
 tools/perf/util/path.h                          |   3 +
 tools/perf/util/setup.py                        |   2 +
 tools/testing/selftests/x86/test_vdso.c         | 172 ++++++++++++++++++++++++
 57 files changed, 690 insertions(+), 182 deletions(-)



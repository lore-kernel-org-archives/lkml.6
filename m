Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418ACC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB5221470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkPNPaso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB5221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbeJKXL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbeJKXL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:11:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F632098A;
        Thu, 11 Oct 2018 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272651;
        bh=RVygJvAiQoPoCUQRxcOIHmq+H4TWlvzt8KMpSyVr9HA=;
        h=From:To:Cc:Subject:Date:From;
        b=KkPNPaso4JYGeEh/VnkRrDaHrhKkaflHZhC6TnpWdTOIC4rSTv7zRcAhJPQBaQVE1
         d3P1k8b/JOAhatDez2FIdMA4JtmIRPsDWREXhNgzKZ9Z8R+Kf/0vPjpVIi/Im2WXLo
         7SmRHAiu92nN/bo/M3CRjCXLsSC+JCQvw8FhSIGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/35] 4.9.133-stable review
Date:   Thu, 11 Oct 2018 17:35:02 +0200
Message-Id: <20181011152520.174949126@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.133-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.133-rc1
X-KernelTest-Deadline: 2018-10-13T15:25+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.133 release.
There are 35 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Oct 13 15:25:09 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.133-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.133-rc1

Andy Lutomirski <luto@kernel.org>
    x86/fpu: Finish excising 'eagerfpu'

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "perf: sync up x86/.../cpufeatures.h"

Rik van Riel <riel@redhat.com>
    x86/fpu: Remove struct fpu::counter

Andy Lutomirski <luto@kernel.org>
    x86/fpu: Remove use_eager_fpu()

Gao Feng <gfree.wind@vip.163.com>
    ebtables: arpreply: Add the standard target sanity check

Zhi Chen <zhichen@codeaurora.org>
    ath10k: fix scan crash due to incorrect length calculation

Frederic Weisbecker <fweisbec@gmail.com>
    sched/cputime: Fix ksoftirqd cputime accounting regression

Frederic Weisbecker <fweisbec@gmail.com>
    sched/cputime: Increment kcpustat directly on irqtime account

Frederic Weisbecker <fweisbec@gmail.com>
    sched/cputime: Convert kcpustat to nsecs

Richard Weinberger <richard@nod.at>
    ubifs: Check for name being NULL while mounting

Cong Wang <xiyou.wangcong@gmail.com>
    ucma: fix a use-after-free in ucma_resolve_ip()

Chao Yu <yuchao0@huawei.com>
    f2fs: fix invalid memory access

Feng Tang <feng.tang@intel.com>
    x86/mm: Expand static page table for fixmap space

Vineet Gupta <vgupta@synopsys.com>
    ARC: clone syscall to setp r25 as thread pointer

Michal Suchanek <msuchanek@suse.de>
    powerpc/fadump: Return error when fadump registration fails

Yu Wang <yyuwang@codeaurora.org>
    ath10k: fix kernel panic issue during pci probe

Carl Huang <cjhuang@codeaurora.org>
    ath10k: fix use-after-free in ath10k_wmi_cmd_send_nowait

Prateek Sood <prsood@codeaurora.org>
    cgroup: Fix deadlock in cpu hotplug path

Theodore Ts'o <tytso@mit.edu>
    ext4: always verify the magic number in xattr blocks

Theodore Ts'o <tytso@mit.edu>
    ext4: add corruption check in ext4_xattr_set_entry()

Guenter Roeck <linux@roeck-us.net>
    of: unittest: Disable interrupt node tests for old world MAC systems

Dmitry Safonov <dima@arista.com>
    tty: Drop tty->count on tty_reopen() failure

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
    x86/vdso: Fix asm constraints on vDSO syscall fallbacks

Jan Beulich <JBeulich@suse.com>
    xen-netback: fix input validation in xenvif_set_hash_mapping()

Tomi Valkeinen <tomi.valkeinen@ti.com>
    fbdev/omapfb: fix omapfb_memory_read infoleak

Jann Horn <jannh@google.com>
    mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly


-------------

Diffstat:

 Documentation/kernel-parameters.txt             |  6 --
 Makefile                                        |  4 +-
 arch/arc/kernel/process.c                       | 20 +++++++
 arch/powerpc/kernel/fadump.c                    | 23 +++++---
 arch/s390/appldata/appldata_os.c                | 16 +++---
 arch/x86/crypto/crc32c-intel_glue.c             | 17 ++----
 arch/x86/entry/vdso/vclock_gettime.c            | 26 +++++----
 arch/x86/include/asm/cpufeatures.h              |  1 -
 arch/x86/include/asm/fixmap.h                   | 10 ++++
 arch/x86/include/asm/fpu/internal.h             | 37 +-----------
 arch/x86/include/asm/fpu/types.h                | 34 -----------
 arch/x86/include/asm/pgtable_64.h               |  3 +-
 arch/x86/include/asm/trace/fpu.h                |  5 +-
 arch/x86/kernel/fpu/core.c                      | 39 ++-----------
 arch/x86/kernel/fpu/signal.c                    |  8 +--
 arch/x86/kernel/fpu/xstate.c                    |  9 ---
 arch/x86/kernel/head_64.S                       | 16 ++++--
 arch/x86/kvm/cpuid.c                            |  4 +-
 arch/x86/kvm/x86.c                              | 10 ----
 arch/x86/mm/pgtable.c                           |  9 +++
 arch/x86/mm/pkeys.c                             |  3 +-
 arch/x86/xen/mmu.c                              |  8 ++-
 drivers/base/power/main.c                       |  5 +-
 drivers/cpufreq/cpufreq.c                       |  6 +-
 drivers/cpufreq/cpufreq_governor.c              |  2 +-
 drivers/cpufreq/cpufreq_stats.c                 |  1 -
 drivers/infiniband/core/ucma.c                  |  2 +
 drivers/macintosh/rack-meter.c                  |  2 +-
 drivers/md/dm-cache-metadata.c                  |  4 +-
 drivers/md/dm-cache-target.c                    |  9 ++-
 drivers/net/wireless/ath/ath10k/debug.c         | 12 +++-
 drivers/net/wireless/ath/ath10k/trace.h         | 12 ++--
 drivers/net/wireless/ath/ath10k/wmi-tlv.c       |  8 +--
 drivers/net/wireless/ath/ath10k/wmi.c           |  2 +-
 drivers/net/xen-netback/hash.c                  | 12 ++--
 drivers/of/unittest.c                           | 28 ++++++---
 drivers/pci/pci.c                               | 27 ++++++---
 drivers/tty/tty_io.c                            | 11 +++-
 drivers/usb/host/xhci-mtk.c                     |  4 +-
 drivers/usb/host/xhci-pci.c                     |  2 +
 drivers/usb/serial/usb-serial-simple.c          |  3 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |  5 +-
 fs/ext4/xattr.c                                 | 28 +++++----
 fs/f2fs/checkpoint.c                            |  9 +--
 fs/proc/stat.c                                  | 68 +++++++++++-----------
 fs/proc/uptime.c                                |  7 +--
 fs/ubifs/super.c                                |  3 +
 include/linux/netfilter_bridge/ebtables.h       |  5 ++
 kernel/cgroup.c                                 |  6 +-
 kernel/sched/cpuacct.c                          |  2 +-
 kernel/sched/cputime.c                          | 75 +++++++++++--------------
 kernel/sched/sched.h                            | 12 +++-
 mm/vmstat.c                                     |  3 +
 net/bridge/netfilter/ebt_arpreply.c             |  3 +
 net/mac80211/cfg.c                              |  2 +-
 tools/arch/x86/include/asm/cpufeatures.h        |  1 -
 56 files changed, 335 insertions(+), 354 deletions(-)



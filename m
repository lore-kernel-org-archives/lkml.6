Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BADECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E00721480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="euTcbALk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E00721480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeJSCGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbeJSCGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:06:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1036321476;
        Thu, 18 Oct 2018 18:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885881;
        bh=Y17zeGLWfzNXrFtyFK08Urc/r1e0GWdWrv/Qn2ngWW0=;
        h=From:To:Cc:Subject:Date:From;
        b=euTcbALk7iE+7JiZ8sG9X33fvqDhlR/6rO1mY/rgAJv3motX281otnCZSK7gaK5PV
         wyr/Nj00ZbDLJ8765QfS3EEM6U0IzBM1YDHK90ZzDpnsQ4pjzLy2TN54eeMxiAmGS6
         MIbhUdRrxIUsyZ1Xz47yhNatyfSdu7uzqyE/HmOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/35] 4.9.135-stable review
Date:   Thu, 18 Oct 2018 19:54:29 +0200
Message-Id: <20181018175422.506152522@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.135-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.135-rc1
X-KernelTest-Deadline: 2018-10-20T17:54+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.135 release.
There are 35 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Oct 20 17:54:00 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.135-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.135-rc1

Long Li <longli@microsoft.com>
    HV: properly delay KVP packets when negotiation is in progress

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid running out of journal credits when appending to an inline file

Frederic Weisbecker <fweisbec@gmail.com>
    sched/cputime: Fix ksoftirqd cputime accounting regression

Frederic Weisbecker <fweisbec@gmail.com>
    sched/cputime: Increment kcpustat directly on irqtime account

Frederic Weisbecker <fweisbec@gmail.com>
    macintosh/rack-meter: Convert cputime64_t use to u64

Frederic Weisbecker <fweisbec@gmail.com>
    sched/cputime: Convert kcpustat to nsecs

Stephen Warren <swarren@nvidia.com>
    usb: gadget: serial: fix oops when data rx'd after close

Natanael Copa <ncopa@alpinelinux.org>
    HID: quirks: fix support for Apple Magic Keyboards

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: build: Don't set CROSS_COMPILE in arch's Makefile

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: build: Get rid of toolchain check

Xin Long <lucien.xin@gmail.com>
    netfilter: check for seqadj ext existence before adding it in nf_nat_setup_info

Jan Kara <jack@suse.cz>
    mm: Preserve _PAGE_DEVMAP across mprotect() calls

Linus Torvalds <torvalds@linux-foundation.org>
    mremap: properly flush TLB before releasing the page

Arindam Nath <arindam.nath@amd.com>
    iommu/amd: Return devid as alias for ACPI HID devices

Michael Neuling <mikey@neuling.org>
    powerpc/tm: Avoid possible userspace r1 corruption on reclaim

Michael Neuling <mikey@neuling.org>
    powerpc/tm: Fix userspace r13 corruption

James Cowgill <jcowgill@debian.org>
    RISC-V: include linux/ftrace.h in asm-prototypes.h

Nathan Chancellor <natechancellor@gmail.com>
    net/mlx4: Use cpumask_available for eq->affinity_mask

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sd: don't crash the host on invalid commands

Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
    drm: mali-dp: Call drm_crtc_vblank_reset on device init

Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
    ravb: do not write 1 to reserved bits

Michael Schmitz <schmitzmic@gmail.com>
    Input: atakbd - fix Atari CapsLock behaviour

Andreas Schwab <schwab@linux-m68k.org>
    Input: atakbd - fix Atari keymap

Laura Abbott <labbott@redhat.com>
    scsi: ibmvscsis: Ensure partition name is properly NUL terminated

Laura Abbott <labbott@redhat.com>
    scsi: ibmvscsis: Fix a stringop-overflow warning

Keerthy <j-keerthy@ti.com>
    clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for non-am43 SoCs

Marek Lindner <mareklindner@neomailbox.ch>
    batman-adv: fix hardif_neigh refcount on queue_work() failure

Marek Lindner <mareklindner@neomailbox.ch>
    batman-adv: fix backbone_gw refcount on queue_work() failure

Sven Eckelmann <sven@narfation.org>
    batman-adv: Prevent duplicated tvlv handler

Sven Eckelmann <sven@narfation.org>
    batman-adv: Prevent duplicated global TT entry

Sven Eckelmann <sven@narfation.org>
    batman-adv: Prevent duplicated softif_vlan entry

Sven Eckelmann <sven@narfation.org>
    batman-adv: Prevent duplicated nc_node entry

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix segfault when writing to sysfs elp_interval

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix segfault when writing to throughput_override

Jozef Balga <jozef.balga@gmail.com>
    media: af9035: prevent buffer overflow on write


-------------

Diffstat:

 Makefile                                 |  4 +-
 arch/arc/Makefile                        | 24 +---------
 arch/powerpc/kernel/tm.S                 | 20 +++++++--
 arch/riscv/include/asm/asm-prototypes.h  |  7 +++
 arch/s390/appldata/appldata_os.c         | 16 +++----
 arch/x86/include/asm/pgtable_types.h     |  2 +-
 drivers/clocksource/timer-ti-32k.c       |  3 ++
 drivers/cpufreq/cpufreq.c                |  6 +--
 drivers/cpufreq/cpufreq_governor.c       |  2 +-
 drivers/cpufreq/cpufreq_stats.c          |  1 -
 drivers/gpu/drm/arm/malidp_drv.c         |  1 +
 drivers/hid/hid-core.c                   |  3 ++
 drivers/hv/hv_kvp.c                      | 13 +++---
 drivers/input/keyboard/atakbd.c          | 74 ++++++++++++-------------------
 drivers/iommu/amd_iommu.c                |  6 +++
 drivers/macintosh/rack-meter.c           | 28 ++++++------
 drivers/media/usb/dvb-usb-v2/af9035.c    |  6 ++-
 drivers/net/ethernet/mellanox/mlx4/eq.c  |  3 +-
 drivers/net/ethernet/renesas/ravb.h      |  5 +++
 drivers/net/ethernet/renesas/ravb_main.c | 11 ++---
 drivers/net/ethernet/renesas/ravb_ptp.c  |  2 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c |  5 +--
 drivers/scsi/sd.c                        |  3 +-
 drivers/usb/gadget/function/u_serial.c   |  2 +-
 fs/ext4/ext4.h                           |  3 --
 fs/ext4/inline.c                         | 38 +---------------
 fs/ext4/xattr.c                          | 18 +-------
 fs/proc/stat.c                           | 68 ++++++++++++++---------------
 fs/proc/uptime.c                         |  7 +--
 include/linux/huge_mm.h                  |  2 +-
 kernel/sched/cpuacct.c                   |  2 +-
 kernel/sched/cputime.c                   | 75 ++++++++++++++------------------
 kernel/sched/sched.h                     | 12 +++--
 mm/huge_memory.c                         | 10 ++---
 mm/mremap.c                              | 30 ++++++-------
 net/batman-adv/bat_v_elp.c               |  8 +++-
 net/batman-adv/bridge_loop_avoidance.c   | 10 ++++-
 net/batman-adv/network-coding.c          | 27 +++++++-----
 net/batman-adv/soft-interface.c          | 25 ++++++++---
 net/batman-adv/sysfs.c                   | 30 ++++++++-----
 net/batman-adv/translation-table.c       |  6 ++-
 net/batman-adv/tvlv.c                    |  8 +++-
 net/netfilter/nf_nat_core.c              |  2 +-
 43 files changed, 303 insertions(+), 325 deletions(-)



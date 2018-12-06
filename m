Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819E3C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BC0214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107275;
	bh=I+4R1lo2H6CM2WzhiAx/LWJZM+OHWYBmPAwLROMAcCw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gvki1WSZVlT23T3Z0nRdVB9o5nqFB7AjkkKNXgk4iUTC5CIZik3Aw2nAlLIVZ47Ah
	 XHr+mvVN54PsrpbO0JtthZrAxglEgIPb/9zYWv8dDLfFhrcjedrm1fZIa5g0i5DiAU
	 FCZTCSTVPpPyYm8NZgzLiMtb+MN+umtiXOX3jpA8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BC0214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbeLFOlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbeLFOlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D5A20661;
        Thu,  6 Dec 2018 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107270;
        bh=I+4R1lo2H6CM2WzhiAx/LWJZM+OHWYBmPAwLROMAcCw=;
        h=From:To:Cc:Subject:Date:From;
        b=vcySCwZO8hUnrwNjQJTaF1fk4uaCleJlv0xrp3uF6AsAV+1/W9bsJVU9cmTC4oWEf
         HuSWHipvX/EEXiFRH0xO0owf7xYKUQJ33me64BULvNDvJdMTDknecSQBGPvT1GUAX6
         BTMTUzbRQhRElLoXwjxbAp1jwZQphChswYEiKxj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/41] 4.19.8-stable review
Date:   Thu,  6 Dec 2018 15:38:40 +0100
Message-Id: <20181206142949.757402551@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.8-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.8-rc1
X-KernelTest-Deadline: 2018-12-08T14:29+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.8 release.
There are 41 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Dec  8 14:29:30 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.8-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.8-rc1

Guoqing Jiang <gqjiang@suse.com>
    tipc: use destination length for copy string

Alexey Brodkin <abrodkin@synopsys.com>
    arc: [devboards] Add support of NFSv3 ACL

Kevin Hilman <khilman@baylibre.com>
    ARC: change defconfig defaults to ARCv2

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Don't check max block group size as current max chunk size limit is unreliable

Adam Wong <adam@adamwong.me>
    Input: elan_i2c - add support for ELAN0621 touchpad

Noah Westervelt <nwestervelt@outlook.com>
    Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR

Patrick Gaskin <patrick@pgaskin.net>
    Input: elan_i2c - add ELAN0620 to the ACPI table

Brian Norris <briannorris@chromium.org>
    Input: cros_ec_keyb - fix button/switch capability reports

Christian Hoff <christian_hoff@gmx.net>
    Input: matrix_keypad - check for errors from of_get_named_gpio()

Lyude Paul <lyude@redhat.com>
    Input: synaptics - add PNP ID for ThinkPad P50 to SMBus

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - quirk all PDP Xbox One gamepads

Martin Wilck <mwilck@suse.com>
    scsi: lpfc: fix block guard enablement on SLI3 adapters

Lihong Yang <lihong.yang@intel.com>
    i40e: Fix deletion of MAC filters

Paul Moore <paul@paul-moore.com>
    selinux: add support for RTM_NEWCHAIN, RTM_DELCHAIN, and RTM_GETCHAIN

Wei Wang <wawei@amazon.de>
    svm: Add mutex_lock to protect apic_access_page_done on AMD systems

Laura Abbott <labbott@redhat.com>
    kgdboc: Fix warning with module build

Laura Abbott <labbott@redhat.com>
    kgdboc: Fix restrict error

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: shmem: UFFDIO_COPY: set the page dirty if VM_WRITE is not set

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: shmem: add i_size checks

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: use ENOENT instead of EFAULT if the atomic copy user fails

Lyude Paul <lyude@redhat.com>
    drm/meson: Fix OOB memory accesses in meson_viu_set_osd_lut()

Lyude Paul <lyude@redhat.com>
    drm/meson: Enable fast_io in meson_dw_hdmi_regmap_config

Neil Armstrong <narmstrong@baylibre.com>
    drm/meson: Fixes for drm_crtc_vblank_on/off support

Sergio Correia <sergio@correia.cc>
    drm: set is_master to 0 upon drm_new_set_master() failure

Lyude Paul <lyude@redhat.com>
    drm/amd/dm: Understand why attaching path/tile properties are needed

Lyude Paul <lyude@redhat.com>
    drm/amd/dm: Don't forget to attach MST encoders

Sam Bobroff <sbobroff@linux.ibm.com>
    drm/ast: Fix incorrect free on ioregs

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing/fgraph: Fix set_graph_function from showing interrupts

Michael Guralnik <michaelgur@mellanox.com>
    IB/mlx5: Avoid load failure due to unknown link width

Dmitry V. Levin <ldv@altlinux.org>
    mips: fix mips_get_syscall_arg o32 check

Mathias Kresin <dev@kresin.me>
    MIPS: ralink: Fix mt7620 nd_sd pinmux

Zenghui Yu <yuzenghui@huawei.com>
    tracepoint: Use __idx instead of idx in DO_TRACE macro to make it unique

Pavankumar Kondeti <pkondeti@codeaurora.org>
    sched, trace: Fix prev_state output in sched_switch tracepoint

Masami Hiramatsu <mhiramat@kernel.org>
    arm64: ftrace: Fix to enable syscall events on arm64

Frieder Schrempf <frieder.schrempf@kontron.de>
    mtd: nand: Fix memory allocation in nanddev_bbt_init()

Andrea Parri <andrea.parri@amarulasolutions.com>
    uprobes: Fix handle_swbp() vs. unregister() + register() race once more

Sagi Grimberg <sagi@grimberg.me>
    iser: set sector for ambiguous mr status errors

Linus Torvalds <torvalds@linux-foundation.org>
    unifdef: use memcpy instead of strncpy

Linus Torvalds <torvalds@linux-foundation.org>
    test_hexdump: use memcpy instead of strncpy

Jens Axboe <axboe@kernel.dk>
    blk-mq: fix corruption with direct issue


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arc/Kconfig                                   |  2 +-
 arch/arc/Makefile                                  |  2 +-
 arch/arc/configs/axs101_defconfig                  |  2 +
 arch/arc/configs/axs103_defconfig                  |  1 +
 arch/arc/configs/axs103_smp_defconfig              |  1 +
 arch/arc/configs/hsdk_defconfig                    |  1 +
 arch/arc/configs/nps_defconfig                     |  2 +
 arch/arc/configs/nsim_700_defconfig                |  1 +
 arch/arc/configs/nsimosci_defconfig                |  2 +
 arch/arc/configs/nsimosci_hs_defconfig             |  1 +
 arch/arc/configs/nsimosci_hs_smp_defconfig         |  1 +
 arch/arc/configs/tb10x_defconfig                   |  1 +
 arch/arc/configs/vdk_hs38_defconfig                |  1 +
 arch/arc/configs/vdk_hs38_smp_defconfig            |  1 +
 arch/arm64/include/asm/ftrace.h                    | 13 +++++
 arch/mips/include/asm/syscall.h                    |  2 +-
 arch/mips/ralink/mt7620.c                          |  2 +-
 arch/x86/kvm/svm.c                                 | 19 +++++---
 block/blk-mq.c                                     | 26 +++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  5 +-
 drivers/gpu/drm/ast/ast_main.c                     |  3 +-
 drivers/gpu/drm/drm_auth.c                         |  2 +
 drivers/gpu/drm/meson/meson_crtc.c                 | 27 +++++++++-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  1 +
 drivers/gpu/drm/meson/meson_venc.c                 |  3 ++
 drivers/gpu/drm/meson/meson_viu.c                  | 12 ++---
 drivers/infiniband/hw/mlx5/main.c                  | 29 +++++------
 drivers/infiniband/ulp/iser/iser_verbs.c           |  7 ++-
 drivers/input/joystick/xpad.c                      | 16 +++---
 drivers/input/keyboard/cros_ec_keyb.c              |  3 +-
 drivers/input/keyboard/matrix_keypad.c             | 23 +++++----
 drivers/input/mouse/elan_i2c_core.c                |  3 ++
 drivers/input/mouse/synaptics.c                    |  1 +
 drivers/mtd/nand/bbt.c                             |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  2 +-
 drivers/scsi/lpfc/lpfc_init.c                      |  6 ++-
 drivers/scsi/lpfc/lpfc_sli.c                       |  1 -
 drivers/tty/serial/kgdboc.c                        | 43 ++++++++--------
 fs/btrfs/tree-checker.c                            |  8 ++-
 include/linux/tracepoint.h                         |  6 +--
 include/trace/events/sched.h                       | 12 ++++-
 kernel/events/uprobes.c                            | 12 ++++-
 kernel/trace/trace.h                               | 57 ++++++++++++++++++++--
 kernel/trace/trace_functions_graph.c               |  4 ++
 kernel/trace/trace_irqsoff.c                       |  2 +
 kernel/trace/trace_sched_wakeup.c                  |  2 +
 lib/test_hexdump.c                                 |  2 +-
 mm/hugetlb.c                                       |  2 +-
 mm/shmem.c                                         | 31 ++++++++++--
 mm/userfaultfd.c                                   | 47 +++++++++++++++---
 net/tipc/topsrv.c                                  |  2 +-
 scripts/unifdef.c                                  |  4 +-
 security/selinux/nlmsgtab.c                        | 13 ++++-
 54 files changed, 354 insertions(+), 125 deletions(-)



Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8AEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5EC20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570703;
	bh=DLRHY8sJah2hGOQgM3KnnRWNuGaUlSO6f7vIsA6n4S4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=e/KiMu69cp71jh9VhDS+9wT9rl8rw3O0InaFFd4bn954hJyzZyHr3udXdzjeI4PAq
	 HkNJcgY1L9rlSHi/SORn2cqkcEvBAKzOiLgkfTu7Wt98LeqY36F4K1JFsWIvYbZX0P
	 YlA4/HGuGJFmDbdOot4BbmjCu3wc2D85wywt55Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbfAOQpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbfAOQo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2DA320657;
        Tue, 15 Jan 2019 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570696;
        bh=DLRHY8sJah2hGOQgM3KnnRWNuGaUlSO6f7vIsA6n4S4=;
        h=From:To:Cc:Subject:Date:From;
        b=DHL7CGI+ns72Xdy5Pe7Cte0KO64ocQOaFgrY07g/fXhtdO0U/tV0Z+b0F01DX2sh4
         3tD5b1MPZ9trBd6DLm7FtCxUKDV5kKGQOhlmJontO1UtEbW0ziAxc2fAT2snFMooFd
         zdnOrctn0KlBHSOucnSm2RtH2qrxYd5Pl9K+YJqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.20 00/57] 4.20.3-stable review
Date:   Tue, 15 Jan 2019 17:35:41 +0100
Message-Id: <20190115154910.734892368@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.3-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.20.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.20.3-rc1
X-KernelTest-Deadline: 2019-01-17T15:49+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.20.3 release.
There are 57 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jan 17 15:48:32 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.3-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.20.3-rc1

Filipe Manana <fdmanana@suse.com>
    Btrfs: use nofs context when initializing security xattrs to avoid deadlock

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix deadlock when enabling quotas due to concurrent snapshot creation

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix access to available allocation bits when starting balance

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use-after-free in svc_process_common()

Jan Stancek <jstancek@redhat.com>
    mm: page_mapped: don't assume compound page is huge or THP

Theodore Ts'o <tytso@mit.edu>
    ext4: fix special inode number checks in __ext4_iget()

Theodore Ts'o <tytso@mit.edu>
    ext4: track writeback errors using the generic tracking infrastructure

Theodore Ts'o <tytso@mit.edu>
    ext4: use ext4_write_inode() when fsyncing w/o a journal

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid kernel warning when writing the superblock to a dead device

Theodore Ts'o <tytso@mit.edu>
    ext4: fix a potential fiemap/page fault deadlock w/ inline_data

Theodore Ts'o <tytso@mit.edu>
    ext4: make sure enough credits are reserved for dioread_nolock writes

Ilya Dryomov <idryomov@gmail.com>
    rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set

Lyude Paul <lyude@redhat.com>
    drm/amdgpu: Don't fail resume process if resuming atomic state fails

Lyude Paul <lyude@redhat.com>
    drm/amdgpu: Don't ignore rc from drm_dp_mst_topology_mgr_resume()

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915: Unwind failure on pinning the gen7 ppgtt

Ivan Mironov <mironov.ivan@gmail.com>
    drm/fb-helper: Partially bring back workaround for bugs of SDL 1.2

Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
    drm/amd/display: Fix MST dp_blank REG_WAIT timeout

Marc Zyngier <marc.zyngier@arm.com>
    PCI: dwc: Move interrupt acking into the proper callback

Marc Zyngier <marc.zyngier@arm.com>
    PCI: dwc: Take lock when ACKing an interrupt

Marc Zyngier <marc.zyngier@arm.com>
    PCI: dwc: Use interrupt masking instead of disabling

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Add new VegaM pci id

Alex Williamson <alex.williamson@redhat.com>
    vfio/type1: Fix unmap overflow off-by-one

Christian Lamparter <chunkeey@gmail.com>
    mtd: rawnand: qcom: fix memory corruption that causes panic

Yi Zeng <yizeng@asrmicro.com>
    i2c: dev: prevent adapter retries and timeout being set as minus value

Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
    ACPI/IORT: Fix rc_dma_get_range()

Hans de Goede <hdegoede@redhat.com>
    ACPI / PMIC: xpower: Fix TS-pin current-source handling

Hans de Goede <hdegoede@redhat.com>
    ACPI: power: Skip duplicate power resource references in _PRx

Michal Hocko <mhocko@suse.com>
    mm, memcg: fix reclaim deadlock with writeback

Qian Cai <cai@lca.pw>
    mm/usercopy.c: no check page span for stack objects

Christoph Lameter <cl@linux.com>
    slab: alien caches must not be initialized if the allocation of the alien cache failed

Shakeel Butt <shakeelb@google.com>
    fork, memcg: fix cached_stacks case

Jack Stocker <jackstocker.93@gmail.com>
    USB: Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB

Icenowy Zheng <icenowy@aosc.io>
    USB: storage: add quirk for SMI SM3350

Icenowy Zheng <icenowy@aosc.io>
    USB: storage: don't insert sane sense for SPC3+ when bad sense specified

Daniele Palmas <dnlplm@gmail.com>
    usb: cdc-acm: send ZLP for Telit 3G Intel based modems

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    ARM: davinci: da830-evm: fix label names in GPIO lookup entries

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    ARM: davinci: dm644x-evm: fix label names in GPIO lookup entries

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    ARM: davinci: omapl138-hawk: fix label names in GPIO lookup entries

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    ARM: davinci: da850-evm: fix label names in GPIO lookup entries

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    ARM: davinci: dm355-evm: fix label names in GPIO lookup entries

Joe Perches <joe@perches.com>
    cifs: check kzalloc return

Ross Lagerwall <ross.lagerwall@citrix.com>
    cifs: Fix potential OOB access of lock element array

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix credit computation for compounded requests

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not hide EINTR after sending network packets

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not set credits to 1 if the server didn't grant anything

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix adjustment of credits for MTU requests

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Disable headset Mic VREF for headset mode of ALC225

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add unplug function into unplug state of Headset Mode for ALC225

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Support Dell headset mode for New AIO platform

WANG Chao <chao.wang@ucloud.cn>
    x86, modpost: Replace last remnants of RETPOLINE with CONFIG_RETPOLINE

Quentin Perret <quentin.perret@arm.com>
    cpufreq: scmi: Fix frequency invariance in slow path

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: scpi/scmi: Fix freeing of dynamic OPPs

Larry Finger <Larry.Finger@lwfinger.net>
    staging: rtl8188eu: Fix module loading from tasklet for WEP encryption

Larry Finger <Larry.Finger@lwfinger.net>
    staging: rtl8188eu: Fix module loading from tasklet for CCMP encryption

Saranya Gopal <saranya.gopal@intel.com>
    usbcore: Select only first configuration for non-UAC3 compliant devices

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix deadlock when using free space tree due to block group creation

Breno Leitao <leitao@debian.org>
    powerpc/tm: Unset MSR[TS] if not recheckpointing


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/arm/mach-davinci/board-da830-evm.c           |   4 +-
 arch/arm/mach-davinci/board-da850-evm.c           |   4 +-
 arch/arm/mach-davinci/board-dm355-evm.c           |   4 +-
 arch/arm/mach-davinci/board-dm644x-evm.c          |   4 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c       |   4 +-
 arch/powerpc/kernel/signal_32.c                   |  18 +++-
 arch/powerpc/kernel/signal_64.c                   |  20 +++-
 arch/x86/kernel/cpu/bugs.c                        |   2 +-
 drivers/acpi/arm64/iort.c                         |   3 +-
 drivers/acpi/pmic/intel_pmic_xpower.c             |  41 +++++--
 drivers/acpi/power.c                              |  22 ++++
 drivers/block/rbd.c                               |   9 +-
 drivers/cpufreq/scmi-cpufreq.c                    |   8 +-
 drivers/cpufreq/scpi-cpufreq.c                    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |   1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 ++++---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c     |   4 +-
 drivers/gpu/drm/drm_fb_helper.c                   | 126 +++++++++++++---------
 drivers/gpu/drm/i915/i915_gem_gtt.c               |  15 ++-
 drivers/i2c/i2c-dev.c                             |   6 ++
 drivers/mtd/nand/raw/qcom_nandc.c                 |  20 ++--
 drivers/opp/core.c                                |  63 ++++++++++-
 drivers/pci/controller/dwc/pcie-designware-host.c |  37 ++++---
 drivers/staging/rtl8188eu/core/rtw_security.c     |   6 +-
 drivers/usb/class/cdc-acm.c                       |   7 ++
 drivers/usb/core/generic.c                        |   9 +-
 drivers/usb/core/quirks.c                         |   3 +-
 drivers/usb/storage/scsiglue.c                    |   8 +-
 drivers/usb/storage/unusual_devs.h                |  12 +++
 drivers/vfio/vfio_iommu_type1.c                   |   2 +-
 fs/btrfs/ctree.c                                  |  16 +--
 fs/btrfs/qgroup.c                                 |  14 ++-
 fs/btrfs/volumes.c                                |  39 ++++---
 fs/btrfs/xattr.c                                  |   8 ++
 fs/cifs/file.c                                    |   8 +-
 fs/cifs/misc.c                                    |  34 +++---
 fs/cifs/smb2file.c                                |   4 +-
 fs/cifs/smb2pdu.c                                 |   8 +-
 fs/cifs/transport.c                               |  63 +++++++----
 fs/ext4/fsync.c                                   |  16 ++-
 fs/ext4/inline.c                                  |   6 +-
 fs/ext4/inode.c                                   |   5 +-
 fs/ext4/super.c                                   |   2 +-
 include/linux/compiler-gcc.h                      |   2 +-
 include/linux/module.h                            |   2 +-
 include/linux/pm_opp.h                            |   5 +
 include/linux/sunrpc/svc.h                        |   5 +-
 include/trace/events/sunrpc.h                     |   6 +-
 kernel/fork.c                                     |   1 +
 mm/memory.c                                       |  23 ++++
 mm/slab.c                                         |   6 +-
 mm/usercopy.c                                     |   9 +-
 mm/util.c                                         |   2 +-
 net/sunrpc/svc.c                                  |  11 +-
 net/sunrpc/svc_xprt.c                             |   5 +-
 net/sunrpc/svcsock.c                              |   2 +-
 scripts/mod/modpost.c                             |   2 +-
 sound/pci/hda/patch_realtek.c                     |  18 +++-
 59 files changed, 578 insertions(+), 251 deletions(-)



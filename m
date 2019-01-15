Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A72C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE1820645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571271;
	bh=lq6lYr3FjEThMEfbFnTESYExqBjbdo6+qg8i+TP/Q5w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q7QtlSzvjD5X4euI6y9qlp30tfjyBzohZlirhjwVfJv6N0EcczgfEuR2/+ncJ9Wf5
	 MX5+rDvTQ/VBL0PKFst1Hh2dn0MO5XD5XBp4q4qkkIDe0FtTbYAav3WYd2Nqo4CYaY
	 kIKWkK5edjXRnE+Bylc9VPNsMokCNHtenUwy8Oa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbfAOQm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733076AbfAOQmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 321B62054F;
        Tue, 15 Jan 2019 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570569;
        bh=lq6lYr3FjEThMEfbFnTESYExqBjbdo6+qg8i+TP/Q5w=;
        h=From:To:Cc:Subject:Date:From;
        b=J7nrVXZdduQPNs2QxzaoSK3J6txu4p9DwiEk1zj9XdnABa5QtQikdENEZ9eIWA6yz
         ijKUVXcTSsx76+FugYG5kMROSNVzjg0j9NcKwTR0BZICGs9WpmFTYBW0x3eF0Q4fVc
         RegGKIPPz8LIj98EKBHNjNZOkfVsoiHFBZstr5C8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/50] 4.19.16-stable review
Date:   Tue, 15 Jan 2019 17:35:36 +0100
Message-Id: <20190115154909.933241945@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.16-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.16-rc1
X-KernelTest-Deadline: 2019-01-17T15:49+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.16 release.
There are 50 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jan 17 15:48:36 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.16-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.16-rc1

Filipe Manana <fdmanana@suse.com>
    Btrfs: use nofs context when initializing security xattrs to avoid deadlock

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix deadlock when enabling quotas due to concurrent snapshot creation

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix access to available allocation bits when starting balance

Will Deacon <will.deacon@arm.com>
    arm64: compat: Don't pull syscall number from regs in arm_compat_syscall

Christoffer Dall <christoffer.dall@arm.com>
    KVM: arm/arm64: Fix VMID alloc race by reverting to lock-less

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

Neil Armstrong <narmstrong@baylibre.com>
    drm/fb_helper: Allow leaking fbdev smem_start

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

Jack Stocker <jackstocker.93@gmail.com>
    USB: Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB

Icenowy Zheng <icenowy@aosc.io>
    USB: storage: add quirk for SMI SM3350

Icenowy Zheng <icenowy@aosc.io>
    USB: storage: don't insert sane sense for SPC3+ when bad sense specified

Daniele Palmas <dnlplm@gmail.com>
    usb: cdc-acm: send ZLP for Telit 3G Intel based modems

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

Larry Finger <Larry.Finger@lwfinger.net>
    staging: rtl8188eu: Fix module loading from tasklet for WEP encryption

Larry Finger <Larry.Finger@lwfinger.net>
    staging: rtl8188eu: Fix module loading from tasklet for CCMP encryption

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix deadlock when using free space tree due to block group creation


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/arm64/kernel/sys_compat.c                    |   9 +-
 arch/arm64/kernel/syscall.c                       |   9 +-
 arch/x86/kernel/cpu/bugs.c                        |   2 +-
 drivers/acpi/arm64/iort.c                         |   3 +-
 drivers/acpi/pmic/intel_pmic_xpower.c             |  41 ++++--
 drivers/acpi/power.c                              |  22 ++++
 drivers/block/rbd.c                               |   9 +-
 drivers/cpufreq/scmi-cpufreq.c                    |   4 +-
 drivers/gpu/drm/Kconfig                           |  20 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |   1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 ++++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c     |   4 +-
 drivers/gpu/drm/drm_fb_helper.c                   | 151 ++++++++++++++--------
 drivers/gpu/drm/i915/i915_gem_gtt.c               |  15 ++-
 drivers/i2c/i2c-dev.c                             |   6 +
 drivers/mtd/nand/raw/qcom_nandc.c                 |  20 +--
 drivers/pci/controller/dwc/pcie-designware-host.c |  37 ++++--
 drivers/staging/rtl8188eu/core/rtw_security.c     |   6 +-
 drivers/usb/class/cdc-acm.c                       |   7 +
 drivers/usb/core/quirks.c                         |   3 +-
 drivers/usb/storage/scsiglue.c                    |   8 +-
 drivers/usb/storage/unusual_devs.h                |  12 ++
 drivers/vfio/vfio_iommu_type1.c                   |   2 +-
 fs/btrfs/ctree.c                                  |  16 ++-
 fs/btrfs/qgroup.c                                 |  14 +-
 fs/btrfs/volumes.c                                |  39 +++---
 fs/btrfs/xattr.c                                  |   8 ++
 fs/cifs/file.c                                    |   8 +-
 fs/cifs/smb2file.c                                |   4 +-
 fs/cifs/smb2pdu.c                                 |   8 +-
 fs/cifs/transport.c                               |  63 ++++++---
 fs/ext4/fsync.c                                   |  16 ++-
 fs/ext4/inline.c                                  |   6 +-
 fs/ext4/inode.c                                   |   5 +-
 fs/ext4/super.c                                   |   2 +-
 include/linux/compiler-gcc.h                      |   2 +-
 include/linux/module.h                            |   2 +-
 include/linux/sunrpc/svc.h                        |   5 +-
 include/trace/events/sunrpc.h                     |   6 +-
 mm/memory.c                                       |  23 ++++
 mm/slab.c                                         |   6 +-
 mm/usercopy.c                                     |   9 +-
 mm/util.c                                         |   2 +-
 net/sunrpc/svc.c                                  |  11 +-
 net/sunrpc/svc_xprt.c                             |   5 +-
 net/sunrpc/svcsock.c                              |   2 +-
 scripts/mod/modpost.c                             |   2 +-
 sound/pci/hda/patch_realtek.c                     |  18 ++-
 virt/kvm/arm/arm.c                                |  23 ++--
 50 files changed, 509 insertions(+), 228 deletions(-)



Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15189C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D993C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570413;
	bh=mDsr5zQUp4etJcd230i/An4WSZz1y4QLESs+STYgi0o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Qzhc8XQBFpg/7Nrg3izENzcYO9Vc0o5PwSeTenIb05OJ65A4NnG4nJVwoXSAuf3/t
	 yJ4qXzCmE/D55FkNjr+JMUBFQRDSnqCDDFm3j1/vLqE3gMVfs4USIlkpD6NzZz3xL9
	 5BI5bK/4g1nKEEeFmw5UHmLpNwggxYc+zbSW4d0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbfAOQkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732470AbfAOQkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:40:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C072B20873;
        Tue, 15 Jan 2019 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570407;
        bh=mDsr5zQUp4etJcd230i/An4WSZz1y4QLESs+STYgi0o=;
        h=From:To:Cc:Subject:Date:From;
        b=pDqiz3jGxht8BY1XI9pFra0qyHL50NcMlBFBVPPR9/NDVJYK2uTX393ZDxrD5R9r3
         UuiVXMCcLLoyY8ypoyTPtVQ1ouDconkXGO+tp2RUC1r0pED2dWiwwq0U8wGo7N2e25
         +h8HaZ/8qLbdWtG4pKgSxAyMssQJ6pnmgrJ5hC68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/27] 4.14.94-stable review
Date:   Tue, 15 Jan 2019 17:35:49 +0100
Message-Id: <20190115154901.189747728@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.94-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.94-rc1
X-KernelTest-Deadline: 2019-01-17T15:49+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.94 release.
There are 27 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jan 17 15:48:28 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.94-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.94-rc1

Christoffer Dall <christoffer.dall@arm.com>
    KVM: arm/arm64: Fix VMID alloc race by reverting to lock-less

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use-after-free in svc_process_common()

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

Ivan Mironov <mironov.ivan@gmail.com>
    drm/fb-helper: Partially bring back workaround for bugs of SDL 1.2

Yi Zeng <yizeng@asrmicro.com>
    i2c: dev: prevent adapter retries and timeout being set as minus value

Hans de Goede <hdegoede@redhat.com>
    ACPI / PMIC: xpower: Fix TS-pin current-source handling

Hans de Goede <hdegoede@redhat.com>
    ACPI: power: Skip duplicate power resource references in _PRx

Michal Hocko <mhocko@suse.com>
    mm, memcg: fix reclaim deadlock with writeback

Jan Stancek <jstancek@redhat.com>
    mm: page_mapped: don't assume compound page is huge or THP

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
    CIFS: Do not hide EINTR after sending network packets

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

Rik van Riel <riel@redhat.com>
    x86,kvm: move qemu/guest FPU switching out to vcpu_run


-------------

Diffstat:

 Makefile                              |   4 +-
 arch/x86/include/asm/kvm_host.h       |  13 ++++
 arch/x86/kernel/cpu/bugs.c            |   2 +-
 arch/x86/kvm/x86.c                    |  34 ++++-----
 drivers/acpi/pmic/intel_pmic_xpower.c |  41 ++++++++---
 drivers/acpi/power.c                  |  22 ++++++
 drivers/block/rbd.c                   |   9 ++-
 drivers/gpu/drm/drm_fb_helper.c       | 126 ++++++++++++++++++++--------------
 drivers/i2c/i2c-dev.c                 |   6 ++
 drivers/usb/class/cdc-acm.c           |   7 ++
 drivers/usb/core/quirks.c             |   3 +-
 drivers/usb/storage/scsiglue.c        |   8 ++-
 drivers/usb/storage/unusual_devs.h    |  12 ++++
 fs/cifs/file.c                        |   8 +--
 fs/cifs/smb2file.c                    |   4 +-
 fs/cifs/smb2pdu.c                     |   8 ++-
 fs/cifs/transport.c                   |   2 +-
 fs/ext4/fsync.c                       |  16 +++--
 fs/ext4/inline.c                      |   6 +-
 fs/ext4/inode.c                       |   3 +-
 fs/ext4/super.c                       |   2 +-
 include/linux/compiler-gcc.h          |   2 +-
 include/linux/kvm_host.h              |   2 +-
 include/linux/module.h                |   2 +-
 include/linux/sunrpc/svc.h            |   5 +-
 mm/memory.c                           |  23 +++++++
 mm/slab.c                             |   6 +-
 mm/util.c                             |   2 +-
 net/sunrpc/svc.c                      |  11 +--
 net/sunrpc/svc_xprt.c                 |   5 +-
 net/sunrpc/svcsock.c                  |   2 +-
 scripts/mod/modpost.c                 |   2 +-
 sound/pci/hda/patch_realtek.c         |  18 ++++-
 virt/kvm/arm/arm.c                    |  23 +++----
 34 files changed, 300 insertions(+), 139 deletions(-)



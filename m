Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C284EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9397F20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571524;
	bh=MG7W5Ej1l9mqeNMzyvyJGnaERKSiJeApayrklRBHh/E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=S6S7K+48v5VmJy+qDQZ9+Q/sG3cjyhauZgY6xrQDAv3Q8eDerXZ/GKGG7o0KgO4Tv
	 RMRCuUEsvC8wIxPVbdpx7PQCENOJkGWJ4WBydIv+0bqdiWVFpwbjaMCIuQiSaEEAhp
	 ePAp372icLv395WXo5eBskgw7mlj+IAtoNEhc2RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbfAOQ6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:58:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732499AbfAOQj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:39:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FF02054F;
        Tue, 15 Jan 2019 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570395;
        bh=MG7W5Ej1l9mqeNMzyvyJGnaERKSiJeApayrklRBHh/E=;
        h=From:To:Cc:Subject:Date:From;
        b=DSr5ypLIkuRkTU7gQ9vINmncpJceNhdwBGbKkpoGI51Z48BWUMmfeF72vqKUDHdGx
         sgmdSMzZ15z/47eRiWEkPeg5JYWhIm7h4GXfNV2o8ftDDq18r0va76exvMx2HRsBJa
         0p66YIYFzDTGSG83DEJgnV4usSvLXA5dzGC8uxQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/16] 4.9.151-stable review
Date:   Tue, 15 Jan 2019 17:35:43 +0100
Message-Id: <20190115154848.164648613@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.151-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.151-rc1
X-KernelTest-Deadline: 2019-01-17T15:48+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.151 release.
There are 16 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jan 17 15:48:25 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.151-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.151-rc1

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use-after-free in svc_process_common()

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid kernel warning when writing the superblock to a dead device

Theodore Ts'o <tytso@mit.edu>
    ext4: fix a potential fiemap/page fault deadlock w/ inline_data

Theodore Ts'o <tytso@mit.edu>
    ext4: make sure enough credits are reserved for dioread_nolock writes

Ilya Dryomov <idryomov@gmail.com>
    rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set

Yi Zeng <yizeng@asrmicro.com>
    i2c: dev: prevent adapter retries and timeout being set as minus value

Hans de Goede <hdegoede@redhat.com>
    ACPI: power: Skip duplicate power resource references in _PRx

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

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Disable headset Mic VREF for headset mode of ALC225


-------------

Diffstat:

 Makefile                           |  4 ++--
 drivers/acpi/power.c               | 22 ++++++++++++++++++++++
 drivers/block/rbd.c                |  9 ++++-----
 drivers/i2c/i2c-dev.c              |  6 ++++++
 drivers/usb/class/cdc-acm.c        |  7 +++++++
 drivers/usb/core/quirks.c          |  3 ++-
 drivers/usb/storage/scsiglue.c     |  8 ++++++--
 drivers/usb/storage/unusual_devs.h | 12 ++++++++++++
 fs/cifs/file.c                     |  8 ++++----
 fs/cifs/smb2file.c                 |  4 ++--
 fs/cifs/transport.c                |  2 +-
 fs/ext4/inline.c                   |  6 +++---
 fs/ext4/inode.c                    |  3 ++-
 fs/ext4/super.c                    |  2 +-
 include/linux/sunrpc/svc.h         |  5 ++++-
 mm/slab.c                          |  6 ++++--
 mm/util.c                          |  2 +-
 net/sunrpc/svc.c                   |  9 ++++++---
 net/sunrpc/svc_xprt.c              |  5 +++--
 net/sunrpc/svcsock.c               |  2 +-
 sound/pci/hda/patch_realtek.c      | 16 +++++++++++++++-
 21 files changed, 108 insertions(+), 33 deletions(-)



Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC4220883
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570251;
	bh=X4b7TUo2EF+b/p6bwsQdCmbSI6BmlFMsl0juTgLlJJQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SRUQugHwV0M8qBqABRxHs3IRpTfi1r+Fyuuv+7HhMYsbNtQaGE264AK+UBNw870/p
	 XKVUARr90bGp4uN1O1QDnDvRRAgWVGLzJtoz2u87bw/laalF3bq9bdmnAoC4l1rM53
	 yXC25CYFeS+l3s6Vqj8AkOuDTOWa87lpaBqzDaFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbfAOQh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731839AbfAOQh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73DF020896;
        Tue, 15 Jan 2019 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570246;
        bh=X4b7TUo2EF+b/p6bwsQdCmbSI6BmlFMsl0juTgLlJJQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Co0s08jWCKNtOHTFfv335YbQNdojbRvMpjLT1wHvMejLsfUrwmJ6vcOjA+C6DxOZc
         RtOWbyeMcmIyG1Zs3sQ+FXm3ux+LE93k9hFN6MhkYhzURFEn8woBMG38hdE2ZbQeXE
         RiEwfhi2Xl2LFxzan2dpV/W22NTAYDxkb0HcHvI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/51] 4.4.171-stable review
Date:   Tue, 15 Jan 2019 17:34:56 +0100
Message-Id: <20190115154846.928796000@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.171-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.171-rc1
X-KernelTest-Deadline: 2019-01-17T15:48+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.171 release.
There are 51 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jan 17 15:48:21 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.171-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.171-rc1

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use-after-free in svc_process_common()

Theodore Ts'o <tytso@mit.edu>
    ext4: fix a potential fiemap/page fault deadlock w/ inline_data

Eric Biggers <ebiggers@google.com>
    crypto: cts - fix crash on short inputs

Yi Zeng <yizeng@asrmicro.com>
    i2c: dev: prevent adapter retries and timeout being set as minus value

Hans de Goede <hdegoede@redhat.com>
    ACPI: power: Skip duplicate power resource references in _PRx

Ley Foon Tan <lftan@altera.com>
    PCI: altera: Move retrain from fixup to altera_pcie_host_init()

Ley Foon Tan <lftan@altera.com>
    PCI: altera: Rework config accessors for use without a struct pci_bus

Ley Foon Tan <lftan@altera.com>
    PCI: altera: Poll for link training status after retraining the link

Ley Foon Tan <lftan@altera.com>
    PCI: altera: Poll for link up status after retraining the link

Ley Foon Tan <lftan@altera.com>
    PCI: altera: Check link status before retrain link

Bjorn Helgaas <bhelgaas@google.com>
    PCI: altera: Reorder read/write functions

Ley Foon Tan <lftan@altera.com>
    PCI: altera: Fix altera_pcie_link_is_up()

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

Shaokun Zhang <zhangshaokun@hisilicon.com>
    btrfs: tree-checker: Fix misleading group system information

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Check level for leaves and nodes

Qu Wenruo <wqu@suse.com>
    btrfs: Verify that every chunk has corresponding block group at mount time

Qu Wenruo <wqu@suse.com>
    btrfs: Check that each block group has corresponding chunk at mount time

Gu Jinxiang <gujx@cn.fujitsu.com>
    btrfs: validate type when reading a chunk

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Detect invalid and empty essential trees

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Verify block_group_item

David Sterba <dsterba@suse.com>
    btrfs: tree-check: reduce stack consumption in check_dir_item

Arnd Bergmann <arnd@arndb.de>
    btrfs: tree-checker: use %zu format string for size_t

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Add checker for dir item

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Fix false panic for sanity test

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: tree-checker: Enhance btrfs_check_node output

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: Move leaf and node validation checker to tree-checker.c

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: Add checker for EXTENT_CSUM

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: Add sanity check for EXTENT_DATA when reading out leaf

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: Check if item pointer overlaps with the item itself

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: Refactor check_leaf function for later expansion

Jeff Mahoney <jeffm@suse.com>
    btrfs: struct-funcs, constify readers

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix emptiness check for dirtied extent buffers at check_leaf()

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: memset to avoid stale content in btree leaf

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: kill BUG_ON in run_delayed_tree_ref

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: improve check_node to avoid reading corrupted nodes

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: memset to avoid stale content in btree node block

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix BUG_ON in btrfs_mark_buffer_dirty

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: check btree node's nritems

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: detect corruption when non-root leaf has zero item

Josef Bacik <jbacik@fb.com>
    Btrfs: fix em leak in find_first_block_group

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: check inconsistence between chunk and block group

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: add validadtion checks for chunk loading

Qu Wenruo <quwenruo@cn.fujitsu.com>
    btrfs: Enhance chunk validation check

Jeff Mahoney <jeffm@suse.com>
    btrfs: cleanup, stop casting for extent_map->lookup everywhere

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Disable headset Mic VREF for headset mode of ALC225


-------------

Diffstat:

 Makefile                           |   4 +-
 crypto/cts.c                       |   8 +-
 drivers/acpi/power.c               |  22 ++
 drivers/i2c/i2c-dev.c              |   6 +
 drivers/pci/host/pcie-altera.c     | 201 +++++++++---
 drivers/usb/class/cdc-acm.c        |   7 +
 drivers/usb/core/quirks.c          |   3 +-
 drivers/usb/storage/scsiglue.c     |   8 +-
 drivers/usb/storage/unusual_devs.h |  12 +
 fs/btrfs/Makefile                  |   2 +-
 fs/btrfs/ctree.c                   |  14 -
 fs/btrfs/ctree.h                   | 141 ++++----
 fs/btrfs/dev-replace.c             |   2 +-
 fs/btrfs/disk-io.c                 |  80 +----
 fs/btrfs/extent-tree.c             | 112 ++++++-
 fs/btrfs/extent_io.c               |  43 ++-
 fs/btrfs/extent_io.h               |  19 +-
 fs/btrfs/extent_map.c              |   2 +-
 fs/btrfs/extent_map.h              |  10 +-
 fs/btrfs/scrub.c                   |   2 +-
 fs/btrfs/struct-funcs.c            |   9 +-
 fs/btrfs/tree-checker.c            | 649 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-checker.h            |  38 +++
 fs/btrfs/volumes.c                 | 139 +++++++-
 fs/btrfs/volumes.h                 |   2 +
 fs/cifs/file.c                     |   8 +-
 fs/cifs/smb2file.c                 |   4 +-
 fs/cifs/transport.c                |   2 +-
 fs/ext4/inline.c                   |   6 +-
 include/linux/sunrpc/svc.h         |   5 +-
 mm/slab.c                          |   6 +-
 net/sunrpc/svc.c                   |  10 +-
 net/sunrpc/svc_xprt.c              |   5 +-
 net/sunrpc/svcsock.c               |   2 +-
 sound/pci/hda/patch_realtek.c      |  16 +-
 35 files changed, 1324 insertions(+), 275 deletions(-)



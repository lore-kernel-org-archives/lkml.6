Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46B6C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0341218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548419004;
	bh=mH8oagmJGIWGOeU/a8ZIv6XmzNtu01oXtOZxjVpSF0E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vedb2ubpORbP3WuF4tqDEEUTfbiU7n2SMwRKyywdjWFcSdsok7dHdWpkib5049MKT
	 1YasMvvfcsW1zZYMy1QO3DVlexaQJBvJJEEDuLj6NU+Xa4JewPCbBrZmW4785reHpc
	 JsvJ/2CsbZeksKL/ZAxJjNrxi2dZZLzvDW+YvoIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfAYMXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAYMXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:23:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CED6218D9;
        Fri, 25 Jan 2019 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548419001;
        bh=mH8oagmJGIWGOeU/a8ZIv6XmzNtu01oXtOZxjVpSF0E=;
        h=Date:From:To:Cc:Subject:From;
        b=Uo2qfbR8ql+bA2rT5dtpih5a8hJS+fzJyPfaoNuUKqRlpiIdReQW4u73YLqi+RY4Q
         v9CepIbpLqUVgstIVc8bnHJV8+akFn9wyhu/dZn71mwx3wjY+c23CaDkPVxnB0U5Ch
         PlP8j+hMwAQHnrkFoqZeWKfUsMeoD/i5z6l9CjL4=
Date:   Fri, 25 Jan 2019 13:23:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.0-rc4
Message-ID: <20190125122319.GA7685@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.0-rc4

for you to fetch changes up to 52768f324241b2d9624d32787cff63ec3e0e420a:

  i3c: master: Fix an error checking typo in 'cdns_i3c_master_probe()' (2019-01-22 13:56:37 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.0-rc4

Here are some small char and misc driver fixes to resolve some reported
issues, as well as a number of binderfs fixups that were found after
auditing the filesystem code by Al Viro.  As binderfs hasn't been in a
previous release yet, it's good to get these in now before the first
users show up.

All of these have been in linux-next for a bit with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: me: mark LBG devices as having dma support

Anders Roxell (1):
      misc: pvpanic: fix warning implicit declaration

Christian Brauner (15):
      binderfs: remove wrong kern_mount() call
      binderfs: make each binderfs mount a new instance
      binderfs: implement "max" mount option
      binderfs: rename header to binderfs.h
      binderfs: reserve devices for initial mount
      binderfs: handle !CONFIG_IPC_NS builds
      binderfs: use correct include guards in header
      binderfs: use __u32 for device numbers
      binderfs: remove outdated comment
      binderfs: prevent renaming the control dentry
      binderfs: rework binderfs_fill_super()
      binderfs: rework binderfs_binder_device_create()
      binderfs: kill_litter_super() before cleanup
      binderfs: drop lock in binderfs_binder_ctl_create
      binderfs: switch from d_add() to d_instantiate()

Christophe JAILLET (1):
      i3c: master: Fix an error checking typo in 'cdns_i3c_master_probe()'

Dexuan Cui (2):
      Drivers: hv: vmbus: Check for ring when getting debug info
      vmbus: fix subchannel removal

Greg Kroah-Hartman (1):
      Merge tag 'hyperv-fixes-signed' of git://git.kernel.org/.../hyperv/linux into char-misc-linus

Gustavo A. R. Silva (2):
      misc: ibmvsm: Fix potential NULL pointer dereference
      char/mwave: fix potential Spectre v1 vulnerability

Tomas Winkler (2):
      mei: dma: silent the reject message
      mei: me: add denverton innovation engine device IDs

Vitaly Kuznetsov (1):
      hv_balloon: avoid touching uninitialized struct page during tail onlining

Wei Yongjun (1):
      binderfs: fix error return code in binderfs_fill_super()

 drivers/android/binderfs.c                         | 282 +++++++++++----------
 drivers/char/mwave/mwavedd.c                       |   7 +
 drivers/hv/channel.c                               |   9 +-
 drivers/hv/hv_balloon.c                            |  10 +-
 drivers/hv/ring_buffer.c                           |  31 ++-
 drivers/hv/vmbus_drv.c                             |  91 ++++---
 drivers/i3c/master/i3c-master-cdns.c               |   4 +-
 drivers/misc/ibmvmc.c                              |   7 +-
 drivers/misc/mei/hbm.c                             |  12 +-
 drivers/misc/mei/hw-me-regs.h                      |   2 +
 drivers/misc/mei/pci-me.c                          |   4 +-
 drivers/misc/pvpanic.c                             |   4 +
 include/linux/hyperv.h                             |   5 +-
 .../linux/android/{binder_ctl.h => binderfs.h}     |  10 +-
 14 files changed, 274 insertions(+), 204 deletions(-)
 rename include/uapi/linux/android/{binder_ctl.h => binderfs.h} (83%)

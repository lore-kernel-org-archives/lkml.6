Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52463C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227BE21917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549615167;
	bh=DTt2npbO0CIjek8aebxYmgsGTzaWbEIeoB7IHYg1S1w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0ZdscdiFAKC727KzEvs4EsJI7mUCwHfltT1tO7aHhvCtkGNwxXXztCCIXta9h+nrJ
	 JaOUoNyy3VIQDpyVEH+T/z0PbtHRwEtvDq8c6/SvBODe8k63JimwNkTZlAi0ap/3vR
	 TwIfVjdS7bgpHM3jgIi41rlCqUBoij/7ctvF0y1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfBHIjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:39:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBHIjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:39:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E6B21917;
        Fri,  8 Feb 2019 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549615163;
        bh=DTt2npbO0CIjek8aebxYmgsGTzaWbEIeoB7IHYg1S1w=;
        h=Date:From:To:Cc:Subject:From;
        b=CYqeRFm+GKXw4/QwfKgMz/D5X+1SooypBXau829mR8HgE6qHfSZqfzCpm5FKF+upJ
         DoIFigocH66rKjRM9CyKz+w77rsqL7yu06AwT4TmOdvVKD+QGCLofII39TVTlcpl5j
         Vd03R4mfnJRtigYGWVyqTuhkl0u/2EGvwdf2Ewu8=
Date:   Fri, 8 Feb 2019 09:39:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.0-rc6
Message-ID: <20190208083921.GA27053@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.0-rc6

for you to fetch changes up to 4bf13fdbc3567e571c20b415e4df70f564d54067:

  mic: vop: Fix crash on remove (2019-02-01 15:53:54 +0100)

----------------------------------------------------------------
Char/Misc fixes for 5.0-rc6

Here are some small char and misc driver fixes for 5.0-rc6.

Nothing huge here, some more binderfs fixups found as people use it, and
there is a "large" selftest added to validate the binderfs code, which
makes up the majority of this pull request.

There's also some small mei and mic fixes to resolve some reported
issues.

All of these have been in linux-next for over a week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: free read cb on ctrl_wr list flush

Christian Brauner (4):
      selftests: add binderfs selftests
      binder: fix CONFIG_ANDROID_BINDER_DEVICES
      binderfs: respect limit on binder control creation
      binderfs: remove separate device_initcall()

Nicolas Saenz Julienne (1):
      fpga: stratix10-soc: fix wrong of_node_put() in init function

Tomas Winkler (2):
      mei: me: add ice lake point device id.
      samples: mei: use /dev/mei0 instead of /dev/mei

Vincent Whitchurch (3):
      mic: vop: Fix broken virtqueues
      mic: vop: Fix use-after-free on remove
      mic: vop: Fix crash on remove

 drivers/android/binder.c                           |  37 +--
 drivers/android/binder_internal.h                  |   9 +
 drivers/android/binderfs.c                         |  14 +-
 drivers/fpga/stratix10-soc.c                       |   5 +-
 drivers/misc/mei/client.c                          |   5 +-
 drivers/misc/mei/hw-me-regs.h                      |   2 +
 drivers/misc/mei/pci-me.c                          |   2 +
 drivers/misc/mic/vop/vop_main.c                    |  73 +++---
 samples/mei/mei-amt-version.c                      |   2 +-
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/binderfs/.gitignore      |   1 +
 .../selftests/filesystems/binderfs/Makefile        |   6 +
 .../selftests/filesystems/binderfs/binderfs_test.c | 275 +++++++++++++++++++++
 .../testing/selftests/filesystems/binderfs/config  |   3 +
 14 files changed, 380 insertions(+), 55 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/binderfs/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/binderfs/Makefile
 create mode 100644 tools/testing/selftests/filesystems/binderfs/binderfs_test.c
 create mode 100644 tools/testing/selftests/filesystems/binderfs/config

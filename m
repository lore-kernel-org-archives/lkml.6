Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034233AbeEXSQo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:16:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:58001 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970236AbeEXSQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:16:37 -0400
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 4.17-rc6
Date: Thu, 24 May 2018 20:13:50 +0200
Message-Id: <cover.1527183902.git.dsterba@suse.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider pulling a fix for btrfs. This time it's really a
one-liner and prevents leaking an internal error value 1 out of the
ftruncate syscall.

This has been observed in practice. The steps to reproduce make a common
pattern (open/write/fync/ftruncate) but also need the application to not
check only for negative values and happens only for compressed inlined
files. The conditions are narrow but as this could break userspace I
think it's better to merge it now and not wait for the merge window.
Thanks.

----------------------------------------------------------------
The following changes since commit 02ee654d3a04563c67bfe658a05384548b9bb105:

  btrfs: fix crash when trying to resume balance without the resume flag (2018-05-17 14:38:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-4.17-rc6-tag

for you to fetch changes up to d50147381aa0c9725d63a677c138c47f55d6d3bc:

  Btrfs: fix error handling in btrfs_truncate() (2018-05-24 11:56:57 +0200)

----------------------------------------------------------------
Omar Sandoval (1):
      Btrfs: fix error handling in btrfs_truncate()

 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

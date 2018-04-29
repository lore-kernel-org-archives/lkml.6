Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeD2C5x (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 22:57:53 -0400
Received: from imap.thunk.org ([74.207.234.97]:42258 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbeD2C5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 22:57:51 -0400
Date: Sat, 28 Apr 2018 22:57:48 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: torvalds@linux-foundation.org
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 4.17-rc3
Message-ID: <20180429025748.GA9046@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e40ff213898502d299351cc2fe1e350cd186f0d3:

  ext4: force revalidation of directory pointer after seekdir(2) (2018-04-01 23:21:03 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/for_linus_stable

for you to fetch changes up to 7ef79ad52136712172eb0525bf0b462516bf2f93:

  ext4: add MODULE_SOFTDEP to ensure crc32c is included in the initramfs (2018-04-26 00:44:46 -0400)

----------------------------------------------------------------
Fix misc. bugs and a regression for ext4.

----------------------------------------------------------------
Eric Biggers (1):
      ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS

Lukas Czerner (1):
      ext4: fix bitmap position validation

Theodore Ts'o (2):
      ext4: set h_journal if there is a failure starting a reserved handle
      ext4: add MODULE_SOFTDEP to ensure crc32c is included in the initramfs

 fs/ext4/balloc.c      |  9 +++++----
 fs/ext4/extents.c     | 16 +++++++++++-----
 fs/ext4/super.c       |  1 +
 fs/jbd2/transaction.c |  1 +
 4 files changed, 18 insertions(+), 9 deletions(-)

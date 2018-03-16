Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCPONI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:13:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60681 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbeCPONH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:13:07 -0400
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 4.16-rc6
Date: Fri, 16 Mar 2018 15:10:37 +0100
Message-Id: <cover.1521208695.git.dsterba@suse.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's an important revert in this pull request that needs to go to
stable as it causes a corruption on big endian machines. The other fix
is for FIEMAP incorrectly reporting shared extents before a sync and one
fix for a crash in raid56.

So far we got only one report about the BE corruption, the stable
kernels were out for like a week, so hopefully the scope of the damage
is low.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 1f250e929a9c9332fd6ea34da684afee73837cfe:

  Btrfs: fix log replay failure after unlink and link combination (2018-03-01 16:18:40 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-4.16-rc5-tag

for you to fetch changes up to 093e037ca88e1767693bc6bcb2df3f49c6be68c7:

  Revert "btrfs: use proper endianness accessors for super_copy" (2018-03-16 14:49:44 +0100)

----------------------------------------------------------------
David Sterba (1):
      Revert "btrfs: use proper endianness accessors for super_copy"

Dmitriy Gorokh (1):
      btrfs: Fix NULL pointer exception in find_bio_stripe

Edmund Nadolski (1):
      btrfs: add missing initialization in btrfs_check_shared

 fs/btrfs/backref.c     |  1 +
 fs/btrfs/raid56.c      |  1 +
 fs/btrfs/sysfs.c       |  8 +++++---
 fs/btrfs/transaction.c | 20 ++++++++------------
 4 files changed, 15 insertions(+), 15 deletions(-)

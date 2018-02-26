Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeBZUFZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:05:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeBZUFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:05:23 -0500
Date: Mon, 26 Feb 2018 12:05:21 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, linux-kernel@vger.kernel.org,
        Chris Mi <chrism@mellanox.com>, netdev@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] Fixes for IDR
Message-ID: <20180226200521.GB24087@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

I have one test-suite build fix for you and one run-time regression fix.
The regression fix includes new tests to make sure they don't pop back up.

The following changes since commit 3664ce2d930983966d2aac0e167f1332988c4e25:

  Merge tag 'powerpc-4.16-4' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2018-02-24 16:05:50 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git idr-2018-02-06

for you to fetch changes up to 4b0ad07653ee94182e2d8f21404242c9e83ad0b4:

  idr: Fix handling of IDs above INT_MAX (2018-02-26 14:39:30 -0500)

----------------------------------------------------------------
Matthew Wilcox (2):
      radix tree test suite: Fix build
      idr: Fix handling of IDs above INT_MAX

 lib/idr.c                                       | 13 ++++---
 tools/testing/radix-tree/idr-test.c             | 52 +++++++++++++++++++++++++
 tools/testing/radix-tree/linux.c                | 11 +++++-
 tools/testing/radix-tree/linux/compiler_types.h |  0
 tools/testing/radix-tree/linux/gfp.h            |  1 +
 tools/testing/radix-tree/linux/slab.h           |  6 +++
 6 files changed, 75 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/radix-tree/linux/compiler_types.h

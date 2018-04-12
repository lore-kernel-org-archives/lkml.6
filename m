Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeDLPNk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:13:40 -0400
Received: from mail.windriver.com ([147.11.1.11]:45354 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754128AbeDLPNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:13:35 -0400
From: Jason Wessel <jason.wessel@windriver.com>
To: <torvalds@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <kgdb-bugreport@lists.sourceforge.net>
Subject: [GIT PULL] KGDB/KDB fixes for 4.16
Date: Thu, 12 Apr 2018 07:20:11 -0500
Message-ID: <1523535611-1149-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the kgdb tree.

Summary of changes:
   * Fix 2032 time access issues and new compiler warnings
   * minor regression test cleanup
   * formatting fixes for end user use of kdb

git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git tags/for_linus-4.16

Thanks,
Jason.

---
The following changes since commit 5b7d27967dabfb17c21b0d98b29153b9e3ee71e5:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-01-24 17:24:30 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git tags/for_linus-4.16

for you to fetch changes up to 2cf2f0d5b91fd1b06a6ae260462fc7945ea84add:

  kdb: use memmove instead of overlapping memcpy (2018-02-04 21:29:53 -0600)

----------------------------------------------------------------
   * Fix 2032 time access issues and new compiler warnings
   * minor regression test cleanup
   * formatting fixes for end user use of kdb

----------------------------------------------------------------
Arnd Bergmann (2):
      kdb: use __ktime_get_real_seconds instead of __current_kernel_time
      kdb: use memmove instead of overlapping memcpy

Baolin Wang (1):
      kdb: use ktime_get_mono_fast_ns() instead of ktime_get_ts()

Daniel Thompson (1):
      misc: kgdbts: Display progress of asynchronous tests

Randy Dunlap (3):
      kdb: make "mdr" command repeat
      kdb: drop newline in unknown command output
      kdb: bl: don't use tab character in output

 drivers/misc/kgdbts.c              |  8 +++-
 include/linux/timekeeping.h        |  1 +
 kernel/debug/kdb/kdb_bp.c          |  4 +-
 kernel/debug/kdb/kdb_main.c        | 89 +++++++++++++++++---------------------
 kernel/debug/kdb/kdb_support.c     |  4 +-
 kernel/time/timekeeping_internal.h |  2 -
 6 files changed, 51 insertions(+), 57 deletions(-)

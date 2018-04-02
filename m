Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeDBQ0e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:26:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35409 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbeDBQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:26:29 -0400
X-Google-Smtp-Source: AIpwx4/BdIINqZlPruJwniMEeEem+UkzyxkaNdH9VPWnpKekqGWqHmiFqY4NY0nQv9q/TF27Ae6SZg==
Date: Mon, 2 Apr 2018 09:26:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geliang Tang <geliangtang@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] pstore updates for v4.17-rc1
Message-ID: <20180402162626.GA27422@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore changes for v4.17-rc1. This cycle was almost
entirely improvements to the pstore compression options, noted below.

Thanks!

-Kees

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v4.17-rc1

for you to fetch changes up to 58eb5b6707477ff458db3ee522aac317da719e2a:

  pstore: fix crypto dependencies (2018-03-15 10:06:06 -0700)

----------------------------------------------------------------
- Add lz4hc and 842 to pstore compression options (Geliang Tang)
- Refactor to use crypto compression API (Geliang Tang)
- Fix up Kconfig dependencies for compression (Arnd Bergmann)
- Allow for run-time compression selection
- Remove stack VLA usage

----------------------------------------------------------------
Arnd Bergmann (1):
      pstore: fix crypto dependencies

Geliang Tang (2):
      pstore: Add lz4hc and 842 compression support
      pstore: Use crypto compress API

Kees Cook (3):
      pstore: Avoid size casts for 842 compression
      pstore: Select compression at runtime
      pstore/ram: Do not use stack VLA for parity workspace

 fs/pstore/Kconfig          | 101 +++++++++---
 fs/pstore/inode.c          |   2 +
 fs/pstore/internal.h       |   3 +
 fs/pstore/platform.c       | 372 +++++++++++++++------------------------------
 fs/pstore/ram.c            |   2 +-
 fs/pstore/ram_core.c       |  29 +++-
 include/linux/pstore_ram.h |   1 +
 7 files changed, 226 insertions(+), 284 deletions(-)

-- 
Kees Cook
Pixel Security

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeAaGNs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 01:13:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45630 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeAaGNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 01:13:46 -0500
Date: Wed, 31 Jan 2018 06:13:45 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] get_user_pages_fast() stuff
Message-ID: <20180131061345.GG29051@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	A bit more get_user_pages work.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.get_user_pages_fast

for you to fetch changes up to ce53053ce378c21e7ffc45241fd67d6ee79daa2b:

  kvm: switch get_user_page_nowait() to get_user_pages_unlocked() (2017-12-04 13:35:21 -0500)

----------------------------------------------------------------
Al Viro (5):
      fold __get_user_pages_unlocked() into its sole remaining caller
      cris: switch to get_user_pages_fast()
      get_user_pages_unlocked(): pass true to __get_user_pages_locked() notify_drop
      __get_user_pages_locked(): get rid of notify_drop argument
      kvm: switch get_user_page_nowait() to get_user_pages_unlocked()

 arch/cris/arch-v32/drivers/cryptocop.c | 23 ++++++-----------
 mm/gup.c                               | 46 +++++++++++-----------------------
 virt/kvm/kvm_main.c                    | 43 +++++++++----------------------
 3 files changed, 34 insertions(+), 78 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeFDN2V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753057AbeFDN2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:28:20 -0400
Message-ID: <242535dbd409c1183c6a28ec9462970d37df93a9.camel@kernel.org>
Subject: [GIT PULL] fasync fix for v4.18
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kirill Tkhai <ktkhai@virtuozzo.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Bruce Fields <bfields@fieldses.org>
Date: Mon, 04 Jun 2018 09:28:18 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fff75eb2a08c2ac96404a2d79685668f3cf5a7a3:

  Merge tag 'errseq-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux (2018-04-30 16:53:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v4.18-1

for you to fetch changes up to 7a107c0f55a3b4c6f84a4323df5610360bde1684:

  fasync: Fix deadlock between task-context and interrupt-context kill_fasync() (2018-05-01 07:39:50 -0400)

----------------------------------------------------------------

Just a single fix for a deadlock in the fasync handling code that Kirill
observed while testing. The fix is to change the fa_lock to be rwlock_t,
and use a read lock in kill_fasync_rcu.

----------------------------------------------------------------
Kirill Tkhai (1):
      fasync: Fix deadlock between task-context and interrupt-context kill_fasync()

 fs/fcntl.c         | 15 +++++++--------
 include/linux/fs.h |  2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

-- 
Jeff Layton <jlayton@kernel.org>

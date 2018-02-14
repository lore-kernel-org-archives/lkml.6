Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967332AbeBNLFe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:05:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967252AbeBNLFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:05:33 -0500
Date: Wed, 14 Feb 2018 03:04:11 -0800
From: tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-e5684bbfc3f03480d6ba2150f133630fb510d3eb@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, corbet@lwn.net, mingo@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, corbet@lwn.net, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180213185519.18186-2-juri.lelli@redhat.com>
References: <20180213185519.18186-2-juri.lelli@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] Documentation/locking/lockdep: Update info about
 states
Git-Commit-ID: e5684bbfc3f03480d6ba2150f133630fb510d3eb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e5684bbfc3f03480d6ba2150f133630fb510d3eb
Gitweb:     https://git.kernel.org/tip/e5684bbfc3f03480d6ba2150f133630fb510d3eb
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Tue, 13 Feb 2018 19:55:18 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 12:01:22 +0100

Documentation/locking/lockdep: Update info about states

Commit:

  d92a8cfcb37e ("locking/lockdep: Rework FS_RECLAIM annotation")

removed the 'reclaim_fs' lockdep STATE.

Reflect the change in the documentation.

While we are at it, also clarify the formula to calculate the number of state bits.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/20180213185519.18186-2-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/locking/lockdep-design.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 9de1c15..e341c2f 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -27,7 +27,8 @@ lock-class.
 State
 -----
 
-The validator tracks lock-class usage history into 4n + 1 separate state bits:
+The validator tracks lock-class usage history into 4 * nSTATEs + 1 separate
+state bits:
 
 - 'ever held in STATE context'
 - 'ever held as readlock in STATE context'
@@ -37,7 +38,6 @@ The validator tracks lock-class usage history into 4n + 1 separate state bits:
 Where STATE can be either one of (kernel/locking/lockdep_states.h)
  - hardirq
  - softirq
- - reclaim_fs
 
 - 'ever used'                                       [ == !unused        ]
 

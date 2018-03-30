Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeC3V2O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:28:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752571AbeC3V2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:28:12 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 0/3] locking/rwsem: Add DEBUG_RWSEMS & restructure lock debugging menu
Date: Fri, 30 Mar 2018 17:27:57 -0400
Message-Id: <1522445280-7767-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
 - Break patch 2 into 2 separate patches to make them easier to review.

v4:
 - Auto select DEBUG_RWSEMS & DEBUG_WW_MUTEX_SLOWPATH if PROVE_LOCKING
 - Modify patch 2 to do a restructuring of the lock debugging menu.

v3:
 - Add a new patch which adds a master LOCK_DEBUGGING option to turn
   on all lock debugging.

v2:
 - Fix typo in up_read_non_owner().

This patchset enhances lock debugging by adding rwsem lock/unlock
mismatches checking and restructure the lock debugging menu to make it
easier to select options that are likely to be most frequently used.

Waiman Long (3):
  locking/rwsem: Add DEBUG_RWSEMS to look for lock/unlock mismatches
  lib/Kconfig.debug: Add LOCK_DEBUGGING_SUPPORT to make it more readable
  lib/Kconfig.debug: Restructure the lock debugging menu

 kernel/locking/rwsem.c |   4 ++
 kernel/locking/rwsem.h |   8 ++-
 lib/Kconfig.debug      | 150 +++++++++++++++++++++++++++----------------------
 3 files changed, 93 insertions(+), 69 deletions(-)

-- 
1.8.3.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeC1OVf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:21:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750820AbeC1OVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:21:33 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/2] locking/rwsem: Add DEBUG_RWSEMS
Date: Wed, 28 Mar 2018 10:20:50 -0400
Message-Id: <1522246852-17501-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Waiman Long (2):
  locking/rwsem: Add DEBUG_RWSEMS to look for lock/unlock mismatches
  locking/debug: Restructure the lock debugging menu

 kernel/locking/rwsem.c |   4 ++
 kernel/locking/rwsem.h |   8 ++-
 lib/Kconfig.debug      | 150 +++++++++++++++++++++++++++----------------------
 3 files changed, 93 insertions(+), 69 deletions(-)

-- 
1.8.3.1

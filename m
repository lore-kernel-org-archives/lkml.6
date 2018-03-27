Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeC0Vio (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:38:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751114AbeC0Vin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:38:43 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/2] locking/debug: Add DEBUG_RWSEMS & LOCK_DEBUGGING
Date: Tue, 27 Mar 2018 17:38:08 -0400
Message-Id: <1522186690-10526-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
 - Add a new patch which adds a master LOCK_DEBUGGING option to turn
   on all lock debugging.

v2:
 - Fix typo in up_read_non_owner().

This patchset enhances lock debugging by adding rwsem lock/unlock
mismatches checking and a master config option to turn on all lock
debugging.

Waiman Long (2):
  locking/rwsem: Add DEBUG_RWSEMS to look for lock/unlock mismatches
  locking/debug: Add a master lock debugging switch

 kernel/locking/rwsem.c |  4 ++++
 kernel/locking/rwsem.h |  8 +++++++-
 lib/Kconfig.debug      | 39 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 45 insertions(+), 6 deletions(-)

-- 
1.8.3.1

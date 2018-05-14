Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeENTdq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:33:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751498AbeENTdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:33:44 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH v2 0/2] locking/rwsem: Fix DEBUG_RWSEM warning from thaw_sup
Date: Mon, 14 May 2018 15:31:05 -0400
Message-Id: <1526326267-22501-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My original patch (https://lkml.org/lkml/2018/4/4/447) to fix this isse 
probably won't work. This is my second attempt to fix it.

I don't have the setup to reproduce the problem. Could someone try it to see
if it can eliminate the warning?

Waiman Long (2):
  locking/rwsem: Add a new RWSEM_WRITER_OWNED_NOSPIN flag
  locking/percpu-rwsem: Mark rwsem as non-spinnable in
    percpu_rwsem_release()

 include/linux/percpu-rwsem.h |  6 +++---
 include/linux/rwsem.h        | 10 ++++++++++
 kernel/locking/rwsem-xadd.c  | 17 ++++++++---------
 kernel/locking/rwsem.c       | 16 +++++++++++++++-
 kernel/locking/rwsem.h       | 37 ++++++++++++++++++++++++++++++-------
 5 files changed, 66 insertions(+), 20 deletions(-)

-- 
1.8.3.1

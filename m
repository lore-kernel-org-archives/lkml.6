Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935356AbeBMNXA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:23:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57556 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935219AbeBMNW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:22:57 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/2] A couple of qspinlock fixes
Date: Tue, 13 Feb 2018 13:22:55 +0000
Message-Id: <1518528177-19169-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are a couple of fixes for qspinlock issues I've found by code
inspection whilst investigating the possibility of enabling this for
arm64. The first patch fixes a problem with unusual hardware re-ordering
whilst the second fixes a problem with unusual compiler re-ordering.

Cheers,

Will

--->8

Will Deacon (2):
  locking/qspinlock: Ensure node is initialised before updating
    prev->next
  locking/qspinlock: Ensure node->count is updated before initialising
    node

 kernel/locking/qspinlock.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

-- 
2.1.4

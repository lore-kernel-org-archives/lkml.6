Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965658AbeBMSzv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:55:51 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36704 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965584AbeBMSzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:55:44 -0500
X-Google-Smtp-Source: AH8x225foCLaQCxzNlzZTTMPm3gGixfxGcfPK6UwSO9DMI8Zbd55LbL+ExlfWYbQL3JMH473+ntpNA==
From: Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        juri.lelli@redhat.com
Subject: [PATCH 1/2] Documentation/locking/lockdep: update info about states
Date: Tue, 13 Feb 2018 19:55:18 +0100
Message-Id: <20180213185519.18186-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180213185519.18186-1-juri.lelli@redhat.com>
References: <20180213185519.18186-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d92a8cfcb37e ("locking/lockdep: Rework FS_RECLAIM annotation") removed
reclaim_fs lockdep STATE.

Reflect the change in documentation.

While we are at it, also clarify formula to calculate number of state
bits.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/locking/lockdep-design.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 9de1c158d44c..e341c2f34e68 100644
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
 
-- 
2.14.3

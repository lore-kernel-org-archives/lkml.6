Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbeBLBrX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:47:23 -0500
Received: from [198.137.202.136] ([198.137.202.136]:48971 "EHLO
        terminus.zytor.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbeBLBrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:47:20 -0500
Date: Sun, 11 Feb 2018 04:12:35 -0800
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-26be459c9c4431984ad4b576f975ce6d3184d71d@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, torvalds@linux-foundation.org,
        corbet@lwn.net, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: mathieu.desnoyers@efficios.com, torvalds@linux-foundation.org,
        peterz@infradead.org, corbet@lwn.net, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1518282058-24226-1-git-send-email-mathieu.desnoyers@efficios.com>
References: <1518282058-24226-1-git-send-email-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] Documentation/features: Allow comments in arch
 features files
Git-Commit-ID: 26be459c9c4431984ad4b576f975ce6d3184d71d
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

Commit-ID:  26be459c9c4431984ad4b576f975ce6d3184d71d
Gitweb:     https://git.kernel.org/tip/26be459c9c4431984ad4b576f975ce6d3184d71d
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Sat, 10 Feb 2018 12:00:58 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 12:18:50 +0100

Documentation/features: Allow comments in arch features files

The list-arch.sh script considers lines beginning with "#" as match for
the feature table.

Given that those tables are never in lines beginning with "#",
add a reverse grep on "^#" when matching the "ok/TODO" state of
the architecture.

This allows adding comments within the feature files, for instance
describing the architecture requirements for the feature in each
architecture.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/1518282058-24226-1-git-send-email-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/features/list-arch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/list-arch.sh b/Documentation/features/list-arch.sh
index c16b5b5..1ec47c3 100755
--- a/Documentation/features/list-arch.sh
+++ b/Documentation/features/list-arch.sh
@@ -17,7 +17,7 @@ for F in */*/arch-support.txt; do
   N=$(grep -h "^# Feature name:"        $F | cut -c25-)
   C=$(grep -h "^#         Kconfig:"     $F | cut -c25-)
   D=$(grep -h "^#         description:" $F | cut -c25-)
-  S=$(grep -hw $ARCH $F | cut -d\| -f3)
+  S=$(grep -hv "^#" $F | grep -w $ARCH | cut -d\| -f3)
 
   printf "%10s/%-22s:%s| %35s # %s\n" "$SUBSYS" "$N" "$S" "$C" "$D"
 done

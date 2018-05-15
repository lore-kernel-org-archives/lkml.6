Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeEOGWn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:22:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeEOGWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:22:42 -0400
Date: Mon, 14 May 2018 23:22:18 -0700
From: tip-bot for SeongJae Park <tipbot@zytor.com>
Message-ID: <tip-eabed716672c2f2275887ec69e001a9cc30b2294@git.kernel.org>
Cc: torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, paulmck@linux.vnet.ibm.com, sj38.park@gmail.com,
        akpm@linux-foundation.org, hpa@zytor.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, akpm@linux-foundation.org, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, sj38.park@gmail.com
In-Reply-To: <1526338533-6044-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338533-6044-2-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/memory-barriers.txt/kokr: Update Korean
 translation to indicate that READ_ONCE() now implies smp_barrier_depends()
Git-Commit-ID: eabed716672c2f2275887ec69e001a9cc30b2294
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

Commit-ID:  eabed716672c2f2275887ec69e001a9cc30b2294
Gitweb:     https://git.kernel.org/tip/eabed716672c2f2275887ec69e001a9cc30b2294
Author:     SeongJae Park <sj38.park@gmail.com>
AuthorDate: Mon, 14 May 2018 15:55:27 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:13 +0200

locking/memory-barriers.txt/kokr: Update Korean translation to indicate that READ_ONCE() now implies smp_barrier_depends()

Translate this commit to Korean:

  40555946447a ("doc: READ_ONCE() now implies smp_barrier_depends()")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1526338533-6044-2-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 0a0930ab4156..edef154d77b2 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -255,17 +255,20 @@ CPU 에게 기대할 수 있는 최소한의 보장사항 몇가지가 있습니
  (*) 어떤 CPU 든, 의존성이 존재하는 메모리 액세스들은 해당 CPU 자신에게
      있어서는 순서대로 메모리 시스템에 수행 요청됩니다. 즉, 다음에 대해서:
 
-	Q = READ_ONCE(P); smp_read_barrier_depends(); D = READ_ONCE(*Q);
+	Q = READ_ONCE(P); D = READ_ONCE(*Q);
 
      CPU 는 다음과 같은 메모리 오퍼레이션 시퀀스를 수행 요청합니다:
 
 	Q = LOAD P, D = LOAD *Q
 
-     그리고 그 시퀀스 내에서의 순서는 항상 지켜집니다.  대부분의 시스템에서
-     smp_read_barrier_depends() 는 아무일도 안하지만 DEC Alpha 에서는
-     명시적으로 사용되어야 합니다.  보통의 경우에는 smp_read_barrier_depends()
-     를 직접 사용하는 대신 rcu_dereference() 같은 것들을 사용해야 함을
-     알아두세요.
+     그리고 그 시퀀스 내에서의 순서는 항상 지켜집니다.  하지만, DEC Alpha 에서
+     READ_ONCE() 는 메모리 배리어 명령도 내게 되어 있어서, DEC Alpha CPU 는
+     다음과 같은 메모리 오퍼레이션들을 내놓게 됩니다:
+
+	Q = LOAD P, MEMORY_BARRIER, D = LOAD *Q, MEMORY_BARRIER
+
+     DEC Alpha 에서 수행되든 아니든, READ_ONCE() 는 컴파일러로부터의 악영향
+     또한 제거합니다.
 
  (*) 특정 CPU 내에서 겹치는 영역의 메모리에 행해지는 로드와 스토어 들은 해당
      CPU 안에서는 순서가 바뀌지 않은 것으로 보여집니다.  즉, 다음에 대해서:

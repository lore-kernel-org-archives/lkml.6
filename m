Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeEOGXP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:23:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45209 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeEOGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:23:13 -0400
Date: Mon, 14 May 2018 23:22:49 -0700
From: tip-bot for SeongJae Park <tipbot@zytor.com>
Message-ID: <tip-1ea32723c42a5c73a6da6a9731b9bdb6c5f206f0@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        sj38.park@gmail.com, hpa@zytor.com, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org, paulmck@linux.vnet.ibm.com,
        akpm@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, sj38.park@gmail.com,
        will.deacon@arm.com
In-Reply-To: <1526338533-6044-3-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338533-6044-3-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/memory-barriers.txt/kokr: Update Korean
 translation to de-emphasize smp_read_barrier_depends()
Git-Commit-ID: 1ea32723c42a5c73a6da6a9731b9bdb6c5f206f0
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

Commit-ID:  1ea32723c42a5c73a6da6a9731b9bdb6c5f206f0
Gitweb:     https://git.kernel.org/tip/1ea32723c42a5c73a6da6a9731b9bdb6c5f206f0
Author:     SeongJae Park <sj38.park@gmail.com>
AuthorDate: Mon, 14 May 2018 15:55:28 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:14 +0200

locking/memory-barriers.txt/kokr: Update Korean translation to de-emphasize smp_read_barrier_depends()

Translate this commit to Korean:

  9ad3c143d7d6 ("doc: De-emphasize smp_read_barrier_depends")

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
Link: http://lkml.kernel.org/r/1526338533-6044-3-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index edef154d77b2..44e47c2d33cf 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1790,7 +1790,7 @@ CPU 메모리 배리어
 	범용		mb()			smp_mb()
 	쓰기		wmb()			smp_wmb()
 	읽기		rmb()			smp_rmb()
-	데이터 의존성	read_barrier_depends()	smp_read_barrier_depends()
+	데이터 의존성				READ_ONCE()
 
 
 데이터 의존성 배리어를 제외한 모든 메모리 배리어는 컴파일러 배리어를
@@ -2829,7 +2829,10 @@ CPU 2 는 C/D 를 갖습니다)가 병렬로 연결되어 있는 시스템을 
 다른 CPU 들도 분할된 캐시를 가지고 있을 수 있지만, 그런 CPU 들은 평범한 메모리
 액세스를 위해서도 이 분할된 캐시들 사이의 조정을 해야만 합니다.  Alpha 는 가장
 약한 메모리 순서 시맨틱 (semantic) 을 선택함으로써 메모리 배리어가 명시적으로
-사용되지 않았을 때에는 그런 조정이 필요하지 않게 했습니다.
+사용되지 않았을 때에는 그런 조정이 필요하지 않게 했으며, 이는 Alpha 가 당시에
+더 높은 CPU 클락 속도를 가질 수 있게 했습니다.  하지만, Alpha 아키텍쳐 전용
+코드와 READ_ONCE() 매크로 내부에서를 제외하고는 smp_read_barrier_depends() 가
+사용되지 않아야 함을 알아두시기 바랍니다.
 
 
 캐시 일관성 VS DMA

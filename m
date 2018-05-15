Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeEOGYs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:24:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43531 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeEOGYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:24:46 -0400
Date: Mon, 14 May 2018 23:24:22 -0700
From: tip-bot for SeongJae Park <tipbot@zytor.com>
Message-ID: <tip-e89641dd038aa8affbbdc84b6633ccce5d2a2240@git.kernel.org>
Cc: akpm@linux-foundation.org, mingo@kernel.org, peterz@infradead.org,
        hpa@zytor.com, sj38.park@gmail.com, will.deacon@arm.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com
Reply-To: mingo@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
        peterz@infradead.org, sj38.park@gmail.com,
        torvalds@linux-foundation.org, will.deacon@arm.com, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <1526338533-6044-6-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338533-6044-6-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/memory-barriers.txt/kokr: Update Korean
 translation to de-emphasize smp_read_barrier_depends() some more
Git-Commit-ID: e89641dd038aa8affbbdc84b6633ccce5d2a2240
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

Commit-ID:  e89641dd038aa8affbbdc84b6633ccce5d2a2240
Gitweb:     https://git.kernel.org/tip/e89641dd038aa8affbbdc84b6633ccce5d2a2240
Author:     SeongJae Park <sj38.park@gmail.com>
AuthorDate: Mon, 14 May 2018 15:55:31 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:14 +0200

locking/memory-barriers.txt/kokr: Update Korean translation to de-emphasize smp_read_barrier_depends() some more

Translate this commit to Korean:

  f28f0868feb1 ("locking/memory-barriers: De-emphasize smp_read_barrier_depends() some more")

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
Link: http://lkml.kernel.org/r/1526338533-6044-6-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 .../translations/ko_KR/memory-barriers.txt         | 27 ++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 99ef4ca1c1bf..21e78af7ee93 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -80,7 +80,7 @@ Documentation/memory-barriers.txt
 
      - 메모리 배리어의 종류.
      - 메모리 배리어에 대해 가정해선 안될 것.
-     - 데이터 의존성 배리어.
+     - 데이터 의존성 배리어 (역사적).
      - 컨트롤 의존성.
      - SMP 배리어 짝맞추기.
      - 메모리 배리어 시퀀스의 예.
@@ -576,8 +576,14 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 	    Documentation/DMA-API.txt
 
 
-데이터 의존성 배리어
---------------------
+데이터 의존성 배리어 (역사적)
+-----------------------------
+
+리눅스 커널 v4.15 기준으로, smp_read_barrier_depends() 가 READ_ONCE() 에
+추가되었는데, 이는 이 섹션에 주의를 기울여야 하는 사람들은 DEC Alpha 아키텍쳐
+전용 코드를 만드는 사람들과 READ_ONCE() 자체를 만드는 사람들 뿐임을 의미합니다.
+그런 분들을 위해, 그리고 역사에 관심 있는 분들을 위해, 여기 데이터 의존성
+배리어에 대한 이야기를 적습니다.
 
 데이터 의존성 배리어의 사용에 있어 지켜야 하는 사항들은 약간 미묘하고, 데이터
 의존성 배리어가 사용되어야 하는 상황도 항상 명백하지는 않습니다.  설명을 위해
@@ -2802,8 +2808,9 @@ CPU 2 는 C/D 를 갖습니다)가 병렬로 연결되어 있는 시스템을 
 
 
 여기에 개입하기 위해선, 데이터 의존성 배리어나 읽기 배리어를 로드 오퍼레이션들
-사이에 넣어야 합니다.  이렇게 함으로써 캐시가 다음 요청을 처리하기 전에 일관성
-큐를 처리하도록 강제하게 됩니다.
+사이에 넣어야 합니다 (v4.15 부터는 READ_ONCE() 매크로에 의해 무조건적으로
+그렇게 됩니다).  이렇게 함으로써 캐시가 다음 요청을 처리하기 전에 일관성 큐를
+처리하도록 강제하게 됩니다.
 
 	CPU 1		CPU 2		COMMENT
 	===============	===============	=======================================
@@ -2833,9 +2840,9 @@ CPU 2 는 C/D 를 갖습니다)가 병렬로 연결되어 있는 시스템을 
 액세스를 위해서도 이 분할된 캐시들 사이의 조정을 해야만 합니다.  Alpha 는 가장
 약한 메모리 순서 시맨틱 (semantic) 을 선택함으로써 메모리 배리어가 명시적으로
 사용되지 않았을 때에는 그런 조정이 필요하지 않게 했으며, 이는 Alpha 가 당시에
-더 높은 CPU 클락 속도를 가질 수 있게 했습니다.  하지만, Alpha 아키텍쳐 전용
-코드와 READ_ONCE() 매크로 내부에서를 제외하고는 smp_read_barrier_depends() 가
-사용되지 않아야 함을 알아두시기 바랍니다.
+더 높은 CPU 클락 속도를 가질 수 있게 했습니다.  하지만, (다시 말하건대, v4.15
+이후부터는) Alpha 아키텍쳐 전용 코드와 READ_ONCE() 매크로 내부에서를 제외하고는
+smp_read_barrier_depends() 가 사용되지 않아야 함을 알아두시기 바랍니다.
 
 
 캐시 일관성 VS DMA
@@ -2997,7 +3004,9 @@ Alpha CPU 의 일부 버전은 분할된 데이터 캐시를 가지고 있어서
 메모리 일관성 시스템과 함께 두개의 캐시를 동기화 시켜서, 포인터 변경과 새로운
 데이터의 발견을 올바른 순서로 일어나게 하기 때문입니다.
 
-리눅스 커널의 메모리 배리어 모델은 Alpha 에 기초해서 정의되었습니다.
+리눅스 커널의 메모리 배리어 모델은 Alpha 에 기초해서 정의되었습니다만, v4.15
+부터는 리눅스 커널이 READ_ONCE() 내에 smp_read_barrier_depends() 를 추가해서
+Alpha 의 메모리 모델로의 영향력이 크게 줄어들긴 했습니다.
 
 위의 "캐시 일관성" 서브섹션을 참고하세요.
 

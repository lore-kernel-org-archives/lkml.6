Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeEPUJI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:09:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52766 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEPUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:09:06 -0400
X-Google-Smtp-Source: AB8JxZrABBpoKjhTcjr0DUh35ojqjdlGmhfBohNbNM8QRR3wsbeQ+Re0c2JX5EEX7oJCAbmz8wQHlg==
From: Mathieu Malaterre <malat@debian.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Malaterre <malat@debian.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?sched/deadline:=20make=20function=20=E2=80=98gr?= =?UTF-8?q?ub=5Freclaim=E2=80=99=20static?=
Date: Wed, 16 May 2018 22:09:02 +0200
Message-Id: <20180516200902.959-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since function ‘grub_reclaim’ can be made static, make it so.
Silence the following gcc warning (W=1):

  kernel/sched/deadline.c:1120:5: warning: no previous prototype for ‘grub_reclaim’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d6196bc6cbb5..1356afd1eeb6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1117,7 +1117,7 @@ extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
  * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
  * So, overflow is not an issue here.
  */
-u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
+static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 {
 	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
 	u64 u_act;
-- 
2.11.0

Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02115C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C7B218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfAZB1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:27:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:15567 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAZB1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:27:38 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0Q1RaWn049730;
        Sat, 26 Jan 2019 10:27:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Sat, 26 Jan 2019 10:27:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0Q1RaiU049727
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 26 Jan 2019 10:27:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: pids.current with invalid value for hours [5.0.0 rc3 git]
To:     =?UTF-8?Q?Arkadiusz_Mi=c5=9bkiewicz?= <a.miskiewicz@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Aleksa Sarai <asarai@suse.de>, Jay Kamat <jgkamat@fb.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <df806a77-3327-9db5-8be2-976fde1c84e5@gmail.com>
 <20190117122535.njcbqhlmzozdkncw@mikami>
 <1d36b181-cbaf-6694-1a31-2f7f55d15675@gmail.com>
 <96ef6615-a5df-30af-b4dc-417a18ca63f1@gmail.com>
 <1cdbef13-564d-61a6-95f4-579d2cad243d@gmail.com>
 <20190125163731.GJ50184@devbig004.ftw2.facebook.com>
 <a95d004a-4358-7efc-6d21-12aac4411b32@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <480296c4-ed7a-3265-e84a-298e42a0f1d5@I-love.SAKURA.ne.jp>
Date:   Sat, 26 Jan 2019 10:27:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a95d004a-4358-7efc-6d21-12aac4411b32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/26 4:47, Arkadiusz Miśkiewicz wrote:
>> Can you please see whether the problem can be reproduced on the
>> current linux-next?
>>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> I can reproduce on next (5.0.0-rc3-next-20190125), too:
> 

Please try this patch.

Subject: [PATCH v2] memcg: killed threads should not invoke memcg OOM killer
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, David Rientjes <rientjes@google.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Kirill Tkhai <ktkhai@virtuozzo.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <01370f70-e1f6-ebe4-b95e-0df21a0bc15e@i-love.sakura.ne.jp>
Date: Tue, 15 Jan 2019 19:17:27 +0900

If $N > $M, a single process with $N threads in a memcg group can easily
kill all $M processes in that memcg group, for mem_cgroup_out_of_memory()
does not check if current thread needs to invoke the memcg OOM killer.

  T1@P1     |T2...$N@P1|P2...$M   |OOM reaper
  ----------+----------+----------+----------
                        # all sleeping
  try_charge()
    mem_cgroup_out_of_memory()
      mutex_lock(oom_lock)
             try_charge()
               mem_cgroup_out_of_memory()
                 mutex_lock(oom_lock)
      out_of_memory()
        select_bad_process()
        oom_kill_process(P1)
        wake_oom_reaper()
                                   oom_reap_task() # ignores P1
      mutex_unlock(oom_lock)
                 out_of_memory()
                   select_bad_process(P2...$M)
                        # all killed by T2...$N@P1
                   wake_oom_reaper()
                                   oom_reap_task() # ignores P2...$M
                 mutex_unlock(oom_lock)

We don't need to invoke the memcg OOM killer if current thread was killed
when waiting for oom_lock, for mem_cgroup_oom_synchronize(true) can count
on try_charge() when mem_cgroup_oom_synchronize(true) can not make forward
progress because try_charge() allows already killed/exiting threads to
make forward progress, and memory_max_write() can bail out upon signals.

At first Michal thought that fatal signal check is racy compared to
tsk_is_oom_victim() check. But an experiment showed that trying to call
mark_oom_victim() on all killed thread groups is more racy than fatal
signal check due to task_will_free_mem(current) path in out_of_memory().

Therefore, this patch changes mem_cgroup_out_of_memory() to bail out upon
should_force_charge() == T rather than upon fatal_signal_pending() == T,
for should_force_charge() == T && signal_pending(current) == F at
memory_max_write() can't happen because current thread won't call
memory_max_write() after getting PF_EXITING.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Michal Hocko <mhocko@suse.com>
Fixes: 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the charge path")
Fixes: 3100dab2aa09 ("mm: memcontrol: print proper OOM header when no eligible victim left")
Cc: stable@vger.kernel.org # 4.19+
---
 mm/memcontrol.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index af7f18b..79a7d2a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -248,6 +248,12 @@ enum res_type {
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
+static inline bool should_force_charge(void)
+{
+	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
+		(current->flags & PF_EXITING);
+}
+
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
@@ -1389,8 +1395,13 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	};
 	bool ret;
 
-	mutex_lock(&oom_lock);
-	ret = out_of_memory(&oc);
+	if (mutex_lock_killable(&oom_lock))
+		return true;
+	/*
+	 * A few threads which were not waiting at mutex_lock_killable() can
+	 * fail to bail out. Therefore, check again after holding oom_lock.
+	 */
+	ret = should_force_charge() || out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
 	return ret;
 }
@@ -2209,9 +2220,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * bypass the last charges so that they can exit quickly and
 	 * free their memory.
 	 */
-	if (unlikely(tsk_is_oom_victim(current) ||
-		     fatal_signal_pending(current) ||
-		     current->flags & PF_EXITING))
+	if (unlikely(should_force_charge()))
 		goto force;
 
 	/*
-- 
1.8.3.1


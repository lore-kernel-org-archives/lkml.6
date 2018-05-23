Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934437AbeEWTq5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:46:57 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37197 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934232AbeEWTqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:46:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
References: <20180503133338.GA23401@redhat.com> <87y3h0x0qg.fsf@xmission.com>
        <20180504142056.GA26151@redhat.com> <87r2mrh4is.fsf@xmission.com>
        <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com> <871serfk77.fsf@xmission.com>
        <87tvrncoyc.fsf_-_@xmission.com>
        <20180510121418.GD5325@dhcp22.suse.cz>
        <20180522125757.GL20020@dhcp22.suse.cz>
Date: Wed, 23 May 2018 14:46:43 -0500
In-Reply-To: <20180522125757.GL20020@dhcp22.suse.cz> (Michal Hocko's message
        of "Tue, 22 May 2018 14:57:57 +0200")
Message-ID: <87wovu889o.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLZil-0003oj-NV;;;mid=<87wovu889o.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18C/s8kxlIHvnRU7PGZ+MMEMOL2stG12+A=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1372 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 3.2 (0.2%), b_tie_ro: 1.99 (0.1%), parse: 1.10 (0.1%),
        extract_message_metadata: 12 (0.9%), get_uri_detail_list: 2.6 (0.2%),
        tests_pri_-1000: 6 (0.5%), tests_pri_-950: 1.24 (0.1%), tests_pri_-900: 1.01
        (0.1%), tests_pri_-400: 32 (2.3%), check_bayes: 31 (2.3%), b_tokenize: 11
        (0.8%), b_tok_get_all: 11 (0.8%), b_comp_prob: 3.1 (0.2%), b_tok_touch_all:
        4.1 (0.3%), b_finish: 0.60 (0.0%), tests_pri_0: 1302 (94.9%),
        check_dkim_signature: 0.65 (0.0%), check_dkim_adsp: 4.3 (0.3%),
        tests_pri_500: 10 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] mm->owner to mm->memcg fixes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Thu 10-05-18 14:14:18, Michal Hocko wrote:
>> On Fri 04-05-18 12:26:03, Eric W. Biederman wrote:
>> > 
>> > Andrew can you pick up these two fixes as well.
>> > 
>> > These address the issues Michal Hocko and Oleg Nesterov noticed.
>> 
>> I completely got lost in this thread. There are way too many things
>> discussed at once. Could you repost the full series for a proper review
>> please?
>
> ping

Quick summary of where things stand.  (Just getting back from vacation
and catching up with things).

Andrew has picked up the best version of these patches and you can look
at his tree to find the current patches.

Looking at my tree the issues that have been looked at above
the basic patch are:
!CONFIG_MMU support (code motion)
Races during exec.  (Roughly solved but I think we can do better by
                     expanding the scope of
                     cgroup_threadgroup_change_begin/end in exec and
                     just making exec atomic wrt to cgroup changes)




While I was on vacation you posted an old concern about a condtion
where get_mem_cgroup_from_mm was not guaranteed to complete, and how
that interacts with charge migration.


Looking at your description the concern is that cgroup_rmdir can succeed
when a cgroup has just an mm in it (and no tasks).  The result  is
that mem_cgroup_try_charge can loop indefinitely in that case.

That is possible with two processes sharing the same mm, but living in
different memory cgroups.  That is a silly useless configuration but
something to support at least to the level of making certain kernel's
don't wedge when it happens by accident or maliciously.

The suggestion of having cgroup_is_populated take this into account
seems like a good general solution but I don't think that is strictly
necessary.

In the spirit of let's make this work.  How about:

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 23 May 2018 13:48:31 -0500
Subject: [PATCH] memcontrol:  Guarantee that get_mem_cgroup_from_mm does not
 loop forever

The root memory cgroup should always be online, so when returning it
unconditionally bump it's refcount.

The only way for mm->memcg to point to an offline memory cgroup is if
CLONE_VM was used to create two processes that share a mm and those
processes were put in different memory cgroups.  If one of those
processes exited and then cgroup_rmdir was called on it's memory
cgroup.

As two processes sharing an mm is useless and highly unlikely there is
no need to handle this case well, it just needs to be handled well
enough to prevent an indefinite loop.  So when css_tryget_online fails
just treat the mm as belong to the root memory cgroup.

The cgroup migration and the cgroup remove actions both happen
with the the cgroup_mutex held.  So there is no need to worry about
a mm that is migrating cgroups not having a live cgroup.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 mm/memcontrol.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d74aeba7dfed..dbb197bfc517 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -666,25 +666,29 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 
 static struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 {
-	struct mem_cgroup *memcg = NULL;
+	struct mem_cgroup *memcg;
 
 	rcu_read_lock();
-	do {
-		/*
-		 * Page cache insertions can happen withou an
-		 * actual mm context, e.g. during disk probing
-		 * on boot, loopback IO, acct() writes etc.
-		 */
-		if (unlikely(!mm))
-			memcg = root_mem_cgroup;
-		else {
-			memcg = rcu_dereference(mm->memcg);
-			if (unlikely(!memcg))
-				memcg = root_mem_cgroup;
-		}
-	} while (!css_tryget_online(&memcg->css));
+	/*
+	 * Page cache insertions can happen withou an
+	 * actual mm context, e.g. during disk probing
+	 * on boot, loopback IO, acct() writes etc.
+	 */
+	if (unlikely(!mm))
+		goto root_memcg;
+
+	memcg = rcu_dereference(mm->memcg);
+	if (unlikely(!memcg))
+		goto root_memcg;
+	if (!css_tryget_online(&memcg->css))
+		goto root_memcg;
 	rcu_read_unlock();
 	return memcg;
+
+root_memcg:
+	css_get(&root_mem_cgroup->css);
+	rcu_read_unlock();
+	return root_mem_cgroup;
 }
 
 /**
-- 
2.14.1

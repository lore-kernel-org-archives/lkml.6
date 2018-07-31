Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DD1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D35420870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JepEBOmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D35420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeGaDno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:43:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42504 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeGaDno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:43:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so5360389pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+n3IsCXIfXKQ9eeO1rwRumWFV0g1UNY/QxIgbOPxHlc=;
        b=JepEBOmGUPkwxQT7viGZqyV4vrqsiu+k7Bq67fzlNl/MH58KZfz2Ud81x6kzvlRXcu
         nhULcXxEjNFWhvLOWeuJXgGfkAtH7q+FQq2JMCVnfFlJ4YDOpan0vQHam1cdWFLjbVHw
         ljUPKBFcKo87u+EeQjJG7QgnpBk1pFU8r/gn1sr+f+BCVlCZ+JIGZn0QV44LPmDEyv/J
         5sF+xt9hoYtqnYN6JnfcR9gPKBKVP8+VfV6Y/nL5hUTtFwjF6MQyO4R65C4/Y1xeJf6Z
         EO/dOIe5jCn4BlhFFAfvk7pJNg+zvm14TLxOM+n7UNnHbvkmIw8O6ZjoLvqa876LJvwk
         qrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+n3IsCXIfXKQ9eeO1rwRumWFV0g1UNY/QxIgbOPxHlc=;
        b=MGxdKqMb7ltBfyx3C9LjR6MHoy8fZOM9ge6d60qNsbU2L7vBYbJcs8BVUZyNW/NfnL
         WsXBjR1nECPlh4y1hz1ZGVc2BCG5C7JqLNcsRqWgjwV2WzwUeGsx/EGCEzUC+QLoCbh9
         m1MOk0V5+vfXZoMLp4d3r1+ZLTbVebP9GovsiU36w3wd+YZ8NaFSOqtOJevCPzf48obN
         1qcpoiqs6vMxnouQpV9M0T2iZfype7TCKPurOPAiD4us4DTEm1MnTfp6J47GL4qvduxJ
         hgbqAMhsdvnwUwoLKvRfrvsr/K9tuFW73tkJBUy1b6Wt4vxrE2C11itSx2sWiVzLp2Mi
         l74g==
X-Gm-Message-State: AOUpUlGqdq7A6lj+Ex3McIptMusBbG84haYLgH4CFPkZ6iWBS6Xi5ny+
        88J2CaYOAobcSq6LuCt2eTs34Q==
X-Google-Smtp-Source: AAOMgpeRppQl8GyKTW8df73yUoe2pUnYnxyU4qPM8Xt/hmCZg4wil2iSYyn2VzqLb9kw1AzaJ/zIRw==
X-Received: by 2002:a63:fd52:: with SMTP id m18-v6mr13762857pgj.304.1533002751887;
        Mon, 30 Jul 2018 19:05:51 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a77-v6sm23812516pfj.38.2018.07.30.19.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 19:05:51 -0700 (PDT)
Date:   Mon, 30 Jul 2018 19:05:50 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     kernel test robot <rong.a.chen@intel.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [mm, oom]  c1e4c54f9c: BUG:KASAN:null-ptr-deref_in_d
In-Reply-To: <20180730095635.GI24267@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1807301854040.198273@chino.kir.corp.google.com>
References: <20180730090320.GD30690@shao2-debian> <20180730095635.GI24267@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018, Michal Hocko wrote:

> On Mon 30-07-18 17:03:20, kernel test robot wrote:
> [...]
> > [    9.034310] BUG: KASAN: null-ptr-deref in dump_header+0x10c/0x448
> 
> Could you faddr2line on the offset please?
> 

It's possible that p is NULL when calling dump_header().  In this case we 
do not want to print any line concerning a victim because no oom kill has 
occurred.

This code shouldn't be part of dump_header(), which is called from 
multiple contexts even when an oom kill has not occurred, and is 
ratelimited.  The single line output should be the canonical way that 
userspace parses the log for oom victims, we can't ratelimit it.

The following would be a fix patch, but it will be broken if the cgroup 
aware oom killer is removed from -mm so that the oom_group stuff can be 
merged.


diff --git a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -438,14 +438,6 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 
 	dump_stack();
 
-	/* one line summary of the oom killer context. */
-	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
-			oom_constraint_text[oc->constraint],
-			nodemask_pr_args(oc->nodemask));
-	cpuset_print_current_mems_allowed();
-	mem_cgroup_print_oom_context(oc->memcg, p);
-	pr_cont(",task=%s,pid=%d,uid=%d\n", p->comm, p->pid,
-		from_kuid(&init_user_ns, task_uid(p)));
 	if (is_memcg_oom(oc))
 		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
@@ -836,7 +828,8 @@ static bool task_will_free_mem(struct task_struct *task)
 	return ret;
 }
 
-static void __oom_kill_process(struct task_struct *victim)
+static void __oom_kill_process(struct task_struct *victim,
+			       struct oom_control *oc)
 {
 	struct task_struct *p;
 	struct mm_struct *mm;
@@ -883,6 +876,18 @@ static void __oom_kill_process(struct task_struct *victim)
 		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
 		K(get_mm_counter(victim->mm, MM_FILEPAGES)),
 		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
+
+	if (oc) {
+		/* One line summary for non-group oom kills */
+		pr_info("oom-kill: constraint=%s, nodemask=%*pbl",
+			oom_constraint_text[oc->constraint],
+			nodemask_pr_args(oc->nodemask));
+		cpuset_print_current_mems_allowed();
+		mem_cgroup_print_oom_context(oc->memcg, victim);
+		pr_cont(", task=%s, pid=%d, uid=%d\n",
+			victim->comm, victim->pid,
+			from_kuid(&init_user_ns, task_uid(victim)));
+	}
 	task_unlock(victim);
 
 	/*
@@ -986,13 +991,13 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	}
 	read_unlock(&tasklist_lock);
 
-	__oom_kill_process(victim);
+	__oom_kill_process(victim, oc);
 }
 
 static int oom_kill_memcg_member(struct task_struct *task, void *unused)
 {
 	get_task_struct(task);
-	__oom_kill_process(task);
+	__oom_kill_process(task, NULL);
 	return 0;
 }
 
@@ -1020,7 +1025,7 @@ static bool oom_kill_memcg_victim(struct oom_control *oc)
 		    oc->chosen_task == INFLIGHT_VICTIM)
 			goto out;
 
-		__oom_kill_process(oc->chosen_task);
+		__oom_kill_process(oc->chosen_task, oc);
 	}
 
 out:

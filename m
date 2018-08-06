Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71383C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5FA21A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VkvG2XQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5FA21A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbeHFXsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:48:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44988 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeHFXsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:48:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so6781634pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-id;
        bh=BM7m1gI0a/MmuMwdM17vqcIZAxG1kAIfjx0q+JFvBH8=;
        b=VkvG2XQdXcfKwoAp3DZYJzlw5L2MQ1DZJe7syWhoY1L0ktzpH0uvPms1ERSy/aPJCo
         hv45fbnJ3P6hMdaav9/pjw0Lcd2zbVRqq0t5wDgXyoNF8Wt1pFk6XEEuLRqmtP8afWQV
         WgAZ/MLDOkPNJTFNFzMWPPdIAKLvjLo51yOKrsF6ZbZEs8VUjLkbKNY1VZeqRISCPT3T
         vr2y+VJUPRF0+vvpvsU3t6FjS07BkIqByAw9jRF4MIsg9WswEnoLHCvqFOM3rgm3zOTL
         MN5pL2rr5YOlrM1r4oQX75B3cKeAQmrz3BkQR8cJBfEiQmR1P/Ecl/N3Hx4kmCneEogS
         XXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-id;
        bh=BM7m1gI0a/MmuMwdM17vqcIZAxG1kAIfjx0q+JFvBH8=;
        b=FqXpeXXA9mNQOJsa8OpI8ZlUtkyvUNV2RptMJIRU1r4/snXS1g7gkmq6fDPA3sMh2l
         Jv+Zc9aMPeo038tWcKGWyFqZXBiYydSuEN3/i4ou+9uLYN494qHr4nd57E+k0c21VPx9
         Ndsiz2gjhkKDt/0z5/vPd7AlyiLIarQhAKqNq/LWUQKOmo/Y5QrBVG4XxrHz9D8mbpYe
         7VB+IkRH9f+z5hAg5dWv4ie62+HGkt/U9HtRrWQb65p9f8in76k4euPknYTe5N0VSUC0
         HbulZuaFzli3i7jbTVXYm6hd7AqP2nqi9mNXiyy30iKaMV5Ge5qYs0dOhtCoR1HssWHb
         8eMw==
X-Gm-Message-State: AOUpUlHy0eOsKH+1E+JFD+Mtf1bTTKuIkukVy366AdMGBOrIxnEKicCj
        RFIQ2ePTriRpxxs6FdWlqQeH8g==
X-Google-Smtp-Source: AAOMgpcgJ4RqoTVlCrjr9HaG7isQICw/EMDLbCQy4G76OWzXqfC9BflFt33GaN7j8nBQAXUb3NL3tg==
X-Received: by 2002:a62:fccd:: with SMTP id e196-v6mr18841201pfh.245.1533591461721;
        Mon, 06 Aug 2018 14:37:41 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r11-v6sm12954873pgn.62.2018.08.06.14.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 14:37:40 -0700 (PDT)
Date:   Mon, 6 Aug 2018 14:37:40 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
cc:     mhocko@kernel.org, Wind Yu <yuzhoujian@didichuxing.com>,
        rong.a.chen@intel.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [LKP] [mm, oom] c1e4c54f9c: BUG:KASAN:null-ptr-deref_in_d
In-Reply-To: <CAHCio2j-oH2v5xY9F=Naoj9ao4cYw+LP6kqi_GELafqJ4qB6iw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808061436270.43071@chino.kir.corp.google.com>
References: <0d4090532f15434aa71779e9dc8a0014@BJSGEXMBX10.didichuxing.com> <CAHCio2idn3oh55n7urkRPqkdyo+Y-0Qhg=Vc2VHXy2Wy2q1wiA@mail.gmail.com> <20180806060649.GA19540@dhcp22.suse.cz> <CAHCio2j-oH2v5xY9F=Naoj9ao4cYw+LP6kqi_GELafqJ4qB6iw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1113858990-1966416849-1533591451=:43071"
Content-ID: <alpine.DEB.2.21.1808061437370.43071@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1113858990-1966416849-1533591451=:43071
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1808061437371.43071@chino.kir.corp.google.com>

On Mon, 6 Aug 2018, 禹舟键 wrote:

> Hi Michal
> Sorry, I cannot open the link you shared.
> 

The suggestion atop your previous patch was

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


You should be able to find this in your email.  We don't want to emit the 
line when a victim is not chosen.  I also did a couple of cleanups like 
spaces between commas.
--1113858990-1966416849-1533591451=:43071--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756040AbeEaSlv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:41:51 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39623 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756026AbeEaSlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:41:46 -0400
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
References: <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com> <871serfk77.fsf@xmission.com>
        <87tvrncoyc.fsf_-_@xmission.com>
        <20180510121418.GD5325@dhcp22.suse.cz>
        <20180522125757.GL20020@dhcp22.suse.cz> <87wovu889o.fsf@xmission.com>
        <20180524111002.GB20441@dhcp22.suse.cz>
        <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
        <20180530121721.GD27180@dhcp22.suse.cz>
Date: Thu, 31 May 2018 13:41:38 -0500
In-Reply-To: <20180530121721.GD27180@dhcp22.suse.cz> (Michal Hocko's message
        of "Wed, 30 May 2018 14:17:21 +0200")
Message-ID: <87wovjacrh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOSW8-0002Sj-HU;;;mid=<87wovjacrh.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UIUNqVF7loDO0W44yJdSU4Bf9VKJtbzU=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 345 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.7 (0.8%), b_tie_ro: 1.94 (0.6%), parse: 0.86 (0.2%),
        extract_message_metadata: 4.5 (1.3%), get_uri_detail_list: 2.9 (0.8%),
        tests_pri_-1000: 4.2 (1.2%), tests_pri_-950: 1.23 (0.4%), tests_pri_-900:
        1.04 (0.3%), tests_pri_-400: 30 (8.6%), check_bayes: 29 (8.3%), b_tokenize:
        10 (3.0%), b_tok_get_all: 10 (2.9%), b_comp_prob: 3.0 (0.9%),
        b_tok_touch_all: 3.5 (1.0%), b_finish: 0.56 (0.2%), tests_pri_0: 289 (83.8%),
        check_dkim_signature: 0.51 (0.1%), check_dkim_adsp: 2.5 (0.7%),
        tests_pri_500: 4.2 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] mm->owner to mm->memcg fixes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Thu 24-05-18 14:16:35, Andrew Morton wrote:
>> On Thu, 24 May 2018 13:10:02 +0200 Michal Hocko <mhocko@kernel.org> wrote:
>> 
>> > I would really prefer and appreciate a repost with all the fixes folded
>> > in.
>> 
>> [1/2]
>
> Thanks Andrew and sorry it took so long! This seems to be missing the
> fix for the issue I've mentioned in http://lkml.kernel.org/r/20180510121838.GE5325@dhcp22.suse.cz
> and Eric wanted to handle by http://lkml.kernel.org/r/87wovu889o.fsf@xmission.com.
> I do not think that this fix is really correct one though. I will
> comment in a reply to that email.

Agreed.  That was not a correct fix to the possible infinite loop in
get_mem_cgroup_from_mm.   Which in net leaves all of this broken and
not ready to be merged.

> In any case I really think this should better be reposted in one patch
> series and restart the discussion. I strongly suggest revisiting my
> previous attempt http://lkml.kernel.org/r/1436358472-29137-8-git-send-email-mhocko@kernel.org
> including the follow up discussion regarding the unfortunate CLONE_VM
> outside of thread group case and potential solution for that.

With my fix for get_mem_cgroup_from_mm falling flat that limits our
possible future directions:
- Make memory cgroups honest and require all tasks of an mm to be in the
  same memory cgroup.  [BEST]
- Don't allow memory cgroups to be removed even if they are only populated by
  an mm.
- If tryget_online fails in get_mem_cgroup_from_mm find a parent of the
  memcg where tryget_online succeeds and use that one.

  That should not be possible to abose as even if a cgroup subtree is
  delegated it should not be possible for the processes to escape the
  subtree.  So in the worst case the charge would walk back up to the
  delegation point.

>> -static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
>> +static void mm_init_memcg(struct mm_struct *mm)
>>  {
>>  #ifdef CONFIG_MEMCG
>> -	mm->owner = p;
>> +	struct cgroup_subsys_state *css;
>> +
>> +	/* Ensure mm->memcg is initialized */
>> +	mm->memcg = NULL;
>> +
>> +	rcu_read_lock();
>> +	css = task_css(current, memory_cgrp_id);
>> +	if (css && css_tryget(css))
>> +		mm_update_memcg(mm, mem_cgroup_from_css(css));
>> +	rcu_read_unlock();
>
> Is it possible that css_tryget ever fails here? I remember I used to do
> plain css_get in my patch.

Short of races with task migration that can't fail.  As the current
task will keep the memory memory cgroup alive.

I will recheck when I refresh my patch.

>> @@ -4850,15 +4836,16 @@ static int mem_cgroup_can_attach(struct
>>  	if (!move_flags)
>>  		return 0;
>>  
>> -	from = mem_cgroup_from_task(p);
>> +	from = mem_cgroup_from_css(task_css(p, memory_cgrp_id));
>>  
>>  	VM_BUG_ON(from == memcg);
>>  
>>  	mm = get_task_mm(p);
>>  	if (!mm)
>>  		return 0;
>> -	/* We move charges only when we move a owner of the mm */
>> -	if (mm->owner == p) {
c>> +
>> +	/* We move charges except for creative uses of CLONE_VM */
>> +	if (mm->memcg == from) {
>
> I must be missing something here but how do you prevent those cases?
> AFAICS processes sharing the mm will simply allow to migrate.

The mm will only migrate once per set of tasks.  A task that does not
migrate with the mm will not have mm->memcg == from.  Which is all I was
referring to.  Perhaps I did not say that well.

>>  		VM_BUG_ON(mc.from);
>>  		VM_BUG_ON(mc.to);
>>  		VM_BUG_ON(mc.precharge);
>
> Other than that the patch makes sense to me.

I will take a bit and respin this.  Because of algorithmic bug-fix
nature of where this started I want to avoid depending on fixing the
semantics.  With my third option for fixing get_mem_cgroup_from_mm I see
how to do that now.  Then I will include a separate patch to fix the
semantics.  

Eric

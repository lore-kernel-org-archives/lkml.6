Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eUhWAeg7GlsDGAAAmS7hNA
	; Fri, 08 Jun 2018 08:18:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DDF0D607DC; Fri,  8 Jun 2018 08:18:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHO8lKPG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CC80D60590;
	Fri,  8 Jun 2018 08:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC80D60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeFHISo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:18:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43969 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeFHISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:18:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id j20-v6so6247393pff.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mhgb8sSguj0EYxH7CLsDSa3+QwuEcssr+gLqC4aDDjQ=;
        b=gHO8lKPGO2Bv1zPt8cZUmpccKEcKm16sYxHiKcjuFyJIHhX9d5jtgA4BHOtUQpo9dR
         Q7z4M4xZdt3T4s8gCR0sNXmISVJl/A3d3zbIqCB2KdBGSUYhGFLSJLu4o5f/yFoQAtBf
         StBF77Z6S7MeUCV6gi8XSaSH7SG7iIxyz3DxyArQlDZ3uqZMcl+AMfUwRjkkjtYgFUbQ
         HGrkcJ9Di8vW6qUT9dFR819d98+Xlc44t9rBCm4+bRynRoAwWbh+gJM2DxBnyFWkJeWt
         9k0yq65HqNq9r5Gg1Rj+bQi4HvxC9F7qaJPjL7vMPmLM5VxF50GsaV6HQxS1295WcftH
         k3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mhgb8sSguj0EYxH7CLsDSa3+QwuEcssr+gLqC4aDDjQ=;
        b=jgcLYybt7ux49rMZjXSZ+v7tpTryBsXcKuumu6iKUQlLawg+oALRNe+mi1kdoGdUnp
         fhvQ11wjf9nQqj4uCfPn9/3AdohknrGZYLeMiMMYzcnTQD4tZ1zNqYMOpnepHDoCJveh
         fBTXEoRBVni1SnwAdnCRGWnP/oMmSthzD40PcVCDbu3bNc2sDkju/2Nq+JfMeS9SZtGD
         ILhZp16kVUhuESy+jM4iDUZF5AlU0+Ow19639QQTP9laQfAcqKdbvsuH4b3D2cjznh7p
         CxXxjq+GroVy36Tn81+Ng8zjscktT+tYorNufVAEDK0uJcPEoDrOzkLggQa4ejCes5IP
         yLwA==
X-Gm-Message-State: APt69E2Ey7tN+aEoaOeM/ZIgPjdwQQ/aMqO0ekRZ/LEBED+hyas2nLJp
        6KeQemwTR8U88xZanYoCOZjX+nPCGzdVZBmyRfZYZA==
X-Google-Smtp-Source: ADUXVKJ9qWdU/YU7P8wnuHs4a6rLKulgXicXXWfa72B7CeK9MEfLcAftGNG8eX9y1j0AvA4QO1tTlEG8j5UZHTo4b3Q=
X-Received: by 2002:a62:3e9a:: with SMTP id y26-v6mr4999516pfj.98.1528445919356;
 Fri, 08 Jun 2018 01:18:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Fri, 8 Jun 2018 01:18:18
 -0700 (PDT)
In-Reply-To: <6b14e8b9-c335-dd46-98a6-7f58a624fcea@virtuozzo.com>
References: <0000000000006e4595056dd23c16@google.com> <CACT4Y+ZmxgKvgD2RWD1=KEZQqY=vwdhrAZfqMT-gGuj8k8eKKg@mail.gmail.com>
 <cf729ce5-7948-d475-1b20-f31fb313df88@virtuozzo.com> <CACT4Y+bPrdK7xSeUk=pgVVyaseDZUAvArBA4bEWPsUi7CE3EVw@mail.gmail.com>
 <e71c0df1-d83c-030c-7c97-13a923aca1b3@virtuozzo.com> <CACT4Y+YBY2yGJBHgqGhAcOguag9JUkGkeOz1acgKd=KR3q+noQ@mail.gmail.com>
 <04b6ee08-7919-bf2d-5b77-bd346a0bff48@virtuozzo.com> <CACT4Y+b8FkwFe1PCEVDZcTufB4HKVy+ekk=1_YcFH6-RoBGY-w@mail.gmail.com>
 <6b14e8b9-c335-dd46-98a6-7f58a624fcea@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 10:18:18 +0200
Message-ID: <CACT4Y+a57xaVfph_u78Z+kM8xUF=8fVk-VSA+xqok38Zm4bhFw@mail.gmail.com>
Subject: Re: INFO: task hung in ip6gre_exit_batch_net
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: syzbot <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        mschiffer@universe-factory.net, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 9:59 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 07.06.2018 22:03, Dmitry Vyukov wrote:
>> On Thu, Jun 7, 2018 at 8:54 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>>>> Hi, Dmirty!
>>>>>>>
>>>>>>> On 04.06.2018 18:22, Dmitry Vyukov wrote:
>>>>>>>> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
>>>>>>>> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> syzbot found the following crash on:
>>>>>>>>>
>>>>>>>>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>>>>>>>>> git tree:       upstream
>>>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>>>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>>>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>>>>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>>>>
>>>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>>>
>>>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>>>>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
>>>>>>>>
>>>>>>>> Another hang on rtnl lock:
>>>>>>>>
>>>>>>>> #syz dup: INFO: task hung in netdev_run_todo
>>>>>>>>
>>>>>>>> May be related to "unregister_netdevice: waiting for DEV to become free":
>>>>>>>> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9
>>>>>>
>>>>>> netdev_wait_allrefs does not hold rtnl lock during waiting, so it must
>>>>>> be something different.
>>>>>>
>>>>>>
>>>>>>>> Any other explanations for massive hangs on rtnl lock for minutes?
>>>>>>>
>>>>>>> To exclude the situation, when a task exists with rtnl_mutex held:
>>>>>>>
>>>>>>> would the pr_warn() from print_held_locks_bug() be included in the console output
>>>>>>> if they appear?
>>>>>>
>>>>>> Yes, everything containing "WARNING:" is detected as bug.
>>>>>
>>>>> OK, then dead task not releasing the lock is excluded.
>>>>>
>>>>> One more assumption: someone corrupted memory around rtnl_mutex and it looks like locked.
>>>>> (I track lockdep "(rtnl_mutex){+.+.}" prints in initial message as "nobody owns rtnl_mutex").
>>>>> There may help a crash dump of the VM.
>>>>
>>>> I can't find any legend for these +'s and .'s, but {+.+.} is present
>>>> in large amounts in just any task hung report for different mutexes,
>>>> so I would not expect that it means corruption.
>>>>
>>>> Are dozens of known corruptions that syzkaller can trigger. But
>>>> usually they are reliably caught by KASAN. If any of them would lead
>>>> to silent memory corruption, we would got dozens of assorted crashes
>>>> throughout the kernel. We've seen that at some points, but not
>>>> recently. So I would assume that memory is not corrupted in all these
>>>> cases:
>>>> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
>>>
>>> This BUG clarifies the {+.+.}:
>>>
>>> 4 locks held by kworker/0:145/381:
>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] work_static include/linux/workqueue.h:198 [inline]
>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_data kernel/workqueue.c:619 [inline]
>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] process_one_work+0xb12/0x1bb0 kernel/workqueue.c:2084
>>>  #1:  ((work_completion)(&data->destroy_work)){+.+.}, at: [<00000000bbdd2115>] process_one_work+0xb89/0x1bb0 kernel/workqueue.c:2088
>>>  #2:  (rtnl_mutex){+.+.}, at: [<000000009c9d14f8>] rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>>>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] exp_funnel_lock kernel/rcu/tree_exp.h:272 [inline]
>>>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] _synchronize_rcu_expedited.constprop.72+0x9fa/0xac0 kernel/rcu/tree_exp.h:596
>>>
>>> There we have rtnl_mutex locked and the {..} is like above. It's definitely locked
>>> since there is one more lock after it.
>>>
>>> This BUG happen because of there are many rtnl_mutex waiters while owner
>>> is synchronizing RCU. Rather clear for me in comparison to the topic's hung.
>>
>>
>> You mean that it's not hanged, but rather needs more than 2 minutes to
>> complete, right?
>
> Yeah, I think, this is possible. I've seen the situations like that.
> Let synchronize_rcu_expedited() is executed for X seconds. Then,
> it's need just 120/x calls of "this function under rtnl_mutex" to make
> a soft lockup of someone else who wants the mutex too.
>
> Also, despite the CFS is fair scheduler, in case of the calls are
> made from workqueue, every work will cause sleep. So, every work
> will be executed in separate worker task. Every worker will haved its
> own time slice. This increases the probability these tasks will
> take cpu time before the task in the header of the hang.


OK, let's stick with this theory for now. Looking at the crash frequencies here:
https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
I can actually believe that this is just flakes due to too slow execution.

I've noted that we need either reduce load and/or increase timeouts:
https://github.com/google/syzkaller/issues/516#issuecomment-395685629

Let's keep duping new such reports onto "INFO: task hung in
netdev_run_todo" so that they are all collected at a single location.

Thanks for help

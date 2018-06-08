Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1eE1I4RAGls+VgAAmS7hNA
	; Fri, 08 Jun 2018 08:38:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A4B58608CA; Fri,  8 Jun 2018 08:38:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RG0kItN3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 480B36074D;
	Fri,  8 Jun 2018 08:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 480B36074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeFHIif (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:38:35 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38560 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbeFHIi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:38:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so6060845pgf.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OKMRM6WXvi8xEPX4eqO61sOZg/TkUEjyQgVTRugJiKM=;
        b=RG0kItN38Lvys4foCTJdAtvGPozpmX0DWOcWIna83FkS/+QsEH/JFsOfhb5lj8oaLK
         rFoCa8tbEpd63A4XcbzH2E8DpkSsg+DT7Jp1ujAZKE6Sonw6Z6xeNuLnVkfzZdp9gw7T
         CyY4flN6HRfuRzYjLwwf/8bDdXTcbejeSIFXMo6YGRkKmfYP2bcoD2m3+uyDQkPtFWD9
         3jvLsRHomVBxfWsGq5ZXC+EFnt8EovA7PJosDVdSbFlE9DiWaMv3ZmRb5w8gHC1KFgFI
         9QT/0C2tFkKxhS4Q3K3jjasYzozSqT0MRPNh7YSMXYshMGJskAk8PiE/B1qP/G5FFb9I
         r33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OKMRM6WXvi8xEPX4eqO61sOZg/TkUEjyQgVTRugJiKM=;
        b=jPfhCLIDF9TzOMdmSnQ1ccW3tnL5u+az7dTmbENTmRSFPv9MQ4SUxC6S61Ox7J7ari
         jrm6J0gQiKIwfE6YEiF6m9II+bAGUGw4V712H/QvHYvh5x0tkU38ZnPwUTEqDIlXmpGc
         hB8rr8v9PhcECWuc91wCabTsfgkQvq0Ksv/79Sw21iv91G40zNrCjf2+zno0Tx9ruj3S
         aIZqpZuDr99iMD8TmPsJU4s3LpKkzOQBhR16BpQnd7xJeskJedLyfGlLgOed24g7Ze6n
         kdShvpSxKomKgpH//vZsiVKOUMvATH/KGrhSStKlgz8XaHbn+04iraxKzjDhNdHgDDpF
         8AmA==
X-Gm-Message-State: APt69E2p7pDG1s1QXtrHV8hLa4wJkeJI2aHSfDk8Uyv6ulk3PNFsJ3lg
        MksRcolZiTmsP40RyK71sLGzgIcpOK2OVkHRmO++FA==
X-Google-Smtp-Source: ADUXVKKdx1O/JdZqAwGweVaXOffZ+YHt0k/sq6uw+8JDSkhySWYvg/tUZv2yf/aOSck6NlXoFj8XDrIgzUjEmxnpCSs=
X-Received: by 2002:a63:b407:: with SMTP id s7-v6mr4553684pgf.334.1528447107131;
 Fri, 08 Jun 2018 01:38:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Fri, 8 Jun 2018 01:38:06
 -0700 (PDT)
In-Reply-To: <d544eb27-339b-a7df-3143-08ac0fc9bc69@virtuozzo.com>
References: <0000000000006e4595056dd23c16@google.com> <CACT4Y+ZmxgKvgD2RWD1=KEZQqY=vwdhrAZfqMT-gGuj8k8eKKg@mail.gmail.com>
 <cf729ce5-7948-d475-1b20-f31fb313df88@virtuozzo.com> <CACT4Y+bPrdK7xSeUk=pgVVyaseDZUAvArBA4bEWPsUi7CE3EVw@mail.gmail.com>
 <e71c0df1-d83c-030c-7c97-13a923aca1b3@virtuozzo.com> <CACT4Y+YBY2yGJBHgqGhAcOguag9JUkGkeOz1acgKd=KR3q+noQ@mail.gmail.com>
 <04b6ee08-7919-bf2d-5b77-bd346a0bff48@virtuozzo.com> <CACT4Y+b8FkwFe1PCEVDZcTufB4HKVy+ekk=1_YcFH6-RoBGY-w@mail.gmail.com>
 <6b14e8b9-c335-dd46-98a6-7f58a624fcea@virtuozzo.com> <CACT4Y+a57xaVfph_u78Z+kM8xUF=8fVk-VSA+xqok38Zm4bhFw@mail.gmail.com>
 <d544eb27-339b-a7df-3143-08ac0fc9bc69@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 10:38:06 +0200
Message-ID: <CACT4Y+Zo1e3VFEtXRUToM6Gk_pD7egdi6c-VbAhCOc-=cdfJWA@mail.gmail.com>
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

On Fri, Jun 8, 2018 at 10:31 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>>>>>> Hi, Dmirty!
>>>>>>>>>
>>>>>>>>> On 04.06.2018 18:22, Dmitry Vyukov wrote:
>>>>>>>>>> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
>>>>>>>>>> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>>>>>>>>>>> Hello,
>>>>>>>>>>>
>>>>>>>>>>> syzbot found the following crash on:
>>>>>>>>>>>
>>>>>>>>>>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>>>>>>>>>>> git tree:       upstream
>>>>>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>>>>>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>>>>>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>>>>>>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>>>>>>
>>>>>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>>>>>
>>>>>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>>>>>>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
>>>>>>>>>>
>>>>>>>>>> Another hang on rtnl lock:
>>>>>>>>>>
>>>>>>>>>> #syz dup: INFO: task hung in netdev_run_todo
>>>>>>>>>>
>>>>>>>>>> May be related to "unregister_netdevice: waiting for DEV to become free":
>>>>>>>>>> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9
>>>>>>>>
>>>>>>>> netdev_wait_allrefs does not hold rtnl lock during waiting, so it must
>>>>>>>> be something different.
>>>>>>>>
>>>>>>>>
>>>>>>>>>> Any other explanations for massive hangs on rtnl lock for minutes?
>>>>>>>>>
>>>>>>>>> To exclude the situation, when a task exists with rtnl_mutex held:
>>>>>>>>>
>>>>>>>>> would the pr_warn() from print_held_locks_bug() be included in the console output
>>>>>>>>> if they appear?
>>>>>>>>
>>>>>>>> Yes, everything containing "WARNING:" is detected as bug.
>>>>>>>
>>>>>>> OK, then dead task not releasing the lock is excluded.
>>>>>>>
>>>>>>> One more assumption: someone corrupted memory around rtnl_mutex and it looks like locked.
>>>>>>> (I track lockdep "(rtnl_mutex){+.+.}" prints in initial message as "nobody owns rtnl_mutex").
>>>>>>> There may help a crash dump of the VM.
>>>>>>
>>>>>> I can't find any legend for these +'s and .'s, but {+.+.} is present
>>>>>> in large amounts in just any task hung report for different mutexes,
>>>>>> so I would not expect that it means corruption.
>>>>>>
>>>>>> Are dozens of known corruptions that syzkaller can trigger. But
>>>>>> usually they are reliably caught by KASAN. If any of them would lead
>>>>>> to silent memory corruption, we would got dozens of assorted crashes
>>>>>> throughout the kernel. We've seen that at some points, but not
>>>>>> recently. So I would assume that memory is not corrupted in all these
>>>>>> cases:
>>>>>> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
>>>>>
>>>>> This BUG clarifies the {+.+.}:
>>>>>
>>>>> 4 locks held by kworker/0:145/381:
>>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] work_static include/linux/workqueue.h:198 [inline]
>>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_data kernel/workqueue.c:619 [inline]
>>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
>>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] process_one_work+0xb12/0x1bb0 kernel/workqueue.c:2084
>>>>>  #1:  ((work_completion)(&data->destroy_work)){+.+.}, at: [<00000000bbdd2115>] process_one_work+0xb89/0x1bb0 kernel/workqueue.c:2088
>>>>>  #2:  (rtnl_mutex){+.+.}, at: [<000000009c9d14f8>] rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>>>>>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] exp_funnel_lock kernel/rcu/tree_exp.h:272 [inline]
>>>>>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] _synchronize_rcu_expedited.constprop.72+0x9fa/0xac0 kernel/rcu/tree_exp.h:596
>>>>>
>>>>> There we have rtnl_mutex locked and the {..} is like above. It's definitely locked
>>>>> since there is one more lock after it.
>>>>>
>>>>> This BUG happen because of there are many rtnl_mutex waiters while owner
>>>>> is synchronizing RCU. Rather clear for me in comparison to the topic's hung.
>>>>
>>>>
>>>> You mean that it's not hanged, but rather needs more than 2 minutes to
>>>> complete, right?
>>>
>>> Yeah, I think, this is possible. I've seen the situations like that.
>>> Let synchronize_rcu_expedited() is executed for X seconds. Then,
>>> it's need just 120/x calls of "this function under rtnl_mutex" to make
>>> a soft lockup of someone else who wants the mutex too.
>>>
>>> Also, despite the CFS is fair scheduler, in case of the calls are
>>> made from workqueue, every work will cause sleep. So, every work
>>> will be executed in separate worker task. Every worker will haved its
>>> own time slice. This increases the probability these tasks will
>>> take cpu time before the task in the header of the hang.
>>
>>
>> OK, let's stick with this theory for now. Looking at the crash frequencies here:
>> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
>> I can actually believe that this is just flakes due to too slow execution.
>>
>> I've noted that we need either reduce load and/or increase timeouts:
>> https://github.com/google/syzkaller/issues/516#issuecomment-395685629
>
> Hm, I'm not sure we should hide such the situations from syzbot,
> because the load like this may occur in real life on real workload.
> They may help us to understand whether rtnl_mutex already needs
> a redesign came from this statistics. Also, these hungs may happen
> in a place, which can be rewritten without rtnl_mutex, so we focus
> attention on it.

If somebody wants to act on these reports:
https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
it's even better. The point is that testing must not have false
positives, one way or another. If we do nothing then syzbot will
slowly discover all 250 usages of rtnl_lock and produce unique bugs
for them. Each and every of these bug reports will need to handled by
somebody.

Does somebody want to act on these and improve rtnl performance in
foreseeable future?

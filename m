Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9PDfHKKBGVviCAAAmS7hNA
	; Thu, 07 Jun 2018 19:04:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 592776074D; Thu,  7 Jun 2018 19:04:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4oSOXMu"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F0E3601D2;
	Thu,  7 Jun 2018 19:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F0E3601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeFGTD5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:03:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41380 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeFGTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:03:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id a11-v6so5356964pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hFMWShpEFlI3ORQcrICPvV818pjtu8VjeHt1IJr8xlE=;
        b=D4oSOXMuYDrE6nuUQ2Ut/RwJcItsyUzLgGi5mMyxDOmIvTd+uZF88x+bPnov+4IUkD
         VnXfpaLdDGt7jjtiEY+nAjdIn/xlVKc6dTpGt9VRJArOv5NeOyqm0QFQ+bBW3nY8zWSx
         xMUstdoDJrCkFZD9L6Di74nRcoUSis6HtjDAq4fpy6qvm926MgOxMYAiFp2LURPNl05L
         D+YXmQLkTScgZudMKmRSEJqDr4nROCSGUv3JE9KOvcJUP80HyahJi/Jp0c0H5OgOYMTg
         vj0/Fm5fbQ6A90uWRu3d0nykBqO6gmrpyiG+aXhB4lPWVwk2MZU8Kk5MsOZrNPXQ8vMC
         DDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hFMWShpEFlI3ORQcrICPvV818pjtu8VjeHt1IJr8xlE=;
        b=qMOQqNsVjC1k1Fvj1tmmPH+8DQFJs/cxVJ2qHLMFNfTHLBMpj9Vx7pxr+pPJQpWUdq
         ZvQgUdiWogDbzQdqTEmNTP2b2g68mQyKps77gK+6UOX8ItXiHFomygWcP+ZGI6fMmxaS
         Z9EeQt8HvzRCJCvDdoWcT7dEa+Jm3pFEc0cN4esqz7pIlrJuNXSVIMvlJVvX1JYWiHQK
         SaHpNgHFA4zH6sGtH70CeOeJRiBFs04yvFPWDRUXIeFSQbxZhGdiMGl7ddaNnuMTVhOq
         VL0TKfoejcbcOA1JxhfA48BpgT7xQA03CdsW7AHwadlDTqnzzP7DO+tCIn4ABlwE1/PO
         cmhg==
X-Gm-Message-State: APt69E0cQSlDpklD4GBMoET+1GSmdaXyAOGjoLJGLoGn+DiFzheOC8lv
        zA0KHvV5ejpeNDbW8p9hRJSblsyXZFCUas1yOOZYFQ==
X-Google-Smtp-Source: ADUXVKL5x3nvxa2m2rW2zaLIcW0oK44obScho1K/bfEzDXVFaE122S9svwhdIpg5mxF72CIF+MjJq04sA56X2S9KNeY=
X-Received: by 2002:a63:70a:: with SMTP id 10-v6mr2643128pgh.216.1528398234649;
 Thu, 07 Jun 2018 12:03:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Thu, 7 Jun 2018 12:03:34
 -0700 (PDT)
In-Reply-To: <04b6ee08-7919-bf2d-5b77-bd346a0bff48@virtuozzo.com>
References: <0000000000006e4595056dd23c16@google.com> <CACT4Y+ZmxgKvgD2RWD1=KEZQqY=vwdhrAZfqMT-gGuj8k8eKKg@mail.gmail.com>
 <cf729ce5-7948-d475-1b20-f31fb313df88@virtuozzo.com> <CACT4Y+bPrdK7xSeUk=pgVVyaseDZUAvArBA4bEWPsUi7CE3EVw@mail.gmail.com>
 <e71c0df1-d83c-030c-7c97-13a923aca1b3@virtuozzo.com> <CACT4Y+YBY2yGJBHgqGhAcOguag9JUkGkeOz1acgKd=KR3q+noQ@mail.gmail.com>
 <04b6ee08-7919-bf2d-5b77-bd346a0bff48@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 21:03:34 +0200
Message-ID: <CACT4Y+b8FkwFe1PCEVDZcTufB4HKVy+ekk=1_YcFH6-RoBGY-w@mail.gmail.com>
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

On Thu, Jun 7, 2018 at 8:54 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>> Hi, Dmirty!
>>>>>
>>>>> On 04.06.2018 18:22, Dmitry Vyukov wrote:
>>>>>> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
>>>>>> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> syzbot found the following crash on:
>>>>>>>
>>>>>>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>>>>>>> git tree:       upstream
>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>>
>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>
>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
>>>>>>
>>>>>> Another hang on rtnl lock:
>>>>>>
>>>>>> #syz dup: INFO: task hung in netdev_run_todo
>>>>>>
>>>>>> May be related to "unregister_netdevice: waiting for DEV to become free":
>>>>>> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9
>>>>
>>>> netdev_wait_allrefs does not hold rtnl lock during waiting, so it must
>>>> be something different.
>>>>
>>>>
>>>>>> Any other explanations for massive hangs on rtnl lock for minutes?
>>>>>
>>>>> To exclude the situation, when a task exists with rtnl_mutex held:
>>>>>
>>>>> would the pr_warn() from print_held_locks_bug() be included in the console output
>>>>> if they appear?
>>>>
>>>> Yes, everything containing "WARNING:" is detected as bug.
>>>
>>> OK, then dead task not releasing the lock is excluded.
>>>
>>> One more assumption: someone corrupted memory around rtnl_mutex and it looks like locked.
>>> (I track lockdep "(rtnl_mutex){+.+.}" prints in initial message as "nobody owns rtnl_mutex").
>>> There may help a crash dump of the VM.
>>
>> I can't find any legend for these +'s and .'s, but {+.+.} is present
>> in large amounts in just any task hung report for different mutexes,
>> so I would not expect that it means corruption.
>>
>> Are dozens of known corruptions that syzkaller can trigger. But
>> usually they are reliably caught by KASAN. If any of them would lead
>> to silent memory corruption, we would got dozens of assorted crashes
>> throughout the kernel. We've seen that at some points, but not
>> recently. So I would assume that memory is not corrupted in all these
>> cases:
>> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
>
> This BUG clarifies the {+.+.}:
>
> 4 locks held by kworker/0:145/381:
>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] work_static include/linux/workqueue.h:198 [inline]
>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_data kernel/workqueue.c:619 [inline]
>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] process_one_work+0xb12/0x1bb0 kernel/workqueue.c:2084
>  #1:  ((work_completion)(&data->destroy_work)){+.+.}, at: [<00000000bbdd2115>] process_one_work+0xb89/0x1bb0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<000000009c9d14f8>] rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] exp_funnel_lock kernel/rcu/tree_exp.h:272 [inline]
>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] _synchronize_rcu_expedited.constprop.72+0x9fa/0xac0 kernel/rcu/tree_exp.h:596
>
> There we have rtnl_mutex locked and the {..} is like above. It's definitely locked
> since there is one more lock after it.
>
> This BUG happen because of there are many rtnl_mutex waiters while owner
> is synchronizing RCU. Rather clear for me in comparison to the topic's hung.


You mean that it's not hanged, but rather needs more than 2 minutes to
complete, right?


>> I wonder if it can be just that slow, but not actually hanged... net
>> namespace destruction is super slow, so perhaps under heavy load it
>> all stalls for minutes...

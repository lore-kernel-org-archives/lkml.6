Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id R2BHObZ2GVtaGgAAmS7hNA
	; Thu, 07 Jun 2018 18:23:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2738E606FA; Thu,  7 Jun 2018 18:23:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AciOD5ZB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 77F826063F;
	Thu,  7 Jun 2018 18:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77F826063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936269AbeFGSXi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:23:38 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46241 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936250AbeFGSXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:23:35 -0400
Received: by mail-pg0-f66.google.com with SMTP id d2-v6so5134264pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2XwK6MlJ73L23fApvorVZBra8bnG1OOJYIHOkrR7hiY=;
        b=AciOD5ZBKcy4ogaCg2NURwBfrXONWxCWvjVGJ+JKA9DACF8HqXIau/XriIB71Gdv5B
         9a0q2+6vkoc8O6EQMPzjUZnoB73dpI2+poOlhbIan4LvSkQamwn1dbdqbCaD5NDOcyLL
         lJu6BzCQwMkCYTnMUUL5nYABWXOZtqVk00IzjWpCJzyi3XRTVLc8/9QjwF78C5R/VlPa
         scaBMHvfgTZ/Dq3I5h8GIVXKXXXTl+W3zb8SmJ17Rpg4OKwmWj9aZcVr5aqFLEbsSWHm
         lR/8kBFATH6E6920tgCpTZgwrAtO2GpKfpRYvRQf14RYj9Y92T+3uxGoND/JD2Grpvgt
         atEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2XwK6MlJ73L23fApvorVZBra8bnG1OOJYIHOkrR7hiY=;
        b=BdaOsZmJN0ExK0sCrzQU675KUVKuwjWzV8bHALgz/gmAy8SeCB+fNopiaOFQyyZP6I
         vmVvPgsnlHiqaDXxNZYt8E6xdoTS0cESL9CwbkJCZ5kt+tgzMKq+R3yUyMQTXcM27wUj
         ue38XbFAyzsyxIF2wR6DNh3T/o2wxLQ/qtsj3YP/+bgoZsfc3xk0AA3cv+6P4/h1tUfq
         QCgcPHh8e0omU2vgu7b9bDDK8QvqQ6qLLDd1sON81f4sFUgHOpPAVZMg9ZgAgOPhkHvF
         lCXT/ITnXCYHOcjqFVty/VHUtMfJThAi5flWMpz9i1/N2SzluBU0aCSNnmjhQMyoettO
         pkVg==
X-Gm-Message-State: APt69E2ohABbfeFFTCGUrWrua3Wk8PsrMZ4uJSWU+u5W/sE36EREB+7N
        N/eLUtu4vmzdLhlPFMIO1ehIpBPwU18+g3ma4vfQEg==
X-Google-Smtp-Source: ADUXVKKQQJqMX5Lt5zeRpnHwRYiBV9Ocygoe5Murf140qNmRwaRWOWbmgjlOSa/YLxb+2FcjbWToBSgsRm1xTWpJ35g=
X-Received: by 2002:a63:70a:: with SMTP id 10-v6mr2544071pgh.216.1528395814170;
 Thu, 07 Jun 2018 11:23:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Thu, 7 Jun 2018 11:23:13
 -0700 (PDT)
In-Reply-To: <e71c0df1-d83c-030c-7c97-13a923aca1b3@virtuozzo.com>
References: <0000000000006e4595056dd23c16@google.com> <CACT4Y+ZmxgKvgD2RWD1=KEZQqY=vwdhrAZfqMT-gGuj8k8eKKg@mail.gmail.com>
 <cf729ce5-7948-d475-1b20-f31fb313df88@virtuozzo.com> <CACT4Y+bPrdK7xSeUk=pgVVyaseDZUAvArBA4bEWPsUi7CE3EVw@mail.gmail.com>
 <e71c0df1-d83c-030c-7c97-13a923aca1b3@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 20:23:13 +0200
Message-ID: <CACT4Y+YBY2yGJBHgqGhAcOguag9JUkGkeOz1acgKd=KR3q+noQ@mail.gmail.com>
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

On Tue, Jun 5, 2018 at 3:55 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 05.06.2018 12:36, Dmitry Vyukov wrote:
>> On Tue, Jun 5, 2018 at 11:03 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>> Hi, Dmirty!
>>>
>>> On 04.06.2018 18:22, Dmitry Vyukov wrote:
>>>> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
>>>> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following crash on:
>>>>>
>>>>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>>>>> git tree:       upstream
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>
>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>
>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
>>>>
>>>> Another hang on rtnl lock:
>>>>
>>>> #syz dup: INFO: task hung in netdev_run_todo
>>>>
>>>> May be related to "unregister_netdevice: waiting for DEV to become free":
>>>> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9
>>
>> netdev_wait_allrefs does not hold rtnl lock during waiting, so it must
>> be something different.
>>
>>
>>>> Any other explanations for massive hangs on rtnl lock for minutes?
>>>
>>> To exclude the situation, when a task exists with rtnl_mutex held:
>>>
>>> would the pr_warn() from print_held_locks_bug() be included in the console output
>>> if they appear?
>>
>> Yes, everything containing "WARNING:" is detected as bug.
>
> OK, then dead task not releasing the lock is excluded.
>
> One more assumption: someone corrupted memory around rtnl_mutex and it looks like locked.
> (I track lockdep "(rtnl_mutex){+.+.}" prints in initial message as "nobody owns rtnl_mutex").
> There may help a crash dump of the VM.

I can't find any legend for these +'s and .'s, but {+.+.} is present
in large amounts in just any task hung report for different mutexes,
so I would not expect that it means corruption.

Are dozens of known corruptions that syzkaller can trigger. But
usually they are reliably caught by KASAN. If any of them would lead
to silent memory corruption, we would got dozens of assorted crashes
throughout the kernel. We've seen that at some points, but not
recently. So I would assume that memory is not corrupted in all these
cases:
https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545

I wonder if it can be just that slow, but not actually hanged... net
namespace destruction is super slow, so perhaps under heavy load it
all stalls for minutes...


> Also, there may be a locking code BUG, but this seems the least probable for me.
>
> Kirill

Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C348EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32A021502
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="EtCIKlKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32A021502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbeHOUah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:30:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40896 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHOUag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:30:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so800947pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UA2tkIB82HLEywvQ4mDDzSbEmfmj+7uNtUXu2sVPYXk=;
        b=EtCIKlKeteq0U2rTzuh/2uVoQl6Up9+mFGZMgIZIu2IEV/B2ngh9d0mFnrz/dtz3q8
         bLvx9XGHl8ZZe7MKM+1b48cngis8V7Dy9iDCGOD9IBqzLC8fyBMpWRWh1psj+yDen0qU
         7kF6DxJzlQvj289ihVFz9tRieZ4y9wlSlENawFEy3kxxP6PmIqDVRtbi/eG9Uea6KGNz
         jjHzNQYYVsjn1+NesNq0eqvizaEGb84fT0NEtfaFEEZa2i69s4w/nTXjVqAuZ8vDPxyy
         eo8KmSJnsSh0TOjnxiLe65OlML5Kjcij9slAzaGjL1lqhiffE4QECujBBvxr3TSKAyOx
         Tuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UA2tkIB82HLEywvQ4mDDzSbEmfmj+7uNtUXu2sVPYXk=;
        b=Qt7a0JL+ZGk75NiB+IzyD/U8PqioJOz9PF72zL4sTtME/V/jwfhXaRJSMKyiQJRrPy
         YosDEcCUXkwdmemtqO1iFyEFjhCMjGZOtr+mG8Swa3XJdHSPo3HD5RJM0mnkdfEMUFUl
         mYqnUqWBLbQZcznA0wR3ahaCkNTeWnYtDMk2bJv4C+3IMiXWv85keBut/GZKyhE5z0kq
         v3Xk+MAmUE9Lw91BLuoIETZhoIzwmwhKMNKOdrJTMHr137nEfrm6njdaw7FRZR8M7kRL
         Jogat/L9NjKJxaULz2ZvyeIehIqTvigWh5oX6fPGenne0kSLwwTdQo806F0hN5ZjDfBx
         cnww==
X-Gm-Message-State: AOUpUlE5x2Fn+Q/ebf0A8xgRtKkYjZ2orYJuLUv7mwdLMKE3gEmSuLSc
        5flEZBe/MBOu58SN/1hQFd4k6A==
X-Google-Smtp-Source: AA+uWPxjZ1QnJMkjHsxExoEUSEhpSphWMVtJVTHb6yIQA6/uNOvhF7wsXUH4PzlyDq+78Tt1iuWPbg==
X-Received: by 2002:a65:4304:: with SMTP id j4-v6mr26614895pgq.109.1534354651294;
        Wed, 15 Aug 2018 10:37:31 -0700 (PDT)
Received: from ?IPv6:2600:1010:b010:3fbd:7d76:67ee:fa0f:6b7f? ([2600:1010:b010:3fbd:7d76:67ee:fa0f:6b7f])
        by smtp.gmail.com with ESMTPSA id b76-v6sm45398941pfj.184.2018.08.15.10.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 10:37:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CALvZod7TDLtr-DgqgW_0tOKei_54U1JHThpgLKr9_ObaqcC3MA@mail.gmail.com>
Date:   Wed, 15 Aug 2018 10:37:28 -0700
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Michal Hocko <mhocko@kernel.org>, luto@kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19CD1E5B-CB86-493A-8BA6-7389E36291B4@amacapital.net>
References: <20180815003620.15678-1-guro@fb.com> <20180815163923.GA28953@cmpxchg.org> <20180815165513.GA26330@castle.DHCP.thefacebook.com> <2393E780-2B97-4BEE-8374-8E9E5249E5AD@amacapital.net> <20180815172557.GC26330@castle.DHCP.thefacebook.com> <CALvZod7TDLtr-DgqgW_0tOKei_54U1JHThpgLKr9_ObaqcC3MA@mail.gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 15, 2018, at 10:32 AM, Shakeel Butt <shakeelb@google.com> wrote:
>=20
>> On Wed, Aug 15, 2018 at 10:26 AM Roman Gushchin <guro@fb.com> wrote:
>>=20
>>> On Wed, Aug 15, 2018 at 10:12:42AM -0700, Andy Lutomirski wrote:
>>>=20
>>>=20
>>>>> On Aug 15, 2018, at 9:55 AM, Roman Gushchin <guro@fb.com> wrote:
>>>>>=20
>>>>>> On Wed, Aug 15, 2018 at 12:39:23PM -0400, Johannes Weiner wrote:
>>>>>> On Tue, Aug 14, 2018 at 05:36:19PM -0700, Roman Gushchin wrote:
>>>>>> @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(st=
ruct task_struct *tsk, int node)
>>>>>>       return s->addr;
>>>>>>   }
>>>>>>=20
>>>>>> +    /*
>>>>>> +     * Allocated stacks are cached and later reused by new threads,
>>>>>> +     * so memcg accounting is performed manually on assigning/releas=
ing
>>>>>> +     * stacks to tasks. Drop __GFP_ACCOUNT.
>>>>>> +     */
>>>>>>   stack =3D __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
>>>>>>                    VMALLOC_START, VMALLOC_END,
>>>>>> -                     THREADINFO_GFP,
>>>>>> +                     THREADINFO_GFP & ~__GFP_ACCOUNT,
>>>>>>                    PAGE_KERNEL,
>>>>>>                    0, node, __builtin_return_address(0));
>>>>>>=20
>>>>>> @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(s=
truct task_struct *tsk, int node)
>>>>>> #endif
>>>>>> }
>>>>>>=20
>>>>>> +static void memcg_charge_kernel_stack(struct task_struct *tsk)
>>>>>> +{
>>>>>> +#ifdef CONFIG_VMAP_STACK
>>>>>> +    struct vm_struct *vm =3D task_stack_vm_area(tsk);
>>>>>> +
>>>>>> +    if (vm) {
>>>>>> +        int i;
>>>>>> +
>>>>>> +        for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
>>>>>> +            memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
>>>>>> +                      compound_order(vm->pages[i]));
>>>>>> +
>>>>>> +        /* All stack pages belong to the same memcg. */
>>>>>> +        mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
>>>>>> +                     THREAD_SIZE / 1024);
>>>>>> +    }
>>>>>> +#endif
>>>>>> +}
>>>>>=20
>>>>> Before this change, the memory limit can fail the fork, but afterwards=

>>>>> fork() can grow memory consumption unimpeded by the cgroup settings.
>>>>>=20
>>>>> Can we continue to use try_charge() here and fail the fork?
>>>>=20
>>>> We can, but I'm not convinced we should.
>>>>=20
>>>> Kernel stack is relatively small, and it's already allocated at this po=
int.
>>>> So IMO exceeding the memcg limit for 1-2 pages isn't worse than
>>>> adding complexity and handle this case (e.g. uncharge partially
>>>> charged stack). Do you have an example, when it does matter?
>>>=20
>>> What bounds it to just a few pages?  Couldn=E2=80=99t there be lots of f=
orks in flight that all hit this path?  It=E2=80=99s unlikely, and there are=
 surely easier DoS vectors, but still.
>>=20
>> Because any following memcg-aware allocation will fail.
>> There is also the pid cgroup controlled which can be used to limit the nu=
mber
>> of forks.
>>=20
>> Anyway, I'm ok to handle the this case and fail fork,
>> if you think it does matter.
>=20
> Roman, before adding more changes do benchmark this. Maybe disabling
> the stack caching for CONFIG_MEMCG is much cleaner.
>=20
>=20

Unless memcg accounting is colossally slow, the caching should be left on. v=
malloc() isn=E2=80=99t inherently slow, but vfree() is, since we need to do a=
 global broadcast TLB flush after enough vfree() calls.=

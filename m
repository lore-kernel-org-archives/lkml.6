Return-Path: <SRS0=DTvY=F6=gmail.com=jiangshanlai@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-408726-1520468999-2-10424713158989377609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=DTvY=F6=gmail.com=jiangshanlai@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520468997; b=P6lGMK+rGTNcC4qjG+/gPV9VPgm1VBUfscYzSgtzmdD/+Ie
    Cvyykaf92Wm9dwmZIb5q93+UOVEgA2boxTvKuFvfyY9GtyNnUzuJrNdkibNs+cC/
    pMETmDPT9ZcBKuqGHap7mahyqBkbB5Vc+kCj64ct6lgsL/G7eXZjPIsTVIyFGgod
    M3I55bt74OIr3D5DPlFdHQ6oFG27P33ttzbVfhKC2zHPvtoWucijWziDJnPFAnUP
    GCidMR5zORbvd3zzRG5Du3wdisplEnJDG8iGnstVAlV6wlBuTLwQ+f5MEh2F4mpJ
    swtR2ApjuT8TbVnSIWYzRJUrZ9L1P6sIcktPqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1520468997; bh=b7Atjb3/Cn8uhXMIhl6D3zKcvUw79heaG8esWd
    5XXV8=; b=EnX2YxV8pFRiuWu57oydUzPZodDMUwdtI0903P7LtgE5AZUs7xAazP
    KTxz8jNVH+6pjwz9ZSgw4NU6kU5xhq5CNYtNMhlvM4zrL6T2n3OLWorhn8WsYbcV
    4d/Upvw4QUeZ5gkKQkF0XyyucW1Va+34FLoCEUqzBFabgkW+uNP363PpXfw0ThjM
    lNTnT2kBQD/m/tJdmRz/REGxoHTXD0asAC2RZ+IA+Lh0c6lqBS7WRoMFGyh3inOZ
    T3PWslWCMAjFeUp8n83vj4w9WLWfS39unRP+CQzCjXfaB522CIrR2X0oRdcSuzZg
    eJxNQGuF+uDSubBSsZPGtQtj0SmfKFTg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=P2hUtp6l x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=DTvY=F6=gmail.com=jiangshanlai@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rMIC6to9;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=P2hUtp6l x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=DTvY=F6=gmail.com=jiangshanlai@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rMIC6to9;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FFA205F4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=jiangshanlai@gmail.com
X-Google-Smtp-Source: AG47ELsPKob6DWCnwajhnz7pyNF1w2b4sVVOvLVY9IjqE+suYjCvbNDwWeQh5N3WBmKlsFue6igaGfUzNMV9CsGcFtA=
MIME-Version: 1.0
Sender: jiangshanlai@gmail.com
In-Reply-To: <20180307145408.GC3918@linux.vnet.ibm.com>
References: <20180306172657.3060270-1-tj@kernel.org> <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-7-tj@kernel.org> <CAJhGHyAuz3TRCpPnCBzZ+om3k9N3ykCWYOq_bv+hucV=XXiY9w@mail.gmail.com>
 <20180307145408.GC3918@linux.vnet.ibm.com>
From: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date: Thu, 8 Mar 2018 08:29:53 +0800
X-Google-Sender-Auth: 5N6FE972owGHOrjp14CjfLmu6Oc
Message-ID: <CAJhGHyDEpXG88uDHiogxUH0Yp5sU3v1p-kUSvJbGYCZ+HGucvQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] RCU, workqueue: Implement rcu_work
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
	Jann Horn <jannh@google.com>, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	Kent Overstreet <kent.overstreet@gmail.com>, security@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 10:54 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Wed, Mar 07, 2018 at 10:49:49AM +0800, Lai Jiangshan wrote:
>> On Wed, Mar 7, 2018 at 1:33 AM, Tejun Heo <tj@kernel.org> wrote:
>>
>> > +/**
>> > + * queue_rcu_work_on - queue work on specific CPU after a RCU grace period
>> > + * @cpu: CPU number to execute work on
>> > + * @wq: workqueue to use
>> > + * @rwork: work to queue
>>
>> For many people, "RCU grace period" is clear enough, but not ALL.
>>
>> So please make it a little more clear that it just queues work after
>> a *Normal* RCU grace period. it supports only one RCU variant.
>>
>>
>> > + *
>> > + * Return: %false if @work was already on a queue, %true otherwise.
>> > + */
>>
>> I'm afraid this will be a hard-using API.
>>
>> The user can't find a plan B when it returns false, especially when
>> the user expects the work must be called at least once again
>> after an RCU grace period.
>>
>> And the error-prone part of it is that, like other queue_work() functions,
>> the return value of it is often ignored and makes the problem worse.
>>
>> So, since workqueue.c provides this API, it should handle this
>> problem. For example, by calling call_rcu() again in this case, but
>> everything will be much more complex: a synchronization is needed
>> for "calling call_rcu() again" and allowing the work item called
>> twice after the last queue_rcu_work() is not workqueue style.
>
> I confess that I had not thought of this aspect, but doesn't the
> rcu_barrier() in v2 of this patchset guarantee that it has passed
> the RCU portion of the overall wait time?  Given that, what I am
> missing is now this differs from flush_work() on a normal work item.
>
> So could you please show me the sequence of events that leads to this
> problem?  (Again, against v2 of this patch, which replaces the
> synchronize_rcu() with rcu_barrier().)

I mentioned a subtle use case that user would think it is supported
since the comment doesn't disallow it.

It is clear that the user expects
   the work must be called at least once after the API returns
   the work must be called after an RCU grace period

But in the case when the user expects the work must be called
at least once again after "queue_rcu_work() + an RCU grace period",
the API is not competent to it if the work is queued.
Although the user can detect it by the return value of
queue_rcu_work(), the user hardly makes his expectation
happen by adding appropriate code.

>
>> Some would argue that the delayed_work has the same problem
>> when the user expects the work must be called at least once again
>> after a period of time. But time interval is easy to detect, the user
>> can check the time and call the queue_delayed_work() again
>> when needed which is also a frequent design pattern. And
>> for rcu, it is hard to use this design pattern since it is hard
>> to detect (new) rcu grace period without using call_rcu().
>>
>> I would not provide this API. it is not a NACK. I'm just trying
>> expressing my thinking about the API. I'd rather RCU be changed
>> and RCU callbacks are changed to be sleepable. But a complete
>> overhaul cleanup on the whole source tree for compatibility
>> is needed at first, an even more complex job.
>
> One downside of allowing RCU callback functions to sleep is that
> one poorly written callback can block a bunch of other ones.
> One advantage of Tejun's approach is that such delays only affect
> the workqueues, which are already designed to handle such delays.
>
>                                                 Thanx, Paul
>
>> > +bool queue_rcu_work_on(int cpu, struct workqueue_struct *wq,
>> > +                      struct rcu_work *rwork)
>> > +{
>> > +       struct work_struct *work = &rwork->work;
>> > +
>> > +       if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
>> > +               rwork->wq = wq;
>> > +               rwork->cpu = cpu;
>> > +               call_rcu(&rwork->rcu, rcu_work_rcufn);
>> > +               return true;
>> > +       }
>> > +
>> > +       return false;
>> > +}
>> > +EXPORT_SYMBOL(queue_rcu_work_on);
>> > +
>>
>

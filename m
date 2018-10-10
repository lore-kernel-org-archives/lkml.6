Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA4BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C260A20835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwgTyaoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C260A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJJRHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:07:16 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40370 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:07:15 -0400
Received: by mail-it1-f196.google.com with SMTP id i191-v6so7037515iti.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T/Xtc4JDuPxLBVIUSEO2sIVKU497WYVgDA5LVpanvf4=;
        b=PwgTyaooIHS2IjwWMOedtgGe6bNThHX+ncPldx4G0WfvISb6y5ABK/ddIUoShe7ZIV
         X9FrlRRwZBDN0HOZa2Dul3Q2VHabWJZA5jTfwzoOD69Cifj/Lq2GWMMu3dBtpn8R9Gr6
         hRfIB4Hq6TJznQOrijCj5aKlD2fMxTNnai1aWgyzwldwGq0CpvXL2GCysSiE7hO0oisd
         Znt+7wuskn9QFhcHkdHPKfE9VMv9YoOlt1983fh55KFHPQxX0tMitvoS7VtkQD5GSXLr
         bpuAvQwILwDlDHK0yO/l5/A2zqP6DBpfPOwZgDr0LNPBV0E3dpWSK0vEcepv2eihhQPk
         eDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T/Xtc4JDuPxLBVIUSEO2sIVKU497WYVgDA5LVpanvf4=;
        b=ShAjXlvUff3EW/VXGDAjR0yty0pLgp6KCvf9kqsuIePR5Khwm15/HnVMvNSWasJUjd
         qggLmeduotpFPkDLlbyr9PMUvDFtlohmRKg98DDZq4ygw6vIYO3vLWOsViNbz6P/Fwug
         4vSHizY7PybGoXZVpHCLYuPVgscGn6bKkPedTgGMOW6gCryCJBrP9SdDdUYjnVVQc2cB
         pgu78SLZnGgq5zTSZBxxCVix9gA2yYWt6ZGA+FjVX8e5RQrzBwoT3vUxgjk/RU0Tq5bM
         z2JNsYoS/VxTEwcC4uNkxqd/NTfvYLzb7Ps5w/5zxpyNxg1DMOe6MPESzRaT3s3gWYUu
         bwVg==
X-Gm-Message-State: ABuFfogeBeLp3FXyIVDbTp0Yvj2WtKCQHbSZ48lOgho+4OGkxgan9zIF
        BS9on7jxBQdgEFNATkNkU7SNI6Si71znsxtF5ae/Dg==
X-Google-Smtp-Source: ACcGV62OBLCfMrJKmdx0SKWiroVRN8oC3O2xxkqmcNzKu02UGmpbXqQq7f0577WM1xVaxpSsDQXoJ25X2vGa7Bqab8Y=
X-Received: by 2002:a24:940f:: with SMTP id j15-v6mr163814ite.12.1539164753019;
 Wed, 10 Oct 2018 02:45:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 02:45:32
 -0700 (PDT)
In-Reply-To: <20181010092929.a5gd3fkkw6swco4c@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com> <20181005163018.icbknlzymwjhdehi@linutronix.de>
 <20181005163320.zkacovxvlih6blpp@linutronix.de> <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
 <20181009142742.ikh7xv2dn5skjjbe@linutronix.de> <CACT4Y+ZB38pKvT8+BAjDZ1t4ZjXQQKoya+ytXT+ASQxHUkWwnA@mail.gmail.com>
 <20181010092929.a5gd3fkkw6swco4c@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 11:45:32 +0200
Message-ID: <CACT4Y+agGPSTZ-8A8r8haSeRM8UpRYMAF8BC4A87yeM9nvpP6w@mail.gmail.com>
Subject: Re: [PATCH] kasan: convert kasan/quarantine_lock to raw_spinlock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:29 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-10-10 10:25:42 [+0200], Dmitry Vyukov wrote:
>> > That loop should behave like your on_each_cpu() except it does not
>> > involve the remote CPU.
>>
>>
>> The problem is that it can squeeze in between:
>>
>> +               spin_unlock(&q->lock);
>>
>>                 spin_lock(&quarantine_lock);
>>
>> as far as I see. And then some objects can be left in the quarantine.
>
> Okay. But then once you are at CPU10 (in the on_each_cpu() loop) there
> can be objects which are added to CPU0, right? So based on that, I
> assumed that this would be okay to drop the lock here.

What happens here is a bit tricky.

When a kmem cache is freed, all objects from the cache must be already
free. That is kmem_cache_free has returned for all objects (otherwise
it's a user bug), these calls could have have happened on other CPUs.
So is we are freeing a cache on CPU10, it is not possible that CPU0
frees an object from this cache right now/concurrently, the objects
were already freed but they still can be sitting in per-cpu quarantine
caches.
Now a free on an unrelated object on CPU0 can decide to drain CPU
cache concurrently, it grabs whole CPU cache, unlocks the cache
spinlock (with your patch), and now proceeds to pushing the batch to
global quarantine list. At this point CPU10 drains quarantine to evict
all objects related to the cache, but it misses the batch that CPU0
transfers from cpu cache to global quarantine, because at this point
it's referenced from just local stack variable temp in quarantine_put.
Wrapping the whole transfer sequence with irq disable/enable, ensures
that the transfer happens atomically wrt quarantine_remove_cache. That
is, that quarantine_remove_cache will see the object either in cpu
cache or in global quarantine, but not somewhere in the flight.


>> > But this is debug code anyway, right? And it is highly complex imho.
>> > Well, maybe only for me after I looked at it for the first time=E2=80=
=A6
>>
>> It is debug code - yes.
>> Nothing about its performance matters - no.
>>
>> That's the way to produce unusable debug tools.
>> With too much overhead timeouts start to fire and code behaves not the
>> way it behaves in production.
>> The tool is used in continuous integration and developers wait for
>> test results before merging code.
>> The tool is used on canary devices and directly contributes to usage exp=
erience.
>
> Completely understood. What I meant is that debug code in general (from
> RT perspective) increases latency to a level where the device can not
> operate. Take lockdep for instance. Debug facility which is required
> for RT as it spots locking problems early. It increases the latency
> (depending on the workload) by 50ms+ and can't be used in production.
> Same goes for SLUB debug and most other.
>
>> We of course don't want to trade a page of assembly code for cutting
>> few cycles here (something that could make sense for some networking
>> code maybe). But otherwise let's not introduce spinlocks on fast paths
>> just for refactoring reasons.
>
> Sure. As I said. I'm fine with patch Clark initially proposed. I assumed
> the refactoring would make things simpler and avoiding the cross-CPU
> call a good thing.
>
>> > Can you take it as-is or should I repost it with an acked-by?
>>
>> Perhaps it's the problem with the way RT kernel changes things then?
>> This is not specific to quarantine, right?
>
> We got rid of _a lot_ of local_irq_disable/save() + spin_lock() combos
> which were there for reasons which are no longer true or due to lack of
> the API. And this kasan thing is just something Clark stumbled upon
> recently. And I try to negotiate something where everyone can agree on.
>
>> Should that mutex detect
>> that IRQs are disabled and not try to schedule? If this would happen
>> in some networking code, what would we do?
>
> It is not only that it is supposed not to schedule. Assuming the "mutex"
> is not owned you could acquire it right away. No scheduling. However,
> you would record current() as the owner of the lock which is wrong and
> you get into other trouble later on. The list goes on :)
> However, networking. If there is something that breaks then it will be
> addressed. It will be forwarded upstream if this something where it
> is likely to assume that RT won't change. So networking isn't special.
>
> Should I repost Clark's patch?


I am much more comfortable with just changing the type of the lock.
What are the bad implications of using the raw spinlock? Will it help
to do something along the following lines:

// Because of ...
#if CONFIG_RT
#define quarantine_spinlock_t raw_spinlock_t
#else
#define quarantine_spinlock_t spinlock_t
#endif

?

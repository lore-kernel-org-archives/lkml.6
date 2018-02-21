Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591082-1519254279-2-10767052711735148536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519254278; b=nAh7rdv3FOWr2Wbl+hh4HiELMQg23SL/ZNflboTDfE+R1Qq
    pZTnKGV6WYPIdGRuGv6OcmAKZi4V93oHNIfPUDgJYWBWPNyskaLnNlSi49djmMVL
    VgWlWBoOO6mKgpRY0L+hMcDwPatb0kiWXB+c2d27b4xD4NRwLns8OkDp8PzmaiSg
    z3s1d21XCFI8lf3u6LR5Hf70nnVZdXj3IEYJL+3ei4/jONlqPUUV2bETK86mFuVk
    aJBkGCgjojIWi68oVqapeJ2+fVUQARMuWwtq9NeHlJcasf+sUiLaU18gnmbBvgAg
    R/beWg9fIo0mZ5GdGuDVIyxIjgIViNM/VfTfedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519254278; bh=dejs7K5vK1WHfQOBuMoFJphPbmj3ASdoP34RAH
    N+9Mk=; b=FyIldpFX1YHUpKLY6PYMKhJ6J5K2OyTl65UkyvKa1Wr/uCaOBodiU9
    4aNFgT2x7hryGMsguK+yeK6Z+gWjlxI4vIDYs86nmgI0QPxWRIJ1qA3OWnWlOvMC
    3RFeJvGCuV4zY178X7t+54PQOal2VxRO+1RXApMHDSSEaZSyHwitK5FZ3w5L63qw
    wQyWUCp3Ot4VPJwLBBAEUtayygraebxwo6N0hpGjp3MyEhey+sZQ0jTY4JDfCTmB
    eys2v05u/b79TN9doqFNYgOVwUvGeW/OBLhy7BwwciGhiHMoaSE1UeE4nWlRLJ10
    HDS9mIM/2Ztm7JPouXex0yIZC8A1hk0g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=B1WLwtU4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HjbiKW8+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=B1WLwtU4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HjbiKW8+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeBUXEf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 18:04:35 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41219 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBUXEd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 18:04:33 -0500
X-Google-Smtp-Source: AH8x227WczXSqp4nPaIUndqhNRPFOptrWZbwF4MLQ2LGL5Cd1LhcViURoXIo0uwWqr7jICj4y11VbUHiNGC64zadW7U=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180221084601.scnvgiiv32s2pgye@gmail.com>
References: <20170328122915.640228468@linuxfoundation.org> <20170328122918.597715642@linuxfoundation.org>
 <20180220123757.GE25314@hirez.programming.kicks-ass.net> <CAHC9VhTOxzcJpVSFDign56jkkruQjujTp7GQzk107FNWYTXRYg@mail.gmail.com>
 <20180220140640.GE25201@hirez.programming.kicks-ass.net> <CAHC9VhS40=qNxjNJSBqz2GwrqrvTqLKpdOWUrJ5iUDFp8ERO-A@mail.gmail.com>
 <20180220151849.GG25201@hirez.programming.kicks-ass.net> <CAHC9VhQUGF+W0sZemeCstPDUHxwQrD7Pmbu5SnAHZVdkCPdMwg@mail.gmail.com>
 <20180221084601.scnvgiiv32s2pgye@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Feb 2018 18:04:30 -0500
Message-ID: <CAHC9VhSL3MAA75su=J3Q551xfqphwiv9=FbaN8M18-zVrtP==g@mail.gmail.com>
Subject: Re: [PATCH 4.10 070/111] audit: fix auditd/kernel connection state tracking
To: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, linux-audit@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 3:46 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Paul Moore <paul@paul-moore.com> wrote:
>
>> On Tue, Feb 20, 2018 at 10:18 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Tue, Feb 20, 2018 at 09:51:08AM -0500, Paul Moore wrote:
>> >> On Tue, Feb 20, 2018 at 9:06 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> >
>> >> > It's not at all clear to me what that code does, I just stumbled upon
>> >> > __mutex_owner() outside of the mutex code itself and went WTF.
>> >>
>> >> If you don't want people to use __mutex_owner() outside of the mutex
>> >> code I might suggest adding a rather serious comment at the top of the
>> >> function, because right now I don't see anything suggesting that
>> >> function shouldn't be used.  Yes, there is the double underscore
>> >> prefix, but that can mean a few different things these days.
>> >
>> > Find below.
>> >
>> >> > The comment (aside from having the most horribly style) ...
>> >>
>> >> Yeah, your dog is ugly too.  Notice how neither comment is constructive?
>> >
>> > I'm sure you've seen this one:
>> >
>> >   https://lkml.org/lkml/2016/7/8/625
>>
>> Yep.  I stand behind my earlier comment in this thread.
>>
>> >> > Maybe if you could explain how that code is supposed to work and why it
>> >> > doesn't know if it holds a lock I could make a suggestion...
>> >>
>> >> I just spent a few minutes looking back over the bits available in
>> >> include/linux/mutex.h and I'm not seeing anything beyond
>> >> __mutex_owner() which would allow us to determine the mutex owning
>> >> task.  It's probably easiest for us to just track ownership ourselves.
>> >> I'll put together a patch later today.
>> >
>> > Note that up until recently the mutex implementation didn't even have a
>> > consistent owner field. And the thing is, it's very easy to use wrong,
>> > only today I've seen a patch do: "__mutex_owner() == task", where task
>> > was allowed to be !current, which is just wrong.
>>
>> Arguably all the more reason why a strongly worded warning is
>> important (which I see you've included below, feel free to include my
>> Reviewed-by).
>>
>> > Looking through kernel/audit.c I'm not even sure I see how you would end
>> > up in audit_log_start() with audit_cmd_mutex held.
>> >
>> > Can you give me a few code paths that trigger this? Simple git-grep is
>> > failing me.
>>
>> Basically look at the code in audit_receive_msg(), but I wasn't asking
>> your opinion on how we should rewrite the audit subsystem, I was just
>> asking how one could determine if the current task was holding a given
>> mutex in a way that was acceptable to you.  Based on your comments,
>> and some further inspection of the mutex code, it appears that is/was
>> not something that the core mutex code wants to support/make-visible.
>> Which is perfectly fine, I just wanted to make sure I wasn't missing
>> something before I went ahead and wrote a wrapper around the mutex
>> code for use by audit.
>>
>> FWIW, I just put together the following patch which removes the
>> __mutex_owner() call from audit and doesn't appear to break anything
>> on the audit side (you're CC'd on the patch).  It has only been
>> lightly tested, but I'm going to bang on it for a day or so and if I
>> hear no objections I'll merge it into audit/next.
>>
>> * https://www.redhat.com/archives/linux-audit/2018-February/msg00066.html
>
> Could you please explain the audit_ctl_lock()/unlock() primitive you are
> introducing there? You seem to be implementing some sort of recursive locking
> primitive, but in a strange way.
>
> AFAICS the primary problem appears to be this code path:
>
>   audit_receive() -> audit_receive_msg() -> AUDIT_TTY_SET -> audit_log_common_recv_msg() -> audit_log_start()
>
> where we can arrive already holding the lock.
>
> I.e. recursive mutex, kinda.
>
> What's the thinking there? Neither the changelog nor the code explains this.

I don't really go into great detail in the changelog, or comments in
the code, because I'm not really doing anything new with respect to
locking in this commit.  The patch simply wraps the existing
mutex_{lock,unlock}() calls so that we can track the mutex owner.  It
doesn't fundamentally change the locking, it's a quick patch to get
rid our our __mutex_owner() usage as Peter doesn't want anyone,
outside the mutex code, to use that function.

Based on your comments above, I'm guessing some of the
misunderstanding comes from the
__mutex_owner()/audit_ctl_owner_current() call in audit_log_start().
We try to determine the mutex/lock owner in audit_log_start() not
because we are trying to avoid a recursive lock, we do the check as an
optimization to skip the normal queue managment so that the lock
holder isn't subject to the same rescheduling/queue-management (is
"queue calming" a term?) as regular tasks.

-- 
paul moore
www.paul-moore.com

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3351714-1519146392-2-3187454176959549204
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519146392; b=r2WYoWNizXDLfZ28kdaYWJJSIhscpyoy6I1/10kh2Uyod1i
    Yaz3a5K0dMaH8O44oixFp3/ae6AVU86UwSS15v/aW/Yna4DtafXUKjaIIgxfFqhG
    OuFp/PX2XodVz6EcQv7qy1YtR70h2ohdrE+L5xiF8j3NwVxQpQYvV7hnKMRC2ObM
    JoDA8qPPJ3UD2Wppu5vMvJV9Y3JADU887n6SRuCgUK6IWSAesiarUq2+LTTJbBb6
    s1AM0tkiYMOBW1tHrDMYM8+oXPhSCK24qrmDr1Kjm/KLtbV224zAOCZXv/mo/GVM
    W4a1EsXgqPvBoyHoZtkBnOCIPwEIWQf7d8Xh5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519146392; bh=8Gyz1lrbxrqYTyrjmsmqTiPpEpPMFGYHCYlApv
    vq+Jc=; b=ptOCFrFOv1H/4qGK/63Nlc1L9wS3n1+nd7X0ZnaGJY/1lNms/TxwYO
    gAoOBwP7agx5J8s5xuNAWzstD6m7iZuTWuS1veuT3KtdXv1J0HLztU8gdrjCSMLN
    XU5ksyg3/2l/wA3x6hJhtAEnp2Qx/X5UTp4mIZ76qRnabLutSAE6eol1XavnUS0t
    ZSk6EsfFvPzA4QO4IHM7HTBZp3kVpBp16tSxQeBtPIKdnKDdZafp6+zvYUZpwlUc
    2IbO9eiD1/b4z3rmo41hQnKlCrjX44jz2kSGdt8E5HnBxWl51aQ384tWFSYNQibc
    aFfVpS0TNLoMEO1wghjqnSeN/MrMDdeQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=xRphzJsK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gGGxgSQd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=xRphzJsK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gGGxgSQd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbeBTRGa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 12:06:30 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38029 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbeBTRG3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 12:06:29 -0500
X-Google-Smtp-Source: AH8x224vo/yqn/qfpJzvw+UkGq1SgUzESzJgq4ilwLesQUcxPZskZXuYnyeLylftuaZmUJaP4ma8Mz5QWkZ4Ucc2C4k=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180220151849.GG25201@hirez.programming.kicks-ass.net>
References: <20170328122915.640228468@linuxfoundation.org> <20170328122918.597715642@linuxfoundation.org>
 <20180220123757.GE25314@hirez.programming.kicks-ass.net> <CAHC9VhTOxzcJpVSFDign56jkkruQjujTp7GQzk107FNWYTXRYg@mail.gmail.com>
 <20180220140640.GE25201@hirez.programming.kicks-ass.net> <CAHC9VhS40=qNxjNJSBqz2GwrqrvTqLKpdOWUrJ5iUDFp8ERO-A@mail.gmail.com>
 <20180220151849.GG25201@hirez.programming.kicks-ass.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Feb 2018 12:06:26 -0500
Message-ID: <CAHC9VhQUGF+W0sZemeCstPDUHxwQrD7Pmbu5SnAHZVdkCPdMwg@mail.gmail.com>
Subject: Re: [PATCH 4.10 070/111] audit: fix auditd/kernel connection state tracking
To: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:18 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Feb 20, 2018 at 09:51:08AM -0500, Paul Moore wrote:
>> On Tue, Feb 20, 2018 at 9:06 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
>> > It's not at all clear to me what that code does, I just stumbled upon
>> > __mutex_owner() outside of the mutex code itself and went WTF.
>>
>> If you don't want people to use __mutex_owner() outside of the mutex
>> code I might suggest adding a rather serious comment at the top of the
>> function, because right now I don't see anything suggesting that
>> function shouldn't be used.  Yes, there is the double underscore
>> prefix, but that can mean a few different things these days.
>
> Find below.
>
>> > The comment (aside from having the most horribly style) ...
>>
>> Yeah, your dog is ugly too.  Notice how neither comment is constructive?
>
> I'm sure you've seen this one:
>
>   https://lkml.org/lkml/2016/7/8/625

Yep.  I stand behind my earlier comment in this thread.

>> > Maybe if you could explain how that code is supposed to work and why it
>> > doesn't know if it holds a lock I could make a suggestion...
>>
>> I just spent a few minutes looking back over the bits available in
>> include/linux/mutex.h and I'm not seeing anything beyond
>> __mutex_owner() which would allow us to determine the mutex owning
>> task.  It's probably easiest for us to just track ownership ourselves.
>> I'll put together a patch later today.
>
> Note that up until recently the mutex implementation didn't even have a
> consistent owner field. And the thing is, it's very easy to use wrong,
> only today I've seen a patch do: "__mutex_owner() == task", where task
> was allowed to be !current, which is just wrong.

Arguably all the more reason why a strongly worded warning is
important (which I see you've included below, feel free to include my
Reviewed-by).

> Looking through kernel/audit.c I'm not even sure I see how you would end
> up in audit_log_start() with audit_cmd_mutex held.
>
> Can you give me a few code paths that trigger this? Simple git-grep is
> failing me.

Basically look at the code in audit_receive_msg(), but I wasn't asking
your opinion on how we should rewrite the audit subsystem, I was just
asking how one could determine if the current task was holding a given
mutex in a way that was acceptable to you.  Based on your comments,
and some further inspection of the mutex code, it appears that is/was
not something that the core mutex code wants to support/make-visible.
Which is perfectly fine, I just wanted to make sure I wasn't missing
something before I went ahead and wrote a wrapper around the mutex
code for use by audit.

FWIW, I just put together the following patch which removes the
__mutex_owner() call from audit and doesn't appear to break anything
on the audit side (you're CC'd on the patch).  It has only been
lightly tested, but I'm going to bang on it for a day or so and if I
hear no objections I'll merge it into audit/next.

* https://www.redhat.com/archives/linux-audit/2018-February/msg00066.html

> ---
> Subject: mutex: Add comment to __mutex_owner()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Feb 20 16:01:36 CET 2018
>
> Attempt to deter usage, this is not a public interface. It is entirely
> possibly to implement a conformant mutex without having this owner
> field (in fact, we used to have that).
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -66,6 +66,11 @@ struct mutex {
>  #endif
>  };
>
> +/*
> + * Internal helper function; C doesn't allow us to hide it :/
> + *
> + * DO NOT USE (outside of mutex code).
> + */
>  static inline struct task_struct *__mutex_owner(struct mutex *lock)
>  {
>         return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);

Reviewed-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com

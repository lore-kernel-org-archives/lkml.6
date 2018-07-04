Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BEEC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377DE208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7qUbviQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377DE208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeGDOWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:22:37 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43227 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753295AbeGDOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:22:34 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so2703117plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5dHMdC3i///kXDOg31QNJAeTpYK/gt7Tv5O7iO+fEM8=;
        b=k7qUbviQPVY21T+h1IBRFwvcCCs8ET6pVVYIvCdOoyJ6wx90nF0LzZBx4cy/wAHBTi
         +MDq4micTWfeUeeQBJI38+m7WybqM1yQ1YHXs0rWw98bhvo9yy4C1vWE6YOpS0VoJoho
         gmJpSCDvSkxDzfd6cX60q4jFhjNS/vDQMzHTUhnEzJrlE+APERf+kdLXIcxfcRm2M88o
         HQ5e+1kcdugKzpuAEbBjYqZvF7wB0t43EtlWTAqe2QWHVj+gagoDbMDgafyZJL8L4OxP
         ZmfN/OlFKU0RrImfX8dX3barcsF4ru7Yu63QKicdiK2lz4TjYWyDiW9CnbPpDIa7wk1U
         kS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5dHMdC3i///kXDOg31QNJAeTpYK/gt7Tv5O7iO+fEM8=;
        b=Zo7YHKlrOq936/aq3m085Q+iMQQLLiRFFdkDj0RH7Md2NpxkxXWT+WnOvvkeTZuZDh
         M+k02k2cZvPk6etjeiS8Cb+2IYu0ZoJm7U/n4t1bGIS5mIAo6gXuG5utwLSU5v/LivTw
         zwf6TZQDI6D2F+kECubP927PTzw6tJmoVAEg3kjhrkU9YWfSPAArSUcF1RD3zK4/8zTF
         Hm4bmsSUWGzd+3pAnuQ8EqjFe+EThbe3cXWCWYVEUo4+mL1qu5RAzRcFIBX1+5eyfG3X
         fPS5W319ZxUtmcboOCiURavxoB+d/Zd/9QNjQmNIEVDnqRhNUcE6pSkHZXjei+sE/59T
         7qjA==
X-Gm-Message-State: APt69E0mPtwkKVln1qdeSe/SV8U/KlX4g8QsFRU2hnPZq9VKbj+L3KwI
        xhPpjJd0JItwywoh3kmTbF0ALLIqImDcOHiQg6v6Ng==
X-Google-Smtp-Source: AAOMgpe4rBYChtN/Uh7Lcq5Z/C5SGZSjM3pntSY2uaj/J8V8yf12aezF7QHxPhJ2ofp+kLDFbXucgitUNZYEUGPR4/s=
X-Received: by 2002:a17:902:7782:: with SMTP id o2-v6mr2336985pll.93.1530714153168;
 Wed, 04 Jul 2018 07:22:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 4 Jul 2018 07:22:12
 -0700 (PDT)
In-Reply-To: <b9ffe11e-c63f-c5fb-f5e8-fc4eb8c4f0fa@colorfullife.com>
References: <000000000000e403b3056e76c786@google.com> <20180624025651.bvjlcfulbmycz5bf@linux-r8p5>
 <CACT4Y+anMTUCaRH5D4QoZR4bLdtH=_wtCxK2dM6isJozbVThDg@mail.gmail.com>
 <ff30f992-9c75-f230-c86a-902373f4ecaa@colorfullife.com> <CACT4Y+ZX0VSf23PTGpfwps4T0itMV-ZnSDQx6SuOucBE9sPSEw@mail.gmail.com>
 <b9ffe11e-c63f-c5fb-f5e8-fc4eb8c4f0fa@colorfullife.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Jul 2018 16:22:12 +0200
Message-ID: <CACT4Y+a-yU9yWpZjY5XtRktdLedJHsyuJnQK+UZzf8Ow6U+Mog@mail.gmail.com>
Subject: Re: ipc/msg: zalloc struct msg_queue when creating a new msq
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        syzbot <syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 4:08 PM, Manfred Spraul <manfred@colorfullife.com> wrote:
> Hello Dmitry,
> On 07/04/2018 12:03 PM, Dmitry Vyukov wrote:
>>
>> On Wed, Jul 4, 2018 at 11:18 AM, Manfred Spraul
>> <manfred@colorfullife.com> wrote:
>>>
>>>
>>> There are 2 relevant values: kern_ipc_perm.id and kern_ipc_perm.seq.
>>>
>>> For kern_ipc_perm.id, it is possible to move the access to the codepath
>>> that
>>> hold the lock.
>>>
>>> For kern_ipc_perm.seq, there are two options:
>>> 1) set it before publication.
>>> 2) initialize to an invalid value, and correct that at the end.
>>>
>>> I'm in favor of option 2, it avoids that we must think about reducing the
>>> next sequence number or not:
>>>
>>> The purpose of the sequence counter is to minimize the risk that e.g. a
>>> semop() will write into a newly created array.
>>> I intentially write "minimize the risk", as it is by design impossible to
>>> guarantee that this cannot happen, e.g. if semop() sleeps at the
>>> instruction
>>> before the syscall.
>>>
>>> Therefore, we can set seq to ULONG_MAX, then ipc_checkid() will always
>>> fail
>>> and the corruption is avoided.
>>>
>>> What do you think?
>>>
>>> And, obviously:
>>> Just set seq to 0 is dangerous, as the first allocated sequence number is
>>> 0,
>>> and if that object is destroyed, then the newly created object has
>>> temporarily sequence number 0 as well.
>>
>> Hi Manfred,
>>
>> It still looks fishy to me. This code published uninitialized uid's
>> for years (which lead not only to accidentally accessing wrong
>> objects, but also to privilege escalation). Now it publishes uninit
>> id/seq. The first proposed fix still did not make it correct. I can't
>> say that I see a but in your patch, but initializing id/seq in a racy
>> manner rings bells for me. Say, if we write/read seq ahead of id, can
>> reader still get access to a wrong object?
>> It all suggests some design flaw to me. Could ipc_idr_alloc() do full
>> initialization, i.e. also do what ipc_buildid() does? This would
>> ensure that we publish a fully constructed object in the first place.
>> We already have cleanup for ipc_idr_alloc(), which is idr_remove(), so
>> if we care about seq space conservation even in error conditions
>> (ENOMEM?), idr_remove() could accept an additional flag saying "this
>> object should not have been used by sane users yet, so retake its
>> seq". Did I get your concern about seq properly?
>
> You have convinced me, I'll rewrite the patch:
>
> 1) kern_ipc_perm.seq should be accessible under rcu_read_lock(), this means
> replacing ipc_build_id() with two functions:
> One that initializes kern_ipc_perm.seq, and one that would set
> kern_ipc_perm.id.
> 2) the accesses to kern_ipc_perm.id must be moved to the position where the
> lock is held. This is trivial.
> 3) we need a clear table that describes which variables can be accessed
> under rcu_read_lock() and which need ipc_lock_object().
>   e.g.: kern_ipc_perm.id would end up under ipc_lock_object,
> kern_ipc_perm.seq or the xuid fields can be read under rcu_read_lock().
>   Everything that can be accessed without ipc_lock_object must be
> initialized before publication of a new object.
>
> Or, as all access to kern_ipc_perm.id are in rare codepaths:
> I'll remove kern_ipc_perm.id entirely, and build the id on demand.
>
> Ok?


Sounds like a more solid plan. If we remove kern_ipc_perm.id, then we
also don't need to split ipc_buildid() into two functions, right? And
since seq becomes constant throughout object lifetime, it probably
does not need any special access rules.

Thanks

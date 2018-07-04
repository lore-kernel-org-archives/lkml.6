Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577912150E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+aV0hPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577912150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932701AbeGDKD4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:03:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35619 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeGDKDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:03:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id q7-v6so1324778pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PznoCnT2oyBRimoszSXNwc7NhSJAyUbmSgI2Rcu5jPQ=;
        b=q+aV0hPjhy3cVDE76prX78saVUkMfrptKDPrebp7v+FEBaPqJRxgxLlofx6LLjsOSW
         Ag8hu9JVauSSXqbGArlZ8Gtke5V3zuLbhSoOGu/+2UtVLl3SWTnclKITWsH8Cl5SZSqP
         D7qWEfTLFRZqqji3HqZx7tVjwhWD7mdeC+GYAPwrxz2O0CjbmIUAez63A+QSGK2i2YzV
         4ecD8Nq1iVkrYMEjn0nzW1oSU6n3A+opwPOgHXkxEGWjb2MqW19+J8/fDHK+5rcnJzFC
         DRlJEzt+NZ1eoURO7IjAk4UoqhwU4yIbBebnCu4kjk/uesloULicr1iovbYoY6kUhuv9
         7+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PznoCnT2oyBRimoszSXNwc7NhSJAyUbmSgI2Rcu5jPQ=;
        b=n5n/M7ghh+iHmh19R0E6FksfdAYUgKSu4uV1H3vZ/3PnHznUdVotzBhHkJykxaHux4
         CF0WBimx0IFYwJW8KXJ6YYP2UaiH01oIU5p05JM8AysIB70GQ0QS9HxpoVYnT88/T1AM
         2n6K5xiZtrA87/DUu1876BdUR+1WnGzyEOiDK5mD8CT/Xalskd9iAkczsBb7yABXdvWF
         EzF3LAuHNnnGt1JkdSBxvyKzh6OgEF78v5YhIg5BNNj5qGkgqjJrBrdN3pnZmjxUQv6d
         4un2m2E5K4a1B2z2n0ytLlxiXiCZrTEz/I2vhKwYp3ZCvEoGdTaMSuZ3xc8i8FjLnyoW
         MUYw==
X-Gm-Message-State: APt69E1g06eDka6uO2HdKyHNTuSrNoilxAGPWPEOAwiJ5FBWUdnY+S+o
        D01VQbMunGzZMCuYxDRWJYqoKnB+TEditg9tgeMgtQ==
X-Google-Smtp-Source: AAOMgpc5aMpE+B/E1+efoCPShqjBhGFkv6mHTrjqnVUHluVJYHOotEaRtCTna+aCVFpQY1X6J1HrOM1pP0rkhE017S4=
X-Received: by 2002:a62:3f44:: with SMTP id m65-v6mr1495280pfa.98.1530698633930;
 Wed, 04 Jul 2018 03:03:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 4 Jul 2018 03:03:33
 -0700 (PDT)
In-Reply-To: <ff30f992-9c75-f230-c86a-902373f4ecaa@colorfullife.com>
References: <000000000000e403b3056e76c786@google.com> <20180624025651.bvjlcfulbmycz5bf@linux-r8p5>
 <CACT4Y+anMTUCaRH5D4QoZR4bLdtH=_wtCxK2dM6isJozbVThDg@mail.gmail.com> <ff30f992-9c75-f230-c86a-902373f4ecaa@colorfullife.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Jul 2018 12:03:33 +0200
Message-ID: <CACT4Y+ZX0VSf23PTGpfwps4T0itMV-ZnSDQx6SuOucBE9sPSEw@mail.gmail.com>
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

On Wed, Jul 4, 2018 at 11:18 AM, Manfred Spraul
<manfred@colorfullife.com> wrote:
> Hello together,
>
> On 06/25/2018 11:21 AM, Dmitry Vyukov wrote:
>>
>> On Sun, Jun 24, 2018 at 4:56 AM, Davidlohr Bueso <dave@stgolabs.net>
>> wrote:
>>>
>>> The following splat was reported around the msg_queue structure
>>> which can have uninitialized fields left over after newque().
>>> Future syscalls which make use of the msq id (now valid) can thus
>>> make KMSAN complain because not all fields are explicitly initialized
>>> and we have the padding as well. This is internal to the kernel,
>>> hence no bogus leaks.
>>
>> Hi Davidlohr,
>>
>> As far as I understand the root problem is that (1) we publish a
>> not-fully initialized objects and (2) finish it's initialization in a
>> racy manner when other threads already have access to it. As the
>> result other threads can act on a wrong object. I am not sure that
>> zeroing the object really solves these problems. It will sure get rid
>> of the report at hand (but probably not of KTSAN, data race detector,
>> report), other threads still can see wrong 0 id and the id is still
>> initialized in racy way. I would expect that a proper fix would be to
>> publish a fully initialized object with proper, final id. Am I missing
>> something?
>
> There are 2 relevant values: kern_ipc_perm.id and kern_ipc_perm.seq.
>
> For kern_ipc_perm.id, it is possible to move the access to the codepath that
> hold the lock.
>
> For kern_ipc_perm.seq, there are two options:
> 1) set it before publication.
> 2) initialize to an invalid value, and correct that at the end.
>
> I'm in favor of option 2, it avoids that we must think about reducing the
> next sequence number or not:
>
> The purpose of the sequence counter is to minimize the risk that e.g. a
> semop() will write into a newly created array.
> I intentially write "minimize the risk", as it is by design impossible to
> guarantee that this cannot happen, e.g. if semop() sleeps at the instruction
> before the syscall.
>
> Therefore, we can set seq to ULONG_MAX, then ipc_checkid() will always fail
> and the corruption is avoided.
>
> What do you think?
>
> And, obviously:
> Just set seq to 0 is dangerous, as the first allocated sequence number is 0,
> and if that object is destroyed, then the newly created object has
> temporarily sequence number 0 as well.

Hi Manfred,

It still looks fishy to me. This code published uninitialized uid's
for years (which lead not only to accidentally accessing wrong
objects, but also to privilege escalation). Now it publishes uninit
id/seq. The first proposed fix still did not make it correct. I can't
say that I see a but in your patch, but initializing id/seq in a racy
manner rings bells for me. Say, if we write/read seq ahead of id, can
reader still get access to a wrong object?
It all suggests some design flaw to me. Could ipc_idr_alloc() do full
initialization, i.e. also do what ipc_buildid() does? This would
ensure that we publish a fully constructed object in the first place.
We already have cleanup for ipc_idr_alloc(), which is idr_remove(), so
if we care about seq space conservation even in error conditions
(ENOMEM?), idr_remove() could accept an additional flag saying "this
object should not have been used by sane users yet, so retake its
seq". Did I get your concern about seq properly?

Thanks

p.s. I wonder how do you folks decipher unified patches without
context? If somebody will find it useful, side-by-side patch with
context is available here:
https://github.com/dvyukov/linux/commit/c3726a54a3c05b54192b2f5a4eaa4f7fa66ce68a

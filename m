Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3955C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B37020660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgK+GWne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B37020660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeLALFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:05:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeLALFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:05:00 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A96E2145D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 23:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543622037;
        bh=XBn0hCVjLTqL2j1Ldxm73dJx8b3y9HfmX7Ug4Zal9w8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BgK+GWnek6VZ9yhFxYEulYvAjH/97w2qf7SSjPCQlJQN8M/nVPB43MweDQRU+WvM6
         FkSLNwlltSceFKLTZcUZFgONYlJn0QyfANXoQf39QoPYjiLN6aPVWJuQfari2gmd2k
         rA6DVpoPfI28NgV8BXybCMHNpu6tpGhpdz2s7sGs=
Received: by mail-wm1-f50.google.com with SMTP id c126so551970wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:53:57 -0800 (PST)
X-Gm-Message-State: AA+aEWZycc4d7tYjroeiXQJ4k9Dos1WffvAKbicKvFBStQBbBwSVqAq0
        0WSvXm9/0LsodsTp3bfBjnvnLDfSu7EQLUWXteVdwA==
X-Google-Smtp-Source: AFSGD/W+fjORyoQjwppCJEbECYPyttY6wjJ+JBe1As1QeER9qrqOWv6cfB1aOvXb2mNm8gwW0Cyn3IxFDWn0ov0QAzM=
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr635975wme.108.1543622035759;
 Fri, 30 Nov 2018 15:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
 <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io>
 <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com>
 <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com> <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com>
In-Reply-To: <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 30 Nov 2018 15:53:43 -0800
X-Gmail-Original-Message-ID: <CALCETrWcJCjNGEqgq57Bm8O3qWkfEwau2SiXAv+SNYvNmXnBCA@mail.gmail.com>
Message-ID: <CALCETrWcJCjNGEqgq57Bm8O3qWkfEwau2SiXAv+SNYvNmXnBCA@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 2:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Nov 30, 2018 at 5:36 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Fri, Nov 30, 2018 at 3:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > siginfo_t as it is now still has a number of other downsides, and Andy in
> > > particular didn't like the idea of having three new variants on x86
> > > (depending on how you count). His alternative suggestion of having
> > > a single syscall entry point that takes a 'signfo_t __user *' but interprets
> > > it as compat_siginfo depending on in_compat_syscall()/in_x32_syscall()
> > > should work correctly, but feels wrong to me, or at least inconsistent
> > > with how we do this elsewhere.
> >
> > If everyone else is okay with it, I can get on board with three
> > variants on x86.  What I can't get on board with is *five* variants on
> > x86, which would be:
> >
> > procfd_signal via int80 / the 32-bit vDSO: the ia32 structure
> >
> > syscall64 with nr == 335 (presumably): 64-bit
>
> These seem unavoidable

Indeed, although, in hindsight, they should have had the same numbers.

>
> > syscall64 with nr == 548 | 0x40000000: x32
> >
> > syscall64 with nr == 548: 64-bit entry but in_compat_syscall() ==
> > true, behavior is arbitrary
> >
> > syscall64 with nr == 335 | 0x40000000: x32 entry, but
> > in_compat_syscall() == false, behavior is arbitrary
>
> Am I misreading the code? The way I understand it, setting the
> 0x40000000 bit means that both in_compat_syscall() and
> in_x32_syscall become() true, based on
>
> static inline bool in_x32_syscall(void)
> {
> #ifdef CONFIG_X86_X32_ABI
>         if (task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT)
>                 return true;
> #endif
>         return false;
> }

Yes.

>
> The '548 | 0x40000000' part seems to be the only sensible
> way to handle x32 here. What exactly would you propose to
> avoid defining the other entry points?

I would propose that it should be 335 | 0x40000000.  I can't see any
reasonable way to teach the kernel to reject 335 | 0x40000000 that
wouldn't work just as well to accept it and make it do the right
thing.  Currently we accept it and do the *wrong* thing, which is no
good.

>
> > This mess isn't really Christian's fault -- it's been there for a
> > while, but it's awful and I don't think we want to perpetuate it.
>
> I'm not convinced that not assigning an x32 syscall number
> improves the situation, it just means that we now have one
> syscall that behaves completely differently from all others,
> in that the x32 version requires being called through a
> SYSCALL_DEFINE() entry point rather than a
> COMPAT_SYSCALL_DEFINE() one,

There's nothing particularly novel about this.  seccomp(), for
example, already works like this.

> and we have to
> add more complexity to the copy_siginfo_from_user()
> implementation to duplicate the hack that exists in
> copy_siginfo_from_user32().

What hack are you referring to here?

>
> Of course, the nicest option would be to completely remove
> x32 so we can stop worrying about it.

True :)

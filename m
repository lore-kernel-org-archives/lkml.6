Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D382C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51172145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51172145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeLAJVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:21:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33664 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:21:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so7688044qtp.0;
        Fri, 30 Nov 2018 14:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGA1VXKrvoTOERg3O+Jz0z4OocXMxN8reAWA8j2jG78=;
        b=oRA3CLXjXiyigyjWSX3ACCp6JGB32Wr0Fia1xkmbfyPBTWQvqBePsHx5rC/SZ6pjWv
         0JaSjWFE0o/o6FzvK0hC4PHLI9DxniqhFiCJ0FoKYmYpKl+j7OBBuNO7OMQg+snpnVkk
         nJR7a6yMqScm3Tz6Ks6TJLVEWruIbpeHKX8y3CMlmwtSILQChiEZQpkq7mPSg/fC2j9G
         J9GnFcp/394tryEIkqQxIeY41/xrXNut8Vag6dqVoVK+O4/51iH0R4/FV3H7qpyXCXWR
         sGxHZoV5ZBkho0ApRmgQUycDgml1JaIdrzpTmeMSQ6k/JFTJLhWQQruGLB1ZEhnLLLYt
         ipRQ==
X-Gm-Message-State: AA+aEWaZo5Lh1qRiV+tEgZXNlxRS6JgxsL5/kEXOyQkevUBkyR1sqMcL
        n+se7JVcYMRL86X/1fq/8vleS3CVL+JBprNXxhc=
X-Google-Smtp-Source: AFSGD/WkbJ78dI27YZsEIMK1t29r2EHecKM1WBek4m5t1AwK3ZZ3nGX9bpqhi5Y+5ikSnNFyxAbAzJJrG2D8GeZ7Fa0=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr6866210qtm.96.1543615816138;
 Fri, 30 Nov 2018 14:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
 <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io>
 <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com> <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
In-Reply-To: <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 23:09:58 +0100
Message-ID: <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Andy Lutomirski <luto@kernel.org>
Cc:     christian@brauner.io, "Eric W . Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:36 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Nov 30, 2018 at 3:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > siginfo_t as it is now still has a number of other downsides, and Andy in
> > particular didn't like the idea of having three new variants on x86
> > (depending on how you count). His alternative suggestion of having
> > a single syscall entry point that takes a 'signfo_t __user *' but interprets
> > it as compat_siginfo depending on in_compat_syscall()/in_x32_syscall()
> > should work correctly, but feels wrong to me, or at least inconsistent
> > with how we do this elsewhere.
>
> If everyone else is okay with it, I can get on board with three
> variants on x86.  What I can't get on board with is *five* variants on
> x86, which would be:
>
> procfd_signal via int80 / the 32-bit vDSO: the ia32 structure
>
> syscall64 with nr == 335 (presumably): 64-bit

These seem unavoidable

> syscall64 with nr == 548 | 0x40000000: x32
>
> syscall64 with nr == 548: 64-bit entry but in_compat_syscall() ==
> true, behavior is arbitrary
>
> syscall64 with nr == 335 | 0x40000000: x32 entry, but
> in_compat_syscall() == false, behavior is arbitrary

Am I misreading the code? The way I understand it, setting the
0x40000000 bit means that both in_compat_syscall() and
in_x32_syscall become() true, based on

static inline bool in_x32_syscall(void)
{
#ifdef CONFIG_X86_X32_ABI
        if (task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT)
                return true;
#endif
        return false;
}

The '548 | 0x40000000' part seems to be the only sensible
way to handle x32 here. What exactly would you propose to
avoid defining the other entry points?

> This mess isn't really Christian's fault -- it's been there for a
> while, but it's awful and I don't think we want to perpetuate it.

I'm not convinced that not assigning an x32 syscall number
improves the situation, it just means that we now have one
syscall that behaves completely differently from all others,
in that the x32 version requires being called through a
SYSCALL_DEFINE() entry point rather than a
COMPAT_SYSCALL_DEFINE() one, and we have to
add more complexity to the copy_siginfo_from_user()
implementation to duplicate the hack that exists in
copy_siginfo_from_user32().

Of course, the nicest option would be to completely remove
x32 so we can stop worrying about it.

      Arnd

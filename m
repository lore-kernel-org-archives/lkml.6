Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A58C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD9E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtbfLYdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD9E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeLAKQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:16:45 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38547 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeLAKQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:16:45 -0500
Received: by mail-ua1-f65.google.com with SMTP id p9so2477275uaa.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4PDU34XSI5Y+uqhTZvzXQj2OLoTbhKN+2igfT+/Srg=;
        b=qtbfLYdVXU+bwfcTnz3IYErshOnR3WCZIO8cuzA+2xF7QptSe5fwWWy9OUDPga+2/B
         Oc107fO3f9thqoPcyLEYQRBYLvV17Kgb+RC4NenV+PnlsIv+y9jHMMfMmmo5j7000LVk
         0J4YHV4IZ7dQQ7sP8PaJgIsrUsh10yDX8zexFEAoF/erOrBIFFrCufd6y18UyqItPD6P
         ugUdNOfbk2//QlEpI51mHsOh72vWcf12uNKW2Gh8uUnO/BoCvFw5oDzS+5qAC3cwFqVw
         nVy1mov9M7rwfYecgHbKV57d8RpDwLUyZQGCBUZq4cEP51hIvJCQ95xXov4NeRdKzVd+
         ocgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4PDU34XSI5Y+uqhTZvzXQj2OLoTbhKN+2igfT+/Srg=;
        b=XSrsrLiWKACtHUYCqiBC7/VhESmOzX3PCH12aEw+RO9bTx3SnvrVIf+V2w/DxSySCS
         D8blx+2UfmaZNtOkISUmVmymEorLQRNRLzhQvDk6/p9UrrTkyEh5+NBHLQ0MJExUk3El
         l35KTR9JOU5GwJKvkNoTmYiIDMrJtj9/O/CJuB7mz12Asbt84uqjUqbO98T2eq3w5Mdp
         /M0YSNFLRgKGK7v9zHFmluk69J39TAxIJA6NANzrazUkx3dE9nxerH/tspiYATXd5PXz
         lgU6gV5CXNDIq3mgyeEQo9Kit8F5Heudrv74xgTWofvCzRQ0LFL3qGb1Dz3XU5Bez8e3
         x0rg==
X-Gm-Message-State: AA+aEWZ1FT0lq7aFctSWvQTAJlVKYevTY3Ui5ljDg1DrP9HZsyYwCSMY
        yKd7NBnarASpikPZYSPo0+PhJj+jICWl1k0RAKT98A==
X-Google-Smtp-Source: AFSGD/XqxOlM9LjQnNySCVr2W9P0+wKBcaLzhWmWqdlLDKqJPfAV0dX/iVyGmkn9Hs4utNlYdFhHAMRdUV1StXyEHAo=
X-Received: by 2002:ab0:45e2:: with SMTP id u89mr3340909uau.13.1543619150774;
 Fri, 30 Nov 2018 15:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
 <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io>
 <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com>
 <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
 <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com> <EC87B1BE-BDD0-414F-85F8-806C3CC4DD07@brauner.io>
In-Reply-To: <EC87B1BE-BDD0-414F-85F8-806C3CC4DD07@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 30 Nov 2018 15:05:36 -0800
Message-ID: <CAKOZuesEPFnkd7YGbu82TRQwhR=KPwNW8GpYTw=719_xmJx9FA@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 2:26 PM Christian Brauner <christian@brauner.io> wrote:
>
> On December 1, 2018 11:09:58 AM GMT+13:00, Arnd Bergmann <arnd@arndb.de> wrote:
> >On Fri, Nov 30, 2018 at 5:36 PM Andy Lutomirski <luto@kernel.org>
> >wrote:
> >>
> >> On Fri, Nov 30, 2018 at 3:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >> > siginfo_t as it is now still has a number of other downsides, and
> >Andy in
> >> > particular didn't like the idea of having three new variants on x86
> >> > (depending on how you count). His alternative suggestion of having
> >> > a single syscall entry point that takes a 'signfo_t __user *' but
> >interprets
> >> > it as compat_siginfo depending on
> >in_compat_syscall()/in_x32_syscall()
> >> > should work correctly, but feels wrong to me, or at least
> >inconsistent
> >> > with how we do this elsewhere.
> >>
> >> If everyone else is okay with it, I can get on board with three
> >> variants on x86.  What I can't get on board with is *five* variants
> >on
> >> x86, which would be:
> >>
> >> procfd_signal via int80 / the 32-bit vDSO: the ia32 structure
> >>
> >> syscall64 with nr == 335 (presumably): 64-bit
> >
> >These seem unavoidable
> >
> >> syscall64 with nr == 548 | 0x40000000: x32
> >>
> >> syscall64 with nr == 548: 64-bit entry but in_compat_syscall() ==
> >> true, behavior is arbitrary
> >>
> >> syscall64 with nr == 335 | 0x40000000: x32 entry, but
> >> in_compat_syscall() == false, behavior is arbitrary
> >
> >Am I misreading the code? The way I understand it, setting the
> >0x40000000 bit means that both in_compat_syscall() and
> >in_x32_syscall become() true, based on
> >
> >static inline bool in_x32_syscall(void)
> >{
> >#ifdef CONFIG_X86_X32_ABI
> >        if (task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT)
> >                return true;
> >#endif
> >        return false;
> >}
> >
> >The '548 | 0x40000000' part seems to be the only sensible
> >way to handle x32 here. What exactly would you propose to
> >avoid defining the other entry points?
> >
> >> This mess isn't really Christian's fault -- it's been there for a
> >> while, but it's awful and I don't think we want to perpetuate it.
> >
> >I'm not convinced that not assigning an x32 syscall number
> >improves the situation, it just means that we now have one
> >syscall that behaves completely differently from all others,
> >in that the x32 version requires being called through a
> >SYSCALL_DEFINE() entry point rather than a
> >COMPAT_SYSCALL_DEFINE() one, and we have to
> >add more complexity to the copy_siginfo_from_user()
> >implementation to duplicate the hack that exists in
> >copy_siginfo_from_user32().
> >
> >Of course, the nicest option would be to completely remove
> >x32 so we can stop worrying about it.
>
> One humble point I would like to make is that what I care about most is a sensible way forward without having to redo essential parts of how syscalls work.
> I don't want to introduce a sane, small syscall that ends up breaking all over the place because we decided to fix past mistakes that technically have nothing to do with the patch itself.
> However, I do sympathize and understand these concerns.

IMHO, it's fine to just replicate all the splits we have for the
existing signal system calls. It's ugly, but once it's done, it'll be
done for a long time. I can't see a need to add even more signal
system calls after this one.

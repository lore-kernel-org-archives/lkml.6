Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NM8hKj0IGlsDGAAAmS7hNA
	; Fri, 08 Jun 2018 04:38:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8BA70607E4; Fri,  8 Jun 2018 04:38:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbqOl+Dh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EB24C6063F;
	Fri,  8 Jun 2018 04:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB24C6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeFHEiT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeFHEiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:38:17 -0400
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533F520895
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jun 2018 04:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528432696;
        bh=lPdBK5FFP8eQWZExAdb9H7HnZzyQ6rQLjxpLJ8Ru4eM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MbqOl+DhxsfXHG14X4161IAtmaMYTfYPcoKN7v/c+r1ynmH81lTCdFe/H1XAufbsK
         c+dxLBjYDyZEFQ299OoJufRrQaLfpZ8mxSzAX+lEJmUaGOfs4Q6XxOc7raIHXiO2BS
         QHz+6wzoLjVsI90+16PwMh7mU6BHRt6rWGb83CzE=
Received: by mail-wm0-f52.google.com with SMTP id 69-v6so1060016wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 21:38:16 -0700 (PDT)
X-Gm-Message-State: APt69E3dIm/AQnqL4NAhpCuh+8GjljfhS9L9p/CTaCnQjkXav0hJ49bq
        yX7rev1Lo7QPPaetGs24bT7O/2T5v9s11OwogPz46g==
X-Google-Smtp-Source: ADUXVKKKd7W07022IPPiWJZSDi+S4r3VoK0ODCq4hA55QifnbiVMpdTMVmJoPL+NSIbcJr+iB0KhftS6HgsX5NMmQv8=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr314605wmi.46.1528432694803;
 Thu, 07 Jun 2018 21:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <CALCETrV1GG5rq_kwxkS-o3x8Ldr72ThdYgkJKQ9cx9Q63SxgTQ@mail.gmail.com> <CAMe9rOpeDrkwi-AG0vsiZy4NwkmavhB5Empv58FSHxtr3rpapw@mail.gmail.com>
In-Reply-To: <CAMe9rOpeDrkwi-AG0vsiZy4NwkmavhB5Empv58FSHxtr3rpapw@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 21:38:03 -0700
X-Gmail-Original-Message-ID: <CALCETrWhMmqGWKx-yw55YKHMJwGyLZio5f8Pskh8X69zfQMy7A@mail.gmail.com>
Message-ID: <CALCETrWhMmqGWKx-yw55YKHMJwGyLZio5f8Pskh8X69zfQMy7A@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To: "H. J. Lu" <hjl.tools@gmail.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 9:10 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Jun 7, 2018 at 4:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Thu, Jun 7, 2018 at 3:02 PM H.J. Lu <hjl.tools@gmail.com> wrote:
> >>
> >> On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >> > On Thu, Jun 7, 2018 at 1:33 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >> >>
> >> >> On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
> >> >> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >> >> > >
> >> >> > > The following operations are provided.
> >> >> > >
> >> >> > > ARCH_CET_STATUS:
> >> >> > >         return the current CET status
> >> >> > >
> >> >> > > ARCH_CET_DISABLE:
> >> >> > >         disable CET features
> >> >> > >
> >> >> > > ARCH_CET_LOCK:
> >> >> > >         lock out CET features
> >> >> > >
> >> >> > > ARCH_CET_EXEC:
> >> >> > >         set CET features for exec()
> >> >> > >
> >> >> > > ARCH_CET_ALLOC_SHSTK:
> >> >> > >         allocate a new shadow stack
> >> >> > >
> >> >> > > ARCH_CET_PUSH_SHSTK:
> >> >> > >         put a return address on shadow stack
> >> >> > >
> >> >> > > ARCH_CET_ALLOC_SHSTK and ARCH_CET_PUSH_SHSTK are intended only for
> >> >> > > the implementation of GLIBC ucontext related APIs.
> >> >> >
> >> >> > Please document exactly what these all do and why.  I don't understand
> >> >> > what purpose ARCH_CET_LOCK and ARCH_CET_EXEC serve.  CET is opt in for
> >> >> > each ELF program, so I think there should be no need for a magic
> >> >> > override.
> >> >>
> >> >> CET is initially enabled if the loader has CET capability.  Then the
> >> >> loader decides if the application can run with CET.  If the application
> >> >> cannot run with CET (e.g. a dependent library does not have CET), then
> >> >> the loader turns off CET before passing to the application.  When the
> >> >> loader is done, it locks out CET and the feature cannot be turned off
> >> >> anymore until the next exec() call.
> >> >
> >> > Why is the lockout necessary?  If user code enables CET and tries to
> >> > run code that doesn't support CET, it will crash.  I don't see why we
> >> > need special code in the kernel to prevent a user program from calling
> >> > arch_prctl() and crashing itself.  There are already plenty of ways to
> >> > do that :)
> >>
> >> On CET enabled machine, not all programs nor shared libraries are
> >> CET enabled.  But since ld.so is CET enabled, all programs start
> >> as CET enabled.  ld.so will disable CET if a program or any of its shared
> >> libraries aren't CET enabled.  ld.so will lock up CET once it is done CET
> >> checking so that CET can't no longer be disabled afterwards.
> >
> > Yeah, I got that.  No one has explained *why*.
>
> It is to prevent malicious code from disabling CET.
>

By the time malicious code issue its own syscalls, you've already lost
the battle.  I could probably be convinced that a lock-CET-on feature
that applies *only* to the calling thread and is not inherited by
clone() is a decent idea, but I'd want to see someone who understands
the state of the art in exploit design justify it.  You're also going
to need to figure out how to make CRIU work if you allow locking CET
on.

A priori, I think we should just not provide a lock mechanism.

> > (Also, shouldn't the vDSO itself be marked as supporting CET?)
>
> No. vDSO is loaded by kernel.  vDSO in CET kernel is CET
> compatible.
>

I think the vDSO should do its best to act like a real DSO.  That
means that, if the vDSO supports CET, it should advertise support for
CET using the Linux ABI.  Since you're going to require GCC 8 anyway,
this should be a single line of code in the Makefile.

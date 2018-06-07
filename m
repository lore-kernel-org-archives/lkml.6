Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id N1x/ODCdGVuMSwAAmS7hNA
	; Thu, 07 Jun 2018 21:01:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 74431606FA; Thu,  7 Jun 2018 21:01:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vgV9IYMp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DBE28601C3;
	Thu,  7 Jun 2018 21:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBE28601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933252AbeFGVBg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933084AbeFGVBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:01:33 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762FF208B3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 21:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528405292;
        bh=LAzhCQsI78n3I2e+pOOBfSDxsZVMaMCiyQ5I3MvYQ6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vgV9IYMp6wcnT1tkx3OXD61hL/5KDSBptIyqEcQr2DGoPso18cqgslJQQ1OT9GanJ
         ShLlvX/8QTb3eYUFxUeVmS95j3WrkBwqAFB+duvfXK8oRKUEDquAnsiQ+mVwIT1gEK
         +LJjvNInO1RNnuqWtGm2TUNdwDaXZImu5rovUrJg=
Received: by mail-wm0-f46.google.com with SMTP id o13-v6so20320283wmf.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 14:01:32 -0700 (PDT)
X-Gm-Message-State: APt69E1UivAqp+VUFBSE1Rhxu88aKudFMp8gExzmxfWzfDnnQHVhDKrA
        blzhC9RVLhqHpQkrGd3op7CPb88czHWBpxY2apGYBg==
X-Google-Smtp-Source: ADUXVKIJVSCdppq+z5FV1VL3xsAZRNYX58D9Pc+Y/0Rj2RC2peYf4aqit+7V3f4brjouQR57jpDlxYGrh5ZrtgNvTi4=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr2454409wmi.46.1528405290631;
 Thu, 07 Jun 2018 14:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com> <1528403417.5265.35.camel@2b52.sc.intel.com>
In-Reply-To: <1528403417.5265.35.camel@2b52.sc.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 14:01:18 -0700
X-Gmail-Original-Message-ID: <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
Message-ID: <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
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

On Thu, Jun 7, 2018 at 1:33 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > >
> > > The following operations are provided.
> > >
> > > ARCH_CET_STATUS:
> > >         return the current CET status
> > >
> > > ARCH_CET_DISABLE:
> > >         disable CET features
> > >
> > > ARCH_CET_LOCK:
> > >         lock out CET features
> > >
> > > ARCH_CET_EXEC:
> > >         set CET features for exec()
> > >
> > > ARCH_CET_ALLOC_SHSTK:
> > >         allocate a new shadow stack
> > >
> > > ARCH_CET_PUSH_SHSTK:
> > >         put a return address on shadow stack
> > >
> > > ARCH_CET_ALLOC_SHSTK and ARCH_CET_PUSH_SHSTK are intended only for
> > > the implementation of GLIBC ucontext related APIs.
> >
> > Please document exactly what these all do and why.  I don't understand
> > what purpose ARCH_CET_LOCK and ARCH_CET_EXEC serve.  CET is opt in for
> > each ELF program, so I think there should be no need for a magic
> > override.
>
> CET is initially enabled if the loader has CET capability.  Then the
> loader decides if the application can run with CET.  If the application
> cannot run with CET (e.g. a dependent library does not have CET), then
> the loader turns off CET before passing to the application.  When the
> loader is done, it locks out CET and the feature cannot be turned off
> anymore until the next exec() call.

Why is the lockout necessary?  If user code enables CET and tries to
run code that doesn't support CET, it will crash.  I don't see why we
need special code in the kernel to prevent a user program from calling
arch_prctl() and crashing itself.  There are already plenty of ways to
do that :)

> When the next exec() is called, CET
> feature is turned on/off based on the values set by ARCH_CET_EXEC.

And why do we need ARCH_CET_EXEC?

For background, I really really dislike adding new state that persists
across exec().  It's nice to get as close to a clean slate as possible
after exec() so that programs can run in a predictable environment.
exec() is also a security boundary, and anything a task can do to
affect itself after exec() needs to have its security implications
considered very carefully.  (As a trivial example, you should not be
able to use cetcmd ... sudo [malicious options here] to cause sudo to
run with CET off and then try to exploit it via the malicious options.

If a shutoff is needed for testing, how about teaching ld.so to parse
LD_CET=no or similar and protect it the same way as LD_PRELOAD is
protected.  Or just do LD_PRELOAD=/lib/libdoesntsupportcet.so.

--Andy

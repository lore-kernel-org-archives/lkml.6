Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EWDgNYurGVsYLQAAmS7hNA
	; Thu, 07 Jun 2018 22:02:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BBFBF6074D; Thu,  7 Jun 2018 22:02:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOxoPNkA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 26F3460452;
	Thu,  7 Jun 2018 22:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26F3460452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeFGWCs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 18:02:48 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44536 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbeFGWCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:02:46 -0400
Received: by mail-oi0-f66.google.com with SMTP id c128-v6so10047717oig.11;
        Thu, 07 Jun 2018 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rh2DrL7/iybtwDD7R4LHC12nHuu0f69L9bT7WFN7Wac=;
        b=MOxoPNkADt+HbKPjvu1A+TJ353gUJ4TOXYxO6DXRky+dO+xjc0WUvsKuWuc5lyrpnq
         qOMf3qwF637AbrpxzFn6VdIRhNBms5z8LvjYFwLRTFthMToMhV2hj5ji5Pf3plReVi6T
         SobBU45q0WGo90vdRMYUpJws45Sjxi0rrCwzTWLPe9t94Y14eHNAyfNyKste57vU4zLB
         z1OheWLb2G6QYyWEBWSLYpMgFzWzmscFaB3rBAswcz95y8zRdZWKF4OMAECVo+j7cmPc
         U7XnBEqA7HsJ1USFXbfEUc0hgAQmKSob6pwgBmokevo3jEOXrqwK7/htiF8W1kKsHp3J
         p8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rh2DrL7/iybtwDD7R4LHC12nHuu0f69L9bT7WFN7Wac=;
        b=dDJ48UKrAncgKN/yuMCCqtqFR28pc8E3LMTqS36wEeUOlf4RvKj+WtFKxsfq578j1D
         Wg+4CaoyDFPWDYQCMGzx4mj4QcUjxAB9Se0lUPNjYNOSmBf9WBvQT6VC0PfwoMjoByyi
         SkVkmtwZWZxnH/zRhKwaK4bADvzVGNdDNdrfAEYXJ84o+qbjbDzcBkkzT6IgxPaRfXcn
         x99kH8XEI4Km07sx+ms8WsKpQx8EW+yeZK7g8YlgzzQR9kvlKhdrNskjF0Z0gdut1fPS
         2unZVolU0XYTIwdM+MH2j73nSRsY+g7Npmtsc5WClFokHMQDvox8CKsxm2w+PLG6T22F
         ZxxA==
X-Gm-Message-State: APt69E1GQb7jeqKxRDyMwbbhpAF2ITdLr0X6eKL4Es6v0KNGBIHkSBHS
        lu0y581hdIwTaDxu1g5OqZz5IdpsHadmAvtTZ1M=
X-Google-Smtp-Source: ADUXVKK8r0tMUi4YXiafpB5fK7QRRRPIf9U5HugKhNgjXxO4yLRfNtcCRmizz26Gn72xoDHnrMDr9+qAFtFiDDNrK9Y=
X-Received: by 2002:aca:b857:: with SMTP id i84-v6mr1830849oif.279.1528408965830;
 Thu, 07 Jun 2018 15:02:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:7019:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 15:02:44 -0700 (PDT)
In-Reply-To: <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Thu, 7 Jun 2018 15:02:44 -0700
Message-ID: <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To: Andy Lutomirski <luto@kernel.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>,
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

On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Jun 7, 2018 at 1:33 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
>> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>> > >
>> > > The following operations are provided.
>> > >
>> > > ARCH_CET_STATUS:
>> > >         return the current CET status
>> > >
>> > > ARCH_CET_DISABLE:
>> > >         disable CET features
>> > >
>> > > ARCH_CET_LOCK:
>> > >         lock out CET features
>> > >
>> > > ARCH_CET_EXEC:
>> > >         set CET features for exec()
>> > >
>> > > ARCH_CET_ALLOC_SHSTK:
>> > >         allocate a new shadow stack
>> > >
>> > > ARCH_CET_PUSH_SHSTK:
>> > >         put a return address on shadow stack
>> > >
>> > > ARCH_CET_ALLOC_SHSTK and ARCH_CET_PUSH_SHSTK are intended only for
>> > > the implementation of GLIBC ucontext related APIs.
>> >
>> > Please document exactly what these all do and why.  I don't understand
>> > what purpose ARCH_CET_LOCK and ARCH_CET_EXEC serve.  CET is opt in for
>> > each ELF program, so I think there should be no need for a magic
>> > override.
>>
>> CET is initially enabled if the loader has CET capability.  Then the
>> loader decides if the application can run with CET.  If the application
>> cannot run with CET (e.g. a dependent library does not have CET), then
>> the loader turns off CET before passing to the application.  When the
>> loader is done, it locks out CET and the feature cannot be turned off
>> anymore until the next exec() call.
>
> Why is the lockout necessary?  If user code enables CET and tries to
> run code that doesn't support CET, it will crash.  I don't see why we
> need special code in the kernel to prevent a user program from calling
> arch_prctl() and crashing itself.  There are already plenty of ways to
> do that :)

On CET enabled machine, not all programs nor shared libraries are
CET enabled.  But since ld.so is CET enabled, all programs start
as CET enabled.  ld.so will disable CET if a program or any of its shared
libraries aren't CET enabled.  ld.so will lock up CET once it is done CET
checking so that CET can't no longer be disabled afterwards.

>> When the next exec() is called, CET
>> feature is turned on/off based on the values set by ARCH_CET_EXEC.
>
> And why do we need ARCH_CET_EXEC?
>
> For background, I really really dislike adding new state that persists
> across exec().  It's nice to get as close to a clean slate as possible
> after exec() so that programs can run in a predictable environment.
> exec() is also a security boundary, and anything a task can do to
> affect itself after exec() needs to have its security implications
> considered very carefully.  (As a trivial example, you should not be
> able to use cetcmd ... sudo [malicious options here] to cause sudo to
> run with CET off and then try to exploit it via the malicious options.
>
> If a shutoff is needed for testing, how about teaching ld.so to parse
> LD_CET=no or similar and protect it the same way as LD_PRELOAD is
> protected.  Or just do LD_PRELOAD=/lib/libdoesntsupportcet.so.
>

I will take a look.


-- 
H.J.

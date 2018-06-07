Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id B4aiOR25GVv7DQAAmS7hNA
	; Thu, 07 Jun 2018 23:01:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0E2D56089E; Thu,  7 Jun 2018 23:01:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMLV4XiB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5A713601C3;
	Thu,  7 Jun 2018 23:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A713601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeFGXBj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 19:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751990AbeFGXBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 19:01:37 -0400
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com [209.85.128.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F35208A3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 23:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528412497;
        bh=RRA6TxHfG0MrgJ9oyYoyxLRdoG+OMFsQ5PeUsRf7u9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cMLV4XiBhqD7KSaifHoP+0aX7NomKAGLZsl26zYMJEMS77Xd34/L9hVPGDo4mMtWU
         7i055cByUOohu1CXkhFl4bcoTP1lG25OLMs16CGH4C5ib4j9xKQ/RDaSpb/5HyO09v
         EOrPw9qO08x/kUfJTDD9AnFd7ZRBP9HmXS1exaBk=
Received: by mail-wr0-f169.google.com with SMTP id v13-v6so11453469wrp.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 16:01:36 -0700 (PDT)
X-Gm-Message-State: APt69E39KQi8NYwPP8G1puN3yBZgtt3DHfbzAA4FsNwqE0B3HZbamyvF
        KUi5QEtzb05SyCpwUjkeIaPQyGdsDanUNxC8yzXzEA==
X-Google-Smtp-Source: ADUXVKJbqZw0ME+XMu/yadec1IJqxCNDDh20SIGnMaYhgvw7Ywk+vjb+UwvocuNMZF+fhcHpSoBCNwF5Tlc3q+F9dBM=
X-Received: by 2002:adf:b1ca:: with SMTP id r10-v6mr2919455wra.221.1528412495562;
 Thu, 07 Jun 2018 16:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
In-Reply-To: <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 16:01:23 -0700
X-Gmail-Original-Message-ID: <CALCETrV1GG5rq_kwxkS-o3x8Ldr72ThdYgkJKQ9cx9Q63SxgTQ@mail.gmail.com>
Message-ID: <CALCETrV1GG5rq_kwxkS-o3x8Ldr72ThdYgkJKQ9cx9Q63SxgTQ@mail.gmail.com>
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

On Thu, Jun 7, 2018 at 3:02 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Thu, Jun 7, 2018 at 1:33 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >>
> >> On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
> >> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >> > >
> >> > > The following operations are provided.
> >> > >
> >> > > ARCH_CET_STATUS:
> >> > >         return the current CET status
> >> > >
> >> > > ARCH_CET_DISABLE:
> >> > >         disable CET features
> >> > >
> >> > > ARCH_CET_LOCK:
> >> > >         lock out CET features
> >> > >
> >> > > ARCH_CET_EXEC:
> >> > >         set CET features for exec()
> >> > >
> >> > > ARCH_CET_ALLOC_SHSTK:
> >> > >         allocate a new shadow stack
> >> > >
> >> > > ARCH_CET_PUSH_SHSTK:
> >> > >         put a return address on shadow stack
> >> > >
> >> > > ARCH_CET_ALLOC_SHSTK and ARCH_CET_PUSH_SHSTK are intended only for
> >> > > the implementation of GLIBC ucontext related APIs.
> >> >
> >> > Please document exactly what these all do and why.  I don't understand
> >> > what purpose ARCH_CET_LOCK and ARCH_CET_EXEC serve.  CET is opt in for
> >> > each ELF program, so I think there should be no need for a magic
> >> > override.
> >>
> >> CET is initially enabled if the loader has CET capability.  Then the
> >> loader decides if the application can run with CET.  If the application
> >> cannot run with CET (e.g. a dependent library does not have CET), then
> >> the loader turns off CET before passing to the application.  When the
> >> loader is done, it locks out CET and the feature cannot be turned off
> >> anymore until the next exec() call.
> >
> > Why is the lockout necessary?  If user code enables CET and tries to
> > run code that doesn't support CET, it will crash.  I don't see why we
> > need special code in the kernel to prevent a user program from calling
> > arch_prctl() and crashing itself.  There are already plenty of ways to
> > do that :)
>
> On CET enabled machine, not all programs nor shared libraries are
> CET enabled.  But since ld.so is CET enabled, all programs start
> as CET enabled.  ld.so will disable CET if a program or any of its shared
> libraries aren't CET enabled.  ld.so will lock up CET once it is done CET
> checking so that CET can't no longer be disabled afterwards.

Yeah, I got that.  No one has explained *why*.

(Also, shouldn't the vDSO itself be marked as supporting CET?)

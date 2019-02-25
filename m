Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A02AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA3520C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551113925;
	bh=8TxDLXifjcYVzWA0UVAiRS8Oyh1Fwe6ryFEIcieRrdY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OvmI4ym9MK0yws/Cj/EVVuS2CH9H6VWdd4cz/oJvRGtlApnrXg99lMiHyLlaOd1yM
	 vSNhLBmQpKNRPkfiNjOLAzVYg+/46hwdNzKwWfY8wQPwC6TWFXRrEl3Aqc7YwiyyGE
	 RsAdsDmesT0/ouNbJ6Um7cU7zg0tClQrEtJFZ5OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfBYQ6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:58:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbfBYQ6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:58:40 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E170C21848
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551113919;
        bh=8TxDLXifjcYVzWA0UVAiRS8Oyh1Fwe6ryFEIcieRrdY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zRnaLicr87rVVSDr7P2HchrfmjV4Xd4Y99G/RIICsdtyCzLTX4hAf87ZyxfUiLYzD
         F8XmIOG1NtSu3COfYkA+nVZmDdXA2Tnbuwa3aq+7KWk7G6xxWlGzbu8D1LhX6Ninoo
         ThJD2nwqBMZ+8i7o01W6dkOhqEmjJn2cE0lgC10Y=
Received: by mail-wm1-f50.google.com with SMTP id q187so8849377wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 08:58:38 -0800 (PST)
X-Gm-Message-State: AHQUAuYnP8mpRfHWQ6Z2MOAT1Dt8Qa1mcudKzKwopX0L91N94VPoEfqj
        vbXmMUmjeF0R/U2VIT06j9rLvknEFvh1fOQV3AsPpA==
X-Google-Smtp-Source: AHgI3IatZA4FlzcOOsyP+nfZWtKSOHy19xXjxvWjGjNOWk81YIAS7HvacUgq5QpH6XXD4y559DKl5U6xo1WJ9zbYYUY=
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr11036422wml.108.1551113917242;
 Mon, 25 Feb 2019 08:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org>
 <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
 <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
 <20190215191949.04604191@gandalf.local.home> <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190223124746.d021973004c7c892c3b3fde1@kernel.org> <20190223194421.725a03fd@oasis.local.home>
 <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com> <CAGXu5j+4g0YRkbZ7mq-3Zgc7aWCU-hx6+G_onW+DdK+mYcqPDA@mail.gmail.com>
In-Reply-To: <CAGXu5j+4g0YRkbZ7mq-3Zgc7aWCU-hx6+G_onW+DdK+mYcqPDA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Feb 2019 08:58:25 -0800
X-Gmail-Original-Message-ID: <CALCETrXrjxkL1pYu-SDnfNL+99N4h+yuLEzab5ytwczWNgFyRg@mail.gmail.com>
Message-ID: <CALCETrXrjxkL1pYu-SDnfNL+99N4h+yuLEzab5ytwczWNgFyRg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 8:48 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Feb 23, 2019 at 8:38 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Sat, Feb 23, 2019 at 4:44 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Sat, 23 Feb 2019 12:47:46 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > > Since kprobes handler runs in IRQ context, we can not use access_ok() in it.
> > > > (only on x86 + CONFIG_DEBUG_ATOMIC_SLEEP=y)
> > >
> > > Is it really IRQ context or exception context? That is, one
> > > (interrupts) happen for any task, but exceptions happen because of the
> > > software that is executed (like a breakpoint). Although you can have a
> > > kprobe trigger in an interrupt handler (where user access wouldn't make
> > > sense anyway). But there should be no problem with user access from an
> > > exception handler.
> > >
> >
> > Can we just get rid of this might_sleep()?  access_ok() doesn't sleep
> > as far as I know.
>
> We do need to be aware of the userfaultfd case of getting held by
> userspace in the middle of a copy_*_user()... that's a whole other
> problem.
>

I sure hope that pagefault_disable() already takes care of this.
Otherwise we have major problems already.

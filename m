Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A505BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9DA223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdIvPT77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9DA223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbeKLU7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:59:10 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36010 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbeKLU7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:59:10 -0500
Received: by mail-io1-f66.google.com with SMTP id m19so239239ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 03:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YezcMUk03N87CvBb8SLjCGbVQkYfKSc0s2gnQldkZg=;
        b=GdIvPT77oHnGKF7K6dPpIODvAjRSoJB8Ppara6ycXiwOsh3fyLJ/tvDH3jpfj/d17T
         2byf3FhcJi6pj+MWxRWe7kg+gAdtsNQcJ3m7ULFQ6NETwxQNhormsBHcdwhs+eTuUZu0
         l6xBYOP8DiAokqE7eWgj1ho4p2ByXXnxwpgG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YezcMUk03N87CvBb8SLjCGbVQkYfKSc0s2gnQldkZg=;
        b=aPtbiGD8yzxLbEwlYYSCreNegXW57Y9cXYE4AjSUZQ5Z96c758AJYO7cdnzOk2Fn2/
         cQ6jI0QgBtnljXmaLAAQqqVXWBF+aPQVMObD0MvT9v94YLsjCogrfmZLZAaYwgTcLw4c
         5cDdkb/SsgIKsy8oUE4hUpJ+2H47IECHAQRRUbFu8x3gr4DlmVfk0CF9bQrvc+4ddPJB
         vfx2KVP0bEdKrTBOcUmOoOXajRdVR119PaZ6i39fwLOSw0EmtJr0btCcQFhoHuPRxv5e
         OBufPJuEmsHWcJbOlIRoakbcvAnJ4Gfv4+mjt0dw3/ejhPZJM7x4YlmF0T4+czwJIr/K
         y0YA==
X-Gm-Message-State: AGRZ1gKw7uIVi+hnH1GT38OSTxvCjp+6TCAfJiF+5ynRwL8s5nDH3De4
        Jvwfo+S935/+KRi5YzAYFVvQ4QY0/8Sk+eVnvhlESw==
X-Google-Smtp-Source: AJdET5fqaQ7NJrwwa140nTCq0GIsDnbeZiHtpsCjETm60EpamIuVGjXW+S4YkM2jxVmCLMNskEy9aPxS6wnTCX3Wl6o=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr315724iob.170.1542020784131;
 Mon, 12 Nov 2018 03:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20181026142008.D922868C94@newverein.lst.de> <20181026142152.5F0D868C95@newverein.lst.de>
 <CAKv+Gu_D2vzk-sBkufK7JvaPawC+QnpZwkC0+ikTb7A6qko8ng@mail.gmail.com> <20181112110127.GA30967@lst.de>
In-Reply-To: <20181112110127.GA30967@lst.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 12 Nov 2018 12:06:13 +0100
Message-ID: <CAKv+Gu9aM3FBUDkdy3xC+ZhWBx-dgG7P4cGKTJgcVkKEBw1FSA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm64: implement live patching
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 at 12:01, Torsten Duwe <duwe@lst.de> wrote:
>
> On Thu, Nov 08, 2018 at 01:42:35PM +0100, Ard Biesheuvel wrote:
> > On 26 October 2018 at 16:21, Torsten Duwe <duwe@lst.de> wrote:
> > >         /* The program counter just after the ftrace call site */
> > >         str     lr, [x9, #S_PC]
> > > +
> > >         /* The stack pointer as it was on ftrace_caller entry... */
> > >         add     x28, fp, #16
> > >         str     x28, [x9, #S_SP]
> >
> > Please drop this hunk
>
> Sure. I missed that one during cleanup.
>
> > > @@ -233,6 +234,10 @@ ftrace_common:
>                          ^^^^^^^^^^^^^^
> > >         ldr     x28, [fp, 8]
> > >         str     x28, [x9, #S_LR]        /* to pt_regs.r[30] */
> > >
> > > +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
> > > +       mov     x28, lr         /* remember old return address */
> > > +#endif
> > > +
> > >         ldr_l   x2, function_trace_op, x0
> > >         ldr     x1, [fp, #8]
> > >         sub     x0, lr, #8      /* function entry == IP */
> > > @@ -245,6 +250,17 @@ ftrace_call:
> > >
> > >         bl      ftrace_stub
> > >
> > > +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
> > > +       /* Is the trace function a live patcher an has messed with
> > > +        * the return address?
> > > +        */
> > > +       add     x9, sp, #16     /* advance to pt_regs for restore */
> > > +       ldr     x0, [x9, #S_PC]
> > > +       cmp     x0, x28         /* compare with the value we remembered */
> > > +       /* to not call graph tracer's "call" mechanism twice! */
> > > +       b.ne    ftrace_common_return
> >
> > Is ftrace_common_return guaranteed to be in range? Conditional
> > branches have only -/+ 1 MB range IIRC.
>
> It's the same function. A "1f" would do the same job, but the long label
> is a talking identifier that saves a comment. I'd more be worried about
> the return from the graph trace caller, which happens to be the _next_
> function ;-)
>
> If ftrace_caller or graph_caller grow larger than a meg, something else is
> _very_ wrong.
>

Ah ok. I confused myself into thinking that ftrace_common_return() was
defined in another compilation unit

> > > +#endif
> > > +
> > >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >
> > Can we fold these #ifdef blocks together (i.e, incorporate the
> > conditional livepatch sequence here)
>
> I'll see how to make it fit. But remember some people might want ftrace
> but no live patching capability.
>

Sure. I simply mean turning this

#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
<bla>
#endif


#ifdef CONFIG_FUNCTION_GRAPH_TRACER
<bla bla>
#endif

into

#ifdef CONFIG_FUNCTION_GRAPH_TRACER
#ifdef CONFIG_LIVEPATCH
<bla>
#endif
<bla bla>
#endif

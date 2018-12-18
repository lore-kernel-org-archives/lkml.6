Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E973EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBDC21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+hqVbjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeLRTSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:18:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46560 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeLRTSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:18:36 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so19451713qtm.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 11:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntVX8JGSVBRYIvxgJqMMgLRiYpA1/HXcQRgPq+xYILU=;
        b=p+hqVbjSRoc0znn4/Ppyjld7TxzeVR+teGHodCuOXEGnphkluM9YpKGUIaPFtwT3Kb
         n6nl8Sq0R4rwx4NTEDWbCaYL3c/k8w0eGe7f9wy/GGpqJN2FeOK+lXMOIO20iAl71ixG
         r0EG74th5CPMI8L7WxF+1tqcFF3WEojosStDoYNaICiXbf9fVfW5ZrwqePhrzfcHIIt2
         tSGmy7VfBPfEirLqCoDMYzGtaoZoFhR59AUAqK9a9Oka459DOGtSFLGHWa2YDqF9hKZ/
         3kl5Sx8WAot5dP8KzHDnU3be5O99L0PTB0rzPsbH0tvSNScRQo/VqwULribFqf0lJJQG
         RU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntVX8JGSVBRYIvxgJqMMgLRiYpA1/HXcQRgPq+xYILU=;
        b=ZW1L85wQ3ii1Hwx07obq2uvAxumMM5D+h9JXD5yITT6dsFB3e/lXA6o9NfEFCCEpBn
         a9yJIbKRXUKMQkyKuUVX9NqSBi9SE0OvMOopvtBSUkI3ISj42fwPNP0hnIPgkhu62Z4K
         WiPsAzRGnVNpra6Ok6IzEivIjHobr6TOufqb4wbCNeqO5hXFFxFrysH+DK4h4WTY8L0V
         /icB8i5hhma6KLv6eUkE6GPFBZOp5XnXBETUircs5NvrtGOKUNu0YWq9NYJpB3lwDY4X
         arQpyUw5X/bwNeTgxyMWZd1vOqFhleA5RN/gfDfg1lm8ODn0fctOzN0DWgjvMn9mNCuo
         0bBA==
X-Gm-Message-State: AA+aEWb0Tv56qX7xt5L5QWHk9pt/1jGniazAJztvOdVu/1Fua4mHFo2Q
        IuwGUB0IOM6xvmaFNp2cwQO3lr3S1PBGMCcg/tp/kg==
X-Google-Smtp-Source: AFSGD/UF/dd7QWUnkAOdJx8PUrD24kz6K5IDgDuslC558FHE+Lc/lJwJ/3pSk28s7n6dZSuAJ3RWSsoGkge3teNAmOY=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr19137013qta.152.1545160713292;
 Tue, 18 Dec 2018 11:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20181214171508.7791-1-surenb@google.com> <20181214171508.7791-7-surenb@google.com>
 <20181217162223.GD2218@hirez.programming.kicks-ass.net> <CAJuCfpHGsDnE-eAHY1QnX949stA3cvNA=078q1swqVnz95aJfg@mail.gmail.com>
 <20181218104622.GB15430@hirez.programming.kicks-ass.net> <20181218173000.GA4733@cmpxchg.org>
 <CAJuCfpGQKQ9oVKdVeLNQHY2+2XTjLXb6VHDcJKAUCtSxvd68wQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGQKQ9oVKdVeLNQHY2+2XTjLXb6VHDcJKAUCtSxvd68wQ@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 18 Dec 2018 11:18:21 -0800
Message-ID: <CAJWu+oor7SzQVgo7SDKFcJS-BX+Oexj2_x_uWGsC8W=ErNGoNw@mail.gmail.com>
Subject: Re: [PATCH 6/6] psi: introduce psi monitor
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Jens Axboe <axboe@kernel.dk>, dennis@kernel.org,
        Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 9:58 AM 'Suren Baghdasaryan' via kernel-team
<kernel-team@android.com> wrote:
>
> Current design supports only whole percentages and if userspace needs
> more granularity then it has to use usecs.
> I agree that usecs cover % usecase and "threshold * win / 100" is
> simple enough for userspace to calculate. I'm fine with changing to
> usecs only.

Suren, please avoid top-posting to LKML.

Also I was going to say the same thing, just usecs only is better.

thanks,

 - Joel

> On Tue, Dec 18, 2018 at 9:30 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Dec 18, 2018 at 11:46:22AM +0100, Peter Zijlstra wrote:
> > > On Mon, Dec 17, 2018 at 05:21:05PM -0800, Suren Baghdasaryan wrote:
> > > > On Mon, Dec 17, 2018 at 8:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > > > How well has this thing been fuzzed? Custom string parser, yay!
> > > >
> > > > Honestly, not much. Normal cases and some obvious corner cases. Will
> > > > check if I can use some fuzzer to get more coverage or will write a
> > > > script.
> > > > I'm not thrilled about writing a custom parser, so if there is a
> > > > better way to handle this please advise.
> > >
> > > The grammar seems fairly simple, something like:
> > >
> > >   some-full = "some" | "full" ;
> > >   threshold-abs = integer ;
> > >   threshold-pct = integer, { "%" } ;
> > >   threshold = threshold-abs | threshold-pct ;
> > >   window = integer ;
> > >   trigger = some-full, space, threshold, space, window ;
> > >
> > > And that could even be expressed as two scanf formats:
> > >
> > >  "%4s %u%% %u" , "%4s %u %u"
> > >
> > > which then gets your something like:
> > >
> > >   char type[5];
> > >
> > >   if (sscanf(input, "%4s %u%% %u", &type, &pct, &window) == 3) {
> > >       // do pct thing
> > >   } else if (sscanf(intput, "%4s %u %u", &type, &thres, &window) == 3) {
> > >       // do abs thing
> > >   } else return -EFAIL;
> > >
> > >   if (!strcmp(type, "some")) {
> > >       // some
> > >   } else if (!strcmp(type, "full")) {
> > >       // full
> > >   } else return -EFAIL;
> > >
> > >   // do more
> >
> > We might want to drop the percentage notation.
> >
> > While it's somewhat convenient, it's also not unreasonable to ask
> > userspace to do a simple "threshold * win / 100" themselves, and it
> > would simplify the interface spec and the parser.
> >
> > Sure, psi outputs percentages, but only for fixed window sizes, so
> > that actually saves us something, whereas this parser here needs to
> > take a fractional anyway. The output is also in decimal notation,
> > which is necessary for granularity. And I really don't think we want
> > to add float parsing on top of this interface spec.
> >
> > So neither the convenience nor the symmetry argument are very
> > compelling IMO. It might be better to just not go there.
>
> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908FEC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFC02064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="O69wJKPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFC02064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeJSBbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:31:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33337 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJSBbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:31:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so2335903wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pQI5IFcZr6aMajzeJgqYkjwsGAqGYk3eye6qm5t2GeY=;
        b=O69wJKPGnSg07SB5Bgv9x1lqQ9tD1LZzVKHw4zDlWLjFRHQpHaiLhXgKo/xsjUVYVp
         eJtMOoX4RjqR960l1CveJCKBoTs19Vq7sT0bPqFk/DMcwnh+nKXdsFxvYlQnzjIoG78R
         SBWKwxoRK+37tH4M1+9f3kqy7TmeDDoqt6YpK2pWbeaS9k9rNP93NNjlLQpJ2hXJxKTk
         w4P41dM3rL4I6JfjJJxbmd8DnHzucw3gIHvpto1BCXFgbKM6yBbggC7R7ww6Ir5GEQGO
         a6T/MnsV+RhWQOk6vP701jEGH3wgHxuT7NLqmRxKzLdxRrjfxaiLQqgME15OT7NMt8eH
         BAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pQI5IFcZr6aMajzeJgqYkjwsGAqGYk3eye6qm5t2GeY=;
        b=IW5OA3Fy2rYTJPAsMcOiNt8+1o2KJPq3qKq/DvvOJX1yohsXpdtCT6xjXh2vSLzzm6
         Zi1W1yK4zO446M9A50ioxdJhLj2dv012vm3s87/ZBSj8delT3+ZeM12YT/I8zUF+MEwg
         SfWssoCt7tQxmk6ns3l5g4xtg979TsH8I96S4tPEHg1UzBBSpH+/WHea0KmXSNjHEXSr
         CDLg1Ko/3cM1F5v6N5gBMSJlJ+sT/ZY2gahy8ChHlXaD08LRMSygdh9ovO8qCRRJdxbO
         z+rjohZ1i+jWfO5211gWWCjn47jq+SrNB6TR+VNM4KTDyf2vz4BKvRTuAVT/06cUJyGa
         rmzw==
X-Gm-Message-State: ABuFfogEuAPGdMUN7DS0XIAbG6bYxV/R7hgIl7GVQLpb3kJfTth4vzmk
        P6RBqI9OLXDcO1E6pguWNQ4BOgEVjxQLD6poGWiopg==
X-Google-Smtp-Source: ACcGV62jhbm8rweOpKYOnyCsphfrQa8xI9kLlAKONkCSsBfApJy45JhLd8pdZgRhbjY/LLtkpPa5jfyHRnsHFIkKNt8=
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr1326070wmq.14.1539883765074;
 Thu, 18 Oct 2018 10:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181018005420.82993-1-namit@vmware.com> <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net> <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com> <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <2054C1A9-37C1-4A5A-A716-EDAC90564D2A@vmware.com>
In-Reply-To: <2054C1A9-37C1-4A5A-A716-EDAC90564D2A@vmware.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 18 Oct 2018 10:29:13 -0700
Message-ID: <CALCETrUQwHysVOJ2G8AQF25TRVaqUi7k93K8nks4Yp+fFehVBA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:25 AM Nadav Amit <namit@vmware.com> wrote:
>
> at 10:00 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>
> >
> >
> >> On Oct 18, 2018, at 9:47 AM, Nadav Amit <namit@vmware.com> wrote:
> >>
> >> at 8:51 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> >>
> >>>> On Wed, Oct 17, 2018 at 8:12 PM Nadav Amit <namit@vmware.com> wrote:
> >>>> at 6:22 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> >>>>
> >>>>>> On Oct 17, 2018, at 5:54 PM, Nadav Amit <namit@vmware.com> wrote:
> >>>>>>
> >>>>>> It is sometimes beneficial to prevent preemption for very few
> >>>>>> instructions, or prevent preemption for some instructions that pre=
cede
> >>>>>> a branch (this latter case will be introduced in the next patches)=
.
> >>>>>>
> >>>>>> To provide such functionality on x86-64, we use an empty REX-prefi=
x
> >>>>>> (opcode 0x40) as an indication that preemption is disabled for the
> >>>>>> following instruction.
> >>>>>
> >>>>> Nifty!
> >>>>>
> >>>>> That being said, I think you have a few bugs. First, you can=E2=80=
=99t just ignore
> >>>>> a rescheduling interrupt, as you introduce unbounded latency when t=
his
> >>>>> happens =E2=80=94 you=E2=80=99re effectively emulating preempt_enab=
le_no_resched(), which
> >>>>> is not a drop-in replacement for preempt_enable(). To fix this, you=
 may
> >>>>> need to jump to a slow-path trampoline that calls schedule() at the=
 end or
> >>>>> consider rewinding one instruction instead. Or use TF, which is onl=
y a
> >>>>> little bit terrifying=E2=80=A6
> >>>>
> >>>> Yes, I didn=E2=80=99t pay enough attention here. For my use-case, I =
think that the
> >>>> easiest solution would be to make synchronize_sched() ignore preempt=
ions
> >>>> that happen while the prefix is detected. It would slightly change t=
he
> >>>> meaning of the prefix.
> >>
> >> So thinking about it further, rewinding the instruction seems the easi=
est
> >> and most robust solution. I=E2=80=99ll do it.
> >>
> >>>>> You also aren=E2=80=99t accounting for the case where you get an ex=
ception that
> >>>>> is, in turn, preempted.
> >>>>
> >>>> Hmm.. Can you give me an example for such an exception in my use-cas=
e? I
> >>>> cannot think of an exception that might be preempted (assuming #BP, =
#MC
> >>>> cannot be preempted).
> >>>
> >>> Look for cond_local_irq_enable().
> >>
> >> I looked at it. Yet, I still don=E2=80=99t see how exceptions might ha=
ppen in my
> >> use-case, but having said that - this can be fixed too.
> >
> > I=E2=80=99m not totally certain there=E2=80=99s a case that matters.  B=
ut it=E2=80=99s worth checking
> >
> >> To be frank, I paid relatively little attention to this subject. Any
> >> feedback about the other parts and especially on the high-level approa=
ch? Is
> >> modifying the retpolines in the proposed manner (assembly macros)
> >> acceptable?
> >
> > It=E2=80=99s certainly a neat idea, and it could be a real speedup.
>
> Great. So I=E2=80=99ll try to shape things up, and I still wait for other=
 comments
> (from others).
>
> I=E2=80=99ll just mention two more patches I need to cleanup (I know I st=
ill owe you some
> work, so obviously it will be done later):
>
> 1. Seccomp trampolines. On my Ubuntu, when I run Redis, systemd installs =
17
> BPF filters on the Redis server process that are invoked on each
> system-call. Invoking each one requires an indirect branch. The patch kee=
ps
> a per-process kernel code-page that holds trampolines for these functions=
.

I wonder how many levels of branches are needed before the branches
involved exceed the retpoline cost.

>
> 2. Binary-search for system-calls. Use the per-process kernel code-page a=
lso
> to hold multiple trampolines for the 16 common system calls of a certain
> process. The patch uses an indirection table and a binary-search to find =
the
> proper trampoline.

Same comment applies here.

>
> Thanks again,
> Nadav



--=20
Andy Lutomirski
AMA Capital Management, LLC

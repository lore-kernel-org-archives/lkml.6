Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC6AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD4B2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtJ/j+gX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD4B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbeKVK55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:57:57 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39952 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbeKVK54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:57:56 -0500
Received: by mail-vs1-f65.google.com with SMTP id z3so4360987vsf.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 16:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGafZM8nHztSVoXzvUk9Gd122Ugi4qjzBznaComsH8Y=;
        b=TtJ/j+gXIXQ/NnAtsRbeulJiJq8sqvcOm/cNyhNee3K8aeqfLAwfkQYKidDAfMdwDj
         ZS+FJ4R1uNq/eoR1nHjGaa5auKk9Dc9rBWEe39nIBs8/qlKi3iP+HJmgrDVkbeX4LqAK
         AjAD4q2OlYCMwXkn3U7Wml/TnZo2jKJTX2cHNbsqmmXngjn0f2JM7u1Kikwf617OJsBd
         WQxxqEQPthuu4JX1rMvY/TZJF0iLZJb3Z216/Qp/wSOZowAoJr0HCV0U7cikisl/2w/P
         wrAGqiZfDwGIhBs6iaobWnud5UdLUiPQhR+IhGoZiTfMmSs4S9Qzv27AYggBUc/JZmyq
         TSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGafZM8nHztSVoXzvUk9Gd122Ugi4qjzBznaComsH8Y=;
        b=Exc06iNFiC+PxunxmGI1+2EFoDilul9jmYgIRR8+V1PGWH51EAU0Pvs2tgkEGFatx+
         h2YvcrRG6usB8o+EKwVtFe8nQZWVSBNZ9q7lzvZFHrjyRmzoPpnHroWULnQb4CrtTJCR
         TQXuRWObLZDIqcbWFoW3mzE4IpXmZT0By5JYk+HX4fNufHGSEkKQZI82GVCtNnUjdZGK
         GVypNMTIS2T+6uxP8oGdARE3hfEj9qDMvYBxOK91bkeL62p48dscrHHEfK321kBaR4Lr
         AvQrnWc1wyujPurXOqIyE4CBRzDoHLBg7ScN6r/bc8jCIMJuQj7DIyNPFfUBSN7Uhi5F
         Dbgw==
X-Gm-Message-State: AGRZ1gJfRQ8UczbHfOI6QEw2IcsHEkcruVnutAZy056chTshZs72wjzB
        PKFB04yg+O5R6TcBcRKve/UU/414BaxO2bn93FZHow==
X-Google-Smtp-Source: AJdET5c5/2UBHIs7I8nidaCaWbhzHSxXrt1uqb/WsC009aCb4hhlC93VrOhp4pk30fNOD5bH2D2ZlhbGFMcuvP3j0uA=
X-Received: by 2002:a67:105:: with SMTP id 5mr3689481vsb.183.1542846072209;
 Wed, 21 Nov 2018 16:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20181121201452.77173-1-dancol@google.com> <20181121205428.165205-1-dancol@google.com>
 <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org>
 <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com>
 <20181121145043.fa029f4f91afddc2a10bb81e@linux-foundation.org>
 <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com> <37255927-1A93-4B8B-A916-B5A3983D56B6@amacapital.net>
In-Reply-To: <37255927-1A93-4B8B-A916-B5A3983D56B6@amacapital.net>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 21 Nov 2018 16:21:00 -0800
Message-ID: <CAKOZuev9LpJHVw=Hk+rkZVktb0ahR8eVMtjt=npuwj3qptQc4A@mail.gmail.com>
Subject: Re: [PATCH v2] Add /proc/pid_gen
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Primiano Tucci <primiano@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@kernel.org, linux@dominikbrodowski.net,
        jpoimboe@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ktsanaktsidis@zendesk.com, David Howells <dhowells@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 3:35 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > On Nov 21, 2018, at 4:21 PM, Daniel Colascione <dancol@google.com> wrote:
> >
> >> On Wed, Nov 21, 2018 at 2:50 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>
> >>> On Wed, 21 Nov 2018 14:40:28 -0800 Daniel Colascione <dancol@google.com> wrote:
> >>>
> >>>> On Wed, Nov 21, 2018 at 2:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>>>
> >>>>> On Wed, 21 Nov 2018 12:54:20 -0800 Daniel Colascione <dancol@google.com> wrote:
> >>>>>
> >>>>> Trace analysis code needs a coherent picture of the set of processes
> >>>>> and threads running on a system. While it's possible to enumerate all
> >>>>> tasks via /proc, this enumeration is not atomic. If PID numbering
> >>>>> rolls over during snapshot collection, the resulting snapshot of the
> >>>>> process and thread state of the system may be incoherent, confusing
> >>>>> trace analysis tools. The fundamental problem is that if a PID is
> >>>>> reused during a userspace scan of /proc, it's impossible to tell, in
> >>>>> post-processing, whether a fact that the userspace /proc scanner
> >>>>> reports regarding a given PID refers to the old or new task named by
> >>>>> that PID, as the scan of that PID may or may not have occurred before
> >>>>> the PID reuse, and there's no way to "stamp" a fact read from the
> >>>>> kernel with a trace timestamp.
> >>>>>
> >>>>> This change adds a per-pid-namespace 64-bit generation number,
> >>>>> incremented on PID rollover, and exposes it via a new proc file
> >>>>> /proc/pid_gen. By examining this file before and after /proc
> >>>>> enumeration, user code can detect the potential reuse of a PID and
> >>>>> restart the task enumeration process, repeating until it gets a
> >>>>> coherent snapshot.
> >>>>>
> >>>>> PID rollover ought to be rare, so in practice, scan repetitions will
> >>>>> be rare.
> >>>>
> >>>> In general, tracing is a rather specialized thing.  Why is this very
> >>>> occasional confusion a sufficiently serious problem to warrant addition
> >>>> of this code?
> >>>
> >>> I wouldn't call tracing a specialized thing: it's important enough to
> >>> justify its own summit and a whole ecosystem of trace collection and
> >>> analysis tools. We use it in every day in Android. It's tremendously
> >>> helpful for understanding system behavior, especially in cases where
> >>> multiple components interact in ways that we can't readily predict or
> >>> replicate. Reliability and precision in this area are essential:
> >>> retrospective analysis of difficult-to-reproduce problems involves
> >>> puzzling over trace files and testing hypothesis, and when the trace
> >>> system itself is occasionally unreliable, the set of hypothesis to
> >>> consider grows. I've tried to keep the amount of kernel infrastructure
> >>> needed to support this precision and reliability to a minimum, pushing
> >>> most of the complexity to userspace. But we do need, from the kernel,
> >>> reliable process disambiguation.
> >>>
> >>> Besides: things like checkpoint and restart are also non-core
> >>> features, but the kernel has plenty of infrastructure to support them.
> >>> We're talking about a very lightweight feature in this thread.
> >>
> >> I'm still not understanding the seriousness of the problem.  Presumably
> >> you've hit problems in real-life which were serious and frequent enough
> >> to justify getting down and writing the code.  Please share some sob stories
> >> with us!
> >
> > The problem here is the possibility of confusion, even if it's rare.
> > Does the naive approach of just walking /proc and ignoring the
> > possibility of PID reuse races work most of the time? Sure. But "most
> > of the time" isn't good enough. It's not that there are tons of sob
> > stories: it's that without completely robust reporting, we can't rule
> > out of the possibility that weirdness we observe in a given trace is
> > actually just an artifact from a kinda-sort-working best-effort trace
> > collection system instead of a real anomaly in behavior. Tracing,
> > essentially, gives us deltas for system state, and without an accurate
> > baseline, collected via some kind of scan on trace startup, it's
> > impossible to use these deltas to robustly reconstruct total system
> > state at a given time. And this matters, because errors in
> > reconstruction (e.g., assigning a thread to the wrong process because
> > the IDs happen to be reused) can affect processing of the whole trace.
> > If it's 3am and I'm analyzing the lone trace from a dogfooder
> > demonstrating a particularly nasty problem, I don't want to find out
> > that the trace I'm analyzing ended up being useless because the
> > kernel's trace system is merely best effort. It's very cheap to be
> > 100% reliable here, so let's be reliable and rule out sources of
> > error.
> >
> >>>> Which userspace tools will be using pid_gen?  Are the developers of
> >>>> those tools signed up to use pid_gen?
> >>>
> >>> I'll be changing Android tracing tools to capture process snapshots
> >>> using pid_gen, using the algorithm in the commit message.
> >>
> >> Which other tools could use this and what was the feedback from their
> >> developers?
> >
> > I'm going to have Android's systrace and Perfetto use this approach.
> > Exactly how many tools signed up to use this feature do you need?
> >
> >> Those people are the intended audience and the
> >> best-positioned reviewers so let's hear from them?
> >
> > I'm writing plenty of trace analysis tools myself, so I'm part of this
> > intended audience. Other tracing tool authors have told me about
> > out-of-tree hacks for process atomic snapshots via ftrace events. This
> > approach avoids the necessity of these more-invasive hacks.
>
> Would a tracepoint for pid reuse solve your problem?

I initially thought "no", but maybe it would after all.

The /proc scanner would need some way of consuming this tracepoint so
that it would know to re-run the scan. For some tracing systems (like
Perfetto) doing simultaneous event consumption and recording would
work (although it'd be awkward), but other systems (like things based
on the simpler atrace framework) aren't able to process events, and
inferring PID reuse after the fact it's as helpful as being able to
re-scan in response to PID rollover.

OTOH, the ftrace histogram stuff could record a running count of
rollovers events pretty easily independent of the trace recording
machinery, and that running event count would be good enough for doing
the re-scan I want. If /proc/pid_gen isn't on the table, doing it that
way (with a new tracepoint) would work too. There'd be no way to
separate out rollovers per PID namespace though, so we'd have to
re-scan when *any* PID namespace rolled over, not just the current
one. But that's probably not a problem.

I'll send a patch with a PID rollover tracepoint. Thanks.

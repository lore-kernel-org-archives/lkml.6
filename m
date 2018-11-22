Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326E0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E3F206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFsLpiVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E3F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388667AbeKVLHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:07:40 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37681 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388600AbeKVLHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:07:40 -0500
Received: by mail-ua1-f67.google.com with SMTP id u19so2561057uae.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 16:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vT5QLQLBvF9tb71lEfzgsLD/mZfphxrvGxwn3SOscDE=;
        b=RFsLpiVhFTA9C3N3WxgW0gr562MUdo5coo7V1VsgLP3muD7cIxAC1VdnLmMYiowHD/
         BHQsd3xEvJJDYwj29BFjKXiiszTI0ZijJ6F1c6PqLC6HMpYkOUVCdlvsK/uPLC7fdX4m
         +tu8KS0Y7Lrk+RYzGcf8aHAW29l92Cvv13shkVEC4cuPawFUGNmMB/rQEQxrMdMgu6+M
         JZyLOwzwH6a3RrHbiDMzE43eeLYwY+k9TyM7H+Q1c/dzDj3vOyxbGiSgpjvL8/BiidUX
         IcTerfFAmNXPVCwN5/UhsDFRrj10gQ2Y7oWpRnI5tsDEE1g9zhUjYXujbzSz+IrPzwBy
         II/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vT5QLQLBvF9tb71lEfzgsLD/mZfphxrvGxwn3SOscDE=;
        b=J6x3zajjAKwU6z7qJg4QdmCrc3mGyqFPfDAg6/Hp+nXHZJc9p8GDMKY3Zu82xEk434
         Sf6IfPV76jPCRVycuFdEBDC2g/4Wz7CMQxM0YkxNIE81Nmq156T+ZitVKDV8VDCxbu+6
         gBUstJ38198iQXBdrVoYluNKjR4iEFy8yFzr00/Sx2HvagqMHJb79ezUINwgwr7eOBsF
         OAYip8ewjgc0czC+deJ+irM5WMchRIDQw5cH3i2SiSTYuBP7Jl7ONuXexHq89ziVNVTQ
         sxovpfyYpobDRCgPwuYtr7IzUj7IapivxOKWyrUcUcvFbOPgLjYMsgj4PPVDy2AJPIKR
         R0Hg==
X-Gm-Message-State: AA+aEWbOR5B3YySCdnaIyRflhTcG2DpFpvbQACYNtmHJo6yCXuRppBih
        GWK/FOB4dOYVvnNWbb5xQ60xFsbb0ONPpNIwxRK4GA==
X-Google-Smtp-Source: AFSGD/UdfCXRb/SkRpbsEyR87T/swtoCu+4IxX4rlp49zhlyOWbbvlOa0nHEnaTV6JmJCXIjtVZPigaj7qGLp8stwPw=
X-Received: by 2002:ab0:45e2:: with SMTP id u89mr3799107uau.13.1542846653783;
 Wed, 21 Nov 2018 16:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20181121201452.77173-1-dancol@google.com> <20181121205428.165205-1-dancol@google.com>
 <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org>
 <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com>
 <20181121145043.fa029f4f91afddc2a10bb81e@linux-foundation.org>
 <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com>
 <20181121162247.467fcab6c0aca0819a822286@linux-foundation.org> <CAKOZuet7ipw8zoXCDQUB5PKs3kdSye-zesBbEv7jVDSByhXgkw@mail.gmail.com>
In-Reply-To: <CAKOZuet7ipw8zoXCDQUB5PKs3kdSye-zesBbEv7jVDSByhXgkw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 21 Nov 2018 16:30:42 -0800
Message-ID: <CAKOZueuV=X4eqc+-8Jh3Z-2iQO+4fp2otEOs03yQoaa88C9zUA@mail.gmail.com>
Subject: Re: [PATCH v2] Add /proc/pid_gen
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 4:28 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Wed, Nov 21, 2018 at 4:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 21 Nov 2018 15:21:40 -0800 Daniel Colascione <dancol@google.com> wrote:
> >
> > > On Wed, Nov 21, 2018 at 2:50 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Wed, 21 Nov 2018 14:40:28 -0800 Daniel Colascione <dancol@google.com> wrote:
> > > >
> > > > > On Wed, Nov 21, 2018 at 2:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > ...
> > >
> > > > > I wouldn't call tracing a specialized thing: it's important enough to
> > > > > justify its own summit and a whole ecosystem of trace collection and
> > > > > analysis tools. We use it in every day in Android. It's tremendously
> > > > > helpful for understanding system behavior, especially in cases where
> > > > > multiple components interact in ways that we can't readily predict or
> > > > > replicate. Reliability and precision in this area are essential:
> > > > > retrospective analysis of difficult-to-reproduce problems involves
> > > > > puzzling over trace files and testing hypothesis, and when the trace
> > > > > system itself is occasionally unreliable, the set of hypothesis to
> > > > > consider grows. I've tried to keep the amount of kernel infrastructure
> > > > > needed to support this precision and reliability to a minimum, pushing
> > > > > most of the complexity to userspace. But we do need, from the kernel,
> > > > > reliable process disambiguation.
> > > > >
> > > > > Besides: things like checkpoint and restart are also non-core
> > > > > features, but the kernel has plenty of infrastructure to support them.
> > > > > We're talking about a very lightweight feature in this thread.
> > > >
> > > > I'm still not understanding the seriousness of the problem.  Presumably
> > > > you've hit problems in real-life which were serious and frequent enough
> > > > to justify getting down and writing the code.  Please share some sob stories
> > > > with us!
> > >
> > > The problem here is the possibility of confusion, even if it's rare.
> > > Does the naive approach of just walking /proc and ignoring the
> > > possibility of PID reuse races work most of the time? Sure. But "most
> > > of the time" isn't good enough. It's not that there are tons of sob
> > > stories: it's that without completely robust reporting, we can't rule
> > > out of the possibility that weirdness we observe in a given trace is
> > > actually just an artifact from a kinda-sort-working best-effort trace
> > > collection system instead of a real anomaly in behavior. Tracing,
> > > essentially, gives us deltas for system state, and without an accurate
> > > baseline, collected via some kind of scan on trace startup, it's
> > > impossible to use these deltas to robustly reconstruct total system
> > > state at a given time. And this matters, because errors in
> > > reconstruction (e.g., assigning a thread to the wrong process because
> > > the IDs happen to be reused) can affect processing of the whole trace.
> > > If it's 3am and I'm analyzing the lone trace from a dogfooder
> > > demonstrating a particularly nasty problem, I don't want to find out
> > > that the trace I'm analyzing ended up being useless because the
> > > kernel's trace system is merely best effort. It's very cheap to be
> > > 100% reliable here, so let's be reliable and rule out sources of
> > > error.
> >
> > So we're solving a problem which isn't known to occur, but solving it
> > provides some peace-of-mind?  Sounds thin!
>
> So you want to reject a cheap fix for a problem that you know occurs
> at some non-zero frequency? There's a big difference between "may or
> may not occur" and "will occur eventually, given enough time, and so
> must be taken into account in analysis". Would you fix a refcount race
> that you knew was possible, but didn't observe? What, exactly, is your
> threshold for accepting a fix that makes tracing more reliable?

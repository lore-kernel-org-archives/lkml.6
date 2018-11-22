Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F335C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E9120831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhHxGVrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E9120831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbeKVLFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:05:54 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33976 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbeKVLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:05:53 -0500
Received: by mail-vs1-f65.google.com with SMTP id y27so4386290vsi.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 16:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xy2Gwtr+xMhN1Vnc7itdWgAUvkL2cxyloK0TeCw0FCU=;
        b=FhHxGVrET7GYjU8rAJhTVHCd5Qn+J6jkOFuOzzY+sMc2WS+EWcQzUh5obpxA26dsI1
         sXRooCxTYhyqGyjN0omhUAMSoYxEHRodLgHj+i8acOFkrfHKondhOHo4m8rVVv/hkNYJ
         bTfjzSmhUcBLfrEZ4lQFZeCh6qhQ/T6eMCugP7pcHC8PD3YflV1negwmwdwPQyASVaCo
         RQp7eQnSfZlqfjIclokpowge66kyrFXb9xeedLrogUcXYW4rZ4wJU6WyNEEh1I8jxLk6
         yRyZpfNF9BNFS1UHmGxbL1bOWnW2X4mH85J5k/wak8D3Dzw6jsuWq3BH7ZyJdtIlqWf+
         OaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xy2Gwtr+xMhN1Vnc7itdWgAUvkL2cxyloK0TeCw0FCU=;
        b=LFTmqp5K41sEmrLXARcrJhwfOF4mPYdk5YbEHV/5ouPO2QCMDqw3I2t6lSr0/+GzNU
         geACMpzkp3hOqi4hQZl7Z5gmzmYvK8kAvooVEh0CcAKFXAjoXAJCKUbmk4WiUr6qWUuY
         rBJywS73quSPsIjwsJPgGxAuRVmxZlm7CIVyzKPFiXSC5ebqd0sFcKeIWKz2PFJwytI2
         PlSIWP2WCl9rXTal3kx/bUQ0Uh+8Rt6808hKHsdwqwLHcAzP/Za+rUCBZPNAk0F+ZcFB
         /XpGmG2JNrFj22YNrPpa+VHxe2xyKZkxkqX2lvUwMbyoBGiX6CSugfgQB9yqTN8Y8ZRI
         cbgg==
X-Gm-Message-State: AGRZ1gJOTzZaN9+1/lYkP22P0cnoxYGo+UGK6jotHUwF8TtFpkP/lP1A
        5/2egASZPqeu22I8bd6P/peNdxRxnsQpqTL+dlA2ScbU0JY=
X-Google-Smtp-Source: AJdET5cDS8K5BZwMhtVvu12CvsqDkNHmmGkj954vlWsGZQ6WBxUWud1nsTY1tslxek5WeYqsxjY40fb5oXUTOIS1jxM=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr3832399vsc.171.1542846547829;
 Wed, 21 Nov 2018 16:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20181121201452.77173-1-dancol@google.com> <20181121205428.165205-1-dancol@google.com>
 <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org>
 <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com>
 <20181121145043.fa029f4f91afddc2a10bb81e@linux-foundation.org>
 <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com> <20181121162247.467fcab6c0aca0819a822286@linux-foundation.org>
In-Reply-To: <20181121162247.467fcab6c0aca0819a822286@linux-foundation.org>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 21 Nov 2018 16:28:56 -0800
Message-ID: <CAKOZuet7ipw8zoXCDQUB5PKs3kdSye-zesBbEv7jVDSByhXgkw@mail.gmail.com>
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 4:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 21 Nov 2018 15:21:40 -0800 Daniel Colascione <dancol@google.com> wrote:
>
> > On Wed, Nov 21, 2018 at 2:50 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 21 Nov 2018 14:40:28 -0800 Daniel Colascione <dancol@google.com> wrote:
> > >
> > > > On Wed, Nov 21, 2018 at 2:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > ...
> >
> > > > I wouldn't call tracing a specialized thing: it's important enough to
> > > > justify its own summit and a whole ecosystem of trace collection and
> > > > analysis tools. We use it in every day in Android. It's tremendously
> > > > helpful for understanding system behavior, especially in cases where
> > > > multiple components interact in ways that we can't readily predict or
> > > > replicate. Reliability and precision in this area are essential:
> > > > retrospective analysis of difficult-to-reproduce problems involves
> > > > puzzling over trace files and testing hypothesis, and when the trace
> > > > system itself is occasionally unreliable, the set of hypothesis to
> > > > consider grows. I've tried to keep the amount of kernel infrastructure
> > > > needed to support this precision and reliability to a minimum, pushing
> > > > most of the complexity to userspace. But we do need, from the kernel,
> > > > reliable process disambiguation.
> > > >
> > > > Besides: things like checkpoint and restart are also non-core
> > > > features, but the kernel has plenty of infrastructure to support them.
> > > > We're talking about a very lightweight feature in this thread.
> > >
> > > I'm still not understanding the seriousness of the problem.  Presumably
> > > you've hit problems in real-life which were serious and frequent enough
> > > to justify getting down and writing the code.  Please share some sob stories
> > > with us!
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
>
> So we're solving a problem which isn't known to occur, but solving it
> provides some peace-of-mind?  Sounds thin!

So you want to reject a cheap fix for a problem that you know occurs
at some non-zero frequency? There's a big difference between "may or
may not occur" and "will occur eventually, given enough time, and so
must be taken into account in analysis". Would you fix a refcount race
that you knew was possible, but didn't observe? What, exactly, is your
threshold for accepting a fix that makes tracing more reliable?

Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A5FECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0CB214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0CB214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbeIURJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:09:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34978 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeIURJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:09:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so11084583oic.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 04:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjQs98Pn6OPLKTxfJ9NuoKO7MPyxOGpz1R09Y+h7J+8=;
        b=YPOFBtjzghg1X+iLtj0otrHSHlas4ZDxvQfMbz9yAImmxepkjRHBOnS5iMsPOamfW8
         cXO51S9nuvd6JBZLtg8Ye0w4u8wZLUWAcXvlumMf1Hv2cfo/IT7Otit/ffZ0YPbOGUkP
         nlaf41lyBPNd/nFTiCzNSpUsg+yUKwg2g+42W2vCqAN1e9rkBkmcHW91X3EGN7gyDwa9
         vSWYCTyM2fVbeLFNFaCf+OhhaAtpLM8/NMArKCselWycGKs0wVSH3+Jp+d1A/vkQSJCo
         zPInYawnVnkEGp9RncAh2rZDgcMgmu5Cj0KZ8Uv6RlqEjtXRPHDE+TLU+8yqjDNuIwNJ
         5v/w==
X-Gm-Message-State: APzg51Cg34z0WcbkNqgrAuHZanpfY68PqN9rHoV0SsLbY0SSAxai0ujd
        cKnubTLwktb3E/Zb560q0uRa/fMah6U1z9Ws0/ILiQ==
X-Google-Smtp-Source: ANB0Vdb4Rhynk5FVrkO9TDsyEwqo1oE27nopMgIKw8zXgkqT3Qa6uv/pv9j+Dae8718w98dZwVm7+TkLclfp54wCdqI=
X-Received: by 2002:aca:4fcd:: with SMTP id d196-v6mr1202931oib.51.1537528894069;
 Fri, 21 Sep 2018 04:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-2-omosnace@redhat.com>
 <CAHC9VhTZkrmgt7rxNYWTgYvm+TVGgRD6iFu9dDtZ7eYNXBKqHQ@mail.gmail.com>
 <CAFqZXNuir-8TE7WUHYhw5t446THO=sCjOXv+WAxNDs79e6OTWQ@mail.gmail.com> <CAHC9VhQ8dRTzC8vBsUOm8o4LQxVRiwgkSb23xEZwSDfsXhY3uw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ8dRTzC8vBsUOm8o4LQxVRiwgkSb23xEZwSDfsXhY3uw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 21 Sep 2018 13:21:22 +0200
Message-ID: <CAFqZXNtqe8fF318pzmxzGaZgO0Mb_cacNKTRRbFNyMFhxUspJg@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 4:51 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Sep 17, 2018 at 8:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, Sep 14, 2018 at 5:19 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Aug 24, 2018 at 8:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > This patch adds two auxiliary record types that will be used to annotate
> > > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > > been changed.
> > > >
> > > > Next, it adds two functions to the audit interface:
> > > >  - audit_tk_injoffset(), which will be called whenever a timekeeping
> > > >    offset is injected by a syscall from userspace,
> > > >  - audit_ntp_adjust(), which will be called whenever an NTP internal
> > > >    variable is changed by a syscall from userspace.
> > > >
> > > > Quick reference for the fields of the new records:
> > > >     AUDIT_TIME_INJOFFSET
> > > >         sec - the 'seconds' part of the offset
> > > >         nsec - the 'nanoseconds' part of the offset
> > > >     AUDIT_TIME_ADJNTPVAL
> > > >         op - which value was adjusted:
> > > >             offset - corresponding to the time_offset variable
> > > >             freq   - corresponding to the time_freq variable
> > > >             status - corresponding to the time_status variable
> > > >             adjust - corresponding to the time_adjust variable
> > > >             tick   - corresponding to the tick_usec variable
> > > >             tai    - corresponding to the timekeeping's TAI offset
> > >
> > > I understand that reusing "op" is tempting, but the above aren't
> > > really operations, they are state variables which are being changed.
> >
> > I remember Steve (or was it Richard?) convincing me at one of the
> > meetings that "op" is the right filed name to use, despite it not
> > being a name for an operation... But I don't really care, I'm okay
> > with changing it to e.g. "var" as Richard suggests later in this
> > thread.
>
> As I said before, this seems like an abuse of the "op" field.
>
> > > Using the CONFIG_CHANGE record as a basis, I wonder if we are better
> > > off with something like the following:
> > >
> > >  type=TIME_CHANGE <var>=<value_new> old=<value_old>
> > >
> > > ... you might need to preface the variable names with something like
> > > "ntp_" or "offset_".  You'll notice I'm also suggesting we use a
> > > single record type here; is there any reason why two records types are
> > > required?
> >
> > There are actually two reasons:
> > 1. The injected offset is a timespec64, so it consists of two integer
> > values (and it would be weird to produce two records for it, since IMO
> > it is conceptually still a single variable).
> > 2. In all other cases the variable is reset to the (possibly
> > transformed) input value, while in this case the input value is added
> > directly to the system time. This can be viewed as a kind of variable
> > too, but it would be weird to report old and new value for it, since
> > its value flows with time.
> >
> > Plus, when I look at:
> > type=TIME_INJOFFSET [...]: sec=-16 nsec=124887145
> >
> > I can immediately see that the time was shifted back by 16-something
> > seconds, while when I look at something like:
> >
> > type=TIME_CHANGE [...]: var=time_sec new=1537185685 old=1537185701
> > type=TIME_CHANGE [...]: var=time_nsec new=664373417 old=789260562
> >
> > I can just see some big numbers that I need to do math with before I
> > get an idea of what is the magnitude (or sign) of the change.
>
> Okay, with that in mind, perhaps when recording the offset values we
> omit the "old" values (arguably that doesn't make much sense here) and
> keep the sec/nsec split:
>
> type=TIME_CHANGE [...]: offset_sec=<X> offset_nsec=<Y>
>
> ... and for all others we stick with:
>
> type=TIME_CHANGE [...]: ntp_<VAR>=<NEWVAL> old=<OLD_VAL>

Alright, that format would work. However, I would still like to have a
separate type for the offset injection, since it has different field
structure and semantics (difference vs. new+old). I don't see any
reason to sacrifice the distinction for just one record type slot
(AFAIK we technically still have about 2 billion left...).

(Maybe you just duplicated the record type by mistake, in that case
please disregard the last sentence.)

>
> ... and if that results in multiple TIME_CHANGE records for a given
> event, that's fine with me.
>
> > > A reminder that we need tests for these new records and a RFE page on the wiki:
> > >
> > > * https://github.com/linux-audit/audit-testsuite
> >
> > I was going to start working on this once the format issues are
> > settled. (Although I probably should have kept the RFC in the subject
> > until then...)
> >
> > > * https://github.com/linux-audit/audit-kernel/wiki
> >
> > I admit I forgot about this duty, but again I would like to wait for
> > the discussions to settle before writing that up.
>
> That is fine, do it in whatever order works best for you, just
> understand that I'm probably not going to merge patches like this
> until I see both documentation and tests.
>
> --
> paul moore
> www.paul-moore.com

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.

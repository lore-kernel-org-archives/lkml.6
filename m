Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025C1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73172147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ImpZ3ONa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73172147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeIQUSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:18:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40746 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbeIQUSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:18:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id x26-v6so13838674lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxqryL9iXOL37JnZMrEHvO8DFYjQmv5awHEdDAfZjo4=;
        b=ImpZ3ONafhMfd15iWxMDoQiFJ+ODVb816P9yKrsjtIGEwZ/zX9hiGU0VLz9BQZ78Qb
         lilhIP2DUJaPgDtW+betV0sRxhNysF+68X02AkjyGrtQVb7jg83Xz9tLH6Gr7ZyxT7q6
         OQ5UBfgnmrihRU9Jvz85onwafLy/j+v1r06RzJx2lnBe/o1nRM04ovK2NQfsweWiekut
         x1Dr5uep+xQmNlO62J/BtabTe3U0BdK24xadOoPDErYcNHTK29+20ersM1LplNyqe6EG
         EDNj3D0Ga8kSZa25vK9z0IC6wDNhAEy9MZ0wKByr+kNJNAGwqbrg/C2jqY0gRQieMeOj
         +T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxqryL9iXOL37JnZMrEHvO8DFYjQmv5awHEdDAfZjo4=;
        b=ePvJ3NcZOWfzPcJkLz0LjV7UigPP0BJY4Juz3NqM0QhyN72P5YOTtGWdi5mSoBSpK/
         2oRzV30DzyQut0od30rd+CkgjjFHGLp1ZpZFyedD0Myy6dy0o0CGCf7vAzBktFrGyDUu
         SL4hF1Ons8xAVUxaPvfgOzercGoNnBVjJCKVfFUojRVyAfQqcQ4Se0T264LYwnAJFUAM
         IKZwpJgMoXZHLuBRS8dIK/6TKKc5I6DSzt71YiHo9pgN+uODk3kO6aDUeU6RtymN67cN
         /lGuIlpOeqGYH6CtqcZiW5YKdGBgZlMU0a4oeazaVV6Z6chMzqmUwkzlj+GTpaBDNq9j
         x6wQ==
X-Gm-Message-State: APzg51BGIE3B/LKjuFh2KL56V1ed1Ao5MWdg/Qev2x15Z5rQbeXvzOis
        YgwJpOZujIQsNW8GdI2Xer6jWULpWXySeo4cT0og
X-Google-Smtp-Source: ANB0VdZbSCHdGPY8Yf5wVSX1Xh0kTpEj2eVuHB9rgehXFAptEQXCRswtZSoNqBDEZUkRCpbZ/CMg7Idqd/Eh7UkFTVY=
X-Received: by 2002:a19:d789:: with SMTP id q9-v6mr4209264lfi.27.1537195869250;
 Mon, 17 Sep 2018 07:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-2-omosnace@redhat.com>
 <CAHC9VhTZkrmgt7rxNYWTgYvm+TVGgRD6iFu9dDtZ7eYNXBKqHQ@mail.gmail.com> <CAFqZXNuir-8TE7WUHYhw5t446THO=sCjOXv+WAxNDs79e6OTWQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuir-8TE7WUHYhw5t446THO=sCjOXv+WAxNDs79e6OTWQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Sep 2018 10:50:57 -0400
Message-ID: <CAHC9VhQ8dRTzC8vBsUOm8o4LQxVRiwgkSb23xEZwSDfsXhY3uw@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     omosnace@redhat.com
Cc:     linux-audit@redhat.com, rgb@redhat.com, sgrubb@redhat.com,
        mlichvar@redhat.com, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 8:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Sep 14, 2018 at 5:19 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Aug 24, 2018 at 8:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > This patch adds two auxiliary record types that will be used to annotate
> > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > been changed.
> > >
> > > Next, it adds two functions to the audit interface:
> > >  - audit_tk_injoffset(), which will be called whenever a timekeeping
> > >    offset is injected by a syscall from userspace,
> > >  - audit_ntp_adjust(), which will be called whenever an NTP internal
> > >    variable is changed by a syscall from userspace.
> > >
> > > Quick reference for the fields of the new records:
> > >     AUDIT_TIME_INJOFFSET
> > >         sec - the 'seconds' part of the offset
> > >         nsec - the 'nanoseconds' part of the offset
> > >     AUDIT_TIME_ADJNTPVAL
> > >         op - which value was adjusted:
> > >             offset - corresponding to the time_offset variable
> > >             freq   - corresponding to the time_freq variable
> > >             status - corresponding to the time_status variable
> > >             adjust - corresponding to the time_adjust variable
> > >             tick   - corresponding to the tick_usec variable
> > >             tai    - corresponding to the timekeeping's TAI offset
> >
> > I understand that reusing "op" is tempting, but the above aren't
> > really operations, they are state variables which are being changed.
>
> I remember Steve (or was it Richard?) convincing me at one of the
> meetings that "op" is the right filed name to use, despite it not
> being a name for an operation... But I don't really care, I'm okay
> with changing it to e.g. "var" as Richard suggests later in this
> thread.

As I said before, this seems like an abuse of the "op" field.

> > Using the CONFIG_CHANGE record as a basis, I wonder if we are better
> > off with something like the following:
> >
> >  type=TIME_CHANGE <var>=<value_new> old=<value_old>
> >
> > ... you might need to preface the variable names with something like
> > "ntp_" or "offset_".  You'll notice I'm also suggesting we use a
> > single record type here; is there any reason why two records types are
> > required?
>
> There are actually two reasons:
> 1. The injected offset is a timespec64, so it consists of two integer
> values (and it would be weird to produce two records for it, since IMO
> it is conceptually still a single variable).
> 2. In all other cases the variable is reset to the (possibly
> transformed) input value, while in this case the input value is added
> directly to the system time. This can be viewed as a kind of variable
> too, but it would be weird to report old and new value for it, since
> its value flows with time.
>
> Plus, when I look at:
> type=TIME_INJOFFSET [...]: sec=-16 nsec=124887145
>
> I can immediately see that the time was shifted back by 16-something
> seconds, while when I look at something like:
>
> type=TIME_CHANGE [...]: var=time_sec new=1537185685 old=1537185701
> type=TIME_CHANGE [...]: var=time_nsec new=664373417 old=789260562
>
> I can just see some big numbers that I need to do math with before I
> get an idea of what is the magnitude (or sign) of the change.

Okay, with that in mind, perhaps when recording the offset values we
omit the "old" values (arguably that doesn't make much sense here) and
keep the sec/nsec split:

type=TIME_CHANGE [...]: offset_sec=<X> offset_nsec=<Y>

... and for all others we stick with:

type=TIME_CHANGE [...]: ntp_<VAR>=<NEWVAL> old=<OLD_VAL>

... and if that results in multiple TIME_CHANGE records for a given
event, that's fine with me.

> > A reminder that we need tests for these new records and a RFE page on the wiki:
> >
> > * https://github.com/linux-audit/audit-testsuite
>
> I was going to start working on this once the format issues are
> settled. (Although I probably should have kept the RFC in the subject
> until then...)
>
> > * https://github.com/linux-audit/audit-kernel/wiki
>
> I admit I forgot about this duty, but again I would like to wait for
> the discussions to settle before writing that up.

That is fine, do it in whatever order works best for you, just
understand that I'm probably not going to merge patches like this
until I see both documentation and tests.

-- 
paul moore
www.paul-moore.com

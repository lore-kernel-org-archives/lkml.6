Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBA0C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A13A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="Qy0YXGU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A13A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeKUHY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:24:26 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42837 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeKUHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:24:26 -0500
Received: by mail-vs1-f67.google.com with SMTP id b74so1929483vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 12:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6hEfYqKqXbgdgyDI5u1/JKTzsBxjwJXGY3P96ND8RA=;
        b=Qy0YXGU65FtntcFPcq3T4po5Oo0EHVFfFeBtQNHSyX+L+sILRuSGifm67LQpvPWQpx
         eBn591oFh5xvFlGrHh5TeysxEUt7JFSis/30YrhYYAOri1Sr9Vl9Nn1jzv+cN1OIyZqw
         C0uJE1ES7Co0tjcqFOfNo3O2tKPDgvRXXa1nno+V3BJXzTv7K7l9tj5v3HcylVNQ7nWU
         +RPhSBdj3/+9UaCrS0zu92wmNUEJeNzsm1vq2gioc0cWDDjnbDHO4qGaXLRGfFhEiqDy
         nuJ7ibNOOAcgWCr1QnoRztCGFRn+mVQ6sI0DdgNjGnAuJHdfUy9fUib8IVSwARfHLBiR
         DOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6hEfYqKqXbgdgyDI5u1/JKTzsBxjwJXGY3P96ND8RA=;
        b=mnfbZhkgZkXVqMP8OvJIR883OaLsWfvvDLGiVvHyUi1Wck9CssYbrxEo0bNSnNb7VS
         +gD7bs/mYtLbuVj7uYU+wJvOobEYonrvMwrOocMH7GzLsNFfRnxrnKvqBrSO6W6KmWK7
         OFEKGL7mY3plP2rc2fO1MFOcAgLuEN9udBBD4SXYXptR7cjPR4JnTXVFWSQ0LDs4/e+9
         +dTiQlAIRklHee+YALsGLdX6d2TGoomp3hr7CCFa50dIL4Gg5G0/wJOwElWT+rbACdau
         DJWFS8WgkncbU4dXGX+gITOpbY92XwYrxascPl+IdTi/fYkNszTLSp0oRMQnFaYcFQ7g
         Iejg==
X-Gm-Message-State: AGRZ1gLn766oMvHW7WHiTZMISuQjpggApMlZ3hjWWp11lyoc7l4N+Mf2
        G0xSETWdcvJztBM7ZX9MDYlN6+rHi0w2WrbuWYTU1A==
X-Google-Smtp-Source: AJdET5cMwvhnxwWqSn3ShQlCI1JgOfsAIk6QTLZf7o1VeSp9ngSpWZh0kQDJ7BQIhmKIJqRqaEphr9Kh7N5IZR6I/lM=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr1528184vsm.181.1542747202035;
 Tue, 20 Nov 2018 12:53:22 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com> <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com>
In-Reply-To: <20181120201144.GD13936@tassilo.jf.intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 20 Nov 2018 12:53:10 -0800
Message-ID: <CAP045AoF7-3VBjhaij8JrVLuw+1dUxmLAGthPJm7CsTyY7T9nA@mail.gmail.com>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:11 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > > > Given that we're already at rc3, and that this renders rr unusable,
> > > > we'd ask that counter freezing be disabled for the 4.20 release.
> > >
> > > The boot option should be good enough for the release?
> >
> > I'm not entirely sure what you mean here. We want you to flip the
> > default boot option so this feature is off for this release. i.e. rr
> > should work by default on 4.20 and people should have to opt into the
> > inaccurate behavior if they want faster PMI servicing.
>
> I don't think it's inaccurate, it's just different
> than what you are used to.
>
> For profiling including the kernel it's actually far more accurate
> because the count is stopped much earlier near the sampling
> point. Otherwise there is a considerable over count into
> the PMI handler.
>
> In your case you limit the count to ring 3 so it's always cut off
> at the transition point into the kernel, while with freezing
> it's at the overflow point.

I suppose that's fair that it's better for some use cases. The flip
side is that it's no longer possible to get exactly accurate counts
from user space if you're using the PMI (because any events between
the overflow itself and the transition to the PMI handler are
permanently lost) which is catastrophically bad for us :)

- Kyle

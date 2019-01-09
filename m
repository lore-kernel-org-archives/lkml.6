Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4782075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bd3DXS0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfAILzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:55:40 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:37230 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfAILzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:55:40 -0500
Received: by mail-it1-f169.google.com with SMTP id b5so10593055iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 03:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=havypMdbH5gAZ9icq0Hd/GKize3aJjIllpQ4OvlqGFM=;
        b=Bd3DXS0/qZquXI/dNZJiaV1PLY/C55e6Y6VHp426SGKdCzu6gN3TURb9LCg2cT6a9S
         TtAzfQVUvvCfuERzbZgS1TKW7OK+WO31Ru48uGiC1m/fDZGaYtWhoH8tb2OTVCEZpKvu
         SZAkRAnIQrPvEoIcedTSnn5o3X0+WJkcND60PpNwzpQYsyx6NjpiT2A+JdF58FIYLzzj
         pIF2+9atFJm9EZrUOs0+S41aCHpRmBwP+pvkMB0Lf0Oj8zNriao1d9SmsBRbkg9ITJiJ
         +DiQAE0g7+x7nzjLK0Rdew9shwjvcNbtrY10grcasik4hu5WBgRCBNQxhOW1rMqWBiYV
         ij0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=havypMdbH5gAZ9icq0Hd/GKize3aJjIllpQ4OvlqGFM=;
        b=jKi95sxb9O9Hoj0uwVUIfrzYcPU3IGfH1Xvo+KyRPuEUi8pb9t60u/pU8H6bbkE4mz
         phqlG9au0azOmbUVwqoPehfQIYiZ9zqgQ2pGQZ9ec8+CnzIs2XySnUf/lIuy1mWtp+wb
         /3NpYwAoOtYeM+Sgkohfv8iavp1eohEomyGf18s+hskeXh7Zlmp+Bjy9HtLHVfrhhJyU
         k9Tj2JPum5aYPGIYE7BotWztyoIh6ETWKrwamM8w0fLYI0BV+0YTw+KzLAiNEe+AOhz0
         uS22tlOakiYfqSwPXTQ1DWMp7GvCcYU9cyNqFw9bJq9wlxwPvLASSJh9NlLxcXJuvjwC
         JpqA==
X-Gm-Message-State: AJcUuke/WwidLQ8ryLniiHu2EcOpn2PeXFAnYNFljH47yokTwRhOpKaJ
        44tlFwjueZFkCSEXV9+rdlkLnEYtCWbGUbMhoA7XQg==
X-Google-Smtp-Source: ALg8bN6F0vLmX9lqkjGROUqhy8m/a42x58q0T7IXJFc9Xb2I7RtDTCtXtcCgfDa20FJFt2KywJr5Mr8mHYBLrK4cTG8=
X-Received: by 2002:a02:97a2:: with SMTP id s31mr3606454jaj.82.1547034938920;
 Wed, 09 Jan 2019 03:55:38 -0800 (PST)
MIME-Version: 1.0
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190109000214.GA5907@andrea> <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
 <20190109112432.GA6351@andrea>
In-Reply-To: <20190109112432.GA6351@andrea>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Jan 2019 12:55:27 +0100
Message-ID: <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
Subject: Re: seqcount usage in xt_replace_table()
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Paul McKenney <paulmck@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 12:24 PM Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
>
> On Tue, Jan 08, 2019 at 04:36:46PM -0800, Anatol Pomozov wrote:
> > Hello
> >
> > On Tue, Jan 8, 2019 at 4:02 PM Andrea Parri
> > <andrea.parri@amarulasolutions.com> wrote:
> > >
> > > Hi Anatol,
> > >
> > > On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> > > > Hello folks,
> > > >
> > > > A bit of context what I am doing. I am trying to port KTSAN (Kernel
> > > > Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> > > > and makes sure it is accessed in a thread-safe manner.
> > >
> > > Interesting!  FYI, some LKMM's maintainers (Paul included) had and
> > > continued to have some "fun" discussing topics related to "thread-
> > > safe memory accesses": I'm sure that they'll be very interested in
> > > such work of yours and eager to discuss your results.
> >
> > Thread Sanitizer is a great tool to find thread-safety issues with
> > user-space code. The tool been developed by a team of smart people
> > from Google [1].
> >
> > KTSAN is an attempt to bring the same ideas to Linux kernel [2]. A
> > bunch of work been done there but the project is still at
> > proof-of-concept point.
>
> Yes, I have been aware of these tools since at least  ;-)
>
>   https://groups.google.com/forum/#!msg/ktsan/bVZ1c6H2NE0/Dxrw55bfBAAJ
>
>
> >
> > I am not a part of Google's dynamic tools team. But I've decided to
> > pick something to do during the New Year holidays so started porting
> > KTSAN from v4.2 to v4.20. The work is "almost completed" but I need to
> > fix a few crashes [3].
>
> I guess my first reaction would remain
>
>   "it's kind of hard (to use an euphemism) to review 7,582 additions
>   or so for a data race detector without a clear/an accepted (by the
>   community) notion of data race..."

Tsan's notion of a data race is basically the C/C++'s notion:
concurrent/unsynchronized non-atomic access in different threads at
least one of which is a write.
Tremendous (for such a project) benefits of automatic data race
detection is a good motivation to finally agree on and accept a
practically useful notion of a data race.

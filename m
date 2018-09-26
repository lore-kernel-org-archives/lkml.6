Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4794DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F07214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XW4tCmPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F07214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeIZULw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:11:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43217 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:11:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id x24-v6so23289701lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMvbVWHeoCkcQ+J+E4VFyUw/Kb2VssH63cpbHynMeOU=;
        b=XW4tCmPrk/l52xGB4xXmBqbQOCYhqUdcAX4WnDeTlifMPEkewd8PzhOox7r9TpnK8a
         E9NcDQSfV1MJsi2vA2NppmuciEQKsmbtCTpV+FHuIdupDHXFxPpQzn93qfGaCgV6J1IL
         aOTaxZ0eSa2AHqfmhrsxQxxfC/9ZPgwTSYynY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMvbVWHeoCkcQ+J+E4VFyUw/Kb2VssH63cpbHynMeOU=;
        b=Es8iQh1SLTXqgSTBmG4HBiZbNVD0VlKRr7ZGnzZzA577QyUGWJ7OKH6p4cyFp4PrfQ
         Jy1ZIVzpvZrx6ncMCrs6BzxbDyAvADa0f+cL/HWh/RG8dEUn9Kibmh83ifY1lamWvcSX
         kd7Fo++Bde3hsegYJSFl0qmJuBAVJiZFrdMJlaK/zB0kGBbZu/Kauqoacf06/KTVHRiX
         uoXUEuqogtVYvkLZchgkwhWu6juRfhrYf+WpJP1QB9FgMWnmjACOwsV8GzxM8+/qNnZq
         ufB3Zqin6Pp7eEtXQ+k+OOUl5vepQR3mC202Z8h07Qsg19h8aq1l2CjghJYKaY5f9/qv
         OMMg==
X-Gm-Message-State: ABuFfohkj2z11qLMYNdcX3IEVKAUXAWrOoBMSaB5eVJLsUaelWKH1GVA
        3AKYIlkhbn4ACFITRRrf7+F0E/neibhZ2S3N9T1+2w==
X-Google-Smtp-Source: ACcGV62HWVDbMINDxSaD97LTR6irhDiAZu5sdCxCBsiI1S3CS2shsf8ik0UgqLMe2wPBz1vgsWTn3wN8bWq38FBDb7A=
X-Received: by 2002:a19:7391:: with SMTP id h17-v6mr4215394lfk.140.1537970324469;
 Wed, 26 Sep 2018 06:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <1537896922-8508-1-git-send-email-valentin.schneider@arm.com>
 <CAKfTPtB-UiXx39XZeJ0FNeYOU-pLFbY1u7vgbo584MNHSnpr=w@mail.gmail.com>
 <9209a9ec-72b4-17d7-6596-71b55767a9aa@arm.com> <CAKfTPtAUUcwPThggDMfQ1k7z4kguTwrLVEFKnkMqszs9nTri=g@mail.gmail.com>
 <20180926131724.GB2512@hirez.programming.kicks-ass.net>
In-Reply-To: <20180926131724.GB2512@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 26 Sep 2018 15:58:33 +0200
Message-ID: <CAKfTPtBBGh+=uGzPTTJQpYOpO42UG2+ktBffA-zT1TvOqn06Xg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Don't increase sd->balance_interval on
 newidle balance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 at 15:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 26, 2018 at 12:33:25PM +0200, Vincent Guittot wrote:
> > On Wed, 26 Sep 2018 at 11:35, Valentin Schneider
>
> > > library I use) has some phase where it spawns at lot of tasks at once to do
> > > some setup (busybox, shutils, bash...). Some of those tasks are pinned to a
> > > particular CPU, and that can lead to failed load_balance() - and to make things
> > > worse, there's a lot of idle_balance() in there.
> > >
> > > Eventually when I start running my actual workload a few ~100ms later, it's
> > > impacted by that balance_interval increase.
> > >
> > > Admittedly that's a specific use-case, but I don't think this quick increase
> > > is something that was intended.
> >
> > Yes, this really sounds like a specific use-case. Unluckily you find a
> > way to reach max interval quite easily/every time with your test
> > set-up but keep in mind that this can also happen in real system life
> > and without using the newly idle path.
> > So if it's a problem to have a interval at max value for your unitary
> > test, it probably means that it's a problem for the system and the max
> > value is too high
> >
> > Taking advantage of all load_balance event to update the interval
> > makes sense to me. It seems that you care about a short and regular
> > balance interval more that minimizing overhead of load balancing.
> > At the opposite, i'm sure that you don't complain if newly idle load
> > balance resets the interval to min value and overwrite what the
> > periodic load balance set up previously :-)
>
> Well, we've excluded newidle balance from updating such stats before. So
> in that respect the patch proposed by Valentin isn't weird.
>
> Consider for example:
>
>   58b26c4c0257 ("sched: Increment cache_nice_tries only on periodic lb")
>
> In general I think it makes perfect sense to exclude newidle balance
> from such stats; you get much more stable results from the regular
> balance.

Ok so in this case we should exclude all update of  the interval
during newly idle and not only some of them

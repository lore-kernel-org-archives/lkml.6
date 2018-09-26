Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9FBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4103F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCdAzYm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4103F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeIZUJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:09:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38460 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:09:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so25304148ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsAGsC2tdyQ3VG7+MAKL6vSEkkQdKnLvZv7u/7W8T6I=;
        b=MCdAzYm0GdmdX7OXLASImXBkg/fLgZS6LhaYA8QOoxkSg19yTgSj1cuooezrudSXRJ
         v1y8WOjYJxsK03+0o9h9LzeyrJaFb5s8GDHHwS5+rSZtcDuGDKi0DctNTdZBBA0AcQfa
         2Zaz9HgTVXJylNyndDpFWTPF6RFdZFoAhzhi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsAGsC2tdyQ3VG7+MAKL6vSEkkQdKnLvZv7u/7W8T6I=;
        b=dnB9kKT8SpTMY7iTuUihSfu8gF0e38PHa0o3GjkwOqZWzGCej7Kc7K1ay5NEUZC+j0
         pBQGKFCvmJhhLQRk+xy9dq7bETApy9pZGOig3h+P0fir9pDKOwsLxiT5AU22gIqndGcH
         DpwjoIILutVjAmTKeXjIPIfOhrfjj0wI4zgPrnleUoQoVnCkB1EHBrBQQpLHAirfNZ3r
         lXeE3ReFrkETdEXFQeBZOqqHEGW4bd02Fz58H8UGKBpyUNGfKCyrvMfhbeWpSPb+D9yp
         Cea68clNLzMakGk4yPWaqGFY5CsitKnTcyPd9oLay83E6K1XiutfDTCKTTHOw5k2cD96
         L+Cw==
X-Gm-Message-State: ABuFfoirE2a1iUJxNrwFxvFTx79o9RwJXGCWTjaUtEvzTRu1/HRhWtjN
        UtYwLE8o25coYvZFzPJmBI5JL6bPXMgSCXYJ4R77TQ==
X-Google-Smtp-Source: ACcGV62pC+vJMJzdlMeZp1g9OEDWWOi+SZiw9awWOr8LU7HKlKjJzytJQ/Yg1G19itHTbaq1741Z3kMGl+M4P42Y4s4=
X-Received: by 2002:a2e:9813:: with SMTP id a19-v6mr2370823ljj.36.1537970178046;
 Wed, 26 Sep 2018 06:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <1537896922-8508-1-git-send-email-valentin.schneider@arm.com>
 <CAKfTPtB-UiXx39XZeJ0FNeYOU-pLFbY1u7vgbo584MNHSnpr=w@mail.gmail.com>
 <9209a9ec-72b4-17d7-6596-71b55767a9aa@arm.com> <CAKfTPtAUUcwPThggDMfQ1k7z4kguTwrLVEFKnkMqszs9nTri=g@mail.gmail.com>
 <c80b5d26-ad8b-3b13-d317-8db7ec59aee0@arm.com>
In-Reply-To: <c80b5d26-ad8b-3b13-d317-8db7ec59aee0@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 26 Sep 2018 15:56:06 +0200
Message-ID: <CAKfTPtDxn4C-4wiZtyx-yAMK+pjz=AsRb1WwR5gaWuVkKD16wQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Don't increase sd->balance_interval on
 newidle balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 at 15:16, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 26/09/18 11:33, Vincent Guittot wrote:
> > On Wed, 26 Sep 2018 at 11:35, Valentin Schneider
> > [...]
> >>> Can you give us details about the use case that you care about ?
> >>>
> >>
> >> It's the same as I presented last week - devlib (some python target communication
> >
> > ok. you mean at linaro connect
> >
>
> Yeah, sorry.
>
> >> library I use) has some phase where it spawns at lot of tasks at once to do
> >> some setup (busybox, shutils, bash...). Some of those tasks are pinned to a
> >> particular CPU, and that can lead to failed load_balance() - and to make things
> >> worse, there's a lot of idle_balance() in there.
> >>
> >> Eventually when I start running my actual workload a few ~100ms later, it's
> >> impacted by that balance_interval increase.
> >>
> >> Admittedly that's a specific use-case, but I don't think this quick increase
> >> is something that was intended.
> >
> > Yes, this really sounds like a specific use-case. Unluckily you find a
> > way to reach max interval quite easily/every time with your test
> > set-up but keep in mind that this can also happen in real system life
> > and without using the newly idle path.
> > So if it's a problem to have a interval at max value for your unitary
> > test, it probably means that it's a problem for the system and the max
> > value is too high
> >
>
> Limiting the max value for those tests is actually a good point, and I think
> I'll give it a shot. However...
>
> > Taking advantage of all load_balance event to update the interval
> > makes sense to me. It seems that you care about a short and regular
> > balance interval more that minimizing overhead of load balancing.
> > At the opposite, i'm sure that you don't complain if newly idle load
> > balance resets the interval to min value and overwrite what the
> > periodic load balance set up previously :-)
> >
>
> ...My concern is more about increasing balance_interval faster than we should.
> The proposed "fix" is to prevent any balance_interval increase when going
> through idle_balance(), but Patrick (added in cc) suggested offline that
> we could simply limit the rate at which we do these increases, so that they
> match what we do in rebalance_domains().
>
> We'd still increase balance_interval on failed newidle load_balance(), but
> we wouldn't increase from min to max in e.g. 50ms. Would that work better
> for you?

adding a rate limite would be a reasonnable solution.
>
> >> [...]

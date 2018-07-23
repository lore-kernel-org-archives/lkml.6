Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24558ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7BE20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eejNYZy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7BE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeGXAUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:20:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42698 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbeGXAUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:20:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so1427221pgp.9;
        Mon, 23 Jul 2018 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbY+72EjBJtguXX355+V9f/Utv6aKOk+WGAdlbZFx1A=;
        b=eejNYZy3p57uLABTOW7OIJfCXXj98VOF6p3kY//33qSmWbqVdZjpvylo8v/b+/N6FQ
         OuC0lEVgpPP3UBwu8jHd3tmRU4kj8w/l8ucSECFv5OXrLubNO85UJR7si/PqJ7J6abSo
         SyF8DIlZAn+noqOE/ruiE5HxAkPdt9DOfDf9VGleN1iLn+gNqKI3Z7FfVGGAn22a4yzF
         KgPRIEF51Sa/eukusAZHssGZg2KreYarH4dEYKq79rHTGwcpHpZ3l3FqjGN7mf0g6ZXp
         c+2CeZ1mo2hG1ZGsb/a1r1JF43KApYc21BkCtIv66qrVh1Qvm+E3x/Q/1I0JJnVkrl9U
         DDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbY+72EjBJtguXX355+V9f/Utv6aKOk+WGAdlbZFx1A=;
        b=QRUValq7vv/Mf8zey+CJVY/zF4dMx1dC0hiTalxi3uL0YAGRmnDbmrXwys3Anhtr5r
         zpXOGlgTWbZiMNbBWwYLEdXnvpPIOL786WwdSjSfNHtGjaCU4cUkja4cRN78Td42yl1e
         rO4TgyXYPe2JIfzoIGfrE10QCJQU9AoLGBOXB0EQiV0fbRV7YR3IFOzXNnO6vdrfCjW6
         CL5Znj1C7JV6/qIWeFziV343+kl65Ng1FQnmU9+NMKi34KErJgTejtYlqDyYqBYc9mm+
         TK5ZWuXXTMLHvdNPlLGX/luL+Gf96cp2tCmMLePwhDE09OW9Y/FlufMFCgDviCLtZQEi
         A8gw==
X-Gm-Message-State: AOUpUlG1pbShb6rKB4KGZvCzD6jdWrV17simz9UlXU/WLXyL0RcbXaN8
        hU9csXcFdzO+CKmwf8nPF09oLUzBmsHc4FXwNM0mGg==
X-Google-Smtp-Source: AAOMgpd3kDfWY9MtxvBtakPkspL4ryKKMQzkCQhKTcoLCi/3VIevM4k+T5Cq1w1IKlKhcUhUhGeXPVLSJULuCnpHDVM=
X-Received: by 2002:a65:5545:: with SMTP id t5-v6mr13957113pgr.157.1532387795716;
 Mon, 23 Jul 2018 16:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180719132834.GF18667@krava> <20180719191253.3843-1-xiyou.wangcong@gmail.com>
 <20180720115217.GQ2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180720115217.GQ2494@hirez.programming.kicks-ass.net>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 23 Jul 2018 16:16:23 -0700
Message-ID: <CAM_iQpWVhLZKo9j6COGkvryGrxJq6sEXzh2S-ikza2H3=pAyqw@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: fix a possible deadlock scenario
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 4:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jul 19, 2018 at 12:12:53PM -0700, Cong Wang wrote:
> > hrtimer_cancel() busy-waits for the hrtimer callback to stop,
> > pretty much like del_timer_sync(). This creates a possible deadlock
> > scenario where we hold a spinlock before calling hrtimer_cancel()
> > while in trying to acquire the same spinlock in the callback.
>
> Has this actually been observed?


Without lockdep annotation, it is not easy to observe.


>
> > cpu_clock_event_init():
> >   perf_swevent_init_hrtimer():
> >     hwc->hrtimer.function = perf_swevent_hrtimer;
> >
> > perf_swevent_hrtimer():
> >   __perf_event_overflow():
> >     __perf_event_account_interrupt():
> >       perf_adjust_period():
> >         pmu->stop():
> >         cpu_clock_event_stop():
> >           perf_swevent_cancel():
> >             hrtimer_cancel()
>
> Please explain how a hrtimer event ever gets to perf_adjust_period().
> Last I checked perf_swevent_init_hrtimer() results in attr.freq=0.

Good point.

I thought attr.freq is specified by user-space, but seems
perf_swevent_init_hrtimer() clears it purposely and will not change
after initialization, interesting...


>
> > Getting stuck in an hrtimer is a disaster:
>
> You'll get NMI watchdog splats. Getting stuck in NMI context is far more
> 'interesting :-)

Yes, I did see a stack trace in perf_swevent_hrtimer() which led
me here. But I have to admit among those hundreds of soft lockup's,
I only saw one showing swevent hrtimer backtrace.

Previously I thought this is because of NMI handler race, but Jiri
pointed out the race doesn't exist.


>
> > +#define PERF_EF_NO_WAIT      0x08            /* do not wait when stopping, for
> > +                                      * example, waiting for a timer
> > +                                      */
>
> That's a broken comment style.

It is picked by checkpatch.pl, not me, I chose a different one and got
a complain. :)

Thanks!

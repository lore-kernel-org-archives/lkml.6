Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFCBC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6939C20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0W/wiQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfBENkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:40:42 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35564 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbfBENkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:40:41 -0500
Received: by mail-vs1-f68.google.com with SMTP id e7so2158100vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGz+KaIHU6kdZjr70CxUzqvL/Y3JaHXrvpE3EZ2OZfE=;
        b=z0W/wiQn7JYbpAZ1ol9zt74MyT0lCGqciOPnKnapYHSRPgPTaEviiqgcQ9K1b2wh8i
         yPZ6PBrJDufXLkOGem2jmlKPtpWVxIzf1uDzjPvacUf1hdtQttxrmYJbCd3PsU+jgzsP
         /v9+mWIvCCW0dXF8zXGP8fBTWUpy9lhOLqvMYHJTByxbSYRFYyiVoWBXFhgJQJwWHozm
         56qIIc3lJvN0RS56QJuXMFYFYKv7MK7k940KjaYavrVhrCM2YZdtnm8hB+YXfcFQ+8FI
         pKoDyJ61mVVH5zD06oYLTuwtyADsD5UHJ2Z4GHNeoL1Os741Fq1WTl1wJOeBqx7P7ZvU
         PHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGz+KaIHU6kdZjr70CxUzqvL/Y3JaHXrvpE3EZ2OZfE=;
        b=LyoA5jZiSCeOiEd/f9FMWbbRfnfUYlNE/6GLel8XwH21rAYRg+Gg4SvdP8NHXOF1+i
         BMLfutxaicWiAisnbJSxLOmBl0yT1928SbXMPmwgAIbH3qnEiJv3LZLjy9oG9xsT24U5
         sipDJwtT2J+Mqu9FqFyxhVQioNsVVv5MDtnq26BDhoxfAr4O/TWsHQPEMM0+ldYC+A04
         N/mjmgjXhM5GA8XP0eLz70xWiZAS4S0T4PY+x1FHhL8/Reu4vsiUZdpuXGPnVJZqG8DF
         lCPEdybWbXrecunklbwoYa9mflcWZO5Wsm1Ca4NZQa6mQBfd7+VHLAQOFoQcuZOvBuXd
         U2Mw==
X-Gm-Message-State: AHQUAuZCRiCLGnucQhYCc6oPBn+VvUJUb8l0E1msWTTxMhtmTLB/zWTd
        ogS9eYBTlNvoiUXhhN0AUZJuboYGJxg1uuKF2nTAWA==
X-Google-Smtp-Source: AHgI3IYVw/nkWXn4pDQ6QdiimktaGEI7Lc7rL5L+LWqatJUnmPRDh65+YENGhUU2l+fUF4WoXLWXU9Tun+zS5f6jloY=
X-Received: by 2002:a67:b245:: with SMTP id s5mr2002390vsh.200.1549374040188;
 Tue, 05 Feb 2019 05:40:40 -0800 (PST)
MIME-Version: 1.0
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFpyg7oGoDZA+=SG7R3yL874Geeqs5LWrsAf50csxsE05A@mail.gmail.com> <CAMuHMdWdbRpA_M4V1kigab6U8rSDgGYXtidiSU4MVdj5xarK8g@mail.gmail.com>
In-Reply-To: <CAMuHMdWdbRpA_M4V1kigab6U8rSDgGYXtidiSU4MVdj5xarK8g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 Feb 2019 14:40:04 +0100
Message-ID: <CAPDyKFqSofB2TfQXqhngQhaSKRZr-k-z2CXpQ2oWvnCn3JeFHQ@mail.gmail.com>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019 at 14:24, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Wed, Jan 30, 2019 at 1:15 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 30 Jan 2019 at 12:16, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > > The call path is:
> > > change_clocksource
> > >     ...
> > >     write_seqcount_begin
> > >     ...
> > >     timekeeping_update
> > >         ...
> > >         sh_cmt_clocksource_enable
> > >             ...
> > >             rpm_resume
> >
> > Hmm, isn't this already a problem in genpd then?
> >
> > In genpd's ->runtime_resume() callback (genpd_runtime_resume()) we
> > call ktime_get() to measure the latency of running the callback.
> >
> > Or, perhaps irq_safe_dev_in_no_sleep_domain() returns true for the
> > genpd + device in question, which means the ktime thingy is skipped.
> >
> > Geert?
>
> Correct. After adding
>
>     dev_info(dev, "%s: pm_runtime_is_irq_safe = %d,
> genpd_is_irq_safe(%s) = %d => %s\n", __func__,
> pm_runtime_is_irq_safe(dev), genpd->name, genpd_is_irq_safe(genpd),
> ret ? "true" : "false");
>
> I see on R-Car M2-W:
>
>     sh_cmt ffca0000.timer: irq_safe_dev_in_no_sleep_domain:
> pm_runtime_is_irq_safe = 1, genpd_is_irq_safe(always-on) = 0 => true
>
> For all other devices, the result is false.

Thanks for confirming! I guess we have been lucky so far.

Anyway, if runtime PM core converts to use ktime_get_mono_fast_ns(),
we should probably consider to convert genpd to this as well. Don't
you think?

Kind regards
Uffe

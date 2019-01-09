Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CD7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7170206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+3x8aGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfAIQz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:55:59 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37417 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfAIQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:55:58 -0500
Received: by mail-io1-f65.google.com with SMTP id g8so6569953iok.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kki7GX0S+t7hj/hdc6mJj5VtGMKtQZTAwoWP5KR8oJA=;
        b=Q+3x8aGDd/+bdRQp6N+2ZpUI327wJoexTa/6+Tyqu20NnYA2zzh8tCkcaO1tkFHKnA
         jjLaNk/rS/r2luVOoDyyGqM/ujcSa3DbAgotT3KDq99s784yRD8jrMB5+48pj9RmkFwS
         313Ft4ncFR0AyqIIXs4fx2bP7U2xt8BaK5IcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kki7GX0S+t7hj/hdc6mJj5VtGMKtQZTAwoWP5KR8oJA=;
        b=Uf8qoEM7yl5OZM/eT/IquBbfNZC61yYIh1ZA15CnltKrw8FcNP/0OIMCHNzw7pjAQv
         EIZgw2El963UCl7gxI3o/qHrCIKXcDOXVZ3RdTdlDTkSoLBoaood1zFnWAEfANiVOfvA
         UR7oNi0ym4ieEZzFHkU9qZoMPPQPyRvvMubEeytnPXQCscR6g6r1jIGHDjNagdo/QV1u
         T8ErGXYy6aQE0a9hXbZQbVNGFFmJoOYLq/wJuHKlAt94nUXk4JnhZSk34bxcEQG5N0Wa
         o/0vMW2YleD711xYVqTgVl2XQuFIUBo7BkmgYXrzeXDAL+Fc2XCO2n8oHUtQl5oGAL4o
         yFKg==
X-Gm-Message-State: AJcUukdhe8QMtidQws2qr6oB7c+FlrvpZ6F/gAWsUcTtdBLaKj2d2JGF
        ufv0MsJI1hcUOsOER4btOkuGZLrtsNAh+axRyH0TAlb5yWJe6g==
X-Google-Smtp-Source: ALg8bN61k2I49EIfEaI7zbl2JZ1N1JnLQc4jMeV2GRJPyIicfNIkneVXL61psqRGnawj9on/bi2MeTTm70cokk+5RzM=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr4101980iof.183.1547052957562;
 Wed, 09 Jan 2019 08:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com> <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com> <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com> <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
 <20190109162846.GP5544@atomide.com> <CAKfTPtBzE9fqDgUOJ4uTj_Dtfe2KCp+R4FajAaQqpV02upQZJA@mail.gmail.com>
 <20190109165004.GQ5544@atomide.com>
In-Reply-To: <20190109165004.GQ5544@atomide.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 9 Jan 2019 17:55:46 +0100
Message-ID: <CAKfTPtD4ZnRDKF6wG_AdX-5+R0cW0=uwj9Ww6y7O0xocuL+bkQ@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To:     Tony Lindgren <tony@atomide.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Ladislav Michl <ladis@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 at 17:50, Tony Lindgren <tony@atomide.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [190109 16:48]:
> > On Wed, 9 Jan 2019 at 17:28, Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Rafael J. Wysocki <rafael@kernel.org> [190109 09:44]:
> > > > On Wed, Jan 9, 2019 at 2:51 AM Tony Lindgren <tony@atomide.com> wro=
te:
> > > > >
> > > > > * Vincent Guittot <vincent.guittot@linaro.org> [190109 01:42]:
> > > > > > Le Tuesday 08 Jan 2019 =C3=A0 13:37:43 (-0800), Tony Lindgren a=
 =C3=A9crit :
> > > > > > > Lowering the autosuspend_delay_ms to 2100 ms makes things wor=
k again.
> > > > > > > Anything higher than 2200 ms seems to somehow time out immedi=
ately
> > > > > > > now :)
> > > > > >
> > > > > > This is quite close to the max ns of an int on arm 32bits
> > > > > >
> > > > > > Could you try the patch below ?
> > > > >
> > > > > Yup great thanks, that's it:
> > > > >
> > > > > Tested-by: Tony Lindgren <tony@atomide.com>
> > > >
> > > > Cool.  Thanks for getting to the bottom of this!
> > >
> > > No problem.
> > >
> > > One more thing I noticed: The 25% slack can get noticeable
> > > for larger values. For things like a 3 second uart console
> > > timeout slack of 750 ms is quite large variation.
> > >
> > > Should we have a limit of max 100 ms for the slack?
> >
> > Keep in mind that when jiffies were used, expires was rounded to a
> > full second when delay was greater than a second. So you could already
> > have difference of up 990ms on arm before this patch
> > And i don't take into account the rework of timer infra which add
> > another level of variation, something like up to 640 ms more when the
> > timer is greater than 2880 ms for arm IIRC
>
> I think it was rounded up earlier.
>
> Don't we get rounded down now also?

We still round up. In hrtimer we have :
timer->_softexpires =3D time;
timer->node.expires =3D ktime_add_safe(time, delta);
so the hrtimer will expire between "time" and "time+delta"

>
> Regards,
>
> Tony

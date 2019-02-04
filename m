Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94523214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0vIHXJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfBDJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:38:21 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:51691 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfBDJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:38:20 -0500
Received: by mail-it1-f173.google.com with SMTP id w18so19590404ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 01:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSGhkw5w5NGYeAdEK8ZQkr6pLoEPUsljTwSmw58YKtY=;
        b=m0vIHXJL6+cLyhvSisXEY+xr70QqmxGtqcfSzuKssQXEorY22aNzLWBljuaHi0quFF
         PpvO5Cqo/vvWWlmh0T2tkJw5wjQQtwlVvEBLZyZk6pveMKkoSACuL+Q3H6X5pBJCW3uc
         uINJRXq4QUFGkAr81ro1jB5ldDAq3k01vDvrS8Bh3mlkSEL54Uzp1P+OKzdem+KMTgKy
         bmnw+/dx/qpiflPiUFlsS1dMw34Q1saMtFsD0lEBWOiP3lfBA187Och1LPjCoCKmDqXj
         1sINMuJWgbDPM1p9E1hgIlQHujsWusOpjKzR+1ZYjrS47ahgCkmaOdAHLUS2iCxaiG/r
         GLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSGhkw5w5NGYeAdEK8ZQkr6pLoEPUsljTwSmw58YKtY=;
        b=COZoCZ3LqdT+hzf43mxNHW5fW+6822szdxaHpdZPUl3CFj5AlH4V3Z1VtKFe2l3s+a
         4kiYDJJsnnFDju317N6BaUHfewnvt+XCbX5v1Xen+s0WLQ5qqeMuVBCkEVU2auF7K061
         zxTDmFWUc1+rE5fYUlPIzCiwd+c7Kcgh+WQVoxQNcytH3ZDmRpQo1iz+zHCHpLk85XDV
         +FSs+QMV+ineY4GBMx3/hfb7/xPZkeL6oZSbLrurT6q+Ru1dUgrhyKhkwffnmrS0OU+K
         4TTownuSdaz2JJZQ+8NrufrCgHS2vaNFeawpt9hJvcXMXsUKLYSPi+gceoGR3bQmQHm0
         M5rA==
X-Gm-Message-State: AJcUukejm4hZ4LFXD/pmYLb2uN03gIVpbK881MkC7ojec2i6VrFYMXtb
        GVGunqeearXPV4gtEtFB5+/OcHMQLWc8wUTSjCnyyg==
X-Google-Smtp-Source: ALg8bN6QKg+XK7SM2OJA9SxQcbWkRL57ZHXLxrVdlH/jHdYoVxBAX3snkcsOWu65uYF/TXvPABu3Fj953MXd2HuCsks=
X-Received: by 2002:a02:97a2:: with SMTP id s31mr30206430jaj.82.1549273099402;
 Mon, 04 Feb 2019 01:38:19 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bFh_S3=U+JF7GCzZjZ9R8b_Xqzi-1AyruKxqNqGrFVrQ@mail.gmail.com>
 <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com> <alpine.DEB.2.21.1902041025050.8200@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1902041025050.8200@nanos.tec.linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Feb 2019 10:38:08 +0100
Message-ID: <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
Subject: Re: perf_event_open+clone = unkillable process
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 10:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 1 Feb 2019, Dmitry Vyukov wrote:
>
> > On Fri, Feb 1, 2019 at 5:48 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > Hello,
> > >
> > > The following program creates an unkillable process that eats CPU.
> > > /proc/pid/stack is empty, I am not sure what other info I can provide.
> > >
> > > Tested is on upstream commit 4aa9fc2a435abe95a1e8d7f8c7b3d6356514b37a.
> > > Config is attached.
> >
> > Looking through other reproducers that create unkillable processes, I
> > think I found a much simpler reproducer (below). It's single threaded
> > and just setups SIGBUS handler and does timer_create+timer_settime to
> > send repeated SIGBUS. The resulting process can't be killed with
> > SIGKILL.
> > +Thomas for timers.
>
> +Oleg, Eric
>
> That's odd. With some tracing I can see that SIGKILL is generated and
> queued, but its not delivered by some weird reason. I'm traveling in the
> next days, so I won't be able to do much about it. Will look later this
> week.

Just a random though looking at the repro: can constant SIGBUS
delivery starve delivery of all other signals (incl SIGKILL)?

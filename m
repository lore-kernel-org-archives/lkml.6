Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811E1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE0C21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="afbCQs+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfBGM63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:58:29 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43798 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfBGM62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:58:28 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so6578793vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LnlcHpqzXyb8rUW2bmJkzF9pBzhkae9k8y/TMGidJ64=;
        b=afbCQs+mlvsPtSnwUS2Cp3opEwKHWFTWcXoDh2D+f4p5kU4W9ewR8bxaEi4E5LxwuP
         63E29/3iJeibnsl1N40zdSEH2HloKVouoY5+l0uapjniwpXyd+fx5mFurbCLG2tKHtkM
         bO530SmEwUO6nP8S33Xv3YtqW6Lp3lCbm3ethbqBlGentUCmLQ0A21tftuJfUpE7+N0p
         yvTlCoW34qsZVJ2E8qrHP578oxo96IvF+/pBYVT7e2oJM5lv/+dMpmgG+FdhEemaHRQq
         qMmy1TwMf48UipOO1A8XlP7zaWSPrz1cRQlv5WEsGCIQE9ggXME1NnI8dV52LO0cQYIe
         2iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LnlcHpqzXyb8rUW2bmJkzF9pBzhkae9k8y/TMGidJ64=;
        b=EZixHtd+hyvoTANTuNqbENuRku/BoPVGF5tbD4YZkmXTZpQvT6DkTmSY11U+SMkyjQ
         hlHB8zFocXzaiXm2LQjpS1V2Iq1RhmmakyQgtuoxOtKJZj3yK7gbsrrExQrDSG2r4Bta
         lqSH7jlUhSi9he4qf+EyPB7SaFPu3bFJzOkENgA2nXBsdya94xvjJCRpZP03ynYhpNkl
         iB6ly+sU0Zi8PRW+BTJocVdRI5jL5+Hbu8x33FAh0Q2AR5moeQdfQiS13aEOkRVc8Iut
         JgrPjp4cSdeMymLZgln0pcq6UR6js5gnfI6nt/V4KsCjn6idMWs4+1xTgp29A/yRv5q0
         N59g==
X-Gm-Message-State: AHQUAuaPO5VUtjYKmjGKJn773GutA2aQSqQF4RSf7mETnp2HUGPR6/fE
        GiJK5vH2uviRciBd/3gXhh/JYPKbyGcno3JjqVBNtQ==
X-Google-Smtp-Source: AHgI3IZ/3jnwo8Ul00SlJ3zeSEVj25vn/kV5e6TUIG9V42N481M6IPLKVtO52mKIF2+7N83Nu/TD8xTu6DcGHdYwNwk=
X-Received: by 2002:a67:f24d:: with SMTP id y13mr2050119vsm.164.1549544307228;
 Thu, 07 Feb 2019 04:58:27 -0800 (PST)
MIME-Version: 1.0
References: <CAOtvUMd-38BL1jJnHQY0J68mmtxW1WBQF2qGqyNpWtwsrwUcYg@mail.gmail.com>
 <CAKfTPtBaKbtfLMjLH1u20+ukhpm6i9qDK-3HiTPizSjKNCnw=w@mail.gmail.com> <CAOtvUMdRWjqp0sEZUQU6w6RcDFP26i3Gxzg5zsRvG2ej1LVSFg@mail.gmail.com>
In-Reply-To: <CAOtvUMdRWjqp0sEZUQU6w6RcDFP26i3Gxzg5zsRvG2ej1LVSFg@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 7 Feb 2019 14:58:16 +0200
Message-ID: <CAOtvUMdkC+v0R39OADF3R7Qpk+NPWW+JH0S6SUNXoHM3v+19Vg@mail.gmail.com>
Subject: Re: Regression due to "PM-runtime: Switch autosuspend over to using hrtimers"
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Ofir Drang <Ofir.Drang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 10:25 AM Gilad Ben-Yossef <gilad@benyossef.com> wrot=
e:

> >
> > On Wed, 6 Feb 2019 at 17:40, Gilad Ben-Yossef <gilad@benyossef.com> wro=
te:
> > >
> > > Hi all,
> > >
> > > A regression was spotted in the ccree driver running on Arm 32 bit
> > > causing a kernel panic during the crypto API self test phase (panic
> > > messages included with this message) happening in the PM resume
> > > callback that was not happening before.
> > >
> > > I've bisected the change that caused this to commit 8234f6734c5d
> > > ("PM-runtime: Switch autosuspend over to using hrtimers").
> > >
> > > I'm still trying to figure out what is going on inside the callback,
> > > but as it was not happening before, I thought I'd give you a shout ou=
t
> > > to make you aware of this.
> >
> > Are you using autosuspend mode for this device ?
> Yes.
>
>
> > Also this happen in a platform specific function cc_init_hash_sram().
> > I can't see anything related to pm runtime and autosuspend in it.
>
> True. However, the function is called from the driver PM resume
> callback and before that commit it did not fail.
> My guess is that there is something related to the timing the callback
> is called, probably some race condition the change exposed.
>

OK, I've found it. It was indeed a race condition in the ccree driver.
We were doing something in the resume callback that relied on
initialization sequence that happens after autosuspend was enabled for
the device.
It was never a problem because with the lower res timers we always got
around to that initialization before auto suspend kicked in and we had
to resume but with your change we started losing that race.... :-)

Sorry for the noise and thanks for your help!
Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!

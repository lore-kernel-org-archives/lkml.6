Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2759C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5CB222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYQ2TRkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436896AbfBNJFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:05:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33770 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388743AbfBNJFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:05:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id f24-v6so4570828ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhEFyRorUHZ8ki5/8iMMzmB+CjkE0yDd3USd0hgm8Dg=;
        b=vYQ2TRkUOPjE1c7Oy4FM5JQ2+zJrZy3hTHS4xGhthOxGCRzLS886rnnica7tnBwqom
         lfL0Q4bwH73KvyUADMcS52rRl/2Rfn3GzbkzbpK2/l08T+wl2JgQ+NzgIUwhs8ZvZabc
         Nf1/JZZP+h288W5aBNR/fYYTGCrIRMhhTY4mPQ1CApsvDoccgM7ZBhVlIjqyxpY2+7bf
         61of6NRsu0dmWiBSeaNtWM+ouGdQqFsHL0/KB2txqNNle353At4fTqB6PbHGs9mTYpTy
         zVXv+6N0PJ9WXmokU1lR9CYzmma7FMQwZjbeHFb17ECFzRX/Drs76pALhUQxlDrCTKLP
         565w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhEFyRorUHZ8ki5/8iMMzmB+CjkE0yDd3USd0hgm8Dg=;
        b=JhWG3osMvHh6RkXiDsEN1ePVOJZGOkiQbJKuZEJHHtWQUngFgbhhbofW8/xZ0Pd0A9
         HEyJicTOTk9x0hsWCHZY1+JsjWV1zzyrL3qctJEU8EtEq2pF5anTtIV5jMKLlkVFA7KM
         EqyYYPmoBJM8RSQJdMTa747pIc3qLHXO0EyboLtHUs/ZUfh8hXxytOcCXNUtTrc9MgF6
         cIeP/yCkub21HR7PZddSF96ywMm3Ctki0X3qY3CPRbUeLF4t/rZJ9DTGIyjB7kCrW3LX
         M59Bcwi0BcphIDA6pvCafmSwSatIHTtgz4J5RTsbXxvIfPQZ9RDbe19XTx1jYC0J+8hs
         dFbw==
X-Gm-Message-State: AHQUAuZ4Yp818+6y4+SAnKxai//bwU05kGQnU3aExsWO0Fa4b+g9OOTO
        AiSctwqBSs9E+mGDq4ygCIt8P6T97StpeZv2I973Eg==
X-Google-Smtp-Source: AHgI3IblmmdDkn70pjKh0AIyCiCSr3aD+S4wnNB83I1YrzWzbyRDu3h0uoX+Dwv5fbT4e3oxvUzrQ+XdFGc5BZHKeyE=
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr1706413ljc.97.1550135147241;
 Thu, 14 Feb 2019 01:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20190213230618.1907-1-lkundrak@v3.sk> <CACRpkdYyT20Um+5bDAiZAfB-A3M+q5DpUQS31+CkLUSb+qpQOw@mail.gmail.com>
 <50fa8c81950e8bb2583a65bfd920bdf574c9abc1.camel@v3.sk>
In-Reply-To: <50fa8c81950e8bb2583a65bfd920bdf574c9abc1.camel@v3.sk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Feb 2019 10:05:34 +0100
Message-ID: <CACRpkdbuoxZ+dyoAtUGmEjeh1XjjpLz9OHe=GgnKXO3ZK4uKQg@mail.gmail.com>
Subject: Re: [PATCH] gpio: pxa: avoid attempting to set pin direction via
 pinctrl on MMP2
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 9:52 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> On Thu, 2019-02-14 at 09:13 +0100, Linus Walleij wrote:
> > On Thu, Feb 14, 2019 at 12:06 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > > Similarly to PXA3xx, pinctrl-single can't set pin direction on MMP2 either.
> > > See also: commit 9dabfdd84bdfa ("gpio: pxa: disable pinctrl calls for
> > > PXA3xx")
> > >
> > > Fixes: a770d946371e ("gpio: pxa: add pin control gpio direction and request")
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> >
> > Patch applied for fixes.
> >
> > Should this even go into stable?
>
> I would tend to think it should.

OK I tag it for stable.

> This caused a regression for MMP2 platforms that don't use a pinctrl
> driver, and none of them do.
>
> On the other hand it went unnoticed since v4.5.
>
> I've seen stable maintainers pick up fixes even when stable@ wasn't
> Cc'd. I guess they apply some heuristics and perhaps look at Fixes:
> tags to identify bugfixes?

Yes Sasha Levin has an some machine-learning AI that looks at patches
to see if they are elegible for stable, and sometimes people tell
Greg directly to pick a patch, and sometimes Greg just picks a patch
he likes.

But to make things easier for the stable maintainers, it's best to CC stable.

Yours,
Linus Walleij

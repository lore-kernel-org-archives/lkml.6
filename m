Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40774C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049BC2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi77QwRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049BC2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeLJSjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:39:48 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34201 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeLJSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:39:48 -0500
Received: by mail-pg1-f176.google.com with SMTP id 17so5369758pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 10:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gk/YzIRmbKGFTJELUol/CatLTFz8rHh+8fPG3iiadA=;
        b=Pi77QwRyUhqJL5MKDYGkKDhPigwsHeC8Z/tffB3pAQs2mj+AywxUd6vgmXJ3tckqWD
         enIydYK9TxFP0y4JX4GvYywIp4PVj5WYGMaYE6wzI3wbcUHF4JtVCjKGxEilw4aIUe6a
         xgM2W3FMlpiKcKTRoN12vod6+vmKHoEcHd6iuo078uNnIvirx/TPLjqNINnUTFDqpoU8
         dyF4JJxRZLfW3C8XuSbHPNNBb1HalV6+bQVu86YFhmaCZEyPx8IXfhb+YCt5Vvr9/iR2
         Ft/+bBWrOcBtIOOHPN9lGZvuF4E3TF12ps52yKHmGv+Jq4Y01/ZXMsc2mJf1uGvcMHhg
         v0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gk/YzIRmbKGFTJELUol/CatLTFz8rHh+8fPG3iiadA=;
        b=hnQsLuzJSk0nlKTIwFlCqSUJrCTtkIoYGGiMBLZKDRIZVgOPdAmBJ1dAY53avKaSzd
         5OyAMlnjLP+LlTakCNOwv3FgxepfWIor6PGnlNxTLfHMrY1vz5Rw/+c+YOxV8m41D65e
         R6BjAveKyo2iMYtpAM5AL6NksZHHKHj8PbK7iQA0lWakkT3akNOzDp7QVIXUQ6UJzrVu
         VzdvE7KK4urs0ZYEsKFrZeQ4hdYyxZI8/F4qU7QR8cDA7xl4/8vtigwfuGtj9yHIQvAI
         a4Jtfg9m8KGsBbX+Ry3jkPj2SYZVd36RKhgvfEDyQtGDDqJeSE6Ht+ktEG11Cf31aceu
         8zTw==
X-Gm-Message-State: AA+aEWYAr5YTvxfkWxI1tASpPwF1eWNHsihJr8JYE8GDYQZMfaDfa4tQ
        r4IpaE0E81T2zO/dmudv2DaYuVqdiSnk5NNhO1I=
X-Google-Smtp-Source: AFSGD/UKogr7YrvEbogz8yAX/V71bcT3UbZuTbeQQTkp2kRntJ7Q4FqQpD4ifZ+tU1VhP7aVeTY9tH2xSWzwngUiBFQ=
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr11640313pgh.265.1544467187390;
 Mon, 10 Dec 2018 10:39:47 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgHSX8x6mOB0xZibbg-xc3veqsQEnHZ1+3H2DbO5MU5Rw@mail.gmail.com>
 <CAHp75Vf6Au7yY4zdn5=qMjMvDKCi-LVAW45sjzB5f0C+m3VYHw@mail.gmail.com> <CAHk-=wgO2U0rGtLf-3Ym6dUKgavhNPZxHP7Gg8LuG8GgFaxKFA@mail.gmail.com>
In-Reply-To: <CAHk-=wgO2U0rGtLf-3Ym6dUKgavhNPZxHP7Gg8LuG8GgFaxKFA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Dec 2018 20:39:35 +0200
Message-ID: <CAHp75VdCMJVp9A=W+_jppR4ai6Uk8y+A4u1b6-FN=neR=v=xNg@mail.gmail.com>
Subject: Re: Linux 4.20-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Oops, forgot to Cc Darren, fixing)

On Mon, Dec 10, 2018 at 7:46 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Dec 10, 2018 at 1:52 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > Linus, due to my vacation schedule and possibility that Darren might
> > be also busy with some stuff, would be okay to send PR this week, for
> > example?
>
> Oh, absolutely.

Thanks for elaborated answer!

>
> And I want to make it clear that this is not something you ever need
> to even ask about, or make some "special case". It is absolutely
> always true that any submaintainer can send pull requests for the next
> merge window early.
>
> To avoid any confusion, I do ask for a couple of simple things if you
> send a pull request before the merge window opens:
>
>  - make it very clear and _explicit_ in the pull request that this is
> for the next merge window.
>
>    In other words, don't make me unnecessarily upset about "this is
> much too late in the rc series to send something this big" by making
> it a small note at the end.
>
>    This could still be something lik [GIT PULL] in the subject line,
> but on the very first line say "For the next merge window" or
> something. Don't make it subtle or something I might not notice before
> I start getting upset at how big a pull request you're sending me
> during rc6+.
>
>  - don't use it as an excuse to send two or more bigger merge window
> pulls. An early pull is not an excuse to then have a second big pull
> with other changes.
>
>    Second (and third) pulls are obviously fine, but they should either
> be starting the calming-down period, or be about other things entirely
> (some groups send 5-10 pull requests that are independent).
>
>    I don't want to get the feeling that there is a "this is partial
> work, there will be more" pattern.
>
> Anyway, people have done this in the past, and I don't mind it at all.
> Send pull requests early if they are all done and ready.
>
> You don't even need to have a vacation excuse, you can just say "I'm
> done, this is already in linux-next and it's passed testing etc, it's
> not some unbaked thing that I just want to get rid of early"
>
>                   Linus



-- 
With Best Regards,
Andy Shevchenko

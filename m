Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE013C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BCD20817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="su6Pz1k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BCD20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeKSTcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:32:15 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36758 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeKSTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:32:15 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so6423087itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 01:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w/UvPdk3k04KPwiRCCTh5A76t37IqsDKCLrCWDRwgWI=;
        b=su6Pz1k19nzWjDOxxoebECmLsglqLcWVjCYm7RS66am8NBHbm2ZzAx1ZoNLiubcOCH
         oMlzeJNX30AOJ88jsacFySxhDz+etW30I9XsH0Bfb4fMReJeGE45ed+whYqRRAMPjqJI
         mGpC2Hciizu8H55etLVUlA+6uE8MgDF1hZhEzehR+n72XoQVYnXTfp8XCkVfsX275Z3c
         qILbS1+MdlUJ5Lm4cbvkDSaaq7PJBNqC86i7iTuE7PEF1ZFulW+2ZcWIARuNrCpCy5bh
         wOSISd9iZkunJHD7d1Jahmz5E5zbOR21j//6uVnVJLWxLfjkVppKFEqHjtYrQgBasbV+
         ojBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w/UvPdk3k04KPwiRCCTh5A76t37IqsDKCLrCWDRwgWI=;
        b=piEkFTVUZ87lPZ3fZu7ex74J35M1jBEfaKa8yH31an7LE1QGeL6lTeAfplaDhLAw/f
         T4hin/aNbI0EWF86POaSPpx6QUdAH4inaekkoDK/yZSUkRqYDWq1z9Y5sAQqlVv07Aec
         oR0hgHIl55+nZAiMRCgoqiifmW4dK5XiaJ6CeNEr46ZLazFWuuyX4NehWGYRSXCXDxvA
         8nfVehWDGamRoLNI7lDnhFHdo+Vca1pE0wAcCL74QYyFkokriG3KJMZt1W+ZOvU1p1ht
         f1dCuMHHNO3BexOJBwuhhc/7j+ua+CLqgngca8rzgZ3rQHfIQGRCV24/zqkzkQNVlSf6
         tA9g==
X-Gm-Message-State: AGRZ1gKi+/XZEnC7I+P9NafjTnd3zuXALyZ3Exu1hH/3CbGtlaqGAPv9
        67P3suFP21RW+mJbYGfuSJhPXyS0AwBBRsMq6I30wIBY
X-Google-Smtp-Source: AFSGD/W/uEn3toVc2pcIFldDnY6VAYUGvTTSC3vi6fCr+UQJIYzVnCNGSGQQQ/7qJDZMrgnH+7OQPiTZjqrHieASAHA=
X-Received: by 2002:a24:4dc9:: with SMTP id l192-v6mr8059535itb.96.1542618553730;
 Mon, 19 Nov 2018 01:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20181108165255.9940-1-brgl@bgdev.pl> <20181108165255.9940-3-brgl@bgdev.pl>
 <CACRpkdb71d2yCmxWDBaHY+60A9UDG1u0ACuXUq9pcH13_yA6-g@mail.gmail.com>
In-Reply-To: <CACRpkdb71d2yCmxWDBaHY+60A9UDG1u0ACuXUq9pcH13_yA6-g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 19 Nov 2018 10:09:02 +0100
Message-ID: <CAMRc=Me9Ypsz_NH7j1K1TxR8u=9qF9opKPri10Jkn3G=_tdssg@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: mockup: add locking
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 16 lis 2018 o 22:43 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Thu, Nov 8, 2018 at 5:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > While no user reported any race condition problems with gpio-mockup,
> > let's be on the safe side and use a mutex when performing any changes
> > on the dummy chip structures.
> >
> > Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> I tried to apply this but it failed, does it require patch 1?
>

Yes, because of the change in get_direction().

> I can pull in the next -rc after I merged the fix in that case
> and we can apply on top.
>

This is fine, it's aimed for 4.21 anyway.

> __gpio_*
> I tend to dislike __underscore_notation because I feel it
> is semantically ambguous. I prefer a proper name, even
> to the point that I prefer inner_function_foo over __foo,
> but it's your driver and I might be a bit grumpy. :)
>

I think this is a common and intuitive pattern in the kernel codebase.
Many subsystems and drivers use '__' to mark functions that execute
internal logic and expect certain locks to be held etc.

If you don't mind, I'd like to leave it like this.

Bart

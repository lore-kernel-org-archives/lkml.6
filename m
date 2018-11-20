Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA3C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2110B20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkANRk1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2110B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeKTTPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:15:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41224 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKTTPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:15:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so740478lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n6xe3mCXqBqXIMPvfeltvyXoJXOa7un8GIj6UEZ1sdQ=;
        b=XkANRk1EOKeftRqZx5EWW1dHy0qD/YC3SKNElj5hzwyH7GmrpKZqZmICEFo9aKHaSl
         W5anjEP3uktzxAOEgZSPpUUvRKNWWZadKeZ9i4DexoE7z65dqHKijDk3kVy/t6GINAq3
         eXNHZ6lIkaa7y27/B9QUAUz8QYFqdOwVRxMhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n6xe3mCXqBqXIMPvfeltvyXoJXOa7un8GIj6UEZ1sdQ=;
        b=H0Q80qImQ9ZpFRLp1mO7UDPfshXWZmlJiBcP+S4SG7y/LPfWr0/WqjDAsai5d01OCq
         Dgy81mqPhVU4UFqhucYD0U2BNbEPMzG6lExRqUDLzeFUUrySfCG6pQxn6WiBe6TeumcF
         ciEkemLK0R7iMvzuowLy5J7gTD5+k/6Y1oZHWOcZyWm3zXmoh9prTErs+OY4+XzE6ke9
         SPmrVyOzoZUy8SSe34FUpgjLKaZH7DIjHpbaoUK2KponDEWLnz65n25cu36apjHVs8Hp
         MFvR9XttpmWnxjEHVAFjGNKG/MwakvgMg0ImlCmlseCBxX5Uu02zQ2F+H9xkvzi8UXyS
         ddQA==
X-Gm-Message-State: AGRZ1gLWtubZ2aZ2ZYQb99Jrtz4H/OhqfNMzCcClzefPxlRe4wLigBLQ
        oYNbKCR0c38fHXi5F+oeP3C1UZ1pVoXUTW6WE+t5RA==
X-Google-Smtp-Source: AJdET5cfvfcvG1kJ9jnlQqnR5aYcmT2CJowD422F0Ri5wpXJyd+wiNikqf0dv/Nh6PGbT74wPbw23+6ot9QJnRrI3AU=
X-Received: by 2002:a19:f813:: with SMTP id a19mr594633lff.67.1542703621735;
 Tue, 20 Nov 2018 00:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20181108165255.9940-1-brgl@bgdev.pl> <20181108165255.9940-3-brgl@bgdev.pl>
 <CACRpkdb71d2yCmxWDBaHY+60A9UDG1u0ACuXUq9pcH13_yA6-g@mail.gmail.com> <CAMRc=Me9Ypsz_NH7j1K1TxR8u=9qF9opKPri10Jkn3G=_tdssg@mail.gmail.com>
In-Reply-To: <CAMRc=Me9Ypsz_NH7j1K1TxR8u=9qF9opKPri10Jkn3G=_tdssg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 09:46:50 +0100
Message-ID: <CACRpkdasK1UoNz34skdb+NbEE7SQuMhkij+xGW=Y6Pc5LF3AxQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: mockup: add locking
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:09 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> pt., 16 lis 2018 o 22:43 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):

> > __gpio_*
> > I tend to dislike __underscore_notation because I feel it
> > is semantically ambguous. I prefer a proper name, even
> > to the point that I prefer inner_function_foo over __foo,
> > but it's your driver and I might be a bit grumpy. :)
>
> I think this is a common and intuitive pattern in the kernel codebase.
> Many subsystems and drivers use '__' to mark functions that execute
> internal logic and expect certain locks to be held etc.

You say it yourself: interpretation depends on context.

I might be especially stupid for being unable to discern
meaning from context in these cases and so what is
intuitive for some is just not intuitive for me.

Example:
set_bit() vs __set_bit()

Apparently some kernel developers think it is completely
obvious that the latter is the unlocked non-atomic version
of set_bit(). However I was confused for years with no
idea as to what the difference was.

Had it simply been named set_bit_nonatomic(), at the
cost of a few characters, confusion on my part would be
avoided and at least to me the world would be a better
place.

> If you don't mind, I'd like to leave it like this.

No big deal, keep it as is :)

Yours,
Linus Walleij

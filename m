Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214ADC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17F5217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HGKeuq5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbfAKNpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:45:20 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55167 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732139AbfAKNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:45:20 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so2483121ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 05:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JMJ2baQS2dIgXev3LaJ+yp6fOdLMxRc+NIZKmCar2KE=;
        b=HGKeuq5QRPsNaXtA/V1oXRAmpO+X0oqLTUJQIbxxRgoHdmmbLijOGnoaMVEgeVdATA
         uhlmnaYSPTacZSe47nbuCe1RB/1V0sLbAZSRhbX2VwNpwwM8+ScYcx5B+bdly1ZrniRU
         /6ic8HYmkEUQg/wGB3LRxnoGRPuPeQybjARZpIlMhWFFGVTtCCsKkI+N58seb2i9UTrc
         YiGykk6HfO3xAy0OsW7T7MDjyVdsjVXT11IHFZmyAxIyHS5PKh9i/pArHp1IHoBBt8eQ
         g7P8jGUdmmgZcBYUY711jQLCC0rsPGuaSGFxCcRHXf6InQW2PhKzaaOgJrqvAzU6WyYe
         Ly8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JMJ2baQS2dIgXev3LaJ+yp6fOdLMxRc+NIZKmCar2KE=;
        b=F4RBxa4N+AMjfF90vlmp/4pPe8SWFb3MdrmVm/bUQfvLiuu78xGAXtE8Kt/mClQ/9l
         txcuQNwD+yjVWcbfS+MninEFlZhFG7/DEDrrPcwMgZu/8qO+QEhUC0HlNIvRrS0blczP
         ne5nx3skDbe0jqCpSTj7hoekY6r6RBMDGiJFRZbyMUqh9+U1qz5uMLh60dZTHmBDWlOM
         BCcsXTUbbH0armb8Wym3RCTB+WfdQQevlfZ3P5mbOsrGnAywkdAisB+xgGc7tr8bpQBZ
         r1zGfSSbMeTpFNHty8qFNLcEx7FffCYAURkkkRli1M9D1SR6mcJ/pKD6+dRhB0cHtZJ5
         aA8Q==
X-Gm-Message-State: AJcUukeXUW71G8rvwstEe3Ed8M7c8yNl9B2zi/wVEYHDAHK+zezGuaxC
        UkB4PgIMkV4BKSPCQDzwkToL2VR6IECFkRcGr8InBQ==
X-Google-Smtp-Source: ALg8bN7AuiszGrGBDdA6s1urNoKK0E4W8LpxMuXjhmEAWcpDPhzmITor+rXLqKfNPfoTGoKM/RaRBPVmojtLkbRy81U=
X-Received: by 2002:a24:f909:: with SMTP id l9mr1110094ith.74.1547214319324;
 Fri, 11 Jan 2019 05:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20190104103226.2878-1-brgl@bgdev.pl> <CACRpkdacXeBEh2UMmigSo+zYQCj3yMyNRfxHjqhu_kiZ2JMXbg@mail.gmail.com>
In-Reply-To: <CACRpkdacXeBEh2UMmigSo+zYQCj3yMyNRfxHjqhu_kiZ2JMXbg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 11 Jan 2019 14:45:08 +0100
Message-ID: <CAMRc=Md_8MBbc7RSwyPNMGYnJyQqvSgoyHYhEgQf5C4ac_K9eA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix line event timestamps for nested irqs
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 11 sty 2019 o 13:19 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Fri, Jan 4, 2019 at 11:32 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Nested interrupts run inside the calling thread's context and the top
> > half handler is never called which means that we never read the
> > timestamp.
> >
> > This issue came up when trying to read line events from a gpiochip
> > using regmap_irq_chip for interrupts.
> >
> > Fix it by reading the timestamp from the irq thread function if it's
> > still 0 by the time the second handler is called.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Oh that's right. Should this not have Fixes: and Cc: stable?
>
> > +       /*
> > +        * We may be running from a nested threaded interrupt in which =
case
> > +        * we didn't get the timestamp from lineevent_irq_handler().
> > +        */
> > +       if (!le->timestamp)
> > +               le->timestamp =3D ktime_get_real_ns();
> > +
> >         ge.timestamp =3D le->timestamp;
>
> I would merge these:
>
> if (!le->timestamp)
>     ge.timestamp =3D ktime_get_real_ns();
> else
>     ge.timestamp =3D le->timestamp;
>
> Yours,
> Linus Walleij

I'll fix both issues and resend.

Bart

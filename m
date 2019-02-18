Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4706CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1256021736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="S1tqOE4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfBRQo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:44:29 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39113 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbfBRQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:44:29 -0500
Received: by mail-it1-f196.google.com with SMTP id l15so29634110iti.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9V7+lIoDvMVfAb9ZCNOj0vkV9nC3dlS0USj8kqPlxno=;
        b=S1tqOE4pnBPpT2jee6yoleK5ipqLB9Rb6ANxSz3S/YQ3F5MheEPkc3EAzTVD2zUSCc
         TPDSmH2Lif2SqA+x6VoGLQoHNH2rJH7gqbrK7LM4CBJ4Emsu3IhNYGQyvzLlsvSF0ZKp
         /48cYpwLzD26MHfEA8+KKt7U7sP5OFsAx4WSs/bluOpynFHMMxyzggK2WvWkQxnS3hRy
         DW+ySqFnm3JGML2WrHXjzFXi2Kbf5JUfykUnnHW/o8f7nZ3zVORpUS1qPHSlR50XWcpP
         mmPJp02zYf5C+FffdEisJHVjzSFkS/OzJz28n4s18O1JLuRpZfm0UP0QYKH47dF6sGb9
         08VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9V7+lIoDvMVfAb9ZCNOj0vkV9nC3dlS0USj8kqPlxno=;
        b=XAnaPkAW7NMNohhRfZgeutUeBxR15VSo9BSWVu2JP+Zy0YfU9NoNDqYsXYYCCH4y6S
         8ZBG78CwC9pP5CMUYcp9fAO6CYcZSsxWfnwOHiwpO+acnJgSRtAuTWEjixzsqD66L8oT
         GL1/Ul9v8FWpzOYLfNtq8aIeZXzy2tKDDFXGRudCi6LGhB51t/Su6NtSRnbcWcdbOG8u
         /TI3oI8c0ftPn/66kBwbL2WORxxpV+EqiT94Us2B7o34oBtZnoAzaEp97tFMI0OAvyzq
         IOFLq70ZtHD8YiXi2mnU4t9h+/Pmvh/9SBxAAZeTMjFjNvnw/RVWTIzEyTtYKMUffBqS
         7zvw==
X-Gm-Message-State: AHQUAuZb/FqkgHKy+nLXRgiv+LEER1Ldb3YPJb7O72M69GbWgSgUNgl3
        8nYuRuVVnNPmRLCVAbY4RRPgtDjXlpYNLCyod8jnTQ==
X-Google-Smtp-Source: AHgI3IZNV4O7hs5LThVJPf9UsZtnC247nWSNIoxbyNUOJuz1XqLMDiRK4awqPHWwHRIGbg9hIf1RKR5w0ir/TVRPT0s=
X-Received: by 2002:a24:9795:: with SMTP id k143mr11601401ite.74.1550508268013;
 Mon, 18 Feb 2019 08:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20190214134232.3821-1-brgl@bgdev.pl>
In-Reply-To: <20190214134232.3821-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 18 Feb 2019 17:44:17 +0100
Message-ID: <CAMRc=Md-fXCFYtwPdZN5nxL4cecia5QN9aV5=pAG3rpZ9OHi+A@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] gpio: mockup: improve the user-space testing interface
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 14 lut 2019 o 14:42 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Hi Marc,
>
> another try at the irq_sim stuff. This time I added a notifier chain to
> irq_sim and made gpio-mockup register a notifier block. This way interest=
ed
> users will get notified about a type config change.
>
> v1 -> v2:
> - instead of providing the irq_sim_get_type() helper, move the irq type
>   logic into the simulator and provide a helper that allows users to spec=
ify
>   the type of the fired interrupt
>
> v2 -> v3:
> - switch back to having irq_sim_type() and put the line state logic into =
the
>   GPIO testing module
>
> v3- > v4:
> - drop irq_sim_get_type() and use a notifier chain instead so that any ch=
ange
>   in type configuration can be pushed out to interested users
> - change the locking mechanism in gpio-mockup to a spinlock as we can't t=
ake
>   a mutex when a hardirq-safe spinlock in irq_desc is being held when the
>   irq_set_type() callback is called
> - refuse to set any other type than falling or rising edge in irq_set_con=
fig
>
> Bartosz Golaszewski (7):
>   irq/irq_sim: add a notifier chain
>   gpio: mockup: add locking
>   gpio: mockup: implement get_multiple()
>   gpio: mockup: don't create the debugfs link named after the label
>   gpio: mockup: change the type of 'offset' to unsigned int
>   gpio: mockup: change the signature of unlocked get/set helpers
>   gpio: mockup: rework debugfs interface
>
>  drivers/gpio/gpio-mockup.c | 215 ++++++++++++++++++++++++++++++++-----
>  include/linux/irq_sim.h    |  22 +++-
>  kernel/irq/irq_sim.c       |  40 +++++++
>  3 files changed, 246 insertions(+), 31 deletions(-)
>
> --
> 2.20.1
>

Since this really is overkill, I sent v5 in which I simple store the
trigger type by calling irqd_set_trigger_type().

Superseded by v5.

Bartosz

Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E027BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8A92083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pFv4Uorx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfBFKX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:23:59 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40732 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfBFKX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:23:58 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so5037343ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 02:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2H2Fmu5nivfdQanC6lW26Q/Zs/9kNgB8S1U4MnRNqE4=;
        b=pFv4UorxjZUpaKYF9JGdOx44ifsVfN9kV74MuJUFwuf03JWrEVVCERnelDwKMEdkTm
         JC5r4l7LE9sT4X3wSzjIMVMo03xGsWg8XWnzb0E3rreCf2OdbCKXsp0dlmSJjAkKd6vf
         9M7QcjaRLHZzzivz6SplRHThUaWsBmU9WDbYmA/qFoMxFoMXUbJaMm3JMIrg5Phpl2y1
         PGjQcE7qDjT5+HjIjkpM+dKDI6x2G9ylRtzjJnCvJj54gmhHtiYQTYQmZ2x1w9XLqs1W
         ZTTQnW/39/JGFR8E77hxQmw7WixLUMQBUfvX3d7r+zm5vstYRFSTs+HhLYD8BIDxjsHK
         dZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2H2Fmu5nivfdQanC6lW26Q/Zs/9kNgB8S1U4MnRNqE4=;
        b=sZacCBf15u6c0/NLy3oz57hkCyqzyqzA3ltHkZX40UjFwlPlQLLCFcyZVv4PFtXG7K
         urw/J+nzwKSw6G4EZktRYFCSNpiKqYUlZSYZZaE0zUirRGoeobVMBzhCccbGOP6Dh9wJ
         6RFuq1Ry1PWz7XY0UuUd2gokL6FGO4rZ2G/er5yWNx7+xogXKQS/FO9bilZAW6LTn9qJ
         STU4Xu3W5DMxTSOIbMia8j3ogEjCPsxgL/u9VHbeHUlVFKaIcE6Lfmmqz6+MT6JqVHBT
         2sN/Xv9mFSa9Pr8AZlM6CJ0WG/RNWTUo7C4RkUU0++Rc3SOrPF6oQNiodxmqa+Y+inDY
         x0xQ==
X-Gm-Message-State: AHQUAuZwRYSfu7Wf8ZGQl11cLtRYhN04ZoTvjqKlQUNnDXdRi5dvZMem
        hUTwgui/MJ0GSp3fw3Os8JqIUkoEOQle/yJ1oP1nVQ==
X-Google-Smtp-Source: AHgI3IbP1AsBZj+D5qE1wuR4uycYAZTe9iPi2Zss7JTsPmCf6NwknToB21Dm73haXJKK8IkA2J/QzaNcG1KodeWxO40=
X-Received: by 2002:a02:6f4d:: with SMTP id b13mr4867801jae.57.1549448637683;
 Wed, 06 Feb 2019 02:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20190129084411.30495-1-brgl@bgdev.pl>
In-Reply-To: <20190129084411.30495-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 6 Feb 2019 11:23:46 +0100
Message-ID: <CAMRc=MdyJO4F+GJ6S-moxQ1znQXatL6H27RFFiuaaOuLQdvnAA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] gpio: mockup: improve the user-space testing interface
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 29 sty 2019 o 09:44 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This series aims at reworking the gpio-mockup debugfs interface. The
> reason for that is the fact that certain known problems with this
> testing module exist and the user-space tests are broken anyway
> after commit fa38869b0161 ("gpiolib: Don't support irq sharing
> for userspace") which made it impossible for gpio-mockup to ignore
> certain events (e.g. only receive notifications about rising edge
> events).
>
> The first three patches improve the interrupt simulator. The first one
> makes the struct irq_chip part of the irq_sim structure so that we can
> support multiple instances at once. The second delegates the irq number
> mapping to the irq domain subsystem. The third patch provides a helper
> that will allow users to specify the type of the fired interrupt so that
> the configuration set by the set_type() callback can be taken into accoun=
t.
>
> Next six patches improve the gpio-mockup module. Patches 4-5 have been
> reviewed before but missed the last merge window. Patch 6 is there
> because we're already breaking the debugfs interface anyway and it
> removes a link that has no users. Patches 7-8 are minor tweaks.
>
> Last patch introduces a rework of the debugfs interface. With this
> change each mockup chip is represented by a directory named after the
> chip's device name under <debugfs mount point>/gpio-mockup/. Each line
> is represented by a file using the line's offset as the name under the
> chip's directory. Reading from the line's file yields the current
> *value*, writing to the line's file changes the current "pull". Default
> pull for mockup lines is down. More info on that can be found in the
> comment added by this change to the gpio-mockup code.
>
> This is somewhat inspired by the idea of the gpio-simulator by
> Uwe Kleine-K=C3=B6nig except that I strongly belive that when testing
> certain user API code paths we should not be using the same paths for
> verification. That's why there's a separate interface (debugfs) sharing
> as little as possible with the character device that allows to check if
> various operations (reading and setting values, events) work as
> expected instead of two connected dummy chips sharing the same
> interface.
>
> If accepted this will of course require major modification of user-space
> tests in libgpiod once upstream.
>
> v1 -> v2:
> - instead of providing the irq_sim_get_type() helper, move the irq type
>   logic into the simulator and provide a helper that allows users to spec=
ify
>   the type of the fired interrupt
>
> Bartosz Golaszewski (9):
>   irq/irq_sim: don't share the irq_chip structure between simulators
>   irq/irq_sim: use irq domain
>   irq/irq_sim: provide irq_sim_fire_type()
>   gpio: mockup: add locking
>   gpio: mockup: implement get_multiple()
>   gpio: mockup: don't create the debugfs link named after the label
>   gpio: mockup: change the type of 'offset' to unsigned int
>   gpio: mockup: change the signature of unlocked get/set helpers
>   gpio: mockup: rework debugfs interface
>
>  drivers/gpio/gpio-mockup.c | 185 +++++++++++++++++++++++++++++++------
>  include/linux/irq_sim.h    |  17 +++-
>  kernel/irq/irq_sim.c       | 126 ++++++++++++++++++-------
>  3 files changed, 263 insertions(+), 65 deletions(-)
>
> --
> 2.19.1
>

Marc, Thomas,

if there are no objections - could you please ack the three first
patches and let me take them through the GPIO tree? I would really
appreciate if we could have them in v5.1.

Bart

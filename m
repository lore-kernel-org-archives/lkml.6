Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA0EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D31214FE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwULNhff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D31214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeIYPVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:21:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35773 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbeIYPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:21:22 -0400
Received: by mail-io1-f67.google.com with SMTP id w11-v6so19902786iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KKhG+ClsyoH/EJmy1M51ajusGJqD6R42GSJOKiGWFgQ=;
        b=cwULNhff/7+xZJaDWjtT8r4WbYmkv5ac1O4TuRLC93YM6ue8ar68ChXxfIU4X24jc6
         DMrAoqhUimWZiXKrwjlQvG8jMhhjqdD7WgtOOnGauHcmJy+1ZeCmmEEzsLZ3x2ZQGQYq
         fhvythDlxcMUS4XSnvuvMsSGmTopSEEgmyebI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KKhG+ClsyoH/EJmy1M51ajusGJqD6R42GSJOKiGWFgQ=;
        b=azOB65soX8m+Z68T1TVqVK06iLU5AniGiHQP1EgtTDIj28+uMyP7Lm9WQjEoYXRbKg
         ZFz8gm1gY+Af3YHLJaTv21v+u3JzwOhy57E6QWeabfOFV29+Xmg8mm014BWWlCsNXJCW
         J8VFj43gj09Zs0Kb4UXbEoJtXojfA4PZd0lzFjA5YtVw+Hcq6aHzvYrC6dBOz73ukCih
         m1MvmT9azR80ww2CtPA19Ap/glHwts3wBgx2gZsZM8hPajtg3rLpxzLGlZWnMJaLbd0l
         QfcwcTq9bS1m+y5R3yD691Mx1g93WWaIPrdrERLgXCUunh+qsBnwzaVWtNKNEFOZups2
         QRlg==
X-Gm-Message-State: ABuFfoi5tZbF9xmqq7B0RLRtMU5BHXQkiQ3h8X6uGhYe+T90EKx76rJY
        BhGojTB9tXaqGp9ukIgj5BS2G9CgYHj780Be9zr/bIN/
X-Google-Smtp-Source: ACcGV63pUeabpr0u767HBLCk7RumJXDFatuwg6ROUvp3LGVymbkU2d2Scr0epQa5uc156hMVXF2rM8DZLaw4MutuMbo=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr71335iof.304.1537866886197;
 Tue, 25 Sep 2018 02:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180923111727.10378-1-brgl@bgdev.pl> <CAMRc=MfZ8jRZHgXBq9TeYm5VpmLzwG7gF-NMYay9Zg-iEgFQDQ@mail.gmail.com>
 <CACRpkdb7zKfa_e6WWHncg+gxGncsC_Bx7gpkhJyutH4tqJRkew@mail.gmail.com> <20180925090321.GX2664@lahna.fi.intel.com>
In-Reply-To: <20180925090321.GX2664@lahna.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Sep 2018 11:14:33 +0200
Message-ID: <CACRpkdb1BoD2bNfZx=CQvJjgdAYbqQ9556eGPXUawrm=OfKnYg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: use device properties instead of platform_data
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        vincent.whitchurch@axis.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:03 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Sep 25, 2018 at 10:53:30AM +0200, Linus Walleij wrote:
> > On Mon, Sep 24, 2018 at 9:35 AM Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> > > niedz., 23 wrz 2018 o 13:17 Bartosz Golaszewski <brgl@bgdev.pl> napis=
a=C5=82(a):
> > > >
> > > > Some users want to introduce device tree support to the mockup driv=
er.
> > > > Let's make it easier by switching to using generic device propertie=
s.
> > > > The driver stays compatible with previous use cases and after this
> > > > conversion there'll be no need to change the way probing of mockup
> > > > GPIO chips works.
> > > >
> > > > Tested with libgpiod test suite.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > (...)
> > > Linus, I just noticed that we either need to drop the check for
> > > -ENOENT or add an else that returns on any other error. I'll need to
> > > send a v2
> >
> > OK business as usual.
> >
> > > but I'll let you first tell me if you like the general idea.
> >
> > I don't know, I'm a bit ignorant about the idea, scope and
> > ambition with device properties.
> >
> > In my book this relates to the fwnode concept, but maybe
> > I'm wrong?
>
> I think you are right.
>
> > Mika, please fill us in here. The device properties in gpiolib
> > came in the patch
> > "gpio: Rework of_gpiochip_set_names() to use device property accessors"
>
> I'm not sure what to answer to be honest :) The idea behind that patch
> was that we would be able to use the same properties (DT properties,
> ACPI _DSD properties, or possibly built-in properties) to set names for
> GPIOs.

I guess it's a yes.

If Vincent use this as a basis for this DT (etc) probing it means we
can use the mockup GPIO driver for ACPI gpiochip prototyping as
well, which is a win-win.

Yours,
Linus Walleij

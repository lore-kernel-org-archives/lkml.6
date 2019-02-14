Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF1B222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eJkRkujT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438444AbfBNKmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:42:16 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52488 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfBNKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:42:15 -0500
Received: by mail-it1-f196.google.com with SMTP id r11so13859751itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 02:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iLcwJycY1kKvCe6BWQe+p6bxbxBISz8NhGvhbQXeh3o=;
        b=eJkRkujTtmf1S/xBoC1mDpTJYH4BGlpKAnMR/RWf4O5W6GqKq4u+0lwHhMOMuSf2rv
         fCKdh9fzTg5bD9hc1c7xzoGUZk2Uxkwm0V6AGf5Uw+7gUmy9IMfntpTYIwHlGax+gYp3
         nY8FRTUV0Nt306B/TrQx5qjg02CoanvKpEqhs8oQCWEUYJepo6FDzAAcJmkV/qgOFBAu
         vvE+lvXHtZFRBP722gb8RWVkaBELRUoHdVEQpZm9KlGpqXABSJ4Hpa2X0vyyfWBeVrCE
         edD8B7IRqc5krp9umMsyGswVqZFB+d1uYYwSvjr8io8OcZMFyLCQVcKBg37Lzd8rxV9I
         6ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iLcwJycY1kKvCe6BWQe+p6bxbxBISz8NhGvhbQXeh3o=;
        b=nxueHbqLPUrU6g8yPJXT5vrM6BHRTViW95J6eLZkzLpxaZYXSpfu+M5zYL10n0Tgnp
         8f/v/02lgsoTnOBAjwNePYgRDeLWXGNPXZWI58lADq0C7ZVWrsudGTMRuBWmlD7978Ru
         vtZKc5k+IXPUgsKSr5e86F4gm5sX74i5/2lSiTYLZ4GamKwBA+SgpBkY+vCs9KOELtbz
         wMuoihk7W+5Qzr0z8rfXAB9ae+H6YpgKaC3XYVnvBzx/tchuQUKKLICq1TFCV1HOJf74
         qXGPD3z2ngqgD9ob/PxU0OlETA9iLVRwOCaMRoTfTMEynZDuZqu4HCx2Vd/4TzY1Kquo
         4dpQ==
X-Gm-Message-State: AHQUAuZSNL6xC+J+MDwZCE7566nYimt8uMv8bVgMSywEOlylGd1IZwSs
        wO7GmDWjoVj5K3Qg+jKGyyxGoTVs/g1feKYwK+YjNg==
X-Google-Smtp-Source: AHgI3IZT/jwLm4ChYj5cjIvSNaYMeixL8c+L95yT6BZOv63z1+ThM2Gp1SinQsYt302ds+4zm6t5NNuakd7AUu7bsqc=
X-Received: by 2002:a24:9795:: with SMTP id k143mr1469938ite.74.1550140934690;
 Thu, 14 Feb 2019 02:42:14 -0800 (PST)
MIME-Version: 1.0
References: <20190213134335.10838-1-brgl@bgdev.pl> <20190213134335.10838-8-brgl@bgdev.pl>
 <20190214103944.GC6132@amd>
In-Reply-To: <20190214103944.GC6132@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Feb 2019 11:42:03 +0100
Message-ID: <CAMRc=MdR9j3pEw4SFU+SQyWF-jD3n-kp6Z7_6L-bH6J2zyeSZA@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] power: supply: max77650: add support for battery charger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 14 lut 2019 o 11:39 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> Hi!
>
> > +#define MAX77650_CHG_OFF                     0x00
> > +#define MAX77650_CHG_PREQ                    0x01
> > +
> > +#define MAX77650_CHGIN_UNDERVOLTAGE_LOCKOUT  0x00
> > +#define MAX77650_CHGIN_OVERVOLTAGE_LOCKOUT   0x01
> > +#define MAX77650_CHGIN_OKAY                  0x11
>
> Thanks for doing this.
>
> > +#define MAX77650_CHG_ON_CURR                 0x02
> > +#define MAX77650_CHG_ON_CURR_JEITA           0x03
> > +#define MAX77650_CHG_ON_VOLT                 0x04
> > +#define MAX77650_CHG_ON_VOLT_JEITA           0x05
> > +#define MAX77650_CHG_ON_TOPOFF                       0x06
> > +#define MAX77650_CHG_ON_TOPOFF_JEITA         0x07
> > +#define MAX77650_CHG_DONE                    0x08
> > +#define MAX77650_CHG_DONE_JEITA                      0x09
> > +#define MAX77650_CHG_SUSP_PREQ_TIM_FAULT     0x0a
> > +#define MAX77650_CHG_SUSP_FAST_CHG_TIM_FAULT 0x0b
> > +#define MAX77650_CHG_SUSP_BATT_TEMP_FAULT    0x0c
> > +
> > +#define MAX77650_CHARGER_CHGIN_DTLS_MASK     GENMASK(3, 2)
> > +#define MAX77650_CHARGER_CHGIN_DTLS_BITS(_reg) \
> > +             (((_reg) & MAX77650_CHARGER_CHGIN_DTLS_MASK) >> 2)
>
> But I guess these could use similar treatment?
>                                                         Pavel
>

These are already called the same as in the manual, so we can keep them rig=
ht?

Bart

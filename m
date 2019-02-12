Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627E9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E78F2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Q/QF6oRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfBLNaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:30:01 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:40771 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbfBLNaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:30:01 -0500
Received: by mail-it1-f174.google.com with SMTP id i2so7414984ite.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ugX3j3UvK8SJyrk0RaWMgtY69bh6GAn6yfo5IwPPhX0=;
        b=Q/QF6oRYaQDBnZco50tLw1f6AGEEIcTHSA2IDsoqvFl/FlCnRL9mMbXYH3gaBnKECY
         /o1L3URlddMDaN+EXaKLauV1VnoB9uDX7T6SY22a8OlBbhsES88SRYQuOdvbH7mGSJ30
         0LdUeV5p3pCjjMblvb+y3ZgbCvzc76e5OFFDQ1QRbR766M8TAADB4OMT8cmlvLGzmDyN
         pW+OHbvGDFA2WcC3RwA/u78v8LnoUe0p1KgLif0nnAd3T+Dpwlfo7aOU+PraFLPHe8/w
         ajCAn17ePQmon4XpVnD/2e0mu3Q1/hQ/IxnoELOEW21HvanZGM8oE91tkioeVPgDTBAj
         nK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ugX3j3UvK8SJyrk0RaWMgtY69bh6GAn6yfo5IwPPhX0=;
        b=ApM+cDXaHzRqFts0gcPdUNBFJSiDre/m4vOR3Rs4RRGBHqR6hvtseuebqVP32uQaE9
         DQiYa4mwxeXF6uu1GPDCBuWIj64YFQIMv8gAHD2VI5CNdzy2erJLMU/T9jVWwP3KJ+pT
         BfEaPFlcMwiLu/sZ+bxMkB5CLVXR0zHznygwktR8GyU8g3Ki6xQztrb++ByCcU2Q/tb0
         tDtEMDTy0/LphYnta4vK7rglb8LRkrI9QcuN7YHcHJWqiP4DxIVyRHj2/dBakL5dAZK6
         MZqesf7UiSLVnZXZGu3SjSlwzto9WeYi4jH/xnWQHgKjafiZXkvIO2To/zSbLtPQF6Ko
         nDdA==
X-Gm-Message-State: AHQUAuYHqlCnzpKQ/st48M8i2C4lMOBh4PKYNc0bsFNfNgM7YFSaGmrX
        x5k6iDTKUQ+yTcbCAphn4BBypI+8/UEaArPvsDns/Q==
X-Google-Smtp-Source: AHgI3IZZTNYgAINQjN5UY74xFc7tfqnfx4qlxqofjUogfZHRC+KzRz00Wev6YrlZdLdS/bn+sBaI+BtVw8u87ZNoWYc=
X-Received: by 2002:a24:9795:: with SMTP id k143mr1689999ite.74.1549978199784;
 Tue, 12 Feb 2019 05:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20190201094736.32057-1-brgl@bgdev.pl> <20190201094736.32057-11-brgl@bgdev.pl>
 <20190212121745.GE25613@amd>
In-Reply-To: <20190212121745.GE25613@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 14:29:49 +0100
Message-ID: <CAMRc=Md57e93vCV+uJ4WSma2AefdN89iWXCyKiY7yLsWFGUihg@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] input: max77650: add onkey support
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

wt., 12 lut 2019 o 13:17 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> Hi!
>
> > +     error =3D device_property_read_string(dev,
> > +                                         "maxim,onkey-mode", &mode_pro=
p);
> > +     if (error)
> > +             mode_prop =3D "push";
> > +
> > +     if (strcmp(mode_prop, "push") =3D=3D 0)
> > +             mode =3D MAX77650_ONKEY_MODE_PUSH;
> > +     else if (strcmp(mode_prop, "slide") =3D=3D 0)
> > +             mode =3D MAX77650_ONKEY_MODE_SLIDE;
> > +     else
> > +             return -EINVAL;
> ...
> > +     onkey->input->name =3D "max77650_onkey";
> > +     onkey->input->phys =3D "max77650_onkey/input0";
> > +     onkey->input->id.bustype =3D BUS_I2C;
> > +     input_set_capability(onkey->input, EV_KEY, onkey->code);
>
> Is EV_KEY correct for mode=3D=3Dslide?
>

Others are not really documented. Does EV_SW stand for switch event?
In that case it would probably be better.

Bart

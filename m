Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE767C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9762D222BD
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMjoJM6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfAEXMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:12:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46534 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfAEXMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:12:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so35246125ljh.13;
        Sat, 05 Jan 2019 15:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tw4oip6EfatkanJXQ0Zx4DwqRQ3BksFdUuwP9ca2DpU=;
        b=HMjoJM6DXZD4whvqrYNLjU7re2GmchIVGIbLdnvHbZNY46DTSaIP2E6QAxvXSH9ykZ
         z+M4bDbIb3AU5PG/lmBmCgI5tGfPfZ8QC+i8iQmTeGkSJ0juOhdScli4t/wr04Y3R506
         kirKnZ3bfJZSqf63uOtrowJpCNXNT2gP7FI8ngq0MS6BMzmiyqE0VTAThqbavn6tB0Pt
         EogMTpTkdqVpMki+vtvlLikSTZkLAuhWcRzUF6H7KcWFrdhtaNJPwuyKYzgR8iWM1z4H
         k3cCbut6jCVroSr8WVkI95ju8N4V1ILCn0MnzM0DLAmuK0C2jaPQHO/HWk1aDnOCvDMa
         FUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tw4oip6EfatkanJXQ0Zx4DwqRQ3BksFdUuwP9ca2DpU=;
        b=aF2PEYRD8OXA65Jz2cQ+D4OS04idYAdoc5wGx68OSwX/hxuiufN4hQl4PHhSNef+sI
         So5Q73ce91L3JU6he5fG1Bv87bLNIoAHAMcVPZJR79xiSyDRkheCfkLnd9oGJgR3vrVi
         oVpfDArwBs0scXZlVw+0NMY6DLCB8TwcZhW5U2MYMxNPXbKNHAnuxSWsg7bU/lPwnyfP
         8xbD27ErPpsTnMvK7reJQ8VfH7y5cFplJFB0zA7WQ2yG8cqqsrKK+Q6fKnGNIzRhc8nK
         WojssiglwXzkUCipE8QvtomowlelplexcnkMyPoX4b1dwQUiVmMUf5WdGxwSAvpNjuKM
         rRJQ==
X-Gm-Message-State: AJcUukd46veAKOboTQo11jrhxSVIJlW7tMSAdGupTQ4n8KChJRhO8AMF
        mtcn+xkRlvFsDBwjU29LADIwjsjor3uuqlQ2vug=
X-Google-Smtp-Source: ALg8bN5xUo+LdE7VBmqXR/655CMeG7upatvXP5ldSVPRoOztsaSLNe1m7ZMtJxKfQhZPeRSUDEYVeU4qksWpau9JwQQ=
X-Received: by 2002:a2e:2d4:: with SMTP id y81-v6mr31641074lje.62.1546729971898;
 Sat, 05 Jan 2019 15:12:51 -0800 (PST)
MIME-Version: 1.0
References: <20190105202659.20198-1-nazgul33@gmail.com> <20190105202659.20198-2-nazgul33@gmail.com>
In-Reply-To: <20190105202659.20198-2-nazgul33@gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sat, 5 Jan 2019 17:12:40 -0600
Message-ID: <CAKdAkRQKnH++VuL37EGBaFSMmFPvbpCkVkZLwuMU9eWo+KsaXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: rotary_encoder - Support key events
To:     Donghoon Han <nazgul33@gmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Daniel Mack <daniel@caiaq.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 2:27 PM Donghoon Han <nazgul33@gmail.com> wrote:
>
> From: Steven Han <nazgul33@gmail.com>
>
> Support generating EV_KEY pair, instead of EV_REL.
>
> Signed-off-by: Donghoon Han <nazgul33@gmail.com>
> ---
>  drivers/input/misc/rotary_encoder.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index 72eee6d55527..180e35884289 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -41,6 +41,8 @@ struct rotary_encoder {
>         u32 steps;
>         u32 axis;
>         bool relative_axis;
> +       bool relative_keys;
> +       u32 keycodes[2];
>         bool rollover;
>         enum rotary_encoder_encoding encoding;
>
> @@ -79,6 +81,10 @@ static void rotary_encoder_report_event(struct rotary_encoder *encoder)
>         if (encoder->relative_axis) {
>                 input_report_rel(encoder->input,
>                                  encoder->axis, encoder->dir);
> +       } else if (encoder->relative_keys) {
> +               u32 keycode = encoder->keycodes[encoder->dir > 0];
> +               input_event(encoder->input, EV_KEY, keycode, 1);

You need input_sync() here.

> +               input_event(encoder->input, EV_KEY, keycode, 0);
>         } else {
>                 unsigned int pos = encoder->pos;
>
> @@ -237,6 +243,16 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>         device_property_read_u32(dev, "linux,axis", &encoder->axis);
>         encoder->relative_axis =
>                 device_property_read_bool(dev, "rotary-encoder,relative-axis");
> +       encoder->relative_keys =
> +               device_property_read_bool(dev, "rotary-encoder,relative-keys");
> +       if (encoder->relative_keys) {
> +               err = device_property_read_u32_array(dev,
> +                                       "rotary-encoder,relative-keycodes",
> +                                       encoder->keycodes, 2);
> +               if (err)
> +                       dev_err(dev, "unable to get keycodes: %d\n", err);
> +               return err;
> +       }
>
>         encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
>         if (IS_ERR(encoder->gpios)) {
> @@ -260,9 +276,12 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>         input->id.bustype = BUS_HOST;
>         input->dev.parent = dev;
>
> -       if (encoder->relative_axis)
> +       if (encoder->relative_axis) {
>                 input_set_capability(input, EV_REL, encoder->axis);
> -       else
> +       } else if (encoder->relative_keys) {
> +               input_set_capability(input, EV_KEY, encoder->keycodes[0]);
> +               input_set_capability(input, EV_KEY, encoder->keycodes[1]);
> +       } else
>                 input_set_abs_params(input,
>                                      encoder->axis, 0, encoder->steps, 0, 1);
>
> --
> 2.17.1
>

Thanks.

-- 
Dmitry

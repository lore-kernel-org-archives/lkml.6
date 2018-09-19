Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C5120673
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM2g/MqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C5120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeISJkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 05:40:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44687 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbeISJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 05:40:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id g24-v6so3817540lfb.11;
        Tue, 18 Sep 2018 21:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aG7ZklE/LQJ/WhEnFh6VPV+D9L0jQ1iZ3dCHA2GNV/o=;
        b=mM2g/MqC2LH2/KpZBTv5e0zHNLiYw9GlznNNpwjlST6gBkKN8wReT5F07ivtbhZuF+
         8L70H5AM3/Ko6WJ/iKBgsUFS0q5TIJpqvP12izQWEaxg/9TCHRYGIeR1ckEye+uwJUNE
         hzQoWrxNzkoaDzYSs4pVq0ma63XVpmbnB+LxTfJ1+7MjxuuB/icHYfquSG3/R1WFOY67
         MhUZHeD28dEDeXVkFdHhX+SEnWMuDfUAQ99ymzEO60D4ajsCbLGGMwsA0h4H6clUiZtf
         VRYSjjmMnwMhLYFfGk/1C3ajob1gWYS+fJ1xCx5vuSxeYCcSpqJOgQ9HosQba6FlL3gC
         mzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aG7ZklE/LQJ/WhEnFh6VPV+D9L0jQ1iZ3dCHA2GNV/o=;
        b=XTJnUu1ZJUExcfjLOlwZ/MFaWo2MIPgy5jgTjTsp1gdmw/P1vTFI7so9pTxNjqE/El
         C8r1FnRuhVmwUPZS9iZkDBQHLXQYSbXr0JXCS86PSx6R2Eyj19MhtT8/3NGTEHU2+yzF
         08eOwG9NR3PL6Qy2k6Cwx1wDz4cY9MgihclsGQ6iGjW3a3ji/QTrV6u195VGe+9v9jUu
         wZyh0okpgPXqPWA0yC8BtxXGwlQ5b2z2Qx/qog0hY5Z7fkYQRLl/0lfqvjXgE5rd6uXc
         froimv8YnTOQMvtNVCU6yTpu7sVOX7/8pGcf/ctUs5RL3lQEZT3Omr1FnY6MlPfHQGr0
         3MqA==
X-Gm-Message-State: APzg51DtTC63BPQ2xRnZsYHB9JPUOAUVTt1f5mxjVxznTS7kQWVSzYsk
        /DPIdkm/7+LWqbWLYNBYd+nuirOI4vZFAcfOCZl+Yg==
X-Google-Smtp-Source: ANB0VdaCUTXvZCfCliyJUj6DRqZTmmhjG9aQoTcZFN8gW0x32PXCTYCFobFak690Btr+U89rvTCRlgczG5m6jJo8uSc=
X-Received: by 2002:a19:4e51:: with SMTP id c78-v6mr7568287lfb.79.1537329873893;
 Tue, 18 Sep 2018 21:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com> <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
In-Reply-To: <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 19 Sep 2018 06:04:17 +0200
Message-ID: <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Timur Tabi <timur@codeaurora.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus
On Wed, Sep 19, 2018 at 12:40 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Sep 14, 2018 at 12:08 AM Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
>
> > Current code assumes that the direction is input if direction_input
> > function is set.
> > This might not be the case on GPIOs with programmable direction.
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> >  drivers/gpio/gpiolib.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index a57300c1d649..af853749e0bb 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -1352,7 +1352,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
> >                  * it does, and in case chip->get_direction is not set, we may
> >                  * expose the wrong direction in sysfs.
> >                  */
> > -               desc->flags = !chip->direction_input ? (1 << FLAG_IS_OUT) : 0;
> > +               if (chip->get_direction)
> > +                       desc->flags = !chip->get_direction(chip, i) ?
> > +                                       (1 << FLAG_IS_OUT) : 0;
> > +               else
> > +                       desc->flags = !chip->direction_input ?
> > +                                       (1 << FLAG_IS_OUT) : 0;
>
> We used to do this.
>
> But it breaks Qualcomm hardware.

And should't that be tacked in qcom hardware with something like:

if (!priv->initialized)
   return INPUT;

if you or Timur point me to the harware that was crashing I would not
mind looking into that, but the current situations seems to me like a
hack.

Other option would be to implement a new function get_direction_fast()
(the name could be better). I can also try to implement something in
that direction if you want.

Thanks for your review.

>
> commit 1ca2a92b2a99323f666f1b669b7484df4bda05e4
> Author: Timur Tabi <timur@codeaurora.org>
> Date:   Wed Dec 20 13:10:31 2017 -0600
>
>     Revert "gpio: set up initial state from .get_direction()"
>
>     This reverts commit 72d3200061776264941be1b5a9bb8e926b3b30a5.
>
>     We cannot blindly query the direction of all GPIOs when the pins are
>     first registered.  The get_direction callback normally triggers a
>     read/write to hardware, but we shouldn't be touching the hardware for
>     an individual GPIO until after it's been properly claimed.
>
>     Signed-off-by: Timur Tabi <timur@codeaurora.org>
>     Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij



-- 
Ricardo Ribalda

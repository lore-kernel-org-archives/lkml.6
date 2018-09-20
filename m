Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1577BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B575521522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzDcdiZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B575521522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbeIUE3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:29:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46885 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeIUE3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:29:46 -0400
Received: by mail-io1-f67.google.com with SMTP id y12-v6so10130230ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHBMzyPVooT0K4jfAi0xUUuEwdC0fjEtDr2esA8PRPQ=;
        b=CzDcdiZU2VV0pA2siNvNj5IExiuC9FgLGCc72D/zBlN5+MJIzyNgwVg5j6GS6IyFA/
         3K2zydkGupDHtuaXNZVXtbyuiPdHNRxYv9J2Ze1i1IXAdg2p8UZEzt/T+A2gBMGsybgp
         egI5nxCVvOQ8IG4Oa4tP2YZtR9uR/SXVJQzDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHBMzyPVooT0K4jfAi0xUUuEwdC0fjEtDr2esA8PRPQ=;
        b=XNZgZSfLSrFsVoMwb+dHysoB+KuaNfkjhoXYw8e6Q7xg5ytcKRIaEyKBPZaeWAYVB2
         dZWurGWquIZPdbnzQGWAsNexd+KwjgIlCAp4GprqTdmexwJU8Afy5wNtdIg7dOVaYZ9Y
         ln9eeGO++/hvNM6ApF9QjRNzZdFnJWdQusdtZa940Fd4uMJBSkzfjUU2lTtk2Vm2LqMI
         Tv7SK5eCQ5xrGJ9SjVld3KmxJxevOJW3de0gCBl7Vbc+BTnUC3At5FuBxJhqvJlszCfL
         TuoMmcZIOTKUOSr1268q8cAGPZX4vLQfHGsLIO/sQzc7g1E7htlrUwuUHRyMyRXffpfs
         Kaow==
X-Gm-Message-State: APzg51Aig18doZExbtp5yJ6pdKvcEvkjq68EQ/242yGM1YNgksGFZ7b5
        Bu1TJ7bM3rVhpBTrY8p1E3Y8/7Lx0OicKlLUT/g8D09f
X-Google-Smtp-Source: ANB0VdZsgzOWcAzaO2OBYt7nC/2cydeMahvBF1TDTErmmJBaJ9U9I2CdQwGgoecDScheVwX9Jo6YPqwjaTdWHDOAL2g=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr36728350jab.113.1537483439749;
 Thu, 20 Sep 2018 15:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com> <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
 <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
 <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org> <CAPybu_39xtDfoHVo2dv2GZcU5hCQYjBpU7tW2hf3vfUwbUK1mQ@mail.gmail.com>
 <015715f7-64bc-aca6-77fe-68ddb6c938a8@kernel.org> <CAPybu_2ovB3T1fOD2gP9rM46z37WVuOuzu5FyKamfyMWoVg=yw@mail.gmail.com>
In-Reply-To: <CAPybu_2ovB3T1fOD2gP9rM46z37WVuOuzu5FyKamfyMWoVg=yw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 15:43:46 -0700
Message-ID: <CACRpkdYHJT+C+M3wBr-zR=O9DYM4uVMqprCW8gXSiTMPJhzFnQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Timur Tabi <timur@tabi.org>, Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 7:14 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> On Thu, Sep 20, 2018 at 2:20 PM Timur Tabi <timur@tabi.org> wrote:

> > Users are expected to program the direction for every GPIO they want to
> > use, regardless of whatever it's set to before they open it.
>
> I do not agree that the user should program the direction of a GPIO
> which direction cannot be used.
>
> Also I am not talking about programming a gpio, I am talking about an
> technician  connecting portA to portB and burning something because
> the system provided erroneous information

So what is clear is that your need, I guess in userspace, reliable
information about the direction of the GPIOs at boot.

> > Because calling that API before properly claiming the GPIO is a
> > programming error.
>
> Is there a place where this API is defined?. Which functions require
> to be defined.? What is the correct order.?

There is nothing like such. We would have to establish semantics.
I don't see a point in it, the APIs are for using and understanding,
not for discussing API contracts. I would avoid trying to etch this
API in stone.

> > The reason why the Qualcomm driver is impacted the most is because on
> > ACPI platforms, the GPIO map is "sparse".  That is, not every GPIO
> > between 0 and n-1 actually exists.  So reading a GPIO that doesn't exist
> > is invalid.
>
> Why are we adding GPIOs that are invalid?
> If you can figure out that a GPIO is invalid when the user claims a
> gpio, you can also figure it out when the user asks the direction.

Right and that is what the (later introduced) valid_mask
can do.

Any time we call into any of the callbacks that take an offset
we should (theoretically) check the .valid_mask if active.

Since we normally check it when requesting the GPIO, we
can't request invalid GPIOs and normally the other callbacks
would only get called after that, so we are fine.

> > I'm not sure how to properly fix this, but I wonder if we need some kind
> > of late-stage initialization where gpiolib scans all the GPIOs by
> > claiming them first, reading the directions, and then releasing them.
>
> That sounds like a good compromise. Or returning
> -unconfigured / unknown
>
> is also an option.

I would just skip over anything asked off in the valid_mask.

I feel positive of a version of this patch that respect valid_mask
some way, as that should be safe for Qualcomms usecase.

Rough consensus and running code.

Yours,
Linus Walleij

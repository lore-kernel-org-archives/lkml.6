Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0302F21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoak9Qjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0302F21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbeITT6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:58:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34754 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731135AbeITT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:58:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id c29-v6so8507278lfj.1;
        Thu, 20 Sep 2018 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiyLY3ALCmYS6qiy3KHOypSF+vn0DsegDCdhxdPg5hM=;
        b=Hoak9QjnGJUWKDjtijvLSm2czzl0EamP05kTfejlsOw1Zdqq5zbvKyh5ZBPlIr2TRK
         GzNmIFeOLw5dvDwIcJAtXtfG8Gztx36OiVP+oW8RglTXjhEFuS7CN3Aop1FphqLHPyPD
         WTsSIYIifLSMBoq30ZNP1gY1impBSuV3q607DL+23xHGNFVoMx47qjZDje9xE2lLRU+t
         ade5ryQPT461y8aTs+0BnBbyfSlloVxAksjyYCR93vGZyHHqgCqveQDOPrwELPPHe/B6
         b0INdG7J7MZyOCoGxRKHN+qWElKXy6U747FYjQvyEdXmiLRGP+5ma/bym7wbDJDfGaQi
         pEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiyLY3ALCmYS6qiy3KHOypSF+vn0DsegDCdhxdPg5hM=;
        b=gYJ+opNGTEgyfsIMZFTfhr6o/qVauFE+0VKYIz5B/d0B2g4RoSaF5AO3o12S88oCqS
         HRh91Jsj2xjurpA4bXDJjNUJ37DINl5t8AStap2GHJgTqQkUZr2Nas3uKHy+U2ku7bd3
         xYH4coEflJy8awEfEAFfHVFeDrNbPTAfc3MP+uBUam/R67UcjZWTTugbsDNW+hHX1vCK
         mptTxBAMwC+2UgKW32rI9O/xXrZA2GY0PJShtpx4GdcaO2Fb0pAxPUAI60FF7M+Lqhea
         1Lqt7kIRJCHgUEAf/wbtNFyvYI0DrRO2GEBNcARllPL9X5h/kaB7qMxlc/ZeIyAJqm+s
         O5EQ==
X-Gm-Message-State: APzg51DMTMuPQF1LF6CM2sJyzPqQbjC4Zw5VodZnVBGwkjpq7y/lUnV8
        MV/HRFNRP7pXeGha/zX35Sb7deLWI077lSWSAEw=
X-Google-Smtp-Source: ANB0VdZC3UjY7PKzQ2MXtdXKO9jrilCbuvGbfuu/ArfCCgObVw8QoPCtUw3XtVmHvznymAwH4/XQtfMnUbrwhKri1eM=
X-Received: by 2002:a19:2287:: with SMTP id i129-v6mr26320748lfi.20.1537452856871;
 Thu, 20 Sep 2018 07:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com> <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
 <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
 <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org> <CAPybu_39xtDfoHVo2dv2GZcU5hCQYjBpU7tW2hf3vfUwbUK1mQ@mail.gmail.com>
 <015715f7-64bc-aca6-77fe-68ddb6c938a8@kernel.org>
In-Reply-To: <015715f7-64bc-aca6-77fe-68ddb6c938a8@kernel.org>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 20 Sep 2018 16:14:00 +0200
Message-ID: <CAPybu_2ovB3T1fOD2gP9rM46z37WVuOuzu5FyKamfyMWoVg=yw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     timur@tabi.org
Cc:     Linus Walleij <linus.walleij@linaro.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Thu, Sep 20, 2018 at 2:20 PM Timur Tabi <timur@tabi.org> wrote:
>
>
>
> On 09/19/2018 10:27 AM, Ricardo Ribalda Delgado wrote:
> > Let me explain my current setup
> >
> > I have a board with input and output gpios, the direction is defined
> > via pdata. When I run gpioinfo all the gpios are shown as input,
> > regardless if they are input or outputs: Eg:
> >
> > root@qt5022:/tmp# ./gpioinfo
> >
> > gpiochip0 - 16 lines:
> >          line   0:     "PROG_B"       unused   input  active-high
> >          line   1:         "M0"       unused   input  active-high
> >          line   2:         "M1"       unused   input  active-high
> >          line   3:         "M2"       unused   input  active-high
> >          line   4:        "DIN"       unused   input  active-high
> >          line   5:       "CCLK"       unused   input  active-high
> >          line   6:      unnamed       unused   input  active-high
> >          line   7:      unnamed       unused   input  active-high
> >          line   8:       "DONE"       unused   input  active-high
> >          line   9:     "INIT_B"       unused   input  active-high
> >          line  10:      unnamed       unused   input  active-high
> >          line  11:      unnamed       unused   input  active-high
> >          line  12:      unnamed       unused   input  active-high
> >          line  13:      unnamed       unused   input  active-high
> >          line  14:      unnamed       unused   input  active-high
> >          line  15:      unnamed       unused   input  active-high
>
> Yes, this is a known problem that should be fixed.
>
> > That is wrong and very confusing to the user, it can also lead to a
> > mayor fuckup if the user decides to connect two output gpio pins
> > because he expects that both are input. (This is the programming port,
> > but I also have 24 V -high current GPIOs)
>
> Users are expected to program the direction for every GPIO they want to
> use, regardless of whatever it's set to before they open it.

I do not agree that the user should program the direction of a GPIO
which direction cannot be used.

Also I am not talking about programming a gpio, I am talking about an
technician  connecting portA to portB and burning something because
the system provided erroneous information

>
> > There is a function in the API to tell libgpio if a gpio is out our
> > in. Why not use it?
>
> Because calling that API before properly claiming the GPIO is a
> programming error.

Is there a place where this API is defined?. Which functions require
to be defined.? What is the correct order.?

>
> > - If the configuration is hardcoded, the driver will return a fixed value
> > - If it is cheap to query the hardware, the driver will query the hardware,
> > - If it is expensive to query the hardware the driver can either
> > return a cached value or a fake value (current situation)
>
> The reason why the Qualcomm driver is impacted the most is because on
> ACPI platforms, the GPIO map is "sparse".  That is, not every GPIO
> between 0 and n-1 actually exists.  So reading a GPIO that doesn't exist
> is invalid.

Why are we adding GPIOs that are invalid?
If you can figure out that a GPIO is invalid when the user claims a
gpio, you can also figure it out when the user asks the direction.

>
> The way to protect against that is to claim the GPIO first.  If the
> claim is rejected, then you know that you can't access that GPIO.
>
> The bug is that the original code that I deleted (and that you're trying
> to put back) doesn't claim the GPIO first.
>
> >>From my point of view:  "The get_direction callback normally triggers
> > a  read/write to hardware, but we shouldn't be touching the hardware
> > for   an individual GPIO until after it's been properly claimed." is
> > an statement specific for your platform and should be fixed in your
> > driver.
> >
> > Either that, or I have completely missunderstund the purpouse of gpiod
> > :), and that could easily be the case.
>
> It's not a platform-specific statement.  It applies to all drivers.  In
> some drivers, the get_direction function had side-effects (like
> programming muxes, IIRC) that no one really cared about but was
> technically wrong.

A get operation should not set any functionality..., it should return
a cached value or query safely the hardware.


>
> I'm not sure how to properly fix this, but I wonder if we need some kind
> of late-stage initialization where gpiolib scans all the GPIOs by
> claiming them first, reading the directions, and then releasing them.

That sounds like a good compromise. Or returning
-unconfigured / unknown

is also an option.


-- 
Ricardo Ribalda

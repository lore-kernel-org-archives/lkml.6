Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A1C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37E727710
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VNTShMS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37E727710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbeF1ROc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:14:32 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39081 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbeF1ROa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:14:30 -0400
Received: by mail-pg0-f68.google.com with SMTP id n2-v6so2746668pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=A4DwkjOJqZ4R2siFa8JJmjPaGctY6zFgF4vALhmYmvA=;
        b=VNTShMS1+gwaZWR0j8igiiUK03D40rZa/j06qx1/aYcLKb8k/OcFseymbThSLCSxVA
         hv5CR/kloPFpRvvFR5reqeuQRIZPTXgaRlfWrYKHWWEifNQ6Md3++65hsM76W1KmJkej
         IAJk9vnUxsgOEm2rT0hqO34E6fvkIGYYtaRJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=A4DwkjOJqZ4R2siFa8JJmjPaGctY6zFgF4vALhmYmvA=;
        b=Lzt95r2kvtO427iYtKDctHkoqjVOLzSlpcPUOT61U3FTIPhPq0n4Jz6hpJRcP02r/J
         qbPSeE2Q4vKEwXs83cUvrqx8FRWhTuD7H3fDB8tDtrfcfCRjcPyit1AMtkxP9JJ84HtE
         WPb1MEqKGb0AZWV1EDFCk0oghCuaX4QDggK22SUwtfPY4IIrEfvZQn9r+C7UNxnfCWND
         EtFnX2sqFip6WvDJyPHAH1JxnPu4kLtGGffXJp3YAg21GCacu95IclnteBrPcaOAsPct
         SsikNfFWiBm5YPStrI1m0jI15+6TMRmiJS5WNqD4jrWtnEOOON4n0vVfpGBvVnb8Qx7/
         1zCw==
X-Gm-Message-State: APt69E2dXwk7nWk7SskO+s6jbPyRfIJi3VCkFZmON3lc0FMdX1KUMV5W
        EQuAwUUS2oncwgcvFnsGDBpQwg==
X-Google-Smtp-Source: AAOMgpcHVu9UT4FoPYP3lNhwDEuTbsiVR0qDNDVrhV2B+eyKtpYvrWgRv2NxiPWPuzBOAr8Cl+GYyQ==
X-Received: by 2002:a62:ed13:: with SMTP id u19-v6mr10969573pfh.125.1530206070174;
        Thu, 28 Jun 2018 10:14:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id h26-v6sm8075691pfj.77.2018.06.28.10.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 10:14:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CACRpkdZr5tKCjyO6Eq2vPPE8Lg+m+Ky_f24wYBSiLjdZuQ4WwA@mail.gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-3-swboyd@chromium.org>
 <20180622175836.GC3402@tuxbook-pro> <20180622183129.GD3402@tuxbook-pro>
 <CACRpkdZr5tKCjyO6Eq2vPPE8Lg+m+Ky_f24wYBSiLjdZuQ4WwA@mail.gmail.com>
Message-ID: <153020606866.143105.1849265284764230975@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
Date:   Thu, 28 Jun 2018 10:14:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Walleij (2018-06-28 07:25:46)
> On Fri, Jun 22, 2018 at 8:29 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > On Fri 22 Jun 10:58 PDT 2018, Bjorn Andersson wrote:
> > > On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:
> > >
> > > > We rely on devices to use pinmuxing configurations in DT to select =
the
> > > > GPIO function (function 0) if they're going to use the gpio in GPIO
> > > > mode. Let's simplify things for driver authors by implementing
> > > > gpio_request_enable() for this pinctrl driver to mux out the GPIO
> > > > function when the gpio is use from gpiolib.
> > > >
> > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > >
> > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> (...)
> > While both patch 2 and 3 are convenient ways to get around the annoyance
> > of having to specify a pinmux state both patches then ends up relying on
> > some default pinconf state; which I think is bad.

What default state are we relying on? The reset state of the pins? I'm
very confused by this statement. These last two patches are making sure
that when a GPIO is requested as a GPIO or IRQ, it's really in GPIO
mode. If this code is not in place, then we'll allow drivers to request
a GPIO but pinmuxing won't be called to actually mux that pin to GPIO
mode unless they have a DT conf for function =3D "gpio". That seems
entirely unexpected and easy to mess up.

> =

> Nothing stops you from setting up a default conf in
> this callback though.
> =

> But admittedly this call was added for simpler hardware.
> =

> > Further more in situations like i2c-qup (downstream), where the pins are
> > requested as gpios in order to "bitbang" a reset this would mean that
> > the driver has to counter the convenience; by either switching in the
> > default pinmux at the end of probe or postponing the gpio_request() to
> > the invocation of reset and then, after issuing the gpio_release,
> > switching in the default pinmux explicitly again.
> =

> That's a bigger problem. If the system is using device and GPIO
> mode orthogonally, it'd be good to leave like this.
> =


Doesn't that driver need to explicitly mux GPIO mode vs. device mode
right now? So having gpio_request() do the muxing to GPIO mode and then
explicit muxing of the pin to device mode would be what we have after
this patch, while before this patch we would have mux to GPIO, request
GPIO (nop), mux to device. We saved an explicit pinmux call?


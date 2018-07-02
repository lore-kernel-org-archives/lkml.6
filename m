Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99A1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5766824C21
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWYuBzf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5766824C21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeGBTG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:06:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39298 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeGBTGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:06:53 -0400
Received: by mail-pg0-f66.google.com with SMTP id n2-v6so7541494pgq.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JuYMSuLSg6zzvU9B55c+OQn2fOdl9ZANQ0iB3ltSwdE=;
        b=MWYuBzf8k6NYpu27agMccRsdV79aJagcHJngBXRQimOmn7ZjX3s/G7kzfxvxcDRQsn
         BGTF27opoNceMKKzRZ66U94BsGqt9KCFPlHRmOZZ6BlnHVO2OgfJA7TA3zTr4bbt8kXY
         chBeFWX17yFojxo65twQxVarKkYZNd0hTRWAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JuYMSuLSg6zzvU9B55c+OQn2fOdl9ZANQ0iB3ltSwdE=;
        b=i/TzgFHNoo6POjP+2f7ErUI02KEVLs7BfWCy3A/pDCawxF9vF/+BrythFUIJFp/Y6U
         XuOJpu3ttUuz6IOwV7Lc9Qdwh9J0+HeCSqzsFEzaAcxsXD80mPDiOkQecYwQKQ1pcSBd
         9Mh5pfumN5qVFZbQYgoNzc3Dl5Kot0puAwMTPH7Yh64oqGyMB+8FCGH2R0/CVBqC6IXX
         LGHUv50pmgMcUOruN7YKqFbbvBvmEqQhT/nGaqd3NsKwyHSBMcP0YXsKOtTIgVFU0fC4
         PvYdlSclrurmsVSOmpv7skZ0aigbgJjnUNlDlhBTll/kFojsJRBSYlDEy8S6DV9ym/TX
         VRDw==
X-Gm-Message-State: APt69E2mOW1F/xauMrHPBAvifS8ad8AbHtiNlVzHFWQik6eA0KrqPgzT
        4mbycTFkMjD4J9zndcX4glqmgDvgVFg=
X-Google-Smtp-Source: AAOMgpc9ahWV7rDSbeazPyDMmurOKxCYkNsXh1rSDW7C2fYGkFn6U+7VxULbVy1DaMIB4kmZsT3yKg==
X-Received: by 2002:a62:2c46:: with SMTP id s67-v6mr26079811pfs.153.1530558412884;
        Mon, 02 Jul 2018 12:06:52 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b22-v6sm25023937pfi.144.2018.07.02.12.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 12:06:52 -0700 (PDT)
Date:   Mon, 2 Jul 2018 12:09:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with
 gpio_request()
Message-ID: <20180702190922.GE2050@tuxbook-pro>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-3-swboyd@chromium.org>
 <20180622175836.GC3402@tuxbook-pro>
 <20180622183129.GD3402@tuxbook-pro>
 <CACRpkdZr5tKCjyO6Eq2vPPE8Lg+m+Ky_f24wYBSiLjdZuQ4WwA@mail.gmail.com>
 <153020606866.143105.1849265284764230975@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153020606866.143105.1849265284764230975@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28 Jun 10:14 PDT 2018, Stephen Boyd wrote:

> Quoting Linus Walleij (2018-06-28 07:25:46)
> > On Fri, Jun 22, 2018 at 8:29 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > > On Fri 22 Jun 10:58 PDT 2018, Bjorn Andersson wrote:
> > > > On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:
> > > >
> > > > > We rely on devices to use pinmuxing configurations in DT to select the
> > > > > GPIO function (function 0) if they're going to use the gpio in GPIO
> > > > > mode. Let's simplify things for driver authors by implementing
> > > > > gpio_request_enable() for this pinctrl driver to mux out the GPIO
> > > > > function when the gpio is use from gpiolib.
> > > > >
> > > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > >
> > > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > (...)
> > > While both patch 2 and 3 are convenient ways to get around the annoyance
> > > of having to specify a pinmux state both patches then ends up relying on
> > > some default pinconf state; which I think is bad.
> 
> What default state are we relying on? The reset state of the pins? I'm
> very confused by this statement. These last two patches are making sure
> that when a GPIO is requested as a GPIO or IRQ, it's really in GPIO
> mode.

Yes and this is convenient, as the TLMM is both multiplexor and gpio
controller this is probably what people would expect. However looking at
the downstream code people don't think this way (i.e. many drivers calls
gpio_request() to get some sort of exclusive access to its pins - not
to request gpio to be the muxed function).

But my concern is related to pinconf, not pinmux - automating pinmuxing
doesn't change the fact that the systems integrator should make sure to
configure appropriate pull properties on the pins.

> If this code is not in place, then we'll allow drivers to request
> a GPIO but pinmuxing won't be called to actually mux that pin to GPIO
> mode unless they have a DT conf for function = "gpio". That seems
> entirely unexpected and easy to mess up.
> 

I do agree with this, but the opposite doesn't feel crystal clear
either.

> > 
> > Nothing stops you from setting up a default conf in
> > this callback though.
> > 
> > But admittedly this call was added for simpler hardware.
> > 
> > > Further more in situations like i2c-qup (downstream), where the pins are
> > > requested as gpios in order to "bitbang" a reset this would mean that
> > > the driver has to counter the convenience; by either switching in the
> > > default pinmux at the end of probe or postponing the gpio_request() to
> > > the invocation of reset and then, after issuing the gpio_release,
> > > switching in the default pinmux explicitly again.
> > 
> > That's a bigger problem. If the system is using device and GPIO
> > mode orthogonally, it'd be good to leave like this.
> > 
> 
> Doesn't that driver need to explicitly mux GPIO mode vs. device mode
> right now? So having gpio_request() do the muxing to GPIO mode and then
> explicit muxing of the pin to device mode would be what we have after
> this patch, while before this patch we would have mux to GPIO, request
> GPIO (nop), mux to device. We saved an explicit pinmux call?
> 

It's currently possible to call gpio_request() in the i2c driver's probe
function and then mux when needed. With this patch you would have to
either follow the gpio_request with a mux-to-default or defer the
gpio_request until the point where they today would have an explicit
mux-to-gpio.

Regards,
Bjorn

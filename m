Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C596C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9AC23C72
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fk2cFILg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9AC23C72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbeGFRXl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:23:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37821 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933756AbeGFRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:23:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id h20-v6so8958892pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=wxnuWBZfv4yb+LFnf4LOFa+1tsKUWx+z3EsV1YGIa5s=;
        b=Fk2cFILgceb38Aoa3nE0qqlk9ZFqbsOTtMXVGetBYxAyKbxKwYX2S13za2Wd6iTmcv
         i+TN7UDMDgOYtwbimP4QnxVdCZadYQJsLdJmq/ZsAXrqHvS1DN2PDWOGCveUKk8NFt8o
         da3qzo0UtXSFy/bAQRDB9VkvmZZkED6eEq56c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=wxnuWBZfv4yb+LFnf4LOFa+1tsKUWx+z3EsV1YGIa5s=;
        b=qLrGepM19BCCK8Yzj5rNYrKCO/ngIr4K8eb0eqWOCRCXneueOyFhUSFn9sKU3+XTKM
         kF/zKAo1CjH6wYgVPvqoynCQvuf10Mbr/Kmnrgg1cvaezuzvNvTMZC2p8qtJ2dSXniMD
         WxpBVKxWGeyXBeN9IaJD2Cv8+z7woFEUnvdTa98flQEYYMF0sAukGuchqEI7aojxOABC
         /XORmcFWfsiK2YY0ywIbPzs1rnW+x9JYwKi3MziR994gZb+Qsf671M0z4PvVM1cGh96Y
         ocCEGcgFN9Sz9TTLG0VOGmF7OA60IOm7APiYtbzPaXAagqK5IQ5rjN416P/ZzFcvIr4z
         9ZSg==
X-Gm-Message-State: APt69E2vN63ja421relGPG2tFZx/eD6nrJ42V8QExVCFxKmdb0Yhi/cC
        tHdVNFGH0fQ6Pee3AnC84K8+Jw==
X-Google-Smtp-Source: AAOMgpd7R/frWec9RsGnzV6X0+7KPK2DOtXmOV9Sv39yIKTwykDT+Xi0T8rvkBsf3cjLTPOxQKjqSA==
X-Received: by 2002:a62:404e:: with SMTP id n75-v6mr7867244pfa.232.1530897816233;
        Fri, 06 Jul 2018 10:23:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id j23-v6sm15541847pfh.45.2018.07.06.10.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:23:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180702190922.GE2050@tuxbook-pro>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-3-swboyd@chromium.org>
 <20180622175836.GC3402@tuxbook-pro> <20180622183129.GD3402@tuxbook-pro>
 <CACRpkdZr5tKCjyO6Eq2vPPE8Lg+m+Ky_f24wYBSiLjdZuQ4WwA@mail.gmail.com>
 <153020606866.143105.1849265284764230975@swboyd.mtv.corp.google.com>
 <20180702190922.GE2050@tuxbook-pro>
Message-ID: <153089781482.143105.8344344693689942706@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
Date:   Fri, 06 Jul 2018 10:23:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-07-02 12:09:22)
> On Thu 28 Jun 10:14 PDT 2018, Stephen Boyd wrote:
> =

> > Quoting Linus Walleij (2018-06-28 07:25:46)
> > > On Fri, Jun 22, 2018 at 8:29 PM Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > > On Fri 22 Jun 10:58 PDT 2018, Bjorn Andersson wrote:
> > > > > On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:
> > > > >
> > > > > > We rely on devices to use pinmuxing configurations in DT to sel=
ect the
> > > > > > GPIO function (function 0) if they're going to use the gpio in =
GPIO
> > > > > > mode. Let's simplify things for driver authors by implementing
> > > > > > gpio_request_enable() for this pinctrl driver to mux out the GP=
IO
> > > > > > function when the gpio is use from gpiolib.
> > > > > >
> > > > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > >
> > > > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > (...)
> > > > While both patch 2 and 3 are convenient ways to get around the anno=
yance
> > > > of having to specify a pinmux state both patches then ends up relyi=
ng on
> > > > some default pinconf state; which I think is bad.
> > =

> > What default state are we relying on? The reset state of the pins? I'm
> > very confused by this statement. These last two patches are making sure
> > that when a GPIO is requested as a GPIO or IRQ, it's really in GPIO
> > mode.
> =

> Yes and this is convenient, as the TLMM is both multiplexor and gpio
> controller this is probably what people would expect. However looking at
> the downstream code people don't think this way (i.e. many drivers calls
> gpio_request() to get some sort of exclusive access to its pins - not
> to request gpio to be the muxed function).
> =

> But my concern is related to pinconf, not pinmux - automating pinmuxing
> doesn't change the fact that the systems integrator should make sure to
> configure appropriate pull properties on the pins.

Ok. Pinconf wouldn't change here, and I would expect system integrators
to set pinconfs in their DTS board files like always.

> =

> > > =

> > > Nothing stops you from setting up a default conf in
> > > this callback though.
> > > =

> > > But admittedly this call was added for simpler hardware.
> > > =

> > > > Further more in situations like i2c-qup (downstream), where the pin=
s are
> > > > requested as gpios in order to "bitbang" a reset this would mean th=
at
> > > > the driver has to counter the convenience; by either switching in t=
he
> > > > default pinmux at the end of probe or postponing the gpio_request()=
 to
> > > > the invocation of reset and then, after issuing the gpio_release,
> > > > switching in the default pinmux explicitly again.
> > > =

> > > That's a bigger problem. If the system is using device and GPIO
> > > mode orthogonally, it'd be good to leave like this.
> > > =

> > =

> > Doesn't that driver need to explicitly mux GPIO mode vs. device mode
> > right now? So having gpio_request() do the muxing to GPIO mode and then
> > explicit muxing of the pin to device mode would be what we have after
> > this patch, while before this patch we would have mux to GPIO, request
> > GPIO (nop), mux to device. We saved an explicit pinmux call?
> > =

> =

> It's currently possible to call gpio_request() in the i2c driver's probe
> function and then mux when needed. With this patch you would have to
> either follow the gpio_request with a mux-to-default or defer the
> gpio_request until the point where they today would have an explicit
> mux-to-gpio.
> =


Ok, got it. I don't know if we can do any better though, so the question
is if gpio_request() muxing the pin for gpio operation is matching
driver expectations or not. Also, see my reply to Doug here on the same
topic. The documentation file isn't crystal clear to me. If Linus can
clear things up a bit I think we can all get on the same page.


Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAB6C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD5B272D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="D9fx/1gx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U7KyPWTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD5B272D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967949AbeF1Spf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:45:35 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38150 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966764AbeF1Spd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:45:33 -0400
Received: by mail-ua0-f196.google.com with SMTP id 59-v6so4213507uas.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uBeei+7QGV6/8EU6gqu93YilYvl/dBUq9wjsm62fgKM=;
        b=D9fx/1gxjkv/mfcTBngWb4EpNfr99Rz/ogQ/lCnDDzy3xTGExnCdcn/svgAKUp3vMe
         kM9WKSI/7u6tQQ+KyK1eBcg4NWLLAjyCBjEiAQbXTaoNYt24M3g9l4UPWEt99YYY6128
         lmeAsk2RrJpCUf1erXwYInLCTbDM37hVkOfms+hRifXS5aHr6BRUBaItvvJMe/cBEnZ6
         RzXqc630KvxU11K8MegrMEBmSc3s6m+4OMTS6iqt+/L7LcvndfmCNyXBzwBhrTFwCAle
         VgHtNqK6Xrx9pF8nGF9KiugkMAZcwh3j3R9mgEDCB5HjHbnMvSB2FKlPsf41XpxpdsVj
         4wqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uBeei+7QGV6/8EU6gqu93YilYvl/dBUq9wjsm62fgKM=;
        b=U7KyPWTAnJpGmEyXQlWp5F6XjkUk6gkVuz6SKoiodVev71aMIFtXfjR2GyuREqXNur
         77slOarctU1KMrK+GUkcQG8LjAEyocZMHoR9LeN69D5Ouy7H71WvUAmeOU+USCPEJU+I
         QVe2adrq6CU3P6bapyfc8PrtWMVbcd73AkQGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uBeei+7QGV6/8EU6gqu93YilYvl/dBUq9wjsm62fgKM=;
        b=HKm5xfqaDnl4whpqZV25x2+KgAgPJ5ClXCqOjiRBhf+tZTsctQhvNkzT0ODqzJwzcx
         bqUMD1EvOvsFf4cnhW6MHg5gW5ukTagJKgQacE23NbfLg3MRyEioZJwVmhrdIcTBhu2y
         ukRtkZQbC4W9Y4ThnZXvIzRP/Oeu4asxCWnI73pHcRHPgLLVM8z3Ei6JgUg5arJTrF5m
         9oHypruLM07kEOP80mW949ZfYT/gCBVFaTjZDPYr0vHKwtt9JvMaqZttBC+mnUcI1aQS
         7tzeMUxe7UsXjL8tT/t0eM+egTJb2V1sUgfeHQE34TVrfM0E9Gfjb5H29hdj4e6YKJDT
         IAAg==
X-Gm-Message-State: APt69E3HXx13R1FGb/Mcl64LSnsDgNnN3/Ka/mAfhIFbt+2tOLLrjKrZ
        vIU1e6dtacRvu2gCPOmvDkTNfwKBERVWQ/e7gy0BcsQO
X-Google-Smtp-Source: AAOMgpeqqBkKXximzLhX3nKwKuTmsRn6KgujLMbytZO9e7JpRCF52o/yqYdKGefVzyHGdRJC5qDqe7N0X1NUlMsCGIs=
X-Received: by 2002:ab0:5061:: with SMTP id z30-v6mr7244675uaz.82.1530211531558;
 Thu, 28 Jun 2018 11:45:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 11:45:30
 -0700 (PDT)
In-Reply-To: <153020606866.143105.1849265284764230975@swboyd.mtv.corp.google.com>
References: <20180618205255.246104-1-swboyd@chromium.org> <20180618205255.246104-3-swboyd@chromium.org>
 <20180622175836.GC3402@tuxbook-pro> <20180622183129.GD3402@tuxbook-pro>
 <CACRpkdZr5tKCjyO6Eq2vPPE8Lg+m+Ky_f24wYBSiLjdZuQ4WwA@mail.gmail.com> <153020606866.143105.1849265284764230975@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jun 2018 11:45:30 -0700
X-Google-Sender-Auth: laeRmSc4rbm14CpNPLCW1Wx_nOQ
Message-ID: <CAD=FV=Xmo4p7DbOReO02JVKnykoAOz7PtnkbdwryxvpsgZCgWw@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 28, 2018 at 10:14 AM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Linus Walleij (2018-06-28 07:25:46)
>> On Fri, Jun 22, 2018 at 8:29 PM Bjorn Andersson
>> <bjorn.andersson@linaro.org> wrote:
>> > On Fri 22 Jun 10:58 PDT 2018, Bjorn Andersson wrote:
>> > > On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:
>> > >
>> > > > We rely on devices to use pinmuxing configurations in DT to select the
>> > > > GPIO function (function 0) if they're going to use the gpio in GPIO
>> > > > mode. Let's simplify things for driver authors by implementing
>> > > > gpio_request_enable() for this pinctrl driver to mux out the GPIO
>> > > > function when the gpio is use from gpiolib.
>> > > >
>> > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> > >
>> > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> (...)
>> > While both patch 2 and 3 are convenient ways to get around the annoyance
>> > of having to specify a pinmux state both patches then ends up relying on
>> > some default pinconf state; which I think is bad.
>
> What default state are we relying on? The reset state of the pins? I'm
> very confused by this statement. These last two patches are making sure
> that when a GPIO is requested as a GPIO or IRQ, it's really in GPIO
> mode. If this code is not in place, then we'll allow drivers to request
> a GPIO but pinmuxing won't be called to actually mux that pin to GPIO
> mode unless they have a DT conf for function = "gpio". That seems
> entirely unexpected and easy to mess up.
>
>>
>> Nothing stops you from setting up a default conf in
>> this callback though.
>>
>> But admittedly this call was added for simpler hardware.
>>
>> > Further more in situations like i2c-qup (downstream), where the pins are
>> > requested as gpios in order to "bitbang" a reset this would mean that
>> > the driver has to counter the convenience; by either switching in the
>> > default pinmux at the end of probe or postponing the gpio_request() to
>> > the invocation of reset and then, after issuing the gpio_release,
>> > switching in the default pinmux explicitly again.
>>
>> That's a bigger problem. If the system is using device and GPIO
>> mode orthogonally, it'd be good to leave like this.
>>
>
> Doesn't that driver need to explicitly mux GPIO mode vs. device mode
> right now? So having gpio_request() do the muxing to GPIO mode and then
> explicit muxing of the pin to device mode would be what we have after
> this patch, while before this patch we would have mux to GPIO, request
> GPIO (nop), mux to device. We saved an explicit pinmux call?

After reading these replies I'm slightly worried about some of the
stuff Bjorn is worried about too.  In Bjorn's example I think that the
"default" state of the pins is probably i2c-mode and that it might
switch to GPIO mode only when it needs to do the special unwedge of
the i2c port.

So maybe the i2c driver does this:

1. "Default" pinmux state of i2c is i2c-mode, "unwedge" pinmux state
is gpio-mode.

2. In probe, request the GPIOs for use later in case we need to
unwedge.  Don't use them right now since we don't need to unwedge.
Assumes pinmux state stays as "default".

3. When you decide you need to unwedge the bus, pinmux to the special
i2c mode and drive the pins you requested in probe.  Then pinmux back.


...I think your patch will break this because when you request the
GPIOs you'll have an implicit (and unexpected?) pinmux transition.

What do you think?


NOTE: I think even if we don't want patch #2, we might still want at
least part of patch #3?  It feels like if you request a GPIO as an IRQ
that it should be OK to at least automatically change it to an
input...


-Doug

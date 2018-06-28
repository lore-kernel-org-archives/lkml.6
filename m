Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54E0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F89274F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkJLDRbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F89274F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966577AbeF1O0A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:26:00 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55205 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966544AbeF1OZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:25:58 -0400
Received: by mail-it0-f67.google.com with SMTP id 76-v6so13025225itx.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pIpRE23Jo8lCpy0akrfwdryZmfg17rZQVqrESoRafHs=;
        b=dkJLDRbuObycZ1Q1YuDccxgfxRSxxVlk1Siuo9QNanVnwUrOPoQGZ4kNpgqgoDu5/s
         4ygnL3Gy890wABbXOChwdn98teH24XHM/lT4REvIN6MjB0IbxUpPATv/oUrN6H+z8bR0
         fiDDm/xNku+/RXAs1Fb9DtmP5CWsto0q9xW0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIpRE23Jo8lCpy0akrfwdryZmfg17rZQVqrESoRafHs=;
        b=WulOm91LqTbgveUGDyVH7tvwmcx7BXfiYeI98uBASmWBGMu67kY0Ns6lT6iTXFGDaZ
         tvVfWVNWxjh5vGXEdEXUm7EmMYsiaI/IRJLzRrLW5hAb5nsUuH9JTmsIQUlSLI9EdPmb
         Byux59ASuPjCrb84K1aHVXG6JlKNCyJAHLlVweruRDeZ1XDwJp9ygrcL0zG2NRbPYOwb
         aicuxoevMqbwzN7vbs8x0ozVOrFi9ASRWqW7iih5dVN+EgU12PVTJ8oK2t0GX8phRxHR
         nszrnSB9sjI7TmskjVWN+Q2JJ8ksV0dO4biDJPbRDL+GV7DJ/m9O1+q+jTFq6+D0yHSB
         gQmw==
X-Gm-Message-State: APt69E2/absqprRNUWv/K18hPbqnr7Y2WFOQEkgh6c2uSm3C9YURyV3m
        jKHPInmHlBFuuQ9nnL8Gdw9tc1YnrP9pn8g69bD83Q==
X-Google-Smtp-Source: AAOMgpezOGZvR1GYEYuL+EIc1Jxe9LSYl+bQtUcz/sT4w7dINjvvrE/+oOKv0Qbu9cs8EtA0lNgpptLvRjPiJx9ZV0Y=
X-Received: by 2002:a24:8989:: with SMTP id s131-v6mr8499845itd.70.1530195958224;
 Thu, 28 Jun 2018 07:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180618205255.246104-1-swboyd@chromium.org> <20180618205255.246104-3-swboyd@chromium.org>
 <20180622175836.GC3402@tuxbook-pro> <20180622183129.GD3402@tuxbook-pro>
In-Reply-To: <20180622183129.GD3402@tuxbook-pro>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jun 2018 16:25:46 +0200
Message-ID: <CACRpkdZr5tKCjyO6Eq2vPPE8Lg+m+Ky_f24wYBSiLjdZuQ4WwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 8:29 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Fri 22 Jun 10:58 PDT 2018, Bjorn Andersson wrote:
> > On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:
> >
> > > We rely on devices to use pinmuxing configurations in DT to select the
> > > GPIO function (function 0) if they're going to use the gpio in GPIO
> > > mode. Let's simplify things for driver authors by implementing
> > > gpio_request_enable() for this pinctrl driver to mux out the GPIO
> > > function when the gpio is use from gpiolib.
> > >
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
(...)
> While both patch 2 and 3 are convenient ways to get around the annoyance
> of having to specify a pinmux state both patches then ends up relying on
> some default pinconf state; which I think is bad.

Nothing stops you from setting up a default conf in
this callback though.

But admittedly this call was added for simpler hardware.

> Further more in situations like i2c-qup (downstream), where the pins are
> requested as gpios in order to "bitbang" a reset this would mean that
> the driver has to counter the convenience; by either switching in the
> default pinmux at the end of probe or postponing the gpio_request() to
> the invocation of reset and then, after issuing the gpio_release,
> switching in the default pinmux explicitly again.

That's a bigger problem. If the system is using device and GPIO
mode orthogonally, it'd be good to leave like this.

Yours,
Linus Walleij

Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3516C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD2024CDF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n2q2+KHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD2024CDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754722AbeGCJ5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:57:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51563 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754645AbeGCJ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:57:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so1649163wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hw+7XphhYRlXjNsAWUjVJoncDHOf8u+qmrZ0TxMwF/I=;
        b=n2q2+KHQ2/7wf+xbQy9GgvFO6yop9QvkbVDbY1IDLZlDaFP9AMXV78OVFlvMZO4WYI
         LwfI7dEcH9fFvnivHsFsvzG42LUfZ6zRqWWhlKEWcWeyIScIcYvMzS0JlkQeTBxVF0Aq
         FwTptZpJo0LxuvqvEh9Tycb0xjBSnjEX/Ys/BHtgPUYk2V8QSDrKBaNGGh6G9dddKxrc
         LC6lR9SeBK3t6M0vaSN82sbDpC/fUgrXvFBb3i+GrUvvOcV4HiO8wwo+OO72CSf7x934
         WWEtnVM58wv9id4BdubvC1nvhG/pgF8xorVq+EJoGP7l40Q5S0CXk7e/e8PZnoXjp0JH
         WHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hw+7XphhYRlXjNsAWUjVJoncDHOf8u+qmrZ0TxMwF/I=;
        b=rqKQdKqFyUNKy9Du3UlaCwKfxr+g+ZlAwfWB/eKB4Zh6Kz/QAHEKhraDY4ignYyL7T
         GGBMtvQWl+SCsMmnxGqlad+4AE6T4iT594PUL6TosbIOwZNzIc9RcCYLW5QpB+m4JU9+
         KFz+DNSuV9WGCWcMeEC8BrZ11bNjv+xWdzPI5bcs13iU+CJsPi3K7K4HJ7WErkH7Vlok
         ScYg6K8Cx4zbIGTOiHfi2QzxgcQsblqR92ZISOJbbvjtvPoln85mF2R9oNiDZm9qq32D
         dDLWOhxzG7YQh0zlMvLjh59ZNo7ky7Gitmjh0e+8thZfXseKV5FKL0OXdSPrr3S9kEbS
         O6GQ==
X-Gm-Message-State: APt69E018q6xB4zlHY2gPIaWU1Z+T9NIDiLlPuW5dzQl4SgFG5b8aEEH
        vOeEdj2NOv3KhCCq+AF3bKh5pw==
X-Google-Smtp-Source: AAOMgpctVDQ/bCXNzC7liFZ5Kb05iDJg0QQkOfiWpDOsHldqX7QeNHI7L3Rv0OE6yYXeSW6jjDkPkA==
X-Received: by 2002:a1c:8647:: with SMTP id i68-v6mr10583568wmd.28.1530611860034;
        Tue, 03 Jul 2018 02:57:40 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b15-v6sm901212wri.14.2018.07.03.02.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:57:39 -0700 (PDT)
Message-ID: <1530611858.2900.201.camel@baylibre.com>
Subject: Re: [PATCH v4] clk: add duty cycle support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Jul 2018 11:57:38 +0200
In-Reply-To: <CAMuHMdVTZOS91UUK2zqq019xMPfLUVgDPD8EAWSHntza0-ShVw@mail.gmail.com>
References: <20180619144141.8506-1-jbrunet@baylibre.com>
         <CAMuHMdVTZOS91UUK2zqq019xMPfLUVgDPD8EAWSHntza0-ShVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 11:27 +0200, Geert Uytterhoeven wrote:
> Hi Jerome,
> 
> On Tue, Jun 19, 2018 at 4:42 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > Add the possibility to apply and query the clock signal duty cycle ratio.
> > 
> > This is useful when the duty cycle of the clock signal depends on some
> > other parameters controlled by the clock framework.
> > 
> > For example, the duty cycle of a divider may depends on the raw divider
> > setting (ratio = N / div) , which is controlled by the CCF. In such case,
> > going through the pwm framework to control the duty cycle ratio of this
> > clock would be a burden.
> > 
> > A clock provider is not required to implement the operation to set and get
> > the duty cycle. If it does not implement .get_duty_cycle(), the ratio is
> > assumed to be 50%.
> > 
> > This change also adds a new flag, CLK_DUTY_CYCLE_PARENT. This flag should
> > be used to indicate that a clock, such as gates and muxes, may inherit
> > the duty cycle ratio of its parent clock. If a clock does not provide a
> > get_duty_cycle() callback and has CLK_DUTY_CYCLE_PARENT, then the call
> > will be directly forwarded to its parent clock, if any. For
> > set_duty_cycle(), the clock should also have CLK_SET_RATE_PARENT for the
> > call to be forwarded
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> Thanks for your patch!
> 
> > ---
> > The series has been developed to handled the sample clocks provided by
> > audio clock controller of amlogic's A113 SoC. To support i2s modes, this
> > clock need to have a 50% duty cycle ratio, while it should be just one
> > pulse of the parent clock in dsp modes.
> 
> "one pulse" means num = 1, den = the clock rate, right?

No, it would be num = 1, den = divider 

> 
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -66,6 +68,17 @@ struct clk_rate_request {
> >         struct clk_hw *best_parent_hw;
> >  };
> > 
> > +/**
> > + * struct clk_duty - Struture encoding the duty cycle ratio of a clock
> > + *
> > + * @num:       Numerator of the duty cycle ratio
> > + * @den:       Denominator of the duty cycle ratio
> > + */
> > +struct clk_duty {
> > +       unsigned int num;
> > +       unsigned int den;
> 
> So shouldn't both fields be "unsigned long" instead, to match clock rates?
> (Yes, I do know we don't support +4.3 GHz clock rates on 32-bit yet ;-)

Not sure we need to match clock rates, long seems a bit too much.
In the end, all we want a ratio, so a [0 - 1] number. Fraction using unsigned
int already provide a pretty good precision (around 0.0002 ppm with 32bit)

Do you have a use case where you need more than that ?

> 
> Also, you may want to have a higher precision than degrees for the
> phase property when handling pulses.

Is this comment related to this patch ?

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


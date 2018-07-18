Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4CFECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8217F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8217F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbeGRLns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:43:48 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:42651 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbeGRLns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:43:48 -0400
Received: by mail-vk0-f68.google.com with SMTP id t4-v6so2253899vke.9;
        Wed, 18 Jul 2018 04:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILOmiLYMi6v4SrcKSbcNHNZnPsAHz2xcc9s0MFAcU0A=;
        b=U4o7jkS54CmRENm0H63HjP3ti5WHSMfhivEe2DEXd2y5lsf9L0rNNnJSOwGK1Tc/SU
         Y5SVp8Cf+TrEhamqKhI4qR25dfVpNMHQkkD+JSSzF1yMe85ZqIOmw6uS085T1Ex0RnZq
         b0RhkIFVJO77Uu5wuhKIVdqTmWKm//D6rJHh9tO4kCH+o1Lyibr8tsiOA3M5dhH6iLbj
         UY1/1C8RKG45b96BrD9ZvnJwGV7U5ElCehH7r7+6J9p/VbhZzcg0RvqQpAFj4JBy5cDL
         xdcqsBtz02MF7h0cnigbcLFKof2AfmLSaBwvtco62uZ/kZVI4wBjUI63/vs/hthkmkEV
         FuoQ==
X-Gm-Message-State: AOUpUlF2AH9WMpV3UMbp5G5f34x0Qo7i3zNWexI06nTgsR1Esy9x59ZI
        hW0rxCV45b2JzFroeC8O4YwNy5mhsnXgNHItI0FqHg==
X-Google-Smtp-Source: AAOMgpeu79KIudJtIyci63hcGSzVGHmcEO0rHUjUoYULELbGgvFBGX4AOux4VovX/VPQyWbGzeAFBdVpKe3eefDx2YQ=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr3090857vkg.176.1531911984258;
 Wed, 18 Jul 2018 04:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
 <20180717120737.bipotpki3yhn6klf@verge.net.au> <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
 <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
 <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
 <TY1PR01MB1769473F18D646B7011C5803F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20180718091448.fw2y7ea6sk2osi3g@verge.net.au>
In-Reply-To: <20180718091448.fw2y7ea6sk2osi3g@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jul 2018 13:06:12 +0200
Message-ID: <CAMuHMdWJkwJ5+DDqbaWH-cMhRQynWCxb4MbFtpejqi1HhUBHTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
To:     Simon Horman <horms@verge.net.au>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:14 AM Simon Horman <horms@verge.net.au> wrote:
> On Tue, Jul 17, 2018 at 02:57:27PM +0000, Phil Edworthy wrote:
> > On 17 July 2018 15:47, Andy Shevchenko wrote:
> > > On Tue, 2018-07-17 at 14:40 +0000, Phil Edworthy wrote:
> > > > On 17 July 2018 15:19, Andy Shevchenko wrote:
> > > > > On Tue, 2018-07-17 at 12:42 +0000, Phil Edworthy wrote:
> > > > >
> > > > > > > While your point sounds valid (don't remember how clk_get() is
> > > > > > > implemented), NULL is also OK to have.
> > > > > >
> > > > > > Ok as in there is no bus clock, right?
> > > > > > So it should be:
> > > > > >  if (!IS_ERR_OR_NULL (dev->busclk))
> > > > >
> > > > > Nope, NULL is no error case for optional clock.
> > > >
> > > > I must be missing something here...
> > >
> > > See how clk_prepare_enable() is implemented.
> > Ok, if busclk is NULL the code can safely call clk_prepare_enable()
> >
> > > > I agree that NULL for an optional clock is not an error. However, the
> > > > code above is now:
> > > > + if (prepare) {
> > > > +         /* Optional bus clock */
> > >
> > > > +         if (!IS_ERR_OR_NULL(dev->busclk)) {
> > >
> > > Check for NULL is redundant.
> > >
> > > > +                 ret = clk_prepare_enable(dev->busclk);
> > > > +                 if (ret)
> > > > +                         return ret;
> > > > +         }
> > > > +
> > > >           return clk_prepare_enable(dev->clk);
> > > > + }
> > > >
> > > > So, if you have a valid busclk, it gets enabled, otherwise it is left
> > > > alone.
> > >
> > So the code as sent in the original email is correct (aside from Geert's
> > comments about EPROBE_DEFER handling).
> >
> > Maybe I need some coffee :\
> > Thanks
> > Phil
>
> My point is that errors should be treated as errors.
>
> In i2c_dw_prepare_clk() the following appears:
>
>         if (IS_ERR(dev->clk))
>                 return PTR_ERR(dev->clk);
>
> So dev->clk being an error value is treated as an error that
> is passed up to the caller.
>
> But in your patch (and the snippet below) dev->busclk is treated
> as the optional clock not being present. Even if the error stored
> nothing to do with the clock not being present - f.e.  ENOMEM or
> as Geert mentioned elsewhere, EPROBE_DEFER.
>
> Assuming the absense of the optional clock is indicated by ENOENT,
> in my view correct code would include something like:
>
>         ...
>
>         if (IS_ERR(dev->clk))
>                 return PTR_ERR(dev->clk);
>
>         if (IS_ERR(dev->buslck) && PTR_ERR(dev->busclk) != -ENOENT)
>                 return PTR_ERR(dev->busclk);
>
>         ...

As this is a commonly-used construct, perhaps it would be good to introduce
clk_get_optional() (cfr. gpiod_get_optional()) and devm_clk_get_optional(),
which would return NULL instead of -ENOENT?
Then it becomes a simple check for IS_ERR() in the driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

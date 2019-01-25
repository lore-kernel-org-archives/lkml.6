Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476C3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B8521919
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtiE7QN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfAYIRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:17:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43871 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:17:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so7751357otr.10;
        Fri, 25 Jan 2019 00:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51rjv/rE8IVdsNp/pu/SqvKcr4yosm/xU7bN7sHEyl4=;
        b=XtiE7QN0siN9qE83S4VaURtlrAfecWQIQJ7yuon0UZGNZtoDpA6NO+z4QWaZBeG5oG
         t5Tygns5ugebqZ+HxiZ9GkpaUh5hK11hh913ttR6dcdU6IukAInViFyZGzQpJJC1YKfs
         0zuNwC7KRf3pk+L9QGpznBoKsioWvuBfKoFWCYa05PER79+c4apqOJUwOyWORWOgqVrz
         AaoqbL1NDxAq7/kM14pHwrTp6PIBcdMtFRjPe65AA2l0GAykLmAok4g6HN2hm8oo2RCf
         dy1rtQQmCgWD5unj2GIBfXAxZiCOchvHSOPgX/hXxadXOzYcZo7U0DQ7npKGeuvFUxmW
         qlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51rjv/rE8IVdsNp/pu/SqvKcr4yosm/xU7bN7sHEyl4=;
        b=GI8EZkF9YRxHw6gjI7xpCjN9cbbPMSTucH3vK6VYLOdz2n6mUwfPWsAbXTTdT2s7pI
         Wq6pdzV9gd4vH4FwhdkFmCJ2QVbTzZc5AKwMxPRqfs7fPBH+MbtopyQAI/JfbLybvJLn
         zXWk7D/F8ZmZB5gp0r2pDBZ4h+T/wP0CmQXCvqgEOGgVZ97F5uKEZP3VIeKV6ZT9w2hM
         EkC3YQO+OMGexkfc50mdiFBE1NzTXClZ+zL/Jmtvxs01KQCwCHXTrZnAz0QUlPFiwd0o
         D9pDM/bgm0ypWl/zsSjbKPPQsaKnPnav8NPFF/vdBLUfgTpjXd+BEmxPpwD3SFtxQu23
         x1pA==
X-Gm-Message-State: AJcUukfsc9H6uSY2eeZrad/dMXxi2uYZQw95AcOQrM9ztAJaudizhMkH
        xaqMRRk+gWE9U1TTF9ctkamRNALEUWqdIzHGRHM=
X-Google-Smtp-Source: ALg8bN6K74jiOvlxVvF3zxoNHdbOXAUeOPysoSzVE83lWk89ux31aGyqlfQuY0OFys36+JmXzzesuWhuWkEn7Qxnhj4=
X-Received: by 2002:a9d:4d17:: with SMTP id n23mr7190739otf.66.1548404232067;
 Fri, 25 Jan 2019 00:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20181206091052.7644-1-mircea.caprioru@analog.com>
 <20181208152954.596529f8@archlinux> <154475156267.19322.6284056396098102605@swboyd.mtv.corp.google.com>
 <20181216100741.4e362a17@archlinux> <154836968107.136743.11352935762099070131@swboyd.mtv.corp.google.com>
In-Reply-To: <154836968107.136743.11352935762099070131@swboyd.mtv.corp.google.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 25 Jan 2019 10:16:59 +0200
Message-ID: <CA+U=DsqcGqBVnNhx+aYm7Z=igyLMdXt+2x6LTe_GWsp+=ZaWiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: Add clock for external
 clock reference
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 12:41 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Jonathan Cameron (2018-12-16 02:07:41)
> > Rob, Clk experts, questions for you below.
> >
> > Jonathan
> >
> >
> > On Thu, 13 Dec 2018 17:39:22 -0800
> > Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > > Quoting Jonathan Cameron (2018-12-08 07:29:54)
> > > > On Thu, 6 Dec 2018 11:10:51 +0200
> > > > Mircea Caprioru <mircea.caprioru@analog.com> wrote:
> > > >
> > > > > This patch adds a clock to the state structure of ad7192 for getting the
> > > > > external clock frequency. This modifications is in accordance with clock
> > > > > framework dt bindings documentation.
> > > > >
> > > > > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > > >
> > > > +cc Rob and the clk list for advise on how to do the binding for this one.
> > > >
> > > > It is basically 2 pins, you can put a clock in on one of them or connect
> > > > a crystal across them.  The driver has to set a register to say which is
> > > > the case.
> > > >
> > > > Current proposal is two optional clocks (fall back to internal oscillator)
> > > > but that doesn't seem to be commonly done, so I'm wondering if there
> > > > is a 'standard' way to handle this sort of thing.
> > > >
> > >
> > > I'm not sure I fully understand, but I think perhaps
> > > assigned-clock-parents would work? Or does that not work because either
> > > way some parent is assigned, either the crystal or the optional clk that
> > > isn't a crystal?
> > >
> > My concern is they aren't really separate clock inputs.   They are just different
> > ways of providing the same fundamental clock.  So I think we may want to just
> > provide a single clock and have another dt binding to say what it is.
> >
> > So lots of ways we could do it, but I'm not sure what the right one to
> > go with is!
> >
>
> Sorry for getting back to this so late. Is the datasheet public for this
> device? If so, any link to it?
>

Hey,
Link is http://analog.com/ad7192 and that should resolve to the proper
page, where the datasheet is available.
[ General info: most [if not all] datasheets from Analog Devices can
be found by concatenating "http://analog.com/ + "<part name>" ]

But more directly, the link to the PDF is:
https://www.analog.com/media/en/technical-documentation/data-sheets/AD7192.pdf
Page 10 provides some description of the pins, page 20 the mode
register for the clock, and page 32 a general description of the
clock.
If you search for MCLK1 or MCLK2 you should navigate pretty quick
through the doc.

The clock circuitry [the 2 pins] is common for all chips this driver
supports [AD7190/2/3/5].

Thanks
Alex

> If it's two pins, and sometimes one pin is connected and other times two
> pins are connected but a register needs to be set if the pins are
> connected in one configuration or the other I would say your plan for a
> DT property indicating how the pins are configured sounds good. Usually
> the hardware can figure these things out itself so I find this sort of
> odd, but if this is how it is then there's not much that we can do.
>
> It sounds like there aren't two different clk inputs to the device.
> Given that information specifying two optional clks is incorrect because
> there is only one 'slot' is the external clk source.
>

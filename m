Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D76C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D527F214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCZRcV5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfBRI4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:56:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51977 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfBRI4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:56:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id n19so4333167wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=krREZ5mLXdYD0Y0EMtLOYOkg5Rnz8WcDkNptDmHutrY=;
        b=HCZRcV5b5015g0BzDX9qMgMjtZW5IHboRz6RU4CDJ574f4NMFxcvYJoq3mhTsHbJnz
         gNEBRh7hSJp+GwXmOqxvYGI8oXoa51UDcHiqwUHfoczgZHr2V4CtGsUIKT2pe/VDBgdz
         AhSvCOeNnskJXWrgN6KYDWas7VmaT4YAVsKq0mpuKvCxY4i48kXBS4uANeW2mb8EzZaK
         IQyBQ+ELO/rRkK/AJQIOuF6MwYZTSojmHNgoSdpTpF26mkIXPzBSlfsrDxM47d4LfUMF
         EYFFng4leG3bZMBCnQ0SGD9NxxJLMiHjnUUzyW80kbd8zS1Di6+mtftNAXrlgDac3tzv
         jv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=krREZ5mLXdYD0Y0EMtLOYOkg5Rnz8WcDkNptDmHutrY=;
        b=Brj3VpnKT4FaUSY9MAEQSU52myj31FVPRl8aW0lyx72zFQs7+uy53nBrMB1OeC53w8
         NWJdlYaBRpqKu/Cj3fXft2PuJpyVxAC63kEz0l49wlOgO1MkUXaKgb5/jZJPitTdjIgk
         M6rgclWFo0lng/VYFuZ3VtAG6zdkY0sTcZq954o5XdDNSMyKqyNUyEmI6kzp3sMYYaWa
         ybXz4ZIA+x1miCZ0mBP8u44LyyrYx2MtgFqZ9tVdHXLFR48QZvGHYyD4pqri+kthUqN6
         SD/8zKV3swypqjMWNhPw4p+C2QIsTuOyzr57tQg1//vrErpklDO163lSo9RfhV9mozoU
         vZGQ==
X-Gm-Message-State: AHQUAubu6uuexLng978CB0C/3F//HSYQp/WuCt7eIdBgmKwO8xliPvjg
        nXXRIbcA7gKmqXBOuIU9WbOP2A==
X-Google-Smtp-Source: AHgI3IYlGKBuCWeLhSRYDz4QhEf8/UR7u79E7Sv+VOq/UqlgkHUiClzdMXVVaHLD7TO/4TcrwTeP4g==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr4698647wml.4.1550480207990;
        Mon, 18 Feb 2019 00:56:47 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id l129sm7908114wml.42.2019.02.18.00.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 00:56:47 -0800 (PST)
Date:   Mon, 18 Feb 2019 08:56:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Moritz Fischer <moritz.fischer@ettus.com>
Cc:     Virendra Kakade <virendra.kakade@ni.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 2/6] mfd: Support for Ettus Research E31x devices PMU
Message-ID: <20190218085645.GA4118@dell>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-3-virendra.kakade@ni.com>
 <20190214093445.GF13737@dell>
 <CAAtXAHemEOOKOmQGT5StDt-Jxn0RUOoc9L-breMNURhd8=9q=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAtXAHemEOOKOmQGT5StDt-Jxn0RUOoc9L-breMNURhd8=9q=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019, Moritz Fischer wrote:
> On Thu, Feb 14, 2019 at 1:34 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 11 Feb 2019, Virendra Kakade wrote:
> >
> > > Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> > > ---
> > >  drivers/mfd/Kconfig          |  7 +++
> > >  drivers/mfd/Makefile         |  2 +-
> > >  drivers/mfd/e31x-pmu.c       | 89 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/e31x-pmu.h | 20 ++++++++
> > >  4 files changed, 117 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/mfd/e31x-pmu.c
> > >  create mode 100644 include/linux/mfd/e31x-pmu.h

[...]

Try not to quote too many unnecessary lines when replying please.

> > So the whole purpose of this driver is to do a version check.
> >
> > Seems like over-kill!
> >
> > Probably better to do the version check in an inline function stored
> > in a header file, then call it from each of the children's .probe()
> > function.
> 
> A bit of context here, this is based on an in-house driver that we had that does
> a bunch of other stuff (e.g. it controls a flag on whether the device auto-boots
> on power being plugged in etc.). These functions will use the regmap.
> 
> I had advised Virendra to submit a base version and follow up with patches
> that would add these functions one by one as he figures out how to expose them
> in a proper way to the kernel.

Probably best to wait until you have something a little more
featureful before attempting to upstream then.  I couldn't tell you
how many times I've had contributors tell me that they plan to follow
up with additional patches and (for their own perfectly decent reasons
I'm sure) fail to do so.

As it stands, this driver over-kill for what you're trying to achieve
and therefore isn't overly suitable for upstreaming at the moment.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

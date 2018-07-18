Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C0EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11AE20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="an6Slgp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11AE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeGRRMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:12:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37298 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbeGRRMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:12:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id a19-v6so3524259wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tT5meck62edPAXqkrlpPpDOqpQK+sSQS+PF+xhnQppI=;
        b=an6Slgp7LjXF32GKoQLCXYqFCQluNM+x0KEyxoJP+fhuLZ6yC26vLInHAlyjnyYmP1
         a0ce14ITVUPAKPfIGmwbU0iTBDFHzlSx0KHDmQQrGWodCHDPXZVDBEz5qkIFV5qeyOSb
         5ovwRU9B4ntUjpM98JgeaWxQihldvwa6Kjvag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tT5meck62edPAXqkrlpPpDOqpQK+sSQS+PF+xhnQppI=;
        b=mRCJxoksyuSxJEpZhBhi0ueNEdyI7BdEVrfKvUJFFiQBtU5HakNdP+e5Ma1Zhta04S
         yCtFdQQLxhO8esMgiX45H1sNchgLhrmze3IlIG3Ul9P7jJ+Y6PU6gfuAM0gEnC/3ApO4
         bJMsnfwNcwOdHqbj/k86i+Jk4w88r8q2QBl+yrM/vSiubGWkiy5Yu8rgJSx7nORG3OHX
         LIL220xmOxV5hvDWIXQWr5jgW66axVZniyMS2QvBxWHptnTCrWtIa0aThsczuPAXQHUz
         boRmsNmePlVEj/ad1CC+xZRIUQG89UcIsbPxivO8iYeqXKqoDSSHMWurBI1jChpNu7ZB
         lHSQ==
X-Gm-Message-State: AOUpUlGNbrUWF6NKTVTMr97ugZZfZDBysg2Pwh2rB9lCZ3ggcubvziln
        QYPApfraBhJVd2afnPfByWlJAw==
X-Google-Smtp-Source: AAOMgpdt31mYdadniYSD5pZtSwP4LXOrTJBlTA1ZisIpQwXdEageHGXsBtVNymWcGnEYjE7nxYIfVA==
X-Received: by 2002:a1c:58cb:: with SMTP id m194-v6mr2216820wmb.64.1531931648936;
        Wed, 18 Jul 2018 09:34:08 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q14-v6sm4150729wmd.20.2018.07.18.09.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 09:34:07 -0700 (PDT)
Date:   Wed, 18 Jul 2018 17:34:05 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "patches@linaro.org" <patches@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180718163405.mnebf57apzvm276w@holly.lan>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
 <1531902119.16896.13.camel@toradex.com>
 <20180718095335.GD4641@dell>
 <20180718101227.shqf54wpt4kdrsj2@holly.lan>
 <1531918626.16896.22.camel@toradex.com>
 <20180718130853.GE4641@dell>
 <20180718134103.bgwpgk7l6joxtjoa@holly.lan>
 <20180718155544.GF4641@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718155544.GF4641@dell>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:55:44PM +0100, Lee Jones wrote:
> On Wed, 18 Jul 2018, Daniel Thompson wrote:
> 
> > On Wed, Jul 18, 2018 at 02:08:53PM +0100, Lee Jones wrote:
> > > > > > > No, then we are back to the initial issue of num_steps
> > > > > > > potentially not
> > > > > > > being initialised. We really want both of_property_read_u32() to
> > > > > > > succeed AND num_steps to actually be set.
> > > > > > 
> > > > > > I also think num_steps should be pre-initialised.
> > > > 
> > > > Yes, I guess it definitely does not hurt.
> > > > 
> > > > > > Then it will only be set if of_property_read_u32() succeeds.
> > > > 
> > > > Yes, but we still need to check for both, the function not failing and
> > > > num_steps to actually be non zero.
> > > 
> > > Why?  You don't do anything differently if it fails.
> > 
> > Only if you initialize num_steps...
> > 
> > We should either initialize to zero and not worry about the return
> > code[1] or we check the return code and not worry about
> > initialization[2]. I don't think both are worthwhile.
> > 
> > Whilst initialization can fix this specific instance we generally avoid
> > overusing it since it messes up static analysis and, in this instance,
> > distance from declaration to use is >25 lines, hence current patchset.
> > 
> > 
> > Daniel.
> > 
> > 
> > [1] https://lkml.org/lkml/2018/7/16/399
> > [2] https://lkml.org/lkml/2018/7/16/1042
> > 
> > Or...
> > 
> > We check the return code and leave number
> > 
> > num_steps is uninitialized and stack allocated so it only has a valid
> > value if of_property_read_u32() succeeds.
> > 
> > We can (and I originally did) fix the bug by initializing num_steps to 0
> > but its quite some distance between declaration and use so I accepted
> > Marcel's counter proposal to check the return code instead.
> 
> Only checking the return value of of_property_read_u32() is also
> suitable.

I did think about that case... I concluded that it isn't wrong for a
DT to set to this property to 0 (effectively meaning "no interpolated
steps please").

If we take the branch when num_steps is zero we get a bunch of pointless
housekeeping that amounts to no more than an extremely elaborate
malloc/memcpy/free.


Daniel.

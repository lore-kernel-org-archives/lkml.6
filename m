Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B072148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPC4HrPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfBUI1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:27:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33694 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfBUI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:27:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so377672pfd.0;
        Thu, 21 Feb 2019 00:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g5gN4Ti0gN+mczLgHhdKVrENWOTE09jCVWnpN/478RY=;
        b=ZPC4HrPdz+WY6AK9hfFZDhcbS7CxkySmfmXhtYXcQUQkKmLIAX2EVxo+MN8tnhNrYs
         H8pwsE6LR931tqfoTltTDeciYj8gMZmnFqHzpapNqLYGZtsqxLEsJG49B4dDFRzAXZAI
         wxfFc6d+QlYwVFgCJY5jvgbyWQTOwPVzSA/3Mb4QWd6TrCafEYiFPbnL6vzD2cxJ+LDi
         n6pTfn2IQTzSakuXkbroS7vy3VeVtWj0C8jFqGj8OMMn0t+BuQQGORqy7lmBXo6ae1wV
         pTPOR2prRD++s9vCn/842lnW2bGWhrohsW6tTp2vtR18jlTInv5qUO1oBuF8mTooMCM9
         W6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g5gN4Ti0gN+mczLgHhdKVrENWOTE09jCVWnpN/478RY=;
        b=XnKdpljItlULc+G5Q46zzDg/e1VItwxb1NYtdQ/PhUJtk9q79GHHWDd5cMnikCnm8G
         OEVteNdT8tKTRcjrrdUYZEccdTTh0X8LBMTmzmzzyoU+BPvl0hx2PDyd0ffOS2tLXfkT
         XzC1GioUY80yuT1oeeeSZ+bczPpfvz3YUOLOOfAZZzCPVApDsJUjIbpwZ7Dts6zPvFRJ
         ZE+QblKs9NEiVtTXQnbleEWDZqd21pta0TtmIZaVgF11AN7rhw5GUxtxb6nSD58HaRJx
         RZolXG0bV0GNYehJcumc9ho2SIsg+Ni2N5uc64fYudYkC9hP4SdC2czihPIH9N4KZj9s
         rp8Q==
X-Gm-Message-State: AHQUAua/oWx/qo3VBBa9oQtkthuCKJe4T85q1YqhltKwlbjI68COAL2W
        M81AgfGFieNzr6eimrAL2i8=
X-Google-Smtp-Source: AHgI3IZHNJbq9wAWv/DgJ7abDmOyMDM9OF93XsPXA58Q+3Eb1CGKbsQCgm4TJ1+6HhEgw1vRQJEhcA==
X-Received: by 2002:a63:1766:: with SMTP id 38mr33480045pgx.204.1550737670185;
        Thu, 21 Feb 2019 00:27:50 -0800 (PST)
Received: from icarus ([2001:268:c0a4:888c:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id f67sm29158116pff.29.2019.02.21.00.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 00:27:48 -0800 (PST)
Date:   Thu, 21 Feb 2019 17:28:21 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
Message-ID: <20190221082758.GA3380@icarus>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com>
 <20190220164154.00547a77@archlinux>
 <20190221010931.GA3471@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221010931.GA3471@icarus>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:09:54AM +0900, William Breathitt Gray wrote:
> On Wed, Feb 20, 2019 at 04:41:54PM +0000, Jonathan Cameron wrote:
> > On Mon, 18 Feb 2019 15:03:18 +0100
> > Patrick Havelange <patrick.havelange@essensium.com> wrote:
> > 
> > > This driver exposes the counter for the quadrature decoder of the
> > > FlexTimer Module, present in the LS1021A soc.
> > > 
> > > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> > Given you cc'd William, I'm guessing you know about the counter
> > subsystem effort.  I would really rather not take any drivers
> > into IIO if we have any hope of getting that upstreamed soon
> > (which I personally think we do and should!).  The reason is
> > we end up having to maintain old ABI just because someone might be using
> > it and it makes the drivers very messy.
> > 
> > I'll review as is though as may be there are some elements that will
> > cross over.
> > 
> > Comments inline.  William: Looks like a straight forward conversion if
> > it makes sense to get this lined up as part of your initial submission?
> > You have quite a few drivers so I wouldn't have said it needs to be there
> > at the start, but good to have it soon after.
> > 
> > Jonathan
> 
> I agree, we should try to merge this as part of Counter subsystem
> introduction rather than as another IIO Counter driver. As we determined
> when adding support for the STM32 timers, the existing IIO Counter API
> is fundamentally unsuitable for representing counter devices. So
> regardless of how a new Counter API is merged, the existing IIO Counter
> API must be deprecated.
> 
> Patrick, I apologize for the confusion this has caused. Would you be
> able to convert this driver to use the proposed Counter subsystem API
> from this patchset that I believe you encountered before:
> https://marc.info/?l=linux-arm-kernel&m=153229982404051
> 
> Although it was last updated in October, I believe you should be able to
> rebase that Counter subsystem introduction patchset cleanly on top of
> the IIO tree (if there are any merge conflicts send me an email). Take a
> look at the generic-counter.rst file under the Documentation/driver-api/
> directory for an overview of the API; the counter drivers under the
> drivers/counter/ directory also make good references.
> 
> If you have any difficulties understanding the API, or any other
> troubles, don't hesitate to ask. Hopefully, I've made the documentation
> clear enough to make the conversion of this driver quick and easy -- and
> if not, then it's something I need to fix, so let me know. :-)
> 
> William Breathitt Gray

Patrick,

It looks like there were some minor conflicts with the v9 patchset, so
I've rebased it on top of the latest iio tree testing branch and
resolved the conflicts in my personal repository. Please pull from my
personal repository at https://gitlab.com/vilhelmgray/iio.git and base
your patches on top of the generic_counter_v10 branch.

William Breathitt Gray

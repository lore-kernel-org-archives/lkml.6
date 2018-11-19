Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62165C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C5220817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+WIrkjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C5220817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeKSTiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:38:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44498 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeKSTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:38:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so4905990pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 01:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QC3XRj8nNUcvhqzdhjJAaXxDuH4iNsfxmoRRQcKiamc=;
        b=e+WIrkjyMLnT/YxQWDj2yfNv3RApHzP47Hvojz+r9Wv5Ecbv5zh6rmlect/IaVwIYY
         xWWE8y9D57RcKodWZvCKdBDtt5DiAHympTJjki45PudhFg1ZSdd/+wve9lNtKj9e+jfc
         QCBmnAJQIEN3EMSer1NK55+lsGO+N30Os0xzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QC3XRj8nNUcvhqzdhjJAaXxDuH4iNsfxmoRRQcKiamc=;
        b=OLjycfOuPJQ6g5ywqqVHLGNBJGtxE7xhVYEU6G/N6F79wBQHXFAkh5iZqRD6SO2xZ3
         +ePD9kNV8n/uaCag8f8JaObHREgj6YEAykun2BfytZG4z2cEcsXMnobhDwWc0TTViFJR
         Gni2CcaCnTs833xVEWAggaD3tSZkMOUPvE+TdluSHkNbH4pSEQQShv8WyySYFGevV79A
         ahVepcRKlpKWaef9NDCRoUUHRzDvNnWEVG3DCT1cLW0AMxerBqY6S3cuuGn9H0jF8o14
         DSpYeyJRI21tRCe8BH1aH2e7+g9suvVQ4Y4tlGjJ9NkJa91abMrcTmT2MNtwOR1nNsdJ
         tM1Q==
X-Gm-Message-State: AGRZ1gKuhfNndWhC8/eIqMntRbRf2prOhRbNp+TwmYu9ntc1cb8xUSOu
        EjCo2BhAbAOcAP06nej1zW2/bA==
X-Google-Smtp-Source: AJdET5fly6QeyBbN26pA6mIBGKUk8pw9qPJQgXgt0bS7OTUrQw+IL9cbwKHTPrHqLqHGZ4EgvGgSXw==
X-Received: by 2002:a63:5f95:: with SMTP id t143mr19678509pgb.395.1542618949240;
        Mon, 19 Nov 2018 01:15:49 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id h7sm37963134pfa.105.2018.11.19.01.15.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 01:15:47 -0800 (PST)
Date:   Mon, 19 Nov 2018 17:15:27 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>, kishon <kishon@ti.com>,
        sallenki@codeaurora.org, anur@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>, vkoul@kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed
 USB PHY binding
Message-ID: <20181119091523.GC10788@dragon>
References: <20181108070449.23572-1-shawn.guo@linaro.org>
 <20181108070449.23572-2-shawn.guo@linaro.org>
 <5bea0ed8.1c69fb81.8715.38b2@mx.google.com>
 <20181113034200.GD20049@tiger>
 <CAL_JsqKu3kf-zrKNtrtZsQEPi0LN_3jqs08i3-8vbSQDVxuRkA@mail.gmail.com>
 <20181119065503.GB10788@dragon>
 <CAFp+6iGmsLT8UOk+-4zOKkYxJbkhqy=oDw2ZqrXLDCGbF8uTHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iGmsLT8UOk+-4zOKkYxJbkhqy=oDw2ZqrXLDCGbF8uTHA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 12:40:59PM +0530, Vivek Gautam wrote:
> On Mon, Nov 19, 2018 at 12:29 PM Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > On Sat, Nov 17, 2018 at 09:13:38AM -0600, Rob Herring wrote:
> > <snip>
> > > > > > +- qcom,init-seq:
> > > > > > +    Value type: <u32 array>
> > > > > > +    Definition: Should contain a sequence of <offset value delay> tuples to
> > > > > > +                program 'value' into phy register at 'offset' with 'delay'
> > > > > > +           in us afterwards.
> > > > >
> > > > > If we wanted this type of thing in DT, we'd have a generic binding (or
> > > > > forth).
> > > >
> > > > Right now, this is a qualcomm usb phy specific bindings - first used in
> > > > qcom,usb-hs-phy.txt and I extended it a bit for my phy.  As this is not
> > > > a so good hardware description, I'm a little hesitated to make it
> > > > generic for other platforms to use in general.  What about we put off it
> > > > a little bit until we see more platforms need the same thing?
> > >
> > > I'm not saying I want it generic. Quite the opposite. I don't think we
> > > should have it either generically or vendor specific. The main thing I
> > > have a problem with is the timing information because then we're more
> > > that just data. Without that we're talking about a bunch of properties
> > > for register fields or just raw register values in DT. That becomes
> > > more of a judgement call. There's not too much value in making a
> > > driver translate a bunch of properties just to stuff them into
> > > registers on init. But then just allowing any raw register value to be
> > > in DT could be easily abused.
> >
> > Rob,
> >
> > I agree with your comments.  Honestly, I'm not comfortable with this
> > 'qcom,init-seq' thing in the first impression.  The similar existence in
> > mainline qcom,usb-hs-phy.txt makes me think it might be acceptable with
> > the timing data added.  Okay, I know your position on this now.
> >
> > @Sriharsha,
> >
> > Seeing that 'qcom,init-seq' is being configured with the exactly same
> > values for both HS phys in SoC level dts file (qcs404.dtsi), I think
> > such settings can be moved into driver code as SoC specific data.
> > Unless you have a different view on this, I will do it with v4.
> 
> phy-qcom-qmp and phy-qcom-qusb2 have been maintaining such SoC specific
> init sequences in the drivers if you would like to have pointers from them.

Thanks for the pointer, Vivek.  That helps.

Shawn

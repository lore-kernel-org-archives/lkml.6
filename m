Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3111C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE59E21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGjDQnP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbeLUJ1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:27:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53602 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731365AbeLUJ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:27:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so4604220wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bIkpx3d0jT0gZmqfZ9C/hqI/Rmmvfn2emL3mxbUxJms=;
        b=BGjDQnP/v/l4Nf1mI1ZV5c7V6b2v4K4ElI5jbiBOiIkk2/yHTv0LyzgKkV0KEKstoN
         E6W5T0G7FKRFUNLUIsiI7dOpqfTm4FrpCh1mO4lt5MLKSbZt0LKxRp/P9hSGG5p+Zciu
         QxVmF6WiuRhFUEzFR4WguDOlcGeyhED3StjHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bIkpx3d0jT0gZmqfZ9C/hqI/Rmmvfn2emL3mxbUxJms=;
        b=MlfodYkD939MbW9glE9oCLCiY08DY2r+MqhPtQwFJOqPXKTy7hce1d8iqKdbZG4bY5
         4eE0m064FWQzLVuzjht3Y/DCvXb1C49q44rD8NRMJ7/DdK1RClzTHMlIyQxzLOrbbqdZ
         kLdakAX0b08mAkxdH9Doua6r3ninsIaK8NnAAaUJXCb8vmQq8NWYqcQWU1qDtMd0PqQM
         0s6z/C9+k4Z/smh/quPxmDpNiPgwnUcroS6rA0aFa0ggTbOklOhneBqXEP11MH+BWUJ0
         DnAu3hPSf2ZSxU4xMrQ+N0lXPqcRgkx1LeNgzMFuLu/vOiGJe0wM6XZNuyKOTBCc6JU/
         BuGg==
X-Gm-Message-State: AA+aEWb9OjpRnenB5Rs2SGcqXeckNiNIgEBb8wSeJcN0/BFxX5Bi29BY
        U3eZJl1wjOZzcXG7Rs+2d4wLTA==
X-Google-Smtp-Source: AFSGD/VZ28A7uEqB515CFVQRUKLayev3Hpp7QcdWYdsW5uMJYolZOb9ZiM7u71IrsCqMP6DE0iMmpA==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr2010592wmi.24.1545384421312;
        Fri, 21 Dec 2018 01:27:01 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id l20sm23189477wrb.93.2018.12.21.01.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:27:00 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:26:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 1/8] mfd: axp20x: name voltage
 ramping define properly
Message-ID: <20181221092658.GB13248@dell>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
 <20181221083927.GQ4497@dell>
 <20181221084246.myrtv6n4jrv6lajl@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221084246.myrtv6n4jrv6lajl@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018, Priit Laes wrote:

> On Fri, Dec 21, 2018 at 08:39:27AM +0000, Lee Jones wrote:
> > On Tue, 11 Dec 2018, Priit Laes wrote:
> > 
> > > From: Olliver Schinagl <oliver@schinagl.nl>
> > > 
> > > The current axp20x names the ramping register 'scal' which probably
> > > means scaling. Since the register really has nothing to do with
> > > scaling, but really is the voltage ramp we rename it appropriately.
> > > 
> > > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > > Signed-off-by: Priit Laes <plaes@plaes.org>
> > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  include/linux/mfd/axp20x.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > I've lost track of what's happening with this set now.
> > 
> > Mark,
> > 
> > Did you take this patch in the end?
> 
> Yes, this is in linux-next.

I have no idea why Mark's tracker isn't mailing me (this is not the
first time this has happened).

Could you please rebase this set and resubmit all of the patches which
have not yet been applied?

Thank you.

> > > diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> > > index 2302b62..a353cd2 100644
> > > --- a/include/linux/mfd/axp20x.h
> > > +++ b/include/linux/mfd/axp20x.h
> > > @@ -35,7 +35,7 @@ enum axp20x_variants {
> > >  #define AXP152_ALDO_OP_MODE		0x13
> > >  #define AXP152_LDO0_CTRL		0x15
> > >  #define AXP152_DCDC2_V_OUT		0x23
> > > -#define AXP152_DCDC2_V_SCAL		0x25
> > > +#define AXP152_DCDC2_V_RAMP		0x25
> > >  #define AXP152_DCDC1_V_OUT		0x26
> > >  #define AXP152_DCDC3_V_OUT		0x27
> > >  #define AXP152_ALDO12_V_OUT		0x28
> > > @@ -53,7 +53,7 @@ enum axp20x_variants {
> > >  #define AXP20X_USB_OTG_STATUS		0x02
> > >  #define AXP20X_PWR_OUT_CTRL		0x12
> > >  #define AXP20X_DCDC2_V_OUT		0x23
> > > -#define AXP20X_DCDC2_LDO3_V_SCAL	0x25
> > > +#define AXP20X_DCDC2_LDO3_V_RAMP	0x25
> > >  #define AXP20X_DCDC3_V_OUT		0x27
> > >  #define AXP20X_LDO24_V_OUT		0x28
> > >  #define AXP20X_LDO3_V_OUT		0x29
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

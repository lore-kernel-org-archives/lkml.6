Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FBAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1D721924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guKzi/8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfBHLD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:03:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54263 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBHLD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:03:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so2968641wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 03:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=knW0z7TbZkk4k9GAX5c/GhUDvRtIDL/zkxnCrXGg7wc=;
        b=guKzi/8r5BTCFCD7qPgsIdinPklLl5lQl9SqYuAN8HOHuCAVgsPQUoVS55Tz/57xZd
         LhdHT41XQmQk+XRmT1DgFLE6g4XBPdcq3M3Z1FABBXtIh8F67G+cu5nK8rn7NvluORuM
         dIgEdH8kmGYnvYuM83Lkgb1ZMKcZSuPeCcRnS2qmoUQVAUHLT+aFpN34ONRL7aFntyUb
         yFBrlOYR+csN3MQM/T3aUFFnMwvpfaHhS4LLgc8x7mcxIjsCXW4cTsuO1Z1JV2U7mdvS
         I9Mm9/UAW7ztCdc/EXxfET0FcFPAXZ46zTpGZLqY0yRQBtVxsUbNInS2R9+8ozzh5hYa
         nAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=knW0z7TbZkk4k9GAX5c/GhUDvRtIDL/zkxnCrXGg7wc=;
        b=Q3burTxbH7IvPs1imwOrz3v6crvzENuiJQ7589kgiviZThcH3WP7abUV9hTU84c50U
         28BnrNdx6z2XZy8mQviaHIdatb6Ts6GueU6nhYkfCSOWeldaMbEjcKoy6DZnkeyJ7kvs
         78Mvccf6GLdydQGFlSz/K8CuUiIUNpSx+aqn6Vgkvjr0VioHB1kZcUhaMezU8mamjnoT
         4IfPJ0Buu5az/YGkzVmNkdhxYY5ld/DqTDZn5g/uOgt9yRwiLp6Y2ViYw4JVgwiHGzvQ
         RPIHnxsXCag+Fw4GHTak0ySKLxcs/6wUYC+WIQW+IKPs69YATa6gh4YbCvlz6e886L+V
         kF6Q==
X-Gm-Message-State: AHQUAuahY2NhjdRrFXeQCz6SnPZPb5boKMOqve0SK4FOY26IhGzLEuhJ
        astSs8ObT//De6OVTR63cr2/4w==
X-Google-Smtp-Source: AHgI3IaWUmARQbjqZ4kU6hLTUyLy2A5wPMuDrximngCGWcJncatY80GHwlySBSiYnZ+++zUyl6zgpQ==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr2143879wmg.21.1549623806030;
        Fri, 08 Feb 2019 03:03:26 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id h62sm2152740wmf.11.2019.02.08.03.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 03:03:25 -0800 (PST)
Date:   Fri, 8 Feb 2019 11:03:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFT PATCH 7/9] mfd: axp20x: add USB power supply mfd cell to
 AXP813
Message-ID: <20190208110323.GK20638@dell>
References: <20190207064535.9226-1-wens@csie.org>
 <20190207064535.9226-8-wens@csie.org>
 <20190207110247.GE20638@dell>
 <CAGb2v66uC=ZUj3S3ceVHABg68WMuyfHPcG77CV1DjCNn9ff71A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v66uC=ZUj3S3ceVHABg68WMuyfHPcG77CV1DjCNn9ff71A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2019, Chen-Yu Tsai wrote:

> On Thu, Feb 7, 2019 at 7:02 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 07 Feb 2019, Chen-Yu Tsai wrote:
> >
> > > From: Quentin Schulz <quentin.schulz@bootlin.com>
> > >
> > > The AXP813 has a VBUS power input. Now that the axp20x_usb_power driver
> > > supports this variant, we can add an mfd cell for it to use it.
> > >
> > > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > [wens@csie.org: add commit message]
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  drivers/mfd/axp20x.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > > index 3c97f2c0fdfe..17b115845993 100644
> > > --- a/drivers/mfd/axp20x.c
> > > +++ b/drivers/mfd/axp20x.c
> > > @@ -198,6 +198,12 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
> > >       DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> > >  };
> > >
> > > +/* AXP803 and AXP813/AXP818 share the same interrupts */
> > > +static struct resource axp803_usb_power_supply_resources[] = {
> > > +     DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> > > +     DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> >
> > Nit: Why 2 spaces here?                              ^
> 
> 2 spaces? I'm only seeing one.

Eh, that's odd.  My eyes must be failing me.

Just add my Ack then. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

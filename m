Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FDC282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74D82148D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG7fmttc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfA0Kim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 05:38:42 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39066 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfA0Kim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 05:38:42 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so15500565itl.4;
        Sun, 27 Jan 2019 02:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybBP+IUw0wA6yvj6uUeWUOT7wvGHqpFpF4qMfyRcWAM=;
        b=bG7fmttcrAu/Ib97423dO1HX/u6b6j2OiH72pNWCm9YsSPr+CkbvNLaO0+qS0NdiWH
         HfFdW3rJnBrpDG6II8cyG/0GS8Ugk4WYPOgCdZX6GVfQsIaK/vivWBNslH+jaiEhnQR6
         f7sE60jq+WEeDxqydzM+HAOVSFy3XOfkadkxnLT5t+U5xQQz43RFKYjx0h6mGN9394Lu
         bzPX2EKfQZ7tL05oRBJtYqNT+q1e21AmnGOLw5bUoACAmhXAeUD2xFtroammMMN710vz
         fBy+yeKZ1COMftUdn7E0nj1C9LY5Z+8pwth2zEnl0RmbyQlSuadtA4eTnyLHX3itaBQk
         Tt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybBP+IUw0wA6yvj6uUeWUOT7wvGHqpFpF4qMfyRcWAM=;
        b=Ars4TWGSZt0lHZsMWDOa7jXiHvk93Pv5tZdGFEUdofAivvqXJAW7a6ovmXbVoMQ1yg
         jmOQd8uA/bEHFOM3fqmar3f1WmUjQE9xtYJQjsUH09fjHos7XmT1ZsbKabzE/sXKieZG
         H8U5aNGnrdkKJ67dbf96hcwni66fqxcLSSIv0GM8z+LZoZSNujHFTW81xrkjpNjmJHjB
         ProE1Aki/vBj9qnjELlcgqp5gBNAm8dFx6RvuQPXrvSq9VBAF0WXwvH5eoq4AEOHCD6V
         pjGdce7Ut4XoFh0qZVc4nAt6tLOO2XFIb2KIVwvPmn8EWE2U3p2+HC+ihJ04CyQDd1lr
         5sdQ==
X-Gm-Message-State: AJcUukeSclvdRSX5Fp/hAB99UUYAXWpR380nyEmTrQqUr3YTbHm83du8
        6JtkkRZ2yDjlD/ApizHxjbHGLoi9kfyXuKkh7us=
X-Google-Smtp-Source: ALg8bN6auXmMl/eBky+INoX6daFtX2dvE4FectWVTRTKUn3QD9JPQcoJApENBpBky3q1IeDwMvvAWPCFL9rx9wfzzjc=
X-Received: by 2002:a24:80d2:: with SMTP id g201mr8084982itd.63.1548585520921;
 Sun, 27 Jan 2019 02:38:40 -0800 (PST)
MIME-Version: 1.0
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com> <1547801609.2626.5.camel@pengutronix.de>
 <AM0PR04MB42111D634F28492434AA9309809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1547806960.2626.9.camel@pengutronix.de> <AM0PR04MB42111FE266342A2C2EAECC3580980@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1548154758.2465.20.camel@pengutronix.de> <AM0PR04MB4211B9003857795EBC79541480980@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1548161549.2465.24.camel@pengutronix.de> <AM0PR04MB42114F3D625CC48343EA427080980@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1548412956.28802.41.camel@pengutronix.de>
In-Reply-To: <1548412956.28802.41.camel@pengutronix.de>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Sun, 27 Jan 2019 18:38:29 +0800
Message-ID: <CAA+hA=TmBBTaNtmWFEX62LViwPKsBTvv-jWcwU7a7K7yh=JhYQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts support
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

[...]

> > > The fsl,irq-groups property is exactly your NINT32 parameter above. I just
> > > wrongly assumed that it's always in multiples of 64, as that's what the
> > > i.MX8MQ DCSS irqsteer module looks like. We should fix this and be done with
> > > it.
> > >
> >
> > No, not exactly the same thing. Using group will confuse people that the group is 32.
> > However, internally Group is fixed 64 interrupts although it may not use all the
> > 64 interrupts. E.g. 32 interrupts.
> > See CHn_MINTDIS register which is also defined fixed to 64.
> >
> > The two HW parameter for integration is already very clear. We should use interrupts
> > Number for the channel. Not group.
>
> Okay, I see that the name irq-groups is confusing for you. But then I
> find the -per-chan naming confusing.
>
> So given that we seem to agree to split each channel into it's own DT
> node, there is no need to name the property "something-per-chan", as
> it's implied by the split DT nodes that all properties in one node are
> referencing a channel.
>

Double checked with IP module owner by looking into the RTL code,
writes to CHANnCTL registers have no effect.
This register is reserved and the doc will be updated.
Verified on both MX8QXP and MX8MQ.

All channels are isolated and have independent programming model.
So it will be okay to define them separately in device tree.

> May I suggest to name the property "fsl,num-irqs"?

Sounds good to me.

Regards
Dong Aisheng

>
> Regards,
> Lucas
>

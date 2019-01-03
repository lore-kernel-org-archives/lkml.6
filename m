Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79685C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFCB2176F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546536192;
	bh=NEuyCgKqdg15OGCwdBHH/5HtSUOGjbTv9Q4LQClmY8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IrMFWYIPVpI4dmJLUMJsxaLf7+4UHPjqFozz9uPAPl2k/Q4hVtlmFobLFxwA5xJvo
	 c4ISzFEU8gJeEk3UJoXq0wZw/NtTLV2Be3G5b4njJ7tkKD6lJroZIYShbnsUue/Y6X
	 jxGCGMnb1+qK2/z4tCynpclcOm3heACbjvFSbdlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbfACRXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:23:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41408 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbfACRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:23:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so29957618otk.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 09:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+Algh/Ysyc2qh0ZVeiaQBZGmFP+zB1c7uxH2nEn/v4=;
        b=hT9yHTgY/LFzvYQbbuzbQu4ETXfDT/8UF4enthB+9UXZXwOHpTN1aj7QqTYQXyaPwm
         Btb+DJFMVFyOdQlu3Co4SyVLdl5gCCS7YbNcukfNWKskJ/Ad3WqRl4yO8EVuBicjEX6/
         qFvIFcRlzNZfOQsV9z3JHrcXnncE/+aiB1qW6iN60sglQc5S9WSArFdVEJEUzFmI6DsN
         cXciZr5dzf+yfaHG8aMKB7rx49TO+s0YFhxc1AUtF8fhqdL2ORkSwXikjBN96Oke8xu9
         f5jo2UqDHvF6Sc4r7bkeph2AgFo8K8zyC9vWHPACYNbHhrPstapvGXJlPbIZk+vAIlOa
         ywiA==
X-Gm-Message-State: AJcUukdeENBHxX4kXiGWRF7jbVzuBUhGBskcQMlQyRCqEAw+jGRuNOsY
        YGrKogB7uNmudK7Dcfza5OTJJCCA2oHEJ2yvpX4=
X-Google-Smtp-Source: ALg8bN4BW3f84jWlcOVu8qCZefasXC5VB9c2tgXpmhzdTqTmpOrIg2Js0+29sLhBYpBeetofjeWwRahjN+3vGjAIbtQ=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr32154029otn.200.1546536188072;
 Thu, 03 Jan 2019 09:23:08 -0800 (PST)
MIME-Version: 1.0
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20190102185106.56913-1-swboyd@chromium.org> <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
 <154653191998.15366.14229484132412159772@swboyd.mtv.corp.google.com>
In-Reply-To: <154653191998.15366.14229484132412159772@swboyd.mtv.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Jan 2019 18:22:56 +0100
Message-ID: <CAJZ5v0hwhuerPoizdYjqNkdymxubOweZ3JhPiXRUcrNtByz_=Q@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: platform: Add an error message to platform_get_irq*()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        javierm@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 5:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rafael J. Wysocki (2019-01-03 01:40:26)
> > On Wed, Jan 2, 2019 at 7:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > @@ -130,6 +125,22 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> > >         return r ? r->start : -ENXIO;
> > >  #endif
> > >  }
> > > +
> > > +/**
> > > + * platform_get_irq - get an IRQ for a device
> > > + * @dev: platform device
> > > + * @num: IRQ number index
> > > + */
> > > +int platform_get_irq(struct platform_device *dev, unsigned int num)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = __platform_get_irq(dev, num);
> > > +       if (ret < 0 && ret != -EPROBE_DEFER)
> > > +               dev_err(&dev->dev, "IRQ index %u not found\n", num);
> >
> > Why don't you log the error code too?
> >
>
> I don't see much benefit to seeing -ENXIO or -EINVAL printed here, so I
> left out the error code.

OK, so the value of the message is to tell the user that some driver
asked for an invalid IRQ, right?

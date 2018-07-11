Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFAFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A0F208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Qivygn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A0F208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbeGKSTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbeGKSTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:19:00 -0400
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com [209.85.223.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A96620C0B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531332809;
        bh=JDToTqyJJQ6cciA0s6ONBo++EQNaafipnL5viEyeXCM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F2QivygndEgxEj9XpMAgs++Cut0UqCoV7b0+kFCkaEFzW6lkslzE262p4UGXa1CH3
         eSDNSYsrCZfC7K71HmtGBb6SvzF/al68H2IuBCL/sT3uLjuQDC01Qh9x+0vk7JkH/+
         ctJoCqDITLyvDzb62hNewsQdvwL3G8YWbfQnIV1Q=
Received: by mail-io0-f180.google.com with SMTP id i18-v6so9203331ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:13:29 -0700 (PDT)
X-Gm-Message-State: AOUpUlHcQZKPW2mPvRaMGniLneCgvPQJq1O46QPXRNRCYZp6O7Trt+Yq
        +2BCueZIwocimxhY3bVTLSqQ6DNFb227+SWLjw==
X-Google-Smtp-Source: AAOMgpfx61mivqN2cnYpp0mYJ0yzvXEr3qhH9x/7fvRV5O0vzqySf3xBNG86rXKBFvRnutWkmNoRIv5BXzIeI1wVei4=
X-Received: by 2002:a6b:a10d:: with SMTP id k13-v6mr309733ioe.669.1531332809086;
 Wed, 11 Jul 2018 11:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180619214020.18608-1-robh@kernel.org> <CAL_JsqLfnSOgOMdaJU3Q4h5_PGnNgd4rx+vKXdFVZnNEo6+JZA@mail.gmail.com>
 <20180711161443.GY16084@piout.net>
In-Reply-To: <20180711161443.GY16084@piout.net>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Jul 2018 12:13:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzv4=Vpej3kbjMBkFFOpJE_KQRgYr=Svftd_xs-Bj3-g@mail.gmail.com>
Message-ID: <CAL_JsqKzv4=Vpej3kbjMBkFFOpJE_KQRgYr=Svftd_xs-Bj3-g@mail.gmail.com>
Subject: Re: [PATCH] ARM: at91: remove unnecessary of_platform_default_populate
 calls
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:15 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi,
>
> On 09/07/2018 09:50:47-0600, Rob Herring wrote:
> > On Tue, Jun 19, 2018 at 3:40 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > The DT core will call of_platform_default_populate, so it is not
> > > necessary for machine specific code to call it unless there are custom
> > > match entries, auxdata or parent device. Neither of those apply here, so
> > > remove the call.
> > >
> > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  arch/arm/mach-at91/at91rm9200.c | 5 -----
> > >  arch/arm/mach-at91/at91sam9.c   | 5 -----
> > >  arch/arm/mach-at91/sama5.c      | 5 -----
> > >  3 files changed, 15 deletions(-)
> >
> > Ping?
> >
>
> This breaks the platform in two different ways:
>  - PM is not working anymore because of the missing SRAM node
>  - the pinctrl driver fails to probe and so many drivers are
>    deferring the probe forever
>
> Relevant messages (once the earlycon crap is removed to let earlyprintk
> do its job):
>
> at91_pm_sram_init: failed to find sram device!
> AT91: PM not supported, due to no SRAM allocated

So the at91_pm_sram_init function tries to get SRAM platform device,
but it doesn't exist yet. Of course, that is fragile because while the
device may exist, it's just luck that it's driver has probed already.
Would using .init_late hook instead of .init_machine work for you?

Ideally, couldn't much of this code be converted to a driver? It's a
bit strange for initcall code to have a driver dependency.

>
> pinctrl-at91 ahb:apb:pinctrl@fc06a000: you need to specify at least one gpio-controller
> pinctrl-at91: probe of ahb:apb:pinctrl@fc06a000 failed with error -22

So this one has the strange dependency that the child nodes probe
before the parent node. That's backwards. Probe order is probably
changing from link order (all the devices are created before drivers
register) to device creation order. I think the fix is the pinctrl
driver should just count the gpio child nodes rather than relying on
aliases (which I'm not a fan of either). I can write a patch to do
that.

Rob

Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256E2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD72320671
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzd7QSX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD72320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbeKVH2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:28:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389689AbeKVH2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:28:38 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C022087E;
        Wed, 21 Nov 2018 20:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542833561;
        bh=ivgmxi3wKxSciyvdTCKKeTbJY4+d1yoHcggBVSz6nyE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mzd7QSX3A+Ce7JaBeKwSxmCQoljpG1ixW5my8kcl7uKWc6WprEHIg7tkVZ3EmCuh+
         OQEeTbgsHMoiaNo3X49KURlMId1DpWJNeCwiVn+PgjjF/fc2sZmW7Z1jRCdClCxEfi
         tmSPfD+Jzk0ZsGtPKD5orEeRurXouR15vOLppgGU=
Received: by mail-qt1-f172.google.com with SMTP id k12so5354150qtf.7;
        Wed, 21 Nov 2018 12:52:41 -0800 (PST)
X-Gm-Message-State: AGRZ1gKMmyGN5M9TZjJWvNtli7+upsYkw5AM5Z04yX66sQ4+3ZCQMktd
        U+gExCkSLvdMgpkpwLjEHIZDS0uA/Af2JPhrag==
X-Google-Smtp-Source: AJdET5flt676YLNQQ+6h6fLqH9j1tg7rjW7SHqNtYVo4iF+PG24dO9XyDmeog7+7BRwDe4DgAp/O+2mhc1shPwwmI/o=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr7642572qts.144.1542833560284;
 Wed, 21 Nov 2018 12:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
 <20181121112732.15690-3-radu_nicolae.pirea@upb.ro> <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
 <20181121164820.GC12656@piout.net>
In-Reply-To: <20181121164820.GC12656@piout.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 21 Nov 2018 14:52:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLO_L+rTZh70nrpBMU1+CYKct7HhNY0gLGUnU7=JVRuQw@mail.gmail.com>
Message-ID: <CAL_JsqLO_L+rTZh70nrpBMU1+CYKct7HhNY0gLGUnU7=JVRuQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel-usart: add DMA bindings for
 SPI mode
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     radu_nicolae.pirea@upb.ro,
        Richard Genoud <richard.genoud@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.co>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:48 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi Rob,
>
> On 21/11/2018 10:41:01-0600, Rob Herring wrote:
> > > +Optional properties in serial and SPI mode:
> > > +- dma bindings for dma transfer:
> > > +       - dmas: DMA specifier, consisting of a phandle to DMA controller node,
> > > +               memory peripheral interface and USART DMA channel ID, FIFO configuration.
> > > +               Refer to dma.txt and atmel-dma.txt for details.
> > > +       - dma-names: "rx" for RX channel, "tx" for TX channel.
> >
> > > +               dma-names = "tx", "rx";
> >
> > The dma-names should have a defined order.
> >
>
> Why is that? Isn't the purpose of names to get rid of any particular
> ordering?

Because a fundamental rule of DT is the order is defined and
important. The purpose was to allow for cases that had a variable
number of entries, but even a variable number still have a defined
order.

Rob

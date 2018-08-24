Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E88CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93DC208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDX1WX2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93DC208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeHXTKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeHXTKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:10:46 -0400
Received: from mail-qt0-f176.google.com (mail-qt0-f176.google.com [209.85.216.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F2421564;
        Fri, 24 Aug 2018 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535124936;
        bh=l1A3fnVYnOMEUPTllTpTvDLqn+ovh7m18ibAO6Gfg1M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MDX1WX2UMhMyCe1GbdZIYdyVwe3+LwMPA5Rj4pDQuVt9QeBGelnC4QTZ7ZxMhZJeL
         /ZeOT+BrG9RX03dM86cZfBiZRNL+7eZ8Apgnyi2sKCoPZ9X4roxvLT1knJn1gLO59+
         dgY2Hp3a/LwIlw9emfV59suWWtWz2Am3t1zW7dzE=
Received: by mail-qt0-f176.google.com with SMTP id o15-v6so10576493qtk.6;
        Fri, 24 Aug 2018 08:35:35 -0700 (PDT)
X-Gm-Message-State: APzg51DE6PRILyZ9eF9gIMRC0PTzRzavvPrTev/jj27vKA29KsU5uW5g
        JByDuK5zLPttQoI3AYFrx9Ds3Ds0hEZHZsmXNw==
X-Google-Smtp-Source: ANB0VdZqIHkh8jleOE/OYidg3DRxaGf7dx4T1nqTA6PFPkvP6EknnpjJW3FQFu+5oouWOR4657fzVn/e3qcVJtT5WZw=
X-Received: by 2002:a0c:95f7:: with SMTP id t52-v6mr2329708qvt.246.1535124934996;
 Fri, 24 Aug 2018 08:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org> <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org> <20180820153207.xx5outviph7ec76p@flea>
 <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
In-Reply-To: <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 Aug 2018 10:35:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKMPm=qmfYMQH99_gqSv0-ynUSvbkoNjjeDKtyxfgE1tg@mail.gmail.com>
Message-ID: <CAL_JsqKMPm=qmfYMQH99_gqSv0-ynUSvbkoNjjeDKtyxfgE1tg@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider bindings
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 9:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Maxime,
>
> On 08/20/2018 06:32 PM, Maxime Ripard wrote:
> > Hi Georgi,
> >
> > On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
> >>> There is also a patch series from Maxime Ripard that's addressing the
> >>> same general area. See "dt-bindings: Add a dma-parent property". We
> >>> don't need multiple ways to address describing the device to memory
> >>> paths, so you all had better work out a common solution.
> >>
> >> Looks like this fits exactly into the interconnect API concept. I see
> >> MBUS as interconnect provider and display/camera as consumers, that
> >> report their bandwidth needs. I am also planning to add support for
> >> priority.
> >
> > Thanks for working on this. After looking at your serie, the one thing
> > I'm a bit uncertain about (and the most important one to us) is how we
> > would be able to tell through which interconnect the DMA are done.
> >
> > This is important to us since our topology is actually quite simple as
> > you've seen, but the RAM is not mapped on that bus and on the CPU's,
> > so we need to apply an offset to each buffer being DMA'd.
>
> Ok, i see - your problem is not about bandwidth scaling but about using
> different memory ranges by the driver to access the same location. So
> this is not really the same and your problem is different. Also the
> interconnect bindings are describing a path and endpoints. However i am
> open to any ideas.

It may be different things you need, but both are related to the path
between a bus master and memory. We can't have each 'problem'
described in a different way. Well, we could as long as each platform
has different problems, but that's unlikely.

It could turn out that the only commonality is property naming
convention, but that's still better than 2 independent solutions.

I know you each want to just fix your issues, but the fact that DT
doesn't model the DMA side of the bus structure has been an issue at
least since the start of DT on ARM. Either we should address this in a
flexible way or we can just continue to manage without. So I'm not
inclined to take something that only addresses one SoC family.

Rob

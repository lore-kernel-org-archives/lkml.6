Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D05C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13A721756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1ALE0oZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13A721756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbeHNBcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730213AbeHNBcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:32:35 -0400
Received: from mail-qt0-f176.google.com (mail-qt0-f176.google.com [209.85.216.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B209121756;
        Mon, 13 Aug 2018 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534200497;
        bh=y+XrAfhKxp1ox/BFHL9TNgkKEoS4DCzOvSBaT2D2yNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1ALE0oZbfBUIVdTSBzvxUJqxrXNzy+1JAttDfkW44nwNcyh/wzDnzr28vooDVnili
         Y7qZGETGx2FCCtDW+dJB2mkvPVvYNteIGE9eaHl0HCc6bo5HqTvCkWz3IKFnhiYVAy
         DHScVkr5IZ2hCeOqgIETcmFtAxtK506OmRsYFDUo=
Received: by mail-qt0-f176.google.com with SMTP id f18-v6so19252706qtp.10;
        Mon, 13 Aug 2018 15:48:17 -0700 (PDT)
X-Gm-Message-State: AOUpUlGwe5Xt05T7m2ewd/B2sF9FyszyBHSeQAi21dBMpgCydGXN6FvX
        LC7AAYjon0z65ixmbeu8DyFUj8V7rh98Eoe/ow==
X-Google-Smtp-Source: AA+uWPwf4nEMyK+zzhlevIlHrHNGZHaGuoDvIqSZrkgCQ/cvy5ZxzPwYPd1PK8YpTWsgVG+0EIeQofs9FN/gs+K1EtQ=
X-Received: by 2002:ac8:29a4:: with SMTP id 33-v6mr19570899qts.354.1534200496948;
 Mon, 13 Aug 2018 15:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180809192944.7371-1-kieran.bingham@ideasonboard.com>
 <20180813174544.GA11379@rob-hp-laptop> <dedade62-91ed-2c92-dac7-fe4a8f9d9452@ideasonboard.com>
In-Reply-To: <dedade62-91ed-2c92-dac7-fe4a8f9d9452@ideasonboard.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Aug 2018 16:48:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQNtRNq+b3sJ4eEse1pzWy3F-WgbDF7=t-TrvFx6WcUQ@mail.gmail.com>
Message-ID: <CAL_JsqJQNtRNq+b3sJ4eEse1pzWy3F-WgbDF7=t-TrvFx6WcUQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: media: adv748x: Document re-mappable addresses
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 1:17 PM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Rob,
>
> On 13/08/18 18:45, Rob Herring wrote:
> > On Thu, Aug 09, 2018 at 08:29:44PM +0100, Kieran Bingham wrote:
> >> The ADV748x supports configurable slave addresses for its I2C pages.
> >> Document the page names, and provide an example for setting each of the
> >> pages explicitly.
> >
> > It would be good to say why you need this.
>
> In fact - I should probably have added a fixes tag here, which would
> have added more context:
>
> Fixes: 67537fe960e5 ("media: i2c: adv748x: Add support for
> i2c_new_secondary_device")

That doesn't really explain things from a DT perspective.

> Should I repost with this fixes tag?
> Or can it be collected with the RB tag?

I'll leave that to Hans.

> > The only use I can think of
> > is if there are other devices on the bus and you need to make sure the
> > addresses don't conflict.
>
> Yes, precisely. This driver has 'slave pages' which are created and
> mapped by the driver. The device has default addresses which are used by
> the driver - but it's very easy for these to conflict with other devices
> on the same I2C bus.
>
> Because the mappings are simply a software construct, we have a means to
> specify the desired mappings through DT at the board level - which
> allows the boards to ensure that conflicts do not appear.
>
>
> > Arguably, that information could be figured out without this in DT.
>
> How so ?
>
> Scanning the bus is error prone, and dependant upon driver state (and
> presence), and we have no means currently of requesting 'free/unused'
> addresses from the I2C core framework.

True. But assuming all devices are in DT, then you just need to scan
the child nodes of the bus and get a map of the used addresses. Though
if you had 2 or more devices like this, then you'd need to maintain
s/w allocated addresses too. It could all be maintained with a bitmap
which you initialize with addresses in DT.

Rob

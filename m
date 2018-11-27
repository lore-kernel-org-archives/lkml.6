Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3740AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0074020873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdc67awt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0074020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbeK0Vsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:48:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43572 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeK0Vsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:48:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id 83-v6so19595223ljf.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BCbWUpsxHePFLT02LVLlMQFhl4fVbW9t4TnotjDdbA=;
        b=gdc67awtQ9dC3ocimxMbVgMJv14dp84xjn0TLUsJ+L38wIOWpJ7VHqUs365QxIbctc
         X2IrCXWo7VziVRqCI/kI0VFz8X8JLOZg2Gkg/al/kX9ShW8v3+yvo9uj08NINUMlfXx3
         5bLQp60zmiMZCkjbsNigQUZZzMX0Z12e5Gnfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BCbWUpsxHePFLT02LVLlMQFhl4fVbW9t4TnotjDdbA=;
        b=FTGYO2sRuBygnZrIdLsJhjaRq1+6IBRTgvzUIMrvSwIbYD3OLBV5o0KVZINfbXU2iN
         VAmJY766QrYfeXCWzf+5xKXYW5Z6ujAS03a5p1Pcr0z5jjxHFM42dP0EycSOFRYP8HgL
         XRxlWieNqkCrZLqP5jnwKxDDOWy94ZgS7Z7jJWawMdt0MpQM/ry+vZvDrZCJvN76j1Ls
         +Yb8hzUGRIUSszZyOfEmHkgPk2BE72GC3+MAkgENk08LK0ZYUEaIvmdp0+T82YzO5xLp
         YCI7OKKuUTF8mjOKsQXVW+EZGma8FllKlUifK1d4hiugPC8/cN9hxR62mXJnuEFVYIM6
         vgvQ==
X-Gm-Message-State: AA+aEWZKPauRrMPgakI5zIlKd5YZZiPEEDd89dPU5eLacDPy8yG8TCQ7
        9ewYzXjv4rvzK+FL+yPfTlOAHyIMa73E0VQpQX03uA==
X-Google-Smtp-Source: AFSGD/UdFfPjmvD7WdN/FZjIw3+CLEpbmrHke5B1WxlvFlHQIrEJsqIWWiOIFgfF9SdKW/si6XCWArz9k0SNesGwk6c=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr19371561ljk.4.1543315867237;
 Tue, 27 Nov 2018 02:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-3-ckeepax@opensource.cirrus.com> <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
 <20181123105729.GM16508@imbe.wolfsonmicro.main> <20181123132522.GE2089@sirena.org.uk>
 <CACRpkdZKJGFmYFKBHdiayRsA2ona2zWfJ+xckJxD1UBsj39=sA@mail.gmail.com>
In-Reply-To: <CACRpkdZKJGFmYFKBHdiayRsA2ona2zWfJ+xckJxD1UBsj39=sA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 27 Nov 2018 11:50:54 +0100
Message-ID: <CACRpkdZoX0pTqWwvhj__kVtnHqrYD4bJ0JaXzxBo8jOZEtd70Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:53 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> I suspect maybe the lesser evil is to bite the bullet, invent
> gpiod_get_from_of_node() which is the missing API (we currently
> only have devm_gpiod_get_from_of_node()) and simply
> fix up the converted regulator drivers to avoid devm_*
> retrieveal in the same manner as wm8994 (the already
> queued patch). This will make the regulator core own the
> refcounting as it does today.
>
> It's a bit unelegant but it's very straight forward and I know
> I can fix it up qucikly.

I cooked a series like this, just taking it for a ride on the
0day build server before sending it out.

Yours,
Linus Walleij

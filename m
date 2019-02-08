Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D367CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46E62146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzpPKauB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfBHRPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:15:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42692 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBHRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:15:16 -0500
Received: by mail-qk1-f196.google.com with SMTP id y140so2523997qkb.9;
        Fri, 08 Feb 2019 09:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1xMQEVP6TCnc/SzTIcoGln/5cNGj6+SOvsEQlmB7EdI=;
        b=GzpPKauBCrG1z8aNFgM7xAA6svfg7EwUKVbwNOnB5PWR1leCjIH5oWtkQSBBTUFu7Z
         WjTkJF5yuzLk6kaCrstA06WDvMFkNn380lAm7HF0I39j+1VmQxjDtNAVGWZJnF66s2hh
         C3D3MmNugmuP2zMVmte2UR/hRrp+si8gatkBmTcE9cehrkZlJKh2yA+GU68c3PLwuVvk
         jYeY/ydRdq31ahgzPqJx0TiGXkDyYCG5thcAeH3dfOxV/hcaV8G7MY4w66IeOur+Hg/Q
         HE/hPS64JIPKPiYRycbRZguvW/vedH0J4HFgx6S7wfcn5AUoEAHyxAGoNARJ1F34fR2L
         bGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1xMQEVP6TCnc/SzTIcoGln/5cNGj6+SOvsEQlmB7EdI=;
        b=EtEwQt5HefUnfWXlDiPcmhirFFGwnUqok5XUsXPq5f6sngJh4TDMhTfGclmZp8r6Ru
         1fKTaskRs1yZDmVqEjfgXuyqNS/xpBc6kf9gNY2iNr0F+pJALyWvzn86TdeqrHA6ZT74
         LfhWmtwV/l2AUuSC2VkrZ6/JM4N2KIbz47BJRvhImNDkc7bbOMC8ZkxetOxCBY6DXcRs
         TKMkWVgqt96Z8busbBpEJ35FCNRu8Z5L4x/nbhfB3o94VR71i1StwlVJCsaP+925XRJq
         cUJZS8uh076OLVt2H3v83TGlaM6PZadv7vEJwDnDOwlJ/25ymI+d4lO8h/wL/An5H0Xv
         wkYw==
X-Gm-Message-State: AHQUAuZt/BLGUOvNkkTMiSFi3JIK6WyGKRqYGZ+iJvtZ0Fh7CPsbUPQt
        zmEQmOSe25eVkONda0UfUOu0bIZjsY50G5EBs5Y=
X-Google-Smtp-Source: AHgI3IYb+IzHFn3uuHznRr8bRB4134rOHzqFQEoXipSlrf5o0H3GtcrUZJPjWARC7dqcynTwmGUVYAPfJFawS1vssuo=
X-Received: by 2002:a37:be84:: with SMTP id o126mr17102368qkf.312.1549646115541;
 Fri, 08 Feb 2019 09:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20190208012312.105259-1-ncrews@chromium.org> <20190208012312.105259-5-ncrews@chromium.org>
 <4620e71f-9579-0d4e-2cf8-7851e77e81fc@collabora.com> <CAHX4x86pqUoo+v3FK3zY8Dyxgia9L8iGsYVYnfBA-OvRAm9HDw@mail.gmail.com>
In-Reply-To: <CAHX4x86pqUoo+v3FK3zY8Dyxgia9L8iGsYVYnfBA-OvRAm9HDw@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 8 Feb 2019 18:15:04 +0100
Message-ID: <CAFqH_534v=_LxwVVn51SXmeocggvYQVjzq2GOvFs=mm7A7qhkA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] platform/chrome: rtc: Add RTC driver
To:     Nick Crews <ncrews@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Duncan Laurie <dlaurie@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dlaurie@chromium.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,
Missatge de Nick Crews <ncrews@chromium.org> del dia dv., 8 de febr.
2019 a les 17:10:
>
> Hi Enric and Alexandre,
>
> On Fri, Feb 8, 2019 at 5:18 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi,
> >
> > On 8/2/19 2:23, Nick Crews wrote:
> > > This Embedded Controller has an internal RTC that is exposed
> > > as a standard RTC class driver with read/write functionality.
> > >
> > > The driver is added to the drivers/rtc/ so that the maintainer of that
> > > directory will be able to comment on this change, as that maintainer is
> > > the expert on this system. In addition, the driver code is called
> > > indirectly after a corresponding device is registered from core.c,
> > > as opposed to core.c registering the driver callbacks directly.
> > >
> > > To test:
> > >> hwclock --show --rtc /dev/rtc1
> > > 2007-12-31 16:01:20.460959-08:00
> > >> hwclock --systohc --rtc /dev/rtc1
> > >> hwclock --show --rtc /dev/rtc1
> > > 2018-11-29 17:08:00.780793-08:00
> > >
> > >> hwclock --show --rtc /dev/rtc1
> > > 2007-12-31 16:01:20.460959-08:00
> > >> hwclock --systohc --rtc /dev/rtc1
> > >> hwclock --show --rtc /dev/rtc1
> > > 2018-11-29 17:08:00.780793-08:00
> > >
> > > Signed-off-by: Duncan Laurie <dlaurie@google.com>
> > > Signed-off-by: Nick Crews <ncrews@chromium.org>
> >
> > I think that you missed :)
> >
> > Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >
>
> Ah, I removed these because this version is a bit different from the
> one that you Acked. Do you normally keep those sign-offs
> even after making changes that you possibly might not like?
>

Well, it's right that you did a small change in the core, so to be
strict maybe you have reason, but I don't see as a big change so I
expected you maintain my tag. Anyway it's not a problem at all, just
that at least I expected the Alexandre ack :)

[snip]

> >
> > Alexandre, this specific patch depends on the patches of the series to apply,
> > and the first patches of the series also conflicts/depends on some patches
> > queued in chrome-platform-5.1 branch [1]. Is it fine with you if I create an
> > immutable branch and all go via your tree? Or what do you think? I am new here
> > and I am not sure how to manage that.
> >
> > Thanks,
> >   Enric
>
> Let me know if I can help with this. I based this off what I thought was the
> most current master, SHA 74e96711e3379fc66630f2a1d184947f80cf2c48.
> Was this not the correct commit to base these off of?
>

Yeah, it's fine, just that I queued recently some changes and I have
trivial conflicts in Kconfig and Makefile, nothing that you need to
worry.

[snip]

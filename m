Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2929C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F6320685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iv234rAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfAIWPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:15:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36672 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAIWPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:15:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so7659698oix.3;
        Wed, 09 Jan 2019 14:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y20vyWCNfVs+m7NNZt80MMEIx2g9VSVEjKCx98AL8Io=;
        b=iv234rAtcDgwWLa+LY9sZhNlZpZlVvhQKUCzM5JF6cQmOUMRsCWJq2mtNCdjuRtiZl
         9swjh5oJetfMm3tsxTXCYcaNyosYfEcDugMfSPlu7f00sS2CAW1EJq3je3HauJJvw2e9
         khXz+1aSe4p/OomWk3beJivi3icV1bE4pK8fVEdvRNTKMCHZSQT0vhjdBWYcG4Nc3nFa
         4lMzYeLkebCu/9R46cgzPy3W2uUZmkGmRKovflOgu7e5EVpUMkEEvpELfxQThZn5n2Bk
         iX9F8yR8zUxLZjAthiMpSP9rkBT3HiOi/i5Ma3rGkYEF6cfub4w//zh1o+iptReubFCc
         U5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y20vyWCNfVs+m7NNZt80MMEIx2g9VSVEjKCx98AL8Io=;
        b=ayTDXUd0purRn+XCC52FSpF/3qoEyJu1tsIqv+9YQ7MlMoKr9IXhowLOr8pdMG59dQ
         c6qqG5BAoz4nKbbUb/BXZQV7RjIuVd2NUulRsIAYATqi8CKmzXIgfJXbySFo/cQdtXG+
         W7C1PEx1giPkS7qp+fB8irPleF1F60nhGeaclmOdQ8qt8FZCC98kNRHIrv9Mze3qI8Hz
         8GMMjzSj2OYETocwj9byJbsPx2Q97xeS24gen7iKjmutfqx39ISflWx7MzSLdU8Azsgy
         2WOlyuEpjirFCtVEE+wFN/GywEirR/NxJTwJf4R6fpdXUY5bOI2XNt0W5p9m/zlBwY55
         Zgrw==
X-Gm-Message-State: AJcUukdowb73J2qjUwUfPdC7JwePsw0Ig02Ir0x8plLRMUbxtcA/VdzY
        lrcW1z16tTRMGqejHu+hOKFhqL7AJCCuVfuoUSM=
X-Google-Smtp-Source: ALg8bN7OHt5BPL8i7w5mIoSdh8CnFfeu2HUjv+4v+6dZBtVWkyVQ65ydAX6Hm76tcpcp4QKN+gKjXVpLf/WHYODKeqM=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr4768763oib.41.1547072108641;
 Wed, 09 Jan 2019 14:15:08 -0800 (PST)
MIME-Version: 1.0
References: <1547042198-17601-1-git-send-email-lollivier@baylibre.com> <CACRpkdbhVB7-Y9EBhBC6GAxqFt8zujS2QJ4CzGDJnDMDjj2Ptg@mail.gmail.com>
In-Reply-To: <CACRpkdbhVB7-Y9EBhBC6GAxqFt8zujS2QJ4CzGDJnDMDjj2Ptg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 9 Jan 2019 23:14:57 +0100
Message-ID: <CAFBinCBf+yJu4z1JYNdH7B4h07-U_0ckysV_=nC65nd5ByOCvA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: meson: Fix mmc cd-gpio polarity
To:     Linus Walleij <linus.walleij@linaro.org>,
        Loys Ollivier <lollivier@baylibre.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 9, 2019 at 7:31 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Ollivier!
>
> On Wed, Jan 9, 2019 at 2:56 PM Loys Ollivier <lollivier@baylibre.com> wrote:
>
> > Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> > changed the behavior of "cd-inverted" to follow the device tree bindings
> > specification.
> > Lines specifying "cd-inverted" are now "acitve high".
there's a typo in the description - it should be "active"

> >
> > Fix the SD card for meson by setting the cd-gpio as "active low" according
> > to the boards specifications.
> >
> > Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> >
> > v2: fix more occurences, also in other meson boards.
>
> This is a good change in itself since it gets rid of some occasions
> of the dreaded "cd-inverted" property. I think Martin Blumenstingl
> already sent patches like these though (I might be confused).
I sent patches for the 32-bit Amlogic SoCs
my TODO-list is now a bit longer, I'll test this series on my Khadas
VIM, VIM2 and Libretech CC during the weekend

> But we should keep the old device trees working as well.
> Can you test if Martins patch:
> https://marc.info/?l=linux-mmc&m=154637189021211&w=2
>
> Also makes your boards work?
feedback on that patch is appreciated


Regards
Martin

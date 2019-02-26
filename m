Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FCBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 01:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56339217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 01:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACiCPQPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfBZBlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 20:41:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54386 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBZBlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 20:41:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so776553wmh.4;
        Mon, 25 Feb 2019 17:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvqBVF6/EplBfAJqIU6ojB5Ni+SoAGx/lguGhyA2d08=;
        b=ACiCPQPQknEylWmhRTjZGrPhFidCC0TelnBtdK3vxeO2YbHAmse1he5XxyVSCbiSps
         6j/HyrCcBkHBj0Zm39bib4xJV2aI424mJxNajn3ISAcLsW4pQK+NGnEmFj18SGcgnE38
         QnyzYaux25MxruHiKVNeJ3BBfKtyiK1KKwyYlcwwqGw1zx41HpY2p4voIbtARRAFUWtD
         Pn/lFgzal1gj0fdAmYkrNa1XZw4OSMUp08j8F/MPVEQLTReM/pESFgFpyIV6Ju0IMRaL
         lgJT64OGmMPkrJMxqhI0RCev7wdDOfUcEu95QbGr2tgLFXznQ6D5Cd0sdJh9l1h3phqH
         E/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvqBVF6/EplBfAJqIU6ojB5Ni+SoAGx/lguGhyA2d08=;
        b=aWhdPJBWIqqjPVvO85v+WxhYincy0tCsNkHjuPQ69pM9dJdw5oKCBH1zE62MYiuiIx
         fBR+8VpX43NzOneJ9ou8t/YqPbN8P73AUZFup7rM9Z4WE+hcRSN7krc0JtQOv7IoP06+
         E3xr9GNgqbb1UQ0jMtXN8t0ygSO+tiLQrXlcu/H7klh+znIStzW4qhntLf5lxerPp6EB
         PMauR1JDow7xYzTKU5AN2S6/7qn6G03R5i3qKPPuf6BVHNexfm34ecgqDd16/6ysg7RH
         dUMPZq4GYD2QhDF89CUCxb+y4/yn8mxRozmrAaJyn1+ATDFxsjhjG2+Uvsaxq2c+hqTO
         m2Cw==
X-Gm-Message-State: AHQUAuYY0Mztg9jT5wrN4sMhr5jXd5FkwpXMwsoOwZ7LauiznDgGHwWT
        rVREzK7r6tQJNn57uPa9AVcoWp/1X3w9My5qDm8=
X-Google-Smtp-Source: AHgI3IZFGfV+WcOUqFW86WCQjExKD3Nj8jlew6MvK0yIyjxkI5D/aBoZn6NYSIh8v71xxhdkWO6ZZRnMMF/1vOn8w08=
X-Received: by 2002:a1c:a58c:: with SMTP id o134mr863246wme.79.1551145310359;
 Mon, 25 Feb 2019 17:41:50 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsmC5ckLXfQxSUn-tqxLZ4NofEyb9RA69Q07RUoxc79RQ@mail.gmail.com>
 <34c78d7f-cc3c-853d-b3fd-a70abdb66293@ti.com> <22ccca46-7390-1707-cfca-43b3577b79f2@ti.com>
In-Reply-To: <22ccca46-7390-1707-cfca-43b3577b79f2@ti.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 26 Feb 2019 09:41:38 +0800
Message-ID: <CACVXFVP0h-xvJaW1HaMrhozwhR484x0owc6XX63JT-59N08Fag@mail.gmail.com>
Subject: Re: Linux-next 20190218: am57xx-evm: mmc1: ADMA error
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        nm@ti.com, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 9:14 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi Naresh,
>
> + Commit authors.
>
> On 19/02/19 6:38 PM, Faiz Abbas wrote:
> > Hi Naresh,
> >
> > On 18/02/19 6:57 PM, Naresh Kamboju wrote:
> >> Do you see this error on am57xx-evm running Linux next 20190218 ?
> >> I have tested on multiple devices and found this error.
> >> Please find the full boot log [1].
> >> Am i missing any pre required configs [2] ?
> >>
> >> [    5.620263] mmc1: ADMA error
> >> [    5.623266] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> >> [    5.629740] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
> >> [    5.636215] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
> >> [    5.642690] mmc1: sdhci: Argument:  0x002cec70 | Trn mode: 0x00000033
> >> [    5.649162] mmc1: sdhci: Present:   0x01f00000 | Host ctl: 0x00000010
> >> [    5.655634] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> >> [    5.662108] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> >> [    5.668582] mmc1: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
> >> [    5.675055] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
> >> [    5.681529] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> >> [    5.688002] mmc1: sdhci: Caps:      0x21e90080 | Caps_1:   0x00000f77
> >> [    5.694474] mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
> >> [    5.700949] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffef
> >> [    5.707423] mmc1: sdhci: Resp[2]:   0x0f5903ff | Resp[3]:  0xd04f0132
> >> [    5.713896] mmc1: sdhci: Host ctl2: 0x00000004
> >> [    5.718364] mmc1: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xab868218
> >>
> >
> > I see this as well on my setup. Trying to bisect now. Will keep you posted.
>
>
> Reverting the following commit fixes this.
> commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Feb 15 19:13:20 2019 +0800
>
>     block: enable multipage bvecs
>
>     This patch pulls the trigger for multi-page bvecs.
>
>     Reviewed-by: Omar Sandoval <osandov@fb.com>
>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

Hi,

Thanks for your report & bisect.

Could you test the following patch?

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.1/block&id=8f4e80da764ec1ca44c83f3e17dbc9bf0209bccc

Or  simply run the latest -next?


Thanks,
Ming Lei

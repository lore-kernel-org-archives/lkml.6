Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4AAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E8C208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/I//tbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E8C208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756621AbeFOVFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:05:54 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40340 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756517AbeFOVFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:05:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id f79-v6so9978661oib.7;
        Fri, 15 Jun 2018 14:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XBj8E/SJTvSPju6Yn/wOW5dsq996saXrYCIOyeSK2N8=;
        b=d/I//tbWMOQpSLs0KaYeq07joNapM9jNoIIuLkPnI0uzPkYU7zksYrqgc0S6DFQIl1
         /qhVWh4IdhP3dchh6JAF5IitYqWq7dfoHQN1QBJoh+OO51yd72yV+G6CVvGTKi4OGJEx
         6Uh4HxXl4mUHuOkNJIvgKkpTS/Lc70JQG4o+74oy49mEfhW5MYZM7MoIQrzPDPFv38Hf
         scWqyA/RW0ulXiNysLqWLXXHUB/smDX9z3DVuJYIFwSvVQddQtm0LwRGrNmcXbbaMyOF
         tZOj+x4SCBi4myXJvich3FgT+vzGj9r2sYUO0agU3EQginhKwCzNRBCDM89cj3/reRdt
         AwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XBj8E/SJTvSPju6Yn/wOW5dsq996saXrYCIOyeSK2N8=;
        b=qlmXjZid8vuWA7q2BKmVyBYG1H9PAREWSNLkrHUDPtUuSWdHiLJ60g5Hua9pM9dsbC
         i5XmO6SCcI/rlTLP4O+BGuwQP/+nGxSEbdZ6L3p0zJO3Al2iSacVM2eLewsWel5DaoVx
         f5x8Wh2VX9V3wuxU3mGsD4GS4NHfLZaGafme6p1usFiW7wsa0yS+PjrFVev8g7Tfb5Le
         lZFH0bb4JrsYs1zcs2g9fLDERCCsaDIsVTUm5tRYoPQ0L/vVXLc4sv9p8EKfLmETmLKI
         LjO6CAPaglv70MVYKFI9RueczjyKQQ+zkkTXvEbTkIiZYoYRTiXGGvN8VBvgU7lOiqRf
         TjQA==
X-Gm-Message-State: APt69E0z+Bftg21c5lgPiT0X3qJJrwGdZDPtef77Aky7e7cXuV7FrVbo
        8htN/HrheySjXqYNoRYTLyvZwCk1EInGu1S7YIA=
X-Google-Smtp-Source: ADUXVKIVjEy1bf+t5VYqz5WJ0gWIJLqOWMarW6lB1DPiDcRUnkmYWLNR2XPYhGvDvmfWqhoQGJFO/vN+YAItTgV3i1A=
X-Received: by 2002:aca:3a45:: with SMTP id h66-v6mr1947474oia.336.1529096750973;
 Fri, 15 Jun 2018 14:05:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 14:05:50
 -0700 (PDT)
In-Reply-To: <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com> <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com> <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 15 Jun 2018 18:05:50 -0300
Message-ID: <CAOMZO5BnOpaCzK1Sq=CUPaO6Yh8bE6v=8dmN5pxTKpwqjM1Qfw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 5:58 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> In that thread there is a proposal for removing the old fbdev/mxsfb
> driver entirely.
>
> That would break old DTBs, isn't this generally considered bad? Also,
> are we sure the removal of fbdev/mxsfb wouldn't lose any features?

Yes, I also think we should not break old dtb's.

> What my series does is make both drivers work with the same kernel
> image and turns the choice into a board-level dtb decision. Supporting
> everything at once seems desirable to me and it allows for a very
> smooth upgrade path.
>
> The old driver could be removed later, after all users are converted.

Agreed.

Maybe the mxs fbdev driver needs to warn users saying that that the
driver is deprecated and the bindings need to be updated to the DRM
bindings style.

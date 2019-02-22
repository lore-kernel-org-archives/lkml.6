Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B34C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D102070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axjyqcht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfBVPrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:47:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40875 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:47:48 -0500
Received: by mail-oi1-f193.google.com with SMTP id x187so2034991oia.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 07:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=im1Jbglw+ir2dFYAy8wXs7UVMYyDCfuLQXc9xRKLwf0=;
        b=axjyqchtHlxWtBxodqEZeb/ybTYZTc5RBo8CRJkFat6Uo2IlNVSV2oZujcE1dvz8YJ
         6CBI7Ml9zTUIm908If2NcTvQFj1EDN9B1TJXLeBeLKmB78EsGx8umy17ZurKBzkUMc/p
         dfkatk2wRwlEF3U+jRx605QVDCZazwnBdWqvF6Kt7ARRmZbKw2XYnvpIE0phTfbvsB4Z
         if5DadVn0hVEEvjyqhF47zRyk4Gda7zys0ZYQmS8BWAklZPDGc64nPkte4qInpDMHHOU
         CiIqkKq1FxF4vsxhw9Lphkl22aXy0DeiOrmSLfXhTcXZgFaFGWH+2vc3IkvhJ5UJKKO/
         H+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=im1Jbglw+ir2dFYAy8wXs7UVMYyDCfuLQXc9xRKLwf0=;
        b=lzYfNBCR0XjxoH7Z4/geAw5iHbTH0I6Fp2hWcnXI0Qzp+Al1y1R8doFY9664YjJH8W
         qbukZfhw1L+67cwprpiqvNWfhcHr6wM4E3BE4moVqYdcgQShdx16Je07b9QyCnrOmcus
         CLlbjsg6GZt+huzUczDEkQ1hxZoZHO1y+DyNgbDpjx+xj9RoxeR4rqfyUChWMng+e8Ug
         y2Xom0VQlG3DWrT9oiBNHfLIyIJrkqpgQOzBh644CHyVbUL/lW+alffbME8qCTMwCyZ3
         e6lrO+RT2WQ8SxYMBd84jE+1a9T3yyq187AQtvhK+8yru4Pk9G17vxYf99TBA+UyGvRV
         yjOA==
X-Gm-Message-State: AHQUAuY7InZ4dpT3bq/f+zz++8q3nF3pEi066bBEp0zOL2BOWkgbT/fY
        HroHnWL0STwd/xqtpn4F9bIblxGew8kPncQQ0YA=
X-Google-Smtp-Source: AHgI3IaeMlX8kgzbUD39d+9c/kAEu1+iwCnWBYgxiJMfzNUzddnHNUZ0FELrlC2cmssJRgZwHT9RDBXjeld+IDbMpP4=
X-Received: by 2002:aca:3142:: with SMTP id x63mr2811158oix.92.1550850466889;
 Fri, 22 Feb 2019 07:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20190221181814.24829-1-TheSven73@gmail.com> <20190222132051.voznrjt3sctdkpkf@shell.armlinux.org.uk>
In-Reply-To: <20190222132051.voznrjt3sctdkpkf@shell.armlinux.org.uk>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 22 Feb 2019 10:47:35 -0500
Message-ID: <CAGngYiVU0wLVOm=tY+TZ9h1P+qNnDdv_3PybfhRreuBpCZ6D1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/i2c: tda998x: adjust CTS_N audio pre-divider calculation
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 8:21 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Feb 21, 2019 at 01:18:13PM -0500, Sven Van Asbroeck wrote:
>
> >       [SNDRV_PCM_FORMAT_S24_LE] = {
> >               .width = 24, .phys = 32, .le = 1, .signd = 1,
> >               .silence = {},
> >       },
>
> The above table describes the memory format, not the wire format.
> Look further down for SNDRV_PCM_FORMAT_S24_3LE, which is 24-bit
> packed into three bytes (see include/uapi/sound/asound.h for
> the comment specifying that.)
>
> ASoC uses DAIFMT to specify the on-wire format in connection with
> the above.
>

Interesting ! So you're saying that currently, nobody strictly defines the
layout of the on-wire format, correct? I'm not sure how this works in practice,
because codec and cpu dai should agree on the on-wire format? Except if the
formats used have enough flexibility so you don't have to care.

If so, we don't seem to have this luxury here :(

>
> This doesn't really help in terms of working out what the correct
> settings should be, and other information I have laying around does not
> provide any further enlightenment.

I have access to the NXP software library shipped with the tda19988.
The library's release notes have the following entry:

  . "I2S audio does not work, CTS value is not good"
    Check the audio I2S format <snip>
    CTS is automatically computed by the TDA accordingly to the audio input
    so accordingly to the upstream settings (like an OMAP ;)
    For example, I2S 16 bits or 32 bits do not produce the same CTS value

The config structure which you need to fill in to init the audio has a
"i2s qualifier" field, where you have the choice between 16 and 32 bits.
This then maps to a "Clock Time Stamp factor x" called CTSX, which maps to
the following CTS_N register settings:

CTSX -> CTS_N (m,k)
-----------------------------------
16 -> (3,0)
32 -> (3,1) (i2s qualifier = 16 bits)
48 -> (3,2)
64 -> (3,3) (i2s qualifier = 32 bits)
128 -> (0,0)

Does this information bring us any closer to our assumption that CTS_N needs
to be calculated off the bclk to sample rate ratio ?

>
> I think what I'd like to see is passing of the Fs value into the driver
> from hdmi-codec, but I suspect that requires a bit of work in multiple
> drivers.
>

I'd love to take a shot at this, but first I'd like to understand what you're
suggesting :)

Currently there is set_bclk_ratio() support, but no-one is actually using it.
If hdmi-codec is to retrieve the ratio, wouldn't we need to add .GET_blk_ratio
to snd_soc_dai_ops ?

I could add this to fsl_ssi in master mode, but what if somebody connects the
tda to a cpu dai for which no-one implemented .GET_bclk_ratio ? Do we guess?
Or just error out?

Also, what would a proposed snd_soc_dai_GET_bclk_ratio() return e.g. on
fsl_ssi in slave mode, where the value arguably doesn't exist because the ssi
will accept pretty much anything you throw at it?

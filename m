Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB0AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24272082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24272082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeLENcF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:32:05 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46422 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeLENcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:32:05 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so7075096uap.13;
        Wed, 05 Dec 2018 05:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=57brSFTNVlykh+UrdKCfjSi4UwojTyrs80aykKhHwoE=;
        b=Hs/wN5bK23Hd9pEoKodYfxYboHTTFHx1JwFw2iSDAbw64m6NEQHFAKMthHQtOGW6t9
         ClFzdFfCJXOM6/xNi4sifiICYWJhGBFjwUtm8dupop6E8Q1qlVD0ULAM2mwAlSfheJ2o
         WePPodymp0Pgg2rQ1WjpSlH3ZkriWV+YBuGGG7nWp2CbG5Rc4ckCdGq3OIgxJG2iuU4X
         r/8d8DYYg7mR+WmXHH6dIONb6UHEICrhhfSul/zz0k984zCXE0c9b984YNSkfROp2+r7
         npqfqWJ4EdWh66RWierlR4VQI+uXTojC3WRUaJYFuSvNRK6Ued+NPRLDy1dqGwusPV6a
         aJHw==
X-Gm-Message-State: AA+aEWZhij5IqeiZoIj4Ow1VDOn5XhcJYSP1meSqr3bJzhf+IbidbfpA
        zqnKZ4OZTKgXr+/h0KfM/p0eya3Wma2bQFlvxrQ=
X-Google-Smtp-Source: AFSGD/VR6P2tiDISKeuzTL7bfPbfNVEl9uIUCFWOOWJS2/2mXfF4ET2xmcZe3MBI/3hyzbSkVPNoDZsBgWDG0bbHPRc=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr11234301ual.20.1544016723259;
 Wed, 05 Dec 2018 05:32:03 -0800 (PST)
MIME-Version: 1.0
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com> <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com> <CAMuHMdV-Ca5sderSKmdbtovKrd-Z7piwVZbwDtB6vVXPa8Q5AA@mail.gmail.com>
 <8e667f91-70bd-795c-094f-23c919c3802c@gmail.com>
In-Reply-To: <8e667f91-70bd-795c-094f-23c919c3802c@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Dec 2018 14:31:50 +0100
Message-ID: <CAMuHMdXF9PtWgjUKaTomkr4X_00HARQ_1uZPROWUr910HLVMCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     masonccyang@mxic.com.tw,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Wed, Dec 5, 2018 at 2:25 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 12/05/2018 02:15 PM, Geert Uytterhoeven wrote:
> > On Wed, Dec 5, 2018 at 1:57 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> >> On 12/05/2018 08:44 AM, masonccyang@mxic.com.tw wrote:
> >>>> "Marek Vasut" <marek.vasut@gmail.com>
> >>>> 2018/12/05 上午 10:04
> >>>> On 12/03/2018 10:18 AM, Mason Yang wrote:
> >>>>> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> >>>>>
> >>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> >
> >>>>> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> >>>>> +{
> >>>>> +   /*
> >>>>> +    * NOTE: The 0x260 are undocumented bits, but they must be set.
> >>>>> +    *   RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> >>>>> +    *   0x0 : the delay is biggest,
> >>>>> +    *   0x1 : the delay is 2nd biggest,
> >>>>> +    *   0x3 or 0x6 is a recommended value.
> >>>>> +    */
> >>>>
> >>>> Doesn't this vary by SoC ? I think H3 ES1.0 had different value here,
> >>>> but I might be wrong.
> >>>
> >>> I check the Renesas bare-metal code, mini_monitor v4.01.
> >>> It set 0x03 or 0x0 and I test them w/ 0x0, 0x3 and 0x6 are all OK.
> >>
> >> Shouldn't this somehow use the soc_device_match() then and configure it
> >> accordingly for various chips ? Like eg. the r8a7795-cpg-mssr driver does.
> >
> > Please don't use soc_device_match() for per-SoC configuration, if
> > you already have of_device_id.data.
>
> I mean, the value is different on H3 ES1 and ES2 iirc, that's what
> soc_device_match() is for, right ?

Oh, it differs between revisions, too?
Yes, in that case you need soc_device_match().

> > BTW, this drivers support r8a7795 only (for now), as per the compatible
> > value.
>
> 77995

Sorry, typo on my side. So H3 is not yet supported ;-)

> >>>>> +#ifdef CONFIG_RESET_CONTROLLER
> >>>>
> >>>> Just make the driver depend on reset controller.
> >>>
> >>> ?
> >>> please refer to
> >>> https://github.com/torvalds/linux/blob/master/drivers/clk/renesas/renesas-cpg-mssr.c
> >>>
> >>> line 124 ~ 126
> >>
> >> This seems like a stopgap measure for systems which do not have a reset
> >> api compatible controller. Geert ?
> >
> > So far CONFIG_RESET_CONTROLLER is optional.
>
> My understanding is that for this IP, it can well be mandatory, since
> all the chips have a reset wired to the IP internally.

That's what I was trying to find out, hence my question about the purpose.

> >>>>> +         regmap_write(rpc->regmap, RPC_SMWDR0,
> >>>>> +                 *(u32 *)(tx_buf + pos));
> >>>>
> >>>> *(u32 *) cast is probably not needed , fix casts globally.
> >>>
> >>> It must have it!
> >>
> >> Why ?
> >
> > Else you get a compiler warning, as tx_bug is void *.
>
> Don't you need some get_unaligned() in that case ? txbuf+pos can well be
> unaligned if it's void * .

True, but IIRC, arm64 can handle that, right?
Don't know about SuperH.

> >>>>> +#ifdef CONFIG_PM_SLEEP
> >>>>> +static int rpc_spi_suspend(struct device *dev)
> >>>>> +{
> >>>>> +   struct platform_device *pdev = to_platform_device(dev);
> >>>>> +   struct spi_master *master = platform_get_drvdata(pdev);
> >>>>> +
> >>>>> +   return spi_master_suspend(master);
> >>>>
> >>>> Won't the SPI NOR lose state across suspend ? Is that a problem ?
> >>>
> >>> I don't think so.
> >>> Because when the device is not in operation and CS# is high,
> >>> it is put in stand-by mode.
> >>
> >> Is the power to the SPI NOR retained ?
> >
> > Not if PSCI system suspend turns of power to the SoC.
>
> And is that a problem ?

Good question!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

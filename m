Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE35FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A8620818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cE1bhDxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A8620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeKJB4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:56:04 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:50602 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeKJB4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:56:04 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wA9GEh8u026500;
        Sat, 10 Nov 2018 01:14:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wA9GEh8u026500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541780084;
        bh=W5fajcGEodmUzaWQd3l2ZF6Tk8dIBINjzQyIooGAM54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cE1bhDxyGZNWIH2rqbQ5LSzn8llqKxBFSkRYWrMTjzkPRGwsuIyiwcIH+aWPrYJeY
         MsLB3sN+6k6goCx0irWt1K/993gKWri7ZxRYye0vzXt3ChKWrstcGPjZKdTOsTbym5
         6ZPEuxclL0vxMgx9kiT0z27DlbM7PUVnyHclD4wT0ouyCJoyCwAmYYC1WZfdG1ZAi2
         GRW1IN1uYO0sebQM75qmfAo/HR+w2QDwcCck8JevVO2/MdYk9v8TDi3XXN0Av5YmRW
         EH1/yT4GGGj2x9EZf/dq44GGmtvM/qkQtXPSpVlG1BrlVCfj7C8NrMUuHBqSPe/dht
         0Qz0hMEHe2uxg==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id b18so528838vke.2;
        Fri, 09 Nov 2018 08:14:43 -0800 (PST)
X-Gm-Message-State: AGRZ1gLsiIti/Bvi3oFftgbxd+OO5X3WEtNthBZASEzzszjeIP/HYDRk
        qndf3l7BzKmZF2K4UYzi1ZnJVlk+JzTXgqBjzig=
X-Google-Smtp-Source: AJdET5eHapqY7M/By+qSxmOSMo6gaLJDpahWezJjHVJP3+Vpq1godvCSFzkDUfluqWTfDHUZKXZjQkpK6dcJ95LuS04=
X-Received: by 2002:a1f:5e47:: with SMTP id s68mr3953062vkb.64.1541780082491;
 Fri, 09 Nov 2018 08:14:42 -0800 (PST)
MIME-Version: 1.0
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com> <1541775663.4112.48.camel@pengutronix.de>
In-Reply-To: <1541775663.4112.48.camel@pengutronix.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 10 Nov 2018 01:14:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQGftPMLkQk-tU4R6Jtw9W6npka+Br+2wyyZicAgwDvRg@mail.gmail.com>
Message-ID: <CAK7LNAQGftPMLkQk-tU4R6Jtw9W6npka+Br+2wyyZicAgwDvRg@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: reset: uniphier: Add AHCI core reset description
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 12:02 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Kunihiko,
>
> On Fri, 2018-11-09 at 10:42 +0900, Kunihiko Hayashi wrote:
> > Add compatible strings for reset control of AHCI core implemented in
> > UniPhier SoCs. The reset control belongs to AHCI glue layer.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > index f63c511..ea00517 100644
> > --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > @@ -133,6 +133,9 @@ Required properties:
> >      "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC USB3
> >      "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC USB3
> >      "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC USB3
> > +    "socionext,uniphier-pro4-ahci-reset" - for Pro4 SoC AHCI
> > +    "socionext,uniphier-pxs2-ahci-reset" - for PXs2 SoC AHCI
> > +    "socionext,uniphier-pxs3-ahci-reset" - for PXs3 SoC AHCI
>
> Since the driver behaves identically for "socionext,uniphier-pro4-usb3-
> reset" and "socionext,uniphier-pro4-ahci-reset", would it make sense to
> add a common compatible?


As far as I could guess, he just happened to find the same driver code
could be reused for other hardware.

Theoretically, this can happen anywhere since
a reset controller is just a set of registers
each bit of which is connected to a reset line.

If you added a super-generic compatible like "simple-reset",
I would agree with
"socionext,uniphier-pro4-usb3-reset", "simple-reset"
since this is a pattern.


However,
"socionext,uniphier-pro4-glue-reset" is kind of a halfway house
where it is SoC-specific, but still ambiguous.


> Something like:
> "socionext,uniphier-pro4-usb3-reset", "socionext,uniphier-pro4-glue-reset" - for USB3 SoC AHCI
> "socionext,uniphier-pro4-ahci-reset", "socionext,uniphier-pro4-glue-reset" - for Pro4 SoC AHCI
>
> That way if more places turn up where the glue layer reset is used,
> you can add them without patching the driver every time.


This is a trade-off between "patch the driver"
and "potential change of the binding".

There is no real hardware like pro4-glue-reset.



I am guessing this is a part of syscon or something,
but I cannot find any explanation in a bigger picture.

So, I cannot judge this further more.




> regards
> Philipp



--
Best Regards
Masahiro Yamada

Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D65BC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F35420869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5Ye/g1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfBBIxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 03:53:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42620 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfBBIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 03:53:04 -0500
Received: by mail-io1-f66.google.com with SMTP id x6so7807069ioa.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 00:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pFOoei9xHRTkuVGj2aLd4yUTKUmq7LmRLqh2yQAnTM=;
        b=O5Ye/g1LTp5jS6TqYOqEauyXGQ5QqHVhpHziJQ3epgb/hqpgPJ73mCXuffBvLj2sm3
         h6RDy4gqgjKbgbCeVgroVwFw9DpNQxcDu/kjDTZa7/AXTbLqYLK9DUkTHV9VpPYeSf84
         EjbVXwnD9580PbCsu5uaWvOLTaC++z599DUo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pFOoei9xHRTkuVGj2aLd4yUTKUmq7LmRLqh2yQAnTM=;
        b=aIvR02kVXce2if5JtS6I9jCFxZN/ZgsPtX7aB4AE2hRshFVS+MlrjJiDu+tf60R97K
         4pmTfZfzkI7mW++CtciBZrdOWBDGCr+XqmBCsCq3jRi7+sIhPFa4A+DeYCmNmZPikyDK
         2DiFpCu7yjlFSWCddcFgWYTdVVbrZEaY/hqiprNvz9F6kZYT6hpEPSOBQ5bwyV2b60Py
         iGBtOhGPugAB9HAQ0mbLIwB3Onk9C1faR0VTqPXFfAg2XgNCtzljSiTGwEnQ9nUPOpAB
         /zV7Bp96NkIXtHfkdQohDq8bW11pBZ9xm/y9hUh/QlOoVIABex39lDmQJFuhUNminZdR
         MEbg==
X-Gm-Message-State: AHQUAub6tKleW8Qq805ltzv5+c6LOH2KlHQhcSL0JiheUSZQPjCRdiHC
        5fJFaVNA+/wSJN97s5flnmRLsdPDW5xeI5+SJkK3Sw==
X-Google-Smtp-Source: AHgI3IaTz7qaudUtUQE904d4v9f4e17jSgSkgy4FizAAGwAaJx+1cX+qahaR4O4jhVP937PKRUANlihiEUcumfzv+co=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr23969712iof.183.1549097583792;
 Sat, 02 Feb 2019 00:53:03 -0800 (PST)
MIME-Version: 1.0
References: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org> <3722223a-4f06-3e1c-86ca-542289c7c918@hisilicon.com>
In-Reply-To: <3722223a-4f06-3e1c-86ca-542289c7c918@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 2 Feb 2019 09:52:52 +0100
Message-ID: <CAKfTPtDcHC=gbKciUVWb6_q=qyEcBZNnYpQ_VvYo0EsbST41BQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/hisilicon: fix SDcard detection
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Fri, 1 Feb 2019 at 18:00, Wei Xu <xuwei5@hisilicon.com> wrote:
>
> Hi Vincent,
>
> On 1/14/2019 8:24 AM, Vincent Guittot wrote:
> > The SDcard detection of hikey960 is active low so cd-inverted is wrong.
> > Instead of adding cd-inverted, we should better set correctly cd-gpios
> > to use GPIO_ACTIVE_LOW.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Updated the subject as Leo suggested and applied to the hisilicon tree.

Thanks

> Thanks!
>
> Best Regards,
> Wei
>
> > ---
> >
> > SD card detection was not working on v5.0-rc1 but patch
> > https://marc.info/?l=linux-mmc&m=154637189021211&w=2 makes it work.
> > Nevertheles, latest changes in of_mmc_detection makes possible to have
> > a correct DT config.
> >
> >  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> > index 71bfe41..dc314e7 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> > @@ -665,8 +665,7 @@
> >       sd-uhs-sdr50;
> >       sd-uhs-sdr104;
> >       disable-wp;
> > -     cd-inverted;
> > -     cd-gpios = <&gpio25 3 0>;
> > +     cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&sd_pmx_func
> >                    &sd_clk_cfg_func
> >
>

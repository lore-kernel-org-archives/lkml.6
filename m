Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D994FC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A5120842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idvpbNOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A5120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbeGLRZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:25:44 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53192 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbeGLRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:25:44 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so7867385itf.2;
        Thu, 12 Jul 2018 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uk2kBFwML3rEUB7NaRnmE5gBKPS5YALbCnEd3pDEEVs=;
        b=idvpbNOaco9nuHc5HGHCX71KzEXOR+81mq7SoZWYq73yfc3MCsMkVsI6d0OcQgC+Gv
         yAPWXaRRc8KWHatVXMr4D3oCFoOnsFmzchQZaWNyWpW/pxtIqN8wF/t2PDg2ZRKrgYIq
         rw0DysxkAKhTwq2v0qN1oDbSQY9lDqFN//Px53TRwcfYY3XTjDt8k1VptX2dh12b4wrg
         qeRAY48wwyVOK/xYI8GjGBikwi+0sMDLnLAAvVx896P12umw9U4F+qo5ZCdrmHjo98qE
         jH2nY8YGoC8CPIUcfbBg4P72A4UZV+Z6FjJIimlKKByLsqpBMKssDykVyEg6X1bNOnbT
         x8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uk2kBFwML3rEUB7NaRnmE5gBKPS5YALbCnEd3pDEEVs=;
        b=ZtuJKRVVee/PPENSFUn4/wcVU1MSawYrr/9vYt/QCuoMrZWp4yxMbXkS0Wyzcw0GX9
         eVbgkOfKd8hRgm+5lGu5JBnY5KPsRnUznyFR2e4E6u4UeEubFBCFxQuPjdvijVsjIceO
         9eYGEmLiR3aKQu+4RV97nPgaF8iZTjMxRlmE2Grof+OL0xSa3vufL+j0NxuAHscCUAhs
         9OrllZJ+sNr7SNnra3NP0gSz4XXQVnEa5EJ58plM1SZ/Oq2khrXgwPaAA3IWnQkLzbBr
         c9yAjsg87QEfmrRbYwHDc/uaHRwVCBFE6CrU1P1xzG243ZjjPgqA8NYvB0bIN7hJrSJg
         Z6HQ==
X-Gm-Message-State: AOUpUlERGo9R6X/5WqxdUGlGerclp0Gba/ZwP+qCbLndn2QC9U3BeFfb
        fWMW2coniZE7NQTAT1A3JERngT0j4PDBDLR0UCE=
X-Google-Smtp-Source: AAOMgpeSLd2ZNPCdvxxFEKldeG8XVqS1e6WhIQupz8JN6m6H4yJRl3/CtzkHBc48UCFTe+RNBsTig7lGHi+RaXSbmzg=
X-Received: by 2002:a24:2f09:: with SMTP id j9-v6mr2021531itj.86.1531415716658;
 Thu, 12 Jul 2018 10:15:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:d00d:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 10:15:16
 -0700 (PDT)
In-Reply-To: <20180712023337.30112-3-andrew.smirnov@gmail.com>
References: <20180712023337.30112-1-andrew.smirnov@gmail.com> <20180712023337.30112-3-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Thu, 12 Jul 2018 10:15:16 -0700
Message-ID: <CAFXsbZqo6LCbx1gb0vYqwa6hUj5ex8PcYb6=4j0dwmOSmjnxKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog
 compatible string
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Chris Healy <cphealy@gmail.com>

watchdog driver loads and works now.

On Wed, Jul 11, 2018 at 7:33 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> It looks like I made a nasty typo in the original patch which resulted
> in missing watchdog device. Fix it.
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: cphealy@gmail.com
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
> index 0bb42c00d72b..dffb761a1cc8 100644
> --- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
> +++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
> @@ -325,7 +325,7 @@
>                 #size-cells = <1>;
>
>                 watchdog {
> -                       compatible = "zii,rave-sp-watchodg-legacy";
> +                       compatible = "zii,rave-sp-watchdog-legacy";
>                 };
>
>                 eeprom@a4 {
> --
> 2.17.1
>

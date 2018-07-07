Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E03C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E17D2151D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E17D2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932835AbeGGRJH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 13:09:07 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35842 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754254AbeGGRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 13:09:05 -0400
Received: by mail-pf0-f194.google.com with SMTP id u16-v6so10773888pfh.3;
        Sat, 07 Jul 2018 10:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwb0M+yg+7kYBoBZuijnMQ/bg1iIYkJ+fh91Mk52leU=;
        b=LrljsqT3oDNdxkjPLwvFzLq8QDl3FnF9xwmkaT4SOCJ81/dgxO7YB/w58S5N6c5PR7
         5YuUzI5QA/uDxuAaKvsTb9rq2iKtd1/Jk5Xclepkri/C7VTE3ZHraAnynfimLrVE9Yqx
         b4d5RzrAMl+9kfCSdSuNkgVIc9/3V+XUXq0fq7F5uH18DvnmviLeIQcj6BE8xaYgdKFO
         tS3M+pICJ4wjmb5SD54f15I3eAI4d9C3jiClqh0ixX6RG9H0CgNTfSlxoy/Z5pMFoIeS
         CmQAPN5jJrZ2p3uEUjB8w+XJ+yWf1yG/GanHcVho412F+7haWGzKVFMO+nHzOY1PEWp/
         TZvg==
X-Gm-Message-State: APt69E1DM4Kfjx9aEc+AyaxuG3WeJsj1whu2SuqhUvl7GbBpuWI0I/RM
        3guFcv+9+4XAQf6CoIvcm1M=
X-Google-Smtp-Source: AAOMgpdcD1WMCBgvH+imAvLLD4Syg1Fh/2n0+wNO6vAQHZN7OTZU9sKz5Xh0cgHgHYv3MgQ0+T7WIw==
X-Received: by 2002:a62:9bc5:: with SMTP id e66-v6mr14850039pfk.84.1530983344533;
        Sat, 07 Jul 2018 10:09:04 -0700 (PDT)
Received: from lineageos.org (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id n2-v6sm4354799pge.45.2018.07.07.10.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 10:09:03 -0700 (PDT)
Date:   Sun, 8 Jul 2018 03:08:48 +1000
From:   Simon Shields <simon@lineageos.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: exynos: add max77693 irq configuration for
 midas
Message-ID: <20180707170848.GA29870@lineageos.org>
References: <20180707144527.6662-1-simon@lineageos.org>
 <CAJKOXPfUav7URsCDHFzMbtBiw5id+szVj_VtGJ-iu5ymmgWoXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPfUav7URsCDHFzMbtBiw5id+szVj_VtGJ-iu5ymmgWoXw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 05:34:08PM +0200, Krzysztof Kozlowski wrote:
> On 7 July 2018 at 16:45, Simon Shields <simon@lineageos.org> wrote:
> > Currently, we assume that the bootloader has correctly configured
> > the interrupt pin for max77693. This might not actually be the case -
> > so it's better to configure it explicitly.
> >
> > Signed-off-by: Simon Shields <simon@lineageos.org>
> > ---
> >  arch/arm/boot/dts/exynos4412-midas.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
> > index f35176a35a15..30760bf2eb71 100644
> > --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
> > @@ -156,6 +156,8 @@
> >                         compatible = "maxim,max77693";
> >                         interrupt-parent = <&gpx1>;
> >                         interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&max77693_irq>;
> >                         reg = <0x66>;
> >
> >                         regulators {
> > @@ -1117,6 +1119,13 @@
> >                 samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> >         };
> >
> > +       max77693_irq: max77693-irq {
> > +               samsung,pins = "gpx1-5";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> > +       };
> > +
> 
> Please put it before hdmi-hpd (gpx3-7).

OK.

> What about the interrupt for max77693 fuel gauge? 
> Maybe another patch for it as well?

Yes - in fact, it looks like most interrupt pins are configured by the
vendor kernel to have PULL_NONE, something which (as far as i can tell)
mainline doesn't do.

Maybe I should just prepare a series (or a single patch) which fixes all of them?
Or would you prefer I added the (remaining) eint configurations to
exynos4412-pinctrl.dtsi, and then used those?

> 
> Best regards,
> Krzysztof
> 

Cheers,
Simon

> 
> >         sleep1: sleep-states {
> >                 PIN_SLP(gpk0-0, PREV, NONE);
> >                 PIN_SLP(gpk0-1, PREV, NONE);
> > --
> > 2.18.0
> >

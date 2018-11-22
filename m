Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D54FC04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0461820685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYnnLRV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0461820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405741AbeKWBrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:47:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39925 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeKWBrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:47:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so9453507wmc.4;
        Thu, 22 Nov 2018 07:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qQsQft4sROo+Ll8hUhEZXBCjZcyxMAPVwCgbBeJ34mo=;
        b=kYnnLRV3wEDR2Sad5nEx3PQX8uBOVQmfpIVMWiiXHmbaADCQfDr3uG+gbg7XDh3Ufj
         1pQ+bwojjrcgq78MG/E7gOBnH6O/pMF8u57afaapJfr9GpZHg23qZUQDCNQLhvwNfFKW
         mswA97rZgxM8uH7BpB7+OzZ0QthEojxSvzsldnqej4gHLeyyu9ZQ/p2dcTwhOmm8EMQR
         ImBpF29dAMuUyWMbmDKeSCjfEr5JpenR9k1TGHi4y5ZTua8QDI0Lfwr2QHHUzeTyvclQ
         y53R5XytNeJAOuZfFmIii40HdgRy+tRUZ152f4HEKvaWcAHOHR0q6uA+BsiX+hLcpqnM
         ZG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qQsQft4sROo+Ll8hUhEZXBCjZcyxMAPVwCgbBeJ34mo=;
        b=ZdXaNM6J6B7qgAhxdtggfilD8Z48uHNflkMtJEMsr0buyM8QUUzqoPixhO6bvrYhOp
         49njMLy7huWdOkSy4fqj2fCWKkZA3XkXm/LAhH0L8Z7go53zOikidBBKbfjCcPmpLVQq
         GnUdLG286m+x/zwoNULsbKOb++hoE/vms2T1Gw8TETZk8Ycm7ASG5Y3LxmxnU17GHnhW
         vj/pMpnNfSmb7Oc8H7Fq+G2kThuDQzB0KH+PpE2yqWa878C9SE+r9lgipORuG/nQMA+t
         paQSV0gsucyN4xM823v4HBlJ84rRaWzu5rLNSbrfxCQs57+G9XNNYeZaOZAAlINknYNR
         ZX2Q==
X-Gm-Message-State: AA+aEWamCT0DoDj0hQg0M06cCbCYcRp8bILgpinYaUgEzqKV1DiMN9AF
        XGexYmvxsDAqyBwEAAoYepo=
X-Google-Smtp-Source: AJdET5e7MiQz0vvphPAMPaw4OrCZygpCC8pbup1A8sTUOPd4jk33A96rvg1MVuv16moEkDx73SVBLw==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr9565706wme.20.1542899273060;
        Thu, 22 Nov 2018 07:07:53 -0800 (PST)
Received: from localhost ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id x77sm6072030wme.19.2018.11.22.07.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:07:52 -0800 (PST)
Date:   Thu, 22 Nov 2018 18:07:51 +0300
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v3 01/17] ARM: add CONFIG_ARCH_SUNXI_V7 for
 differentiate ARMv5/v7 Allwinner SoCs
Message-ID: <20181122150751.n26pvywmvnuglly5@ThinkPad>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <267ffcf3b91930a82f20d93e1fad1fceaf8b9b0e.1542824904.git.mesihkilinc@gmail.com>
 <20181122082635.br5n33owxxpenv62@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181122082635.br5n33owxxpenv62@flea>
User-Agent: NeoMutt/20180716-631-34bcda
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/22 09:26, Maxime Ripard wrote:
> On Wed, Nov 21, 2018 at 09:30:34PM +0300, Mesih Kilinc wrote:
> > Allwinner also has some ARMv5 SoCs.
> > 
> > In order to add support for them, add a CONFIG_ARCH_SUNXI_V7 bool config
> > which is selected when a ARMv7 soc is selected, and make CONFIG_ARCH_SUNXI
> > a common option which is selected by both V7 and V5 sunxi option.
> > 
> > Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> > ---
> >  arch/arm/mach-sunxi/Kconfig | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index d9c8ecf..7e5f173 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -6,31 +6,38 @@ menuconfig ARCH_SUNXI
> >  	select GENERIC_IRQ_CHIP
> >  	select GPIOLIB
> >  	select PINCTRL
> > -	select PM_OPP
> >  	select SUN4I_TIMER
> >  	select RESET_CONTROLLER
> > +	help
> > +	  Support for Allwinner ARM-based family of processors
> >  
> >  if ARCH_SUNXI
> >  
> > +if ARCH_MULTI_V7
> > +
> > +config ARCH_SUNXI_V7
> > +	bool
> > +	select PM_OPP
> > +
> 
> Actually, thinking more about this, I don't see why the PM_OPP config
> option should be made specific to the ARMv7 sunxi SoCs, you will have
> things cpufreq enabled at some point as well on the armv5 support.
> 
OK. I was basing this code to the first patch series. 
So there will be no need for ARCH_SUNXI_VX configs. Should I drop them
and differantiate IC's by only ARCH_MULTI_VX?

> >  config MACH_SUN4I
> >  	bool "Allwinner A10 (sun4i) SoCs support"
> > -	default ARCH_SUNXI
> > +	select ARCH_SUNXI_V7
> 
> The option is still changed from being on by default to being off by
> default. This breaks all the defconfig, and we really shouldn't change
> that.

OK. I will fix it.

Mesih Veysi Kılınç

Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 87E93C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EDA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSpHKt6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EDA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935961AbeFMP7X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:59:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34380 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935741AbeFMP7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:59:21 -0400
Received: by mail-pf0-f195.google.com with SMTP id a63-v6so1656684pfl.1;
        Wed, 13 Jun 2018 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jPp9Z8+iUyS5bfJ0COwbnw1YUIb9H+yP5Lw/ODDV3u8=;
        b=cSpHKt6jmclSUxfnZzM/LlNAHX/1sr5GV8L/UaqMKECJM/fWwr2Y9LRfKUtf+m/EeG
         bYEeseRB1EMqMlj0UbKW74GBvwdbUWAizuutOH/G93muATCeBUsM+dKQBwJd4Ad42oSr
         LKDLPK+fKnIL42dAlCLlMOvCM6SBR+W6HFe8yhodmUMbZOJbZEpfoQcYH521OxtfpnZ7
         Ei1lYjdUhSa+T7pGipjgGYjWaFAPdFZ8VH6S41JJ8yWSohA1Phj1mYvsB2wpoi1iqEqm
         dyxAaiXPn1rrPTsEyUWvLjcWIaeKtcHleLSPcXgQjAjwkW++s/TCj2kEh6ZjLancjSbq
         Hf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jPp9Z8+iUyS5bfJ0COwbnw1YUIb9H+yP5Lw/ODDV3u8=;
        b=ohVtK86lKS98RDpPQijEYIDahvuurwQcxFd+gg66KMn2ukObIYBrMTGyMAYHlELLrU
         YrAacax93pIudcJsfG5Dho2Dm6fUn1KlYCgKhQEz2pVTF9VMpt5xuDctPNy2alka5v8b
         bT8MMjayH1LAcIFJJ8uahW8uD9XT9yS+aFFHJhBcwRYbjnCbHIAVzToRSifGOxyMje/U
         p1xMNVQB0qEUaEsTSmgCCv7ntFpR0/FBiJ0jqp5g/5mcVMwoUiMYvNuwuPr48SngkHF3
         AlC2qb29ux6sSuaNacCNQaIwb7lwuoI5A/lOEqf/onbCa4tEU7EWUXD/kReuGh9TxmaE
         RwDg==
X-Gm-Message-State: APt69E1Klqy2vo54xx5saJfEh2oKoG8GCoy7XTXagdmO5gxQ1T3b/w47
        kSIIO4RxYYiDGP1xk7QEWQ==
X-Google-Smtp-Source: ADUXVKJP3VXBLd0Qruf1UWZgar995cK1ivy0ZS4W15XTNFpdZ+fzMGr6AvHeEVIezW4Luz9rrEuOtg==
X-Received: by 2002:a65:4841:: with SMTP id i1-v6mr4499291pgs.75.1528905560326;
        Wed, 13 Jun 2018 08:59:20 -0700 (PDT)
Received: from arch (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.gmail.com with ESMTPSA id j15-v6sm6742914pfk.40.2018.06.13.08.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 08:59:19 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:58:53 +0100
From:   Craig Tatlor <ctatlor97@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] power: supply: Add support for the Qualcomm
 Battery Monitoring System
Message-ID: <20180613155819.GA10090@arch>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180607181306.9766-1-ctatlor97@gmail.com>
 <20180607181306.9766-2-ctatlor97@gmail.com>
 <e1a78fe3-593d-d39c-05b3-a1cc2b948e90@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1a78fe3-593d-d39c-05b3-a1cc2b948e90@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:08:20PM -0700, Randy Dunlap wrote:
> On 06/07/2018 11:12 AM, Craig Tatlor wrote:
> > This patch adds a driver for the BMS (Battery Monitoring System)
> > block of the PM8941 PMIC, it uses a lookup table defined in the
> > device tree to generate a capacity from the BMS supplied OCV, it
> > then ammends the coulomb counter to that to increase the accuracy
> 
>        amends
> 
> > of the estimated capacity.
> > 
> > Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> > ---
> 
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 428b426842f4..6c354c37bc55 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -82,6 +82,15 @@ config BATTERY_ACT8945A
> >  	  Say Y here to enable support for power supply provided by
> >  	  Active-semi ActivePath ACT8945A charger.
> >  
> > +config BATTERY_BMS
> > +	tristate "Qualcomm Battery Monitoring System driver"
> > +	depends on MFD_SPMI_PMIC || COMPILE_TEST
> > +	depends on OF
> > +	depends on REGMAP_SPMI
> 
> 	select REGMAP_SPMI
> 
> I'm not a fan of "select", but it does not have a prompt string so it isn't
> user settable (not directly; it can be set indirectly).
> And all other uses of it in Kconfig files use "select".
> 
> > +	help
> > +	  Say Y to include support for the Battery Monitoring hardware
> > +	  found in some Qualcomm PM series PMICs.
> > +
> >  config BATTERY_CPCAP
> >  	tristate "Motorola CPCAP PMIC battery driver"
> >  	depends on MFD_CPCAP && IIO
> 
Thanks for the review.
> 
> -- 
> ~Randy

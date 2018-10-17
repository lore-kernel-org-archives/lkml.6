Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FE4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FE721470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGJST7k8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FE721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeJRCR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:17:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42295 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJRCR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:17:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id g15-v6so30766952wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UoNJnelEFmPdb35EGMG0P1d3GYcJ8yPZ6YszMr1od94=;
        b=AGJST7k8GS7pIdo0SoUOy/X/ee3lmyVJ1rvb/TE8rHpfmOyDwLUyX6HGFIovjqTK7l
         yfxeoMRoeEtnOWBcoQCgs3+GtqdL/n9r4SiGSLKRHxzdwzugcexek9cwL7H8pXptX6QR
         T2cqhbu3TloodPrrjukW70sCYs+2QM/f0KNcE7SybhFaRuC+qg+pCWtfbEE2FNBHKEoe
         YD6yGNh8f9g1ZLQZ6uIHEmjUGt2mJjCpLYDys5DKI8dfxoi7gmqlySRX6ukXLmzCdhpx
         Zwy7nWTNf+E70B69Z1814sAunXOWHOTJyyKC9rCp8irnzZmHiDqsLMGYr4Kwd/To5fM2
         j66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UoNJnelEFmPdb35EGMG0P1d3GYcJ8yPZ6YszMr1od94=;
        b=WQbl70l0muDWg9LDFTsJUSr3JfujD/iIAVebG9SDR5RseoCQIG4XNz+3M7wzlZb9OB
         kHwYmNdFakgCSaqhQmaBaM+I+TiR4IA02o2KQ0+2xMd+tEqE/9c/Dbd4a4xcHk5hxAcV
         i6AYt8yDy5Mth3Kdg0vAap2nOs/05azLoifxa3nBsRmJ/HTICzTkAWLfQ7ZPwVsM3P9L
         VMS1nGhrV8AVK7yotTL/WT8NmqHLmWrsr5wuLWmM+klpfdBmAgzn4PggB/sMe8iKw2pD
         lB+MqosmHsrqm6QnofJ4KeKIO1ErxG1zlON4jm7AGcCnZ9aGRZXrmPD1mHmaq012HCr1
         Whhg==
X-Gm-Message-State: ABuFfohWkCzqY/6qvxA+2oFywTHP8QES8kgsG8FrqtMBkNoMUjLuyPFy
        NLOBIH/oqjxjpy/Y5N0DRGI=
X-Google-Smtp-Source: ACcGV63PP/VV6Wm0J23JoSM18Z4OUm5NKBcdGUgEAi8W3GJs6D5gCEKKE/OVD5r82uANQZHewj2H0g==
X-Received: by 2002:adf:f404:: with SMTP id g4-v6mr3629301wro.198.1539800433902;
        Wed, 17 Oct 2018 11:20:33 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 91-v6sm4126720wrb.95.2018.10.17.11.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 11:20:33 -0700 (PDT)
Date:   Wed, 17 Oct 2018 11:20:31 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: atmel-ssc: Fix section annotation on
 atmel_ssc_get_driver_data
Message-ID: <20181017182031.GA9678@flashbox>
References: <20181017170901.13119-1-natechancellor@gmail.com>
 <20181017181625.GW17341@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017181625.GW17341@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 08:16:25PM +0200, Alexandre Belloni wrote:
> On 17/10/2018 10:09:02-0700, Nathan Chancellor wrote:
> > After building the kernel with Clang, the following section mismatch
> > warning appears:
> > 
> > WARNING: vmlinux.o(.text+0x3bf19a6): Section mismatch in reference from
> > the function ssc_probe() to the function
> > .init.text:atmel_ssc_get_driver_data()
> > The function ssc_probe() references
> > the function __init atmel_ssc_get_driver_data().
> > This is often because ssc_probe lacks a __init
> > annotation or the annotation of atmel_ssc_get_driver_data is wrong.
> > 
> > Remove __init from atmel_ssc_get_driver_data to get rid of the mismatch.
> > 
> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> I would add:
> 
> Fixes: 5c86ac695c7e ("ASoC: atmel-ssc: use module_platform_driver macro")
> 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> > 
> > Alternatively, ssc_probe could be marked as __init, I don't think there
> > is any way for the probe to defer. I decided to go with the more
> > conservative option first but I'm happy to respin if necessary.
> > 
> 
> A probe function should never be marked __init, unless you ensure there
> is no way to bind/unbind the driver at runtime.
> 

Thank you for the review and that clarification, wasn't able to find
much regarding __init on probe functions in my research.

> > Thanks!
> > 
> >  drivers/misc/atmel-ssc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> > index b2a0340f277e..d8e3cc2dc747 100644
> > --- a/drivers/misc/atmel-ssc.c
> > +++ b/drivers/misc/atmel-ssc.c
> > @@ -132,7 +132,7 @@ static const struct of_device_id atmel_ssc_dt_ids[] = {
> >  MODULE_DEVICE_TABLE(of, atmel_ssc_dt_ids);
> >  #endif
> >  
> > -static inline const struct atmel_ssc_platform_data * __init
> > +static inline const struct atmel_ssc_platform_data *
> >  	atmel_ssc_get_driver_data(struct platform_device *pdev)
> >  {
> >  	if (pdev->dev.of_node) {
> > -- 
> > 2.19.1
> > 
> 
> -- 
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Cheers,
Nathan

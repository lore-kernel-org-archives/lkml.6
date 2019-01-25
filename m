Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D3FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CE1218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtKXMVLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfAYPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:18:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39827 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfAYPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:18:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so4696087pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 07:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQyVqyjAD0UyM5BgevkTZgjLaebiRunzdWd/bduHnnQ=;
        b=jtKXMVLXW2qJn51/uL/ymU0bcO1tV1zzF0r35YxSHcGlgNr1UKbE/mMoc1ztI+ABfP
         3QJQEbbwia0I7MO5AyOkoOZGX3GBHrLW+h4ZnxIKhUaQ6S8NeKfj7mGFtg90ZmRV9+zG
         1S005em1c9gjLWh+oR1FNNo0w2TbzemyhiBGBfGn4r8YZIyc9bpM5ChMBQF5OReokd8/
         VHZW3jQCPnuRBfhHq8yoE51DOl9FotuhP+hQfHn86vRlDw+y1JuFz2SMtoU2BJzV2jnU
         QxAuc6ecdXLmQ/gJBEvC0TQdkYNMevEeIfbN7nKN+nBg4bywqzvT1hDhKJORYG2f6ngP
         7Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQyVqyjAD0UyM5BgevkTZgjLaebiRunzdWd/bduHnnQ=;
        b=dEg5Kyi5oe/LASP0OV1HAr/eIcY0Z40lI9gRqxHZRAvl9Rs3JUrGcXaH5XBFv7cPwl
         CvUZIte5A51US7WD2zzm+MTOCvdX6+5XKygJg91qA1uF89zvQr+ahxok7yrsMo+qYGRP
         eRqrssFPxE7GxqNgPfEO6u8LZ/5xTs+VSC0hQhtxHziaTb9Td7azFj8P4n0nXWDqXVab
         VJx/WTyjh6k1XZ1rsuROqZWsTlaDEQyOo3WB74mm0z/Ps74ZVK7e/XX4+Lhby22bwOhV
         WT+7kitbG5Pa7DMSI89d4AkIPjdb2IVzFLWr+QESt0bMwVBZqZScM8OvYEMiGSiGRxLT
         3n4g==
X-Gm-Message-State: AJcUukcJwNeFBYLyI9sQm54LnAo4P3i1dI/GJUw+5lk6grLTM3tprNQu
        kjZLSSZX7oJ2UUMSuobur9I=
X-Google-Smtp-Source: ALg8bN6MKOggyl7HMhfHPyX378n0yRmmGyR6dm2Xe3Xu4d6ZoDMIgUjl8Oo0AAxgdca3Vpr6rr0yvQ==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24mr11072502pls.71.1548429483040;
        Fri, 25 Jan 2019 07:18:03 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id b10sm36543837pfj.183.2019.01.25.07.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 07:18:02 -0800 (PST)
Date:   Fri, 25 Jan 2019 20:47:53 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        John Crispin <blogic@openwrt.org>, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: mt7621-pinctrl: Remove space after cast
Message-ID: <20190125151751.GA11257@nishad>
References: <20190123163122.GA4807@nishad>
 <b51b1d3071aec95915d48159c1dd6e0a336cd9f4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51b1d3071aec95915d48159c1dd6e0a336cd9f4.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 09:45:53AM -0800, Joe Perches wrote:
> On Wed, 2019-01-23 at 22:01 +0530, Nishad Kamdar wrote:
> > This patch removes space after a cast as it
> > is not needed.
> > Issue found by checkpatch.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> > index 80e7067cfb79..3e959fa73703 100644
> > --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> > +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> > @@ -363,7 +363,7 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
> >  		}
> >  
> >  		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
> > -		range->name = name = (char *) &range[1];
> > +		range->name = name = (char *)&range[1];
> >  		sprintf(name, "pio");
> 
> I find this code unsightly and fragile.
> It doesn't test the return of devm_kzalloc for failure.
> 
> This might as well be
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> index 80e7067cfb79..9b52d44abef1 100644
> --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> @@ -350,7 +350,6 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
>  	for_each_compatible_node(np, NULL, "ralink,rt2880-gpio") {
>  		const __be32 *ngpio, *gpiobase;
>  		struct pinctrl_gpio_range *range;
> -		char *name;
>  
>  		if (!of_device_is_available(np))
>  			continue;
> @@ -362,9 +361,10 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
>  			return -EINVAL;
>  		}
>  
> -		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
> -		range->name = name = (char *) &range[1];
> -		sprintf(name, "pio");
> +		range = devm_kzalloc(p->dev, sizeof(*range), GFP_KERNEL);
> +		if (!range)
> +			return -ENOMEM;
> +		range->name = "pio";
>  		range->npins = __be32_to_cpu(*ngpio);
>  		range->base = __be32_to_cpu(*gpiobase);
>  		range->pin_base = range->base;
> 	
> 	
> 

Ok, I'll include it as a new patch as I think this one has already been
accepted.

Thanks for the review.

Regards,
Nishad

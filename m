Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F381C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2206A20855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLYHa8w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfA3O0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:26:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41091 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3O0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:26:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so11120223plm.8;
        Wed, 30 Jan 2019 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VM3p6/s4SVy5fZUAia87KEQ5MWuRdZWo7LUOAtBmQU0=;
        b=nLYHa8w66+qrneKZnCCbqE31p44ZKWGoYR5IiBhfdXYWJkAa8uxeZe1/xbqBohz9FF
         l3u/s74nE0bN8+lMvpbXmxM6SzQpMVRtYLDGC3JMMzgOVy3NB5swxxJAvcu/c8Iyz/BT
         CxEcfa/ZYNw9pHkCYhmNMmhkA9IlPxh9n2+rThc9+Jo/qtJV8TFwp163z8o6H8iuidnT
         t6UvNZwtjO8kgX0/816iYqYB6UB3m+DY5UhksR3Mq59zHpDWQZtW2+QOoyqP/iUqHoWl
         vZQxwFV3RDrvVPpQaLYByZf3+Mwi31w2nZ0irehfrPCKbINzRrCKosixSJLP7/qbgf9r
         GYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VM3p6/s4SVy5fZUAia87KEQ5MWuRdZWo7LUOAtBmQU0=;
        b=dRydQwW34cF5xoX0zZB5MUFKWRB2ECe+58MfUJa2wNp2NSq2v50x1ZimlcNr6C+aID
         2Y/3ool8/upt7oCTPQrEG1qi52JpebIjkZs4M8Gq5mEU7Vv0s0YsvygxrlaGb59LWtai
         a8595mNW3TodnqdTzRifvuU5KKXZ0NS8XOKomjIFBDFIR0ORkSziV/zQ8r0v/v+W3dvv
         uKsBWH9wj7A9TGaA28G+Fp8K6vw7rbmvrfCa1I6XDopeicP6owaN4NCe90zzfFs+8rRG
         WOopzIkZO983Gc3dGoBMbyDz+lAiVgCbd2KZjN5NX5O5RnRI5dIX/hgKFRkX+AXvq5la
         TdBw==
X-Gm-Message-State: AJcUukfDT7fDGQHPm1GT/rxHNuOhWWhelx4h98G3MzVBCVRXmZ+RmkYw
        37nwvlcdXiKFLyGtFuDPAlI=
X-Google-Smtp-Source: ALg8bN7Z2n67V/khSr8jW7o6rC2vZTkoUwukGWZqFX/Zl264nG9Ydtaze3ojN0g3enJfw3NYDk8v+w==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr29937393plr.207.1548858373930;
        Wed, 30 Jan 2019 06:26:13 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id l22sm3330164pfj.179.2019.01.30.06.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 06:26:13 -0800 (PST)
Date:   Wed, 30 Jan 2019 19:56:03 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Joe Perches <joe@perches.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Select PINCTRL_RT2880 when RALINK is enabled
Message-ID: <20190130142601.GA26071@nishad>
References: <20190129152522.GA24872@nishad>
 <20190129200905.vnb3amouxq6o57fn@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129200905.vnb3amouxq6o57fn@pburton-laptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 08:09:07PM +0000, Paul Burton wrote:
> Hi Nishad,
> 
> On Tue, Jan 29, 2019 at 08:55:27PM +0530, Nishad Kamdar wrote:
> > This patch selects config PINCTRL_RT2880 when config RALINK is
> > enabled as per drivers/staging/mt7621-pinctrl/TODO list. PINCTRL
> > is also selected when RALINK is enabled to avoid config dependency
> > warnings.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  arch/mips/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index e2fc88da0223..cea529cf6284 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -623,6 +623,8 @@ config RALINK
> >  	select CLKDEV_LOOKUP
> >  	select ARCH_HAS_RESET_CONTROLLER
> >  	select RESET_CONTROLLER
> > +	select PINCTRL
> > +	select PINCTRL_RT2880
> >  
> >  config SGI_IP22
> >  	bool "SGI IP22 (Indy/Indigo2)"
> 
> Wouldn't this also require selecting STAGING? Perhaps that's why it
> wasn't done in the first place?
> 
> Thanks,
>     Paul
Ok, got it.

Thanks for the review.

Regards,
Nishad

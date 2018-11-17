Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7655C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 07:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633542084A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 07:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCiJU9Ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633542084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbeKQR1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 12:27:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37311 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeKQR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 12:27:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so11574604pge.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 23:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j5px/syCsxxZ+Kvyqc38VU9LHx7gEwoYxbQJsTuCjMA=;
        b=OCiJU9Ui8NNIGrcXTfqBe0Bt9U0ZEAShE0ICg3cgVcSltIHofXNwKcL3O4KV1TIjXC
         UDKdPi4wAghm7mQDF6JL/77CRbg+D33tws4OgjWqTw0WgC6pVyz8FkiN4p1vAl4bE/z+
         7aSWHpkwrkMnm7j9wGwfwevHIzdc+aLeorqhZlqoMvh+FPIMuvekBCACr5SxYv06yj+T
         kZoqpal40/YPd6R+G8mmspg8TYYQZ+fUM++5phMlFuRxIbcyO1u/J6JNtJ9LxIS9oNNa
         REq/Py1bx5b/R2tCRTiSwHwf/eqN41IuHK8wvfNBrNH40JecVqztaIXUdAqBdhgrutD5
         xLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j5px/syCsxxZ+Kvyqc38VU9LHx7gEwoYxbQJsTuCjMA=;
        b=TAd1UhgiW1/ipvs5E1w7mb9LjDsM4rl1eZNgi1ncQljZ2dhbs33PCRWZ+Mx8cv1jrA
         NAd+aQ7MYGDizpOu0LRpiGPKdvht/z35J+dn0kylCWcBkcMxy2MGU0WQiekJWsqacRU+
         Gzkl1X5u+BOA54eIO2YxRnYXsUT1jyr2BUh0ZIMWq4g01npYHZE3I2O5HXj4y9RHQ89F
         OFdrmQ0UHs2h1VKVU41VRq7V4lWQx1ZTbLWFqqmYfe2uNjADy9gBk18q0AP9IXoeMInk
         x+Suv1AHlzy58SfX2ouC8gi5ajs3Zjyx5gvc9m5547mLLGITJOftBoO8I0Crv0CbFFnk
         fnNQ==
X-Gm-Message-State: AGRZ1gLZcP4fZvWZocu8m5coW6hIG0S08HVfbvUsSfCX3gB7071hnHR6
        +XPt5FiC1HcjrkGwnxzL6oc=
X-Google-Smtp-Source: AJdET5cdI81Mc4HdSIzsOXU88uFx4pOyHDFSrw/8MoFoGMcUlh8vglDlTUtRpR9np1zQyH00MUOz/Q==
X-Received: by 2002:a63:990a:: with SMTP id d10mr12780367pge.279.1542438679263;
        Fri, 16 Nov 2018 23:11:19 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id g65sm72855310pfa.63.2018.11.16.23.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 23:11:18 -0800 (PST)
Date:   Sat, 17 Nov 2018 12:41:11 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: arche-platform: Switch to the gpio
 descriptor interface
Message-ID: <20181117071109.GA14187@nishad>
References: <20181116151740.GA12250@nishad>
 <20181116160622.GQ19900@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116160622.GQ19900@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:06:22PM +0100, Johan Hovold wrote:
> On Fri, Nov 16, 2018 at 08:47:44PM +0530, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated
> > old non-descriptor interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> 
> Always include a change log here after the cut-off line so we know what
> changed since previous versions.
> 
> Also include the patch revision in the Subject (e.g. "[PATCH v3]
> staging: greybus: ...").
> 

Ok, but this is the first patch version that I submitted
for greybus: arche-platform.

> >  drivers/staging/greybus/arche-platform.c | 120 ++++++++---------------
> >  1 file changed, 42 insertions(+), 78 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > index 4c36e88766e7..a826a1835628 100644
> > --- a/drivers/staging/greybus/arche-platform.c
> > +++ b/drivers/staging/greybus/arche-platform.c
> > @@ -8,10 +8,9 @@
> >  
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> > -#include <linux/of_gpio.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> > @@ -45,14 +44,15 @@ enum svc_wakedetect_state {
> >  
> >  struct arche_platform_drvdata {
> >  	/* Control GPIO signals to and from AP <=> SVC */
> > -	int svc_reset_gpio;
> > +	struct gpio_desc *svc_reset;
> > +	struct gpio_desc *svc_sysboot;
> >  	bool is_reset_act_hi;
> > -	int svc_sysboot_gpio;
> > -	int wake_detect_gpio; /* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
> > +	struct gpio_desc *wake_detect;
> > +	/* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
> 
> I'm not commenting on the rest, but comments never go underneath what
> they apply to.
> 
> Just keep the current comment here, even if it's placement is a bit odd
> and makes the line be longer than 80 cols.
> 
> Johan

Ok, I'll keep that in mind.

Thanks for the review.

thanks and regards,
Nishad

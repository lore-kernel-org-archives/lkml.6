Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED37EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDFA20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A02hP/F4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfA1HLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:11:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39851 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfA1HLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:11:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so7348364pld.6;
        Sun, 27 Jan 2019 23:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=22XFa1E2MJqDKU7B+mGZ5DHfMi0ISNi6eHvXMKeC1e0=;
        b=A02hP/F4c8LCy0M8ymYdErsuIh3g3W4MLdPpTLjMal40fFVVd8npUPT74wajQ2p35x
         E6FBelhXxBpsdCTxyk//PftXuTW7OfAbqu9Ntn7iiWvwGjLBRnjFUzUsUJrNKAlCQQTg
         dVQrUcazjVGghb7JGnbJ3goLZLaBf8TZV7HQWks+NHPrIVenKTsX0RQgMNcxA0VYsUfL
         XiTF9KVkedRioI3bvGEXcx6aW9FwZpnxa0KkWnObR/NQwyONI9PmBmZkQTh/vZKxWAqu
         83w5nRIMz/x1ICeETWTv8IVjJxsjWxDJHsqxDEfVRF32mJuz04lSSQASFN3Vh9IrAaDt
         MA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=22XFa1E2MJqDKU7B+mGZ5DHfMi0ISNi6eHvXMKeC1e0=;
        b=JnAe9rOsURS5x8ZYbPiBz8c14m8XEEU5jLxOi+1u1m4/e2TvBDj4nNC2iKuqCzY1ba
         Z1/yNmbvP00K2vs59qD/03jWzL5h2xzCi9dYq/U15446d5lH90X2yMGnStsUi9J60DeE
         zmYx/oA/4YM0WdvhXh6w3RwX4iqQAhclqcicqxigEa+3EYq3BFKosSXzZoTlQP6MJbXA
         o7I6OWa2ue+95IgjuNJgJj1ztTeEVvqy7OIU9TfC7Rm7mr/P/bS9H3eefLgN6CWEi15f
         VIu8RdMr7MTJMuIlADh4HndwB6am3x2elQ1/v704FOXhTptZ7JCCHayiToAvSNoT8Hae
         KvaQ==
X-Gm-Message-State: AJcUukewwDtIZVf6iToVi8Jray2+PVVIHQTA+jB86ecLPcVXYHaUpvqR
        +DGKVICbfQBR0nH5SyyBm7Ku+YDPCsU=
X-Google-Smtp-Source: ALg8bN4SjmQG9wYWLkrGD6MiTcb+dr0OQJ1aI16sBJFdvp3Hf1X7eH54DE9QTSSOZ3y8ZS4J/nTu8g==
X-Received: by 2002:a17:902:765:: with SMTP id 92mr20769678pli.242.1548659463763;
        Sun, 27 Jan 2019 23:11:03 -0800 (PST)
Received: from chikyu ([202.83.16.90])
        by smtp.gmail.com with ESMTPSA id l19sm64880937pfi.71.2019.01.27.23.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 23:11:03 -0800 (PST)
Date:   Mon, 28 Jan 2019 12:40:59 +0530
From:   Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
To:     sfr@canb.auug.org.au, linux-next@vger.kernel.org
Cc:     rdunlap@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: Fix build issues in ptn5150
Message-ID: <20190128071059.GA32040@chikyu>
References: <88f71303-575e-6680-a207-da102bda8ef2@infradead.org>
 <1548650292-15762-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1548650292-15762-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:08:12AM +0530, Vijai Kumar K wrote:
I was wondering, what is the normal procedure in the below case
when the build fails because of the driver.
Should I send a new patch as a whole [PATCH v3] for the driver
or should I send a new patch to fix the issue like below.

Thanks,
Vijai Kumar K
> - extcon-ptn5150 driver uses gpio libraries
> - Add GPIOLIB in depends section of Kconfig
> 
> Error:
> -----
> >   CC      drivers/extcon/extcon-ptn5150.o
> > ../drivers/extcon/extcon-ptn5150.c: In function ‘ptn5150_irq_work’:
> > ../drivers/extcon/extcon-ptn5150.c:130:5: error: implicit declaration of function ‘gpiod_set_value’ [-Werror=implicit-function-declaration]
> >      gpiod_set_value(info->vbus_gpiod, 0);
> >      ^
> > ../drivers/extcon/extcon-ptn5150.c: In function ‘ptn5150_i2c_probe’:
> > ../drivers/extcon/extcon-ptn5150.c:242:2: error: implicit declaration of function ‘devm_gpiod_get’ [-Werror=implicit-function-declaration]
> >   info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
> >   ^
> > ../drivers/extcon/extcon-ptn5150.c:242:53: error: ‘GPIOD_IN’ undeclared (first use in this function)
> >   info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
> >                                                      ^
> > ../drivers/extcon/extcon-ptn5150.c:242:53: note: each undeclared identifier is reported only once for each function it appears in
> > ../drivers/extcon/extcon-ptn5150.c:252:2: error: implicit declaration of function ‘gpiod_direction_output’ [-Werror=implicit-function-declaration]
> >   ret = gpiod_direction_output(info->vbus_gpiod, 0);
> >   ^
> > ../drivers/extcon/extcon-ptn5150.c:271:3: error: implicit declaration of function ‘gpiod_to_irq’ [-Werror=implicit-function-declaration]
> >    info->irq = gpiod_to_irq(info->int_gpiod);
> -----
> 
> Signed-off-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> ---
>  drivers/extcon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index b9cc027..330dd8b 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -116,7 +116,7 @@ config EXTCON_PALMAS
>  
>  config EXTCON_PTN5150
>  	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
> -	depends on I2C
> +	depends on I2C && GPIOLIB
>  	select REGMAP_I2C
>  	help
>  	  Say Y here to enable support for USB peripheral and USB host
> -- 
> 2.7.4
> 

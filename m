Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 674ECC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC0D208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2Bsy+6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC0D208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934875AbeFLWYC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:24:02 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34656 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934418AbeFLWYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:24:00 -0400
Received: by mail-pg0-f67.google.com with SMTP id q4-v6so248315pgr.1;
        Tue, 12 Jun 2018 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hnmKm7rpFDKdViozsx57KeQ2owOgOEmOxtUHRT8SSfE=;
        b=e2Bsy+6ciboA77z99rAkDMXdr6vspVsQGqTv0vHVq5BbhHoWe9XGbRazfaXFrlD9q3
         HApQINsKgBnJBoFcgkNpNERvld0CHTFIGkcPquyJOoFWLmEWugcN9HVAyuYQy5rh7Q68
         zxhHBtN9rYtL7WmEQYGnd5Q0eCoz6fgmq0jV09Gxi6zMdOSXSOtqS5uCQdwFgOCL//hs
         djx8qarKEu74gbiohryijNWaqHlQx4/NwPQs0cPizaedCcD11GQYTCGBuV9Rt7dXxTW+
         QlJwzXRJ15Kk8buGS1/7TO9QeMTK1PYLDSmazWGqsbKqsyNseL1mU1w1I5+IT9G4yMWX
         dUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hnmKm7rpFDKdViozsx57KeQ2owOgOEmOxtUHRT8SSfE=;
        b=nasQ8cMxu32ui2D3SO4oecy/K+VJ/3PMBCfJNDDpeh2yzO9G9+4gMvWwXjb/4163LZ
         nbSJaXRC+D8IhXApG+nvOGv3gL5U9joUNa/C6N85AmrZXq/O2bBsxuk9h2vT104WsK91
         Mr7BJDYMz6BZJ660gXBm/Jy6cgHu6bpVOKi3Id7lPZRMtvIPJx6DOKgxFnNrJoDXrvHs
         UU2LAbu690S7rWoA06ieI1NYJ8K8wCsl6CEBAJBTdkf5nYehl2eTBwwWkV5TqybxbiW1
         YqwG+2HveR64aXy9bojHPN4NT6eIJxgWajEKA6WqljJACfEk0aZn0DQZwbr/xjVzQfU+
         2brA==
X-Gm-Message-State: APt69E0BDC0HbF0Vio8jssNBbynXgo81oDdAaiPZ6z9BEIVmJb/x1e5c
        YO4MCQh5TCD1/i39mbeSU/c=
X-Google-Smtp-Source: ADUXVKLCeiwxxwM7lDP1yevT+tUiiBVkUiaFkUrJCo4rViyPEZvnue3GwZ81ORMYofMyLYK6+rlPCA==
X-Received: by 2002:a62:6cc4:: with SMTP id h187-v6mr2207794pfc.145.1528842239426;
        Tue, 12 Jun 2018 15:23:59 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id d88-v6sm1545339pfb.43.2018.06.12.15.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:23:58 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:23:56 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] ARM: OMAP1: ams-delta: drop GPIO lookup table for
 serio device
Message-ID: <20180612222356.GD38773@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Sat, Jun 09, 2018 at 04:02:15PM +0200, Janusz Krzysztofik wrote:
> GPIO lookup table for ams-delta-serio device was introduced by commit
> 0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables").
> Unfortunately, a follow up patch "Input: ams_delta_serio: use GPIO
> lookup table" was not accepted by subystem maintainer who requested
> conversion of the driver to a platform driver, replacepemnt of IRQ GPIO
> pin with IRQ resource, replacement of GPIO pin providing keyboard power
> with a regulator and removal of remaining GPIO pins from the driver as
> not handled by it.
> 
> Let's start with removal of no the longer needed GPIO lookup table from
> the board init file.
> 
> Series created and tested on top of next-20180608 tag from linux-next
> tree.

This all is really nice (modulo a couple of questions), thank you for
implementing this. How do you want to merge this? Through OMAP tree or
input?

> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 80f54cb54276..18e0ff437b27 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -504,20 +504,6 @@ static struct platform_device cx20442_codec_device = {
>  	.id     = -1,
>  };
>  
> -static struct gpiod_lookup_table ams_delta_serio_gpio_table = {
> -	.table = {
> -		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_KEYBRD_DATA,
> -			    "data", 0),
> -		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_KEYBRD_CLK,
> -			    "clock", 0),
> -		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_PWR,
> -			    "power", 0),
> -		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT,
> -			    "dataout", 0),
> -		{ },
> -	},
> -};
> -
>  static struct platform_device *ams_delta_devices[] __initdata = {
>  	&latch1_gpio_device,
>  	&latch2_gpio_device,
> @@ -534,7 +520,6 @@ static struct platform_device *late_devices[] __initdata = {
>  
>  static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
>  	&ams_delta_audio_gpio_table,
> -	&ams_delta_serio_gpio_table,
>  };
>  
>  static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
> @@ -580,10 +565,6 @@ static void __init ams_delta_init(void)
>  	 */
>  	ams_delta_audio_gpio_table.dev_id =
>  			dev_name(&ams_delta_audio_device.dev);
> -	/*
> -	 * No device name is assigned to GPIO lookup table for serio device
> -	 * as long as serio driver is not converted to platform device driver.
> -	 */
>  
>  	gpiod_add_lookup_tables(ams_delta_gpio_tables,
>  				ARRAY_SIZE(ams_delta_gpio_tables));
> -- 
> 2.16.1
> 

-- 
Dmitry

Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574A2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19A322B26
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctoTiyYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19A322B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934084AbeFVALw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:11:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42494 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932397AbeFVALu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:11:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id w17-v6so2515527pll.9;
        Thu, 21 Jun 2018 17:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dpqMzOO+MA0d5Ip/zqvb+MeBogZmJp/F2060yG6uOSU=;
        b=ctoTiyYlLsUJAfPTKfKbpOqxEHrG+mRA44fxnwb6HN6R17UJRkmDYt0zLWm35J5T5T
         vbWWr6hTXG7Tc/78GvTg2DNlj5g/Unt5Vtj/RYMHGPtj1cLxG0koIkpyJDjI+RI5QKlQ
         RleU0DESOx6ZmaklzNQW22axUGQZ20tA1IK3hKMpc/BeoYvBZ2GIvhs/5QVKQOuWBiD+
         nFHOuVq32yGQ18bgH30tlRF6fky6WO7641Fa1XmR6rjLD6IGAlV8hvWtDJdw6Vxw94Ff
         r52lQ1r0PXi6GLxdesPIxBDDmIg5ZnLfyQi8zCMrYpDBIce02j51eImhlNU4jszdrWgd
         oEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dpqMzOO+MA0d5Ip/zqvb+MeBogZmJp/F2060yG6uOSU=;
        b=RYj2j6sXNErzk79H6svgiz0Mek4AQLT0Blz5Tu+XjRo2FyFBMXmKb4VVTyX4UO54nA
         f/pb1HMuKXusYhf3WDvJgPDj7WboFwpI+j9pl6jC8o2SmKvLGV6iTD5fM6Di/5nIBw4w
         w8PVV+7BTXw3gPgRj4qfqBYl2SlHGXN06YJTzCXro1wbWgllqjw0KtcTMXnzo4bJ0clA
         W2s7onhSuiQ6V+PNCQ4Ot9lJuCtDp7Q9p48HX3uqQstRgf1rFbf8Sqevh+bFRQ++bUca
         NDCvbAp/kCjnLqKyuOfRW7PTZmHZ8KHBmb7Rz5qxhzZ/RHOLrhuM4/OrciOZNcoFDilB
         T1MQ==
X-Gm-Message-State: APt69E0wVOPEl8RPFsttNK95lsvMIvFH+/gx/WAgyDlbSIEfmaOD3t24
        mOvulRHMfXvWr4vKXQntGxI=
X-Google-Smtp-Source: ADUXVKJ5ACSCMwVpBWNj3dGYdfnQewc3zL3Yvmm59ldNu1XRM5ixbam+XnHqWynOsymK8hH3R3PP2g==
X-Received: by 2002:a17:902:7686:: with SMTP id m6-v6mr30982384pll.340.1529626309548;
        Thu, 21 Jun 2018 17:11:49 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id t68-v6sm10253235pfe.91.2018.06.21.17.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 17:11:48 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:11:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] Input: ams_delta_serio: Get FIQ buffer from
 platform_data
Message-ID: <20180622001146.GG79890@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-10-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621224128.17623-10-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:41:28AM +0200, Janusz Krzysztofik wrote:
> Instead of exporting the FIQ buffer symbol to be used in
> ams-delta-serio driver, pass it to the driver as platform_data.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Input bits look good.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Changelog:
> v2: rebased on v4.18-rc1, no conflicts
> 
>  arch/arm/mach-omap1/ams-delta-fiq.c         |  6 +++---
>  arch/arm/mach-omap1/board-ams-delta.c       |  8 ++++++++
>  drivers/input/serio/ams_delta_serio.c       | 20 +++++++++++++-------
>  include/linux/platform_data/ams-delta-fiq.h |  4 ----
>  4 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
> index 82ca4246a5e4..b0dc7ddf5877 100644
> --- a/arch/arm/mach-omap1/ams-delta-fiq.c
> +++ b/arch/arm/mach-omap1/ams-delta-fiq.c
> @@ -40,8 +40,7 @@ static struct fiq_handler fh = {
>   * keystrokes received from the qwerty keyboard.  See
>   * <linux/platform_data/ams-delta-fiq.h> for details of offsets.
>   */
> -unsigned int fiq_buffer[1024];
> -EXPORT_SYMBOL(fiq_buffer);
> +static unsigned int fiq_buffer[1024];
>  
>  static struct irq_chip *irq_chip;
>  static struct irq_data *irq_data[16];
> @@ -203,9 +202,10 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip,
>  	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
>  	omap_writel(val, OMAP_IH1_BASE + offset);
>  
> -	/* Initialize serio device IRQ resource */
> +	/* Initialize serio device IRQ resource and platform_data */
>  	serio->resource[0].start = gpiod_to_irq(clk);
>  	serio->resource[0].end = serio->resource[0].start;
> +	serio->dev.platform_data = fiq_buffer;
>  
>  	/*
>  	 * Since FIQ handler performs handling of GPIO registers for
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 84177ba3e39a..772892487827 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -520,6 +520,14 @@ static struct resource ams_delta_serio_resources[] = {
>  static struct platform_device ams_delta_serio_device = {
>  	.name		= "ams-delta-serio",
>  	.id		= PLATFORM_DEVID_NONE,
> +	.dev		= {
> +		/*
> +		 * Initialize .platform_data explicitly with NULL to
> +		 * indicate it is going to be used.  It will be replaced
> +		 * with FIQ buffer address as soon as FIQ is initialized.
> +		 */
> +		.platform_data = NULL,
> +	},
>  	.num_resources	= ARRAY_SIZE(ams_delta_serio_resources),
>  	.resource	= ams_delta_serio_resources,
>  };
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index c1f8226f172e..f8663d7891f2 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
>  struct ams_delta_serio {
>  	struct serio *serio;
>  	struct regulator *vcc;
> +	unsigned int *fiq_buffer;
>  };
>  
>  static int check_data(struct serio *serio, int data)
> @@ -66,22 +67,23 @@ static int check_data(struct serio *serio, int data)
>  static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
>  {
>  	struct ams_delta_serio *priv = dev_id;
> -	int *circ_buff = &fiq_buffer[FIQ_CIRC_BUFF];
> +	int *circ_buff = &priv->fiq_buffer[FIQ_CIRC_BUFF];
>  	int data, dfl;
>  	u8 scancode;
>  
> -	fiq_buffer[FIQ_IRQ_PEND] = 0;
> +	priv->fiq_buffer[FIQ_IRQ_PEND] = 0;
>  
>  	/*
>  	 * Read data from the circular buffer, check it
>  	 * and then pass it on the serio
>  	 */
> -	while (fiq_buffer[FIQ_KEYS_CNT] > 0) {
> +	while (priv->fiq_buffer[FIQ_KEYS_CNT] > 0) {
>  
> -		data = circ_buff[fiq_buffer[FIQ_HEAD_OFFSET]++];
> -		fiq_buffer[FIQ_KEYS_CNT]--;
> -		if (fiq_buffer[FIQ_HEAD_OFFSET] == fiq_buffer[FIQ_BUF_LEN])
> -			fiq_buffer[FIQ_HEAD_OFFSET] = 0;
> +		data = circ_buff[priv->fiq_buffer[FIQ_HEAD_OFFSET]++];
> +		priv->fiq_buffer[FIQ_KEYS_CNT]--;
> +		if (priv->fiq_buffer[FIQ_HEAD_OFFSET] ==
> +		    priv->fiq_buffer[FIQ_BUF_LEN])
> +			priv->fiq_buffer[FIQ_HEAD_OFFSET] = 0;
>  
>  		dfl = check_data(priv->serio, data);
>  		scancode = (u8) (data >> 1) & 0xFF;
> @@ -116,6 +118,10 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	priv->fiq_buffer = pdev->dev.platform_data;
> +	if (!priv->fiq_buffer)
> +		return -EINVAL;
> +
>  	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
>  	if (IS_ERR(priv->vcc)) {
>  		err = PTR_ERR(priv->vcc);
> diff --git a/include/linux/platform_data/ams-delta-fiq.h b/include/linux/platform_data/ams-delta-fiq.h
> index dc0f835ea918..cf4589ccb720 100644
> --- a/include/linux/platform_data/ams-delta-fiq.h
> +++ b/include/linux/platform_data/ams-delta-fiq.h
> @@ -55,8 +55,4 @@
>  
>  #define FIQ_CIRC_BUFF		30      /*Start of circular buffer */
>  
> -#ifndef __ASSEMBLER__
> -extern unsigned int fiq_buffer[];
> -#endif
> -
>  #endif
> -- 
> 2.16.4
> 

-- 
Dmitry

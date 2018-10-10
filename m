Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A837C46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AE52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhtqx7MZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AE52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeJKAdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:33:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45917 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeJKAdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:33:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so2801999pgd.12;
        Wed, 10 Oct 2018 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yqh6bWuUzP6eSKEYl4RhvXswDfe+ceXyaVCSadEeM5g=;
        b=Mhtqx7MZFgTWmPF5UJ9n5kXPsvmnLf4h4lS3fnlE5/odplKLulzhDCNLt1VHRmUFZE
         6wjPJqKxpf6ZenY8dbd86JxcFdJ8hRiW+JWYFAVl/++qqp8mt6/Wtyf1gdXOPKu12/Ht
         /xyG9WdwteE0DmxnkCrpeCj7dYX/cPo21ia5QqYQqZ28LTYb2gu82vaGGxKFEpqd5i/U
         HUP6/yZCYJj4vPnKM3954qwFKYq8WCWbxSENB6Kbf8v/ugWTJJwevhaXjQ0Obz7BbApW
         K7KTbFTySVlJOUD1XSsCmS2ECBi3I32hA+OgGomIyWKxd5/OgYQV2VPig8shaOAZ7rFb
         9GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yqh6bWuUzP6eSKEYl4RhvXswDfe+ceXyaVCSadEeM5g=;
        b=s4Xh1qrbmyC5P8HAeKjED7FmkP6Us6Llw+BSmNqqcHhGbADbYm4Lur1xZ4zL2qUinI
         oAPh/IzakXoECNh04gz1nGYEaNfpy68FglL65ZQJSmqVnibQLN8n2lzXlqhEH4208ObD
         o1NNI6wRsT5VID3JeKlOv2VnMLn5ZSUQzl/9spRA8B+T2IJ1v1W+PAo0HcCGnVRhjpEM
         2Ombd4HCRYPgeks49u5R1DWUU+eNyb+WvVebIQBvnTj3tyOCQYC74kaeO7YA2fMkJ2Cy
         WVmThKSEGeUEpbOAhCJHK3p4jqFsa2RMvMDUPVNT7bMb1514Rg01nSpvemSPzhEj18t7
         CFFg==
X-Gm-Message-State: ABuFfogf6zm1IVgbN8swntYFi3eR1shpQTtQ1a2aDx2K+jJjwaX0Ct4p
        MbdABjYHM+8iMrz02+0NGwQ=
X-Google-Smtp-Source: ACcGV62znNPaROqlymSnv73J3rpP0Jn19wUHsqg7b0vM9/eVrdQSF8qx8EF0VdBdjWlBgclEtreMHw==
X-Received: by 2002:a63:cc0b:: with SMTP id x11-v6mr16738132pgf.33.1539191417399;
        Wed, 10 Oct 2018 10:10:17 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b3-v6sm35495406pfb.151.2018.10.10.10.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 10:10:16 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:10:13 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 8/8] Input: olpc_apsp: allocate the GPIOs used
Message-ID: <20181010171013.GD47260@dtor-ws>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-9-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-9-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:25:04PM +0200, Lubomir Rintel wrote:
> Take the GPIO lines are used by the SP. The driver doesn't touch the
> lines -- this is done to disallow anything else from fiddling with
> them because that would confuse the SP firmware.
> 
> Also, the lines are now nicely visible in /sys/kernel/debug/gpio.

Linus, is this something that should be handled by GPIO "hogs"?

> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/input/serio/olpc_apsp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
> index fe9e19014e70..287759c5f36d 100644
> --- a/drivers/input/serio/olpc_apsp.c
> +++ b/drivers/input/serio/olpc_apsp.c
> @@ -24,6 +24,7 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
> +#include <linux/gpio/consumer.h>
>  
>  /*
>   * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 controller.
> @@ -76,6 +77,8 @@ struct olpc_apsp {
>  	struct serio *padio;
>  	void __iomem *base;
>  	struct clk *clk;
> +	struct gpio_desc *clk_gpio;
> +	struct gpio_desc *data_gpio;
>  	int open_count;
>  	int irq;
>  };
> @@ -211,6 +214,16 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->clk))
>  		return PTR_ERR(priv->clk);
>  
> +	priv->clk_gpio = devm_gpiod_get_optional(&pdev->dev, "clk",
> +							GPIOD_ASIS);
> +	if (IS_ERR(priv->clk_gpio))
> +		return PTR_ERR(priv->clk_gpio);
> +
> +	priv->data_gpio = devm_gpiod_get_optional(&pdev->dev, "data",
> +							GPIOD_ASIS);
> +	if (IS_ERR(priv->data_gpio))
> +		return PTR_ERR(priv->data_gpio);
> +
>  	/* KEYBOARD */
>  	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
>  	if (!kb_serio)
> -- 
> 2.19.0
> 

-- 
Dmitry

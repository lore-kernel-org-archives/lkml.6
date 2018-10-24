Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4DC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC7D20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC7D20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeJXTnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:43:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42475 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbeJXTnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:43:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3939D208B0; Wed, 24 Oct 2018 13:15:20 +0200 (CEST)
Received: from localhost (unknown [185.7.230.213])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8B70020890;
        Wed, 24 Oct 2018 13:15:19 +0200 (CEST)
Date:   Wed, 24 Oct 2018 13:15:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/5] pinctrl: pinctrl-at91-pio4: simplify getting
 .driver_data
Message-ID: <20181024111518.GA15587@piout.net>
References: <20181021200032.1833-1-wsa+renesas@sang-engineering.com>
 <20181021200032.1833-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021200032.1833-6-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2018 22:00:31+0200, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/pinctrl/pinctrl-at91-pio4.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index 5a850491a5cb..4ee135d7b883 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -868,8 +868,7 @@ static struct pinctrl_desc atmel_pinctrl_desc = {
>  
>  static int __maybe_unused atmel_pctrl_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
> +	struct atmel_pioctrl *atmel_pioctrl = dev_get_drvdata(dev);
>  	int i, j;
>  
>  	/*
> @@ -897,8 +896,7 @@ static int __maybe_unused atmel_pctrl_suspend(struct device *dev)
>  
>  static int __maybe_unused atmel_pctrl_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
> +	struct atmel_pioctrl *atmel_pioctrl = dev_get_drvdata(dev);
>  	int i, j;
>  
>  	for (i = 0; i < atmel_pioctrl->nbanks; i++) {
> -- 
> 2.19.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

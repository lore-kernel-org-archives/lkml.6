Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835DDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AB520820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=slimlogic.co.uk header.i=@slimlogic.co.uk header.b="rFI+KvXj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o6qhpygC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AB520820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=slimlogic.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393285AbeKVTer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:34:47 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54749 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731714AbeKVTer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:34:47 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4AD9E228F1;
        Thu, 22 Nov 2018 03:56:15 -0500 (EST)
Received: from web4 ([10.202.2.214])
  by compute6.internal (MEProxy); Thu, 22 Nov 2018 03:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slimlogic.co.uk;
         h=message-id:from:to:cc:mime-version:content-transfer-encoding
        :content-type:in-reply-to:date:references:subject; s=fm1; bh=mhh
        WAt9m3BcOFh7Z7sVRFf0ZeOaTRktGCxTzbk0QATE=; b=rFI+KvXj0ksPUkSUvZ5
        Vl8vwTrjbkZEigDI1QcQ7rR6KhEXcusYi2/0unRY4S2RMno1JZ25Nv+rMlqzRtUH
        vSOwCUbtSljXjdC/zMCw55wehH7/Y8bWQlX7nt3xD2BX5++y2TDpVsEECVPugWMa
        fl3l2OzIVjVJJG+OjPuAf3l9C4sRvMq/C+zhvncHN7GopMeJltKsnSm419odHR/y
        cHLjagZcXMc50NFrZNg9axUBGHWcAJQ3KYZa+Po9NrrPj8umkceZgs2vV5IB1acX
        LrZmNcK3uiuEQTCNGon+MuhbNyUter7Eh0oixh/IcHrI7fcM5a8YcvHpYpEhJ6J+
        bFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=mhhWAt9m3BcOFh7Z7sVRFf0ZeOaTRktGCxTzbk0QA
        TE=; b=o6qhpygCdKoxa5wqNGHURLf/UY3/x7ZpacTrUCJAsY6Rk1SM8n7w9D2OZ
        OxMZBzbDD22G9BGP4C53p5GX8tZ/8LIijaewS4LmT5XvybiNHlenllQvJlhqFm6O
        8xO1CnE/M0KaNVANywQTyBOfqsTIgGkHHYoJcVsPwssQ5DQuoqHgzaIFxwUZCcyN
        94h7BxkUi7IesolBehPprgMZN13Tl0TlQUjZ3q7U+DSfbiClCyFbCyl5afwXnBbY
        aY/W2lq12RUF+Ek5/tygYd+5F4ZHwEeos487pohORX/SzRc6+o6gVGlj9ceIPCBw
        Wdek37YYA754gW/Ix2jlEnRS3n29A==
X-ME-Sender: <xms:Lm_2W8K18JBl_fMKMForHYywbWTtKXswBnLPzAdzPWAbQwikYR7DdA>
X-ME-Proxy: <xmx:Lm_2W8VwtlVbYzTEX5jgIbjIhyf0bUa7bj-7Q5J0cHF_6d2NoaCj5g>
    <xmx:Lm_2W-0xDwtZucmwlMpB2nX90ilvKcQiomZ0KwtITT-Ru92Sp-AfRg>
    <xmx:Lm_2W5gnmIdE0n8FZZBk_s8LVtpj-fb0luOAaL4mpBstrGDZoUvj8g>
    <xmx:Lm_2W8iVEE0V3nSnvf5dcHv0sc_h8FSBGr1iKQBo285aKYW2vdWbuw>
    <xmx:Lm_2Wz6dcT6ipHTr_W0KFSXJvgJDVj2g0fttP6s2UJvXzFQ6Rf25_Q>
    <xmx:L2_2W5h8lhusQE59twte-VZPqUsxqJiFdaRqq_5kcQPDI2RREWCUqg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id DD778BA7C4; Thu, 22 Nov 2018 03:56:13 -0500 (EST)
Message-Id: <1542876973.660187.1585411488.20C3DE15@webmail.messagingengine.com>
From:   Graeme Gregory <gg@slimlogic.co.uk>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        linux-omap@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-3449945b
In-Reply-To: <1542861179-8941-10-git-send-email-paul.gortmaker@windriver.com>
Date:   Thu, 22 Nov 2018 08:56:13 +0000
References: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com>
 <1542861179-8941-10-git-send-email-paul.gortmaker@windriver.com>
Subject: Re: [PATCH 09/11] mfd: tps65910: Make it explicitly non-modular
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Nov 2018, at 4:32 AM, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config MFD_TPS65910
> drivers/mfd/Kconfig-    bool "TI TPS65910 Power Management chip"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
> 
> We don't replace module.h with init.h since the file already has that.
> We do delete an unused moduleparam.h include though.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
> 
This is all fine with me.

Acked-by: Graeme Gregory <gg@slimlogic.co.uk>

Thanks

> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Graeme Gregory <gg@slimlogic.co.uk>
> Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/mfd/tps65910.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
> index bf16cbe6fd88..aa3d472a10ff 100644
> --- a/drivers/mfd/tps65910.c
> +++ b/drivers/mfd/tps65910.c
> @@ -1,5 +1,5 @@
>  /*
> - * tps65910.c  --  TI TPS6591x
> + * tps65910.c  --  TI TPS6591x chip family multi-function driver
>   *
>   * Copyright 2010 Texas Instruments Inc.
>   *
> @@ -13,8 +13,6 @@
>   *
>   */
>  
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
>  #include <linux/init.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> @@ -374,7 +372,6 @@ static const struct of_device_id tps65910_of_match[] = {
>  	{ .compatible = "ti,tps65911", .data = (void *)TPS65911},
>  	{ },
>  };
> -MODULE_DEVICE_TABLE(of, tps65910_of_match);
>  
>  static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
>  						unsigned long *chip_id)
> @@ -527,8 +524,6 @@ static const struct i2c_device_id tps65910_i2c_id[] = {
>         { "tps65911", TPS65911 },
>         { }
>  };
> -MODULE_DEVICE_TABLE(i2c, tps65910_i2c_id);
> -
>  
>  static struct i2c_driver tps65910_i2c_driver = {
>  	.driver = {
> @@ -545,14 +540,3 @@ static int __init tps65910_i2c_init(void)
>  }
>  /* init early so consumer devices can complete system boot */
>  subsys_initcall(tps65910_i2c_init);
> -
> -static void __exit tps65910_i2c_exit(void)
> -{
> -	i2c_del_driver(&tps65910_i2c_driver);
> -}
> -module_exit(tps65910_i2c_exit);
> -
> -MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
> -MODULE_AUTHOR("Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>");
> -MODULE_DESCRIPTION("TPS6591x chip family multi-function driver");
> -MODULE_LICENSE("GPL");
> -- 
> 2.7.4
> 

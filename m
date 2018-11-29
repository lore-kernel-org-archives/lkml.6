Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD078C07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1D6213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd9+rFws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1D6213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeK3Fn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:43:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38515 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeK3FnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:43:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so1449873pfi.5;
        Thu, 29 Nov 2018 10:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BMV86iOUY9CP8xxtOTmF1D1KrYI5IvEZqgAjjuU7nkg=;
        b=Gd9+rFwsFdLTNWphGiToRtlGAD2UESOaObnBQx+9wexhyX9GZxUyVvNl1WViKjh1uj
         3chmszJfkITdqF0f7V7/8a7+61C2COkwPk3M/CSBLPpj8REFmQjgl9NftYlTO9wuqa7H
         vH5N9NmLTgxyOavJ/1Qqb52zUJMl8rjBAF62/A6fvNNAFhrpbCW2pb9NISRfPKLoLTOY
         1TwpVV4CGJLerDc7RuvwjcO0rBwysUYUp7TRfh/IlOcPcrEA/pOd2d8T5c46TcFPiW0k
         YqGr2n2gG4x+TK5g19u/NgY8zA1Tyt7D45tdY16oyY5XIv0GeIKX+fNFIs7mLjxg0UqQ
         /BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMV86iOUY9CP8xxtOTmF1D1KrYI5IvEZqgAjjuU7nkg=;
        b=SU2uysmiAY+07XNxE4TS0f6n7dlDdEMMIdBxBhs+I5a49FJ5Rd1uz2I0cywX16i2O3
         awHYTJaVfkVFRSnyfht2bANCgkqaH05jDTsos93M4NBmHEbPWP/SSy4U4Coc1H5iwxds
         ZbjIey5xn4/jHwKnkK+JG2A7/DLpw3yrGo5cWvFKi67r7XPcn1+TA8f3JBpzJoqAMPsj
         9pp5CuFd3Iu8sCXPeZOkQZP/Xbdy4YwXPBXWLHlVLa4T0kDBSZAB3ZVCM52cRZ3IU7rg
         kv+3xbgKVXttXK1dIO/HqndWmNzjaXRJ5vhS5zr/0Cl6XXLQtNmt5UkYsEH51wHZtMHh
         +BdQ==
X-Gm-Message-State: AA+aEWZXs5gWFmI59gNGiblQWSjjvpzvOndkoYYTZJR5XW/MnDOcF5Ik
        yoc+BWbXfhskre1GSZXDdDE=
X-Google-Smtp-Source: AFSGD/UZvr5jp4/0+8mJK4OoHExnjGBdkxwUPipszuStri32CSprZ5aeOFoD9f+1OCwu9H+4GxDGpA==
X-Received: by 2002:a62:1289:: with SMTP id 9mr2519177pfs.102.1543516620279;
        Thu, 29 Nov 2018 10:37:00 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v5sm3552682pgn.5.2018.11.29.10.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 10:36:59 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:36:57 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 add of_node_put()
Message-ID: <20181129183657.GD54791@dtor-ws>
References: <20181121143513.22961-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121143513.22961-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Wed, Nov 21, 2018 at 09:35:13AM -0500, Yangtao Li wrote:
> use of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/input/serio/i8042-sparcio.h | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> index 796289846204..5495bc035518 100644
> --- a/drivers/input/serio/i8042-sparcio.h
> +++ b/drivers/input/serio/i8042-sparcio.h
> @@ -108,18 +108,21 @@ static struct platform_driver sparc_i8042_driver = {
>  
>  static int __init i8042_platform_init(void)
>  {
> +	int rc;
>  	struct device_node *root = of_find_node_by_path("/");
>  
>  	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
>  		/* Hardcoded values for MrCoffee.  */
>  		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
>  		kbd_iobase = ioremap(0x71300060, 8);
> -		if (!kbd_iobase)
> -			return -ENODEV;
> +		if (!kbd_iobase){
> +			rc = -ENODEV;
> +			goto out;
> +		}
>  	} else {
> -		int err = platform_driver_register(&sparc_i8042_driver);
> -		if (err)
> -			return err;
> +		rc = platform_driver_register(&sparc_i8042_driver);
> +		if (rc)
> +			goto out;
>  
>  		if (i8042_kbd_irq == -1 ||
>  		    i8042_aux_irq == -1) {
> @@ -127,13 +130,18 @@ static int __init i8042_platform_init(void)
>  				of_iounmap(kbd_res, kbd_iobase, 8);
>  				kbd_iobase = (void __iomem *) NULL;
>  			}
> -			return -ENODEV;
> +			rc = -ENODEV;
> +			goto out;
>  		}
>  	}
>  
>  	i8042_reset = I8042_RESET_ALWAYS;
>  
> -	return 0;
> +	rc = 0;
> +out:
> +	of_node_put(root);
> +
> +	return rc;

Instead of rearranging code like this, can we instead have:

static inline bool i8042_is_mr_coffee(void)
{
	struct device_node *root;
	bool is_mr_coffree;

	root = of_find_node_by_path("/");
	is_mr_coffree = !strcmp(root->name, "SUNW,JavaStation-1");
	of_node_put(root);

	return is_mr_coffee;
}

?

Thanks.

-- 
Dmitry

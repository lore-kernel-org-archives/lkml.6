Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE0AC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B26C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7ns2Blx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B26C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeIYFLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:11:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55760 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeIYFLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:11:46 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so4822609itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hHPOn700Cvv6nz7O9Tql1vFayIAICs0JvoJEL+U86Rg=;
        b=K7ns2BlxweCeEAs10ypsVYqswacJLLfak96kIQaTZh7hAY74Qj888wkhXvnXipAX1X
         pxo/oIgsr+9Ym37BERfyh7dk6jDx74Jt2g5CdgcosNPSdMbRsEI1PV3KvJo52NxehJd3
         AJQjMbTvuULQUeu22ljC82SUtiCb4QiRVIhKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hHPOn700Cvv6nz7O9Tql1vFayIAICs0JvoJEL+U86Rg=;
        b=mjiPtWeJWlIV+HBWuXiKD9JLRIqCCuISMUnToDWk6Nlv+5v0S6IIqodGFHlgP2/2Tq
         QOBo+V/Ums3/wfwc+pIyoBxu3mlt/JYe7C8u7EyubP99uW7CXenQQ8FtZS/Oow021xNT
         erIB+1YcDygffWYwp8xaBMIqwjiQiLiGy0QUGEObw5X84mWH3CjM1mR7mIdnpGJzQ7cp
         rf7rR66W1hYekI0DB8ZszDluiz7eZqsAcmg0CCF+Mhapxjqq8q8tgg6tnbLPAyfrwM8j
         TcO2UOAwySQ/ta8ZccytyNa5NfF6hRMmB3UA62ta/pyGEbmBZuallOTRBOD3LFZ1SRy4
         dVMQ==
X-Gm-Message-State: ABuFfohZ8lCNBsARx6lwAFXXu5M9cdgK3m0rMTFpMiTggKgZbuLrL/rS
        rzm27PgxGgm1H1rNKYF4K5Pk8A==
X-Google-Smtp-Source: ACcGV62ikZll5T0Q/Cuz83B1U40esQ4xarZUZnAfIYN0PotennKQAMqbxT/SBxDEpvEN0hdf3oHJ5A==
X-Received: by 2002:a24:1d84:: with SMTP id 126-v6mr568978itj.63.1537830432377;
        Mon, 24 Sep 2018 16:07:12 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id o201-v6sm186766ito.41.2018.09.24.16.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 16:07:11 -0700 (PDT)
Date:   Mon, 24 Sep 2018 18:07:10 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 164/235] pinctrl: pinmux: Return selector to the
 pinctrl driver
Message-ID: <20180924230710.o7bqbw353few6pjw@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113121.469295005@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924113121.469295005@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:52:30PM +0200, Greg Kroah-Hartman wrote:
> 4.18-stable review patch.  If anyone has any objections, please let me know.

I bisected a boot failure on an x15 (arm) board to this commit on
4.18.10-rc1. I'm also seeing issues on 4.14 and 4.18 with arm64 boards
hikey and dragonboard 410c, but I have not investigated them yet (they
could be unrelated).

I see there are fixes to this commit that have not been backported.
Namely:

823dd71f58eb ("pinctrl: ingenic: Fix group & function error checking")
a203728ac6bb ("pinctrl: core: Return selector to the pinctrl driver")

However, I tried adding those two in but I still see the boot failure on
x15.

Dan

> 
> ------------------
> 
> From: Tony Lindgren <tony@atomide.com>
> 
> [ Upstream commit f913cfce4ee49a3382a9ff95696f49a46e56e974 ]
> 
> We must return the selector from pinmux_generic_add_function() so
> pin controller device drivers can remove the right group if needed
> for deferred probe for example. And we now must make sure that a
> proper name is passed so we can use it to check if the entry already
> exists.
> 
> Note that fixes are also needed for the pin controller drivers to
> use the selector value.
> 
> Fixes: a76edc89b100 ("pinctrl: core: Add generic pinctrl functions for
> managing groups")
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Christ van Willegen <cvwillegen@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Tested-By: H. Nikolaus Schaller <hns@goldelico.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pinctrl/pinmux.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> --- a/drivers/pinctrl/pinmux.c
> +++ b/drivers/pinctrl/pinmux.c
> @@ -308,7 +308,6 @@ static int pinmux_func_name_to_selector(
>  		selector++;
>  	}
>  
> -	dev_err(pctldev->dev, "function '%s' not supported\n", function);
>  	return -EINVAL;
>  }
>  
> @@ -775,6 +774,16 @@ int pinmux_generic_add_function(struct p
>  				void *data)
>  {
>  	struct function_desc *function;
> +	int selector;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	selector = pinmux_func_name_to_selector(pctldev, name);
> +	if (selector >= 0)
> +		return selector;
> +
> +	selector = pctldev->num_functions;
>  
>  	function = devm_kzalloc(pctldev->dev, sizeof(*function), GFP_KERNEL);
>  	if (!function)
> @@ -785,12 +794,11 @@ int pinmux_generic_add_function(struct p
>  	function->num_group_names = num_groups;
>  	function->data = data;
>  
> -	radix_tree_insert(&pctldev->pin_function_tree, pctldev->num_functions,
> -			  function);
> +	radix_tree_insert(&pctldev->pin_function_tree, selector, function);
>  
>  	pctldev->num_functions++;
>  
> -	return 0;
> +	return selector;
>  }
>  EXPORT_SYMBOL_GPL(pinmux_generic_add_function);
>  
> 
> 

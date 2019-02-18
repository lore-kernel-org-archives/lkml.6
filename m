Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD114C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39F22184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520462;
	bh=xKLSQXhAzNYlpHBDBERxxeHLNT30q/zzIP1hWIkXWCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xpvdejSOZ+1ZuNBjvYyp8ZcFgniO7dQGHYsP027Ac1tSI027N0+phONjBXXIMloyl
	 KtZ+zOEE9l9EdWoOHGaAoWONuhiUotNEsnzyXy2x8lV+bU4XN5vpCpBH4Iy3DdreLn
	 vSpW8Iw7b4ImtHVxI3jeq7utBPB5JwfYO8WsvGuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfBRUHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:07:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37557 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:07:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so30360090otp.4;
        Mon, 18 Feb 2019 12:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2b2Y7Iun/ctFLRuKgbIgA/ZW1xFrkIh5XOjZf/ESH0=;
        b=bTPetOm0f4s4ubQY8sZBIG1PVbg2rU9ru/pU/ox/9MuwUQ836uIGWn8hSMeUK0ettC
         KcttzLhml4Tlg5yHxBQQZf25zpvY+myS7npCTVyredd7p49FxBS0TiElCsKWJb/PN0Xl
         vyeLBT+XHu+TkqAGv/hg4p5s3NBW622hGTuT22WfxnKofx96TiX+shiw+ArZZphcDoA5
         Ac5MWTZpKkyj4n2871Sxotua775WZir03VZBG9hGu5bNlG4ayAZXKCfuf8jXqPuKhypV
         pTUoMjUPs6tcxqObFkg/ibM9NGmtLi+Qi32DW/HpIhnDAjxCQiXypSFYBCfEEm9Fu18c
         R+0g==
X-Gm-Message-State: AHQUAubUd3qqzhMTKE3fkmJUMvzut4BHwG0TIzyupGpMBYoYDCWQUZ4i
        hamSQ53cj4EuCJqG60U0Hw==
X-Google-Smtp-Source: AHgI3Ib+3bJbxk7SZVGjbtY7CqGonFbJ1GuDuX9C980gjU/r61mVUxzB9YGCnbP8DaXdVS1IWfmdHw==
X-Received: by 2002:aca:428b:: with SMTP id p133mr322093oia.123.1550520459050;
        Mon, 18 Feb 2019 12:07:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r13sm2417343otq.8.2019.02.18.12.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:07:38 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:07:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     mark.rutland@arm.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gpio: sprd: Change to use SoC compatible string
Message-ID: <20190218200737.GA7091@bogus>
References: <3818909a5d6f956ef30ff25cfc42f7550d062086.1550201284.git.baolin.wang@linaro.org>
 <ad2fbe222ad715b3f7e6e093a7f822743e465f9a.1550201284.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2fbe222ad715b3f7e6e093a7f822743e465f9a.1550201284.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:55:19PM +0800, Baolin Wang wrote:
> Change to use SoC compatible string instead of wildcard string.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - None.
> ---
>  drivers/gpio/gpio-pmic-eic-sprd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
> index ac573da..24228cf 100644
> --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> @@ -364,7 +364,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id sprd_pmic_eic_of_match[] = {
> -	{ .compatible = "sprd,sc27xx-eic", },
> +	{ .compatible = "sprd,sc2731-eic", },

You need to keep the old one if you care about backwards compatibility. 
If you don't then state why in the commit message.

>  	{ /* end of list */ }
>  };
>  MODULE_DEVICE_TABLE(of, sprd_pmic_eic_of_match);
> -- 
> 1.7.9.5
> 

Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3C0C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2909E218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWHfYk5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBGLCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:02:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51688 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBGLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:02:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so5641202wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=J/pM0jxyaOEUTLPWuvo5olApQH7SNEpeuvTbqTu51bA=;
        b=kWHfYk5sNUc7DK611zxEgHqlydUZiOX0B/p0pD6Ybn8zad/aeMwI+vPeco1NJK6/mv
         n1jdKN9bGGsZW3OkXs9IPVPBmLLKWX1MxUf4t+xc0waVEYGL5AezAIcP8GjKvWz6lQbK
         fcDUgTD1KJlKKBHLRMC0howf+kuh5QJulVwe0LY1PRI7Y/ERC0c37CRv2rJBJkQQNcHf
         pAwgNC/uURfEU7lSsEkEtKScLnWExVp743hL68qNRpYgqTPHq3Lq8ZZf+mJLrfEVuko7
         z9Var2N0Jt11dds4j2I0ApwRpfha4fG5pouCM9K1Tymy/BB1rwrrkgJQy7tP+wgiOXf6
         doig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J/pM0jxyaOEUTLPWuvo5olApQH7SNEpeuvTbqTu51bA=;
        b=LZJgcMnbj7F2CDnwJF/RoGL3m22eojDd59MAt5aD5mQm2QBN8IQLPSIIfL54njFfMa
         COPnxHCOi1ESV5W1gUrquiecRDdeEmckn1r/ueQLoN5n77wevQ5ml6hpGCBatotV/mT0
         +cr5YSV4oPpGoYlj+q4YuvWwBXJf+l1PWhwXuhneP4G+SDTuWT+UGHk52/wZo60KOHKj
         l3YfuYMFQSWi8ri6MjKlPYqDy4NY802ZNuCzJiN/+YtO0Hzpo+4pyyThCvCFrya5J4Mu
         CarFDHe/tjF7helz36obegSuvdLTJGc90W/a4Mr86v1io4yKLD4XYmm//atZRGKGECZe
         TsiQ==
X-Gm-Message-State: AHQUAuawNsie6PtmfMNl0J+muSNMEe8MoG++WEaAHGTGbSk/x+XRKLPi
        y8vvtfDp+0NByrEcyM4ryyiugA==
X-Google-Smtp-Source: AHgI3IY+ZRaQ1ZHmwrTN0Hx/PWGH9S3/GQrjaoecCVZeXtNwlzby8OUxZxKGUq7K7foY0S3YD2tOdA==
X-Received: by 2002:a1c:7a03:: with SMTP id v3mr1428214wmc.57.1549537369322;
        Thu, 07 Feb 2019 03:02:49 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id q12sm21622838wrx.31.2019.02.07.03.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 03:02:48 -0800 (PST)
Date:   Thu, 7 Feb 2019 11:02:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFT PATCH 7/9] mfd: axp20x: add USB power supply mfd cell to
 AXP813
Message-ID: <20190207110247.GE20638@dell>
References: <20190207064535.9226-1-wens@csie.org>
 <20190207064535.9226-8-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190207064535.9226-8-wens@csie.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2019, Chen-Yu Tsai wrote:

> From: Quentin Schulz <quentin.schulz@bootlin.com>
> 
> The AXP813 has a VBUS power input. Now that the axp20x_usb_power driver
> supports this variant, we can add an mfd cell for it to use it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> [wens@csie.org: add commit message]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 3c97f2c0fdfe..17b115845993 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -198,6 +198,12 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>  };
>  
> +/* AXP803 and AXP813/AXP818 share the same interrupts */
> +static struct resource axp803_usb_power_supply_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),

Nit: Why 2 spaces here?                              ^

With that fixed, you can add my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

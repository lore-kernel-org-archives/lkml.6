Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F19C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EAC205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNyGzxvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfBTLQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:16:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37941 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfBTLQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:16:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so6021357wmh.3;
        Wed, 20 Feb 2019 03:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hcoE6dM0ipPacXSKpEUVwoCOfF5UW9l4UO/l4vXJhv4=;
        b=SNyGzxvBAH3e/f2cgB8yb8c6g5DFA1+a9ylVnOlcBGXq+VBb0I33mBXLQ/vzIjlQd0
         vTWlSrE/WG3S9kCChwDqUO9sxojk2bxfY7GMnLqw4wiuKKvgGc24xIyUDWcV8/bE5Qao
         14OQx/rqAAQd+Tsv5x5ubNekp/asPqZvke+5cH6U88KqwYv9UPYSPt1K8YEvNa58pDx+
         bnateBvS95isLTVswSRx+LdC0oV+VRjGnDJkglEoZiyhTL8JqCF49RLwQuy/zUcU4xns
         Z3FWEpm2M0MO9rEeJmrxtXwEJ15EyJt2uKTTlTqtrp5pXVZdW7iBIBCsdUMLfJDpvd/A
         F5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hcoE6dM0ipPacXSKpEUVwoCOfF5UW9l4UO/l4vXJhv4=;
        b=C3C+g1f89UyaITN1WLV5ITmtGIS5wmka0AUX91vgCjXEKPsePTeh135CCyhPo7Bt1n
         ME+fXsc6CZ+71yIVGhBeMiyYGeAsrO2awioxupxAS2fWJs8mSvTWhf2xFg3HKyY+PG7M
         zDZ5+edKbyNydxgk5w0FTZPMWi7KNvY7XRylNtwqp7Xe+0OFx1aFAd5HP13HXLmjd9ft
         f0f/UzqSjiW+R76fAavmW24SXGW52zAyeaSzNN3EqyT0q3wi2tCQ2JXLW+vE3ETUI4sr
         c6iGr1r7+ubHCXLgdOTGzusqUe7aVNmD+JwtpL/LjkGcgYM39K3318Qv/3b7+Anj7twQ
         GQ6w==
X-Gm-Message-State: AHQUAuYS7nAsGVxsgEtJ2iXtHJjZ82x2SsRqpOfCtvF6qKbiCEgnvf4M
        TWtJ/N0g6lwNDWQ/r0A2VrqS6jDD
X-Google-Smtp-Source: AHgI3IY1CZgQHWKcXw5YU3jCHImWK/OFsI5bk602PSYUti0n8WnbxahFseqLtxirvtxNRX7BKItK8A==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr6535620wmf.38.1550661367940;
        Wed, 20 Feb 2019 03:16:07 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id d24sm60117579wrb.47.2019.02.20.03.16.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:16:07 -0800 (PST)
From:   Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] gpio: of: Restrict enable-gpio quirk to regulator-gpio
To:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20190220105214.26618-1-thierry.reding@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <9f6eed1d-0c7f-f3e6-f091-3faf8fcc966a@gmail.com>
Date:   Wed, 20 Feb 2019 12:15:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220105214.26618-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 11:52 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Commit 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only to
> enable-gpios") breaks the device tree ABI specified in the device tree
> bindings for fixed regulators (compatible "regulator-fixed"). According
> to these bindings the polarity of the GPIO is exclusively controlled by
> the presence or absence of the enable-active-high property. As such the
> polarity quirk implemented in of_gpio_flags_quirks() must be applied to
> the GPIO specified for fixed regulators.
> 
> However, commit 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only
> to enable-gpios") restricted the quirk to the enable-gpios property for
> fixed regulators as well, whereas according to the commit message itself
> it should only apply to "regulator-gpio" compatible device tree nodes.
> 
> Fix this by actually implementing what the offending commit intended,
> which is to ensure that the quirk is applied to the GPIO specified by
> the "enable-gpio" property for the "regulator-gpio" bindings only.
> 
> This fixes a regression on Jetson TX1 where the fixed regulator for the
> HDMI +5V pin relies on the flags quirk for the proper polarity.
> 
> Fixes: 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only to enable-gpios")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/gpio/gpiolib-of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 1b4c741e0635..bddfc6102a50 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -84,10 +84,10 @@ static void of_gpio_flags_quirks(struct device_node *np,
>  	 * Note that active low is the default.
>  	 */
>  	if (IS_ENABLED(CONFIG_REGULATOR) &&
> -	    !strcmp(propname, "enable-gpio") &&
>  	    (of_device_is_compatible(np, "regulator-fixed") ||
>  	     of_device_is_compatible(np, "reg-fixed-voltage") ||
> -	     of_device_is_compatible(np, "regulator-gpio"))) {
> +	     (of_device_is_compatible(np, "regulator-gpio") &&
> +	      strcmp(propname, "enable-gpio") == 0))) {
>  		/*
>  		 * The regulator GPIO handles are specified such that the
>  		 * presence or absence of "enable-active-high" solely controls

On R8A7795 Salvator-XS
Tested-by: Marek Vasut <marek.vasut@gmail.com>

-- 
Best regards,
Marek Vasut

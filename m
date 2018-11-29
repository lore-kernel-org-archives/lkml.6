Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F2DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E32081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWrtYGvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412E32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeK2WzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:55:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35947 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeK2WzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:55:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so1651770edb.3;
        Thu, 29 Nov 2018 03:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JGEzD/RveMfJI747izxHlPNnHHV3qWXMsNUmThPClW8=;
        b=OWrtYGvMoKO2RxsGuiQtO43Acb6CeXnvNLa+CjIlIQG30ycvoTo5vcbdClTvPYu0In
         ETAL9o0V4cRMvEwbAW2g6ZBDX8KNodmnGKGwnnpWbKHYIkwNHmI9FntiT0zIIwZOtwTy
         yNuNC+139ZOBCVJ8tgBU+jx047MVnX9E8ZViUN/AJk3vzSSDtYNzXEXx3tkr29B+UmXe
         xnlqB56aU8TwV9Vc1d0YCP0FpLCfMIUMxMY8ueTEhcJnh1pTL0TF4Ju+vL2M3s2CQn+Y
         c+pxjWmvPmiCFwxwvPOlavdZ3L0CY7V2NlTZApd2x40IaewUTsSvWcCHCQQrFTfUwqlo
         j4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JGEzD/RveMfJI747izxHlPNnHHV3qWXMsNUmThPClW8=;
        b=WJtkaXzzNWr0W6PcsazfrdrwL9PHhVjfkc4knrCmUuF+C/hOF+Z2AIwwtsNaixUPjZ
         yqqs0VGmVO3n93P+sziZD6BULo6BtuFAPwCPY6fyR2bg9l/azjFSHznyFIZckFh4hUMc
         Kh3xTLtz8HXz7JJI5c3zbVh6I5CHXnllnhn7BFAff5KOTu6dwRuuqVtp7CmOtiDpk1N6
         0S+qSHmuzvfndZuFB8EYj3OytB3AxWNfNi1VIUhFVCuTIml8Dr5WSOo5DMwm2Lsjb3Mf
         JR+Ufih6eZnDqh9cjNWX/GGOmkyLo4vXkqiUBRLdIcjN9YyebUHOUSpHDs/KE5F1fE0F
         Dzrg==
X-Gm-Message-State: AA+aEWbUc9qaNbXP8v30ncS2SieIxPW3kj5ADfZ9beAjBKPPp5Cl/D78
        ySMsp1oKtCf/KqhPS9JAVhg=
X-Google-Smtp-Source: AFSGD/WZbbraXv/fy30xvL5OACje6lRPOLDyRLQl1/OMkWRnb1qtQGGCTXsJIu1mmwnVKUG+89EMDw==
X-Received: by 2002:a17:906:30d5:: with SMTP id b21-v6mr1412903ejb.42.1543492209337;
        Thu, 29 Nov 2018 03:50:09 -0800 (PST)
Received: from ziggy.stardust ([37.223.145.41])
        by smtp.gmail.com with ESMTPSA id z6-v6sm313300ejq.63.2018.11.29.03.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 03:50:08 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: Add uart for mt6797 EVB
To:     matthias.bgg@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
References: <20181116183040.18696-1-matthias.bgg@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <4a28375f-7487-f745-5d05-e2bc4c939369@gmail.com>
Date:   Thu, 29 Nov 2018 12:50:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116183040.18696-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2018 19:30, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> This patch adds the pinctrl configuration for the mt6797 EVB.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6797-evb.dts | 2 ++
>  arch/arm64/boot/dts/mediatek/mt6797.dtsi    | 7 +++++++
>  2 files changed, 9 insertions(+)
> 

pushed to v4.20-next/dts64


> diff --git a/arch/arm64/boot/dts/mediatek/mt6797-evb.dts b/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
> index c79109c65409..237e869a5fa1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
> @@ -33,4 +33,6 @@
>  
>  &uart0 {
>  	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_a>;
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> index a64bb84bdec3..2b2a69c7567f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> @@ -142,6 +142,13 @@
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  
> +		uart0_pins_a: uart0 {
> +			pins0 {
> +				pinmux = <MT6797_GPIO234__FUNC_UTXD0>,
> +					 <MT6797_GPIO235__FUNC_URXD0>;
> +			};
> +		};
> +
>  		uart1_pins_a: uart1 {
>  			pins1 {
>  				pinmux = <MT6797_GPIO232__FUNC_URXD1>,
> 

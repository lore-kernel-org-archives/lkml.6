Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C230C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454522133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=adirat-com.20150623.gappssmtp.com header.i=@adirat-com.20150623.gappssmtp.com header.b="TkBWGGDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfA0Ud1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:33:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36024 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA0Ud1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:33:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so11675256wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 12:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adirat-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=w+2Ky73FIN6TlxiPuvYaVz5DmY08FlUVHBFUHW5SDNg=;
        b=TkBWGGDFWBG9o5t/MH/Siu2TrPb42Sja+LQ98X/Z/pcOccNpVxse6p7WS9BD+bWRpo
         SwuV+VUKOG1uITkZhVNte3wRLp965YOZQv8dnIT56ds2MnV1INawx1MzrPnVADHNUisY
         7Yrm6zQxA8hVGlogNttnzDBqLl8TrJ8iqI62unSMJOvWoP+zkVcWtlNphtfKG+h+ijDh
         LNMU/c0c/6CU/sdxGBEPV18jgqPPAHCEfh+shjlI3fHSSkyz2f2GFB8gjBV8b595XxuK
         ekquaSAyoAXkA9hMr6/MLDb/vwMFCQbMOBvhzJbWgGdwPQXYjtnCvaGko1riXs7TST0S
         DGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=w+2Ky73FIN6TlxiPuvYaVz5DmY08FlUVHBFUHW5SDNg=;
        b=U8T3Kx/Z5fexgrysxjaU7/jbPeZWqlnO8OEOb2AxEr5muSDN7ORZPqkuAObLRIhVju
         /Cdib9xWt4SzVjzXSHiK5ZzjWh00neYC3aLtDJLUP3habEHJS0hSDaIj+3aDKCVRBJwk
         X6gke20ZgfrOPgq+ckQKlW6fNPnTWmH9XHAwG0oztrbKbIcpC979YNrRCp96zI9mxowZ
         EYoezdITdcW/mFGJq/DCIWrnVdGTwlG1FyxYrZafIWx2fZr4PR9zfk0qLhZ6+kpuVaOX
         xlaBUx8BraPfSNb0u4sMK6Mtu2XTA8skKkZNXamZCWzeKkiKfzY/aVmapC3xfTpiH97X
         9ykQ==
X-Gm-Message-State: AJcUukcCjGoGcl6k48ZTV1rlFYs6FFsywpm0RaaLjoiic1QJxUBmUm9D
        CjbHzaaKZgoxU4BQLD4MwFpnZ4SDbYG1IQ==
X-Google-Smtp-Source: ALg8bN7s8T381hkPCjXZrvo4gcKVdI7yLThV6JsWcGCWbMQUkJsJhLiMAHaSfZAklW/DxLlDZPgXDg==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr13853333wme.84.1548621205320;
        Sun, 27 Jan 2019 12:33:25 -0800 (PST)
Received: from iwork ([188.24.59.111])
        by smtp.gmail.com with ESMTPSA id o16sm159165303wrn.11.2019.01.27.12.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 12:33:24 -0800 (PST)
From:   Ioan-Adrian Ratiu <adi@adirat.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [RFC][PATCH] Revert "ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs"
In-Reply-To: <20190127202813.29493-1-adi@adirat.com>
References: <20190127202813.29493-1-adi@adirat.com>
Date:   Sun, 27 Jan 2019 22:33:24 +0200
Message-ID: <87zhrl96y3.fsf@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link to the full 4.19.18 config I'm using:

https://drive.google.com/open?id=1ZI3MeGB2fkYMsEjzGQYXUk2wqr0h9h7R

On Sun, 27 Jan 2019, Ioan-Adrian Ratiu <adi@adirat.com> wrote:
> This reverts commit bea8a160c621d19f7f78b13e14e03f4b8e44cd4b.
>
> Contrary to what the commit message says, on my rpi 3 b v1.2 changing
> the polarity causes the exact behaviour this commit intends to fix, as
> described at the referenced link below (wlan0 disapears).
>
> With reset-gpios = ... GPIO_ACTIVE_HIGH, brcmfmac errors in dmesg:
>
> [    7.977512] brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
> [    7.977623] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.978007] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.978377] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.978724] brcmfmac: brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
> [    7.978734] brcmfmac: brcmf_proto_bcdc_query_dcmd: brcmf_proto_bcdc_msg failed w/status -110
> [    7.978747] brcmfmac: brcmf_cfg80211_get_channel: chanspec failed (-110)
> [    7.982817] brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
> [    7.982880] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.983255] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
>
> The only solution I currently have is to revert and everything works
> as expected and as before changing the polarity.
>
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911443
> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
> ---
>  arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 +-
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> index 93762244be7f..4adb85e66be3 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> @@ -31,7 +31,7 @@
>  
>  	wifi_pwrseq: wifi-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
> -		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> index 89e6fd547c75..c318bcbc6ba7 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -26,7 +26,7 @@
>  
>  	wifi_pwrseq: wifi-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
> -		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
>  	};
>  };
>  
> -- 
> 2.20.1

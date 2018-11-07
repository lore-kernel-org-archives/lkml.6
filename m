Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D15C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6F920827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="In5Z78tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6F920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeKGWRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:17:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39322 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeKGWRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:17:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so17248263wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 04:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dabjdtAH3uYSr1byjY4hPEot3YFqQg2gR9qaYXaRVQA=;
        b=In5Z78tVCHDL8D7jFhyn/eAgCBxQ3V1Y+ntyOcqOI2XqcGIypKzS+oKTZhm4orAscN
         qUdaUFZR6wa76OMpCVjzNf3V7PmQoMrzK9BiAp40FhuNGi+KlMEK3xgTb9cc1PELbVtK
         sFQxIA4Gmh3AHa/iOAV8lJi6k60fMWRRc6KKtmKbGMEYvbesLHW7zd43v8D0KythCF32
         GiPgvtEE1bM9Fq2wTlYVyyuewHtYPgrBRB62elHUmfTeCD1BMU0A3RrEjN6vQJ7ZHq0Q
         jke+LjQqcn8+h5DwZIEhnJxegZxVepOqa2m1dZY6RCV9aXfW3m9bzhcoo5PvZ85tZcpO
         0/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dabjdtAH3uYSr1byjY4hPEot3YFqQg2gR9qaYXaRVQA=;
        b=EwsM6L5ZP6ezi47gqU7Oh4j/ue/vxpNpq3n0e3u7WGBRDEdGr5ur0nGMTUE2hQoxLH
         kxl7i5QfDJInHdWT0IPLEWLMPviA66U9wZP6AdZijt+tIvynqygrETygnWSpe3YxeT29
         si/wgZHezioQ915xI32f3rNuIzZ+GAaR914MzCXXR4l2/3WIrDqb6q+6DRYirakwjlIO
         ocRk2V8pJeaOo3go3KPn4gZqA7zoCeiLhG023KQddtSqTJuI6L1KzgaCkM/16sunzhwF
         OmXiqjY3isgf+ykdcXnJlU7BWQMJNcyW1jLO3ur5Q2ES9gCxMt+V1xWYynr8MYKwBZ0B
         TqtQ==
X-Gm-Message-State: AGRZ1gJZLeJWzpm9NmbbegDNalZP6f1icTE7OnYRCO2QBzqDIrlisBgN
        7RRDqd3HYm6vaLRfRb6j96fYpg==
X-Google-Smtp-Source: AJdET5fM4Ea1E/P4KXYw63hCej6kH9G1sVURxSkFTEPelpIkVngSBAUcoO1bw6jrRl7Di0tVtMaHYg==
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr87391wrc.188.1541594824698;
        Wed, 07 Nov 2018 04:47:04 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o130-v6sm1578952wmd.11.2018.11.07.04.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 04:47:03 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson-gx: Add hdmi_5v regulator as hdmi tx
 supply
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1541434917-18126-1-git-send-email-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <1b209a7e-e69a-079c-51e1-67b18410e5a0@baylibre.com>
Date:   Wed, 7 Nov 2018 13:47:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541434917-18126-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 17:21, Neil Armstrong wrote:
> The hdmi_5v regulator must be enabled to provide power to the physical HDMI
> PHY and enables the HDMI 5V presence loopback for the monitor.
> 
> Fixes: b409f625a6d5 ("ARM64: dts: meson-gx: Add HDMI_5V regulator on selected boards")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts         | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> index 765247b..eb8eec8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> @@ -125,6 +125,7 @@
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>  	pinctrl-names = "default";
> +	phy-supply = <&hdmi_5v>;
>  };
>  
>  &hdmi_tx_tmds_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> index d32cf38..69c28c4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> @@ -78,6 +78,7 @@
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>  	pinctrl-names = "default";
> +	phy-supply = <&hdmi_5v>;
>  };
>  
>  &hdmi_tx_tmds_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index 90a56af..86a7be8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -155,6 +155,7 @@
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>  	pinctrl-names = "default";
> +	phy-supply = <&hdmi_5v>;
>  };
>  
>  &hdmi_tx_tmds_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> index 5896e8a..8a39d95 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> @@ -51,6 +51,7 @@
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>  	pinctrl-names = "default";
> +	phy-supply = <&hdmi_5v>;
>  };
>  
>  &hdmi_tx_tmds_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 313f88f..50d2be1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -271,6 +271,7 @@
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>  	pinctrl-names = "default";
> +	phy-supply = <&hdmi_5v>;
>  };
>  
>  &hdmi_tx_tmds_port {
> 


Oops, it should be hdmi_supply...

I'll resend..

neil

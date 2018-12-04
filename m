Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89976C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453D72082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aZ/0i7WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453D72082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLDIbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:31:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38013 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLDIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:31:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so8355264wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7ZatcExTkGNvL1QAPOgoPHhFY0vtvF3cG5gZrC9GwTM=;
        b=aZ/0i7WPT1rdSbDqkyeucTFQvSTqk8/y43LW9DDpLnKjY5rvsGn5sFEM+pkZWXq5UG
         8y7NcoIVdx0jmYLvSc4w/LKJboZJJ0XlFwkPP+ioCspIAQ6Kzf9MAwHzg8BJZkGEg0ip
         7eS53efc0Yfe8bO70lrBCafqAD1F693bShLoRLli/ckuywgqhl1CHMqdTb+plSXsnURI
         7iw/kBMKp9XmJwvSwcfpOOiKYgSUKGijphEB9rCuymd2+AKrW6YyMuk6LddYLxPzIpMi
         xkT9vECiKuNiEP9JhqtZrnjIs6ATQoHh5aN5QmuLvEm2GHQ283KG0j0v/70G+VLcxair
         050g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7ZatcExTkGNvL1QAPOgoPHhFY0vtvF3cG5gZrC9GwTM=;
        b=G0yQi0myBXnFMDGggwmS5QYskzbcgi47/noTfS8k95n9nw4iTNs+7HTCqqpeZjcdYJ
         LufnPA/MlwxeNSMPQtEzhS6n0axvsJfmOZ+GhCMe/71Io/EdG8eNLGLCE67U4ISaREm4
         sSfjhpI7y+B37ALME7pWXxup5+hIcvAJn96lR/Cz94D36T/JdvBmfkKwu3E/PpBgBwsG
         0nMcFR44ORQHdm5RzJaNvFwarDtIibYxb+y8QlD6EUy/gLNelY7btEtMaV3AJmxp0XSC
         lS71CbtSHlfU+QfocTEIBba8JA03ano3ErDX0DnwQ8akESw5suFROXKXotcfKRCemaWT
         XvyQ==
X-Gm-Message-State: AA+aEWYEUNc6FXpTFdb3Rf1yOrdu3NfJf5jn8FsyY2+0dMWlLgMywHMF
        f+quosNzApWcr+PDkqNCTsBcIQ==
X-Google-Smtp-Source: AFSGD/WB8pXeVn+ad5mtLI5YIVEupd0WL32xw60jaABdOmRQGXZFl+3VaWajL3xhFYNSbYQqv8dtzg==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr11432437wmi.10.1543912303915;
        Tue, 04 Dec 2018 00:31:43 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e16sm15192724wrn.72.2018.12.04.00.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 00:31:43 -0800 (PST)
Subject: Re: [PATCH v2 13/34] dt-bindings: arm: amlogic: Move 'amlogic,
 meson-gx-ao-secure' binding to its own file
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-14-robh@kernel.org>
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
Message-ID: <cd586e5a-d7c3-5fd9-5eb0-1903d5165806@baylibre.com>
Date:   Tue, 4 Dec 2018 09:31:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203213223.16986-14-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 22:32, Rob Herring wrote:
> It is best practice to have 1 binding per file, so board level bindings
> should be separate for various misc SoC bindings.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
>  .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
>  2 files changed, 28 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> index 4498292b833d..f5c8d50a3506 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
> @@ -107,32 +107,3 @@ Board compatible values (alphabetically, grouped by SoC):
>    - "amlogic,s400" (Meson axg a113d)
>  
>    - "amlogic,u200" (Meson g12a s905d2)
> -
> -Amlogic Meson Firmware registers Interface
> -------------------------------------------
> -
> -The Meson SoCs have a register bank with status and data shared with the
> -secure firmware.
> -
> -Required properties:
> - - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
> -
> -Properties should indentify components of this register interface :
> -
> -Meson GX SoC Information
> -------------------------
> -A firmware register encodes the SoC type, package and revision information on
> -the Meson GX SoCs.
> -If present, the following property should be added :
> -
> -Optional properties:
> -  - amlogic,has-chip-id: If present, the interface gives the current SoC version.
> -
> -Example
> --------
> -
> -ao-secure@140 {
> -	compatible = "amlogic,meson-gx-ao-secure", "syscon";
> -	reg = <0x0 0x140 0x0 0x140>;
> -	amlogic,has-chip-id;
> -};
> diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
> new file mode 100644
> index 000000000000..c67d9f48fb91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
> @@ -0,0 +1,28 @@
> +Amlogic Meson Firmware registers Interface
> +------------------------------------------
> +
> +The Meson SoCs have a register bank with status and data shared with the
> +secure firmware.
> +
> +Required properties:
> + - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
> +
> +Properties should indentify components of this register interface :
> +
> +Meson GX SoC Information
> +------------------------
> +A firmware register encodes the SoC type, package and revision information on
> +the Meson GX SoCs.
> +If present, the following property should be added :
> +
> +Optional properties:
> +  - amlogic,has-chip-id: If present, the interface gives the current SoC version.
> +
> +Example
> +-------
> +
> +ao-secure@140 {
> +	compatible = "amlogic,meson-gx-ao-secure", "syscon";
> +	reg = <0x0 0x140 0x0 0x140>;
> +	amlogic,has-chip-id;
> +};
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

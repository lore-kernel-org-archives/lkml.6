Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43220C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C3A20878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SS5qxOXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C3A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLCKWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:22:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42518 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeLCKWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:22:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so11500402wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dAllDGtUaWoHz6r8oyOzW6MC1RWTTQtcsyuCN1DIlbw=;
        b=SS5qxOXnObMPMFZWEk0JR5yNC5KVE/IrHVMvM5UJgqGa5KXZhf2NxJVvscW8l8Hqp8
         pEZXM0ZaGOkjomEt+CwOsZMqoPJF6kkSkuYRr85ZpAclO90TbEoCVp7zetwBaMU8PJYj
         N/fV+4qlyWVF3DYe8RspEdllGrX9SL+sO7xtjwNPk+XnuaxY6HH6sX8np4HWbTLojGcd
         SYz38mErBwnZulymojmO+796C54JgKwS2hkrU5KQ12JDxIQKvIyQERqR+9oEu3ksyyfV
         AYPUeOnLykuMopCQUx7HZycfErcwJUQZTzR+zp+26TuawjpIWacosBZvq62vGWwrC9b+
         8m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dAllDGtUaWoHz6r8oyOzW6MC1RWTTQtcsyuCN1DIlbw=;
        b=WgAGwm2YYZBYTRxoPOrKehT7pcQyQVUex89TJWWC1wi1ceICuH30amYwtiychAJrP5
         iyupEtkm91UfVjJuwJDweA7JUP/EbE85mY1kc12ceWv/RWUPAT4UuwxbNiU/TmiViedn
         LLOVtgLax+GB0ulz+NSZMcURNVNNeA6DzgDPCD3fno//YYdd9rpeIgoW8ccJK3HDUNPS
         2pt8fnEwd7KJWwZ9dHvlflacxBRhGlEGFuYIoMN6jL31kXSvze3mG3BIM8ieBrweN2MD
         Hj0AWIAi4oBNX7zsjp++b4Y1z/taX43TUbIRU2f7LcSr4e5nL/jQEWlh2DW1UPhpkjMz
         ebZA==
X-Gm-Message-State: AA+aEWaUQHmFClDOEGTO3fhBZgGC6pfJRTKy+vh+1rwXV7UBF23wNkIZ
        z+F+nXHu91nvV6T2dilUWWsAIA==
X-Google-Smtp-Source: AFSGD/WA1JQWohBfUetRs4cHrJz8HMolzeu6Awef4Sc07UTBjGnF/eY8OdRuPr2zihMcmTzwGXvO+A==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr9144845wrq.265.1543832504047;
        Mon, 03 Dec 2018 02:21:44 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c7sm19537562wre.64.2018.12.03.02.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:21:43 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Remove myself from the list
To:     Carlo Caione <ccaione@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
References: <20181201151749.10932-1-ccaione@baylibre.com>
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
Message-ID: <928e27de-cb7b-cf40-b8b6-2aa43a69ee39@baylibre.com>
Date:   Mon, 3 Dec 2018 11:21:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181201151749.10932-1-ccaione@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2018 16:17, Carlo Caione wrote:
> Kevin is basically doing all the work. Remove my name as co-maintainer.

Sure, but couldn't we move you as reviewer and add Martin as reviewer aswell since he is dedicated to the Meson8X support ?

Or maybe add a separate entry with Kevin as maintainer and Martin as reviewer for Meson8X ?

Neil

> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 01645edc2388..63a2ad093524 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1297,7 +1297,6 @@ F:	include/dt-bindings/clock/gxbb*
>  F:	Documentation/devicetree/bindings/clock/amlogic*
>  
>  ARM/Amlogic Meson SoC support
> -M:	Carlo Caione <carlo@caione.org>
>  M:	Kevin Hilman <khilman@baylibre.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-amlogic@lists.infradead.org
> 


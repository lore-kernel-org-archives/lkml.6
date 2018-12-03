Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB39C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CB520851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G9YqCu5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CB520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLCKHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:07:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39568 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:07:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so2571487wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F++MSDZ9NwcbKE28yth3o0igpRm9LeO2TCIWU6MMa3Y=;
        b=G9YqCu5CkkFpSFaHoDGjwYuuZMEgnI4ZC00EUXS6IHhydHAqvxD64lye5ySwgJE1oo
         5aPcQ84gSDEQr52s0vWoTTNAeifUo/jEd+9UZp944OXAWRi8vrQRIVmTpfYxSNkD6sFG
         ojLZ5qQhhCEEWqHPUxsBskOr+mxGPiJX87x5vA7Uuky1oPUk4AGFw67HQqkrvvECw3V+
         NHEtTFk4U15rmyNBzMBJ4PEZwmZYBwOyeaME5PPRK37eNcHT4bxT7z+T7MgIrztYxKFa
         pbjclWozHOI3s6FLh81I4IHenfAjrZNm15qdAFWmcAAZW4NFtiQKjY1CX/zWcaaCnUVr
         qsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F++MSDZ9NwcbKE28yth3o0igpRm9LeO2TCIWU6MMa3Y=;
        b=da1zUGM9ie6fjm21xNOlcfQcQaPei9U1yDidrZxzCZEhBQ9ShRMR4Nhkev3sgDlYVN
         WlBKGHuKLRKyTbQ1BckN764Fwpba1uKim46cE05OqCU255VmVtqqiQq+DcGM5R0m6aQ0
         GK2m+RFOz/Hc5isE8SBfEfeOwh8OKEPkFJRPNOMJcEUs6TYg6ddEeT6xG02ZGzw/3ZgA
         xKNaWcavdhQOFr0SW74GfkZ58uDtJCduGAb1cQoIWQvXm2PJDTEJr+ZVkInkIPoab+s7
         UPKrSjItYtWx2G/RKCAE5HBH6diW6hRtZmKXheGKPNx1h0gn+bECQbLhlVqGfWsM4vH5
         aw7A==
X-Gm-Message-State: AA+aEWYD9BXpWqdVP5+Q3RkiMHy9bo78Qq5qM5KXvqDb3IqQhJwbark9
        hcpN8rCUUQ7areLti42zyoYb0A==
X-Google-Smtp-Source: AFSGD/W4YNU//GtRZXwhqgCiSVEmKzMsZiRv4yL9RScZhBVu705tInPibS9IeDvdqvKilrhLCeTRJQ==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr8106488wmg.53.1543831597318;
        Mon, 03 Dec 2018 02:06:37 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y138sm6091647wmc.16.2018.12.03.02.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:06:36 -0800 (PST)
Subject: Re: [PATCH 2/2] irqchip/meson-gpio: Add support for Meson-G12A SoC
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20181203061324.36248-1-xingyu.chen@amlogic.com>
 <20181203061324.36248-3-xingyu.chen@amlogic.com>
 <7a2f88d849ada782de6e27676518d0b9897e30e7.camel@baylibre.com>
 <dc42e7df-a3de-7323-177f-56a08564fb60@amlogic.com>
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
Message-ID: <4fc0694c-4c00-5abd-5336-ef85ad36d9b5@baylibre.com>
Date:   Mon, 3 Dec 2018 11:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <dc42e7df-a3de-7323-177f-56a08564fb60@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 10:28, Xingyu Chen wrote:
> 
> 
> On 2018/12/3 17:19, Jerome Brunet wrote:
>> On Mon, 2018-12-03 at 14:13 +0800, Xingyu Chen wrote:
>>> The Meson-G12A SoC uses the same GPIO interrupt controller IP block as the
>>> other Meson SoCs, A totle of 100 pins can be spied on, which is the sum of:
>>>
>>> - 223:100 undefined (no interrupt)
>>> - 99:97   3 pins on bank GPIOE
>>> - 96:77   20 pins on bank GPIOX
>>> - 76:61   16 pins on bank GPIOA
>>> - 60:53   8 pins on bank GPIOC
>>> - 52:37   16 pins on bank BOOT
>>> - 36:28   9 pins on bank GPIOH
>>> - 27:12   16 pins on bank GPIOZ
>>> - 11:0    12 pins in the AO domain
>>>
>>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>> ---
>>>   drivers/irqchip/irq-meson-gpio.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-
>>> gpio.c
>>> index 7b531fd075b8..971e8dea069a 100644
>>> --- a/drivers/irqchip/irq-meson-gpio.c
>>> +++ b/drivers/irqchip/irq-meson-gpio.c
>>> @@ -67,12 +67,17 @@ static const struct meson_gpio_irq_params axg_params = {
>>>       .nr_hwirq = 100,
>>>   };
>>>   +static const struct meson_gpio_irq_params g12a_params = {
>>> +    .nr_hwirq = 100,
>>> +};
>>> +
>>
>> Same comment as on i2c, the g12 seems compatible with the axg.
>> Is this patchset patchset really necessary ?
>>
> Although the total number of pins is the same as the Meson-AXG SoC, the gpio banks and irq numbers are different. To avoid confusion on use, i think the new compatible string is needed.

OK for the new compatible, but you can re-use the same struct like for i2c.

Neil

>>>   static const struct of_device_id meson_irq_gpio_matches[] = {
>>>       { .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
>>>       { .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params
>>> },
>>>       { .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params
>>> },
>>>       { .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
>>>       { .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
>>> +    { .compatible = "amlogic,meson-g12a-gpio-intc", .data = &g12a_params
>>> },
>>>       { }
>>>   };
>>>   
>>
>>
>> .
>>
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic


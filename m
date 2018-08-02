Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE416C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492A82124D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E9lhSOLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492A82124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeHBJmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:42:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53182 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeHBJmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:42:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so1362776wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SuwYbppRarbhRcpWok9Vz5YQA2YmqxstuN1aXom7epM=;
        b=E9lhSOLGeKku3hI7dts4/GlqSIQETQHKDtRCWQJ+Cno61d6YHYh3qSSFudf8yvvvPD
         UIXlId+ZZKQErk2I2VYbLUqtTZq+98/oVCCLGc2uiQUSQ7lQCrMeZyGHc4K5NoRxcGgr
         USlLqJARV+YUA6XskfXB87qZkHu1uoRYu9wTxkWaEPlAT5w2e9BrVTFAWexO/RuuOmwn
         HkXD9qdzrP9zH8IKSl5VXivN1caJpsdvFWXjI9rzPMFU1TSbLuaf3FX2IxHucv8OiRrK
         N7pnj6O/J7pDbl3hJx4rmPdfjcIIlIMQCkutsGDaUQd77EexD+1GVGsH7gn5eJ4lETW5
         pxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SuwYbppRarbhRcpWok9Vz5YQA2YmqxstuN1aXom7epM=;
        b=O2ZBkcJjhkgQBLy/YKVal7u79B+g27lN+WGGPG9Z5U91u4mJo6ICJTXIIgN5qfYoOA
         S0Go8dh7zHLXzZXQ7HYuM63vUrCpbYDmBIiNcFiFpKHpb3nBMux2CNCBHn1bWhxL6yN9
         glNnDj7eoWZU5L51HlQYuZ01u5dU18rCcQfSYmNh5iL0TNqTU9yauYTG+mQDxi2sikvX
         Z2KHSO8A0zcqtNALfu98ClZ+MplKGCQ+DjVb7n7Xqkmmk7Oi79jEDAjVTz/jn2G5dSF3
         5pgb95pBp/BCrlPAT/jvvjqgqD31sD+LhiqU1FUbnv4F1l5MfWoU9l6rbGrX64FKAlo8
         uUUA==
X-Gm-Message-State: AOUpUlGjikgdyxnYt28eudQKqqUCCAw6L43D4jsSLMHNYxOF1dGSZ5bx
        JT+Q8ErDgM++pH55lgGrOEnvCA==
X-Google-Smtp-Source: AAOMgpd8UWsABJopW6s9p/KhNCfUKXo5sgHeh/Rjp5f4xHouVELcVPI1zNizHK7e/VCkmsIknX4f+A==
X-Received: by 2002:a1c:a009:: with SMTP id j9-v6mr1062666wme.132.1533196375128;
        Thu, 02 Aug 2018 00:52:55 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y102-v6sm1151301wmh.9.2018.08.02.00.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 00:52:54 -0700 (PDT)
Subject: Re: [PATCH 2/5] pinctrl: meson: Add support to set direction with a
 secure monitor call
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linus.walleij@linaro.org,
        linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
 <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
 <CAFBinCBcUijFGdLoQwkzioX7MF0H_gH1rbcvxG+UWc1rA2pRiQ@mail.gmail.com>
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
Message-ID: <d319d871-ba93-ab1d-dae4-b44916161e85@baylibre.com>
Date:   Thu, 2 Aug 2018 09:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCBcUijFGdLoQwkzioX7MF0H_gH1rbcvxG+UWc1rA2pRiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2018 22:23, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Wed, Aug 1, 2018 at 12:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
>> set the TEST_N pin direction.
>> This patch adds a "smc" boolean to the bank structure to differentiate
>> the TEST_N bank and call the Secure Monitor in the _input/_output functions.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/pinctrl/meson/Kconfig         |  1 +
>>  drivers/pinctrl/meson/pinctrl-meson.c | 31 ++++++++++++++++++++++++++-----
>>  drivers/pinctrl/meson/pinctrl-meson.h | 10 +++++++++-
>>  3 files changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
>> index c80951d..1b90470 100644
>> --- a/drivers/pinctrl/meson/Kconfig
>> +++ b/drivers/pinctrl/meson/Kconfig
>> @@ -8,6 +8,7 @@ menuconfig PINCTRL_MESON
>>         select GPIOLIB
>>         select OF_GPIO
>>         select REGMAP_MMIO
>> +       select MESON_SM
> I wonder why PINCTRL_MESON has to select MESON_SM - shouldn't
> PINCTRL_MESON_GXBB, PINCTRL_MESON_GXL and PINCTRL_MESON_AXG select it
> instead?
> selecting MESON_SM is probably no-op on Meson8 and Meson8b (which
> don't have the GX secure monitor), but I haven't tested it yet

Hi Martin, you are right !

I will fix it on v2..

Neil

> 
> 
> Regards
> Martin
> 


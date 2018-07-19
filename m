Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B566BECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C8A20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yX4+RKFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C8A20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbeGSJmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:42:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40116 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbeGSJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:42:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so5541396wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=edg1qusFaU7MKZa2yFfG+ND35bMVk8XL9ewZZAHhujY=;
        b=yX4+RKFSFwqlvhrjANiItWQ92Sl8+egOjTVs75VzL1X+5GqxgY7r93lpLHIT3+8vRV
         55LrSfgbPp+Nw7LEamzFvybsN8tTwX/2tia6lxVeVYFZ2g8XhtN5RgN4wq7vyUwV9Iv1
         RQMsEWaS1/2W0LIs/PqvYhX6ZSO7POUOkt+QJ0EzkWSMOC8ZlxBjmGi9ccOH+8cNAPqp
         rAX8DhODaMPCvZhE6ziEMziAIFY0AXJD6elTX2flHIAUW5JUZMFse4ZveSTk6JKBIOIl
         zoCQzdD2LPd3Mf3j6u6T69B4PV3GOFyWCwWwPc28QkfXvxSgc2s/CSBKXFp5Wo6ps40p
         uiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=edg1qusFaU7MKZa2yFfG+ND35bMVk8XL9ewZZAHhujY=;
        b=F34tmTYpXCIWExlaeIxneAuBnvQ1a1zVbTb3mpnqm7sixvJ8Pvqupq0pcf+0MJ4q8S
         je/zlEnCioSupEMIC4GPNcmBELhBz1qNh8uDeq0DrHpbBs60213Q5uUibGv7Lu7PMomR
         wJEDlaUG6+QHx4CqGZ/6YdkTl78e6Fo+nNxw285kgExwuEqYgPL2/6F3x6KIiC1VgBAO
         WuTCJ5/+xsdzX9GfQBHQP94s+x1MGS+f3R3ddFsLLh2AGvmvqhHsH+ojLK9OXu1gh0iH
         rKKifwxOHv7M3iF81c90AgppzKQyrA7RIImx88qXNPAvBesKuG0J0dxqnB08tKfX7YbE
         SS+A==
X-Gm-Message-State: AOUpUlG9C3rprTqv4PAmGDMwjJR5CoBu4NS1ad6xH8kl/iWnVqMMR2AY
        eIPdC8i0tdFk8wcSRgPTmGYBw/ukE36iqg==
X-Google-Smtp-Source: AAOMgpe9gY3jHKV2euBXznviUroTAderxNVq3+hYvhagsAtKLBSNVBy8BMWH7xEgxjBQGsPp059kfg==
X-Received: by 2002:a1c:a8d6:: with SMTP id r205-v6mr3561883wme.6.1531990789799;
        Thu, 19 Jul 2018 01:59:49 -0700 (PDT)
Received: from [192.168.1.24] (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id t6-v6sm3556087wrn.97.2018.07.19.01.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:59:49 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] add ISO7816 support
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     alexandre.belloni@bootlin.com, arnd@arndb.de,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jslaby@suse.com
References: <20180719084737.1490-1-ludovic.desroches@microchip.com>
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
Message-ID: <034fe4ed-979b-51ee-db7c-5dc7137b98e5@baylibre.com>
Date:   Thu, 19 Jul 2018 10:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719084737.1490-1-ludovic.desroches@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ludovic,

On 19/07/2018 10:47, Ludovic Desroches wrote:
> Hi,
> 
> This patchset adds support for the ISO7816 standard. The USART devices in
> Microchip SoCs have an ISO7816 mode. It allows to let the USART managing
> the CLK and I/O signals of a smart card.

Wow, I would have loved to have this at the time...
I'm curious, do you have an example of userspace code using this ?
The ATR rx needs a very weird handling, I'm curious how you managed it.

Thanks,
Neil

> 
> Changes:
> - v2
>   - uart_get_iso7816_config: check there is an iso7816_config function
>   - use IOCTL macros to generate the IOCTL number
>   - check that reserved field is not used
>   - remove debug logs
>   - check that the iso7816_config is right before doing any action
>   - change the error from nack and max iteration status to a debug message
>   - remove patch 3 as it concerns both rs485 and iso7816 to think more
>   about the need of adding a lock or not
> 
> Nicolas Ferre (2):
>   tty/serial_core: add ISO7816 infrastructure
>   tty/serial: atmel: add ISO7816 support
> 
>  arch/alpha/include/uapi/asm/ioctls.h   |   2 +
>  arch/mips/include/uapi/asm/ioctls.h    |   2 +
>  arch/powerpc/include/uapi/asm/ioctls.h |   2 +
>  arch/sh/include/uapi/asm/ioctls.h      |   2 +
>  arch/sparc/include/uapi/asm/ioctls.h   |   2 +
>  arch/xtensa/include/uapi/asm/ioctls.h  |   2 +
>  drivers/tty/serial/atmel_serial.c      | 170 +++++++++++++++++++++++++++++++--
>  drivers/tty/serial/atmel_serial.h      |   3 +-
>  drivers/tty/serial/serial_core.c       |  60 ++++++++++++
>  include/linux/serial_core.h            |   3 +
>  include/uapi/asm-generic/ioctls.h      |   2 +
>  include/uapi/linux/serial.h            |  17 ++++
>  12 files changed, 256 insertions(+), 11 deletions(-)
> 


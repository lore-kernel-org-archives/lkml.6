Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED369C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405CB20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ruWJGIDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405CB20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeGKIAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:00:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42552 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeGKIAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:00:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id p1-v6so17104717wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jwB7lVvQm7AjA1NW+X1m20f4FmoGqLb25d1cg5Jidgc=;
        b=ruWJGIDSAOiXvfP4mrHAZi2Msx4cg9M/0zwg9niNfIYGpxXPKW8rgimW1nVobU+a8z
         /gO5EwyB/pfZfq5AYnSQ91wfwB/K2STJzCqD053f5ybxjmXHTBVAyZQE7JCpA3XC35OG
         nvyRLOu3E4kMexjwwcBdezcaCBPzj9LmBJMyYP7O6qmZJ15BgJbXkJHJ6KHh5zyNhRFA
         aUHxl78d1l1NXtcjEiPdT6I35eR8a1T35HC/RCypNmcSaxLQ6zx7trHYDYqU+buJ8yf/
         qBbSNTWyI/yIswYUj1YmM2XP8R6LrvD/95qT5kDwWQ+5Bdga4TEp/FzzpqjFqXQFC81e
         USjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jwB7lVvQm7AjA1NW+X1m20f4FmoGqLb25d1cg5Jidgc=;
        b=iaO6u/NXWqcbah45qHcYFAel8VXajhvIcFqieQx3TkOZ+ObSoDA0VZLJ4trWKwXNzl
         t0BtX0CGX8wIpI2V8MGTIrYIjozWpVFaUDPhTMmbRUP5v11d9uiIc+CB2O4yepUT03oZ
         y2qAIC6wBefG0gx97Ie9K8ZtcPyKjnaeT1zfjsirMquPLB43T40m0hBGAihzJBK8Nnq/
         etDOYpSJbcLa2L76VlT0wExm9MOfzI1jjlpZdOziHFqS+c2Xx+GvNt0xuUIfyBcSmnl1
         nrloKL2K/v/vxeTm8ZvwUS6PwmDj0aKsxVyKwZP4PVUazc+qeqUJbOtAegX4aEo5dFG0
         O/TQ==
X-Gm-Message-State: APt69E3HAo0M8e9HzftfR1GttkyD6tmkp2Pbo5dxGwazacRkvlSrzePG
        Uge6dmVFP/22ySxwyxjoxIXfBg==
X-Google-Smtp-Source: AAOMgpf2O066SrVaGx1SfSFCu72w9PaJm0rMkWoBIcyZUCFfpyWD3OTnEGNBHAx9OrGiIC4YObH7yQ==
X-Received: by 2002:adf:cd0e:: with SMTP id w14-v6mr18760717wrm.226.1531295863931;
        Wed, 11 Jul 2018 00:57:43 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 5-v6sm2714297wmv.48.2018.07.11.00.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:57:43 -0700 (PDT)
Subject: Re: [PATCH 0/2] Add support for S805X based P241 Reference Design
 board
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com
References: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
 <7hfu0sm3ep.fsf@baylibre.com>
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
Message-ID: <93c53a69-abe3-731d-dcb6-45cf111ce286@baylibre.com>
Date:   Wed, 11 Jul 2018 09:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7hfu0sm3ep.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2018 00:48, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> The Amlogic P241 board is the Reference Design board for the S805X
>> variant of the Amlogic Meson GXL SoC family.
>>
>> The S805X is a variant of the Amlogic Meson GXL SoC family with the
>> following physical limitations :
>> - No SDCard interface
>> - No GPIOCLK pins
>> - No USB OTG ID pin (but Gadget feature can stil be forced)
>> - No 5V regulator
>> - Reduced ADC inputs (only ADC0 and ADC1)
>> - GPIODV_26, GPIOAO_3, GPIOAO_4, GPIOAO_5, GPIOAO_6, GPIOX_14,
>>   GPIOX_15, GPIOH_3 are no more exposed on the package
>>
>> Amlogic exposes the following SW limitations :
>> - HDMI max resolution should be 1080p60, VPU clock should be downgraded
>> - Video Decoding should be limited to 1080p60, VDEC clock should be downgraded
>> - CPU speed should be limited by SCPI OPP table to 1.2GHz
>> - DRAM interface is limited to DDR4 16bit up to 1GiB
>>
>> The P241 board has the following features :
>> - 1GiB DDR4 Memory
>> - HDMI Connector with CEC
>> - A/V jack with Stereo Audio and CVBS
>> - 10/100 Ethernet
>> - 2x USB2.0 Type-A
>> - On-board WiFi SDIO Module
>> - On-board eMMC storage
>> - Infraread Received
>> - Factory Reset button
>> - UART connector
> 
> Applied to v4.19/dt64.
> 
> The cover letter didn't say, but I assume this was at least boot tested
> on a p241 board?

Exact, it's boot tested on a p241 board.

Neil


> 
> Thanks,
> 
> Kevin
> 


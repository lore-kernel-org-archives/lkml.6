Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E19C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0DD21723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Uc8Jhm9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0DD21723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeHCKFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:05:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44486 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbeHCKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:05:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so4528603wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 01:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1yE0+qTJ7nbfRjacGJHzIerSs0ymcMIN3MzeOb9SAak=;
        b=Uc8Jhm9/LWGIBnN7EDgIPKZXDas6LHmuV+KbEZo52Rmw52IlsTuYf8WXjlcptsevtv
         aTgyAd2XNwoSbkQzk8AMdQSP17FAESgR9sPyLCr1XrN/Vgzc+yjmSs59t2FmwI221umX
         t+eSqygXgDE5OSyBVdqvBWbTAx1IdQyV9gOaTHZVo0itkuIIafSEeIjS4phe2dszms9p
         OqEtQOXAf1mQcvE6nfWD1JXwkBR0p60vbzoj0/4du79YCj7fOSEjcVsFr42fMqrtDJfx
         ipOvtSPNkMfdu3N3Gaqu+5RK3IvFcJd2ttomJTYMRwdxLhyWhcEMsCL9hdEaccvbqcTS
         2KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1yE0+qTJ7nbfRjacGJHzIerSs0ymcMIN3MzeOb9SAak=;
        b=P3+gLAG9w0X8IKru65XhDoIYYWsCgNn//cnGSWoTc33EJ2uPw+X4RJSMdsRgkd453U
         pRH6vjlxYuL/89fsrm/f4LKggbgzu1MzCjzirn/m+IOS5aMC3KPdyVelfMKp/HslN+bS
         Vi5jf6n94iaEDSd3sgdRr1rnDFZn9+plJDCx/c7i0c4eU3+EIV/qZsPLKJSuC4YvYPMl
         pIgZ4epzW5VXDAFQsA65zf5ZwzFbb4oUUMrtmQ6mwEQhUtzRYqSik+KC3akBRChID0t0
         Zx6do58Tw4RAUetuGMmTxWf4kKv0arPCc/OrVNFMncoThRjXrTlk6K08EdHgcZ19Jca4
         ed5Q==
X-Gm-Message-State: AOUpUlH8uJBd6NpkuwbtcC9wNGMLODqjayw3hOXBINFx0HxglO4Ay1/J
        JUbbowwIE0ZXb3TY46x/2vJ89A==
X-Google-Smtp-Source: AAOMgpeuRhv78tR2OUpgOj3VW7PWEZiOQyEkd1culRqjLkGxJjEe2czkMbtig215LAqwGx+pXjPNMg==
X-Received: by 2002:adf:bb08:: with SMTP id r8-v6mr1718974wrg.244.1533283811180;
        Fri, 03 Aug 2018 01:10:11 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y11-v6sm4626736wrt.4.2018.08.03.01.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 01:10:10 -0700 (PDT)
Subject: Re: [PATCH 2/5] pinctrl: meson: Add support to set direction with a
 secure monitor call
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jbrunet@baylibre.com
Cc:     khilman@baylibre.com, linus.walleij@linaro.org,
        linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
 <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
 <CAFBinCBcUijFGdLoQwkzioX7MF0H_gH1rbcvxG+UWc1rA2pRiQ@mail.gmail.com>
 <d319d871-ba93-ab1d-dae4-b44916161e85@baylibre.com>
 <acab5d8ab9eb871c616171c00814d1fec93af1e7.camel@baylibre.com>
 <CAFBinCAAcqiJAwBMr2_7V90beFwq9xkPBnBdKB8oPsMKXU_-HA@mail.gmail.com>
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
Message-ID: <ff6d516d-5d3b-c80f-941b-fed41a3a9ead@baylibre.com>
Date:   Fri, 3 Aug 2018 10:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCAAcqiJAwBMr2_7V90beFwq9xkPBnBdKB8oPsMKXU_-HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 22:42, Martin Blumenstingl wrote:
> On Thu, Aug 2, 2018 at 1:21 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>> On Thu, 2018-08-02 at 09:52 +0200, Neil Armstrong wrote:
>>> On 01/08/2018 22:23, Martin Blumenstingl wrote:
>>>> Hi Neil,
>>>>
>>>> On Wed, Aug 1, 2018 at 12:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>>
>>>>> The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
>>>>> set the TEST_N pin direction.
>>>>> This patch adds a "smc" boolean to the bank structure to differentiate
>>>>> the TEST_N bank and call the Secure Monitor in the _input/_output functions.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>> ---
>>>>>  drivers/pinctrl/meson/Kconfig         |  1 +
>>>>>  drivers/pinctrl/meson/pinctrl-meson.c | 31 ++++++++++++++++++++++++++-----
>>>>>  drivers/pinctrl/meson/pinctrl-meson.h | 10 +++++++++-
>>>>>  3 files changed, 36 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
>>>>> index c80951d..1b90470 100644
>>>>> --- a/drivers/pinctrl/meson/Kconfig
>>>>> +++ b/drivers/pinctrl/meson/Kconfig
>>>>> @@ -8,6 +8,7 @@ menuconfig PINCTRL_MESON
>>>>>         select GPIOLIB
>>>>>         select OF_GPIO
>>>>>         select REGMAP_MMIO
>>>>> +       select MESON_SM
>>>>
>>>> I wonder why PINCTRL_MESON has to select MESON_SM - shouldn't
>>>> PINCTRL_MESON_GXBB, PINCTRL_MESON_GXL and PINCTRL_MESON_AXG select it
>>>> instead?
>>>> selecting MESON_SM is probably no-op on Meson8 and Meson8b (which
>>>> don't have the GX secure monitor), but I haven't tested it yet
>>
>> I'm not so sure about that. meson_sm_call() symbol is used in the common pinctrl
>> code, so it should be selected when compiled even if meson8b is not going to use
>> it in the end.
> unfortunately MESON_SM depends on ARM64_4K_PAGES so it can't be
> enabled for the 32-bit SoCs
> any ideas how to solve this?

I think I'll need to wrap the meson_sm calls around a
#if IS_ENABLED(MESON_SM)

and
select MESON_SM if ARM64

in Kconfig

> 
> 
> Regards
> Martin
> 


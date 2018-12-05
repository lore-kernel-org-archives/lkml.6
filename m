Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3308CC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC97F2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u3YUik7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC97F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeLEJvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:51:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53765 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbeLEJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:51:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so12461134wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 01:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AsJlj7TTdyb72m1SKwkKkmtm6HVwnxQK4+r+hq0uuDA=;
        b=u3YUik7j5JhEtKfoLDIHcsx6lrjBru8JtcUSxmIld+yn3Tyr8g5L+uX1tXim42MvGd
         53qbnfLfxH6HZedUbtBgmD9nzbmYy59E2rtMLUGs/RJztqyGUvRineaJMvC7ujdJni18
         aNyUAb+Y1ADwdggOWxTys964IqNHNUlSamwtj57c3CeqS8iGBZl4FUR3lXTrOng39uyR
         XnpiwBKXj5WuLBWABHPUJyG8yj0ZuPFhipxFg0YS2quphoj0vbZgEwNRWnSGejjTHH7F
         ZiM5gIwApNofnAuDBLoAWnm0KhdRVUHwrswwfzD0WYSwUYPwe9JZY226lzZpRIdMx51g
         EdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AsJlj7TTdyb72m1SKwkKkmtm6HVwnxQK4+r+hq0uuDA=;
        b=MYnIaEbK19yEv/r9A68Deo83rUjwwY5IMyjTXEmDWeZvzJaJF8ExVorqgk6+2Hxd6h
         ZuCuOmvGUmrch0AgqSsL9iAzgPym9cuaDMNJ2PcK/Dk6SX8Hp971hyQH4UbUhw1v3TD9
         wdLz6Bls5VUy52GpU5vppR0IeJ/Mh7w4JD6b4hI39MMU/DNoi5eCOiXQt41qlaPVLGwI
         CqOgsMSCwRub5ySw7OVqog+ZcuXX5z/4lqT7H5sEn0xhIRmTsS3Bv1OmFOj/RHJSOJgK
         hgxiySARJpR+t94M6UxYFGUarWGUW2m/UNkdcacAv2hRTJLMf6u8RiaekDIqCCF1oDnJ
         5iyA==
X-Gm-Message-State: AA+aEWYM8AwT1+c1fAtwEo76fSY44kaYIY+As80UY7XWKvyFHwocKW88
        N/31qYNpMElwHxRglROmg5u7JEGY5Z9IaQ==
X-Google-Smtp-Source: AFSGD/VhdQyuxXg13sBUAyRXmrIUvmgyWpwT4LequVvKOVPvH1qwGhumZEvQ99umm4SLhHGxzB0HYQ==
X-Received: by 2002:a1c:cec1:: with SMTP id e184mr15934500wmg.75.1544003499502;
        Wed, 05 Dec 2018 01:51:39 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:819f:4d34:9af9:e67? ([2a01:cb1d:4ce:ea00:819f:4d34:9af9:e67])
        by smtp.gmail.com with ESMTPSA id y34sm49302614wrd.68.2018.12.05.01.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 01:51:38 -0800 (PST)
Subject: Re: [PATCH 0/5] clk: meson: axg: add 32k clock generation
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20181204165310.20806-1-jbrunet@baylibre.com>
 <8e7ae6ab-a38b-d2ef-ecfc-58d198821b9c@baylibre.com>
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
Message-ID: <e94b0970-a9ae-c273-0c59-fd8fc99d63d1@baylibre.com>
Date:   Wed, 5 Dec 2018 10:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8e7ae6ab-a38b-d2ef-ecfc-58d198821b9c@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2018 10:50, Neil Armstrong wrote:
> On 04/12/2018 17:53, Jerome Brunet wrote:
>> The goal of this patchset is to add the internal generation of the
>> 32768Hz clock within the axg AO clock controller.
>>
>> This was initially added has the CEC clock on gxbb. To properly
>> integrate it on the axg, a simpler 'dual divider' driver is added.
>> Then gxbb AO clock controller is reworked to use it. Finally the 32k
>> clock tree is added to the AXG.
>>
>> This patchset requires depends on this CCF change [0]
>>
>> [0]: https://lkml.kernel.org/r/20181204163257.32085-1-jbrunet@baylibre.com
>>
>> Jerome Brunet (5):
>>   dt-bindings: clk: meson: add ao slow clock path ids
>>   clk: meson: clean-up clock registration
>>   clk: meson: add dual divider clock driver
>>   clk: meson: gxbb-ao: replace cec-32k with the dual divider
>>   clk: meson: axg-ao: add 32k generation subtree
>>
>>  drivers/clk/meson/Makefile              |   3 +-
>>  drivers/clk/meson/axg-aoclk.c           | 175 +++++++++++++++--
>>  drivers/clk/meson/axg-aoclk.h           |  13 +-
>>  drivers/clk/meson/clk-dualdiv.c         | 130 +++++++++++++
>>  drivers/clk/meson/clkc.h                |  19 ++
>>  drivers/clk/meson/gxbb-aoclk-32k.c      | 193 -------------------
>>  drivers/clk/meson/gxbb-aoclk.c          | 238 +++++++++++++++++++-----
>>  drivers/clk/meson/gxbb-aoclk.h          |  20 +-
>>  drivers/clk/meson/meson-aoclk.c         |  15 +-
>>  include/dt-bindings/clock/axg-aoclkc.h  |   7 +-
>>  include/dt-bindings/clock/gxbb-aoclkc.h |   7 +
>>  11 files changed, 527 insertions(+), 293 deletions(-)
>>  create mode 100644 drivers/clk/meson/clk-dualdiv.c
>>  delete mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c
>>
> 
> Good move, it's good to have a common driver to enable USB device support for
> GX and AXg families since they depends on the slow_clk path.
> 
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> and
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> And applied on next/drivers
> 
> Neil
> 

In fact, I'll wait until the CCF change at [1] is applied on clk-next.

Neil

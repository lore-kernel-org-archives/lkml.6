Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F052AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA7222360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MhqYAbKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA7222360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbeKNTN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:13:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43884 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbeKNTN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:13:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id y3-v6so16353462wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LXJF7UqFazHaPW4rafwoTdP5g5YNnnj0CJYnLCLBqEA=;
        b=MhqYAbKI57q/S3r2qN4ocpWWEbrdZjIopssmXCo9wBwNcymAsvNv7QCKmf9lsOFvxg
         wpNU9ENdUDg40/ib6yK2NK1C84fllsfe/EF/Es6huAJQ5sINAEGsUiwTYrd4XZg8Kfov
         nsXEmnsDDwavTMj8tRkTeT73NcbHUCr9xyyY1pIwQPj2famMJoJSiYorIXa6s5/stwZ0
         sKjQm7S1OAo62Kd09ecauz8Rns/66dMo8gm5bABQlM20Lry4PvCYFcdsHwDl4nzo/jVi
         GkVTiYsBXlc1NAIujmDxtbWX1VKdWmQy1ZirrevusMo2gYFdSN21ZvzjfpjcCzWGsikC
         CEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LXJF7UqFazHaPW4rafwoTdP5g5YNnnj0CJYnLCLBqEA=;
        b=ahJhmJUFiyBzGayYeGr/4XaVAXs9Zfv9J+uVk+TYl3Hlulb1izvcg7WFf4/mGzs530
         I4zG2YS+iLAsESBQDBxkc/0LiCDhZREmBWw8wYSVsHiVpqxgb9St65M0pcrE/r1f2wE8
         FA2BiJFd3VISvMDj7DSi1Rj+Emn6h9zKSuUUZP1xEH/xxXa8y2qk+zj/kIZCUjT15Po2
         3BYuSmWouOFU7w3tnQufCxBAp4tEKpygwGYo9Q/dQPqELsSr1sb0epgLZCIZvB9NCIOS
         ZfIZUHOSpSY7rjsQXb2kpDeTh+cp1dV35JGvcCWdKsa6+Cz9DGZZKXfYOyQjXy8Q3eIE
         fPqw==
X-Gm-Message-State: AGRZ1gLlYj9rst+7qerAA2EpyGCyZxSyefqRrGm0XQLpvEqHNGHV/Zb3
        83e1POAFopBAX0HQxl9Qap0b7i6CAek=
X-Google-Smtp-Source: AJdET5fMbR871cE8mfQn03aTQ0hWfc/LkmCSe3NREi6AOzVVhWz1zMAXvVLEbmucQLyMzjJXro5zRw==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr994173wro.194.1542186663174;
        Wed, 14 Nov 2018 01:11:03 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e10-v6sm28818863wrp.56.2018.11.14.01.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 01:11:02 -0800 (PST)
Subject: Re: [PATCH v2 0/4] clk: meson: Add video clocks path
To:     jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
 <f7679f4c93aca9a11b9078611b6c4952e83c9a9e.camel@baylibre.com>
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
Message-ID: <5137a72c-e5fa-6fad-f1b6-e64968e78391@baylibre.com>
Date:   Wed, 14 Nov 2018 10:11:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f7679f4c93aca9a11b9078611b6c4952e83c9a9e.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2018 15:18, jbrunet@baylibre.com wrote:
> On Tue, 2018-11-06 at 15:57 +0100, Neil Armstrong wrote:
>> This patchset is an attempt to handle the Amlogic Meson GX Video clock
>> in the Common Clock Framework in order to move the video pipeline and
>> HDMI controller clock management out of the Meson DRM Driver.
>>
>> In order :
>> - Add support the VID_PLL fully programmable divider used right after the
>>   HDMI PLL clock source.
>> - Fix the GXL HDMI PLL DCO
>> - Add the video clock bindings covering all the video graphics pipeline
>>   and the HDMI controller.
>> - Add the clocks entries used in the video clock path
>>
>> The vid_pll programmable divider is introduced in its R/O form right now,
>> but will be extended to be R/W in a next iteration.
>>
>> All dividers are flagged with CLK_GET_RATE_NOCACHE, and all gates are
>> flagged
>> with CLK_IGNORE_UNUSED since they are currently directly handled by the
>> Meson DRM Driver.
>>
>> Once the DRM Driver is fully migrated to using the Common Clock Framework
>> to handle the video clock tree, the CLK_GET_RATE_NOCACHE and
>> CLK_IGNORE_UNUSED
>> will be dropped.
>>
>> Changes since v1 at [1]:
>>  - Fixed comments from Martin
>>  - Fixed GXL HDMI PLL DCO
>>  - Added the missing HDMI controller clock
>>  - Moved bindings to a separate patch
>>  - Updated the commit logs
>>
>> [1] 
>> https://lkml.kernel.org/r/1532079581-978-1-git-send-email-narmstrong@baylibre.com
>>
>> Neil Armstrong (4):
>>   clk: meson: Add vid_pll divider driver
>>   clk: meson-gxbb: Fix HDMI PLL for GXL SoCs
>>   dt-bindings: clk: meson-gxbb: Add Video clock bindings
>>   clk: meson-gxbb: Add video clocks
>>
>>  drivers/clk/meson/Makefile            |   2 +-
>>  drivers/clk/meson/clkc.h              |   6 +
>>  drivers/clk/meson/gxbb.c              | 773
>> +++++++++++++++++++++++++++++++++-
>>  drivers/clk/meson/gxbb.h              |  26 +-
>>  drivers/clk/meson/vid-pll-div.c       |  91 ++++
>>  include/dt-bindings/clock/gxbb-clkc.h |  18 +
>>  6 files changed, 911 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/clk/meson/vid-pll-div.c
>>
> 
> Looks sane enough ;)
> 
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> 

Thanks, applied on next/drivers !

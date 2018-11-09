Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF355C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7621620827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="157Pkpf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7621620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeKIS3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:29:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38375 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeKIS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:29:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id f2-v6so1178227wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oKsZvW81DQ7dTNUylOUC3pGW7J94hNiePNe736TDnvU=;
        b=157Pkpf4Qmxh9UERK2AjIODn9VjNQKKt2wqRGnexp2o2/GJhLei9cgT9aF5imryrJN
         uFfb/wYQCS69Kmoh2YPkFlpqfwgnskMmEVfwteCwweS2THZG21USUjQ7xEgjGXV1OSK1
         5BJDWrOPmdcYvAcbU1DMsHXTxA4AIhV2Qmd2UiGQQ2GkK8DS2m978PhjhETyl9GWehDw
         TfV/90ftpq07Lit/lqWFe7Epa+CKhHkOQzrkIA+d898jdtijqSH2R4LU4n34C+1GOY/6
         JDPazq0D118DfAqDKlqQNFs2LYMoCMN0e2lN0rJpgnpRStlgX6EQ7tRgI/IlyTAb13QZ
         ukug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oKsZvW81DQ7dTNUylOUC3pGW7J94hNiePNe736TDnvU=;
        b=uI7ndw/VtyFLiN9ImSWEUdRD2bMvt/JFEtrY0H0Bbj4sV+4HhLc+rpUxSx6x9jLrfY
         PKVgkFtJZg3XpAff2lpboyXyEqLTqxwOjmmqtIQ+tRGamxOX5OEIkq5TaMpMQ7tGLkjd
         olwv5VaJgabTlo81GorVX6WK+E1abWczsXNL+btDkQ7IDRFDcGPiKP7B8mMZ5CTSQpRd
         kAbtxXpU3Fsp+r461V+11MdNo2HvDWU+UFmkp6WrP28i2lCEYYBRlwKyPAw/zZIAALKt
         /CURqMYy9h4cqS5lQauvS04fE34lrS91xA0Cv2tiK4KCdfCTFG0y25cW14F/JAiQL/bW
         ZR2g==
X-Gm-Message-State: AGRZ1gI2ahAAkFlvFvIj7IuWrabz4YQMJZ7te7RAsB7m2RZjWkDE93vo
        Y4ghTvHhLOXStVYtUEurAYxWk/ks9X0=
X-Google-Smtp-Source: AJdET5f1Go4AmU9Q7OHRdNo5C6TkNKULEWXNnMP3w9ZtHeVHtUNf9b/k9Wk8SXsyq2otgLTy5rT5Lw==
X-Received: by 2002:a1c:1383:: with SMTP id 125-v6mr4054324wmt.71.1541753413263;
        Fri, 09 Nov 2018 00:50:13 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r126-v6sm800820wmg.1.2018.11.09.00.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:50:12 -0800 (PST)
Subject: Re: [PATCH 0/2] sony-cxd2880: add optional vcc regulator
To:     Frank Rowand <frowand.list@gmail.com>, Yasunari.Takiguchi@sony.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
 <5328b351-e768-6c4a-66c4-c5f6d5894244@gmail.com>
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
Message-ID: <b1a8f0c4-de98-5c8e-bfce-84c8f32789aa@baylibre.com>
Date:   Fri, 9 Nov 2018 09:50:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5328b351-e768-6c4a-66c4-c5f6d5894244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On 09/11/2018 03:22, Frank Rowand wrote:
> Hi Neil,
> 
> On 11/8/18 4:50 AM, Neil Armstrong wrote:
>> This patchset adds an optional VCC regulator to the bindings and driver to
>> make sure power is enabled to the module before starting attaching to
>> the device.
>>
>> Neil Armstrong (2):
>>   media: cxd2880-spi: Add optional vcc regulator
>>   media: sony-cxd2880: add optional vcc regulator to bindings
>>
>>  .../devicetree/bindings/media/spi/sony-cxd2880.txt       |  4 ++++
>>  drivers/media/spi/cxd2880-spi.c                          | 16 ++++++++++++++++
>>  2 files changed, 20 insertions(+)
>>
> 
> Please see Documentation/devicetree/bindings/submitting-patches.txt
> for some helpful information about submitting a series that includes
> a bindings patch.
> 
> You will want to add 'dt-bindings:' into the subject line, along with the
> current 'media:'.  And getmaintainer will give you Rob's and Mark's
> emails.

I'll re-spin with dt-bindings, but some maintainers don't want or don't care,
so it's always a wild guess at some point !

> 
> Thanks,
> 
> Frank
> 

Neil

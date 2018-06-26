Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19677C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3964208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y30ABjRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3964208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeFZIJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:09:20 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34277 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbeFZIJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:09:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so16233473wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cli5wUcPbL9G10dPsOyjZYy5/cvIMG117xIO1SqrtCU=;
        b=Y30ABjRYpFp4EyPflVGwIry5EgmM09wUxdIYuc51aI8A0kkzFYX/QSMJ92YqESoKQu
         X+YLjFzq7jZbJX9B5RpR+cnkBghTZQVHBbqB1+9Oxoj9mL11WKYXXOlQa2ha2G20BQ10
         7JfSAGznGvKmjCNEwtGX3wgb6JHv5o74W3rZIty7misZZy0kBeENNuFHWAARClJr0xsO
         y/SxEzAt0Co88yTl1X/JLqAnWgeZMRRPzdGWoiAV2h+1GGAgqpPya5jTRoxucAToD9eP
         J3wjTlHOhvIWSzjuGKZkxcJIV8PEbDLVSk4ygkNnGeN3RDP6UNHwmbF9LrziB5CT1xrV
         wfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cli5wUcPbL9G10dPsOyjZYy5/cvIMG117xIO1SqrtCU=;
        b=PEHlBQ1bVy2VPBUTm/Qkb0DZk0GE9WY7XwyGwF91KrZy3pAYostnJOoY0E/NE4rLBj
         YMQjhgojXE4w14F/jfZX7bOYJ01bT1p/pg3QsBYCn/DOWGF/HKzDexUkUL0QQl9Vdg+6
         sbSN3zNXlSXwelpAECADk3ObIxD0wGan8+gi2IVkyGUuf/TTTDg/JzQZ/oBbtBqlDBkS
         9mdnZHv4iuF+z5DfeGlFafIJAur5Rcf58tgL5z6rMHr1w/7n3KBd7AcY/XBhEmRcH7iS
         O+jVNrmnrRSTLapj8/SI3iId7oiDQGuDUEoSuju8uCAWNRdyhWyPy6qHFy3K7+sz66jC
         tz0g==
X-Gm-Message-State: APt69E2nLGZoRDwImPIJZtBJMB+fdR+uIyyimQyl3sAJgTBPgBLzP4PO
        4OqTAfT9g3h/6qWe+KzykmC7Hjy1BY8=
X-Google-Smtp-Source: AAOMgpfRgTDR8b0K43SzALNHvErUmCo8fzaVkgrBBhBc28D8lpnHjyc9Kax8vPNRRGI6uoLyHrpLkQ==
X-Received: by 2002:adf:e48e:: with SMTP id i14-v6mr572138wrm.8.1530000554963;
        Tue, 26 Jun 2018 01:09:14 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a203-v6sm1243595wme.46.2018.06.26.01.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:09:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] clk: meson: remove unused clk-audio-divider driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180620100610.29010-1-jbrunet@baylibre.com>
 <20180620100610.29010-3-jbrunet@baylibre.com>
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
Message-ID: <2cdbc56d-a1e5-62f7-c3d5-9d5f37544118@baylibre.com>
Date:   Tue, 26 Jun 2018 10:09:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620100610.29010-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2018 12:06, Jerome Brunet wrote:
> clk-audio-divider is no longer used, we can remove it.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/Makefile            |   2 +-
>  drivers/clk/meson/clk-audio-divider.c | 110 ----------------------------------
>  drivers/clk/meson/clkc.h              |   7 ---
>  3 files changed, 1 insertion(+), 118 deletions(-)
>  delete mode 100644 drivers/clk/meson/clk-audio-divider.c
> 
[...]
Acked-by: Neil Armstrong <narmstrong@baylibre.com>

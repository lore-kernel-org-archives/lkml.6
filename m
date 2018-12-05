Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A4CC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AA52082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kXUqrqaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AA52082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeLEKQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:16:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34343 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeLEKQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:16:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so19057326wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=57eaKVrJbAST+zjqvbxYBPsqC3bXOx38CPtaP3zRr+g=;
        b=kXUqrqaF6tgvM7tDXH9HLiqW1Tl6HFA8j2f/gpkFU0tBJuK0aRmVx6gFLOuHzHi3Ed
         9CsjKbM79h+P/NoE1+tKXuN4L3zPuo86WvgO+fxGWDRZOH3LnBNx7cuvXfYliRVaa2Q2
         5e08Tx8Mx1rxVT5D6R/qaXZfEdDRFtkMTMTWQVsyitujGSyPwAsxkdXpUYReP+TEQlrr
         NHMiPyoDC9G9a98y8trEPUMvv8DHEOK7ViFDDuKFFdJEMSItTP3t2JUsbS2tIpPLJIni
         MAM8H+iRtZpOy0dYexCI8vykJ86O98g3uHLdIFW+ye/iz/N6zPuotRbl4ywdefhA+bHE
         tsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=57eaKVrJbAST+zjqvbxYBPsqC3bXOx38CPtaP3zRr+g=;
        b=SNXy3RxKm2TzfTGU+sUyxOs2lC3ypHP9JNzhdtC66d6/n+EyZDt5y0QRMNfbsped6Y
         JMjfD4LwHgEK2wRCVYAeAMkzlRsGpJcLadqyXZpSDWRVlkZMFcGcUN4u3uz0zUejwdc8
         HyzCow2L3JNWg/zzJjpX4G4wp5OQjem49B1UKgUGDe0Om+xghc4CJCs/4FDe8mE3gw7S
         V95Fuptwy6ZtWHLFeIdbtqEg0F7GiSct+OSIZLZ3GdYqbtnPobn35ZYfzDRhagvLu98T
         XG/EB53My+eqDeMs4YEJOaSs2uyreTMN9bkJddQ+i0vDJ/sRUUH5sJVWQz+7N+Cez5+2
         kprw==
X-Gm-Message-State: AA+aEWbJQoqWp+BWigIdpxU6Tx09tAO/+lqWXlipizvRsKNv60e6GY6Q
        lR9QDO7YepcztapQ3j1kDmGRPQ==
X-Google-Smtp-Source: AFSGD/WfsWqmd2BEV+5i8FbN8V8ID2e2fj3AN3J3DmByLADqxI5d7Q8dIVJm3kFom3Cv7baZS/A9Sg==
X-Received: by 2002:adf:a4d9:: with SMTP id h25mr19840891wrb.167.1544004983158;
        Wed, 05 Dec 2018 02:16:23 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:819f:4d34:9af9:e67? ([2a01:cb1d:4ce:ea00:819f:4d34:9af9:e67])
        by smtp.gmail.com with ESMTPSA id t5sm11297413wmg.43.2018.12.05.02.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 02:16:22 -0800 (PST)
Subject: Re: [PATCH 0/2] clk: meson: add clk-input helper
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20181204165819.21541-1-jbrunet@baylibre.com>
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
Message-ID: <88cc4a9c-d51d-ee34-3e38-36645e53bb13@baylibre.com>
Date:   Wed, 5 Dec 2018 11:16:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204165819.21541-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 17:58, Jerome Brunet wrote:
> When the related bindings get merged, we will add more input clocks
> to the different amlogic clock controllers. Instead of copying this
> code around, lets create an helper function and use it.
> 
> Jerome Brunet (2):
>   clk: meson: add clk-input helper function
>   clk: meson: axg-audio: use the clk input helper function
> 
>  drivers/clk/meson/Makefile    |  2 +-
>  drivers/clk/meson/axg-audio.c | 83 ++++++++++-------------------------
>  drivers/clk/meson/clk-input.c | 44 +++++++++++++++++++
>  drivers/clk/meson/clkc.h      |  5 +++
>  4 files changed, 74 insertions(+), 60 deletions(-)
>  create mode 100644 drivers/clk/meson/clk-input.c
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Will be useful for the next cycle to take in account the controller input clocks
defined in the DT.

Applied on next/drivers

Neil

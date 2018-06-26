Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2586FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D0C2612A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i43kR1dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D0C2612A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbeFZIHd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:07:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36158 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeFZIH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:07:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id u18-v6so732481wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sN3Qeh962eQrzvQBbDrqYVXr+KyWKG7m8xLF/LqyWVM=;
        b=i43kR1dtxl3xUG/8Udi0lF3NuHcpYPcAob4NCWTX1WKidaLv3KYq2UkCzouOWyNA3V
         kouYIwUROqgfR3Ynp17HZE+fFP4mDzuRSXRVNqhp4buXXNteYGWHnFO/G1xOTZD/xWZ4
         JJZCsu08m1lfX4fQgqKg6WOTN8RDgOGloEMpPJeO4xkpEChvKBDnSTFBJ0dVdk0ECiD9
         GDhWe+mhEp5j0nUEC+Y2CdP9UTkd296CRx/RuExyc5T8yp16am6G4BHHsAKgoG+iHSdF
         dP7zsKkkSsv5no/4JYgxUjxPKGy38oX9wKRKl7srmylHtEQSxf1kYeDMQR9K2WqJSc4I
         zwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sN3Qeh962eQrzvQBbDrqYVXr+KyWKG7m8xLF/LqyWVM=;
        b=BaXAEDEJozIELj3M8wmEPSAljQT+B6ZcMvK8M++9e6DiE0HdbF7Y0Xj7wov1m/k3kF
         MKwX77Jbq5oENKp57ooOyIoT8rgEnaw5qPZsE15x3acoLgNOqPHos2zetOj5MKGBHipf
         2obWjpvdeSiLoG0+nXbU+NeJXEdWiDdnraOZZQBCrV5UNIzXbt5AmItYrQUxp1hzc7hi
         2DRzfpEj5sCc5ad+Hzl+xDFrp7z1x/BPbpaKDGF+0sJJ8tQHKjFEvOc+YhTqO8exP62j
         +ajmvPbtu+GuvdD/izHtUmLstshsB/cN9ywThSX1cH6QidpzwNEUbTTzI0Qab97eJqXU
         0SpQ==
X-Gm-Message-State: APt69E0DsKTsAFq94YZQIQi7xFkP4yeSAD5fTvuLShNIa9PmlXVp1BkP
        yLSGtxGnn/rALz0Ce9kbjizZdw==
X-Google-Smtp-Source: AAOMgpfcHuqMi1+dcJBBIDh7Do8fZP1vg3OI/Zjc/nPD7q40wxgHj9Qm4Y1KKkrtfQBWcFNthsJpLQ==
X-Received: by 2002:a1c:894f:: with SMTP id l76-v6mr686932wmd.103.1530000447635;
        Tue, 26 Jun 2018 01:07:27 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 74-v6sm1917683wmt.31.2018.06.26.01.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:07:26 -0700 (PDT)
Subject: Re: [PATCH] ARM64: dts: meson-axg: fix ethernet stability issue
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180625125653.3404-1-jbrunet@baylibre.com>
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
Message-ID: <d59a60d1-d5fc-6d89-f89b-148c8e3f3521@baylibre.com>
Date:   Tue, 26 Jun 2018 10:07:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625125653.3404-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 14:56, Jerome Brunet wrote:
> Like the odroid-c2 and wetek, the s400 uses the RTL8211F and seems to
> suffer from the kind of stability issue.
> 
> Doing an iperf3 download test, we can see a significant number of LPI
> interrupts on the tx path. After a short while (5 to 15 seconds), the
> network connection dies. If using rootfs over NFS, the connection may
> also break during the boot sequence.
> 
> We still don't have a real explanation for this problem so let's disable
> EEE once again.
> 
> Fixes: f6f6ac914b82 ("ARM64: dts: meson-axg: enable ethernet for A113D S400 board")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
[...]
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316FEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E2A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1I27N1nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E2A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeLKJQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:16:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40955 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKJQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:16:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so1368888wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E3P0VB4t6+DqCGyBcLCrB5erX8OZcvz7dPWAblWoNGA=;
        b=1I27N1ncJyt304PlsEgJEzqOyGu4scX0m98ZhGyuRECobPkxvQbgFTopn3fhawiHYj
         vFnlPsc2tFmsu7G2ZnMAL0xY4qJcsONSNnNgWriNOBSSO0GX5aCGm0rSfK03+iKuxZgj
         tT7jL3AMIIYvxVcJOr+WSTHXsSqCbl+VpjfM+HWBpJsN40dPqqivokjeNMCUmbZtJVkr
         7Du4V9rC7sU+8osxEqmZT64T5fMll9Lf1VVEsVvpvD4krXEZk7CWm7hJqYSGQZGV1UTj
         9RuwUFjU5h8DqZm2GCCjq8dRbe8y+R8TH6HbomPY+ZWb39WtlozVh9KhVaGeIfnXtkBQ
         SqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E3P0VB4t6+DqCGyBcLCrB5erX8OZcvz7dPWAblWoNGA=;
        b=ToYBwx0iKW7/9SM9vpdZ0f6BX9N4HMad+fGQDthBA9Xe0DSOlHFZtHYp9dH4176ypN
         GdVr+deWgNVuEn4HH6H1hTm8i6WpK/pZGN4nsuKun8LRcFIs3a4+aINPUlQll75/4lWD
         6p5aJv/JjBMPHwZ8hLZldwsN76DHbr/JkZZeQMBWjy5PAO1kWpsISIB7pgn86TO3y776
         VeulJPoj7Ub6UmQ8KmF0LyIJBv2X6pKzugzF4vTP0PAY5HkxVJ+9V8/bUsqh2Q1Nl7Wi
         Z9lcP9pYl7w2oqCTrIqKxsKS+BVRKyO1hzEcf6z2N7FMVDDlLmoDRz3JVGQkFcDNBmwZ
         dT8w==
X-Gm-Message-State: AA+aEWaiWndSPTs9Ag+yzfQu7+00tNpGvh7uFOiZqmAZZrvxvjmbyVgH
        lQiktxGkBkD5BgJ2meStTl6NRA==
X-Google-Smtp-Source: AFSGD/WfPmpnmda9WPjhcNVXlZ9RE+xqQZ4f+3qKfKYKCOaMCKplEoYR+torXVFcbAHWmHuuV+7lfA==
X-Received: by 2002:a1c:1a90:: with SMTP id a138mr1589549wma.109.1544519794435;
        Tue, 11 Dec 2018 01:16:34 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157? ([2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157])
        by smtp.gmail.com with ESMTPSA id 60sm25778639wrb.81.2018.12.11.01.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 01:16:33 -0800 (PST)
Subject: Re: [PATCH v2 0/3] ARM: dts: meson: add the APB/APB2 busses
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
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
Message-ID: <ba3e4fef-7a18-8c7d-e0ea-05c541b29913@baylibre.com>
Date:   Tue, 11 Dec 2018 10:16:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2018 17:50, Martin Blumenstingl wrote:
> This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
> Meson6. This is preparation work for adding the Mali GPU which is
> located on theses busses.
> 
> Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
> region at 0xd0000000 is called APB2 or A9_APB and it has a different
> size (256k) compared to Meson8 and Meson8b (2M).
> 
> Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
> - Meson6: [0]
> - Meson8: [1]
> - Meson8b: [2]
> 
> 
> Changes since v1 at [3]:
> - re-send the patches but this time don't include the old patches
>   which still had a typo in the patch description (ABP vs APB)
> 
> 
> [0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
> [1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
> [2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53
> [3] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009424.html
> 
> 
> Martin Blumenstingl (3):
>   ARM: dts: meson6: add the APB2 bus
>   ARM: dts: meson8: add the APB bus
>   ARM: dts: meson8b: add the APB bus
> 
>  arch/arm/boot/dts/meson6.dtsi  | 8 ++++++++
>  arch/arm/boot/dts/meson8.dtsi  | 8 ++++++++
>  arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
>  3 files changed, 24 insertions(+)
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

But frankly I'll squash the meson8/meson8b patches with the mali node patches !

Neil

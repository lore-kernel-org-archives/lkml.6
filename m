Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51661C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED53B20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ooYIk3nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED53B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIKS2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:28:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54164 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeIKS2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:28:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id b19-v6so998677wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GfD+hY1VLOiFB9LpWoSjQQgGs7MEBCb+DeIG80JdnuY=;
        b=ooYIk3nYD1PCmHLRWYrPgMFbGmrY1x/48ksQkUPupo7n6z1x5aY3Tvbyjb59Wz9BJB
         KClYgcneHfVD/sWAapDSm+1k+GUi4p77+lcjm1Kl4WB4DJyx6AU3S/ck7aFTBgQBgyze
         urzUCZWai8FhqcRrW3fTAueFsEuOJv3a3NWu9T+RsUDu0mSqqCEIC81r0sqs9HmaY/KL
         NRDAqyxdMhccFydQTay/DmeYbeyANDTT/b9SULFoRxXD4HZ30XmpCxgxonIVAwymK/dV
         XcoMk20dIZv9f0TAjeSf3Pop5c12VBbrvnneEjk9vl5jRtk8fTsaxbXV5LsEohL9FzBQ
         48tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GfD+hY1VLOiFB9LpWoSjQQgGs7MEBCb+DeIG80JdnuY=;
        b=IZzasLiJM3Nu4eNcvBrEq6YQOFrWoSGBeMvGdeWUh+G3jyoOGNg4Pu4HJ7RPFTCMam
         Bj0sr1QyUwsai1Z0hOzN1pfnbeTV71TEb9dzmKV+A1juHboBK6R3xY3TUolVT/skw8eR
         V+d2hODYImE7ykp6GeA3wpLD5XoI127a1cvo942gpP7SWZDturhJh7gngNKDTlhXg1iA
         cBU3lmtHUcgDCJEmJQaoIW2FoLq2h9myX/yrrT2dE7OscX5TrdbhUrUPdW3mnMq87RIH
         XlMUAi8R690JoczDLKqKTXpFrvQ8wLO6ox4ZnUWoPluAWS+P8EFsU3/JrBSg6pBC5ye+
         tcbA==
X-Gm-Message-State: APzg51C6f5xHxDoK0XxWc8fcoM0tfyzfYK00bVauv01jI1gatwuYY8vQ
        BBnU4bdVpTgtHBWth77ccQ5zmA==
X-Google-Smtp-Source: ANB0VdahcvNaSghf2tJzp1c6Pa/awkvKfSdSuoUlOroBVumG7gD6+0PTyYQIoGqcFo+PrWLaUM3ADA==
X-Received: by 2002:a1c:cf8a:: with SMTP id f132-v6mr1380143wmg.0.1536672533632;
        Tue, 11 Sep 2018 06:28:53 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:10fd:4780:9fae:1ba3? ([2a01:cb1d:4ce:ea00:10fd:4780:9fae:1ba3])
        by smtp.gmail.com with ESMTPSA id s131-v6sm1194561wmf.2.2018.09.11.06.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 06:28:52 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson-axg-s400: Add chosen and memory nodes
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1536604395-31925-1-git-send-email-narmstrong@baylibre.com>
 <CAFBinCDeHVZ5s2f5xhuRByg7pt+MTqqfO8_5C_s_B3hbZkDANg@mail.gmail.com>
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
Message-ID: <b7118d22-45f7-d509-70fe-a2923a0b78ff@baylibre.com>
Date:   Tue, 11 Sep 2018 15:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCDeHVZ5s2f5xhuRByg7pt+MTqqfO8_5C_s_B3hbZkDANg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 10/09/2018 20:45, Martin Blumenstingl wrote:
> On Mon, Sep 10, 2018 at 8:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add missing chosen and memory nodes.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> out of curiosity:
> - does the bootloader add the memory node (meaning that this is just a
> cosmetic bit)?

Yes, but it's always better to already have the node so it only change the memory,
otherwise it has to relocate and insert a node in the middle of the dtb.

> - setting stdout-path is always a good idea, without it you can't use
> earlycon (without parameters)
> 
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 

Thanks,
Neil

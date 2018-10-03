Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA5DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2022098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TIS/0mDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2022098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJCU3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:29:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51915 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCU3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:29:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so5755090wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=twKYn5IcCbEYdsCFJSxkULtCKpA/HmUxHWeUZO669OA=;
        b=TIS/0mDuf495wvWoWnhlyfJDdho/3FrL9jI3mYZ3XLFE33Ud12FIBy1IqnHzlcQbg5
         9nLvzaSYMpqa0fLcBB2dbqt0SSZfWtg/OFQoCwF2hJdZu4kEfx06LqP9Xe4eo8sVkq9w
         KddbHlUHEAB3HaqfTxcnBaCZ8+xnoUFWhPg0ouCHpbwBk4qdTFXTPsNxmu4ZP4UOz/NG
         kLKZZExdYjj1MJfeAsdk/NXClh9/A7TLShfMQGjxn1FqUl9NuKMFMahfdUqHI6dr4uFo
         /710QHohkiBHB4iAnIsDbW8+l8kZpjlwh+5QFuvHHfGRG2b70WKn8ALtN+lvnMGGET29
         JRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=twKYn5IcCbEYdsCFJSxkULtCKpA/HmUxHWeUZO669OA=;
        b=SczRAVgJPHvFzil7Gr+TLU7j1EMofoI+ys9a0DzHvkrXAtN7nlB1BC6OkPZn3wUp8B
         B+NYNnDDi6EgrjnUzDdVBo3T6gA1Tyie5etTgXazV58oBNbBZ9pna7UrZGDSjMJ/9A/n
         9EqaffNKui9QW0svnXnfuJEA9T0fAI8WuY9tma3dJcPXYAQcXAsaXI7g0SN2ERyBq1qe
         sOLLPZ43VykI8qCmuWLCF9IKFrVbXQ0KzRAHXAfzafeFph/+XqnnVBue92/ENEctnaW1
         g9zxn1EVhyDZRPM5UnVrNJC7/5JLzEjAf6W+p3S1Rlio6lzs8PBKBNOR4K6Kjvggh2Ac
         vWIA==
X-Gm-Message-State: ABuFfogN/nbMbLRm9DyPqAorJrYxxO0M8nnzQjunyCQehsMU7OJJ4zvy
        EoDZvqXnz111G0a0rDhbWqfvkOiGXdk=
X-Google-Smtp-Source: ACcGV60oPG7A9MBNQ2odrjrkZCfxhx3jA6DZty3fSmipvXBRnfYDOgI42MjKE+NTDnyM721WM0FN4g==
X-Received: by 2002:a1c:5d54:: with SMTP id r81-v6mr1457219wmb.88.1538574085780;
        Wed, 03 Oct 2018 06:41:25 -0700 (PDT)
Received: from ?IPv6:2a01:e34:eeb6:4690:6c78:1f23:6bb3:14f6? ([2a01:e34:eeb6:4690:6c78:1f23:6bb3:14f6])
        by smtp.gmail.com with ESMTPSA id b193-v6sm2042696wmg.44.2018.10.03.06.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:41:24 -0700 (PDT)
Subject: Re: [PATCH] mfd: cros-ec: copy the whole event in get_next_event_xfer
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Emil Karlson <jekarlson@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        lee.jones@linaro.org, bleung@chromium.org, olof@lixom.net,
        linux-kernel@vger.kernel.org
References: <22cc40a7-015b-6038-2093-8cd1ff0c807e@baylibre.com>
 <20180928170818.32124-1-jekarlson@gmail.com>
 <84a0aba3-0793-1659-c70c-d5ece650f832@collabora.com>
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
Message-ID: <13bda116-5766-1340-81e1-48ca899ff41a@baylibre.com>
Date:   Wed, 3 Oct 2018 15:41:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <84a0aba3-0793-1659-c70c-d5ece650f832@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 03/10/2018 13:01, Enric Balletbo i Serra wrote:
> Hi Emil,
> 
> Many thanks to catch this and fix. Some comments below.
> 
> You missed to add the v2, please send the next patch with v3 prefix.
> 
> On 28/9/18 19:08, Emil Karlson wrote:
>> Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
>> be truncated on many chromebooks so that Left and Right keys on Column 12 were
>> always 0. Use ret as memcpy len to fix this.
>>

[...]

> 
> Neil, can you give us your Tested-by to have the make sure this doesn't break
> with protocol v1, I don't have such hardware.

I'd like to, but I'm unable to get developer mode and legacy boot back on my TEEMO device...

Neil

> 
> Benson, will be really good have this merged in this rc. Are you fine with this
> solution?
> 
> BTW, you can add my in next version.
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 


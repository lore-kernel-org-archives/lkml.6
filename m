Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF26C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCF7223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Bg/3z01U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCF7223E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeHJKSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:18:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44075 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeHJKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:18:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so7395161wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+n0VR3Q4KevkzBGS6sqR9YHYsXrqfUW0vVYxt3RVVm0=;
        b=Bg/3z01UqQF0ZKNb7oj9rYA/3IyZKlQJHc7T1jGfYHZZxp+oicMOVpkKzaD4Uhrg9A
         wE2g4gxC/LwOvlU3VOFGPHwDe18eoan4BrUk3kRoydSw8VOVGAdvv/oyU9jQ/HADvyeS
         jp0rfXo/pZwLzmoOQd5pB5rZ3bRmr0bW4w1YMhd1OpMrUQeuFUcKE1WXIfYljn2Xz/RY
         IiNTGw77t/IBOLNguhOC0gkNgZHcLCflauNGaV1Yopk4veUrBrOmcl1a6Ow6PiLMqNEv
         ANZ0Utund823/99qyvVdvh+sJ3Y8DTqayC62/zR4IwY8VpRYizko9oAL6xG68C8yjZLs
         I3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+n0VR3Q4KevkzBGS6sqR9YHYsXrqfUW0vVYxt3RVVm0=;
        b=YjyC4NMnvaqwdtbBJaIk18NNPqN+3+p7GAb91UhqNR26COdx38m4UNMXmTEjQfcNlb
         H1gJjvae0EEKOyNF+K4an3plgJAsdk7ewQMFYSzWKQWccJJ3KKf+yZqrpn8ehKhf+oh0
         e4b5Y/T3DVMoVGC3tf+So6SvWDYHg60jFsf0hr3sQk+SbHWIPkpm8/t6fWfj3KLPMSb+
         DglPw2ep8Apyu+qL5MiB7yQoj08B32rqGPkI5anakY9hxEP+VTRtG0W1hT3ETRXHGJKu
         /qBhJfc2dDtmZy05VLTLGhn1Nyzue6tFjKaldpyhWmYFGDu5/gDCcrKo4JQsz+2ha0i0
         yYpA==
X-Gm-Message-State: AOUpUlFi49U7PhSaBtLQ8GYhNF4z4XxvK10wDVX6pxtRHGtUZkxKGyim
        S9VejaO4nBp5jrf4WoZ4diqQl8phLh8=
X-Google-Smtp-Source: AA+uWPxlTrUSKjxxa+dngz+qSmCfKRWPQ1nmBcsNnMGx2/7a89IwKVOlRwo7jXIEwgfGwUT8wgGGuA==
X-Received: by 2002:a5d:504d:: with SMTP id h13-v6mr3365551wrt.18.1533887358864;
        Fri, 10 Aug 2018 00:49:18 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f23-v6sm529664wmc.42.2018.08.10.00.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 00:49:17 -0700 (PDT)
Subject: Re: [PATCH 4/4] drm/meson: convert to the new canvas module
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Rob Herring <robh@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-5-maxi.jourdan@wanadoo.fr>
 <5b6cc316.1c69fb81.682d3.1216@mx.google.com>
 <CAHStOZ6oemCwYWb7dW6SS_ZaWEiVWSfrF=dB_G6CkVb6KS96nA@mail.gmail.com>
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
Message-ID: <e95fe817-ef12-9d06-e7c3-af2a959a2443@baylibre.com>
Date:   Fri, 10 Aug 2018 09:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHStOZ6oemCwYWb7dW6SS_ZaWEiVWSfrF=dB_G6CkVb6KS96nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2018 08:35, Maxime Jourdan wrote:
> 2018-08-10 0:41 GMT+02:00 Rob Herring <robh@kernel.org>:
>> Hi, this is an automated email from Rob's (experimental) review bot. I
>> found a couple of common problems with your patch. Please see below.
>>
>> On Wed,  1 Aug 2018 20:51:28 +0200, Maxime Jourdan wrote:
>>> This removes the meson_canvas files within the meson/drm layer
>>> and makes use of the new canvas module that is referenced in the dts.
>>>
>>> Canvases can be used by different IPs and modules, and it is as such
>>> preferable to rely on a module that can safely dispatch canvases on
>>> demand.
>>>
>>> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>>
>> The preferred subject prefix is "dt-bindings: <binding dir>: ...".
>>
>>> ---
>>>  .../bindings/display/amlogic,meson-vpu.txt    |  9 +--
>>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  7 +-
>>>  drivers/gpu/drm/meson/Kconfig                 |  1 +
>>>  drivers/gpu/drm/meson/Makefile                |  2 +-
>>>  drivers/gpu/drm/meson/meson_canvas.c          | 70 -------------------
>>>  drivers/gpu/drm/meson/meson_canvas.h          | 42 -----------
>>>  drivers/gpu/drm/meson/meson_crtc.c            |  5 +-
>>>  drivers/gpu/drm/meson/meson_drv.c             | 35 ++++++----
>>>  drivers/gpu/drm/meson/meson_drv.h             |  5 +-
>>>  drivers/gpu/drm/meson/meson_plane.c           |  3 +-
>>>  drivers/gpu/drm/meson/meson_viu.c             |  1 -
>>>  11 files changed, 39 insertions(+), 141 deletions(-)
>>>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
>>>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h
>>>
>>
>> DT bindings (including binding headers) should be a separate patch. See
>> Documentation/devicetree/bindings/submitting-patches.txt.
>>
> 
> Hi, What's the standard procedure here ? The reason I kept
> devicetree+drm changes together is because I didn't want to have
> floating commits that would break the drm module.
> 
> Should I split the changes anyway ?
> 
> Maxime
> 

Yep, split the dt-bindings and the code change.

In a non-perfect work, it could be great to keep the "old" canvas until
everything is merged, except if Kevin let me merge everything (including DT) in drm-misc.

Neil

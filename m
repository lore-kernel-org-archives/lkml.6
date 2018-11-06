Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAEFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D023A2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m9kO7J5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D023A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388377AbeKFXCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:02:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46697 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388116AbeKFXCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:02:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id 74-v6so13510885wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0/KvwNXApNOUnRf5yyLFmWPtGfdCTPu2OGRKhSYWFoY=;
        b=m9kO7J5TIYRFtQcy9fAPIsPeGdIbl2WcJENisVye/3Efbvw8MzvTqmvNz7mw973tLr
         zXdZBiIR07S4sJqxmrcLmgrwfhcY1nprs3HST2BC13ueZj2do8RkBx0GBidFx9T+oK6C
         PJ9WQX1TtT12UVA1Glew9HM0ZfYiazHwVJJELeSYVxI0z36QgzS/jneQxTIffmioAy7A
         cjBpNyKacl2u7obII+yVs+Gr65WMxs683S5sMiaqI0j8AGbfaanwkmpCDutbXFvfNPrM
         nuGftxryJAKTOmzXCdOu0Y1JQ57I3RzE8BkUhd1FcFIursq+fuxOb8rxIV1jMSE4Ihmi
         35PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0/KvwNXApNOUnRf5yyLFmWPtGfdCTPu2OGRKhSYWFoY=;
        b=CzaKVBTgKEJcxH7JAg02fpXouatJYasDdTXTT4h3Y1VeTiTK2YtaXInEC9cU/NY2tI
         ue8QzMXVzF1excScijUvXgbZE6uv2VWuLrjcYkBZsWCdDfwcwAZRnIXk0c5JzKO4FZHC
         Wo1j4Oemo0H7EYk6GZNgsQyqjZsWQttwGtWVj3xKzL1qxc88VXaYskIaFJVk5tQFh02t
         IAFgll/SSz3KrSx14QpyTkjANNJHznRd1vDw1QB2d7R5IH3Qlh+nCkpQHW6DV6IXE5NJ
         SphAaED7eixwvgZVCzzqDvyt1bUGIxzGPYLWOdo9hkiCPksdscl0FX5lvpp9BQ0HSHri
         IUwA==
X-Gm-Message-State: AGRZ1gL+6svfvDTeVqW3jRKRmHLqIUKhp5jU9C9Bw6tM3B6m/Cvfvv9q
        NQIvCnn9jiQTX42Ez4OrJyoCDA==
X-Google-Smtp-Source: AJdET5cpP1hjKDAOEJ64GoiYKQjznWcFXQyh+TmsB0TA3O1ALF6SiI8PpHTGLq1mHU4+mMT7Kxz4xg==
X-Received: by 2002:adf:ff4e:: with SMTP id u14-v6mr23493401wrs.232.1541511418270;
        Tue, 06 Nov 2018 05:36:58 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u2-v6sm2031488wme.4.2018.11.06.05.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 05:36:57 -0800 (PST)
Subject: Re: [PATCH 0/3] drm/meson: Add support for Overlay and OSD Plane
 scaling
To:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
 <20181106111310.GP21967@phenom.ffwll.local>
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
Message-ID: <c991c4cc-317c-19e7-a106-ce675f239559@baylibre.com>
Date:   Tue, 6 Nov 2018 14:36:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181106111310.GP21967@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 06/11/2018 12:13, Daniel Vetter wrote:
> On Tue, Nov 06, 2018 at 10:39:59AM +0100, Neil Armstrong wrote:
>> This serie adds support for :
>> - Overlay Plane blended with the primary plane, we can describe as "behind"
>> - Primary Plane up-scaling up to 5x factor to support the OSD plane being
>>   upscaled from 1920x1080 when the display mode is set as 3840x2160.
>>
>> These patches depends on the "drm/meson: Allow using optional canvas provider"
>> patchset from Maxime Jourdan at [1]
>>
>> [1] https://patchwork.kernel.org/project/linux-amlogic/list/?series=38355
>>
>> Neil Armstrong (3):
>>   drm/meson: Support Overlay plane for video rendering
>>   drm/meson: move OSD scaler management into plane atomic update
>>   drm/meson: Add primary plane scaling
> 
> Got bored, read a bit your patch series. Two things I've noticed:

Great you got bored today !

> - We need to drop the crtc_state argument from
>   drm_atomic_helper_check_plane_state(), some drivers (not meson) do
>   really funny stuff with this.

Should drm_atomic_get_crtc_state() be integrated into drm_atomic_helper_check_plane_state() ?

> 
> - I think your osd1_commit = true update is racy with the interrupt
>   handler checking it. Needs at least a few memory barriers. Since helpers
>   guarantee that you can't overtake a preceending update (you do the
>   vblank handling after the updating) that should be ok, except you arm
>   the vblank before setting up registers, so this might race too.

Yeah, I need to do a cleanup of this at some point...

> 
> Anyway all unrelated, so feel free to smash an
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> on the entire series.

thanks !

Will push to drm-misc-next once the branch is ready.

Neil

> 
> Cheers, Daniel
> 
>>
>>  drivers/gpu/drm/meson/Makefile          |   2 +-
>>  drivers/gpu/drm/meson/meson_canvas.c    |   7 +-
>>  drivers/gpu/drm/meson/meson_canvas.h    |  11 +-
>>  drivers/gpu/drm/meson/meson_crtc.c      | 251 +++++++++++++-
>>  drivers/gpu/drm/meson/meson_drv.c       |  29 +-
>>  drivers/gpu/drm/meson/meson_drv.h       |  62 ++++
>>  drivers/gpu/drm/meson/meson_overlay.c   | 586 ++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/meson/meson_overlay.h   |  14 +
>>  drivers/gpu/drm/meson/meson_plane.c     | 177 ++++++++--
>>  drivers/gpu/drm/meson/meson_registers.h |   3 +
>>  drivers/gpu/drm/meson/meson_viu.c       |  15 +
>>  drivers/gpu/drm/meson/meson_vpp.c       |  90 +++--
>>  12 files changed, 1156 insertions(+), 91 deletions(-)
>>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.h
>>
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


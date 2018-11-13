Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37789C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE84F223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BDrAbEgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE84F223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbeKMXbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:31:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36534 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbeKMXbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:31:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id s11so2089365wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DZ5Zn44hLQbDGpGv/YP7g5l2jJoCH2YAJyu/PLBrnNM=;
        b=BDrAbEgVvAkxiJsaY01H52VEWdWs9TWYrKAQwGanDEE+QDzOEHXCXrpCuvJGHC3NrM
         XUJ+jMim43pny6t72PcYwMpoN0JDDbEsK/8lOvNXPQN0UksGj+RENG55OyL6hlf42m0C
         yFB70lfL2upX94AuZYM7BLa0s54rcWGFxyVuOc2Ur/h47GnhlkEdF2WDJk+Mrs491+8Y
         43XmDmVoF765ADA+66WD4lVnyyUvA9qS5sATKGvjnurPdSLWjusDFt8VnByalX3xXiCs
         AphQcE39BG0tQY249xKtfeZZ/eFMhm+ovQsr4YgiHeUC9DlzYmxXsUZYI7UjFjCraiYk
         3BOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DZ5Zn44hLQbDGpGv/YP7g5l2jJoCH2YAJyu/PLBrnNM=;
        b=MGv9wVK7o9gZXdTtTVB6kaauzeSIQuZ+XRSZlj62FcwsWdUNVjHM8as9+Nqzn3KCeD
         5K9NmC/l4vTrmzHiU+cfdW2Pdg17yn0r3cxxY3rmhpkqAvbpJPmY6xB1XYbySIZEIVDf
         TvhnHyO3GdCAIJbC+emQEV1gFbZvRiW8dbohVZVYmf3e8Yhkzm/+Q1lJahfyaaejmFMi
         XOkYQn1tRIgHksSdAzXz0HceaAlauGpPy2+NfILPU3MUmh47y+fTzf++QjxPWiyKsC6t
         3d7LmVxk97uu3EKwi3DNE+CC0K1JLHdJCLOeTy8IoLH12XI34NU0IbBI24lglXLgAbCj
         7LlA==
X-Gm-Message-State: AGRZ1gI4HG4BeyVtzwG2gPEt8lwU2GYLf7qrWdeQrTY1Pr8uGnoyXNNy
        YvTfYCZp+4Ze8uxltYEWvRfzRGUundE=
X-Google-Smtp-Source: AJdET5fhYwKYMKnwvqDg7wYz1xihcJNH7Eqlgl9ndDpnOw6TPe+ZQzz379e3Ber2AXrNnsEEOLyK/Q==
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr2020842wmj.129.1542115991321;
        Tue, 13 Nov 2018 05:33:11 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 197-v6sm13878702wmh.44.2018.11.13.05.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 05:33:10 -0800 (PST)
Subject: Re: [PATCH 0/3] drm/meson: Add support for Overlay and OSD Plane
 scaling
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
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
Message-ID: <66e1a959-3809-8ee1-9eab-d4409b340a85@baylibre.com>
Date:   Tue, 13 Nov 2018 14:33:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 10:39, Neil Armstrong wrote:
> This serie adds support for :
> - Overlay Plane blended with the primary plane, we can describe as "behind"
> - Primary Plane up-scaling up to 5x factor to support the OSD plane being
>   upscaled from 1920x1080 when the display mode is set as 3840x2160.
> 
> These patches depends on the "drm/meson: Allow using optional canvas provider"
> patchset from Maxime Jourdan at [1]
> 
> [1] https://patchwork.kernel.org/project/linux-amlogic/list/?series=38355
> 
> Neil Armstrong (3):
>   drm/meson: Support Overlay plane for video rendering
>   drm/meson: move OSD scaler management into plane atomic update
>   drm/meson: Add primary plane scaling
> 
>  drivers/gpu/drm/meson/Makefile          |   2 +-
>  drivers/gpu/drm/meson/meson_canvas.c    |   7 +-
>  drivers/gpu/drm/meson/meson_canvas.h    |  11 +-
>  drivers/gpu/drm/meson/meson_crtc.c      | 251 +++++++++++++-
>  drivers/gpu/drm/meson/meson_drv.c       |  29 +-
>  drivers/gpu/drm/meson/meson_drv.h       |  62 ++++
>  drivers/gpu/drm/meson/meson_overlay.c   | 586 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_overlay.h   |  14 +
>  drivers/gpu/drm/meson/meson_plane.c     | 177 ++++++++--
>  drivers/gpu/drm/meson/meson_registers.h |   3 +
>  drivers/gpu/drm/meson/meson_viu.c       |  15 +
>  drivers/gpu/drm/meson/meson_vpp.c       |  90 +++--
>  12 files changed, 1156 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.c
>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.h
> 

Applied

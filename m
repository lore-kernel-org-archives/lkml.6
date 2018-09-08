Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9FBC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AA920844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mEnrKg6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AA920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeIHSou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:44:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40694 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeIHSou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:44:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so17515462wrw.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0C20rDbUe4v3NvAVW7h/5kiupxvjnopqvUYEwSM6Ghg=;
        b=mEnrKg6YrcrEKatCvcalPmokYE9ixVth0L3HQaVVk4DGfeAeLxbhgae9v09fOU4NZT
         6kIouS0LLjxN826g3s7T8VdVbwoZqxfadyyhiv7v3AdrSc5PSwEVjWEmE4Fvi0yGkxTF
         hSR+NVIkydiXH5YS4bdDF7DxOrRfOYvsNEz4Aa2mskeBtfvmYBlwJx/8yjwyUyqL/ATe
         Mw5plOecQ7+sHaKuenHyD/EQKYY32OunQcxEuSBVBhd0mMz9IU/3yDOL5pfe3nQD97NQ
         BWeDI334POujs6au3eDnN5+YcrLJABp31srmZ+0S9ywaDj+rbslOPw3QAmDrZE32O3+5
         GORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0C20rDbUe4v3NvAVW7h/5kiupxvjnopqvUYEwSM6Ghg=;
        b=NEeb+YbRhRKA8bcyGVL4bEJOM3iMrl5kGcBMAPaqCLGm3mkJgiVsYGfQKdPfa6GtYc
         9cn5DodwKre2octia0CSdPJbBNxvpsKWFejTxRenxof7qrEZT+PyUt8oIOqmmq2zl6yg
         szlUN0Y5YZU9rO0YrLC+hX+3+469h2oRaY+AhG2FfvfY6LnBwYIdb0+KRHVMX6PQ2y18
         t80ONzzcgpsNy2YB38WcXCEe/abP4oqJ+4U74YBq/XbyvpnT+G42uF3M7ThYV4TEdudI
         NcGvqNj7hM6oZT+cJmjAK4aCg0oZhKKe1SESOh48hfNXnt2A1PacGAFaHSo4+xr0d/mM
         yC6g==
X-Gm-Message-State: APzg51AZc41D85E7LrOWMZZLjEdSKFmrdrx/WpBuiXlMHz8E8OCnFIsT
        RSZSjCHujYMLEQ2PGNB+XqewDA==
X-Google-Smtp-Source: ANB0VdYaApNdtipPhmwcv/R42PCSayNagoDdYZSs2dm+v3jsG5BByf1FJtiklhDzqJNtyP/D9yvEsg==
X-Received: by 2002:a5d:5009:: with SMTP id e9-v6mr3978038wrt.18.1536415135034;
        Sat, 08 Sep 2018 06:58:55 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:51e2:78a:41c6:4228? ([2a01:cb1d:4ce:ea00:51e2:78a:41c6:4228])
        by smtp.gmail.com with ESMTPSA id g2-v6sm20584920wrd.71.2018.09.08.06.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 06:58:54 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Add support for Arm Framebuffer Compression(AFBC)
To:     Ayan Kumar Halder <ayan.halder@arm.com>, liviu.dudau@arm.com,
        brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
References: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
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
Message-ID: <0e22e63c-6981-9e5d-ed2d-2ad1dfbccd4f@baylibre.com>
Date:   Sat, 8 Sep 2018 15:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan,

On 10/07/2018 15:18, Ayan Kumar Halder wrote:
> In the current series of patches, we are trying to add support for AFBC
> modifiers in malidp. AFBC modifiers adds some constraints to framebuffer
> size, alignment, pitch, formats, etc. Here we are trying to add support
> for one combination of AFBC modifier ie AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
> AFBC_FORMAT_MOD_SPARSE | AFBC_FORMAT_MOD_YTR.
> In future, we intend to add support for more combination of AFBC modifiers.
> Currently, we are trying to enable a basic support of AFBC in malidp.

Thanks for pushing AFBC support, this will help supporting it on other SoCs implementing support
like Amlogic, Rockchip or Samsung.

I have one question, is there a way to generate such AFBC buffers without the Mali GPU ?
I mean, is there a way to generate some sample buffers with some of the modifier features
to validate it without having the complete Mali GPU -> DRM chain ?

Thanks in advance,
Neil

> 
> Changes from v2:
> - Added ack by Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> for patch 1. However, this has been kept in this series in order to help
> reviewers review the other patches (which are related to patch 1)
> - For patches 2 and 4, replaced DRM_ERROR() with DRM_DEBUG_KMS()
> - For patch 3, reworked malidp_de_set_plane_afbc() so as to consolidate
> all afbc specific register configuration in this.
> 
> Ayan Kumar Halder (4):
>   drm/arm/malidp: Add modifier definitions for describing Arm
>     Framebuffer Compression (AFBC).
>   drm/arm/malidp: Implemented the size validation for AFBC framebuffers
>   drm/arm/malidp: Set the AFBC register bits if the framebuffer has AFBC
>     modifier
>   drm/arm/malidp: Added support for AFBC modifiers for all layers except
>     DE_SMART
> 
>  drivers/gpu/drm/arm/malidp_drv.c    | 129 +++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/arm/malidp_hw.c     |  27 +++++---
>  drivers/gpu/drm/arm/malidp_hw.h     |   7 ++
>  drivers/gpu/drm/arm/malidp_planes.c | 129 +++++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/arm/malidp_regs.h   |  20 ++++++
>  include/uapi/drm/drm_fourcc.h       |  83 +++++++++++++++++++++++
>  6 files changed, 373 insertions(+), 22 deletions(-)
> 


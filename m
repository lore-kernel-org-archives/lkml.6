Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE01C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8923122419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D5Z84ra7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8923122419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbeKMXag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:30:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44660 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbeKMXaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:30:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id j17-v6so13303889wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nYewF1NJy29VOlAlEcBiWJOtSLrcPCQ4IvhXrvAJfFo=;
        b=D5Z84ra7cudXR72FIL9RdnuimQlp+b547+8OrCT5FgMEpyKqJuIne6jDj+GZxaEPYl
         qYGouK8yFdftZcVHR5qEM1s0jxmG5TJvHgN5sSXe4VnWFMTd8y5X/tMWJKyRF+KS73JY
         2B2o9U2bXBDc1vvf5lJb3HHNBfIii12PmSlkg7Aon26JynVPvYyn1p6bqyEAc7CKacEo
         emg6HK+vFEvZQrO0SZN2ubcj2KSQ/gqI/6kE/NEp3HpIs3hFpkohafmguqSBiUo9639p
         JnI07BP3CsJ6aCZlc4MWpNKIzSaZGOSuMeNiBTes7A45lcyU76X5f7JycHb9vGid/xky
         YnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nYewF1NJy29VOlAlEcBiWJOtSLrcPCQ4IvhXrvAJfFo=;
        b=DljId9kdVmQsdCQbDRhmo/V0spqZzFiqrKxlEk/Sa3cCZEUWLXYAk7kBNfpZ1qqLaP
         TvQn+3Wmw/nkolQIgFiX0kkOOPkAxOQwJsGwwuKZ0fAwDiXrhWysovKbsTncjpDbA2CE
         VVRcW3kMvuFzBXYu3FpoKxdd/hofJnX/jT50KlQECCZtK16Ov54Rj2b7ZRncK7Ml/cTT
         JIV29/Eawta7lry5atFdbzhrqs2MPpD0rPeBEw+hLUX3gzvNVp5JnimsatqCNBG5BCbR
         S1ZrBX7rBNtS3ciZVhKvgb+Ol35iTkkXImvkTefEaCrRw9wGcm3RuitaGeUR/82Vdybe
         61BQ==
X-Gm-Message-State: AGRZ1gI92AH9TGbWK+zCMwFHtThX0DLErDMLc185S73NsuCYJLROkvWh
        l0njqXuAUl81Nxpw2zhQVQJSe2laDfI=
X-Google-Smtp-Source: AJdET5fv1ft9oCM15zLYHnTvfmih311hfw2iXaMY97PIvYYU7mHAlNau/LIIUpqkJWVNZpH9Qo/+0g==
X-Received: by 2002:a5d:4708:: with SMTP id y8-v6mr5388321wrq.16.1542115944439;
        Tue, 13 Nov 2018 05:32:24 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d4sm6822407wrp.89.2018.11.13.05.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 05:32:23 -0800 (PST)
Subject: Re: [PATCH] drm/meson: venc: dmt mode must use encp
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Jorge Ramirez-Ortiz <jramirez@baylibre.com>, airlied@linux.ie,
        carlo@caione.org, khilman@baylibre.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1542048069-22603-1-git-send-email-jramirez@baylibre.com>
 <9f20e9d1-2e15-c087-db52-674300d7581d@baylibre.com>
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
Message-ID: <ffe5e73a-c685-0a51-5038-1ede0e249b38@baylibre.com>
Date:   Tue, 13 Nov 2018 14:32:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9f20e9d1-2e15-c087-db52-674300d7581d@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2018 09:35, Neil Armstrong wrote:
> On 12/11/2018 19:41, Jorge Ramirez-Ortiz wrote:
>> From: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
>>
>> The video mode for DMT is only populated to support encp.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
>> ---
>>  drivers/gpu/drm/meson/meson_venc.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
>> index 514245e..acbbad3 100644
>> --- a/drivers/gpu/drm/meson/meson_venc.c
>> +++ b/drivers/gpu/drm/meson/meson_venc.c
>> @@ -854,6 +854,13 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
>>  	unsigned int sof_lines;
>>  	unsigned int vsync_lines;
>>  
>> +	/* Use VENCI for 480i and 576i and double HDMI pixels */
>> +	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
>> +		hdmi_repeat = true;
>> +		use_enci = true;
>> +		venc_hdmi_latency = 1;
>> +	}
>> +
>>  	if (meson_venc_hdmi_supported_vic(vic)) {
>>  		vmode = meson_venc_hdmi_get_vic_vmode(vic);
>>  		if (!vmode) {
>> @@ -865,13 +872,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
>>  	} else {
>>  		meson_venc_hdmi_get_dmt_vmode(mode, &vmode_dmt);
>>  		vmode = &vmode_dmt;
>> -	}
>> -
>> -	/* Use VENCI for 480i and 576i and double HDMI pixels */
>> -	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
>> -		hdmi_repeat = true;
>> -		use_enci = true;
>> -		venc_hdmi_latency = 1;
>> +		use_enci = false;
>>  	}
>>  
>>  	/* Repeat VENC pixels for 480/576i/p, 720p50/60 and 1080p50/60 */
>>
> 
> Thanks !
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> I'll apply to drm-misc-fixes !
> 
> Neil
> 

Applied.

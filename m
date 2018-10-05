Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20F9C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888322064D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wkMryX8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888322064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeJEPRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:17:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51170 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJEPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:17:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so1007082wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PIJa3hWmze9zexd3iAZfzYCBSU4k96LIr0r64ZRPMBM=;
        b=wkMryX8tbeiPNhsu/Sjh/VESdCB000onNJ8IvVfozE6UwFCfP08BdKUJTz1auSAPhz
         l7f0R6atBg59gGSFttIDjkO+hibt3fhkwfJzQfyZokLBdoMJydFR5Wp3mot41rgedUer
         1IRecblVpnvwInX3tqzhHm1YOuHu0v8gjYJvmwv1o6eYlKGTR/4lk6/cWw2NmDqDwUZX
         TnnZCfxjJsChdMNIc4mzbxqieA+ewn3LEl42/7GvVF/Dsbii6Buj/kjBQ4e9WDbbN17n
         IHuFocMcfikB5s1Tl57lW6YXJo9/L/BMbSgJghRv5m1HDnttsJ1zua1dFWNEscgouKaB
         Vt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PIJa3hWmze9zexd3iAZfzYCBSU4k96LIr0r64ZRPMBM=;
        b=airsP76mzau2gCheKuPgIvHx1vkLBtAEGhhWClCxQnLglwekWdOmVPu5z2PRmQVWDQ
         JhDTmJWnYwSVo+qYZp0SSMA6QMQDqzp6VGT2eTDoAkvOaKsi5KykzglnZ6IlthfQ1Ubh
         93/fjsebfBUHAup1RZiGOPkZhR5sBV7kZBYQEo6sbhKhC0lUyW/7s2/F56BTj64gyk/9
         tndwMhIZobmoD4LWmBz4Jn1frkqRuaMCfLLdatgNgpR5zRjuPWKbIZxtGX+NfPc8Rh4R
         NG+JWM9qQVbINpU9OEJmbK6jbQDugLhVFc+6yRL6Ce2Oi2GYh90ATLBwKyX37NyesjUr
         JOOw==
X-Gm-Message-State: ABuFfoiAhrIHQgiepL7M91lkUCNyk8KU9YQ9oLjfqvlBRJDKePnnc5PM
        czbDtVYQiqVehZcrz9GJWpz3dQ==
X-Google-Smtp-Source: ACcGV61Mgrnj/cm5Z0vgcqVhbBNqqH8J+NRg9NoMocQiKuF5ngp1O5wad9/nZa5iZL4jMLlN1LGB5A==
X-Received: by 2002:a1c:1c4e:: with SMTP id c75-v6mr7554418wmc.4.1538727570650;
        Fri, 05 Oct 2018 01:19:30 -0700 (PDT)
Received: from ?IPv6:2a01:e34:eeb6:4690:b5a6:614d:8d5d:e80d? ([2a01:e34:eeb6:4690:b5a6:614d:8d5d:e80d])
        by smtp.gmail.com with ESMTPSA id z184-v6sm4158256wmz.0.2018.10.05.01.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:19:29 -0700 (PDT)
Subject: Re: [PATCH] drm/meson: fix max mode_config height/width
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
 <20181004100958.GI31561@phenom.ffwll.local>
 <0ef7fa13-ce77-f8a5-f5f3-6568be3d6145@baylibre.com>
 <CAKMK7uHxiDF3z19cMBb0o2o4Ev0DFJkhMR7Ny6U2776Ry4oc=A@mail.gmail.com>
 <8e980de4-5a52-8f3d-fba2-734617e40d1b@baylibre.com>
 <CAKMK7uE71OeOdDPb+5-cs9bByD-unYPxBV_R1t+4A0Nb4H6CAw@mail.gmail.com>
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
Message-ID: <5dbd6337-7e08-f3f7-6d4a-d6bcaddfd3be@baylibre.com>
Date:   Fri, 5 Oct 2018 10:19:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uE71OeOdDPb+5-cs9bByD-unYPxBV_R1t+4A0Nb4H6CAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 09:58, Daniel Vetter wrote:
> On Fri, Oct 5, 2018 at 9:39 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>

[...]

>> OK, won't this be enough ?
>> --- a/include/drm/drm_mode_config.h
>> +++ b/include/drm/drm_mode_config.h
>> @@ -333,6 +333,8 @@ struct drm_mode_config_funcs {
>>   * @min_height: minimum fb pixel height on this device
>>   * @max_width: maximum fb pixel width on this device
>>   * @max_height: maximum fb pixel height on this device
>> + * @max_fb_width: maximum fb buffer width if differs from max_width
>> + * @max_fb_height: maximum fb buffer height if differs from max_height
>>   * @funcs: core driver provided mode setting functions
>>   * @fb_base: base address of the framebuffer
>>   * @poll_enabled: track polling support for this device
>> @@ -508,6 +510,7 @@ struct drm_mode_config {
>>
>>         int min_width, min_height;
>>         int max_width, max_height;
>> +       int max_fb_width, max_fb_height;
>>         const struct drm_mode_config_funcs *funcs;
>>         resource_size_t fb_base;
>>
>> --- a/drivers/gpu/drm/drm_framebuffer.c
>> +++ b/drivers/gpu/drm/drm_framebuffer.c
>> @@ -283,14 +283,20 @@ drm_internal_framebuffer_create(struct drm_device *dev,
>>                 return ERR_PTR(-EINVAL);
>>         }
>>
>> -       if ((config->min_width > r->width) || (r->width > config->max_width)) {
>> +       if ((config->min_width > r->width) ||
>> +           (!config->max_fb_width && r->width > config->max_width) ||
>> +           (config->max_fb_width && r->width > config->max_fb_width)) {
>>                 DRM_DEBUG_KMS("bad framebuffer width %d, should be >= %d && <= %d\n",
>> -                         r->width, config->min_width, config->max_width);
>> +                         r->width, config->min_width, config->max_fb_width ?
>> +                         config->max_fb_width : config->max_width);
>>                 return ERR_PTR(-EINVAL);
>>         }
>> -       if ((config->min_height > r->height) || (r->height > config->max_height)) {
>> +       if ((config->min_height > r->height) ||
>> +           (!config->max_fb_height && r->height > config->max_height) ||
>> +           (config->max_fb_height && r->height > config->max_fb_height)) {
>>                 DRM_DEBUG_KMS("bad framebuffer height %d, should be >= %d && <= %d\n",
>> -                         r->height, config->min_height, config->max_height);
>> +                         r->height, config->min_height, config->max_fb_height ?
>> +                         config->max_fb_height : config->max_height);
>>                 return ERR_PTR(-EINVAL);
>>         }
>>
>> and in the driver :
>>
>> +       drm->mode_config.max_width = 4096;
>> +       drm->mode_config.max_height = 3840;
>> +       drm->mode_config.max_fb_width = 16384;
>> +       drm->mode_config.max_fb_height = 8192;
>>
>> With this I leave the mode filtering intact.
> 
> Not enough. See
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html#c.drm_connector_helper_funcs
> and scroll down to mode_valid. You need to filter modes both in the
> detect paths, and the atomic_check paths.
> 
> Detect is explicitly filtered out, but atomic_check was only
> implicitly filtered, through the max fb size checks. Ok, you could
> light up a mode that's bigger than max fb, but in practice, no
> userspace ever did that. But with your code we're missing crucial
> validation now, and userspace could fall over that. What I think we
> need is to add mode filter against mode_config.max_width/height in
> drm_atomic_helper_check_modeset(). Probably best to stuff that into
> the mode_valid() function.

Ok I understood now, thanks for pointer, I'll try to add this.

Neil

> 
> Cheers, Daniel
>>
>> Neil
>>
>>
>>> -Daniel
>>>
>>>>
>>>> Neil
>>>>
>>>>>
>>>>> Bunch of igt to make sure we're not missing anything would be sweet on
>>>>> top, e.g. e.g. trying to set a mode over the limit and making sure it
>>>>> fails.
>>>>>
>>>>> Cheers, Daniel
>>>>>
>>>>>> ---
>>>>>>  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>>>>>> index d344312..2e29968 100644
>>>>>> --- a/drivers/gpu/drm/meson/meson_drv.c
>>>>>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>>>>>> @@ -243,8 +243,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>>>>>>              goto free_drm;
>>>>>>
>>>>>>      drm_mode_config_init(drm);
>>>>>> -    drm->mode_config.max_width = 3840;
>>>>>> -    drm->mode_config.max_height = 2160;
>>>>>> +    drm->mode_config.max_width = 16384;
>>>>>> +    drm->mode_config.max_height = 8192;
>>>>>>      drm->mode_config.funcs = &meson_mode_config_funcs;
>>>>>>
>>>>>>      /* Hardware Initialization */
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>>>>>> _______________________________________________
>>>>>> dri-devel mailing list
>>>>>> dri-devel@lists.freedesktop.org
>>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>>
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>>>
>>>
>>
> 
> 


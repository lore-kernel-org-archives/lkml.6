Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4062FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E430F20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0WfhEGnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E430F20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJDV6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:58:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40619 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJDV6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:58:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so5876327wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CIwkzlgJDoSBkwmSaPuyMyKXkIyPy4AmeLcix0GUTsM=;
        b=0WfhEGnq1fsZeOTt1p0kG0X9hKLqP2sGQPn1E84YFkUCg3OaN+FKcRzvoxGypgtnld
         ThLPZcORP7ipREaRDrXP8eryq+oSGpwvqTceVpqw34t8ri+q5AvYlhxfXAJz2KWClENS
         wJdTlH0C837vyPxuTocDNv3L45qmMcruSshUt7Ov+RHFG25ugoGAZ98XEcjbhEB4xUfB
         XSKC1kwZVzmQhp9t2NBQDK7Zr0Nb+klvgKUjHL1qAQurZs4Dd6gBhzIFBMN9LkAiaxwM
         rEXKTj0aXnf5l+Gi6x2y/1YaqnbgZ8Ol3a8tbrJZ3Fg21nGrlgw0iBcLkxonR77ZSLcn
         U4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CIwkzlgJDoSBkwmSaPuyMyKXkIyPy4AmeLcix0GUTsM=;
        b=dI4DxHHgunzIg2QB2WQZhzpHN/6zFWp/XCVKxzLrLfM0vNpD29pw0xhYh06jPAcDZs
         o/TqxsP3icMgtuzuxpFVGNZwIpAJ61hj1A0TsJY71pl1bvNemrCC1nCpTnuq2zDwgOFd
         lilz/5IZXT7aVOuMLIPQAq+xFlwdT+62lo1jmVxVzfcS4BijpnnUn02OQ345LpPk+rKx
         90L3YB0bxhvDxWK86Kq3mTdn3tIA+jSfSwqAwESKcqBMS1xih8nJZREijjBHLZnTHFjq
         sppqfUxqQKZYpdB5nxQjWgKy6U2GXxeK8niEmITc9FqlRYg6M8A5ZQI94uxsPqLqDaHm
         Cl2Q==
X-Gm-Message-State: ABuFfoiBOtb46Gt8XL3BqYH8MTSVv5U/T6UcQ7gSD0h6DfLRMYELyxBB
        raHrtptDe3pU80ZGRfdAPPfkh0r0Y08=
X-Google-Smtp-Source: ACcGV63CdhhWRfpYpoVXs+K5NQcaAFcZTvutctp5KsFWtiu9QyJP8li8rWV4suR22Aoz3avvCoscew==
X-Received: by 2002:a5d:4409:: with SMTP id z9-v6mr4812673wrq.227.1538665467300;
        Thu, 04 Oct 2018 08:04:27 -0700 (PDT)
Received: from ?IPv6:2a01:e34:eeb6:4690:3412:2a4:3cc3:ee11? ([2a01:e34:eeb6:4690:3412:2a4:3cc3:ee11])
        by smtp.gmail.com with ESMTPSA id u5-v6sm6978462wru.16.2018.10.04.08.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 08:04:26 -0700 (PDT)
Subject: Re: [PATCH] drm/meson: fix max mode_config height/width
To:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
 <20181004100958.GI31561@phenom.ffwll.local>
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
Message-ID: <0ef7fa13-ce77-f8a5-f5f3-6568be3d6145@baylibre.com>
Date:   Thu, 4 Oct 2018 17:04:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004100958.GI31561@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 12:09, Daniel Vetter wrote:
> On Thu, Oct 04, 2018 at 10:42:43AM +0200, Neil Armstrong wrote:
>> The mode_config max_width/max_height determines the maximum framebuffer
>> size the pixel reader can handle. But the values were set thinking they
>> were determining the maximum screen dimensions.
>>
>> This patch changes the values to the maximum height/width the CANVAS block
>> can handle rounded to some coherent values.
>>
>> Fixes: a41e82e6c457 ("drm/meson: Add support for components")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> It's both. Grep for all the callers of ->fill_modes and you'll see that
> this limit is also used to filter max screen sizes.
> 
> If you want to change this, then I think we need a new
> mode_config.fb_max_width/height, which if non-zero, would extend the limit
> for fbs.
> 
> There's also the problem that if you extend this for fbs, then there's no
> check anymore in the atomic_commit paths (or legacy modeset), so that
> needs to be addressed somehow too.

What about adding optionals mode_config.fb_max_width/height and update
drm_internal_framebuffer_create() to use these if non-0 or fallback
to the mode_config max_width/max_height.

Neil

> 
> Bunch of igt to make sure we're not missing anything would be sweet on
> top, e.g. e.g. trying to set a mode over the limit and making sure it
> fails.
> 
> Cheers, Daniel
> 
>> ---
>>  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>> index d344312..2e29968 100644
>> --- a/drivers/gpu/drm/meson/meson_drv.c
>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>> @@ -243,8 +243,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>>  		goto free_drm;
>>  
>>  	drm_mode_config_init(drm);
>> -	drm->mode_config.max_width = 3840;
>> -	drm->mode_config.max_height = 2160;
>> +	drm->mode_config.max_width = 16384;
>> +	drm->mode_config.max_height = 8192;
>>  	drm->mode_config.funcs = &meson_mode_config_funcs;
>>  
>>  	/* Hardware Initialization */
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


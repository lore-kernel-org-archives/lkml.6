Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8657DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394FB20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dbBLeQ2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394FB20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504503AbeKWX76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:59:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55188 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394867AbeKWX75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:59:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so11942790wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OG9Fku2qd1zlm5sMMBVIgCdneVny+aDNTlvtD2rtPMM=;
        b=dbBLeQ2fVkEU9x3z25NbAt1n5UuKyYgFBPZOlj2gBgVneYEeEBt99BgVuAvGSmYYye
         OUzH4SWJijf+PCtCcubJonKTXeKzJge3/WxgQrs3UjwQQdlztWcai9tBxdj1P5GgSuNg
         gzdexT2HigrnGgODLAoHbnsvr0UbDIxXdiaTEk4cj836M6MCFhSe4Hx35AfJDqLhXqM0
         Kr1j1Z6tB3i+yyPikvtUwq1Ova7WR+SqJrwMAVzx7C4ETpOyUYN86sw3tj7Zrp5HbSLG
         yGTkkgZ6Q5rvARq6PWTa2YCYlqPvQa7B+jIMTa9kEIbe8Fzrz8SZmBdcnNZknqey+S1F
         9nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OG9Fku2qd1zlm5sMMBVIgCdneVny+aDNTlvtD2rtPMM=;
        b=ingvLkyHS5U1DeUIFf5EhcU8xmcMHVXh5FPAKvcKmQ8FayUc9PgRZZpxVdxFXNke5o
         gzI54I6NAul9zjpcEtNeD2S48NkUJerf0kefh//XESEKyJkQSC557okfJ1T3NAaePbQi
         BcxKL2pG5265Zm+9QNGgjoi8X4XpA/i2j10gNn/l1laOkhsj+s1UtOc7CvpbWwWHG2oi
         Mi7exmFESDSDMNSZKcwc9wkl3gLD981Hb5KU9aAC+r8QrHvDgUFDI97qyXOboi702Pga
         rtFsYaYLEZJUMdnQ5tbr16tlf8p3zL7M05PIoRoXLoCS/RMJ1h9u+iAq2bxkoxauRCk6
         WP0A==
X-Gm-Message-State: AA+aEWZDMrzmcYjIx2VBOLUTrxGXyKoislNczepKukU43ht806YUHaEb
        za7vCbrFwQcgpsMjlhIy8xoMDGR9Aqp6PQ==
X-Google-Smtp-Source: AJdET5erRRo3wa67EnjomqNzJkYWhQwccYkKOlhLpF1t0AiTxaP8seOpP6dXAt0+g0AKk977fWUGgQ==
X-Received: by 2002:a1c:4a:: with SMTP id 71-v6mr13643931wma.140.1542978946178;
        Fri, 23 Nov 2018 05:15:46 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v1sm11004430wrw.90.2018.11.23.05.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 05:15:45 -0800 (PST)
Subject: Re: [PATCH] drm/meson: add support for 1080p25 mode
To:     Michal Lazo <michal.lazo@mdragon.org>
Cc:     christianshewitt@gmail.com, airlied@linux.ie, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        carlo@caione.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1542793169-13008-1-git-send-email-christianshewitt@gmail.com>
 <2a9d9fa9-c9ba-c624-28da-dd3804faf438@baylibre.com>
 <CAFW1BFzC0wzwmjvpSqb90ipY4mzdWPMc3buXjkwvi4X5e8wGJg@mail.gmail.com>
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
Message-ID: <ea9d3fd1-068f-7bec-4166-9399d0aea02f@baylibre.com>
Date:   Fri, 23 Nov 2018 14:15:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFW1BFzC0wzwmjvpSqb90ipY4mzdWPMc3buXjkwvi4X5e8wGJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 23/11/2018 13:57, Michal Lazo wrote:
> I would suggest same aproach as for
> "meson_hdmi_encp_mode_1080p30"
> and "meson_hdmi_encp_mode_1080p60"
> 
> so duplicate "meson_hdmi_encp_mode_1080p50"
> with name "meson_hdmi_encp_mode_1080p25"

The configs are litterally the same for 1080p25 and 1080p60 unlike 1080p30/1080p60,
so I don't see the point about duplicating a same table for the sake of naming.

We will the exact same thing to support the 2160p50/2160p60 modes by reusing the
same config are 2160p25/2160p50, and I don't see the point of duplication the
tables here aswell.

Neil

> 
> now the code looks really like common copy paste problem
> Michal Lazo
> On Wed, Nov 21, 2018 at 10:47 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On 21/11/2018 10:39, Christian Hewitt wrote:
>>> This essential mode for PAL users is missing, so add it.
>>>
>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>> ---
>>>  drivers/gpu/drm/meson/meson_venc.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
>>> index acbbad3..ab16046 100644
>>> --- a/drivers/gpu/drm/meson/meson_venc.c
>>> +++ b/drivers/gpu/drm/meson/meson_venc.c
>>> @@ -714,6 +714,7 @@ struct meson_hdmi_venc_vic_mode {
>>>       { 5, &meson_hdmi_encp_mode_1080i60 },
>>>       { 20, &meson_hdmi_encp_mode_1080i50 },
>>>       { 32, &meson_hdmi_encp_mode_1080p24 },
>>> +     { 33, &meson_hdmi_encp_mode_1080p50 },
>>>       { 34, &meson_hdmi_encp_mode_1080p30 },
>>>       { 31, &meson_hdmi_encp_mode_1080p50 },
>>>       { 16, &meson_hdmi_encp_mode_1080p60 },
>>>
>>
>> Exact, I forgot this mode...
>>
>> Thanks for the change !
>>
>> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> I'll add :
>> Fixes: 335e3713afb87 ("drm/meson: Add support for HDMI venc modes and settings")
>> when applying to drm-misc-fixes.
>>
>> Neil
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> 
> 


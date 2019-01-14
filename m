Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB75C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7076F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nxhGnXIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfANPeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:34:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55825 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfANPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:34:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so9299845wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7CpENgUYFuaKkwmwSVJ/+AjrvPwUExByKZFzFxjT7kI=;
        b=nxhGnXICfpq9zz6mE65kV48XNAq8yJYi1WQ53qLZmbYXfHVeMROBuYcoN1PiErCvEK
         zZJ7igpCtcAlqlyT845dHrZFWGKKub5mh3a7WkjcPAhHLwabIjnNWSDim2IS+XZ6xTih
         qMIVR5ecf9sbFD/SWe3thf4r/lV9KUKZ6Xhk4zduX0ecBVWAtzEdQwYZFTQOpn4vD2aM
         pQTEx1izH11+yo5sW4HV4QtArpI43XZOo5Vlg/rDeZzELmdkTQE6k/00IfooEK/wcnez
         F4CISryCl3FVh5y1/EXUAKKsln9gcCiNBwceXQXw0ga1uNmKajb0XOt6008ZSlu/j6SA
         qd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7CpENgUYFuaKkwmwSVJ/+AjrvPwUExByKZFzFxjT7kI=;
        b=dupjDQFghO29C2eAZj+1flK5uuPoQx2igtvlm8wP2fM4JCN1f+WSymZNxN25bLnRJU
         q3ISjhQbn1XTx0rXQrbGOtq88fSwqri8KhWLcrHpVZTpM5C9a2CGXngHZsDalR99I8St
         9ovO2dcp0KAfCbMwd6oRspUAholEIbfFAOxFNCk1DE3/MRJGXKz8KokuJlAS4QlPWKg4
         3C9lcFfgQQuAoM385BYAarP/epxBnNUdgtCfxzQ9O5lIU9gbL8jT0fWm+ICSGKzf8zCd
         jkn1m6FLQLLyHIvN57tW/H+95wgWZh8VQ8+Vdre7/B9nICR1YnUwNwsEny7k5DbJVj8Y
         Ohew==
X-Gm-Message-State: AJcUukeRCSGVAAFZv145tGNih7GOoL4wgc9Yp483R9IawJS4zijrxodD
        N4/9McSF9I0xtWOC+oHBzkisyA==
X-Google-Smtp-Source: ALg8bN4pPQqyKVszuoPcZDhe9Kfxso9uzbz6Ls2znnZniKErRx0tlvkDqxvSuBFaVfWsyNrAz5TYpQ==
X-Received: by 2002:a1c:bb04:: with SMTP id l4mr12408307wmf.142.1547480058333;
        Mon, 14 Jan 2019 07:34:18 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 124sm31308374wmh.22.2019.01.14.07.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 07:34:17 -0800 (PST)
Subject: Re: [PATCH RESEND] drm/meson: remove firmware framebuffers
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20181210092853.13050-1-mjourdan@baylibre.com>
 <c5138091-d801-8b2a-85ab-d815f0508933@baylibre.com>
 <CAMO6nay4+8Y_O2iTWJ041Bt0+3VUuOQj0WEN3Pyf6L80vuxHTA@mail.gmail.com>
 <19df7254-3fec-fb60-7581-54cf22e10509@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <f510a201-ef9b-9107-3f2b-038e6a69f001@baylibre.com>
Date:   Mon, 14 Jan 2019 16:34:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <19df7254-3fec-fb60-7581-54cf22e10509@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2018 13:39, Neil Armstrong wrote:
> On 12/12/2018 13:22, Maxime Jourdan wrote:
>> Hi Neil,
>> On Wed, Dec 12, 2018 at 10:55 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>
>>> Hi Maxime,
>>>
>>> On 10/12/2018 10:28, Maxime Jourdan wrote:
>>>> In case we are using simplefb or another conflicting framebuffer, make
>>>> the call to drm_fb_helper_remove_conflicting_framebuffers()
>>>>
>>>> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
>>>> ---
>>>>  drivers/gpu/drm/meson/meson_drv.c | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>>>> index d3443125e661..afbb3d707d15 100644
>>>> --- a/drivers/gpu/drm/meson/meson_drv.c
>>>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>>>> @@ -159,6 +159,23 @@ static void meson_vpu_init(struct meson_drm *priv)
>>>>       writel_relaxed(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
>>>>  }
>>>>
>>>> +static void meson_remove_framebuffers(void)
>>>> +{
>>>> +     struct apertures_struct *ap;
>>>> +
>>>> +     ap = alloc_apertures(1);
>>>> +     if (!ap)
>>>> +             return;
>>>> +
>>>> +     /* The framebuffer can be located anywhere in RAM */
>>>> +     ap->ranges[0].base = 0;
>>>> +     ap->ranges[0].size = ~0;
>>>> +
>>>> +     drm_fb_helper_remove_conflicting_framebuffers(ap, "meson-drm-fb",
>>>> +                                                   false);
>>>
>>> I always wondered, where does the "meson-drm-fb" comes from ???
>>>
>>> Neil
>>>
>>
>> This name ultimately ends up in a printk and has no functional impact.
>> See drivers/video/fbdev/core/fbmem.c:1613 :
>>
>> printk(KERN_INFO "fb%d: switching to %s from %s\n", i, name,
>> registered_fb[i]->fix.id);
>>
>> I just picked one that was similar to the names of other drm drivers
>> calling drm_fb_helper_remove_conflicting_framebuffers().
> 
> Ok Cool !
> 
>>
>> Maxime
>>
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> I'll push it when the bindings are acked and when v4.21-rc1 is tagged !
> 
> Neil
> 

Applied to drm-misc-next.

Thanks,
Neil

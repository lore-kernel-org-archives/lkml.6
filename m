Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0D8ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC852150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2iPxHuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC852150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeITVs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:48:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33793 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeITVs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:48:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so8913198ljk.1;
        Thu, 20 Sep 2018 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JDP9a70oXwAQU2VOz2AwH0KOP5KlMsPZLdmFF2Cz+3w=;
        b=Z2iPxHuWUbjmR/CzJ6utqFKitkD6Sm1LTA1599TirPJAbue9GdddZZuay0JY91sQ/c
         HFXm+ok2esmM8QPy+AuCASByKe2E5gFb3RUx+TzEWESDvT6WQ5c1vFOhscf0BsMgmG6q
         /oJw0EEJMrc/hA2SBw9RnKdrDOofuZtLn70fZjC38FP+kehJGvt0/E5Js65iAbZbItF2
         cacG9b2WxGvFlVAjfXnt6x6E4/oqVaEjLUjj/W9QKEDvAkeDkD3VSAN/odF58wW2vlzm
         BGkGCdOPXSnHK36IbwOexIVkavAkggl09BhuqurS7ZDxtwk2ve9vo0/5zeIdu4ESENrW
         EISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JDP9a70oXwAQU2VOz2AwH0KOP5KlMsPZLdmFF2Cz+3w=;
        b=pdwc/ttR8fM6BC70juwpDOkwD4c9tgKTzkz50CoQxJvMx3Sk6fl49w7IaHlEVsA3QG
         1sAEOQXh5pZLCfWvD1NM7YfVsvEpUwA8F4MEZkGVG4ehBBZtgQtTFGzwmivSVKoEq22x
         dMDtIJDCQ0BeE5376CCAmRi+CRh5eX++oCxj/1y7qGL4EKPg1Z8oIKZTb9xDICyTnEQc
         ZhaRe5Yfn8QPrKPUsTi5FpZOTjF9mSQXGsQlYnZ/iR34ijdBm09Oes1Xqav0CD3FL9Cu
         qq4rNBcoSjQ7wHnqyES36evkxp3oUNhuw/K59GJVdaZy/tLe4gsw8DPzWAvlyWNcBmjE
         riVQ==
X-Gm-Message-State: APzg51AXlIPB5JIceG54iPZGdAoJhYbiOWxo/+N+Zr7a2QwZ9eFcmxXc
        grXAG+sWGimVNq7FoKmnUri173JA
X-Google-Smtp-Source: ANB0VdauMkan/JktwH5TUsvecVmZeC5WVS8aSlooZ2Hn69f77oRUWa94HBx2ecmMDjjVGJR41lP1rw==
X-Received: by 2002:a2e:2b4c:: with SMTP id q73-v6mr2496673lje.128.1537459485229;
        Thu, 20 Sep 2018 09:04:45 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id x5-v6sm1744630lfi.45.2018.09.20.09.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:04:44 -0700 (PDT)
Subject: Re: [RFC PATCH v4 1/2] drm: Add generic colorkey properties for
 display planes
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180807172202.1961-1-digetx@gmail.com>
 <20180807172202.1961-2-digetx@gmail.com>
 <20180808081608.GK30658@n2100.armlinux.org.uk> <2089566.PDTrKWWE8Q@dimapc>
 <cbf46404-051b-312e-0201-7956229abd20@linux.intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f31ce849-7f1e-99d7-191e-112798f1ffb5@gmail.com>
Date:   Thu, 20 Sep 2018 19:04:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cbf46404-051b-312e-0201-7956229abd20@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/18 2:42 PM, Maarten Lankhorst wrote:
> Op 08-08-18 om 16:30 schreef Dmitry Osipenko:
>> On Wednesday, 8 August 2018 11:16:09 MSK Russell King - ARM Linux wrote:
>>> On Tue, Aug 07, 2018 at 08:22:01PM +0300, Dmitry Osipenko wrote:
>>>> + * Glossary:
>>>> + *
>>>> + * Destination plane:
>>>> + *	Plane to which color keying properties are applied, this planes takes
>>>> + *	the effect of color keying operation. The effect is determined by a
>>>> + *	given color keying mode.
>>>> + *
>>>> + * Source plane:
>>>> + *	Pixels of this plane are the source for color key matching operation.
>>> ...
>>>
>>>> +	/**
>>>> +	 * @DRM_PLANE_COLORKEY_MODE_TRANSPARENT:
>>>> +	 *
>>>> +	 * Destination plane pixels are completely transparent in areas
>>>> +	 * where pixels of a source plane are matching a given color key
>>>> +	 * range, in other cases pixels of a destination plane are
>> unaffected.
>>>> +	 * In areas where two or more source planes overlap, the topmost
>>>> +	 * plane takes precedence.
>>>> +	 */
>>> This seems confusing to me.
>>>
>>> What you seem to be saying is that the "destination" plane would be the
>>> one which is (eg0 the graphic plane, and the "source" plane would be the
>>> the plane containing (eg) the video.  You seem to be saying that the
>>> colorkey matches the video and determines whether the pixels in the
>>> graphic plane are opaque or transparent.
>> Your example is correct.
>>
>> With the "plane_mask" property we can specify any plane as the "source" for
>> color key, so it can been either a video plane or graphic plane and even both
>> at the same time.
> I'm not sure we should specify plane mask from userspace.

It looks like a quite flexible approach. Do you have any other suggestions?

> Can't we make major loops? How do you want to handle those?

It's up to a specific driver to accept the mask or reject it. You could make a 
loop if HW allows to do that, I don't see what's the problem.

>>> Surely that is the wrong way round - in video overlay, you want to
>>> colorkey match the contents of the graphic plane to determine which
>>> pixels from the video plane to overlay.
>> The "transparent" mode makes the color-matched pixels to become transparent,
>> you want the inversion effect and hence that should be called something like a
>> "transparent-inverted" mode. Maarten Lankhorst was asking for that mode in his
>> comment to v3, I'm leaving for somebody else to add that mode later since
>> there is no real use for it on Tegra right now.
> I would like it to be described and included, so I can convert the existing intel_sprite_set_colorkey_ioctl to atomic.

Okay, I can add it. Though probably better to call that mode "opaque" rather 
than "transparent-inverted".

> Then again, could transparent-inverted also be handled by setting transparent on the primary?

If HW allows to do that, then yes.

> 
>> So in your case the graphic plane will be the "source" plane (specified via
>> the colorkey.plane_mask property), video plane will be the "destination" plane
>> (plane to which the colorkey properties are applied) and the colorkey.mode
>> will be "transparent-inverted". Pixels of the "source" plane are being matched
>> and "destination" plane takes the effect of color keying operation, i.e. the
>> color-matched pixels of graphic plane leave the video plane pixels unaffected
>> and the unmatched pixels make the video plane pixels transparent.
>>
>>> If it's the other way around (source is the graphic, destination is the
>>> video) it makes less sense to use the "source" and "destination" terms,
>>> I can't see how you could describe a plane that is being overlaid on
>>> top of another plane as a "destination".
>> Tegra has a bit annoying limitations in regard to a reduced plane blending
>> functionality when color keying is enabled. I found that the best variant to
>> work around the limitations is to move the graphic plane on top of the video
>> plane and to make the graphic plane to match itself. I.e. the matched pixels
>> of graphic plane become transparent and hence poked by video plane.
>>
>>> I guess the terminology has come from a thought about using a GPU to
>>> physically do the colorkeying when combining two planes - if the GPU
>>> were to write to the "destination" plane, then this would be the wrong
>>> way around.  For starters, taking the above example, the video plane
>>> may well be smaller than the graphic plane.  If it's the other way
>>> around, that has other problems, like destroying the colorkey in the
>>> graphic plane when writing the video plane's contents to it.
>> It all depends on a use-case scenario. It won't be easy for userspace to
>> generalize the usage of color keying, at best the color keying interface could
>> be generalized and then userspace may choose the best fitting variant based on
>> available HW capabilities.
> There's TEST_ONLY for a reason, though I guess it makes generic color keying slightly more invovled for userspace. :)

It is also quite involved for kernel to present a non-standard feature as 
something generic, pleasing everyone in the same time.

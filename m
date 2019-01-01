Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE18CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BE9218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9lwT1Ih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfAAO0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:26:50 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:37056 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfAAO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:26:50 -0500
Received: by mail-lj1-f176.google.com with SMTP id t18-v6so25182669ljd.4;
        Tue, 01 Jan 2019 06:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xI5gkJCBeuNkn9fAUMrO8rB+1hxa51VIPdfDASle4nM=;
        b=g9lwT1Ih8mH8QpiJv0VKg6fjcJ+BUSbkaGZ9+ziYvz6VjnK9te4yntKsoESbSpZzCD
         WAtDEB5Ze5vClp/rJJBAEm6DKLsGImEidjwGMUwNt9dLZTs18CUT6oLFhSxs3OTKpgTs
         txclfJR0q+pSjKJTDpf2DEFYrk0AbqDnDXl6+FLE9wVItrY+/FkB+DkhXclYYvZeqhZG
         chnCei9LFozoLBEEapgUGml0mFx2RbgJNg/3EksQbOvyBoFzZRdBgAutt2uGGmL0TG2x
         H1aHHZsU+B4TPJtFp8ee25COxkHFtKJMudd2NfPQm95N9sQwyrStZv60Wrr0frs3KcWA
         vRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xI5gkJCBeuNkn9fAUMrO8rB+1hxa51VIPdfDASle4nM=;
        b=oyz/nvW2sMaGv8CDHfQciIaL9tx3/82ThisTPexjXl0X5XeqZCF8jMSpzlt0/VJ1mY
         Aizx7rKSESgg4fPRqT3rer7HEVQVBGeZoy5cop5JqPvXxoMExo086mA4mKr2XCrNajQv
         r1ikTUBTLSpQKLQBvWmvZjg8eAiC4eYDf2S3sshYxbptnGtvLrWWyGmRE156pzrSCH27
         4p2Ul514TtK59/1VQebjaFThl7Npejj9vi826lr6d4FMXLT06tOSY3D7Ybv0wbaWZ96t
         C/TU+5lzH/P6aYB6Xvni5V3Itlq/LSax9P2d/zatrzR87FRd1pFNw8bXz2yNvFykRYVN
         0Yhg==
X-Gm-Message-State: AJcUukdacPV0CRGSpJ9jC/yIMA53Uzdo7D6zpA35X2nZfSpk5AhBAIlq
        yUFEgQ72aIoqKlUmRT6kUmHkX1ZF
X-Google-Smtp-Source: ALg8bN5DgyJBKxuEjPRAw1gVYL9i+JE6ioRbIlYNr8BP0k1hMQ/NcTxBB6yruLYdnXvjqyX4AXw4GQ==
X-Received: by 2002:a2e:8156:: with SMTP id t22-v6mr2450273ljg.32.1546352807122;
        Tue, 01 Jan 2019 06:26:47 -0800 (PST)
Received: from [192.168.1.18] (dnq182.neoplus.adsl.tpnet.pl. [83.24.98.182])
        by smtp.gmail.com with ESMTPSA id r29-v6sm10550854ljd.44.2019.01.01.06.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 06:26:46 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <71d3ac12-5beb-0a26-71e1-5eae798e7b9f@gmail.com>
 <2bca210b-76ad-d5a9-906c-4151695050c3@gmail.com>
 <45ce01f0-af6e-1cc6-5126-fb557c7d2a82@ti.com>
 <b7c69135-1641-48cb-1770-c4c77a989efe@gmail.com> <20181229190726.GA29851@amd>
 <4b5a89ed-0c0b-3103-ca57-a0f97aa5ace9@gmail.com> <20181230173505.GA19593@amd>
 <7763a3ae-343c-0fbe-da88-afce8459e4c2@gmail.com> <20181231162828.GA8846@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <16b9d4ce-d99c-fd86-139c-6e7b5cfecf55@gmail.com>
Date:   Tue, 1 Jan 2019 15:26:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181231162828.GA8846@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 12/31/18 5:28 PM, Pavel Machek wrote:
> Hi!
> 
>>>>>> There is still HSV approach [0] in store. One problem with proposed
>>>>>> implementation is fixed algorithm of RGB <-> HSV color space conversion.
>>>>>> Maybe allowing for some board specific adjustments in DT would add
>>>>>> more flexibility.
>>>>>>
>>>>>> [0] https://lkml.org/lkml/2017/8/31/255
>>>>>
>>>>> Yes we could do HSV. Problem is that that we do not really have RGB
>>>>> available. We do have integers for red, green and blue, but they do
>>>>> not correspond to RGB colorspace.
>>>>
>>>> OK, so conversion from HSV to RGB would only increase the aberration.
>>>> So, let's stick to RGB - we've got to have some stable ground and this
>>>> is something that the hardware at least pretends to be compliant
>>>> with.
>>>
>>> I'm not saying that we should stick to RGB. I'm just saying that
>>> problem is complex.
>>>
>>> And no, hardware does not even pretend to be compliant with RGB color
>>> model ( https://en.wikipedia.org/wiki/RGB_color_model ). In
>>> particular, in RGB there is non-linear brightness curve.
>>
>> Quotation from the wiki page you referred to:
>>
>> "RGB is a device-dependent color model: different devices detect or
>> reproduce a given RGB value differently, since the color elements (such
>> as phosphors or dyes) and their response to the individual R, G, and B
>> levels vary from manufacturer to manufacturer, or even in the same
>> device over time. Thus an RGB value does not define the same color
>> across devices without some kind of color management"
>>
>> This claim alone leaves much room for the manufacturers to pretend that
>> their devices are compliant with RGB model.
> 
> Much room, but everyone agrees that R=G=B=255 should be some kind of
> white, and what other colors "approximately" mean.
> 
> I have two monitors, and no, colors don't match.
> 
> Do you have access to RGB led? Try to compare two monitors, and then
> RGB led with monitor. RGB led will be _way_ off.
> 
> This chart makes sense:
> 
> https://www.rapidtables.com/web/color/RGB_Color.html
> 
> Try it on your LED device...
> 
>>> I believe problem to start with is the "white" problem. Setting
>>> R=G=B=255 will _not_ result in anything close to white light on
>>> hardware I have.
>>
>> RGBW LED controllers solve this problem. For the devices without
>> white/amber we cannot do more than the hardware allows for.
> 
> But the hardware can do some kind of white. It is just that R=G=B=255
> will result in green-ish-blue and something like R=255, G=50, B=10 is
> neccessary to get approximation of white.
> 
> IMO good start would be to specify what kind of intensities are
> neccessary to approximate white. And then try converting from RGB to
> led intensities, and see if it somehow works.

I don't have access to RGB LED, and unfortunately have lack of time
currently to play with it even if I had one.

In order to gain a full understanding of your idea of RGB to LED
intensity conversion, we'd need to see the full algorithm.

It feels like imposing some restrictions on user regarding
the available scope of colors to set.

-- 
Best regards,
Jacek Anaszewski

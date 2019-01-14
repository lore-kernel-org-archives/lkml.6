Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4E1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC54B20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujes8CpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfANU2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:28:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45842 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfANU2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:28:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so366522wrr.12;
        Mon, 14 Jan 2019 12:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VtmmDuekwI7K/YgcGDz9rGD92Y7roKt/1abkMXehVJM=;
        b=ujes8CpPu2R3yuM0haOybJkh9zWdy3o2cJHh+8feCEPOo3FpNiBfw3kzY8UcMnpBmb
         GQ2TzVKOMqG6lncQ9rhtkt6TQOIGJWCUYD825kCeOCyITvAYdYWH7wWAYNlUeEZNakzW
         hnUtlIbFXQUpj2m97UtIBJXpVJjPPOeQoA1GjuXQF5TKkQhyPhzE+Dbpkf8S2GLdNqGw
         /RGFIDMLLXZ0PX0bpjw1+h0/pnRL2qodAmEi816K1DYnT1CRZaS9moNWB/UQd0uBZB1K
         ksuWorGo8LxdGRRPhx7oM8sHfXVfQ4fOJpF5rJ+rUQ8f4VS8v4p8X9mrFmaku2Rk6oNj
         WlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VtmmDuekwI7K/YgcGDz9rGD92Y7roKt/1abkMXehVJM=;
        b=HcS746JuXYVbTaVlFHF70PICxNCX9IS6MWrYD58n0eBmXeWWcjT/oi6OuRBZEE67db
         0mYc87t7CQx1NfUl66EhVk/rC+kzcbOQw3L2pNq0zUDapmSssxvvgKMDUPp13JpOEJw/
         d2P7+4DgyPuiACojW/+4KyhhDisBu/CVei79IZItp7w7Ut1O+NJWJEh8lFfKr25dDG3y
         qQc8JhGKpxULsLi8mFpEozIAMAR+4rfZLvx+A5m+r2q6tT+oesVGhl2Xygf85Pj0gheb
         NUW/z+EM5aLvNnWuI4kkIZPrxBe1aTUSLBPHxh4PWUUtERBuR2qo3DX+uWdsGp8dNeqy
         efaQ==
X-Gm-Message-State: AJcUukeyrmAcMuY3a9jBDSiTOMwce2MhPOEzb+vLrX/HD1tNPSJLDiGZ
        1MEkUFaHCjwOus0jK1WNO9wKHMpi
X-Google-Smtp-Source: ALg8bN7UpdqbDHVG3TJvWlffv9Ep7eIO0KmnoOykaFAWYI+MLNCyRd69Uc+wbE+c++SZq60XuAFf5w==
X-Received: by 2002:adf:bc02:: with SMTP id s2mr164162wrg.255.1547497686392;
        Mon, 14 Jan 2019 12:28:06 -0800 (PST)
Received: from [192.168.1.18] (dnr9.neoplus.adsl.tpnet.pl. [83.24.99.9])
        by smtp.gmail.com with ESMTPSA id s66sm23029494wmf.34.2019.01.14.12.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 12:28:05 -0800 (PST)
Subject: Re: [PATCH 1/2] dt: bindings: lp5024: Introduce the lp5024 and lp5018
 RGB driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20181219162626.12297-1-dmurphy@ti.com>
 <2d2d5dcd-9c23-e901-daac-9b79aa5a5e82@ti.com>
 <6c62956e-7789-58ba-5437-f2e033f2825c@gmail.com>
 <366cbf6d-94fa-fea9-be58-07ddb09cff3a@ti.com>
 <df59c10d-7038-cb4a-45f0-7420254c6398@gmail.com>
 <ec0393b7-118e-1f3b-d5af-86ecdf66412a@ti.com>
 <ae700129-7b59-c92b-0c0a-b57a6f230ff7@gmail.com>
 <adcd7987-f7fc-ae1f-9aa4-cebcbf01ad58@ti.com>
 <1702dfd6-b08f-c1ff-e46d-1366618bedb0@gmail.com>
 <72112839-11d4-54be-df94-b2322f77cb0f@ti.com>
 <8b126077-c200-ed34-03b7-6d43a22fb0c9@gmail.com>
 <92cc81dc-7280-8bf0-9536-9c4d990eaf3b@ti.com>
 <459a4d7a-980b-5a46-9bd8-7a7afb37e1c3@gmail.com>
 <76577ad1-8c29-c5f6-e253-a8541a150dc0@ti.com>
 <3674d644-ccf6-d545-fc41-6bdf8960df44@gmail.com>
 <0140ad64-432e-7723-2415-0b3a8ac4d8dc@ti.com>
 <ed78b2fd-7ab8-d7c3-cf28-4d5b06783fb3@gmail.com>
 <1c452daa-d77e-5d31-3694-b9dfda9cc8f3@ti.com>
 <9c129b00-39e6-dd29-c2a7-0506a1780fb8@gmail.com>
 <17752128-5a08-4122-9502-47f2fca9a8bb@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <5204698e-bd20-9989-9c85-09db7984ed28@gmail.com>
Date:   Mon, 14 Jan 2019 21:28:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <17752128-5a08-4122-9502-47f2fca9a8bb@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 1/14/19 9:14 PM, Dan Murphy wrote:
[...]
>>>>> One last question I am going to add the LP5036 and 30 which have the same technology but slightly different register maps.
>>>>> Should I rename the driver to LP5036.c as the 30, 24 and 18 would technically be subsets?
>>>>
>>>> How about leds-lp50xx.c ? You can also create a library like
>>>> drivers/leds/leds-lp55xx-common.c if that would simplify the code.
>>>>
>>>
>>> A library would be overkill.
>>> Is it just the DT that we don't want to use wild cards in naming?
>>
>> DT is for concrete board and cpu, so it doesn't make sense to
>> use wildcards in *.dts file names.
>>
>>> leds-lp50xx.c is a fine name to me.
>>
>> Apart of that, I've been also mulling over if we shouldn't go for single
>> "color" sysfs file for setting r,g,b components at one go.
>> I don't see any downsides. There is no risk that number of elements will
>> grow, and the benefit will be an atomic way of setting color - the
>> feature people are looking for. Vesa was mentioning the case where lack
>> of it had been a real problem [0].
>>
> 
> Well thats what I did and have it working.  I was going to submit v2 today after I write the documentation.
> 
> I basically exposed a "hue" file that takes in a 24 bit R,G,B value and sets the registers accordingly.
> 
> I figured hue would be good as that may be the same ABI we have when the RGB framework comes in.
> 
> The change over would be transparent to the past users.

I'd prefer "color" over "hue". The latter implies HSV color space, which
was the first thing that came to my mind when reading your message.

-- 
Best regards,
Jacek Anaszewski

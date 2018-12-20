Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB14520989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdQbSjr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbeLTMk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:40:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38421 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbeLTMk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:40:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so1416398lja.5;
        Thu, 20 Dec 2018 04:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OAbIzZ1QLXITn9zJ/+VdE14YTPS6lrAtkbqngHncBiM=;
        b=SdQbSjr+hVQuIN7WEhOMmn7G2BjQSEAvvczWjelzMXxEINQjSqMnvY9IpG8y91gExQ
         KB5mbo5OcTlPzuKN7X64AjtuRXCv9wsHDLJDf2pIhyRfmT8ETR116SRWSR2ApSVe/iWZ
         TqyKdOrMpuqTyyEuTQ5pVqGmPh9DD/yfufjKS5WcXkALwhxsXXjufZnXakHVQaPz7aSZ
         IRbqQe2Z7jSRDlw7kTUy+33tvG3VueEJYEXZCN4VQ1ZzO/WhwLYH23X4qZEfAtMk8CTd
         8xFnnmkM90yLvnn/MxZPJQF4z9b2+8h6Qc3zPAV7FDmnPOK4lGUBaJI348h2EF/9cz1T
         jFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OAbIzZ1QLXITn9zJ/+VdE14YTPS6lrAtkbqngHncBiM=;
        b=nGd3AyEHYEgMDIYAaeyuWfcz5DjBN8M5WzrL75vzYWU2GBbbGim4/Z1ImpZ/fN8XJZ
         I3SLoy3F3Hzn1/MCzGEBACOYY3tnzxlgH7/Fudk66QI11HHhMhIP22NCvtQmKcpy491A
         LsStCx5vYvjaAWOmRqBxXgBu/1wl3N7qIZA/CPiffUG0VRFYIA4vYACssOkTyARtz4XC
         IT05QcaJUl6G/yawhxBXMsyCt90Z5nLdQBHy64bTDLmT7NVzpE7Bqw0AbtzIExmm7W+x
         lGyKPM8uuzFPs9YHXElBJRiqDeY/TRM/A86KwQB/lSDIORTiKUlV9SPLNDt1AL/JG1GO
         tOnw==
X-Gm-Message-State: AA+aEWbek2OwykyaM57zz4JPh/l7t71nml7OxYxJZO+LbxOX4Bok/CAV
        qmf1X7f17qpdU+COe1MD+8VSc3qCLos=
X-Google-Smtp-Source: AFSGD/UEwlZfTAyNPcZTJeM1AUblTOxNCuEAseEmfvVMJY7DJlmWqRU9632xSCl/HxHiqFlNJKEPVw==
X-Received: by 2002:a2e:3803:: with SMTP id f3-v6mr15166660lja.169.1545309653919;
        Thu, 20 Dec 2018 04:40:53 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:200b:ab20:c3cf:58fb? (dtynxhybybr1wbt0snd9t-3.rev.dnainternet.fi. [2001:14ba:8017:3300:200b:ab20:c3cf:58fb])
        by smtp.googlemail.com with ESMTPSA id p89-v6sm1532019ljp.60.2018.12.20.04.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:40:52 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com> <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com> <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
Date:   Thu, 20 Dec 2018 14:40:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 19/12/2018 23.50, Dan Murphy wrote:
> On 12/19/2018 03:36 PM, Jacek Anaszewski wrote:
>> Hi Dan and Pavel,
>> Some time ago we had discussion with Vesa Jääskeläinen about possible
>> approaches to RGB LEDs [0]. What seemed to be the most suitable
>> variation of the discussed out-of-tree approach was the "color" property
>> and array of color triplets defined in Device Tree per each color.
>>
> 
> Why does Device tree define the color?
> 
> Rob indicated that Device tree is supposed to define the hardware.
> This thread seems to be defining the operation.
> 
> Shouldn't the color be done via user space and not dt?
> 
> Especially if they want to change the color real time?
> 
> Dan
> 
>> Please refer to [0] for the details.
>>
>> [0] https://lkml.org/lkml/2018/11/9/938
>>

Idea was to define preset colors in device tree as an example when you 
are dealing with multi-color LEDs without PWM. In that case you only 
have GPIOs to control and then have a problem what does those GPIO's mean.

With preset definitions one can use color names to act as a shortcut to 
configure GPIO's to proper state for that particular color.

For more flexible setups where you have PWM or such control you have 
larger space of available colors. In this case you need to somehow 
define also meaning of those controls.

Also we may not have LED with only red, green and blue elements. There 
might in example be amber, ultraviolet, white elements.

This is where device tree is concerned. It helps us craft the logical 
definition for LED so that we can control it from user space in common way.

Now the next problem then is how does user space work then.

For multi-color LEDs it it important to change the color atomically so 
that no wrong colors are being shown as user space got interrupted when 
controlling it.

Also we have brightness setting that would be useful for PWM controlled 
LEDs.

Setting color is easy when you use preset names then you only need to 
deal with brightness value (eg. RGB -> HSV * brightness -> RGB). Of 
course here additional problem is other color elements are they then 
scaled according to brightness value?.

Setting color as "raw" values is then next problem. In order to do it 
atomically it needs to be one atomic activation and could be eg. one 
write to "color" sysfs entry with combination of all color elements and 
perhaps additionally also brightness value. Next question is then what 
is the format for such entry then? What are the value ranges? In here we 
can utilize device tree definition to help define what kind of LED we do 
have and what kind of capabilities it does have.

Additional problem risen also in discussion was non-linearity of some 
control mechanisms vs. perceived color. So there might be a need for 
curve mapping similarly what is with backlight control and that would be 
defined either in device tree and possibly in user space if there is a 
need for that. I suppose golden curve definition in device tree should 
be good enough.

Then there was additional discussion about possible animation support 
but I would leave that for future design as that would then be utilizing 
the same framework.

I suppose color space handling and that kind of stuff should be in some 
led core functionality and then raw control should be part of physical 
led driver.

I was planning to play with it during holiday season but lets see how it 
goes. Feel free to also experiment with the idea.

Thanks,
Vesa Jääskeläinen

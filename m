Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3ADC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C6620871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA5Hm4sT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C6620871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbeKLFwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:52:33 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41498 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeKLFwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:52:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so4726515lfj.8;
        Sun, 11 Nov 2018 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ey+s89R73pXXQMefmAI7L9aekd1JL/1Fa2/6Z+PWM7k=;
        b=ZA5Hm4sTqY0wEoFCcHxfN7iCBHSncZtWrmV+d65P0OoN7y6iORlFpMgNpEFRvc5FEV
         SJdNOMDs2lgwCJGSLm2lmdTGBmGhT/tctaRbCH+nrd4STeTc29IBYCqu07hpM7LibIBg
         Xh9BPoyX/j4ta/encUlDx2R/3PDnG25ps1gP4c4keer497xrVtqDKMScb3s5NCCit+CZ
         +xHJ/XAJvL2d4KeXElbZS7h2OwxUMPm32EryxoFIfI1R2/nUc3xFrqpiul9uZwZKwy1L
         REcUZpwAmx5JSoaGvOPV+E8ET+xpq/VjoiIhfQAtMc4ZbeU6Ca24qG4OTTaNcqmtdK4i
         ZxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ey+s89R73pXXQMefmAI7L9aekd1JL/1Fa2/6Z+PWM7k=;
        b=VVcFf6DGRJMRaLT6GrujETysnHMogsMGvpMo78dBcoOk4oKRkJcYAb04fGVKHekOQn
         Uw9nnCr2LMkMmgs7nzDm2l9B53pys8dnbGFpKSE4mpjNyqyZgIuH1Bawci3o7FBzmhJR
         IZmTy4MYawmUWMNbboGgEF2SRF1WcUo2sNn7LWeXndSwlzoVXYco0HF08Kdez1xFSVSL
         Oca/wAL96j1HDnilSmYHq15zHy/5bsp5vwEaVn+Oa4G1T7ojjFkF3E84YiMoGfGaz57z
         BzrNpHpHbpX7bvL++6kRcZsGl1gvb0wu0UKKT6Y3E6gGJ/NFLEFEaqpZ00RSBMaliNuC
         PoUg==
X-Gm-Message-State: AGRZ1gKOWqjlWIRm5hPRcxnIZ0X25DpFduYGO4rKYVrEOhsLH4xv8dhQ
        nU/F4/8Hc2sXPuQT4iBoOLY=
X-Google-Smtp-Source: AJdET5eBY4foCLZ2noYEUFlBc/AKioD0WBjhtnlLhUY9e14OE0EhClPdYYR4Oaa+HEAxsw1F2AjSHA==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr10179798lfj.83.1541966582406;
        Sun, 11 Nov 2018 12:03:02 -0800 (PST)
Received: from [192.168.1.18] (cjk171.neoplus.adsl.tpnet.pl. [83.31.60.171])
        by smtp.gmail.com with ESMTPSA id e19-v6sm1919409ljf.67.2018.11.11.12.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 12:03:01 -0800 (PST)
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
Date:   Sun, 11 Nov 2018 21:02:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181111120234.GA28794@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 11/11/2018 01:02 PM, Pavel Machek wrote:
> Hi!
> 
>> Add public led_compose_name() API for composing LED class device
>> name basing on fwnode_handle data. The function composes device name
>> according to either a new <color:function> pattern or the legacy
>> <devicename:color:function> pattern. The decision on using the
>> particular pattern is made basing on whether fwnode contains new
>> "function" and "color" properties, or the legacy "label" proeprty.
>>
>> Backwards compatibility with in-driver hard-coded LED class device
>> names is assured thanks to the default_desc argument.
>>
>> In case none of the aformentioned properties was found, then, for OF
>> nodes, the node name is adopted for LED class device name.
>>
> 
>> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
>> index 836cb16..e9009c4 100644
>> --- a/Documentation/leds/leds-class.txt
>> +++ b/Documentation/leds/leds-class.txt
>> @@ -43,7 +43,7 @@ LED Device Naming
>>  
>>  Is currently of the form:
>>  
>> -"devicename:colour:function"
>> +"colour:function"
>>  
> 
> I don't think we want to do it in all cases.
> 
> So, on my cellphone seeing lp5523:green:led is indeed not useful.
> 
> But on notebook with usb keyboard attached, you need to keep the
> devicename to be able to distinguish capslock on internal keyboard and
> capslock on first USB keyboard and capslock on second USB keyboard.
> 
> Taking look at the list of functions, here's stuff like "hdd" and
> "hdderr". I assume the first means hdd activity... If we can do it, it
> would be nicest to have "sda:green:activity" and maybe
> "sda:red:error". For a raid array with 8 drives...
> 
> For example I have a router running linux. It has 4 lan ports, with
> correspondings LED, and an wan led.
> 
> Having "green:lan1" to "green:lan4" and "green:wan" plus
> "red:wanerror" would work, but I'd really preffer
> "eth0:green:link"... "adsl0:green:link", "adsl0:red:error".
> 
> There are now phones with flashes on both main and selfie
> cameras. Again, knowing which device is which is important. As is
> knowing which display is controlled by particular backlight.

It's overcomplicating the naming again. In every case you can tweak
the function name to eth0_link, eth1_link etc.

-- 
Best regards,
Jacek Anaszewski

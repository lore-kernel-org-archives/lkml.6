Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24BDC636A2
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721472087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3dHKInH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfATPan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:30:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44964 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfATPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:30:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so13721942lfe.11;
        Sun, 20 Jan 2019 07:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLXNamU0GSfbcDAFhOde0SY3gBbe0iiZKAf8IeifH4g=;
        b=s3dHKInHwSlnsJYjH1tJ2COiGR1jacbDxLt2W6+LRjjGCVsKhV5ySjG0HRSn1Jyz96
         lufs+hO8GfjzB161u5/MnAU5Spz/q/g/Ab6vKHcMsiVuicFCx5vewOpXfvfMLVb6iMY7
         oZL8M+BEe11au9LLcxy5hPCp7fcLLGDc3P4yWsUOIvbO5KkPUq8OJXKGpf3pv7u5gBge
         2nOB1Dw7ouvJzL8SJyayn8VlpGxfesC96ZbOBqzPm5qsxHW74GuzkPYkbXGQlAtA2sRN
         JPSSnRuPd933MCsKBy9KbaEF3UGAI2DYxxpZCQ+AhV5j2Z5rgLFSxUNdbx83NU1n5j2/
         da4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLXNamU0GSfbcDAFhOde0SY3gBbe0iiZKAf8IeifH4g=;
        b=cah/g/ZfFVw2cGVffSdRGU1PNCkruxoNBDxHQ9QrnzqPsoHwM7MIqFM6cda1QUMBT0
         PYJSfKdT7+01SLRHI3GfLN3gOhcMHjaD8vbGwj8abNJqPrSw1N11INcKn4Mg/TCSNz+C
         LDybaSK76bRGbv5vbuR62a+zjSiJ8HCLW09uBbcX+UBcs+AffPOpVACJnw+m05yPp7ZS
         l1/lvW2Db6HRBTjBsy/SrEFYYh3rJNVgriJ6o8qcIIUIdwUiWcinSxpGeBPjr1RQqJ+2
         rZvNRa+u9VALVwcYapRP0Tj/OmkIri/2YTXwCxZoZQd9yumcpCBAISWfhZvdzi0ess9m
         I4Vg==
X-Gm-Message-State: AJcUukcsTjJzz1kV6buoaecmIybALDUqEL0YZnhWWKw0OKMogMVTHu7S
        M+cGHcbKF6xAbu7AJgpgKdQ=
X-Google-Smtp-Source: ALg8bN6A7o3fbFUvYhaUqxeCVudSMo5ScQgV+sIJ1xT+eAnB+i9nnFGBQPNq1vhYs9dAIgkFWvg1Vg==
X-Received: by 2002:a19:5402:: with SMTP id i2mr16237673lfb.128.1547998239824;
        Sun, 20 Jan 2019 07:30:39 -0800 (PST)
Received: from [192.168.1.18] (bdu110.neoplus.adsl.tpnet.pl. [83.28.6.110])
        by smtp.gmail.com with ESMTPSA id u12-v6sm1761653ljk.79.2019.01.20.07.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 07:30:39 -0800 (PST)
Subject: Re: RGB LED class Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX
 family of the RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dachaac@gmail.com, robh+dt@kernel.org
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
 <8dfa2854-2814-6874-ab8e-1858e9a18acf@gmail.com> <20190118000235.GB27661@amd>
 <61fa89eb-c12e-8f9c-9457-9d6d17ba7717@gmail.com> <20190119213629.GA3654@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9d2e0220-69f0-faaa-adb9-13d905f9c51d@gmail.com>
Date:   Sun, 20 Jan 2019 16:30:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119213629.GA3654@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/19 10:36 PM, Pavel Machek wrote:
> Hi!
> 
>>> First, I think we want to decide if RGB LED should be presented as
>>> 3 LEDs or as 1 LED... and what to do with existing RGB leds being
>>> presented as 3 LEDs.
>>>
>>> I don't think we want to support both RGB and HSV in the kernel. It is
>>> math, and not a nice one.
>>>
>>> Yes, both have advantages and disadvantages, but having _both_ in
>>> kernel has disadvantages of both.
>>>
>>> One way I could imagine the interface:
>>>
>>>      RGB LED presented as one LED.
>>>
>>>      brightness -- controls brightness of whole RGB module.
>>
>> What algorithm would be used for mapping brightness levels to RGB values
>> in case of devices without hardware support for that?
> 
> Output power = brightness / max_brightness * pwm_channel[x].

IIUC you mean it as a formula for calculating r,g,b, values?
I.e., on brightness setting we would have to do this calculation for
each of three channels?

Then, it will result in changing hue as well. That's why we're
discussing HSV.

>>>      pwm_channels -- "1000 240 300" -- "red part should be full on, green
>>>      should be pwm controlled to 240/1000, blue should be 300/1000"
>>>
>>>      pwm_white -- "1000 500 400" -- tells userspace what to write to PWM
>>>      channels to get approximately white color.
>>>
>>>      This would assume that RGB LEDs are always pwm controlled. That
>>>      seems to be true for hardware I seen.
>>
>> Why pwm in the file names? I don't see any gain and only possible
>> problems. Many LED controllers use current level and not PWM
>> for driving LEDs.
> 
> I want to make sure userspace understands this has linear relation to
> output power. I'd like to avoid mentioning color because there power
> output is not linear with "RGB"
> 
>> s/pwm/color/
> 
> s/pwm/power/ would work for me.

Power implies physical units. I'd prefer "intensity".

>> Besides white also other color presets could be defined in DT.
> 
> They should not be neccessary. When userspace knows what is white and
> that power is linear with values in power_channels, it should be able
> to do colorspace conversion itself.

Have you verified it in practice? Would it allow to convert RGB values
of the color displayed on the monitor to LED RGB class intensities,
allowing to achieve similar color on the LED?

-- 
Best regards,
Jacek Anaszewski

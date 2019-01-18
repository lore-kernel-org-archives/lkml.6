Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87588C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BB020883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfARPfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:35:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42776 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfARPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:35:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id y20so11415593edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 07:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KlCbU+v2Ly6akxMfB/fMOsrfrjngzKkxYrx+Juqud64=;
        b=MnCUSay7XVR1dnzfcyReZ2sIFXXbeZBbsPS7bBPTVML+L+69QA5A8n2zUdg/WQl3WJ
         vRix8bfD/ji1+qTc4OWF66yupIZnYvJJ1ITf/+U4bPIl/y93WdI9gIzJ4kQqtxz5SXX6
         kK96FSA2J7sQ1uGb/q3OPknXSbvIF3Sk4hlj3NTf8QuET044LSVi1ivou3FKXAY+F+bi
         7df5RYK6Q0+h84seCZklotFg7H/XbwnZ4zJ0QeJWG2u533t/lE+zY16hpoouumrNkNqt
         Tqw84aabJos0LwCKph3gL8NN0sEK+wksMy/XbGtLYFpNFp+6lbUAOLrjs/Prz8N9dv9H
         Skrg==
X-Gm-Message-State: AJcUukeQSxYnw5PVBB9Z56ofh97pEICxae1KHffVUaFEGSzNaF86Iy4n
        wZW4UcC3lNtlCrF4OUnTz7DI6khGVeM=
X-Google-Smtp-Source: ALg8bN6ePZRrwzfw1keGsTzx61lfsdSkPHnIMz55CQMKN+riF3LWObI/PQclycFJFJuzOkq1n3m2mg==
X-Received: by 2002:a17:906:e0cb:: with SMTP id gl11-v6mr15085794ejb.92.1547825717007;
        Fri, 18 Jan 2019 07:35:17 -0800 (PST)
Received: from dhcp-44-202.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3971571ejz.70.2019.01.18.07.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 07:35:16 -0800 (PST)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Mogens Jensen <mogens-jensen@protonmail.com>
Cc:     Dean Wallace <duffydack73@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181025232517.ywnw54qibemosjws@picard>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
 <3iO9ehQbZm_haTV0IuZ0qhsVHR0QLUbTgRJT8ZenGuRsnz2_uBvO93f0bHVYnsApibUT16JsJ0dgphLhUBd-u0t-lDBNsbvvlKWTgq8XOlw=@protonmail.com>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
 <20190117091214.7djttnpo4jjzi4su@spock>
 <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
 <pozwYTgSVvWumpTgwwf_C-qvYFNnl7yl9gcq9M-LOUXQTvkSX5f8E_2d-HYNYV_ruL8kAURaIR3ItM_UmFJeV-e28eYy8b2MomlwHMbb-5U=@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <983fb777-df22-1b53-acea-8bbcab23b260@redhat.com>
Date:   Fri, 18 Jan 2019 16:35:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <pozwYTgSVvWumpTgwwf_C-qvYFNnl7yl9gcq9M-LOUXQTvkSX5f8E_2d-HYNYV_ruL8kAURaIR3ItM_UmFJeV-e28eYy8b2MomlwHMbb-5U=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/17/19 8:30 PM, Mogens Jensen wrote:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Thursday, January 17, 2019 12:05 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 17-01-19 10:12, Dean Wallace wrote:
>>
>>> Hi Hans, Mogens,
>>> On 17-01-19, Mogens Jensen wrote:
>>>
>>>> Kernel is compiled with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and the quirk seems to have fixed the problem caused by commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL"), as sound is now working if running "speaker-test" on my system which is clean ALSA.
>>
>> Note being "clean ALSA" is really not a good thing now a days,
>> for lots of things we depend on pulseaudio (like setting
>> up UCM mixer profiles).
>>
> I'm using UCM mixer profile from:
> 
> https://github.com/plbossart/UCM/tree/master/chtmax98090
> 
> This is enabled with:
> 
> alsaucm -c chtmax98090 set _verb HiFi set _enadev Speakers
> 
>>>> Unfortunately, SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH driver is unusable on Clapper Chromebooks as audio played from everything but "speaker-test" as video players or web browsers is extremly low and sounds like played at 10x speed. At the same time kernel log is spammed with messages like this:
>>>> max98090 i2c-193C9890:00: PLL unlocked
>>>> intel_sst_acpi 80860F28:00: FW Version 01.0c.00.01
>>>> writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00 ............U...
>>>> writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00 ............u...
>>>> This is probably not related to the problem discussed in this thread, but the result is that I have to use the legacy driver SND_SOC_INTEL_BYT_MAX98090_MACH and therefore still has to revert commit 648e921888ad for sound to work.
>>>> Is it possible to create a fix for SND_SOC_INTEL_BYT_MAX98090_MACH on kernel 4.19? Kernel 4.19 is a long term release so it would be very nice to have fix for this version upstream.
>>>
>>> I have been reverting "clk: x86: Stop marking clocks as CLK_IS_CRITICAL"
>>> and the patch that initially added the quirk for swanky because of sound
>>> instability issues as you described. I'm compiling vanilla Archlinux
>>> kernel with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH, using pulseaudio,
>>> and have sound in all my apps.
>>> Baytrail sound has always been a little touchy, especially using headset
>>> with mic, but since the clk patch breaking sound and the quirk patch to
>>> fix it, there is a lot more instability. Just running pavucontrol, or
>>> plugging in headset sets it off. It's a head scratcher.
>>
>> Mogens, Dean, can you please try the SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
>> driver, without reverting any patches, with the attached patch on top and
>> see if that helps?
>>
>> Thanks & Regards,
>>
>> Hans
> 
> I have applied the patch to kernel 4.19.15 and unfortunately this has not solved the problems.
> 
> Audio generated from "speaker-test" is normal, but from everything else is very low and played at 10x speed. However, I'm not seeing the "max98090 i2c-193C9890:00: PLL unlocked" message in kernel log anymore, but it's still spammed with "writing to lpe: ...".

Hmm, I've a feeling the problem is your using alsa directly, do you have
dmix enabled ? You probably need dmix since the SST sound support
only supports 48KHz AFAIK.

Can you perhaps give things a try with pulseaudio ?

Regards,

Hans

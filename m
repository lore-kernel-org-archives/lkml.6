Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CBFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685612175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3AY3mS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfBDSrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:47:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41245 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfBDSrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:47:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so301572pgq.8;
        Mon, 04 Feb 2019 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4KfUgQVBDWIdCDPG5YpSqhiBtJUtwUj4oSWyrZMCqFU=;
        b=C3AY3mS9LtHdVixKDTMumbp0Bo6HIM5TiOXAR2lZah3FhylrRFrr8ttkX+yu2r0Rj4
         tSgig25YYcmkl+VrQITbj4tbPjIgkHXMBRP6HSaEFb4cs9fj7Vzhk9f7RUdf1W7jT7d0
         ig/zGpC4JUIYOm4941W8XaDHGnCIYnB0ALZl1DM/N1GEBO/h4lMr1wiBrgtyYFd8cYJA
         uorcLEed3DLVwEc4ym/jyjeYdxWwvkEP4TSd6a6efCEbkYiHQS2FmKt+tcvm3e2/owDj
         Bk9o0yw6NgzQFTrP5Vdi+ZjMUMgVGr1UeHSZ7pOnDN+n9u78KZiYlpqGJiSsE21XceUj
         715g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4KfUgQVBDWIdCDPG5YpSqhiBtJUtwUj4oSWyrZMCqFU=;
        b=MXmmapRwLBJqZ6v61t86N0SSAE+BYn4iUfxd/y4Zhz9gvox3MFfRno8trl8h9Jt8Ti
         xQB8RdtiPblAiKK0ZM0L11TMN9mZfxAjllfK7FfyqFhKLj7lmp8Kts6+aTr/JG0RJxt2
         5AM6nZvjufIQmamew7bULvQnmsnhVe07E3cfhV0ODHXZoekAGPL75V+sB2v/7kVe1V72
         ynJDYNksrDdceyTH7sJp2GnnDz2S8StcwIR4mqQNUqQdgTQ+KBsBc2PIH4d9BCQVei3D
         ziPtAq1qoaqIzC+Z+j5wK7WaWtlpGk5lfRsBXybKZvSMN80KQa3phN6I9Twj61eZutGV
         nBnQ==
X-Gm-Message-State: AHQUAuZ7n5f7n6pR3st7b5Jxdy80MAKdXSXgNaMNl41sQyj2ycnytMey
        Wlbzc8YZ6ib8QvHva/ST7ZB6k+sH
X-Google-Smtp-Source: AHgI3IZAjMjqx4p1oeD39J1dtBh1wxQ038qoI22B6REEGY9a5jTu/7mlfu285Iq7T63dEJgLsdsf7w==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr719548pgc.366.1549306036860;
        Mon, 04 Feb 2019 10:47:16 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id z62sm1519794pfl.33.2019.02.04.10.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 10:47:15 -0800 (PST)
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, mkumard@nvidia.com,
        rlokhande@nvidia.com, sharadg@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo> <2034694.JE9CgBysmF@aspire.rjw.lan>
 <20190204084555.GF19087@ulmo>
 <07d58962-4c49-0575-2f95-4c885998bb52@nvidia.com>
 <20190204110510.GA10412@ulmo>
 <f0bdcc21-efca-4d04-c7ec-953ec3d87031@gmail.com>
 <20190204140024.GJ10412@ulmo>
 <ef8cef12-12d5-4729-b603-9f0c6c0c0865@gmail.com>
 <20190204161736.GA25476@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <081d4eeb-424a-f448-cc06-e16a483e9287@gmail.com>
Date:   Mon, 4 Feb 2019 21:46:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204161736.GA25476@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.02.2019 19:17, Thierry Reding пишет:
> On Mon, Feb 04, 2019 at 05:28:23PM +0300, Dmitry Osipenko wrote:
>> 04.02.2019 17:00, Thierry Reding пишет:
>>> On Mon, Feb 04, 2019 at 03:03:49PM +0300, Dmitry Osipenko wrote:
>>>> 04.02.2019 14:05, Thierry Reding пишет:
>>>>> On Mon, Feb 04, 2019 at 09:53:32AM +0000, Jon Hunter wrote:
>>>>>>
>>>>>>
>>>>>> On 04/02/2019 08:45, Thierry Reding wrote:
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>> The idea was, as I was saying below, to reuse dev_pm_ops even if
>>>>>>> !CONFIG_PM. So pm_runtime_enable() could be something like this:
>>>>>>>
>>>>>>> 	pm_runtime_enable(dev)
>>>>>>> 	{
>>>>>>> 		if (!CONFIG_PM)
>>>>>>> 			if (dev->pm_ops->resume)
>>>>>>> 				dev->pm_ops->resume(dev);
>>>>>>>
>>>>>>> 		...
>>>>>>> 	}
>>>>>>>
>>>>>>> But that's admittedly somewhat of a stretch. This could of course be
>>>>>>> made somewhat nicer by adding an explicit variant, say:
>>>>>>>
>>>>>>> 	pm_runtime_enable_foo(dev)
>>>>>>> 	{
>>>>>>> 		if (!CONFIG_PM && dev->pm_ops->resume)
>>>>>>> 			return dev->pm_ops->resume(dev);
>>>>>>>
>>>>>>> 		return 0;
>>>>>>> 	}
>>>>>>>
>>>>>>> Maybe the fact that I couldn't come up with a good name is a good
>>>>>>> indication that this is a bad idea...
>>>>>>
>>>>>> How about some new APIs called ...
>>>>>>
>>>>>> pm_runtime_enable_get()
>>>>>> pm_runtime_enable_get_sync()
>>>>>> pm_runtime_put_disable() (implies a put_sync)
>>>>>>
>>>>>> ... and in these APIs we add ...
>>>>>>
>>>>>> pm_runtime_enable_get(dev)
>>>>>> {
>>>>>> 	if (!CONFIG_PM && dev->pm_ops->resume)
>>>>>> 		return dev->pm_ops->resume(dev);
>>>>>>
>>>>>> 	pm_runtime_enable(dev);
>>>>>> 	return pm_runtime_get(dev);
>>>>>> }
>>>>>
>>>>> Yeah, those sound sensible. I'm still a bit torn between this and just
>>>>> enforcing PM. At least on the display side I think we already require PM
>>>>> and with all the power domain work that you did we'd be much better off
>>>>> if we could just get rid of the !PM workarounds.
>>>>>
>>>>>>>>> This would be somewhat tricky because drivers
>>>>>>>>> usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
>>>>>>>>> that would result in an empty structure if !CONFIG_PM, but we could
>>>>>>>>> probably work around that by adding a __SET_RUNTIME_PM_OPS that would
>>>>>>>>> never be compiled out for this kind of case. Or such drivers could even
>>>>>>>>> manually set .runtime_suspend and .runtime_resume to make sure they're
>>>>>>>>> always populated.
>>>>>>>>>
>>>>>>>>> Another way out of this would be to make sure we never run into the case
>>>>>>>>> where runtime PM is disabled. If we always "select PM" on Tegra, then PM
>>>>>>>>> should always be available. But is it guaranteed that runtime PM for the
>>>>>>>>> devices is functional in that case? From a cursory look at the code it
>>>>>>>>> would seem that way.
>>>>>>>>
>>>>>>>> If you select PM, then all of the requisite code should be there.
>>>>>>>
>>>>>>> We do this on 64-bit ARM, but there had been some pushback when we had
>>>>>>> proposed to do the same thing on 32-bit ARM. I think there were two
>>>>>>> concerns:
>>>>>>>
>>>>>>> 	1) select PM would force the setting for all platforms on multi-
>>>>>>> 	   platforms builds
>>>>>>>
>>>>>>> 	2) prevents anyone from disabling PM for debugging purposes
>>>>>>>
>>>>>>> 1) no longer seems to be valid because Rockchip already selects PM
>>>>>>> unconditionally. I'm not sure if 2) is valid anymore either. I haven't
>>>>>>> run a build with !PM in a very long time and I wouldn't be surprised if
>>>>>>> that was completely broken.
>>>>>>>
>>>>>>> Maybe we need to try this again since a couple of years have elapsed and
>>>>>>> runtime PM support on Tegra is much more mature at this point.
>>>>>>>
>>>>>>>> Alternatively, you can make the driver depend on PM.
>>>>>>>
>>>>>>> That's probably the easiest way out, but to be honest I think I'd prefer
>>>>>>> to just enforce PM and keep things simple.
>>>>>>>
>>>>>>> Jon, any objections?
>>>>>>
>>>>>> None, but seems overkill just for this case.
>>>>>
>>>>> But that's precisely the point. It's not just about this case. We've
>>>>> already got some drivers where we do a similar dance just to be able to
>>>>> support the, let's admit it, exotic case where somebody turns off PM. I
>>>>> think supporting !PM might have made sense at a point where we had no
>>>>> support for power management at all. But I think we've come a long way
>>>>> since then, and while we may still have some ways to go in some areas,
>>>>> we do fairly decent runtime PM most of the time, to the point where I no
>>>>> longer see any benefits in !PM.
>>>>
>>>> I'm requesting PM_DEBUG_ALWAYS_ON option then! Disabling PM is a
>>>> useful debug feature, it can't just go away. 
>>>
>>> What is it about disabling PM that you consider useful? I can understand
>>> why you'd want that option if power management is broken, but as far as
>>> I can tell, power management on Tegra is in pretty good state, and it's
>>> more likely that !PM would actually be broken (though I haven't built a
>>> configuration like that in a couple of years, so I'm speculating). We
>>> already can't disable PM on 64-bit ARM, so I don't understand why 32-bit
>>> ARM should be treated any differently.
>>
>> Yes, I want an option for debugging of a broken PM. It doesn't matter
>> that there are no known PM-related issues on Tegra today, it could
>> become a problem tomorrow. Probably a kernel boot parameter like
>> pm_debug_always_on would suit even better here. 
>>
>> Or maybe PM API already provides such debug options and I'm just not
>> aware about them?
> 
> I'm not sure I understand what you're trying to do. If you want to use
> !PM as a way to debug broken PM, how would that help? Presumably if you
> disable !PM then the problem would be gone? In other words, in order to
> reproduce a PM related issue don't you have to enable PM first?

Disabling PM globally is one of first diagnostics steps, at least it gives an idea about source of a problem.

> I'm not aware of an alternate mechanism to force PM to off once built
> into the kernel.

I think runtime PM could be disabled per-device. That's probably what tools like powertop use to tune power management.

>> Do you know what's the exact reason for ARM64 to not support !PM?
> 
> There's no reason per se not to support PM. It's just that at the time
> we made the decision that we didn't want to. I vaguely remember that we
> tried to do the same thing for 32-bit ARM, but at the time we would've
> been the only platform to select PM, and that would've meant enabling
> PM for all subarchitectures and therefore forcing PM in multi-platform
> builds. Today if you build multi-platform kernels, at least Rockchip
> will also forcibly enable PM for everyone.
> 
> I think you may also have objected at the time for similar reasons. But
> this was a long time ago (at least 2 to 3 years I would guess) and much
> has changed since then. Power management has gotten a lot better on
> Tegra, to the point where we actually need it in order to properly
> function. For example, Tegra DRM is not going to work with !PM because
> we rely on runtime PM while disabling and enabling display pipelines.

I also know that people are disabling PM for performance reasons, sometime it's more important to reduce system's response latency than to care about power savings. But that probably not very relevant to Tegra usages. Okay, I guess in general it should be fine to enforce PM requirement and improve debug-ability later on by as-needed basis.

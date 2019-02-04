Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87074C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486662087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiP6e7vC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfBDMEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:04:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38489 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfBDMEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:04:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so11309150lja.5;
        Mon, 04 Feb 2019 04:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LW9g0Q+2WO7fgozCUWbBwatqRYrXsPEznQ+yYx8lK5o=;
        b=hiP6e7vCftQNbiA9K5YlSIfIVdlhcilt2pCZ0fyymH1vzeFvoyfElih0ZQDHT9zcix
         neoDf+bcWJHpNIj2GIYp8lTxW62DDHZpECEvoRRi3sLDHal3jv5HUGw1yzBjHNENyMSa
         1zoHHq0gUY66ztsyFZyBQS4yJwDkdpHkWc1zZoo80iMnkmVjDK8aWVLJ7p84oSf66H9w
         702oJWvf6axgQIA/KwnwYlZeqHO+LyiWDRgpoRnreK+5dEyv6IbVX4oBy8EOXkSlTJoH
         2VrIOzwrz7ApzVGVoSwNCXxITEBWRa1TtuN1YLzoYWuF5n4w0u0dEH6kZTEZMGRcAlvD
         WT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LW9g0Q+2WO7fgozCUWbBwatqRYrXsPEznQ+yYx8lK5o=;
        b=kNMyT0GmEv+L9212Hp+d5cqrvieyAvVRzYUplzprqQnkipL0k4gWBARvIB2jVCEiOs
         3Gs7uCoQN/Etyp2gbpbd+SbZqSrm9Jy+RIor2uc/8WLq4ForNk0s9bGzZsrgA5FviacU
         CsFad9hLxp0Nv/SH2jh7juMmTWL283pasMwDVjYh8o4pCCPkmLR3Sepzutea7H96xOIM
         U9tF8zpTxwe0I4lgUFhd4SB7hKxxKUCfHc9qPYLAecZbtoys5oY19V5CqB8SEkmtyzHc
         1ZX6d+RA4LAkhv4EjrTQQpd23iD42BkQNgLrBV8RvcW7vrNirIQZNclWW1G+ufO0gTsy
         jjhQ==
X-Gm-Message-State: AHQUAuY6kZaQmLREntDqdLDSSF3Q4/WlWN1cqhENWv9uUQireWvgx4Dz
        ZBQ7Zo1N6LPBvILgZTidVlD8GoMi
X-Google-Smtp-Source: AHgI3IaphSzPSKSkNr8ku7jlfiYplnKNaHPRXUAgZ0VyiI1Sbj2+CgREbN3mhj82Ny74/zJLq3yteg==
X-Received: by 2002:a2e:8858:: with SMTP id z24-v6mr7771889ljj.197.1549281870762;
        Mon, 04 Feb 2019 04:04:30 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id l3-v6sm2734406ljg.21.2019.02.04.04.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 04:04:29 -0800 (PST)
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f0bdcc21-efca-4d04-c7ec-953ec3d87031@gmail.com>
Date:   Mon, 4 Feb 2019 15:03:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204110510.GA10412@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.02.2019 14:05, Thierry Reding пишет:
> On Mon, Feb 04, 2019 at 09:53:32AM +0000, Jon Hunter wrote:
>>
>>
>> On 04/02/2019 08:45, Thierry Reding wrote:
>>
>> ...
>>
>>> The idea was, as I was saying below, to reuse dev_pm_ops even if
>>> !CONFIG_PM. So pm_runtime_enable() could be something like this:
>>>
>>> 	pm_runtime_enable(dev)
>>> 	{
>>> 		if (!CONFIG_PM)
>>> 			if (dev->pm_ops->resume)
>>> 				dev->pm_ops->resume(dev);
>>>
>>> 		...
>>> 	}
>>>
>>> But that's admittedly somewhat of a stretch. This could of course be
>>> made somewhat nicer by adding an explicit variant, say:
>>>
>>> 	pm_runtime_enable_foo(dev)
>>> 	{
>>> 		if (!CONFIG_PM && dev->pm_ops->resume)
>>> 			return dev->pm_ops->resume(dev);
>>>
>>> 		return 0;
>>> 	}
>>>
>>> Maybe the fact that I couldn't come up with a good name is a good
>>> indication that this is a bad idea...
>>
>> How about some new APIs called ...
>>
>> pm_runtime_enable_get()
>> pm_runtime_enable_get_sync()
>> pm_runtime_put_disable() (implies a put_sync)
>>
>> ... and in these APIs we add ...
>>
>> pm_runtime_enable_get(dev)
>> {
>> 	if (!CONFIG_PM && dev->pm_ops->resume)
>> 		return dev->pm_ops->resume(dev);
>>
>> 	pm_runtime_enable(dev);
>> 	return pm_runtime_get(dev);
>> }
> 
> Yeah, those sound sensible. I'm still a bit torn between this and just
> enforcing PM. At least on the display side I think we already require PM
> and with all the power domain work that you did we'd be much better off
> if we could just get rid of the !PM workarounds.
> 
>>>>> This would be somewhat tricky because drivers
>>>>> usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
>>>>> that would result in an empty structure if !CONFIG_PM, but we could
>>>>> probably work around that by adding a __SET_RUNTIME_PM_OPS that would
>>>>> never be compiled out for this kind of case. Or such drivers could even
>>>>> manually set .runtime_suspend and .runtime_resume to make sure they're
>>>>> always populated.
>>>>>
>>>>> Another way out of this would be to make sure we never run into the case
>>>>> where runtime PM is disabled. If we always "select PM" on Tegra, then PM
>>>>> should always be available. But is it guaranteed that runtime PM for the
>>>>> devices is functional in that case? From a cursory look at the code it
>>>>> would seem that way.
>>>>
>>>> If you select PM, then all of the requisite code should be there.
>>>
>>> We do this on 64-bit ARM, but there had been some pushback when we had
>>> proposed to do the same thing on 32-bit ARM. I think there were two
>>> concerns:
>>>
>>> 	1) select PM would force the setting for all platforms on multi-
>>> 	   platforms builds
>>>
>>> 	2) prevents anyone from disabling PM for debugging purposes
>>>
>>> 1) no longer seems to be valid because Rockchip already selects PM
>>> unconditionally. I'm not sure if 2) is valid anymore either. I haven't
>>> run a build with !PM in a very long time and I wouldn't be surprised if
>>> that was completely broken.
>>>
>>> Maybe we need to try this again since a couple of years have elapsed and
>>> runtime PM support on Tegra is much more mature at this point.
>>>
>>>> Alternatively, you can make the driver depend on PM.
>>>
>>> That's probably the easiest way out, but to be honest I think I'd prefer
>>> to just enforce PM and keep things simple.
>>>
>>> Jon, any objections?
>>
>> None, but seems overkill just for this case.
> 
> But that's precisely the point. It's not just about this case. We've
> already got some drivers where we do a similar dance just to be able to
> support the, let's admit it, exotic case where somebody turns off PM. I
> think supporting !PM might have made sense at a point where we had no
> support for power management at all. But I think we've come a long way
> since then, and while we may still have some ways to go in some areas,
> we do fairly decent runtime PM most of the time, to the point where I no
> longer see any benefits in !PM.

I'm requesting PM_DEBUG_ALWAYS_ON option then! Disabling PM is a useful debug feature, it can't just go away. 

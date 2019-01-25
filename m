Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FE0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509F2218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gJxlosgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfAYOFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:05:01 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4534 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:05:01 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4b178c0000>; Fri, 25 Jan 2019 06:05:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 06:05:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 25 Jan 2019 06:05:00 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 14:04:58 +0000
Subject: Re: [PATCH] ALSA: hda/tegra: enable clock during probe
To:     Takashi Iwai <tiwai@suse.de>
CC:     Sameer Pujar <spujar@nvidia.com>,
        <pierre-louis.bossart@linux.intel.com>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <thierry.reding@gmail.com>,
        <rlokhande@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1548351403-1875-1-git-send-email-spujar@nvidia.com>
 <s5h5zudc1qw.wl-tiwai@suse.de>
 <06c00ce1-32ed-8aa9-0340-d00202a8fa62@nvidia.com>
 <s5hr2d0zz96.wl-tiwai@suse.de>
 <b64f5d05-f352-7b46-d70d-3809aab8ddda@nvidia.com>
 <s5hef90zvo0.wl-tiwai@suse.de>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1f4c5185-e518-5674-4a8c-4e7db64aa0d3@nvidia.com>
Date:   Fri, 25 Jan 2019 14:04:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <s5hef90zvo0.wl-tiwai@suse.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548425100; bh=cMHGwQhGfnxvoTzmgYSvcaJzUhzFBmhRQUHVrzVuKks=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gJxlosgzR3EhHfLUI0EImjVoVYe671poiibuCiGdkOJbSmkzTsnce+MiFXhNfosGQ
         wax/TPeAZ6SLlAoCkz4SsJncFuNwz4uXPxMmr6N1cUmxf8MqpimZ8pnEx4n3BwB1Uh
         El+JPw8mWXJ9NJFSYiEx1IxOin4/umVUEYC0Kkef8sSXnxPRNRhpiV/F26oN3yl2c3
         ppFSJfApD+EAs5b/tjcpukIwNW0V0vdYd1AxoEszdMo0AcRkLhh7hjz1WxncIb5GP2
         sHOK9bwovxfjzLR1W0HQS6DLYXurQCcSzIvn4v0I+gm+tKBWdXZrBa7OW+lFnpEBo1
         7OGbYXB8epnDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/01/2019 13:58, Takashi Iwai wrote:
> On Fri, 25 Jan 2019 14:26:27 +0100,
> Jon Hunter wrote:
>>
>>
>> On 25/01/2019 12:40, Takashi Iwai wrote:
>>> On Fri, 25 Jan 2019 12:36:00 +0100,
>>> Jon Hunter wrote:
>>>>
>>>>
>>>> On 24/01/2019 19:08, Takashi Iwai wrote:
>>>>> On Thu, 24 Jan 2019 18:36:43 +0100,
>>>>> Sameer Pujar wrote:
>>>>>>
>>>>>> If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
>>>>>> will not be ON. This could cause issue during probe, where hda init
>>>>>> setup is done. This patch checks whether runtime PM is enabled or not.
>>>>>> If disabled, clocks are enabled in probe() and disabled in remove()
>>>>>>
>>>>>> This patch does following minor changes as cleanup,
>>>>>>   * return code check for pm_runtime_get_sync() to take care of failure
>>>>>>     and exit gracefully.
>>>>>>   * In remove path runtime PM is disabled before calling snd_card_free().
>>>>>>   * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
>>>>>>   * runtime PM callbacks moved out of CONFIG_PM check
>>>>>>
>>>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>>>> Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
>>>>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>>>> (snip)
>>>>>> @@ -555,6 +553,13 @@ static int hda_tegra_probe(struct platform_device *pdev)
>>>>>>  	if (!azx_has_pm_runtime(chip))
>>>>>>  		pm_runtime_forbid(hda->dev);
>>>>>>  
>>>>>> +	/* explicit resume if runtime PM is disabled */
>>>>>> +	if (!pm_runtime_enabled(hda->dev)) {
>>>>>> +		err = hda_tegra_runtime_resume(hda->dev);
>>>>>> +		if (err)
>>>>>> +			goto out_free;
>>>>>> +	}
>>>>>> +
>>>>>>  	schedule_work(&hda->probe_work);
>>>>>
>>>>> Calling runtime_resume here is really confusing...
>>>>
>>>> Why? IMO it is better to have a single handler for resuming the device
>>>> and so if RPM is not enabled we call the handler directly. This is what
>>>> we have been advised to do in the past and do in other drivers. See ...
>>>
>>> The point is that we're not "resuming" anything there.  It's in the
>>> early probe stage, and the device state is uninitialized, not really
>>> suspended.  It'd end up with just calling the same helper
>>> (hda_tegra_enable_clocks()), though.
>>
>> Yes and you can make the same argument for every driver that calls
>> pm_runtime_get_sync() during probe to turn on clocks, handle resets,
>> etc, because at the end of the day the very first call to
>> pm_runtime_get_sync() invokes the runtime_resume callback, when we have
>> never been suspended.
> 
> Although there are some magical pm_runtime_*() in some places, most of
> such pm_runtime_get_sync() is for the actual runtime PM management (to
> prevent the runtime suspend), while the code above is for explicitly
> setting up something for non-PM cases.
> 
> And if pm_runtime_get_sync() is obviously superfluous, we should
> remove such calls.  Really.

Yes agree.

>> Yes at the end of the day it is the same and given that we have done
>> this elsewhere I think it is good to be consistent if/where we can.
> 
> The code becomes less readable, and that's a good reason against it :)

I don't its less readable. However, I do think it is less error prone :-)

Jon

-- 
nvpublic

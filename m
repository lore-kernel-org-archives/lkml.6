Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43181C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0444B218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l6wA7czb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbfAaOVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:21:46 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16984 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfAaOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:21:46 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c53044f0000>; Thu, 31 Jan 2019 06:21:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 06:21:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 06:21:44 -0800
Received: from [10.25.75.21] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 14:21:38 +0000
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, <mkumard@nvidia.com>,
        <rlokhande@nvidia.com>, <sharadg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com>
 <s5ha7jicd4l.wl-tiwai@suse.de> <20190131110530.GA23438@ulmo>
 <s5htvhpax8s.wl-tiwai@suse.de>
 <CAJZ5v0i_G36Cw3ZvDxyU2F+pBpiw9i=3_wfQ3tDh3_JgOAb3zw@mail.gmail.com>
 <s5hh8dpavhw.wl-tiwai@suse.de>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <ab7dbd95-6852-12e1-5fcb-8372c73bfdf6@nvidia.com>
Date:   Thu, 31 Jan 2019 19:51:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548944463; bh=njYyIG6apH9x6+J88NDrmgbazHY3VwxJaHqQG8RunUc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=l6wA7czbXspX6fISgbXPcDGsKMziBKLD8KkRrVTz7WLZHJM557eNsRLsTPhglM5pO
         ugoMGmT4phEhQ0m6SDJyp2Ibpps2p5HNqwWsgDDAj1pWT/YuCP6B5T9rlQEYH5yGmO
         kPqS3gO34Nitk1p4tDyLCw7blA0nUw28A+DmMIs7iSq0vyIB+AA4i5CXZBcjVutQlR
         Gll4vTKb/GnJVSaYYwTVEreISPRkZB/yX+q95OaQ6ZRiSg5VxO1Wx35mfw8k8xGkGI
         DPhMxFGY7MCTSIPrGnyFCuuv9dIPK1OlFhcA/4YrTq7gnz7zAutI7UK7cUYIzc6oBN
         WSYocvcqYRw9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/2019 5:40 PM, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 12:59 PM Takashi Iwai <tiwai@suse.de> wrote:
>> On Thu, 31 Jan 2019 12:46:54 +0100,
>> Rafael J. Wysocki wrote:
>>> On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wrote:
>>>> On Thu, 31 Jan 2019 12:05:30 +0100,
>>>> Thierry Reding wrote:
>>>>> On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
>>> [cut]
>>>
>>>>>> If I understand correctly the code, the pm domain is already activated
>>>>>> at calling driver's probe callback.
>>>>> As far as I can tell, the domain will also be powered off again after
>>>>> probe finished, unless the device grabs a runtime PM reference. This is
>>>>> what happens via the dev->pm_domain->sync() call after successful probe
>>>>> of a driver.
>>>> Ah, a good point.  This can be a problem with a probe work like this
>>>> case.

Are you suggesting, whether runtime PM is enabled/disabled, after 
successful probe the
domain would be powered off?
For CONFIG_PM enabled case, probe() can call get_sync() and put_sync() 
can be in probe_work.
How this needs to be handled for CONFG_PM disabled case? (just calling 
clock_enable() may
not be sufficient as per previous comments)

>>>>> It seems to me like it's not a very well defined case what to do when a
>>>>> device needs to be powered up but runtime PM is not enabled.
>>>>>
>>>>> Adding Rafael and linux-pm, maybe they can provide some guidance on what
>>>>> to do in these situations.
>>>>>
>>>>> To summarize, what we're debating here is how to handle powering up a
>>>>> device if the pm_runtime infrastructure doesn't take care of it. Jon's
>>>>> proposal here was, and we use this elsewhere, to do something like this:
>>>>>
>>>>>        pm_runtime_enable(dev);
>>>>>        if (!pm_runtime_enabled(dev)) {
>>>>>                err = foo_runtime_resume(dev);
>>>>>                if (err < 0)
>>>>>                        goto fail;
>>>>>        }
>>>>>
>>>>> So basically when runtime PM is not available, we explicitly "resume"
>>>>> the device to power it up.
>>>>>
>>>>> It seems to me like that's a fairly common problem, so I'm wondering if
>>>>> there's something that the runtime PM core could do to help with this.
>>>>> Or perhaps there's already a way to achieve this that we're all
>>>>> overlooking?
>>>>>
>>>>> Rafael, any suggestions?
>>>> If any, a common helper would be appreciated, indeed.
>>> I'm not sure that I understand the problem correctly, so let me
>>> restate it the way I understand it.
>>>
>>> What we're talking about is a driver ->probe() callback.  Runtime PM
>>> is disabled initially and the device is off.  It needs to be powered
>>> up, but the way to do that depends on some configuration of the board
>>> etc., so ideally
>>>
>>> pm_runtime_enable(dev);
>>> ret = pm_runtime_resume(dev);
>>>
>>> should just work, but the question is what to do if runtime PM doesn't
>>> work as expected.  That is, CONFIG_PM_RUNTIME is unset?  Or something
>>> else?
>> Yes, the question is how to write the code for both with and without
>> CONFIG_PM (or CONFIG_PM_RUNTIME).
> This basically is about setup, because after that point all should
> just work in both cases.
>
> Personally, I would do
>
> if (IS_ENABLED(CONFIG_PM)) {
>    do setup based on pm-runtime
> } else {
>    do manual setup
> }

do we really need config check here?
The debate was, whether to call hda_tegra_runtime_resume() or 
hda_tegra_enable_clocks() unconditionally here.
It would take care of both CONFIG_PM enabled/disabled cases. Then enable 
runtime PM.

>> Right now, we have a code like below, pushing the initialization in an
>> async work and let the probe returning quickly.
>>
>>          hda_tegra_probe() {
>>                  ....
> So why don't you do
>
> if (!IS_ENABLED(CONFIG_PM)) {
>    do manual clock setup
> }
>
> here?
>
>>                  pm_runtime_enable();
>>                  schedule_work();
>>                  return;
>>          }
>>
>>          hda_tegra_probe_work() {
>>                  pm_runtime_get_sync();
>>                  ....
>>                  pm_runtime_put_sync();
>>          }
>>
>> Then it truned outhis code lacks of the clock initialization when
>> runtime PM isn't enabled.  Normally it's done via runtime resume
>>
>>          hda_tegra_runtime_resume() {
>>                  hda_tegra_enable_clocks();
>>                  ....
>>          }
>>
>> And now the question is what is the standard idiom in such a case.
>>
>> IMO, calling pm_runtime_resume() inside the probe function looks
>> weird, and my preference was to initialize the clocks explicitly, then
>> enable runtime PM.  But if using pm_runtime_resume() in the proc
>> should be seen as a standard procedure, I'm fine with that.

I think reference here is, whether calling hda_tegra_runtime_resume() in 
probe() is
a standard procedure or not.

> Well, people do pm_runtime_resume() in ->probe() too, but
> pm_runtime_resume() returns 1 for CONFIG_PM unset, so that won't give
> you what you want anyway. :-)
>
> Cheers,
> Rafael

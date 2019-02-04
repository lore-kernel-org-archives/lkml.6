Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74D8C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3B3214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h8prSZV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfBDIQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:16:30 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4009 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBDIQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:16:29 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c57f4bd0000>; Mon, 04 Feb 2019 00:15:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 04 Feb 2019 00:16:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 04 Feb 2019 00:16:27 -0800
Received: from [10.25.72.40] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 4 Feb
 2019 08:16:23 +0000
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, <mkumard@nvidia.com>,
        <rlokhande@nvidia.com>, <sharadg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo> <2034694.JE9CgBysmF@aspire.rjw.lan>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <e7597220-2be7-ca29-50b7-c515c06cbed7@nvidia.com>
Date:   Mon, 4 Feb 2019 13:46:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2034694.JE9CgBysmF@aspire.rjw.lan>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549268157; bh=5thbI/yHg4zp4SH83Gu99gMouPmDMmBR7FvjbhXyp1w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=h8prSZV0yu8a8aZ93gC78k/lhaNFOG43aweEA7zyZP5j544ITuc/Vu65GiLSmZHWW
         cTsBTI78ZEDPS+TcKaiI1omlQifwuyVIRa6dRajpOPCxs6605a3FHj0g3ED0JGEoqc
         jFWMmIqQ6wQMZ9KhYxLTw34c9Xo46UnWLxAD6xY+oR8HvS8TkgJodhdQzkIpWdz0lc
         UzONOkOyJzF50hkyBp+ZN3MoMJFQuZCBFyV/Ah6JjzAHbIRhs9lGWHg3U4S96CxX8R
         YqDLEVQ2HB6Eq4OpCRysBm1NTBJIO4HovAdWhihs1/9k2r+lmShfwHdFydYrX9cYwJ
         2ytVsPEQuofnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/2019 4:54 AM, Rafael J. Wysocki wrote:
> On Thursday, January 31, 2019 3:30:24 PM CET Thierry Reding wrote:
>> --Pk/CTwBz1VvfPIDp
>> Content-Type: text/plain; charset=3Dus-ascii
>> Content-Disposition: inline
>> Content-Transfer-Encoding: quoted-printable
>>
>> On Thu, Jan 31, 2019 at 01:10:01PM +0100, Rafael J. Wysocki wrote:
>>> On Thu, Jan 31, 2019 at 12:59 PM Takashi Iwai <tiwai@suse.de> wrote:
>>>> On Thu, 31 Jan 2019 12:46:54 +0100,
>>>> Rafael J. Wysocki wrote:
>>>>> On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wrote:
>>>>>> On Thu, 31 Jan 2019 12:05:30 +0100,
>>>>>> Thierry Reding wrote:
>>>>>>> On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
>>>>> [cut]
>>>>>
>>>>>>>> If I understand correctly the code, the pm domain is already ac=3D
>> tivated
>>>>>>>> at calling driver's probe callback.
>>>>>>> As far as I can tell, the domain will also be powered off again a=
=3D
>> fter
>>>>>>> probe finished, unless the device grabs a runtime PM reference. T=
=3D
>> his is
>>>>>>> what happens via the dev->pm_domain->sync() call after successful=
=3D
>>   probe
>>>>>>> of a driver.
>>>>>> Ah, a good point.  This can be a problem with a probe work like this
>>>>>> case.
>>>>>>
>>>>>>> It seems to me like it's not a very well defined case what to do =
=3D
>> when a
>>>>>>> device needs to be powered up but runtime PM is not enabled.
>>>>>>>
>>>>>>> Adding Rafael and linux-pm, maybe they can provide some guidance =
=3D
>> on what
>>>>>>> to do in these situations.
>>>>>>>
>>>>>>> To summarize, what we're debating here is how to handle powering =
=3D
>> up a
>>>>>>> device if the pm_runtime infrastructure doesn't take care of it. =
=3D
>> Jon's
>>>>>>> proposal here was, and we use this elsewhere, to do something lik=
=3D
>> e this:
>>>>>>>        pm_runtime_enable(dev);
>>>>>>>        if (!pm_runtime_enabled(dev)) {
>>>>>>>                err =3D3D foo_runtime_resume(dev);
>>>>>>>                if (err < 0)
>>>>>>>                        goto fail;
>>>>>>>        }
>>>>>>>
>>>>>>> So basically when runtime PM is not available, we explicitly "res=
=3D
>> ume"
>>>>>>> the device to power it up.
>>>>>>>
>>>>>>> It seems to me like that's a fairly common problem, so I'm wonder=
=3D
>> ing if
>>>>>>> there's something that the runtime PM core could do to help with =
=3D
>> this.
>>>>>>> Or perhaps there's already a way to achieve this that we're all
>>>>>>> overlooking?
>>>>>>>
>>>>>>> Rafael, any suggestions?
>>>>>> If any, a common helper would be appreciated, indeed.
>>>>> I'm not sure that I understand the problem correctly, so let me
>>>>> restate it the way I understand it.
>>>>>
>>>>> What we're talking about is a driver ->probe() callback.  Runtime PM
>>>>> is disabled initially and the device is off.  It needs to be powered
>>>>> up, but the way to do that depends on some configuration of the board
>>>>> etc., so ideally
>>>>>
>>>>> pm_runtime_enable(dev);
>>>>> ret =3D3D pm_runtime_resume(dev);
>>>>>
>>>>> should just work, but the question is what to do if runtime PM doesn'=
t
>>>>> work as expected.  That is, CONFIG_PM_RUNTIME is unset?  Or something
>>>>> else?
>>>> Yes, the question is how to write the code for both with and without
>>>> CONFIG_PM (or CONFIG_PM_RUNTIME).
>>> =3D20
>>> This basically is about setup, because after that point all should
>>> just work in both cases.
>>> =3D20
>>> Personally, I would do
>>> =3D20
>>> if (IS_ENABLED(CONFIG_PM)) {
>>>    do setup based on pm-runtime
>>> } else {
>>>    do manual setup
>>> }
>>> =3D20
>>>> Right now, we have a code like below, pushing the initialization in an
>>>> async work and let the probe returning quickly.
>>>>
>>>>          hda_tegra_probe() {
>>>>                  ....
>>> =3D20
>>> So why don't you do
>>> =3D20
>>> if (!IS_ENABLED(CONFIG_PM)) {
>>>    do manual clock setup
>>> }
>>> =3D20
>>> here?
>> I think that's exactly what Jon and Sameer were proposing, although the
>> discussion started primarily because of the way it was done.
>>
>> So basically the idea was to do:
>>
>> 	pm_runtime_enable()
>> 	if (!pm_runtime_enabled())  /* basically !IS_ENABLED(CONFIG_PM) */
> But why is it any better than checking !IS_ENABLED(CONFIG_PM) directly?
>
>> 		hda_runtime_resume()
>>
>> So we're not calling pm_runtime_resume() but rather the driver's
>> implementation of it. This is to avoid duplicating the code, which under
>> some circumstances can be fairly long. Duplicating is also error prone
>> because both instances may not always be in sync.
>>
>> My understanding is that Takashi had reservations about using this kind
>> of construct because, well, frankly, it looks a little weird.
> Yes, the way it was originally written above was weird, but is checking
> IS_ENABLED(CONFIG_PM) directly really so weird?
>
>> We'd also likely want to have a similar construct again in the ->remove(=
)
>> callback to make sure we properly power off the device when it is no lon=
ger
>> needed.
> Sure.  Again, why don't you make it conditional on IS_ENABLED(CONFIG_PM)?
>
>> I'm just wondering if perhaps there should be a mechanism in the
>> core to take care of this,
> How exactly?  How's the core going to know what to do when CONFIG_PM is
> disabled?
>
>> because this is basically something that we'd need to do for every singl=
e
>> driver.
> That is not true.  If the device is alwyas "on" to start with, you don't
> need to do anything.  That's the case on many systems.
>
>> For example, if !CONFIG_PM couldn't the pm_runtime_enable() function be
>> modified to do the above?
> But you'd need to pass a pointer to your hda_runtime_resume() to it at le=
ast
> and how's that simpler than using a simple conditional directly?
>
>> This would be somewhat tricky because drivers
>> usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
>> that would result in an empty structure if !CONFIG_PM, but we could
>> probably work around that by adding a __SET_RUNTIME_PM_OPS that would
>> never be compiled out for this kind of case. Or such drivers could even
>> manually set .runtime_suspend and .runtime_resume to make sure they're
>> always populated.
>>
>> Another way out of this would be to make sure we never run into the case
>> where runtime PM is disabled. If we always "select PM" on Tegra, then PM
>> should always be available. But is it guaranteed that runtime PM for the
>> devices is functional in that case? From a cursory look at the code it
>> would seem that way.
> If you select PM, then all of the requisite code should be there.
>
> Alternatively, you can make the driver depend on PM.
Objective is to have things working with or without CONFIG_PM enabled.
 From previous comments and discussions it appears that there is mixed=20
response
for calling hda_tegra_runtime_resume() or runtime PM APIs in probe()=20
call. Need
to have consensus regarding the best practice to be followed, which=20
would eventually
can be used in other drivers too.

Rafael is suggesting to use CONFIG_PM check to do manual setup or=20
runtime PM setup in probe,
which would bring back the earlier above mentioned concern.

if (IS_ENABLED(CONFIG_PM)) {
do setup based on pm-runtime
} else {
 =C2=A0=C2=A0=C2=A0 do manual setup
}
Both if/else might end up doing the same here.
Do we really need CONFIG_PM check here?

Instead does below proposal appear fine?

probe() {
 =C2=A0=C2=A0=C2=A0 hda_tegra_enable_clock();
}

probe_work() {
 =C2=A0=C2=A0=C2=A0 /* hda setup */
 =C2=A0=C2=A0=C2=A0 . . .
 =C2=A0=C2=A0=C2=A0 pm_runtime_set_active(); /* initial state as active */
 =C2=A0=C2=A0=C2=A0 pm_runtime_enable();
 =C2=A0=C2=A0=C2=A0 return;
}

remove() {
 =C2=A0=C2=A0=C2=A0 pm_runtime_disable();
 =C2=A0=C2=A0=C2=A0 if (!pm_runtime_status_suspended())
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 hda_tegra_runtime_suspend(); /* take=
s care of both CONFIG_PM=20
enable/disable case */
}

One of the other concern was, remove() and probe() do not appear to be=20
in sync, because in probe() hda_tegra_enable_clock()
is called and in remove() there is hda_tegra_runtime_suspend() to=20
effectively disable clock.
IMO, this should be ok since it can avoid duplication and proper comment=20
can be added here for clarity.
Alternatively we can call hda_tegra_runtime_resume() in probe()=20
unconditionally to avoid confusion.

Another point Thierry mentioned was, after successful probe()=20
power-domain would be turned OFF. It seems Rafael had a different
view. I am little confused here. Kindly clarify if above proposal seems=20
fine.

Thanks,
Sameer.

> Cheers,
> Rafael
>

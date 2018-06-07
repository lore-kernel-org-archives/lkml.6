Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bDfTFAGfGVtoVQAAmS7hNA
	; Thu, 07 Jun 2018 21:10:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 538F6605A2; Thu,  7 Jun 2018 21:10:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 90FC660290;
	Thu,  7 Jun 2018 21:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90FC660290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeFGVKF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:10:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56290 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752537AbeFGVKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:10:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89F761529;
        Thu,  7 Jun 2018 14:10:03 -0700 (PDT)
Received: from [192.168.0.21] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA4953F25D;
        Thu,  7 Jun 2018 14:09:57 -0700 (PDT)
Subject: Re: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
To: Kim Phillips <kim.phillips@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com>
 <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com>
 <20180607083401.GE16651@kroah.com>
 <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com>
 <20180607091353.GA20438@kroah.com>
 <2f8d233e-8847-ce3d-3a5b-06b175e3944b@arm.com>
 <20180607095322.GA26174@kroah.com>
 <adbabdb0-df2c-be74-3cde-cda4f6bce579@arm.com>
 <20180607121304.017d1d6804466050dd5c0af2@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <39d1089f-585d-bc19-2ecd-c9c9c812f85f@arm.com>
Date: Thu, 7 Jun 2018 22:10:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180607121304.017d1d6804466050dd5c0af2@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 06:13 PM, Kim Phillips wrote:
> On Thu, 7 Jun 2018 11:07:15 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> 
>> On 06/07/2018 10:53 AM, Greg Kroah-Hartman wrote:
>>> On Thu, Jun 07, 2018 at 10:32:21AM +0100, Suzuki K Poulose wrote:
>>>> On 06/07/2018 10:13 AM, Greg Kroah-Hartman wrote:
>>>>> On Thu, Jun 07, 2018 at 10:04:33AM +0100, Suzuki K Poulose wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> On 06/07/2018 09:34 AM, Greg Kroah-Hartman wrote:
>>>>>>> On Wed, Jun 06, 2018 at 03:55:01PM -0500, Kim Phillips wrote:
>>>>>>>> On Wed, 6 Jun 2018 10:46:36 +0100
>>>>>>>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>>>>>
>>>>>>>>> On 06/06/2018 09:24 AM, Greg Kroah-Hartman wrote:
>>>>>>>>>> On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
>>>>>>>>>>> Increment the refcnt for driver modules in current use by calling
>>>>>>>>>>> module_get in coresight_build_path and module_put in release_path.
>>>>>>>>>>>
>>>>>>>>>>> This prevents driver modules from being unloaded when they are in use,
>>>>>>>>>>> either in sysfs or perf mode.
>>>>>>>>>>
>>>>>>>>>> Why does it matter?  Shouldn't you be allowed to remove any module at
>>>>>>>>>> any point in time, much like a networking driver?
>>>>>>
>>>>>> The user doesn't have an explicit refcount on the individual components
>>>>>> in a trace session. So, when a trace session is in progress, it is as
>>>>>> good as having a "file" open on each component that is part of the
>>>>>> active trace session. So, we don't want the driver to be removed when
>>>>>> the component is being used in the trace collection.
>>>>>
>>>>> Why not?  What's wrong with that happening and then the trace collection
>>>>> starts failing with -ENODEV or something?
>>>>
>>>> May be I am missing something here. Can we allow the driver to be removed
>>>> when one of its device is "turned ON" and we need the same
>>>> driver to "turn it OFF" when the session ends ? To make a better
>>>> comparison :
>>>>
>>>> Can we unload a usb_mass_storage module when a USB disk(which uses the
>>>> module driver) is mounted and is being used ? I believe, the module
>>>> will eventually get unloaded when we unmount the disk, if someone did
>>>> a unload.
>>>
>>> No, mount causes the module count to be incrememted.  Mount and
>>> "open/close" are the old-school way of doing module reference counting.
>>>
>>> Look at how network drivers work today, you can unload any network
>>> driver even if there is a valid network connection "up and running"
>>> attached to it.  It just gets torn down when that request happens.
>>
>> Ok, that makes more sense now. Thanks for the hints. However, it doesn't
>> look that easy from the coresight point due to the way the devices are
>> used in an interconnected manner which could be part of multiple trace
>> sessions.
>>
>> e.g, a funnel could be part of two independent trace sessions with
>> different sets of sources/sinks. Tearing down the trace sessions is
>> going to be a difficult task unless we make drastic changes to the PMU
>> framework itself. But will see, what best we can do to make it modern
>> :-)
>>>
>>>> We have a similar situation here. The only difference is the driver is
>>>> referenced only when one of its device is in a trace session.
>>>
>>> I understand, I'm saying that you have to be very careful when messing
>>> around with module reference counts to get it correct and perhaps you
>>> should just change your design to not care about module reference counts
>>> at all, like networking did 15+ years ago.
>>>
>>> Let's learn from the good examples in our past (like networking), and
>>> not like the older bad examples (like mount/files).
>>>
>>>>> Remember, removing a kernel module is something that only happens very
>>>>> rarely, and is an explicit choice by someone with root permissions.  If
>>>>> you want to remove that module, it should be able to go, as you know
>>>>> what you are doing at that point in time.
>>>>
>>>> Right, but when a device is "in use" can we do that ? I thought the user
>>>> will get a module is in use or busy, error.
>>>
>>> Try it on networking today :)
>>>
>>>>> Don't try to "protect the user from themselves" here, they want to shoot
>>>>> their foot, make it hurt if they are aiming it there :)
>>>>>
>>>>
>>>> The module_get/put added here are only triggered when we start a trace
>>>> session, where we build a path for the current session from the configured
>>>> "source" to the configured "sink" and the path is destroyed
>>>> at the end of the trace session. i.e, the path is not a permanent thing.
>>>> It is constructed per session. So it is perfectly possible to remove a
>>>> device in between trace sessions.
>>>
>>> That's fine, but again, just be careful to get this correct.  The patch
>>> I reviewed did not seem to do that.
>>
>> Thanks for the useful suggestions, we will explore this more.

Kim,

> 
> I'm going to assume the series is still valid after this discussion,
> since technically just this patch can get dropped, and the user is able
> to shoot themselves in the foot.

That doesn't mean the kernel can panic() if the user decided to unload 
the module while the trace session is in progress. It only means that
the trace session could be stopped in between in the worst case. But
nothing more harmful to the system.

>  This series is for development  purposes, after all.

Do you mean that this series is for internal development purposes and 
not upstream ? Making the drivers modular are always helpful, especially 
for something related to tracing, that allows the module to be unloaded 
after use. So, it would be good to have this series in, but in a manner 
which is usable and doesn't cause harm to the overall system usage.

I think the summary of the discussion is that we need more robust code
to handle the situation, which also allows unloading the modules without
any trouble.

Cheers

Suzuki

> 
> Let me know if I'm missing something.
> 
> Thanks,
> 
> Kim
> 

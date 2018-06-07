Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id N8/hKMr7GFtXDAAAmS7hNA
	; Thu, 07 Jun 2018 09:32:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 943E8607E7; Thu,  7 Jun 2018 09:32:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0AF0F601C3;
	Thu,  7 Jun 2018 09:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AF0F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeFGJcx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:32:53 -0400
Received: from foss.arm.com ([217.140.101.70]:49166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932377AbeFGJcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:32:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BDBE15AB;
        Thu,  7 Jun 2018 02:32:21 -0700 (PDT)
Received: from [10.37.9.91] (unknown [10.37.9.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12A113F5A0;
        Thu,  7 Jun 2018 02:32:15 -0700 (PDT)
Subject: Re: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kim Phillips <kim.phillips@arm.com>,
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
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2f8d233e-8847-ce3d-3a5b-06b175e3944b@arm.com>
Date: Thu, 7 Jun 2018 10:32:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180607091353.GA20438@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 10:13 AM, Greg Kroah-Hartman wrote:
> On Thu, Jun 07, 2018 at 10:04:33AM +0100, Suzuki K Poulose wrote:
>> Hi Greg,
>>
>> On 06/07/2018 09:34 AM, Greg Kroah-Hartman wrote:
>>> On Wed, Jun 06, 2018 at 03:55:01PM -0500, Kim Phillips wrote:
>>>> On Wed, 6 Jun 2018 10:46:36 +0100
>>>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>
>>>>> On 06/06/2018 09:24 AM, Greg Kroah-Hartman wrote:
>>>>>> On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
>>>>>>> Increment the refcnt for driver modules in current use by calling
>>>>>>> module_get in coresight_build_path and module_put in release_path.
>>>>>>>
>>>>>>> This prevents driver modules from being unloaded when they are in use,
>>>>>>> either in sysfs or perf mode.
>>>>>>
>>>>>> Why does it matter?  Shouldn't you be allowed to remove any module at
>>>>>> any point in time, much like a networking driver?
>>
>> The user doesn't have an explicit refcount on the individual components
>> in a trace session. So, when a trace session is in progress, it is as
>> good as having a "file" open on each component that is part of the
>> active trace session. So, we don't want the driver to be removed when
>> the component is being used in the trace collection.
> 
> Why not?  What's wrong with that happening and then the trace collection
> starts failing with -ENODEV or something?

May be I am missing something here. Can we allow the driver to be 
removed when one of its device is "turned ON" and we need the same
driver to "turn it OFF" when the session ends ? To make a better
comparison :

Can we unload a usb_mass_storage module when a USB disk(which uses the 
module driver) is mounted and is being used ? I believe, the module
will eventually get unloaded when we unmount the disk, if someone did
a unload.

We have a similar situation here. The only difference is the driver is
referenced only when one of its device is in a trace session.

> 
> Remember, removing a kernel module is something that only happens very
> rarely, and is an explicit choice by someone with root permissions.  If
> you want to remove that module, it should be able to go, as you know
> what you are doing at that point in time.

Right, but when a device is "in use" can we do that ? I thought the user
will get a module is in use or busy, error.


> 
> Don't try to "protect the user from themselves" here, they want to shoot
> their foot, make it hurt if they are aiming it there :)
> 

The module_get/put added here are only triggered when we start a trace 
session, where we build a path for the current session from the 
configured "source" to the configured "sink" and the path is destroyed
at the end of the trace session. i.e, the path is not a permanent thing.
It is constructed per session. So it is perfectly possible to remove a
device in between trace sessions.

>> This will be
>> released as soon as the session is ended. It is just like a PMU driver
>> where the module refcount is held to ensure the module stays until the
>> session is over. In this case, we have multiple components, each with
>> its own driver invisible to the PMU driver. Hence the coresight driver
>> must hold the reference.
> 
> Again, please think this through and don't add extra complexity to the
> normal path, and get it right if you do it (the existing patch is not
> right as I pointed out.)  Personally, I feel the code should just be
> able to be unloaded whenever they want, user beware...

Sure, will explore more to refine the code. Thanks for the trigger.

Cheers
Suzuki

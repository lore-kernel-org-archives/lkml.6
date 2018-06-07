Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IW+zLTemGVvrAwAAmS7hNA
	; Thu, 07 Jun 2018 21:40:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6E03C6074D; Thu,  7 Jun 2018 21:40:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuD2KE7C"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7C79C605A2;
	Thu,  7 Jun 2018 21:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C79C605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeFGVkr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:40:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32819 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752615AbeFGVkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:40:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so4765835wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KtLmFu33foNz9gMnPIyqDswcvU38GK2V8IeOId/vc44=;
        b=QuD2KE7CbsLBzkWdDxZh4SwLMA9Nkg3F3TdcJxGpLzVcMvMDA+8e/Jg6V9WfmgaCNa
         8Ijep+PEykMRYtfGNZso7D5KzP5v2WBhKdK7J7z0xQ6Z3tq4U+qSTMnflEWqxRZlK6oO
         XSBwHjonc1BmjX1F4usOFIdUsK+1vSvDKchxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KtLmFu33foNz9gMnPIyqDswcvU38GK2V8IeOId/vc44=;
        b=hlKMgVttykxBGH6FzbQKa4JcJydT9277x7drvwSSQPkDn5+YjMxu2u63VwVWC83xWo
         Abc0vIzwRjrwtOIXGPd6jT0uiFUsdN6l0kxoiK7ywdHRad+L96DrG1QStVJJwGNgGOmo
         2y1GJqPC+BsRnTlWCT7WMN1Ar/bge4HN1mPNLAohK7wHcyOVMPgEblclsWukSO7uDJkv
         UvZKhQY2tIV+IfjS0KRxdWKZS6Ncy1EIpFfjP6PJ8SwzJpCuGtKA5qfqM/3DhnRHUTx9
         TVFnHhjfYlc5nve3/GdMoz+jX6EnPFSl2/jsDE2WqtqwiLEG3M+RMU4Jwca3a9ZGoXfr
         Xbtg==
X-Gm-Message-State: APt69E2bMaHNh/iCdoqGjICs1t0a+hC950xCMeeqCCXAjdUa1cnYdBTB
        5RWhVVmhKBUQ5mErA2Es4BWyCJjlhGDgLq8+RkJX3A==
X-Google-Smtp-Source: ADUXVKKiHaiVXAppde9adUQRIbcJWnSFPGslY69gY+YTF2kG0iQWnbqThPtffGrg6y4wvgBtwP23qjHvAUu8fvpDoH8=
X-Received: by 2002:a50:b003:: with SMTP id i3-v6mr4100419edd.293.1528407644598;
 Thu, 07 Jun 2018 14:40:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a48a:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 14:40:43 -0700 (PDT)
In-Reply-To: <39d1089f-585d-bc19-2ecd-c9c9c812f85f@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com> <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com> <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com> <20180607083401.GE16651@kroah.com>
 <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com> <20180607091353.GA20438@kroah.com>
 <2f8d233e-8847-ce3d-3a5b-06b175e3944b@arm.com> <20180607095322.GA26174@kroah.com>
 <adbabdb0-df2c-be74-3cde-cda4f6bce579@arm.com> <20180607121304.017d1d6804466050dd5c0af2@arm.com>
 <39d1089f-585d-bc19-2ecd-c9c9c812f85f@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 7 Jun 2018 15:40:43 -0600
Message-ID: <CANLsYkwEh9H9cP7ihw2iNzne-+=nZ2KE8OMXV3oN1L1WLKhrpA@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] coresight: get/put module in coresight_build/release_path
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 June 2018 at 15:10, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> On 06/07/2018 06:13 PM, Kim Phillips wrote:
>>
>> On Thu, 7 Jun 2018 11:07:15 +0100
>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>>> On 06/07/2018 10:53 AM, Greg Kroah-Hartman wrote:
>>>>
>>>> On Thu, Jun 07, 2018 at 10:32:21AM +0100, Suzuki K Poulose wrote:
>>>>>
>>>>> On 06/07/2018 10:13 AM, Greg Kroah-Hartman wrote:
>>>>>>
>>>>>> On Thu, Jun 07, 2018 at 10:04:33AM +0100, Suzuki K Poulose wrote:
>>>>>>>
>>>>>>> Hi Greg,
>>>>>>>
>>>>>>> On 06/07/2018 09:34 AM, Greg Kroah-Hartman wrote:
>>>>>>>>
>>>>>>>> On Wed, Jun 06, 2018 at 03:55:01PM -0500, Kim Phillips wrote:
>>>>>>>>>
>>>>>>>>> On Wed, 6 Jun 2018 10:46:36 +0100
>>>>>>>>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>>>>>>
>>>>>>>>>> On 06/06/2018 09:24 AM, Greg Kroah-Hartman wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Increment the refcnt for driver modules in current use by
>>>>>>>>>>>> calling
>>>>>>>>>>>> module_get in coresight_build_path and module_put in
>>>>>>>>>>>> release_path.
>>>>>>>>>>>>
>>>>>>>>>>>> This prevents driver modules from being unloaded when they are
>>>>>>>>>>>> in use,
>>>>>>>>>>>> either in sysfs or perf mode.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Why does it matter?  Shouldn't you be allowed to remove any
>>>>>>>>>>> module at
>>>>>>>>>>> any point in time, much like a networking driver?
>>>>>>>
>>>>>>>
>>>>>>> The user doesn't have an explicit refcount on the individual
>>>>>>> components
>>>>>>> in a trace session. So, when a trace session is in progress, it is as
>>>>>>> good as having a "file" open on each component that is part of the
>>>>>>> active trace session. So, we don't want the driver to be removed when
>>>>>>> the component is being used in the trace collection.
>>>>>>
>>>>>>
>>>>>> Why not?  What's wrong with that happening and then the trace
>>>>>> collection
>>>>>> starts failing with -ENODEV or something?
>>>>>
>>>>>
>>>>> May be I am missing something here. Can we allow the driver to be
>>>>> removed
>>>>> when one of its device is "turned ON" and we need the same
>>>>> driver to "turn it OFF" when the session ends ? To make a better
>>>>> comparison :
>>>>>
>>>>> Can we unload a usb_mass_storage module when a USB disk(which uses the
>>>>> module driver) is mounted and is being used ? I believe, the module
>>>>> will eventually get unloaded when we unmount the disk, if someone did
>>>>> a unload.
>>>>
>>>>
>>>> No, mount causes the module count to be incrememted.  Mount and
>>>> "open/close" are the old-school way of doing module reference counting.
>>>>
>>>> Look at how network drivers work today, you can unload any network
>>>> driver even if there is a valid network connection "up and running"
>>>> attached to it.  It just gets torn down when that request happens.
>>>
>>>
>>> Ok, that makes more sense now. Thanks for the hints. However, it doesn't
>>> look that easy from the coresight point due to the way the devices are
>>> used in an interconnected manner which could be part of multiple trace
>>> sessions.
>>>
>>> e.g, a funnel could be part of two independent trace sessions with
>>> different sets of sources/sinks. Tearing down the trace sessions is
>>> going to be a difficult task unless we make drastic changes to the PMU
>>> framework itself. But will see, what best we can do to make it modern
>>> :-)
>>>>
>>>>
>>>>> We have a similar situation here. The only difference is the driver is
>>>>> referenced only when one of its device is in a trace session.
>>>>
>>>>
>>>> I understand, I'm saying that you have to be very careful when messing
>>>> around with module reference counts to get it correct and perhaps you
>>>> should just change your design to not care about module reference counts
>>>> at all, like networking did 15+ years ago.
>>>>
>>>> Let's learn from the good examples in our past (like networking), and
>>>> not like the older bad examples (like mount/files).
>>>>
>>>>>> Remember, removing a kernel module is something that only happens very
>>>>>> rarely, and is an explicit choice by someone with root permissions.
>>>>>> If
>>>>>> you want to remove that module, it should be able to go, as you know
>>>>>> what you are doing at that point in time.
>>>>>
>>>>>
>>>>> Right, but when a device is "in use" can we do that ? I thought the
>>>>> user
>>>>> will get a module is in use or busy, error.
>>>>
>>>>
>>>> Try it on networking today :)
>>>>
>>>>>> Don't try to "protect the user from themselves" here, they want to
>>>>>> shoot
>>>>>> their foot, make it hurt if they are aiming it there :)
>>>>>>
>>>>>
>>>>> The module_get/put added here are only triggered when we start a trace
>>>>> session, where we build a path for the current session from the
>>>>> configured
>>>>> "source" to the configured "sink" and the path is destroyed
>>>>> at the end of the trace session. i.e, the path is not a permanent
>>>>> thing.
>>>>> It is constructed per session. So it is perfectly possible to remove a
>>>>> device in between trace sessions.
>>>>
>>>>
>>>> That's fine, but again, just be careful to get this correct.  The patch
>>>> I reviewed did not seem to do that.
>>>
>>>
>>> Thanks for the useful suggestions, we will explore this more.
>
>
> Kim,
>
>>
>> I'm going to assume the series is still valid after this discussion,
>> since technically just this patch can get dropped, and the user is able
>> to shoot themselves in the foot.
>
>
> That doesn't mean the kernel can panic() if the user decided to unload the
> module while the trace session is in progress. It only means that
> the trace session could be stopped in between in the worst case. But
> nothing more harmful to the system.
>
>>  This series is for development  purposes, after all.
>
>
> Do you mean that this series is for internal development purposes and not
> upstream ? Making the drivers modular are always helpful, especially for
> something related to tracing, that allows the module to be unloaded after
> use. So, it would be good to have this series in, but in a manner which is
> usable and doesn't cause harm to the overall system usage.

Correct, we can't have a patchset that generates a kernel panic.

>
> I think the summary of the discussion is that we need more robust code
> to handle the situation, which also allows unloading the modules without
> any trouble.

The tricky part is the "unloading without any trouble".  The first
thing to so is if the driver is being used, the _remove() functions
need to go through the same process as it would under normal
condition.  That will allow to reinsert the module and have a fairly
good level of assurance that things will work properly.

Looking at things a little closer all the interconnection dependencies
in the core are done using a csdev and a lot of the current code is
already checking for a NULL condition (more checks may be needed with
the introduction of this set).  The real problem is with the "path"
used to keep track of the devices taking part in active sessions.
Those can be accessed when a process is swapped in and out, mandating
something fast and efficient.  One thing we could do is in a path,
keep track of a reference on csdev rather than make a copy of their
addresses.  That way the _remove() functions could simply set those to
NULL, making it easy to deal with.

>
> Cheers
>
> Suzuki
>
>>
>> Let me know if I'm missing something.
>>
>> Thanks,
>>
>> Kim
>>
>

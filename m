Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E520C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29B82147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbfBMNHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:07:03 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35546 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733281AbfBMNHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:07:03 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544482800"; 
   d="scan'208";a="369257766"
Received: from unknown (HELO [193.50.110.185]) ([193.50.110.185])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA; 13 Feb 2019 14:06:59 +0100
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal
 RAM
From:   Brice Goglin <Brice.Goglin@inria.fr>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Takashi Iwai <tiwai@suse.de>,
        Ross Zwisler <zwisler@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
References: <20190124231441.37A4A305@viggo.jf.intel.com>
 <20190124231448.E102D18E@viggo.jf.intel.com>
 <c4c6aca8-6ee8-be10-65ae-4cbe0aa03bfb@inria.fr>
 <26ac36f4-7391-5321-217b-50d67e2119d7@intel.com>
 <453f13cd-a7fe-33eb-9a27-8490825ca29c@inria.fr>
 <CAPcyv4jF7ZyKaFDw7nb04UvWkVWGJdLGkZDQ1g=X7i+kdu7JRg@mail.gmail.com>
 <a3bfe739-228e-26fe-90f7-4a4f8ceb3a9a@inria.fr>
 <CAPcyv4jJ=C7ZEsJqBxzBMsQWz4+C8BZmWuk7OkztOebprd2rMg@mail.gmail.com>
 <057ad938-e745-02f7-edce-e19bd326da6a@inria.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=Brice.Goglin@inria.fr; prefer-encrypt=mutual; keydata=
 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
Message-ID: <eb58cb96-1f61-2dd2-b1ab-5a7d4df78297@inria.fr>
Date:   Wed, 13 Feb 2019 14:06:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <057ad938-e745-02f7-edce-e19bd326da6a@inria.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 13/02/2019 à 09:43, Brice Goglin a écrit :
> Le 13/02/2019 à 09:24, Dan Williams a écrit :
>> On Wed, Feb 13, 2019 at 12:12 AM Brice Goglin <Brice.Goglin@inria.fr> wrote:
>>> Le 13/02/2019 à 01:30, Dan Williams a écrit :
>>>> On Tue, Feb 12, 2019 at 11:59 AM Brice Goglin <Brice.Goglin@inria.fr> wrote:
>>>>> # ndctl disable-region all
>>>>> # ndctl zero-labels all
>>>>> # ndctl enable-region region0
>>>>> # ndctl create-namespace -r region0 -t pmem -m devdax
>>>>> {
>>>>>   "dev":"namespace0.0",
>>>>>   "mode":"devdax",
>>>>>   "map":"dev",
>>>>>   "size":"1488.37 GiB (1598.13 GB)",
>>>>>   "uuid":"ad0096d7-3fe7-4402-b529-ad64ed0bf789",
>>>>>   "daxregion":{
>>>>>     "id":0,
>>>>>     "size":"1488.37 GiB (1598.13 GB)",
>>>>>     "align":2097152,
>>>>>     "devices":[
>>>>>       {
>>>>>         "chardev":"dax0.0",
>>>>>         "size":"1488.37 GiB (1598.13 GB)"
>>>>>       }
>>>>>     ]
>>>>>   },
>>>>>   "align":2097152
>>>>> }
>>>>> # ndctl enable-namespace namespace0.0
>>>>> # echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/remove_id
>>>>> <hang>
>>>>>
>>>>> I tried with and without dax_pmem_compat loaded, but it doesn't help.
>>>> I think this is due to:
>>>>
>>>>   a9f1ffdb6a20 device-dax: Auto-bind device after successful new_id
>>>>
>>>> I missed that this path is also called in the remove_id path. Thanks
>>>> for the bug report! I'll get this fixed up.
>>> Now that remove_id is fixed, things fails later in Dave's procedure:
>>>
>>> # echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/remove_id
>>> # echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
>>> # echo -n dax0.0 > /sys/bus/dax/drivers/kmem/new_id
>> In the current version of the code the bind is not necessary, so the
>> lack of error messages here means the bind succeeded.


It looks like "unbind" is required to make the PMEM appear as a new
node. If I remove_id from devdax and new_id to kmem without "unbind" in
the middle, nothing appears.

Writing to "kmem/bind" didn't seem necessary.

Brice



>>
>>> # echo -n dax0.0 > /sys/bus/dax/drivers/kmem/bind
>>> -bash: echo: write error: No such device
>> This also happens when the device is already bound.
>>
>>> (And nothing seems to have changed in /sys/devices/system/memory/*/state)
>> What does "cat /proc/iomem" say?
>
> 3060000000-1aa5fffffff : Persistent Memory
>   3060000000-36481fffff : namespace0.0
>   3680000000-1a9ffffffff : dax0.0
>     3680000000-1a9ffffffff : System RAM
> (the last line wasn't here before attaching to kmem)
>
> I said nothing changed in memory/*/state, I actually meant that nothing
> was offline. But things are actually working!
>
> First, node4 appeared, all memory is already attached to it without
> having to write to memory/*/state
>
> Node 4 MemTotal:       1558183936 kB
> Node 4 MemFree:        1558068564 kB
> Node 4 MemUsed:          115372 kB
>
> I wasn't expecting node4 to appear because the machine has no
> /sys/firmware/acpi/tables/HMAT when running in 1LM (there's one in 2LM).
> I thought you said in the past that no HMAT would mean memory would be
> added to the existing DDR node?
>
> Thanks!
>
> Brice
>
>

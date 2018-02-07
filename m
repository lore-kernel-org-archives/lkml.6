Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeBGR1A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:27:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53930 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754412AbeBGR06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:26:58 -0500
Subject: Re: [PATCH] kconfig: Remove last trace of GENERIC_IO
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <422a4ff024038db02a2952158b0babe5b9281b2b.1517922544.git.robin.murphy@arm.com>
 <CAL_JsqKZ8xzKD=ncTyT1LzCe0+gRL1pzcjDVOyBv61hUTGESnA@mail.gmail.com>
 <16de2ed2-c2d8-8236-b001-2bc78e4c1d2f@arm.com>
 <CAL_JsqJ1Hc8irF4LWM=1=OACC=fmRbg4c1evV777zKj3XOzi=w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <dc837b10-a41d-4eb3-c14e-ca3fc69a55a9@arm.com>
Date: Wed, 7 Feb 2018 17:26:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ1Hc8irF4LWM=1=OACC=fmRbg4c1evV777zKj3XOzi=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 17:15, Rob Herring wrote:
> On Feb 6, 2018 8:14 AM, "Robin Murphy" <robin.murphy@arm.com> wrote:
>>
>> On 06/02/18 16:06, Rob Herring wrote:
>>>
>>> On Tue, Feb 6, 2018 at 7:11 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> Since commit 9de8da47742b ("kconfig: kill off GENERIC_IO option"), this
>>>> select has done nothing, and is now just confusing. Clean it up.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>    lib/Kconfig | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>
>>>
>>> We already have:
>>>
>>> https://lkml.org/lkml/2018/1/17/924
>>>
>>> and this series:
>>>
>>> https://lkml.org/lkml/2018/2/4/208
>>
>>
>> Agh, Ulf's patch is even sat in my inbox...
>>
>> This was just a drive-by from looking into HAS_IOMEM, sorry for the noise :)
> 
> What are you looking into there? IMO, we should get rid of HAS_IOMEM.
> It's basically a !UML option to turn off a bunch of drivers in UML.

I was just having a quick investigate out of curiosity after Geert 
raised it in the context of awkward COMPILE_TEST dependencies here:

https://lists.linuxfoundation.org/pipermail/iommu/2018-February/025963.html

I don't have the bandwidth myself to actually work on burying it, but it 
does seem like that might be feasible.

Robin.

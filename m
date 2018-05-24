Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965568AbeEXIy0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:54:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965545AbeEXIyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:54:22 -0400
Subject: Re: [PATCH RFCv2 1/4] ACPI: NUMA: export pxm_to_node
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20180523182404.11433-1-david@redhat.com>
 <20180523182404.11433-2-david@redhat.com>
 <CAJZ5v0jar8TqC5MGRPcAVZfM3LmmoSV3fT3Sgok=r6D9cDG0+w@mail.gmail.com>
 <5342a59c-4ca1-2cf5-a1d4-07a6d6f03587@redhat.com>
 <CAJZ5v0grgYRi24oyFP0xcjip5Z5apLE5ozn8znahdtkqKvD_MA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9cf4c5f3-f1ee-67c2-967e-07aa568685c4@redhat.com>
Date: Thu, 24 May 2018 10:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0grgYRi24oyFP0xcjip5Z5apLE5ozn8znahdtkqKvD_MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.2018 10:47, Rafael J. Wysocki wrote:
> On Thu, May 24, 2018 at 10:33 AM, David Hildenbrand <david@redhat.com> wrote:
>> On 24.05.2018 10:12, Rafael J. Wysocki wrote:
>>> On Wed, May 23, 2018 at 8:24 PM, David Hildenbrand <david@redhat.com> wrote:
>>>> Will be needed by paravirtualized memory devices.
>>>
>>> That's a little information.
>>>
>>> It would be good to see the entire series at least.
>>
>> It's part of this series (guess you only received the cover letter and
>> this patch). Here a link to the patch using it:
>>
>> https://lkml.org/lkml/2018/5/23/803
> 
> OK, thanks!
> 
> It looks like you have a reason to use it in there, but please note
> that CONFIG_ACPI_NUMA depends on CONFIG_NUMA, so you don't need to use
> the latter directly in the #ifdef.  Also wouldn't IS_ENABLED() work
> there?

Thanks for the tip on CONFIG_ACPI_NUMA. Wouldn't IS_ENABLED() require to
have a dummy implementation of pxm_to_node() in case drivers/acpi/numa.c
is not compiled?

> 
> Moreover, you don't need the local node variable in
> virtio_mem_translate_node_id().
> 

Indeed, thanks!

-- 

Thanks,

David / dhildenb

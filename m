Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754233AbeEWIIe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:08:34 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39640 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754255AbeEWII3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:08:29 -0400
X-Google-Smtp-Source: AB8JxZo/F3AbRTxPyqjaBUAS3DVA43hIMteXXrlAsPr5rxhPhrPcEWyOgd3WF1Z4T9yGuw/q6Fr2mZy7Gl2DlmmC7uo=
MIME-Version: 1.0
In-Reply-To: <425bceb1-a03c-06da-f39c-1299662fb6b0@cn.fujitsu.com>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
 <20180320110432.28127-5-douly.fnst@cn.fujitsu.com> <alpine.DEB.2.21.1805191704150.1599@nanos.tec.linutronix.de>
 <7c33b3bd-7e9d-1583-737c-d2edd457bd1a@cn.fujitsu.com> <425bceb1-a03c-06da-f39c-1299662fb6b0@cn.fujitsu.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 May 2018 10:08:28 +0200
X-Google-Sender-Auth: 4gUbRATX0y3GUCK0e4BtZMqBycY
Message-ID: <CAJZ5v0hVUL0OdErMrKZyEST-LqboDfvVXYDMGiiuvTXewMCEnQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] acpi/processor: Fix the return value of acpi_processor_ids_walk()
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 3:34 AM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> At 05/22/2018 09:47 AM, Dou Liyang wrote:
>>
>>
>>
>> At 05/19/2018 11:06 PM, Thomas Gleixner wrote:
>>>
>>> On Tue, 20 Mar 2018, Dou Liyang wrote:
>>>
>>>> ACPI driver should make sure all the processor IDs in their ACPI
>>>> Namespace
>>>> are unique for CPU hotplug. the driver performs a depth-first walk of
>>>> the
>>>> namespace tree and calls the acpi_processor_ids_walk().
>>>>
>>>> But, the acpi_processor_ids_walk() will return true if one processor is
>>>> checked, that cause the walk break after walking pass the first
>>>> processor.
>>>>
>>>> Repace the value with AE_OK which is the standard acpi_status value.
>>>>
>>>> Fixes 8c8cb30f49b8 ("acpi/processor: Implement DEVICE operator for
>>>> processor enumeration")
>>>>
>>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>>> ---
>>>>   drivers/acpi/acpi_processor.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/acpi_processor.c
>>>> b/drivers/acpi/acpi_processor.c
>>>> index 449d86d39965..db5bdb59639c 100644
>>>> --- a/drivers/acpi/acpi_processor.c
>>>> +++ b/drivers/acpi/acpi_processor.c
>>>> @@ -663,11 +663,11 @@ static acpi_status __init (acpi_handle handle,
>>>>       }
>>>>       processor_validated_ids_update(uid);
>>>> -    return true;
>>>> +    return AE_OK;
>>>>   err:
>>>>       acpi_handle_info(handle, "Invalid processor object\n");
>>>> -    return false;
>>>> +    return AE_OK;
>>>
>>>
>>> I'm not sure whether this is the right return value here. Rafael?
>>>
>
> +Cc Rafael's common used email address.
>
> I am sorry, I created the cc list using ./script/get_maintainers.pl ...
> and didn't check it.

No worries, I saw your messages, but thanks!

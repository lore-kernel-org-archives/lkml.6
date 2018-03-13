Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AG47ELtIkB12Dh7AVZ+WKf1XG3/c07ua49HYG+xwpzGDssscKzsv/mIPmjOyVhKnRae4lB6ch+7u
ARC-Seal: i=1; a=rsa-sha256; t=1520951953; cv=none;
        d=google.com; s=arc-20160816;
        b=kbHCzpCiau9m3JSleNcsgv6Wvcaq490rdwxrA9nOw+HoFhPrLPUVPFgAQgqokd/aoC
         dLLB4zHYNWgkCSFqhyp4SRVmIaA6LZT+IUPKKumhL/rBXeqZ9h+KLKMA3w+1PBP1WHOi
         j7ULZj3xusGc+DXl89m7Glb2tKmEmDAaM4WBHAAD1lIUv94TKMIoRNPQ0EzRDL07NbrX
         5OqcBAEjF/Sersil1yOkpHXE7zWkEnldJuDeLg0YsmNXVZle+YdsdfYlxY0Ag61Gp7Ry
         0jCNYRsEWjglpZtmcHiRBlqE9ZWzdBY/zVUC9VOq02hePA0GzO8TrvjE2hMiJ6pWJOro
         Pz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=gILkTrsjYJCXjY3cCJjPhJLlOabmgqKlYJXfXgiPOjA=;
        b=gnL4xw6VazJePVGpr8JFi57BUCPJWpxW/G8CADmu7a9k20qsf0ejjUi9jydF1jEUkD
         j0XitHjFzMmnE8PQK3s8zUTdQhyIsWApojyhg7/fKthJ/k8mHrQ4kRRqKLCOzvonn81v
         Botp2YRtEA/9RyX6Mp0A3/X4ERwdoHcZggwNO3sMciNgo9HeMJGvAkNwRlhZS4KpgaGa
         ruCsmZVXX75F2D8V3aoD9pQbH7wlhxidYFgCKwTeEnU5q465R+kZIgiNz5RhQPlmmO7/
         31k2RL+TMLrd3sCxcJhwqjBn/jezHUhGstW+wQ78gu4/nL/2bMm92dYed0C0sw22AiC2
         4wcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=KNDuY/Gb;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SoKO4I/+;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=KNDuY/Gb;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SoKO4I/+;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D53F760854
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <4eaf2006-ea68-d9e9-a0db-89acec0ea299@arm.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-2-vivek.gautam@codeaurora.org> <8903307.QazHKW0JrR@aspire.rjw.lan>
 <CAFp+6iE=0PD6fZZVd+bC1Z95Lkt=X-F4YOXz8EtdiXL=jsC1RA@mail.gmail.com> <4eaf2006-ea68-d9e9-a0db-89acec0ea299@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Tue, 13 Mar 2018 20:09:09 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGaAbXOj2hXf12oQzi57J2DX+13f86oprOezyF8rkeyNg@mail.gmail.com>
Message-ID: <CAFp+6iGaAbXOj2hXf12oQzi57J2DX+13f86oprOezyF8rkeyNg@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
	"robh+dt" <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	Tomasz Figa <tfiga@chromium.org>, Sricharan R <sricharan@codeaurora.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Archit Taneja <architt@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594833715192303170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Robin,


On Tue, Mar 13, 2018 at 6:19 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 13/03/18 09:55, Vivek Gautam wrote:
>>
>> On Tue, Mar 13, 2018 at 3:10 PM, Rafael J. Wysocki <rjw@rjwysocki.net>
>> wrote:
>>>
>>> On Tuesday, March 13, 2018 9:55:30 AM CET Vivek Gautam wrote:
>>>>
>>>> The lists managing the device-links can be traversed to
>>>> find the link between two devices. The device_link_add() APIs
>>>> does traverse these lists to check if there's already a link
>>>> setup between the two devices.
>>>> So, add a new APIs, device_link_find(), to find an existing
>>>> device link between two devices - suppliers and consumers.
>>>>
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>>
>>>>   * New patch added to this series.
>>>>
>>>>   drivers/base/core.c    | 30 +++++++++++++++++++++++++++---
>>>>   include/linux/device.h |  2 ++
>>>>   2 files changed, 29 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>> index 5847364f25d9..e8c9774e4ba2 100644
>>>> --- a/drivers/base/core.c
>>>> +++ b/drivers/base/core.c
>>>> @@ -144,6 +144,30 @@ static int device_reorder_to_tail(struct device
>>>> *dev, void *not_used)
>>>>        return 0;
>>>>   }
>>>>
>>>> +/**
>>>> + * device_link_find - find any existing link between two devices.
>>>> + * @consumer: Consumer end of the link.
>>>> + * @supplier: Supplier end of the link.
>>>> + *
>>>> + * Returns pointer to the existing link between a supplier and
>>>> + * and consumer devices, or NULL if no link exists.
>>>> + */
>>>> +struct device_link *device_link_find(struct device *consumer,
>>>> +                                  struct device *supplier)
>>>> +{
>>>> +     struct device_link *link = NULL;
>>>> +
>>>> +     if (!consumer || !supplier)
>>>> +             return NULL;
>>>> +
>>>> +     list_for_each_entry(link, &supplier->links.consumers, s_node)
>>>> +             if (link->consumer == consumer)
>>>> +                     break;
>>>> +
>>>
>>>
>>> Any mutual exclusion?
>>>
>>> Or is the caller expected to take care of it?  And if so, then how?
>>
>>
>> I think it's better that we take care of lock here in the code rather
>> than depending
>> on the caller.
>> But i can't take device_links_write_lock() since device_link_add()
>> already takes that.
>
>
> Well, the normal pattern is to break out the internal helper function as-is,
> then add a public wrapper which validates inputs, handles locking, etc.,
> equivalently to existing caller(s). See what device_link_del() and others
> do, e.g.:
>
> static struct device_link *__device_link_find(struct device *consumer,
>                 struct device *supplier)
> {
>         list_for_each_entry(link, &supplier->links.consumers, s_node)
>                 if (link->consumer == consumer)
>                         return link;
>         return NULL;
> }
>
> struct device_link *device_link_find(struct device *consumer,
>                 struct device *supplier)
> {
>         struct device_link *link;
>
>         if (!consumer || !supplier)
>                 return NULL;
>
>         device_links_write_lock();
>         link = __device_link_find(consumer, supplier);
>         device_links_write_unlock();
>         return link;
> }
>
> where device_link_add() would call __device_link_find() directly.

Right, I understand it now. Thanks for detailed explanation.

regards
Vivek

>
> However, as Tomasz points out (and I hadn't really considered), if the only
> reasonable thing to with a link once you've found it is to delete it, then
> in terms of the public API it may well make more sense to just implement
> something like a device_link_remove() which does both in one go.
>
> Robin.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

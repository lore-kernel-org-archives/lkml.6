Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AG47ELtXII0ejTogXJ7wCDdsu9StNMQhZ/95TXuUwV6yzcjZRzRrifJZHLopb5uj1kXQJ4msSyLG
ARC-Seal: i=1; a=rsa-sha256; t=1520945383; cv=none;
        d=google.com; s=arc-20160816;
        b=bR955nuF7ytWSpHcGn0lPYlZ3MtVCbRXa2RR0cGYS9Cmxhj326HSCPyDsWc09R1EZg
         Biq08u1ScNEh8T0Smn6vGNHbXYrlEK5Pk0OwGrQQPfWecOkT0Uf9w24oWmTNyZUVdmh2
         EvAxONeIaLJu6ja453/1Po1EFxKkXWFT/kIxiGrAqKItupi4LijWH1G/4On8UWcN3kuh
         ybPz0f7YmR1ETMvRgQ8e9VW8KHZS6oShPzSykE/jG1cIL6a0Tm4lbG+IL9Y7soV53AGa
         Jf7qPBkr/ZgJviA/8KOwiACt4gOQBnNqIRpHwbaPtBFEnO+j9kVVgof/BNgt0RxevS/7
         CjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=SRBeb/iZCrE3QRPFDoaFkOM0G+vFjaLFv68hDa2lebs=;
        b=YceUHA+JfN+p9+xDelyZhHH2evrXSFHbXJe2CY0kvqazcNJmTKkx4sxjj7Rsg8GOOg
         ef0xH/bjJnMQ3QIqi+oWfbXXIcyQHDFpcd+7AbVfuT01bBWM1sOLH60nKE6INBODSfUx
         FyCFPQJaq4n/Cdv42FOc5F4bcLid9+lFGW1NmbTSbgdEAomTQrYCvKBol4mjqvHKlHMv
         iallVmnbeD/PSvJ6v9zE1VnkeuBJdwLypfsC41NBQVETP4I7iYntYemee4x75RYIXGta
         u/FpjvkY5sx7oF6DkgELdQzLSj3cxVbDhsahX2pelHCWeTEdsYHg9JO+PJVEjqHdKUbM
         neTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
 devices
To: Vivek Gautam <vivek.gautam@codeaurora.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, joro@8bytes.org, robh+dt
 <robh+dt@kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Rob Clark <robdclark@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 Sricharan R <sricharan@codeaurora.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Archit Taneja <architt@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-2-vivek.gautam@codeaurora.org>
 <8903307.QazHKW0JrR@aspire.rjw.lan>
 <CAFp+6iE=0PD6fZZVd+bC1Z95Lkt=X-F4YOXz8EtdiXL=jsC1RA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4eaf2006-ea68-d9e9-a0db-89acec0ea299@arm.com>
Date: Tue, 13 Mar 2018 12:49:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFp+6iE=0PD6fZZVd+bC1Z95Lkt=X-F4YOXz8EtdiXL=jsC1RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594826825849219587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13/03/18 09:55, Vivek Gautam wrote:
> On Tue, Mar 13, 2018 at 3:10 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, March 13, 2018 9:55:30 AM CET Vivek Gautam wrote:
>>> The lists managing the device-links can be traversed to
>>> find the link between two devices. The device_link_add() APIs
>>> does traverse these lists to check if there's already a link
>>> setup between the two devices.
>>> So, add a new APIs, device_link_find(), to find an existing
>>> device link between two devices - suppliers and consumers.
>>>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>
>>>   * New patch added to this series.
>>>
>>>   drivers/base/core.c    | 30 +++++++++++++++++++++++++++---
>>>   include/linux/device.h |  2 ++
>>>   2 files changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index 5847364f25d9..e8c9774e4ba2 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -144,6 +144,30 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>>>        return 0;
>>>   }
>>>
>>> +/**
>>> + * device_link_find - find any existing link between two devices.
>>> + * @consumer: Consumer end of the link.
>>> + * @supplier: Supplier end of the link.
>>> + *
>>> + * Returns pointer to the existing link between a supplier and
>>> + * and consumer devices, or NULL if no link exists.
>>> + */
>>> +struct device_link *device_link_find(struct device *consumer,
>>> +                                  struct device *supplier)
>>> +{
>>> +     struct device_link *link = NULL;
>>> +
>>> +     if (!consumer || !supplier)
>>> +             return NULL;
>>> +
>>> +     list_for_each_entry(link, &supplier->links.consumers, s_node)
>>> +             if (link->consumer == consumer)
>>> +                     break;
>>> +
>>
>> Any mutual exclusion?
>>
>> Or is the caller expected to take care of it?  And if so, then how?
> 
> I think it's better that we take care of lock here in the code rather
> than depending
> on the caller.
> But i can't take device_links_write_lock() since device_link_add()
> already takes that.

Well, the normal pattern is to break out the internal helper function 
as-is, then add a public wrapper which validates inputs, handles 
locking, etc., equivalently to existing caller(s). See what 
device_link_del() and others do, e.g.:

static struct device_link *__device_link_find(struct device *consumer,
		struct device *supplier)
{
	list_for_each_entry(link, &supplier->links.consumers, s_node)
		if (link->consumer == consumer)
			return link;
	return NULL;
}

struct device_link *device_link_find(struct device *consumer,
		struct device *supplier)
{
	struct device_link *link;

	if (!consumer || !supplier)
		return NULL;

	device_links_write_lock();
	link = __device_link_find(consumer, supplier);	
	device_links_write_unlock();
	return link;
}

where device_link_add() would call __device_link_find() directly.

However, as Tomasz points out (and I hadn't really considered), if the 
only reasonable thing to with a link once you've found it is to delete 
it, then in terms of the public API it may well make more sense to just 
implement something like a device_link_remove() which does both in one go.

Robin.

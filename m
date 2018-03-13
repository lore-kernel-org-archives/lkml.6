Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AG47ELutE6dcdgiEvLMri8gERXBxsHZ0sM4MRQQ223TtpuAXgzLrNxQfXwR6q3t0WLmeXXOUrIp9
ARC-Seal: i=1; a=rsa-sha256; t=1520934921; cv=none;
        d=google.com; s=arc-20160816;
        b=aB9stTwZKm6m9rAm1DoiH0/2WJARfXZUc/b9yrPZOGNGXCA8aojtznidOHCtnrQXU1
         jhSPypwEXaUjGZFKC2iQ9sYgJcslFUmcgB7rRtGf7uwTyM4ehQoSUk/rc7DfPiL06GRg
         EGQcCZd033XUTpwZvx0s4N2gzIlr4dpIX0zSmfZ5yoKnSnAZjGF7SYdTpfvXf2w8m1f/
         Z6QneGJHU2FGOADwFB+vqgR2wnBDNKXPBPXWzdcD2v+dFeJYUqrUc5JIZB3VFaHS73Ie
         G25RuGOaslDZ9BqjLuZ6dPylvlnJnLA+0zdmE5JmJV6EWGwCsrgVg1+Ojin8k1Jyd2+y
         hnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=TgD35LWOvW0b5MeeI9tKOq6Ycf4/vZbPgI2AcUU9OyI=;
        b=G0LbfIswBpzw9Fkdk3dkvdpv038vw3c+wchAFzZwhCoMQpmRralteP+Xk+ToubMysv
         nU/PDpbUSRdyHl25Dnt21kCcvEnbQe8kMb2EdRZzd6PFynwFIhrd7hlGT5WiapRMZ2o3
         okwZhhzQGG5vlLt7RQX9g59U5sJOxbM/EU54JQKMD5ZUy6DmyjEAFbqvs3rl+fixfZy/
         EGXqXjpTCsgQoE47c0UOruIMH7OSZvXRPm27mnA2XVP5n0QkOKljy+GVKSKWPwWTnnqO
         4VUlSSwbUh/5RO84UbKwXz7+NiiqDidj79AlnDpHsKiHItSoItGlyL4VWdK50Nxf2ee0
         /esw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ba6JnaXm;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nzzXX4Xl;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ba6JnaXm;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nzzXX4Xl;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83C2B6070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <8903307.QazHKW0JrR@aspire.rjw.lan>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-2-vivek.gautam@codeaurora.org> <8903307.QazHKW0JrR@aspire.rjw.lan>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Tue, 13 Mar 2018 15:25:18 +0530
X-Gmail-Original-Message-ID: <CAFp+6iE=0PD6fZZVd+bC1Z95Lkt=X-F4YOXz8EtdiXL=jsC1RA@mail.gmail.com>
Message-ID: <CAFp+6iE=0PD6fZZVd+bC1Z95Lkt=X-F4YOXz8EtdiXL=jsC1RA@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	Tomasz Figa <tfiga@chromium.org>, Sricharan R <sricharan@codeaurora.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Archit Taneja <architt@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594815856554658663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 3:10 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, March 13, 2018 9:55:30 AM CET Vivek Gautam wrote:
>> The lists managing the device-links can be traversed to
>> find the link between two devices. The device_link_add() APIs
>> does traverse these lists to check if there's already a link
>> setup between the two devices.
>> So, add a new APIs, device_link_find(), to find an existing
>> device link between two devices - suppliers and consumers.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>
>>  * New patch added to this series.
>>
>>  drivers/base/core.c    | 30 +++++++++++++++++++++++++++---
>>  include/linux/device.h |  2 ++
>>  2 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 5847364f25d9..e8c9774e4ba2 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -144,6 +144,30 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>>       return 0;
>>  }
>>
>> +/**
>> + * device_link_find - find any existing link between two devices.
>> + * @consumer: Consumer end of the link.
>> + * @supplier: Supplier end of the link.
>> + *
>> + * Returns pointer to the existing link between a supplier and
>> + * and consumer devices, or NULL if no link exists.
>> + */
>> +struct device_link *device_link_find(struct device *consumer,
>> +                                  struct device *supplier)
>> +{
>> +     struct device_link *link = NULL;
>> +
>> +     if (!consumer || !supplier)
>> +             return NULL;
>> +
>> +     list_for_each_entry(link, &supplier->links.consumers, s_node)
>> +             if (link->consumer == consumer)
>> +                     break;
>> +
>
> Any mutual exclusion?
>
> Or is the caller expected to take care of it?  And if so, then how?

I think it's better that we take care of lock here in the code rather
than depending
on the caller.
But i can't take device_links_write_lock() since device_link_add()
already takes that.

regards
Vivek

>
>> +     return link;
>> +}
>> +EXPORT_SYMBOL_GPL(device_link_find);
>> +
>>  /**
>>   * device_link_add - Create a link between two devices.
>>   * @consumer: Consumer end of the link.
>> @@ -195,9 +219,9 @@ struct device_link *device_link_add(struct device *consumer,
>>               goto out;
>>       }
>>
>> -     list_for_each_entry(link, &supplier->links.consumers, s_node)
>> -             if (link->consumer == consumer)
>> -                     goto out;
>> +     link = device_link_find(consumer, supplier);
>> +     if (link)
>> +             goto out;
>>
>>       link = kzalloc(sizeof(*link), GFP_KERNEL);
>>       if (!link)
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index b093405ed525..13bc1884c3eb 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -1278,6 +1278,8 @@ extern const char *dev_driver_string(const struct device *dev);
>>  struct device_link *device_link_add(struct device *consumer,
>>                                   struct device *supplier, u32 flags);
>>  void device_link_del(struct device_link *link);
>> +struct device_link *device_link_find(struct device *consumer,
>> +                                  struct device *supplier);
>>
>>  #ifdef CONFIG_PRINTK
>>
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AG47ELtjMEDdx7jZMhBzVru279TkmAic+5S21s7NneAC+CNan5Llxm15BdJ+A9BRfS73uRsFcrrD
ARC-Seal: i=1; a=rsa-sha256; t=1521029660; cv=none;
        d=google.com; s=arc-20160816;
        b=obdMAyRCzwBCRnn0UUTX+OJrj4j7HWVrMuV4LHTKSv5/50ryUczHuHV+dmwSodOsq5
         Z7dg9v26foLhH4F8r0VsIsjKSbg/SEJiIftK3LkThsQEv70Za7+ck/wfIaT3P/pWOp6I
         R9MJ3k+HHFIJvMEfaQojF5wn1NjZzQaLhewzxg8yLJ9bX+Yn1TCnkzP9Ls622Jm12nZm
         g3dtqnTEIAL5HZXYpb3LThczMtENAZNSt7DdnkDqsb6GRlULNn7/XGs0py4ZtLj3MNiR
         ct1vDeZTENTEWOt5YR5YN1o5jdDSpwYpwHjzwTDWYQ/Gu9m8K+ASmtPdmp8Z8tdBiCtl
         C7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=F3Z/b6RNF0Hht+SaFesrSEX5Y0J+dXC6bndvzoytIyo=;
        b=e9KBPKwtrRN+j6vCi6wcX0LwztL4xyFAuHFXX7cAzMQcRJP/UQL1K/hq3Kc8rm3mFI
         TtCIfgb3ZgzAgbEUHSLfR1x71k1FXaNSpX5suHFnseDYCT8DDgI5eDQjm0sfIWVj35Tq
         AJ0luw25xDMBSJB5Ay7FgUyW+4cCL/wLpv2/a8pu8ZrymJrNCkItnS9ZB86ssJGa8Oyp
         JOuEBLie5nSYACZ3+Fy0Ac2cWSoXgzqtmN5ybQsor8JfrPiCiPEaag9y+oMzVQj5+1fW
         5thb6gpFJJ0xIeeeuTt3mnJXJa7rwdnt1V6ZlUMMt2KeYFhsqQ0l9W2ZBidFJkzLvHqq
         wxTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
 devices
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tfiga@chromium.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, Lukas Wunner
 <lukas@wunner.de>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Rob Clark <robdclark@gmail.com>, Sricharan R <sricharan@codeaurora.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Archit Taneja <architt@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <2217404.A2W3Iek6du@aspire.rjw.lan>
 <CAAFQd5CQXY0Efv+2MC1kTVW5q4eZjJ=gwVaR-LA=3agnSSHzUw@mail.gmail.com>
 <2705105.V6KYPvoJqj@aspire.rjw.lan>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <11eae0bc-7921-e598-9c01-63498400c85b@arm.com>
Date: Wed, 14 Mar 2018 12:14:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2705105.V6KYPvoJqj@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594915197272807168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rafael,

On 14/03/18 11:57, Rafael J. Wysocki wrote:
> On Wednesday, March 14, 2018 12:50:54 PM CET Tomasz Figa wrote:
>> On Wed, Mar 14, 2018 at 8:12 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
>>>> On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam
>>>> <vivek.gautam@codeaurora.org> wrote:
>>>>> Hi Tomasz,
>>>>>
>>>>> On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>>>> Hi Vivek,
>>>>>>
>>>>>> Thanks for the patch.
>>>>>>
>>>>>> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam
>>>>>> <vivek.gautam@codeaurora.org> wrote:
>>>>>>> The lists managing the device-links can be traversed to
>>>>>>> find the link between two devices. The device_link_add() APIs
>>>>>>> does traverse these lists to check if there's already a link
>>>>>>> setup between the two devices.
>>>>>>> So, add a new APIs, device_link_find(), to find an existing
>>>>>>> device link between two devices - suppliers and consumers.
>>>>>>
>>>>>> I'm wondering if this API would be useful for anything else that the
>>>>>> problem we're trying to solve with deleting links without storing them
>>>>>> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
>>>>>> better alternative?
>>>>>
>>>>> Yea, that sounds simpler i think. Will add this API instead of
>>>>> find_link(). Thanks.
>>>>
>>>> Perhaps let's wait for a moment to see if there are other opinions. :)
>>>>
>>>> Rafael, Lucas, any thoughts?
>>>
>>> It is not clear to me what the device_link_del_dev(consumer, supplier) would do.
>>
>> It would delete a link between consumer and supplier.
> 
> If there's one I suppose.
> 
> I'm wondering if you are somehow trying to address the same problem as the
> device links reference counting patch from Lukas that has been queued up for 4.17
> already.

Not quite - the issue here is that we have one supplier with an 
arbitrarily large number of consumers, and would prefer that supplier 
not to have to spend a whole bunch of memory to store all the struct 
device_link pointers for the sole reason of having something to give to 
device_link_del() at the end, given that the device links code is 
already keeping track of everything internally anyway.

The current API would permit doing this:

	iommu_attach(dev) {
		...
		if (!device_link_add(dev, iommu, IOMMU_LINK_FLAGS))
			return -ENODEV;
		...
	}

	iommu_detach(dev) {
		...
		// Will return the existing link from earlier
		link = device_link_add(dev, iommu, IOMMU_LINK_FLAGS);
		device_link_del(link);
		// Needed once refcounting is in place
		//device_link_del(link);
		...
	}

but it looks so wacky and non-obvious that we'd like to encapsulate the 
same behaviour into a more formal interface (my personal naming 
preference would be device_link_remove(consumer, supplier)).

Robin.

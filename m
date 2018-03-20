Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AG47ELu9CjPW0Efmc/yZMIAijDcUu+LoitfpDosT6rVKeePuUrrFCOYkCTn+KsWhVzTk2+La5+FO
ARC-Seal: i=1; a=rsa-sha256; t=1521532618; cv=none;
        d=google.com; s=arc-20160816;
        b=YvDi6OWLQufBFdSzncL9Lxb4PCWU6o/xT77wiKqjt+UCvFoHprfkqmyGwcFncigeQU
         JzbEcINjb2rC36Q9JEE9jEfAYNmCacZb52kKJh0ZQsbmw29jJ31ZdqlnDsbtvZGnTvjk
         bp92ajZiYrS3leHlMy71mtADR012hnG8GXHbTe15+1bK0O+3/wmiRSITom8FIdzWSKKL
         RA2rC+xE7lFeP/gs2ueG9gqDOC38++2NVB9J4BGofmQbDfDbXHcBfJ7bYDBy2cSMscQJ
         SQ8/k0o8D/XbhHSuO3tzpuIOnN0xbmDgiLxKYFVnO72gHysnkOQenm2RDWVwa+N3S1Z5
         RWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=nseFxllVmY+Q7uCQBXUVL8div4Uutlc8ROdSO36UiUI=;
        b=IsQi0L6ffA4FZ9aUdYfAD+4lNdAYH+yGfwFkgI9EOUQpFUsQMH+DgYBdqiEa0nlc4e
         e3e8gLCPAGsMhH0UZvlhGbyLVRd7j9svIdipHIo6dHSOye5hk6ZxJg9JNwpzN9JE7uJt
         aG6ODdDVcMz6Vx12QD4QPVivnlDK7gwYRLQv41vXPDCDH3wWjf7kBxtxu8QLPC9CyrlK
         7Uh7IlqkT86bazHjycajNBbPds602Quim3jpN4Abuvvz9OZwmapiNQ5n3lqeuYBx5HAb
         7o4Nj/08QDh//Dguc0lWayi9omksIBvhJJyzP7TxpYjNJFs/hUg3aL/2355DHIhIAucY
         CPAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YYDA1Gss;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kOzo851M;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YYDA1Gss;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kOzo851M;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50AD060314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
 devices
To: Lukas Wunner <lukas@wunner.de>, Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa
 <tfiga@chromium.org>, Joerg Roedel <joro@8bytes.org>,
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
 <11eae0bc-7921-e598-9c01-63498400c85b@arm.com>
 <20180314122759.GB19651@wunner.de>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <726cf34b-568f-55c9-0459-ff34176f9927@codeaurora.org>
Date: Tue, 20 Mar 2018 13:26:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314122759.GB19651@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1595442587166741780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Lukasz,


On 3/14/2018 5:57 PM, Lukas Wunner wrote:
> On Wed, Mar 14, 2018 at 12:14:15PM +0000, Robin Murphy wrote:
>>>> On Wed, Mar 14, 2018 at 8:12 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>> On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
>>>>>> On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>>>>>>> On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>>>>>> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>>>>>>>>> The lists managing the device-links can be traversed to
>>>>>>>>> find the link between two devices. The device_link_add() APIs
>>>>>>>>> does traverse these lists to check if there's already a link
>>>>>>>>> setup between the two devices.
>>>>>>>>> So, add a new APIs, device_link_find(), to find an existing
>>>>>>>>> device link between two devices - suppliers and consumers.
>>>>>>>> I'm wondering if this API would be useful for anything else that the
>>>>>>>> problem we're trying to solve with deleting links without storing them
>>>>>>>> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
>>>>>>>> better alternative?
>>>>>>> Yea, that sounds simpler i think. Will add this API instead of
>>>>>>> find_link(). Thanks.
>>>>>> Perhaps let's wait for a moment to see if there are other opinions. :)
>>>>>>
>>>>>> Rafael, Lucas, any thoughts?
>>>>> It is not clear to me what the device_link_del_dev(consumer, supplier)
>>>>> would do.
>> Not quite - the issue here is that we have one supplier with an arbitrarily
>> large number of consumers, and would prefer that supplier not to have to
>> spend a whole bunch of memory to store all the struct device_link pointers
>> for the sole reason of having something to give to device_link_del() at the
>> end, given that the device links code is already keeping track of everything
>> internally anyway.
> Makes sense to me.  How about an additional flag which autoremoves the
> link on provider unbind?

If I understand this correctly, if we create the device link with 
DL_FLAG_AUTOREMOVE, the link is deleted after a consumer unbind. During 
a supplier unbind all we get is a WARN_ON with DL_FLAG_AUTOREMOVE. I 
guess that's an intended behavior?

If this is the case, then the consumer/supplier drivers just don't have 
to take care of deleting the device link explicitly.
Is my understanding correct?

regards
Vivek

>
> Thanks,
>
> Lukas

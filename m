Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AH8x224S5MinrETZUFiu2rgRAgLRIyusFFVDlskZCAALU4nFoTz0MYT2/aWgcUY86VxMkZXggW0l
ARC-Seal: i=1; a=rsa-sha256; t=1518529064; cv=none;
        d=google.com; s=arc-20160816;
        b=yA1mHwALckh1WnESwF2cTo5HI1xW+LBxqSZFUuwFEikEIRz11GCCUm3raf79Uyhyym
         2qfyZoNQTxMMVX7kcFUS2foTqbSEEIdkbzAKgb6Za5HQyzMKkc4d1lnfhxYyWZK0ZJgK
         g477ObPsxcwU0RKeFozQiPlAtDhzEAVEMcr5hyaSFnCWZrtr/TXZXAuEj2l9In4GdEjL
         4JevTiEXcVlR3ezalB7RwsAYqWsqFocuy8Y10YaJu6b/0YN3U1TGDTKMft/kfqsDIk4S
         vNWenT3rzG6lKDUu4tNesEzazS/W4k1cYwH3zT4YtnuxIFuBdJrZ9MMHTbwhQGHaG1JN
         ulpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=833oXPNEmIsSVMHQE0CCUoiZ779UX0dXuR5ReiR4wwk=;
        b=nhqesFM8B6HmBt+VIzkxhobyVkiHCjaxiismqG+DWEoxjGYJdFuIpS1sZgI7JPMqgD
         9tx1GT4xmXQVmw+rYY93t179M+c236IT+c3U/P7sxPSeLJu1k35Xsrn1pVx1930UImGD
         1xSOcr8uT3nBtHi3M8oJUyloj6ausJCLmecuFb4HYvJO2V56x+ZJR0Dso8KY/UI0H6Az
         J2MIDUkbNfCWv2nn48Z//CSCCVKWdJ6y6GDhDrxKh+GKOBevEqMF29vojUAtadFO05zW
         z/G5DjhPxDpRxX+eT26SvVgTtTc1tumGvGPrf3trBAaX6ucBl2zqRkGL/CBzcgS8wfl1
         j+pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v7 1/6] base: power: runtime: Export
 pm_runtime_get/put_suppliers
To: Tomasz Figa <tfiga@chromium.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>,
 Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Greg KH <gregkh@linuxfoundation.org>, sboyd@codeaurora.org,
 linux-arm-msm@vger.kernel.org
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-2-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5BmroRf-C8dQkvTKHWK1psGnNi1t7g-q=Xce6KjrGTsdw@mail.gmail.com>
 <65d707c0-76cc-d59e-ff18-1fdd89306900@arm.com>
 <CAAFQd5DNzGYnTRuc2hDr1osQ2=6ruM0wQqV8svP=a10hxTVOGQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d6aa408f-6458-7a40-51ea-409ea9663af2@arm.com>
Date: Tue, 13 Feb 2018 13:37:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DNzGYnTRuc2hDr1osQ2=6ruM0wQqV8svP=a10hxTVOGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737849838824813?=
X-GMAIL-MSGID: =?utf-8?q?1592293131948217399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13/02/18 12:54, Tomasz Figa wrote:
> On Tue, Feb 13, 2018 at 9:00 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 13/02/18 07:44, Tomasz Figa wrote:
>>>
>>> Hi Vivek,
>>>
>>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>>> <vivek.gautam@codeaurora.org> wrote:
>>>>
>>>> The device link allows the pm framework to tie the supplier and
>>>> consumer. So, whenever the consumer is powered-on the supplier
>>>> is powered-on first.
>>>>
>>>> There are however cases in which the consumer wants to power-on
>>>> the supplier, but not itself.
>>>> E.g., A Graphics or multimedia driver wants to power-on the SMMU
>>>> to unmap a buffer and finish the TLB operations without powering
>>>> on itself.
>>>
>>>
>>> This sounds strange to me. If the SMMU is powered down, wouldn't the
>>> TLB lose its contents as well (and so no flushing needed)?
>>
>>
>> Depends on implementation details - if runtime PM is actually implemented
>> via external clock gating (in the absence of fine-grained power domains),
>> then "suspended" TLBs might both retain state and not receive invalidation
>> requests, which is really the worst case.
> 
> Agreed. That's why in "[PATCH v7 3/6] iommu/arm-smmu: Invoke
> pm_runtime during probe, add/remove device" I actually suggested
> managing clocks separately from runtime PM. At least until runtime PM
> framework arrives at a state, where multiple power states can be
> managed, i.e. full power state, clock-gated state, domain-off state.
> (I think I might have seen some ongoing work on this on LWN though...)
> 
>>
>>> Other than that, what kind of hardware operations would be needed
>>> besides just updating the page tables from the CPU?
>>
>>
>> Domain attach/detach also require updating SMMU hardware state (and possibly
>> TLB maintenance), but don't logically require the master device itself to be
>> active at the time.
> 
> Wouldn't this hardware state need to be reinitialized anyway after
> respective power domain power cycles? (In other words, hardware would
> only need programming if it's powered on at the moment.)

Yes, if the entire SMMU was fully powered down because all masters were 
inactive, then all that should need to be done is to update the software 
shadow state in the expectation that arm_smmu_reset() would re-sync it 
upon TCU powerup. If at least some part of the internal logic remains 
active, though, then you may or may not need to fiddle with zero or more 
clocks and/or power domains (depending on microarchitecture and 
integration) in order to be sure that everything from the programming 
slave interface through to wherever that state is kept works correctly 
so that it can be changed.

The main motivation here is that the Qualcomm SMMU microarchitecture 
apparently allows the programming interface to be shut down separately 
from the TCU core (context banks, page table walker, etc.), and they get 
an appreciable power saving from doing so. This is different from, say, 
the Arm Ltd. implementations, where the entire TCU is a single 
clock/power domain internally (although you could maybe still gate the 
external APB interface clock).

As the previous discussions have shown, this is really, really hard to 
do properly in a generic manner.

Robin.

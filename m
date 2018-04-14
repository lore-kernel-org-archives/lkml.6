Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+BIqQTm94OL2OIKVQggvTIPvc0EzD+ZbVn8Z32jfAO8RCejiZePbSizxv+urMYyKMsEVW5
ARC-Seal: i=1; a=rsa-sha256; t=1523721203; cv=none;
        d=google.com; s=arc-20160816;
        b=T8/6DVCu0ozUrl7zWtc9P1+mKr26S8Q2LuYskItavC11aO3y/WEGcEIJc0aAvHreec
         JTFA/Gmi9vdxr4cG41CHq+k9peUNz/fXNgGXuy3XP3OqG9eyHfl9c3iulLSw9ZpdfdEP
         qwQtaFXE+BrmeqCG7DD91N3LFYkLDzKK/WH1XISTFeV8jYFp9/uPobGxAqyffGR8bh3w
         Zp6aqVaGpGvJZps9XaNnO6hSWzHiddEFlkleddJOsJcFm9DINiqX1nT4uPxd1WCa1NBv
         7jdYBTrfWH7EzYbc08BWiB1829+7+otK/xC2u55L9JEeT/txzYrKtdJj+7w4r6Ks+Khn
         YkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=fM8FYRHHhcV2DRQRoqqnCg8IdpYoWKxinBGKQzluerw=;
        b=eBTJ0v50TJCC8C50PF6bCoMw/BMBst21Ij/t0WYZXxi38Al0OyOGSn0Y09q0OPzXVq
         G68S/Ue4hCyyDSMclUJFQfx7Nnw8AMHwVhpgzf76a/6d3B8TSXXFfGN1PZoP9hpDHqob
         I51c5Ns2p/aJ2mAZlBXzc+woScYnVh6lMAhmPDlHSX5+mCJ/MCj/T8uKrv6jyNFLQRHv
         XseCjhctRQWUwDBsrLKMbiQK7t3fYngwM2w2QU73+wKRJUkj9wy4d5ZCGYrY6rgbYYzt
         fW959c9EHqkdVs3SF4+ardjeb0xIUjCy6wsk24k8cauW4j2Jr+5ID2TVj/nUqiPX+7qC
         mQfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dOyD7AxR;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jEi2qjUO;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dOyD7AxR;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jEi2qjUO;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0E1C600ED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
To: Keith Busch <keith.busch@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Oza Pawandeep <poza@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
 <20180412150231.GD4810@localhost.localdomain>
 <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
 <20180412170911.GA6424@localhost.localdomain>
 <fa167b21-f70d-a220-5671-5ad66a0f72c0@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <cced24b5-c0bd-138a-0304-c87cac2ec226@codeaurora.org>
Date: Sat, 14 Apr 2018 11:53:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fa167b21-f70d-a220-5671-5ad66a0f72c0@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597737484764295750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Keith, Bjorn;

On 4/12/2018 1:41 PM, Sinan Kaya wrote:
> On 4/12/2018 1:09 PM, Keith Busch wrote:
>> On Thu, Apr 12, 2018 at 12:27:20PM -0400, Sinan Kaya wrote:
>>> On 4/12/2018 11:02 AM, Keith Busch wrote:
>>>>
>>>> Also, I thought the plan was to keep hotplug and non-hotplug the same,
>>>> except for the very end: if not a hotplug bridge, initiate the rescan
>>>> automatically after releasing from containment, otherwise let pciehp
>>>> handle it when the link reactivates.
>>>>
>>>
>>> Hmm...
>>>
>>> AER driver doesn't do stop and rescan approach for fatal errors. AER driver
>>> makes an error callback followed by secondary bus reset and finally driver
>>> the resume callback on the endpoint only if link recovery is successful.
>>> Otherwise, AER driver bails out with recovery unsuccessful message.
>>
>> I'm not sure if that's necessarily true. People have reported AER
>> handling triggers PCIe hotplug events, and creates some interesting race
>> conditions:
> 
> By reading the code, I don't see a stop and rescan in the AER error recovery
> path.
> 
> As both logs indicate, stop and rescan is initiated in response to link down
> and link up interrupts triggered by the secondary bus reset. 
> The SW entity handling these is not AER driver. It is the hotplug driver
> running asynchronous to the AER driver.
> 
> AER driver should have tried a slot reset before attempting to do a secondary
> bus reset.
> 
> /**
>  * pci_reset_slot - reset a PCI slot
>  * @slot: PCI slot to reset
>  *
>  * A PCI bus may host multiple slots, each slot may support a reset mechanism
>  * independent of other slots.  For instance, some slots may support slot power
>  * control.  In the case of a 1:1 bus to slot architecture, this function may
>  * wrap the bus reset to avoid spurious slot related events such as hotplug.
>  * Generally a slot reset should be attempted before a bus reset.  All of the
>  * function of the slot and any subordinate buses behind the slot are reset
>  * through this function.  PCI config space of all devices in the slot and
>  * behind the slot is saved before and restored after reset.
>  *
>  * Return 0 on success, non-zero on error.
>  */
> int pci_reset_slot(struct pci_slot *slot)
> 
> Slot reset is there to mask hotplug interrupts before the reset and unmask them
> after reset.
> 
>>
>> https://marc.info/?l=linux-pci&m=152336615707640&w=2
>>
>> https://www.spinics.net/lists/linux-pci/msg70614.html
>>
>>> Why do we need an additional rescan in the DPC driver if the link is up
>>> and driver resumes operation?
>>
>> I thought the plan was to have DPC always go through the removal path
>> to ensure all devices are properly configured when containment is
>> released. In order to reconfigure those, you'll need to initiate the
>> rescan from somewhere.
>>
> 
> This is where the contradiction is. 
> 
> Bjorn is asking for a unified error handling for both AER and DPC.
> 
> Current AER error recovery framework is error callback + secondary
> bus reset + resume callback.
> 
> How does this stop + rescan model fit?
> 
> Do we want to change the error recovery framework? I suppose this will 
> become a bigger conversation as there are more customers of this.
> 

I also want to highlight that the PCI Error recovery sequence is well
documented here.

https://www.kernel.org/doc/Documentation/PCI/pci-error-recovery.txt

We don't really have to guess what Linux does. 

IMO, the hotplug issues Keith is seeing are orthogonal and needs to be
addressed independent of this series by following the pci slot reset
procedure.

Hotplug driver handles link up/down events due to insertion/removal.
Hotplug driver is expected to do the re-enumeration.

I don't understand why we need to do another re-enumeration if system
observes a PCIe error handled by the AER/DPC driver. 

These two are independent events.

PCIe error recovery framework does the reset callback + SBR + resume
behavior today.

Bjorn,

You indicated that you want to unify the AER and DPC behavior. Let's
settle on what we want to do one more time. We have been going forth
and back on the direction.

We are on V13. I hope we won't hit V20 :)

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

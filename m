Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49lbBrDsonjiFH1T+9bBcZ4e1z6ulLboqD/aTM+yJz8ddpN7+vs7dpRZ1O1FOQJVGeZnt8B
ARC-Seal: i=1; a=rsa-sha256; t=1523554889; cv=none;
        d=google.com; s=arc-20160816;
        b=IN4bcPT7Jl7ejdRlIQwdcQQTeDYQE10nmoOnGnNcyseMBaxCfyxiKhwPdtUvz2x9rJ
         H9E3n2WKD6Uip7q6pcVAEatWSDQgMyyhMz0xi7i/ixwRJBc4XKw6q7TsBGNadxFOSMnS
         fuU47eV7+VVzv2PCUOcqK+P28vH5nzktrRJrWfy2g+hD7qqKieigD3iQhIQJ7tjcVDM6
         GsMx/WEild/nHP37BnUZT2v+TLwF3GenlZ1pNBu2MGc3+eRvP2DeJuX+6YFtVTdKDOWR
         V9PWcTPQSVZieyW+KWGkwciuNETLQk9kpnz4DbZKp4mHHek6Mp3/Z3VYSyYHS4c7FCp8
         kC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=62S4LFGYEyOcjtH2EQulj5W9h9IhEU5Sv8aUTsNxqYI=;
        b=KH71qd3OL15hhykAP5LtnBjp4wGoXvxKta25lYeFfzAh66NZwVugn4HXYw9nsii5rf
         v+qeVDXvmd/dzsliEFgtMbt3ZaYp1fAikr58jQp9BPIOokiR3h8k1v6mNVvD+hUh7N6Z
         /1bYdLCn4XIihxE8AbzcrlRGxsoWEIIhh/QuofYELzc88iveKOGWHXjTvDGhiI6Ah1NI
         8S17Z1ephIx833UN+Vb4nLZ6pxecuJ6bTMO7yRGhOg6WAKYnV4jz8M5cupt7jZ0zhYEM
         RaDYat7q44BLt4XnUeLkoqWnvpvezlj+7KG0Yw8jtgJmbXByyv2sAlHzt80av7dmcZwq
         +a6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VfcfzAOM;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=aMY74+In;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VfcfzAOM;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=aMY74+In;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34E5C607EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <fa167b21-f70d-a220-5671-5ad66a0f72c0@codeaurora.org>
Date: Thu, 12 Apr 2018 13:41:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412170911.GA6424@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597563091591626492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/12/2018 1:09 PM, Keith Busch wrote:
> On Thu, Apr 12, 2018 at 12:27:20PM -0400, Sinan Kaya wrote:
>> On 4/12/2018 11:02 AM, Keith Busch wrote:
>>>
>>> Also, I thought the plan was to keep hotplug and non-hotplug the same,
>>> except for the very end: if not a hotplug bridge, initiate the rescan
>>> automatically after releasing from containment, otherwise let pciehp
>>> handle it when the link reactivates.
>>>
>>
>> Hmm...
>>
>> AER driver doesn't do stop and rescan approach for fatal errors. AER driver
>> makes an error callback followed by secondary bus reset and finally driver
>> the resume callback on the endpoint only if link recovery is successful.
>> Otherwise, AER driver bails out with recovery unsuccessful message.
> 
> I'm not sure if that's necessarily true. People have reported AER
> handling triggers PCIe hotplug events, and creates some interesting race
> conditions:

By reading the code, I don't see a stop and rescan in the AER error recovery
path.

As both logs indicate, stop and rescan is initiated in response to link down
and link up interrupts triggered by the secondary bus reset. 
The SW entity handling these is not AER driver. It is the hotplug driver
running asynchronous to the AER driver.

AER driver should have tried a slot reset before attempting to do a secondary
bus reset.

/**
 * pci_reset_slot - reset a PCI slot
 * @slot: PCI slot to reset
 *
 * A PCI bus may host multiple slots, each slot may support a reset mechanism
 * independent of other slots.  For instance, some slots may support slot power
 * control.  In the case of a 1:1 bus to slot architecture, this function may
 * wrap the bus reset to avoid spurious slot related events such as hotplug.
 * Generally a slot reset should be attempted before a bus reset.  All of the
 * function of the slot and any subordinate buses behind the slot are reset
 * through this function.  PCI config space of all devices in the slot and
 * behind the slot is saved before and restored after reset.
 *
 * Return 0 on success, non-zero on error.
 */
int pci_reset_slot(struct pci_slot *slot)

Slot reset is there to mask hotplug interrupts before the reset and unmask them
after reset.

> 
> https://marc.info/?l=linux-pci&m=152336615707640&w=2
> 
> https://www.spinics.net/lists/linux-pci/msg70614.html
> 
>> Why do we need an additional rescan in the DPC driver if the link is up
>> and driver resumes operation?
> 
> I thought the plan was to have DPC always go through the removal path
> to ensure all devices are properly configured when containment is
> released. In order to reconfigure those, you'll need to initiate the
> rescan from somewhere.
> 

This is where the contradiction is. 

Bjorn is asking for a unified error handling for both AER and DPC.

Current AER error recovery framework is error callback + secondary
bus reset + resume callback.

How does this stop + rescan model fit?

Do we want to change the error recovery framework? I suppose this will 
become a bigger conversation as there are more customers of this.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

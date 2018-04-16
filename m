Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AIpwx499oX+qF0sNvN3T45ow4vRHKfd85ZkXccaBnnBBUHtFbFAkG+J134z2ZUhrJmnsYIVjaVZ8
ARC-Seal: i=1; a=rsa-sha256; t=1523857877; cv=none;
        d=google.com; s=arc-20160816;
        b=AaeQHn97YwYBnbKKwkfsLYjXJ6woCsKh+7eR2Op7v0YgfWvnLgDc4guOgyiyjc/enq
         wQy3o+tb5PyD4974EQDVdYlQGI+96eAuU7wKyGuRJdNGEzsPhuFfE2PrsZG2qApe4or5
         0xAnfHs+ALzt53ce7upK7oW6lYsb/gjp9xEvT7/lmf3qtIEJX/mtB5/Jv+Zi4DrUfIrQ
         x19zs1enE56F5c7Ev8fuDRsvHAENJsg4nP3JU3zvdDcXC65vhpmU9OxNZsDAb0uG7gsA
         4pLivtQUJKeKcUe0kF87RFPJbYtIIINnAnjgz+MyEbVHd3ltmZ1xpQEpEDbQiOwHmQ57
         oRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=sQG+MgKrA7OQ48WDuNso8/kHtLBfTPY6AHRqnSXH7Z4=;
        b=o2EHiD/jnDICkDHVLC6af5fjvWwD+7UYbsWaTqfXg6UTFU4nJer28oYR3GADbHq4V0
         +0nQOKNZkV7cJTvU5KDJc2yFVa9q7NZGxF2mRNI4K++qr3sowNocvTSrfrmiJymgWgK2
         p4jiIMesKeORKC/D+pKgszjEG5KzfqBl0/YOrs7INyvY1WzzOjkvml4uAWI3SWEuX+we
         ivA2H3gJ6zWt4kO1QJf1oUZVMROt3Tn05ivhhPuUGwkzs8729SztOalTkB/dnuTy5x+0
         zw/RKE3yJYoPSpdIhP1elYF17zF84+5pBRbHpr3QCBDOuHpqDpCO3Z1dJ1JmU87ZavmM
         BTUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IQ2rNXC3;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RCK3LChl;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IQ2rNXC3;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RCK3LChl;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Apr 2018 11:21:15 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Keith Busch <keith.busch@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Wei
 Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>, Alex Williamson
 <alex.williamson@redhat.com>, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
In-Reply-To: <da626c40564276097ab7380ead5f0238@codeaurora.org>
References: <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
 <20180412150231.GD4810@localhost.localdomain>
 <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
 <20180412170911.GA6424@localhost.localdomain>
 <fa167b21-f70d-a220-5671-5ad66a0f72c0@codeaurora.org>
 <cced24b5-c0bd-138a-0304-c87cac2ec226@codeaurora.org>
 <20180416031726.GB158153@bhelgaas-glaptop.roam.corp.google.com>
 <da626c40564276097ab7380ead5f0238@codeaurora.org>
Message-ID: <a903dd90b53f018945d790b78e9572b9@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597880797447347787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-16 11:03, poza@codeaurora.org wrote:
> On 2018-04-16 08:47, Bjorn Helgaas wrote:
>> On Sat, Apr 14, 2018 at 11:53:17AM -0400, Sinan Kaya wrote:
>> 
>>> You indicated that you want to unify the AER and DPC behavior. Let's
>>> settle on what we want to do one more time. We have been going forth
>>> and back on the direction.
>> 
>> My thinking is that as much as possible, similar events should be
>> handled similarly, whether the mechanism is AER, DPC, EEH, etc.
>> Ideally, drivers shouldn't have to be aware of which mechanism is in
>> use.
>> 
>> Error recovery includes conventional PCI as well, but right now I
>> think we're only concerned with PCIe.  The following error types are
>> from PCIe r4.0, sec 6.2.2:
>> 
>>   ERR_COR
>>     Corrected by hardware with no software intervention.  Software
>>     involved for logging only.
>> 
>>     Handled by AER via pci_error_handlers; DPC is never involved.
>> 
>>     Link is unaffected.
>> 
>>   ERR_NONFATAL
>>     A transaction is unreliable but the link is fully functional.
>> 
>>     If DPC is not supported, handled by AER via pci_error_handlers and
>>     the link is unaffected.
>> 
>>     If DPC supported, handled by DPC (because we set
>>     PCI_EXP_DPC_CTL_EN_NONFATAL) via remove/re-enumerate.
>> 
>>   ERR_FATAL
>>     The link is unreliable.
>> 
>>     If DPC is not supported, handled by AER via pci_error_handlers and
>>     the link is reset.
>> 
>>     If DPC supported, handled by DPC via remove/re-enumerate.
>> 
>> It doesn't seem right to me that we handle both ERR_NONFATAL and
>> ERR_FATAL events differently if we happen to have DPC support in a
>> switch.
>> 
>> Maybe we should consider triggering DPC only on ERR_FATAL?  That would
>> keep DPC out of the ERR_NONFATAL cases.
>> 
>> For ERR_FATAL, maybe we should bite the bullet and use
>> remove/re-enumerate for AER as well as for DPC.  That would be painful
>> for higher-level software, but if we're willing to accept that pain
>> for new systems that support DPC, maybe life would be better overall
>> if it worked the same way on systems without DPC?
>> 
>> Bjorn
> 
> This had crossed my mind when I first looked at the code.
> DPC is getting triggered for both ERR_NONFATAL and ERR_FATAL case.
> I thought the primary purpose of DPC to recover fatal errors, by
> triggering HW recovery.
> but what if some platform wants to handle both FATAL and NON_FATAL with 
> DPC ?
> 
> As you said AER FATAL cases and DPC FATAL cases should be handled 
> similarly.
> e.g. remove/re-enumerate the devices.
> 
> while NON_FATAL case; only AER would come into picture.
> if some platform would like to handle DPC NON_FATAL then it should
> follow AER NON_FATAL path  (where it does not do remove/re-enumerate)
> 
> And the case where hotplug is enabled, remove/re-enumerate more sense
> in case of ERR_FATAL.
> And the case where hotplug is disabled, only re-enumeration is
> required. (no need to remove the devices)
> but then do we need to handle this case specifically, what is the harm
> in removing the devices in all the cases followed by re-enumerate ?

To Clarify the last line, what I meant here was, in case of ERR_FATAL we 
can always remove/re-enumerate the devices irrespective of hotplug is 
enabled or not.

and in case of ERR_NONFATAL, DPC will follow AER path (where it just 
tries to recover)
although I am not very sure that how to handle ERR_NONFATAL case if 
hotplug is enabled. Because as Keith suggested device might have been 
changed run-time.

> 
> Regards,
> Oza.

Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AIpwx49VsNN2hlFnuEs1I84j+GDtIrbCgZ4uVOUgKhwCMxCpGhqseWrs1ay5ylVQA+1WD0FRua6G
ARC-Seal: i=1; a=rsa-sha256; t=1523898922; cv=none;
        d=google.com; s=arc-20160816;
        b=dr/46Co9lanpwO5hTjwc5cKLjOyTcA0lSch9wKDW9awuEyH90NRVDx6WkxdO9p3Gf7
         44+F/1JvpUH15ZYqwZnTEz3RIkT0GJanXvFLm7vC+FzKVXHgQq0jkJb8m50zOQf8Bv6v
         97gPb2bE7GZ0Nu5jomBmque9wWuztMl1y4F/G7qEIUgbuUdRjo+vww2l+dCceYvr+A8b
         S7TxXLPLOQsyJvVp82Gim0pwu9rz/+qqzgBIYJuLBKGDH9JnyZRTAA2HouBU05D/F2nO
         6SVmxx9jcUFJuH2olqX2fEG2TnmcwEv//JpFIdbkhdXLoSjqyfcGlTBIXWIzId3i6Z3a
         pebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=jV4jtprRSDvaDhQ7ZEGfM/jNeAokj8nf5YNiqxV2Ea4=;
        b=lPXDKH7ZVcBx9ZLBJLrtVXERXvBkqQ9ZBWS39cMNTXAN+ZpL0tEq45rbXJ4lBQWoNm
         W6p1xpRSmFHnfgVBdSz/hYJgc61rdXZVrjFBrbNoXtL8sURctClnGGJ4IV1tXbvMk3lr
         3sCX3OJMYgd3kRpfy71RlVCJdSKq4xfpA4QYjrk1ji0qqS1OQQu9ku2NIxUW2sN+a95y
         VIGZoDHI5r9uphOl2abF4k359nfSPfMxUAkmpxtWymAjO3qcNH4rdn7nCFnMx0AQwLuw
         62xn91BAbUeq8Z+FO6Wf52Evsymjal+czYI9wHf46YN3uY2KsCeSOEaARkotY1MQXEKo
         xWqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RGSN5KNf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jBpbBOkd;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RGSN5KNf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jBpbBOkd;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Apr 2018 22:45:19 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Wei
 Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
In-Reply-To: <c236b732-ed65-9f94-7ae5-b1203dff2eb0@codeaurora.org>
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
 <c236b732-ed65-9f94-7ae5-b1203dff2eb0@codeaurora.org>
Message-ID: <0bed6fb09478349a95d9f6ad4449f31f@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597923836058450356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-16 20:16, Sinan Kaya wrote:
> On 4/15/2018 11:17 PM, Bjorn Helgaas wrote:
>> It doesn't seem right to me that we handle both ERR_NONFATAL and
>> ERR_FATAL events differently if we happen to have DPC support in a
>> switch.
>> 
>> Maybe we should consider triggering DPC only on ERR_FATAL?  That would
>> keep DPC out of the ERR_NONFATAL cases.
>> 
> From reliability perspective, it makes sense. DPC handles NONFATAL 
> errors
> by bringing down the link. If error happened behind a switch and root 
> port
> is handling DPC, we are impacting a lot of devices operation because of 
> one
> faulty device.
> 
> Keith, do you have any preference on this direction?
> 
>> For ERR_FATAL, maybe we should bite the bullet and use
>> remove/re-enumerate for AER as well as for DPC.  That would be painful
>> for higher-level software, but if we're willing to accept that pain
>> for new systems that support DPC, maybe life would be better overall
>> if it worked the same way on systems without DPC?
> 
> Sure, we can go to this route as well.


ok so finally this is what is being proposed and so far Bjorn, Sinan and 
myself agreed on following:

I need to move the stop and re-enumerate code into the AER path instead 
of patch #6 for both DPC_FATAL and AER_FATAL error types.
Also, I should turn off DPC NON_FATAL error detection.

Keith, please confirm if you are okay with above proposal.

Regards,
Oza.

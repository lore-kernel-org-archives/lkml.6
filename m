Return-Path: <eli.billauer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519761197; cv=none;
        d=google.com; s=arc-20160816;
        b=xiCv24JYax69kKL4ouZIW8sl0AtgnUvY59cOHryslABOe4jFkXj9am71Ehp1j05Mud
         8EYX7TZ/qMf+PAdcF6rMvtbWVQ8ELUWYyqreyyoETKwwv0sjPexNVJLGrS23aCwgNbtq
         ltneYsDj/u0+UsXhHXU3jali3C5ml0Zy5vf/+ztKW+buJ144X+Kj1Ujuu6T2CikupMBW
         M+OrCEhIIA6Gd6TWKD8ntlbrNq4RA07uhmPiXV43CZdhAYkICBKgh6axXPXRJwu3fMPF
         QL4ohYPbEpDUbFWLj3IRJptLeYhUa4ttFpCuE0EbB7nZq6ZBhw/JSznGwgNGtZRLU0/J
         /cBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id:dkim-signature
         :arc-authentication-results;
        bh=fLAmkOp8Bbm2m1I98KnPs3UwAL74ERS4qeQu8TQCSi8=;
        b=nbrcN48xHu55ZePR/b+lo83dJumqJdVsUaoq/fXn+ls7PSHUYxERFpaiAHZ4aMLZJ+
         UeL/Pp8aQcrSR0Ml8OQY9mRaPu/mcagtdLi9RDOLkMz/6v+/f9u7SYu28BFTTbrySv/u
         nkaTLoCGrHD2P9mdu7fEWQmKyUb3KnzW41TrW9a+kODpm5XZOzKnr5jkvcdBmAy1Vn/x
         gztzbiotIFCJIkKyaYPRQXtBaEnylqHQuEANsVdZFNc2TcyjISmvq9ktks0R840pSAEM
         t8r3dRQDaFm0CCW+2bNGsLOB4eIYqrvu2uJX+bnAIJGk/5y/cl9RmrgxNlphm6XeGjbR
         gUkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=L72nxDtL;
       spf=pass (google.com: domain of eli.billauer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=eli.billauer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=L72nxDtL;
       spf=pass (google.com: domain of eli.billauer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=eli.billauer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x22719PQlWc5gRkJTBs/y17LVlFxkntuByygZtGddnfu1TkLm7H7DvxzQT5h9uVbnShVnUr5DIw==
Message-ID: <5A95B6EF.1030305@gmail.com>
Date: Tue, 27 Feb 2018 21:52:15 +0200
From: Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To: Johannes Thumshirn <jthumshirn@suse.de>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Michael Moese <mmoese@suse.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] PCI: add vendor id for Altera
References: <20180227133018.7732-1-jthumshirn@suse.de> <20180227133018.7732-2-jthumshirn@suse.de> <CAHp75VdwHZxCzppayKaLdGJ++QKTKnZWwfHXOJ_bhMVHOJCu1A@mail.gmail.com> <1519746127.25526.25.camel@suse.de>
In-Reply-To: <1519746127.25526.25.camel@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593561031161649636?=
X-GMAIL-MSGID: =?utf-8?q?1593585117859547060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Johannes,

Thanks for the patch.

I can confirm that xillybus_pcie.c compiles well with and without 
including pci_ids.h. As a matter of fact, it already used 
PCI_VENDOR_ID_XILINX, which is defined in pci_ids.h, without including 
it directly. Hence moving PCI_VENDOR_ID_ALTERA didn't change much in 
terms of the dependency on pci_ids.h.

This is a matter of convention -- I'm fine either way.

Regards,
    Eli

On 27/02/18 17:42, Johannes Thumshirn wrote:
> On Tue, 2018-02-27 at 17:32 +0200, Andy Shevchenko wrote:
>    
>> On Tue, Feb 27, 2018 at 3:30 PM, Johannes Thumshirn<jthumshirn@suse.de>
>> wrote:
>>      
>>> Add the Altera PCI Vendor id to pci_ids.h and remove the private
>>> definitions from xillybus_pcie.c and altera-cvp.c.
>>>        
>>      
>>>   #include<linux/pci.h>
>>> +#include<linux/pci_ids.h>
>>>        
>>      
>>>   #include<linux/pci.h>
>>> +#include<linux/pci_ids.h>
>>>        
>> Isn't pci.h includes pci_ids.h ?
>>      
> It indeed is, but it won't do any harm and it's not quite clear what the
> general policy (regarding pci_ids.h) is, some drivers include it (even in
> the drivers/pci/) some don't.
>
> Bjorn, any guidance from your side?
>
> Byte,
> 	Johannes
>
>    

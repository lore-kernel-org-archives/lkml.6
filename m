Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/SXHCRTK33RUkm84kKJxD4XcAitzShg3X60oZEr+C9VOt4nowy2vf6kpQwSnzkJReMrAlJ
ARC-Seal: i=1; a=rsa-sha256; t=1523989724; cv=none;
        d=google.com; s=arc-20160816;
        b=BAnl87VdDXxAdSo1BHOP/Q9P5wLJcyuVgk0BPmh4f8TSKrSNE9oPndIfx914ixKDzm
         bRTAX8XlzEq0q+UJPgSwVaBRXo2uKY+EybaiXtpAHHIswuvurunlewxOwaCNG1d0jvtc
         SwDiXavXGmZ+Y5KhUMZxd180pcw93+OvKEjWcAxOa9z8nPvbKjNTSdCHbvaujqOZyrso
         cT//hczErLiOwS3N3rwvv938V9FefgZR+5tl/4z3QERTySMj+EtxQEwBZ+biO7eBybhy
         HjEXh/esglFUuoRlfP6HG1gxlEAftbspdIQ1iE6lHCFvZJkZAFFStw8cNr61c0xA3cgg
         vl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=4yrhsH9n9aPSf8kYZrxnWABxzWdGYAEVknAFgq6AQ70=;
        b=Xs5Y9ohMGh2Hpt1ZvYwtINyhm5imvVpW9X2xlVxpRaGMQcMWYjpvQ+XJDDK1Vv9MzQ
         aW0ayEsO9FyXBCYCzmu/49Ozu5WDwaj5bmmYSOhK+dIrJJ4UqZe0P0KoG1SK1+WEx+rF
         K2rZ2vNrVgpkLi3Y/vCghXGsiq1VX6NxtseFXnPsjJv0Q2f8aRqhm+Q3irftn5xDmzO8
         x44R5hi1zxh8Z+1AXidBj10PiWmUgTOO9Pjrzsp/AIJVDxvcW2ka5/1f2sNLEoCLJZYY
         /9/ZDu7E582HljsWHq9CUu/eMIuFzzXCKm7Z/Bb9Ecc5tyY/iA9MKjGz8yMJDEsMCrYw
         cnFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Wfu4GDsb;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cBykc+j4;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Wfu4GDsb;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cBykc+j4;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00A9560246
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v2 2/2] parisc: define stronger ordering for the default
 readX()
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org, arnd@arndb.de, timur@codeaurora.org,
 sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Helge Deller <deller@gmx.de>, Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
 <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
 <1523957852.3250.9.camel@HansenPartnership.com>
 <38a1d4e3-cabe-6c39-4355-8d8111637382@codeaurora.org>
 <1523980508.3310.9.camel@HansenPartnership.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <86252a65-265d-e081-b71f-42a0be6b1693@codeaurora.org>
Date: Tue, 17 Apr 2018 14:28:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523980508.3310.9.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597964966697704374?=
X-GMAIL-MSGID: =?utf-8?q?1598019049567681433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/17/2018 11:55 AM, James Bottomley wrote:
> On Tue, 2018-04-17 at 10:13 -0400, Sinan Kaya wrote:
>> Hi James,
>>
>>>
>>> Perhaps if you gave an example of the actual problem you're trying
>>> to fix we could assess if it affects parisc.
>>
>> Let me clarify myself here. Maybe, there is a better solution.
>>
>> 		/* assign ownership */
>> 		desc->status = DEVICE_OWN;
>>
>> 		/* notify device of new descriptors */
>> 		writel(DESC_NOTIFY, doorbell);
>>
>> The difference between writel() and writel_relax() is writel()
>> guarantees memory transactions to be flushed to the device before the
>> register write.
> 
> Um, no it doesn't, at least not in PCI.  It guarantees the write will
> be issued by the memory system, but it may still be cached (called
> posting) in the PCI bridge.  So it doesn't guarantee the write reaches
> the device by the time it returns.


The correct terminology here would be to use observability. Yes, it can be
cached in whatever part of the system for some amount of time as long as
PCI device sees it in the correct order.

Let's do this exercise. 
1. OS writes to memory for some descriptor update
2. OS writes to the device via writel to hit a doorbell
3. Device comes and fetches the memory contents for the descriptor

writel() of PA-RISC needs to ensure that 3. cannot bypass 1. This is typically
done by a write barrier embedded into the writel() on relaxed architectures.

> 
>>  writel_relaxed() does not provide any guarantees about the memory
>> and IO operations.
>>
>> Similarly, readl() provides following code to observe the DMA result
>> while readl_relaxed() does not provide this guarantee.
> 
> Right, the relaxed operator provides no guarantee of ordering between
> the memory and IO domains.  However, it's only really a problem on
> multiple memory controller systems (i.e. NUMA).  Parisc (except
> superdome, which we don't support) doesn't have this problem.  We also
> turn of CPU stream reordering, so compile order is retire order on our
> CPUs (which makes life a lot simpler).

Good to know.

> 
>> Ideally, you want to embed rmb() and wmb() into the writel() and
>> readl() to provide this guarantee.
>>  
>> PA-RISC doesn't seem to support neither one of the barrier types. If
>> you are familiar with the architecture, maybe you could guide us
>> here.
>>
>> Is __raw_writeX() enough to provide this guarantee for this
>> architecture?
> 
> Well, with the volatile address it is.
> 
> The current implementations provide the expected semantics: namely the
> position in the instruction stream is compile (retire) ordered and
> issued from memory once retired.  We still do have the write posting
> problem, but you'll find additional reads in the drivers to flush the
> posted writes, so I don't actually believe we need anything changing.
> 

OK. I'll withdraw my patch. I'm just trying to ensure that all architectures
support writel() semantics. There is an attempt to remove unnecessary
write barriers from the drivers directory between the descriptor update and
writel. 

Just checking that PA-RISC won't break after this.

> James
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

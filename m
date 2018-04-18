Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/7+WFYg8c5BO1Xg50SmporEhO2ovTEef0RKzn/ecUg/foEfc6e8Fxl/1nogHkFckezRtFT
ARC-Seal: i=1; a=rsa-sha256; t=1524058773; cv=none;
        d=google.com; s=arc-20160816;
        b=EM8eR0t96jSpAXsNANSXWv+bXlygcsNLfNKp405VcH1kLYkMUG2oq+6UPtW5C++e6L
         qnec5VLt1qBUJY+zfdsbsK3iBtj9V63frAcuUnNg6Su4roPMJlaA9qaHFdLhHU+h2wxZ
         FH8xn3MsYybzZEHM7pYtKNLNI+vcdYnEv216X29qWYx28Ju+pnAgf0XHAkJb38YOxO/t
         jLaBu4n7uU1Ltm1bl3FXHJO1nVAuZxKw5d8f1ZYnc6eWsxSsQUGceLqu9z6goyyL5GAZ
         49LjhfiG+bmffJqMId1lmWmd/3B7Ja37ACGH27a+fKK5siakWxF1wHdAS7koEQxY1BJG
         lT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=esxgcIvF0NFkQmcoWNj9Q1H8XVTfXn7jaUbAMTcIJIk=;
        b=wPMNwRwRGgCX4JeRq0fXkqXje8qhyXDJjAWiizt4La5RBh6uEMoxmV8T0rjm1KdQm4
         0a7cLiPy0smTV1f152Iaj/vaUZVsMHXOzRaBcMU12wAwsRYa4tfhi8vV0yKBy4gh8BUs
         5iQxFPBXcAZ0UnNxhP6Vl7xO4ZF6wSB2r52cbXjuDSm29tDVm1QPR7I2Ob08xhYmWlb5
         fH52WY63tLvBe8t81kNN7Y4vxqLOzP5a79BQWZ++/NnKbNaEGM8rUU2gXFizi8E8qToh
         TbR4Uzmr+XkoMs5YNCDtD+EoAkkPQYdOqdeZdz3g1/5+u8F/8iesMLoEm8ZefaSRkFg9
         CxAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=F3Ix1qwa;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=W3F39e3G;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=F3Ix1qwa;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=W3F39e3G;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FC57602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v2 2/2] parisc: define stronger ordering for the default
 readX()
To: John David Anglin <dave.anglin@bell.net>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
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
 <86252a65-265d-e081-b71f-42a0be6b1693@codeaurora.org>
 <97fc18a7-b321-0039-0413-d461abc2097b@bell.net>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a8c3391d-7109-47bf-e1c4-9217fc68bfd0@codeaurora.org>
Date: Wed, 18 Apr 2018 09:39:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <97fc18a7-b321-0039-0413-d461abc2097b@bell.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597964966697704374?=
X-GMAIL-MSGID: =?utf-8?q?1598091452664806443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/17/2018 6:53 PM, John David Anglin wrote:
> On 2018-04-17 2:28 PM, Sinan Kaya wrote:
>> The correct terminology here would be to use observability. Yes, it can be
>> cached in whatever part of the system for some amount of time as long as
>> PCI device sees it in the correct order.
>>
>> Let's do this exercise.
>> 1. OS writes to memory for some descriptor update
>> 2. OS writes to the device via writel to hit a doorbell
>> 3. Device comes and fetches the memory contents for the descriptor
>>
>> writel() of PA-RISC needs to ensure that 3. cannot bypass 1. This is typically
>> done by a write barrier embedded into the writel() on relaxed architectures.
> The sequence point after the argument evaluation for writel prevents the compiler from reordering
> 1 and 2.  Accesses to I/O space are strongly ordered on PA-RISC, so 1 must occur before 2 (Page G-1
> of the PA-RISC 2.0 Architecture).  Thus, the current code is okay.
> 

Many thanks for the clarification.

> Dave
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

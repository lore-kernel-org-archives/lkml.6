Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELseQ+98CeQdZdL/gpnDwiXdh/RPD00bsb5KicB0lE4kNOHlwRDgwZIpcbj2tMVVgEh6kW6h
ARC-Seal: i=1; a=rsa-sha256; t=1521098253; cv=none;
        d=google.com; s=arc-20160816;
        b=lgWal3fotUO+7mB4UJdjazwhOF+MTZNRJ9NMZ7q1OOuWVyuEc2+CEvyLyM8LeOK7fk
         k1HCTzV1ZtzqknXluaZ0cwUcT+0sYue8a4Q/M4FT86E3xDtaaF5p38MtV+tGGD7I/V/J
         X7K09T3gGNrYQKsB7MzOXhS3mJsvryewnIql/UF3O4nGC+FVPZuE4fkxukfgAWVqMCLw
         AElTB9/1y500GfOKCCLEUC59npFJ/HB99zJ3suQeoq410KigO5JK3gHzLQm2RCxGvnvK
         hs7KjJvYjD5tKdjsiDNsYf6Nx3uDgeYhYuTgCdhVXFoQg+aW7Tlj5DYtHpoGhVPRObjr
         AtaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=9jihw+9TlbYnazzvYcZp7JHuTVAB3xKpIQKhIWyWCik=;
        b=jVVVrMh4QlyLq2FnK+m81Qzzmik/H3QUHPHjIWBmXlnJwYNV3Yz2sXsfyRMWPWLSCy
         +xaa04KwWh27nhrAfc8X1n4k4RSAVUFi0atZWiKTwrjO7/9z213nPUCcHXKiPmEQdXCn
         o2MgBKnhtR4/xj9mB3uIsyGd85nAs19NY+XS5W32KTH6wsXgTA4DGBPNMNTZYeJc6Quu
         zrSBw2dDOqmU6sjiehevePhihqrA+94/2fW28jGJ6OFICO2Ep+qpkrYWWX9xa4D7nAxL
         EsCvkWkdqhUOGB0V5X4Sq41EtjwDfSClrpe/ACcJgTs1w5nQ+iOSpuD+MBoj0zMAfykg
         L1yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SeizeR6y;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SeizeR6y;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SeizeR6y;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SeizeR6y;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AD8460590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v1 0/4] Fix issues with huge mapping in ioremap
To: "Kani, Toshi" <toshi.kani@hpe.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521038277.2693.131.camel@hpe.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <9954bd28-0457-b80e-8af7-6259b63533f2@codeaurora.org>
Date: Thu, 15 Mar 2018 12:47:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521038277.2693.131.camel@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902258124982014?=
X-GMAIL-MSGID: =?utf-8?q?1594987122059061818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/14/2018 8:08 PM, Kani, Toshi wrote:
> On Wed, 2018-03-14 at 14:18 +0530, Chintan Pandya wrote:
>> Note: I was working on these patches for quite sometime
>> and realized that Toshi Kani has shared some patches
>> addressing the same isssue with subject
>> "[PATCH 0/2] fix memory leak / panic in ioremap huge pages".
>> I've taken slightly different approach here, so sending
>> to the list, finally.
> 
> Hi Chintan,
Hi Toshi
> 
> Do you have any issue in my patchset?  If so, can you please comment on
Not functional issues. But I didn't see issues you mentioned in your
commit text being solved for ARM64 in your patches. It is just being
masked which they were already by Will's patch. In my approach, end
goal was to get benefits of huge mapping back for ARM64.

> them?  It complicates the thing when you send a different approach
> without telling why a different approach is needed.  Your approach
See my reply above. I just had my original patches and I sent it.

> purges TLB after updating pmd/pud, which I think is broken.  Can you
Yes, they are broken. I understood the issues after Mark and Marc's
review comments.

> work on top of my patchset and properly implement pXd_free_pte_page()
I have realized that if I address Mark's comments, my new patch will
look similar to what you have done. So, I will work on top of your
patches.

> for arm64?  I will send out my v2 today.
>    
> Thanks,
> -Toshi
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project

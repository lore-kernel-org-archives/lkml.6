Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELsI4JpR3oAOJNED0uyXH3QCo5WD55iAVo6U4ZTlVFmgxM5yL49iWYCUOWvgzk7StfVGRrTS
ARC-Seal: i=1; a=rsa-sha256; t=1521184485; cv=none;
        d=google.com; s=arc-20160816;
        b=Chs2nfXa9FDAE3Z/tjSQ9LqH1+6McrOuKh2jVn5OkXnC1S3bxmW4DCubzvEke5pu4p
         vidv2Cj0YKgbnCPY/o3ETVbwoVLBaD0cEC8MRMCL2TjshIHA1Ne+GlqJ4XZ7Q+cQOEFj
         sIc9D9uiCA69Ipx3apLkGx1E7WaH/1GYgYcPa9yRYwP6i77QkD1QTspVP0lTW0zQ4wLl
         YwhVSHhzWbJTMYoYOcQTUNRyjWxK/OmvdKr78ADYImSQ+x/JXWa8icls65uOirRSmFtR
         KPatFUnBcRpDGCHb6vXnQvXCoVHS05/4se4/0HdRAq2AwasBQ2+9i/HgLpgnphKhd12/
         FN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=hPB1atSePrr14chfCSe+hBPtRUEHmlSOae6M8CBS4A8=;
        b=NYZBF6qJT/xhOLurafH7O2HF9GUNXjJBdNiwetxMoK17yz4TaKzXCZ/LDhIUzKJl5w
         uofXHMR1iAQcjwxeT3UAW+PRaLpoIyKcP+jzPYU1dbri/iY0aFJ8cT54FY2jtym9WS9Y
         +WOPMup3s0gPvTJwUAeAjXGl73zqg//Yl9dOiuaf2+c+MpDWkwox/k3YVOZdns94u6fU
         0oUFR93z3rgURKickYrHGSvKD7S1gSolvLfsf/h7gRvHpDobi5j8AjNhG4GJxkUcrH2f
         3iNKlhKjOQsxCvbjrjuIX81QrJv5IA2i7NaIctp2atSrDjMJkvPBb2Up9JbQl+96uOp7
         PIsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=D52fGAwV;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=OaO1e2mR;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=D52fGAwV;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=OaO1e2mR;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C8FD6016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
 <20180315131316.fd5ftqwgdb5bf5we@lakrids.cambridge.arm.com>
 <839387ee-e1c2-cc71-c06a-7bc2d0eda73d@codeaurora.org>
 <20180315151645.fsgcywyawvtiwx52@lakrids.cambridge.arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <7d1716a1-0a69-4851-68c6-ebc00d2e8e1d@codeaurora.org>
Date: Fri, 16 Mar 2018 12:44:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315151645.fsgcywyawvtiwx52@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007763353693659?=
X-GMAIL-MSGID: =?utf-8?q?1595077542599482740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/15/2018 8:46 PM, Mark Rutland wrote:
> On Thu, Mar 15, 2018 at 06:55:32PM +0530, Chintan Pandya wrote:
>> On 3/15/2018 6:43 PM, Mark Rutland wrote:
>>> On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
>>>> Huge mapping changes PMD/PUD which could have
>>>> valid previous entries. This requires proper
>>>> TLB maintanance on some architectures, like
>>>> ARM64.
>>>
>>> Just to check, I take it that you mean we could have a valid table
>>> entry, but all the entries in that next level table must be invalid,
>>> right?
>>
>> That was my assumption but my assumption can be wrong if any VA gets
>> block mapping for 1G directly (instead of the 2M cases we discussed
>> so far), then this would go for a toss.
> 
> Ok. Just considering the 4K -> 2M case, is that an assumption, or a
> guarantee?
For 4K->2M case, that's confirmed. I mean, while mapping 2M, all the
next level entries will be unmapped and cleared. That gets ensured
before we land to page table code. But if someone calls these page table
APIs directly without respecting previous mappings, we will not hit
BUG_ON() anywhere but a crash later in unfamiliar situations. But that's
the wrong thing to do.

> 
> Thanks,
> Mark.
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project

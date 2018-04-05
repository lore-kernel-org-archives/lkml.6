Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49PcmeVHF52Y34bpd4aCPuTwVJVwv88uVdOUdGj9sHZR2zV6gSyakvS+RTeXPOuU7pu2I4R
ARC-Seal: i=1; a=rsa-sha256; t=1522919374; cv=none;
        d=google.com; s=arc-20160816;
        b=I/8W3DTn83ra67NA99gqsy5xCuu2rYH9r/+n1q6RJimZ8SVSsoGFMAhJnJ/uFDaBhp
         bVqzmyi6Fv9PPDEEoquOeQOM3Spg2eIkyhC9N1E/U7utKgo+69I6xLLmg5GeF2ZtCPFs
         pLksa+eX58g/i1nDBSeuMkyw9xeyLcjxXnUfORGS7Rd9+bmTl+628nJEn8inrHywPzJS
         sTGPkT7pmkh9+BwlUQIKCd4jaHY1KTOtFuWHaBfInxiV0Fvh/aMKJD93rrYUAMHPtCjJ
         cSwq0uBTDEFHl0WUu+5FKxCtDDb3niO4utt3j5Q+27g7/mXvF8zZc7AE9KsDiQZSxZxN
         iLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=p/tLoCjGHNhTPy+2aupGINvTFVp01nsOSieC/toC1lE=;
        b=EeXOlp7i5T/4aC/+Pz2OPz3IGHEyCxcixMa6/AHxN9PRCBs6YGmHs9fK99LSvE/b2b
         ya/PKrNqgYtrcnZVAYm4NvX88Rws2Kul9f9HnKqYVa4w1gocJOAtQQihISah163ai/fU
         AghKY8kyCePAk/woqgSVIaZu8lSQOOyMgR6vOPtvBZExd4+T0fUMCac88NnSMLP7UQGJ
         XbI1c/v8nTjT4HbDjYt+0bMcSH/mdFdxyomjcWB0Fk7Bdhv2UyU4/wtnPwkdSLvjfL3d
         CxC+pWOyAeS4aWci67zVcQCrzAu+eqUzeomBeI72QsXzrLwz0GkxYKCQ79tLkQeylDEv
         J9sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=J1niWxFA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UmF1wIbv;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=J1niWxFA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UmF1wIbv;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEB69601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
From: Chintan Pandya <cpandya@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com,
 tglx@linutronix.de, akpm@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
 <a613f834-f356-a826-526f-aef532f62951@arm.com>
 <0229cecc-18fc-c3ef-a5cb-be3f9829cad4@codeaurora.org>
Message-ID: <fcc152ba-c88e-6330-7608-4bec398d33d8@codeaurora.org>
Date: Thu, 5 Apr 2018 14:39:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0229cecc-18fc-c3ef-a5cb-be3f9829cad4@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711199968894044?=
X-GMAIL-MSGID: =?utf-8?q?1596896705636850690?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/3/2018 5:25 PM, Chintan Pandya wrote:
> 
> 
> On 4/3/2018 2:13 PM, Marc Zyngier wrote:
>> Hi Chintan,
> Hi Marc,
>>
>> On 03/04/18 09:00, Chintan Pandya wrote:
>>> This series of patches are follow up work (and depends on)
>>> Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
>>> panic in ioremap huge pages".
>>>
>>> This series of patches are tested on 4.9 kernel with Cortex-A75
>>> based SoC.
>>
>> Given that this is targeting mainline, can you please test with 4.16?
>> Basing your patches on something that is over 15 months old is not
>> exactly reassuring.
> 
> We have 4.14 ported with the devices (remotely) accessible to me. If
> that's sufficient, I will post test report by tomorrow.
> 
> If we really require these patches to be tested with 4.16, I would need
> some help here.
> 
Rajendra Nayak <rnayak@codeaurora.org> helped me with testing these
patches on 4.16 kernel (with all the dependent patches already part of
4.16) on SDM845.

In addition to kernel boot up, he executed my test-code which was
stressing ioremap framework and was able to reproduce the bug without
these patches (and Will Deacon's WA).

That passed 10hrs of run.

[36001.446355] IOREMAP_TEST: my tests ended now

Thanks Rajendra Nayak  for testing these patches.

> Thanks,
> 
>>
>> Thanks,
>>
>>     M.
>>
> 
> Chintan

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project

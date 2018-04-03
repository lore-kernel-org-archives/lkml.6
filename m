Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+RRRdnw1wheKixIKbCtVoZqp60UFc9XKaG4iYHaE8LMxmtpyEuzLqJgWP4t9JTRIiVC0n+
ARC-Seal: i=1; a=rsa-sha256; t=1522756542; cv=none;
        d=google.com; s=arc-20160816;
        b=gcjR7bjJlW1A7DoQoCawMfoz75Ksx2jyHAxVh9qftKPGd4/0OCrDgB1wBGvgwGuYZS
         0p5SRd+kxfi/psKAA4A0gmq0cu2+PKk1CjhdNVOgWeFcyvOSKNp+OPeDeN7lBywuIzne
         tcrMF3utqWguCBnTV+PJnHlDUMRJepJNewW9hJiMUTTnYyRg92k5mP8GmSsOgXEu17PL
         Xr9KKgClsMeDFpt0P6CutbaAxFKcYJbXnLktvX7JNrWvfb3Pv+NgWRbHdUyL5VMOjXoC
         j351NI+LQIdUA4E82DwUZfIFeWWaB2g3RHCf3gaprvf4sNTUDxMDB20abXEMGKfQ8vX7
         AwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=GEE7a31ueTFuLAugKfDIvjBBS2ZN/eeiEChiLHfUyh4=;
        b=bEtJSFDW3a0/9vog/T+XUJCkTuoZ1onnVocGuy+cV7eCIWu37LMOLgOZM4McdHPc73
         K19aFgjdQZujY3im6rFK0TqfdBClc9/rt5+r0/dfS1pVl6YErKi8SYxKo9cU8ddOnppR
         RI9b3/B+nxuZFGQjF5bkJu46NRBAvRAcjrQcDNIdzbz+tBEI+9LuC+B1WtVII7qa5D4i
         1LClqpUoK3/sJyDbZd8lq9HmYYWXFgTkYkxoLAf939sca/JdIydDXtgo1apcQUEOGfpN
         eEoBYrYX2kDoDNM3zYcjzZ37Jv0HzNwGPZPAO5Frk8GSQHpHZKZM/rvQJWMcDvBxsqc8
         IEuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jMMmJYT1;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QFRRD+yp;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jMMmJYT1;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QFRRD+yp;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AF936022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
To: Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
 <a613f834-f356-a826-526f-aef532f62951@arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <0229cecc-18fc-c3ef-a5cb-be3f9829cad4@codeaurora.org>
Date: Tue, 3 Apr 2018 17:25:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a613f834-f356-a826-526f-aef532f62951@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711199968894044?=
X-GMAIL-MSGID: =?utf-8?q?1596725964035159046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/3/2018 2:13 PM, Marc Zyngier wrote:
> Hi Chintan,
Hi Marc,
> 
> On 03/04/18 09:00, Chintan Pandya wrote:
>> This series of patches are follow up work (and depends on)
>> Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
>> panic in ioremap huge pages".
>>
>> This series of patches are tested on 4.9 kernel with Cortex-A75
>> based SoC.
> 
> Given that this is targeting mainline, can you please test with 4.16?
> Basing your patches on something that is over 15 months old is not
> exactly reassuring.

We have 4.14 ported with the devices (remotely) accessible to me. If
that's sufficient, I will post test report by tomorrow.

If we really require these patches to be tested with 4.16, I would need
some help here.

Thanks,

> 
> Thanks,
> 
> 	M.
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project

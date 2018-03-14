Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AG47ELsQHIX5gP0AKGor87pjIxgfgJR2mGW3zHpuQd/ZEI4atrTGTiKwOdeO3rdtXSvpYHigH1EK
ARC-Seal: i=1; a=rsa-sha256; t=1521042833; cv=none;
        d=google.com; s=arc-20160816;
        b=wWKZdbt9ILivfntpEbY7lXCmZZfNx/+uugBPdjTe9+MKtm4Ep8aAQZCZjI6JQsOzHS
         TDwJ98dLevQrVGapoQA3V3lOb39/LF9XsU9V4puOWnm1o9fYDgg9+LY5XreCJBOoR2xJ
         1S6R88xU2dOW85wCmfs0fArBvyr5AltivODNIT/pWFHd50EJOVh98VspTEoXNGXeEqIx
         zAxj5TT5j7ENOFF+zNklZ2lGdsRdMYbKlbc52fg6heXKI82s/46Ze6cRHo8vXogLGiQG
         Doa6UUXAi5bxP+WT7d03c83dsaF+sbJPRmfICfTSyADb9zFzomKFer41KTWNDuLOhXUb
         DGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=ghmsn+1C8EFTD0NMNeJ2qY3LNUC2+OdrA2ZYYz6shXI=;
        b=ahd3sNnXu3XtREV9lYvmVaz/tzPcK2Z9LM9+Fpy1sWGA4Yei+e3w1l1NdeqekJAUPR
         4KIX9Yc1XxR3Khs226g9UNdJ1sZPpkt5FT732Wpater5lButmnzgxA10J5Eu3nGgQNin
         tixeSmV/2M9+gQPsLwt0VeLd5HYmBWfha1cOKeFtcJtLGQvpD2idYqonwkHPVG62nN1K
         VpVi6QuL6xrucZiU9Wyva0VswniG+cPtAUCuaJiJQVdnR7pSozgoGEs9y+cA8fxLXfL/
         xxyUwLQdyMBVHpz3qJkDDij8sm5UdQJ5zWdzftqo/YlHMBvfWgno+tmyiq2qSmpHGcPk
         riOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Subject: Re: [PATCH 0/6] irqchip/mips-gic: Enable & use VEIC mode if available
To: James Hogan <jhogan@kernel.org>
Cc: Matt Redfearn <matt.redfearn@mips.com>, Ralf Baechle
 <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
 Dengcheng Zhu <dengcheng.zhu@mips.com>, linux-kernel@vger.kernel.org,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Paul Burton <paul.burton@mips.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
 <c9b5d20c-7adf-5308-1a45-21471d206d10@arm.com>
 <20180314154641.GA8976@saruman>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <bf5ab15a-1151-1163-e139-a3657614d0fd@arm.com>
Date: Wed, 14 Mar 2018 15:53:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314154641.GA8976@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588748156278723185?=
X-GMAIL-MSGID: =?utf-8?q?1594929009966131919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/03/18 15:46, James Hogan wrote:
> On Wed, Mar 14, 2018 at 11:15:47AM +0000, Marc Zyngier wrote:
>> Hi Matt,
>> 
>> On 05/01/18 10:31, Matt Redfearn wrote:
>>> 
>>> This series enables the MIPS GIC driver to make use of the EIC
>>> mode supported in some MIPS cores. In this mode, the cores 6
>>> interrupt lines are switched to represent a vector number,
>>> 0..63. Currently all GIC interrupts are routed to a single CPU
>>> interrupt pin, but this is inefficient since we end up checking
>>> both local and shared interrupt flag registers for both local
>>> and shared interrupts. This introduces additional latency into
>>> the interrupt paths. With EIC mode this can be improved by
>>> using separate vectors for local and shared interrupts.
>>> 
>>> This series is based on 4.15-rc6 and has been tested on Boston,
>>> Malta & SEAD3 MIPS platforms implementing a GIC with and
>>> without EIC mode supported in hardware.
>> 
>> What the status of this series?
> 
> FYI I've been meaning to test it with KVM, since host EIC I think
> will affect KVM & guest stuff.

OK. I'll park that until I hear from you guys.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

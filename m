Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeBTL3C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:29:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751511AbeBTL3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:29:01 -0500
Subject: Re: [PATCH v3 2/4] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
To: David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: karahmed@amazon.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        bp@alien8.de, peterz@infradead.org, jmattson@google.com,
        rkrcmar@redhat.com, arjan.van.de.ven@intel.com, dave.hansen@intel.com,
        mingo@kernel.org
References: <1519037457-7643-1-git-send-email-dwmw@amazon.co.uk>
 <1519037457-7643-3-git-send-email-dwmw@amazon.co.uk>
 <alpine.DEB.2.21.1802200854010.24268@nanos.tec.linutronix.de>
 <1519116825.7876.112.camel@infradead.org>
 <alpine.DEB.2.21.1802201115190.24268@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1802201141160.24268@nanos.tec.linutronix.de>
 <1519125725.7876.117.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36704ae6-650a-e061-0220-9228173e5d81@redhat.com>
Date: Tue, 20 Feb 2018 12:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519125725.7876.117.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2018 12:22, David Woodhouse wrote:
>>>> However, Paolo is very insistent that taking the trap every time is
>>>> actually a lot *slower* than really frobbing IBRS on certain
>>>> microarchitectures, so my hand-waving "pfft, what did they expect?" is
>>>> not acceptable.
>>>>  
>>>> Which I think puts us back to the "throwing the toys out of the pram"
>> There are no more toys in the pram. I threw them all out weeks ago ...
>
> One option is to take the patch as-is¹ with the trap on every access.

Please reword the commit message at least, mentioning that the slow case
is not one we don't care much about yet (no IBRS_ALL CPUs in the wild
afaik) and we won't care much about in the long run either (IBRS_ALL
really only used on a handful of blacklisted processors).

Thanks,

Paolo

> As soon as Intel define that 'IBRS_ALL_AND_THE_BIT_IS_A_NOOP' bit in
> MSR_IA32_ARCH_CAPABILITIES, *then* we can expose it to guests directly
> again just as we do at the moment.
> 
> That way, the slowdown that Paolo is concerned about is limited to a
> small set of current CPUs on which we're mostly unlikely to care too
> much about KVM anyway.

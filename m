Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeCPPAn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:00:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57360 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbeCPPAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:00:42 -0400
Subject: Re: arm64 kvm built with clang doesn't boot
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Hines <srhines@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kernel-dynamic-tools <kernel-dynamic-tools@google.com>
References: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
 <26a25069-ea1d-5fb3-549c-ab653f454a30@arm.com>
 <CAAeHK+zq4-mw3pCNf3nob3gN-s+aWVq7vUy1p8yY4bU4QYNNMg@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <2e84a842-96e8-aec4-8b85-9ee879bb323a@arm.com>
Date: Fri, 16 Mar 2018 15:00:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zq4-mw3pCNf3nob3gN-s+aWVq7vUy1p8yY4bU4QYNNMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/18 14:53, Andrey Konovalov wrote:
> On Fri, Mar 16, 2018 at 3:13 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> I wasn't aware of that discussion, but this is indeed quite annoying.
>> Note that you should be able to restrict this to arch/arm64/kvm/hyp/*
>> and virt/kvm/arm/hyp/*.
> 
> That works as well (tried it, the kernel boots). I've also tried
> compiling without the flag for virt/kvm/arm/hyp/*, it boots as well.

That's just luck. Anything in a hyp/ directory has the potential to be
executed at EL2, and thus could be generating these jump tables. It
could blow up at a later time, once you start running VMs...

	M.
-- 
Jazz is not dead. It just smells funny...

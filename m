Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbeDTINl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:13:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45644 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754264AbeDTINi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:13:38 -0400
Subject: Re: Clang arm64 build is broken
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
References: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <c61336a2-7c66-ea48-3daa-e644403d7a6e@arm.com>
Date: Fri, 20 Apr 2018 09:13:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey.

On 19/04/18 18:06, Andrey Konovalov wrote:
> Hi Marc!
> 
> Your recent commit [1] broke clang build on arm64.

Or rather, it has uncovered yet another missing feature in clang! ;-)

> The issue is that
> clang doesn't know about the "S" asm constraint. I reported this to
> clang [2], and hopefully this will get fixed. In the meantime, would
> it possible to work around using the "S" constraint in the kernel?

I have no idea, I've never used clang to build the kernel. Clang isn't
really supported to build the arm64 kernel anyway (as you mention
below), and working around clang deficiencies would mean that we leave
with the workaround forever. I'd rather enable clang once it is at
feature parity with GCC.

> While we're here, regarding the other issue with kvm [3], I didn't
> receive any comments as to whether it makes sense to send the fix that
> adds -fno-jump-tables flag when building kvm with clang.

Is that the only thing missing? Are you sure that there is no other way
for clang to generate absolute addresses that will then lead to a crash?
Again, I'd rather make sure we have the full picture.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

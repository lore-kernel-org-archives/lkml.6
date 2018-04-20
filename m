Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeDTQ5V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:57:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52034 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752325AbeDTQ5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:57:19 -0400
Subject: Re: Clang arm64 build is broken
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        LKML <linux-kernel@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
References: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
 <c61336a2-7c66-ea48-3daa-e644403d7a6e@arm.com>
 <CAKwvOdnKuFuqoWKpVJqVa1u8A0z2+vQp9j7+TsNh9qz3Yitk-Q@mail.gmail.com>
 <8b3e95df-a429-2f84-565c-3caed8e30e28@arm.com>
 <CAKwvOdmhNH4PYNwH+tsZc4uQQJVhOOHSph2YdDCHcyWNyFMxyA@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <ad937bae-ea95-2758-acf6-6170c4d94d07@arm.com>
Date: Fri, 20 Apr 2018 17:57:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmhNH4PYNwH+tsZc4uQQJVhOOHSph2YdDCHcyWNyFMxyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/18 17:43, Nick Desaulniers wrote:
> On Fri, Apr 20, 2018 at 9:36 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> On 20/04/18 17:30, Nick Desaulniers wrote:
>>> On Fri, Apr 20, 2018 at 1:13 AM Marc Zyngier <marc.zyngier@arm.com>
> wrote:
>>>> Clang isn't
>>>> really supported to build the arm64 kernel anyway
>>>
>>> Can you expand on this?  There are millions of arm64 devices shipping
> with
>>> Clang built Linux kernels.
> 
>> How many of these devices run a full-featured mainline kernel?
> 
>> Sure, Android is building the kernel with clang, but that's with a pile
>> of out of tree patches. At that point, I'm not sure we're talking about
>> the same arm64 kernel.
> 
> Do you recommend that we only work with ARM licensed SoC vendors with no
> out of tree patches?

I mean the clang-related patches which are not upstream. We can ignore
SoC support code for this discussion.

The android clang patches try to create the illusion that clang is
usable for the kernel. It is not. It misses fundamental functionality
that either leads to performance degradation (lack of asm goto) or
prevents the implementation of security fixes (see the recent discussion
about SMCCC 1.1 and the top of this very thread).

I'd rather recommend that clang is brought up to the level of GCC so
that we don't have to continuously have that discussion. Give us that
compiler, and we'll make sure the arm64 doesn't break.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

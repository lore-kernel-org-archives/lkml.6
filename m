Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754026AbeCPOzU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:55:20 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34117 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeCPOzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:55:18 -0400
X-Google-Smtp-Source: AG47ELuip+iWLr7/LbTfdsb4/pkEcy8xpMNS14pM5Y45xTnXEbVBLHsBh+RJEb6MAvOYD2hC462vXwWxyQgDNPkcido=
MIME-Version: 1.0
In-Reply-To: <20180316143119.cdjw4dhm6crcjyrd@lakrids.cambridge.arm.com>
References: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
 <20180316141313.q5vjmj627rv7r7kf@lakrids.cambridge.arm.com> <20180316143119.cdjw4dhm6crcjyrd@lakrids.cambridge.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 16 Mar 2018 15:55:16 +0100
Message-ID: <CAAeHK+z12AhRNQMVL5Xza+U=E-7NL3YA3VZmvrN2pGx8O-+a5Q@mail.gmail.com>
Subject: Re: arm64 kvm built with clang doesn't boot
To: Mark Rutland <mark.rutland@arm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Hines <srhines@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        kernel-dynamic-tools <kernel-dynamic-tools@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 3:31 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>
> FWIW, with that same compiler and patch applied atop of v4.16-rc4, and
> some bodges around clang not liking the rX register naming in the SMCCC
> code, I get a kernel that boots on my Juno, though I immediately hit a
> KASAN splat:
>
> [    8.476766] ==================================================================
> [    8.483990] BUG: KASAN: slab-out-of-bounds in __d_lookup_rcu+0x350/0x400
> [    8.490664] Read of size 8 at addr ffff8009336e2a30 by task init/1

I see this as well, I'm looking into it. It seems that
__no_sanitize_address is not defined for clang (defining it doesn't
help though, so the issue might be deeper).

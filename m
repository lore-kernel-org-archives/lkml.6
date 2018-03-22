Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCVWo7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:44:59 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42073 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCVWo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:44:58 -0400
X-Google-Smtp-Source: AG47ELsSr4niUrKI8BlGq9SgDNZNbryOsbu15bsEreQwrnJz4rrOSj9WNzpuUUEgubI8QBT3lTFJ9A==
Date: Thu, 22 Mar 2018 15:44:56 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>, Dave.Martin@arm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Hackmann <ghackmann@google.com>
Subject: Re: [PATCH] arm/arm64: smccc: Use xN for arm64 register constraints
 with clang
Message-ID: <20180322224456.GB78232@google.com>
References: <20180322212705.141175-1-mka@chromium.org>
 <CAKwvOdk4Tos1Q8dyQvic4PUX3cjy3q1hn3FkK=xiVSChht+gEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdk4Tos1Q8dyQvic4PUX3cjy3q1hn3FkK=xiVSChht+gEg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, Mar 22, 2018 at 10:26:18PM +0000 Nick Desaulniers ha dit:

> Note that a patch in this form has previously been implemented by:
> 
> Andrey Konovalov <andreyknvl@google.com>:
> https://gist.github.com/xairy/ee11682ea86044a45c0291c528cd936f
> 
> and another by:
> 
> Greg Hackmann <ghackmann@google.com>:
> https://android-review.googlesource.com/c/kernel/common/+/645181
> 
> If you used either as a reference, you may want to credit them with a
> `Suggested-by:` in the commit message.

Not really, but I think I prefer Greg's version over mine and might
use it in a respin if nobody raises objections.

> On Thu, Mar 22, 2018 at 2:28 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > +#ifndef __clang__
> > +#define __reg__ "r"
> > +#else
> > +#define __reg__ "x"
> > +#endif
> 
> Can this be flipped to #ifdef __clang__ ?  having an if...else where the
> conditional negated is kind of funny.

Sure, my thought was "common case first", but I agree that the negated
condition isn't ideal either.

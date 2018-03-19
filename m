Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968085AbeCSRWE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:22:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55786 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964956AbeCSRVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 13:21:40 -0400
Date: Mon, 19 Mar 2018 17:21:47 +0000
From: Will Deacon <will.deacon@arm.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v2 00/12] Rewrite asm-generic/bitops/{atomic,lock}.h
 and use on arm64
Message-ID: <20180319172147.GM14916@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
 <CAK7LNATktPPTHDDhS0i=3o8p=XoVXBJ1KB+3VmDp_iqn239Z8g@mail.gmail.com>
 <CAK7LNAT+DVCJ8CbxKYX0yEUdsp-vYU1J+az+yfM9h3-DzoWGgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT+DVCJ8CbxKYX0yEUdsp-vYU1J+az+yfM9h3-DzoWGgQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Mon, Mar 12, 2018 at 12:56:28PM +0900, Masahiro Yamada wrote:
> 2018-03-01 16:16 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > 2018-02-27 0:04 GMT+09:00 Will Deacon <will.deacon@arm.com>:
> >> Hi everyone,
> >>
> >> This is version two of the RFC I previously posted here:
> >>
> >>   https://www.spinics.net/lists/arm-kernel/msg634719.html
> >>
> >> Changes since v1 include:
> >>
> >>   * Fixed __clear_bit_unlock to work on archs with lock-based atomics
> >>   * Moved lock ops into bitops/lock.h
> >>   * Fixed build breakage on lesser-spotted architectures
> >>
> >> Trying to fix the circular #includes introduced by pulling atomic.h
> >> into btops/lock.h has been driving me insane. I've ended up moving some
> >> basic BIT definitions into bits.h, but this might all be better in
> >> const.h which is being proposed by Masahiro. Feedback is especially
> >> welcome on this part.
> >
> >
> > Info for reviewers:
> >
> > You can see my patches at the following:
> >
> > 1/5: https://patchwork.kernel.org/patch/10235457/
> > 2/5: https://patchwork.kernel.org/patch/10235461/
> > 3/5: https://patchwork.kernel.org/patch/10235463/
> > 4/5: https://patchwork.kernel.org/patch/10235469/
> > 5/5: https://patchwork.kernel.org/patch/10235471/
> >
> >
> > 5/5 has conflict with Will's 2/12.
> >
> > Fortunately, it is at the tail of the series.
> > It is easy to pick/drop/change
> > when we decide how to organize it.
> 
> 
> No comments so far about this part.
> 
> I think your approach is better
> since putting BIT* macros into a single header
> is more consistent.
> 
> So, I will ask Andrew to drop mine.

Thanks.

> However, I think <linux/bits.h> will make more sense
> than <asm-generic/bits.h>
> 
> These macros are really arch-agnostic.
> So, we would not expect to have <asm/bits.h>
> that could fall back to <asm-generic/bits.h>, right?

That's fair. I'll do a respin using linux/*.

Cheers,

Will

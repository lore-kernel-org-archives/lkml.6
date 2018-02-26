Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeBZUdI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:33:08 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38356 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbeBZUdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:33:05 -0500
X-Google-Smtp-Source: AH8x2258B5t0JIB/Y4rEWziM7x3pk+pyDHCXD6rMrzsDGaKb9ZNiQQ3jG5zNGmGt7dcVif1eTXbDOyalJBZC/arkOm4=
MIME-Version: 1.0
In-Reply-To: <20180223121456.GZ25201@hirez.programming.kicks-ass.net>
References: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com>
 <20180223121456.GZ25201@hirez.programming.kicks-ass.net>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 26 Feb 2018 12:32:44 -0800
Message-ID: <CAM_iQpUn2Dw=RLXDwEykvhiQDGBfkRVgcb39UN91VAmbk3=i0w@mail.gmail.com>
Subject: Re: Long standing kernel warning: perfevents: irq loop stuck!
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>, "Liang, Kan" <kan.liang@intel.com>,
        jolsa@redhat.com, bigeasy@linutronix.de,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 4:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Feb 22, 2018 at 08:59:47PM -0800, Cong Wang wrote:
>> Hello,
>>
>> We keep seeing the following kernel warning from 3.10 kernel to 4.9
>> kernel, it exists for a rather long time.
>>
>> Google search shows there was a patch from Ingo:
>> https://patchwork.kernel.org/patch/6308681/
>>
>> but it doesn't look like ever merged into mainline...
>>
>> I don't know how it is triggered. Please let me know if any other
>> information I can provide.
>
> What exact workload are you using to reproduce?

I have no idea how to reproduce it. It has been reported so many times
from so many different machines via ABRT.


>
> And I'm taking that the patch 'works' for you?

I don't try it yet, because according to Ingo himself, that patch
is not complete:

"
Also, I'd apply the quirk not just to Haswell, but Nehalem, Westmere
and Ivy Bridge as well, I have seen it as early as on a Nehalem
prototype box.
"

I can try it if that patch makes sense for you and if you can make it
complete. ;)


>
> Given the HSD143 errata and its possible relevance, have you tried
> changing the magic number to 32, does it then still fix things?
>
> No real objection to the patch as such, it just needs a coherent comment
> and a tested-by tag I think.

I will give it a try. Please let me know if you have an updated
version of that patch I can apply on recent kernel (4.9), since it was
made almost 3 years ago, otherwise I can apply it manually.

It will take some time due to the deployment process of a new kernel.

Thanks!

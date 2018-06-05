Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeFEPFV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:05:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44589 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeFEPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:05:18 -0400
X-Google-Smtp-Source: ADUXVKJ62ayiBkQqtwBIS2HKD6VBEKRKhDDpR45LDHcK41aP3AHElO2C4TbbvtfzpGnW/U5YGTjoWA==
Date: Tue, 5 Jun 2018 17:05:14 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: x86/asm: __clear_user() micro-optimization (was: "Re: [GIT PULL]
 x86/asm changes for v4.18")
Message-ID: <20180605150514.GA31065@gmail.com>
References: <20180604122132.GA3337@gmail.com>
 <CA+55aFx=zLkZx4h4rcWv79OKQSGJAwC3eS8=zSDgKjyrsbLrNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx=zLkZx4h4rcWv79OKQSGJAwC3eS8=zSDgKjyrsbLrNA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Jun 4, 2018 at 5:21 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  - __clear_user() micro-optimization (Alexey Dobriyan)
> 
> Was this actually tested?

I'm not sure - Alexey?

> I think one reason people avoided the constant was that on some
> microarchitecture it ended up being a separate uop just for the
> constant generation, because it wouldn't fit in a single uop.
> 
> I'm pretty sure that used to be the case for P4, for example.
> 
> Afaik there have also been issues with decoding instructions that have
> both an immediate and a memory offset.
> 
> I suspect none of this is an issue on modern cores, but there really
> at least historically were cases where
> 
>    mov %reg,mem
> 
> was better than
> 
>    mov $imm,mem
> 
> if %reg already had the right value, so it's not at all 100% obvious
> that the micro-optimization really _optimizes_ anything.
> 
> Any time people do this, they should add numbers.

Ok, fair point and agreed - if Alexey sends some measurements to back the change 
I'll keep this, otherwise queue up a revert.

Thanks,

	Ingo

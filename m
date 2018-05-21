Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbeEUUTz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 16:19:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47508 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeEUUTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 16:19:53 -0400
Date: Mon, 21 May 2018 22:19:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
Message-ID: <20180521201914.GB14289@pd.tnic>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
 <20180514162752.GG23049@pd.tnic>
 <CAG=yYwk-dbMF_7eS9bUraAru8b4fyCosxp+MpQA=1ZYH0nd_hg@mail.gmail.com>
 <20180520204032.GA19845@pd.tnic>
 <CAG=yYw=bdgsTSW80R1Wt9uUTtXeMwX5macbjrPBNzVLihk-Ufw@mail.gmail.com>
 <20180521165803.GA15717@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180521165803.GA15717@agluck-desk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 09:58:03AM -0700, Luck, Tony wrote:
> So BIOS did something to trigger some issues in the L3
> cache (more than once since the overflow and filter bits
> are both set).
> 
> I think (but am not 100% sure because I don't have an
> internal decoder that knows about this specific CPU model)
> that the error was a write-back to MMIO (this matches other
> cases where we've seen BIOS trigger some error and left the
> logs for Linux to find at boot).

We do have that __mcheck_cpu_apply_quirks() and cfg->bootlog thing to
shut it up. Because it all sounds like BIOS forgot to clean up after
itself and the kernel seeing those errors is doing nothing but puzzle
people.

And it's not like there's anything we can do about the erros...

Anyway, just thinking out loud.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

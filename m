Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932326AbeCLUV3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:21:29 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55558 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbeCLUV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:21:27 -0400
X-Google-Smtp-Source: AG47ELvM/rwjbnSb/k+lylogYk8ymhew/Rmms9y4/tEHT2ULcijNyp6q5HwxS9YLCWXGEMELP2wv0uQC6UfmkUl2Xus=
MIME-Version: 1.0
In-Reply-To: <20180311110551.GX17177@axis.com>
References: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
 <20180308155116.GW17177@axis.com> <20180311110551.GX17177@axis.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 12 Mar 2018 21:21:25 +0100
X-Google-Sender-Auth: P-EMC6KffEJXi9ol2nI_RJYMR5I
Message-ID: <CAK8P3a2LRyHmQ1=bFwrW9a3RR53W0CiiakNTg2823utAnVpBmQ@mail.gmail.com>
Subject: Re: [GIT PULL] CRIS: Drop support for the CRIS-port
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Simek <monstr@monstr.eu>, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-cris-kernel@axis.com, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <jesper@jni.nu>, Greentime Hu <green.hu@gmail.com>,
        Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Vincent Chen <deanbo422@gmail.com>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 12:05 PM, Jesper Nilsson
<jesper.nilsson@axis.com> wrote:
> Hi Arnd,
>
> As promised, pull the below tag for the removal of the CRIS-port.
> There are still a few references to the CRIS port left, and they
> can be grouped into two categories:
>
> - Examples or references to the CRIS port as provenance.
>         These I believe can be left as is.
>
> - The workarounds for CRIS not having "unpacked" structs.
>         When I looked at it 10 years ago, CRIS was the only port
>         that needed explicit alignment of some structs,
>         due to pointers being valid at any byte offset in CRIS,
>         which would wreak havoc with code that assumed that the
>         lower bits of a pointer are free to use as flags.
>         I'm leaving these in until we can say that no newer
>         port has the same problem.
>
> Best regards,

Hi Jesper,

Thanks for the patch! I had done a slightly different approach, but
am merging your changes into my tree now. I already have separate
patches for each driver subsystem, so I'll keep my versions, having
already made sure that your changes were identical.

For Documentation/features and the Kconfig files that have lists
of architectures, I also have separate patches that do the changes
for all architectures, to avoid touching those files (up to) eight times
for one trivial change each. I could redo those, but since your patch
conflicts with David Howell's patch for mn10300, it's easier to keep
what I already have.

This leaves basically the removal of arch/cris along with the MAINTAINER
file update. I'm keeping the patch I did, but change the author and
changelog text to what you sent, with my Signed-off-by and a list
of my modifications) added below.

Hope that works for you.

     Arnd

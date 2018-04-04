Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeDDEcP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 00:32:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43721 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbeDDEcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 00:32:14 -0400
X-Google-Smtp-Source: AIpwx481EqsnCeztvfHdrn3iuImC4bI44yj3qtZw4qeImp6loVBzTaSXxBgS3EEY8CfQ92bVrnlDcw==
Subject: Re: [GIT pull] irq updates for 4.17
Date: Tue,  3 Apr 2018 21:31:27 -0700
Message-Id: <20180404043130.31277-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <CA+55aFxRZQgPwtjS0+eiCZvkEVFvOKktuiwG4TZ653Yso3E4bA@mail.gmail.com>
References: <CA+55aFxRZQgPwtjS0+eiCZvkEVFvOKktuiwG4TZ653Yso3E4bA@mail.gmail.com>
Cc: mingo@kernel.org, Arnd Bergmann <arnd@arndb.de>
From: Palmer Dabbelt <palmer@sifive.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Apr 2018 19:03:28 PDT (-0700), Linus Torvalds wrote:
> On Tue, Apr 3, 2018 at 6:51 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> Thanks!  The linked patch set should be fully bisectable, while this one
>> will fail on some ARM randconfigs.
>
> If it's only some (not very realistic) randconfigs, I suspect an
> incremental fix is probably the easier solution, rather than redoing
> that whole branch.

They're randconfigs that can't be selected via menuconfig so maybe that's not a
big deal (and it's why I missed it in the first place).  I'm a big fan of the
sorts of automated build tools that find all my bugs, which is why I was 
willing to jump through some hoops to make the patch set bisectable.

> So mind at least sending that incremental fix on top of the branch to
> Thomas and making his life easier if he decides to go that way?

I'm treating this as the cover letter to that patch set.  I've build
tested this with the same set of configs as my full patch set (arm
defconfig, arm64 defconfig, openrisc defconfig, and a failing arm config
from the 0-day robot) but only after the final patch was applied -- it's
not bisectable anyway.

I've dropped the various acknowledgements, as this is a bit messy and I
don't want to sign any else up as agreeing with it :).

I have follow-on patches to convert arm, arm64, and openrisc to
GENERIC_IRQ_MULTI_HANDLER and then remove the MULTI_IRQ_HANDLER, but
since they're not strictly part of this cleanup I'll submit those via a
more normal process if you end up taking these patches.

This is available as a more pull request smelling method via

    git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
    palmer-for-linus-4.17-ugly_irq

It's on top of the full IRQ pull request.  After doing everything I feel
like it might have been a bit better to base this only on top of the
broken patch (so git bisect could have a bit more info to avoid entering
the broken region), but I feel like that's splitting hairs at this
point.

> And if Thomas is busy doing something else (*), and I come back to
> this tomorrow as-is, I'd want to pull his tree and just apply the
> incremental fix anyway, so it makes sense to send it to me as well.
>
>                     Linus
>
> (*) I have long since accepted that some people have a life outside of
> kernel development too, and don't always reply immediately. I may not
> _understand_ it, but I am resigned to the fact.

Ah, well, I guess in this case it's all really my fault: While I
generally try to avoid having a life, I recently went outside to attend
ELC and managed to catch the flu, which resulted in me missing Thomas'
complaints of me breaking things.

I can't promise that won't happen again :).

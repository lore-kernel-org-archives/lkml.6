Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbeDBVov (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:44:51 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40673 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754317AbeDBVot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:44:49 -0400
X-Google-Smtp-Source: AIpwx49enxiNA1ajDPQlaNIGxM6+3hM7FUudTQHaUCzoidJSA0eSVajymOSEevAY7R3tNhTG7U4rct8CieygD57X3QU=
MIME-Version: 1.0
In-Reply-To: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 14:44:48 -0700
X-Google-Sender-Auth: 0uK087U3p1SAyNgROhND5oRWP6I
Message-ID: <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Ingo Molnar <mingo@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 2:50 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> The biggest change is the forcing of asm-goto support on x86, which effectively
> increases the GCC minimum supported version to gcc-4.5 (on x86).

So my biggest worry isn't gcc-4.5 (anybody who hasn't updated deserves
to be forced, or can stay with old kernels).

No, my biggest worry is clang. What's the status there?

I've pulled this, and honestly, the disaster with
-fmerge-all-constants makes me think that clang isn't that good a
compiler choice anyway, but it's sad if this undoes a lot of clang
work just because of the worries about Spectre and mis-speculated
branches.

             Linus

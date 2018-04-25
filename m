Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755480AbeDYRbZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:31:25 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35342 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754750AbeDYRbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:31:21 -0400
X-Google-Smtp-Source: AB8JxZorsZvKf2ajQqlMvZLSxbCZjnrbAoLM0eSgQvIjVZrUP+tb8OzanE/DLCEHdonG+E0cKfRzGYeL1AZTgiT0xRQ=
MIME-Version: 1.0
In-Reply-To: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Apr 2018 10:31:19 -0700
X-Google-Sender-Auth: jRvdef9jpBfjpoCgcQgGSPkRH24
Message-ID: <CA+55aFypQ0aMSO7T0hxN2YCvckSLZh6BMTuz185TyJZ69jRUrg@mail.gmail.com>
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME
To: Mark Salyzyn <salyzyn@android.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>, Peter Anvin <hpa@zytor.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, Pavel Machek <pavel@ucw.cz>,
        Kevin Easton <kevin@guarana.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 6:45 AM, tip-bot for Thomas Gleixner
<tipbot@zytor.com> wrote:
>
> As stated in the pull request for the unification of CLOCK_MONOTONIC and
> CLOCK_BOOTTIME, it was clear that we might have to revert the change.

I'm ok with the revert., but I do want the revert message to talk
about *exactly* what broke.

I don't see the reported watchdog things, and I run systemd and I ran
these patches.

So it's not just "systemd uses this for a watchdog". It must be
something specific that made it trigger for some people and not
others, and it's that specific thing that we should document so that
we know why this simplification failed.

                 Linus

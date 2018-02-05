Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeBEVVM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:21:12 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:32957 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeBEVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:21:07 -0500
X-Google-Smtp-Source: AH8x224E0jkqgvj0FJ87Q3Y5kfCuHzkv1BJH4+usdEFh5XWsLdnaOEnwvdcAwEHPu5kWcu+OSpPoXANlOWRY/AloIHA=
MIME-Version: 1.0
In-Reply-To: <tip-ebfc15019cfa72496c674ffcb0b8ef10790dcddc@git.kernel.org>
References: <20180202145634.200291-1-arnd@arndb.de> <tip-ebfc15019cfa72496c674ffcb0b8ef10790dcddc@git.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Feb 2018 22:21:06 +0100
X-Google-Sender-Auth: cCAdOmzGGHRfw6Ong-N8TPPwBdo
Message-ID: <CAK8P3a3MMwRQ00YxuPhEmNzqiMn4+VX48b82831i+kCqruCMfQ@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/dumpstack: Avoid uninitlized variable
To: Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Nicolas Pitre <nico@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        bpetkov@suse.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc: linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 11:36 PM, tip-bot for Arnd Bergmann
<tipbot@zytor.com> wrote:
> Commit-ID:  ebfc15019cfa72496c674ffcb0b8ef10790dcddc
> Gitweb:     https://git.kernel.org/tip/ebfc15019cfa72496c674ffcb0b8ef10790dcddc
> Author:     Arnd Bergmann <arnd@arndb.de>
> AuthorDate: Fri, 2 Feb 2018 15:56:17 +0100
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Fri, 2 Feb 2018 23:33:50 +0100
>
> x86/dumpstack: Avoid uninitlized variable
>
> In some configurations, 'partial' does not get initialized, as shown by
> this gcc-8 warning:
>
> arch/x86/kernel/dumpstack.c: In function 'show_trace_log_lvl':
> arch/x86/kernel/dumpstack.c:156:4: error: 'partial' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     show_regs_if_on_stack(&stack_info, regs, partial);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This initializes it to false, to get the previous behavior in this case.
>
> Fixes: a9cdbe72c4e8 ("x86/dumpstack: Fix partial register dumps")


I just noticed my annotation got lost when I sent the patch. I originally
meant to ask Josh to double-check whether it should be 'false' or 'true'
here, or if we maybe need a larger change.

Josh, could you take a look? Unfortunately I did not really understand
your original commit, so I don't know what the safe choice is here
in those cases in which 'partial' is uninitialized.

       Arnd

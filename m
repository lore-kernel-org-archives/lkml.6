Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeCEFwa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:52:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932662AbeCEFw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:52:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66E4A6022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH] bug: Exclude non-BUG/WARN exceptions from report_bug()
References: <20180301225934.GA34350@beast>
        <CA+55aFzG6od5cy_mmepygSb_9m3Em336T00LoOK-MVkVPsJ-hg@mail.gmail.com>
        <CAGXu5jKCsWvRRZRhdcFdDTipjWZcL_UO6jekH2R-_C3f8Mi1-A@mail.gmail.com>
        <CA+55aFwPZdYGQaEww_wPM_AibQ7tpNSXXAQpKkbgBQRrYN2WZA@mail.gmail.com>
Date: Mon, 05 Mar 2018 07:52:23 +0200
In-Reply-To: <CA+55aFwPZdYGQaEww_wPM_AibQ7tpNSXXAQpKkbgBQRrYN2WZA@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 2 Mar 2018 13:23:27 -0800")
Message-ID: <87a7vn9ii0.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Mar 2, 2018 at 12:22 PM, Kees Cook <keescook@chromium.org> wrote:
>>
>> My question would be, will the existing automated systems that parse
>> the "PATCH" subject deal with a non-whitespaced suffix like this?
>
> Hmm. Maybe just space them out. That's what networking already does,
> ie you'll see things like
>
>     [PATCH net-next v3 0/5] patch description here
>
>     [PATCH net] some-patch-description
>
> in subject lines. Maybe we can just encourage that format in general.
>
> And yes, I agree, for when the targets are obvious, this clearly isn't
> needed. And often they are.
>
> So this would still likely be the exception rather than the rule, but
> it would be a lot more obvious than hiding a one-liner commentary deep
> in the middle of the email.

At least for me (as the wireless-drivers maintainer) this would be a
major improvement as it's not always clear to which to tree a patch
should be applied and it would save unnecessary ping pong when I need to
ask which tree is the patch going to. I think few times I have even
accidentally applied a patch which Dave has already applied to the net tree
because of the target tree was not clearly marked.

So at least I would very much welcome having this documented somewhere
in Documentation so that I can start convincing people to use it more :)

-- 
Kalle Valo

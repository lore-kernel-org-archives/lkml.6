Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933728AbeCBVXb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:23:31 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:40649 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933644AbeCBVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:23:29 -0500
X-Google-Smtp-Source: AG47ELt5XOnxl3M0RSDY93hUGECbLrQEKM1ujCgByQ3AEV0It3riPn17irQRxoUGg66LgVzPypykWWzrpcG4jNE2qC0=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKCsWvRRZRhdcFdDTipjWZcL_UO6jekH2R-_C3f8Mi1-A@mail.gmail.com>
References: <20180301225934.GA34350@beast> <CA+55aFzG6od5cy_mmepygSb_9m3Em336T00LoOK-MVkVPsJ-hg@mail.gmail.com>
 <CAGXu5jKCsWvRRZRhdcFdDTipjWZcL_UO6jekH2R-_C3f8Mi1-A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Mar 2018 13:23:27 -0800
X-Google-Sender-Auth: 5pcbibl-vRJTp8FXzP03I4iHQC4
Message-ID: <CA+55aFwPZdYGQaEww_wPM_AibQ7tpNSXXAQpKkbgBQRrYN2WZA@mail.gmail.com>
Subject: Re: [RESEND][PATCH] bug: Exclude non-BUG/WARN exceptions from report_bug()
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 12:22 PM, Kees Cook <keescook@chromium.org> wrote:
>
> My question would be, will the existing automated systems that parse
> the "PATCH" subject deal with a non-whitespaced suffix like this?

Hmm. Maybe just space them out. That's what networking already does,
ie you'll see things like

    [PATCH net-next v3 0/5] patch description here

    [PATCH net] some-patch-description

in subject lines. Maybe we can just encourage that format in general.

And yes, I agree, for when the targets are obvious, this clearly isn't
needed. And often they are.

So this would still likely be the exception rather than the rule, but
it would be a lot more obvious than hiding a one-liner commentary deep
in the middle of the email.

              Linus

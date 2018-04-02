Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeDBR43 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:56:29 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:55329 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeDBR42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:56:28 -0400
X-Google-Smtp-Source: AIpwx4/D4/k2AzzlQp6h/84EQ7XxC1JXom4uA5YIJ3ZqAQdutQ1uohTI9k5b0bf7dkiKn+szznkITR4KGwrs07EdlsU=
MIME-Version: 1.0
In-Reply-To: <20180402172713.B7D6F0C0@viggo.jf.intel.com>
References: <20180402172700.65CAE838@viggo.jf.intel.com> <20180402172713.B7D6F0C0@viggo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 10:56:26 -0700
X-Google-Sender-Auth: aNZvh9xEuxtZ-tAlqOVjjcu_ptM
Message-ID: <CA+55aFx5GCahkr_-Y0qF5S=USCXhNcvWZ6gr_TxpvUVAh46STA@mail.gmail.com>
Subject: Re: [PATCH 09/11] x86/pti: enable global pages for shared areas
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, namit@vmware.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 10:27 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> +       /*
> +        * The cpu_entry_area is shared between the user and kernel
> +        * page tables.  All of its ptes can safely be global.
> +        */
> +       if (boot_cpu_has(X86_FEATURE_PGE))
> +               pte = pte_set_flags(pte, _PAGE_GLOBAL);

So this is where the quesion of "why is this conditional" is valid.

We could set _PAGE_GLOBAL unconditionally, not bothering with testing
X86_FEATURE_PGE.

                Linus

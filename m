Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeBGBzi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:55:38 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43396 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752468AbeBGBzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:55:37 -0500
X-Google-Smtp-Source: AH8x225oXqIgB+VR+3Ud8JZPM2ZLwhvY133YfFmaFPBJmOk98bHtff2lDXy7wuDxVSeEyO7ROdT188Od0EeIz+mNXco=
MIME-Version: 1.0
In-Reply-To: <CA+55aFy4UkbAgghSGN_vcLLF229avLmdx8nWyLMSBPRuD+vCvw@mail.gmail.com>
References: <151796719550.10756.8688156573547110419.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFy4UkbAgghSGN_vcLLF229avLmdx8nWyLMSBPRuD+vCvw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Feb 2018 17:55:36 -0800
Message-ID: <CAPcyv4hZjYh2eTiDWV1NTdoDoNMZa8YM21CSqmh+jwhObZjf6Q@mail.gmail.com>
Subject: Re: [PATCH] x86/nospec: Fixup array_index_nospec_mask() asm constraint
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 5:50 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Feb 6, 2018 at 5:33 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> Allow the compiler to handle @size as an immediate value rather than
>> allocating a register.
>
> Actually, maybe that "ir" should be "g".
>
> Because it's fine if it's a memory location too. "cmp" takes pretty
> much anything, as long as the thing we compare _to_ is a register.

Ok, no worries I'll do a v2. In fact you suggested 'g' in your initial
version and I lost that along the way while wrestling with why the
compiler miscompiled it until I put it in a static inline rather than
a macro.

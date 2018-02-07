Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeBGBuZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:50:25 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:34917 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753045AbeBGBuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:50:22 -0500
X-Google-Smtp-Source: AH8x225iAj9AvWo3V8pGALkmeS2gNS9U5s2vrYJBFB5UNJsAoKQlbjDfqZ2BK/enHdBz9uOx+hEIEWLJ9AiE9TUTk4s=
MIME-Version: 1.0
In-Reply-To: <151796719550.10756.8688156573547110419.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151796719550.10756.8688156573547110419.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Feb 2018 17:50:21 -0800
X-Google-Sender-Auth: wH1-F_JWmLGDVs9SCNvSjOpLp00
Message-ID: <CA+55aFy4UkbAgghSGN_vcLLF229avLmdx8nWyLMSBPRuD+vCvw@mail.gmail.com>
Subject: Re: [PATCH] x86/nospec: Fixup array_index_nospec_mask() asm constraint
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 5:33 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> Allow the compiler to handle @size as an immediate value rather than
> allocating a register.

Actually, maybe that "ir" should be "g".

Because it's fine if it's a memory location too. "cmp" takes pretty
much anything, as long as the thing we compare _to_ is a register.

              Linus

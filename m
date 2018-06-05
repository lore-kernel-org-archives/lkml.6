Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeFEV3A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:29:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40054 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeFEV25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:28:57 -0400
X-Google-Smtp-Source: ADUXVKKrBpCX61JQTGM5J5SuPDMo7NSOfXSL0A4NoQV4qFwbuTjbP1eOKV0MMv+XD/QYVLemott3UFU3aPBK6a1dNxA=
MIME-Version: 1.0
In-Reply-To: <20180605170532.170361-3-ndesaulniers@google.com>
References: <20180605170532.170361-1-ndesaulniers@google.com> <20180605170532.170361-3-ndesaulniers@google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Jun 2018 23:28:54 +0200
X-Google-Sender-Auth: mL3x_csGcqYNBuk7-miSAUq_tQk
Message-ID: <CAK8P3a0v6sr_oZmYTZV7E-uJ8JdG6D8JqUesHDPkPY2UrWKdvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86: paravirt: make native_save_fl extern inline
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, akataria@vmware.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        gregkh <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, mjg59@google.com,
        Matthias Kaehlcke <mka@chromium.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>, tweek@google.com,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        virtualization@lists.linux-foundation.org, astrachan@google.com,
        manojgupta@google.com, Greg Hackmann <ghackmann@google.com>,
        sedat.dilek@gmail.com, tstellar@redhat.com,
        Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>, mawilcox@microsoft.com,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 7:05 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The semantics of extern inline has changed since gnu89. This means that
> folks using GCC versions >= 5.1 may see symbol redefinition errors at
> link time for subdirs that override KBUILD_CFLAGS (making the C standard
> used implicit) regardless of this patch. This has been cleaned up
> earlier in the patch set, but is left as a note in the commit message
> for future travelers.

I think the keyword you are missing is

__attribute__((gnu_inline))

which forces the gnu89 behavior on all compiler versions. It's been supported
since gcc-4.2, so it should not cause problems on any compiler that is able
to build an x86 kernel.

       Arnd

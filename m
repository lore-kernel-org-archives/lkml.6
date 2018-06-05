Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeFERxO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:53:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38515 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeFERwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:55 -0400
X-Google-Smtp-Source: ADUXVKLJx5iu+uE0lO8wS8Beia0gJ0bHXTSUr1XNyGYLTqgGuo3DOHPjzEIYdJVKapmyEPcqAMpw5drXRcJ4/fizOOU=
MIME-Version: 1.0
References: <20180605170532.170361-1-ndesaulniers@google.com>
 <20180605170532.170361-3-ndesaulniers@google.com> <26c7fd1c-ab40-368f-c2e3-43a6b45157fd@zytor.com>
 <0dd024cd-e05a-0d67-c1bf-1a532714bb1a@zytor.com>
In-Reply-To: <0dd024cd-e05a-0d67-c1bf-1a532714bb1a@zytor.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 5 Jun 2018 10:52:42 -0700
Message-ID: <CAKwvOdk0v4gY04_pbMeUT7Ly5oRHetKorQXnjp_UVBabK74Ekw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86: paravirt: make native_save_fl extern inline
To: hpa@zytor.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, akataria@vmware.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "J. Kiszka" <jan.kiszka@siemens.com>, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        kirill.shutemov@linux.intel.com, mingo@redhat.com, mjg59@google.com,
        Matthias Kaehlcke <mka@chromium.org>,
        Philippe Ombredanne <pombredanne@nexb.com>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/18 10:28, H. Peter Anvin wrote:
> On 06/05/18 10:05, Nick Desaulniers wrote:
>> +
>> +/*
>> + * void native_restore_fl(unsigned long flags)
>> + * %rdi: flags
>> + */
>> +ENTRY(native_restore_fl)
>> +    push %_ASM_DI
>> +    popf
>> +    ret
>> +ENDPROC(native_restore_fl)
>> +EXPORT_SYMBOL(native_restore_fl)
>>
>
> To work on i386, this would have to be %_ASM_AX in that case.

?

Does the kernel have a different calling convention for 32b x86? How
does that work? regparm=3? Does that need to be added to the
declaration?

> Something like this added to <asm/asm.h> might be useful; then you can
> simply:
>
>       push %_ASM_ARG1
>
> Version with fixed typo...

Oh, nice, thanks! I'll pick this up and add it to my patch set for v3
(or did you want me to review/sign-off now?) I can pick up Sedat's
suggestion.
-- 
Thanks,
~Nick Desaulniers

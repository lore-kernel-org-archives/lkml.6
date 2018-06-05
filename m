Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeFESIS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:08:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34047 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbeFESIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:08:15 -0400
Subject: Re: [PATCH v2 2/2] x86: paravirt: make native_save_fl extern inline
To: Nick Desaulniers <ndesaulniers@google.com>
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
References: <20180605170532.170361-1-ndesaulniers@google.com>
 <20180605170532.170361-3-ndesaulniers@google.com>
 <26c7fd1c-ab40-368f-c2e3-43a6b45157fd@zytor.com>
 <0dd024cd-e05a-0d67-c1bf-1a532714bb1a@zytor.com>
 <CAKwvOdk0v4gY04_pbMeUT7Ly5oRHetKorQXnjp_UVBabK74Ekw@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <a40b7e04-8d7c-b26f-4cb9-457bf0fd4a6a@zytor.com>
Date: Tue, 5 Jun 2018 11:06:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdk0v4gY04_pbMeUT7Ly5oRHetKorQXnjp_UVBabK74Ekw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/18 10:52, Nick Desaulniers wrote:
> 
> Does the kernel have a different calling convention for 32b x86? How
> does that work? regparm=3? Does that need to be added to the
> declaration?
> 

Yes, -mregparm=3.  No, doesn't need to be added to the declaration.


>> Something like this added to <asm/asm.h> might be useful; then you can
>> simply:
>>
>>       push %_ASM_ARG1
>>
>> Version with fixed typo...
> 
> Oh, nice, thanks! I'll pick this up and add it to my patch set for v3
> (or did you want me to review/sign-off now?) I can pick up Sedat's
> suggestion.
> 

Add it to your patchset and add your own signoff underneath mine.

	-hpa

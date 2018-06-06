Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96FAA601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933496AbeFFQlw convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Wed, 6 Jun 2018 12:41:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37503 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932724AbeFFQlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:41:50 -0400
Date: Wed, 06 Jun 2018 09:39:25 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+icZUXEpe954z0TSbhSJPdFCfOqsBtpO9mPZBcJ2HWubSo_zQ@mail.gmail.com>
References: <20180605170532.170361-1-ndesaulniers@google.com> <20180605170532.170361-2-ndesaulniers@google.com> <202492204c2d5bd5ca27307cbca5e44673b739ed.camel@perches.com> <5ad1876557235a089a50e6ed6c558a7dcb0da714.camel@perches.com> <CA+icZUXEpe954z0TSbhSJPdFCfOqsBtpO9mPZBcJ2HWubSo_zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 1/2] compiler-gcc.h: add gnu_inline to all inline declarations
To: sedat.dilek@gmail.com, Sedat Dilek <sedat.dilek@gmail.com>,
        Joe Perches <joe@perches.com>
CC: Nick Desaulniers <ndesaulniers@google.com>,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        aryabinin@virtuozzo.com, akataria@vmware.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        caoj.fnst@cn.fujitsu.com, gregkh@linuxfoundation.org,
        jan.kiszka@siemens.com, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, mingo@redhat.com,
        mjg59@google.com, mka@chromium.org, pombredanne@nexb.com,
        rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
        tweek@google.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org, astrachan@google.com,
        manojgupta@google.com, ghackmann@google.com, tstellar@redhat.com,
        keescook@google.com, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, linux-kbuild@vger.kernel.org,
        geert@linux-m68k.org, will.deacon@arm.com, mawilcox@microsoft.com,
        Arnd Bergmann <arnd@arndb.de>, rientjes@google.com
From: hpa@zytor.com
Message-ID: <5C97550D-BEF4-4069-9373-F7543E3878FB@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 6, 2018 1:05:45 AM PDT, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>Hi,
>
>when discovering 'gnu_inline', I found ...
>
>$ git grep -w  __FORTIFY_INLINE
>include/linux/string.h:#define __FORTIFY_INLINE extern __always_inline
>__attribute__((gnu_inline))
>include/linux/string.h:__FORTIFY_INLINE char *strncpy(char *p, const
>char *q, __kernel_size_t size)
>include/linux/string.h:__FORTIFY_INLINE char *strcat(char *p, const
>char *q)
>include/linux/string.h:__FORTIFY_INLINE __kernel_size_t strlen(const
>char *p)
>include/linux/string.h:__FORTIFY_INLINE __kernel_size_t strnlen(const
>char *p, __kernel_size_t maxlen)
>include/linux/string.h:__FORTIFY_INLINE size_t strlcpy(char *p, const
>char *q, size_t size)
>include/linux/string.h:__FORTIFY_INLINE char *strncat(char *p, const
>char *q, __kernel_size_t count)
>include/linux/string.h:__FORTIFY_INLINE void *memset(void *p, int c,
>__kernel_size_t size)
>include/linux/string.h:__FORTIFY_INLINE void *memcpy(void *p, const
>void *q, __kernel_size_t size)
>include/linux/string.h:__FORTIFY_INLINE void *memmove(void *p, const
>void *q, __kernel_size_t size)
>include/linux/string.h:__FORTIFY_INLINE void *memscan(void *p, int c,
>__kernel_size_t size)
>include/linux/string.h:__FORTIFY_INLINE int memcmp(const void *p,
>const void *q, __kernel_size_t size)
>include/linux/string.h:__FORTIFY_INLINE void *memchr(const void *p,
>int c, __kernel_size_t size)
>include/linux/string.h:__FORTIFY_INLINE void *memchr_inv(const void
>*p, int c, size_t size)
>include/linux/string.h:__FORTIFY_INLINE void *kmemdup(const void *p,
>size_t size, gfp_t gfp)
>include/linux/string.h:__FORTIFY_INLINE char *strcpy(char *p, const
>char *q)
>
>After the inline changes suggested by Joe this can be adapted?
>
>Beyond this, a general question: Can someone explain why all these
>inline defines are in compiler-gcc.h (as there exists compiler.h and
>compiler-clang.h)?
>
>Thanks.
>
>Regards,
>- Sedat -

Because gcc itself also supports both GNU89-style and C99-style inlines, but the kernel was built with the former, and it is not necessarily a trivial modification, except for "static inline" which is the same for both.

The other option is to pass -fgnu89-inline on the command line, which is supported by both gcc and clang. The two methods are fully equivalent.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

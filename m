Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx48GS/QGKvDszy28jBaCjFCNnyPKIKBSI3fnI5Xziua6LgdxuFVy+d5JBqNnlH9/DNQveHLd
ARC-Seal: i=1; a=rsa-sha256; t=1522207296; cv=none;
        d=google.com; s=arc-20160816;
        b=DaziT/pHcL3lPDhUFWUWVKxhByOIR4vdsRRJRAf5rqMKZcaQ4a2zRku+Jw+rnwso2G
         uBAHZrR/hd9+QQcwfGkN6oIP3/GXhDl5o4wwFFF3lAKUtzjpF7LT/StyRejGLuyCrrFz
         e82rZF254Fsmeu5ODCD9+OGJs/r392MXl5Mmyj6rgb85NEH+rhxh6tUK7DG8tvqcsMja
         cK1UtEQcxbCiTQbOeZuUmGlLysia/cKgU6ev70kJeMjzr8IRqDhXDw+DC8K6JPB4qgm3
         Z0PNUFs7I2PQNJGvabIkPw2qX2H78RhWJiWxf/jaVjCA4tQ85MCrxLehhDlgO7oNYPEr
         tFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=ZAy76ZDgMpFyv4iDm97KiRcdcWibykMvlk2bUyZBNa0=;
        b=0hykhrUzgWms9YuPBnCvAmkfJFsvIGkTFnQBA+HHG3lWrxLcN3If2KLVkpBzzAxXK0
         wB+1F6vnx/ZU3aynvlvvkR7njBnzajZPIcmyVBKYD+mwQ3DB3r/DVJJZf07s2+ACQwhH
         6y5ion4aFCWQ7E+WgdSyE81bg/EvaNHYpWBK2N2GTKVw8r8R8kiDJWVneczSumpjT9+S
         g7f6c+10BCuzp5Kd29SvoNDIVQKSifcbt6JZk1N7IlsFCuoylLMl3NtV32igOZQplzNX
         L4RNmmLQPmF6c9STZGNTc8vV/q0MqVdWnk8N53EchFjX4fRXklRchp8lta4FKcmAUKBc
         PXwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=KWANbInd;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=KWANbInd;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w2S3LEp0004697
X-Nifty-SrcIP: [209.85.217.176]
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJMEG6WZo8qEjGpFBkU7FkjyFbjf5diZqa8sz+XqCxHuQ@mail.gmail.com>
References: <1522204848-11803-1-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jJMEG6WZo8qEjGpFBkU7FkjyFbjf5diZqa8sz+XqCxHuQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 28 Mar 2018 12:20:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ69JWJU_RJzr39b4gtF1ss-qm_b_AzLBFf2+m2-bx+Xg@mail.gmail.com>
Message-ID: <CAK7LNAQ69JWJU_RJzr39b4gtF1ss-qm_b_AzLBFf2+m2-bx+Xg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: move <linux/compiler_types.h> out of <linux/kconfig.h>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596147516031704256?=
X-GMAIL-MSGID: =?utf-8?q?1596150038553899835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-28 12:10 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Tue, Mar 27, 2018 at 7:40 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Since commit 28128c61e08e ("kconfig.h: Include compiler types to avoid
>> missed struct attributes"), <linux/kconfig.h> pulls in kernel-space
>> headers to unrelated file.
>>
>> Commit 0f9da844d877 ("MIPS: boot: Define __ASSEMBLY__ for its.S build")
>> suppressed the build error by defining __ASSEMBLY__, but ITS (i.e. DTS)
>> is not assembly, and should not include <linux/compiler_types.h> in the
>> first place.
>>
>> Looking at arch/s390/tools/Makefile, host programs gen_facilities and
>> gen_opcode_table now pull in <linux/compiler_types.h> as well.
>>
>> The motivation for that commit was to define necessary attributes
>> before any struct is defined.  Obviously, this happens only in C.
>>
>> It is enough to include <linux/compiler_types.h> only when compiling
>> C files, and only when compiling kernel space.
>>
>> Move the <linux/compiler_types.h> inclusion to c_flags.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> I will also send a correct fix-up for MIPS Makefile later.
>
> As long as the result is the same: it's impossible to define a
> structure without defined attributes, I'm fine with it. :)
>
> Question below...
>
>>
>>
>>
>>  include/linux/kconfig.h | 3 ---
>>  scripts/Makefile.lib    | 1 +
>>  2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
>> index dcde947..cc8fa10 100644
>> --- a/include/linux/kconfig.h
>> +++ b/include/linux/kconfig.h
>> @@ -70,7 +70,4 @@
>>   */
>>  #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
>>
>> -/* Make sure we always have all types and struct attributes defined. */
>> -#include <linux/compiler_types.h>
>> -
>>  #endif /* __LINUX_KCONFIG_H */
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index c114ce5..07d0740 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -152,6 +152,7 @@ __cpp_flags     = $(call flags,_cpp_flags)
>>  endif
>>
>>  c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
>> +                -include $(srctree)/include/linux/compiler_types.h       \
>
> Why here instead of adding it to LINUXINCLUDE ?
>


LINUXINCLUDE contains '-include $(srctree)/include/linux/kconfig.h'

If you add compier_types.h there, nothing would change.


My intention is to include <linux/compiler_types.h> only for C.
Not assembly, linker scripts, or anything else.






-- 
Best Regards
Masahiro Yamada

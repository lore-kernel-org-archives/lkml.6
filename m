Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 33B93C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FA42086A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FA42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755510AbeFNVip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:38:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40473 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbeFNVin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:38:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so3852588pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 14:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hCrxT6RZ1E50clHN21dVDDpH2Ba7VFCNOk8KOEoGcyY=;
        b=kF7/wt0vuVwr2wsSOLkynt/mRLQ2PMpQdKRIHlyMh/WoN4Bcpu9nuyLPyo4B4xU8oH
         iDzdQUd9BgihXnoMGtuUlo7Codi5ytN+qu/xV3+aZKENynxb8mWAkdxKNpnmtVV4klyw
         e7ZLCgbs8x6k6aXjR+DXq1DnAQ/X8C5wJ+qV3ogWmucPsTQD6x1LEcer6JVa2ITC+Mer
         YLinxlcHC2jt2ASu8bxqY8Z9D0VGLa6cEULFZWqMkvXX6sjowwYhoD0YW8S+WxzDoCaN
         /6a972fMYRRwf/8zsuKil5LLqdUm78rBUIb9ABQk1rMirtiMAIv6TJ7kn+fJTRd6Mst6
         I5Og==
X-Gm-Message-State: APt69E0i2RIuXeLcFbvFq++ULAh31k+SW7bU9eMaArfpVixnVgls5YUI
        YWRVLgKx5v9oBw9tRFBDHjfOnQ==
X-Google-Smtp-Source: ADUXVKIVR7z8iitG9Wu/hpe+eG+ByShxNmQL/cAzGZQY744WJkv6iLErv+yI9lOsTrIuK+jZO5jOWw==
X-Received: by 2002:a63:6882:: with SMTP id d124-v6mr3689821pgc.83.1529012322707;
        Thu, 14 Jun 2018 14:38:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:602:9802:a8dc::27e5])
        by smtp.gmail.com with ESMTPSA id b74-v6sm15239666pfl.138.2018.06.14.14.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 14:38:41 -0700 (PDT)
Subject: Re: [PATCHv4 2/3] kbuild: Introduce build-salt linker section and
 config option
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <20180612003224.3658-1-labbott@redhat.com>
 <20180612003224.3658-3-labbott@redhat.com>
 <CAK7LNASB3Jdj3TwWJGmSEsrXWfJX8xcm1ZN2gKwY7P8hReog-w@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <b843fc76-664d-6f9f-af00-93489e421546@redhat.com>
Date:   Thu, 14 Jun 2018 14:38:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNASB3Jdj3TwWJGmSEsrXWfJX8xcm1ZN2gKwY7P8hReog-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 11:06 PM, Masahiro Yamada wrote:
> Hi.
> 
> 
> 2018-06-12 9:32 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>>
>> The build id generated from --build-id can be generated in several different
>> ways, with the default being the sha1 on the output of the linked file. For
>> distributions, it can be useful to make sure this ID is unique, even if the
>> actual file contents don't change. The easiest way to do this is to insert
>> a section with some data.
>>
>> Introduce a macro to insert a linker section which will be filled
>> with a hex value. This will ensure the build id can be changed just via
>> a config option. Users who don't care about this can leave the
>> default value and strip the section.
>>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   include/asm-generic/vmlinux.lds.h | 6 ++++++
>>   init/Kconfig                      | 9 +++++++++
>>   scripts/module-common.lds.S       | 4 ++++
>>   3 files changed, 19 insertions(+)
>>
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index e373e2e10f6a..4af7e683aad2 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -830,6 +830,12 @@
>>   #define PERCPU_DECRYPTED_SECTION
>>   #endif
>>
>> +#define        BUILD_SALT                                                      \
>> +       . = ALIGN(32);                                                  \
>> +       .salt : AT(ADDR(.salt) - LOAD_OFFSET) {                         \
>> +         LONG(0xffaa5500);                                             \
>> +         . = ALIGN(32);                                                \
>> +       } = CONFIG_BUILD_ID_SALT                                        \
> 
> 
> What is 0xffaa5500 ?
> 
> Is it another salt in addition to CONFIG_BUILD_ID_SALT ?
> 
> Or, does it have a special meaning?
> 
> 
> 
>>   /*
>>    * Default discarded sections.
>> diff --git a/init/Kconfig b/init/Kconfig
>> index d2b8b2ea097e..eb92ccfe4ecb 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1967,3 +1967,12 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>>   # <asm/syscall_wrapper.h>.
>>   config ARCH_HAS_SYSCALL_WRAPPER
>>          def_bool n
>> +
>> +config BUILD_ID_SALT
>> +       hex "Build ID Salt"
>> +       default 0x12345678
>> +       help
>> +          The build ID is used to link binaries and their debug info. Setting
>> +          this option will use the value in the calculation of the build id.
>> +          This is mostly useful for distributions which want to ensure the
>> +          build is unique between builds. It's safe to leave the default.
> 
> 
> If you run "make menuconfig",
> you will notice this looks so strange;
> "Build ID Salt" is displayed in the top level menu.
> 
> 
> 
> 
> 
> 
>> diff --git a/scripts/module-common.lds.S b/scripts/module-common.lds.S
>> index d61b9e8678e8..3c8410270ac1 100644
>> --- a/scripts/module-common.lds.S
>> +++ b/scripts/module-common.lds.S
>> @@ -3,6 +3,9 @@
>>    * Archs are free to supply their own linker scripts.  ld will
>>    * combine them automatically.
>>    */
>> +
>> +#include <asm-generic/vmlinux.lds.h>
>> +
> 
> You are pulling many macros in <asm-generic/vmlinux.lds.h>
> into modules, VDSO, etc.
> 
> 
> You also need to touch
> arch/*/kernel/vmlinux.lds.S
> of all architectures.
> 
> This is not so nice.
> 
> 
> 
> 
>>   SECTIONS {
>>          /DISCARD/ : {
>>                  *(.discard)
>> @@ -23,4 +26,5 @@ SECTIONS {
>>          .init_array             0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
>>
>>          __jump_table            0 : ALIGN(8) { KEEP(*(__jump_table)) }
>> +       BUILD_SALT
>>   }
>> --
>> 2.18.0.rc1
> 
> 
> 
> I was playing with a different approach.
> 
> Instead of touching linker scripts around,
> how about putting the salt into an elfnote?
> 
> 
> The compiler puts the build ID
> into the '.note.gnu.build-id' section.
> 
> So, I guess it is sensible to put
> the salt into '.note.*' section as well.
> 
>
> I attached my trial below:
> 
> 
>   - I moved 'config BUILD_SALT' to a better location
>     so that it will be displayed in the "General setup" menu.
> 
>   - I added 'range 0 0xffffffff' to avoid warnings.
> 
>   - I renamed the config symbol to CONFIG_BUILD_SALT
>     and change the default to 0x0.
>     Of course, this is just bike-shed things, though..
> 
>   - It looks like 'owner=Linux, type_id=0'
>     is already used in VDSO.
>     https://github.com/torvalds/linux/blob/v4.17/arch/arm64/kernel/vdso/note.S#L26
> 
>     I chose 0x100 for the type id, but it could be a different value
>


I like this approach. It covers what was suggested without having
to add extra infrastructure. With this approach, we could go
back to the original suggestion of making the salt a string which
is easier to work with from a distro perspective (can just use the
unique version string for each package vs. having to calculate a hash)

Thanks,
Laura
  
> 
> diff --git a/arch/x86/entry/vdso/vdso-note.S b/arch/x86/entry/vdso/vdso-note.S
> index 79a071e..7942317 100644
> --- a/arch/x86/entry/vdso/vdso-note.S
> +++ b/arch/x86/entry/vdso/vdso-note.S
> @@ -3,6 +3,7 @@
>    * Here we can supply some information useful to userland.
>    */
> 
> +#include <linux/build-salt.h>
>   #include <linux/uts.h>
>   #include <linux/version.h>
>   #include <linux/elfnote.h>
> @@ -10,3 +11,5 @@
>   ELFNOTE_START(Linux, 0, "a")
>          .long LINUX_VERSION_CODE
>   ELFNOTE_END
> +
> +BUILD_SALT
> diff --git a/arch/x86/entry/vdso/vdso32/note.S
> b/arch/x86/entry/vdso/vdso32/note.S
> index 9fd51f2..e78047d 100644
> --- a/arch/x86/entry/vdso/vdso32/note.S
> +++ b/arch/x86/entry/vdso/vdso32/note.S
> @@ -4,6 +4,7 @@
>    * Here we can supply some information useful to userland.
>    */
> 
> +#include <linux/build-salt.h>
>   #include <linux/version.h>
>   #include <linux/elfnote.h>
> 
> @@ -14,6 +15,8 @@ ELFNOTE_START(Linux, 0, "a")
>          .long LINUX_VERSION_CODE
>   ELFNOTE_END
> 
> +BUILD_SALT
> +
>   #ifdef CONFIG_XEN
>   /*
>    * Add a special note telling glibc's dynamic linker a fake hardware
> diff --git a/include/linux/build-salt.h b/include/linux/build-salt.h
> new file mode 100644
> index 0000000..66e87c9
> --- /dev/null
> +++ b/include/linux/build-salt.h
> @@ -0,0 +1,20 @@
> +#ifndef __BUILD_SALT_H
> +#define __BUILD_SALT_H
> +
> +#include <linux/elfnote.h>
> +
> +#define LINUX_ELFNOTE_BUILD_SALT       0x100
> +
> +#ifdef __ASSEMBLER__
> +
> +#define BUILD_SALT \
> +       ELFNOTE(Linux, LINUX_ELFNOTE_BUILD_SALT, .long CONFIG_BUILD_SALT)
> +
> +#else
> +
> +#define BUILD_SALT \
> +       ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_SALT, CONFIG_BUILD_SALT)
> +
> +#endif
> +
> +#endif /* __BUILD_SALT_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index d2b8b2e..54b5828 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -92,6 +92,16 @@ config LOCALVERSION_AUTO
> 
>            which is done within the script "scripts/setlocalversion".)
> 
> +config BUILD_SALT
> +       hex "Build ID Salt"
> +       default 0x0
> +       range 0 0xffffffff
> +       help
> +          The build ID is used to link binaries and their debug info. Setting
> +          this option will use the value in the calculation of the build id.
> +          This is mostly useful for distributions which want to ensure the
> +          build is unique between builds. It's safe to leave the default.
> +
>   config HAVE_KERNEL_GZIP
>          bool
> 
> diff --git a/init/version.c b/init/version.c
> index bfb4e3f..ef4012e 100644
> --- a/init/version.c
> +++ b/init/version.c
> @@ -7,6 +7,7 @@
>    */
> 
>   #include <generated/compile.h>
> +#include <linux/build-salt.h>
>   #include <linux/export.h>
>   #include <linux/uts.h>
>   #include <linux/utsname.h>
> @@ -49,3 +50,5 @@ const char linux_proc_banner[] =
>          "%s version %s"
>          " (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
>          " (" LINUX_COMPILER ") %s\n";
> +
> +BUILD_SALT;
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 1663fb1..dc6d714 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2125,10 +2125,13 @@ static int check_modname_len(struct module *mod)
>    **/
>   static void add_header(struct buffer *b, struct module *mod)
>   {
> +       buf_printf(b, "#include <linux/build-salt.h>\n");
>          buf_printf(b, "#include <linux/module.h>\n");
>          buf_printf(b, "#include <linux/vermagic.h>\n");
>          buf_printf(b, "#include <linux/compiler.h>\n");
>          buf_printf(b, "\n");
> +       buf_printf(b, "BUILD_SALT;\n");
> +       buf_printf(b, "\n");
>          buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
>          buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
>          buf_printf(b, "\n");
> 
> 
> 
> 

